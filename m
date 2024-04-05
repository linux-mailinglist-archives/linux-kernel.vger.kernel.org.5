Return-Path: <linux-kernel+bounces-133167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8712E899FD8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3741F23B51
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733CB16F282;
	Fri,  5 Apr 2024 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cff9G3DB"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE88416EC10;
	Fri,  5 Apr 2024 14:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327620; cv=none; b=MkEannvQSArYfAOL9C7yvYzSyqZj5I7XrtxGZiwXX6bsnHlHOgPwmLoMk5ZknB/sD4pcH+5ZNB1RmURe4beKILkNBEMi2WToCCTdXezgEEb0oKh1/26ml79YI9BwqZt7xv4V+OUR5wM/pEpaH1xifC5JluXM8yx2XwUc/+2UXZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327620; c=relaxed/simple;
	bh=VZNc/1BmguK0z9H5D1pOv4bCKdVw6Fjy+qvkjTFgPW0=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=njT1ouJeQpqJSUjCrB+LqNsEt6FWiO4zigFEXIVDZqIgZd7li6mHSfhDec4nLI2Jzv6nmH59otRUPrl61teMddKCiykVQzAv+c7tVRyxd5/NjOwXcJXnGkLQ0wKfT75AtmbYMaUj3Izvk7ynWl0Ovo/GLHVodX63rg9oSkAFHb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cff9G3DB; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3416a975840so1643042f8f.0;
        Fri, 05 Apr 2024 07:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712327617; x=1712932417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XE7bBtXjTLLxuBkd0cUQ4f+BnesVFs7jpuSpsklKO2U=;
        b=cff9G3DBuy6W0JhZEVes4Ik3Dg12guHpIm7pIR0AiLuhf44yoxNDXkyj8/BwofdQmq
         iKAc7jksRApNHjShfFmXnIsYVcZBsgO4TUfa6dD2APk4IhkCyF2Gv4oOYqk3END9wNts
         1IJDLZ/ICvKa/FPTVMjLqV46ouKRpUdeEbyZMvPprnFT/j+JWk/gvlAgLmEYJ4WxAiub
         P573Fy4xEUY+zMkJj1L7Wtfs50Cf9ceVmUwuEOedmo3OjgKFmsTugaFFGHWqYbMMisbI
         kvpodTxXhqmtRyTiIYIQfh9gj0YH1ZlY8gd9M2P5VuNUulsKUXx9zx3r+bxwcB6FyJm9
         O8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712327617; x=1712932417;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XE7bBtXjTLLxuBkd0cUQ4f+BnesVFs7jpuSpsklKO2U=;
        b=MLK9fCN9fMslYCrRl+1Z7+EdX0yemASCq5ztx3zzn4q1DFZ4+Q85HNI0FzbieJmYZU
         xhG05wv9PCIz7m4W3WtbEyRDgel2Q1zIxZDNVzMZnoqc/5MOgl9mjRdNT2PwSVIH9Gfc
         3Dtx7q80yiyUHAb3ZDwtCjRq7t2NxM1WBwa/3d9r0k1OwU89cyJ3RdKTpuNndXBPQVi+
         Slqu20QkvtFJjMKeD2T7kzFRRA761xIfTsE7p6fNLyr2JizcqctNvulumP/3vWrfIin9
         SiU8AYMCC8hXTgd621ufDBP0TgNQ1Fpdz9BzkFNNx54SNhCEaX2tih2uA+yIOYixfPwn
         gHVA==
X-Forwarded-Encrypted: i=1; AJvYcCXcrCAxsb3DbreqEtMKs4bAcJWibS3o32ibrVLQO0pl98k1tWw70plqTlT32BB8W9qylU1Ghy7ku2Ul7CcC88mA7Ui56wAeFf8rUyIeGxDYmQuiTeC0VBL46r7n8zcaHqzc
X-Gm-Message-State: AOJu0YzFlCUwCpL/u+UNOWlxQjEWi3FmA7lXMF1zSxtdZcizh7YqyAeo
	sqnebLpjzDmUqfbTGCfZ97TVTsn3oyZrlucaGTOKA0pzZtXvJ1dW
X-Google-Smtp-Source: AGHT+IEZHLxAivag9esAnrX7FyCLYw7AgXgDUqm69jkpKf7pmtQeCzm4iQJH8oEUjk/4um4e6tEGng==
X-Received: by 2002:a05:6000:229:b0:343:968e:f27c with SMTP id l9-20020a056000022900b00343968ef27cmr1223599wrz.27.1712327617094;
        Fri, 05 Apr 2024 07:33:37 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id d11-20020adff84b000000b0033e7a102cfesm2167143wrq.64.2024.04.05.07.33.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2024 07:33:36 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, "KP
 Singh" <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Pu Lehui
 <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next] riscv, bpf: add internal-only MOV instruction
 to resolve per-CPU addrs
In-Reply-To: <87wmpbnbce.fsf@all.your.base.are.belong.to.us>
References: <20240405124348.27644-1-puranjay12@gmail.com>
 <87wmpbnbce.fsf@all.your.base.are.belong.to.us>
Date: Fri, 05 Apr 2024 14:33:34 +0000
Message-ID: <mb61pjzlb98w1.fsf@gmail.com>
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
>> Support an instruction for resolving absolute addresses of per-CPU
>> data from their per-CPU offsets. This instruction is internal-only and
>> users are not allowed to use them directly. They will only be used for
>> internal inlining optimizations for now between BPF verifier and BPF
>> JITs.
>>
>> RISC-V uses generic per-cpu implementation where the offsets for CPUs
>> are kept in an array called __per_cpu_offset[cpu_number]. RISCV stores
>> the address of the task_struct in TP register. The first element in
>> tast_struct is struct thread_info, and we can get the cpu number by
>      ^
>      k ;-)

I need to start using some kind of spell-check in vim :D.

>> reading from the TP register + offsetof(struct thread_info, cpu).
>>
>> Once we have the cpu number in a register we read the offset for that
>> cpu from address: &__per_cpu_offset + cpu_number << 3. Then we add this
>> offset to the destination register.
>
> Just to clarify for readers; BPF programs are run with migrate disable,
> which means that on RT we can be preempted, which means that per-cpu
> operations are trickier (disabling interrupts/preemption).
>
> However, this BPF instruction is about calculating the per-cpu address,
> so the look up can be inlined.
>
> It's not a per-cpu *operation*.

Will add this information to the commit message.

>> To measure the improvement from this change, the benchmark in [1] was
>> used on Qemu:
>>
>> Before:
>> glob-arr-inc   :    1.127 =C2=B1 0.013M/s
>> arr-inc        :    1.121 =C2=B1 0.004M/s
>> hash-inc       :    0.681 =C2=B1 0.052M/s
>>
>> After:
>> glob-arr-inc   :    1.138 =C2=B1 0.011M/s
>> arr-inc        :    1.366 =C2=B1 0.006M/s
>> hash-inc       :    0.676 =C2=B1 0.001M/s
>>
>> [1] https://github.com/anakryiko/linux/commit/8dec900975ef
>>
>> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
>> ---
>>  arch/riscv/net/bpf_jit_comp64.c | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_co=
mp64.c
>> index 15e482f2c657..e95bd1d459a4 100644
>> --- a/arch/riscv/net/bpf_jit_comp64.c
>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>> @@ -12,6 +12,7 @@
>>  #include <linux/stop_machine.h>
>>  #include <asm/patch.h>
>>  #include <asm/cfi.h>
>> +#include <asm/percpu.h>
>>  #include "bpf_jit.h"
>>=20=20
>>  #define RV_FENTRY_NINSNS 2
>> @@ -1089,6 +1090,24 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn=
, struct rv_jit_context *ctx,
>>  			emit_or(RV_REG_T1, rd, RV_REG_T1, ctx);
>>  			emit_mv(rd, RV_REG_T1, ctx);
>>  			break;
>> +		} else if (insn_is_mov_percpu_addr(insn)) {
>> +			if (rd !=3D rs)
>> +				emit_mv(rd, rs, ctx);
>> +#ifdef CONFIG_SMP
>> +				/* Load current CPU number in T1 */
>> +				emit_ld(RV_REG_T1, offsetof(struct thread_info, cpu), RV_REG_TP,
>> +					ctx);
>> +				/* << 3 because offsets are 8 bytes */
>> +				emit_slli(RV_REG_T1, RV_REG_T1, 3, ctx);
>> +				/* Load address of __per_cpu_offset array in T2 */
>> +				emit_imm(RV_REG_T2, (u64)&__per_cpu_offset, ctx);
>
> Did you try using emit_addr() here? I'd guess that'll be fewer
> instructions, no?

Yes, I should have used that, the address would always be in the range
of auipc+addi right? I will try and see.=20

Thanks,
Puranjay

