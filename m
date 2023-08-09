Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE05776328
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjHIPAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjHIPAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:00:42 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F6BEE;
        Wed,  9 Aug 2023 08:00:41 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 379F0Dbs007717;
        Wed, 9 Aug 2023 10:00:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691593213;
        bh=i7bVCI+bG8yEkvK35K3cSP5/2aCwy76gPfSYzYfAe9k=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=DY40GdSO3gGinENEsD+wo4qhSAQ4Yh/Zh7fzsSBrnHd55ucWXGFIWEz3ICZqOsdSR
         9qd15qSCMEroMBYRk3iuN+Iq4B1dYf7xryM2Imtf3LZ5u58KSmUeZoDuyuULQamhmj
         f6SmIlj3Tebj/Y9dPd+umScVxV/AiLKnKhfjC884=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 379F0Dtv029675
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 10:00:13 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 10:00:12 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 10:00:13 -0500
Received: from [10.250.38.120] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 379F0BWH057964;
        Wed, 9 Aug 2023 10:00:11 -0500
Message-ID: <b43ee5ca-2aab-445a-e24b-cbc95f9186ea@ti.com>
Date:   Wed, 9 Aug 2023 10:00:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/5] net: ti: icss-iep: Add IEP driver
Content-Language: en-US
To:     MD Danish Anwar <danishanwar@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     <nm@ti.com>, <srk@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230809114906.21866-1-danishanwar@ti.com>
 <20230809114906.21866-4-danishanwar@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230809114906.21866-4-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/23 6:49 AM, MD Danish Anwar wrote:
> From: Roger Quadros <rogerq@ti.com>
> 
> Add a driver for Industrial Ethernet Peripheral (IEP) block of PRUSS to
> support timestamping of ethernet packets and thus support PTP and PPS
> for PRU ethernet ports.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>   drivers/net/ethernet/ti/Kconfig          |  12 +
>   drivers/net/ethernet/ti/Makefile         |   1 +
>   drivers/net/ethernet/ti/icssg/icss_iep.c | 935 +++++++++++++++++++++++
>   drivers/net/ethernet/ti/icssg/icss_iep.h |  38 +
>   4 files changed, 986 insertions(+)
>   create mode 100644 drivers/net/ethernet/ti/icssg/icss_iep.c
>   create mode 100644 drivers/net/ethernet/ti/icssg/icss_iep.h
> 
> diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
> index 63e510b6860f..88b5b1b47779 100644
> --- a/drivers/net/ethernet/ti/Kconfig
> +++ b/drivers/net/ethernet/ti/Kconfig
> @@ -186,6 +186,7 @@ config CPMAC
>   config TI_ICSSG_PRUETH
>   	tristate "TI Gigabit PRU Ethernet driver"
>   	select PHYLIB
> +	select TI_ICSS_IEP

Why not save selecting this until you add its use in the ICSSG_PRUETH driver in the next patch.

[...]

> +
> +static u32 icss_iep_readl(struct icss_iep *iep, int reg)
> +{
> +	return readl(iep->base + iep->plat_data->reg_offs[reg]);
> +}

Do these one line functions really add anything? Actually why
not use the regmap you have here.

[...]

> +static void icss_iep_enable(struct icss_iep *iep)
> +{
> +	regmap_update_bits(iep->map, ICSS_IEP_GLOBAL_CFG_REG,
> +			   IEP_GLOBAL_CFG_CNT_ENABLE,
> +			   IEP_GLOBAL_CFG_CNT_ENABLE);

Have you looked into regmap_fields?

[...]

> +
> +	if (!!(iep->latch_enable & BIT(index)) == !!on)
> +		goto exit;
> +

There has to be a better way to write this logic..

[...]

> +
> +static const struct of_device_id icss_iep_of_match[];
> +

Why the forward declaration?

> +static int icss_iep_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct icss_iep *iep;
> +	struct clk *iep_clk;
> +
> +	iep = devm_kzalloc(dev, sizeof(*iep), GFP_KERNEL);
> +	if (!iep)
> +		return -ENOMEM;
> +
> +	iep->dev = dev;
> +	iep->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(iep->base))
> +		return -ENODEV;
> +
> +	iep_clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(iep_clk))
> +		return PTR_ERR(iep_clk);
> +
> +	iep->refclk_freq = clk_get_rate(iep_clk);
> +
> +	iep->def_inc = NSEC_PER_SEC / iep->refclk_freq;	/* ns per clock tick */
> +	if (iep->def_inc > IEP_MAX_DEF_INC) {
> +		dev_err(dev, "Failed to set def_inc %d.  IEP_clock is too slow to be supported\n",
> +			iep->def_inc);
> +		return -EINVAL;
> +	}
> +
> +	iep->plat_data = of_device_get_match_data(dev);

Directly using of_*() functions is often wrong, try just device_get_match_data().

[...]

> +static struct platform_driver icss_iep_driver = {
> +	.driver = {
> +		.name = "icss-iep",
> +		.of_match_table = of_match_ptr(icss_iep_of_match),

This driver cannot work without OF, using of_match_ptr() is not needed.

Andrew
