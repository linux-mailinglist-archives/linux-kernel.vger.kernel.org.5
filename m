Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D3478358F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 00:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjHUWW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 18:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjHUWW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 18:22:57 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E331B9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:22:16 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52164adea19so4831551a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692656533; x=1693261333;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z8zs5R1yv/FPCc0JPFhm89lCNeRIwrocWVxU6CC7ui0=;
        b=aX1O8VRczlfYN55hMC9NizKEq6XP2KZ1MedjYMOwsNNaZqHHO7zteuJstI18Qzmo8B
         /09YKlXzzxqdgJXfK64tCudVfaMtNf9JpBWv4zc7mGQtpfIMX0TpiPA+X7uAH0NUHMXT
         klFLHCFC7/eXhO4iSd248tHO0yUKqHT9FcLiKw66QLF03G4p3/WblRGEiNNJWABI68q3
         E8/ZQVNPB1JQG3y/S6tifNqYXVLESMjmjzKJ/f1KvqzVhUTq3cbONtINqVw2Edbxu7s8
         YMqgOFIiasfpAxhc6ETL4H3GvMuRNY9ciXmuCvyW/nbSFJ5ViL2RYWMfO2yy91Szrlxy
         9QCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692656533; x=1693261333;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z8zs5R1yv/FPCc0JPFhm89lCNeRIwrocWVxU6CC7ui0=;
        b=H05E3ZVCHBdCvO9/TwAPZH5RX3dCCe/Vz40zS1m3PJFb9vlyIwpXKlp41zROVbvdrQ
         yBFGpoaSfeB4/bs36bImOB6OA67DkXanAS53viR2pH5VlCQ1jbKeR8Ix7j50QvR5rgP0
         zBfcwHj0ezTz84+kALAh625XQjZsPfjDUJJfdSR42xWlfPp66NZi0GMAYW7yPiOs70VM
         bOnAS4Yl7HxDgOIMUmv0DrGQPxeVqEAy3TUxHrMv85of1iz0w/Af9XbWWb/amfPsvLP1
         ITlI/HX68xrN318vXHYci2JNus11+JjJrerhSpTFR+7JoPLwsf/aYCGR9D4N+51THqEV
         ZVVw==
X-Gm-Message-State: AOJu0Ywrb9qqD6DrQiCTYvr1zzcd3ApXKB/ZdqMS4XEUyoUDb1xr9vYr
        FRlgmtnTB+jA8chthpwb+ns=
X-Google-Smtp-Source: AGHT+IF5NxI8c2iIaQO4DJRWJO32K+wmKFB3dnLH0kyVDdKeGGFX6PVfm2bhqonftzV7Wx2jeCnVjg==
X-Received: by 2002:a05:6402:1206:b0:51e:5251:8f45 with SMTP id c6-20020a056402120600b0051e52518f45mr6838098edw.4.1692656532949;
        Mon, 21 Aug 2023 15:22:12 -0700 (PDT)
Received: from ?IPV6:2a02:908:8b3:1840:ab60:7575:6541:6820? ([2a02:908:8b3:1840:ab60:7575:6541:6820])
        by smtp.gmail.com with ESMTPSA id u9-20020aa7d0c9000000b00523a43f9b1dsm6528035edo.22.2023.08.21.15.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 15:22:12 -0700 (PDT)
Message-ID: <e151e29e-7dc7-e237-aeed-4005911d9583@gmail.com>
Date:   Tue, 22 Aug 2023 00:22:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 03/12] drm/bridge: tc358768: Fix bit updates
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
        =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        Francesco Dolcini <francesco@dolcini.it>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Aradhya Bhatia <a-bhatia1@ti.com>
References: <20230816-tc358768-v2-0-242b9d5f703a@ideasonboard.com>
 <20230816-tc358768-v2-3-242b9d5f703a@ideasonboard.com>
From:   Maxim Schwalm <maxim.schwalm@gmail.com>
In-Reply-To: <20230816-tc358768-v2-3-242b9d5f703a@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

On 16.08.23 13:25, Tomi Valkeinen wrote:
> The driver has a few places where it does:
> 
> if (thing_is_enabled_in_config)
> 	update_thing_bit_in_hw()
> 
> This means that if the thing is _not_ enabled, the bit never gets
> cleared. This affects the h/vsyncs and continuous DSI clock bits.
> 
> Fix the driver to always update the bit.
> 
> Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/gpu/drm/bridge/tc358768.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
> index bc97a837955b..b668f77673c3 100644
> --- a/drivers/gpu/drm/bridge/tc358768.c
> +++ b/drivers/gpu/drm/bridge/tc358768.c
> @@ -794,8 +794,8 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
>  		val |= BIT(i + 1);
>  	tc358768_write(priv, TC358768_HSTXVREGEN, val);
>  
> -	if (!(mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS))
> -		tc358768_write(priv, TC358768_TXOPTIONCNTRL, 0x1);
> +	tc358768_write(priv, TC358768_TXOPTIONCNTRL,
> +		       (mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) ? 0 : BIT(0));
>  
>  	/* TXTAGOCNT[26:16] RXTASURECNT[10:0] */
>  	val = tc358768_to_ns((lptxcnt + 1) * dsibclk_nsk * 4);
> @@ -861,11 +861,12 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
>  	tc358768_write(priv, TC358768_DSI_HACT, hact);
>  
>  	/* VSYNC polarity */
> -	if (!(mode->flags & DRM_MODE_FLAG_NVSYNC))
> -		tc358768_update_bits(priv, TC358768_CONFCTL, BIT(5), BIT(5));
> +	tc358768_update_bits(priv, TC358768_CONFCTL, BIT(5),
> +			     (mode->flags & DRM_MODE_FLAG_PVSYNC) ? BIT(5) : 0);
> +
>  	/* HSYNC polarity */
> -	if (mode->flags & DRM_MODE_FLAG_PHSYNC)
> -		tc358768_update_bits(priv, TC358768_PP_MISC, BIT(0), BIT(0));
> +	tc358768_update_bits(priv, TC358768_PP_MISC, BIT(0),
> +			     (mode->flags & DRM_MODE_FLAG_PHSYNC) ? BIT(0) : 0);
>  
>  	/* Start DSI Tx */
>  	tc358768_write(priv, TC358768_DSI_START, 0x1);
> 

shouldn't the last patch of this series be moved before this one?
Currently, this patch will still lead to a temporary regression until
patch #12 is applied.

Best regards,
Maxim


