Return-Path: <linux-kernel+bounces-120431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6558888D739
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9707F1C230DD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E17D28DC3;
	Wed, 27 Mar 2024 07:28:50 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EB523754;
	Wed, 27 Mar 2024 07:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711524529; cv=none; b=atyGNzukVQnMzT9n/FJN+sAOf+EhVB7Cp5Seg6XaD3lUTnsgHUeapoidVh8gQO2dTPvNeBpSKY0fyrT6sdqSboPfxQqn7PRRue8I30RdBpbPdHiLHlvZU8jJMl9pzhWzCwI2snVo2I7Z4nyDWJ5XEwpS/w5FSceQm5OQeJAqcCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711524529; c=relaxed/simple;
	bh=zRPikjOVGuxUHj0iYEwFs+kVUlxAZ63d9nP1HOlrotM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ksRi3QfJYdIWNDzogKBV8m8+9DLDowMh4YDju322dLVxy4FuqDXRnKrDbaOTmeTspgz1MUmDmE+PzxsUwpkPFK/2QUjD/+aDVB+Fzh76Ymf4eVO57HT7CFXYlDul3AsHEwj5LhkW4t3sKhDsumnt6KvHwHTI0owT9a7wZpi9RNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4V4JF201Dbz4f3khv;
	Wed, 27 Mar 2024 15:28:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 389161A0568;
	Wed, 27 Mar 2024 15:28:44 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP1 (Coremail) with SMTP id cCh0CgBngQqrygNmXjPeIA--.44585S2;
	Wed, 27 Mar 2024 15:28:43 +0800 (CST)
Message-ID: <bb48f1f1-70c8-4cab-86f7-91f19c00724e@huaweicloud.com>
Date: Wed, 27 Mar 2024 15:28:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/2] bpf,riscv: Implement bpf_addr_space_cast
 instruction
Content-Language: en-US
To: Puranjay Mohan <puranjay12@gmail.com>
References: <20240326224943.86912-1-puranjay12@gmail.com>
 <20240326224943.86912-3-puranjay12@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>,
 Xi Wang <xi.wang@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20240326224943.86912-3-puranjay12@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBngQqrygNmXjPeIA--.44585S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1xXr17Xw4xCw1fAry5urg_yoW5Xr1DpF
	45GFn3CrWvqwn7XF13Ja1UWr45Ars5ua12gFy7CrW5XFsIqry8Gw1rK3W5JrZ8CFy8W3Wr
	CFWY9rnak3s7X37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UdxhLUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2024/3/27 6:49, Puranjay Mohan wrote:
> LLVM generates bpf_addr_space_cast instruction while translating
> pointers between native (zero) address space and
> __attribute__((address_space(N))). The addr_space=0 is reserved as
> bpf_arena address space.
> 
> rY = addr_space_cast(rX, 0, 1) is processed by the verifier and
> converted to normal 32-bit move: wX = wY
> 
> rY = addr_space_cast(rX, 1, 0) has to be converted by JIT.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>   arch/riscv/net/bpf_jit.h        |  1 +
>   arch/riscv/net/bpf_jit_comp64.c | 14 ++++++++++++++
>   arch/riscv/net/bpf_jit_core.c   |  1 +
>   3 files changed, 16 insertions(+)
> 
> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
> index 8a47da08dd9c..5fc374ed98ea 100644
> --- a/arch/riscv/net/bpf_jit.h
> +++ b/arch/riscv/net/bpf_jit.h
> @@ -82,6 +82,7 @@ struct rv_jit_context {
>   	unsigned long flags;
>   	int stack_size;
>   	u64 arena_vm_start;
> +	u64 user_vm_start;
>   };
>   
>   /* Convert from ninsns to bytes. */
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index 73726f455f6b..77ea306452d4 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -1081,6 +1081,15 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>   	/* dst = src */
>   	case BPF_ALU | BPF_MOV | BPF_X:
>   	case BPF_ALU64 | BPF_MOV | BPF_X:
> +		if (insn_is_cast_user(insn)) {
> +			emit_mv(RV_REG_T1, rs, ctx);
> +			emit_zextw(RV_REG_T1, RV_REG_T1, ctx);
> +			emit_imm(rd, (ctx->user_vm_start >> 32) << 32, ctx);
> +			emit(rv_beq(RV_REG_T1, RV_REG_ZERO, 4), ctx);
> +			emit_or(RV_REG_T1, rd, RV_REG_T1, ctx);
> +			emit_mv(rd, RV_REG_T1, ctx);
> +			break;
> +		}
>   		if (imm == 1) {
>   			/* Special mov32 for zext */
>   			emit_zextw(rd, rd, ctx);
> @@ -2026,3 +2035,8 @@ bool bpf_jit_supports_ptr_xchg(void)
>   {
>   	return true;
>   }
> +
> +bool bpf_jit_supports_arena(void)
> +{
> +	return true;
> +}
> diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
> index 9ab739b9f9a2..8a69d6d81e32 100644
> --- a/arch/riscv/net/bpf_jit_core.c
> +++ b/arch/riscv/net/bpf_jit_core.c
> @@ -81,6 +81,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>   	}
>   
>   	ctx->arena_vm_start = bpf_arena_get_kern_vm_start(prog->aux->arena);
> +	ctx->user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
>   	ctx->prog = prog;
>   	ctx->offset = kcalloc(prog->len, sizeof(int), GFP_KERNEL);
>   	if (!ctx->offset) {

Reviewed-by: Pu Lehui <pulehui@huawei.com>
Tested-by: Pu Lehui <pulehui@huawei.com>


