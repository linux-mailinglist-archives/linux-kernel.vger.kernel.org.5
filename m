Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A7F7A1A8F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbjIOJ3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbjIOJ3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:29:19 -0400
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24C326B8;
        Fri, 15 Sep 2023 02:28:44 -0700 (PDT)
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38F7ElsG002919;
        Fri, 15 Sep 2023 11:28:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=1Of1fldvAc+SLebPZyCDhNTzbbsU2y5odJdWE5qVCiI=; b=Hd
        igeR1KLEPtrblw5zVOznhSk5Z5Ik6TJeBslqk+yXH6I94o9HKk3wLwtx4hCvmN3e
        OjjIz1M/dxfG7kuiq+78CqUM+5wA2HLpIgbbV27J7okGOUcTUBXzjp3/YOtCymF/
        r3YH4Nxi/d0p+eqODAPAnR9ofyKn6Yto+wgh1dahea8i6pdyfc3u15IENXnMNTri
        SU3snXuOCA8wVsI57kBnXC5hGFdsXNYgOGPudLW4fkTIdxUO+UiSBvs5KOY+1gjg
        DFZxQzOFkU/JAuDvT+UNmWSSd4iyURz2hNzWvjV0UJj7AzPhYZcEooJfb0VojLEh
        3Y+wRvbO3tvSq3xdE+/g==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t434d3xsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 11:28:15 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C4149100040;
        Fri, 15 Sep 2023 11:28:13 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BA41521ADDB;
        Fri, 15 Sep 2023 11:28:13 +0200 (CEST)
Received: from [10.201.20.32] (10.201.20.32) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 11:28:13 +0200
Message-ID: <4819d89b-c2a4-0c75-27e1-d8122827ceca@foss.st.com>
Date:   Fri, 15 Sep 2023 11:28:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 07/10] dt-bindings: rng: add st,rng-lock-conf
To:     Rob Herring <robh@kernel.org>
CC:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lionel Debieve <lionel.debieve@foss.st.com>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230908165120.730867-1-gatien.chevallier@foss.st.com>
 <20230908165120.730867-8-gatien.chevallier@foss.st.com>
 <20230911150958.GA1255978-robh@kernel.org>
Content-Language: en-US
From:   Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <20230911150958.GA1255978-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.32]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_06,2023-09-14_01,2023-05-22_02
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

On 9/11/23 17:09, Rob Herring wrote:
> On Fri, Sep 08, 2023 at 06:51:17PM +0200, Gatien Chevallier wrote:
>> If st,rng-lock-conf is set, the RNG configuration in RNG_CR, RNG_HTCR
>> and RNG_NSCR will be locked. It is supported starting from the RNG
>> version present in the STM32MP13
> 
> This should be squashed into the prior binding patch.
> 
>>
>> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
>> ---
>>   .../devicetree/bindings/rng/st,stm32-rng.yaml      | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/rng/st,stm32-rng.yaml b/Documentation/devicetree/bindings/rng/st,stm32-rng.yaml
>> index 59abdc85a9fb..0055f14a8e3f 100644
>> --- a/Documentation/devicetree/bindings/rng/st,stm32-rng.yaml
>> +++ b/Documentation/devicetree/bindings/rng/st,stm32-rng.yaml
>> @@ -37,6 +37,20 @@ required:
>>     - reg
>>     - clocks
>>   
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - st,stm32mp13-rng
>> +    then:
>> +      properties:
>> +        st,rng-lock-conf:
>> +          type: boolean
>> +          description: If set, the RNG configuration in RNG_CR, RNG_HTCR and
>> +                       RNG_NSCR will be locked.
> 
> Define the property at the top-level and then restrict its presence in
> a if/then schema.
> 

Can you please point me to an example of such case. I can't find a way
to define at the top-level the property then restrict it to specific
compatibles.

Else I'd change
additionalProperties :false to
unevaluatedProperties: false

so the definition of the property is seen.

Best regards,
Gatien

>> +
>>   additionalProperties: false
> 
> Did you test this property is allowed? No, because additionalProperties
> won't work with properties defined in if/then schemas.
> 
>>   
>>   examples:
>> -- 
>> 2.25.1
>>
