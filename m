Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3047F7F9068
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 01:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjKZAGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 19:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKZAGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 19:06:34 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB81A127
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 16:06:40 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7b37dbf896eso60941939f.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 16:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700957200; x=1701562000; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NZyjHH024UtJYC8nd5F0O4jycJThUYyuQjeJaYfroYQ=;
        b=X0RTjRPthpgEryiNF+PMCTxgwRhMjbAXhrCLMNqh5KF5BmuAGpKseLedeEh7ZNL1Zq
         6BUaxoBFRjb6pz0vvr4htmuvpYcOFffMDa9jj6ocr12iIr8STwot5M2XMrrbNukT7Lha
         p6BwqRtPkb8c6mdZaXwqfRH8K6BqrsIyr3sUvNOQpLD8gd5HueEDUakCV7mvmKQyZJD3
         0Za1RYzdQuHi/Lc+yPk5Gha32aFZHQ1peTq5AGrv9PNaDPQnvxl6gi4oZRNsyNOqBzAb
         fkyiNo5qeT+8lTiOM2grx0FnU1iv1BKOA9G831BcQ/aqO8dZQiZDQAjv+b1+cQ+dt20R
         xzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700957200; x=1701562000;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NZyjHH024UtJYC8nd5F0O4jycJThUYyuQjeJaYfroYQ=;
        b=KHMYecX7knSxfueGMlyA2AFNQ5j8pCTj7WgET1t6+7kA5WTHEsgyDYrTlNTuLRdc//
         tnx/i0yYlVMKMwSijbIDNlgHF+NFYvbknU5mAJwGtu/+Yjg0z+TAOSoqpeeKSzV8z/GK
         wXUUWf30B+NFm22aQi1Jj+YwqkaXlmn8aPB9zqYEHrTnobfUuE5TI5viPhqV+1N8fHEm
         gLmVGkqiU8P2KghA+6b92jHB2p2StIDjWYVQjRDwb8fs5AgrygEmXnZhKETBwqpui4tq
         A1VZalhuIwq9jSpxwkfUO0Bo9XYJeP3w7iDtamOkFQOfZunJvwWsSE3Xa3HD83VAxaqj
         Urhg==
X-Gm-Message-State: AOJu0YzPn4gU/pPz6OHz5JFm0db6M7jFHKuEytqVxqKE+mwjaDQoWDpi
        EQEAaEialgufkJRr/8YDNZCqeg==
X-Google-Smtp-Source: AGHT+IHE9BSfvxwbGgqEygc0h8j2GlFdwRFUv/TXF2ue/ukhihc8koozSoNApEJTTPospumyntOOgQ==
X-Received: by 2002:a5e:8614:0:b0:7b3:84f4:f003 with SMTP id z20-20020a5e8614000000b007b384f4f003mr3186196ioj.19.1700957200239;
        Sat, 25 Nov 2023 16:06:40 -0800 (PST)
Received: from ?IPV6:2605:a601:adae:4500:169:4685:f118:f646? ([2605:a601:adae:4500:169:4685:f118:f646])
        by smtp.gmail.com with ESMTPSA id m7-20020a02cdc7000000b004667006c370sm1564707jap.76.2023.11.25.16.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 16:06:39 -0800 (PST)
Message-ID: <17d0646b-bcd5-48ff-a55c-d5cf88cdd015@sifive.com>
Date:   Sat, 25 Nov 2023 18:06:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Fix SMP when shadow call stacks are enabled
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>,
        Andy Chiu <andy.chiu@sifive.com>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nam Cao <namcaov@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org
References: <20231121211958.3158576-1-samuel.holland@sifive.com>
 <20231123-vision-nuttiness-b75be703f162@wendy>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20231123-vision-nuttiness-b75be703f162@wendy>
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

On 2023-11-23 8:06 AM, Conor Dooley wrote:
> On Tue, Nov 21, 2023 at 01:19:29PM -0800, Samuel Holland wrote:
>> This fixes two bugs in SCS initialization for secondary CPUs. First,
>> the SCS was not initialized at all in the spinwait boot path. Second,
>> the code for the SBI HSM path attempted to initialize the SCS before
>> enabling the MMU. However, that involves dereferencing the thread
>> pointer, which requires the MMU to be enabled.
>>
>> Fix both issues by setting up the SCS in the common secondary entry
>> path, after enabling the MMU.
> 
> I'm curious, mostly because I do not know much about the implemtnation
> of the shadow call stack, but does it actually work correctly when the
> kernel is built without mmu support?

I imagine it would work. The SCS implementation is purely software; it stores
the return address in a stack at `gp` instead of with the rest of local
variables at `sp`.

The problem here is that we are passing a pointer between CPUs with different
views of the virtual address space (i.e. the boot CPU sees the kernel at
0xffffffff80000000 while the CPU being brought up sees it at its physical
address), and then dereferencing it. If there is no MMU support, then the
virtual address space is identity mapped on all CPUs, and there is no problem.

Regards,
Samuel

>> Fixes: d1584d791a29 ("riscv: Implement Shadow Call Stack")
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
>>
>>  arch/riscv/kernel/head.S | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
>> index b77397432403..76ace1e0b46f 100644
>> --- a/arch/riscv/kernel/head.S
>> +++ b/arch/riscv/kernel/head.S
>> @@ -154,7 +154,6 @@ secondary_start_sbi:
>>  	XIP_FIXUP_OFFSET a3
>>  	add a3, a3, a1
>>  	REG_L sp, (a3)
>> -	scs_load_current
>>  
>>  .Lsecondary_start_common:
>>  
>> @@ -165,6 +164,7 @@ secondary_start_sbi:
>>  	call relocate_enable_mmu
>>  #endif
>>  	call .Lsetup_trap_vector
>> +	scs_load_current
>>  	tail smp_callin
>>  #endif /* CONFIG_SMP */
>>  
>> -- 
>> 2.42.0
>>

