Return-Path: <linux-kernel+bounces-112453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF17887A07
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 19:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28A051C20BBB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 18:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6425A116;
	Sat, 23 Mar 2024 18:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjQGrGDg"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393625914B;
	Sat, 23 Mar 2024 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711219728; cv=none; b=crvcY9TQsCRVi72B9hbdD3JgZmBVhKqTSHTAzQKebY+1Ef7aFDuUps7SzH4fOYu5JvaiUui6mbFj7n0p+VkIDN9iaas4v0cCrxGFlcg5K+A+Y6Dsy/+TxcJE1MMh5QI1W/L+MKVodF5j35tAcH3B/4RDdX6hHa4Y68pZX4PIViI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711219728; c=relaxed/simple;
	bh=6Mpl4fksmU7IteXk6U17LAVHtOAUQUvMXKCFYyQleH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eR/aWRAmHyCPbX44+COa9USLZXjJ1TiSLZZ3+byyYZ/HfH84I/Gw8jjvN3ldaAWfStjW/o8264i1+pIuM58tRGLUyafCDofJV4snvh5mdWsfQj38BoDPX9rKRvbga9TSjYVN7k/xDES3WtY1+GQ3HHXuyk7hjLL4Q87B7DNe7mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjQGrGDg; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-341b9f6fb2eso892080f8f.2;
        Sat, 23 Mar 2024 11:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711219725; x=1711824525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARn5Da8AgGy7FE68WhzYMw3Qt2QRYNlRmGpn70yH7+g=;
        b=TjQGrGDgeBZ/BRu0+DTgNPR6E6CY6/1CPUV43qQJZ1nt6AR2O4sH1qq0vZ+Y39jwy6
         T+GM6oesN3XN6SwW3+Kd80NeEFjRbwrVGWzskfdnycQFqIVw6KaE4UxssiyLtvI+D+pA
         6gzJFzocQ3gNlCCza96s3hkYcFtwSrocfadUNKETobiAGLcEWOKFBzCa2y5J3ykSjUA3
         //SFBT7Rid727lHjgtX4BVoyuKgz57Xs8wttbrUAIy7/OIHM4kfvkJNg48GZKENME2GW
         U7XwrtYvHI++lQ0VXb0YJUGgGwXLyCbnnj51SSv+Vaf2OKfK2sGDJtcj14UijPmBLuaE
         /Vpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711219725; x=1711824525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ARn5Da8AgGy7FE68WhzYMw3Qt2QRYNlRmGpn70yH7+g=;
        b=XFifQ2+XG9vTV5h209FF07uun5gfHgv7J78JHX3TCZzh57/I2DWyCROrzHbEVrordW
         Jd4m6na9Cm5v19vBWhPtdmTYgEjeC1KLC3o0KdF/y7tr5cfnzs+oXWx69espRaGOKJC8
         jbXUGmVxJX7BANqfQzdCNn8mbpeeEnuLTZRmaxbNSZy3ZAYiQNUYVGMoQsGq9nYcu/fV
         ty+LlUrPGMT/evXiQtxBVSZifHVqF4fPdFrO8voGDalF9vm7oMpbaHblAWaXJQyEdbhp
         F/dfQyJjrNXQDDihMDVHNhz0gta5wgOYtxCF0Ee2uJDMmNTlsLGyvdvIJE5SwxO7xLXP
         kA4A==
X-Forwarded-Encrypted: i=1; AJvYcCVJMa0sUALc3vnNJ8/rRUAkSqc6nr+B8quNBlE+FCm4fzKhQxZojFx5sr0GvqnbaL5fl7E8mDwntBAexwusHGT1+nR0+Kq2+Ypv0J7+zFcx398z128mZ7uxD2wJcVxe9DCs
X-Gm-Message-State: AOJu0Yx/yLVWk1euKHO5V1TxnA71eJwd9D0lC+I1SQToo8tjmKWI2Spp
	LZHOAo/p4LoojX7jmVGoNt6CVe+HwoBnGEmjc9UIIpYwc1IzR00SCU+2UZn6q2ur3rtIkEcnbdy
	HxV2OQkI7Gg9OSCtDiyuy0kcqwGyBkQnzsqY=
X-Google-Smtp-Source: AGHT+IFStp9f7YpURs1lHif07k9BmlJ7lrxiDAwy7kUVNxSVQS8n4jaqBOn3YN6g7M4EYHMa6REAdnBhRK4o830nEZI=
X-Received: by 2002:a5d:594a:0:b0:341:9a25:e384 with SMTP id
 e10-20020a5d594a000000b003419a25e384mr2025122wri.50.1711219725475; Sat, 23
 Mar 2024 11:48:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240323103057.26499-1-puranjay12@gmail.com> <20240323103057.26499-2-puranjay12@gmail.com>
In-Reply-To: <20240323103057.26499-2-puranjay12@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 23 Mar 2024 11:48:34 -0700
Message-ID: <CAADnVQ+-Wt=OohzVJL9g3r2pLkaomGXDLLdLdGeGYE4D+f4cAA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Add arm64 JIT support for
 PROBE_MEM32 pseudo instructions.
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Zi Shen Lim <zlim.lnx@gmail.com>, Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2024 at 3:31=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> +#define PROBE_MEM32_BASE (MAX_BPF_JIT_REG + 5)
>
>  #define check_imm(bits, imm) do {                              \
>         if ((((imm) > 0) && ((imm) >> (bits))) ||               \
> @@ -67,6 +68,8 @@ static const int bpf2a64[] =3D {
>         /* temporary register for blinding constants */
>         [BPF_REG_AX] =3D A64_R(9),
>         [FP_BOTTOM] =3D A64_R(27),
> +       /* callee saved register for kern_vm_start address */
> +       [PROBE_MEM32_BASE] =3D A64_R(28),
>  };
>
>  struct jit_ctx {
> @@ -295,7 +298,7 @@ static bool is_lsi_offset(int offset, int scale)
>  #define PROLOGUE_OFFSET (BTI_INSNS + 2 + PAC_INSNS + 8)
>
>  static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
> -                         bool is_exception_cb)
> +                         bool is_exception_cb, u64 arena_vm_start)
>  {
>         const struct bpf_prog *prog =3D ctx->prog;
>         const bool is_main_prog =3D !bpf_is_subprog(prog);
> @@ -306,6 +309,7 @@ static int build_prologue(struct jit_ctx *ctx, bool e=
bpf_from_cbpf,
>         const u8 fp =3D bpf2a64[BPF_REG_FP];
>         const u8 tcc =3D bpf2a64[TCALL_CNT];
>         const u8 fpb =3D bpf2a64[FP_BOTTOM];
> +       const u8 pb =3D bpf2a64[PROBE_MEM32_BASE];

In addition to riscv comments please use more verbose name here.
'pb' is too cryptic.
'mem32_base' ?

I would also drop PROBE prefix and use:
#define MEM32_BASE (MAX_BPF_JIT_REG + 5)

From the verifier pov the ld/st mode is BPF_PROBE_MEM32,
since it's asking JIT to emit code to probe read/write such arena address,
but from JIT pov the base is a real base that it got from
bpf_arena_get_kern_vm_start().
#define KERN_VM_START (MAX_BPF_JIT_REG + 5)
would be an alternative name that also fits.
or
#define ARENA_VM_START ...

