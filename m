Return-Path: <linux-kernel+bounces-133288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB3F89A1C0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67E8AB24D4F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E247A16FF4C;
	Fri,  5 Apr 2024 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnVYWO9u"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5236016F848;
	Fri,  5 Apr 2024 15:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712332133; cv=none; b=kRXS4JJc0lZifR206WDnR1CwkLwqNo9UwP9pAtVTS92G0EAo8eTZniXreZRKyUioChH4wojasw2QaUFxnK+C1dQTnlhLaWfmA8eUBdWwU4SmSUuCNdZVsOfnfO7VSce7yKcKuemqO84OihAdEi4dEb4dvnnlH5qaD8+iBjLA8LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712332133; c=relaxed/simple;
	bh=rtMy8As82sQFAQ0eM6aaoJZIh+y0qT+mIoXOQz3kSYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6ntfrZpjlG80pVVVCj8DKf9+EroKjUPnPKTzZAQ5fynUHhWatZuWZc3agtFCTTds0GRdtpa7yjjKdXyB/+p05yisbCIUxDQObXqwhoXQk4SAJAtxrGKtrypzy5U1Yvtvoa36Ayp8XPpZXE2yEYasCV54Xra3Oq0UGpcVCZjxyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnVYWO9u; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4162bac959cso13675525e9.0;
        Fri, 05 Apr 2024 08:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712332129; x=1712936929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyyD3DEAbC4by9MKRG14Yd9xsYk8/3G2qMgmBFElUfU=;
        b=RnVYWO9uV35BjRBiTjzmMcuDHdn5n6cpnDaTOseNfjAsoVYyZWJQVOAoeD3oY2Cx6L
         /3zUMkI9oinY3EJMdIIqu2z8B9sQ6Ck31i4ZQbvFFriSWvTraMsI0bgVcNC/Bb2ATpZ0
         fJ0SYdwEv2rlitK0TOVb0j9cCuy/533IAHfQjEXMV3hckHJgD0qLqzGJitQ+DvoPX4n3
         C5weXRQ9eX84ZByy2gbXVdd3q9krxTJs/Ss0pYOaMntSqSl/637AruJXN1yaAcHyjBTN
         O/M8l1FStKRPXLuoqQkEfTaDp/9HiW5cQewLFb1G/SbfCIiMj0/XZfVrPz4uCf+dAko/
         3NgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712332129; x=1712936929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyyD3DEAbC4by9MKRG14Yd9xsYk8/3G2qMgmBFElUfU=;
        b=vEiveoo0qf97/QLDomXxvJ6UkR4oE3eYIRVCJuGHh8GTgEmPTgebMxj0Lv/as9AaT7
         nHf+CebJ3iBiM4JSsZzdDirsehEH6A15WfRBtT3jgZb5WB6h9HIFsISk3eiB2KXozQB3
         MRwZ3V7MmNCnD0RMp18Di2b12CZRQhjVWCtZZrBdaBHQzi4g5H9oJ1jQ6sEmrVZ/q2lY
         9nNlk8RiGXCNe8eIBbczRhnh3Zvg1ohK5QnYFMnN5yJcgkM3kslzxTK8/Q1XBNqT1tXu
         M7hfO2hU4Vrv7Djgu85meyXiyKemK1cgI2Pj8C41N+eoJlpt1BGjfY6MihGSf2MdruYp
         pAUA==
X-Forwarded-Encrypted: i=1; AJvYcCUDw5UUTng4coj/WO9fYtS+0Uzf7CnaX4dxw6WBUVsEDjoeOBUZ4CHIT2NC2rJuLSyiOEcE3mOatv5kdYAySBNQME/8vaTDGHnZM1GzPrrf6+5eeOCKHVy5dCAZioCp4XuZ
X-Gm-Message-State: AOJu0Ywb97PBq+Go49K/FVk3EGLLRaCbmMPX0nDPEurYV6TeBclsxcpC
	NeiX6mt6fGv07HwBPVinQu+1RiHAwX0gz7diMLpZtzr09qPTvXOykVhdj1HlbuxLFlMKXQmO902
	eXDvYBDVPa4MKdYpnTQZd3N6JKeM=
X-Google-Smtp-Source: AGHT+IE15rl9GsqAwGgp3KEfT9yqEzO1rkXukPV0FY8i9RljV8lpxj2+bTxkHlsGdQ5YX49O1YvMfPCYaOxBadpWYgk=
X-Received: by 2002:a5d:644d:0:b0:343:7cdc:458b with SMTP id
 d13-20020a5d644d000000b003437cdc458bmr1503986wrw.7.1712332129419; Fri, 05 Apr
 2024 08:48:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405091707.66675-1-puranjay12@gmail.com>
In-Reply-To: <20240405091707.66675-1-puranjay12@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 5 Apr 2024 08:48:38 -0700
Message-ID: <CAADnVQ+MRAg2hKJfG_QUjXu8WHLb+7tpPgMOQv8rfCSmKU2w5Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] arm64, bpf: add internal-only MOV instruction to
 resolve per-CPU addrs
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Zi Shen Lim <zlim.lnx@gmail.com>, Xu Kuohai <xukuohai@huawei.com>, 
	Florent Revest <revest@chromium.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 2:17=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.com=
> wrote:
>
> Support an instruction for resolving absolute addresses of per-CPU
> data from their per-CPU offsets. This instruction is internal-only and
> users are not allowed to use them directly. They will only be used for
> internal inlining optimizations for now between BPF verifier and BPF
> JITs.
>
> Since commit 7158627686f0 ("arm64: percpu: implement optimised pcpu
> access using tpidr_el1"), the per-cpu offset for the CPU is stored in
> the tpidr_el1/2 register of that CPU.
>
> To support this BPF instruction in the ARM64 JIT, the following ARM64
> instructions are emitted:
>
> mov dst, src            // Move src to dst, if src !=3D dst
> mrs tmp, tpidr_el1/2    // Move per-cpu offset of the current cpu in tmp.
> add dst, dst, tmp       // Add the per cpu offset to the dst.
>
> If CONFIG_SMP is not defined, then nothing is emitted if src =3D=3D dst, =
and
> mov dst, src is emitted if dst !=3D src.
>
> To measure the performance improvement provided by this change, the
> benchmark in [1] was used:
>
> Before:
> glob-arr-inc   :   23.597 =C2=B1 0.012M/s
> arr-inc        :   23.173 =C2=B1 0.019M/s
> hash-inc       :   12.186 =C2=B1 0.028M/s
>
> After:
> glob-arr-inc   :   23.819 =C2=B1 0.034M/s
> arr-inc        :   23.285 =C2=B1 0.017M/s
> hash-inc       :   12.419 =C2=B1 0.011M/s
>
> [1] https://github.com/anakryiko/linux/commit/8dec900975ef

You don't see as big of a gain, because bpf_get_smp_processor_id()
is not inlined yet on arm64.

But even without it I expected bigger gains.
Could you do 'perf report' before/after ?
Just want to see what's on top.

>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  arch/arm64/include/asm/insn.h |  7 +++++++
>  arch/arm64/lib/insn.c         | 11 +++++++++++
>  arch/arm64/net/bpf_jit.h      |  6 ++++++
>  arch/arm64/net/bpf_jit_comp.c | 16 ++++++++++++++++
>  4 files changed, 40 insertions(+)
>
> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.=
h
> index db1aeacd4cd9..d16d68550c22 100644
> --- a/arch/arm64/include/asm/insn.h
> +++ b/arch/arm64/include/asm/insn.h
> @@ -135,6 +135,11 @@ enum aarch64_insn_special_register {
>         AARCH64_INSN_SPCLREG_SP_EL2     =3D 0xF210
>  };
>
> +enum aarch64_insn_system_register {
> +       AARCH64_INSN_SYSREG_TPIDR_EL1   =3D 0xC684,
> +       AARCH64_INSN_SYSREG_TPIDR_EL2   =3D 0xE682,
> +};
> +
>  enum aarch64_insn_variant {
>         AARCH64_INSN_VARIANT_32BIT,
>         AARCH64_INSN_VARIANT_64BIT
> @@ -686,6 +691,8 @@ u32 aarch64_insn_gen_cas(enum aarch64_insn_register r=
esult,
>  }
>  #endif
>  u32 aarch64_insn_gen_dmb(enum aarch64_insn_mb_type type);
> +u32 aarch64_insn_gen_mrs(enum aarch64_insn_register result,
> +                        enum aarch64_insn_system_register sysreg);
>
>  s32 aarch64_get_branch_offset(u32 insn);
>  u32 aarch64_set_branch_offset(u32 insn, s32 offset);
> diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
> index a635ab83fee3..b008a9b46a7f 100644
> --- a/arch/arm64/lib/insn.c
> +++ b/arch/arm64/lib/insn.c
> @@ -1515,3 +1515,14 @@ u32 aarch64_insn_gen_dmb(enum aarch64_insn_mb_type=
 type)
>
>         return insn;
>  }
> +
> +u32 aarch64_insn_gen_mrs(enum aarch64_insn_register result,
> +                        enum aarch64_insn_system_register sysreg)
> +{
> +       u32 insn =3D aarch64_insn_get_mrs_value();
> +
> +       insn &=3D ~GENMASK(19, 0);
> +       insn |=3D sysreg << 5;
> +       return aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RT,
> +                                           insn, result);
> +}
> diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
> index 23b1b34db088..b627ef7188c7 100644
> --- a/arch/arm64/net/bpf_jit.h
> +++ b/arch/arm64/net/bpf_jit.h
> @@ -297,4 +297,10 @@
>  #define A64_ADR(Rd, offset) \
>         aarch64_insn_gen_adr(0, offset, Rd, AARCH64_INSN_ADR_TYPE_ADR)
>
> +/* MRS */
> +#define A64_MRS_TPIDR_EL1(Rt) \
> +       aarch64_insn_gen_mrs(Rt, AARCH64_INSN_SYSREG_TPIDR_EL1)
> +#define A64_MRS_TPIDR_EL2(Rt) \
> +       aarch64_insn_gen_mrs(Rt, AARCH64_INSN_SYSREG_TPIDR_EL2)
> +
>  #endif /* _BPF_JIT_H */
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
> index 76b91f36c729..e9ad9f257a18 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -877,6 +877,17 @@ static int build_insn(const struct bpf_insn *insn, s=
truct jit_ctx *ctx,
>                         emit(A64_ORR(1, tmp, dst, tmp), ctx);
>                         emit(A64_MOV(1, dst, tmp), ctx);
>                         break;
> +               } else if (insn_is_mov_percpu_addr(insn)) {
> +                       if (dst !=3D src)
> +                               emit(A64_MOV(1, dst, src), ctx);
> +#ifdef CONFIG_SMP
> +                       if (cpus_have_cap(ARM64_HAS_VIRT_HOST_EXTN))
> +                               emit(A64_MRS_TPIDR_EL2(tmp), ctx);
> +                       else
> +                               emit(A64_MRS_TPIDR_EL1(tmp), ctx);
> +                       emit(A64_ADD(1, dst, dst, tmp), ctx);
> +#endif
> +                       break;
>                 }
>                 switch (insn->off) {
>                 case 0:
> @@ -2527,6 +2538,11 @@ bool bpf_jit_supports_arena(void)
>         return true;
>  }
>
> +bool bpf_jit_supports_percpu_insn(void)
> +{
> +       return true;
> +}
> +
>  void bpf_jit_free(struct bpf_prog *prog)
>  {
>         if (prog->jited) {
> --
> 2.40.1
>

