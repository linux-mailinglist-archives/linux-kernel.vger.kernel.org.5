Return-Path: <linux-kernel+bounces-51738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38070848EB9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CEDF1C21DF0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282E5224D2;
	Sun,  4 Feb 2024 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJOVU5Em"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116502261D;
	Sun,  4 Feb 2024 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707058467; cv=none; b=kJUZ57qpr1p8UOyn3tp7hrhX+zmDkDFeHDmuGi1BJVF7QcxjcuTQUdReMiOYaa0MBpSuyy1sYzTPd1Z4kmJdSPA7j2f4nrZMICRVO28YO9ooL6fLrRvuGNerJFiHz39VkQU3yUan3eQPcKjv76FJ+BkFtch2axctUsvfEfazm4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707058467; c=relaxed/simple;
	bh=19VaFyH1wAwIJFBUEbUWhHCYP3fU7IyWnh+H1mYPIWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nnGWqrGKwImPzvBMNftUq9DS2wZu1CqCnY/Dv7D2C8xi+1TEk4iXE+YZLGW1Wh0/1pa0JIMMp7Yx3jtEMpqc5dpxPBweS6Q9OmF60LE5Bvlj4aIqBnuh9CfAsxY1BDzKoUoteQLEc0dHqzvKOWXBL/0Zx0oHi9WLmXpX9lk0p8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJOVU5Em; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6da6b0eb2d4so2311267b3a.1;
        Sun, 04 Feb 2024 06:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707058465; x=1707663265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgWoWhZI6Jt4ifeI2jAQa8yY6PW0nUJE61HeVZboEZ8=;
        b=cJOVU5Em0HNZchKkKYtWSNYca01+4q41IqyEdjZ12wYc8rXDW08VKqv8g/yiwqYj22
         P1n5Vmg4Url7EZQr5Quyx+WcJTpjVbIk07l1Q/9ISAWglivlUqK2CD9Ias5j/enEOw7c
         LKo9nKCvwY8VO91pMGPH3eK+r3oFOzLXDBWziCOrpH/L2iTq8hsoKKtSgb/Khpu4orpo
         UE+eINHSEII4eJdsOiMft3Us55HOj4uAUyl5IueIAyJ6m7U8oBNVvHZIYgn8hqO0Mr9b
         HHvtzOCpHKDHnz3UX+J+LjJTzUhQGFE5oxI2aAHuOYpqVaRw9GsUwZosvyrYs9KedZe8
         k4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707058465; x=1707663265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgWoWhZI6Jt4ifeI2jAQa8yY6PW0nUJE61HeVZboEZ8=;
        b=ZasI8PNVJwkjkTNI2NN11JFVz6Oh70yLImwjN/3RAJ5zCTOmS1iTlDJ1PWtOwXfBOb
         RtvZ3JGaPX3lvUSuDK/kVnLyYXo28R4YbTvykeNeyjZM0eukjexX8RmuCNq5OaoSoDMF
         Tbqab/48Xv8/CZcmQClHW/DEiezgH6X/DUWK0EfX+84onen/shOpUalr2U5/FNKhupPu
         fPJWjCwoqAelRIq2D4u3iNGgKNKTViF+Qn6BfWthrvRuPHl2maCvybXJgPUjJa9Nnyyq
         WINghI9I1WfP6gnluIaQJTmkoKoaXeg+hFN0/BQMd1lKEl6QHSOA9apNdZGKfE7nJlmO
         /wpw==
X-Gm-Message-State: AOJu0YyNOUaORfnUp3ovqnDByCdOVsqqEleenvS2TL5jyRgYTCWm9xZd
	yioY3JmXMAxdDabPX3S5gdH3vO/Ve+roMU0ehM53RpKDKZSDRrTyMOdvVHiN0EYbmAgvJxoDkVI
	dTnh9yuNMiVzSR6kVkvxOOszvSDg=
X-Google-Smtp-Source: AGHT+IGSX8kX5MA8ZbTQDoQMsW8S27tIoZz4dXskIGi/iCXvA3jGKdesaVZqnt2TBMScGsd6VoU8nD7JHy3LffXnc2s=
X-Received: by 2002:a62:ce86:0:b0:6e0:3769:eb92 with SMTP id
 y128-20020a62ce86000000b006e03769eb92mr1260042pfg.25.1707058465268; Sun, 04
 Feb 2024 06:54:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203165307.7806-1-aford173@gmail.com> <20240203165307.7806-7-aford173@gmail.com>
 <20240204120033.GA4656@francesco-nb>
In-Reply-To: <20240204120033.GA4656@francesco-nb>
From: Adam Ford <aford173@gmail.com>
Date: Sun, 4 Feb 2024 08:54:13 -0600
Message-ID: <CAHCN7xKGMNpiTxy_7vMKd+rSsS6aya7N+duVVwFNKnpG0M0gBQ@mail.gmail.com>
Subject: Re: [PATCH V8 06/12] arm64: dts: imx8mp: add HDMI irqsteer
To: Francesco Dolcini <francesco@dolcini.it>
Cc: linux-arm-kernel@lists.infradead.org, marex@denx.de, 
	alexander.stein@ew.tq-group.com, frieder.schrempf@kontron.de, 
	Lucas Stach <l.stach@pengutronix.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Liu Ying <victor.liu@nxp.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 6:00=E2=80=AFAM Francesco Dolcini <francesco@dolcini=
it> wrote:
>
> On Sat, Feb 03, 2024 at 10:52:46AM -0600, Adam Ford wrote:
> > From: Lucas Stach <l.stach@pengutronix.de>
> >
> > The HDMI irqsteer is a secondary interrupt controller within the HDMI
> > subsystem that maps all HDMI peripheral IRQs into a single upstream
> > IRQ line.
> >
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>
> This is missing your signed-off-by, and in other patches of this series

Opps.  I thought I caught all those.

> your signed-off-by is not the last, as it should be.
>
> Please have a look and fix this and the other instances.
>

OK.  I have some work to do on some other portions, so I'll clean up that t=
oo.

adam
> Thanks for this work!

Thanks for the feedback.

adam
>
> Francesco
>

