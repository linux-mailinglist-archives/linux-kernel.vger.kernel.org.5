Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F854789AE5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 04:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjH0CBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 22:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjH0CAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 22:00:53 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED57410D
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 19:00:49 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-34ba9d6f033so7813865ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 19:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1693101649; x=1693706449;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BlSuJKsHYnZJEVs8d+DkMrax8UWM8PJfpxzbSZhob4c=;
        b=SILQ0dy7yyODpbhPwIqg7gLpES7ddixyQwG5eJ3f/eCB4h58PirgfUl+PxkrwZF0of
         vQ/tzOjFcbOecqd8KchPhcJA3h2t96i5XuYbOnRStyI7wqGDNOfV5SfUu4Ya+wahQyok
         87ckMQB2pmHMUSx78/XuW/En7xot7HfP0EQhotd6pK/GWz8v+g9Wif7Y7L5YDeUfaWJd
         Syr26qTcui5k4V3CghKN2Ltu/llJKpiAyFc/z3dMfiKkQ4iO0VN2OoqUM5PGdGZlpOkr
         gz4ueUt681q5TIMkRS7VsHL8ZN3V0hMRUTnc6AqDiz9ybf6g4OpbcIKKfDA7/rLi9HKu
         DxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693101649; x=1693706449;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlSuJKsHYnZJEVs8d+DkMrax8UWM8PJfpxzbSZhob4c=;
        b=j+vbEtwqiSBx21c+495CK10ZIKK+vLvEotjLaz0YQfxmING4Xuy1U2IH4YWdAdrRZw
         tnmtaRUU77mc9Fv2PTMmr+i34uO1tEirImnn70u973LzMf8VRw9JKUmbF+OP1lUtQEs4
         qASwZIJktALTiJ1ilC/mfvk4dm7bu2iC/st/o0iD/LbBjdUgmCuKb9NBhouK4yKpO1Xb
         BDq65ZyIZsFMJLdt1J948rTmT7jdDtsNkphA/cJBtYqQdu2yvF+OAm2QgC+3lnrCOulC
         N8kvM49c4hw1+S1A8PxY3pw/F+bgTXFsN95e8zfCqeWVcCQmEx0RYnU4pTuxelOU/5Qv
         wFvw==
X-Gm-Message-State: AOJu0YxoM23wGk2qGGlJ92iRfJ4sp0c6PxGVejxF6PqsH3KwWAJ25v/S
        EOIdQI+HR1Q6v9IdfVMcSsoLdqaJtC2K4RnKFUc=
X-Google-Smtp-Source: AGHT+IG+vwM3D2XyZX5lR9mOoky02Ai+tLY9YcXHIjFwhPcdLHYppT+84YH7Ap2mNkHSRwfULseVhQ==
X-Received: by 2002:a05:6e02:1d96:b0:345:f28f:cc26 with SMTP id h22-20020a056e021d9600b00345f28fcc26mr15749614ila.24.1693101649219;
        Sat, 26 Aug 2023 19:00:49 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902654a00b001bc930d4517sm4472599pln.42.2023.08.26.19.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 19:00:47 -0700 (PDT)
Date:   Sat, 26 Aug 2023 19:00:47 -0700 (PDT)
X-Google-Original-Date: Sat, 26 Aug 2023 19:00:43 PDT (-0700)
Subject:     Re: [PATCH 1/5] riscv: Checksum header
In-Reply-To: <20230827-turf-parched-b965bc697882@spud>
CC:     charlie@rivosinc.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-d43dc0a3-7985-4195-9611-5ca0c38390e7@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Aug 2023 18:42:41 PDT (-0700), Conor Dooley wrote:
> On Sat, Aug 26, 2023 at 06:26:06PM -0700, Charlie Jenkins wrote:
>> Provide checksum algorithms that have been designed to leverage riscv
>> instructions such as rotate. In 64-bit, can take advantage of the larger
>> register to avoid some overflow checking.
>> 
>> Add configuration for Zba extension and add march for Zba and Zbb.
>> 
>> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>> ---
>>  arch/riscv/Kconfig                | 23 +++++++++++
>>  arch/riscv/Makefile               |  2 +
>>  arch/riscv/include/asm/checksum.h | 86 +++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 111 insertions(+)
>> 
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 4c07b9189c86..8d7e475ca28d 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -507,6 +507,29 @@ config RISCV_ISA_V_DEFAULT_ENABLE
>>  
>>  	  If you don't know what to do here, say Y.
>>  
>> +config TOOLCHAIN_HAS_ZBA
>> +	bool
>> +	default y
>> +	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zba)
>> +	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zba)
>> +	depends on LLD_VERSION >= 150000 || LD_VERSION >= 23900
>> +	depends on AS_HAS_OPTION_ARCH
>> +
>> +config RISCV_ISA_ZBA
>> +	bool "Zba extension support for bit manipulation instructions"
>> +	depends on TOOLCHAIN_HAS_ZBA
>> +	depends on MMU
>> +	depends on RISCV_ALTERNATIVE
>> +	default y
>> +	help
>> +	   Adds support to dynamically detect the presence of the ZBA
>> +	   extension (basic bit manipulation) and enable its usage.
>> +
>> +	   The Zba extension provides instructions to accelerate a number
>> +	   of bit-specific address creation operations.
>> +
>> +	   If you don't know what to do here, say Y.
>> +
>>  config TOOLCHAIN_HAS_ZBB
>>  	bool
>>  	default y
>> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
>> index 6ec6d52a4180..51fa3f67fc9a 100644
>> --- a/arch/riscv/Makefile
>> +++ b/arch/riscv/Makefile
>> @@ -61,6 +61,8 @@ riscv-march-$(CONFIG_ARCH_RV64I)	:= rv64ima
>>  riscv-march-$(CONFIG_FPU)		:= $(riscv-march-y)fd
>>  riscv-march-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-y)c
>>  riscv-march-$(CONFIG_RISCV_ISA_V)	:= $(riscv-march-y)v
>> +riscv-march-$(CONFIG_RISCV_ISA_ZBA)	:= $(riscv-march-y)_zba
>> +riscv-march-$(CONFIG_RISCV_ISA_ZBB)	:= $(riscv-march-y)_zbb
>
> AFAICT, this is going to break immediately on any system that enables
> RISCV_ISA_ZBA (which will happen by default) but does not support the
> extension. You made the option depend on RISCV_ALTERNATIVE, but I do
> not see any use of alternatives in the code to actually perform the
> dynamic detection of Zba.

I guess we kind of have an ambiguity here: for stuff like C we just 
unconditionally use the instructions, but for the rest we probe first.  
We should probably have three states for each extension: disabled, 
dynamically detected, and assumed.

> Note that for fd & v, we add it to riscv-march-y, but then immediately
> remove it again before passing to the compiler, only allow them in
> AFLAGS:
> 	# Remove F,D,V from isa string for all. Keep extensions between "fd" and "v" by
> 	# matching non-v and non-multi-letter extensions out with the filter ([^v_]*)
> 	KBUILD_CFLAGS += -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64ima)fd([^v_]*)v?/\1\2/')
>
> What am I missing?

FD and V both have state that can be saved lazily, so we can't let 
arbitrary code use them.  The extensions formally known as B don't add 
state, so they are safe to flip on in arbitrary places (aside from the 
issues you pointed out above).

>
> Thanks,
> Conor.
