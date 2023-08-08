Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B501774456
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbjHHSR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235348AbjHHSQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:16:25 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98D47C72D;
        Tue,  8 Aug 2023 10:23:08 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3789ib6f033387;
        Tue, 8 Aug 2023 04:44:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691487877;
        bh=x4KzLhx5BX2F6004xNI9OIlMNZqfZlvnhOagsXCzdtc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=DyIPmv9YiZPXPAz7XX1maF9evUxrDOSm5qnFSSLtrSTjKjqh8xPPoMJ0K4HFqdh7A
         3dCpiq3h9ojI1G3y+s1+9Ium3bhM/a4eTDjRvu2ArylSDrqhS4QWeqcPP0vTHiw0oB
         WADKKshywpgMkgsrkftsRjWv9GLp8U57ZPeZUobY=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3789ibUJ001331
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 04:44:37 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 04:44:37 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 04:44:37 -0500
Received: from [172.24.227.217] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3789iWPm001940;
        Tue, 8 Aug 2023 04:44:33 -0500
Message-ID: <910a4a98-712a-5517-5a5b-ffb962f83463@ti.com>
Date:   Tue, 8 Aug 2023 15:14:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dt-bindings: remoteproc: pru: Add Interrupt property
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>
CC:     Suman Anna <s-anna@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <srk@ti.com>, <nm@ti.com>
References: <20230807110836.2612730-1-danishanwar@ti.com>
 <20230807-euphemism-trailing-ef4130dc7437@spud>
From:   Md Danish Anwar <a0501179@ti.com>
Organization: Texas Instruments
In-Reply-To: <20230807-euphemism-trailing-ef4130dc7437@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On 07/08/23 8:09 pm, Conor Dooley wrote:
> On Mon, Aug 07, 2023 at 04:38:36PM +0530, MD Danish Anwar wrote:
>> Add interrupts and interrupt-names protperties for PRU and RTU cores.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  .../bindings/remoteproc/ti,pru-rproc.yaml     | 22 +++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
>> index cd55d80137f7..6970316943bb 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
>> +++ b/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
>> @@ -66,6 +66,16 @@ properties:
>>        Should contain the name of the default firmware image
>>        file located on the firmware search path.
>>  
>> +  interrupts:
>> +    maxItems: 1
>> +    description:
>> +      Interrupt specifiers enable the virtio/rpmsg communication between MPU
>> +      and the PRU/RTU cores.
>> +
>> +  interrupt-names:
>> +    items:
>> +      - const: vring
>> +
>>  if:
>>    properties:
>>      compatible:
>> @@ -171,6 +181,9 @@ examples:
>>                <0x22400 0x100>;
>>          reg-names = "iram", "control", "debug";
>>          firmware-name = "am65x-pru0_0-fw";
>> +        interrupt-parent = <&icssg0_intc>;
>> +        interrupts = <16 2 2>;
>> +        interrupt-names = "vring";
>>        };
> 
> These examples would probably be more helpful if they used the
> appropriate defines, no?
> 

PRUSS Interrupt controller doesn't have any appropriate defines. This doesn't
use GIC so defines from arm-gic.h can not be used here. These are specific to
PRUSS INTC.

I think these example are OK. Please let me know if this is OK to you.

>>  
>>        rtu0_0: rtu@4000 {
>> @@ -180,6 +193,9 @@ examples:
>>                <0x23400 0x100>;
>>          reg-names = "iram", "control", "debug";
>>          firmware-name = "am65x-rtu0_0-fw";
>> +        interrupt-parent = <&icssg0_intc>;
>> +        interrupts = <20 4 4>;
>> +        interrupt-names = "vring";
>>        };
>>  
>>        tx_pru0_0: txpru@a000 {
>> @@ -198,6 +214,9 @@ examples:
>>                <0x24400 0x100>;
>>          reg-names = "iram", "control", "debug";
>>          firmware-name = "am65x-pru0_1-fw";
>> +        interrupt-parent = <&icssg0_intc>;
>> +        interrupts = <18 3 3>;
>> +        interrupt-names = "vring";
>>        };
>>  
>>        rtu0_1: rtu@6000 {
>> @@ -207,6 +226,9 @@ examples:
>>                <0x23c00 0x100>;
>>          reg-names = "iram", "control", "debug";
>>          firmware-name = "am65x-rtu0_1-fw";
>> +        interrupt-parent = <&icssg0_intc>;
>> +        interrupts = <22 5 5>;
>> +        interrupt-names = "vring";
>>        };
>>  
>>        tx_pru0_1: txpru@c000 {
>> -- 
>> 2.34.1
>>

-- 
Thanks and Regards,
Danish.
