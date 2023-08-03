Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8955176DFC3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 07:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjHCF2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 01:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbjHCF16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 01:27:58 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5AC3AA6;
        Wed,  2 Aug 2023 22:27:08 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3735QllP022178;
        Thu, 3 Aug 2023 00:26:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691040407;
        bh=YJ9CcnFAMJCNkfcKb8huujcKoibbyLGYUDF/oc0fZ4c=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=x3VJiHi8PWJDYKXLR4BDkkFHzMxT9ypQcMSmRWC3ZHeFn/HlaQTM8QBR1WSkf4IxV
         mZXV+4WX+DY760VUsGGuqH0Y+rk5PuAELENa0nA5iaM7ktdC8UDjJiMpQwFp98w+Ow
         +VCtRVfo/xu/MRcMXiOdIDnPadTrL2OlGKcAftk0=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3735QlLt088489
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Aug 2023 00:26:47 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Aug 2023 00:26:47 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Aug 2023 00:26:46 -0500
Received: from [172.24.227.112] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3735Qg9R015387;
        Thu, 3 Aug 2023 00:26:42 -0500
Message-ID: <63175eeb-b8f7-344b-5019-10dfa83db245@ti.com>
Date:   Thu, 3 Aug 2023 10:56:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 5/5] arm64: dts: ti: k3-am69-sk: Add DP and HDMI
 support
To:     Roger Quadros <rogerq@kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <tomba@kernel.org>
CC:     <s-vadapalli@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <a-bhatia1@ti.com>, <r-ravikumar@ti.com>,
        <sabiya.d@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230801070019.219660-1-j-choudhary@ti.com>
 <20230801070019.219660-6-j-choudhary@ti.com>
 <b7d18f79-9063-2bc0-f17e-3f96abde5827@kernel.org>
 <93bc83da-1093-fb2f-4a5c-af8a3dd29836@kernel.org>
Content-Language: en-US
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <93bc83da-1093-fb2f-4a5c-af8a3dd29836@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Roger,

On 01/08/23 22:28, Roger Quadros wrote:
> +Tomi (fixed email)
> 
> Need to fix this in
> Documentation/devicetree/bindings/display/bridge/ti,tfp410.yaml
> 
> On 01/08/2023 19:48, Roger Quadros wrote:
>>
>>
>> On 01/08/2023 10:00, Jayesh Choudhary wrote:
>>> From: Dasnavis Sabiya <sabiya.d@ti.com>
>>>
>>> AM69 starter kit features an HDMI port and an eDP port.
>>>
>>> Add assigned clocks for DSS, DT node for DisplayPort PHY,
>>> pinmux for HDMI hotplug and power down, mcu_i2c1 and dss_vout
>>> for HDMI.
>>> Also enable Serdes4 settings for DP display.
>>>
>>> Add the endpoint nodes to describe connection from:
>>> DSS => MHDP => DisplayPort connector
>>> DSS => TI TFP410 DPI-to-DVI Bridge => HDMI connector
>>>
>>> Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
>>> [j-choudhary@ti.com: Fix dvi-bridge, dss, mhdp and serdes-refclk]
>>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>>> ---
>>>   arch/arm64/boot/dts/ti/k3-am69-sk.dts | 237 ++++++++++++++++++++++++++
>>>   1 file changed, 237 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
>>> index d282c2c633c1..d9a0794bcf6e 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
>>> +++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
>>> @@ -107,6 +107,83 @@ vdd_sd_dv: regulator-tlv71033 {
>>>   		states = <1800000 0x0>,
>>>   			 <3300000 0x1>;
>>>   	};
>>> +
>>> +	dp0_pwr_3v3: regulator {
>>
>> To be consistent with the rest of the file please
>> use regulator-dp0-pwr

Sure.

>>
>>> +		compatible = "regulator-fixed";
>>> +		regulator-name = "dp0-pwr";
>>> +		regulator-min-microvolt = <3300000>;
>>> +		regulator-max-microvolt = <3300000>;
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&dp_pwr_en_pins_default>;
>>> +		gpio = <&main_gpio0 4 0>;	/* DP0_3V3 _EN */
>>> +		enable-active-high;
>>> +	};
>>> +
>>> +	dp0: connector {
>>
>> connector-dp0

Ok

>>
>>> +		compatible = "dp-connector";
>>> +		label = "DP0";
>>> +		type = "full-size";
>>> +		dp-pwr-supply = <&dp0_pwr_3v3>;
>>> +
>>> +		port {
>>> +			dp0_connector_in: endpoint {
>>> +				remote-endpoint = <&dp0_out>;
>>> +			};
>>> +		};
>>> +	};
>>> +
>>> +	hdmi-connector {
>>
>> connector-hdmi

Ok.

>>
>>> +		compatible = "hdmi-connector";
>>> +		label = "hdmi";
>>> +		type = "a";
>>> +
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&hdmi_hpd_pins_default>;
>>> +
>>> +		ddc-i2c-bus = <&mcu_i2c1>;
>>> +
>>> +		/* HDMI_HPD */
>>> +		hpd-gpios = <&main_gpio0 0 GPIO_ACTIVE_HIGH>;
>>> +
>>> +		port {
>>> +			hdmi_connector_in: endpoint {
>>> +				remote-endpoint = <&tfp410_out>;
>>> +			};
>>> +		};
>>> +	};
>>> +
>>> +	dvi-bridge {
>>
>> Although DT binding doc for ti,tfp410 says encoder
>> a name starting with bridge maybe more appropriate.

Will keep it as bridge-dvi.

Will edit the node names in suggested in 3/5 and 4/5 as well.
I will address the new-line comments too.

Thanks
-Jayesh

>>

[...]

