Return-Path: <linux-kernel+bounces-68529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE345857BC9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DD001F21337
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312D777F11;
	Fri, 16 Feb 2024 11:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XA1KeJJZ"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F1017C6D;
	Fri, 16 Feb 2024 11:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708083283; cv=none; b=FSeSCw2GK3l6s6pTo6YNvighLXRoNeE5P7LzMLFXFK6v50swgTyteYpORKPGZBtnxjTpwjJaY3y3XKpuQNcn45wlGWQp3KyM5qfYlriUuzvlBw75nbxccud8o7u/QsRii6uNEiVme3bg6rYh7MRyZjVQ1YLxXLLogQHR/UwF6oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708083283; c=relaxed/simple;
	bh=e6V/HWz1Ktk32eEQXR0nxHlhgWt2dfGcCYPrGGek8Gw=;
	h=Content-Type:Mime-Version:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=eqhIWwUmW39vAhJhnLHvc97WonkPVOcPrHx32SWROxM16VO2dYQ/zP1Vwq9LRvjLDEkBHxN85KbyUbjrGVef61zAfxeYDleLJqOJgNX3lFrz2MpINvm1lHLp9ZeqoV3kJKQrfyvCWR8HJaO2Fj+3Q2ouFTYXyrS6V43twfjONIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XA1KeJJZ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5611e54a92dso2592836a12.2;
        Fri, 16 Feb 2024 03:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708083280; x=1708688080; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5vGNgG2f3G+UkQlriVVRU5p/C0qOFEiSsKyK9Ds93Cw=;
        b=XA1KeJJZ5iDsGj3cbatSOeBs15R3VBH/WqyG3+mMpT9hjzsAxtrCxKQbytzOYnMWBr
         iFuRweC6WC4e1KUmh4FWBAfAlSO1P+cPXRcgAqz1WsUCQ4I5v8DPaphza9tGTtSpTjMV
         +HwdPYYKOrtG5TrgWUChNCnajGjqT8FX7j4gM4X06Tef3WhVmNTpM9cY9yh+KC8FPbYC
         c98qJcd8/Z0/ThuDDj1yEtdb04wOPNgtGVGFUSsGjPDVHyk8xhlzEY4Yg8ONyUbSeNxs
         HiQYDH7HVjQ5Jex/nX5hrDSBxKnMXrZjRjlG0uAYvx3mIt92xCfM/1q36a6Eb51CYvfl
         vUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708083280; x=1708688080;
        h=in-reply-to:references:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5vGNgG2f3G+UkQlriVVRU5p/C0qOFEiSsKyK9Ds93Cw=;
        b=oG/237ys06Jp1JW9hE4lhEhKEHuAl/wwc0PL9RAh8Ez3Cj9Yl8Sth1wUPbeG9F4Gkx
         7tw0OkLKFtmBZlrNKXBZDyFHvIug6XaZ+NmEjY2SUzuN9Grqq/KujW4jjJ/zMX5Qb+uS
         TTwozbpdie6TfTxXvc6HBBNlt7QZwW0jynRwtA6MuT6DIXfU3AsCpqu+uHysjVb9KzOT
         tw28opFGfb32a2RJbu0AvJ/AsYCUVrG+t/zPhyiCIxjSkP03oV+U43Ef5yXvBimAtnuo
         rszjkyt/eaASNtYsYESnq3T88VGAc1+mgOF7anncmjThLxtZPAp9nYaY2mZIqFpOTtkB
         258w==
X-Forwarded-Encrypted: i=1; AJvYcCUWD+8dqKl9VdIQBXRnXEaQ/YxeW6forR4DSyU343u+HonD0QA2l1uGSo3YZv5D/nNLnjLECnDT0m77fWOdo4I/AzT+Zkw9S1T1onhdRb7fn7SSeYefiYXdxtWsLcuNZeA0CNT6DQBqw1g=
X-Gm-Message-State: AOJu0YzgFgv4RzWO7Kb3xHCc3T2XNtEevZsXHNlU7uMmSx33w1MBE3Hv
	6m1CNd3g/XO7wI3sFBZ+X4VKkRFF3PVGPWoGFgKUZq98/5MamDv/nBBSkdyN
X-Google-Smtp-Source: AGHT+IHdC3DVtY8yfL9trVF62kPfAirRBoeXaa6wHJ40Jqnk6AwJjPdtXdR+EDYvwfI67RY/wqTAGg==
X-Received: by 2002:a17:906:4a17:b0:a38:107a:94f6 with SMTP id w23-20020a1709064a1700b00a38107a94f6mr3013335eju.71.1708083279901;
        Fri, 16 Feb 2024 03:34:39 -0800 (PST)
Received: from localhost (p200300e41f147f00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f14:7f00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id wb3-20020a170907d50300b00a3d2e690abfsm1472443ejc.122.2024.02.16.03.34.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 03:34:39 -0800 (PST)
Content-Type: multipart/signed;
 boundary=86f3d511563110b0118336ed3165a0d780ba36a3ab76703486e9fe5bdcaa;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 16 Feb 2024 12:34:38 +0100
Message-Id: <CZ6GZLO63NL2.3FNHFOQ3W3JSY@gmail.com>
Subject: Re: [PATCH] soc/tegra: pmc: Add SD wake event for Tegra234
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Petlozu Pravareshwar" <petlozup@nvidia.com>, <jonathanh@nvidia.com>,
 <pshete@nvidia.com>, <p.zabel@pengutronix.de>,
 <dmitry.osipenko@collabora.com>, <ulf.hansson@linaro.org>,
 <kkartik@nvidia.com>, <cai.huoqing@linux.dev>, <spatra@nvidia.com>,
 <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240216080450.456135-1-petlozup@nvidia.com>
In-Reply-To: <20240216080450.456135-1-petlozup@nvidia.com>

--86f3d511563110b0118336ed3165a0d780ba36a3ab76703486e9fe5bdcaa
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Feb 16, 2024 at 9:04 AM CET, Petlozu Pravareshwar wrote:
> From: Prathamesh Shete <pshete@nvidia.com>
>
> Add SD wake event for Tegra234 so that system can be woken up from
> suspend when SD card hot-plug/unplug event is detected.
>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 6dfcc7f50ece..dc4eab3191c2 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -3,7 +3,7 @@
>   * drivers/soc/tegra/pmc.c
>   *
>   * Copyright (c) 2010 Google, Inc
> - * Copyright (c) 2018-2023, NVIDIA CORPORATION. All rights reserved.
> + * Copyright (c) 2018-2024, NVIDIA CORPORATION. All rights reserved.
>   *
>   * Author:
>   *	Colin Cross <ccross@google.com>
> @@ -4199,6 +4199,7 @@ static const struct tegra_wake_event tegra234_wake_=
events[] =3D {
>  	TEGRA_WAKE_IRQ("pmu", 24, 209),
>  	TEGRA_WAKE_GPIO("power", 29, 1, TEGRA234_AON_GPIO(EE, 4)),
>  	TEGRA_WAKE_GPIO("mgbe", 56, 0, TEGRA234_MAIN_GPIO(Y, 3)),
> +	TEGRA_WAKE_GPIO("sd_wake", 8, 0, TEGRA234_MAIN_GPIO(G, 7)),

I'd prefer to stick with - instead of _ in these names, like we do with
sw-wake. No need to resend, I can make that change when applying,
provided you don't have any objections.

Thierry

>  	TEGRA_WAKE_IRQ("rtc", 73, 10),
>  	TEGRA_WAKE_IRQ("sw-wake", SW_WAKE_ID, 179),
>  };


--86f3d511563110b0118336ed3165a0d780ba36a3ab76703486e9fe5bdcaa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmXPSE8ACgkQ3SOs138+
s6Ft2Q/7BUsouJfMl7g2EdUjU8QMD1/QRt9NHwdPr6yaDYSXnxkDwY89GScmuBaP
oF41QOLImcT+M8Z1U4GW9Kz9LjGF2d+wR4YdE3t/38jlScJf6ovO7x6Boa71ZCVQ
zddKiaLvVN93noR0nBf26LXE3tFnF8PXjQOTo80Du799k59A9S5+bk00KiDUn3pJ
zDFdmRBiHZA+DkN9fiC6l6Pc1JRKuAvBuhxr25gQBbDLAouj9xKzihcZonp5cLLS
dksI86oRJ7qC8H7lde+T6ONheQ1X+C8XT8F0ftnuYGQHDjTgTQXmEmIWtChgGTp3
PG8fTvefEIGhXpbu9QKOpMakIegSLY4rQ0dTQcpFBlbVse7z81dswG4p2BElWwy9
1isj7KPZItYGA8UCVsf3Sq7jpe4LA3u+Uof5BkAVKli0om+yUYos4MihA0mHfll7
Bd/5BEm9DwMXh6bdZDME+h+W9wjMQNFj9a0Q0hDCRHKCm6seVrCHNHIXgvoAcnzr
AuR1I5rRalVg/nxNsStj9PNCTyn1UBNJjbBmMOEkzSk/QwV05DwGpFNHzqTEl5FV
wsMHF1lJjDwoKLhfFVEpuHpTfN1xQ0cbQJrEMykYsE2KwnBUP1FiwBlmaNTo3NiK
imgyHe2Wacxh0W22lXvC72+KxRJcue3p3L+eXNacdtlTbpQr80U=
=cSkk
-----END PGP SIGNATURE-----

--86f3d511563110b0118336ed3165a0d780ba36a3ab76703486e9fe5bdcaa--

