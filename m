Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB457BE2AA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376964AbjJIOZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346526AbjJIOZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:25:31 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F8C9C;
        Mon,  9 Oct 2023 07:25:25 -0700 (PDT)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 399D7FQb012945;
        Mon, 9 Oct 2023 16:25:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=zayNHG01hD7SoipP4cr3YE823OncQrlcIxbIlovpurY=; b=bc
        9rpABeH8vTnol3/l+5Ly3ssLWnLy3/e25zP66iOFn4tkBcWy96oHWyhgTUXCi2QL
        Lub43y6ZklmSU45fIGxlqaXeoZ3g2ccL7VABlmlLboVNtRM7riHntKdxzzY6s9br
        Y+Yr8V6xjKESRIwzrnTHJNUrVXkOQP6VK877JBqFweIqiVbzVTvkrPR45uMTm8c1
        VLTv21bmq7J109mjPoxWExoSleWuh+BhipUYstU2z+EhLb34E9UYCgmP3KFQnUkt
        k4v8olLJ6NZofkKhCF0CrldnlbFWrfaGvA1YFlz20sB90QwEP11d/p+onyGXZ4g/
        kJebhUODwDWC7F0BOsBQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3tkhk3dk2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 16:25:02 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3FFAC100063;
        Mon,  9 Oct 2023 16:25:01 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2D7F6255514;
        Mon,  9 Oct 2023 16:25:01 +0200 (CEST)
Received: from [10.201.20.120] (10.201.20.120) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 16:25:00 +0200
Message-ID: <fa0e6187-ab7d-bc23-299c-a491c8ff1d8f@foss.st.com>
Date:   Mon, 9 Oct 2023 16:24:59 +0200
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
From:   Hugues FRUCHET <hugues.fruchet@foss.st.com>
In-Reply-To: <1e2a4d87-5478-4655-993d-7f404d507c82@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.120]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_12,2023-10-09_01,2023-05-22_02
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 10/9/23 15:56, Krzysztof Kozlowski wrote:
> On 09/10/2023 15:49, Hugues FRUCHET wrote:
>> Hi Krzysztof,
>>
>> On 10/5/23 21:45, Krzysztof Kozlowski wrote:
>>> On 04/10/2023 11:15, Hugues Fruchet wrote:
>>>> Add STM32MP25 VENC video encoder bindings.
>>>>
>>>
>>> I don't understand why this binding is separate from video decoder.
>>> Merge them.
>> VDEC and VENC are two independent IPs with their own clock, reset,
>> interrupt & register set, they have their own access to APB/AXI bus.
>> Moreover future chipsets may embed only VENC or VDEC.
>>
>> Hoping that this clarifies the reason of two different bindings.
> 
> No, it does not. These are no reasons to have independent bindings,
> except when having actual impact on the bindings. The bindings look
> identical. What are the differences?
I'm sorry but I really don't understand your point, these are two 
different IPs with very different registers in it, so why should
I share that in a single binding ?

> 
> Best regards,
> Krzysztof
> 

BR,
Hugues.
