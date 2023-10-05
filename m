Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D97A7BA51A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241190AbjJEQNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240390AbjJEQMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:12:19 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CFC24E90
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 04:27:29 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-533f193fc8dso1432070a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 04:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696505248; x=1697110048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v36wx9Pk64n53fIg/6A0WMF6jR/YhJkuHYrw/KUTl6k=;
        b=Kf/dZ1QtITz+yuoa0l3mL33bdwPG9sRU4elNZqn8RvRYVxR07Qm5ok22B13lGigzuj
         wfEMd8iTVnLrObpOcaVlRe5hNq8xt0nRD8tUUri9LP6cxMKrjMzGvXyfjsmWPT/kcInj
         qVhlisVdUqupM6nnOypCP4OPMR1Hf6/arv/KiP22ETmR+bd8ZUzIR1+Csjm2Z3odib4H
         mtmmqY1N1xB54LoGoz888V0VEKmxQmRjbEXdjL1tG6y2W++MutTVrOeC6hkw7oBS0gjT
         /T6QtCXW5ioAQffN8+/n6XJ6Hq3PZZL/nLJ1N0n3RdnpZONepJQ8Pji6TSDKFocq7NkD
         ppAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696505248; x=1697110048;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v36wx9Pk64n53fIg/6A0WMF6jR/YhJkuHYrw/KUTl6k=;
        b=b9rEQLT2ftDEO01Vb5DMIGXzwht7vRUbgkzaby/Vlpx31kZh+iqGIPLlTCOtL6T3la
         91azviJjiURMyYbPFzJHxgyaOs+hZzpCy2PAT5y0TzyD8kteo+CpZzJkaOmGDr68uZAH
         zWdCwa3TAvxj16omRRX8apuB2aTlTy5T4pW2ahGTa0TyWYqj3hR9cefi/GZHXYK5MTTN
         M8usHi8HVssM/9OGwfvtMyJ8PUOv94ObFNHYoiWRALwCua4rpl8dovhlO0zAOQTCPKZO
         xlpVwC34Lv5cWSFd7W7Wz33xZfGXbP2Fd+gaxbcVZ+yDUzP0pnVKizefOp6pNqen0tmw
         qsGQ==
X-Gm-Message-State: AOJu0YxUaCZpWQ+gOQgRQj/52wd8g2B/ch2eLH3LlNA7Z6A4ZTW517PG
        tgD7GEIcThWOcU04a6vB+y5eKg==
X-Google-Smtp-Source: AGHT+IH5sTt0UC8bfVW5JJhNwhjYB38ckB3QAE2oyGcpN6Y52pD844+c/uZe7G0bj2x75kqsUvspCg==
X-Received: by 2002:a05:6402:4025:b0:531:1f3b:cb36 with SMTP id d37-20020a056402402500b005311f3bcb36mr5316270eda.9.1696505247836;
        Thu, 05 Oct 2023 04:27:27 -0700 (PDT)
Received: from [192.168.1.197] (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id w24-20020a50fa98000000b00532bec5f768sm915596edr.95.2023.10.05.04.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 04:27:27 -0700 (PDT)
Message-ID: <aa7aab2b-6e9a-4055-b9c7-9edc27556bd7@linaro.org>
Date:   Thu, 5 Oct 2023 13:27:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] dt-bindings: usb: ci-hdrc-usb2: add npcm750 and
 npcm845 compatible
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     peter.chen@kernel.org, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        xu.yang_2@nxp.com, peng.fan@nxp.com, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, j.neuschaefer@gmx.net,
        openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20231003110130.229711-1-tmaimon77@gmail.com>
 <20231003110130.229711-3-tmaimon77@gmail.com>
 <25e8c953-8bf1-4107-9531-263d68c41128@linaro.org>
 <CAP6Zq1gwbYfE4xg0-TCC+Wfoo_1omdsWukupJqpZekMem0xeMA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAP6Zq1gwbYfE4xg0-TCC+Wfoo_1omdsWukupJqpZekMem0xeMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2023 12:46, Tomer Maimon wrote:
> Hi Krzysztof,
> 
> Thanks for your comment
> 
> On Wed, 4 Oct 2023 at 11:03, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 03/10/2023 13:01, Tomer Maimon wrote:
>>> Add a compatible string for Nuvoton BMC NPCM750 and Nuvoton BMC NPCM845.
>>>
>>> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>>> ---
>>>  Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
>>> index 1394557517b1..a9e173432002 100644
>>> --- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
>>> +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
>>> @@ -16,6 +16,8 @@ properties:
>>>        - enum:
>>>            - chipidea,usb2
>>>            - lsi,zevio-usb
>>> +          - nuvoton,npcm750-udc
>>> +          - nuvoton,npcm845-udc
>>
>> Your driver clearly suggests these are compatible. If they are not, why
>> commit msg does no explain anything here?
> Do you mean to add nuvoton,npcmxxx-udc as described below to the end
> of the compatible property?
>       - items:
>           - enum:
>               - nuvoton,npcm845-udc
>           - const: nuvoton,npcm750-udc

For the 845 yes. Of course you also need enum entry for 750.

Best regards,
Krzysztof

