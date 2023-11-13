Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C0B7E9DBF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjKMNtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjKMNtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:49:33 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B0DD4E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:49:29 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a7fb84f6ceso44952257b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1699883368; x=1700488168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NYpuCEau1tKn7+UB1fO/FAD7Mu4SsuLXPkxhTi6wqWY=;
        b=GPWR57klPdcde2As80V84A59qZJ6s2fVjltLqM4Klg97+IJHaAxM1DzlTlo3xDrn6v
         ZM9VafYqGvCa4KZLaxf0xIx83IOyjX2Mc2902VeRzUo7fT6yYB6fe9Y/p9IYyjIpwyGc
         /ZbEhS/S9SKu210fA0ei/oGX071rIREs5cJ/9oW9LTH387U/VB0kbwihC/5SGVlvbBOa
         qWV7LXlwqC2ebbiatuyQSxaT4azYx1zPHx5FU1REh9L0EuWFVyQn1fhAVuUjlYkdxX2n
         WJ/wyQRiwYkuMUibumyR1YIbdYD7rV02cINHdv1U4GxGLm/6iStuj5kb63tigT1oe2qZ
         eCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699883368; x=1700488168;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NYpuCEau1tKn7+UB1fO/FAD7Mu4SsuLXPkxhTi6wqWY=;
        b=nVW4oSV1gWSf1IW0CCDtKnkOhVaYdOc4A1TB/MuKunZhe6u387XruJyFudd1TZxUgc
         nrXanhM/wt6T9lg+QgKFPbMCM+fpblK7ZpvZN+z9Z1yJCjGK8pLQbM4v3NV+gJwNDMcX
         n7LlYKyFksRSagzEgrLwbSZZwCLrNdNnbtPFcXjO660bottJbPXtywdFZosL2FCERWD1
         IYrF/ehQXsV6MUhpt4JE9K1veSTREn1nDmTXERYAsdY3bLEYn5uGLNANpcUAFm+i9ghP
         O9omPKw+a79irICU6PrdMM2tIn1MrzTX8ZfM7emPXQiYxTr9uxWEoI3/6hBxDLYU3egk
         P2LQ==
X-Gm-Message-State: AOJu0YzbSIMpvlLp9qC3PMR9EeyXhF91YvTW1rGOmyNiZS5pbhdYTmco
        BTiXoaE7MJLF9qTz3GlmzZiICA==
X-Google-Smtp-Source: AGHT+IHZ/t0JIdIrzY/Nm2LAWZjGdMgD8dn4JMNbHzzhWh5JSt4geynVCnSMFpNdMwKJepJUA1oVbg==
X-Received: by 2002:a25:1e83:0:b0:da0:cb34:1644 with SMTP id e125-20020a251e83000000b00da0cb341644mr3741569ybe.21.1699883368209;
        Mon, 13 Nov 2023 05:49:28 -0800 (PST)
Received: from [172.25.81.170] ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id z8-20020a0cfec8000000b00677a12f11bcsm2052439qvs.24.2023.11.13.05.49.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 05:49:27 -0800 (PST)
Message-ID: <40f003c9-a94b-4ded-b35b-be4985aba3a2@sifive.com>
Date:   Mon, 13 Nov 2023 08:49:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] riscv: dts: cv1800b: add pinctrl node for cv1800b
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>, Jisheng Zhang <jszhang@kernel.org>
Cc:     Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>
References: <20231113005702.2467-1-jszhang@kernel.org>
 <20231113005702.2467-2-jszhang@kernel.org>
 <58a99001-8260-4970-9fc7-25fe81e557a5@sifive.com> <ZVIejw2O6on8QMYy@xhacker>
 <20231113-mama-underarm-a8bbf0c2a1f1@squawk>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20231113-mama-underarm-a8bbf0c2a1f1@squawk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On 2023-11-13 7:29 AM, Conor Dooley wrote:
> On Mon, Nov 13, 2023 at 09:03:11PM +0800, Jisheng Zhang wrote:
>> On Sun, Nov 12, 2023 at 08:51:20PM -0500, Samuel Holland wrote:
>>> On 2023-11-12 6:57 PM, Jisheng Zhang wrote:
>>>> Add the reset device tree node to cv1800b SoC reusing the
>>>           ^^^^^
>>>           I assume you mean pinctrl here?
>>
>> oops copy and paste the commit msg ;) thanks
>>>
>>>> pinctrl-single driver.
>>>>
>>>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>>>> ---
>>>>  arch/riscv/boot/dts/sophgo/cv-pinctrl.h | 19 +++++++++++++++++++
>>>>  arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 10 ++++++++++
>>>>  2 files changed, 29 insertions(+)
>>>>  create mode 100644 arch/riscv/boot/dts/sophgo/cv-pinctrl.h
>>>>
>>>> diff --git a/arch/riscv/boot/dts/sophgo/cv-pinctrl.h b/arch/riscv/boot/dts/sophgo/cv-pinctrl.h
>>>> new file mode 100644
>>>> index 000000000000..ed78b6fb3142
>>>> --- /dev/null
>>>> +++ b/arch/riscv/boot/dts/sophgo/cv-pinctrl.h
>>>
>>> A couple of questions: Should this go in include/dt-bindings? And is it worth
>>
>> When I cooked this series two weeks ago, I did put it in dt-binding, but
>> then I found commit fe49f2d776f799 ("arm64: dts: ti: Use local header for
>> pinctrl register values"), "These definitions were previously put in the
>> bindings header to avoid code duplication and to provide some context
>> meaning (name), but they do not fit the purpose of bindings." which is
>> suggested and acked by Krzysztof, so I just want to follow the style
>> here.
>>
>>
>>> including macros for the actual function mappings, like in the vendor source[1]?
>>
>> Do you want something as the following?
>>
>> #define UART0_TX	0
>> #define CAM_MCLK1	1
>> ...
>>
>> #define REG_UART0_TX	0x24
>> ...
>>
>> pinctrl-single,pins = <REG_UART0_TX UART0_TX>;
>>
>> Other pinctl-single users just uses the register value directly, I have
>> no preference. But I'd like to get suggestions from DT and pinctl-single
>> maintainers. Hi Rob, Krzysztof, Conor, Tony, what's your opinion?
> 
> Basically, if the definitions map directly to registers and are just
> used to make writing your devicetree easier then they do not belong
> in a binding. This differs from clock or reset indices, where we
> essentially make up a set of indices that may or may not correlate to
> offsets in the hardware as using the register values without any sort of
> abstraction is not defining an ABI.

Right. I should have remembered this policy :)

Regards,
Samuel

