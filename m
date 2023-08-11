Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D38779499
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbjHKQaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234235AbjHKQaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:30:14 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3C3114
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:30:13 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe44955decso2515275e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691771411; x=1692376211;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2/ZgtA0gGeFA9ARzcKyq/wfMee1HxVAs2Iq9uKy9GzI=;
        b=T45ipXlkJctgMiHzz+/lYcwMfWNHoGh+Bu7pIOMhsYbLipQLXBpZ0UZ4ZJeq73gRIF
         WlSZbpBQwNOGoDLk9Gj2cgQhn2dIV3t16JeXYz90bmgBnszduX540Co8vUmW+pSjVPK7
         qgjIpIvL9i10521xujgKNoiHB8LaSxwDrk22Yy3jn45IActFwkxCW0O+gXb0y24hqxwt
         gfVs3ZddXahIRiL1tha11JVpyDlU7EoX8fwx4gbydMlVn9pOgB10NvqQVPDNIWVjI4s9
         XcWtV8mI0YLYAKcQtS3kIGLn7uDcnTFnywA8cMd8Os0oZ8GzUvKP9NvCiC1ZyKTbu9rq
         sYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691771411; x=1692376211;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2/ZgtA0gGeFA9ARzcKyq/wfMee1HxVAs2Iq9uKy9GzI=;
        b=B2jfHO0j7VPYcS3z/Aqcia3SjpRoZTVlHiRchejwGFq7s//f9gZvUg63VWdSOyNeDS
         hWXWC3c806mbI+mIoN9mTH37I9KR+4EPpFbZNZyDEYh3KEuqnhSLMz82ory3JQ/7EpYK
         /i+TYfgyO6M27CQrMNebgPtoCIzciuAdCQHa6FcjrQqI66GeNVKb13AgE5ibY7m6wt4e
         71HXHVDn70VIRezIa1+/nlnFdt4NqcI3u3hbyERC5IuygpNvgnMwtlj6vjaZXW4anx1R
         v/YmC5Ex3hOXvXXjG78tFg65v/4jR37WBC8568PFTHmaxBsfSsD9HDhfI+WSEZxJTnrI
         YDFQ==
X-Gm-Message-State: AOJu0Yz+1fs1/5OZdjar8dvmyTArVqzjUR2qqvzZZkRFSKMJlui6YFf8
        dWHmA0/5MExIuaw8hc2M+WE=
X-Google-Smtp-Source: AGHT+IGiN9mlvaEZFQjq2+rvs0GpAhRCAVkwzXmxQ+7B4rkc734LEfrg2khTGF8Oo01cjH4BCo0Luw==
X-Received: by 2002:a05:6512:3111:b0:4fb:8938:48ab with SMTP id n17-20020a056512311100b004fb893848abmr789797lfb.16.1691771411434;
        Fri, 11 Aug 2023 09:30:11 -0700 (PDT)
Received: from [10.0.0.100] (host-85-29-92-32.kaisa-laajakaista.fi. [85.29.92.32])
        by smtp.gmail.com with ESMTPSA id a5-20020a19f805000000b004fb9536bc99sm778839lff.169.2023.08.11.09.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 09:30:11 -0700 (PDT)
Message-ID: <38ea533d-bae1-4c31-a5d9-bd65bbd98fc7@gmail.com>
Date:   Fri, 11 Aug 2023 19:32:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] drm/bridge: tc358768: Use dev for dbg prints, not
 priv->dev
Content-Language: en-US
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Francesco Dolcini <francesco@dolcini.it>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Aradhya Bhatia <a-bhatia1@ti.com>
References: <20230804-tc358768-v1-0-1afd44b7826b@ideasonboard.com>
 <20230804-tc358768-v1-6-1afd44b7826b@ideasonboard.com>
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20230804-tc358768-v1-6-1afd44b7826b@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/08/2023 13:44, Tomi Valkeinen wrote:
> Simplify the code by capturing the priv->dev value to dev variable, and
> use it.

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/gpu/drm/bridge/tc358768.c | 41 ++++++++++++++++++++-------------------
>  1 file changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
> index 0ef51d04bb21..3266c08d9bf1 100644
> --- a/drivers/gpu/drm/bridge/tc358768.c
> +++ b/drivers/gpu/drm/bridge/tc358768.c
> @@ -651,9 +651,10 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
>  	const u32 internal_delay = 40;
>  	int ret, i;
>  	struct videomode vm;
> +	struct device *dev = priv->dev;
>  
>  	if (mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) {
> -		dev_warn_once(priv->dev, "Non-continuous mode unimplemented, falling back to continuous\n");
> +		dev_warn_once(dev, "Non-continuous mode unimplemented, falling back to continuous\n");
>  		mode_flags &= ~MIPI_DSI_CLOCK_NON_CONTINUOUS;
>  	}
>  
> @@ -661,7 +662,7 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
>  
>  	ret = tc358768_sw_reset(priv);
>  	if (ret) {
> -		dev_err(priv->dev, "Software reset failed: %d\n", ret);
> +		dev_err(dev, "Software reset failed: %d\n", ret);
>  		tc358768_hw_disable(priv);
>  		return;
>  	}
> @@ -669,7 +670,7 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
>  	mode = &bridge->encoder->crtc->state->adjusted_mode;
>  	ret = tc358768_setup_pll(priv, mode);
>  	if (ret) {
> -		dev_err(priv->dev, "PLL setup failed: %d\n", ret);
> +		dev_err(dev, "PLL setup failed: %d\n", ret);
>  		tc358768_hw_disable(priv);
>  		return;
>  	}
> @@ -709,7 +710,7 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
>  		data_type = MIPI_DSI_PACKED_PIXEL_STREAM_16;
>  		break;
>  	default:
> -		dev_err(priv->dev, "Invalid data format (%u)\n",
> +		dev_err(dev, "Invalid data format (%u)\n",
>  			dsi_dev->format);
>  		tc358768_hw_disable(priv);
>  		return;
> @@ -733,65 +734,65 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
>  				  dsibclk);
>  	dsiclk_nsk = (u32)div_u64((u64)1000000000 * TC358768_PRECISION, dsiclk);
>  	ui_nsk = dsiclk_nsk / 2;
> -	dev_dbg(priv->dev, "dsiclk_nsk: %u\n", dsiclk_nsk);
> -	dev_dbg(priv->dev, "ui_nsk: %u\n", ui_nsk);
> -	dev_dbg(priv->dev, "dsibclk_nsk: %u\n", dsibclk_nsk);
> +	dev_dbg(dev, "dsiclk_nsk: %u\n", dsiclk_nsk);
> +	dev_dbg(dev, "ui_nsk: %u\n", ui_nsk);
> +	dev_dbg(dev, "dsibclk_nsk: %u\n", dsibclk_nsk);
>  
>  	/* LP11 > 100us for D-PHY Rx Init */
>  	val = tc358768_ns_to_cnt(100 * 1000, dsibclk_nsk) - 1;
> -	dev_dbg(priv->dev, "LINEINITCNT: %u\n", val);
> +	dev_dbg(dev, "LINEINITCNT: %u\n", val);
>  	tc358768_write(priv, TC358768_LINEINITCNT, val);
>  
>  	/* LPTimeCnt > 50ns */
>  	val = tc358768_ns_to_cnt(50, dsibclk_nsk) - 1;
>  	lptxcnt = val;
> -	dev_dbg(priv->dev, "LPTXTIMECNT: %u\n", val);
> +	dev_dbg(dev, "LPTXTIMECNT: %u\n", val);
>  	tc358768_write(priv, TC358768_LPTXTIMECNT, val);
>  
>  	/* 38ns < TCLK_PREPARE < 95ns */
>  	val = tc358768_ns_to_cnt(65, dsibclk_nsk) - 1;
> -	dev_dbg(priv->dev, "TCLK_PREPARECNT %u\n", val);
> +	dev_dbg(dev, "TCLK_PREPARECNT %u\n", val);
>  	/* TCLK_PREPARE + TCLK_ZERO > 300ns */
>  	val2 = tc358768_ns_to_cnt(300 - tc358768_to_ns(2 * ui_nsk),
>  				  dsibclk_nsk) - 2;
> -	dev_dbg(priv->dev, "TCLK_ZEROCNT %u\n", val2);
> +	dev_dbg(dev, "TCLK_ZEROCNT %u\n", val2);
>  	val |= val2 << 8;
>  	tc358768_write(priv, TC358768_TCLK_HEADERCNT, val);
>  
>  	/* TCLK_TRAIL > 60ns AND TEOT <= 105 ns + 12*UI */
>  	raw_val = tc358768_ns_to_cnt(60 + tc358768_to_ns(2 * ui_nsk), dsibclk_nsk) - 5;
>  	val = clamp(raw_val, 0, 127);
> -	dev_dbg(priv->dev, "TCLK_TRAILCNT: %u\n", val);
> +	dev_dbg(dev, "TCLK_TRAILCNT: %u\n", val);
>  	tc358768_write(priv, TC358768_TCLK_TRAILCNT, val);
>  
>  	/* 40ns + 4*UI < THS_PREPARE < 85ns + 6*UI */
>  	val = 50 + tc358768_to_ns(4 * ui_nsk);
>  	val = tc358768_ns_to_cnt(val, dsibclk_nsk) - 1;
> -	dev_dbg(priv->dev, "THS_PREPARECNT %u\n", val);
> +	dev_dbg(dev, "THS_PREPARECNT %u\n", val);
>  	/* THS_PREPARE + THS_ZERO > 145ns + 10*UI */
>  	raw_val = tc358768_ns_to_cnt(145 - tc358768_to_ns(3 * ui_nsk), dsibclk_nsk) - 10;
>  	val2 = clamp(raw_val, 0, 127);
> -	dev_dbg(priv->dev, "THS_ZEROCNT %u\n", val2);
> +	dev_dbg(dev, "THS_ZEROCNT %u\n", val2);
>  	val |= val2 << 8;
>  	tc358768_write(priv, TC358768_THS_HEADERCNT, val);
>  
>  	/* TWAKEUP > 1ms in lptxcnt steps */
>  	val = tc358768_ns_to_cnt(1020000, dsibclk_nsk);
>  	val = val / (lptxcnt + 1) - 1;
> -	dev_dbg(priv->dev, "TWAKEUP: %u\n", val);
> +	dev_dbg(dev, "TWAKEUP: %u\n", val);
>  	tc358768_write(priv, TC358768_TWAKEUP, val);
>  
>  	/* TCLK_POSTCNT > 60ns + 52*UI */
>  	val = tc358768_ns_to_cnt(60 + tc358768_to_ns(52 * ui_nsk),
>  				 dsibclk_nsk) - 3;
> -	dev_dbg(priv->dev, "TCLK_POSTCNT: %u\n", val);
> +	dev_dbg(dev, "TCLK_POSTCNT: %u\n", val);
>  	tc358768_write(priv, TC358768_TCLK_POSTCNT, val);
>  
>  	/* max(60ns + 4*UI, 8*UI) < THS_TRAILCNT < 105ns + 12*UI */
>  	raw_val = tc358768_ns_to_cnt(60 + tc358768_to_ns(18 * ui_nsk),
>  				     dsibclk_nsk) - 4;
>  	val = clamp(raw_val, 0, 15);
> -	dev_dbg(priv->dev, "THS_TRAILCNT: %u\n", val);
> +	dev_dbg(dev, "THS_TRAILCNT: %u\n", val);
>  	tc358768_write(priv, TC358768_THS_TRAILCNT, val);
>  
>  	val = BIT(0);
> @@ -805,10 +806,10 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
>  	/* TXTAGOCNT[26:16] RXTASURECNT[10:0] */
>  	val = tc358768_to_ns((lptxcnt + 1) * dsibclk_nsk * 4);
>  	val = tc358768_ns_to_cnt(val, dsibclk_nsk) / 4 - 1;
> -	dev_dbg(priv->dev, "TXTAGOCNT: %u\n", val);
> +	dev_dbg(dev, "TXTAGOCNT: %u\n", val);
>  	val2 = tc358768_ns_to_cnt(tc358768_to_ns((lptxcnt + 1) * dsibclk_nsk),
>  				  dsibclk_nsk) - 2;
> -	dev_dbg(priv->dev, "RXTASURECNT: %u\n", val2);
> +	dev_dbg(dev, "RXTASURECNT: %u\n", val2);
>  	val = val << 16 | val2;
>  	tc358768_write(priv, TC358768_BTACNTRL1, val);
>  
> @@ -902,7 +903,7 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
>  
>  	ret = tc358768_clear_error(priv);
>  	if (ret) {
> -		dev_err(priv->dev, "Bridge pre_enable failed: %d\n", ret);
> +		dev_err(dev, "Bridge pre_enable failed: %d\n", ret);
>  		tc358768_bridge_disable(bridge);
>  		tc358768_bridge_post_disable(bridge);
>  	}
> 

-- 
Péter
