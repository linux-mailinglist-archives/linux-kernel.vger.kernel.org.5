Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3C475ADBB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjGTMCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjGTMCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:02:45 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE6310F5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:02:43 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbab0d0b88so11822705e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689854562; x=1690459362;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4mVNLMpsr1KtXrPPiYyd6fMKyNfmqypKKGtmUwwbo1s=;
        b=Ru776Nvt3yRM/Id4yJqBSMOIMMRox1ohJl228qwtuRlY7Z9Ds7hcbx++Eg/mZjULXg
         Vlbo7Dj/QyrE0PKRKzeuGhFLqR0u0A8EoEKAd0VknDWIgk0dit+0/1KtPmxC24TROnEv
         tIUiBEAQgDBTls6DjHiUaIuxj9sckC6VGVoYz7GlGO0UlXA6m9Bo1CkVTQFOVo6cviWb
         wRagJAakNX8D54z2sgC0IiD8qxQBEg7iu9iDxdkqwzCZp1FASPAqFGq6mj0TCEZBL2wM
         89ixhK3hHIptelHiMKP/rnC3AyTYgokdlou9nuoKkvrK6cGj1H8bHp7S4ZgJoNMfHCa9
         7aCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689854562; x=1690459362;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4mVNLMpsr1KtXrPPiYyd6fMKyNfmqypKKGtmUwwbo1s=;
        b=HW998UcQ/51L/ee5IMv85NeRN/2eXjT/tQXyanzQTy/zhCXhaq+rgjSlfcfUmuB29x
         gWD8OE/PZ5f7LxGfeXkqlPuPZDQEv7jYx8UmnCqH7DkvH/mtatmaDVhrfEAMLIsAIewa
         YSTCWud+vPiGLVOCz1VEL2paKUBXtsrLE09wMUhr8hzNaN4n3SdSFBMc9Y2sJ6fRsKuQ
         xXGSYIOE3MX30XWiehrw1S9HqWbcrv6GpcR2w2KHJ/Fd7kHsq/gfbiYnBoR+a3Jl1Lq9
         iBiYbe/4+SJuj8PKcNVyoAy8X/XHNb3HEaje2Tyj9tQ0No8Bs1yiu5KuAkWH3XQ0MCg4
         YSpA==
X-Gm-Message-State: ABy/qLYk2QVErThFszxnoszeiZJhY+lE6ukFLdW70SjZJ4SllQNmvbEd
        dxgT1XbGq4tB/36d4/fHFvMimw==
X-Google-Smtp-Source: APBJJlE5/EGARCmArGxUZUpUjd94gNv62IZomso69Wj7PlLRXdVNWS6mN9JA2NEzdednqnnEnvDfbQ==
X-Received: by 2002:adf:f88d:0:b0:316:fc03:3c66 with SMTP id u13-20020adff88d000000b00316fc033c66mr2168789wrp.3.1689854562194;
        Thu, 20 Jul 2023 05:02:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600001cd00b00316eb7770b8sm1164458wrx.5.2023.07.20.05.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 05:02:41 -0700 (PDT)
Message-ID: <85d14351-9b5a-a488-c1c9-ac2f1e28eeef@linaro.org>
Date:   Thu, 20 Jul 2023 14:02:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] dt-bindings: input: convert syna,rmi4 to DT schema
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Vincent Huang <vincent.huang@tw.synaptics.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230720110008.133359-1-krzysztof.kozlowski@linaro.org>
 <ZLkYWL4wMhYLRTuL@zx2c4.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZLkYWL4wMhYLRTuL@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2023 13:19, Jason A. Donenfeld wrote:
> On Thu, Jul 20, 2023 at 01:00:08PM +0200, Krzysztof Kozlowski wrote:
>> Convert the bindings for Synaptics RMI4 bus and devices to DT schema.
>> Changes during conversion:
>> 1. Add reset-gpios already used in DTS and mentioned by RMI4
>>    specification.
>> 2. Do not require address/size cells, because without functions
>>    (children) they aren't really needed.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Jason, Matthias, Vincent,
>> I put your names as maintainers, because moderately recently you were
>> changing the driver. Let me know if this is okay or you prefer not to
>> maintain the hardware.
>  
> I'm more of the occasional "why doesn't my new Thinkpad work?" sort of
> drive-by RMI4-er, rather than an actual maintainer. I don't know a lot
> about the protocol beyond what it takes to drag a laptop into behaving
> right. So maybe best to leave me off the list.

If you have hardware with it and you are interested in this device
working, then it is good enough.  This is maintainership only of the
bindings, not entire driver.

Best regards,
Krzysztof

