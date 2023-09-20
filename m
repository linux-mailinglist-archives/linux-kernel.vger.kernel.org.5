Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EBD7A8348
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbjITNJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236415AbjITNJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:09:35 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743DFB9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:09:20 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-530a6cbbb47so6218138a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695215358; x=1695820158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=270Wv+j/EwaXulOu1WjjWayYksd1Jqq5ecQjbVvwBS8=;
        b=z4LYhMZ+dAF2KXaevR327ucipQ9nHK0ng4vCY6bnpe6aQl0z7ByeWBuKn7zXDS47o/
         qjrKW2uXB3lVe8AFrsYufMtqh4KN0WCOH36n7pcwrOz+pFDf8qHiUKjy3IeTlY8taj8D
         yu2GWjP8PKJqgZfPLw575TdOW35yQ2lFFJwd/2YYVlk42XqxiL+9MqginwPPsiZ0aRtK
         CNLyfGIWs5OrcfMzwrCgVDqceCFFfthw0IJxzGMQVo1mFg85UHWiUUEYQxakcmRUpVRJ
         eTNzcijCLgUYMO17ancnaS9i07yh/fzwyn54qg3VBcIUAcWdQAU6Qw2aYhZKyrqaRviA
         4X+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695215358; x=1695820158;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=270Wv+j/EwaXulOu1WjjWayYksd1Jqq5ecQjbVvwBS8=;
        b=SRII1xOxtyc9JKaKo6EUha5mvWSRvHjmQ8xr5PWkUvipRYS4WxSMBqEhwwmOTsdKfB
         tTp13T0Sbo6umAgOV0zUhtDljdRG997y78X/Hr5DhTFkRr+sWmYfN2/0hxbXugrwXlLe
         AYLHsUm9c3Y721C2uNodGnhSru9cvp5AYeeuPQf5LUMEWbRg68C+eELGTxaXxNB3Pg3J
         Shu5B5s/eEDyggVAzIHfh4nSbmS4a5ePaw/lgEdTurQLgyomrGE7+CGLQ8Tfip+TyZUk
         sbX0FX0U+K8u8erY9XWyDmu5M/V3cm0zN/53DAmY07HzqiwAsUdSMf/Tyr7nYZnmhph8
         31Cw==
X-Gm-Message-State: AOJu0YzpWP/r7f3gXiFrtAR1TI8x4udDjNzEi18sxlyu58jdzGHZn0ZY
        rM3orYeKaidLnOgtysTHnUQJmg==
X-Google-Smtp-Source: AGHT+IH297j9ktrdQwrQLmNMBcLuT4NjDCohRQHwALOPnweXJcwlZz2yapKIbPE04mbFmOYfOuw6FQ==
X-Received: by 2002:a05:6402:b35:b0:52f:2a38:1f3 with SMTP id bo21-20020a0564020b3500b0052f2a3801f3mr2081318edb.2.1695215358664;
        Wed, 20 Sep 2023 06:09:18 -0700 (PDT)
Received: from [172.20.24.238] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id by6-20020a0564021b0600b0052a198d8a4dsm8786806edb.52.2023.09.20.06.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 06:09:17 -0700 (PDT)
Message-ID: <3172861a-4f13-363c-e3af-c7047899501b@linaro.org>
Date:   Wed, 20 Sep 2023 15:09:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 06/11] dt-bindings: timer: Add Sophgo sg2042 clint
To:     Conor Dooley <conor@kernel.org>,
        Inochi Amaoto <inochiama@outlook.com>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com,
        evicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Chen Wang <wangchen20@iscas.ac.cn>
References: <66b988f0-39fc-2ed3-8f38-151d6a3c9e52@linaro.org>
 <IA1PR20MB49536BFE1254ADEE0E795A26BBF9A@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20230920-8503c6365655d3ef3dadfd53@fedora>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230920-8503c6365655d3ef3dadfd53@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2023 14:58, Conor Dooley wrote:
> On Wed, Sep 20, 2023 at 08:40:07PM +0800, Inochi Amaoto wrote:
>>> On 20/09/2023 14:15, Inochi Amaoto wrote:
>>>>> On 20/09/2023 08:39, Chen Wang wrote:
>>>>>> From: Inochi Amaoto <inochiama@outlook.com>
>>>>>>
>>>>>> Add two new compatible string formatted like `C9xx-clint-xxx` to identify
>>>>>> the timer and ipi device separately, and do not allow c900-clint as the
>>>>>
>>>>> Why?
>>>>>
>>>>
>>>> If use the same compatible, SBI will process this twice in both ipi and
>>>> timer, use different compatible will allow SBI to treat these as different.
>>>> AFAIK, the aclint in SBI use the same concepts, which make hard to use the
>>>> second register range. I have explained in another response.
>>>
>>> What is a SBI? Linux driver? If so, why some intermediate Linux driver
>>> choice should affect bindings?
>>> Best regards,
>>> Krzysztof
>>>
>>
>> SBI (Supervisor Binary Interface) is defined by riscv, which is an interface
>> between the Supervisor Execution Environment (SEE) and the supervisor. The
>> detailed documentation can be found in [1].
>>
>> The implement of SBI needs fdt info of the platform, which is provided by
>> kernel. So we need a dt-bindings for these devices, and these will be
>> processed by SBI.
>>
>> [1] https://github.com/riscv-non-isa/riscv-sbi-doc
> 
> Yeah, this is the unfortunate problem of half-baked bindings (IMO)
> ending up in OpenSBI (which likely means they also ended up in QEMU).
> This T-Head stuff is coming across our (metaphorical) desks, so we are
> obviously going to try to do things correctly. I may end up speaking to
> Anup later today, if I do I will point him at this thread (if he hasn't
> seen it already).

If the OpenSBI started to work with some half-baked-bindings before
proper review, it's their loss. If we do not push back on such stuff,
how our review can ever matter?

Anyway, firmware/SBI/whatever parsing compatible twice is not really a
reason to model same thing with two different compatibles. Assuming of
course this is the same thing.

Best regards,
Krzysztof

