Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAB979C857
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjILHjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjILHjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:39:39 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2F2E7C;
        Tue, 12 Sep 2023 00:39:35 -0700 (PDT)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38C3N8bC006265;
        Tue, 12 Sep 2023 09:39:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=W6ZFSny7x5hTX7VHE3RAqqRXrh5zcFFP1oA9ZYe1TR0=; b=O6
        sEC3DWDxvkpK0fP1ZfbdNaRLyz8DljJOJRxQLP6ZnPjlk1F3sauZHJU4q5Nau8Oh
        pyPoKMerndpDvj4If+UI6pm5XzLqujorcuntOJvNCgQ7TgWxDFa4rmfDrBRNhvgY
        DHc1ad/Wgev9ePRbu/lF/7CNHM0pXZreVgsft2F8eicATDeTNEfuuu1bjWdxDvuo
        MhYyoNLjI0gDrO/5M0d0a2aKg4NPuePM0TjSKkMnUsl5AZSJF5AsOXwtYBTca5Ak
        8CcDovAp5Dok02K27+Cg3Qak3+5NlHjZ0eACKoX9h0v52B6PpIc0bcn57Cdsr7Vh
        sb637vw6RgiuHv0MT3xw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t2g1hryc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 09:39:15 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6D0C0100058;
        Tue, 12 Sep 2023 09:39:14 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 548FF21ED3A;
        Tue, 12 Sep 2023 09:39:14 +0200 (CEST)
Received: from [10.201.20.32] (10.201.20.32) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Sep
 2023 09:39:13 +0200
Message-ID: <3c138ce6-7766-87a7-1447-22f597863ab3@foss.st.com>
Date:   Tue, 12 Sep 2023 09:39:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 07/10] dt-bindings: rng: add st,rng-lock-conf
Content-Language: en-US
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
From:   Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <20230911150958.GA1255978-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.32]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_04,2023-09-05_01,2023-05-22_02
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

Ok, I will squash both for V3.

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

Ok, will change in V3. Thanks for your input

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

Best regards,
Gatien
