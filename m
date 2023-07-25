Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885E4760CDF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjGYIXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGYIXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:23:36 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A43D10C3;
        Tue, 25 Jul 2023 01:23:33 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36P8NKH4063046;
        Tue, 25 Jul 2023 03:23:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690273400;
        bh=csTp1gSAJevM1r7adANvI2VZ+uKXhEKluf8kdGBt1KE=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=UVIUMEnzqiHpMoB/Y2pN6E95XOAVax/ixxbCGMsjpRSnysWkbGAy3hBifvOtmMRzD
         GG2E/qkOZAm7CPuL71G/5JfXc7RHnbLkLG+/OJRSoE7iLdhEmAw6ZNd+wXIs6lqhug
         mSuraQGyy88SAJHsn8f9NpxEXNTphrqsDyQL47jw=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36P8NKx1114351
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Jul 2023 03:23:20 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Jul 2023 03:23:20 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Jul 2023 03:23:20 -0500
Received: from [10.249.130.150] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36P8NFF5129185;
        Tue, 25 Jul 2023 03:23:16 -0500
Message-ID: <c8220210-033e-018a-460a-1b87232cfdb8@ti.com>
Date:   Tue, 25 Jul 2023 13:53:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] arm64: dts: ti: k3-am62a7-sk: Enable dual role support
 for Type-C port
To:     Roger Quadros <rogerq@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
References: <20230724115133.2226-1-r-gunasekaran@ti.com>
 <c907c3aa-84b8-c667-e8ea-dd7e5bd4a54b@linaro.org>
 <1fed3f09-75e4-bb44-71d7-f7319f1b0c3c@ti.com>
 <dd800ec2-684a-d6fc-2fb3-d146b95a8370@kernel.org>
Content-Language: en-US
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <dd800ec2-684a-d6fc-2fb3-d146b95a8370@kernel.org>
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



On 7/25/2023 1:13 PM, Roger Quadros wrote:
>
> On 25/07/2023 07:19, Ravi Gunasekaran wrote:
>>
>> On 7/24/2023 7:27 PM, Krzysztof Kozlowski wrote:
>>> On 24/07/2023 13:51, Ravi Gunasekaran wrote:
>>>> USB0 is interfaced with a Type-C DRP connector and is managed via a
>>>> USB PD controller. Add support for the Type-C port with dual data
>>>> and power sink role.
>>>>
>>>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>>>> ---
>>>>  arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 33 +++++++++++++++++++++++++
>>>>  1 file changed, 33 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
>>>> index d2cca6182738..b478b794de00 100644
>>>> --- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
>>>> +++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
>>>> @@ -226,6 +226,24 @@
>>>>  	pinctrl-names = "default";
>>>>  	pinctrl-0 = <&main_i2c0_pins_default>;
>>>>  	clock-frequency = <400000>;
>>>> +
>>>> +	typec_pd0:tps6598x@3f {
>> Thanks for reviewing the patch.
>>
>>> Missing space after:
>> I will fix this in v2.
>>
>>> Node names should be generic. See also an explanation and list of
>>> examples (not exhaustive) in DT specification:
>>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>> Thanks for pointing to the section. I checked it and also few other node names
>> in the existing DTs.
>> TPS6598 is a USB Type C and Power Delivery Controller. So does a node name
>> "type-c-pd-controller" sound fine?
> Type-c is irrelevant in node name.
> The name needs to indicate it has something to do with USB, Power Control and Role control.
>
> e.g.
> usb-power-controller
> or
> usb-role-controller
> ?

I will use the node name "usb-power-controller'.

>
>>> Best regards,
>>> Krzysztof
>>>
>> Regards,
>> Ravi

