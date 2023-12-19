Return-Path: <linux-kernel+bounces-5606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C167818D03
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF8E1C24BC1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66B32031E;
	Tue, 19 Dec 2023 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4thzRet"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04632E647;
	Tue, 19 Dec 2023 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a1fae88e66eso535224766b.3;
        Tue, 19 Dec 2023 08:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703004862; x=1703609662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hnbv43rPSyuI7Tjsf1jCy999PgtXeEb5DS5jkSFPK+Y=;
        b=Q4thzRetp4YzPjqgrzT5mlQeGocrwukaFH6SBZ+xXSF05WlMawLdI0D/S2iMLoiqBo
         fTpO+hopSKLezmu3j8SYzKy2s3b1vm+d5beln/XOsLNur546CLZu/BEUdQyKlffSnWPo
         un2+Cjqnuj57s/Hdu6QjncUf3JchagRUf7RAqRVubvta4r2hAs+7wrTHtG2i7gw+r27x
         qVK1i9stPdHgM89B0AZdJWV59SvHDPLoUQ+WPidRTS1B+5Gu6A01y8E9M0o/mUKRScQk
         1Nb9H7XHPXd5nBOY0rBobrsppdQjnDHWx9BZxFf1qEZirxituYmvYqCzZUM+x0baCWHk
         PQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703004862; x=1703609662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hnbv43rPSyuI7Tjsf1jCy999PgtXeEb5DS5jkSFPK+Y=;
        b=S1SmMvJNj3U8BDuvrqelFs6HNSZ9fUHT/SNoY+x9mcjs+fBpohOLR1WxpJ3JeW5uFD
         kyiwi9iKpDdu8LoNYYq1FXerpng4x6EwQs5EuMr/mAyp1Hy8eN2t7tTIcFSPiW/Gu3LS
         ruSP6wRRclmYItkny10h1MFh81OZkR3p4y/C3KRBjs5GJtnhxvVgLLmBc0R9fY7bC5Bh
         4rhUN9A7CcAfWk2qtVaKHXbTvqr/90e/jsuJYgsOxe+xksBVq7hCuCrRJSS6U4NjYL94
         Qw3fo1TKk8LGwt0YeT5gdhP5vsNSdI50p5awZ8CjgSe0M0IOJKN5wX+JDotR8NxbV3LL
         skLw==
X-Gm-Message-State: AOJu0YwUzwNmiuZpFs1zgZEanMjf62ajBk+SDRi277GmgbPg9sJINSCL
	/YC+ckOerj8eEBKd3p6wp8Y=
X-Google-Smtp-Source: AGHT+IFGpPOrKgiesvyt3dvb35pzq6oOzYVmDiF0hcfrJBLGErG46GoedhJeqiXAL1OIyI4NZrBVxQ==
X-Received: by 2002:a17:906:2611:b0:a23:48d2:be33 with SMTP id h17-20020a170906261100b00a2348d2be33mr1859295ejc.128.1703004861755;
        Tue, 19 Dec 2023 08:54:21 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id s19-20020a170906c31300b00a236e9cfe74sm1381021ejz.103.2023.12.19.08.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 08:54:21 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
 Purism Kernel Team <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Frank Oltmanns <frank@oltmanns.dev>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Frank Oltmanns <frank@oltmanns.dev>
Subject:
 Re: [PATCH 4/5] clk: sunxi-ng: a64: Add constraints on PLL-VIDEO0's n/m ratio
Date: Tue, 19 Dec 2023 17:54:19 +0100
Message-ID: <13411739.uLZWGnKmhe@jernej-laptop>
In-Reply-To: <20231218-pinephone-pll-fixes-v1-4-e238b6ed6dc1@oltmanns.dev>
References:
 <20231218-pinephone-pll-fixes-v1-0-e238b6ed6dc1@oltmanns.dev>
 <20231218-pinephone-pll-fixes-v1-4-e238b6ed6dc1@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne ponedeljek, 18. december 2023 ob 14:35:22 CET je Frank Oltmanns napisal(a):
> The Allwinner A64 manual lists the following constraint for the
> PLL-VIDEO0 clock: 8 <= N/M <= 25
> 
> Use this constraint.
> 
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> index c034ac027d1c..75d839da446c 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> @@ -68,7 +68,8 @@ static SUNXI_CCU_NM_WITH_SDM_GATE_LOCK(pll_audio_base_clk, "pll-audio-base",
>  				       BIT(28),	/* lock */
>  				       CLK_SET_RATE_UNGATE);
>  
> -static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_CLOSEST(pll_video0_clk, "pll-video0",
> +static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_FEAT_NM_RATIO(pll_video0_clk,
> +						"pll-video0",
>  						"osc24M", 0x010,
>  						192000000,	/* Minimum rate */
>  						1008000000,	/* Maximum rate */
> @@ -80,7 +81,10 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_CLOSEST(pll_video0_clk, "pll-vid
>  						297000000,	/* frac rate 1 */
>  						BIT(31),	/* gate */
>  						BIT(28),	/* lock */
> -						CLK_SET_RATE_UNGATE);
> +						CLK_SET_RATE_UNGATE,
> +						CCU_FEATURE_FRACTIONAL |
> +						CCU_FEATURE_CLOSEST_RATE,

Above flags are unrelated change, put them in new patch if needed.

Best regards,
Jernej

> +						8, 25);		/* min/max nm ratio */
>  
>  static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_ve_clk, "pll-ve",
>  					"osc24M", 0x018,
> 
> 





