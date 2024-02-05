Return-Path: <linux-kernel+bounces-53168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0F784A19B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27B75284EBB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91932481CB;
	Mon,  5 Feb 2024 17:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aW4OyUKS"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CA8481A0;
	Mon,  5 Feb 2024 17:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155775; cv=none; b=q8CEGz0bPzJHfgZ1bPTYPZ4mimFUAYBRtKy0vBVxIvEm5PUdkqcjB5LenRJNsmWo+0lBn6SP5PkxePWXTCrRvX4T2o4oXtgaGejTuZD7DbTT45E47pmkY/6zjFtwmMIdWX71BjRQZpNIEQ+9e9qr02nyZ9HPBOln29nrFmi3/JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155775; c=relaxed/simple;
	bh=dcEb2nf7K4Z0S7p1uHTCyCEbqhKHVVffOCKTgy2nN0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ki6gU2nSd13PHkVRccp3Fec3eyuQCrUi4YUn7VDSKqJY6IZcYyOy7rsS2ddrBhDq/tQ/sQFWkMCzg3vW7vgw4/R/cI4ZmiSR5DafrmZzZYzjAvxbk4Nnn4CadaURrtb9Le6zjU8BYbG69pk+dVE7Ookanyjz8gjy2tX/ONBQtkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aW4OyUKS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40fdd5bbe65so7444905e9.2;
        Mon, 05 Feb 2024 09:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707155772; x=1707760572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQo7DEH+Zbxsn/GDq6x2R3lR0LaSJXJADj+lFUkrcCQ=;
        b=aW4OyUKSCdWvdvUIrUGg7x4Bex6NWRc+O9ilT3tvtphu+oJukAPap9Mt3gyNCJkhuM
         grqxXjRhY0+n/Xv/25Xm8VE2iDf3WV1t2OIYCNcuypS1m0Cj8tlc3Hoa+Rkd6ZErVSTt
         H/qVheAWP7CvvqTCCJDC5+MH81EIc+3bT9GIzlXb9pH8z6GZrkIaocO4DmxhxDAep4kz
         YGH2YoIKvFwzyJx9Ofz8DcOuaQfyH5m35sKjUqlZolihECZwAr7OcfBCQbc94vO2CUj1
         UKx7OFzucy4Z5Y9V+qvaXeVAuL3wBdJcHY+uTc90tKQLrU6CcUYm4u+SFoZvdRmMi3X6
         oelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707155772; x=1707760572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQo7DEH+Zbxsn/GDq6x2R3lR0LaSJXJADj+lFUkrcCQ=;
        b=CZ3MFsPS8lJ3BjwALTjx8FscGFjLyfEgR08itzB4eOUeUjsERw6rJTOmBBxS/v2dgO
         EVUnuhtDhnm8wsl66dI3RmgpdIA5Xei4K58ks3hleSvz2CMRiQYgCHxOpuirKMiDisdU
         ntq28B5cXP+uS0ipkWkWOurHDX/U8U5YyzmtyQBvKgHe781JVN2HZj56vj4/6ZfHZzpL
         ki9tW9k22XzD1jqQIgVn/kHl81AUjK1NqApYEJpxRjTL7j+4JgoaIQyFUoC4a6Du274I
         zcqCWIGtBpFObePdyGWpu7NlBm2q/KdcTCRfz0NQECEwci0+m3sNBS594vVbHW/S33Fm
         N2Kw==
X-Gm-Message-State: AOJu0YytGJOBd57a/ZWNZ08t20lbFem1++/e0bXl3hdHism8aCnJZOYj
	H5dPQBE3I7F1cuLfV95TD2gpac6eplmkb5usjehjUyMmVMY+e3ay
X-Google-Smtp-Source: AGHT+IEsTlp9iHH6e8DPKagWNrPZEnjKRxqc6vq6sXhD5ZPYHBTALUGH8fsHvNTKshHOCqRe73BnQw==
X-Received: by 2002:a05:600c:4e90:b0:40e:f681:b7b6 with SMTP id f16-20020a05600c4e9000b0040ef681b7b6mr340863wmq.37.1707155772063;
        Mon, 05 Feb 2024 09:56:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXPLF5BJxHk+SVf+iXJqOC4NqstlwVSQCIrIQZ0CNKx8ubzjsfiVziRQGSQjYrsoTpZS719hvULJu17cAsZCT1mJqFYI87qvTedGmJh27eHfDmDc/xT+M4qqBBmjm1fw5N0GFwDaOt5pID6gTxIDZzOG699DFKNj10o5fwAuCAjF/iBN5GfoIDWavEsOcGYJRC0i0oc/EEWvPfQfDpX8V0OXLXLm7zbwOgTkrV840/lRKYjWXEzpdNT7ruexZWEx7yt1Y7AWw0mgsfD3gF9jzPiqwVeqtLeVkKk6OiP0pg11SrkJkWPpcD33wXcDmrzX44WIjkvgzTvM01NkQiFu6sKPtuHTxjVmc7DKWkYk0HMq8w9DVJVHId+g8FMK5qFa3a+Hbe5YwXWckiu65qxVa6SUJuagtrMU6nr5bKCqks/E9gLYFxzvum7AFxwEcph+cl9FtZklC6jPxL12g41YTi4tG6usJR9juOrxJMvKmQiRH9CF4e9yBZBlEopCajudfY3Sk+I5UmM/i2DXlhyB0rEoqns95uSDxyUgBtgbv+0bdeL+xLYqpuMU/cjhxrmZ44fkH+BvJ5nz6cBI7Z+/mO2rQzRk66jE62DAIeCR36FneUwm7kHaV5CQ+wvM1x1M6a24wmx0kviiUARhVkKOtxWREpKRc6Z0erXqYG2cTyUDJjw0U0LsZ4R7WTH+Rtx2NI9tzNWsnjEM1WG5YUcs684BlQZBX6+EC4/1q2b2veO7C/qHXyN0jZMKO5H7Z7NoyHN5pObCTBBPA==
Received: from jernej-laptop.localnet (82-149-13-182.dynamic.telemach.net. [82.149.13.182])
        by smtp.gmail.com with ESMTPSA id c29-20020adfa31d000000b0033b3a010001sm144509wrb.4.2024.02.05.09.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:56:11 -0800 (PST)
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
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Oltmanns <frank@oltmanns.dev>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 Frank Oltmanns <frank@oltmanns.dev>
Subject:
 Re: [PATCH v2 3/6] clk: sunxi-ng: nkm: Support minimum and maximum rate
Date: Mon, 05 Feb 2024 18:56:09 +0100
Message-ID: <4543794.LvFx2qVVIh@jernej-laptop>
In-Reply-To: <20240205-pinephone-pll-fixes-v2-3-96a46a2d8c9b@oltmanns.dev>
References:
 <20240205-pinephone-pll-fixes-v2-0-96a46a2d8c9b@oltmanns.dev>
 <20240205-pinephone-pll-fixes-v2-3-96a46a2d8c9b@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne ponedeljek, 05. februar 2024 ob 16:22:26 CET je Frank Oltmanns napisal(a):
> According to the Allwinner User Manual, the Allwinner A64 requires
> PLL-MIPI to run at 500MHz-1.4GHz. Add support for that to ccu_nkm.
> 
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> ---
>  drivers/clk/sunxi-ng/ccu_nkm.c | 13 +++++++++++++
>  drivers/clk/sunxi-ng/ccu_nkm.h |  2 ++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
> index 1168d894d636..7d135908d6e0 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> @@ -181,6 +181,12 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
>  	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
>  		rate *= nkm->fixed_post_div;
>  
> +	if (nkm->min_rate && rate < nkm->min_rate)
> +		rate = nkm->min_rate;
> +
> +	if (nkm->max_rate && rate > nkm->max_rate)
> +		rate = nkm->max_rate;

Please take a look at ccu_nm_round_rate() code. You need to consider postdiv
and you can return immediately.

> +
>  	if (!clk_hw_can_set_rate_parent(&nkm->common.hw))
>  		rate = ccu_nkm_find_best(*parent_rate, rate, &_nkm, &nkm->common);
>  	else
> @@ -220,6 +226,13 @@ static int ccu_nkm_set_rate(struct clk_hw *hw, unsigned long rate,
>  	_nkm.min_m = 1;
>  	_nkm.max_m = nkm->m.max ?: 1 << nkm->m.width;
>  
> +
> +	if (nkm->min_rate && rate < nkm->min_rate)
> +		rate = nkm->min_rate;
> +
> +	if (nkm->max_rate && rate > nkm->max_rate)
> +		rate = nkm->max_rate;
> +

No need for this, clk subsystem calls round rate before setting actual clock
rate.

Best regards,
Jernej

>  	ccu_nkm_find_best(parent_rate, rate, &_nkm, &nkm->common);
>  
>  	spin_lock_irqsave(nkm->common.lock, flags);
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.h b/drivers/clk/sunxi-ng/ccu_nkm.h
> index c409212ee40e..358a9df6b6a0 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkm.h
> +++ b/drivers/clk/sunxi-ng/ccu_nkm.h
> @@ -27,6 +27,8 @@ struct ccu_nkm {
>  	struct ccu_mux_internal	mux;
>  
>  	unsigned int		fixed_post_div;
> +	unsigned long		min_rate;
> +	unsigned long		max_rate;
>  	unsigned long		max_m_n_ratio;
>  	unsigned long		min_parent_m_ratio;
>  
> 
> 





