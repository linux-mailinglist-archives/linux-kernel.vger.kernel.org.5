Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E757F9FF7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbjK0Mrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbjK0Mq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:46:56 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4E61FE2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:46:33 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-332eac4dec4so640948f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701089192; x=1701693992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ixV65JoK4WBoO4OnOo2GnsKuJZUviKgMNawpUYurg+w=;
        b=GgzJIUcGKeYunF+TaPbc0yuNgBAWC5jIbFdwFtegIyPYTA0jyWuJtzL3Agubgu0OZ+
         NpX2PD1xyaDHqeWovn0vh2pGO1/1XJF/hId3WGslzLe9fEleT/DmZLbZJ8qg/2Hydes8
         T6Ne/XVTlnIgsP6nk/GYJTPTqKFjRWj2v8v3y6HOcx7BSjNzHFNh39C5hHkU6Q6eQ5E9
         KLC8JLE1IQIW4bXagS5k7gaKRKI5boyvemzGLWa6xk1+DjHfb1hQC4roGIyeaajMcX48
         msinrN+fnzx1RkDHElVGvnZPDM4JlrMJFdNMJlFhR5dUvcGLHL/IMlL3/pxGEHpZ+MM4
         +ahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701089192; x=1701693992;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ixV65JoK4WBoO4OnOo2GnsKuJZUviKgMNawpUYurg+w=;
        b=RUR9BMe9NuTry/jRZkWuev80L9o2zJP2bqd/6bpTD3AgyjHVox1AQEvu2queb/KX+j
         3YLodwXOxX552IcJWr105rmIzHNSn7oCc89iBcCRNeGgDLi0mdryJgxv8gJ/ypqs2ss3
         5OOUrpf1NyUnkM8sIwqIf9CijqNeAy0YwvzSXR63kN1LsAW/OOzz5E1IefiYI4DFjF8R
         z0UlCFRKcIVzWUw6VOl3sbYg39zyLXcjlTwZvykdP4NBDmOWmCMjVUUZVZ3jweCypuUd
         JpNt6wOr7Vc/ee9cZ8GP2+GbLalbNGiurrMelLtmJjqfsU+J1mrdddb0q3gevYkHSvlA
         ebbw==
X-Gm-Message-State: AOJu0YxvRgQZWZxHP5M6DHsLaRTWjYqTbgtAH6/8QmpZ8a51I6gyI9uc
        f6YTbvsNNgE0XI9ehaLnx3Fi2w==
X-Google-Smtp-Source: AGHT+IHHV5GEjSjDaLLNI5ze5I2oKNEJnCCns6qXufXDi1DsBjKoFU4y3gk3vwDwUkk/7AtXr5b2iQ==
X-Received: by 2002:a5d:64c2:0:b0:332:c6ae:ea03 with SMTP id f2-20020a5d64c2000000b00332c6aeea03mr8315395wri.1.1701089192293;
        Mon, 27 Nov 2023 04:46:32 -0800 (PST)
Received: from ?IPV6:2a01:e0a:999:a3a0:c123:224a:77e5:3aba? ([2a01:e0a:999:a3a0:c123:224a:77e5:3aba])
        by smtp.gmail.com with ESMTPSA id dm16-20020a0560000bd000b00332cb4697ebsm12011768wrb.55.2023.11.27.04.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 04:46:31 -0800 (PST)
Message-ID: <300ba40f-4dce-44f1-8809-5a0abcb41aa4@rivosinc.com>
Date:   Mon, 27 Nov 2023 13:46:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: fix incorrect use of __user pointer
Content-Language: en-US
To:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        kernel test robot <lkp@intel.com>
References: <20231124113803.165431-1-cleger@rivosinc.com>
 <b4ee0ab3-9772-439c-bc9c-474f6f2862ba@codethink.co.uk>
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <b4ee0ab3-9772-439c-bc9c-474f6f2862ba@codethink.co.uk>
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



On 27/11/2023 13:02, Ben Dooks wrote:
> On 24/11/2023 11:38, Clément Léger wrote:
>> These warnings were reported by sparse and were due to lack of __user
>> annotation as well as dereferencing such pointer:
>>
>> arch/riscv/kernel/traps_misaligned.c:361:21: warning: dereference of
>> noderef expression
>> arch/riscv/kernel/traps_misaligned.c:373:21: warning: dereference of
>> noderef expression
>> arch/riscv/kernel/traps_misaligned.c:381:21: warning: dereference of
>> noderef expression
>> arch/riscv/kernel/traps_misaligned.c:322:24: warning: incorrect type
>> in initializer (different address spaces)
>> arch/riscv/kernel/traps_misaligned.c:322:24:    expected unsigned char
>> const [noderef] __user *__gu_ptr
>> arch/riscv/kernel/traps_misaligned.c:322:24:    got unsigned char
>> const [usertype] *addr
>> arch/riscv/kernel/traps_misaligned.c:361:21: warning: dereference of
>> noderef expression
>> arch/riscv/kernel/traps_misaligned.c:373:21: warning: dereference of
>> noderef expression
>> arch/riscv/kernel/traps_misaligned.c:381:21: warning: dereference of
>> noderef expression
>> arch/riscv/kernel/traps_misaligned.c:332:24: warning: incorrect type
>> in initializer (different address spaces)
>> arch/riscv/kernel/traps_misaligned.c:332:24:    expected unsigned char
>> [noderef] __user *__gu_ptr
>> arch/riscv/kernel/traps_misaligned.c:332:24:    got unsigned char
>> [usertype] *addr
>>
>> As suggested by Christoph Hellwig, casting pointers from an address
>> space to another is not a good idea and we should rather cast the
>> untyped unsigned long to their final address space. Fix the ones in
>> load_u8()/store_u8()/__read_insn() by passing a unsigned long and then
>> casting it to the appropriate type (__user of not) depending if used in
>> kernel/ user mode. Also remove unneeded else construct in store_u8()/
>> load_u8().
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes:
>> https://lore.kernel.org/oe-kbuild-all/202311160606.obGOOwB3-lkp@intel.com/
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> ---
>>   arch/riscv/kernel/traps_misaligned.c | 55 +++++++++++++---------------
>>   1 file changed, 25 insertions(+), 30 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/traps_misaligned.c
>> b/arch/riscv/kernel/traps_misaligned.c
>> index 5eba37147caa..a92b88af855a 100644
>> --- a/arch/riscv/kernel/traps_misaligned.c
>> +++ b/arch/riscv/kernel/traps_misaligned.c
>> @@ -265,19 +265,19 @@ static unsigned long get_f32_rs(unsigned long
>> insn, u8 fp_reg_offset,
>>   #define GET_F32_RS2S(insn, regs) (get_f32_rs(RVC_RS2S(insn), 0, regs))
>>     #ifdef CONFIG_RISCV_M_MODE
>> -static inline int load_u8(struct pt_regs *regs, const u8 *addr, u8
>> *r_val)
>> +static inline int load_u8(struct pt_regs *regs, const unsigned long
>> addr, u8 *r_val)
>>   {
>>       u8 val;
>>   -    asm volatile("lbu %0, %1" : "=&r" (val) : "m" (*addr));
>> +    asm volatile("lbu %0, %1" : "=&r" (val) : "m" (*(const u8 *)addr));
>>       *r_val = val;
>>         return 0;
>>   }
>>   -static inline int store_u8(struct pt_regs *regs, u8 *addr, u8 val)
>> +static inline int store_u8(struct pt_regs *regs, unsigned long addr,
>> u8 val)
>>   {
>> -    asm volatile ("sb %0, %1\n" : : "r" (val), "m" (*addr));
>> +    asm volatile ("sb %0, %1\n" : : "r" (val), "m" (*(u8 *)addr));
>>         return 0;
>>   }
>> @@ -316,34 +316,32 @@ static inline int get_insn(struct pt_regs *regs,
>> ulong mepc, ulong *r_insn)
>>       return 0;
>>   }
>>   #else
>> -static inline int load_u8(struct pt_regs *regs, const u8 *addr, u8
>> *r_val)
>> +static inline int load_u8(struct pt_regs *regs, const unsigned long
>> addr, u8 *r_val)
>>   {
>> -    if (user_mode(regs)) {
>> -        return __get_user(*r_val, addr);
>> -    } else {
>> -        *r_val = *addr;
>> -        return 0;
>> -    }
>> +    if (user_mode(regs))
>> +        return __get_user(*r_val, (u8 __user *)addr);
>> +
>> +    *r_val = *(const u8 *)addr;
>> +    return 0;
>>   }
>>   -static inline int store_u8(struct pt_regs *regs, u8 *addr, u8 val)
>> +static inline int store_u8(struct pt_regs *regs, unsigned long addr,
>> u8 val)
>>   {
>> -    if (user_mode(regs)) {
>> -        return __put_user(val, addr);
>> -    } else {
>> -        *addr = val;
>> -        return 0;
>> -    }
>> +    if (user_mode(regs))
>> +        return __put_user(val, (u8 __user *)addr);
>> +
>> +    *(u8 *)addr = val;
>> +    return 0;
>>   }
>>   -#define __read_insn(regs, insn, insn_addr)        \
>> +#define __read_insn(regs, insn, insn_addr, type)    \
>>   ({                            \
>>       int __ret;                    \
>>                               \
>>       if (user_mode(regs)) {                \
>> -        __ret = __get_user(insn, insn_addr);    \
>> +        __ret = __get_user(insn, (type __user *) insn_addr); \
>>       } else {                    \
>> -        insn = *insn_addr;            \
>> +        insn = *(type *)insn_addr;        \
>>           __ret = 0;                \
>>       }                        \
>>                               \
>> @@ -356,9 +354,8 @@ static inline int get_insn(struct pt_regs *regs,
>> ulong epc, ulong *r_insn)
>>         if (epc & 0x2) {
>>           ulong tmp = 0;
>> -        u16 __user *insn_addr = (u16 __user *)epc;
>>   -        if (__read_insn(regs, insn, insn_addr))
>> +        if (__read_insn(regs, insn, epc, u16))
>>               return -EFAULT;
>>           /* __get_user() uses regular "lw" which sign extend the loaded
>>            * value make sure to clear higher order bits in case we
>> "or" it
>> @@ -369,16 +366,14 @@ static inline int get_insn(struct pt_regs *regs,
>> ulong epc, ulong *r_insn)
>>               *r_insn = insn;
>>               return 0;
>>           }
>> -        insn_addr++;
>> -        if (__read_insn(regs, tmp, insn_addr))
>> +        epc += sizeof(u16);
>> +        if (__read_insn(regs, tmp, epc, u16))
>>               return -EFAULT;
>>           *r_insn = (tmp << 16) | insn;
>>             return 0;
>>       } else {
>> -        u32 __user *insn_addr = (u32 __user *)epc;
>> -
>> -        if (__read_insn(regs, insn, insn_addr))
>> +        if (__read_insn(regs, insn, epc, u32))
>>               return -EFAULT;
>>           if ((insn & __INSN_LENGTH_MASK) == __INSN_LENGTH_32) {
>>               *r_insn = insn;
>> @@ -491,7 +486,7 @@ int handle_misaligned_load(struct pt_regs *regs)
>>         val.data_u64 = 0;
>>       for (i = 0; i < len; i++) {
>> -        if (load_u8(regs, (void *)(addr + i), &val.data_bytes[i]))
>> +        if (load_u8(regs, addr + i, &val.data_bytes[i]))
>>               return -1;
>>       }
>>   @@ -589,7 +584,7 @@ int handle_misaligned_store(struct pt_regs *regs)
>>           return -EOPNOTSUPP;
>>         for (i = 0; i < len; i++) {
>> -        if (store_u8(regs, (void *)(addr + i), val.data_bytes[i]))
>> +        if (store_u8(regs, addr + i, val.data_bytes[i]))
>>
> 
> Would it not be easier to have a switch here for memcpy or copy_to_user?

Most probably yes. I'll update the V3 with these modifications. We'll
get rid of store_u8()/load_u8() entirely.

Thanks,

Clément

> 
>                return -1;
>>       }
>>   
> 
