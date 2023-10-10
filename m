Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E757BF2FF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442254AbjJJG3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442233AbjJJG3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:29:16 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95A791;
        Mon,  9 Oct 2023 23:29:14 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39A06bmO016239;
        Tue, 10 Oct 2023 08:28:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=ygQRlf3Hn9wsw07l8Czu/bcaaMX5S5BP/kxw/s8CccE=; b=QN
        F6Y69xofXZpvB6tOhxcu/nE9KGtYsGNEfkm7/XmIWRbb3yXQ/72bbYx9RIcG95gp
        ecifLHDfsSd43j44zUkAscjk3HiOzCh48Mlr1CFNL/eEsTFcdPNtoJ4iWfDLW91K
        BLUNNl0GoHHoAhzvjgX1A03T8PyysGWnhGw19my9OEFL/8YvMNZl6AhohsJH/2G3
        QnRlmKPYeiA4dJYI2WO24KA+t+31VW+hSgML4Q9MnvXd0CZf3V/XwThsf1HiwvzR
        bw3rxGofdg2ezMVBDaglRGD9Jj5O5X3iI4UsaCgPyNLmyqStxxmwqkWg8rrJfYk8
        c0V6CyggZgRaSwJWXPjA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3tkhf7gbq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 08:28:56 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 85CB310005E;
        Tue, 10 Oct 2023 08:28:55 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3AA2E212319;
        Tue, 10 Oct 2023 08:28:55 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 08:28:54 +0200
Message-ID: <b6f79025-2257-f739-7e12-4e18cb4c2048@foss.st.com>
Date:   Tue, 10 Oct 2023 08:28:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] remoteproc: st: Use device_get_match_data()
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231009211356.3242037-10-robh@kernel.org>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20231009211356.3242037-10-robh@kernel.org>
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
>  drivers/remoteproc/st_remoteproc.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/remoteproc/st_remoteproc.c b/drivers/remoteproc/st_remoteproc.c
> index e3ce01d98b4c..b0638f984842 100644
> --- a/drivers/remoteproc/st_remoteproc.c
> +++ b/drivers/remoteproc/st_remoteproc.c
> @@ -16,10 +16,9 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
>  #include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/remoteproc.h>
>  #include <linux/reset.h>
> @@ -341,7 +340,6 @@ static int st_rproc_parse_dt(struct platform_device *pdev)
>  static int st_rproc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	const struct of_device_id *match;
>  	struct st_rproc *ddata;
>  	struct device_node *np = dev->of_node;
>  	struct rproc *rproc;
> @@ -349,19 +347,15 @@ static int st_rproc_probe(struct platform_device *pdev)
>  	int enabled;
>  	int ret, i;
>  
> -	match = of_match_device(st_rproc_match, dev);
> -	if (!match || !match->data) {
> -		dev_err(dev, "No device match found\n");
> -		return -ENODEV;
> -	}
> -
>  	rproc = rproc_alloc(dev, np->name, &st_rproc_ops, NULL, sizeof(*ddata));
>  	if (!rproc)
>  		return -ENOMEM;
>  
>  	rproc->has_iommu = false;
>  	ddata = rproc->priv;
> -	ddata->config = (struct st_rproc_config *)match->data;
> +	ddata->config = (struct st_rproc_config *)device_get_match_data(dev);
> +	if (!ddata->config)
> +		goto free_rproc;
>  
>  	platform_set_drvdata(pdev, rproc);
>  


Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
