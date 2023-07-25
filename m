Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E871760724
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 06:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjGYETa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 00:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGYETZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 00:19:25 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E770E66;
        Mon, 24 Jul 2023 21:19:22 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36P4JAAB005753;
        Mon, 24 Jul 2023 23:19:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690258750;
        bh=q/wLvzBx97nvR87taLyG6ZA5RS4fLFpXcYB3x1G8eWY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=nnSQCa1qm2Tzl+4k8f/v0x1yQCQNp+mgoUPOtULLss+JF0oOPCHNDA1Ydmh8OlehZ
         WOrYazhLHlXTYBHfF2H7NQRL54QpGj2IO06mQj6ZjxOH0Wxv+K0EfeZv3rn0p3iO3R
         jl9lnpuSbkJN+LXra4QVnP0PJ1IOwEl3dNRjaRBw=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36P4JAKl097201
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Jul 2023 23:19:10 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 24
 Jul 2023 23:19:09 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 24 Jul 2023 23:19:09 -0500
Received: from [10.249.130.150] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36P4J67r124531;
        Mon, 24 Jul 2023 23:19:06 -0500
Message-ID: <1fed3f09-75e4-bb44-71d7-f7319f1b0c3c@ti.com>
Date:   Tue, 25 Jul 2023 09:49:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] arm64: dts: ti: k3-am62a7-sk: Enable dual role support
 for Type-C port
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, <nm@ti.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rogerq@kernel.org>
References: <20230724115133.2226-1-r-gunasekaran@ti.com>
 <c907c3aa-84b8-c667-e8ea-dd7e5bd4a54b@linaro.org>
Content-Language: en-US
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <c907c3aa-84b8-c667-e8ea-dd7e5bd4a54b@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/2023 7:27 PM, Krzysztof Kozlowski wrote:
> On 24/07/2023 13:51, Ravi Gunasekaran wrote:
>> USB0 is interfaced with a Type-C DRP connector and is managed via a
>> USB PD controller. Add support for the Type-C port with dual data
>> and power sink role.
>>
>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 33 +++++++++++++++++++++++++
>>  1 file changed, 33 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
>> index d2cca6182738..b478b794de00 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
>> @@ -226,6 +226,24 @@
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&main_i2c0_pins_default>;
>>  	clock-frequency = <400000>;
>> +
>> +	typec_pd0:tps6598x@3f {

Thanks for reviewing the patch.

> Missing space after:

I will fix this in v2.

>
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Thanks for pointing to the section. I checked it and also few other node names
in the existing DTs.
TPS6598 is a USB Type C and Power Delivery Controller. So does a node name
"type-c-pd-controller" sound fine?

>
> Best regards,
> Krzysztof
>

Regards,
Ravi
