Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C77777781
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbjHJLuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjHJLuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:50:44 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9146D125;
        Thu, 10 Aug 2023 04:50:43 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37ABoHk9040014;
        Thu, 10 Aug 2023 06:50:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691668217;
        bh=FE7E5AGWhpz4jXEjj/FP6DfavRJUIthZ9J1868D/XLo=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=WUA0ne0xjbd4zm2nlNRoOZz9h4rVcuBu5XCzQ5NGfIKcMRG1HYb49XyweGNmJHZ2H
         9y5zdrbnHETbnAHsoJGROZlY4bXFWKLbAGE0VkqeHPzErHASqYmFC7rszEt/YWoPMx
         jzqZb8B4DfIBAFL7ItV4k9AFuoSrR90z1uSz7cPE=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37ABoHlQ072490
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 06:50:17 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 06:50:17 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 06:50:17 -0500
Received: from [172.24.227.217] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37ABoBqe076317;
        Thu, 10 Aug 2023 06:50:11 -0500
Message-ID: <c7ddb12d-ae18-5fc2-9729-c88ea73b21d7@ti.com>
Date:   Thu, 10 Aug 2023 17:20:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/5] net: ti: icss-iep: Add IEP driver
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, MD Danish Anwar <danishanwar@ti.com>,
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
 <b43ee5ca-2aab-445a-e24b-cbc95f9186ea@ti.com>
From:   Md Danish Anwar <a0501179@ti.com>
Organization: Texas Instruments
In-Reply-To: <b43ee5ca-2aab-445a-e24b-cbc95f9186ea@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 09/08/23 8:30 pm, Andrew Davis wrote:
> On 8/9/23 6:49 AM, MD Danish Anwar wrote:
>> From: Roger Quadros <rogerq@ti.com>
>>
>> Add a driver for Industrial Ethernet Peripheral (IEP) block of PRUSS to
>> support timestamping of ethernet packets and thus support PTP and PPS
>> for PRU ethernet ports.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>   drivers/net/ethernet/ti/Kconfig          |  12 +
>>   drivers/net/ethernet/ti/Makefile         |   1 +
>>   drivers/net/ethernet/ti/icssg/icss_iep.c | 935 +++++++++++++++++++++++
>>   drivers/net/ethernet/ti/icssg/icss_iep.h |  38 +
>>   4 files changed, 986 insertions(+)
>>   create mode 100644 drivers/net/ethernet/ti/icssg/icss_iep.c
>>   create mode 100644 drivers/net/ethernet/ti/icssg/icss_iep.h
>>
>> diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
>> index 63e510b6860f..88b5b1b47779 100644
>> --- a/drivers/net/ethernet/ti/Kconfig
>> +++ b/drivers/net/ethernet/ti/Kconfig
>> @@ -186,6 +186,7 @@ config CPMAC
>>   config TI_ICSSG_PRUETH
>>       tristate "TI Gigabit PRU Ethernet driver"
>>       select PHYLIB
>> +    select TI_ICSS_IEP
> 
> Why not save selecting this until you add its use in the ICSSG_PRUETH driver in
> the next patch.
> 

The next patch is only adding changes to icssg-prueth .c /.h files. This patch
is adding changes to Kconfig and the Makefile. To keep it that way selecting
this is added in this patch. No worries, I will move this to next patch.

> [...]
> 
>> +
>> +static u32 icss_iep_readl(struct icss_iep *iep, int reg)
>> +{
>> +    return readl(iep->base + iep->plat_data->reg_offs[reg]);
>> +}
> 
> Do these one line functions really add anything? Actually why
> not use the regmap you have here.

These one line functions are not really adding anything but they are acting as
a wrapper around readl /writel and providing some sort of encapsulation as
directly calling readl will result in a little complicated code.

/* WIth One line function */
ts_lo = icss_iep_readl(iep, ICSS_IEP_COUNT_REG0);

/* Without one line function */
ts_lo = readl(iep->base, iep->plat_data->reg_offs[ICSS_IEP_COUNT_REG0]);

Previously regmap was used in this driver. But in older commit [1] in
5.10-ti-linux-kernel (Before I picked the driver for upstream) it got changed
to readl / writel stating that regmap_read / write is too slow. IEP is time
sensitive and needs faster read and write, probably because of this they
changed it.

> 
> [...]
> 
>> +static void icss_iep_enable(struct icss_iep *iep)
>> +{
>> +    regmap_update_bits(iep->map, ICSS_IEP_GLOBAL_CFG_REG,
>> +               IEP_GLOBAL_CFG_CNT_ENABLE,
>> +               IEP_GLOBAL_CFG_CNT_ENABLE);
> 
> Have you looked into regmap_fields?
> 

No I hadn't. But now I looked into regmap_fields, seems to be another way to
update the bits, instead of passing mask and value, regmap_filed_read / write
only takes the value. But for that we will need to create a regmap field. If
you want me to switch to regmap_fields instead of regmap_update_bits I can make
the changes. But I am fine with regmap_update_bits().

> [...]
> 
>> +
>> +    if (!!(iep->latch_enable & BIT(index)) == !!on)
>> +        goto exit;
>> +
> 
> There has to be a better way to write this logic..
> 
> [...]
> 
>> +
>> +static const struct of_device_id icss_iep_of_match[];
>> +
> 
> Why the forward declaration?

I will remove this, I don't see any reason for this.

> 
>> +static int icss_iep_probe(struct platform_device *pdev)
>> +{
>> +    struct device *dev = &pdev->dev;
>> +    struct icss_iep *iep;
>> +    struct clk *iep_clk;
>> +
>> +    iep = devm_kzalloc(dev, sizeof(*iep), GFP_KERNEL);
>> +    if (!iep)
>> +        return -ENOMEM;
>> +
>> +    iep->dev = dev;
>> +    iep->base = devm_platform_ioremap_resource(pdev, 0);
>> +    if (IS_ERR(iep->base))
>> +        return -ENODEV;
>> +
>> +    iep_clk = devm_clk_get(dev, NULL);
>> +    if (IS_ERR(iep_clk))
>> +        return PTR_ERR(iep_clk);
>> +
>> +    iep->refclk_freq = clk_get_rate(iep_clk);
>> +
>> +    iep->def_inc = NSEC_PER_SEC / iep->refclk_freq;    /* ns per clock tick */
>> +    if (iep->def_inc > IEP_MAX_DEF_INC) {
>> +        dev_err(dev, "Failed to set def_inc %d.  IEP_clock is too slow to be
>> supported\n",
>> +            iep->def_inc);
>> +        return -EINVAL;
>> +    }
>> +
>> +    iep->plat_data = of_device_get_match_data(dev);
> 
> Directly using of_*() functions is often wrong, try just device_get_match_data().
> 

Sure. I will change to device_get_match_data().

> [...]
> 
>> +static struct platform_driver icss_iep_driver = {
>> +    .driver = {
>> +        .name = "icss-iep",
>> +        .of_match_table = of_match_ptr(icss_iep_of_match),
> 
> This driver cannot work without OF, using of_match_ptr() is not needed.
> 

Sure, I will drop of_match_ptr().

> Andrew


For reading and updating registers, we can have
	1. icss_iep_readl / writel and regmap_update_bits() OR
	2. regmap_read / write and regmap_update_bits() OR
	3. icss_iep_readl / writel and regmap_fields OR
	4. regmap_read / write and regmap_fields
	

Currently we are using 1. Please let me know if you are fine with this and I
can continue using 1. If not, please let me know your recommendation out of this 4.

[1]
https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/?h=linux-5.10.y&id=f4f45bf71cad5be232536d63a0557d13a7eed162

-- 
Thanks and Regards,
Danish.
