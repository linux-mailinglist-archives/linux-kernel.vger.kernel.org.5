Return-Path: <linux-kernel+bounces-147312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2E08A725D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2518428376D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065E61339B1;
	Tue, 16 Apr 2024 17:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tm7yarSz"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CA010A22;
	Tue, 16 Apr 2024 17:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713288585; cv=none; b=EO5cvI97u2f33n2fHjnuhvMry9u0PQo7DqIBkYzHy/yFFzUyDfUbI5ZcKNMrc+Z1Vj24LV5fUbKG2hM7zXelPYxH59PUbjw4sHD5iotxPet/Ju+8t24B2GUJZ5gJ7AxwZ4TQni4QwNbcTLxzOxhwFDiGJpm1MB0Xlmwn1LFiNAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713288585; c=relaxed/simple;
	bh=u4a+StXvoc7WZc5sUtyqx0k9GiGrDUHS6kRfh3byeo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z7+tsYaXPJSUdF+if0EENAUujDbyDrptqpkqXYOE2Vmk+NTRcFizezzfvTmItTe+vdQIzP/3HWLPH5/SI5gKfuprhejNtcKCc8/rTecsEfxW9v7lJltVz249XCJdaw1sbv/Y5lMzOr+EqY5oV+MZ6+zdQOs3f2klzSGNHfn0sI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tm7yarSz; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a53f131d9deso288670166b.3;
        Tue, 16 Apr 2024 10:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713288582; x=1713893382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZP0IzBwvbXB7gkSUghvhzzGvmfIuLQzpi5ckhJzdidI=;
        b=Tm7yarSzgLpPWOLjyUyNjlw2Z/hbjtIpnMx5JTnz6U4e4kU7t2X7zQAGiIAt2sr4ga
         LpBnJkxur9hDOM/gZGtKx8jPmHlesH84CStERlojGPV1xSfPAYWjqyDYhRbn0eXZRKRQ
         U9I9y0sZRQZek6kRT00Mkn9DmP67BbmPI37m5UPhYPwNU2LHFbwb/KSUkWJbKyEDynK1
         R1gJCCvj98DykH6oVhyFDtMO0/FNMPo2p6MEu7K+3exwqiCsGp4k1Jiv8peDTmOaLITU
         Rz2QlTySmx2245KyhOVAd3NhJZlHOufBxXCvMTvStOgmHEL/oobHu95kLgJj6fmIKbps
         HUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713288582; x=1713893382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZP0IzBwvbXB7gkSUghvhzzGvmfIuLQzpi5ckhJzdidI=;
        b=JqKoLA1p0GJGMmvadSajEeyKf2bFoaLV8RAotJ64S+8ObsS7pKoilYQ2akprk9s7Yx
         rVUD/e5N80MbyzkLVfB4I0Ct0EGXGMbRrlhROGo6ug/bW/CQPgs3O+PaKpeuB4yekhJK
         XCP5U4zhitLSzhjc5NzRte9ghDf0Uxv7RwADeBS89RDj2yGJH/wjFm3DMdFEEfrROWGK
         8SEI/YLtBnbBlALS73E1TXuNelwT+lrmzBVB/dWIDshUGijYpECS84YdZzLLE+MamuSY
         B5AONRz+RUV3/omZXBpoiwQ0fvNImvqV68PdYIlQhcsarNRou6rgjWFPLfYvZqmSPxRk
         3wKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVgVHHscM0PFStqJpLr7Q+rOSsF0NuoDX0sfPKggPvq9Sw5s9A8HIG+5SFyYHBFbOP/TtaKZj2IGKbSuvseRPdLMOTIp0FvzK4KMWXFH9nSK3Xks80gfJCxSo4mXqiSfjY4lShYL7/sSWM0lsL/haOKBOomgyMq5n6+wLEe+hEwwkbhNdF3x4EpLhQzpOY5CbQTG1PPbVHCQr9/ns7vHiVC1E9GL1lHA==
X-Gm-Message-State: AOJu0Yz7phvj0jpSWP8d2GXZUJUdbjho77aM/9UTWx7IbkDIqBdiCytB
	54jm8j1Qzh7Xr+HbLjqgWTS6jA5sr+tLei9DrToKclJ486E2ky/vXe0ZL6N80vQXA3STLc9GgFD
	FSG9AlmFRsp3Mw5fy1mgHwURTMPmTwWrX
X-Google-Smtp-Source: AGHT+IGCWdqkd/mwwc21XqeYTFY6CEqZUxRw4U6LgrWgKvfvcMlwntLhuogiSWo4ZNwPxC6TWjiuSC76CYM2vJHDCx0=
X-Received: by 2002:a17:907:724b:b0:a52:5a04:fb0d with SMTP id
 ds11-20020a170907724b00b00a525a04fb0dmr5603113ejc.3.1713288581874; Tue, 16
 Apr 2024 10:29:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416053909.256319-1-hpa@redhat.com> <20240416053909.256319-3-hpa@redhat.com>
In-Reply-To: <20240416053909.256319-3-hpa@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 16 Apr 2024 20:29:05 +0300
Message-ID: <CAHp75Vdw6gCN=45iRdKcm=qT07Z90+z6Cw=inYR+C6+5gML+_Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] leds: rgb: leds-ktd202x: Get device properties
 through fwnode to support ACPI
To: Kate Hsuan <hpa@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	=?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 8:39=E2=80=AFAM Kate Hsuan <hpa@redhat.com> wrote:
>
> This LED controller is installed on a Xiaomi pad2 and it is an x86
> platform. The original driver is based on the device tree and can't be
> used for this ACPI based system. This patch migrated the driver to use
> fwnode to access the properties. Moreover, the fwnode API supports the
> device tree so this work won't affect the original implementations.

..

> -       int num_channels;
> +       int num_channels =3D 0;

Split this assignment, so...

>         int i =3D 0;

> -       num_channels =3D of_get_available_child_count(np);

..it become

  num_channels =3D 0;

here.

> +       fwnode_for_each_available_child_node(fwnode, child)
> +               num_channels++;

..

> -static int ktd202x_add_led(struct ktd202x *chip, struct device_node *np,=
 unsigned int index)
> +static int ktd202x_add_led(struct ktd202x *chip,
> +                          struct fwnode_handle *fwnode,
> +                          unsigned int index)

Why split over 3 lines? I believe it can be still two or one
(depending if you use a relaxed limit).

..

>  static int ktd202x_probe_dt(struct ktd202x *chip)

Perhaps you want to rename this to something like ktd202x_probe_fw().

..

> +       fwnode =3D dev_fwnode(dev);

Will be no use if the bellow applied, right?

..

> -       for_each_available_child_of_node(np, child) {
> +       fwnode_for_each_available_child_node(fwnode, child) {

Use device_for_each_child_node() instead.

>         }

..

> -       .shutdown =3D ktd202x_shutdown,
> +       .shutdown =3D ktd202x_shutdown

Stray change.

--=20
With Best Regards,
Andy Shevchenko

