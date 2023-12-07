Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E332C808966
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441907AbjLGNnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjLGNno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:43:44 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADB2D54;
        Thu,  7 Dec 2023 05:43:50 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B7DhhoH067822;
        Thu, 7 Dec 2023 07:43:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701956623;
        bh=/FQO++Y5swUkctZSmrGpa24HWk4rIJeD9rWaIjxBst8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=XPQhOsExUkD7inCNDDaCJb5As8nrZu+DUP/LgFIJyCEZkJwT8pT20p8AvoJJ7batB
         lcQKZkoOAfPgYhLSXwaa9Kfme+0CGbuXUrFDAcwSyb8AMDqgbsS8aKgXTwsehIkRiv
         f8kqx+t4JWzjWUhOppipQBB0na1+CQ7ULWcxw2do=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B7DhhDs074417
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Dec 2023 07:43:43 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Dec 2023 07:43:43 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Dec 2023 07:43:43 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
        by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B7Dhhmd037794;
        Thu, 7 Dec 2023 07:43:43 -0600
Date:   Thu, 7 Dec 2023 07:43:43 -0600
From:   Nishanth Menon <nm@ti.com>
To:     "Anwar, Md Danish" <a0501179@ti.com>
CC:     MD Danish Anwar <danishanwar@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, <srk@ti.com>,
        <r-gunasekaran@ti.com>
Subject: Re: [PATCH 2/3] arm64: dts: ti: k3-am642-evm: add ICSSG1 Ethernet
 support
Message-ID: <20231207134343.ufiy2owik5kn3y2r@degrease>
References: <20231207081917.340167-1-danishanwar@ti.com>
 <20231207081917.340167-3-danishanwar@ti.com>
 <20231207131818.3n7z64ve6izatlvs@unchanged>
 <f83f21c0-3f5f-4069-abab-2b47e371d3bd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f83f21c0-3f5f-4069-abab-2b47e371d3bd@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18:58-20231207, Anwar, Md Danish wrote:
[...]
> >> +
> >>  	memory@80000000 {
> >>  		bootph-all;
> >>  		device_type = "memory";
> >> @@ -229,6 +234,70 @@ transceiver2: can-phy1 {
> >>  		max-bitrate = <5000000>;
> >>  		standby-gpios = <&exp1 9 GPIO_ACTIVE_HIGH>;
> >>  	};
> >> +
> >> +	icssg1_eth: icssg1-eth {
> >> +		compatible = "ti,am642-icssg-prueth";
> >> +		pinctrl-names = "default";
> >> +		pinctrl-0 = <&icssg1_rgmii1_pins_default>;
> >> +
> >> +		sram = <&oc_sram>;
> >> +		ti,prus = <&pru1_0>, <&rtu1_0>, <&tx_pru1_0>, <&pru1_1>, <&rtu1_1>, <&tx_pru1_1>;
> >> +		firmware-name = "ti-pruss/am65x-sr2-pru0-prueth-fw.elf",
> >> +				"ti-pruss/am65x-sr2-rtu0-prueth-fw.elf",
> >> +				"ti-pruss/am65x-sr2-txpru0-prueth-fw.elf",
> >> +				"ti-pruss/am65x-sr2-pru1-prueth-fw.elf",
> >> +				"ti-pruss/am65x-sr2-rtu1-prueth-fw.elf",
> >> +				"ti-pruss/am65x-sr2-txpru1-prueth-fw.elf";
> > 
> > Umm... am65x??? is that a typo? I'd rather keep it am64x here and drop
> > that sr2 thing. Tomorrow there will be a custom bug on am64 and then we
> > will have to respin this again.
> > 
> 
> No Nishant, this is not a typo. Both AM64x and AM65x use the same ICSSG
> firmwares. We only have am65x-sr2-* firmwares and they are used by both
> AM64x and AM65x and that is why I have kept the firmware-name here in dt
> same as the files that we load on the pru cores.
> 

SoCs are different. The hardware as a result is different as well. In
fact, you do have a different compatible to distinguish the two. Some
day, there will be an erratum that is different and we will be stuck
with abi breakage across distros. So, unless you can explain why this
scenario will never occur, I don't buy the argument this will survive
long term.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
