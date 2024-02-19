Return-Path: <linux-kernel+bounces-71639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DE385A82F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E56E11C210A2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDC53B7A8;
	Mon, 19 Feb 2024 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+mGaHHQ"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BCA3308A;
	Mon, 19 Feb 2024 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358813; cv=none; b=qjOF2N1pqy6YRhi6orxF86PCL3KLd9HjpGyQMHfXb80x0NlcXKLWyIFjFuTW3KykSN6fo5SxG3hGJhMyrZLHscNVnBfySkZUbKrLyH5FgFsBOhHuTxFSfxHxQSOE9BOHsj3PjU2kjInrx5i0yQjVc+birxRmSKVe3o8sP8FXT3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358813; c=relaxed/simple;
	bh=o/Tt/aNgskIIpJbtYfiY1C/VVmJ60rm2VifCiLV87cc=;
	h=Content-Type:Mime-Version:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YYDg777YoRxhxpsfOLhLBiVbXuHlxc8wmXZP07Ogud9ZSkUUUyujvXdi4iIAUk4z8jl5Dhscwkr2XK6wtoLNCeRKwbGTZaaYFwUdl2X6gr+gUTdHVG4P96dQoCcoIYpUbPSKhB4qyPCdFRDwU1vH1nDFefCj+p6ZpDKxPdyYG1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+mGaHHQ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4126ada76bcso3223365e9.1;
        Mon, 19 Feb 2024 08:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708358810; x=1708963610; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O6+K3p98rrkbJ5Yw3zsXbXs6AtGDMV+vIo5vbrjJJSM=;
        b=Q+mGaHHQoXC4I4wCHmVfJ0sWcEMMJp6uREVNXyBSuva7ymn5ssCJdrYzyi3DTZKzW5
         CIGgtRFsyM6zsRDTEWNEUh41QSkItTDbchfJWEm3BQDHVcdMIsGJZZxu8T+/4r6v/4e6
         IhRgDWJzLP1Nak2ScocNh9Tgx6rCj9EdqbO7jhx3Tw2mnhLngUr2ST/Dfmgq38kzUjto
         eQetmyuWXIJjO+w05WU8CY/quwyqKumSFVj3Yp2ha3SdsbGniX5xmDwa6wB34Vaf+drZ
         R/bbcTcNp7ZtDv86PKfQ8tnxTtINgCn/ppca1yBuWwuAV1yO82BK3Rr+SP3EhInQCp7u
         Quuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708358810; x=1708963610;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O6+K3p98rrkbJ5Yw3zsXbXs6AtGDMV+vIo5vbrjJJSM=;
        b=aBjNVj7nKj8W4SraRekE6I/K+IXffvmUB+t97aAcdJltN0JkrDEXEcX2RMzA9F6Y5a
         wDWUmzTWuoMB4DrQdzcW/hNRSUWa6d6Xw/dTjaGoyNiApfijWv6cWeD7uysls/cqjMCt
         PII7Kce8PINsrOnDkd3XmuUpN3wQo4szQeCRQmdlNNjs4aII1W5qkE2Af6wWuubQWqoJ
         +u/FOAOkkrPC2xrqfby5xexHdae4bB52N/iDzjXp9zEnzjTBFX6F4bUYQE4x9LtXapz4
         6ktm7l1EdBbZOOFJ+MUbvCvyGFA0ANe5EcLMuM3QenOn/3nS9XpZpzAt+LRLv0pKk7QN
         ntAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkjF3ttnMRjhj79sV7/kYrJ0G939lPFGdKH5w9cGVc7HUoIvfmIaMCdxmNsGe1eyDcTnAECpg8W9kUuazKUldYC4UI7FAFZYyvqJju/m/eKmL8FHzxf847Qnt4+szkZJUFjGLZqR2EWoc=
X-Gm-Message-State: AOJu0YzMRPLbuNKUH2Rc8VxR8pZapk4zEgiYMP7HUPf1ovD141QER/lh
	0mrHri89UWf0kuF9pE2AqhcOx+9mSglF+2AXvZo9xY5y4s8w6GnG
X-Google-Smtp-Source: AGHT+IEQJSKKhZ9J1YWzcwu5vi6aRAzszLFKpFo670hirt/u2Fe2srKZeCZpFa4niPALbX0nE0ZRGw==
X-Received: by 2002:a05:600c:45ce:b0:412:69c6:6be9 with SMTP id s14-20020a05600c45ce00b0041269c66be9mr974948wmo.4.1708358809505;
        Mon, 19 Feb 2024 08:06:49 -0800 (PST)
Received: from localhost (p200300e41f2d4600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f2d:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id t22-20020a7bc3d6000000b0040d5ae2906esm11691050wmj.30.2024.02.19.08.06.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 08:06:49 -0800 (PST)
Content-Type: multipart/signed;
 boundary=b0da0a27ceabff049215f580b6f79f3cc323727d60ffb73d4a209fb6824b;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Mon, 19 Feb 2024 17:06:48 +0100
Message-Id: <CZ96NM6U8O59.3TXG2WKAL7L8F@gmail.com>
Cc: <sumitg@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] clocksource/drivers/timer-tegra186: add
 WDIOC_GETTIMELEFT support
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Pohsun Su" <pohsuns@nvidia.com>, <daniel.lezcano@linaro.org>,
 <tglx@linutronix.de>, <jonathanh@nvidia.com>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240216210258.24855-1-pohsuns@nvidia.com>
 <20240216210258.24855-2-pohsuns@nvidia.com>
In-Reply-To: <20240216210258.24855-2-pohsuns@nvidia.com>

--b0da0a27ceabff049215f580b6f79f3cc323727d60ffb73d4a209fb6824b
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Feb 16, 2024 at 10:02 PM CET, Pohsun Su wrote:
> This change adds support for WDIOC_GETTIMELEFT so userspace
> programs can get the number of seconds before system reset by
> the watchdog timer via ioctl.
>
> Signed-off-by: Pohsun Su <pohsuns@nvidia.com>
> ---
>  drivers/clocksource/timer-tegra186.c | 44 +++++++++++++++++++++++++++-
>  1 file changed, 43 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/t=
imer-tegra186.c
> index 304537dadf2c..8f516366da86 100644
> --- a/drivers/clocksource/timer-tegra186.c
> +++ b/drivers/clocksource/timer-tegra186.c
> @@ -1,8 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Copyright (c) 2019-2020 NVIDIA Corporation. All rights reserved.
> + * Copyright (c) 2019-2024 NVIDIA Corporation. All rights reserved.
>   */
> =20
> +#include <linux/bitfield.h>
>  #include <linux/clocksource.h>
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
> @@ -29,6 +30,7 @@
> =20
>  #define TMRSR 0x004
>  #define  TMRSR_INTR_CLR BIT(30)
> +#define  TMRSR_PCV GENMASK(28, 0)
> =20
>  #define TMRCSSR 0x008
>  #define  TMRCSSR_SRC_USEC (0 << 0)
> @@ -45,6 +47,9 @@
>  #define  WDTCR_TIMER_SOURCE_MASK 0xf
>  #define  WDTCR_TIMER_SOURCE(x) ((x) & 0xf)
> =20
> +#define WDTSR 0x004
> +#define  WDTSR_CURRENT_EXPIRATION_COUNT GENMASK(14, 12)
> +
>  #define WDTCMDR 0x008
>  #define  WDTCMDR_DISABLE_COUNTER BIT(1)
>  #define  WDTCMDR_START_COUNTER BIT(0)
> @@ -234,12 +239,49 @@ static int tegra186_wdt_set_timeout(struct watchdog=
_device *wdd,
>  	return 0;
>  }
> =20
> +static unsigned int tegra186_wdt_get_timeleft(struct watchdog_device *wd=
d)
> +{
> +	struct tegra186_wdt *wdt =3D to_tegra186_wdt(wdd);
> +	u32 timeleft;
> +	u32 expiration;
> +
> +	if (!watchdog_active(&wdt->base)) {
> +		/* return zero if the watchdog timer is not activated. */
> +		return 0;
> +	}
> +
> +	/*
> +	 * System power-on reset occurs on the fifth expiration of the watchdog=
 timer and so

Is "system power-on reset" really what this is called? Power-on reset
sounds like something that only happens after you power the device on,
not something that can be triggered by the watchdog.

> +	 * when the watchdog timer is configured, the actual value programmed i=
nto the counter
> +	 * is 1/5 of the timeout value. Once the counter reaches 0, expiration =
count will be
> +	 * increased by 1 and the down counter restarts.
> +	 * Hence to get the time left before system reset we must combine 2 par=
ts:
> +	 * 1. value of the current down counter
> +	 * 2. (number of counter expirations remaining) * (timeout/5)
> +	 */

Can you wrap this comment so that it fits within 80 columns? It's fine
to occasionally go beyond that limit if there's a good reason for it,
but this comment doesn't seem to fall into that category.

> +
> +	/* Get the current number of counter expirations. Should be a value bet=
ween 0 and 4. */
> +	expiration =3D FIELD_GET(WDTSR_CURRENT_EXPIRATION_COUNT, readl_relaxed(=
wdt->regs + WDTSR));
> +
> +	/* Convert the current counter value to seconds, rounding up to the nea=
rest second. */
> +	timeleft =3D FIELD_GET(TMRSR_PCV, readl_relaxed(wdt->tmr->regs + TMRSR)=
);
> +	timeleft =3D (timeleft + USEC_PER_SEC / 2) / USEC_PER_SEC;

Same for these. Maybe make an extra variable to store the register value
in to get rid of some of that extra horizontal space.

> +
> +	/*
> +	 * Calculate the time remaining by adding the time for the counter valu=
e
> +	 * to the time of the counter expirations that remain.
> +	 */
> +	timeleft +=3D wdt->base.timeout * (4 - expiration) / 5;

This doesn't quite match what the comment above says. Shouldn't this be:

	timeleft +=3D (wdt->base.timeout / 5) * (4 - expiration);

instead?

Thierry

> +	return timeleft;
> +}
> +
>  static const struct watchdog_ops tegra186_wdt_ops =3D {
>  	.owner =3D THIS_MODULE,
>  	.start =3D tegra186_wdt_start,
>  	.stop =3D tegra186_wdt_stop,
>  	.ping =3D tegra186_wdt_ping,
>  	.set_timeout =3D tegra186_wdt_set_timeout,
> +	.get_timeleft =3D tegra186_wdt_get_timeleft,
>  };
> =20
>  static struct tegra186_wdt *tegra186_wdt_create(struct tegra186_timer *t=
egra,


--b0da0a27ceabff049215f580b6f79f3cc323727d60ffb73d4a209fb6824b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmXTfJgACgkQ3SOs138+
s6GORA//ZiipCoOSu/wox8hsJdL/TpRaNXjRNKNMz0NErbEYulBe30SnI7eT5XTW
lbTiLsc5jF+1u0PwmpYpOCpxH3iTWFbTR5GvSWE2DSjtVRkve+Laz6uYGetcip9w
MdN4t53myl86ehPL9eWMJesi20aqyfRbKkLP/rG424LItSgjnAqdRNSMlnBGozBY
2CFa3GGepna7+3VSFGhHcuvslCFc9xIyg4kGcdsiAStPRtnVrx0XEW8KSUFT+u+b
IjZi3w4EU3rYLCxvrrCQ8EcV0XMSQ7lmhcxFohsXK1cHx4hVtrTQ9RtXZcNQ3IZC
DxfwqBDa4eeCWmek+8Y4a8jLvE32gAzPyuVrfLwCckVkmvGDicMNrt91Dtu3UABU
aEsuKfM6DQJ0DXQeEqhwF3tfWSqbxIu9n0P20cBY65E/Pvu2yd+0VDW1VGUdGQba
64RHPWq/jvgQTOG+xX7S2gOjk/E/8Bnr2thKQ+eWsadU9ZMffOWFv+hyd+CfUnYk
IQ6V0ZIWGf6zmvjubb1XK+UVigr8bD1CETRUF7QOkXppdlbm2+P7pACgaewdaMyY
2nDFrpCCi8jextNbkKCsMk5tI/0kAsLJBhYg48Ki2gFl4s9L4FO8927CjxaBIJXd
oWJZDv766LuFtbYtvYCEXfBoqJvRWzq5v+dq5YVbl3Gp5qfJiM8=
=dCoG
-----END PGP SIGNATURE-----

--b0da0a27ceabff049215f580b6f79f3cc323727d60ffb73d4a209fb6824b--

