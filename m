Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7337743FC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjHHSOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbjHHSOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:14:02 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A006574AE2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:19:41 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99c93638322so13685966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691515179; x=1692119979;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6UQwIyuye8mYS0km2qczmsMo0G4UsG0TMMEf3YJ5cAk=;
        b=JUSFCrEIpTfNvOMEa49N7Dy9hsxrZY4z8VghqVRotvCENVvzlHS9drdidc/PTm6ERR
         BcWKASzGGUg+24QPWD0hhYPlxFmcRlhMNFx+7zixtkpzARMDsP0h5MmYP070wYdp1bfm
         3GVv9u7esmw6+w8nxQsZX3n8dpfgYjEcmcfeWoo4Nd8k6Z590aLCOeza3PYYHxiOZUQw
         Ke4XysHe4uKVMkC1ItlvDRJFaN6YuNb+VtQ+KlVSsuIN+2+iZYjlzcqxTvGfMv97P0Vk
         i/dBiEUVSgPJpa7v8vKIBoDfNCKHeTrZbKIVTy/BuJ8C1UKBV2WE4kINa1g8OxXKXiwm
         Fiiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691515179; x=1692119979;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6UQwIyuye8mYS0km2qczmsMo0G4UsG0TMMEf3YJ5cAk=;
        b=T1PTDVSGXMjw7tNR05YXDW7lAIJQLZp2UVyoIGWB2mvV0BGH2WMLbeswOQTnprTI84
         ow/FIZS5dS4EgGRvV3lnzLYAt6GNH3j6EOa1NkFJij6vDgRREhdPTAn+6dCU0nHJyCiO
         9SPzSPcJIcsTM+v2iC2YWdwg8QRa+/dLU1FzhblB9+k8YeejKNmgQEXEtd8Y49jLAies
         4BCF81k/tzY3Dgx9H6WhbVNZVK83m1jRzLTmKz5lVfBXuoGJirxDcN6buWimHTJiIupw
         eaf/Awg/syn4Qdvq3t0rahuUP3JGUIGIwFNqDEJgcb4noSe8GT5/tBIeLtFECtvBITa8
         0ybA==
X-Gm-Message-State: AOJu0Yzii4vtZgObD69KaSvhxy4g34ZMKzGxFJ5OuBjBtnjoR/CFkfW0
        2Iht22n+O78BIRa5XF5ZMTvIGS3KHcI7jMWTX6A=
X-Google-Smtp-Source: AGHT+IEAWtqj6IGMQaxg9T1mvEziRnQ63AxagirqrvclWjlQA6LYi5Gwjfcee2RpFhk/TpTKnyzDKg==
X-Received: by 2002:a5d:5265:0:b0:317:5dcc:b7d4 with SMTP id l5-20020a5d5265000000b003175dccb7d4mr7125084wrc.33.1691490380266;
        Tue, 08 Aug 2023 03:26:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id d18-20020adffbd2000000b003176c6e87b1sm13123307wrs.81.2023.08.08.03.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 03:26:19 -0700 (PDT)
Message-ID: <d8e79173-1f73-0ae1-f698-90cd551dde1a@linaro.org>
Date:   Tue, 8 Aug 2023 12:26:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] dt-bindings: media: Add bindings for Imagination E5010
 JPEG Encoder driver
Content-Language: en-US
To:     Devarsh Thakkar <devarsht@ti.com>, mchehab@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     praneeth@ti.com, nm@ti.com, vigneshr@ti.com, a-bhatia1@ti.com,
        j-luthra@ti.com, b-brnich@ti.com, detheridge@ti.com,
        p-mantena@ti.com, vijayp@ti.com
References: <20230726162615.1270075-1-devarsht@ti.com>
 <b6bddd59-ac78-3f75-828e-cff54766fc72@linaro.org>
 <8fef77fb-d3bf-eab1-0734-919ebf2e61af@ti.com>
 <50d97c30-4926-0bbf-1209-dfd25043e359@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <50d97c30-4926-0bbf-1209-dfd25043e359@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2023 12:20, Devarsh Thakkar wrote:
>>>> +properties:
>>>> +  compatible:
>>>> +    const: img,e5010-jpeg-enc
>>>
>>> Your description suggests that this is part of TI SoC. Pretty often
>>> licensed blocks cannot be used on their own and need some
>>> customizations. Are you sure your block does not need any customization
>>> thus no dedicated compatible is needed?
>>>
>>
>> There is a wrapper for interfacing this core with TI SoC, I will recheck this
>> interfacing but I believe nothing changes from programming perspective as
>> there is 1-to-1 maintained between the clocks and signals w.r.t actual E5010
>> core.
>>
> 
> Just to add to above, on a second thought we think it would be  better to
> still have a separate compatible for TI as you suggested (since we have a
> wrapper) so that it allows any customization needed for future. So compatible
> enum would look like :
> 
>     oneOf:
>       - items:
>         - const: ti,e5010-jpeg-enc
>         - const: img,e5010-jpeg-enc
>       - const: img,e5010-jpeg-enc
> 
> Thanks for the suggestion.

Yeah, it's fine, assuming block can be used as img,e5010-jpeg-enc on its
own.

Best regards,
Krzysztof

