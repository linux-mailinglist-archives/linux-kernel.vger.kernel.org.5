Return-Path: <linux-kernel+bounces-95664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F68F8750F4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F3F6B24FA6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632D312D74C;
	Thu,  7 Mar 2024 13:52:15 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D581512C7E2;
	Thu,  7 Mar 2024 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709819535; cv=none; b=OIlmJGxaK0nruS/MwNVL9mozXtwSRuK0cOJxtQ/fxf6NIBPnry10wzI+HoQEdewkWf1N6VWqurjpywMgq1VJHmHWSwmpPD82ZAgv/CnnesexXmeuDgOo7BAiwwN8fv6pOw1uD2n7P5G8w3gv+U986rhuWOxFhOl1mxE90uura/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709819535; c=relaxed/simple;
	bh=KACBD3FSuJOn9a5+HguwCmiT6CB3AHGw3w1coDABmhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=XcmuUsP77kEoqhnIq6z6PQ2EEU3yOxxG2D5+i1Cd4uGah+f72jXr9ze4cFDghk6n5UisCzPGrHL2BFNFoduclj5pibbEfvMYrIKokkVGp0CFausNw64rL11dfQ6VZO7eFR0rTq4TtUyAH7YHxq//ixT/TK2uGJwKD11cZlXZwyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Tr9fl1hd7zHqfx;
	Thu,  7 Mar 2024 21:50:23 +0800 (CST)
Received: from kwepemd100009.china.huawei.com (unknown [7.221.188.135])
	by mail.maildlp.com (Postfix) with ESMTPS id 941CD140134;
	Thu,  7 Mar 2024 21:52:02 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemd100009.china.huawei.com (7.221.188.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 7 Mar 2024 21:52:01 +0800
Message-ID: <bf44125e-9eeb-49d9-8e7a-82f1676db123@huawei.com>
Date: Thu, 7 Mar 2024 21:52:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] arm64, bpf: Use bpf_prog_pack for arm64 bpf
 trampoline
Content-Language: en-US
To: Puranjay Mohan <puranjay12@gmail.com>, <bpf@vger.kernel.org>
References: <20240304202803.31400-1-puranjay12@gmail.com>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <catalin.marinas@arm.com>,
	<mark.rutland@arm.com>, <kpsingh@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<xukuohai@huaweicloud.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20240304202803.31400-1-puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd100009.china.huawei.com (7.221.188.135)


On 2024/3/5 4:28, Puranjay Mohan wrote:
> We used bpf_prog_pack to aggregate bpf programs into huge page to
> relieve the iTLB pressure on the system. This was merged for ARM64[1]
> We can apply it to bpf trampoline as well. This would increase the
> preformance of fentry and struct_ops programs.
> 
> [1] https://lore.kernel.org/bpf/20240228141824.119877-1-puranjay12@gmail.com/
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>   arch/arm64/net/bpf_jit_comp.c | 55 +++++++++++++++++++++++++++++------
>   1 file changed, 46 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 5afc7a525eca..c5b461dda438 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -2076,7 +2076,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>   		/* store return value */
>   		emit(A64_STR64I(A64_R(0), A64_SP, retval_off), ctx);
>   		/* reserve a nop for bpf_tramp_image_put */
> -		im->ip_after_call = ctx->image + ctx->idx;
> +		im->ip_after_call = ctx->ro_image + ctx->idx;
>   		emit(A64_NOP, ctx);
>   	}
>   
> @@ -2091,7 +2091,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>   				run_ctx_off, false);
>   
>   	if (flags & BPF_TRAMP_F_CALL_ORIG) {
> -		im->ip_epilogue = ctx->image + ctx->idx;
> +		im->ip_epilogue = ctx->ro_image + ctx->idx;
>   		emit_addr_mov_i64(A64_R(0), (const u64)im, ctx);
>   		emit_call((const u64)__bpf_tramp_exit, ctx);
>   	}
> @@ -2124,9 +2124,6 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>   		emit(A64_RET(A64_R(10)), ctx);
>   	}
>   
> -	if (ctx->image)
> -		bpf_flush_icache(ctx->image, ctx->image + ctx->idx);
> -
>   	kfree(branches);
>   
>   	return ctx->idx;
> @@ -2169,14 +2166,43 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
>   	return ret < 0 ? ret : ret * AARCH64_INSN_SIZE;
>   }
>   
> -int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
> -				void *image_end, const struct btf_func_model *m,
> +void *arch_alloc_bpf_trampoline(unsigned int size)
> +{
> +	return bpf_prog_pack_alloc(size, jit_fill_hole);
> +}
> +
> +void arch_free_bpf_trampoline(void *image, unsigned int size)
> +{
> +	bpf_prog_pack_free(image, size);
> +}
> +
> +void arch_protect_bpf_trampoline(void *image, unsigned int size)
> +{
> +}
> +
> +void arch_unprotect_bpf_trampoline(void *image, unsigned int size)
> +{
> +}
> +
> +int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
> +				void *ro_image_end, const struct btf_func_model *m,
>   				u32 flags, struct bpf_tramp_links *tlinks,
>   				void *func_addr)
>   {
>   	int ret, nregs;
> +	void *image, *tmp;
> +	u32 size = ro_image_end - ro_image;
> +
> +	/* image doesn't need to be in module memory range, so we can
> +	 * use kvmalloc.
> +	 */
> +	image = kvmalloc(size, GFP_KERNEL);
> +	if (!image)
> +		return -ENOMEM;
> +
>   	struct jit_ctx ctx = {
>   		.image = image,
> +		.ro_image = ro_image,
>   		.idx = 0,
>   	};
>   
> @@ -2185,15 +2211,26 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
>   	if (nregs > 8)
>   		return -ENOTSUPP;
>   
> -	jit_fill_hole(image, (unsigned int)(image_end - image));
> +	jit_fill_hole(image, (unsigned int)(ro_image_end - ro_image));
>   	ret = prepare_trampoline(&ctx, im, tlinks, func_addr, nregs, flags);
>   
> -	if (ret > 0 && validate_code(&ctx) < 0)
> +	if (ret > 0 && validate_code(&ctx) < 0) {
>   		ret = -EINVAL;
> +		goto out;
> +	}
>   
>   	if (ret > 0)
>   		ret *= AARCH64_INSN_SIZE;
>   
> +	tmp = bpf_arch_text_copy(ro_image, image, size);
> +	if (IS_ERR(tmp)) {
> +		ret = PTR_ERR(tmp);
> +		goto out;
> +	}
> +
> +	bpf_flush_icache(ro_image, ro_image + size);
> +out:
> +	kvfree(image);
>   	return ret;
>   }
>   

Reviewed-by: Pu Lehui <pulehui@huawei.com>

