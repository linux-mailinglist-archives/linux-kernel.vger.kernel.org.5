Return-Path: <linux-kernel+bounces-120008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3AF88D013
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5C2EB23AB6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11A713D88F;
	Tue, 26 Mar 2024 21:30:58 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8097213D62E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711488658; cv=none; b=RLLfmkKk0Zoir3c5S+y9bauooinY6eGPsLE1gphQKjExeYFCugYYFAi3SrcPN/E92PDkWOsZ/+Ft5GeBHCayHYyzV3ADwbJeN0fmvCNnbxe+v25V57Ip5PmEiOyAILfRGvJICH0H5Ev9JkdHhw38k9KLXOg1b70CSLnv0vC/LWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711488658; c=relaxed/simple;
	bh=GQsOFn3z/ltzMiSqHOLQ6WIb6HGqbMhSL9srQPYMWSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffxVO7IsY+PaukwN6q+U8MIykET22hrsJSu/d2LYThxD/7XxdVGx4cyA4hamo5F93l2NCyN9KHCrIOTwFiLE5MGazx8hW8mFAh21UvFF6Sfep+CERssckYEVyo+0W7Fv/efmbowLJNUStzXjNZ7b1jt3/0OD2l5yrk7rFulSycc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [117.22.85.11])
	by gateway (Coremail) with SMTP id _____8DxdfGNPgNm74oeAA--.6526S3;
	Wed, 27 Mar 2024 05:30:53 +0800 (CST)
Received: from [192.168.0.105] (unknown [117.22.85.11])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxrhOLPgNmX3RpAA--.21721S3;
	Wed, 27 Mar 2024 05:30:52 +0800 (CST)
Message-ID: <9d557c37-d376-40c3-0630-4e904db27528@loongson.cn>
Date: Wed, 27 Mar 2024 05:30:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] LoongArch: Give chance to build under !CONFIG_SMP
Content-Language: en-US
To: maobibo <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 Marc Zyngier <maz@kernel.org>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 loongson-kernel@lists.loongnix.cn
References: <20240326062101.9822-1-yangtiezhu@loongson.cn>
 <55494710-ddaa-c35a-f6cd-5baf98b13931@loongson.cn>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
In-Reply-To: <55494710-ddaa-c35a-f6cd-5baf98b13931@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxrhOLPgNmX3RpAA--.21721S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WF43Xw17ZF47GF4UGFWUZFc_yoW8CFyfpF
	WvyF4UtF409r1vkr97Jan5uFyrZrn3Ja9rGry3Ca4DJasxXrnaqr4vgwn0vFyDurWSq3W0
	vFZrWa1fuF1Yq3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
	AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07je0PfUUUUU=

Hi Bibo,

On 3/26/24 20:58, maobibo wrote:
> 
> 
> On 2024/3/26 下午2:21, Tiezhu Yang wrote:
>> In the current code, SMP is selected in Kconfig for LoongArch, the users
>> can not unset it, this is reasonable for a multiprocessor machine. But as
>> the help info of config SMP said, if you have a system with only one CPU,
>> say N. On a uniprocessor machine, the kernel will run faster if you say N
>> here.
>>
>> The Loongson-2K0500 is a single-core CPU for applications like industrial
>> control, printing terminals, and BMC (Baseboard Management Controller),
>> there are many development boards, products and solutions on the market,
>> so it is better and necessary to give a chance to build under !CONFIG_SMP
>> for a uniprocessor machine.

..

>> +++ b/arch/loongarch/include/asm/smp.h
>> @@ -6,6 +6,7 @@
>>   #ifndef __ASM_SMP_H
>>   #define __ASM_SMP_H
>> +#ifdef CONFIG_SMP
>>   #include <linux/atomic.h>
>>   #include <linux/bitops.h>
>>   #include <linux/linkage.h>
>> @@ -101,4 +102,8 @@ static inline void __cpu_die(unsigned int cpu)
>>   }
>>   #endif
>> +#else /* !CONFIG_SMP */
>> +#define cpu_logical_map(cpu)    0
> It is unsafe here though physical cpuid of BSP is 0 always.
> It is better to use __cpu_logical_map[cpu] or read_csr_cpuid()
> 
>> +#endif

..

>> +++ b/arch/loongarch/power/suspend.c
>> @@ -44,7 +44,9 @@ void loongarch_common_resume(void)
>>   {
>>       sync_counter();
>>       local_flush_tlb_all();
>> +#ifdef CONFIG_HAVE_SETUP_PER_CPU_AREA
>>       csr_write64(per_cpu_offset(0), PERCPU_BASE_KS);
>> +#endif
> It is another issue, CONFIG_HAVE_SETUP_PER_CPU_AREA should not depend on 
> NUMA. PERCPU_BASE_KS should be set even for UP.

Thanks for your review and suggestions.

Let me wait for some days, if no more comments, I will address in v3 
since the v2 has been sent.

Thanks,
Tiezhu


