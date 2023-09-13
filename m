Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C960179E125
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 09:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238665AbjIMHtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 03:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238645AbjIMHtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 03:49:41 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7B2198B;
        Wed, 13 Sep 2023 00:49:37 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38D7IYCY012197;
        Wed, 13 Sep 2023 09:49:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=qvNrnSqmnkbcVN82Gdh3SbGyVzQj2Bekue7XEA12AWI=; b=Yc
        y2NwhjcV7oUxZHalY/c3jSPAgKLENTGyEzJISuOlGDDe6iSlhgartrpn74UjLtBD
        1Q795kytgQP29NvHjGU1R1MrZW72i7U2Zw0IEk34IyJLZBa43EbNV3Ki7uC0Ew1O
        C7kAqKzm8Ni2fCylkWdpodRzI07K0boBGbs0okVx7+g90pqlBYoK4gX26kmbtZzW
        Qe220r8ssdGysZWC4Db+U5tOyYlUa/x9N/q52DSiWAZi/x4Dk9W6Luyreze7opue
        i5G1mnInh/IdIdMscobI22EEt0hQ3qAeaffx5gmI4VCUYLahWbmrUYH9CTwsS5pM
        Vl8nUu/JbDB2fB0mAJoA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t2y7n9y2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 09:49:06 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4D39E100057;
        Wed, 13 Sep 2023 09:49:03 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 43A8F226FC7;
        Wed, 13 Sep 2023 09:49:03 +0200 (CEST)
Received: from [10.201.20.32] (10.201.20.32) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 09:49:02 +0200
Message-ID: <d5f2d1b3-fc91-76f0-af3d-bcdf6c4b5703@foss.st.com>
Date:   Wed, 13 Sep 2023 09:48:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 07/10] dt-bindings: rng: add st,rng-lock-conf
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Lionel Debieve <lionel.debieve@foss.st.com>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230911120203.774632-1-gatien.chevallier@foss.st.com>
 <20230911120203.774632-8-gatien.chevallier@foss.st.com>
 <28ec58a3-63d5-f604-cef9-571b062fe244@linaro.org>
Content-Language: en-US
From:   Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <28ec58a3-63d5-f604-cef9-571b062fe244@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.32]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_24,2023-09-05_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/23 16:38, Krzysztof Kozlowski wrote:
> On 11/09/2023 14:02, Gatien Chevallier wrote:
>> If st,rng-lock-conf is set, the RNG configuration in RNG_CR, RNG_HTCR
>> and RNG_NSCR will be locked. It is supported starting from the RNG
>> version present in the STM32MP13
>>
>> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
> 
> How did you implement the comment? There is no changelog, so was it ignored?
> 
> Best regards,
> Krzysztof
> 

Hello Krzysztof,

I've sent V2 before Rob's review. I'll apply Rob's comment for V3.

Best regards,
Gatien
