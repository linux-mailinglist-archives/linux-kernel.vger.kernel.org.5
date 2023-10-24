Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1CD7D4E4E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 12:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbjJXKzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 06:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbjJXKzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 06:55:00 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DAF10C6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 03:54:57 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32caaa1c493so3091611f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 03:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698144896; x=1698749696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gBjIA3JIo1sy3RNrJcAV6N9d4U3rcdnIefv5ozmPc9A=;
        b=OpIoz1Mx+isVH6wKqBhVZycmI8OhjaHCPvMd2YIalwrQvvXLVRoL8ONiVyWW75q69T
         WJUIVsaTFAu0KGurWkoJJDrSJEJ9QLCJujGwJ3/bWfEpb0IRTo+diWL0YIVffbs+WsYP
         coHhgb6fAEu9CJNgwxdC50eeYhsAHjDQELVJK+h6jQ7YN+gvF5w8e+Vc4tZD2yuiUvIO
         Nb9xcMWNIoAEt2mUuXolLMzXZdX8XHB2EMwbKA1a9cItJGYDeqBbcDu2gd0Xd+RdiCLY
         CJ5ELqURQfM3W9eGG4t19Yc/+SyGCncLVMlN4GI/0kJwQtxwOPReifTR0bNmiYIVHZju
         jNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698144896; x=1698749696;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gBjIA3JIo1sy3RNrJcAV6N9d4U3rcdnIefv5ozmPc9A=;
        b=vmzXPU1fHfbI1u/l5btDWNyuuznV25Tfb8AXCX5Oqz3vQ/ygUmnTs5L5ChKyyZx+CZ
         QSlaXYeaSL2qkgtVKbjW8AxOSCIRM1FTYngWu4PXzDfnqNUJKkferQZvGiHGesUEzZU0
         BVwsrZIzYDkHY76KnMAmv2/LRjo2yiw8fv6B/b1kPikv1coWHdPGuAP/+Kww++XeNfKJ
         f/qNGrMzS3ETXb/TOP2gOu7eZ6wPJXBLRV01wLLt4D1M1bZDt1kN4ZA2gV+h0Jw6sGCc
         0l/orGGIbyFadvuUMIH4yI7Bi7H6xawSrO30QQxsF9AZOn8nW/wthPBhegof67XR92ZG
         iklA==
X-Gm-Message-State: AOJu0YwmGtg21kPgSNZ6CGXmF8NRQK4y48iKNW4Qrkk2se/P4RBw7c6T
        mxW3XDfcbl/WALlWS2XOJzXeLQ==
X-Google-Smtp-Source: AGHT+IEIoCUddSBcnlQQLdnnNbyiMdjN0h2DsjSQPEvT41D9C5/jVn3Y3SRUs9EjNpIKK7a70ECbJA==
X-Received: by 2002:a05:6000:1741:b0:316:efb9:101d with SMTP id m1-20020a056000174100b00316efb9101dmr8646715wrf.25.1698144896276;
        Tue, 24 Oct 2023 03:54:56 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id a3-20020a5d4d43000000b003196b1bb528sm9640030wru.64.2023.10.24.03.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 03:54:55 -0700 (PDT)
Message-ID: <7018bf8b-1f89-408e-8649-3788a28f3b1a@linaro.org>
Date:   Tue, 24 Oct 2023 12:54:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] net: dt-bindings: Introduce the Qualcomm
 IPQESS Ethernet switch
Content-Language: en-US
To:     Romain Gantois <romain.gantois@bootlin.com>
Cc:     Rob Herring <robh@kernel.org>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>, netdev@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Andy Gross <agross@kernel.org>, davem@davemloft.net,
        thomas.petazzoni@bootlin.com, Paolo Abeni <pabeni@redhat.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Robert Marko <robert.marko@sartura.hr>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>
References: <20231023155013.512999-1-romain.gantois@bootlin.com>
 <20231023155013.512999-2-romain.gantois@bootlin.com>
 <169808266457.861402.14537617078362005098.robh@kernel.org>
 <35ec9e4b-21ee-1436-da00-02e11effdc23@bootlin.com>
 <550cba92-39dc-4e45-beb3-c714d14d9d85@linaro.org>
 <498ee025-b1b7-eafc-3758-993c5d564f67@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <498ee025-b1b7-eafc-3758-993c5d564f67@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2023 12:05, Romain Gantois wrote:
> On Tue, 24 Oct 2023, Krzysztof Kozlowski wrote:
> 
>> On 24/10/2023 11:54, Romain Gantois wrote:
>>> Hello Rob,
>>>
>>> On Mon, 23 Oct 2023, Rob Herring wrote:
>>>
>>>> pip3 install dtschema --upgrade
>>>>
>>>> Please check and re-submit after running the above command yourself. Note
>>>> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
>>>> your schema. However, it must be unset to test all examples with your schema.
>>>>
>>>>
>>>
>>> Even after upgrading dtschema to 2023.9, installing yamllint 1.32.0 and running 
>>> without DT_SCHEMA_FILES, I can't seem to reproduce this error. I've also tried 
>>> rebasing on v6.5-rc1 which didn't show it either. However, It seems like 
>>
>> v6.5-rc1 is some ancient version, so how can you rebase on top of it?
> I just cherry-picked this patch series on v6.5-rc1. I also tried v6.6-rc1. Since 
> Rob mentionned basing his series on rc1 in his last message, I inferred that he 
> compiled the dtb checks on the last kernel rc1, but maybe I misunderstood what 
> he meant. 
> 
>>
>> Which commit this is based on?
> 
> This patch series was based on:
> 
> 6e7ce2d71bb9 net: lan966x: remove useless code in lan966x_xtr_irq_handler
> 
> which was the latest commit in net-next/main at the time. Essentially, the patch 
> series is meant to be based on net-next.
> 

Ah, ok.

Rob's bot might be using not-yet-released dtschema from main branch,
thus the error. However the error is true: you added a custom field
without type. That's why I asked: where is it defined?

Best regards,
Krzysztof

