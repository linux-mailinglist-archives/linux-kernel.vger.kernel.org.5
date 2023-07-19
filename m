Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C06759F16
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjGST4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjGST4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:56:34 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBA392;
        Wed, 19 Jul 2023 12:56:33 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbc12181b6so75084895e9.2;
        Wed, 19 Jul 2023 12:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689796591; x=1692388591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkXfqP5HTc7LAT471rM4RtSLWgyDDA4RKqfhTSA/bHM=;
        b=Ur6fXRxqNVu6iJfQVwhSvCj8F/Ub6ioJGh7LOMqSUduRNJ5g723VsQ3iS5DTqLbDPi
         LM3fTKR8y2LLZkbP/K1+550CBQ6qVN7I/j9R/2LfV47wk0ygWxvRbAD+bJu0uxO0vJCS
         1qTuPTjblcCvUd5+R2JwFuLqpVdGC02ud8M2sPOomwQNJKcUPCceKjlbI/Yi26s8fv8O
         tGFgSvHwXxNIEG136IZMdJYdeeGHq0NxbPfFMJ+cTHnL6YHY1ipyWJuVZhq4JnkMaWfl
         5gdcBXWA8wxg7fW99UtS5X9wAeO3FEIfL6xEaA2OIoFO/z5d4jLZetn6i4xm97sfv1r6
         0jUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689796591; x=1692388591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HkXfqP5HTc7LAT471rM4RtSLWgyDDA4RKqfhTSA/bHM=;
        b=mH4+codFjN+dEuv4m6zMQA4AFBIeENO+63sAouyvMlJwHLHyW2QovcFEmFENaaRexg
         X11+ddhIUT9qMW6zCz4oGeowgePLqDVUICmuu2QVENKTKWTDu+AKGR257fWf4b42iBgX
         0s8AMBCKpmlLXu7/bFsm1hZboajJyQSo5iG1B/b6WhwHBY4v0BMZ0lua43eKVcbpd2mR
         eMpevKJelYYgiHSFWQEL9s56QankdPI263qUaA2X9v7qlR6tjWfom1Q2NIdCU2SXPW6l
         xM+TYMw3qsluyPfR1Of5WvGgO1c+q3j1KJoLr3yQRmdRNU8XIu0+0A7GuaJaCtUbVZVc
         Gdvg==
X-Gm-Message-State: ABy/qLaijR9epKlTjtQUnhSfutbqa0LXWmsfLO6o/3xI8WmTcCBM9qH0
        LJeJimd3o3ZwG/cf8OKKiF4=
X-Google-Smtp-Source: APBJJlFr+x78/f/4ot76lC8mJxJeAa7g9BNSia7Aug5kEv7lgO0VS3TFcD/HAU9e5hLbCT97nsVT4w==
X-Received: by 2002:a05:600c:2494:b0:3fb:b1fd:4183 with SMTP id 20-20020a05600c249400b003fbb1fd4183mr316396wms.12.1689796591016;
        Wed, 19 Jul 2023 12:56:31 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id w13-20020a5d680d000000b00313e2abfb8dsm6093571wru.92.2023.07.19.12.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 12:56:30 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] thermal/drivers/sun8i: Free calibration nvmem after reading it
Date:   Wed, 19 Jul 2023 21:56:27 +0200
Message-ID: <13308789.uLZWGnKmhe@jernej-laptop>
In-Reply-To: <20230719-thermal-sun8i-free-nvmem-v1-1-f553d5afef79@kernel.org>
References: <20230719-thermal-sun8i-free-nvmem-v1-1-f553d5afef79@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 19. julij 2023 ob 02:58:54 CEST je Mark Brown napisal(a):
> The sun8i thermal driver reads calibration data via the nvmem API at
> startup, updating the device configuration and not referencing the data
> again.  Rather than explicitly freeing the nvmem data the driver relies
> on devm_ to release it, even though the data is never referenced again.
> The allocation is still tracked so it's not leaked but this is notable
> when looking at the code and is a little wasteful so let's instead
> explicitly free the nvmem after we're done with it.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/thermal/sun8i_thermal.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/sun8i_thermal.c
> b/drivers/thermal/sun8i_thermal.c index 195f3c5d0b38..af3098717e3c 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -286,7 +286,7 @@ static int sun8i_ths_calibrate(struct ths_device *tmdev)
> size_t callen;
>  	int ret = 0;
> 
> -	calcell = devm_nvmem_cell_get(dev, "calibration");
> +	calcell = nvmem_cell_get(dev, "calibration");
>  	if (IS_ERR(calcell)) {
>  		if (PTR_ERR(calcell) == -EPROBE_DEFER)
>  			return -EPROBE_DEFER;
> @@ -316,6 +316,8 @@ static int sun8i_ths_calibrate(struct ths_device *tmdev)
> 
>  	kfree(caldata);
>  out:
> +	if (!IS_ERR(calcell))
> +		nvmem_cell_put(calcell);
>  	return ret;
>  }
> 
> 
> ---
> base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
> change-id: 20230718-thermal-sun8i-free-nvmem-3e9e21306e3e
> 
> Best regards,




