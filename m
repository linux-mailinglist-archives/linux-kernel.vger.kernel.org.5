Return-Path: <linux-kernel+bounces-158272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D04D58B1DB5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98451F20010
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669FB86248;
	Thu, 25 Apr 2024 09:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="n2jmnZOj"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D8984D1C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036744; cv=none; b=Agz1Ns44N+lUsjkUudczZIyA7bgS52g+alUfxEGCdfTRUUQ8n/iwGeI5d4QwCXbX6auTPg0GonJipeBpnhwmzzmK9SaJWFSFAPq/Xn3ofYqhAKQ1pgxS5B2gxJI/XPimbBfHTbUJmFfqmjawB6TFn7bel9KA6216OZ1reCCjiVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036744; c=relaxed/simple;
	bh=9ukg3ruu+ax3frqEmm5ZMZBZr8axWQjOXc7tfBTfkIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=ibu+p1zUpcAlU2EHHej5lm4oEWuvcVcADxpjQc2oIWTrPwLfRlhFKS+AL7zyQOYu9MOYG+Botm/dmqyXHk6Nk/q44j3cfWYEd/zEKNKAK+VzOSkG2Z5Ej3RVbbo67yMc6JWn0g/wuDx7yW5eDxT1pgSzI05lKrhejVUO9P8BR7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=n2jmnZOj; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240425091901euoutp02c81fb13751ff4081aaea8d0f0e00f9c7~Je1Wuy3au1614216142euoutp02i
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:19:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240425091901euoutp02c81fb13751ff4081aaea8d0f0e00f9c7~Je1Wuy3au1614216142euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714036741;
	bh=VVybz3ArjG9SCkgGYI737DCfD9gNvfNWH5pq4og9JqM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=n2jmnZOj+xfBxkwgxzN+y5rOEAcx0ppo65WLIu2F1N449bWFdBSSWszstKMIwiXLQ
	 rr4yoyL2siZ2vXjJdzF6REikIPFheYS+MCpVaAdg3m5j8ZUh23Rt0+FZuTx5FkcrOB
	 GukJEehdYMcVVm6slV+J3BbFPUBuaStmW+zfum9o=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240425091900eucas1p1645037da54c87e6c9656aeaf90ded5bb~Je1WXRL1z0566605666eucas1p16;
	Thu, 25 Apr 2024 09:19:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 95.FA.09624.4002A266; Thu, 25
	Apr 2024 10:19:00 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240425091900eucas1p190e706ee0812ddf335f73a19a0d1d2fe~Je1V4M4BG0531605316eucas1p1z;
	Thu, 25 Apr 2024 09:19:00 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240425091900eusmtrp2f52e83848f5a5dc3139f028e2f6c11d2~Je1V2Y63_0050200502eusmtrp2C;
	Thu, 25 Apr 2024 09:19:00 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-87-662a200478bf
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 26.5D.08810.4002A266; Thu, 25
	Apr 2024 10:19:00 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240425091859eusmtip17ec77fc46434a61640e187bdbde9790d~Je1U5fpUe1005310053eusmtip1Y;
	Thu, 25 Apr 2024 09:18:59 +0000 (GMT)
Message-ID: <6fcfe1bb-a1e9-4d7c-aff7-e572bcdf5d31@samsung.com>
Date: Thu, 25 Apr 2024 11:18:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] drm/bridge: samsung-dsim: Fix porch
 calcalcuation rounding
To: Adam Ford <aford173@gmail.com>, dri-devel@lists.freedesktop.org
Cc: marex@denx.de, aford@beaconembedded.com, Frieder Schrempf
	<frieder.schrempf@kontron.de>, Inki Dae <inki.dae@samsung.com>, Jagan Teki
	<jagan@amarulasolutions.com>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil
	Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
	<jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
	Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Marco Felsch
	<m.felsch@pengutronix.de>, Michael Tretter <m.tretter@pengutronix.de>,
	linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20240211230931.188194-2-aford173@gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0yTVxjHc95bS13NS8X0qCwsTeo2BhV0l+NQdLAPb/ww8QOhzjip8goo
	VNaKii5NXTKUkrECLpYKpUAVRAXHAO1FXHERKrFuTFipJV2dCRfpsBbY5iLO9t2Fb//zPL/n
	8n9y+LjoLLWaX6g8zKqUiiIJJSB6b/95L5l4LXF/ir1KinwPhnBkH6nkocGfmzHkbwkT6EVv
	NY7uz89S6MvzbhLV+PUEmuvSU2iisQMg18wIgSqqLTz0k62eQk9sIzjqbXvJNYV6CDRTfhKg
	8ooLJJq1egGqMY2RqHummty6krkS8pPMVKsWZ0zGQYK5sWAmGKtxnMecO11HMi2OKYzpaq+g
	mO9HWkhmUD+MMb5RB8WYXDsYf+UAxnz1PIWp6m4HzLdDJ7JiPxZsymOLCo+wqnXpuYKCCVMz
	KGmIPXb3mRNogVeoAzF8SL8Nv6j8DdcBAV9EtwEY/s6FRxIieg7AW82ZnA4D2BTQ6AA/WrDY
	9hnHtwL4dc2PPI4JAaib/jSihXQ6ND+pjfYhaClcMFdQXDwWuuoeERG9kk6Afq8hWruClsO5
	2stRPo7OhK7nC1hkAE5PkTAY6CEjCZwWQ++jRiyiKToV6oK6aNMYeiMc6wwQHJMArwXro24g
	XSeA7gttBGfzQzjqtFKcXgGnB7p5nI6HL6yNGFdwCkDzX/5/HnoAtRNewFFp0Od+RkX84/Sb
	sNO2jgt/AO/a+kjuLMuhJxjLLbEc1vSexbmwEJ4uF3H0Wmgc6PhvrPOHYVwPJMYldzEusWlc
	Ysf4/1wzINqBmC1VF+ez6lQle1SmVhSrS5X5sn2HirvAy787tDjw9DpomA7J+gHGB/0A8nFJ
	nHAs9MZ+kTBPUXacVR3aoyotYtX9YA2fkIiF0rwEVkTnKw6zB1m2hFX9m8X4Mau12EaLnecY
	29RwxpBxgp+5xYEb5TnSTkOZSJlrzbnxiWPzVfUBbZY0OTm+YFmVopA4fyltWNZPTrzfcW7+
	ZsaZK7MlijUWeUpn31GVXZz99KYntHPVPct7W2tvuak7RXWnLiUOY9nhpDS1Z9d6zWPBXsXv
	l+ud78g0+vVOtKPVZEieHZw0d2zw5fBSai9+vm3t1Z6DoodvJckSdH2/Bu4odkv+8GSLPkr0
	/SI/ucwWL08/Ml6m2feNRHN7qHi+fdX9LfOTDzIeOirr418db7zmyRqdlC7GPd4buL45EFPl
	toe3l1qOhUbJd8VNvKTggazdhlfyct2vo10bBMGmPd21249LCHWBIjURV6kVfwNriKwIKgQA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsVy+t/xu7osClppBnevMlvcuX2a2WL31W52
	ixPXFzFZ3F/8mcXi/7aJzBZXvr5ns+hdeo7VYtL9CSwWXzZNYLN4Pn8do8XJN1dZLDonLmG3
	uLxrDpvFh11AU7atAKpb+HEri8WbtkZGi7bOZawW73feYrSYNO8mq8WWNxNZHUQ91n68z+rx
	cnkDs8e8WSdYPPZ+W8DisXPWXXaP2R0zWT0W73nJ5LFpVSebx5Gri1k9Tky4xORx59oeNo95
	JwM97ncfZ/Lo/2vg0bdlFaPH5tPVAYJRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbm
	sVZGpkr6djYpqTmZZalF+nYJehnP5y1iLJgrWHH210HGBsZbvF2MHBwSAiYS/1bUdDFycQgJ
	LGWUWHbgGUsXIydQXEbi5LQGVghbWOLPtS42iKL3jBJzXu5kA0nwCthJLPgwmRnEZhFQlfi2
	oBMqLihxcuYTsEGiAvIS92/NYAexhQUiJG5ObQKzRQScJU7+/cYEMpRZ4DWrxLdb5xghNuxm
	lPh5YS3YVGYBcYlbT+YzgdhsAoYSXW+7wDZwClhK3Fz/kAWixkyia2sXI4QtL7H97RzmCYxC
	s5AcMgvJqFlIWmYhaVnAyLKKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMNlsO/Zz8w7Gea8+
	6h1iZOJgPMQowcGsJMJ786NGmhBvSmJlVWpRfnxRaU5q8SFGU2BoTGSWEk3OB6a7vJJ4QzMD
	U0MTM0sDU0szYyVxXs+CjkQhgfTEktTs1NSC1CKYPiYOTqkGpnn1qROTT87T2TuBSbxu5/9F
	fZtMb29yfnPy/9yDTw4kSkyf7SG9cJlc3KWjK4uZeNb8yr9eZPNO+nCNWkZ59ZbtVz+5T3hw
	zECXb2t2yHbhIueDkcu/r5bivLpj0rF/EmwXXgdvYe66aLPLLEpU+O0N9qKP3EvWffY42l6/
	uHpp1TtRqQnNQt4FHJc29r39URZ/o+X/XZPJfzo4uU38V7Gm3eqweq9z+GDsrZlmXtGLpTm8
	Oye0Hy8rsD6uvjNM9BlXa/1ptrI3x1PSlx6YYrhj/8MNBhoRAlwuXs/KUw3Pcyw+kL6yZM25
	KKWSGf3r3HbZz978NPX0hOPiPK9iGnUFGE119TqcRYvZX+3IyVFiKc5INNRiLipOBADu2C4P
	vwMAAA==
X-CMS-MailID: 20240425091900eucas1p190e706ee0812ddf335f73a19a0d1d2fe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240211230945eucas1p1863deb244ef4fdc68825ff01d082e270
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240211230945eucas1p1863deb244ef4fdc68825ff01d082e270
References: <20240211230931.188194-1-aford173@gmail.com>
	<CGME20240211230945eucas1p1863deb244ef4fdc68825ff01d082e270@eucas1p1.samsung.com>
	<20240211230931.188194-2-aford173@gmail.com>

On 12.02.2024 00:09, Adam Ford wrote:
> When using video sync pulses, the HFP, HBP, and HSA are divided between
> the available lanes if there is more than one lane.  For certain
> timings and lane configurations, the HFP may not be evenly divisible.
> If the HFP is rounded down, it ends up being too small which can cause
> some monitors to not sync properly. In these instances, adjust htotal
> and hsync to round the HFP up, and recalculate the htotal.
>
> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de> # Kontron BL i.MX8MM with HDMI monitor
> Signed-off-by: Adam Ford <aford173@gmail.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
> V2:  No changes
>
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
> index 8476650c477c..52939211fe93 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -1606,6 +1606,27 @@ static int samsung_dsim_atomic_check(struct drm_bridge *bridge,
>   		adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
>   	}
>   
> +	/*
> +	 * When using video sync pulses, the HFP, HBP, and HSA are divided between
> +	 * the available lanes if there is more than one lane.  For certain
> +	 * timings and lane configurations, the HFP may not be evenly divisible.
> +	 * If the HFP is rounded down, it ends up being too small which can cause
> +	 * some monitors to not sync properly. In these instances, adjust htotal
> +	 * and hsync to round the HFP up, and recalculate the htotal. Through trial
> +	 * and error, it appears that the HBP and HSA do not appearto need the same
> +	 * correction that HFP does.
> +	 */
> +	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE && dsi->lanes > 1) {
> +		int hfp = adjusted_mode->hsync_start - adjusted_mode->hdisplay;
> +		int remainder = hfp % dsi->lanes;
> +
> +		if (remainder) {
> +			adjusted_mode->hsync_start += remainder;
> +			adjusted_mode->hsync_end   += remainder;
> +			adjusted_mode->htotal      += remainder;
> +		}
> +	}
> +
>   	return 0;
>   }
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


