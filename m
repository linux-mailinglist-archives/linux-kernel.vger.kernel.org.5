Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611BF79397A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 12:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbjIFKGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 06:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjIFKG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:06:26 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097531723
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 03:05:48 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9a6190af24aso530473766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 03:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693994745; x=1694599545; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7tKSKwBQVJKDaycrv4wlK1AbEjFOCJ/VVVw+I8g0nGI=;
        b=OGGvPgR/BGfFhvXkOtmyminynoXM4BVTqXvnPHePT4aZLOK/9fHxprWiUw/hytpNvK
         iXvE4RpSOeSNSXwYh8NikXVYzORZt8CpJX8nqegvDT0TyXTSeBm939sYuSLyXLemddaS
         mT/31LrrlXS79ox8thi557bsHXCbTyfzyA0F5JjxBHhUCZ/bOK6hh+4+Id2x+1WhiJKG
         1HZnIdV/AM+qf9LhA16eM/MKElnte60QySwKZmeoNoeB9NrBTSi+g4fSQ7mkzPZ11pst
         QN6GDyA+sunlcXmU56F2vWCsWoyvcOWziPfWHeKsq+y2q/wuUqqA0x/lMtHwHxwM6oUH
         qVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693994745; x=1694599545;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7tKSKwBQVJKDaycrv4wlK1AbEjFOCJ/VVVw+I8g0nGI=;
        b=jmcDdFOGOPC0XDQeA1l4IW7JoEJsUmcLBC9bMYIjqr0lj+SUECu9d7AhZBqFq9/azJ
         051aimMJfaomnaxx7vZp5pm+l1Y15/thDuje/J8GU1iqMnCoQNes6yvpGC/hEenx56DV
         Ik/NzxMBfK3f20QsnIb5XC+gFlm8qXGgsrlrl783oL1pwWVCsbQFjOd6ngg9HMP5VINs
         uFJH171wjLTIKWoVjcKJS6MNY/q8MMkzyFzDBDNs6O6UI7jTK4kMjkPzUHImDgWFIF81
         Pn9F4OQXjcyylCpYeYvIwCCFODCeL0vF097iA8zPDjfodLGBjPT3cellPd4pnZjXw2/W
         WeBQ==
X-Gm-Message-State: AOJu0Yym36OImPAVsaDNEgF0cez3c5Bn93a11tXHDDee6GLyVZmcAnU2
        dINAElVLhfVed8qmAY8m7Uwu9Q==
X-Google-Smtp-Source: AGHT+IEpRMvEFs2ZXroiFAbWtiUkVoWLxloTk4Lnh3qMYc6HU6F1RXvTuILRkfk3ScVp4BKkj9bzmg==
X-Received: by 2002:a17:906:9e:b0:9a1:eb67:c0ce with SMTP id 30-20020a170906009e00b009a1eb67c0cemr1953939ejc.50.1693994744740;
        Wed, 06 Sep 2023 03:05:44 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id o21-20020a1709062e9500b009a13fdc139fsm8824751eji.183.2023.09.06.03.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 03:05:44 -0700 (PDT)
Message-ID: <5ee0ab7f-0250-accb-83bb-0704ea9074e1@linaro.org>
Date:   Wed, 6 Sep 2023 12:05:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 1/2] dt-bindings: arm64: dts: mediatek: add mt8395-evk
 board
Content-Language: en-US
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>
References: <20230904092043.5157-1-macpaul.lin@mediatek.com>
 <20230906092527.18281-1-macpaul.lin@mediatek.com>
 <fbad941f-232b-9f56-5de3-98a16a8c4d89@linaro.org>
 <c3ddf00c-235a-2d23-db60-c998a67a3fcd@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c3ddf00c-235a-2d23-db60-c998a67a3fcd@mediatek.com>
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

On 06/09/2023 11:53, Macpaul Lin wrote:
> 
> 
> On 9/6/23 17:32, Krzysztof Kozlowski wrote:
>> 	
>>
>> External email : Please do not click links or open attachments until you 
>> have verified the sender or the content.
>>
>> On 06/09/2023 11:25, Macpaul Lin wrote:
>>> 1. Add compatible for MT8395.
>>> 2. Add bindings for the MediaTek mt8395-evk board, also known
>>> as the "Genio 1200-EVK".
>>>
>>> The MT8195 and MT8395 belong to the same SoC family,
>>> with only minor differences in their physical characteristics.
>>> They utilize unique efuse values for differentiation.
>>>
>>> The booting process and configurations are managed by boot
>>> loaders, firmware, and TF-A. Consequently, the part numbers
>>> and procurement channels vary.
>>>
>>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>>> ---
>>>  Documentation/devicetree/bindings/arm/mediatek.yaml | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>
>> Do not attach (thread) your patchsets to some other threads (unrelated
>> or older versions). This buries them deep in the mailbox and might
>> interfere with applying entire sets.
>>
>>>
>>> Changes for v2:
>>>  - add more detail description for mt8395.
>>>  - add bindings for mt8395, and mt8395-evk.
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
>>> index ae12b1cab9fb..d7a20df640d7 100644
>>> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
>>> @@ -248,6 +248,11 @@ properties:
>>>            - enum:
>>>                - mediatek,mt8365-evk
>>>            - const: mediatek,mt8365
>>> +      - description: MediaTek Genio 1200 Boards (Genio 1200 EVK)
>>> +        items:
>>> +          - enum:
>>> +              - mediatek,mt8395-evk
>>> +          - const: mediatek,mt8395
>>
>>
>> I don't understand. You said last time this is fully compatible with
>> mt8195, so why it's not here?
>>
> 
> Yes, mt8395 is fully compatible with mt8195.
> 
> But after reading Angelo's comment, we thought it is necessary to create 
> a new compatible to avoid confusion for users.
> https://lore.kernel.org/lkml/bf8394c6-5460-8696-f46b-0c39927aaf84@collabora.com/
> 

New compatible is a requirement, you got clear comments from me on this
as well. However we did not ask to remove a compatible of compatible
devices. You also need it. Otherwise how your compatibility is going to
work?

Best regards,
Krzysztof

