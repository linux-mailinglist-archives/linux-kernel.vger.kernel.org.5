Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B0A77190F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 06:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjHGEjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 00:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjHGEjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 00:39:32 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D51B10F6;
        Sun,  6 Aug 2023 21:39:30 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3774d59W095336;
        Sun, 6 Aug 2023 23:39:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691383145;
        bh=APCpSccY3IAvSeWWn8YjMyI7Inx0AhMlTsgMSw5GeC8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=F5ukYQvc7oof3VcOmi5WyZkf2tFmsZPpws5cgIUcOB7oEoP9Yssgo8sjFKcQF8P9Q
         Rg45D3LpunD2S5YWcXZ27MsVaDpxy9slVao5AUbt8AOYa0/DvjFvrm9eP/oESCHvSI
         /lw3N7UU4krz2MiGRvxjpH4gkP6XTYd6pMOYCTJ4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3774d5LA106623
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 6 Aug 2023 23:39:05 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 6
 Aug 2023 23:39:04 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 6 Aug 2023 23:39:04 -0500
Received: from [172.24.227.217] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3774cw28066389;
        Sun, 6 Aug 2023 23:38:58 -0500
Message-ID: <296d8c57-67aa-cb0a-8bab-538c52fb41e4@ti.com>
Date:   Mon, 7 Aug 2023 10:08:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [EXTERNAL] Re: [PATCH 1/4] dt-bindings: net: Add ICSS IEP
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
CC:     MD Danish Anwar <danishanwar@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, <nm@ti.com>, <srk@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230803110153.3309577-1-danishanwar@ti.com>
 <20230803110153.3309577-2-danishanwar@ti.com>
 <20230803-guacamole-buddy-d8179f11615e@spud>
 <d3d53a4f-a1f8-09d4-77e8-a881829fac68@ti.com>
 <20230804-uncombed-escalate-d46b38ce37a2@spud>
From:   Md Danish Anwar <a0501179@ti.com>
Organization: Texas Instruments
In-Reply-To: <20230804-uncombed-escalate-d46b38ce37a2@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/23 9:05 pm, Conor Dooley wrote:
> On Fri, Aug 04, 2023 at 11:56:19AM +0530, Md Danish Anwar wrote:
>> Hi Conor,
>>
>> On 03/08/23 8:57 pm, Conor Dooley wrote:
>>> On Thu, Aug 03, 2023 at 04:31:50PM +0530, MD Danish Anwar wrote:
>>>> From: Md Danish Anwar <danishanwar@ti.com>
>>>>
>>>> Add DT binding documentation for ICSS IEP module.
>>>>
>>>> Signed-off-by: Md Danish Anwar <danishanwar@ti.com>
>>>> ---
>>>>  .../devicetree/bindings/net/ti,icss-iep.yaml  | 37 +++++++++++++++++++
>>>>  1 file changed, 37 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/net/ti,icss-iep.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/net/ti,icss-iep.yaml b/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
>>>> new file mode 100644
>>>> index 000000000000..79cd72b330a6
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
>>>> @@ -0,0 +1,37 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/net/ti,icss-iep.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Texas Instruments ICSS Industrial Ethernet Peripheral (IEP) module
>>>> +
>>>> +maintainers:
>>>> +  - Md Danish Anwar <danishanwar@ti.com>
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - ti,am654-icss-iep   # for K3 AM65x, J721E and AM64x SoCs
>>>
>>> No. ti,am654-icss-iep is for am654. You should really have compatibles
>>> specific to the SoC - is there a reason why this has not been done?
>>>
>>
>> Yes, ti,am654-icss-iep is for am654. You are right, the compatibles should be
>> specific to SoC. Currently the upstream support is being added for only AM65x.
>>
>> I will remove J721E and AM64x SoCs from the comment above and these compatibles
>> when their support is enabled in future.
> 
> So the comment was totally wrong? Or does the same code work for all 3
> of these SoC types & you used the same compatible on each of the 3?

Comment was not totally wrong, the same compatible currently works for all
these 3 SoCs as the same code works for them.

But for now as we are upstreaming only for AM65x, I will only keep am65x in the
comment.

> 
> Thanks,
> Conor.
> 
> 
>> Below is the updated compatible property.
>>
>> properties:
>>   compatible:
>>     enum:
>>       - ti,am654-icss-iep   # for K3 AM65x SoCs

-- 
Thanks and Regards,
Danish.
