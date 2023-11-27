Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF9E7FAEB9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 00:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbjK0Xyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 18:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjK0Xyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 18:54:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30B4182
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 15:54:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32217C433C8;
        Mon, 27 Nov 2023 23:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701129278;
        bh=a4P4BVbYULK6L0Qcy9l2Nr9bwz51FMIOg7cjJS/nXYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bslYKD5tUGWZ5VSkxmL+cLa+gMT+XtEYLO9BWapWvLceaa88PssY9/4CTV+dXRCvd
         6IhiiX/Q1brdnbjkBXsNvfclpuDKcKLrQqWFwFysyOsGdJvgD9nNsWXS88+anMvXVx
         F5MUM6tfr9M206FhKnogoEANUBjVlokkcCVzQJja+aky1jjL+tZB+SeQmcglrLPKsh
         dtTityQ7Ek4LW3WNsgx2UsghXr488n4T2gc7M0bNTNy7++qqucyG+MivIGAAz7ZbnB
         wIt0MurNIjj4i48Vk3piofcL3x+LfTZZD7fDkYMWB6X035SsUTqgEErQZMh6clNjmB
         yF+F9SwCzWz8g==
Date:   Tue, 28 Nov 2023 00:54:34 +0100
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v4 07/24] i2c: designware: Add missing 'c' into PCI IDs
 variable name
Message-ID: <20231127235434.p6c6lxcjbxkerhoj@zenone.zhora.eu>
References: <20231120144641.1660574-1-andriy.shevchenko@linux.intel.com>
 <20231120144641.1660574-8-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120144641.1660574-8-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, Nov 20, 2023 at 04:41:49PM +0200, Andy Shevchenko wrote:
> Add missing 'c' into i2c_designware_pci_ids variable name.
> 
> Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-designware-pcidrv.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
> index e67956845c19..ed2f9e7ba5d3 100644
> --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
> +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
> @@ -355,7 +355,7 @@ static void i2c_dw_pci_remove(struct pci_dev *pdev)
>  	i2c_del_adapter(&dev->adapter);
>  }
>  
> -static const struct pci_device_id i2_designware_pci_ids[] = {
> +static const struct pci_device_id i2c_designware_pci_ids[] = {
>  	/* Medfield */
>  	{ PCI_VDEVICE(INTEL, 0x0817), medfield },
>  	{ PCI_VDEVICE(INTEL, 0x0818), medfield },
> @@ -403,16 +403,16 @@ static const struct pci_device_id i2_designware_pci_ids[] = {
>  	{ PCI_VDEVICE(ATI,  0x7464), navi_amd },
>  	{ 0,}
>  };
> -MODULE_DEVICE_TABLE(pci, i2_designware_pci_ids);
> +MODULE_DEVICE_TABLE(pci, i2c_designware_pci_ids);
>  
>  static struct pci_driver dw_i2c_driver = {
>  	.name		= DRIVER_NAME,
> -	.id_table	= i2_designware_pci_ids,
>  	.probe		= i2c_dw_pci_probe,
>  	.remove		= i2c_dw_pci_remove,
>  	.driver         = {
>  		.pm     = &i2c_dw_pm_ops,
>  	},
> +	.id_table	= i2c_designware_pci_ids,

why this change?

Thanks,
Andi

>  };
>  module_pci_driver(dw_i2c_driver);
>  
> -- 
> 2.43.0.rc1.1.gbec44491f096
> 
