Return-Path: <linux-kernel+bounces-23413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 023F982AC72
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FF451F23812
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B113114F6A;
	Thu, 11 Jan 2024 10:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="aFX6KVGR"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA6B14F60
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cd6c0b7dbbso5359931fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704970191; x=1705574991; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s1dTcljljjbzC/kh3vHpEuL3WEnDjy1A0qz4miGt7qo=;
        b=aFX6KVGRNOdqho+GDybNitxAgXoqvkn0U+2Zi1amPz09NBwJXs3nKXnSH/vpkj9YjT
         L4vsZS5jL1REGUMqUwStfsqQscBPEScFlNXQOdAfZXa23k5MQEn0C6UVt88D898CVjOm
         tDH0UlCtllyxhPh/HAPQAWRdMedR39mHWXkK3Wu1S9Yry3UQZG8tEr7uqVzeVClOlFc4
         mHtjoPgj2ithlT9kF+HAAfPekDsrrqWt4DUIvOwLNsFqwSYSU9TXE9fhR9fXLNjAq3sx
         RR5/5JH6KuSb8b+kTP/oj3PdbIsejDcQQmk8NmtStmrV4CKK+9V13p+gwjYd3lACnk7J
         FkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704970191; x=1705574991;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s1dTcljljjbzC/kh3vHpEuL3WEnDjy1A0qz4miGt7qo=;
        b=MLjJqymD5A95lj5W55pkGRvPi6FMgs2lApAi1qFFeiGuV6YtZpVOOPccHx0i51rExE
         PUKlwXFa+ao6+BsSbxn/kp6tXNen1mvvv2UFl7F5CHp7QO/CWu4caQj4A3H71UxTzeKI
         nHx3b247ZDyxFWDw+FzqP51GgvbzFRfW6QyEGYq/8D64h93SiVhOolrnnhfrwsDUIoeX
         E8KSMgEgnqDBC3WSzpWXwVBud5R6Mm4727a9MbYziT96bnyLxB2AaggTncF/14rMn6A/
         hsU+7/JaLxIkvRvdGNJBcSpVxSfs5cyUBthKLkxjePHbNM+xDWym4yk1dIEOqkbanDne
         HIsg==
X-Gm-Message-State: AOJu0YzjbpzHLffI0cQSmGrIhwYM6KUMzmCog+NkvN7YuC3WnRwjBuBy
	ejaH+49Y+tnu0ezTky8hYHr6jxjLsPUW8g==
X-Google-Smtp-Source: AGHT+IEL/miHMbrsEIJ3YKGjGRju9tM/OC4JSiDh6ozMI3LPqM42XTQcwyS/+vFSR2fdmi7Ow55Ekg==
X-Received: by 2002:a2e:860c:0:b0:2cd:3337:6729 with SMTP id a12-20020a2e860c000000b002cd33376729mr1118430lji.3.1704970190789;
        Thu, 11 Jan 2024 02:49:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:999:a3a0:bf36:e934:b395:fd62? ([2a01:e0a:999:a3a0:bf36:e934:b395:fd62])
        by smtp.gmail.com with ESMTPSA id k11-20020a2e92cb000000b002cd7a4a2611sm104933ljh.35.2024.01.11.02.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 02:49:50 -0800 (PST)
Message-ID: <78afc7ce-c6ce-4edd-b91a-1f8a94ce298a@rivosinc.com>
Date: Thu, 11 Jan 2024 11:49:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/3] riscv: Add Zicbop instruction definitions &
 cpufeature
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>
Cc: guoren@kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
 paul.walmsley@sifive.com, palmer@dabbelt.com, panqinglin2020@iscas.ac.cn,
 bjorn@rivosinc.com, conor.dooley@microchip.com, leobras@redhat.com,
 peterz@infradead.org, keescook@chromium.org, wuwei2016@iscas.ac.cn,
 xiaoguang.xing@sophgo.com, chao.wei@sophgo.com, unicorn_wang@outlook.com,
 uwu@icenowy.me, jszhang@kernel.org, wefu@redhat.com, atishp@atishpatra.org
References: <20231231082955.16516-1-guoren@kernel.org>
 <20231231082955.16516-2-guoren@kernel.org>
 <6bce1adb-6808-40df-8dd7-b0b2c6031547@rivosinc.com>
 <20240103-77f6b0856efb7a9f4591c53b@orel>
 <331610f6-9987-4d1b-8d57-f21311a43f5d@rivosinc.com>
 <20240111-416377ebfcaff924b71fb419@orel>
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20240111-416377ebfcaff924b71fb419@orel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/01/2024 11:45, Andrew Jones wrote:
> On Thu, Jan 11, 2024 at 11:31:32AM +0100, Clément Léger wrote:
>>
>>
>> On 03/01/2024 13:00, Andrew Jones wrote:
>>> On Wed, Jan 03, 2024 at 10:31:37AM +0100, Clément Léger wrote:
>>>>
>>>>
>>>> On 31/12/2023 09:29, guoren@kernel.org wrote:
>>>>> From: Guo Ren <guoren@linux.alibaba.com>
>>>>>
>>>>> Cache-block prefetch instructions are HINTs to the hardware to
>>>>> indicate that software intends to perform a particular type of
>>>>> memory access in the near future. This patch adds prefetch.i,
>>>>> prefetch.r and prefetch.w instruction definitions by
>>>>> RISCV_ISA_EXT_ZICBOP cpufeature.
>>>>>
>>>>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>>>>> Signed-off-by: Guo Ren <guoren@kernel.org>
>>>>> ---
>>>>>  arch/riscv/Kconfig                | 15 ++++++++
>>>>>  arch/riscv/include/asm/hwcap.h    |  1 +
>>>>>  arch/riscv/include/asm/insn-def.h | 60 +++++++++++++++++++++++++++++++
>>>>>  arch/riscv/kernel/cpufeature.c    |  1 +
>>>>>  4 files changed, 77 insertions(+)
>>>>>
>>>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>>>> index 24c1799e2ec4..fcbd417d65ea 100644
>>>>> --- a/arch/riscv/Kconfig
>>>>> +++ b/arch/riscv/Kconfig
>>>>> @@ -579,6 +579,21 @@ config RISCV_ISA_ZICBOZ
>>>>>  
>>>>>  	   If you don't know what to do here, say Y.
>>>>>  
>>>>> +config RISCV_ISA_ZICBOP
>>>>> +	bool "Zicbop extension support for cache block prefetch"
>>>>> +	depends on MMU
>>>>> +	depends on RISCV_ALTERNATIVE
>>>>> +	default y
>>>>> +	help
>>>>> +	  Adds support to dynamically detect the presence of the ZICBOP
>>>>> +	  extension (Cache Block Prefetch Operations) and enable its
>>>>> +	  usage.
>>>>> +
>>>>> +	  The Zicbop extension can be used to prefetch cache block for
>>>>> +	  read/write fetch.
>>>>> +
>>>>> +	  If you don't know what to do here, say Y.
>>>>> +
>>>>>  config TOOLCHAIN_HAS_ZIHINTPAUSE
>>>>>  	bool
>>>>>  	default y
>>>>> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
>>>>> index 06d30526ef3b..77d3b6ee25ab 100644
>>>>> --- a/arch/riscv/include/asm/hwcap.h
>>>>> +++ b/arch/riscv/include/asm/hwcap.h
>>>>> @@ -57,6 +57,7 @@
>>>>>  #define RISCV_ISA_EXT_ZIHPM		42
>>>>>  #define RISCV_ISA_EXT_SMSTATEEN		43
>>>>>  #define RISCV_ISA_EXT_ZICOND		44
>>>>> +#define RISCV_ISA_EXT_ZICBOP		45
>>>>
>>>> Hi Guo,
>>>>
>>>> Since you are adding support for the Zicbop extension, you could
>>>> probably also allow to probe it from userspace using hwprobe. Add a few
>>>> definitions to sys_riscv.c/hwprobe.h and it will be fine.
>>>
>>> To expose to userspace, we should also start parsing the block size,
>>> so it can also be exposed to userspace. Starting to parse the block
>>> size first requires that we decide we need to parse the block size
>>> (see [1]).
>>
>> Hi Andrew, thanks for the thread.
>>
>> I read it (and the other ones that are related to it) and basically, it
>> seems there was a first decision (expose Zicbop block size indivudally)
>> due to the fact the specification did not mentioned anything specific
>> about clock sizes  but then after that, there was a clarification in the
>> spec stating that Zicbop and Zicbom have the same block size so the
>> first decision was questioned again.
>>
>> From a user coherency point of view, I think it would make more sense to
>> expose it individually in hwprobe  so that zicboz, zicbop and zicbom
>> have their "own" block size (even though zicbop and zicbom would use the
>> same one). Moreover, it would allow us for future evolution easily
>> without breaking any userspace later if zicbop and zicbom block size are
>> decoupled.
> 
> I agree and QEMU has already headed down the road of generating
> riscv,cbop-block-size (I guess Conor's ack on [1] was interpreted as
> being sufficient to merge the QEMU bits), so we can add the Linux
> support and test with QEMU now. The work could probably be a separate
> series to this one, though.

Yes, it QEMU had it merged. and agreed, since this requires a bit more
plumbing, it can probably be left out of this series. I could probably
take care of that later.

Thanks,

Clément

