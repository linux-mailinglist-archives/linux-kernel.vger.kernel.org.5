Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADF175ADCE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbjGTMHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjGTMHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:07:11 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C4D1715
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:07:08 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98df3dea907so124117366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689854826; x=1690459626;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C/pQYZXvCL/vH+InQO678qhur3p7zMNQkrPa73LIehA=;
        b=b4SbQwmdb5WswWDI1wo6eR85VROuxSBN7cQHGY1PrNXLz5oDMzsxtTm/0rcFWqcEcO
         Cxp12ZA7Vf3zn5cqDYG/mBnHrBO4v9cNudmeH7WSSSkdnuG2Cj0gNUERs5mFlu+tAO9y
         GtfFSxxndfir5ZdDQ+LhaFHRfjMDYBA5VzkE0uTjX+qtIxmm6kZw0nVimMq014FZ+tBk
         rrLgP/6XC+RfCErFUiwVOldbncNbecud1Gh1Fy6y7lPkSkij50g4EcMYjlXpIn6EKESu
         BP+43KWiGPLFNIOrWa7t4KNjnfVeQfjHzBm+UbaJMfzEzRudh3lfcFuraVrctmPnq54f
         pBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689854826; x=1690459626;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C/pQYZXvCL/vH+InQO678qhur3p7zMNQkrPa73LIehA=;
        b=imYb5J+NQZo4gTb4zaqwpTOHIDktt1ifr8lspLMDkJkNSlUU9oIX7GPelgdC0Jq0XU
         Z693qq1LKq4jN4rqmXCWPMpEvMqJJLwwK/uv2YBLpg4Ne8ERqAB8M+BtLFwdQyBqb1JI
         9RbAWcdlReb6DBktHugojrxZEVVHUoPu2gj9INREJ4y4u6N/ByT0uCJsi36XbT76j59q
         tUGdKqbAFVwVL7LmPySIJuX4I4jwsF4WB3p+LY/TRHmVXEZYD9CWtlayyonIJLDNKlc9
         fyhVZris/ztSbC/WzDD3lQMHA8V16/XMJQbmybcbAdCt4vQJWq0xAaKuwr/EnZshcNjX
         GCHw==
X-Gm-Message-State: ABy/qLbHivekmpRpMRusduoATucsChuvF4DJHhNjJMls6sLVBX1k/vnG
        /AvTGDGTx9+TcHb7YlvFFjWxtw==
X-Google-Smtp-Source: APBJJlE0xBhrIqBKnTaU36gyXlOT5nf8DniN0oGDkPcqlA18Hu2PRw42dkrUVAQsFiZM2IUUdeqFGg==
X-Received: by 2002:a17:906:7791:b0:992:764b:90d5 with SMTP id s17-20020a170906779100b00992764b90d5mr1991567ejm.71.1689854826324;
        Thu, 20 Jul 2023 05:07:06 -0700 (PDT)
Received: from [10.1.3.131] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c11-20020a170906924b00b0098e34446464sm615265ejx.25.2023.07.20.05.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 05:07:05 -0700 (PDT)
Message-ID: <6c3422e8-4e2e-ba3a-4f30-d24308ef7c2a@baylibre.com>
Date:   Thu, 20 Jul 2023 14:07:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3,3/3] drm/mediatek: dp: Add the audio divider to
 mtk_dp_data struct
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Shuijing Li <shuijing.li@mediatek.com>,
        chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        matthias.bgg@gmail.com, jitao.shi@mediatek.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230720082604.18618-1-shuijing.li@mediatek.com>
 <20230720082604.18618-4-shuijing.li@mediatek.com>
 <44cc9cc5-7dce-f7a2-f077-b62d7851ee12@baylibre.com>
 <65da6005-3c07-a7ea-6b63-db45c8915ae8@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <65da6005-3c07-a7ea-6b63-db45c8915ae8@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/07/2023 13:54, AngeloGioacchino Del Regno wrote:
> Il 20/07/23 12:14, Alexandre Mergnat ha scritto:
>>
>>
>> On 20/07/2023 10:26, Shuijing Li wrote:
>>> Due to the difference of HW, different dividers need to be set.
>>>
>>> Signed-off-by: Shuijing Li <shuijing.li@mediatek.com>
>>> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
>>> ---
>>> Changes in v3:
>>> Separate these two things into two different patches.
>>> per suggestion from the previous thread:
>>> https://lore.kernel.org/lkml/e2ad22bcba31797f38a12a488d4246a01bf0cb2e.camel@mediatek.com/
>>> Changes in v2:
>>> - change the variables' name to be more descriptive
>>> - add a comment that describes the function of 
>>> mtk_dp_audio_sample_arrange
>>> - reduce indentation by doing the inverse check
>>> - add a definition of some bits
>>> - add support for mediatek, mt8188-edp-tx
>>> per suggestion from the previous thread:
>>> https://lore.kernel.org/lkml/ac0fcec9-a2fe-06cc-c727-189ef7babe9c@collabora.com/
>>> ---
>>>   drivers/gpu/drm/mediatek/mtk_dp.c     | 7 ++++++-
>>>   drivers/gpu/drm/mediatek/mtk_dp_reg.h | 1 +
>>>   2 files changed, 7 insertions(+), 1 deletion(-)
>>>
...
>>> b/drivers/gpu/drm/mediatek/mtk_dp_reg.h
>>> index f38d6ff12afe..6d7f0405867e 100644
>>> --- a/drivers/gpu/drm/mediatek/mtk_dp_reg.h
>>> +++ b/drivers/gpu/drm/mediatek/mtk_dp_reg.h
>>> @@ -162,6 +162,7 @@
>>>   #define AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_MUL_2    (1 << 8)
>>>   #define AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_MUL_4    (2 << 8)
>>>   #define AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_MUL_8    (3 << 8)
>>> +#define MT8188_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_2    (4 << 8)
>>
>> IMO, it's a bit weird to have SoC specific define in the generic header.
>> Are you sure this bit is only available for MT8188 ?
>>
> 
> Eh, the P0_DIV2 bit is 5<<8 for MT8195, while for 8188 it's 4<<8, 
> clearly :-)
> 

Ok then, to avoid this kind of issue for other SoCs in the future, is 
that make sense for you to do a SoC specific header file beside the 
generic one?

>>>   #define AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_2    (5 << 8)
>>>   #define AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_4    (6 << 8)
>>>   #define AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_8    (7 << 8)
>>
>> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
>>
> 
> 

-- 
Regards,
Alexandre
