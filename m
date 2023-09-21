Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEADC7AA128
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjIUU6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjIUU5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:57:55 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDF429792;
        Thu, 21 Sep 2023 10:11:45 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38LF9G9c053265;
        Thu, 21 Sep 2023 10:09:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695308956;
        bh=oTNy2wHSxIaJqOc+yS1dO/7QvHpmd/SGTpHunhYERaU=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=uaVms098IiGUq4F+/3TXjTR/+/Vxl/3nUqx716SB/wJrgGXm+9za0VN5dP49Nyebs
         RK+QCOfkJqiMYcwDVPdha06I7sGsNK76c7U5KUVWTcy1/eAgc5czdxe6C4KjbtgVw1
         AIHDOZG9fBAP9975wbQj5TNp/MmAkOivENRP5UsA=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38LF9GFq020971
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Sep 2023 10:09:16 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Sep 2023 10:09:16 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Sep 2023 10:09:16 -0500
Received: from [10.249.139.5] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38LF9CL8067245;
        Thu, 21 Sep 2023 10:09:13 -0500
Message-ID: <1a608e54-36a4-475a-ac21-906d4c9df475@ti.com>
Date:   Thu, 21 Sep 2023 20:39:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] arm64: dts: ti: k3-j721e-mcu-wakeup: Add MCU domain
 ESM instance
Content-Language: en-US
To:     "Kumar, Udit" <u-kumar1@ti.com>, <robh+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>
References: <20230920063029.3081579-1-n-francis@ti.com>
 <191d1260-48f0-2388-ab29-405222302cda@ti.com>
From:   Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <191d1260-48f0-2388-ab29-405222302cda@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Udit

On 21-Sep-23 4:29 PM, Kumar, Udit wrote:
> 
> On 9/20/2023 12:00 PM, Neha Malcom Francis wrote:
>> Currently J721E defines only the main_esm in DTS. Add node for mcu_esm
>> as well.
> Could you please add some more description in commit message , why we 
> need mcu_esm node.

Yes I will add that in, thanks for reviewing!

>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi 
>> b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
>> index 05d6ef127ba7..fa8af20c7818 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
>> @@ -671,4 +671,11 @@ wkup_vtm0: temperature-sensor@42040000 {
>>           power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
>>           #thermal-sensor-cells = <1>;
>>       };
>> +
>> +    mcu_esm: esm@40800000 {
>> +        compatible = "ti,j721e-esm";
>> +        reg = <0x00 0x40800000 0x00 0x1000>;
>> +        ti,esm-pins = <95>;
>> +        bootph-pre-ram;
>> +    };
>>   };
> 
> With that change
> 
> Reviewed-by: Udit Kumar <u-kumar1@ti.com>
> 
> 

Thanking You
Neha Malcom Francis
