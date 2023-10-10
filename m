Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E237BF303
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442262AbjJJG3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442233AbjJJG3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:29:38 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5EA9F;
        Mon,  9 Oct 2023 23:29:37 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39A0OEOY030835;
        Tue, 10 Oct 2023 08:29:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=nXW3qRlXx4bi+QU4+EuXILrIzXmfut+QZKeJU9II6o0=; b=eV
        Ks8hBCCJE6gA0oirU31QLcG1Pg9JvSZsrDI/ZetyZQw0wrHCWzA1IIlIlAVO4YCL
        ZCUDnJU9bFA0mDszRmKxTZNm84d0wdTN6HJzccj/Yh4jonH0LMV7oeCcphn3ra+E
        y5U9jAZSwuH2LrZN+EVaaS/UKfWucb1X9kWbf9P/d1mr06DLfB9F9DfJUmeop/cw
        7LLjyF5wGR3aNA6XWuyIsNl0667BqUNxHnmgJkVAlpsVS7MkdNp860MpzkfiCauU
        vxKKdvmeOskyvo7OoX5zMFvawnh+vKUjkxhVMSidLzCh0onn12ZHWS8hW3YvrviA
        G2Ropo4st8gW+XAmCdFg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3tkhfe0bu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 08:29:12 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 59736100058;
        Tue, 10 Oct 2023 08:29:11 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 529002128AA;
        Tue, 10 Oct 2023 08:29:11 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 08:29:10 +0200
Message-ID: <f7b1dfe5-5efd-54d8-b651-b1fd5c2ab291@foss.st.com>
Date:   Tue, 10 Oct 2023 08:29:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] watchdog: st_lpc: Use device_get_match_data()
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231009211356.3242037-18-robh@kernel.org>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20231009211356.3242037-18-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_04,2023-10-09_01,2023-05-22_02
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/9/23 23:13, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/watchdog/st_lpc_wdt.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/watchdog/st_lpc_wdt.c b/drivers/watchdog/st_lpc_wdt.c
> index d2aa43c00221..4c5b8d98a4f3 100644
> --- a/drivers/watchdog/st_lpc_wdt.c
> +++ b/drivers/watchdog/st_lpc_wdt.c
> @@ -15,7 +15,6 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/watchdog.h>
> @@ -42,7 +41,7 @@ struct st_wdog {
>  	void __iomem *base;
>  	struct device *dev;
>  	struct regmap *regmap;
> -	struct st_wdog_syscfg *syscfg;
> +	const struct st_wdog_syscfg *syscfg;
>  	struct clk *clk;
>  	unsigned long clkrate;
>  	bool warm_reset;
> @@ -150,7 +149,6 @@ static void st_clk_disable_unprepare(void *data)
>  static int st_wdog_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	const struct of_device_id *match;
>  	struct device_node *np = dev->of_node;
>  	struct st_wdog *st_wdog;
>  	struct regmap *regmap;
> @@ -173,12 +171,7 @@ static int st_wdog_probe(struct platform_device *pdev)
>  	if (!st_wdog)
>  		return -ENOMEM;
>  
> -	match = of_match_device(st_wdog_match, dev);
> -	if (!match) {
> -		dev_err(dev, "Couldn't match device\n");
> -		return -ENODEV;
> -	}
> -	st_wdog->syscfg	= (struct st_wdog_syscfg *)match->data;
> +	st_wdog->syscfg	= (struct st_wdog_syscfg *)device_get_match_data(dev);
>  
>  	base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base))

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
