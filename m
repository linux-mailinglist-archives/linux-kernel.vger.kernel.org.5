Return-Path: <linux-kernel+bounces-125454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB2A89265C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8B61F24EC5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE26613CC53;
	Fri, 29 Mar 2024 21:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtFEeVUc"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F92E1E897;
	Fri, 29 Mar 2024 21:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711749199; cv=none; b=YcUIPWpHs7mLZnVdaPh2sGq8r5F5xF21yFPDxMZ/gm0YeJrT/TWfFs/Gh9WnFRa71L3nMBK9Nnv6q1uk/kZxQqMajeyclU7BgxRjaaMsw/eReYwfsEd5M1f1xxGZ/6c71chWZmsbAHPSHVYj437pvbvRgRDUvYwenfjdDa7AKfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711749199; c=relaxed/simple;
	bh=ZkGv2aECxPpKjlvqInjY5t6BAWJ1JpiWyKfHeeHLgFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N4wUMXak4yyRayehjv1ar0r8EyyPLMwBc3uJ0bwl/C4uF0p7B7G/bWOwvNeZYeq6b3W3Vcfr0NdbT29Ffwzm149FPXaVcG2iO3WP/b1G80f4/vw74ISsQwa8epN/zn528A3NyNmNXX0nycQdjpBblQ7EyQAtFDKts98b9c+Xxik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtFEeVUc; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-341e3682c78so1377084f8f.0;
        Fri, 29 Mar 2024 14:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711749195; x=1712353995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSnIkrXKOxIFx664NuP3H7hYth27RezAKOIyptzRih0=;
        b=DtFEeVUcXHxQSM1acoLPB3xIZ2HSM6vWTSGbB4Vn2PTFo59S2qm9Wdb/PYmKmlkt7q
         bweDNoN2FkFdd+biODVbvTAWaLZraY63rTLXLI3Uj2YXC5gXRj51NmN6ndvk0CmDMb0e
         HIob6o5pR32SYbzkWHSn4Jg4Btu/S+g0UAjgMXPRMh1EcOgJV/whXSYiykrw7f/6s77P
         /H5ZCsxnDWl4kNYCj9mzXKbfqQBAv6Lnt80sLG1vRk3gD9HqNaAkNP/seJmggh7Vb0eo
         x3i++yNtv1UR3TkN0hCOiKzOfpwFxG/x3+oaCYHUq4IcorpsSpcrx239+6AZFAOrQdbA
         WyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711749195; x=1712353995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSnIkrXKOxIFx664NuP3H7hYth27RezAKOIyptzRih0=;
        b=oKWLVHtPvz9J+QXVTc54yStjx+NkapzU4nW5NsuqPQ5h82t98mF43eq2fZPnUSPhaT
         MGdf9ycXYZkO41VrOpN62JqHNhZQR/quC5iGCtAX8SbX3Zql03mdeT6pd9hdt04AMwNI
         v7s3h6cmiqq3SNt6pWwVBYRqxOm+JPpZT5yDuDLXj7HFAWYEdMSKpeIILWSrLfRqeGmF
         0Wu0zy7UE5pH6ZQnPhhEBhM4jmoqIk7Jl9U1SyEn4ioN3y3x18oyrKxSulpIT55d/yc8
         64AGB3PNnhGmaMJktfTQg6iokvhAcecEo9Sr4wvXZuzD5l1KTyylDAgGYGp2D5OwKZyP
         iGgw==
X-Forwarded-Encrypted: i=1; AJvYcCUd4xvQHL/oaQCMtCuugnR3C+1mNP+kYnHMed8zOGO5hdRvAX21HlPyuCzWSAKy8Bt5pMwgz3toD1E3Xn4ARVBMo22+kQWtIVLj26ICYQSx1B5RhgBvSbm3JXQKMiyRL5E4gFZ/VAumoFjE2Vcpg7zLq5/DEIrGAbwW
X-Gm-Message-State: AOJu0YyKhnyWxAp7UfXLi6lEMSL4950T9e1nKDvTnmG9yMcApYpszSgu
	6nlrYsSq1udaQLoImKyk+HbI3U4g2GsYOT0pZe1ZoHsOJsdjCd5+EVv1QU8gEWIM6DBowMLNfme
	dpizDXQEt670AhG7mMjM3Cbt2ZFB5CMSUPpA=
X-Google-Smtp-Source: AGHT+IESQ34cqmbczYM0CtTFQ4n7hfhahLrps7uGUEuczD5xhOvFv09EChC/YJ/FIRR8VtuzAy4gIzrPZKwGa0EMMVQ=
X-Received: by 2002:a5d:6d49:0:b0:341:e4f4:4399 with SMTP id
 k9-20020a5d6d49000000b00341e4f44399mr1687491wri.68.1711749195364; Fri, 29 Mar
 2024 14:53:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329094906.18147-1-ubizjak@gmail.com> <20240329094906.18147-3-ubizjak@gmail.com>
In-Reply-To: <20240329094906.18147-3-ubizjak@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 29 Mar 2024 14:53:03 -0700
Message-ID: <CAADnVQ+6D++hCXaP=aK+Q5wienMzhHo3h9YCvpA_7sHjMt+q6A@mail.gmail.com>
Subject: Re: [PATCH RESEND bpf 2/2] x86/bpf: Fix IP for relocating call depth accounting
To: Uros Bizjak <ubizjak@gmail.com>
Cc: X86 ML <x86@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	=?UTF-8?Q?Joan_Bruguera_Mic=C3=B3?= <joanbrugueram@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 2:49=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> From: Joan Bruguera Mic=C3=B3 <joanbrugueram@gmail.com>
>
> The recently introduced support for %rip-relative relocations in the
> call thunk template assumes that the code is being patched in-place,
> so the destination of the relocation matches the address of the code.
> This is not true for the call depth accounting emitted by the BPF JIT,
> so the calculated address is wrong and usually causes a page fault.

Could you share the link to what this 'rip-relative' relocation is ?

> Pass the destination IP when the BPF JIT emits call depth accounting.
>
> Fixes: 17bce3b2ae2d ("x86/callthunks: Handle %rip-relative relocations in=
 call thunk template")

Ohh. It's buried inside that patch.
Pls make commit log a bit more clear that that commit 17bce3b2ae2d
broke x86_call_depth_emit_accounting logic.

> Signed-off-by: Joan Bruguera Mic=C3=B3 <joanbrugueram@gmail.com>
> Reviewed-by: Uros Bizjak <ubizjak@gmail.com>
> Acked-by: Ingo Molnar <mingo@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  arch/x86/include/asm/alternative.h |  4 ++--
>  arch/x86/kernel/callthunks.c       |  4 ++--
>  arch/x86/net/bpf_jit_comp.c        | 19 ++++++++-----------
>  3 files changed, 12 insertions(+), 15 deletions(-)
>
> diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/al=
ternative.h
> index fcd20c6dc7f9..67b68d0d17d1 100644
> --- a/arch/x86/include/asm/alternative.h
> +++ b/arch/x86/include/asm/alternative.h
> @@ -117,7 +117,7 @@ extern void callthunks_patch_builtin_calls(void);
>  extern void callthunks_patch_module_calls(struct callthunk_sites *sites,
>                                           struct module *mod);
>  extern void *callthunks_translate_call_dest(void *dest);
> -extern int x86_call_depth_emit_accounting(u8 **pprog, void *func);
> +extern int x86_call_depth_emit_accounting(u8 **pprog, void *func, void *=
ip);
>  #else
>  static __always_inline void callthunks_patch_builtin_calls(void) {}
>  static __always_inline void
> @@ -128,7 +128,7 @@ static __always_inline void *callthunks_translate_cal=
l_dest(void *dest)
>         return dest;
>  }
>  static __always_inline int x86_call_depth_emit_accounting(u8 **pprog,
> -                                                         void *func)
> +                                                         void *func, voi=
d *ip)
>  {
>         return 0;
>  }
> diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
> index 30335182b6b0..e92ff0c11db8 100644
> --- a/arch/x86/kernel/callthunks.c
> +++ b/arch/x86/kernel/callthunks.c
> @@ -314,7 +314,7 @@ static bool is_callthunk(void *addr)
>         return !bcmp(pad, insn_buff, tmpl_size);
>  }
>
> -int x86_call_depth_emit_accounting(u8 **pprog, void *func)
> +int x86_call_depth_emit_accounting(u8 **pprog, void *func, void *ip)
>  {
>         unsigned int tmpl_size =3D SKL_TMPL_SIZE;
>         u8 insn_buff[MAX_PATCH_LEN];
> @@ -327,7 +327,7 @@ int x86_call_depth_emit_accounting(u8 **pprog, void *=
func)
>                 return 0;
>
>         memcpy(insn_buff, skl_call_thunk_template, tmpl_size);
> -       apply_relocation(insn_buff, tmpl_size, *pprog,
> +       apply_relocation(insn_buff, tmpl_size, ip,

Did the logic inside apply_relocation() change to have
a new meaning for 'dest' and 'src'?
Answering to myself... yes. in that commit.
Better commit log would have made the code review so much easier.

>                          skl_call_thunk_template, tmpl_size);
>
>         memcpy(*pprog, insn_buff, tmpl_size);
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 09f7dc9d4d65..f2e8769f5eee 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -481,7 +481,7 @@ static int emit_rsb_call(u8 **pprog, void *func, void=
 *ip)
>  {
>         void *adjusted_ip;
>         OPTIMIZER_HIDE_VAR(func);
> -       adjusted_ip =3D ip + x86_call_depth_emit_accounting(pprog, func);
> +       adjusted_ip =3D ip + x86_call_depth_emit_accounting(pprog, func, =
ip);

Now I see why you added extra var in the previous patch.
Should have mentioned it in the commit log.

>         return emit_patch(pprog, func, adjusted_ip, 0xE8);
>  }
>
> @@ -1973,20 +1973,17 @@ st:                     if (is_imm8(insn->off))
>
>                         /* call */
>                 case BPF_JMP | BPF_CALL: {
> -                       int offs;
> +                       u8 *ip =3D image + addrs[i - 1];
>
>                         func =3D (u8 *) __bpf_call_base + imm32;
>                         if (tail_call_reachable) {
>                                 RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stac=
k_depth);
> -                               if (!imm32)
> -                                       return -EINVAL;
> -                               offs =3D 7 + x86_call_depth_emit_accounti=
ng(&prog, func);
> -                       } else {
> -                               if (!imm32)
> -                                       return -EINVAL;
> -                               offs =3D x86_call_depth_emit_accounting(&=
prog, func);
> +                               ip +=3D 7;
>                         }
> -                       if (emit_call(&prog, func, image + addrs[i - 1] +=
 offs))
> +                       if (!imm32)
> +                               return -EINVAL;
> +                       ip +=3D x86_call_depth_emit_accounting(&prog, fun=
c, ip);
> +                       if (emit_call(&prog, func, ip))
>                                 return -EINVAL;
>                         break;
>                 }
> @@ -2836,7 +2833,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
>                  * Direct-call fentry stub, as such it needs accounting f=
or the
>                  * __fentry__ call.
>                  */
> -               x86_call_depth_emit_accounting(&prog, NULL);
> +               x86_call_depth_emit_accounting(&prog, NULL, image);

Overall it all makes sense.
Pls respin with more precise commit logs.

