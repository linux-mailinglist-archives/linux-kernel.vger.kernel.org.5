Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBC3771247
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 23:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjHEVGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 17:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjHEVGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 17:06:50 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19F0272A
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 14:06:48 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe4cdb724cso12606195e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 14:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691269607; x=1691874407;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7bQWyorKrsAyTYwSEr05KzsqtWIhFwBSuW+LToiflyQ=;
        b=urnNl0V9kas1yV3Bnm4XUiLjXd3e7p1tpR/zWTWZApJFL7Rf1VbI3hWvWoY1bjXpSz
         2+LAVdn6ukkicg0yY2qPw7b+e8whqR0SIMeSIiL5WTxuLwq3rNZ8WNEr4wLtcgMWYaR2
         ZADglGlIoVHQsSWa5fpz30yv+rVjNZ0rt2i2DHkGgPgS9vWZOtzd6+qDvYTW/gI2bdRy
         kCpwewow2HPjCpF7noCc2fcg6uX1BGweP7CbTJqUmNxrUsw64AyQcgFOwMZxC2QAaAMz
         r0MJ93EEQ7vDKdpteQK1DLAppiK94NwhqAHUi66px8WxNDLBKOoUnluPSuXWSj7mgi70
         e+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691269607; x=1691874407;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7bQWyorKrsAyTYwSEr05KzsqtWIhFwBSuW+LToiflyQ=;
        b=Y0KwFqK0GLoA+9JrXQWpUgMAGjXjQ7LTt0ADNss2xzKu8bVSX4BZPPoz0qTiOzH9Tu
         2GMNXc3mFIz83wVH9JaJB+QB+DSUwdSFo9f5kB4ayA0IUQvOZQUcQtCu5IxhQHJSrild
         q45ibY7NklI8WhpA0sebODW/4+jL6yFTbo+PAlcGtRJOt7XwGlDrKdxx6HTFdERkn4c3
         XFtRkSQHY5vL7tcQGSC3Jm7vHplrxYKidknWeA4fjSzcTq9ASvJcncY94cKT2DRH0ZAt
         aQIIKmDGUGUmdmlQ+dwoLVm2hsaD0avt1lG9wBrj0B7Fcc1HqEA0tnuaFQg5NxDG2JQ8
         mduA==
X-Gm-Message-State: AOJu0YzM7zR6csvWymXB29z7awQLAuULZCsway/QiGjN+LBwFlUGZvJe
        vyQNMe/IigfngHPvr5CS7VIQkL5OzQG0DgdCdSE=
X-Google-Smtp-Source: AGHT+IGBFr8NySeTwyPsNV646xsK3/GAjBh+mi0q0UZ3HrUugcDHoZRLvIbht/mcU3b6eaKo7B9hrg==
X-Received: by 2002:a7b:cbc7:0:b0:3fb:bc6d:41f1 with SMTP id n7-20020a7bcbc7000000b003fbbc6d41f1mr4242361wmi.17.1691269606259;
        Sat, 05 Aug 2023 14:06:46 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.245])
        by smtp.gmail.com with ESMTPSA id n22-20020a7bc5d6000000b003fe195cecb3sm10258351wmk.38.2023.08.05.14.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Aug 2023 14:06:45 -0700 (PDT)
Message-ID: <000f45c5-d7dd-237e-1e1b-72056acd4af1@linaro.org>
Date:   Sat, 5 Aug 2023 23:06:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v8 04/16] media: cadence: Add support for TI SoCs
Content-Language: en-US
To:     Jai Luthra <j-luthra@ti.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        niklas.soderlund+renesas@ragnatech.se,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, nm@ti.com,
        devarsht@ti.com
References: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
 <20230731-upstream_csi-v8-4-fb7d3661c2c9@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230731-upstream_csi-v8-4-fb7d3661c2c9@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/2023 10:29, Jai Luthra wrote:
> Multiple TI SoCs (J721E, AM62) use this CSI2RX receiver, integrated with
> an external DPHY and a pixel-grabber IP that unwraps the pixel data and
> send it to memory via DMA.
> 
> Add a separate compatible for the TI-specific version of this IP.
> 
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---
> New in v8
> 
>  drivers/media/platform/cadence/cdns-csi2rx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
> index 0d879d71d818..b087583d636f 100644
> --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> @@ -559,6 +559,7 @@ static void csi2rx_remove(struct platform_device *pdev)
>  
>  static const struct of_device_id csi2rx_of_table[] = {
>  	{ .compatible = "starfive,jh7110-csi2rx" },
> +	{ .compatible = "ti,j721e-csi2rx" },

Why do you need it? It's redundant - already compatible with cdns. No
need to add empty match entries.

>  	{ .compatible = "cdns,csi2rx" },
>  	{ },


Best regards,
Krzysztof

