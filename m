Return-Path: <linux-kernel+bounces-76752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B94B85FBF6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B1201C225B8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DCF14AD33;
	Thu, 22 Feb 2024 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="UwkIsLyk"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA7914A09F
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 15:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614688; cv=none; b=Q9hiaz8pS+ATcIwG+ncwVHbT/qa64Ii1P4Ykq7CanO73olQ++oSNXNog33/pmecmtTwDv9VFgDYTqoNrsJs3RFdAIpgUYIWbeF+Y+SreX4T017eJELNZao9nspoLPdbn1pnqqCjYpmM5fKqcau2SHFrHRU7NUwyDdfEp0+gRULY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614688; c=relaxed/simple;
	bh=E0AvIIn162mSDyZwPDTo2b1xyRz7jAaOfrYbNUsD19s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dhY8dLnfwAJvQLtedxUgAnuv5vShZXeYTBVJS0ZG8A7bO95tTP7JKIjDp4xGqFRSvyoWmZWMZmkzcH7GCE6Igt8lwt8KAMYhjMuH/a08KmaoERIDtrCBm4c1gGxFEC9bobC6ZeHiSvh7+se28kZ9i8d/KrQhSIvfOpHaOwxd+fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=UwkIsLyk; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d2505352e6so35529711fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 07:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708614684; x=1709219484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1MyTAa9W6rwmrz4X17WTkjYYC8wuvxkD+qfkCmD8gA=;
        b=UwkIsLykfJRFNvIHoHGBPHMNOiHcdcQuVYCHaWoS5aYxT5Ka5iGYvLPTlpAaP+ej2l
         LkSANWN1ECg+wxpZc13XRS2NPCmfmdUMvRLiA3BV6HEdlghd1rdFyBB9kG3FgENyu2l/
         s2QvMk5J6v6XoSo9GqdOHWlQdTP/C8L3G6CQ2CKe2UVU1Lp8B5PacI1vk4kwZjZcgpnm
         ofl2c4aUnIHqRT6ifeTSNvRL1QmW+os+Fku/Nz33UOl8QJBgkr+rn2oI8K/hKqFQpmoq
         gKuDgoTMhWmU1ZnRh2GxW1UVcfpmHgexdkEe5WeeSEejr9sClJ5ibqIctcgrIy+95J+u
         C4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708614684; x=1709219484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1MyTAa9W6rwmrz4X17WTkjYYC8wuvxkD+qfkCmD8gA=;
        b=qbit4AXh7Zbotep0Go21CichtKbQ+uxwKxXEvjeQ/FpHwMV16mdrCN1+v0UfhW67LA
         ENSLW6iXIrkAnYKHzQEP7fuVeweUhC1Kl9t7+rqQBd0791oHidIcZgo6js5sv/hJJ0qQ
         wlDCmRECMQfSjVoETttpFZlKFl/Dsda46c1mWyrGokrtBX78k7noAM3SiV4Ol5El1jyo
         j/Alrdl7tkkII3DqroMkGZmWZLSvR0jq078WJW+ZK8VrZNuG55TtpOq4YhHdv9Fxce9E
         elsIYPTfgmlGhqxgJS6YLJCq8S0pRQrxjI9MjVsL0DewRJP1FVzhf9EC/fVXmel59h/R
         lXjQ==
X-Gm-Message-State: AOJu0YxOk7q7R+CQ00FHgljSyuCKZyqRLd0iqFQ30ezIr13A2mI1FfeX
	c//WJM/fv4Hj4+7Bs+dnAe52rRkXpW+IojhF04YTBRfZTI6Ag083fIigfoTjqM0z8HoalpuaiHJ
	0H22JftlxUh0jVCgFc75I69HJbykRAEiRVbGz9Q==
X-Google-Smtp-Source: AGHT+IGw3hbqPWYN/3vfhhQBFzrTvi1PbeoR9WvH0886TzS1KyGrr602I8E8lLCB6pIuc8bHxZF8tDM1xPYr0gG8zd8=
X-Received: by 2002:a2e:b166:0:b0:2d2:6002:c239 with SMTP id
 a6-20020a2eb166000000b002d26002c239mr1510902ljm.3.1708614684451; Thu, 22 Feb
 2024 07:11:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222145838.12916-1-kabel@kernel.org>
In-Reply-To: <20240222145838.12916-1-kabel@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 22 Feb 2024 16:11:11 +0100
Message-ID: <CAMRc=McWhC0ZdR55TMkkdVov=dwT0=H-4_c4J-bq0quRpvyoBw@mail.gmail.com>
Subject: Re: [PATCH 1/2] devm-helpers: Add resource managed version of mutex init
To: =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
Cc: linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Lucas De Marchi <lucas.demarchi@intel.com>, Oded Gabbay <ogabbay@kernel.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Aleksandr Mezin <mezin.alexander@gmail.com>, Jean Delvare <jdelvare@suse.com>, 
	Guenter Roeck <linux@roeck-us.net>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-gpio@vger.kernel.org, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-hwmon@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 3:58=E2=80=AFPM Marek Beh=C3=BAn <kabel@kernel.org>=
 wrote:
>
> A few drivers are doing resource-managed mutex initialization by
> implementing ad-hoc one-liner mutex dropping functions and using them
> with devm_add_action_or_reset(). Help drivers avoid these repeated
> one-liners by adding managed version of mutex initialization.
>
> Use the new function devm_mutex_init() in the following drivers:
>   drivers/gpio/gpio-pisosr.c
>   drivers/gpio/gpio-sim.c

Yes, please!

For GPIO part:

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

