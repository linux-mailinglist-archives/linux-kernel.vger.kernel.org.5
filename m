Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5617E75ADC1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjGTMF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjGTMF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:05:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087BD10FC;
        Thu, 20 Jul 2023 05:05:24 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DBDD16607083;
        Thu, 20 Jul 2023 13:05:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689854722;
        bh=4zdlMTy2Q9xaiOXHklHe2EJ+an362L+tbbNoTvs277Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PHtnqlc7wNEtf+0+9asTEBLPgo5wze4be0hStobRTy0R6rwA22zNO9NTVSd9r8rKx
         FsPD10bOkxbdjvSH3z2HjVy7ztDBTVIFCXA2vqM0y20mbdfYMdAA8xOgp6UkHKPZnE
         yiSQ+uiIySkDWLCvRWVt9J0Kk0zn+r/hMmm/e0ipaDxBoYMhnGrKZFPGKFPAvgxCtp
         m4v31whL4HjmrG+VOJfAwwyYiuINYXe77MWs0qyrTViuXb5K6tjla+hQ7OQQlESjKL
         VHVqO4rq0ri1s8iilG/b65BdyjvhVD5xQI4L2LVikN6flY2YLaVXo7waj2GZl4wPRP
         lBFFvT60bwfoQ==
Message-ID: <ac583fec-d991-713b-8329-96b3626465ef@collabora.com>
Date:   Thu, 20 Jul 2023 14:05:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] arm64: dts: mediatek: mt6795: Add support for display
 blocks and DPI/DSI
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, kernel@collabora.com
References: <20230720091559.86406-1-angelogioacchino.delregno@collabora.com>
 <20230720091559.86406-2-angelogioacchino.delregno@collabora.com>
 <0809ac02-b8bf-ed63-9e2e-e77cd7e93464@baylibre.com>
 <d892a76c-165b-dbeb-79aa-70f3ebd7f07c@collabora.com>
 <ab463c69-59e0-99b5-1526-7c344fcc593f@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <ab463c69-59e0-99b5-1526-7c344fcc593f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/07/23 14:01, Krzysztof Kozlowski ha scritto:
> On 20/07/2023 13:52, AngeloGioacchino Del Regno wrote:
>> Il 20/07/23 13:35, Alexandre Mergnat ha scritto:
>>>
>>>
>>> On 20/07/2023 11:15, AngeloGioacchino Del Regno wrote:
>>>> Introduce all nodes for all of the display blocks in the MediaTek Helio
>>>> X10 MT6795 SoC, including the DSI PHY and DSI/DPI interfaces: those are
>>>> left disabled as usage is board specific.
>>>>
>>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>> ---
>>>>    arch/arm64/boot/dts/mediatek/mt6795.dtsi | 252 +++++++++++++++++++++++
>>>>    1 file changed, 252 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt6795.dtsi
>>>> b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
>>>> index 597bce2fed72..d805d7a63024 100644
>>>> --- a/arch/arm64/boot/dts/mediatek/mt6795.dtsi
>>>> +++ b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
>>>> @@ -2,6 +2,9 @@
>>>>    /*
>>>>     * Copyright (c) 2015 MediaTek Inc.
>>>>     * Author: Mars.C <mars.cheng@mediatek.com>
>>>> + *
>>>> + * Copyright (C) 2023 Collabora Ltd.
>>>> + *                    AngeloGioacchino Del Regno
>>>> <angelogioacchino.delregno@collabora.com>
>>>
>>> Shouldn't be like this ?
>>>
>>>    * Copyright (c) 2015 MediaTek Inc.
>>>    * Copyright (C) 2023 Collabora Ltd.
>>>    * Authors: Mars.C <mars.cheng@mediatek.com>
>>>    *          AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>
>>>
>>
>> I don't think that there's any rule about this?
>> Also I don't really mind the strings order, but if anyone really does, I can change
>> it....
> 
> These have two entirely different meanings. Your patch suggests you hold
> copyrights (which is usually not true if working for employer).

Right. Thank you, I'll send a new version tomorrow :-)

> 
> Best regards,
> Krzysztof
> 


