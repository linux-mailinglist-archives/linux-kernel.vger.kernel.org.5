Return-Path: <linux-kernel+bounces-112414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F30D88798A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 17:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BBDC2826B8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 16:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F204DA04;
	Sat, 23 Mar 2024 16:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDA2v0V3"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CE41EB34;
	Sat, 23 Mar 2024 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711212605; cv=none; b=GI/0KMWYractxgM9bztGnRgoCsua57Uv5zPbWMTjREjOFQpfMbvYR2a0F8chdFeIBa0iHk+Q/RUCkoHo+WhAOFOwPYC6dr8Ghgzuvqag2x0nVnzORdyWxNCrXUarr5eBFV9elv/ftn0+TALHnKBj69npKj2bVjVy8rUHjh7Nbbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711212605; c=relaxed/simple;
	bh=FCa+zdri2byezl1CH5h7lx8PklCLKuJ3W0WVfBHXkvw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RG1jfLbPLP4cTwO3b9x0GaMACdO/d/xQyw3zzXKQpBXOOHRHAQb8zeFCcpdXgwL1R8mW4qSkQSJPubAcsirmFj0nCuZtRDV2TkjRVPfwoGoPIvlETyDdoZ8tayyKOiFvIxZgr6MmqJH59ZG2Og6vAXRWHXqFEglA336A63Z+0vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDA2v0V3; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d49f7e5c2cso42290921fa.2;
        Sat, 23 Mar 2024 09:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711212602; x=1711817402; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HnA+iaUYbG4Zl+BUkgQEG3RRYKiMKGopzjr/nHZbKKo=;
        b=eDA2v0V3uFLJXnhQg/C+s18QzPZf9FnMadAXqb1AY6riPaHyTph0t06+NDB4uJielv
         KrLVehHTA7FNeZO4bow/ag1dm1SCraCpRcr80DC+NbQ5Vr/IpVC+84AV6qskKiemW/f2
         2ndlzhr6grhGfokXk+t8NItC+PeY/SpF0wT0XVow8YJYh+U4ebITo/WVJbkK5Tw8OuFb
         y9HJyYuC+GnjdfUfln4WgI/1T9zU7o5KAxzmpzzpy7tVD3RDP+gX8sw0ySvEoYcJZGoz
         kxf7K04H0NxO6anBqjxp6UEv9FEeUz5lz+JRTODptUOehsmOFmrYLSxIvBo8TtCMm2/e
         cYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711212602; x=1711817402;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HnA+iaUYbG4Zl+BUkgQEG3RRYKiMKGopzjr/nHZbKKo=;
        b=KGVNgmOLHt1x5GWt2yZ1cUtKS0rSZHAfU0JtW5rox5phn1qF0cKIKb+AgWfU25PvQm
         FwbKUS4+1DR40BdDtFWmC7x52tPk+WEzsFQ1VoKxdHy34C3fL7jwpziEz/5eKaurvm4m
         T7tACe4KjydPh0rwnFiBO26Av9uXmdKA4daI8duhe802ckYAhXvMZZTevLLu1O4jEr9u
         Anjs/vh6Fu5WRLSZwVY298e9VcmXgt2TBKEgetr5iO1VW8uR2kQpSS0WvVhRCh7PUzsp
         KayZiseJyeZXwO9MKnYj9/wcH2aYzah2vTF6+ctiX7Pg5VF3QM1qTwdBlhnvMFFmXZ6T
         HilA==
X-Forwarded-Encrypted: i=1; AJvYcCX44ZKe3RvPtalnrtL5s7KlgttjQtXPE30j8lNnIf89TK+5SDYkcZSxB2IA5tUetG2deKBfqRacIQcpERYNxJV68wiSg8e+RL3ChBIEiszGarkvaLK9/us+Lr+22dc8HNdB
X-Gm-Message-State: AOJu0Yx3RKzCLhBYAFzfwOFigG8SzJA7sp9eFEJn2wWRd3E9uKFu6RBC
	+TovmdhNmTAZo16IkO3pxxzQYNLv9AU/cQMqC4tC+tzZ4ovPQeZqruK9XG9Rn231vw==
X-Google-Smtp-Source: AGHT+IHCcxMTH7762NkjXUWik4Nd9KALd68m94V4NNqeQwzxO1MBq0tT9rOVo2N3NsCmmWY/uvGQkA==
X-Received: by 2002:a05:651c:1042:b0:2d4:764f:8256 with SMTP id x2-20020a05651c104200b002d4764f8256mr1716395ljm.53.1711212601733;
        Sat, 23 Mar 2024 09:50:01 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id fc19-20020a05600c525300b0041401eb021asm2949255wmb.24.2024.03.23.09.50.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2024 09:50:01 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Pu Lehui <pulehui@huawei.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, "KP
 Singh" <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, =?utf-8?B?QmrDtnJuIFQ=?=
 =?utf-8?B?w7ZwZWw=?=
 <bjorn@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>, Xi Wang
 <xi.wang@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/2] bpf,riscv: Implement bpf_addr_space_cast
 instruction
In-Reply-To: <3e07fb21-da08-4183-8bd4-064b519c7ddb@huawei.com>
References: <20240323154652.54572-1-puranjay12@gmail.com>
 <20240323154652.54572-3-puranjay12@gmail.com>
 <3e07fb21-da08-4183-8bd4-064b519c7ddb@huawei.com>
Date: Sat, 23 Mar 2024 16:49:54 +0000
Message-ID: <mb61pjzlslwp9.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pu Lehui <pulehui@huawei.com> writes:

> On 2024/3/23 23:46, Puranjay Mohan wrote:
>> LLVM generates bpf_addr_space_cast instruction while translating
> [snip]
>>   
>>   /* Convert from ninsns to bytes. */
>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
>> index f51b832eafb6..3c389e75cb96 100644
>> --- a/arch/riscv/net/bpf_jit_comp64.c
>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>> @@ -1083,6 +1083,16 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>>   	/* dst = src */
>>   	case BPF_ALU | BPF_MOV | BPF_X:
>>   	case BPF_ALU64 | BPF_MOV | BPF_X:
>> +		if (BPF_CLASS(insn->code) == BPF_ALU64 && insn->off == BPF_ADDR_SPACE_CAST &&
>> +		    insn->imm == 1U << 16) {
>> +			emit_mv(RV_REG_T1, rs, ctx); > +			emit_zextw(RV_REG_T1, RV_REG_T1, ctx);
> combine mv and zextw will be better

Do you suggest doing:

emit_zextw(RV_REG_T1, rs, ctx);

Will do it in next version.

>> +			emit_imm(rd, (ctx->user_vm_start >> 32) << 32, ctx);
>> +			emit(rv_beq(RV_REG_T1, RV_REG_ZERO, 4), ctx);
>> +			emit_or(RV_REG_T1, rd, RV_REG_T1, ctx);
>> +			emit_mv(rd, RV_REG_T1, ctx);
> ditto, but for or and mv

How would we combine or and mv? 
also, we have a beq above and in one case both or and mv should happen,
but in other case only mv should happen.

Thanks,
Puranjay

