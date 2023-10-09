Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E057F7BE5A6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376948AbjJIP43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377086AbjJIP41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:56:27 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1AF99;
        Mon,  9 Oct 2023 08:56:25 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399D7P9l030790;
        Mon, 9 Oct 2023 17:56:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=72yN/PJtKSRJXmtVA+yut3IcjcusVBV+3vh9OJ6jXMI=; b=0U
        F6OFshRICcuO2W9xvyThnUicqt2zch1ApwS7VOhnC0+fo2Fs2nvIi9c88XwJ0MMC
        MVd7MoC2faveq64tHhqp0uCamd0Br6OAirAngFphh6rkAyPVWzq2DKJv08JhLCNf
        /b6+sY8NVBg8/AQOBNu4/FyisRSpyO4TGSz1ulfB0U43Gz47llPtU08vkJ4WDcQU
        82GSjJ/bEJR8MUOpOlGc1WOys9OpnQNl5/3XTwzqTNZjULVoYO/+ANEitNZyyn5p
        bk1HjRWc8UBig5Ie848l+czpH1eHzj6cO92Q/YYCdwQO4lU8BxhsBwbZWQ9c4ne6
        SdT8CmVtj/+SJGH+samQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3tkhfdx0sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 17:56:03 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C4DB710005E;
        Mon,  9 Oct 2023 17:56:01 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B7DED26DDAC;
        Mon,  9 Oct 2023 17:56:01 +0200 (CEST)
Received: from [10.201.20.120] (10.201.20.120) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 17:56:00 +0200
Message-ID: <13aa532e-5fbe-b8d4-d005-1973f589cef3@foss.st.com>
Date:   Mon, 9 Oct 2023 17:56:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/7] dt-bindings: media: Document STM32MP25 VENC video
 encoder
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        <linux-media@vger.kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>
CC:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
References: <20231004091552.3531659-1-hugues.fruchet@foss.st.com>
 <20231004091552.3531659-4-hugues.fruchet@foss.st.com>
 <6bc60e4a-ddf1-4125-ba27-53ab55a553d2@linaro.org>
 <0de2ae74-2ba1-0e8d-aa7b-77806ac8b252@foss.st.com>
 <1e2a4d87-5478-4655-993d-7f404d507c82@linaro.org>
 <fa0e6187-ab7d-bc23-299c-a491c8ff1d8f@foss.st.com>
 <d3f56d51-beb0-4f7a-a1f6-3ae03bbc9826@linaro.org>
From:   Hugues FRUCHET <hugues.fruchet@foss.st.com>
In-Reply-To: <d3f56d51-beb0-4f7a-a1f6-3ae03bbc9826@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.120]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_14,2023-10-09_01,2023-05-22_02
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 10/9/23 16:28, Krzysztof Kozlowski wrote:
> On 09/10/2023 16:24, Hugues FRUCHET wrote:
>> Hi Krzysztof,
>>
>> On 10/9/23 15:56, Krzysztof Kozlowski wrote:
>>> On 09/10/2023 15:49, Hugues FRUCHET wrote:
>>>> Hi Krzysztof,
>>>>
>>>> On 10/5/23 21:45, Krzysztof Kozlowski wrote:
>>>>> On 04/10/2023 11:15, Hugues Fruchet wrote:
>>>>>> Add STM32MP25 VENC video encoder bindings.
>>>>>>
>>>>>
>>>>> I don't understand why this binding is separate from video decoder.
>>>>> Merge them.
>>>> VDEC and VENC are two independent IPs with their own clock, reset,
>>>> interrupt & register set, they have their own access to APB/AXI bus.
>>>> Moreover future chipsets may embed only VENC or VDEC.
>>>>
>>>> Hoping that this clarifies the reason of two different bindings.
>>>
>>> No, it does not. These are no reasons to have independent bindings,
>>> except when having actual impact on the bindings. The bindings look
>>> identical. What are the differences?
>> I'm sorry but I really don't understand your point, these are two
>> different IPs with very different registers in it, so why should
>> I share that in a single binding ?
> 
> Because the binding is identical. If not, maybe I missed something, so
> please point me to differences in the binding.

OK, currently they are identical so I will merge into a single one
even if I disagree on that.
I hope that in future this will not change otherwise I'll need to 
revisit that and make separate bindings as initially proposed...
I'll so push a v2 with merged version proposal.

> 
> Best regards,
> Krzysztof
> 

BR,
Hugues.
