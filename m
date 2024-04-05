Return-Path: <linux-kernel+bounces-133447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2519589A3D7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F9A6B23ED4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4827D171E6D;
	Fri,  5 Apr 2024 18:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dr2Z7Jo9"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E9216C690;
	Fri,  5 Apr 2024 18:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712340276; cv=none; b=YuEdO71Zd7wEion1i012pu3m7PGzt4d9+r32rfa0a0xyWPhoIvZdcI9Tn2YKSgnQt1Uj+ttxI65sODXb76+o3Tvwst+B3RPVe/FB3MvapCKIAczGfcPPRvJTWV2XCKVZ/V6IQ5IZfIIhg3woxBqvuNPAizI28NDpvM/cu3nDmP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712340276; c=relaxed/simple;
	bh=rx5x61JaVED7/ekps9HFAxH2BM+q2K439h5TgWEG2Ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ve5m33Mx1z/aWzLE+feNv1ZGEh+hlX2ubmwLBqw1TSaCmRndzF7F2ukdAKzlG/xNdXX9xobmMy5xhf/Jwd23Dkyt/+u9DtUjFip4umV0nAdS5uLlLl7DEjGK1FULwZNdRF/FAqGFRA4Jyb7T6fAhDZSLnIAx2SbTZHJOnDttP0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dr2Z7Jo9; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2a2601f0562so1895725a91.0;
        Fri, 05 Apr 2024 11:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712340274; x=1712945074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbOOQHHfJnX2pfDfgWCsINU2rgHj1dQeerUU+fle01c=;
        b=Dr2Z7Jo9DfiitqchV+DIM0JsJS4WGB6CYcxHLNOvWgK47mM8EBlGbLSHp5YuJZgHc1
         NB5HUuiG+D2b9IDhAbbEc9IeIzuQgZcZrnS9dNqTTjFhXdxnsI2Kfq88e+4Te4ou4ly8
         6RpBWNSGXt++oKKy8Ry13d9mTzC0+1XRvqRhx1HTXmrgWueyqM9KoC7eoIOALb+aKn7C
         xEvoZ7rKG7LOEKwegZZbp3ZQnzP3Xh/XrlchoYc2VzNp2ywuFXOZOCtEsiYdWdJdWatB
         e6tXmJI9bJZG/rDd88aUC7E6UjQ+fwHzvAWGLjWdpUNrPcqQH0lzovwOUb/LGwJfyYIJ
         tSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712340274; x=1712945074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbOOQHHfJnX2pfDfgWCsINU2rgHj1dQeerUU+fle01c=;
        b=nVHT6G7ChqiUf/dF0SF7nR4dv1gVBzmEa8pU6WUMTx4Ep72ZXEwOisFY5W+1y1BUBS
         8jD/uiSw8jjEys19apn0UCfDQRP0c6oUP7K7URlRzCMDmUNEat66D8v3BgdL/5lmUGCe
         QmlPWv0jbtGvrc+ExPwSDD9bqnLVfYj7if1K0UGW3djwG7CjqsL88H85Mcud1Et2K3Uk
         oqMNjBSUFPXliJMeqXRa4aTnr3cqnj7++mktNtsYZtf69rRzlnoc2yQwC3hzIPKpaq3+
         aUj/WSk6JiqqOs3wDlLRFbMjqFGJtJ8g0s55IQFYA6VA/caM10xdfcHZv5w7reEJkixF
         psIA==
X-Forwarded-Encrypted: i=1; AJvYcCVGIxlidx0k8aZJjz47Ujl/0p6F99/Tq8j8o9vRHXyosOJo5QAqc7yQmxFuvm5bd0yT4kwp72R6xilD1PY9XwreRnyWZ5Z2Vhm7s+UmCgG43LyH0CPPij/PZM9l34W8dE60
X-Gm-Message-State: AOJu0YxfDFQEaOsSdm+E0IaTAbFAGpfde5PNXYZ9Zfa0KS3T5dy+Jjox
	VWuQzXJkkh6uepJ7cV26UK/9BkbNykVczeAgu24Dwh4rqPcHxSZuWznZOiwmXeLguMRZ9kyOCbO
	ObBhEBLGDvZ0oK1m4E9wodE2rAuM=
X-Google-Smtp-Source: AGHT+IFR6c4K6HiUOrAnSGIi/JYq+JJaevdAeZxUHbgCPbjn52JO0QkZBlusRD+P+L2TahE4h5Uhq4seaG3OVeiowIc=
X-Received: by 2002:a17:90b:1bcc:b0:2a2:5860:dea8 with SMTP id
 oa12-20020a17090b1bcc00b002a25860dea8mr1932174pjb.7.1712340274157; Fri, 05
 Apr 2024 11:04:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405124348.27644-1-puranjay12@gmail.com>
In-Reply-To: <20240405124348.27644-1-puranjay12@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Apr 2024 11:04:22 -0700
Message-ID: <CAEf4BzZ2Tz5-GwbQKYg7KoGwqN8ewPBakmghHaH20MfoATe74g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] riscv, bpf: add internal-only MOV instruction to
 resolve per-CPU addrs
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, bpf@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Pu Lehui <pulehui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 5:44=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.com=
> wrote:
>
> Support an instruction for resolving absolute addresses of per-CPU
> data from their per-CPU offsets. This instruction is internal-only and
> users are not allowed to use them directly. They will only be used for
> internal inlining optimizations for now between BPF verifier and BPF
> JITs.
>
> RISC-V uses generic per-cpu implementation where the offsets for CPUs
> are kept in an array called __per_cpu_offset[cpu_number]. RISCV stores
> the address of the task_struct in TP register. The first element in
> tast_struct is struct thread_info, and we can get the cpu number by
> reading from the TP register + offsetof(struct thread_info, cpu).
>
> Once we have the cpu number in a register we read the offset for that
> cpu from address: &__per_cpu_offset + cpu_number << 3. Then we add this
> offset to the destination register.
>
> To measure the improvement from this change, the benchmark in [1] was
> used on Qemu:
>
> Before:
> glob-arr-inc   :    1.127 =C2=B1 0.013M/s
> arr-inc        :    1.121 =C2=B1 0.004M/s
> hash-inc       :    0.681 =C2=B1 0.052M/s
>
> After:
> glob-arr-inc   :    1.138 =C2=B1 0.011M/s
> arr-inc        :    1.366 =C2=B1 0.006M/s
> hash-inc       :    0.676 =C2=B1 0.001M/s

TBH, I don't trust benchmarks done inside QEMU. Can you try running
this on some real hardware?

>
> [1] https://github.com/anakryiko/linux/commit/8dec900975ef
>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  arch/riscv/net/bpf_jit_comp64.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index 15e482f2c657..e95bd1d459a4 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -12,6 +12,7 @@
>  #include <linux/stop_machine.h>
>  #include <asm/patch.h>
>  #include <asm/cfi.h>
> +#include <asm/percpu.h>
>  #include "bpf_jit.h"
>
>  #define RV_FENTRY_NINSNS 2
> @@ -1089,6 +1090,24 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn,=
 struct rv_jit_context *ctx,
>                         emit_or(RV_REG_T1, rd, RV_REG_T1, ctx);
>                         emit_mv(rd, RV_REG_T1, ctx);
>                         break;
> +               } else if (insn_is_mov_percpu_addr(insn)) {
> +                       if (rd !=3D rs)
> +                               emit_mv(rd, rs, ctx);

Is this an unconditional move instruction? in x86-64, EMIT_mov checks
whether source and destination registers are the same and doesn't emit
anything if they match (which makes sense, right)?

> +#ifdef CONFIG_SMP
> +                               /* Load current CPU number in T1 */
> +                               emit_ld(RV_REG_T1, offsetof(struct thread=
_info, cpu), RV_REG_TP,
> +                                       ctx);

nit: maybe keep this on the same line?

> +                               /* << 3 because offsets are 8 bytes */
> +                               emit_slli(RV_REG_T1, RV_REG_T1, 3, ctx);
> +                               /* Load address of __per_cpu_offset array=
 in T2 */
> +                               emit_imm(RV_REG_T2, (u64)&__per_cpu_offse=
t, ctx);
> +                               /* Add offset of current CPU to  __per_cp=
u_offset */
> +                               emit_add(RV_REG_T1, RV_REG_T2, RV_REG_T1,=
 ctx);
> +                               /* Load __per_cpu_offset[cpu] in T1 */
> +                               emit_ld(RV_REG_T1, 0, RV_REG_T1, ctx);
> +                               /* Add the offset to Rd */
> +                               emit_add(rd, rd, RV_REG_T1, ctx);
> +#endif
>                 }
>                 if (imm =3D=3D 1) {
>                         /* Special mov32 for zext */
> @@ -2038,3 +2057,8 @@ bool bpf_jit_supports_arena(void)
>  {
>         return true;
>  }
> +
> +bool bpf_jit_supports_percpu_insn(void)
> +{
> +       return true;
> +}
> --
> 2.40.1
>

