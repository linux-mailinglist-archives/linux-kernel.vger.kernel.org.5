Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE57760C24
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjGYHly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbjGYHle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:41:34 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97C11B3;
        Tue, 25 Jul 2023 00:41:05 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36P7eaLB078862;
        Tue, 25 Jul 2023 02:40:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690270837;
        bh=qHKTTygeeH82schrrvP3laQUGHdtt+a7Gv1Kpgd9SQs=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=kacMc2QErSx8ugBhVMqDX3BRzKshrgoWADhxjWKmB0juxu+oKEUesCXtJj+49s7V+
         ib5cFgv/8EKjBtGcPo0LLoRWetphr/OR84D8zrQZIBY8oLJXfX8hWwNO2hBpOINF4U
         UDFt1FqaF8JlzwCkI9JCL7HdmlbSFYHwH8x2+yHM=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36P7eaBM005583
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Jul 2023 02:40:36 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Jul 2023 02:40:36 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Jul 2023 02:40:36 -0500
Received: from [172.24.227.217] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36P7eU0l088544;
        Tue, 25 Jul 2023 02:40:31 -0500
Message-ID: <b2016718-b8e4-a1f8-92ed-f0d9e3cb9c17@ti.com>
Date:   Tue, 25 Jul 2023 13:10:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [EXTERNAL] Re: [PATCH v11 03/10] net: ti: icssg-prueth: Add
 Firmware config and classification APIs.
Content-Language: en-US
To:     Simon Horman <simon.horman@corigine.com>,
        MD Danish Anwar <danishanwar@ti.com>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, <nm@ti.com>, <srk@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230724112934.2637802-1-danishanwar@ti.com>
 <20230724112934.2637802-4-danishanwar@ti.com> <ZL94/L1RMlU5TiAb@corigine.com>
From:   Md Danish Anwar <a0501179@ti.com>
Organization: Texas Instruments
In-Reply-To: <ZL94/L1RMlU5TiAb@corigine.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On 25/07/23 12:55 pm, Simon Horman wrote:
> On Mon, Jul 24, 2023 at 04:59:27PM +0530, MD Danish Anwar wrote:
>> Add icssg_config.h / .c and icssg_classifier.c files. These are firmware
>> configuration and classification related files. These will be used by
>> ICSSG ethernet driver.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> Hi Danish,
> 
> some feedback from my side.
> 

Thanks for the feedback.

> ...
> 
>> diff --git a/drivers/net/ethernet/ti/icssg_classifier.c b/drivers/net/ethernet/ti/icssg_classifier.c
> 
> ...
> 
>> +void icssg_class_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac)
> 
> This function appears to be unused.
> Perhaps it would be better placed in a later patch?
> 
> Or perhaps not, if it makes it hard to split up the patches nicely.
> In which case, perhaps the __maybe_unused annotation could be added,
> temporarily.
> 

Due to splitting the patch into 8-9 patches, I had to introduce these helper
APIs earlier. All these APIs are helper APIs, they will be used in patch 6
(Introduce ICSSG Prueth driver).

I had this concern that some APIs which will be used later but introduced
earlier can create some warnings, before splitting the patches.

I had raised this concern in [1] and asked Jakub if it would be OK to introduce
these APIs earlier. Jakub said it would be fine [2], so I went ahead with this
approach.

It will make very hard to break patches if these APIs are introduced and used
in same patch.

> Flagged by clang-16 W=1, and gcc=12 W=1 builds.
> Likewise for other issues flagged below regarding
> function declarations/definitions.
> 
>> +{
>> +	regmap_write(miig_rt, offs[slice].mac0, (u32)(mac[0] | mac[1] << 8 |
>> +		     mac[2] << 16 | mac[3] << 24));
>> +	regmap_write(miig_rt, offs[slice].mac1, (u32)(mac[4] | mac[5] << 8));
>> +}
>> +
>> +/* disable all RX traffic */
>> +void icssg_class_disable(struct regmap *miig_rt, int slice)
> 
> This function is only used in this file.
> Please consider making it static.
> 

This is later used in icssg_prueth.c, that is why this is not static.

> ...
> 
>> +void icssg_class_default(struct regmap *miig_rt, int slice, bool allmulti)
> 
> This function also appears to be unused.
> 

This is later used in icssg_prueth.c

> ...
> 
>> +/* required for SAV check */
>> +void icssg_ft1_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac_addr)
> 
> This function also appears to be unused.
> 

This is later used in icssg_prueth.c

> ...
> 
>> diff --git a/drivers/net/ethernet/ti/icssg_config.c b/drivers/net/ethernet/ti/icssg_config.c
> 
> ...
> 
>> +void icssg_config_ipg(struct prueth_emac *emac)
> 
> This function is also only used in this file.
> 

This is later used in icssg_prueth.c

> ...
> 
>> +static void icssg_init_emac_mode(struct prueth *prueth)
>> +{
>> +	/* When the device is configured as a bridge and it is being brought
>> +	 * back to the emac mode, the host mac address has to be set as 0.
>> +	 */
>> +	u8 mac[ETH_ALEN] = { 0 };
>> +
>> +	if (prueth->emacs_initialized)
>> +		return;
>> +
>> +	regmap_update_bits(prueth->miig_rt, FDB_GEN_CFG1,
>> +			   SMEM_VLAN_OFFSET_MASK, 0);
>> +	regmap_write(prueth->miig_rt, FDB_GEN_CFG2, 0);
>> +	/* Clear host MAC address */
>> +	icssg_class_set_host_mac_addr(prueth->miig_rt, mac);
> 

This is later used in icssg_prueth.c

> icssg_class_set_host_mac_addr() is defined in icssg_classifier.c
> but used here in icssg_config.c.
> 
> Please consider providing a declaration of this function,
> ideally in a .h file.
> 

The declaration of this function is added later(in patch 6) in icssg_prueth.h

> ...
> 
>> +int emac_set_port_state(struct prueth_emac *emac,
>> +			enum icssg_port_state_cmd cmd)
> 
> This function also appears to be unused.
> 
> ...
> 
>> +void icssg_config_set_speed(struct prueth_emac *emac)
> 
> Ditto.
> 

Both these APIs are later used in icssg_prueth.c

> ...

[1] https://lore.kernel.org/all/17cd1e70-73bc-78d5-7e9d-7b133d6f464b@ti.com/
[2] https://lore.kernel.org/all/20230720081741.0c32d5e6@kernel.org/

-- 
Thanks and Regards,
Danish.
