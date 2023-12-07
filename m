Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359EE808034
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 06:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjLGFbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 00:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLGFbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 00:31:37 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AB01B4;
        Wed,  6 Dec 2023 21:31:42 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B75VV7g021580;
        Wed, 6 Dec 2023 23:31:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701927091;
        bh=3PkybeaP/Mwr9akGCdejbiJE0NMpl+ewBfJjQWJxfEc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=eMAOu7p9KaNBeU7o7dGvBC0OTXqd5C3x7ryIa4B6P3jC7GNGF2rxZQjE/DD/TAOXg
         css0yEiAGx4EQuMLa6sduUafoxOF5XdP6eakYfFQbQBgjt1F8UCeNZ0wG0sW3N+1/s
         jJwrcji+9TvX12V8jSD6AY5yl72NVf5Trmi9t5bA=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B75VV3K063179
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Dec 2023 23:31:31 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Dec 2023 23:31:30 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Dec 2023 23:31:30 -0600
Received: from [172.24.227.36] (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
        by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B75VPtU027686;
        Wed, 6 Dec 2023 23:31:26 -0600
Message-ID: <cc2c3e97-e2c6-487b-91a5-c5f5fbe2c3bc@ti.com>
Date:   Thu, 7 Dec 2023 11:01:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/7] arm64: dts: ti: k3-j721e-sk: Add TPS6594 family
 PMICs
Content-Language: en-US
To:     "Kumar, Udit" <u-kumar1@ti.com>, Nishanth Menon <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <a-nandan@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <eblanc@baylibre.com>, <jneanne@baylibre.com>,
        <aseketeli@baylibre.com>, <jpanis@baylibre.com>, <j-luthra@ti.com>,
        <vaishnav.a@ti.com>, <hnagalla@ti.com>, <devarsht@ti.com>
References: <20231205093439.2298296-1-n-francis@ti.com>
 <20231205093439.2298296-7-n-francis@ti.com>
 <20231205151647.vh6rlhro7qlwoerc@knelt>
 <5e22f8cb-1004-4bcc-9bd0-2c30180ba10e@ti.com>
From:   Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <5e22f8cb-1004-4bcc-9bd0-2c30180ba10e@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth, Udit,

On 07/12/23 10:12, Kumar, Udit wrote:
> 
> On 12/5/2023 8:46 PM, Nishanth Menon wrote:
>> On 15:04-20231205, Neha Malcom Francis wrote:
>>> This patch adds support for TPS6594 PMIC family on wakeup I2C0 bus.
>>> These devices provide regulators (bucks and LDOs), but also GPIOs, a
>>> RTC, a watchdog, an ESM (Error Signal Monitor) which monitors the SoC
>>> error output signal, and a PFSM (Pre-configurable Finite State Machine)
>>> which manages the operational modes of the PMIC.
>>>
>>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>>> ---
>>>   arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 158 +++++++++++++++++++++++++
>>>   1 file changed, 158 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts 
>>> b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
>>> index 42fe8eee9ec8..e600825f7e78 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
>>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
>>> @@ -459,6 +459,13 @@ J721E_IOPAD(0x234, PIN_INPUT, 7) /* (U3) 
>>> EXT_REFCLK1.GPIO1_12 */
>>>   };
>>>   &wkup_pmx0 {
>>> +    pmic_irq_pins_default: pmic-irq-default-pins {
>>> +        bootph-pre-ram;
>>> +        pinctrl-single,pins = <
>>> +            J721E_WKUP_IOPAD(0x0cc, PIN_INPUT, 7) /* (G28) WKUP_GPIO0_7 */
>>> +        >;
>>> +    };
>>> +
>>>       mcu_cpsw_pins_default: mcu-cpsw-default-pins {
>>>           pinctrl-single,pins = <
>>>               J721E_WKUP_IOPAD(0x84, PIN_INPUT, 0) /* (B24) MCU_RGMII1_RD0 */
>>> @@ -560,6 +567,157 @@ eeprom@51 {
>>>           compatible = "atmel,24c512";
>>>           reg = <0x51>;
>>>       };
>>> +
>>> +    tps659413: pmic@48 {
>>> +        bootph-pre-ram;
>> only for the leaf nodes. See
>> https://libera.irclog.whitequark.org/armlinux/2023-10-19
> 
> 
> AFAIK, please correct me, u-boot still needs in all nodes ?
> 

That's what I believe as well, is it better to have only the leaf nodes in 
kernel and have U-Boot DTSI handle the parent bootph properties? If so I'll send 
out v10 making change accordingly.

>>
>>> +        compatible = "ti,tps6594-q1";
>>> +        reg = <0x48>;
>>> +        system-power-controller;
>>> +        pinctrl-names = "default";
>>> +        pinctrl-0 = <&pmic_irq_pins_default>;
>>> +        interrupt-parent = <&wkup_gpio0>;
>>> +        interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
>>> +        ti,primary-pmic;
>>> +
>>> +        gpio-controller;
>>> +        #gpio-cells = <2>;
>>> +
>>> +        buck123-supply = <&vsys_3v3>;
>>> +        buck4-supply = <&vsys_3v3>;
>>> +        buck5-supply = <&vsys_3v3>;
>>> +        ldo1-supply = <&vsys_3v3>;
>>> +        ldo2-supply = <&vsys_3v3>;
>>> +        ldo3-supply = <&vsys_3v3>;
>>> +        ldo4-supply = <&vsys_3v3>;
>>> +
>>> +        regulators {
>>> +            bootph-pre-ram;
>>> +            bucka123: buck123 {
>>> +                bootph-pre-ram;
>>> +                regulator-name = "vdd_cpu_avs";
>>> +                regulator-min-microvolt = <600000>;
>>> +                regulator-max-microvolt = <900000>;
>>> +                regulator-boot-on;
>>> +                regulator-always-on;
>>> +            };
>>> +
>>> +            bucka4: buck4 {
>>> +                regulator-name = "vdd_mcu_0v85";
>>> +                regulator-min-microvolt = <850000>;
>>> +                regulator-max-microvolt = <850000>;
>>> +                regulator-boot-on;
>>> +                regulator-always-on;
>>> +            };
>>> +
>>> +            bucka5: buck5 {
>>> +                regulator-name = "vdd_phyio_1v8";
>>> +                regulator-min-microvolt = <1800000>;
>>> +                regulator-max-microvolt = <1800000>;
>>> +                regulator-boot-on;
>>> +                regulator-always-on;
>>> +            };
>>> +
>>> +            ldoa1: ldo1 {
>>> +                regulator-name = "vdd1_lpddr4_1v8";
>>> +                regulator-min-microvolt = <1800000>;
>>> +                regulator-max-microvolt = <1800000>;
>>> +                regulator-boot-on;
>>> +                regulator-always-on;
>>> +            };
>>> +
>>> +            ldoa2: ldo2 {
>>> +                regulator-name = "vdd_mcuio_1v8";
>>> +                regulator-min-microvolt = <1800000>;
>>> +                regulator-max-microvolt = <1800000>;
>>> +                regulator-boot-on;
>>> +                regulator-always-on;
>>> +            };
>>> +
>>> +            ldoa3: ldo3 {
>>> +                regulator-name = "vdda_dll_0v8";
>>> +                regulator-min-microvolt = <800000>;
>>> +                regulator-max-microvolt = <800000>;
>>> +                regulator-boot-on;
>>> +                regulator-always-on;
>>> +            };
>>> +
>>> +            ldoa4: ldo4 {
>>> +                regulator-name = "vda_mcu_1v8";
>>> +                regulator-min-microvolt = <1800000>;
>>> +                regulator-max-microvolt = <1800000>;
>>> +                regulator-boot-on;
>>> +                regulator-always-on;
>>> +            };
>>> +        };
>>> +    };
>>> +
>>> +    tps659411: pmic@4c {
>>> +        compatible = "ti,tps6594-q1";
>>> +        reg = <0x4c>;
>>> +        system-power-controller;
>>> +        interrupt-parent = <&wkup_gpio0>;
>>> +        interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
>>> +
>>> +        gpio-controller;
>>> +        #gpio-cells = <2>;
>>> +
>>> +        buck1234-supply = <&vsys_3v3>;
>>> +        buck5-supply = <&vsys_3v3>;
>>> +        ldo1-supply = <&vsys_3v3>;
>>> +        ldo2-supply = <&vsys_3v3>;
>>> +        ldo3-supply = <&vsys_3v3>;
>>> +        ldo4-supply = <&vsys_3v3>;
>>> +
>>> +        regulators {
>>> +            buckb1234: buck1234 {
>>> +                regulator-name = "vdd_core_0v8";
>>> +                regulator-min-microvolt = <800000>;
>>> +                regulator-max-microvolt = <800000>;
>>> +                regulator-boot-on;
>>> +                regulator-always-on;
>>> +            };
>>> +
>>> +            buckb5: buck5 {
>>> +                regulator-name = "vdd_ram_0v85";
>>> +                regulator-min-microvolt = <850000>;
>>> +                regulator-max-microvolt = <850000>;
>>> +                regulator-boot-on;
>>> +                regulator-always-on;
>>> +            };
>>> +
>>> +            ldob1: ldo1 {
>>> +                regulator-name = "vdd_sd_dv";
>>> +                regulator-min-microvolt = <1800000>;
>>> +                regulator-max-microvolt = <3300000>;
>>> +                regulator-boot-on;
>>> +                regulator-always-on;
>>> +            };
>>> +
>>> +            ldob2: ldo2 {
>>> +                regulator-name = "vdd_usb_3v3";
>>> +                regulator-min-microvolt = <3300000>;
>>> +                regulator-max-microvolt = <3300000>;
>>> +                regulator-boot-on;
>>> +                regulator-always-on;
>>> +            };
>>> +
>>> +            ldob3: ldo3 {
>>> +                regulator-name = "vdd_io_1v8";
>>> +                regulator-min-microvolt = <1800000>;
>>> +                regulator-max-microvolt = <1800000>;
>>> +                regulator-boot-on;
>>> +                regulator-always-on;
>>> +            };
>>> +
>>> +            ldob4: ldo4 {
>>> +                regulator-name = "vda_pll_1v8";
>>> +                regulator-min-microvolt = <1800000>;
>>> +                regulator-max-microvolt = <1800000>;
>>> +                regulator-boot-on;
>>> +                regulator-always-on;
>>> +            };
>>> +        };
>>> +    };
>>>   };
>>>   &mcu_uart0 {
>>> -- 
>>> 2.34.1
>>>

-- 
Thanking You
Neha Malcom Francis
