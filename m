Return-Path: <linux-kernel+bounces-166102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A36048B963C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42C451F24CC7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33022E832;
	Thu,  2 May 2024 08:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kBbCqZEh"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC89128E11
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 08:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637724; cv=none; b=SziaPzbSLFBIAPtueXamHxRWIcujTzPRGGqO/dr2Aof8bQNOasCq/IZXDILgkKVVq54TV6HQvjNsfqluNsK1oLYeF+tKiB3wsK8rno4mTKL8YSPJGB1b5KU+1sUeNpk7An/ftvbL3ME6mFAX9osSYzRAKVZjZT5AHB/JZjA0JUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637724; c=relaxed/simple;
	bh=ZtDqgAXYiT02MT1jYbSADdleWVaaJVqj8qyuZIZtBv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LF4m9YLwTITiKSOfOgmixXJsn3gwN89jpWVpSQFLuUH2FE4x2IdFRcmr/prgzfOV6gs6P1DYqx+t0WMkQ2yowEAIKX5rM8REbDyri22b3xJhRvELK5IFj+hPhmawjZTv9Duvu8Q8Q3uO0WR2XPIGEZbmgv9HoS0V+ZSLZ4NJ8Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kBbCqZEh; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-61be4b98766so36287907b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 01:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714637722; x=1715242522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksrXWA++hq4uo5b14CGOhlwMbP35YcH8qiFN3VUhLdo=;
        b=kBbCqZEhM0nejAJkj8NYj39JbSxBU4YYdj1UTkMZVMZ3K8fErst+LxSsrEKtXsOTo9
         ytKMNBqdxiYqXB64azeTE/+J8QV23O3umjFtAzJ3LHQY6jTUwfoetAN8MAJTGJyDIqxa
         I3MN3HW+b0Jz9t8j6m7j20ZhL75R4ymaHmG2cOyc0asbcYbJBsM2roqk/WBq7Q6H9pFh
         tKd3G7SplytuMIt3pZyIeDV0EQ8zthG41uAy9UP3tL4CBQzrM8UdXlISITWpNM6g+LNY
         aDxvOosPgdeXktCnzp0emM+2x31EK4AXx9nkmbofEMs6MeBi3oqgbswh5Lw6Iyhjvl9Q
         An3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714637722; x=1715242522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ksrXWA++hq4uo5b14CGOhlwMbP35YcH8qiFN3VUhLdo=;
        b=eJcZqV2RgNDFZT1p9ILOj3sTIo5UKB8ljZcSkx8e5mAcHqqtlMd8rV78rgZpQIkf7b
         cwp5p8D4yMaFwzcRo92vPqkdlExJ3AzmEqRcc8MHrZ2tL/CAj4c3tlk+RpDutuO/d02c
         b9xWyo6djpyZROojZT1PMHdAMNW4/ZSA4IDdN1D5ek7TGpmkSUsZXQRFlBcIb8qFUVdt
         maxZXRIjs50VYGfs14PdqsCodqafauFxZVTzDgnaDWG6/ZFMgok5NRAcG6etjkTGcMCa
         O2Fec4/IlM1ZvvHFmo+jxtwBSyHLBuQxNFhxz0hwBCjDPv5YgmWTjbEzkzMJi50omTv+
         90Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUvUR7jcfzTSaiG608oRUHyRIDBqa4RmCPwew5wv/Z04nnqQTZj5twXKTMRjJ8LchSC0ALfX34pgPwLe5c2+V0K0q9pzPD0BwJKl9oi
X-Gm-Message-State: AOJu0YxFqjxH09AMgrvwYfEtggAwZYf02M4GC1Yd6gGkKcOpw/IfVuas
	oXrUgFmBWJTsPb+/KtfYX7Hs18DPpXtLXKP3dvMdUcwNBQJ50j2ldvM6bHD0gAnel+PgH50Ld8t
	hRgBdlIwdMDnlQqDNjfmTJN+awIRGUcENlXndRQ==
X-Google-Smtp-Source: AGHT+IGX8v+8VmddJzrDHjwUwXISt1o62/4S2TF455DujQU9cLxV5tMcWCQoLUuneneXH3ceSHMKHYls/F7UcN1WCOo=
X-Received: by 2002:a05:690c:6d93:b0:61a:c4a3:8a5c with SMTP id
 iw19-20020a05690c6d9300b0061ac4a38a5cmr5471921ywb.44.1714637719772; Thu, 02
 May 2024 01:15:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501154251.3302887-1-dianders@chromium.org> <20240501084109.v3.1.I30fa4c8348ea316c886ef8a522a52fed617f930d@changeid>
In-Reply-To: <20240501084109.v3.1.I30fa4c8348ea316c886ef8a522a52fed617f930d@changeid>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 2 May 2024 10:15:08 +0200
Message-ID: <CACRpkdZOyK=CSG2C64ELXXiieHUd_BaHBBR=iLrG6moYDUTC4w@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] drm/mipi-dsi: Fix theoretical int overflow in mipi_dsi_dcs_write_seq()
To: Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>, Hsin-Yi Wang <hsinyi@google.com>, 
	Brian Norris <briannorris@chromium.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Javier Martinez Canillas <javierm@redhat.com>, 
	Joel Selvaraj <jo@jsfamily.in>, lvzhaoxiong@huaqin.corp-partner.google.com, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 5:43=E2=80=AFPM Douglas Anderson <dianders@chromium.=
org> wrote:

> The mipi_dsi_dcs_write_seq() macro makes a call to
> mipi_dsi_dcs_write_buffer() which returns a type ssize_t. The macro
> then stores it in an int and checks to see if it's negative. This
> could theoretically be a problem if "ssize_t" is larger than "int".
>
> To see the issue, imagine that "ssize_t" is 32-bits and "int" is
> 16-bits, you could see a problem if there was some code out there that
> looked like:
>
>   mipi_dsi_dcs_write_seq(dsi, cmd, <32767 bytes as arguments>);
>
> ...since we'd get back that 32768 bytes were transferred and 32768
> stored in a 16-bit int would look negative.
>
> Though there are no callsites where we'd actually hit this (even if
> "int" was only 16-bit), it's cleaner to make the types match so let's
> fix it.
>
> Fixes: 2a9e9daf7523 ("drm/mipi-dsi: Introduce mipi_dsi_dcs_write_seq macr=
o")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

All right! Nice work.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

