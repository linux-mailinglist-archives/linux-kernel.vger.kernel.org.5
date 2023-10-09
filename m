Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B907BDD17
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376656AbjJINHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376326AbjJING7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:06:59 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6688C8F;
        Mon,  9 Oct 2023 06:06:57 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39988KWV002751;
        Mon, 9 Oct 2023 15:06:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=3PQ+2v2hmYuHs5jDOC8Az7oTSOTXepldPGCW+7kNOTA=; b=qj
        KXN6ucPltGfUQkCxs5eJy7A75jo7dich1n9YVbSe4Eii8m5W4Nbhpj+Fn/qDpai5
        Dbo9az6CTZcEyjF5vlr3tce4X4YgmKmg0OPJ9hnWqu9Z2OlOtebz6gtyJb2Z/J6t
        xc9ps9L7MmTXwV+T0t0XHRjixFUwKPPfuOqxzONPy2uecd6OVygRbjgmxK3toVK+
        nvZKlPFnhc10HgFuCJnCOVdHMdZCyGsQnj++QSIPoZ4XvfN80uhgRa/i7Ut6/+g+
        mtnknabD4AxY0yNQeLZBNya+nocaQ9n4k+zR2xJwwxvDkZzK/04tESU95bPjf5a4
        OiQr0lskndAPscCSkm3g==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3tkhfdw9uw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 15:06:32 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5FA51100063;
        Mon,  9 Oct 2023 15:06:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 52ABC23D411;
        Mon,  9 Oct 2023 15:06:30 +0200 (CEST)
Received: from [10.201.20.120] (10.201.20.120) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 15:06:29 +0200
Message-ID: <fb77b886-b557-b2af-a2f5-c0057a95b589@foss.st.com>
Date:   Mon, 9 Oct 2023 15:06:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/7] dt-bindings: media: Document STM32MP25 VENC video
 encoder
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Adam Ford <aford173@gmail.com>
CC:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        <linux-media@vger.kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>
References: <20231004091552.3531659-1-hugues.fruchet@foss.st.com>
 <20231004091552.3531659-4-hugues.fruchet@foss.st.com>
 <CAHCN7xKrriTPaRMJ-r86cSgFDUUP1At08imLBr_zEP0g3fga_g@mail.gmail.com>
 <20231006162703.GA4030032-robh@kernel.org>
From:   Hugues FRUCHET <hugues.fruchet@foss.st.com>
In-Reply-To: <20231006162703.GA4030032-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.120]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_11,2023-10-09_01,2023-05-22_02
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 10/6/23 18:27, Rob Herring wrote:
> On Wed, Oct 04, 2023 at 06:41:09PM -0500, Adam Ford wrote:
>> On Wed, Oct 4, 2023 at 4:16 AM Hugues Fruchet
>> <hugues.fruchet@foss.st.com> wrote:
>>>
>>> Add STM32MP25 VENC video encoder bindings.
>>>
>>> Signed-off-by: Hugues Fruchet <hugues.fruchet@foss.st.com>
>>> ---
>>>   .../bindings/media/st,stm32mp25-venc.yaml     | 56 +++++++++++++++++++
>>>   1 file changed, 56 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/media/st,stm32mp25-venc.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/media/st,stm32mp25-venc.yaml b/Documentation/devicetree/bindings/media/st,stm32mp25-venc.yaml
>>> new file mode 100644
>>> index 000000000000..c69e0a34f675
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/media/st,stm32mp25-venc.yaml
>>> @@ -0,0 +1,56 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/media/st,stm32mp25-venc.yaml#
>>
>> Can this dt-binding be made more generic, like something like
>> hantro-h1 or VC8000NanoE?
>>
>> I think there will be more boards that may incorporate the Hantro-H1
>> or a VC8000 in the future, because I don't think this IP is unique to
>> the STM32MP25.
> 
> Unless the underlying IP is well documented (i.e. public), then it's
> kind of pointless. Everyone will just invent their own numbers and names
> of clocks, resets, etc. unless someone can enforce not doing that.

Unfortunately the IP documentation is not public, there are no documents 
provided publicly by Verisilicon for the time being.

> 
> Rob

BR,
Hugues
