Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569DD79C732
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjILGwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjILGwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:52:42 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B142FE75
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:52:38 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so13590094a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694501557; x=1695106357; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YCCgJL7CLOtHoIO/zrNI8lFiRIRwo/myDfec2fb0VWc=;
        b=JpeygGG18GuY5c6YdSz1ftlmg5aDvlzthhe0z+mE+Mx1dvg+YPp5QXpHUmM5HfdJuP
         4nEvteQWThnZx0nhlTNbpJfvO/JiEPbt+yxSTMUBUwBKAkUzqJCBituubHkg/ESslxjY
         dLzpgkxxV+uXDB/HwjQibnLks49/2/Gg11BDU+WW/+pEEc+VJ1JcRf94ZU0xF+xT0rKX
         LJ3K8l4pTFhVErez+pZFgJlx7UP4goe2n63tbjm2pUT5cwb2r+1mNelt7nljoyd1pk7U
         p1tUfm6o3YYXZlcdt7VaqVKTteVKIkcXqh5IzoVEe3LiAgl0UTL5wIdR05eK1qh7fk4R
         HNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694501557; x=1695106357;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YCCgJL7CLOtHoIO/zrNI8lFiRIRwo/myDfec2fb0VWc=;
        b=p6580FTuPrucnT1PbaEz44KiVroMd7euvZGVKrYn87fmnPcf17JxUDpFg0R4d+p0yt
         fygubxXvxrqTRBkb8pFHn3rptpjSPIaPsXwo5LYdXHaY1J7gpmlX0/z9uJF+stEisQJw
         Q5PORDZUu54LXO1ZvUSxzqQv/TuUz7Vr6MgsRp2gn6mag3Em7XwJlGpX6Y9DsNe3QCeO
         LmlcHSADtdCHSS5DZzq/kPfY/IqH3g7C/xZVNmp+h/s2iv6tXrRyzymZmfXS6BHhPXSb
         wnCzDT9/8HcpW/OrgjNPa8u62YDlP7S1MPLzE22N2nJCQ3Wf00qy3rVtMeixXqwinbD9
         n3IQ==
X-Gm-Message-State: AOJu0YyRcyJkjBMulViZZiXYz3Uay1v64nuXp1X/wBSIHhkkTNMRqwda
        BMlfrL98mBWp8Zed5fNVeC/GVg==
X-Google-Smtp-Source: AGHT+IEWx95lm8CI08zr313SKed7edRDb0xjUNuKz1BYbcYP69GABjKTuBlO5trTmLCvZTrPwxPVCA==
X-Received: by 2002:a05:6402:d06:b0:51d:b184:efd with SMTP id eb6-20020a0564020d0600b0051db1840efdmr2064236edb.20.1694501557143;
        Mon, 11 Sep 2023 23:52:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id g12-20020a056402114c00b0052ea9ad21bdsm5474261edw.72.2023.09.11.23.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 23:52:36 -0700 (PDT)
Message-ID: <89341643-3d0e-89f6-f81c-579c56a358a3@linaro.org>
Date:   Tue, 12 Sep 2023 08:52:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2] dt-bindings: arm64: dts: mediatek: add description for
 mt8365-evk board
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
References: <20230911081126.18463-1-macpaul.lin@mediatek.com>
 <53cd72f7-5a8d-ee9e-4d8a-f5159cafb3e7@linaro.org>
 <4010955c-9df7-da30-aef9-477ae8483e89@mediatek.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4010955c-9df7-da30-aef9-477ae8483e89@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2023 08:29, Macpaul Lin wrote:
> 
>>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>>> ---
>>>  Documentation/devicetree/bindings/arm/mediatek.yaml | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> change for v2:
>>>  - rebase this patch to follow the v5 patch set of mt8395.
>>>   - depends on https://lore.kernel.org/lkml/20230909132819.21626-2-macpaul.lin@mediatek.com/T/
>>>  - Fix description as a single board.
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
>>> index 2e8ad49c3479..b163995e32d5 100644
>>> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
>>> @@ -244,7 +244,8 @@ properties:
>>>            - enum:
>>>                - mediatek,mt8183-pumpkin
>>>            - const: mediatek,mt8183
>>> -      - items:
>>> +      - description: MediaTek Genio 350 Board (Genio 350 EVK)
>>
>> Drop, no need, redundant (copies the compatible) and your other entries
>> do not have it.
> 
> The primary objective of this patch is to incorporate a description that 
> will prevent users from confusing this platform with others.

How platform can be confused? The compatibles define it, not description.

> Additionally, it aids in identifying this as a "Genio EVK" for marketing 
> purposes.

Kernel is not a place for marketing.

> Thanks
> Macpaul Lin

Best regards,
Krzysztof

