Return-Path: <linux-kernel+bounces-105759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B41B587E3EA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2842A1F21679
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E85224D4;
	Mon, 18 Mar 2024 07:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RW+YnpLe"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D29DDA0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 07:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710745946; cv=none; b=X2gTSwDsAeTeAUtwDjyQWODNYY8NBGx1w7u9G9bQzxBMvHuvV9bj2UZVpW2e937HIMCDolwU/+rSkR7hSIDXg+wCsMzQMXqgmzC6+pIyj8JrIuJf46ipewSKXuOkdF5RrZoAWF5sKVJ+VjPUOpY6vJM0DNyZJMz3GJnQKXCRZMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710745946; c=relaxed/simple;
	bh=eaMPlpNli94b6ODRM7lvAIZfbqE1sL3ZXlhADuz4s78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I9vIzEzm6SnCEoQ0ZxsG8o2425b1WblbEVrKdzWqNdLOVBJ6HcA46h6ch2TBZdgLyKlelV3cqiCfk7mG+iwHHttDolAV70jO2ob57lDT+Z0TbdtgwQ/h3elQqR5oJoS6mY1oEEAzPKaL1r2NPLAwkYjUEu12CupNWdb/0jqpwEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RW+YnpLe; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d4541bf57eso52390391fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 00:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710745942; x=1711350742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihoHXreMSfCWmXnNzhFtGHwPfWoWG7tmZ8dT8g2oQoY=;
        b=RW+YnpLe2SM80AB5eRgHcrpoq4+PncJmG3qeIL61gwRxl/T3Ihn5cWrYpB3Hl3oLEZ
         aAtJxxUlRrV83flgFAavfSJganJlNuC5DlMp8GIHeqn7o7QSDPX8dTlongXOk+vUiixL
         WF4eqsEJOoSt9LGP4llxQOGAtB+NkinWg0cLeW3xHRSHAflQig7CCcQmrtrZreDgRpow
         m1RZ6XbBHr8x1yDki4GBzkBjhchtlAxy0+P4vnvOFDihmI7wjrmZ3nVlEJuLQL4nGwrM
         ewW8dhAgiUlc58AL/vAvCWSEwzvYhCqabu4dCR8zY8h2ATYqqOKHU5y8BIvoBE5Nc+Jt
         4EFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710745942; x=1711350742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihoHXreMSfCWmXnNzhFtGHwPfWoWG7tmZ8dT8g2oQoY=;
        b=AlRRP06Adt6c5y5yEl8j+b30haG9fdPLGsXa+FlNCFaDc7Zp0Qi12fv57i8LWu+V1E
         7SlzAQdKQX72VkJcn3eTylmpVCQgTSNzFh3k0nyINUaTM4C/OD4buG4q1q/fe/bLQXcn
         CAfG0FqGB1dKvN0y+x5PL455v/jRDWIwbw9Derp3zRK0q3AkPGTZUMsw2uLbARx4NRtN
         6/fxww6FKyXF1VIc4idQqTw5XBDe1bV0rFJv3IMeaWv26LLPlkwf+vLNciULFBF2g4g9
         2MOhhIA10J7mnjfrD6X1IDJs8SSUyEJNCNpq2jjMlFFmI3AAaQ6ZawD1MI5jJhlEm+Cr
         PQ7A==
X-Forwarded-Encrypted: i=1; AJvYcCUj1uMJloKcbyh291TcYb/q0dATCTmlv2mNSb5CBUW+Oxlb3uEVmw5pJdcxEpVUHhjGv2cbjHhoc6J7n37F/yE1/wxDRay/4Nt7in20
X-Gm-Message-State: AOJu0YyerMI4V4rMr+40/pPSC7dOT5Cf84fWGcaMi/MAKB/5BFrKvIgu
	fDQIck0z6SPLG6OsnLBuKxyABLpCiV7FTnvDlVnttam8/RZYQxugTv2If1xizBScKj5PhL7QIBE
	NFW0TlPYv0MsQ2E386OsCdyvQWk8=
X-Google-Smtp-Source: AGHT+IFVkQUToDSpE8AgoqVRbdQ2OhqpvjdyQU7PhEbeWDpVrJ4vU1bmDZYdvI5/ol1V8yLUby/QKKK5FXCselQuYUw=
X-Received: by 2002:a05:651c:807:b0:2d3:9b4:4363 with SMTP id
 r7-20020a05651c080700b002d309b44363mr6577322ljb.23.1710745941381; Mon, 18 Mar
 2024 00:12:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240316232104.368561-1-joanbrugueram@gmail.com> <20240316232104.368561-3-joanbrugueram@gmail.com>
In-Reply-To: <20240316232104.368561-3-joanbrugueram@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 18 Mar 2024 08:12:10 +0100
Message-ID: <CAFULd4Z2PcfhKrtb+iR1FeS+WQc86iHb6RqJQzpiccu2rGzhLg@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/bpf: Fix IP for relocating call depth accounting
To: =?UTF-8?Q?Joan_Bruguera_Mic=C3=B3?= <joanbrugueram@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	"H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2024 at 12:21=E2=80=AFAM Joan Bruguera Mic=C3=B3
<joanbrugueram@gmail.com> wrote:
>
> The recently introduced support for %rip-relative relocations in the
> call thunk template assumes that the code is being patched in-place,
> so the destination of the relocation matches the address of the code.
> This is not true for the call depth accounting emitted by the BPF JIT,
> so the calculated address is wrong and usually causes a page fault.
>
> Pass the destination IP when the BPF JIT emits call depth accounting.
>
> Fixes: 17bce3b2ae2d ("x86/callthunks: Handle %rip-relative relocations in=
 call thunk template")
> Signed-off-by: Joan Bruguera Mic=C3=B3 <joanbrugueram@gmail.com>

Reviewed-by: Uros Bizjak <ubizjak@gmail.com>

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
>         }
>         EMIT1(0x55);             /* push rbp */
>         EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
> --
> 2.44.0
>

