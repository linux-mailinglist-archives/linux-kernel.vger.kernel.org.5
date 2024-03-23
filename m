Return-Path: <linux-kernel+bounces-112287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5128877F1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 11:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38FBDB21486
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 10:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B3E10A12;
	Sat, 23 Mar 2024 10:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcyieKl0"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8EDDF78;
	Sat, 23 Mar 2024 10:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711189274; cv=none; b=VAhGO4sLrqAlqGTRXMAbQ4RZn9AMKVigNLIaeQmPN1lnfDsNVJEaSPc3NeArcl5ee8VO3OiORJXumg1tTFbFaiI6kPLhXjxc3Yje2i8mKLxwYjhzZma98TGQyUC5vgvgrAd7OIasKO7y5IJAUTgRA5SlI4LVGCi5MBsTdjM4DG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711189274; c=relaxed/simple;
	bh=FL6r5rz38S7l9+1xAvn38KLVHfx2Rp+dm8JmvJNJqPo=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QsBvUr2sHFnAy0zCPRDA2VEBjCELK8hU6tvYeLvNZIOoHGGqOOajSisJPp9+PTaZefCj7MUZYAV8iz46m5ehS7XQDV9U63DCQGUTfPGS+RQNAgLlq+Xl7RPNV/vGTowRLlTd8PH5lAixgIwPKU5SIsuQCJkMil+6TeRvFNqQQvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcyieKl0; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41484cc3a16so400265e9.0;
        Sat, 23 Mar 2024 03:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711189271; x=1711794071; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9NQ40m1g0BVn9cfsR5PX8bbpzjpY5a0ph3Nz5Bz4Smk=;
        b=UcyieKl0AJvMQFYUUawP346VgVeuKXceHE7YXeSc91D78JpGWzxWLu8bfq/3O31EBp
         YFapPD8m/gaI0Fk6LiMiDS7QSIxoujREMgwlSOvTIFdfsm2Fop7zBwJJCkVN2ZV+pR8J
         So1WPrSTmhgDLWU589Gz2VqkmsSnvNrpwvpJtVBKOH1LAHq7b2A3qm1qVf8N2geSjKMp
         OzkMJrmnHMeltO4sTR5YwE9zeO0QK8/BorNtaHk51wUl5xnKLJDK4JrgBEilE1z+tf/A
         SzPUV9goN+VQr+NPkyZkM7mmnlPpQjldFN16UAxSG26F7E/7w9PvtkVweKjaL9kffghF
         uYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711189271; x=1711794071;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9NQ40m1g0BVn9cfsR5PX8bbpzjpY5a0ph3Nz5Bz4Smk=;
        b=m4KY7ZgbFVS3YvPusmVHjQQDWWH03sbQC+LJxlrTxiQnoRlx9S5HLIyuiBerckikU5
         kRlS34a2gUFV0b8an9aSIBOEoeZLqMJACsnaRX5ERIGz3rEyJPtzZjieJv4HI7V5/9l/
         voJOx8y9B5o4vMxzr6453ggRucgfXrMaqAZJl/bEFMZragn+ONKPdAYEKGmfOr16YXcJ
         iLZqFyBRiFuJSj1Avs6oiAeH2bozjPUJks5oC5OMJPJ26UfK6YH2loVzlS53HZgezcrQ
         BeWxTQfmOTkZiFFiQ2Z8a4MWsLksSTt+RuW0U3wlWl3ai1I1HezFL/N9AF57D3MAGOtB
         sL4A==
X-Forwarded-Encrypted: i=1; AJvYcCVjlq9VdElxgx5+DMRJAGfQ98fsIbvS0FhlU5A2+gkDRCIIpU4hJIzIDDxKwb/vaQaNwmwLj071bugcZ28TLzxqGydVvJJCSb4g3ftJdccq2nZAwou7Zn97lxN8IPBlN9T2
X-Gm-Message-State: AOJu0YyRT4soJx79KZWEy0PAefqThsJGQSk2NMz4GRHjGCHuH6vuZr44
	LHS8GL7uz6z5QvyBHYjx48dPT698izdxXtuXABD55cR+eCBePpxj
X-Google-Smtp-Source: AGHT+IGQ4MPAkOe7cQ4k/R8uDcbv4Jd9/G9hT8nhFYtDxEj4cdAlCc5M8bcYfOB01FMSkAVC2jd59Q==
X-Received: by 2002:a1c:7701:0:b0:412:ed3f:1b4b with SMTP id t1-20020a1c7701000000b00412ed3f1b4bmr1279496wmi.11.1711189270383;
        Sat, 23 Mar 2024 03:21:10 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id m29-20020a05600c3b1d00b004147b5dd6f8sm2095252wms.9.2024.03.23.03.21.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2024 03:21:09 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Zi Shen Lim <zlim.lnx@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf: Add arm64 JIT support for
 bpf_addr_space_cast instruction.
In-Reply-To: <5c66cb9a-8f6e-4839-a590-ffc0d411333e@huaweicloud.com>
References: <20240321153102.103832-1-puranjay12@gmail.com>
 <20240321153102.103832-3-puranjay12@gmail.com>
 <5c66cb9a-8f6e-4839-a590-ffc0d411333e@huaweicloud.com>
Date: Sat, 23 Mar 2024 10:21:07 +0000
Message-ID: <mb61pa5mp8d0s.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Xu Kuohai <xukuohai@huaweicloud.com> writes:

> On 3/21/2024 11:31 PM, Puranjay Mohan wrote:
>> LLVM generates bpf_addr_space_cast instruction while translating
>> pointers between native (zero) address space and
>> __attribute__((address_space(N))). The addr_space=1 is reserved as
>> bpf_arena address space.
>> 
>> rY = addr_space_cast(rX, 0, 1) is processed by the verifier and
>> converted to normal 32-bit move: wX = wY
>> 
>> rY = addr_space_cast(rX, 1, 0) has to be converted by JIT:
>> 
>> Here I explain using symbolic language what the JIT is supposed to do:
>> We have:
>> 	src = [src_upper32][src_lower32] // 64 bit src kernel pointer
>> 	uvm = [uvm_upper32][uvm_lower32] // 64 bit user_vm_start
>> 
>> The JIT has to make the dst reg like following
>> 	dst = [uvm_upper32][src_lower32] // if src_lower32 != 0
>> 	dst = [00000000000][00000000000] // if src_lower32 == 0
>> 
>> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
>> ---
>>   arch/arm64/net/bpf_jit.h                     |  1 +
>>   arch/arm64/net/bpf_jit_comp.c                | 35 ++++++++++++++++++++
>>   tools/testing/selftests/bpf/DENYLIST.aarch64 |  2 --
>>   3 files changed, 36 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
>> index 23b1b34db088..813c3c428fde 100644
>> --- a/arch/arm64/net/bpf_jit.h
>> +++ b/arch/arm64/net/bpf_jit.h
>> @@ -238,6 +238,7 @@
>>   #define A64_LSLV(sf, Rd, Rn, Rm) A64_DATA2(sf, Rd, Rn, Rm, LSLV)
>>   #define A64_LSRV(sf, Rd, Rn, Rm) A64_DATA2(sf, Rd, Rn, Rm, LSRV)
>>   #define A64_ASRV(sf, Rd, Rn, Rm) A64_DATA2(sf, Rd, Rn, Rm, ASRV)
>> +#define A64_RORV(sf, Rd, Rn, Rm) A64_DATA2(sf, Rd, Rn, Rm, RORV)
>>   
>>   /* Data-processing (3 source) */
>>   /* Rd = Ra + Rn * Rm */
>> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
>> index b9b5febe64f0..37c94ebd06b2 100644
>> --- a/arch/arm64/net/bpf_jit_comp.c
>> +++ b/arch/arm64/net/bpf_jit_comp.c
>> @@ -82,6 +82,7 @@ struct jit_ctx {
>>   	__le32 *ro_image;
>>   	u32 stack_size;
>>   	int fpb_offset;
>> +	u64 user_vm_start;
>>   };
>>   
>>   struct bpf_plt {
>> @@ -868,6 +869,34 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
>>   	/* dst = src */
>>   	case BPF_ALU | BPF_MOV | BPF_X:
>
> is it legal to encode BPF_ADDR_SPACE_CAST with BPF_ALU?

No, the verifier will reject BPF_ALU MOV that has off=BPF_ADDR_SPACE_CAST.
So, a check is not required but I will add BPF_CLASS(code) == BPF_ALU64 below
in the next version.

>>   	case BPF_ALU64 | BPF_MOV | BPF_X:
>> +		if (insn->off == BPF_ADDR_SPACE_CAST &&
>> +		    insn->imm == 1U << 16) {
>> +			/* Zero out tmp2 */
>> +			emit(A64_EOR(1, tmp2, tmp2, tmp2), ctx);
>> +
>> +			/* Move lo_32_bits(src) to dst */
>> +			if (dst != src)
>> +				emit(A64_MOV(0, dst, src), ctx);
>> +
>> +			/* Logical shift left by 32 bits */
>> +			emit(A64_LSL(1, dst, dst, 32), ctx);
>> +
>> +			/* Get upper 32 bits of user_vm_start in tmp */
>> +			emit_a64_mov_i(0, tmp, ctx->user_vm_start >> 32, ctx);
>> +
>> +			/* dst |= up_32_bits(user_vm_start) */
>> +			emit(A64_ORR(1, dst, dst, tmp), ctx);
>> +
>> +			/* Rotate by 32 bits to get final result */
>> +			emit_a64_mov_i(0, tmp, 32, ctx);
>> +			emit(A64_RORV(1, dst, dst, tmp), ctx);
>> +
>> +			/* If lo_32_bits(dst) == 0, set dst = tmp2(0) */
>> +			emit(A64_CBZ(0, dst, 2), ctx);
>> +			emit(A64_MOV(1, tmp2, dst), ctx);
>> +			emit(A64_MOV(1, dst, tmp2), ctx);
>
> seems we could simplify it to:
>
> emit_a64_mov_i(0, dst, ctx->user_vm_start >> 32, ctx);
> emit(A64_LSL(1, dst, dst, 32), ctx);
> emit(A64_MOV(0, tmp, src), ctx); // 32-bit mov clears the upper 32 bits
> emit(A64_CBZ(1, tmp, 2), ctx);
> emit(A64_ORR(1, tmp, dst, tmp), ctx);
> emit(A64_MOV(1, dst, tmp), ctx);

Thanks, I will use this in the next version. I will move the
emit(A64_MOV(0, tmp, src), ctx); to the top so if the src and dst are same
then src will be moved to tmp before it is overwritten through dst:

emit(A64_MOV(0, tmp, src), ctx); // 32-bit mov clears the upper 32 bits
emit_a64_mov_i(0, dst, ctx->user_vm_start >> 32, ctx);
emit(A64_LSL(1, dst, dst, 32), ctx);
emit(A64_CBZ(1, tmp, 2), ctx);
emit(A64_ORR(1, tmp, dst, tmp), ctx);
emit(A64_MOV(1, dst, tmp), ctx);

>> +		break;
>
> not aligned

Will fix it in the next version.

Thanks for the feedback.

Puranjay

