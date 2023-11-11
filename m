Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D847E89A9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 08:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjKKHzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 02:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjKKHzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 02:55:09 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5F03C19
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 23:55:05 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-408382da7f0so21514925e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 23:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699689303; x=1700294103; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wpvtUlVO2IhJS75FTLKOl44VBAIxaPpUsmZ2qBQY3ek=;
        b=td/q3DeSkP9lyjfvDPheZfDX8+zp15ZCjHWoiLloB+SxLOTyJi8iB9wdFWYnP9ws/w
         3WGNYHVcCpKk5lToaAvZuRjPX/jKuNYCB4QPfeKoEI2Sn2TiojP6JnB465a2VNAwvcL1
         JGEP7t31YGt03P8mImjvJXTgyVumqdnb1k861M+ht2mUertw+o7JPqjsk6OBFUm/hjL2
         LILb9OtDW2HY9BnI6lDc15E99WQiA6BbwyN/CY+ydPfReHhkzeRPiVtAd61OHcWoW+nI
         AFiYT5rqgjCiS+OfjVNmbz8y+akrCid/NlrJn9LGiwPaJ87KGWce+8h2HBrDKzKWiFtL
         luPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699689303; x=1700294103;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpvtUlVO2IhJS75FTLKOl44VBAIxaPpUsmZ2qBQY3ek=;
        b=s8Ao26qcSKPAE9iGwlRl9nC3pJswYEzPDUJhr0ZkZvWfVjQdruqlGBWRImALIdWPU2
         VlwTXry6214kkH+sGz140CaoLtwjMOVV0ucentFagz+TV/h4h8N7R1ydjWFgQhgGzS5g
         C1frLaspwgFR8MR4j5lyUyZaFLZWxt0zFGGjdRtMkY4FRJym3CjkxeeytCIyBN7HHS2k
         +QYJR4at2I8saFv6IzjL8bxoThj23DCPeLAM29XJKZS5vmeBwtClQjjCICM/lzl+kb0x
         pKUdzSw/51IC6vbO/UuYVPqZdQXo9bQyLeJUsjSXntoJLzBVGBAu0M9tjjTYVSBsEf5l
         P2Ng==
X-Gm-Message-State: AOJu0YxCoFpgf5eW/DHn3WsXQHKHbdmBguzdRjnDUgFbO13zbBqru6yp
        xvSW1t2CGFcgbezm8zcl6bBKww==
X-Google-Smtp-Source: AGHT+IE4G+AWegdOx9xxri1//vXyFTgcgmLlO+1gKfZm1MBZaiMPn19dmBFUQQzd9WJy157xrwSEVw==
X-Received: by 2002:a05:600c:1e11:b0:408:3f61:cb4f with SMTP id ay17-20020a05600c1e1100b004083f61cb4fmr968635wmb.23.1699689302966;
        Fri, 10 Nov 2023 23:55:02 -0800 (PST)
Received: from [10.230.170.72] (46-253-189-43.dynamic.monzoon.net. [46.253.189.43])
        by smtp.gmail.com with ESMTPSA id c20-20020a05600c0ad400b0040588d85b3asm7098432wmr.15.2023.11.10.23.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 23:55:02 -0800 (PST)
Message-ID: <8a0a95a1-eb20-4906-9b15-c20d568b7baa@linaro.org>
Date:   Sat, 11 Nov 2023 08:55:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: mediatek,mtk-wdt: add MT7988
 watchdog and toprgu
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     devicetree@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-watchdog@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>
References: <6912f6f406bc45674020681184f3eeca2f2cb63f.1699576174.git.daniel@makrotopia.org>
 <59629ec1-cc0c-4c5a-87cc-ea30d64ec191@linaro.org>
 <fc52c1df-e414-49a9-a3a7-7a4ce45c403e@linaro.org>
 <49cd75fd-962f-417c-9196-3c9edd42e4d5@linaro.org>
 <ZU6WfOUF7owz7ZLN@makrotopia.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZU6WfOUF7owz7ZLN@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2023 21:45, Daniel Golle wrote:
> On Fri, Nov 10, 2023 at 09:00:26PM +0100, Krzysztof Kozlowski wrote:
>> On 10/11/2023 16:20, Krzysztof Kozlowski wrote:
>>> On 10/11/2023 09:09, Krzysztof Kozlowski wrote:
>>>> On 10/11/2023 01:30, Daniel Golle wrote:
>>>>> Add binding description for mediatek,mt7988-wdt.
>>>>>
>>>>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>>>>> ---
>>>>
>>>> ...
>>>>
>>>>> diff --git a/include/dt-bindings/reset/mediatek,mt7988-resets.h b/include/dt-bindings/reset/mediatek,mt7988-resets.h
>>>>> new file mode 100644
>>>>> index 0000000000000..fa7c937505e08
>>>>> --- /dev/null
>>>>> +++ b/include/dt-bindings/reset/mediatek,mt7988-resets.h
>>>>> @@ -0,0 +1,12 @@
>>>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>>>>> +
>>>>> +/* TOPRGU resets */
>>>>> +#define MT7988_TOPRGU_SGMII0_GRST		1
>>>>> +#define MT7988_TOPRGU_SGMII1_GRST		2
>>>>> +#define MT7988_TOPRGU_XFI0_GRST			12
>>>>> +#define MT7988_TOPRGU_XFI1_GRST			13
>>>>> +#define MT7988_TOPRGU_XFI_PEXTP0_GRST		14
>>>>> +#define MT7988_TOPRGU_XFI_PEXTP1_GRST		15
>>>>> +#define MT7988_TOPRGU_XFI_PLL_GRST		16
>>>>
>>>> IDs should start from 0 or 1 and increment by 1. If these are not IDs,
>>>> then you do not need them in the bindings.
>>>>
>>>> Where is the driver change using these IDs?
> 
> It isn't needed as the driver doesn't list the IDs. If that would

Then it is no a binding.

> be true, it would be sufficient to put them into a header next to the
> driver or defined inside the driver C file.

Not related. Binding header is used by both driver and DTS.

> 
> The defined IDs here are intended to be used in device tree files.

Then not a binding.

> 
>>>
>>> You nicely skipped my email and keep pushing the idea of putting this
>>> into separate patch.
>>>
>>> No. Respond to received comments.
>>>
>>>>
>>>>> +
>>>>> +#define MT7988_TOPRGU_SW_RST_NUM		24
>>>>
>>>> Why 24? I see 7. 
> 
> Because the wdt on MT7988 has a total of 24 resets. Most of them are
> (currently, as there are no GPL drops, no publicly available devices,
> ...) undocumented and are not used in Linux **at this point**. Having
> to change the driver every time a new reset is discovered or needed to

There is no need to change the driver. Once it is set in the binding, to
let's say 7, it must stay like this. Since this is not representing real
binding resets (there are 7, not 24) and it is no used in DTS: this is
not a binding.


> be used is tideous, so I thought the best would be -- as we know the
> total number of resets -- to already define that, as it's safe to do
> and won't need to change.


> 
>>>> Why having it in the bindings in the first place.
> 
> This line can indeed go into the driver, it's not used anywhere else.
> I was merely immitating the style of all the existing binding headers
> for similar SoCs and didn't want to stick-out style-wise, also in terms
> of the added code to the driver which relies on that number being
> defined in the header for all other SoCs.
> 
>>>>
>>>> It's quite likely I asked the same question about other bindings for
>>>> Mediatek. I will be asking every time till this is fixed.
>>>
>>> No response to this, either.
>>
>> You still did not respond here. To none of the points here. It's my
>> third ping because I want this to be resolved. But ignoring my emails,
>> and skipping paragraphs of my replies will not lead anywhere.
> 
> I have answered to this before:
> The driver does NOT have any internal list of names of individual
> resets, it relies on the reset number from device tree matching the bit
> in the controller, just like for any other MediaTek toprgu already
> supported by mtk-wdt.c.

Sure, and this is not a binding. Please do not make binding things which
are not bindings, because later you (you as in plural) come and request
to change it, which must not be allowed. But because people stuff
not-binding-things into the binding they use it later as arguments that
it is allowed to change.

As I wrote before, I complained about this already several times and I
will be complaining every time.

Best regards,
Krzysztof

