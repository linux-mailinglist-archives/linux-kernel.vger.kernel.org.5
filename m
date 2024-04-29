Return-Path: <linux-kernel+bounces-162986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A88798B630E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1C71F226A9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C02140E5B;
	Mon, 29 Apr 2024 20:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REU937Cx"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CB613DBBF;
	Mon, 29 Apr 2024 20:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420949; cv=none; b=h9K85U4MWNqIe9gZG9GJt6JdPjzuAoisHA1PdnI9z5sX0EkVga12ffWuujdojxL8eGxpcM5I0LsbZbkMec/1Ak+RXS+2Jmtx/BKYReJJ5kJmdQp9f2hev1tElyv2nrijcj6Gjs/kLSr0qVN3RHdj856qcqpcGV65QJ+p37occUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420949; c=relaxed/simple;
	bh=v+dxWNWY34GkaZ5wYOrRbLg5bO3DUAUxb8ICY4EgA1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NLn2N1RKGMSEEOOtnJ8a3voHsqjoyyBjt200GDBgiA6zKiO9xFZXVFOA1nyw1H73ibl/1orOblENRfNcH5geK0ZWiHlu2SrBs7OSrPFFZz8UX6jf0wnZn9CklFIYWJnsXukRJJzTPWuO4Za6fxMU9cy1yUutdhNReO77Nsccuzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REU937Cx; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a58e787130fso396002466b.0;
        Mon, 29 Apr 2024 13:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714420946; x=1715025746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsKE8r7F5xni1GwzY6+eg4w0O41Z5E2Stz6sTWPm390=;
        b=REU937CxFn9boL4+gwSAq6+MJdzoG5EnZtEtEhXgLOE7/qqXP5c11xnIi/3aMuySGS
         MxDLlP+ng1R0xcsRvrZ7jrifxuK+neVzfOW58IflRX3cv+EPw7yNeGZJoqG7NA0e/gk6
         avMUEeqMT+eK0rmWfnFR5ROTiXWNXdcfO2s8SnRXsAuGpi9NRQJ9myiIiN0gGacwf7Ft
         BlsOZfLZA5eP8/ZfqG7+TcVa5aGoqksOKKAi1w6mC5eaT2jLATfXNgtlVEmc+TfSZR3d
         ygopN/DDrvMnQtAut3Y+FmEphlukeMKARbLItAOOvvnkymaW1B0n6X6hosVCvN3YIJqU
         NRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714420946; x=1715025746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VsKE8r7F5xni1GwzY6+eg4w0O41Z5E2Stz6sTWPm390=;
        b=oAaMoCv6386RtEiuUUPZSko+Hau87FyQo7J8Yaedc9rXlZUcADXMKWdvivEMVUpvCF
         3UZIjIa8rVTv+rUyd4FjRPsriXXqVM6NNTIkqtPdwLasxy08YN1WM/haSF4U1Bvu9iuo
         LgdwG7+EnDpTMs4MVm4++HeWyEHlz7bdSJGGAGM8PeulM5FjU1EUvADPO5J4O+kweW/+
         ewZbSMpZKAQS28F7KxkfHAcq53vuMMuKi+q9KBRtFO1EvX1b8YXAkyFHOVFg+L5amnbB
         nt/2YX3rn7JMh2dYUpGEqR1ZjszR9l+3Pk5+gxVEhnYVijukJ6svgdTvsqf1oB6rEmOd
         ne4g==
X-Forwarded-Encrypted: i=1; AJvYcCUum9hKs80GmtgObNqPgBzogCViGRqKgqxQ5OBYIlH/d8VAHDTo+XgHwjGQP4CRKiFRslZoUD+aOA+yXIWKt37vVcSR9o0uc0ebIZdzsBhDghCqizhUBaR54mpCxrDhxgN/4RyUpgWZQso=
X-Gm-Message-State: AOJu0Yzql7J2KU+eis3BMxBcvVBo9giLCRVHPzd06BrpKSVUJlpviqx0
	wspZvXXdZxkxTxmTwxS7j6QWfmGSozefGiCG7S/eipV4/JyFxBFe
X-Google-Smtp-Source: AGHT+IHIKx0SyAjsW4Smx5uzNZpKk0OnRHPvT5Zv6XPyI3hdLPyaGW8TdxmJ1VY4Gefq40RqnxSymg==
X-Received: by 2002:a17:907:7e9e:b0:a58:e8cf:664f with SMTP id qb30-20020a1709077e9e00b00a58e8cf664fmr718919ejc.23.1714420945336;
        Mon, 29 Apr 2024 13:02:25 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id r20-20020a170906705400b00a555ef55ab5sm14215787ejj.218.2024.04.29.13.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 13:02:24 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Ban Tao <fengzheng923@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Joao Schim <joao@schimsalabim.eu>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2] ASoC: sunxi: DMIC: Add controls for adjusting the mic gains
Date: Mon, 29 Apr 2024 22:02:23 +0200
Message-ID: <2931892.e9J7NaK4W3@jernej-laptop>
In-Reply-To: <20240429194920.1596257-1-joao@schimsalabim.eu>
References: <20240429194920.1596257-1-joao@schimsalabim.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne ponedeljek, 29. april 2024 ob 21:49:20 GMT +2 je Joao Schim napisal(a):
> The AllWinner H6 and later SoCs that sport a DMIC block contain a set of registers to control
> the gain (left + right) of each of the four supported channels.
> 
> Add ASoC controls for changing each of the stereo channel gains using alsamixer and alike
> 
> Signed-off-by: Joao Schim <joao@schimsalabim.eu>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  sound/soc/sunxi/sun50i-dmic.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/sound/soc/sunxi/sun50i-dmic.c b/sound/soc/sunxi/sun50i-dmic.c
> index c76628bc86c6..dd32780fb6a4 100644
> --- a/sound/soc/sunxi/sun50i-dmic.c
> +++ b/sound/soc/sunxi/sun50i-dmic.c
> @@ -14,6 +14,7 @@
>  #include <sound/dmaengine_pcm.h>
>  #include <sound/pcm_params.h>
>  #include <sound/soc.h>
> +#include <sound/tlv.h>
>  
>  #define SUN50I_DMIC_EN_CTL			(0x00)
>  	#define SUN50I_DMIC_EN_CTL_GLOBE			BIT(8)
> @@ -43,6 +44,17 @@
>  	#define SUN50I_DMIC_CH_NUM_N_MASK			GENMASK(2, 0)
>  #define SUN50I_DMIC_CNT				(0x2c)
>  	#define SUN50I_DMIC_CNT_N				(1 << 0)
> +#define SUN50I_DMIC_D0D1_VOL_CTR		(0x30)
> +	#define SUN50I_DMIC_D0D1_VOL_CTR_0R			(0)
> +	#define SUN50I_DMIC_D0D1_VOL_CTR_0L			(8)
> +	#define SUN50I_DMIC_D0D1_VOL_CTR_1R			(16)
> +	#define SUN50I_DMIC_D0D1_VOL_CTR_1L			(24)
> +#define SUN50I_DMIC_D2D3_VOL_CTR                (0x34)
> +        #define SUN50I_DMIC_D2D3_VOL_CTR_2R                     (0)
> +        #define SUN50I_DMIC_D2D3_VOL_CTR_2L                     (8)
> +        #define SUN50I_DMIC_D2D3_VOL_CTR_3R                     (16)
> +        #define SUN50I_DMIC_D2D3_VOL_CTR_3L                     (24)
> +
>  #define SUN50I_DMIC_HPF_CTRL			(0x38)
>  #define SUN50I_DMIC_VERSION			(0x50)
>  
> @@ -273,8 +285,30 @@ static const struct of_device_id sun50i_dmic_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, sun50i_dmic_of_match);
>  
> +static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(sun50i_dmic_vol_scale, -12000, 75, 1);
> +
> +static const struct snd_kcontrol_new sun50i_dmic_controls[] = {
> +
> +        SOC_DOUBLE_TLV("DMIC Channel 0 Capture Volume", SUN50I_DMIC_D0D1_VOL_CTR,
> +                       SUN50I_DMIC_D0D1_VOL_CTR_0L, SUN50I_DMIC_D0D1_VOL_CTR_0R,
> +                       0xFF, 0, sun50i_dmic_vol_scale),
> +        SOC_DOUBLE_TLV("DMIC Channel 1 Capture Volume", SUN50I_DMIC_D0D1_VOL_CTR,
> +                       SUN50I_DMIC_D0D1_VOL_CTR_1L, SUN50I_DMIC_D0D1_VOL_CTR_1R,
> +                       0xFF, 0, sun50i_dmic_vol_scale),
> +        SOC_DOUBLE_TLV("DMIC Channel 2 Capture Volume", SUN50I_DMIC_D2D3_VOL_CTR,
> +                       SUN50I_DMIC_D2D3_VOL_CTR_2L, SUN50I_DMIC_D2D3_VOL_CTR_2R,
> +                       0xFF, 0, sun50i_dmic_vol_scale),
> +        SOC_DOUBLE_TLV("DMIC Channel 3 Capture Volume", SUN50I_DMIC_D2D3_VOL_CTR,
> +                       SUN50I_DMIC_D2D3_VOL_CTR_3L, SUN50I_DMIC_D2D3_VOL_CTR_3R,
> +                       0xFF, 0, sun50i_dmic_vol_scale),
> +
> +
> +};
> +
>  static const struct snd_soc_component_driver sun50i_dmic_component = {
>  	.name           = "sun50i-dmic",
> +	.controls	= sun50i_dmic_controls,
> +	.num_controls	= ARRAY_SIZE(sun50i_dmic_controls),
>  };
>  
>  static int sun50i_dmic_runtime_suspend(struct device *dev)
> 





