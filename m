Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D40C7CF12D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344745AbjJSH0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjJSH0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:26:47 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578A4112
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 00:26:44 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6bbfb8f7ac4so1075526b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 00:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697700404; x=1698305204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wgTcFnd2WuQ3b93x6mtXxA5MmL51CRaK2ux9aDnBicU=;
        b=ALgjGUGVojPdKw06M7V19ORNMHqFpjA1hO9W+3LMyeQym7l7C94maxnHf2Z7AoB4/Q
         O2cHH3+hGhxUecr0INsYtr2w7u/f9lPLywibkhBH8WlaAGBp4TBy/pK6JLZf1JPzbTRH
         kLb1o5T0fErCDrFFnBdfwlLYb20q1qVMczrxHzjQtFDnRdlqyogygvyGOS9PFcesXU4U
         MZHX+ZBRvP7VFTXFyL6NRf9ZwlEPJO1i9SEwnFdQpIeClYhdaLRD6JvHQVuP/h3sqywf
         4fIu8+0DRMFDjVxxySHqhGMaukYuUMj8iFV+WPVUHAMe/GqaBEqDgQI05jO5xr3RLT1G
         cj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697700404; x=1698305204;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wgTcFnd2WuQ3b93x6mtXxA5MmL51CRaK2ux9aDnBicU=;
        b=Ia8NQSEXKxv79VtbudxqZCo3KVhqJmZrmwrtGYGPJTWnnPwqcVBEOlIdsPo0B+jcym
         iJptkivzb1RqrlzORJnaj2D7r9Eny/N+ObMkEi5NDtqUyKsRDIOVyVZJPIEyodbr5L4z
         CZn11dfcSWQAhdUarS6qtiyZ1mkHtBToY0wTsMkJ00cYtyZ83tvnDkj+RrE0XCymTRY3
         1cuwaYM8AoZMkfXyGvvYq8JU8PEb/FMubtIeZ+xXEbkFf/ykZ5hNDOro+Ogvdb/DyIfm
         XmfdoNPAsJ7/SDS4DsANLuw0HZGs40Fpi0dkvsHRXftC0FsLj7ChfnV+Lx1tZM8EPfj2
         0Ibw==
X-Gm-Message-State: AOJu0YxdV+lT3V4TWYeX4Kr0mi3v510Weq83tPrlQWQhE86PEsYObGmP
        2OzYv1hrp/jiZ0dn7UaLxMttsKQSDIitCaXhWzqbSA==
X-Google-Smtp-Source: AGHT+IHBolW3gGracNxmsGlk+qzVRPdVEtKUfRfRdsaXZ4nG07zJsUHKMW68cjsZuxWvQXGUOxGzrQ==
X-Received: by 2002:a62:b613:0:b0:6bc:67ca:671d with SMTP id j19-20020a62b613000000b006bc67ca671dmr1233298pff.1.1697700403743;
        Thu, 19 Oct 2023 00:26:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:6933:1fe3:b858:3dde? ([2a01:e0a:999:a3a0:6933:1fe3:b858:3dde])
        by smtp.gmail.com with ESMTPSA id g7-20020aa79f07000000b00693411c6c3csm4455829pfr.39.2023.10.19.00.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 00:26:43 -0700 (PDT)
Message-ID: <844f6f35-3125-4014-852c-9ad7aee19ddc@rivosinc.com>
Date:   Thu, 19 Oct 2023 09:26:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/19] riscv: hwprobe: factorize hwprobe ISA extension
 reporting
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>, Evan Green <evan@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Samuel Ortiz <sameo@rivosinc.com>
References: <20231017131456.2053396-1-cleger@rivosinc.com>
 <20231017131456.2053396-2-cleger@rivosinc.com>
 <CALs-HssL=wNwj9nRuZwpZhy1CB9p9-X=OqgwBw9zvgA7hA4fEg@mail.gmail.com>
 <20231018-scrap-bankable-a0f321d97a46@spud>
 <20231018-flagpole-footpad-07a6228485f3@spud>
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20231018-flagpole-footpad-07a6228485f3@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/10/2023 19:36, Conor Dooley wrote:
> On Wed, Oct 18, 2023 at 06:33:34PM +0100, Conor Dooley wrote:
>> On Wed, Oct 18, 2023 at 10:24:15AM -0700, Evan Green wrote:
>>> On Tue, Oct 17, 2023 at 6:15 AM Clément Léger <cleger@rivosinc.com> wrote:
>>>>
>>>> Factorize ISA extension reporting by using a macro rather than
>>>> copy/pasting extension names. This will allow adding new extensions more
>>>> easily.
>>>>
>>>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>>> ---
>>>>  arch/riscv/kernel/sys_riscv.c | 32 ++++++++++++++++++--------------
>>>>  1 file changed, 18 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
>>>> index 473159b5f303..e207874e686e 100644
>>>> --- a/arch/riscv/kernel/sys_riscv.c
>>>> +++ b/arch/riscv/kernel/sys_riscv.c
>>>> @@ -145,20 +145,24 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
>>>>         for_each_cpu(cpu, cpus) {
>>>>                 struct riscv_isainfo *isainfo = &hart_isa[cpu];
>>>>
>>>> -               if (riscv_isa_extension_available(isainfo->isa, ZBA))
>>>> -                       pair->value |= RISCV_HWPROBE_EXT_ZBA;
>>>> -               else
>>>> -                       missing |= RISCV_HWPROBE_EXT_ZBA;
>>>> -
>>>> -               if (riscv_isa_extension_available(isainfo->isa, ZBB))
>>>> -                       pair->value |= RISCV_HWPROBE_EXT_ZBB;
>>>> -               else
>>>> -                       missing |= RISCV_HWPROBE_EXT_ZBB;
>>>> -
>>>> -               if (riscv_isa_extension_available(isainfo->isa, ZBS))
>>>> -                       pair->value |= RISCV_HWPROBE_EXT_ZBS;
>>>> -               else
>>>> -                       missing |= RISCV_HWPROBE_EXT_ZBS;
>>>> +#define CHECK_ISA_EXT(__ext)                                                   \
>>>> +               do {                                                            \
>>>> +                       if (riscv_isa_extension_available(isainfo->isa, __ext)) \
>>>> +                               pair->value |= RISCV_HWPROBE_EXT_##__ext;       \
>>>> +                       else                                                    \
>>>> +                               missing |= RISCV_HWPROBE_EXT_##__ext;           \
>>>> +               } while (false)
>>>> +
>>>> +               /*
>>>> +                * Only use CHECK_ISA_EXT() for extensions which can be exposed
>>>> +                * to userspace, regardless of the kernel's configuration, as no
>>>> +                * other checks, besides presence in the hart_isa bitmap, are
>>>> +                * made.
>>>
>>> This comment alludes to a dangerous trap, but I'm having trouble
>>> understanding what it is.
>>
>> You cannot, for example, use this for communicating the presence of F or
>> D, since they require a config option to be set before their use is
>> safe.
> 
> Funnily enough, this comment is immediately contradicted by the vector
> subset extensions, where these CHECK_ISA_EXT() macros are used wrapped
> in has_vector(). The code looks valid to me, since has_vector() contains
> the Kconfig check, but does fly in the face of this comment.

Yes, the KConfig checks are already done by the headers, adding #ifdef
would be redundant even if more coherent with the comment. BTW, wouldn't
it make more sense to get rid out of the unsupported extensions directly
at ISA string parsing ? ie, if kernel is compiled without V support,
then do not set the bits corresponding to these in the riscv_isa_ext[]
array ? But the initial intent was probably to be able to report the
full string through cpuinfo.

Clément

> 
>>
>>> Perhaps some rewording to more explicitly
>>> state the danger would be appropriate. Other than that:
>>>
>>> Reviewed-by: Evan Green <evan@rivosinc.com>
> 
> 
