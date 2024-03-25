Return-Path: <linux-kernel+bounces-117561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFC788AC99
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 613411C60231
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD93D46430;
	Mon, 25 Mar 2024 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjo0NWyx"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924874691;
	Mon, 25 Mar 2024 17:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386957; cv=none; b=Ysj5cHrtqCQL6kgD4wjyOTvtPewq1Ly9mVoOwIu0LWw21K9ra0vuvgcL37nKfExzuhjXeRMz3rYK+iQ7Tjg9nUgdHn1afr81Kn/wBfqHxFw8/OIXYGqVdLNJC5xSYndpFuJxKliWM/+Xl8Pz7tI+7077yw+1fhsfelvs7czp6uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386957; c=relaxed/simple;
	bh=j8p3im1FoDBv1nShbdEtREoAUJDqe3kxTZ7MnLlwcnA=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IsV6WDe4LrVsSmu9cdOCIZ8rXokVx4qpf3n8rGIemyCGFLqrrTCqXpcqnE6cazMF4kJHNk/gQulTiXwQ6YJZP8lXK2UCyBpvzZ9w5r8LhegCjIfSxCZ9RqQNDcL/dkXBfmu0vzd4iE2G/E8diuj0wAWPxjtONXecK5AxQiG2xmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjo0NWyx; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-341b01dbebbso3323228f8f.0;
        Mon, 25 Mar 2024 10:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711386954; x=1711991754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3JcP9Ixxq7VYfRSOZNRDlURNxIkwxj5RGFVViXNJk14=;
        b=bjo0NWyxH7q85db171Isa93Z+W5dY1tz4V/cYiYSzTGAA3NYU2Fa1/+cXTu9uv93g1
         +idwvP9IYCWqJBZPNSBcBTsZzzm+TrTMeseFhtgfiBv/BD7SBxmRR0aKzOQnaO68nD0G
         LHj92c8unzYh1o5HREl8IEB8ToYEpwzL1gmRWarV3XYAtSWI+iAx1+v3r6clnH9Ppmcx
         zkvL49m41/dYnQuIjbh0JY9YcutI3O/3ePxOZWDNAC9OBt1IhJDMVnfLPnkXIjfNrRRk
         3kD5b1OhbiJgD51Bn832LDtEczgseXbz+pkIIiq7lOS/cw0vZwVcPIOHZQv9FZgnp2jv
         NULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711386954; x=1711991754;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3JcP9Ixxq7VYfRSOZNRDlURNxIkwxj5RGFVViXNJk14=;
        b=HSoIzDT7x4pXNfpxXhBOp3EyZP9bFzSP/LsGGXp+yxVoAbzW52GNN+lnVKoOuR0kyL
         kQM42SEVDkb/2PH5ipx26DJWg0QSraPhyVbSIjOG+B/Kji8RUREAaIGgvsB9Q4zQQ9vA
         MRArvuLoo/2iqgpXS5XVMPM+ViqKw09XehrdbeyvzT5rwu42Wxt1naACfbYXtoCYmJ9i
         ql6m8bwxMIomAxmBHoFML+VGIX2mRap7OUBjGBlcEzkiROv+I1FssQWYD4Q4Md1wU9ql
         LgUyO5hryw2zpcYFCYZgE1UqLcB3T4CC5ORtgAk6WtVSkjReVdAWj1Szki0tjMhdEW1W
         I07w==
X-Forwarded-Encrypted: i=1; AJvYcCVLWvTwHRaZKgFPBixliisSuz2bRprHJB1kd7LObVA4yewAfy1zg67fz39V8FKcSmHyQZlIN7dJul7fWZnY4ZNIix8bf1KS1CelEQbvsKUzY7D5s6kZ+zJF6kH3N+p0yq9u
X-Gm-Message-State: AOJu0YweyDK+bl/0pKBhSUudTXyw9koD8gQoF14hTNhRbue5qt0Cvb2U
	06/n5+1p6IzoVXiNvKqW9twCPidEmEEirg1uQZwnJWm/loO1imh3
X-Google-Smtp-Source: AGHT+IE42lV8EQMw1EFXIiTWcsfY5Tdd8VoYbW7AxgP48DLUyoyJH4apdN/DLdWNdOb2U1bUlQzVqw==
X-Received: by 2002:a5d:4fc2:0:b0:33f:84a1:7eb8 with SMTP id h2-20020a5d4fc2000000b0033f84a17eb8mr6124207wrw.1.1711386953673;
        Mon, 25 Mar 2024 10:15:53 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id x3-20020adfcc03000000b0033e41e1ad93sm9908955wrh.57.2024.03.25.10.15.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2024 10:15:53 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, "KP
 Singh" <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Luke Nelson
 <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Pu Lehui
 <pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf,riscv: Implement PROBE_MEM32 pseudo
 instructions
In-Reply-To: <875xxafe33.fsf@all.your.base.are.belong.to.us>
References: <20240325155434.65589-1-puranjay12@gmail.com>
 <20240325155434.65589-2-puranjay12@gmail.com>
 <875xxafe33.fsf@all.your.base.are.belong.to.us>
Date: Mon, 25 Mar 2024 17:15:51 +0000
Message-ID: <mb61ple66mdvc.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

> Puranjay Mohan <puranjay12@gmail.com> writes:
>
>> Add support for [LDX | STX | ST], PROBE_MEM32, [B | H | W | DW]
>> instructions.  They are similar to PROBE_MEM instructions with the
>> following differences:
>> - PROBE_MEM32 supports store.
>> - PROBE_MEM32 relies on the verifier to clear upper 32-bit of the
>>   src/dst register
>> - PROBE_MEM32 adds 64-bit kern_vm_start address (which is stored in S7
>>   in the prologue). Due to bpf_arena constructions such S7 + reg +
>>   off16 access is guaranteed to be within arena virtual range, so no
>>   address check at run-time.
>> - S7 is a free callee-saved register, so it is used to store kern_vm_sta=
rt
>> - PROBE_MEM32 allows STX and ST. If they fault the store is a nop. When
>>   LDX faults the destination register is zeroed.
>>
>> To support these on riscv, we do tmp =3D S7 + src/dst reg and then use
>> tmp2 as the new src/dst register. This allows us to reuse most of the
>> code for normal [LDX | STX | ST].
>
> Cool to see the RV BPF JIT keeping up with x86 features! ;-) Nice work!

It is my self proclaimed duty to make sure that all 64-bit JITs have
feature parity. :D

>
> A couple of minor comments below.
>
>> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
>> ---
>>  arch/riscv/net/bpf_jit.h        |   1 +
>>  arch/riscv/net/bpf_jit_comp64.c | 193 +++++++++++++++++++++++++++++++-
>>  arch/riscv/net/bpf_jit_core.c   |   1 +
>>  3 files changed, 192 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
>> index f4b6b3b9edda..8a47da08dd9c 100644
>> --- a/arch/riscv/net/bpf_jit.h
>> +++ b/arch/riscv/net/bpf_jit.h
>> @@ -81,6 +81,7 @@ struct rv_jit_context {
>>  	int nexentries;
>>  	unsigned long flags;
>>  	int stack_size;
>> +	u64 arena_vm_start;
>>  };
>>=20=20
>>  /* Convert from ninsns to bytes. */
>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_co=
mp64.c
>> index 1adf2f39ce59..0c0588e327af 100644
>> --- a/arch/riscv/net/bpf_jit_comp64.c
>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>> @@ -255,6 +255,10 @@ static void __build_epilogue(bool is_tail_call, str=
uct rv_jit_context *ctx)
>>  		emit_ld(RV_REG_S6, store_offset, RV_REG_SP, ctx);
>>  		store_offset -=3D 8;
>>  	}
>> +	if (ctx->arena_vm_start) {
>> +		emit_ld(RV_REG_S7, store_offset, RV_REG_SP, ctx);
>> +		store_offset -=3D 8;
>> +	}
>>=20=20
>>  	emit_addi(RV_REG_SP, RV_REG_SP, stack_adjust, ctx);
>>  	/* Set return value. */
>> @@ -548,6 +552,7 @@ static void emit_atomic(u8 rd, u8 rs, s16 off, s32 i=
mm, bool is64,
>>=20=20
>>  #define BPF_FIXUP_OFFSET_MASK   GENMASK(26, 0)
>>  #define BPF_FIXUP_REG_MASK      GENMASK(31, 27)
>> +#define DONT_CLEAR		17	/* RV_REG_A7 unused in pt_regmap */
>
> Hmm, so this is just a a sentinel node, right? Isn't it more robust to
> use, say REG_ZERO which will never be used? Maybe REG_DONT_CLEAR_MARKER
> or smth, so it's obvious how it's used?

Yes, I agree, RV_REG_ZERO would be the best thing to use here.

>
>
>>  bool ex_handler_bpf(const struct exception_table_entry *ex,
>>  		    struct pt_regs *regs)
>> @@ -555,7 +560,8 @@ bool ex_handler_bpf(const struct exception_table_ent=
ry *ex,
>>  	off_t offset =3D FIELD_GET(BPF_FIXUP_OFFSET_MASK, ex->fixup);
>>  	int regs_offset =3D FIELD_GET(BPF_FIXUP_REG_MASK, ex->fixup);
>>=20=20
>> -	*(unsigned long *)((void *)regs + pt_regmap[regs_offset]) =3D 0;
>> +	if (regs_offset !=3D DONT_CLEAR)
>> +		*(unsigned long *)((void *)regs + pt_regmap[regs_offset]) =3D 0;
>>  	regs->epc =3D (unsigned long)&ex->fixup - offset;
>>=20=20
>>  	return true;
>> @@ -572,7 +578,8 @@ static int add_exception_handler(const struct bpf_in=
sn *insn,
>>  	off_t fixup_offset;
>>=20=20
>>  	if (!ctx->insns || !ctx->ro_insns || !ctx->prog->aux->extable ||
>> -	    (BPF_MODE(insn->code) !=3D BPF_PROBE_MEM && BPF_MODE(insn->code) !=
=3D BPF_PROBE_MEMSX))
>> +	    (BPF_MODE(insn->code) !=3D BPF_PROBE_MEM && BPF_MODE(insn->code) !=
=3D BPF_PROBE_MEMSX &&
>> +	     BPF_MODE(insn->code) !=3D BPF_PROBE_MEM32))
>>  		return 0;
>>=20=20
>>  	if (WARN_ON_ONCE(ctx->nexentries >=3D ctx->prog->aux->num_exentries))
>> @@ -622,6 +629,9 @@ static int add_exception_handler(const struct bpf_in=
sn *insn,
>>=20=20
>>  	ex->insn =3D ins_offset;
>>=20=20
>> +	if (BPF_CLASS(insn->code) !=3D BPF_LDX)
>> +		dst_reg =3D DONT_CLEAR;
>> +
>
> Instead of having a side-effect, and passing a dummy dst_reg for the
> probe_mem32, just explicitly add DONT_CLEAR when calling
> add_exception_handler(). It's more obvious to me at least.

Sure, will do that in the next version.

>
>>  	ex->fixup =3D FIELD_PREP(BPF_FIXUP_OFFSET_MASK, fixup_offset) |
>>  		FIELD_PREP(BPF_FIXUP_REG_MASK, dst_reg);
>>  	ex->type =3D EX_TYPE_BPF;
>> @@ -1063,7 +1073,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn,=
 struct rv_jit_context *ctx,
>>  		    BPF_CLASS(insn->code) =3D=3D BPF_JMP;
>>  	int s, e, rvoff, ret, i =3D insn - ctx->prog->insnsi;
>>  	struct bpf_prog_aux *aux =3D ctx->prog->aux;
>> -	u8 rd =3D -1, rs =3D -1, code =3D insn->code;
>> +	u8 rd =3D -1, rs =3D -1, code =3D insn->code, reg_arena_vm_start =3D R=
V_REG_S7;
>>  	s16 off =3D insn->off;
>>  	s32 imm =3D insn->imm;
>>=20=20
>> @@ -1539,6 +1549,11 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn=
, struct rv_jit_context *ctx,
>>  	case BPF_LDX | BPF_PROBE_MEMSX | BPF_B:
>>  	case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
>>  	case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
>> +	/* LDX | PROBE_MEM32: dst =3D *(unsigned size *)(src + S7 + off)*/
>> +	case BPF_LDX | BPF_PROBE_MEM32 | BPF_B:
>> +	case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
>> +	case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
>> +	case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
>>  	{
>>  		int insn_len, insns_start;
>>  		bool sign_ext;
>> @@ -1546,6 +1561,11 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn=
, struct rv_jit_context *ctx,
>>  		sign_ext =3D BPF_MODE(insn->code) =3D=3D BPF_MEMSX ||
>>  			   BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEMSX;
>>=20=20
>> +		if (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM32) {
>> +			emit_add(RV_REG_T2, rs, reg_arena_vm_start, ctx);
>> +			rs =3D RV_REG_T2;
>> +		}
>> +
>>  		switch (BPF_SIZE(code)) {
>>  		case BPF_B:
>>  			if (is_12b_int(off)) {
>> @@ -1682,6 +1702,87 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn=
, struct rv_jit_context *ctx,
>>  		emit_sd(RV_REG_T2, 0, RV_REG_T1, ctx);
>>  		break;
>>=20=20
>> +	case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
>> +	case BPF_ST | BPF_PROBE_MEM32 | BPF_H:
>> +	case BPF_ST | BPF_PROBE_MEM32 | BPF_W:
>> +	case BPF_ST | BPF_PROBE_MEM32 | BPF_DW:
>> +	{
>> +		int insn_len, insns_start;
>> +
>> +		emit_add(RV_REG_T3, rd, reg_arena_vm_start, ctx);
>> +		rd =3D RV_REG_T3;
>> +
>> +		/* Load imm to a register then store it */
>> +		emit_imm(RV_REG_T1, imm, ctx);
>> +
>> +		switch (BPF_SIZE(code)) {
>> +		case BPF_B:
>> +			if (is_12b_int(off)) {
>> +				insns_start =3D ctx->ninsns;
>> +				emit(rv_sb(rd, off, RV_REG_T1), ctx);
>> +				insn_len =3D ctx->ninsns - insns_start;
>> +				break;
>> +			}
>> +
>> +			emit_imm(RV_REG_T2, off, ctx);
>> +			emit_add(RV_REG_T2, RV_REG_T2, rd, ctx);
>> +			insns_start =3D ctx->ninsns;
>> +			emit(rv_sb(RV_REG_T2, 0, RV_REG_T1), ctx);
>> +			insn_len =3D ctx->ninsns - insns_start;
>> +
>> +			break;
>> +
>> +		case BPF_H:
>> +			if (is_12b_int(off)) {
>> +				insns_start =3D ctx->ninsns;
>> +				emit(rv_sh(rd, off, RV_REG_T1), ctx);
>> +				insn_len =3D ctx->ninsns - insns_start;
>> +				break;
>> +			}
>> +
>> +			emit_imm(RV_REG_T2, off, ctx);
>> +			emit_add(RV_REG_T2, RV_REG_T2, rd, ctx);
>> +			insns_start =3D ctx->ninsns;
>> +			emit(rv_sh(RV_REG_T2, 0, RV_REG_T1), ctx);
>> +			insn_len =3D ctx->ninsns - insns_start;
>> +			break;
>> +		case BPF_W:
>> +			if (is_12b_int(off)) {
>> +				insns_start =3D ctx->ninsns;
>> +				emit_sw(rd, off, RV_REG_T1, ctx);
>> +				insn_len =3D ctx->ninsns - insns_start;
>> +				break;
>> +			}
>> +
>> +			emit_imm(RV_REG_T2, off, ctx);
>> +			emit_add(RV_REG_T2, RV_REG_T2, rd, ctx);
>> +			insns_start =3D ctx->ninsns;
>> +			emit_sw(RV_REG_T2, 0, RV_REG_T1, ctx);
>> +			insn_len =3D ctx->ninsns - insns_start;
>> +			break;
>> +		case BPF_DW:
>> +			if (is_12b_int(off)) {
>> +				insns_start =3D ctx->ninsns;
>> +				emit_sd(rd, off, RV_REG_T1, ctx);
>> +				insn_len =3D ctx->ninsns - insns_start;
>> +				break;
>> +			}
>> +
>> +			emit_imm(RV_REG_T2, off, ctx);
>> +			emit_add(RV_REG_T2, RV_REG_T2, rd, ctx);
>> +			insns_start =3D ctx->ninsns;
>> +			emit_sd(RV_REG_T2, 0, RV_REG_T1, ctx);
>> +			insn_len =3D ctx->ninsns - insns_start;
>> +			break;
>> +		}
>
> A lot of similar code, with emit of different sizes. Possible to move
> move out to a function, and wrap the emits? The main loop is hard read
> already!

I thought about this as well. My plan is to refactor the whole thing in a
seperate patch. I did not do it with this feature as it will cause a lot
of unrelated code churn.

Thanks,
Puranjay

