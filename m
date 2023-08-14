Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CD677B0B5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 07:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbjHNFOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 01:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbjHNFOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 01:14:21 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F98FE5F;
        Sun, 13 Aug 2023 22:14:19 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37E5E41C078228;
        Mon, 14 Aug 2023 00:14:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691990044;
        bh=zgU1is/ey29ER1sZI03mQdYN+tGRD2RBHOYFCdNCr2I=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=gKRirqPpgGaTQi8/d3ej9TvBfwXg4bbFtPJ+uXj9aT7I8ZhNSlQCoyLvXwGdC1/Os
         5RY/VQI5MUQs0fsrMXD8ywHd0yRImfFJNHuESwAJxRunwsyJ/N1zqlB5+tRQcL9zWg
         lXRytkKKJzt/nBShx9SU0tdvT7lVRIw0vgOc5etc=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37E5E4r4024156
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Aug 2023 00:14:04 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Aug 2023 00:14:03 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Aug 2023 00:14:03 -0500
Received: from [172.24.227.217] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37E5DwQv038047;
        Mon, 14 Aug 2023 00:13:59 -0500
Message-ID: <ce22155c-31b9-3dd1-8336-275fa92c234d@ti.com>
Date:   Mon, 14 Aug 2023 10:43:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] dt-bindings: remoteproc: pru: Add Interrupt property
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
CC:     MD Danish Anwar <danishanwar@ti.com>, Suman Anna <s-anna@ti.com>,
        Conor Dooley <conor+dt@kernel.org>,
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
 <910a4a98-712a-5517-5a5b-ffb962f83463@ti.com>
 <20230808-unwomanly-generic-67d20f0e51cd@spud>
 <cd74e31f-8bc6-445b-9c33-51e53a439cd2@ti.com>
 <20230808-bazooka-uncoated-a3401d94b063@spud>
 <e49fb304-bd5d-5013-815f-5933a2a170c4@ti.com>
 <20230811-ladylike-snore-abba84731921@spud>
From:   Md Danish Anwar <a0501179@ti.com>
Organization: Texas Instruments
In-Reply-To: <20230811-ladylike-snore-abba84731921@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/23 8:51 pm, Conor Dooley wrote:
> On Fri, Aug 11, 2023 at 04:48:28PM +0530, Md Danish Anwar wrote:
> 
>>>> There are no standard defines for these interrupt types. However I can create a
>>>> new .h file defining all the three interrupt cells and their values for both
>>>> PRU and RTU cores if you think that is required. Otherwise we can go with
>>>> hardcoded values.
>>>>
>>>> Please let me know what you think should be done here.
>>>
>>> It'd be good to reference to the documentation for the cells, I don't
>>> think adding a header is necessary here.
>>>
>>
>> How should I reference to the documentation for the cells?
>>
>> Should I just add the details of cells in description of interrupt property here.
>>
>>   interrupts:
>>     maxItems: 1
>>     description:
>>       Interrupt specifiers enable the virtio/rpmsg communication between MPU
>>       and the PRU/RTU cores. The value of the interrupts should be the PRU
>>       System event number [cell 1], PRU channel [cell 2] and PRU host_event
>>       (target) [cell 3].
>>
>> Please let me know if this looks OK to you.
> 
> I was thinking there'd be an binding for the interrupt controller that
> you could mentioned.

There is a binding for interrupt-controller [1] that I can mention. I tried using

- $ref: /schemas/interrupt-controller/ti,pruss-intc.yaml#

But it was throwing dt binding errors so I didn't add the ref.

I will mention this file name in the description of the property like below,

     description:
       Interrupt specifiers enable the virtio/rpmsg communication between MPU
       and the PRU/RTU cores. For the values of the interrupt cells please
       refer to interrupt-controller/ti,pruss-intc.yaml schema.

Please let me know if this looks OK to you.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc.yaml

-- 
Thanks and Regards,
Danish.
