Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605FC7FDCE7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjK2QWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjK2QWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:22:48 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DDD10A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:22:54 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40b2a628c25so5619575e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701274973; x=1701879773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=roHW8B0kGVQi7v3u5rXDrRfq0dqjl02SvhNdMtM5u1Y=;
        b=yuS+xXqNvfBJ0kTlmWbw/s/lsNqFJDNB04gSWmVboITVANh+Zyv9ANbPJgxyml0GtL
         QcL8AFqIMjoTMa31Izqud4ybK+X7QXPIs/8Daw34Nz1/NiphTpgIpblexPR5NlS+Vh0g
         ACMT+gnetJKlfQpD9d9RAIsj55rIgH5yxSARni23HDfv6jweR9/TXfPzr7re4DvlCMeS
         /DL9AzCulcPMCu5KhfBShvaD9S4N7VoG3exfvvOye7asfPgJ7kvQz+5iTdOcMRIJGKve
         bWbEiqnHCI3+G7/8nK8zxojol5+F2c+pu/g3Z+zHzVZCM9knZZpF50UymULho2GEB1me
         /7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701274973; x=1701879773;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=roHW8B0kGVQi7v3u5rXDrRfq0dqjl02SvhNdMtM5u1Y=;
        b=I7EKNbe1AIyLjMSA2bA9evl8nPmJsKBSiScpezDI4cX28unCNOgx60PjpORBadfWXs
         2ND6//1DzHfeiIZv85POSa8x8yDtJ7eNKWF1SflrnpEiX2VG6zGyHVZemxKWD9yd8nLk
         qcvqgJzNPu+luvdr2nXuOAnXe8JUAXRa7PVP3Um49wvzXHPsH0gn6O616eBMoGhyUg61
         F+sOgDJ9lDDDaos/sK0irW4gc3zluE6xfz/JbODS5TZ0xf1DM8rkD9m3y53Td6PnkTmA
         8lRw4qWrxQGLLc2Nvt8lIaPgKME/qltdMXmCbYy7R7NTHRO3HxsiLze+tg3Rf4wAZUlo
         jt7Q==
X-Gm-Message-State: AOJu0Yzo9bKo4VVCq44PMgB7ucPWowub7xQRWl6KTpxxriKh3GjlvDN1
        eLWSUcNUMj+ZSJgVEX34tOMllQ==
X-Google-Smtp-Source: AGHT+IHTXDyYM7XpEJ2XOUVTrvwcppAZpJsj+SvZ6k6SHb/GzwKbtcTUwskr31NgpgLj4swFKUUmDA==
X-Received: by 2002:a05:600c:2219:b0:40b:4889:667e with SMTP id z25-20020a05600c221900b0040b4889667emr5939341wml.4.1701274972623;
        Wed, 29 Nov 2023 08:22:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:999:a3a0:11a9:3d89:528b:b336? ([2a01:e0a:999:a3a0:11a9:3d89:528b:b336])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c4f8a00b004053e9276easm2717649wmq.32.2023.11.29.08.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 08:22:52 -0800 (PST)
Message-ID: <9a54fbb3-c4cc-4f94-8df5-38b40f3f91f2@rivosinc.com>
Date:   Wed, 29 Nov 2023 17:22:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RISC-V: Implement archrandom when Zkr is available
Content-Language: en-US
To:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Samuel Ortiz <sameo@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>
References: <20231129160325.1119803-1-cleger@rivosinc.com>
 <2feb3ff4-3d26-41f7-83f5-6440393d6e43@codethink.co.uk>
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <2feb3ff4-3d26-41f7-83f5-6440393d6e43@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/11/2023 17:15, Ben Dooks wrote:
> On 29/11/2023 16:03, Clément Léger wrote:
>> From: Samuel Ortiz <sameo@rivosinc.com>
>>
>> From: Samuel Ortiz <sameo@rivosinc.com>
>>
>> The Zkr extension is ratified and provides 16 bits of entropy seed when
>> reading the SEED CSR.
>>
>> We can implement arch_get_random_seed_longs() by doing multiple csrrw to
>> that CSR and filling an unsigned long with valid entropy bits.
>>
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>> Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>
>> ---
>>
>> This series depends on "riscv: report more ISA extensions through
>> hwprobe" series [1].
>>
>> Link:
>> https://lore.kernel.org/lkml/20231114141256.126749-1-cleger@rivosinc.com/ [1]
>> ---
>>   arch/riscv/include/asm/archrandom.h | 69 +++++++++++++++++++++++++++++
>>   arch/riscv/include/asm/csr.h        |  9 ++++
>>   2 files changed, 78 insertions(+)
>>   create mode 100644 arch/riscv/include/asm/archrandom.h
>>
>> diff --git a/arch/riscv/include/asm/archrandom.h
>> b/arch/riscv/include/asm/archrandom.h
>> new file mode 100644
>> index 000000000000..795837ccb583
>> --- /dev/null
>> +++ b/arch/riscv/include/asm/archrandom.h
>> @@ -0,0 +1,69 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Kernel interface for the RISCV arch_random_* functions
>> + *
>> + * Copyright (c) 2023 by Rivos Inc.
>> + *
>> + */
>> +
>> +#ifndef ASM_RISCV_ARCHRANDOM_H
>> +#define ASM_RISCV_ARCHRANDOM_H
>> +
>> +#include <asm/csr.h>
>> +
>> +#define SEED_RETRY_LOOPS 100
>> +
>> +static inline bool __must_check csr_seed_long(unsigned long *v)
>> +{
>> +    unsigned int retry = SEED_RETRY_LOOPS, valid_seeds = 0;
>> +    const int needed_seeds = sizeof(long) / sizeof(u16);
>> +    u16 *entropy = (u16 *)v;
>> +
>> +    do {
>> +        /*
>> +         * The SEED CSR must be accessed with a read-write instruction.
>> +         */
>> +        unsigned long csr_seed = csr_swap(CSR_SEED, 0);
>> +
>> +        switch (csr_seed & SEED_OPST_MASK) {
>> +        case SEED_OPST_ES16:
>> +            entropy[valid_seeds++] = csr_seed & SEED_ENTROPY_MASK;
>> +            if (valid_seeds == needed_seeds)
>> +                return true;
>> +            break;
>> +
>> +        case SEED_OPST_DEAD:
>> +            pr_err_once("archrandom: Unrecoverable error\n");
>> +            return false;
>> +
>> +        case SEED_OPST_BIST:
>> +        case SEED_OPST_WAIT:
>> +        default:
>> +            continue;
> 
> is it worth adding a cpu_relax() here?

Yeah, that clearly makes sense !

> 
>> +        }
>> +    } while (--retry);
>> +
>> +    return false;
>> +}
>> +
>> +static inline size_t __must_check arch_get_random_longs(unsigned long
>> *v, size_t max_longs)
>> +{
>> +    return 0;
>> +}
>> +
>> +static inline size_t __must_check arch_get_random_seed_longs(unsigned
>> long *v, size_t max_longs)
>> +{
>> +    if (!max_longs)
>> +        return 0;
>> +
>> +    /*
>> +     * If Zkr is supported and csr_seed_long succeeds, we return one
>> long
>> +     * worth of entropy.
>> +     */
>> +    if (riscv_has_extension_likely(RISCV_ISA_EXT_ZKR) &&
>> csr_seed_long(v))
>> +        return 1;
> 
> I'm assuming the code will retry if max_longs > 1 ?

Yes the caller will call it until gathering enough data (see
drivers/char/random.c).

Thanks,

Clément

> 
> 
> 
>> +    return 0;
>> +}
>> +
>> +#endif /* ASM_RISCV_ARCHRANDOM_H */
>> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
>> index 306a19a5509c..510014051f5d 100644
>> --- a/arch/riscv/include/asm/csr.h
>> +++ b/arch/riscv/include/asm/csr.h
>> @@ -411,6 +411,15 @@
>>   #define CSR_VTYPE        0xc21
>>   #define CSR_VLENB        0xc22
>>   +/* Scalar Crypto Extension - Entropy */
>> +#define CSR_SEED        0x015
>> +#define SEED_OPST_MASK        _AC(0xC0000000, UL)
>> +#define SEED_OPST_BIST        _AC(0x00000000, UL)
>> +#define SEED_OPST_WAIT        _AC(0x40000000, UL)
>> +#define SEED_OPST_ES16        _AC(0x80000000, UL)
>> +#define SEED_OPST_DEAD        _AC(0xC0000000, UL)
>> +#define SEED_ENTROPY_MASK    _AC(0xFFFF, UL)
>> +
>>   #ifdef CONFIG_RISCV_M_MODE
>>   # define CSR_STATUS    CSR_MSTATUS
>>   # define CSR_IE        CSR_MIE
> 
