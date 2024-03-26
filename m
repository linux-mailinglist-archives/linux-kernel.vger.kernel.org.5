Return-Path: <linux-kernel+bounces-120042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 081DB88D0C6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41947B21B0A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7250713DDAA;
	Tue, 26 Mar 2024 22:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l37iR5Ar"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE9F1CAAE;
	Tue, 26 Mar 2024 22:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492104; cv=none; b=tSSO5mgKQDgHmsehzi2CwGLQyHSz7uKzeoLXCJC8jY/rS2fgr5W0+3XqJNUIWTpBbGB09XQuqzCoQc7ZQHC3VSNwpXHOTLH6bYa7QhWy0pfyG0yTXRE4FrmtlpSmZD0ytq0xv6ZkS81ogNW1Z9roMsC+xpj3dAuw/JPWitVyDlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492104; c=relaxed/simple;
	bh=wzezVpTVwGfJv1k3aAJcJyIzoh8AVwmzflZyyOUxAB8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ieIwOjI+Bi6j40a5uFWr9bhN7rQXjz0L75+lbisGPwFp0s4KyixtDvzUFyA7njQwhiEfEryDagb+Y2v42CNheRudWa+b5HDw6GQc1Lm8lEaxyv26WmhxBJAJMjiGHDraCqxoQbkKE3IkZIahHdDTfcDCn/cch+1z5b7Xdekm9j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l37iR5Ar; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4148f00fa66so10560025e9.0;
        Tue, 26 Mar 2024 15:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711492101; x=1712096901; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=L+iANpX1WYT9Q+zJXFdaMUHrlAg8xnNgWmXswE8pd2Q=;
        b=l37iR5ArgvjPvArSzhD3nKp2aNuVz8SKj1jY5Q6wATI/2CRbnII6A2KTFTMPx2k4Z1
         Lgno7SiAf7qG1/BpvYn1r35pjblEDcy+GX+r9N0EYHOIiXf0v4Hls43ekQe/i7r/Q6iO
         6n3fb1j07aqxfqObG5m54pQXFvw6auqeRvM0LhSFjYC38MEEkn4b9aa8exGNC21W6nJW
         7vRjmB5b/Nf12WCnJskf+zkCGNQPkhm4DquiTXpgINFbQnVxu+HJ88RQxei+wDvohWOI
         usZaSIhhKOUTZuTxad1PfymwskYLKctQPEnIBjvpUOP65+EmnLvf99WEwSk/EdJRqNiI
         /ZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711492101; x=1712096901;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+iANpX1WYT9Q+zJXFdaMUHrlAg8xnNgWmXswE8pd2Q=;
        b=etk5X176kSEZyuMsRLSVbm/S/Pr4TCS81B5REttyoWRDYofibKA1CmWjSVuv7m0aPc
         uQl++0im/yGvvvDHRtXIlppaJMWqh99L5af9oqcwmrt6mWpx9MNGFitBYbkIdISXzcd3
         2fRINZYZSX+I9a1xzxBuQt5YPp1kZJ7v+xqrWl9uB+NvZdaWP0/1yUM7BvnQ+0duXz56
         6yYv6YF2dzkHLIczsdzto7Nl3R/8PdnNDCNIt8sFSa0s9EXOYDRqtSv1vvv6wHT6ey7Z
         ksYlGSbffKZrFlo1DVrQvF8+VEly+l4ZVlJkGjDLKhyRp8mxOlwzGsZLHyA39VtdhRFX
         mRFA==
X-Forwarded-Encrypted: i=1; AJvYcCW9czZ21KD6eu3iv3M0Tsi1+g7QUJV6D14hRwO0D2/2rEO4q/Zb0cJ+HYfJLyQhY1yYfvHq7cYSR6sZJfxw0NRksPZ/8LUUJS1dCfFwZN5wZoZDoP4g4ajj+N4BpABtl+hc
X-Gm-Message-State: AOJu0YyZctXJjMuNIc+uEEU31Q2hM73bozPYMKvUbrwKZSgEgz0Gruau
	qbAtCixfYr0y2/0PvkTAuSaI3b8iBbct7b5JAD2HRKbRZ67qCodi
X-Google-Smtp-Source: AGHT+IFYWqnB/4pWM90qbOyAvSoGbYdjKsraFY5eCFyzaRf55vrwKtCoUxRSPOXPnm0AyhZbiqnp+w==
X-Received: by 2002:a05:600c:4751:b0:413:f4d1:199e with SMTP id w17-20020a05600c475100b00413f4d1199emr733680wmo.31.1711492100325;
        Tue, 26 Mar 2024 15:28:20 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id e6-20020a05600c4b8600b004132ae838absm228058wmp.43.2024.03.26.15.28.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2024 15:28:19 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Zi Shen Lim <zlim.lnx@gmail.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Mark Brown <broonie@kernel.org>,
 linux-arm-kernel@lists.infradead.org, open list
 <linux-kernel@vger.kernel.org>, "open list:BPF [GENERAL] (Safe Dynamic
 Programs and Tools)" <bpf@vger.kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>
Subject: Re: [PATCH bpf-next v2 1/1] arm64/cfi,bpf: Support kCFI + BPF on arm64
In-Reply-To: <ZgMbFqWpmZgahiV6@FVFF77S0Q05N.cambridge.arm.com>
References: <20240324211518.93892-1-puranjay12@gmail.com>
 <20240324211518.93892-2-puranjay12@gmail.com>
 <ZgMbFqWpmZgahiV6@FVFF77S0Q05N.cambridge.arm.com>
Date: Tue, 26 Mar 2024 22:28:06 +0000
Message-ID: <mb61pv858vdah.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mark Rutland <mark.rutland@arm.com> writes:

> Hi Puranjay,
>
> On Sun, Mar 24, 2024 at 09:15:18PM +0000, Puranjay Mohan wrote:
>> Currently, bpf_dispatcher_*_func() is marked with `__nocfi` therefore
>> calling BPF programs from this interface doesn't cause CFI warnings.
>> 
>> When BPF programs are called directly from C: from BPF helpers or
>> struct_ops, CFI warnings are generated.
>> 
>> Implement proper CFI prologues for the BPF programs and callbacks and
>> drop __nocfi for arm64. Fix the trampoline generation code to emit kCFI
>> prologue when a struct_ops trampoline is being prepared.
>> 
>> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
>
> Presumably this'll need a Cc stable and a Fixes tag?

Thanks for mentioning, I will find out from what commit this is broken.

>
>> ---
>>  arch/arm64/include/asm/cfi.h    | 23 ++++++++++++++
>>  arch/arm64/kernel/alternative.c | 54 +++++++++++++++++++++++++++++++++
>>  arch/arm64/net/bpf_jit_comp.c   | 28 +++++++++++++----
>>  3 files changed, 99 insertions(+), 6 deletions(-)
>>  create mode 100644 arch/arm64/include/asm/cfi.h
>> 
>> diff --git a/arch/arm64/include/asm/cfi.h b/arch/arm64/include/asm/cfi.h
>> new file mode 100644
>> index 000000000000..670e191f8628
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/cfi.h
>> @@ -0,0 +1,23 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_ARM64_CFI_H
>> +#define _ASM_ARM64_CFI_H
>> +
>> +#ifdef CONFIG_CFI_CLANG
>> +#define __bpfcall
>> +static inline int cfi_get_offset(void)
>> +{
>> +	return 4;
>> +}
>> +#define cfi_get_offset cfi_get_offset
>> +extern u32 cfi_bpf_hash;
>> +extern u32 cfi_bpf_subprog_hash;
>> +extern u32 cfi_get_func_hash(void *func);
>> +#else
>> +#define cfi_bpf_hash 0U
>> +#define cfi_bpf_subprog_hash 0U
>> +static inline u32 cfi_get_func_hash(void *func)
>> +{
>> +	return 0;
>> +}
>> +#endif /* CONFIG_CFI_CLANG */
>> +#endif /* _ASM_ARM64_CFI_H */
>> diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
>> index 8ff6610af496..1715da7df137 100644
>> --- a/arch/arm64/kernel/alternative.c
>> +++ b/arch/arm64/kernel/alternative.c
>> @@ -13,6 +13,7 @@
>>  #include <linux/elf.h>
>>  #include <asm/cacheflush.h>
>>  #include <asm/alternative.h>
>> +#include <asm/cfi.h>
>>  #include <asm/cpufeature.h>
>>  #include <asm/insn.h>
>>  #include <asm/module.h>
>> @@ -298,3 +299,56 @@ noinstr void alt_cb_patch_nops(struct alt_instr *alt, __le32 *origptr,
>>  		updptr[i] = cpu_to_le32(aarch64_insn_gen_nop());
>>  }
>>  EXPORT_SYMBOL(alt_cb_patch_nops);
>> +
>> +#ifdef CONFIG_CFI_CLANG
>> +struct bpf_insn;
>> +
>> +/* Must match bpf_func_t / DEFINE_BPF_PROG_RUN() */
>> +extern unsigned int __bpf_prog_runX(const void *ctx,
>> +				    const struct bpf_insn *insn);
>> +
>> +/*
>> + * Force a reference to the external symbol so the compiler generates
>> + * __kcfi_typid.
>> + */
>> +__ADDRESSABLE(__bpf_prog_runX);
>> +
>> +/* u32 __ro_after_init cfi_bpf_hash = __kcfi_typeid___bpf_prog_runX; */
>> +asm (
>> +"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"
>> +"	.type	cfi_bpf_hash,@object				\n"
>> +"	.globl	cfi_bpf_hash					\n"
>> +"	.p2align	2, 0x0					\n"
>> +"cfi_bpf_hash:							\n"
>> +"	.word	__kcfi_typeid___bpf_prog_runX			\n"
>> +"	.size	cfi_bpf_hash, 4					\n"
>> +"	.popsection						\n"
>> +);
>> +
>> +/* Must match bpf_callback_t */
>> +extern u64 __bpf_callback_fn(u64, u64, u64, u64, u64);
>> +
>> +__ADDRESSABLE(__bpf_callback_fn);
>> +
>> +/* u32 __ro_after_init cfi_bpf_subprog_hash = __kcfi_typeid___bpf_callback_fn; */
>> +asm (
>> +"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"
>> +"	.type	cfi_bpf_subprog_hash,@object			\n"
>> +"	.globl	cfi_bpf_subprog_hash				\n"
>> +"	.p2align	2, 0x0					\n"
>> +"cfi_bpf_subprog_hash:						\n"
>> +"	.word	__kcfi_typeid___bpf_callback_fn			\n"
>> +"	.size	cfi_bpf_subprog_hash, 4				\n"
>> +"	.popsection						\n"
>> +);
>> +
>> +u32 cfi_get_func_hash(void *func)
>> +{
>> +	u32 hash;
>> +
>> +	if (get_kernel_nofault(hash, func - cfi_get_offset()))
>> +		return 0;
>> +
>> +	return hash;
>> +}
>> +#endif
>
> I realise this is following the example of x86, but this has nothing to do with
> alternatives, so could we please place it elsewhere? e.g. add a new
> arch/arm64/net/bpf_cfi.c?

Sure, a new file would work.
How about: arch/arm64/kernel/cfi.c

>
> Which functions is cfi_get_func_hash() used against? The comment in the code
> below says:
>
> 	if (flags & BPF_TRAMP_F_INDIRECT) {
> 		/*
> 		 * Indirect call for bpf_struct_ops
> 		 */
> 		emit_kcfi(cfi_get_func_hash(func_addr), ctx);
> 	}
>
> ... but it's not clear to me which functions specifically would be in that
> 'func_addr', not why returning 0 is fine -- surely we should fail compilation
> if the provided function pointer causes a fault and we don't have a valid
> typeid?

'func_addr' will have one of the cfi_stubs like in net/ipv4/bpf_tcp_ca.c
Explained in more detail below:

>> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
>> index bc16eb694657..2372812bb47c 100644
>> --- a/arch/arm64/net/bpf_jit_comp.c
>> +++ b/arch/arm64/net/bpf_jit_comp.c
>> @@ -17,6 +17,7 @@
>>  #include <asm/asm-extable.h>
>>  #include <asm/byteorder.h>
>>  #include <asm/cacheflush.h>
>> +#include <asm/cfi.h>
>>  #include <asm/debug-monitors.h>
>>  #include <asm/insn.h>
>>  #include <asm/patching.h>
>> @@ -158,6 +159,12 @@ static inline void emit_bti(u32 insn, struct jit_ctx *ctx)
>>  		emit(insn, ctx);
>>  }
>>  
>> +static inline void emit_kcfi(u32 hash, struct jit_ctx *ctx)
>> +{
>> +	if (IS_ENABLED(CONFIG_CFI_CLANG))
>> +		emit(hash, ctx);
>> +}
>> +
>>  /*
>>   * Kernel addresses in the vmalloc space use at most 48 bits, and the
>>   * remaining bits are guaranteed to be 0x1. So we can compose the address
>> @@ -295,7 +302,7 @@ static bool is_lsi_offset(int offset, int scale)
>>  #define PROLOGUE_OFFSET (BTI_INSNS + 2 + PAC_INSNS + 8)
>>  
>>  static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
>> -			  bool is_exception_cb)
>> +			  bool is_exception_cb, bool is_subprog)
>>  {
>>  	const struct bpf_prog *prog = ctx->prog;
>>  	const bool is_main_prog = !bpf_is_subprog(prog);
>> @@ -306,7 +313,6 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
>>  	const u8 fp = bpf2a64[BPF_REG_FP];
>>  	const u8 tcc = bpf2a64[TCALL_CNT];
>>  	const u8 fpb = bpf2a64[FP_BOTTOM];
>> -	const int idx0 = ctx->idx;
>>  	int cur_offset;
>>  
>>  	/*
>> @@ -332,6 +338,8 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
>>  	 *
>>  	 */
>>  
>> +	emit_kcfi(is_subprog ? cfi_bpf_subprog_hash : cfi_bpf_hash, ctx);
>> +	const int idx0 = ctx->idx;
>>  	/* bpf function may be invoked by 3 instruction types:
>>  	 * 1. bl, attached via freplace to bpf prog via short jump
>>  	 * 2. br, attached via freplace to bpf prog via long jump
>> @@ -1648,7 +1656,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>  	 * BPF line info needs ctx->offset[i] to be the offset of
>>  	 * instruction[i] in jited image, so build prologue first.
>>  	 */
>> -	if (build_prologue(&ctx, was_classic, prog->aux->exception_cb)) {
>> +	if (build_prologue(&ctx, was_classic, prog->aux->exception_cb,
>> +			   bpf_is_subprog(prog))) {
>>  		prog = orig_prog;
>>  		goto out_off;
>>  	}
>> @@ -1696,7 +1705,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>  	ctx.idx = 0;
>>  	ctx.exentry_idx = 0;
>>  
>> -	build_prologue(&ctx, was_classic, prog->aux->exception_cb);
>> +	build_prologue(&ctx, was_classic, prog->aux->exception_cb,
>> +		       bpf_is_subprog(prog));
>>  
>>  	if (build_body(&ctx, extra_pass)) {
>>  		prog = orig_prog;
>> @@ -1745,9 +1755,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>  		jit_data->ro_header = ro_header;
>>  	}
>>  
>> -	prog->bpf_func = (void *)ctx.ro_image;
>> +	prog->bpf_func = (void *)ctx.ro_image + cfi_get_offset();
>>  	prog->jited = 1;
>> -	prog->jited_len = prog_size;
>> +	prog->jited_len = prog_size - cfi_get_offset();
>>  
>>  	if (!prog->is_func || extra_pass) {
>>  		int i;
>> @@ -2011,6 +2021,12 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>>  	/* return address locates above FP */
>>  	retaddr_off = stack_size + 8;
>>  
>> +	if (flags & BPF_TRAMP_F_INDIRECT) {
>> +		/*
>> +		 * Indirect call for bpf_struct_ops
>> +		 */
>> +		emit_kcfi(cfi_get_func_hash(func_addr), ctx);
>> +	}
>
> I'm confused; why does the trampoline need this?
>
> The code that branches to the trampoline doesn't check the type hash: either
> the callsite branches directly (hence no check), or the common ftrace
> trampoline does so indirectly, and the latter doesn't know the expected typeid,
> so it cannot check.

This is not used when the trampoline is attached to the entry of a
kernel function and called through a direct call or from ftrace_caller.

This is only used when we are building a trampoline for bpf_struct_ops.

Here a kernel subsystem can call this trampoline through a function
pointer.

See: tools/testing/selftests/bpf/progs/bpf_dctcp.c

Here tcp_congestion_ops functions are implemented in BPF and
registered with the networking subsystem.

So, the networking subsystem will call them directly for example like:

struct tcp_congestion_ops *ca_ops = ....

ca_ops->cwnd_event(sk, event);

cwnd_event() is implemented in BPF and this call will land on a
trampoline. Because this is being called from the kernel through a
function pointer, type_id will be checked. So, the landing location in
the trampoline should have a type_id above it.

In the above example kernel is calling a function of type
void cwnd_event(struct sock *sk, enum tcp_ca_event ev);

so the calling code will fetch the type_id from above the destination
and compare it with the type_id of the above prototype.

To make this work with BPF trampolines, we define stubs while
registering these struct_ops with the BPF subsystem.

Like in net/ipv4/bpf_tcp_ca.c
a stub is defined like following:

static void bpf_tcp_ca_cwnd_event(struct sock *sk, enum tcp_ca_event ev)
{
}

This is what `func_addr` will have in the prepare_trampoline() function
and we use cfi_get_func_hash() to fetch the type_id and put it above the
landing location in the trampoline.

> If we wanted a tpyeid here, that should probably be distinct from the original
> function tpyeid, since the trampoline calling convention is different.

Here the trampoline is called using standard calling convention and the
type_id is dependent on the prototype of the called function.

> IIUC this isn't reachable today regardless since CALL_OPS and KCFI are
> currently mutually exclusive.

As explained above, this kind of the BPF trampoline is not called from
function entry through a direct call so CALL_OPS is not required for
this usage.

I am not well versed with the in-depth implementation of struct_ops, so
maybe Alexei can explain more about this feature or correct me if I miss
represented some fact.

Thanks,
Puranjay

