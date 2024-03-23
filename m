Return-Path: <linux-kernel+bounces-112248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0D2887767
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 08:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 564C61C223A6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 07:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98507C157;
	Sat, 23 Mar 2024 07:19:46 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7A24C6B;
	Sat, 23 Mar 2024 07:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711178386; cv=none; b=hk1wcy70YFUvV7l6fmmBzQJrpwPAyGxa9nUKTTiRfZvs87ofO94QKky2TZtk2B3dobT7XMJ4iQltHuGBV8HbFzA4dw2Tv60PX7uIvIqGmWm5kiHZhYeXf1vEb6P8AgfzUb1q7s5sYtYGbkqQrSziFas0FSTMpTyv/YnhzmjAQ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711178386; c=relaxed/simple;
	bh=BArv9evpT+BKy2w6n6EkUPpK2VXQxbIwzSDdG+dzDoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SnYGKENZdYb0r2ZYtdG51hQHkcz+IQvM6RvzbmbUe2pms63elg/j5N4AQVRH2QzqpbVdaXXty9e1jkcRC4phPzL07VqNnOfqu6UsS8vA7AA4zf38Ax0K/i8pIpFapz0LT58TkA6gD+9fyPciweyt862Zh2eADG9Zp5A6bNY6G7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4V1rDH4Cdhz4f3khb;
	Sat, 23 Mar 2024 15:19:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A4F6E1A016E;
	Sat, 23 Mar 2024 15:19:33 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgDXJ2qEgv5ld8PLHw--.64132S2;
	Sat, 23 Mar 2024 15:19:33 +0800 (CST)
Message-ID: <5c66cb9a-8f6e-4839-a590-ffc0d411333e@huaweicloud.com>
Date: Sat, 23 Mar 2024 15:19:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/2] bpf: Add arm64 JIT support for
 bpf_addr_space_cast instruction.
Content-Language: en-US
To: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Zi Shen Lim <zlim.lnx@gmail.com>
References: <20240321153102.103832-1-puranjay12@gmail.com>
 <20240321153102.103832-3-puranjay12@gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20240321153102.103832-3-puranjay12@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDXJ2qEgv5ld8PLHw--.64132S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1xXr17Xw4fAw1fAw4UCFg_yoWrKrWkpF
	sxZ3ySkw4vqw1UZFyfArsrWr4F9an7uF40gFy5GrWftr1jqF9rGF1IkFW5CrZ8GFy5Ww4r
	CFW2kry3ua9rX37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 3/21/2024 11:31 PM, Puranjay Mohan wrote:
> LLVM generates bpf_addr_space_cast instruction while translating
> pointers between native (zero) address space and
> __attribute__((address_space(N))). The addr_space=1 is reserved as
> bpf_arena address space.
> 
> rY = addr_space_cast(rX, 0, 1) is processed by the verifier and
> converted to normal 32-bit move: wX = wY
> 
> rY = addr_space_cast(rX, 1, 0) has to be converted by JIT:
> 
> Here I explain using symbolic language what the JIT is supposed to do:
> We have:
> 	src = [src_upper32][src_lower32] // 64 bit src kernel pointer
> 	uvm = [uvm_upper32][uvm_lower32] // 64 bit user_vm_start
> 
> The JIT has to make the dst reg like following
> 	dst = [uvm_upper32][src_lower32] // if src_lower32 != 0
> 	dst = [00000000000][00000000000] // if src_lower32 == 0
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>   arch/arm64/net/bpf_jit.h                     |  1 +
>   arch/arm64/net/bpf_jit_comp.c                | 35 ++++++++++++++++++++
>   tools/testing/selftests/bpf/DENYLIST.aarch64 |  2 --
>   3 files changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
> index 23b1b34db088..813c3c428fde 100644
> --- a/arch/arm64/net/bpf_jit.h
> +++ b/arch/arm64/net/bpf_jit.h
> @@ -238,6 +238,7 @@
>   #define A64_LSLV(sf, Rd, Rn, Rm) A64_DATA2(sf, Rd, Rn, Rm, LSLV)
>   #define A64_LSRV(sf, Rd, Rn, Rm) A64_DATA2(sf, Rd, Rn, Rm, LSRV)
>   #define A64_ASRV(sf, Rd, Rn, Rm) A64_DATA2(sf, Rd, Rn, Rm, ASRV)
> +#define A64_RORV(sf, Rd, Rn, Rm) A64_DATA2(sf, Rd, Rn, Rm, RORV)
>   
>   /* Data-processing (3 source) */
>   /* Rd = Ra + Rn * Rm */
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index b9b5febe64f0..37c94ebd06b2 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -82,6 +82,7 @@ struct jit_ctx {
>   	__le32 *ro_image;
>   	u32 stack_size;
>   	int fpb_offset;
> +	u64 user_vm_start;
>   };
>   
>   struct bpf_plt {
> @@ -868,6 +869,34 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
>   	/* dst = src */
>   	case BPF_ALU | BPF_MOV | BPF_X:

is it legal to encode BPF_ADDR_SPACE_CAST with BPF_ALU?

>   	case BPF_ALU64 | BPF_MOV | BPF_X:
> +		if (insn->off == BPF_ADDR_SPACE_CAST &&
> +		    insn->imm == 1U << 16) {
> +			/* Zero out tmp2 */
> +			emit(A64_EOR(1, tmp2, tmp2, tmp2), ctx);
> +
> +			/* Move lo_32_bits(src) to dst */
> +			if (dst != src)
> +				emit(A64_MOV(0, dst, src), ctx);
> +
> +			/* Logical shift left by 32 bits */
> +			emit(A64_LSL(1, dst, dst, 32), ctx);
> +
> +			/* Get upper 32 bits of user_vm_start in tmp */
> +			emit_a64_mov_i(0, tmp, ctx->user_vm_start >> 32, ctx);
> +
> +			/* dst |= up_32_bits(user_vm_start) */
> +			emit(A64_ORR(1, dst, dst, tmp), ctx);
> +
> +			/* Rotate by 32 bits to get final result */
> +			emit_a64_mov_i(0, tmp, 32, ctx);
> +			emit(A64_RORV(1, dst, dst, tmp), ctx);
> +
> +			/* If lo_32_bits(dst) == 0, set dst = tmp2(0) */
> +			emit(A64_CBZ(0, dst, 2), ctx);
> +			emit(A64_MOV(1, tmp2, dst), ctx);
> +			emit(A64_MOV(1, dst, tmp2), ctx);

seems we could simplify it to:

emit_a64_mov_i(0, dst, ctx->user_vm_start >> 32, ctx);
emit(A64_LSL(1, dst, dst, 32), ctx);
emit(A64_MOV(0, tmp, src), ctx); // 32-bit mov clears the upper 32 bits
emit(A64_CBZ(1, tmp, 2), ctx);
emit(A64_ORR(1, tmp, dst, tmp), ctx);
emit(A64_MOV(1, dst, tmp), ctx);

> +		break;

not aligned

> +		}
>   		switch (insn->off) {
>   		case 0:
>   			emit(A64_MOV(is64, dst, src), ctx);
> @@ -1690,6 +1719,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>   	}
>   
>   	ctx.fpb_offset = find_fpb_offset(prog);
> +	ctx.user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
>   
>   	/*
>   	 * 1. Initial fake pass to compute ctx->idx and ctx->offset.
> @@ -2511,6 +2541,11 @@ bool bpf_jit_supports_exceptions(void)
>   	return true;
>   }
>   
> +bool bpf_jit_supports_arena(void)
> +{
> +	return true;
> +}
> +
>   void bpf_jit_free(struct bpf_prog *prog)
>   {
>   	if (prog->jited) {
> diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
> index d8ade15e2789..0445ac38bc07 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
> +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
> @@ -10,5 +10,3 @@ fill_link_info/kprobe_multi_link_info            # bpf_program__attach_kprobe_mu
>   fill_link_info/kretprobe_multi_link_info         # bpf_program__attach_kprobe_multi_opts unexpected error: -95
>   fill_link_info/kprobe_multi_invalid_ubuff        # bpf_program__attach_kprobe_multi_opts unexpected error: -95
>   missed/kprobe_recursion                          # missed_kprobe_recursion__attach unexpected error: -95 (errno 95)
> -verifier_arena                                   # JIT does not support arena
> -arena_htab                                       # JIT does not support arena


