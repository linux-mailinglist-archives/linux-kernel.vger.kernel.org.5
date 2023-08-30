Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD06878D8B7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbjH3SbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245141AbjH3OfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:35:12 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9698C19A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:35:08 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bcf2de59cso750867366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693406107; x=1694010907; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HWEvSMgNacJqUkTieejzfG9YUtgYVDcl76TESgQKKR4=;
        b=fXoT+9vAMmL8/ramgzQkUNoMjGWwLV54SUJyCrrxE5FYpJa9edxgRiNkFI3rXg4ai5
         1meMnsFWXsUFENt6l5vtZlNvZsnBcPPUU5p3GKlETQ/sIocRBM+xN+Wxfs/abZmsHlhm
         Y5BmHTTBOno5UgJ1wDwuOLQOBKRH9r7bBuMFnVEbDeFh6Tg7mU+SO5DGXFxHhdo7fVdU
         isy1a5aYsO7Jg8B2dR7JfOhYuGj8AYg6B4Oh3EurO3AaBi9TqfzulWoRyR05sc4Xc579
         2zNBvzca/UbsqtamuRkeYhH0jFNw5lHx06mdF34XUwZKgtEvs+tuTWJTRqiQ/BLsohrP
         W8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693406107; x=1694010907;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HWEvSMgNacJqUkTieejzfG9YUtgYVDcl76TESgQKKR4=;
        b=UPVUk3GqwR+jrPZd4MgNlPbA3X9zPh4JhV3i9gocLu+PhZNPinSvKMS93GYY+4AmcN
         /F4DoqQ/CyaqvPOw+qboAABfJbsv9S1kHgPx2edOeIKc+3X4G9cqu6YsX07MEPOGqN5J
         /9KsRLRgoNdDlQIiimk8SoeyRutbGS/VzoKSx54F+WCxVg4JmUTCkeDRzmyqvq5bht+c
         +bkPOloJN9oHY3noGwjOPz8pyhTW6Nq3oOUfF2/7vWASTi9kSYA8WLdPojmREp8xNEHI
         msrfojaWSIRtBPkBb49QzPe+U72X+VyH8e7SMxGandRyj+P/ZRQ52mvhb4n2AjOBLgCG
         bmDQ==
X-Gm-Message-State: AOJu0Yyscs8ZeR66d/SYZV+BkyplXzGaRuAxFww+Lrr9IQrOLpHZRQV+
        vjYId0qcoTeI8tIbJHA9kpV+bw==
X-Google-Smtp-Source: AGHT+IG61XeRKRMr0t+dXqrDi4RK7A9HWvGFxAWqK1wi7P7kP2CltaFkStkaGLtj0eMm3le5F8DlFA==
X-Received: by 2002:a17:906:5301:b0:9a5:a247:5bbc with SMTP id h1-20020a170906530100b009a5a2475bbcmr1564429ejo.28.1693406107032;
        Wed, 30 Aug 2023 07:35:07 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id q22-20020a170906361600b0099bd6026f45sm7292611ejb.198.2023.08.30.07.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 07:35:06 -0700 (PDT)
Message-ID: <3412e871-ae2b-bed0-88fb-2272f9db3af0@linaro.org>
Date:   Wed, 30 Aug 2023 16:35:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: loongson,liointc:
 Fix warnings about liointc-2.0
Content-Language: en-US
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Binbin Zhou <zhoubb.aaron@gmail.com>
Cc:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, devicetree@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, diasyzhang@tencent.com,
        linux-kernel@vger.kernel.org
References: <20230821061315.3416836-1-zhoubinbin@loongson.cn>
 <e62185ca-cdf6-bde9-ad46-f4150db9ed6d@linaro.org>
 <CAMpQs4JhfuB4=s9VFc+xmw_+8h5u2EwPdM_0x2vO_=SYabAAxw@mail.gmail.com>
 <6ba31912-6738-6156-d5f4-3c8d3a3ca7bc@linaro.org>
 <CAMpQs4+GiExt9uMmV1pf8gg8rFwWxbLkx9mdW7hY9xxXDOza3Q@mail.gmail.com>
 <d11873a1-b552-71f5-1100-7464687f8bb4@linaro.org>
 <a084e6e9-46b0-42ef-b500-69c114ae11b2@flygoat.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a084e6e9-46b0-42ef-b500-69c114ae11b2@flygoat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2023 05:59, Jiaxun Yang wrote:
> 
> 
> 在 2023/8/25 20:56, Krzysztof Kozlowski 写道:
> [...]
>> How did you sneak this property? The version - v2 - which was reviewed
>> by Rob:
>> https://lore.kernel.org/all/20190905144316.12527-7-jiaxun.yang@flygoat.com/
>> did not have it.
>>
>> Now v3 suddenly appears with Rob's review and this property:
>> https://lore.kernel.org/all/20200112081416.722218-4-jiaxun.yang@flygoat.com/
>>
>> Please help me understand this property appeared there and how did you
>> get it reviewed?
> Hi all,
> 
> It has been some years since this series was merged.
> My vague memory tells me there was some off-list discussion made in IRC with
> linux-arch folks and IRQ folks to come up with this binding design.

We would not suggest you property which in the name has underscores and
duplicates interrupt-map property.

> 
> In this case I guess I forgot to drop Rob's R-b tag when updating this patch
> between reversions. I  apologize for any inconvenience this may have caused.


> 
>>
>>>                                                  <0xffffffff>, /* int1 */
>>>                                                  <0x00000000>, /* int2 */
>>>                                                  <0x00000000>; /* int3 */
>> So now you will keep bringing more hacks for a hacky property. No, this
>> cannot go on.
> 
> What's the best way, in your opinion, to overhaul this property? As we don't
> really care backward compatibility of DTBs on those systems we can just 
> redesign it.

Deprecate the property in the bindings, allow driver to work with or
without it and finally drop it entirely from DTS.
> 
> A little bit background about this property, LIOINTC can route a 
> interrupt to any of
> 4 upstream core interrupt pins. Downstream interrupt devicies should not 
> care about
> which pin the interrupt go but we want to leave a knob in devicetree for 
> performance
> tuning. So we designed such property that use masks corresponding to 
> each upsteam
> interrupt pins to tell where should a interrupt go.


Best regards,
Krzysztof

