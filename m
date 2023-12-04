Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007BB802AB4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 05:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbjLDEJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 23:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjLDEJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 23:09:48 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB04CD5;
        Sun,  3 Dec 2023 20:09:54 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B449hS2101147;
        Sun, 3 Dec 2023 22:09:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701662983;
        bh=sFJlW8fQVjtSfz4/mO3eSp9K2vfl+J4Hwc+oiMu7Ebk=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=DqMRqWSXv3I0d3KUQQu8CzgntoxtPCKpP7/lPhiSfGcO9LRd7CpO65+JrLEtr0Ro/
         pWu1ZDfZFHpTDezTdKcMuGh2rWrjMj5Ad1NLLW2zZ07wCxsrSKg2ZejeZiMwRbnRXp
         UjiWoSF2+d5AcmzlnAfRLDAJ5jeXPfl8rrf6GSVw=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B449hae116989
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 3 Dec 2023 22:09:43 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 3
 Dec 2023 22:09:42 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 3 Dec 2023 22:09:42 -0600
Received: from [172.24.20.156] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B449bjH040369;
        Sun, 3 Dec 2023 22:09:38 -0600
Message-ID: <2cbb60f0-3dfc-48f2-9b61-41adf14648c7@ti.com>
Date:   Mon, 4 Dec 2023 09:39:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/7] Add TPS6594 PMIC support on several boards
To:     Neha Malcom Francis <n-francis@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <a-nandan@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <eblanc@baylibre.com>, <jneanne@baylibre.com>,
        <aseketeli@baylibre.com>, <jpanis@baylibre.com>, <j-luthra@ti.com>,
        <vaishnav.a@ti.com>, <hnagalla@ti.com>, <devarsht@ti.com>
References: <20231128055230.342547-1-n-francis@ti.com>
Content-Language: en-US
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20231128055230.342547-1-n-francis@ti.com>
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


On 11/28/2023 11:22 AM, Neha Malcom Francis wrote:
> TPS6594 is a Power Management IC which provides regulators and others
> features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
> PFSM (Pre-configurable Finite State Machine). The SoC and the PMIC can
> communicate through the I2C or SPI interfaces.
> TPS6594 is the super-set device while TPS6593 and LP8764 are derivatives.

Please consider adding bootph property in avs regulator node.

Thanks

Udit


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
>
> ---
> Changes from v7:
> https://lore.kernel.org/all/20231122104513.2335757-1-n-francis@ti.com/
> - (New Patches) Add support for SK boards that have TPS6594xx PMIC
>    present (J721E-SK and AM69-SK)
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
>   arch/arm64/boot/dts/ti/k3-am69-sk.dts        | 100 ++++++++++
>   arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi  | 157 +++++++++++++++
>   arch/arm64/boot/dts/ti/k3-j721e-sk.dts       | 154 ++++++++++++++
>   arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi  | 163 +++++++++++++++
>   arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi | 199 +++++++++++++++++++
>   arch/arm64/boot/dts/ti/k3-j784s4-evm.dts     | 104 ++++++++++
>   arch/arm64/configs/defconfig                 |   2 +-
>   7 files changed, 878 insertions(+), 1 deletion(-)
>
