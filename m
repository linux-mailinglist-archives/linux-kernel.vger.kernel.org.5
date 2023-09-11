Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F4379A416
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbjIKHDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbjIKHDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:03:50 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC751AD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:03:44 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52c4d3ff424so5320354a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694415823; x=1695020623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2HRm+Y6RHREhAisd/9XgRmAyoMKP+6E7yqxOyOn8vFA=;
        b=O8vX888k2FTOeI15qh9tjjO3Yik/B+GUV35yPOV7lJWe4wCyQYWMUpXtpv40skRJH0
         +Den6DXPX6zUjNDUNslM2gaM+fjtCfzt7h/64TLXmqUZLosqA2quqt94jrIc0FSilXfF
         bGWgpgaO/clAivjDShTscv1mIl4LG8jpIXilZJl0zwz+bWj1KrEBod8az2pU9uOkC8QY
         p9t3fLRV8VrQhbrDBNKCpa4cV+slgC+0LofZlccMuVjkZYpMq1VwMlP9dji2J9YIiCVV
         5WzaE3G2LPgbXtCsAxe5x3agK2YS54BD3G8Z1bfriwvHAAp7vq36myVvKBSt82okNUrv
         nKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694415823; x=1695020623;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2HRm+Y6RHREhAisd/9XgRmAyoMKP+6E7yqxOyOn8vFA=;
        b=OtKCK6OZqswUk5zt952TZ+oZklNUmAZwb321fGLh6dxAfrBYSQsPnuwENVlcxlEl9T
         PtOUVWQp/D2Z5C3TR5iI260DyTXaw8J0uMmN/K0eja7QSBb8ZgrV9myVlIwHsA6F6K7Z
         WdCgIkHKAMsVJep8lMfz+HcSDf+rDy64Juvbi90eZt15NXdFkZM7DCDWP+VnwkffWVsC
         3Isp9TrMAls3f9rSPtQaM+Ndn73+RC2XIhj6l3gtgKcYmOycAbVTCIyZmERlMbj1W9X/
         JdPOs/44okd53qZrd7Gu4cbHa39ttTkZR6Ylc8EBhfJUq5l+eLlf14hnWcXLWVHaTv8A
         eocg==
X-Gm-Message-State: AOJu0YwwoUIL5QF5BmzGPKZcPvvGDvsKyff3VxoE3Vkv+99dUjWDd9zR
        3FQky7comE08xcDF9Vd9nCn1eA==
X-Google-Smtp-Source: AGHT+IGlhl6S6bo4yFHk9OuoeD6bmuBmPDRsJLNGTMN304xWsSVIV7iaHzYC4iOaU65e/b4CLF5/mA==
X-Received: by 2002:a17:906:31c1:b0:9a9:e735:f621 with SMTP id f1-20020a17090631c100b009a9e735f621mr7374615ejf.15.1694415823235;
        Mon, 11 Sep 2023 00:03:43 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id cx2-20020a170906c80200b0099cbfee34e3sm4886533ejb.196.2023.09.11.00.03.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 00:03:42 -0700 (PDT)
Message-ID: <81fe77c4-5f19-984d-5331-cbc4b13f2de3@linaro.org>
Date:   Mon, 11 Sep 2023 09:03:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v5 1/2] dt-bindings: arm64: dts: mediatek: add mt8395-evk
 board
Content-Language: en-US
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>
References: <20230909132819.21626-1-macpaul.lin@mediatek.com>
 <2318be3d-5687-8b6c-3669-1d2ae1c94d2c@linaro.org>
 <946ee1c5-77af-3ce0-83ba-2966fab70a5f@mediatek.com>
 <fc4bd212-c112-0d42-e94c-c3ba569d2d32@linaro.org>
 <d959de4d-43e3-ec58-8873-415165ac2705@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d959de4d-43e3-ec58-8873-415165ac2705@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2023 08:46, Macpaul Lin wrote:
> On 9/11/23 14:07, Krzysztof Kozlowski wrote:
>> 	
>>
>> External email : Please do not click links or open attachments until you 
>> have verified the sender or the content.
>>
>> On 10/09/2023 14:23, Macpaul Lin wrote:
>>>
>>>
>>> On 9/10/23 18:56, Krzysztof Kozlowski wrote:
>>>>
>>>>
>>>> External email : Please do nost click links or open attachments until you 
>>>> have verified the sender or the content.
>>>>
>>>> On 09/09/2023 15:28, Macpaul Lin wrote:
>>>>> 1. Add compatible for MT8395.
>>>>> 2. Add bindings for the MediaTek mt8395-evk board, also known
>>>>> as the "Genio 1200-EVK".
>>>>>
>>>>> The MT8195 and MT8395 belong to the same SoC family,
>>>>> with only minor differences in their physical characteristics.
>>>>> They utilize unique efuse values for differentiation.
>>>>>
>>>>> The booting process and configurations are managed by boot
>>>>> loaders, firmware, and TF-A. Consequently, the part numbers
>>>>> and procurement channels vary.
>>>>>
>>>>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>
>>> Changes for v4:
>>> Changes for v5:
>>>   - No change, update Reviewed-by tag only. Thanks.
>>>
>>> The explanation is here. The version v4 and v5 are the same.
>>> For sending v5 is because "Patch v5 2/2" has been updated and these 2 
>>> patches were in the same patch set. I think to update the whole patch 
>>> set together with a single modified patch should be a usual operation.
>>> Did I miss anything?
>>
>> Yeah, like not top-posting.
>>
>> Why do you change the same line in other patchset?
> 
> Hmm, they are different patch actually.

That's what I wrote. "Other patchset" == "different patch".

> I've tested the patch v5 here can be applied with / without mt8365's 
> description patch independently.

That's not the answer to my question. I asked "Why". I have troubles
getting any answers here, so let's be clear - this or the other patch is
just wrong.

Best regards,
Krzysztof

