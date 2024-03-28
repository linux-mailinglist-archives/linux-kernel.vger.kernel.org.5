Return-Path: <linux-kernel+bounces-98936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9033887813D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A96441C228DA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E313FB2D;
	Mon, 11 Mar 2024 14:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="aA63oAbI";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="vqzo5xHL"
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F93E3FB2C;
	Mon, 11 Mar 2024 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.207.88.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710165845; cv=none; b=uHd+/YLwfvAIGrfrsIHq4XDToTlezwh4mjABvnvUm2HpiSAM4BljhsxvKpATmP0YKjjyvksLA8X+PO+a4RGAbUejyBqgV6tmH2E4TJPIYlQSD59Wi3bAvh3KbsZRrfffHRnlQijEj5NF3amZv9JAel/aqFQ9Ku1CQWAn6S27cE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710165845; c=relaxed/simple;
	bh=oUuAdxmWlp24LjWzNIohgFRBoDPpB7BqUTXbZzC1jAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sWykwh+nKTRC7AL0laaOhL5o2Y8yjb9FEae8ljiEZEjryH2YfAbx6tvbz4pLndqnp0XjqgLcBYH5BjW4fp2R3/SaOiYnpKdvz81XryNV/LMU7rDHuO+2hVZoNUX5cw1abroz+vFM9IL0XMIUERLSvm305/TPhBZMe1lTzmnvEU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com; spf=pass smtp.mailfrom=yadro.com; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=aA63oAbI; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=vqzo5xHL; arc=none smtp.client-ip=89.207.88.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 5AB7FC0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1710165372; bh=Vdq2GWghl2rfXEpJJWvzxWu9k5je6NG63O3Va6kn9y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=aA63oAbIrhqLgN1VxugvqG50lysQSMasw2Qx9mcvMPX2mNRn1Ud5hhDYO7z5dDtBW
	 Kqlbw/vueJCCiPl4xgROjYylZpzqtdeKFnv7TouARaAEkqk8YlqPasy44joKWRFuGc
	 YJi3WGDNiwFgjjZprA1ucJyQpECghXyuc+gxY90EXPCkMVVpeQu4khsyLQDMKAAaL+
	 2AcuAyY8yT8j+tIdHf52Y9A63sQSb+VWy0ZoWtF7OgZzn9tSq1r1D8YC3NbTsXE/Fp
	 H2PurLSdU9yae9bH8cki/vDVx6Z8YVytGUEk/2Uomx4CRbsqhaxQv9WWqHMTUVtkTG
	 L9QWK0o85AUXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1710165372; bh=Vdq2GWghl2rfXEpJJWvzxWu9k5je6NG63O3Va6kn9y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=vqzo5xHLJtxtUTROCR3VcFh4PUUnWJQtjCitjIhGugWzzPUZmw2fkjCWM2zu2/Xf0
	 KcACV+SUkL+28YdTsgJ5L1kNf1b+QYkyfF52xeE8UHn4bXpQOgTom+R8JIcsyPhOx2
	 hDaHtn1CL3foRe2welAVEKZDmZ8DAMURws50oS79ENlLDrfFX/R8DS0+12T6Ez3kZY
	 n87H8fm4iXgJqFs924BR0qVDuZeBLrZoez4TSSH5M3nTD8ERoKQC0js5vaRBsg5F9D
	 jqDU4g5mkCSBKUjb06Y3gIiVg8iLdWSzAGgkH2Xleo6EBzkGIXKH8beU7QB2SIit26
	 puC/dQjU65UjA==
Message-ID: <4ca03ffb-559b-4db2-9b92-14d73dfab7e2@yadro.com>
Date: Mon, 11 Mar 2024 16:56:08 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DMARC Error] Re: [RFC PATCH] riscv: Implement
 HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
Content-Language: en-US
To: Puranjay Mohan <puranjay12@gmail.com>
CC: Alexandre Ghiti <alex@ghiti.fr>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Sami Tolvanen <samitolvanen@google.com>,
	Guo Ren <guoren@kernel.org>, Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Deepak Gupta <debug@rivosinc.com>, Sia Jee Heng
	<jeeheng.sia@starfivetech.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
	<bjorn@rivosinc.com>, Song Shuai <suagrfillet@gmail.com>,
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, Al Viro
	<viro@zeniv.linux.org.uk>, Jisheng Zhang <jszhang@kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux@yadro.com>
References: <20240306165904.108141-1-puranjay12@gmail.com>
 <34c9d54a-0f19-4671-8b05-9adf3b6c9a1a@ghiti.fr>
 <CANk7y0jO5dysnsazCq-r=G-EvWUPTwQaW257PcqEbq8SvVRf2Q@mail.gmail.com>
From: Evgenii Shatokhin <e.shatokhin@yadro.com>
In-Reply-To: <CANk7y0jO5dysnsazCq-r=G-EvWUPTwQaW257PcqEbq8SvVRf2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: T-EXCH-10.corp.yadro.com (172.17.11.60) To
 T-EXCH-10.corp.yadro.com (172.17.11.60)

Hi,

On 07.03.2024 03:17, Puranjay Mohan wrote:
> 
> Hi Alex,
> 
> On Wed, Mar 6, 2024 at 9:35 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>>
>> Hi Puranjay,
>>
>> On 06/03/2024 17:59, Puranjay Mohan wrote:
>>> This patch enables support for DYNAMIC_FTRACE_WITH_CALL_OPS on RISC-V.
>>> This allows each ftrace callsite to provide an ftrace_ops to the common
>>> ftrace trampoline, allowing each callsite to invoke distinct tracer
>>> functions without the need to fall back to list processing or to
>>> allocate custom trampolines for each callsite. This significantly speeds
>>> up cases where multiple distinct trace functions are used and callsites
>>> are mostly traced by a single tracer.
>>>
>>> The idea and most of the implementation is taken from the ARM64's
>>> implementation of the same feature. The idea is to place a pointer to
>>> the ftrace_ops as a literal at a fixed offset from the function entry
>>> point, which can be recovered by the common ftrace trampoline.
>>>
>>> We use -fpatchable-function-entry to reserve 8 bytes above the function
>>> entry by emitting 2 4 byte or 4 2 byte  nops depending on the presence of
>>> CONFIG_RISCV_ISA_C. These 8 bytes are patched at runtime with a pointer
>>> to the associated ftrace_ops for that callsite. Functions are aligned to
>>> 8 bytes to make sure that the accesses to this literal are atomic.
>>>
>>> This approach allows for directly invoking ftrace_ops::func even for
>>> ftrace_ops which are dynamically-allocated (or part of a module),
>>> without going via ftrace_ops_list_func.
>>>
>>> I've benchamrked this with the ftrace_ops sample module on Qemu, with
>>> the next version, I will provide benchmarks on real hardware:
>>>
>>> Without this patch:
>>>
>>> +-----------------------+-----------------+----------------------------+
>>> |  Number of tracers    | Total time (ns) | Per-call average time      |
>>> |-----------------------+-----------------+----------------------------|
>>> | Relevant | Irrelevant |    100000 calls | Total (ns) | Overhead (ns) |
>>> |----------+------------+-----------------+------------+---------------|
>>> |        0 |          0 |        15615700 |        156 |             - |
>>> |        0 |          1 |        15917600 |        159 |             - |
>>> |        0 |          2 |        15668000 |        156 |             - |
>>> |        0 |         10 |        14971500 |        149 |             - |
>>> |        0 |        100 |        15417600 |        154 |             - |
>>> |        0 |        200 |        15387000 |        153 |             - |
>>> |----------+------------+-----------------+------------+---------------|
>>> |        1 |          0 |       119906800 |       1199 |          1043 |
>>> |        1 |          1 |       137428600 |       1374 |          1218 |
>>> |        1 |          2 |       159562400 |       1374 |          1218 |
>>> |        1 |         10 |       302099900 |       3020 |          2864 |
>>> |        1 |        100 |      2008785500 |      20087 |         19931 |
>>> |        1 |        200 |      3965221900 |      39652 |         39496 |
>>> |----------+------------+-----------------+------------+---------------|
>>> |        1 |          0 |       119166700 |       1191 |          1035 |
>>> |        2 |          0 |       157999900 |       1579 |          1423 |
>>> |       10 |          0 |       425370100 |       4253 |          4097 |
>>> |      100 |          0 |      3595252100 |      35952 |         35796 |
>>> |      200 |          0 |      7023485700 |      70234 |         70078 |
>>> +----------+------------+-----------------+------------+---------------+
>>>
>>> Note: per-call overhead is estimated relative to the baseline case with
>>> 0 relevant tracers and 0 irrelevant tracers.
>>>
>>> With this patch:
>>>
>>> +-----------------------+-----------------+----------------------------+
>>> |   Number of tracers   | Total time (ns) | Per-call average time      |
>>> |-----------------------+-----------------+----------------------------|
>>> | Relevant | Irrelevant |    100000 calls | Total (ns) | Overhead (ns) |
>>> |----------+------------+-----------------+------------+---------------|
>>> |        0 |          0 |        15254600 |        152 |             - |
>>> |        0 |          1 |        16136700 |        161 |             - |
>>> |        0 |          2 |        15329500 |        153 |             - |
>>> |        0 |         10 |        15148800 |        151 |             - |
>>> |        0 |        100 |        15746900 |        157 |             - |
>>> |        0 |        200 |        15737400 |        157 |             - |
>>> |----------+------------+-----------------+------------+---------------|
>>> |        1 |          0 |        47909000 |        479 |           327 |
>>> |        1 |          1 |        48297400 |        482 |           330 |
>>> |        1 |          2 |        47314100 |        473 |           321 |
>>> |        1 |         10 |        47844900 |        478 |           326 |
>>> |        1 |        100 |        46591900 |        465 |           313 |
>>> |        1 |        200 |        47178900 |        471 |           319 |
>>> |----------+------------+-----------------+------------+---------------|
>>> |        1 |          0 |        46715800 |        467 |           315 |
>>> |        2 |          0 |       155134500 |       1551 |          1399 |
>>> |       10 |          0 |       442672800 |       4426 |          4274 |
>>> |      100 |          0 |      4092353900 |      40923 |         40771 |
>>> |      200 |          0 |      7135796400 |      71357 |         71205 |
>>> +----------+------------+-----------------+------------+---------------+
>>>
>>> Note: per-call overhead is estimated relative to the baseline case with
>>> 0 relevant tracers and 0 irrelevant tracers.
>>>
>>> As can be seen from the above:
>>>
>>>    a) Whenever there is a single relevant tracer function associated with a
>>>       tracee, the overhead of invoking the tracer is constant, and does not
>>>       scale with the number of tracers which are *not* associated with that
>>>       tracee.
>>>
>>>    b) The overhead for a single relevant tracer has dropped to ~1/3 of the
>>>       overhead prior to this series (from 1035ns to 315ns). This is largely
>>>       due to permitting calls to dynamically-allocated ftrace_ops without
>>>       going through ftrace_ops_list_func.
>>>
>>> Why is this patch a RFC patch:
>>>    1. I saw some rcu stalls on Qemu and need to debug them and see if they
>>>       were introduced by this patch.
>>
>>
>> FYI, I'm currently working on debugging such issues (and other) with the
>> *current* ftrace implementation, so probably not caused by your
>> patchset. But keep debugging too, maybe this introduces other issues or
>> even better, you'll find the root cause :)
>>
>>
>>>    2. This needs to be tested thoroughly on real hardware.
>>>    3. Seeking reviews to fix any fundamental problems with this patch that I
>>>       might have missed due to my lack of RISC-V architecture knowledge.
>>>    4. I would like to benchmark this on real hardware and put the results in
>>>       the commit message.
>>>
>>> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
>>> ---
>>>    arch/riscv/Kconfig              |  2 ++
>>>    arch/riscv/Makefile             |  8 +++++
>>>    arch/riscv/include/asm/ftrace.h |  3 ++
>>>    arch/riscv/kernel/asm-offsets.c |  3 ++
>>>    arch/riscv/kernel/ftrace.c      | 59 +++++++++++++++++++++++++++++++++
>>>    arch/riscv/kernel/mcount-dyn.S  | 42 ++++++++++++++++++++---
>>>    6 files changed, 112 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>> index 0bfcfec67ed5..e474742e23b2 100644
>>> --- a/arch/riscv/Kconfig
>>> +++ b/arch/riscv/Kconfig
>>> @@ -78,6 +78,7 @@ config RISCV
>>>        select EDAC_SUPPORT
>>>        select FRAME_POINTER if PERF_EVENTS || (FUNCTION_TRACER && !DYNAMIC_FTRACE)
>>>        select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if DYNAMIC_FTRACE
>>> +     select FUNCTION_ALIGNMENT_8B if DYNAMIC_FTRACE_WITH_CALL_OPS
>>
>>
>> A recent discussion [1] states that -falign-functions cannot guarantee
>> this alignment for all code and that gcc developers came up with a new
>> option [2]: WDYT? I have added Andy and Evgenii in +cc to help on that.
> 

Yes, the recent GCC supports -fmin-function-alignment option which makes 
sure all functions are properly aligned.

I used the following patch on top of Andy's patchset [3]:
-----------
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index b33b787c8b07..b831ae62672d 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -14,10 +14,15 @@ endif
  ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
  	LDFLAGS_vmlinux += --no-relax
  	KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
+ifeq ($(CONFIG_CC_IS_GCC),y)
+	CC_FLAGS_FTRACE := -fmin-function-alignment=4
+else
+	CC_FLAGS_FTRACE := -falign-functions=4
+endif
  ifeq ($(CONFIG_RISCV_ISA_C),y)
-	CC_FLAGS_FTRACE := -fpatchable-function-entry=12 -falign-functions=4
+	CC_FLAGS_FTRACE += -fpatchable-function-entry=12
  else
-	CC_FLAGS_FTRACE := -fpatchable-function-entry=6 -falign-functions=4
+	CC_FLAGS_FTRACE += -fpatchable-function-entry=6
  endif
  endif

-----------

We probably need something like this in arch/riscv/Kconfig as well, to 
allow dynamic Ftrace only if GCC supports -fmin-function-alignment:
-----------
  config GCC_SUPPORTS_DYNAMIC_FTRACE
  	def_bool CC_IS_GCC
-	depends on $(cc-option,-fpatchable-function-entry=8)
+	depends on $(cc-option,-fpatchable-function-entry=6)
+	depends on $(cc-option,-fmin-function-alignment=4)
-----------


> I saw arm64 uses the same and assumes this guarantee, maybe it is broken too?
> Will look into the discussion and try to use the other option. I am
> currently using Clang to build the kernel.

I tried dynamic Ftrace with clang too (LLVM 17.0.6 built from the 
official RISC-V toolchain). It seems, clang has no problems with 
alignment of functions, unlike GCC, and 'falign-functions=4' is enough 
to align everything properly.

However, there is a serious issue with clang and dynamic Ftrace: [4].

In short: for static functions with 9 or more arguments, like 
__find_rr_leaf 
(https://elixir.bootlin.com/linux/v6.8-rc4/source/net/ipv6/route.c#L786), 
clang may switch to "fastcall" calling convention. This way, the 9th 
argument will be passed in the register t2, the 10th - in t3, etc., 
rather than on the stack like RISC-V ABI requires.

This causes kernel craches when trying to enable "function", 
"function_graph" and other tracers for such functions. The 
implementation of Ftrace assumes that t0 - t3 can be safely clobbered at 
the beginning of the function. clang assumes otherwise.

Unless a compiler option or something to disable switching to fastcall 
convention is added (there is currently no such option in clang, it 
seems), dynamic Ftrace cannot be used safely with clang-built kernels.

> 
>>
>> [1]
>> https://lore.kernel.org/linux-riscv/4fe4567b-96be-4102-952b-7d39109b2186@yadro.com/
>> [2]
>> https://gcc.gnu.org/git/gitweb.cgi?p=gcc.git;h=0f5a9a00e3ab1fe96142f304cfbcf3f63b15f326
>>
>>
>>>        select GENERIC_ARCH_TOPOLOGY
>>>        select GENERIC_ATOMIC64 if !64BIT
>>>        select GENERIC_CLOCKEVENTS_BROADCAST if SMP
>>> @@ -127,6 +128,7 @@ config RISCV
>>>        select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && (CLANG_SUPPORTS_DYNAMIC_FTRACE || GCC_SUPPORTS_DYNAMIC_FTRACE)
>>>        select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>>>        select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
>>> +     select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS if (DYNAMIC_FTRACE_WITH_REGS && !CFI_CLANG)
>>>        select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
>>>        select HAVE_FUNCTION_GRAPH_TRACER
>>>        select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
>>> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
>>> index 252d63942f34..875ad5dc3d32 100644
>>> --- a/arch/riscv/Makefile
>>> +++ b/arch/riscv/Makefile
>>> @@ -14,12 +14,20 @@ endif
>>>    ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
>>>        LDFLAGS_vmlinux += --no-relax
>>>        KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
>>> +ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS), y)
>>> +ifeq ($(CONFIG_RISCV_ISA_C),y)
>>> +     CC_FLAGS_FTRACE := -fpatchable-function-entry=8,4
>>> +else
>>> +     CC_FLAGS_FTRACE := -fpatchable-function-entry=4,2
>>> +endif
>>> +else
>>>    ifeq ($(CONFIG_RISCV_ISA_C),y)
>>>        CC_FLAGS_FTRACE := -fpatchable-function-entry=4
>>>    else
>>>        CC_FLAGS_FTRACE := -fpatchable-function-entry=2
>>>    endif
>>>    endif
>>> +endif
>>>
>>>    ifeq ($(CONFIG_CMODEL_MEDLOW),y)
>>>    KBUILD_CFLAGS_MODULE += -mcmodel=medany
>>> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
>>> index 329172122952..c9a84222c9ea 100644
>>> --- a/arch/riscv/include/asm/ftrace.h
>>> +++ b/arch/riscv/include/asm/ftrace.h
>>> @@ -28,6 +28,9 @@
>>>    void MCOUNT_NAME(void);
>>>    static inline unsigned long ftrace_call_adjust(unsigned long addr)
>>>    {
>>> +     if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
>>> +             return addr + 8;
>>> +
>>>        return addr;
>>>    }
>>>
>>> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
>>> index a03129f40c46..7d7c4b486852 100644
>>> --- a/arch/riscv/kernel/asm-offsets.c
>>> +++ b/arch/riscv/kernel/asm-offsets.c
>>> @@ -488,4 +488,7 @@ void asm_offsets(void)
>>>        DEFINE(STACKFRAME_SIZE_ON_STACK, ALIGN(sizeof(struct stackframe), STACK_ALIGN));
>>>        OFFSET(STACKFRAME_FP, stackframe, fp);
>>>        OFFSET(STACKFRAME_RA, stackframe, ra);
>>> +#ifdef CONFIG_FUNCTION_TRACER
>>> +     DEFINE(FTRACE_OPS_FUNC,         offsetof(struct ftrace_ops, func));
>>> +#endif
>>>    }
>>> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
>>> index f5aa24d9e1c1..e2e75e15d32e 100644
>>> --- a/arch/riscv/kernel/ftrace.c
>>> +++ b/arch/riscv/kernel/ftrace.c
>>> @@ -82,9 +82,52 @@ static int __ftrace_modify_call(unsigned long hook_pos, unsigned long target,
>>>        return 0;
>>>    }
>>>
>>> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
>>> +static const struct ftrace_ops *riscv64_rec_get_ops(struct dyn_ftrace *rec)
>>> +{
>>> +     const struct ftrace_ops *ops = NULL;
>>> +
>>> +     if (rec->flags & FTRACE_FL_CALL_OPS_EN) {
>>> +             ops = ftrace_find_unique_ops(rec);
>>> +             WARN_ON_ONCE(!ops);
>>> +     }
>>> +
>>> +     if (!ops)
>>> +             ops = &ftrace_list_ops;
>>> +
>>> +     return ops;
>>> +}
>>> +
>>> +static int ftrace_rec_set_ops(const struct dyn_ftrace *rec,
>>> +                           const struct ftrace_ops *ops)
>>> +{
>>> +     unsigned long literal = rec->ip - 8;
>>> +
>>> +     return patch_text_nosync((void *)literal, &ops, sizeof(ops));
> 
> ^^
> I will change this to use a new function that does a 64 bit write and
> doesn't do flush_icache_range() as naturally aligned writes are
> atomic and therefore synchronization is not required here.
> 
>>> +}
>>> +
>>> +static int ftrace_rec_set_nop_ops(struct dyn_ftrace *rec)
>>> +{
>>> +     return ftrace_rec_set_ops(rec, &ftrace_nop_ops);
>>> +}
>>> +
>>> +static int ftrace_rec_update_ops(struct dyn_ftrace *rec)
>>> +{
>>> +     return ftrace_rec_set_ops(rec, riscv64_rec_get_ops(rec));
>>> +}
>>> +#else
>>> +static int ftrace_rec_set_nop_ops(struct dyn_ftrace *rec) { return 0; }
>>> +static int ftrace_rec_update_ops(struct dyn_ftrace *rec) { return 0; }
>>> +#endif
>>> +
>>>    int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>>>    {
>>>        unsigned int call[2];
>>> +     int ret;
>>> +
>>> +     ret = ftrace_rec_update_ops(rec);
>>> +     if (ret)
>>> +             return ret;
>>>
>>>        make_call_t0(rec->ip, addr, call);
>>>
>>> @@ -98,6 +141,11 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
>>>                    unsigned long addr)
>>>    {
>>>        unsigned int nops[2] = {NOP4, NOP4};
>>> +     int ret;
>>> +
>>> +     ret = ftrace_rec_set_nop_ops(rec);
>>> +     if (ret)
>>> +             return ret;
>>>
>>>        if (patch_text_nosync((void *)rec->ip, nops, MCOUNT_INSN_SIZE))
>>>                return -EPERM;
>>> @@ -125,6 +173,13 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
>>>
>>>    int ftrace_update_ftrace_func(ftrace_func_t func)
>>>    {
>>> +     /*
>>> +      * When using CALL_OPS, the function to call is associated with the
>>> +      * call site, and we don't have a global function pointer to update.
>>> +      */
>>> +     if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
>>> +             return 0;
>>> +
>>>        int ret = __ftrace_modify_call((unsigned long)&ftrace_call,
>>>                                       (unsigned long)func, true, true);
>>>        if (!ret) {
>>> @@ -147,6 +202,10 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
>>>        make_call_t0(caller, old_addr, call);
>>>        ret = ftrace_check_current_call(caller, call);
>>>
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     ret = ftrace_rec_update_ops(rec);
>>>        if (ret)
>>>                return ret;
>>>
>>> diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
>>> index b7561288e8da..cb241e36e514 100644
>>> --- a/arch/riscv/kernel/mcount-dyn.S
>>> +++ b/arch/riscv/kernel/mcount-dyn.S
>>> @@ -191,11 +191,35 @@
>>>        .endm
>>>
>>>        .macro PREPARE_ARGS
>>> -     addi    a0, t0, -FENTRY_RA_OFFSET
>>> +     addi    a0, t0, -FENTRY_RA_OFFSET       // ip (callsite's auipc insn)
>>> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
>>> +     /*
>>> +      * When CALL_OPS is enabled (2 or 4) nops [8B] are placed before the
>>> +      * function entry, these are later overwritten with the pointer to the
>>> +      * associated struct ftrace_ops.
>>> +      *
>>> +      * -8: &ftrace_ops of the associated tracer function.
>>> +      *<ftrace enable>:
>>> +      *  0: auipc  t0/ra, 0x?
>>> +      *  4: jalr   t0/ra, ?(t0/ra)
>>> +      *
>>> +      * -8: &ftrace_nop_ops
>>> +      *<ftrace disable>:
>>> +      *  0: nop
>>> +      *  4: nop
>>> +      *
>>> +      * t0 is set to ip+8 after the jalr is executed at the callsite,
>>> +      * so we find the associated op at t0-16.
>>> +      */
>>> +     mv      a1, ra                          // parent_ip
>>> +     REG_L   a2, -16(t0)                     // op
>>> +     REG_L   ra, FTRACE_OPS_FUNC(a2)         // op->func
>>> +#else
>>>        la      a1, function_trace_op
>>> -     REG_L   a2, 0(a1)
>>> -     mv      a1, ra
>>> -     mv      a3, sp
>>> +     REG_L   a2, 0(a1)                       // op
>>> +     mv      a1, ra                          // parent_ip
>>> +#endif
>>> +     mv      a3, sp                          // regs
>>>        .endm
>>>
>>>    #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
>>> @@ -233,8 +257,12 @@ SYM_FUNC_START(ftrace_regs_caller)
>>>        SAVE_ABI_REGS 1
>>>        PREPARE_ARGS
>>>
>>> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
>>> +     jalr ra
>>> +#else
>>>    SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
>>>        call    ftrace_stub
>>> +#endif
>>>
>>>        RESTORE_ABI_REGS 1
>>>        bnez    t1, .Ldirect
>>> @@ -247,9 +275,13 @@ SYM_FUNC_START(ftrace_caller)
>>>        SAVE_ABI_REGS 0
>>>        PREPARE_ARGS
>>>
>>> -SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
> 
> ^^ this hunk is a mistake, I will fix it in the next version.
> 
>>> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
>>> +     jalr ra
>>> +#else
>>> +SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
>>>        call    ftrace_stub
>>>
>>> +#endif
>>>        RESTORE_ABI_REGS 0
>>>        jr      t0
>>>    SYM_FUNC_END(ftrace_caller)
>>
>>
>> As I'm diving into ftrace right now, I'll give a proper review soon. But
>> as a note, I noticed that the function_graph tracer, when enabled, makes
>> the whole system unresponsive (but still up, just very slow). A fix I
>> sent recently seems to really improve that if you're interested in
>> testing it (I am :)). You can find it here:
>> https://lore.kernel.org/linux-riscv/20240229121056.203419-1-alexghiti@rivosinc.com/
> 
> I saw the same issue where function_graph was making the system slow on Qemu.
> What hardware do you use for testing? or are you testing on Qemu as well?
> 
> I tested your patch, it speeds up the process of patching the
> instructions so the following
> command completes ~2.5 seconds faster compared to without your patch.
> $ time echo function_graph > current_tracer
> 
> But at runtime the system is still slow and laggy with function_graph,
> I guess because my
> Qemu setup is not powerful enough to run function_graph.
> 
> Thanks,
> Puranjay
> 

[3] 
https://lore.kernel.org/all/CAJF2gTRc487qEme5tQw4ich5xuf8_DYhTB8fp=TXav3Gs4KWnQ@mail.gmail.com/T/#mdba180cfd0c9a6df3da49e9c330649ce5151a24a

[4] https://github.com/llvm/llvm-project/issues/83111 - "RISC-V ABI 
break: x7/t2 register is used to pass the 9th argument to a function in 
certain cases"

Regards,
Evgenii

