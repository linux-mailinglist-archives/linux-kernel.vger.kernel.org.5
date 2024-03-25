Return-Path: <linux-kernel+bounces-117158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7781988A80E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046231FA01A5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B26F12CDAC;
	Mon, 25 Mar 2024 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAHK62NK"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E29612C7F9;
	Mon, 25 Mar 2024 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374073; cv=none; b=dCkUgkh3gg+liW1LFvKJzpFRHiXttzJ06HJrC0YJLWdZbpq/4Vo6CEaQriL3ulWZXivbjVCVBZ7e3+SnCVQpU2g+AWnwpT+AU4Lea5XoWAa2182KBe/f5x/bCZnecCtyNcxyYdxa2koKPs2hHu8sHL4HpoJBeboWJCl0YZSscu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374073; c=relaxed/simple;
	bh=WgdUCSrnKAGw2TF5y8bAENJkYNr1jVJYvWxlovRCCZM=;
	h=Content-Type:Mime-Version:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=q3/QslZ7OwKpdHvG7cw6Hr7XK1Za6/liHgt68fZt8MO8ZqBDhPD5uCOMDAlmwSI5CvqhZZC2tczbZxU0edW8FqPGFjORKwB0nAKj+AC2N4E695aNBdmsQAe+LJMZB+uGihtRnYHqt38rAkb7RE+lP6dyEvfjjBsriTzl0IMOx/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAHK62NK; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51381021af1so6741597e87.0;
        Mon, 25 Mar 2024 06:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711374070; x=1711978870; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9fW3TP6U7rAT0YQU6K+tYG9SUW8HtzWbLUAXpV7C8xQ=;
        b=KAHK62NKHWpZ0MYJUPY2XmYv8WI4YT/tEYrTXI1YsZAp1GvRB7kGA1qyp2xcBL4Xnw
         vZAqWI+dPcrTvjfu0w11scE1fhZaENb5SorlruXN7npQoanAew77IxGEwfP9vwfDRrcB
         HmVlnKp5CeG1CHwJYGbikoPXg2HiGcpOxTVwqgehUmQMYGEdDtfZDWTOIBDm9G+dqvZZ
         CGg+IlJtXFUcn+xGfBl5MZ4Sk/+ROX4jnsQ/F0w5P8nzoU09kYMq51waFClcVbM/vU26
         KtLrDR1SXIHrRFfx10rsAsvKPcuXOffuB/XHBjd1N7X4pVVajc8OJlUIVW2PR8/3B4b8
         tVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711374070; x=1711978870;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9fW3TP6U7rAT0YQU6K+tYG9SUW8HtzWbLUAXpV7C8xQ=;
        b=R64es4ttsBQuoEPEChmqFZTgrbOv3MdNL/GALwlF//CVtbmR8lms/Uoi1aOP1bRCOR
         Pub/y+BmASeSXmrjl91hw5zFcRRjXvX117pRLRmnS5U4eclmp5V0NuFHogr0H1H7mmEN
         iYqR8CMlxQ1ZgRVQZt+iuWUxOfJLtCu4jOT9fxYWTb0149XguZVfHc0E3ZHERQkeAbqX
         QzV/xPoyTtvaQNlRoK4UIgwie7Q8R0zubad8VFEEMaw8JmUnEWRAlXEa0ewnt9zqNo1T
         LIdEE2nIWUCRMCx8eH0pf7Cawl2946sZ2FV5FoVKS2Cb50gw/G/CPVGh6TlsTBg3zcxb
         uiKQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3quyAuUxTGP2j7LNEmv4jqA+qv7XZ+BXC0r7ulXGQuuDSzIYP9nqkGvEX4FDJRECP7iSecYeNo+F7UDVQmwcPiFJNjhUVrS3E/ZQghpHosVBXOg3Wm8rurRGiZ846aWCm+SCDq7pmoR1Z6lWsuvjACotPnHzx1BlvmQ2H+SZFsy8=
X-Gm-Message-State: AOJu0Yz0BToWG1b8bdMaqsp+Mhb+N1MILovezocoPqh7MIn3AQVce+9S
	d4N+zIZxxAi6IAoZXTDejOaklSWQ//Vvd8NFIuv3l8DART7mjX6/
X-Google-Smtp-Source: AGHT+IHFZcT7cCZU+2peD7kPFIrbSzoXyVVras2/b4e8Wkx4t8Kby1ECloKaZu4recJeyOK2uAMvKg==
X-Received: by 2002:a19:4344:0:b0:513:e14d:15e1 with SMTP id m4-20020a194344000000b00513e14d15e1mr5689528lfj.57.1711374069495;
        Mon, 25 Mar 2024 06:41:09 -0700 (PDT)
Received: from localhost (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id kv20-20020a17090778d400b00a46cc48ab07sm3068893ejc.221.2024.03.25.06.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 06:41:09 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=7c0212269c912adc4455d93afd23d4aee2f75956631fcdfadad28a09c895;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Mon, 25 Mar 2024 14:41:08 +0100
Message-Id: <D02VH5KH4A9R.6IOJPPMBF0K5@gmail.com>
Cc: <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <lgirdwood@gmail.com>, <jonathanh@nvidia.com>, <mkumard@nvidia.com>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH] ASoC: tegra: Fix DSPK 16-bit playback
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Sameer Pujar" <spujar@nvidia.com>, <broonie@kernel.org>,
 <linux-sound@vger.kernel.org>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240325104928.2796868-1-spujar@nvidia.com>
In-Reply-To: <20240325104928.2796868-1-spujar@nvidia.com>

--7c0212269c912adc4455d93afd23d4aee2f75956631fcdfadad28a09c895
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Mar 25, 2024 at 11:49 AM CET, Sameer Pujar wrote:
> DSPK configuration is wrong for 16-bit playback and this happens because
> the client config is always fixed at 24-bit in hw_params(). Fix this by
> updating the client config to 16-bit for the respective playback.
>
> Fixes: 327ef6470266 ("ASoC: tegra: Add Tegra186 based DSPK driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  sound/soc/tegra/tegra186_dspk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/tegra/tegra186_dspk.c b/sound/soc/tegra/tegra186_d=
spk.c
> index aa37c4ab0adb..3a152e76122b 100644
> --- a/sound/soc/tegra/tegra186_dspk.c
> +++ b/sound/soc/tegra/tegra186_dspk.c
> @@ -1,8 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> +// SPDX-FileCopyrightText: Copyright (c) 2020-2024 NVIDIA CORPORATION & =
AFFILIATES. All rights reserved.
>  //
>  // tegra186_dspk.c - Tegra186 DSPK driver
> -//
> -// Copyright (c) 2020 NVIDIA CORPORATION. All rights reserved.
> =20
>  #include <linux/clk.h>
>  #include <linux/device.h>
> @@ -246,6 +245,7 @@ static int tegra186_dspk_hw_params(struct snd_pcm_sub=
stream *substream,
>  	switch (params_format(params)) {
>  	case SNDRV_PCM_FORMAT_S16_LE:
>  		cif_conf.audio_bits =3D TEGRA_ACIF_BITS_16;
> +		cif_conf.client_bits =3D TEGRA_ACIF_BITS_16;

Do we perhaps want to move the common cif_conf.client_bits assignment
into the S32_LE case now? It doesn't make much sense to have a common
assignment that's overridden for the S16_LE case and only kept for the
only other alternative (S32_LE).

Thierry

--7c0212269c912adc4455d93afd23d4aee2f75956631fcdfadad28a09c895
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYBfvUACgkQ3SOs138+
s6FALg/+Ife+lFuYpPI7oOhuX256Czmwcb6Ey73+YJeFTYvB51f7oFhaupJh0Urj
Gda3FfgCjHbEU4cMrx2jYyKN//Fvs1Yqc3+JK4tmt7E5JAPV4S52lLty8Lgpmvd/
2aDv5UgrH58PrQgQu/QKHmNcGJ0LrAXp6pH6BGrRJZ0URFiOX0CiGRM3W0YsWw9y
87FYcPkpH8Y0hHjfWhJMeh6npOc6CbcjmCdMo7p3SYjBR9Z88BtJA0JGKyE/JoQ6
tLCMgAnJCXbWGfTuUOqCck5kZE0zo7n9Mu8lDdMHhlyJalyc5ikSBiIhGXuDJQHO
LTEyyPO6d3TVaSKF6nRCq5Vg8eaxVW5L5Knc6EYIm+DgsUvXz12ClhXl08EPKtxe
odUxIZuAajREk8YFon5cGszOLgjLEMbl+/d4abD2+YHe0Ct3Qdxwlb0x6pcdWUeg
bxYPqTpAw57nMkmTfZmaUgi42xcgekE0OnLuw8oQ+gPrhC1S+MBJYxe5sztN6XNm
ubfhqDRdniGPGtvnXw9snSpl30q5ec5ZXArARO593ZUSXC6uKK1Rg5s1+na+iKTS
jaXg+yCMcbx01JO3M/VvC2+fsSuCZ1MjBPskCHg+o2jbs9pbpPLpJRV5xZFISyvT
IZfDLFEuJJ1DUp6dVbJbaLHAbPhIaFJmxWLLZ0pGdWZ5wGEC8Nk=
=TLnc
-----END PGP SIGNATURE-----

--7c0212269c912adc4455d93afd23d4aee2f75956631fcdfadad28a09c895--

