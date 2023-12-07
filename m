Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C11808002
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 06:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjLGFKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 00:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjLGFKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 00:10:31 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359B1D44;
        Wed,  6 Dec 2023 21:10:37 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B75AT0c077218;
        Wed, 6 Dec 2023 23:10:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701925829;
        bh=iP+g/I8yA4NofAFT2YlcQSRPdT6ZK1QM6d3BX+2pB1g=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=hIeOLnZJOzpmLgTIy0aziyHVdkURvHx210+Paz+hV/R49zHG6BZLLFU/ZD3xVcp9L
         05j55ACNNZXdHNA+o+EsTkKbwktD/WdxICbLoY99CALD3gYe1P+qeADBOZeZfqyFKF
         mPGJS3blN6bCKxtNZEVJRafV2S2pV00EQuAtxZBI=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B75ATIs024140
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Dec 2023 23:10:29 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Dec 2023 23:10:29 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Dec 2023 23:10:29 -0600
Received: from [172.24.227.36] (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
        by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B75AN16032413;
        Wed, 6 Dec 2023 23:10:24 -0600
Message-ID: <48ede2d2-29b8-4c92-940c-ac28f9d7c10f@ti.com>
Date:   Thu, 7 Dec 2023 10:40:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/7] arm64: dts: ti: k3-am69-sk: Add support for
 TPS6594 PMIC
To:     "Kumar, Udit" <u-kumar1@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <a-nandan@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <eblanc@baylibre.com>, <jneanne@baylibre.com>,
        <aseketeli@baylibre.com>, <jpanis@baylibre.com>, <j-luthra@ti.com>,
        <vaishnav.a@ti.com>, <hnagalla@ti.com>, <devarsht@ti.com>
References: <20231205093439.2298296-1-n-francis@ti.com>
 <20231205093439.2298296-6-n-francis@ti.com>
 <5eecd094-bc14-4257-bbe9-1e20aabd38f7@ti.com>
Content-Language: en-US
From:   Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <5eecd094-bc14-4257-bbe9-1e20aabd38f7@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Udit,

On 07/12/23 10:29, Kumar, Udit wrote:
> 
> On 12/5/2023 3:04 PM, Neha Malcom Francis wrote:
>> This patch adds support for TPS6594 PMIC on wkup I2C0 bus. This device
>> provides regulators (bucks and LDOs), but also GPIOs, a RTC, a watchdog,
>> an ESM (Error Signal Monitor) which monitors the SoC error output
>> signal, and a PFSM (Pre-configurable Finite State Machine) which manages
>> the operational modes of the PMIC.
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> Tested-by: Manorit Chawdhry <m-chawdhry@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-am69-sk.dts | 100 ++++++++++++++++++++++++++
>>   1 file changed, 100 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts 
>> b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
>> index 9868c7049bfb..dec27acb4e96 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
>> @@ -431,6 +431,17 @@ J784S4_IOPAD(0x000, PIN_INPUT, 7) /* (AN35) 
>> EXTINTN.GPIO0_0 */
>>       };
>>   };
>> +&wkup_pmx1 {
>> +    status = "okay";
>> +
>> +    pmic_irq_pins_default: pmic-irq-default-pins {
>> +        pinctrl-single,pins = <
>> +            /* (AA37) MCU_ADC1_AIN4.WKUP_GPIO0_83 */
>> +            J784S4_WKUP_IOPAD(0x12c, PIN_INPUT, 7)
>> +        >;
>> +    };
>> +};
> 
> Could you re check this pin mux
> 
> wkup_pmx1 is defined as reg = <0x00 0x4301c038 0x00 0x02c>;
> 
> LTM, this is above wrt given size
> 

You're right it must be in wkup_pmx2. Thanks for catching this!

> 
>> +
>>   &wkup_pmx2 {
>>       bootph-all;
>>       wkup_uart0_pins_default: wkup-uart0-default-pins {
>> @@ -631,6 +642,95 @@ eeprom@51 {
>>           compatible = "atmel,24c512";
>>           reg = <0x51>;
>>       };
>> +
>> +    tps659413: pmic@48 {
>> +        compatible = "ti,tps6594-q1";
>> +        reg = <0x48>;
>> +        system-power-controller;
>> +        pinctrl-names = "default";
>> +        pinctrl-0 = <&pmic_irq_pins_default>;
>> +        interrupt-parent = <&wkup_gpio0>;
>> +        interrupts = <39 IRQ_TYPE_EDGE_FALLING>;
>> +        ti,primary-pmic;
>> +
>> +        gpio-controller;
>> +        #gpio-cells = <2>;
>> +
>> +        buck12-supply = <&vsys_3v3>;
>> +        buck3-supply = <&vsys_3v3>;
>> +        buck4-supply = <&vsys_3v3>;
>> +        buck5-supply = <&vsys_3v3>;
>> +        ldo1-supply = <&vsys_3v3>;
>> +        ldo2-supply = <&vsys_3v3>;
>> +        ldo3-supply = <&vsys_3v3>;
>> +        ldo4-supply = <&vsys_3v3>;
>> +
>> +        regulators {
>> +            bucka12: buck12 {
>> +                regulator-name = "vdd_ddr_1v1";
>> +                regulator-min-microvolt = <1100000>;
>> +                regulator-max-microvolt = <1100000>;
>> +                regulator-boot-on;
>> +                regulator-always-on;
>> +            };
>> +
>> +            bucka3: buck3 {
>> +                regulator-name = "vdd_ram_0v85";
>> +                regulator-min-microvolt = <850000>;
>> +                regulator-max-microvolt = <850000>;
>> +                regulator-boot-on;
>> +                regulator-always-on;
>> +            };
>> +
>> +            bucka4: buck4 {
>> +                regulator-name = "vdd_io_1v8";
>> +                regulator-min-microvolt = <1800000>;
>> +                regulator-max-microvolt = <1800000>;
>> +                regulator-boot-on;
>> +                regulator-always-on;
>> +            };
>> +
>> +            bucka5: buck5 {
>> +                regulator-name = "vdd_mcu_0v85";
>> +                regulator-min-microvolt = <850000>;
>> +                regulator-max-microvolt = <850000>;
>> +                regulator-boot-on;
>> +                regulator-always-on;
>> +            };
>> +
>> +            ldoa1: ldo1 {
>> +                regulator-name = "vdd_mcuio_1v8";
>> +                regulator-min-microvolt = <1800000>;
>> +                regulator-max-microvolt = <1800000>;
>> +                regulator-boot-on;
>> +                regulator-always-on;
>> +            };
>> +
>> +            ldoa2: ldo2 {
>> +                regulator-name = "vdd_mcuio_3v3";
>> +                regulator-min-microvolt = <3300000>;
>> +                regulator-max-microvolt = <3300000>;
>> +                regulator-boot-on;
>> +                regulator-always-on;
>> +            };
>> +
>> +            ldoa3: ldo3 {
>> +                regulator-name = "vds_dll_0v8";
>> +                regulator-min-microvolt = <800000>;
>> +                regulator-max-microvolt = <800000>;
>> +                regulator-boot-on;
>> +                regulator-always-on;
>> +            };
>> +
>> +            ldoa4: ldo4 {
>> +                regulator-name = "vda_mcu_1v8";
>> +                regulator-min-microvolt = <1800000>;
>> +                regulator-max-microvolt = <1800000>;
>> +                regulator-boot-on;
>> +                regulator-always-on;
>> +            };
>> +        };
>> +    };
>>   };
>>   &wkup_gpio0 {

-- 
Thanking You
Neha Malcom Francis
