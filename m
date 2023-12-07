Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2E7808992
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442434AbjLGNyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442098AbjLGNyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:54:10 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EF1133;
        Thu,  7 Dec 2023 05:54:15 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B7Ds45R083785;
        Thu, 7 Dec 2023 07:54:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701957244;
        bh=W5gXtXfZlSK11aQjTNxP7QVpz+cyU+aQUS0zTnnUPpc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=p65KeSRApGwvhso3ak+P27MaIukNysRQ+TWyldNFdhLd3e+2vNmvzLDLrZIW2RTdP
         R4GOOVToI0o/TJIOPn2UT7r89WrjM1tSQ31nOW58+3udob8dC1HYk1rixTWwRYcUJ3
         LeMV409vzXHzyJw4bEE3hDQFy0JyqZc0zaCsnS0c=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B7Ds4L5082652
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Dec 2023 07:54:04 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Dec 2023 07:54:03 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Dec 2023 07:54:03 -0600
Received: from [10.249.135.225] ([10.249.135.225])
        by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B7Ds04n032059;
        Thu, 7 Dec 2023 07:54:00 -0600
Message-ID: <6f2c1c23-bed6-48be-8407-030f2993ec8a@ti.com>
Date:   Thu, 7 Dec 2023 19:23:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: ti: k3-am642-evm: add ICSSG1 Ethernet
 support
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     MD Danish Anwar <danishanwar@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, <srk@ti.com>,
        <r-gunasekaran@ti.com>
References: <20231207081917.340167-1-danishanwar@ti.com>
 <20231207081917.340167-3-danishanwar@ti.com>
 <20231207131818.3n7z64ve6izatlvs@unchanged>
 <f83f21c0-3f5f-4069-abab-2b47e371d3bd@ti.com>
 <20231207134343.ufiy2owik5kn3y2r@degrease>
From:   "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <20231207134343.ufiy2owik5kn3y2r@degrease>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/2023 7:13 PM, Nishanth Menon wrote:
> On 18:58-20231207, Anwar, Md Danish wrote:
> [...]
>>>> +
>>>>  	memory@80000000 {
>>>>  		bootph-all;
>>>>  		device_type = "memory";
>>>> @@ -229,6 +234,70 @@ transceiver2: can-phy1 {
>>>>  		max-bitrate = <5000000>;
>>>>  		standby-gpios = <&exp1 9 GPIO_ACTIVE_HIGH>;
>>>>  	};
>>>> +
>>>> +	icssg1_eth: icssg1-eth {
>>>> +		compatible = "ti,am642-icssg-prueth";
>>>> +		pinctrl-names = "default";
>>>> +		pinctrl-0 = <&icssg1_rgmii1_pins_default>;
>>>> +
>>>> +		sram = <&oc_sram>;
>>>> +		ti,prus = <&pru1_0>, <&rtu1_0>, <&tx_pru1_0>, <&pru1_1>, <&rtu1_1>, <&tx_pru1_1>;
>>>> +		firmware-name = "ti-pruss/am65x-sr2-pru0-prueth-fw.elf",
>>>> +				"ti-pruss/am65x-sr2-rtu0-prueth-fw.elf",
>>>> +				"ti-pruss/am65x-sr2-txpru0-prueth-fw.elf",
>>>> +				"ti-pruss/am65x-sr2-pru1-prueth-fw.elf",
>>>> +				"ti-pruss/am65x-sr2-rtu1-prueth-fw.elf",
>>>> +				"ti-pruss/am65x-sr2-txpru1-prueth-fw.elf";
>>>
>>> Umm... am65x??? is that a typo? I'd rather keep it am64x here and drop
>>> that sr2 thing. Tomorrow there will be a custom bug on am64 and then we
>>> will have to respin this again.
>>>
>>
>> No Nishant, this is not a typo. Both AM64x and AM65x use the same ICSSG
>> firmwares. We only have am65x-sr2-* firmwares and they are used by both
>> AM64x and AM65x and that is why I have kept the firmware-name here in dt
>> same as the files that we load on the pru cores.
>>
> 
> SoCs are different. The hardware as a result is different as well. In
> fact, you do have a different compatible to distinguish the two. Some
> day, there will be an erratum that is different and we will be stuck
> with abi breakage across distros. So, unless you can explain why this
> scenario will never occur, I don't buy the argument this will survive
> long term.
> 

Agreed, this property was introduced for this purpose only. Today am65x
and am64x share the same firmware however in future the firmwares might
change and that is why we have this property. Currently this property is
not used in driver and firmware name is defined in the driver (with the
below structure) which is used for both am64x and am65x. I will rename
the firmware names here to am64x-sr2* in v2. In future when we have
different firmwares for different SoCs, we can stop using the below
structure and use the firmware-name property from dt.

static struct icssg_firmwares icssg_emac_firmwares[] = {
	{
		.pru = "ti-pruss/am65x-sr2-pru0-prueth-fw.elf",
		.rtu = "ti-pruss/am65x-sr2-rtu0-prueth-fw.elf",
		.txpru = "ti-pruss/am65x-sr2-txpru0-prueth-fw.elf",
	},
	{
		.pru = "ti-pruss/am65x-sr2-pru1-prueth-fw.elf",
		.rtu = "ti-pruss/am65x-sr2-rtu1-prueth-fw.elf",
		.txpru = "ti-pruss/am65x-sr2-txpru1-prueth-fw.elf",
	}
};

-- 
Thanks and Regards,
Md Danish Anwar
