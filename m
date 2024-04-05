Return-Path: <linux-kernel+bounces-133151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2184899FA0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B97D1C2259A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FB716EC0D;
	Fri,  5 Apr 2024 14:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIpag5M7"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C84E16D32D;
	Fri,  5 Apr 2024 14:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327283; cv=none; b=s2oC6FEtk/kkzfHwhcTxcXnfRBUFq6v2hAfCFfxl9ihEzOeNqzBWBHD6n5UunBsiGRANJJy76vEwEHzuEnsnEF+ZBT2bh+dUq/9H85gbtkgpWomfie8f89431kiGRTRr4J0XeRUZLxSpWaXgenRUFjY9B3tnR/BJXvFcRAPF8xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327283; c=relaxed/simple;
	bh=edtWDz0F9ERyIwkradda1dEIoOdPdwzXb2qVkEfqBV0=;
	h=Content-Type:Mime-Version:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=lGaVtozIKtUSKp0J0xMug7Htbtd4OI5mF1kIX8tcpwlbNKz8eTaz966PrPM+ZI/jM6MjSoIu/GExIRa9Tt8TeesbUUFYVzCxbjyGVa53udrcgV8CFLf9+d7jGMKz8s3ENPEB7dz0r2E7i7MQ1Heud5JlNSnNE/Tql61dcUhno/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIpag5M7; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4162ec14805so7510085e9.1;
        Fri, 05 Apr 2024 07:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712327280; x=1712932080; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O7LERPVCSW+Wfgv7Cf7Coboc+jfMXyoBnYaZV6ymz4A=;
        b=RIpag5M78SHwP4RvqAZaWdnkoNPkr2eZb/5eFr103wlw3dNgXWAzesltU1F4er5EEl
         0nswVIqpEcwDniyI9Xzii3tXzADjaYJaEE2Zfh9fbBSGXwuVsJLBondgZqBFbOG7pWbW
         pLjAjiA+l6ErcJFXIpFIbmj2DaUpQvrYhs1sHodFarUndI3N8i3JxJXtFE0cczBl2hoU
         qCBJN6lyIAyw1RrtDq2wgDgQqd4aWxEkE5lELHP82x9/64NT2BxoBlbv0WdvVSlzCE2+
         lLlSDKoiLM4z3rfINIwJt42+ecK1l4H9FPkD/0mFRneo8LFG7XEJtachzsuUeD1FHGWp
         +frg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712327280; x=1712932080;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O7LERPVCSW+Wfgv7Cf7Coboc+jfMXyoBnYaZV6ymz4A=;
        b=QDPcJDN+Pp0oT//u4sF8zjQzRu9Joh8sweB8L5DXoCY8OWtM2LM0tA6NtjsGn23jsA
         FsBY7D/OKfcFamCdAJ4+WlNYz4k5xzOhWCSj9g6Lu06ff3igoMs21FKXc/oj4+WAXuv7
         mgswZn2LI4GmdoyEmrU1QcqzSw4nyCLnbL9bZgeCfZfxsAcE/hygeHoNZZs5+s+dR1/T
         pqsUzILOv3UIjwf5WDGJpExE9aAxoKcGkGEZIOynraxoS5zu1unyk09c8uaor0NDARh1
         bCeCBuJhxCd5MHWy3pk4UGJk6KZBZxXOQOzc8iWGUoimAScbIx05wTbml/7h+g5mDzNZ
         IgMw==
X-Forwarded-Encrypted: i=1; AJvYcCXpJi7gIpM8kan83r/qAPg2QRPWlrWpjoXpG487mQ9Qk08S/COYrtn7yvXSg97At30O3s7GAh/AFoA+vhkhuacjwzQlGhIGY9yJNLXF8lPxOg48e9MLnLzbRuylpkJk7g2i/jd06vjgOjAPM1ncnB4CnxKi6rnm+sa0IbzL3nddrz4=
X-Gm-Message-State: AOJu0YzGVDts9PinOnfJYGRQyjgMb6f0RIwbDj9vaSS1t/6TPD7zUy3U
	LgNRlAa0kdIWb+I6ktJZvAGhRqCu6BamYSxg1RHRgGfcOP2Znm+59mVZbJus
X-Google-Smtp-Source: AGHT+IGmhovB4WvvEoGfhcQ7/7+9sQMUwNRkZ/ya0lVDZIypZ5bRpVOnEtbrPOgNbrIt2UzRbbBa6g==
X-Received: by 2002:a05:6000:188a:b0:343:39f4:3f2e with SMTP id a10-20020a056000188a00b0034339f43f2emr2164436wri.5.1712327279625;
        Fri, 05 Apr 2024 07:27:59 -0700 (PDT)
Received: from localhost (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id i6-20020a05600c354600b0041488691eb1sm6662907wmq.17.2024.04.05.07.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 07:27:59 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=2bced5962d6df3645374ca32f7e19dc7b5f911531a5e3e0d1afd7115069e;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 05 Apr 2024 16:27:58 +0200
Message-Id: <D0C9D05HXLMP.PNF08QRPH8O2@gmail.com>
To: "Sameer Pujar" <spujar@nvidia.com>, <broonie@kernel.org>,
 <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>
Cc: <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <lgirdwood@gmail.com>, <jonathanh@nvidia.com>, <mkumard@nvidia.com>,
 <stable@vger.kernel.org>
Subject: Re: [RESEND PATCH v2] ASoC: tegra: Fix DSPK 16-bit playback
From: "Thierry Reding" <thierry.reding@gmail.com>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240405104306.551036-1-spujar@nvidia.com>
In-Reply-To: <20240405104306.551036-1-spujar@nvidia.com>

--2bced5962d6df3645374ca32f7e19dc7b5f911531a5e3e0d1afd7115069e
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Apr 5, 2024 at 12:43 PM CEST, Sameer Pujar wrote:
> DSPK configuration is wrong for 16-bit playback and this happens because
> the client config is always fixed at 24-bit in hw_params(). Fix this by
> updating the client config to 16-bit for the respective playback.
>
> Fixes: 327ef6470266 ("ASoC: tegra: Add Tegra186 based DSPK driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  changes in v2:
>   * moved common setting to S32_LE switch case.
>
>  sound/soc/tegra/tegra186_dspk.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--2bced5962d6df3645374ca32f7e19dc7b5f911531a5e3e0d1afd7115069e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYQCm8ACgkQ3SOs138+
s6HsnRAAnbvXUuFwGeAoUlndo/z+e8xofUaZP2R83hBnA3JyUK5SdmWuf44y6VoJ
x0/RyQOZ20Wm0MGqRnalCMND9z5yNtfH0prJMBJlvhjKJFtMUI1+zpcfvqzMCxLJ
4qtwzO324JwLnPMMV64aWfiHY5unR6wvwf2Angf60yWrD61RjJ0LPUfY/9a/zAGO
ZKuGqslx+x7Xx3OZayaf/9sg+a1DcQEbCRsAzsWp22PGi52wp4PPgfDNUcTHGkhK
bWFTkm46ZWV7DdUTCnJ50xc2lcz/9hDRou6sEbaZZYtWHjZTj5V4omVyteP0xIsL
7dVC8lCT2Mf99iBcKlLRPy58NdWPnun5PCKMJ8s1GmFA+BYuGsUVxYko8Lnq5LDh
GV9uzOIYwzs6LWJ2cMEKnR6uNXJEtLoq8YFoBvSHxaBnvAi0jO20Ak5UlO4YTwEo
aUx8dpyjjCv6N+4U+9Y+rj0D7MsIvVbeBx8T8Ln6/0sw4mQ8qJe094/AzdU/UJEc
8jnJFmkf1ae6CkTBpOrOR/KUQO6jcdENhqzUV4NAQPKJOm5mQ/0Zxd7hK8fYHWOB
6ptE6q+mrMQJfsMdjl4X+MExHSX2LC8rCxawk0E4zoBQ7LBGDVLt5DtngAAVFBVP
DpZMRBOvlDBSWQtdg3Gwlgq9Tw8VfyBihA0izA/HBugbXG9VrYg=
=+hkQ
-----END PGP SIGNATURE-----

--2bced5962d6df3645374ca32f7e19dc7b5f911531a5e3e0d1afd7115069e--

