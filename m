Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBBE772888
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjHGPEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjHGPEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:04:05 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EB410DE;
        Mon,  7 Aug 2023 08:04:04 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377F3uHL034016;
        Mon, 7 Aug 2023 10:03:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691420636;
        bh=jBjigxkPANNxDbSmkBTt2+eMWKG3CgZnzkwkM96vAGQ=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=OSofJgoAHRiEkYWGa7uDG4DHvCa11/QjyNwT8LCHHGuD0yOX//0zb+k7XsPW6/pnl
         qatZEDGZC0SGDVLi0e2PjJWmfA0gcSVnJ1RZ6Hv87PTvY43gWgck85GqVfAXUN3VDC
         1Wk3GIAHrjm0J4q9ht+3EnKB6injOu2Ych5PiRLk=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377F3uYi012063
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 10:03:56 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 10:03:55 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 10:03:55 -0500
Received: from [10.250.148.76] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377F3meG057272;
        Mon, 7 Aug 2023 10:03:51 -0500
Message-ID: <5f882fff-4f68-b762-a8f3-a0f228046a52@ti.com>
Date:   Mon, 7 Aug 2023 20:33:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j784s4-evm: Correct Pin mux offset
 for ospi
To:     Vaishnav Achath <vaishnav.a@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <t-konduru@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bhavya Kapoor <b-kapoor@ti.com>
References: <20230802114126.162445-1-u-kumar1@ti.com>
 <0d311099-a93e-4270-e78f-a464b7fcaa34@ti.com>
Content-Language: en-US
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <0d311099-a93e-4270-e78f-a464b7fcaa34@ti.com>
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

Thanks Vaishnav.

Hi Nishanth,

On 8/7/2023 8:09 PM, Vaishnav Achath wrote:
> Hi Udit,
>
> On 02/08/23 17:11, Udit Kumar wrote:
>> [...]
>> Thank you for the patch,
>>
>> For OSPI functionality:
>>
>> Tested-by: Vaishnav Achath <vaishnav.a@ti.com>
>>
>> before: https://gist.github.com/vaishnavachath/c87275e53f6ae38bacc44c65ed09c733
>> (QSPI probe fails due to wrong pinmux)
>> after: https://gist.github.com/vaishnavachath/b5f6147cfae5218815aca94ec0dfd991
>> (both QSPI, OSPI is functional)
>>
>> heads-up :
>> I see the following warnings for ADC:
>>
>> ```
>>   pinctrl-single 4301c068.pinctrl: mux offset out of range: 0x134 (0x120)
>>   pinctrl-single 4301c068.pinctrl: could not add functions for
>> mcu-adc0-default-pins 308x
>> pinctrl-single 4301c068.pinctrl: mux offset out of range: 0x154 (0x120)
>> pinctrl-single 4301c068.pinctrl: could not add functions for
>> mcu-adc1-default-pins 340x
>> ```
>>
>> mcu_adc0_pins_default and mcu_adc1_pins_default entries needs to have the
>> wkup_pmx2 base (0x68) subtracted to get the appropriate offsets, not sure if
>> there is already a patch addressing the same or should be part of this patch.

let me know, if you are ok with other patch to address adc pin mux or I 
should respin with adc changes


>> Thanks and Regards,
>> Vaishnav
>>
>>   		>;
>>   	};
>>   };
>> @@ -437,7 +444,7 @@ &fss {
>>   &ospi0 {
>>   	status = "okay";
>>   	pinctrl-names = "default";
>> -	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
>> +	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>, <&mcu_fss0_ospi0_1_pins_default>;
>>   
>>   	flash@0 {
>>   		compatible = "jedec,spi-nor";
