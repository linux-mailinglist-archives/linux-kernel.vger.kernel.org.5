Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00F7772D98
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 20:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjHGSSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 14:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjHGSSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 14:18:05 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7505E8F;
        Mon,  7 Aug 2023 11:18:03 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377IHjDo022900;
        Mon, 7 Aug 2023 13:17:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691432265;
        bh=oMMx78YV6VfxvlJN1HcoBm/7y38m0PaGk3Zpp1RJNKw=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=eT1vR3df+b395NewVTI57nLURe6hFxXdZul4LABx+xV31jyvq4LxmWEcgUK+1WYcx
         ivSCOvN3iXAjafBgb2xUcWPkT1qThuB1F3fwhMYH3d2R7jl5vew7phd8ZIuRCpy/aP
         Ni/A9w+hCNd4WnZwKy3AVpbQTmGvfbjv1gB7SS7g=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377IHju3070927
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 13:17:45 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 13:17:45 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 13:17:44 -0500
Received: from [10.250.36.243] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377IHieQ050998;
        Mon, 7 Aug 2023 13:17:44 -0500
Message-ID: <842af185-0b5f-af7d-27a0-c88d78161559@ti.com>
Date:   Mon, 7 Aug 2023 13:17:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/4] arm64: dts: ti: k3-am62x: Enable AUDIO_REFCLKx
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>,
        Francesco Dolcini <francesco@dolcini.it>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jai Luthra <j-luthra@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
References: <20230806085113.15373-1-francesco@dolcini.it>
 <20230806085113.15373-2-francesco@dolcini.it>
 <20230807174306.yktrky7f6w3gqph7@sensually>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230807174306.yktrky7f6w3gqph7@sensually>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/23 12:43 PM, Nishanth Menon wrote:
> On 10:51-20230806, Francesco Dolcini wrote:
>> From: Jai Luthra <j-luthra@ti.com>
>>
>> On AM62-based SoCs the AUDIO_REFCLKx clocks can be used as an input to
>> external peripherals when configured through CTRL_MMR, so add the
>> clock nodes.
>>
>> Signed-off-by: Jai Luthra <j-luthra@ti.com>
>> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
>> ---
>> v2:
>>   - s/clock/clock-controller/ on audio refclk nodes name.
>> ---
>>   arch/arm64/boot/dts/ti/k3-am62-main.dtsi  | 18 ++++++++++++++++++
>>   arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 18 ++++++++++++++++++
>>   2 files changed, 36 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>> index ef90b2bc81eb..5f19ef46d44c 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>> @@ -60,6 +60,24 @@ epwm_tbclk: clock-controller@4130 {
>>   			reg = <0x4130 0x4>;
>>   			#clock-cells = <1>;
>>   		};
>> +
>> +		audio_refclk0: clock-controller@82e0 {
>> +			compatible = "ti,am62-audio-refclk";
>> +			reg = <0x82e0 0x4>;
>> +			clocks = <&k3_clks 157 0>;
>> +			assigned-clocks = <&k3_clks 157 0>;
>> +			assigned-clock-parents = <&k3_clks 157 8>;
>> +			#clock-cells = <0>;
>> +		};
>> +
>> +		audio_refclk1: clock-controller@82e4 {
>> +			compatible = "ti,am62-audio-refclk";
>> +			reg = <0x82e4 0x4>;
>> +			clocks = <&k3_clks 157 10>;
>> +			assigned-clocks = <&k3_clks 157 10>;
>> +			assigned-clock-parents = <&k3_clks 157 18>;
>> +			#clock-cells = <0>;
>> +		};
>>   	};
>>   
>>   	dmss: bus@48000000 {
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
>> index 3198af08fb9f..75ea7202e071 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
>> @@ -60,6 +60,24 @@ epwm_tbclk: clock-controller@4130 {
>>   			reg = <0x4130 0x4>;
>>   			#clock-cells = <1>;
>>   		};
>> +
>> +		audio_refclk0: clock-controller@82e0 {
>> +			compatible = "ti,am62-audio-refclk";
>> +			reg = <0x82e0 0x4>;
>> +			clocks = <&k3_clks 157 0>;
>> +			assigned-clocks = <&k3_clks 157 0>;
>> +			assigned-clock-parents = <&k3_clks 157 8>;
>> +			#clock-cells = <0>;
>> +		};
>> +
>> +		audio_refclk1: clock-controller@82e4 {
>> +			compatible = "ti,am62-audio-refclk";
>> +			reg = <0x82e4 0x4>;
>> +			clocks = <&k3_clks 157 10>;
>> +			assigned-clocks = <&k3_clks 157 10>;
>> +			assigned-clock-parents = <&k3_clks 157 18>;
>> +			#clock-cells = <0>;
>> +		};
>>   	};
>>   
>>   	dmss: bus@48000000 {
>> -- 
>> 2.25.1
>>
> 
> 
> Jeez what a bit of a mess here - looks like I will have to punt this
> series.
> 
> a) main_conf in arch/arm64/boot/dts/ti/k3-am62-main.dtsi is still
>    syscon, simple-mfd -> I had thought we have converted these already, but
>    apparently not.


Right, we are working on it, but have been blocked as the "phy_gmii_sel"
node used to require the parent to be a "syscon" node. This was fixed
by [0] but it is still only in -next. After that we can convert more
of these nodes.

[0] https://lore.kernel.org/lkml/20230713200957.134480-1-afd@ti.com/T/

Andrew

> b) we then have the yaml itself. Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
>     it picks up clock-controller as ti,am654-ehrpwm-tbclk.yaml
>     but the actual binding is Documentation/devicetree/bindings/clock/ti,am62-audio-refclk.yaml
>     which is not enforced.
> 
> Jai: please sort this out before I can look at any of these audio
> enablement patches involving refclk.
> 
> 
> ALSO: please DONOT ignore dtbs_check warnings folks. it does show some
> real issues in either bindings or dts.
> 
