Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0309A76E8A1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235363AbjHCMnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbjHCMnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:43:37 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D833595;
        Thu,  3 Aug 2023 05:43:35 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 373ChNnG036292;
        Thu, 3 Aug 2023 07:43:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691066603;
        bh=aPHWtWf7TJnZlcTe2M3Z9Aoa24TwoWZQarjS+yCL+N0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=ErYdrtPlba8J4gIAFhODhHO/1ns1B63JgUZlKH8tElUp6ecyFQXKJcXEjs69J/FTj
         Rb2uhuz3PGbjzKczMQGNIWaNrxuIPaeMe6ABJmUsX2QcsdVwrpVyEFxPdYy/KOb3ZV
         6CO3ih8+JdT+Ssfsgonj5DSOkTORxd2z7OWdlvOk=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 373ChNZ9085015
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Aug 2023 07:43:23 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Aug 2023 07:43:23 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Aug 2023 07:43:23 -0500
Received: from [10.249.141.75] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 373ChICG088196;
        Thu, 3 Aug 2023 07:43:19 -0500
Message-ID: <165f0792-d71a-5828-49a1-fe9ebe667e71@ti.com>
Date:   Thu, 3 Aug 2023 18:13:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 2/6] arm64: dts: ti: k3-j721s2-som-p0: Add TP6594
 family PMICs
To:     Vaishnav Achath <vaishnav.a@ti.com>,
        Esteban Blanc <eblanc@baylibre.com>,
        "Menon, Nishanth" <nm@ti.com>,
        "Raghavendra, Vignesh" <vigneshr@ti.com>,
        "kristo@kernel.org" <kristo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jneanne@baylibre.com" <jneanne@baylibre.com>,
        "aseketeli@baylibre.com" <aseketeli@baylibre.com>,
        "jpanis@baylibre.com" <jpanis@baylibre.com>, <u-kumar1@ti.com>
References: <20230727130908.10656-1-eblanc@baylibre.com>
 <20230727130908.10656-3-eblanc@baylibre.com>
 <e9f9ebf13ee640daabd54a730e286193@ti.com>
 <44468675-f091-852e-ef83-661ffdd2e469@ti.com>
Content-Language: en-US
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <44468675-f091-852e-ef83-661ffdd2e469@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Vaishnav

On 8/3/2023 4:43 PM, Vaishnav Achath wrote:
>
> On 03/08/23 16:01, Kumar, Udit wrote:
>> Hi Esteban
>>
> Hi Esteban, Udit,
>
>>> [...]
>>> Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
>>> ---
>>> arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi | 199 +++++++++++++++++++
>>> 1 file changed, 199 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
>>> b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
>>> index d57dd43da0ef..5348aafe3277 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
>>> @@ -61,6 +61,15 @@ J721S2_WKUP_IOPAD(0x004, PIN_INPUT, 0) /* (E20)
>>> MCU_OSPI0_LBCLKO */
>>> 	};
>>> };
>>>
>>> +&wkup_pmx1 {
>>> +	pmic_irq_pins_default: pmic-irq-pins-default {
>>> +		pinctrl-single,pins = <
>>> +			/* (C21) MCU_OSPI1_CSn1.WKUP_GPIO0_39 */
>>> +			J721S2_WKUP_IOPAD(0x28, PIN_INPUT, 7)
>>> +		>;
>> I see, this pin is getting shared with OSPI-1 .
>> I think either OSPI or PMIC could be functional at one time ?
>>
> OSPI CS1 is not being used, so the corresponding entry under OSPI1 can be removed.


let me handle this in on going series

https://lore.kernel.org/all/20230802113500.162276-1-u-kumar1@ti.com/

> Thanks and Regards,
> Vaishnav
>
>>> +	};
>>> +};
>>> +
>>>   [...]
