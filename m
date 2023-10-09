Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0897B7BDD06
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376631AbjJINCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376530AbjJINCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:02:51 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FAF9C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 06:02:49 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32163c3ece5so366000f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 06:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696856568; x=1697461368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EwpVnrmSx861JVksI7Zb0upCp3LT7vnk8jsCfHBhWt4=;
        b=ojfJ6BQ0tOawPPhDLGPSi21WV243ejCFKviRoJnIZPU1R/X8qtv6MnJ5GhYUOk1Rbz
         K3CQyT7K0Hy2HSLR4958kruHLekpETgvjPKQ/9DX2Dnum1+cxuyZaCYTYcCW/qaKVeor
         Zn/caMpFBcZVS7dBeqtxHmSnIKUtO5j2/sOKv1aq6WFjhFjFb1tuKN/KX5T/9OxElhi9
         UJhaLe71RS9EKEMTmSyvVaHCUjwYFXuYKcr2hgTB4Tm1q4YhxJBc8junun5GLZqsUSFQ
         4qDCB0rGY5TOEB1S3QeyIKy1EH27Z91O97+mjEc+cSXL0qitpeouuqODV3MhPkHquzCq
         aJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696856568; x=1697461368;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EwpVnrmSx861JVksI7Zb0upCp3LT7vnk8jsCfHBhWt4=;
        b=pYMy5okiPwsVt7Oytwe/XgTMwaWUsuooKSIeYfDITZPadyJdSqBGQU9D/xNu1RqaRg
         IHj2RlwYLTKwtQ/qEpb7XUtj0QUCPvvP2NHNeFGlRx3TUMRgrQpuK4xvyZNSUAXOLIIa
         /TICN76mR7j+Y2dU8Ch5AReCI2TC6ovlUYocng8gsZvBOTRhsJvAXshKhWcSkycPj2cP
         GaXMhHP4GE+z7qFB8MU8Kgr3R/0D47rso2zCKLRymhr3ehgetu0v0hWEbjqY/9uKuBwL
         KRlQ4tkBp7noZK6IDtmUxw7tqsHbTytH0BKvy2rtUE8EOpaDXhNOgd8cp4CIRfmXkQn4
         YDOA==
X-Gm-Message-State: AOJu0YzqVDW+j0E3NPZfB4zkLyzekm03ET5xF9wWkNE3pB/ZOEdtemxk
        dqKMX4g9TE1XxmAqmWUIIbrkgw==
X-Google-Smtp-Source: AGHT+IEASGONYRFXA4cHgywDI+XLP2c22ckZQT+Jgx1u14KJOj6gK1tCwswzdOHqIUN7HrTNMBuWMw==
X-Received: by 2002:a5d:58c2:0:b0:324:87d3:873d with SMTP id o2-20020a5d58c2000000b0032487d3873dmr12967469wrf.3.1696856566689;
        Mon, 09 Oct 2023 06:02:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:b2f5:bf53:6bd1:414e? ([2a01:e0a:999:a3a0:b2f5:bf53:6bd1:414e])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d4b0f000000b00325aca09ad1sm9678417wrq.24.2023.10.09.06.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 06:02:46 -0700 (PDT)
Message-ID: <114052a2-6e2f-46cb-acb0-8d85c3b584bb@rivosinc.com>
Date:   Mon, 9 Oct 2023 15:02:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] riscv: remove unused functions in
 traps_misaligned.c
Content-Language: en-US
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Topel?= <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ron Minnich <rminnich@gmail.com>,
        Daniel Maslowski <cyrevolt@googlemail.com>,
        Conor Dooley <conor@kernel.org>
References: <20231004151405.521596-1-cleger@rivosinc.com>
 <20231004151405.521596-2-cleger@rivosinc.com>
 <877co2gwkb.fsf@all.your.base.are.belong.to.us>
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <877co2gwkb.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/10/2023 18:51, Björn Töpel wrote:
> Clément Léger <cleger@rivosinc.com> writes:
> 
>> Replace macros by the only two function calls that are done from this
>> file, store_u8() and load_u8().
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> ---
>>  arch/riscv/kernel/traps_misaligned.c | 46 +++++-----------------------
>>  1 file changed, 7 insertions(+), 39 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
>> index 378f5b151443..e7bfb33089c1 100644
>> --- a/arch/riscv/kernel/traps_misaligned.c
>> +++ b/arch/riscv/kernel/traps_misaligned.c
>> @@ -151,51 +151,19 @@
>>  #define PRECISION_S 0
>>  #define PRECISION_D 1
>>  
>> -#define DECLARE_UNPRIVILEGED_LOAD_FUNCTION(type, insn)			\
>> -static inline type load_##type(const type *addr)			\
>> -{									\
>> -	type val;							\
>> -	asm (#insn " %0, %1"						\
>> -	: "=&r" (val) : "m" (*addr));					\
>> -	return val;							\
>> -}
>> +static inline u8 load_u8(const u8 *addr)
> 
> Really a nit, and applies to the whole file: "static inline" in a .c
> file is just useless.

Oh yes clearly, I should have fixed that while factorizing, I simply
kept them from the previous code.

> 
>> +{
>> +	u8 val;
>>  
>> -#define DECLARE_UNPRIVILEGED_STORE_FUNCTION(type, insn)			\
>> -static inline void store_##type(type *addr, type val)			\
>> -{									\
>> -	asm volatile (#insn " %0, %1\n"					\
>> -	: : "r" (val), "m" (*addr));					\
>> -}
>> +	asm volatile("lbu %0, %1" : "=&r" (val) : "m" (*addr));
> 
> Why do you need early clobber here?

Ditto, copy pasted from existing code but I don't think there is a need
for early clobber here.

Clément

> 
> 
> Björn
