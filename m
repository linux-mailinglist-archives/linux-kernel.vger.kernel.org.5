Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC7577DE28
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243729AbjHPKFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243775AbjHPKFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:05:06 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB27C1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:05:02 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-307d20548adso5620481f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692180301; x=1692785101;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AXexP5J2IB86LOs7JUU2PjEMrJazlbcjbHMuFD834+M=;
        b=i4mEovXgQd4EmL17YmGNfmx7BiPnJ8rYLqIZVgELKnIDaVjme+nSNmkXBgq1r01riU
         D9jbtq5YKdgzJp04nLuzumD2SCASPuHNpMfdgvpST4bKpzUlOEAXFur+pFGWF+hqxYfu
         dMhtF4P7BJngyc1ERtiYgY2Dt+bC7gy48nYIx7wtOAQjsuDZCQdO505WLSoUWAZSE/Ye
         wIwjgJXh2y0sxy7BO3+KAcUnDeFiZMFwg9Q03O7zL8vUSnoBOMhQ5QYE0H78MnJWHE9d
         pgcWzLp3BH5AvxDi555Rn/cPWDq0L2GALv3NqaeiQ0a98rN3QbWRhq3FhZVnu/QDV+/7
         BLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692180301; x=1692785101;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AXexP5J2IB86LOs7JUU2PjEMrJazlbcjbHMuFD834+M=;
        b=MVzVV5jJS21SIhRSGjt1ODkLFlV/D9EY0dBHZFp6kOar6LgPjVNMKDATlIFlsmpGgG
         Kv9TvGujsI/kX1R73BQ6udOeY96X3b1v6YTOsIduyqNO34/QfUOkmSUGkG5l2Iv6veq1
         r5sz9QZAPFdalqwRN8wNkpH0YH82KO6IEhYzQHzdjQU5Ikf5SM7YHg/UZ0ZQ7GFEcTkg
         WbSkiLk4163VuedBEPxY3S0/FWc+OYgx+5Ahq05WasqPjKe8ZVhfTNt5HSn8msoJqglb
         cRBcW1mG+QFvwN3AO/0ijRgaz6LZhMkFZG5f+zLeZrF0PTWSXdPMuepW7jzWjVMjV8Tx
         +eoA==
X-Gm-Message-State: AOJu0YzMWXMVeVIu3PQVYWbVRoDOLX20t6NnlHnmIYebC4Pva1TOBc8x
        Br93hpjSDAq9QYGmwX4z+Zuo8g==
X-Google-Smtp-Source: AGHT+IE7WTr4mwMLvR3/of6jx6jHLQJNhj1JGefVICNU1EcR9Md8dsCZ3SrFuXbKjenuHFR0Jnl06w==
X-Received: by 2002:adf:d0c3:0:b0:319:62ba:5d08 with SMTP id z3-20020adfd0c3000000b0031962ba5d08mr994283wrh.33.1692180301070;
        Wed, 16 Aug 2023 03:05:01 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id d10-20020a056000114a00b00301a351a8d6sm20552461wrx.84.2023.08.16.03.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 03:05:00 -0700 (PDT)
Message-ID: <47417e4b-f230-7182-5cb5-c76b34b635c0@linaro.org>
Date:   Wed, 16 Aug 2023 12:04:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RESEND RESEND] thermal/of: support thermal zones w/o trips
 subnode
Content-Language: en-US
To:     Icenowy Zheng <zhengxingda@iscas.ac.cn>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Icenowy Zheng <uwu@icenowy.me>
References: <20230722122534.2279689-1-zhengxingda@iscas.ac.cn>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230722122534.2279689-1-zhengxingda@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/2023 14:25, Icenowy Zheng wrote:
> From: Icenowy Zheng <uwu@icenowy.me>
> 
> Although the current device tree binding of thermal zones require the
> trips subnode, the binding in kernel v5.15 does not require it, and many
> device trees shipped with the kernel, for example,
> allwinner/sun50i-a64.dtsi and mediatek/mt8183-kukui.dtsi in ARM64, still
> comply to the old binding and contain no trips subnode.
> 
> Allow the code to successfully register thermal zones w/o trips subnode
> for DT binding compatibility now.
> 
> Furtherly, the inconsistency between DTs and bindings should be resolved
> by either adding empty trips subnode or dropping the trips subnode
> requirement.
> 
> Fixes: d0c75fa2c17f ("thermal/of: Initialize trip points separately")
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
> 
> Unfortunately the code gets dropped by mailing lists again and again...
> 
> Sorry for the disturbance.
> 
>   drivers/thermal/thermal_of.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 6fb14e521197..2c76df847e84 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -127,15 +127,17 @@ static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *n
>   
>   	trips = of_get_child_by_name(np, "trips");
>   	if (!trips) {
> -		pr_err("Failed to find 'trips' node\n");
> -		return ERR_PTR(-EINVAL);
> +		pr_debug("Failed to find 'trips' node\n");
> +		*ntrips = 0;

set ntrips at the beginning of the function.

> +		return NULL;

return ERR_PTR(-ENXIO);

>   	}
>   
>   	count = of_get_child_count(trips);
>   	if (!count) {
> -		pr_err("No trip point defined\n");
> -		ret = -EINVAL;
> -		goto out_of_node_put;
> +		pr_debug("No trip point defined\n");
> +		of_node_put(trips);
> +		*ntrips = 0;
> +		return NULL;

Why not keep goto out_of_node_put ?

>   	}
>   
>   	tt = kzalloc(sizeof(*tt) * count, GFP_KERNEL);
> @@ -519,7 +521,10 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *


The function should check the return value of thermal_of_trips_init()

If this one returns -ENXIO, it should pr_warn().

>   	of_ops->bind = thermal_of_bind;
>   	of_ops->unbind = thermal_of_unbind;
>   
> -	mask = GENMASK_ULL((ntrips) - 1, 0);
> +	if (ntrips)
> +		mask = GENMASK_ULL((ntrips) - 1, 0);
> +	else
> +		mask = 0;

	mask = ntrips ? GENMASK_ULL((ntrips) - 1, 0) : 0;

>   	tz = thermal_zone_device_register_with_trips(np->name, trips, ntrips,
>   						     mask, data, of_ops, tzp,

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

