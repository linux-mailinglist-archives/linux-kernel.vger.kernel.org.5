Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1067BA3E6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240032AbjJEP7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbjJEP5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:57:05 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DFA5BAF;
        Thu,  5 Oct 2023 06:54:01 -0700 (PDT)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3957sk4Z016062;
        Thu, 5 Oct 2023 11:03:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:from:subject:to:cc:references
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=TL8rjdUxIkJ2Lw6N7JSwlTLRlaqLDrKfaBPpYRDg6Sk=; b=Q8
        Y0m8gC7EFxzcTF30JVYIedHOeHhIKGO2C+yDCdIErSG47kE6+/aiDbLm3oZ/zgMj
        XU4n/AbivH9uq20jH4cl2SY4wfW33pBnZ6Ay45rp7ZIWqriZrQzUCrNzsBZTRHlX
        hvZXUmKUpMRwKhBbt993HAmYtYeEGh4DAOo9rY/Jg4cxKPy5IId8IObE205sJxGr
        9YQwetJwHU2ed5atklPTQLfnVzwgeeHFHbaoBTqwcLkl3Zv570qSVXBqJsqktyWo
        OHpbcjtDl8T2P3H6GhkNDHqMEmr0NZjvbL2OsA8/G9kBsMYJ8GoxK21B8jc41rYZ
        FndGzzPHMOTi5jJon/CQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ths5ugc85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 11:03:59 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F18B610005C;
        Thu,  5 Oct 2023 11:03:57 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A02C3229A76;
        Thu,  5 Oct 2023 11:03:57 +0200 (CEST)
Received: from [10.252.31.76] (10.252.31.76) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 11:03:54 +0200
Message-ID: <85e3b93c-36b2-cb4c-9438-ad05d24b3332@foss.st.com>
Date:   Thu, 5 Oct 2023 11:03:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From:   Christophe ROULLIER <christophe.roullier@foss.st.com>
Subject: Re: [PATCH v3 02/12] dt-bindings: net: add new property st,ext-phyclk
 in documentation for stm32
To:     Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230928151512.322016-1-christophe.roullier@foss.st.com>
 <20230928151512.322016-3-christophe.roullier@foss.st.com>
 <20230928-ruse-parsnip-ce691bd4d0c9@spud>
Content-Language: en-US
In-Reply-To: <20230928-ruse-parsnip-ce691bd4d0c9@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.31.76]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_06,2023-10-02_01,2023-05-22_02
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/28/23 19:17, Conor Dooley wrote:
> On Thu, Sep 28, 2023 at 05:15:02PM +0200, Christophe Roullier wrote:
>> Add property st,ext-phyclk to manage cases when PHY have no cristal/quartz
>> This property can be used with RMII phy without cristal 50Mhz and when we
>> want to select RCC clock instead of ETH_REF_CLK
>> Can be used also with RGMII phy with no cristal and we select RCC clock
>> instead of ETH_CLK125
>> This new property replace st,eth-clk-sel and st,eth-ref-clk-sel
> I don't really see a response to Rob's comment on v2, either here or in
> a reply to his email on v2:
> | Certainly 1 property is better than 2 for me, but carrying 3 is not
> | great. I don't understand why the we need a new property. What can't be
> | supported with the existing properties?
>
> A sentence saying explaining exactly what the old properties do not
> support that this one does, would be very helpful.
>
> Thanks,
> Conor.

I understand your remarks, the goal of the new property is to be more 
simple for customers/users

with old properties we have lots of support to explain which one to use 
in which cases, now only one property to use (regardless of mode)

Thanks,

Christophe.

>> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
>> ---
>>   Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
>> index ca976281bfc22..67840cab02d2d 100644
>> --- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
>> +++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
>> @@ -78,12 +78,21 @@ properties:
>>         encompases the glue register, the offset of the control register and
>>         the mask to set bitfield in control register
>>   
>> +  st,ext-phyclk:
>> +    description:
>> +      set this property in RMII mode when you have PHY without crystal 50MHz and want to
>> +      select RCC clock instead of ETH_REF_CLK. or in RGMII mode when you want to select
>> +      RCC clock instead of ETH_CLK125.
>> +    type: boolean
>> +
>>     st,eth-clk-sel:
>> +    deprecated: true
>>       description:
>>         set this property in RGMII PHY when you want to select RCC clock instead of ETH_CLK125.
>>       type: boolean
>>   
>>     st,eth-ref-clk-sel:
>> +    deprecated: true
>>       description:
>>         set this property in RMII mode when you have PHY without crystal 50MHz and want to
>>         select RCC clock instead of ETH_REF_CLK.
>> -- 
>> 2.25.1
>>
