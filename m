Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575A279A420
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjIKHHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjIKHHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:07:05 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3F2133
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:06:59 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99bcf2de59cso514743466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694416018; x=1695020818; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BjkKRWZOJVa0TjkWXeagUayHJQ6YOMEruC33WrNwKSs=;
        b=eciPGxU9ElGNRMPn7APlgQtqjZh7nLFHyCMtaGTqo9KOUp2UDvpyT6jo9n2atbzaZF
         8ccOgQqAdnfwimkyovUsCncu6ryOmHbYqEjxlYn6X1xvlem9fbzlO6dOPS6peiNmibrS
         D+Ny8YjLsDImuVS4+AhZrDm4plLH36WLlUDDDwBl2rjlmXMmK/GlT7uBuzFBHEyLDb+j
         k328vxxB0soj6O2UbXt0WZiU2NdR5Oq2a3w1p7IDXXbRcfll+0tnYD1xJf3pndK5If6P
         iWZxGRSdDKd5f53dOUL1jXELp5a7fzFnyEM6Q6FCeSJpvhCXK/0BZJg90PICG4DcCy6D
         TzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694416018; x=1695020818;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BjkKRWZOJVa0TjkWXeagUayHJQ6YOMEruC33WrNwKSs=;
        b=oITUP/yqsiI8SJFMuSNoxhavBglaXHEIYgAdxBegeYi4fK87wDVAwgiLI2Jd2xAAeI
         H8bQEsGXxSai96CR0n48WIKg8m6qmcy+VEUHe+KgeVAySyCc0CAdeh7C62HPj0Ryz8EH
         Qvd5BFp8Ei1AzrhPx/7iw72ez4YeoARXvsDjJwuiZh1j38yD4kQYdECWc/WtOX5FbEPi
         yI5i/DZWRRVX7jZ+4vqJ1qc3ZAcdMcTF0KfPxA6FEnyBeA6xpVCL+gXPNC9ApPgEs0sY
         XQuVwnQuD3z2IpZMiEKKfMxWx4rfxM4FKV76U+hywph7FjeKffoKpnkrcE2kSqJw/8nD
         0LXw==
X-Gm-Message-State: AOJu0YwnTK6sapQktha+pNb47/krGdxUNg12pkHg+Fj1RXm+WfVeQ+nc
        F/yAjtziUTA+w2CWMeDeIKRjTQ==
X-Google-Smtp-Source: AGHT+IF75xWq2fgCjjeLMTUeemR7hwE6+rL8Au86+kLHDRAffyVeK9OvpXwGtMKr5jkQa92kCB450A==
X-Received: by 2002:a17:906:ef8b:b0:99b:4ed4:5527 with SMTP id ze11-20020a170906ef8b00b0099b4ed45527mr7377789ejb.25.1694416017794;
        Mon, 11 Sep 2023 00:06:57 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id z10-20020a170906074a00b0099293cdbc98sm4910558ejb.145.2023.09.11.00.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 00:06:57 -0700 (PDT)
Message-ID: <649e89c3-343a-c00c-ae89-329833b38981@linaro.org>
Date:   Mon, 11 Sep 2023 09:06:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] dt-bindings: arm64: dts: mediatek: add description for
 mt8365-evk board
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
References: <20230910062852.15415-1-macpaul.lin@mediatek.com>
 <f8864242-daa1-e72f-4759-aac3fa1bbcf2@linaro.org>
 <12bdd17a-98f4-5551-4253-229dc36f0c77@mediatek.com>
 <ef81697f-473e-898e-ec13-4dd255e2e3d7@linaro.org>
 <82a0ab25-a3cc-3e87-e379-9b15b3fbbf76@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <82a0ab25-a3cc-3e87-e379-9b15b3fbbf76@mediatek.com>
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

On 11/09/2023 08:34, Macpaul Lin wrote:
> On 9/11/23 14:09, Krzysztof Kozlowski wrote:
>> 	
>>
>> External email : Please do not click links or open attachments until you 
>> have verified the sender or the content.
>>
>> On 10/09/2023 14:07, Macpaul Lin wrote:
>>>
>>>
>>> On 9/10/23 17:09, Krzysztof Kozlowski wrote:
>>>>> +      - description: MediaTek Genio 350 Boards (Genio 350 EVK)
>>>>
>>>> That's a bit confusing. So all of the boards here will be Genio 350 EVK?
>>>> I don't get what is the point of this description.
>>>>
>>>>
>>>>> +        items:
>>>>>            - enum:
>>>>>                - mediatek,mt8365-evk
>>>>>            - const: mediatek,mt8365
>>>
>>> Thes boards with compatible 'mediatek,mt8365-evk' is indeed used by
>>
>> Boards?
> 
> I'm not sure if there will be more hardware version released to market.
> Current the p1v3 is the final version of mt8365-evk.

Then your code (enum) does not match description. The code is saying:
this is for multiple boards based on mt8365.

Your description is saying: this is only for 350 boards.

Now your email is saying: there is only one 350 board.

Three different versions. Sorry, I am confused.

> 
>>> Genio 350-EVK, which Baylibre helped to do upstream tasks. The only 
>>> production version of hardware will be available on the market. The 
>>> derived version of customer's hardware is not available yet.
>>>
>>> The separate patch for renaming mt8365-evk.dts file should be send next 
>>> week for aligning the naming rules.
>>
>> So the description is not correct.
>>
>> Anyway, this patch does not make much sense to me considering nothing
>> like this was merged. You just sent v5 doing the same!
> 
> 
> Sorry I'm confused now.
> These are independent patches.
> This patch is for SOC mt83'6'5 and board mt8365-evk, which is not relate 
> SOC mt83'9'5 and board mt8395-evk.

OK, I see my confusion. mt8365 and mt8395.

Still the description is not matching the code, at least to my limited
understanding of the description.


Best regards,
Krzysztof

