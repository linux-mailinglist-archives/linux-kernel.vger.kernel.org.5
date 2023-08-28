Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD86478A886
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjH1JJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjH1JIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:08:53 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCD1F3;
        Mon, 28 Aug 2023 02:08:49 -0700 (PDT)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37S8Uk4K026282;
        Mon, 28 Aug 2023 11:08:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=fFvavlPIt+A1DOELjHMzSiyMJPiZovKh2ZTXIfqoO28=; b=lj
        aA3YV9fBIilP9cpnYjypzBn0eIq0THLcVIJcOp9aLIDzKDvDUccMYRfidto9eJhc
        nSjwFTlFLlCt8gMsXfoIIwIXxFNnKd0Eyl55d0LXhtUw7IKnUjW4JGWGkch9+584
        sI23A+QGEkgdnz3xzpHL6rF5V2lJwJzcOaDiM2+/R2NC4yWqNzxeYY4hRrO07wqJ
        5RvJiwDPifmJtAOXecFgCysgEun5WHjN8YBHe/mkHZeIWbhtPj116sDDjjd3Bbbc
        X/HMyRnPyi7ypjqkqiW+PGALN4UUMXKiCKs2LIHpCtp+sHjy6xHHGS2+Z3a4R/uA
        xKJ9zDqsRVdmakcWdscQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sqtxymdwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 11:08:38 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CCF5B10005A;
        Mon, 28 Aug 2023 11:08:36 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B208F218622;
        Mon, 28 Aug 2023 11:08:36 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 28 Aug
 2023 11:08:36 +0200
Message-ID: <c54227f2-9bba-c4bb-baf9-0530b4a644bd@foss.st.com>
Date:   Mon, 28 Aug 2023 11:08:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 28/30] usb: ehci-st: Use
 devm_platform_get_and_ioremap_resource()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230726113816.888-1-frank.li@vivo.com>
 <20230726113816.888-28-frank.li@vivo.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20230726113816.888-28-frank.li@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_06,2023-08-25_01,2023-05-22_02
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/23 13:38, Yangtao Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  drivers/usb/host/ehci-st.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-st.c b/drivers/usb/host/ehci-st.c
> index ee0976b815b4..2dbb0d86daaa 100644
> --- a/drivers/usb/host/ehci-st.c
> +++ b/drivers/usb/host/ehci-st.c
> @@ -158,11 +158,6 @@ static int st_ehci_platform_probe(struct platform_device *dev)
>  	irq = platform_get_irq(dev, 0);
>  	if (irq < 0)
>  		return irq;
> -	res_mem = platform_get_resource(dev, IORESOURCE_MEM, 0);
> -	if (!res_mem) {
> -		dev_err(&dev->dev, "no memory resource provided");
> -		return -ENXIO;
> -	}
>  
>  	hcd = usb_create_hcd(&ehci_platform_hc_driver, &dev->dev,
>  			     dev_name(&dev->dev));
> @@ -222,14 +217,13 @@ static int st_ehci_platform_probe(struct platform_device *dev)
>  			goto err_put_clks;
>  	}
>  
> -	hcd->rsrc_start = res_mem->start;
> -	hcd->rsrc_len = resource_size(res_mem);
> -
> -	hcd->regs = devm_ioremap_resource(&dev->dev, res_mem);
> +	hcd->regs = devm_platform_get_and_ioremap_resource(dev, 0, &res_mem);
>  	if (IS_ERR(hcd->regs)) {
>  		err = PTR_ERR(hcd->regs);
>  		goto err_put_clks;
>  	}
> +	hcd->rsrc_start = res_mem->start;
> +	hcd->rsrc_len = resource_size(res_mem);
>  
>  	err = usb_add_hcd(hcd, irq, IRQF_SHARED);
>  	if (err)
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
