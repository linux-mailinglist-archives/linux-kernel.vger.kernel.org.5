Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A237BF51F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442691AbjJJH7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442686AbjJJH7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:59:35 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34267BA;
        Tue, 10 Oct 2023 00:59:32 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39A0nQgY016238;
        Tue, 10 Oct 2023 09:59:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=selector1; bh=t6FqgqlXllmqDpAuOcl6Z
        MCWgd2QVrsE+XreUWApzA8=; b=8WG6ldG0V+qYvxZh225ReFUd/uM46ZswXZSpm
        0OWAdpoqq1PV/zkX/pS9te9Sd5ryP+EX8SkQtAcCwPSFOzWuQmAf8JIriXW/VDfY
        X/RH8FwK3Zo1EdvJOAhVCl+p051ADyShFwGrIBjkqKJsDlW6/AJ/WiLvhVo/tnQu
        BSjoko3UbmDljHPTjwtl7e3L6yk/KmRxB9cpB7XOawDqSe1H65vaVIjpauBnz8X4
        FWsq2nJlrWf7RwwWdckkGXTbjmr0VTBZoHpIPkTN4v9eGcUNREUMH8VueQBrSYWd
        ef8WFNLN5lO2sKu2Q+aVAuymUo7yDHuTLHfWmJGm+Yp+uqcDA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3tkhf7grvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 09:59:17 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 67756100058;
        Tue, 10 Oct 2023 09:59:16 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 57A842128B1;
        Tue, 10 Oct 2023 09:59:16 +0200 (CEST)
Received: from gnbcxd0016.gnb.st.com (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 09:59:16 +0200
Date:   Tue, 10 Oct 2023 09:59:07 +0200
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Rob Herring <robh@kernel.org>
CC:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>
Subject: Re: [Linux-stm32] [PATCH] media: stm32-dcmi: Drop unnecessary
 of_match_device() call
Message-ID: <20231010075907.GA1642294@gnbcxd0016.gnb.st.com>
Mail-Followup-To: Rob Herring <robh@kernel.org>,
        Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
References: <20231009211356.3242037-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231009211356.3242037-2-robh@kernel.org>
X-Disclaimer: ce message est personnel / this message is private
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_04,2023-10-09_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

thanks for the patch.

Acked-by: Alain Volmat <alain.volmat@foss.st.com>

Regards,
Alain

On Mon, Oct 09, 2023 at 04:13:32PM -0500, Rob Herring wrote:
> If probe is reached, we've already matched the device and in the case of
> DT matching, the struct device_node pointer will be set. Therefore, there
> is no need to call of_match_device() in probe.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/media/platform/st/stm32/stm32-dcmi.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/media/platform/st/stm32/stm32-dcmi.c b/drivers/media/platform/st/stm32/stm32-dcmi.c
> index 8cb4fdcae137..48140fdf40bb 100644
> --- a/drivers/media/platform/st/stm32/stm32-dcmi.c
> +++ b/drivers/media/platform/st/stm32/stm32-dcmi.c
> @@ -20,7 +20,6 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/of_graph.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
> @@ -1890,7 +1889,6 @@ static int dcmi_graph_init(struct stm32_dcmi *dcmi)
>  static int dcmi_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> -	const struct of_device_id *match = NULL;
>  	struct v4l2_fwnode_endpoint ep = { .bus_type = 0 };
>  	struct stm32_dcmi *dcmi;
>  	struct vb2_queue *q;
> @@ -1899,12 +1897,6 @@ static int dcmi_probe(struct platform_device *pdev)
>  	struct clk *mclk;
>  	int ret = 0;
>  
> -	match = of_match_device(of_match_ptr(stm32_dcmi_of_match), &pdev->dev);
> -	if (!match) {
> -		dev_err(&pdev->dev, "Could not find a match in devicetree\n");
> -		return -ENODEV;
> -	}
> -
>  	dcmi = devm_kzalloc(&pdev->dev, sizeof(struct stm32_dcmi), GFP_KERNEL);
>  	if (!dcmi)
>  		return -ENOMEM;
> -- 
> 2.42.0
> 
> _______________________________________________
> Linux-stm32 mailing list
> Linux-stm32@st-md-mailman.stormreply.com
> https://st-md-mailman.stormreply.com/mailman/listinfo/linux-stm32
