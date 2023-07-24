Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81D975EE5D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjGXIvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjGXIvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:51:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF39C9;
        Mon, 24 Jul 2023 01:51:37 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 02C356607029;
        Mon, 24 Jul 2023 09:51:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690188695;
        bh=d9AW+MKnPahVLf1G6Ns/+qjCnIfMZz9qqZK1zh/61Yw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GXXb+XLfsbMrOxDaM8ivaBqOyvExwuqpxtZm/hOZSB9s+2LucLV2W65c0MJM+ClcF
         r8GoTVNuYOZ7CtolHG9Cw6MZ+V3RvI+vg3C106XhoaQ8B1kLVTI3waBhEwxiMNNk2G
         BCGhd3lkOfVhbnBXC1UmZRlo/t+SLznzoeGb7r06vPOmAC/NZpXXZ177oFdZuOPqBf
         zdnQzifz5evJefPP2mgbtTbzA6lpu0WSyw1RBekzsD+qBlgh7mmIcuUF7jKJ7xo/mV
         +Tcl/htutTr3np1dM/AOihRHSabhfMN4AUsTg2detC2P9lEU6XtLtj7ZytAuOW9mtc
         UnoxuHfkFRNoA==
Message-ID: <7f20ec52-bcd2-a9e1-369a-878be1e20a67@collabora.com>
Date:   Mon, 24 Jul 2023 10:51:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/7] clk: qcom: hfpll: Allow matching pdata
Content-Language: en-US
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230723140712.9438-1-a39.skl@gmail.com>
 <20230723140712.9438-4-a39.skl@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230723140712.9438-4-a39.skl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/07/23 16:06, Adam Skladowski ha scritto:
> HFPLL driver can be used to drive PLLs also on different SoCs like MSM8976
> On MSM8976 each PLL gets it own different configuration,
> add matching pdata to driver to support multiple configurations.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>   drivers/clk/qcom/hfpll.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/qcom/hfpll.c b/drivers/clk/qcom/hfpll.c
> index f4d78003d189..ec18bc8f0089 100644
> --- a/drivers/clk/qcom/hfpll.c
> +++ b/drivers/clk/qcom/hfpll.c
> @@ -6,6 +6,7 @@
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
>   #include <linux/of.h>
> +#include <linux/of_device.h>
>   #include <linux/clk.h>
>   #include <linux/clk-provider.h>
>   #include <linux/regmap.h>
> @@ -32,7 +33,7 @@ static const struct hfpll_data hdata = {
>   };
>   
>   static const struct of_device_id qcom_hfpll_match_table[] = {
> -	{ .compatible = "qcom,hfpll" },
> +	{ .compatible = "qcom,hfpll", &hdata },

This is supposed to be

{ .compatible = xxx, .data = &hdata }

Regards,
Angelo

>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, qcom_hfpll_match_table);
> @@ -83,7 +84,7 @@ static int qcom_hfpll_probe(struct platform_device *pdev)
>   
>   	init.parent_data = &pdata;
>   
> -	h->d = &hdata;
> +	h->d = of_device_get_match_data(&pdev->dev);
>   	h->clkr.hw.init = &init;
>   	spin_lock_init(&h->lock);
>   

