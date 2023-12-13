Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9D180F299
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjLLQbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjLLQbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:31:16 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB287A8;
        Tue, 12 Dec 2023 08:31:21 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BCGVCMZ083588;
        Tue, 12 Dec 2023 10:31:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702398672;
        bh=LEmNYIFrVw7zMUtcFI4YdLysi2p7AFa1gos13Iw9C1w=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=HQGLtTd3efspGdr8rk/38xMLULNRf4Vb5WdMOYBcfRjGdXK+njZAf7RWtI2o458G+
         sF65upSzmMiSU6So6t/Do5NKJZaUZyBwhQNw7k2v5L6DKi/SJRs07muWf4CieEantN
         kOiFHfJip4AH/FiwaJK1CjMyNUtLEcw4VznfA6vQ=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BCGVCt7016107
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Dec 2023 10:31:12 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Dec 2023 10:31:12 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Dec 2023 10:31:12 -0600
Received: from [10.249.141.75] ([10.249.141.75])
        by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BCGV6eq006219;
        Tue, 12 Dec 2023 10:31:07 -0600
Message-ID: <ab20afc0-e42f-4ee1-a6aa-68a2688f22c0@ti.com>
Date:   Tue, 12 Dec 2023 22:01:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/7] Add TPS6594 PMIC support on several boards
To:     Neha Malcom Francis <n-francis@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <a-nandan@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <eblanc@baylibre.com>, <jneanne@baylibre.com>,
        <aseketeli@baylibre.com>, <jpanis@baylibre.com>, <j-luthra@ti.com>,
        <vaishnav.a@ti.com>, <hnagalla@ti.com>, <devarsht@ti.com>
References: <20231208114919.3429562-1-n-francis@ti.com>
Content-Language: en-US
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20231208114919.3429562-1-n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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

Thanks Neha

On 12/8/2023 5:19 PM, Neha Malcom Francis wrote:
> TPS6594 is a Power Management IC which provides regulators and others
> features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
> PFSM (Pre-configurable Finite State Machine). The SoC and the PMIC can
> communicate through the I2C or SPI interfaces.
> TPS6594 is the super-set device while TPS6593 and LP8764 are derivatives.
>
> This series adds device tree nodes for TI TPS6594 PMICs found in the
> following boards:
> - J721EXSOMXEVM:
>    Link: https://www.ti.com/tool/J721EXSOMXEVM
> - J721S2XSOMXEVM:
>    Link: https://www.ti.com/tool/J721S2XSOMXEVM
> - J7200XSOMXEVM:
>    Link: https://www.ti.com/tool/J7200XSOMXEVM
> - J784S4XEVM
>    Link: https://www.ti.com/tool/J784S4XEVM
> - SK-AM69
>    Link: https://www.ti.com/tool/SK-AM69
> - SK-TDA4VM (J721E-SK)
>    Link: https://www.ti.com/tool/SK-TDA4VM
>
> Boot Logs with required config (DONOTMERGE patch) enabled:
> https://gist.github.com/nehamalcom/f47fcd6183360ed8a146c9ba456202c3
> Boot Logs without config enabled:
> https://gist.github.com/nehamalcom/58217b100e614ae55726f314e02b5001

For series

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


> ---
> Changes from v9:
> https://lore.kernel.org/all/20231205093439.2298296-1-n-francis@ti.com/
> - moved from wkup_pmx1 to wkup_pmx2 (Udit)
> - changed boot logs for AM68-SK to the latest one
> - removed Tested-by tag for AM68-SK
> - modified order of properties in line with latest kernel DTS
>    conventions
>
> Changes from v8:
> https://lore.kernel.org/all/20231128055230.342547-4-n-francis@ti.com/
> - added bootph-pre-ram to AVS regulator (Udit)
> - keeping boot logs and Tested-by tags the same (no effect to kernel)
>
> Changes from v7:
> https://lore.kernel.org/all/20231122104513.2335757-1-n-francis@ti.com/
> - (New Patches) Add support for SK boards that have TPS6594xx PMIC
>    present (J721E-SK and AM69-SK) (Nishanth)
> - Add DONOTMERGE defconfig patch to show test logs
>
> Changes from v6:
> https://lore.kernel.org/all/20230810-tps6594-v6-0-2b2e2399e2ef@ti.com/
> - Modify patch series to include only patches not merged (J7)
> - Add boot logs for all affected boards
>
> Changes from v5:
> https://lore.kernel.org/all/20230809-tps6594-v5-0-485fd3d63670@ti.com
> - Range-diff: http://0x0.st/H_fD.diff
> - Reword the patch fixing interrupt ranges for mcu domain gpio intr, and
>    add Fixes: tag
> - Also fix interrupt ranges for main domain gpio intr in the same patch
> - Change pinctrl node names to end in -pins to fix dtbs_check warnings
> - (New Patch) Enable TPS6594 in defconfig
>
> Changes from v4:
> https://lore.kernel.org/all/20230727130908.10656-1-eblanc@baylibre.com/
> - Range-diff: https://0x0.st/H_L7.diff
> - Rebased on top of linux-next
> - Fix min voltage on vdd_usb_3v3 regulator (ldo2) on j721e-som
> - Use 3-hex-digit format for pinctrl values
>
> Changes from v3:
> https://lore.kernel.org/all/20230417154832.216774-1-eblanc@baylibre.com/
> - Rebased on top of v6.5-rc1.
> - Change pinctrl number for irq pin as wkup_pmx0 was split on some boards.
> - Use already present wkup_i2c0 node instead of creating a new one.
>
> Changes from v2:
> https://lore.kernel.org/lkml/20230414112843.1358067-1-eblanc@baylibre.com/
> - Change node name as per Krzysztof review.
> - Add a fix for the interrupt range of wakeup gpio used by TPS6594 pmic
>    on J784S4.
>    The interruptions of the PMIC were not working before that.
> - Remove dependencies on other patch series as that was a mistake, see
>    https://lore.kernel.org/lkml/CRYY2V3HJ0CP.96JQ18PLZB3C@burritosblues/
>
> Changes from v1:
> https://lore.kernel.org/lkml/20230329142948.833800-1-eblanc@baylibre.com/
> - Harmonize regulators names across the different boards.
> - Adjust AVS voltage range.
> - Remove some outdated comments.
> - Add PMIC to J784S4 board.
> - Compatible string modified to match dt-bindings.
> - Add gpio-controller and gpio-cells properties.
>
> Esteban Blanc (2):
>    arm64: dts: ti: k3-j7200-som-p0: Add TP6594 family PMICs
>    arm64: dts: ti: k3-j721s2-som-p0: Add TP6594 family PMICs
>
> Jerome Neanne (2):
>    arm64: dts: ti: k3-j721e-som-p0: Add TP6594 family PMICs
>    arm64: dts: ti: k3-j784s4-evm: Add support for TPS6594 PMIC
>
> Neha Malcom Francis (3):
>    arm64: dts: ti: k3-am69-sk: Add support for TPS6594 PMIC
>    arm64: dts: ti: k3-j721e-sk: Add TPS6594 family PMICs
>    DONOTMERGE: arm64: defconfig: Enable TPS6594 PMIC for J7 devices
>
>   arch/arm64/boot/dts/ti/k3-am69-sk.dts        |  94 +++++++++
>   arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi  | 153 +++++++++++++++
>   arch/arm64/boot/dts/ti/k3-j721e-sk.dts       | 151 +++++++++++++++
>   arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi  | 160 +++++++++++++++
>   arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi | 193 +++++++++++++++++++
>   arch/arm64/boot/dts/ti/k3-j784s4-evm.dts     | 102 ++++++++++
>   arch/arm64/configs/defconfig                 |   2 +-
>   7 files changed, 854 insertions(+), 1 deletion(-)
>
