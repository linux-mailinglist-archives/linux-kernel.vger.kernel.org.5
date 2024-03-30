Return-Path: <linux-kernel+bounces-126271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FFE89348B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574CC28472C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6664715F301;
	Sun, 31 Mar 2024 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nle+vzJj"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BC815ECD5;
	Sun, 31 Mar 2024 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903425; cv=fail; b=NZf5Qn12dPl5TBMR+FNCFjidP7IsMKyeJm2XWStJZIN3WIAGrp51YktSDrF1rTfgeiOByvQrJhWBpro1iO8tOeJNnXoV94fYTYauiKfpFQ04/uZ4vQGTHubsGF24D1OetkEKH/J7Tki5WPzNiPea8Xuhrp5dY9Llc7dzCruRy8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903425; c=relaxed/simple;
	bh=w0OqRzN57AzPILbckYVvgfXewAtDf2iU8AsBytCBXN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s1702cWMB1pUx+ribdikojXRkzIt0OgIm4f0uw5KyH94Y/yaD69zXZ/1ebOxf3iruPaBVpgLNShTTTffX8yPQjv7HhLdxpmFwu0DuqRgjlYsQo0iRRArbiVqkCUaZkKm8mO/c4QqczUvFZ09/5gc3GvYznpnVnekKFx2w+ue8Mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nle+vzJj reason="signature verification failed"; arc=none smtp.client-ip=209.85.208.171; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id B9BD420842;
	Sun, 31 Mar 2024 18:43:41 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TICoQZvxdyXF; Sun, 31 Mar 2024 18:43:40 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id C472A207D5;
	Sun, 31 Mar 2024 18:43:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com C472A207D5
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id B7869800060;
	Sun, 31 Mar 2024 18:43:39 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:43:39 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:37:02 +0000
X-sender: <netdev+bounces-83496-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoARoOmlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 16739
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=netdev+bounces-83496-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com BCB2D207E4
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711789276; cv=none; b=LJliKGtxdDA5DncUU3WQ86IqJfxxDdmZL62lReMe091FMMVzSAkVNUab0eixlHeqVTjIQ9EEtdUySkdcLp6rFtixRUTTmQdeeFsygIBsVZzOYDo25RMQNI1crLiHrVMDdGnqz68Wu6CyxrARRiiLwfKV6AS/7WwNSvW09W60zck=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711789276; c=relaxed/simple;
	bh=CFUfaZfb7X/JJv0DB5cn0CBJrMrECWzMZrlMK1UCZYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o3BMwVDUvqhNVOZ/cIBlL/eEF8qwRIumKR1fMWrSA7H4zcSOpuQv/ioQzXQqrodsIUyARBuvkzwtgX1F3ahG1oBV9JsqyrWjN58qqzsylGWNrONt419EuA+HV2Hnb6GN/l1yLYA/QgPCW6C6kp/GDTzIPXK00zlXkPjIpLmtnu4=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nle+vzJj; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711789272; x=1712394072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbl/CLMq3nWKqNjaubWInMz1kaQBbZVVwZ4B6Yhcsik=;
        b=Nle+vzJjShWs0Ti3+DNi47la3wp5ECIHDAW+EvbhX+Ton8pxr5GAT+OKLN9tkpsdWp
         7pmY92Vv0JN9muB7m6ZKKOed2eTaDIbVC7yQe3iYoQYmuzNt6FG/2CRXCn5axo5T0Er+
         mIawl+AjZ9LcJ+2LwfqLqtGS9Swzi333W06D5Rkope/9r9oRpQjGT7vy46uzFz6Xcl6b
         S77spLQ2G+CQpl+4BKwdDBzhD3S36TpnXk6mrY+NzXkbO3VsCQIQvMCBSh38nAhwLdwg
         DDcnS4Gu8cVLbgH/tpVDy41vXbLuY8G8wYbQmHDkXrHBBWVRq9R4WCn8orBArD2q7glw
         BXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711789272; x=1712394072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbl/CLMq3nWKqNjaubWInMz1kaQBbZVVwZ4B6Yhcsik=;
        b=SissUbPdoWrUM0u1xqTsea9iktJot0W8ikz/21w6oDLw29oHo1E/zyykrKQer/3OWO
         qPdKEegxJqdMg3v5GqOnOKWhyGLwFbh6p2b85j1Ts+6BbLFl9oFkAqze+79DH3UTgvpX
         8eHg+dcra2W81v3T0kNwO/Rz19x/a4qUnJoY4xXfsGku0ULlQwIKn/HG4uSfeFFaQsvQ
         uTzuZm8A/9h9KcYqL8SvAcdlpvE/AK5/d243lGtC7Es8bpk5HpBF6YLgEqB9CQU7scmf
         XLKGETg+gvfwQ/3vIK2nDBH9GUewEyTA+wZonkJx4DDqfRJaO4cU3mQBB6idP5IB1mep
         Hw+g==
X-Forwarded-Encrypted: i=1; AJvYcCXMPjsPXXatSVDH641eiZD9Tylx5ujw2zvU8pLsO9HYR1XJhfBDwIOO8cDOnkZQvsFw51iNGrNYsj+ZOC9s/nmtelqQeBg/s4CmUPCyx03PDGJu4fX5flrhGr2i0fu9s/8eCySMSfdAa696W6WVC4RItEDieQnLUtLc
X-Gm-Message-State: AOJu0YxogawIyIXt1FmwtLXKYPIfA7/NqcoJp2+CkbXskVq401KWqBS9
	dv/uHIbm1VAuF/Vdv+59bCR/JaF94WfnbXteVNB+T1wBqWVEkaHONlAM1xQ2s4fdMV8thx39cxA
	tPcarlYh9vw0yYnOBdeRY+OsGAlI=
X-Google-Smtp-Source: AGHT+IGeaymGC7cAQwieQg4TakZq0ARBnpQFix3PExtV6ez87eomevGZHhs6eDxl1CtxiB/HrZm8Uq2a8idogtbdJIc=
X-Received: by 2002:a2e:8612:0:b0:2d6:a5ce:b261 with SMTP id
 a18-20020a2e8612000000b002d6a5ceb261mr2175202lji.25.1711789271815; Sat, 30
 Mar 2024 02:01:11 -0700 (PDT)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329094906.18147-1-ubizjak@gmail.com> <20240329094906.18147-3-ubizjak@gmail.com>
 <CAADnVQ+6D++hCXaP=aK+Q5wienMzhHo3h9YCvpA_7sHjMt+q6A@mail.gmail.com>
In-Reply-To: <CAADnVQ+6D++hCXaP=aK+Q5wienMzhHo3h9YCvpA_7sHjMt+q6A@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sat, 30 Mar 2024 10:01:04 +0100
Message-ID: <CAFULd4b6juiw3wC3Z61V9=-UnA+NGyUt4231vC14UnGAATk6tA@mail.gmail.com>
Subject: Re: [PATCH RESEND bpf 2/2] x86/bpf: Fix IP for relocating call depth accounting
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: X86 ML <x86@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	=?UTF-8?Q?Joan_Bruguera_Mic=C3=B3?= <joanbrugueram@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, Mar 29, 2024 at 10:53=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Mar 29, 2024 at 2:49=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> w=
rote:
> >
> > From: Joan Bruguera Mic=C3=B3 <joanbrugueram@gmail.com>
> >
> > The recently introduced support for %rip-relative relocations in the
> > call thunk template assumes that the code is being patched in-place,
> > so the destination of the relocation matches the address of the code.
> > This is not true for the call depth accounting emitted by the BPF JIT,
> > so the calculated address is wrong and usually causes a page fault.
>
> Could you share the link to what this 'rip-relative' relocation is ?

Please see the "RIP relative addressing" section in [1].

[1] https://compas.cs.stonybrook.edu/~nhonarmand/courses/sp17/cse506/ref/as=
sembly.html

In our case:

The callthunks patching creates a call thunk template in the .rodata
section (please see arch/x86/kernel/callthunks.c)  that is later
copied to the .text section at the correct place. The template uses
X86_call_depth in the pcpu_hot structure. Previously, the template
used absolute location for X86_call_depth and the linker resolved the
address in the template to this absolute location. There is no issue
when this template is copied to the various places in the .text
section.

When we want to use PC relative relocations (to reduce the code size),
then the linker calculates the address of the variable in the template
according to the PC in the .rodata section. If we want to copy the
template to its final location, then the address of X86_call_depth,
relative to the PC, has to be adjusted, as explained in
arch/x86/kernel/alternative.c, in the comment above apply_reloc_n
macro.

Uros.

> > Pass the destination IP when the BPF JIT emits call depth accounting.
> >
> > Fixes: 17bce3b2ae2d ("x86/callthunks: Handle %rip-relative relocations =
in call thunk template")
>
> Ohh. It's buried inside that patch.
> Pls make commit log a bit more clear that that commit 17bce3b2ae2d
> broke x86_call_depth_emit_accounting logic.
>
> > Signed-off-by: Joan Bruguera Mic=C3=B3 <joanbrugueram@gmail.com>
> > Reviewed-by: Uros Bizjak <ubizjak@gmail.com>
> > Acked-by: Ingo Molnar <mingo@kernel.org>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > ---
> >  arch/x86/include/asm/alternative.h |  4 ++--
> >  arch/x86/kernel/callthunks.c       |  4 ++--
> >  arch/x86/net/bpf_jit_comp.c        | 19 ++++++++-----------
> >  3 files changed, 12 insertions(+), 15 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/=
alternative.h
> > index fcd20c6dc7f9..67b68d0d17d1 100644
> > --- a/arch/x86/include/asm/alternative.h
> > +++ b/arch/x86/include/asm/alternative.h
> > @@ -117,7 +117,7 @@ extern void callthunks_patch_builtin_calls(void);
> >  extern void callthunks_patch_module_calls(struct callthunk_sites *site=
s,
> >                                           struct module *mod);
> >  extern void *callthunks_translate_call_dest(void *dest);
> > -extern int x86_call_depth_emit_accounting(u8 **pprog, void *func);
> > +extern int x86_call_depth_emit_accounting(u8 **pprog, void *func, void=
 *ip);
> >  #else
> >  static __always_inline void callthunks_patch_builtin_calls(void) {}
> >  static __always_inline void
> > @@ -128,7 +128,7 @@ static __always_inline void *callthunks_translate_c=
all_dest(void *dest)
> >         return dest;
> >  }
> >  static __always_inline int x86_call_depth_emit_accounting(u8 **pprog,
> > -                                                         void *func)
> > +                                                         void *func, v=
oid *ip)
> >  {
> >         return 0;
> >  }
> > diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.=
c
> > index 30335182b6b0..e92ff0c11db8 100644
> > --- a/arch/x86/kernel/callthunks.c
> > +++ b/arch/x86/kernel/callthunks.c
> > @@ -314,7 +314,7 @@ static bool is_callthunk(void *addr)
> >         return !bcmp(pad, insn_buff, tmpl_size);
> >  }
> >
> > -int x86_call_depth_emit_accounting(u8 **pprog, void *func)
> > +int x86_call_depth_emit_accounting(u8 **pprog, void *func, void *ip)
> >  {
> >         unsigned int tmpl_size =3D SKL_TMPL_SIZE;
> >         u8 insn_buff[MAX_PATCH_LEN];
> > @@ -327,7 +327,7 @@ int x86_call_depth_emit_accounting(u8 **pprog, void=
 *func)
> >                 return 0;
> >
> >         memcpy(insn_buff, skl_call_thunk_template, tmpl_size);
> > -       apply_relocation(insn_buff, tmpl_size, *pprog,
> > +       apply_relocation(insn_buff, tmpl_size, ip,
>
> Did the logic inside apply_relocation() change to have
> a new meaning for 'dest' and 'src'?
> Answering to myself... yes. in that commit.
> Better commit log would have made the code review so much easier.
>
> >                          skl_call_thunk_template, tmpl_size);
> >
> >         memcpy(*pprog, insn_buff, tmpl_size);
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 09f7dc9d4d65..f2e8769f5eee 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -481,7 +481,7 @@ static int emit_rsb_call(u8 **pprog, void *func, vo=
id *ip)
> >  {
> >         void *adjusted_ip;
> >         OPTIMIZER_HIDE_VAR(func);
> > -       adjusted_ip =3D ip + x86_call_depth_emit_accounting(pprog, func=
);
> > +       adjusted_ip =3D ip + x86_call_depth_emit_accounting(pprog, func=
, ip);
>
> Now I see why you added extra var in the previous patch.
> Should have mentioned it in the commit log.
>
> >         return emit_patch(pprog, func, adjusted_ip, 0xE8);
> >  }
> >
> > @@ -1973,20 +1973,17 @@ st:                     if (is_imm8(insn->off))
> >
> >                         /* call */
> >                 case BPF_JMP | BPF_CALL: {
> > -                       int offs;
> > +                       u8 *ip =3D image + addrs[i - 1];
> >
> >                         func =3D (u8 *) __bpf_call_base + imm32;
> >                         if (tail_call_reachable) {
> >                                 RESTORE_TAIL_CALL_CNT(bpf_prog->aux->st=
ack_depth);
> > -                               if (!imm32)
> > -                                       return -EINVAL;
> > -                               offs =3D 7 + x86_call_depth_emit_accoun=
ting(&prog, func);
> > -                       } else {
> > -                               if (!imm32)
> > -                                       return -EINVAL;
> > -                               offs =3D x86_call_depth_emit_accounting=
(&prog, func);
> > +                               ip +=3D 7;
> >                         }
> > -                       if (emit_call(&prog, func, image + addrs[i - 1]=
 + offs))
> > +                       if (!imm32)
> > +                               return -EINVAL;
> > +                       ip +=3D x86_call_depth_emit_accounting(&prog, f=
unc, ip);
> > +                       if (emit_call(&prog, func, ip))
> >                                 return -EINVAL;
> >                         break;
> >                 }
> > @@ -2836,7 +2833,7 @@ static int __arch_prepare_bpf_trampoline(struct b=
pf_tramp_image *im, void *rw_im
> >                  * Direct-call fentry stub, as such it needs accounting=
 for the
> >                  * __fentry__ call.
> >                  */
> > -               x86_call_depth_emit_accounting(&prog, NULL);
> > +               x86_call_depth_emit_accounting(&prog, NULL, image);
>
> Overall it all makes sense.
> Pls respin with more precise commit logs.

X-sender: <linux-kernel+bounces-125632-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoATIOmlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 16859
Received: from mbx-dresden-01.secunet.de (10.53.40.199) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 10:01:43 +0100
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Sat, 30 Mar 2024 10:01:43 +0100
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id 10A2520315
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 10:01:43 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -5.049
X-Spam-Level:
X-Spam-Status: No, score=-5.049 tagged_above=-999 required=2.1
	tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
	DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
	FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
	MAILING_LIST_MULTI=-1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
	SPF_PASS=-0.001] autolearn=ham autolearn_force=no
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=pass (2048-bit key) header.d=gmail.com
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B8ZWMzr-RJt4 for <steffen.klassert@secunet.com>;
	Sat, 30 Mar 2024 10:01:42 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125632-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com A420F2025D
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nle+vzJj"
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id A420F2025D
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 10:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FF4D282F2A
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 09:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AE9DF5A;
	Sat, 30 Mar 2024 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nle+vzJj"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2F7847E;
	Sat, 30 Mar 2024 09:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711789276; cv=none; b=LJliKGtxdDA5DncUU3WQ86IqJfxxDdmZL62lReMe091FMMVzSAkVNUab0eixlHeqVTjIQ9EEtdUySkdcLp6rFtixRUTTmQdeeFsygIBsVZzOYDo25RMQNI1crLiHrVMDdGnqz68Wu6CyxrARRiiLwfKV6AS/7WwNSvW09W60zck=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711789276; c=relaxed/simple;
	bh=CFUfaZfb7X/JJv0DB5cn0CBJrMrECWzMZrlMK1UCZYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o3BMwVDUvqhNVOZ/cIBlL/eEF8qwRIumKR1fMWrSA7H4zcSOpuQv/ioQzXQqrodsIUyARBuvkzwtgX1F3ahG1oBV9JsqyrWjN58qqzsylGWNrONt419EuA+HV2Hnb6GN/l1yLYA/QgPCW6C6kp/GDTzIPXK00zlXkPjIpLmtnu4=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nle+vzJj; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d6ee6c9945so20258311fa.3;
        Sat, 30 Mar 2024 02:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711789272; x=1712394072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbl/CLMq3nWKqNjaubWInMz1kaQBbZVVwZ4B6Yhcsik=;
        b=Nle+vzJjShWs0Ti3+DNi47la3wp5ECIHDAW+EvbhX+Ton8pxr5GAT+OKLN9tkpsdWp
         7pmY92Vv0JN9muB7m6ZKKOed2eTaDIbVC7yQe3iYoQYmuzNt6FG/2CRXCn5axo5T0Er+
         mIawl+AjZ9LcJ+2LwfqLqtGS9Swzi333W06D5Rkope/9r9oRpQjGT7vy46uzFz6Xcl6b
         S77spLQ2G+CQpl+4BKwdDBzhD3S36TpnXk6mrY+NzXkbO3VsCQIQvMCBSh38nAhwLdwg
         DDcnS4Gu8cVLbgH/tpVDy41vXbLuY8G8wYbQmHDkXrHBBWVRq9R4WCn8orBArD2q7glw
         BXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711789272; x=1712394072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbl/CLMq3nWKqNjaubWInMz1kaQBbZVVwZ4B6Yhcsik=;
        b=SissUbPdoWrUM0u1xqTsea9iktJot0W8ikz/21w6oDLw29oHo1E/zyykrKQer/3OWO
         qPdKEegxJqdMg3v5GqOnOKWhyGLwFbh6p2b85j1Ts+6BbLFl9oFkAqze+79DH3UTgvpX
         8eHg+dcra2W81v3T0kNwO/Rz19x/a4qUnJoY4xXfsGku0ULlQwIKn/HG4uSfeFFaQsvQ
         uTzuZm8A/9h9KcYqL8SvAcdlpvE/AK5/d243lGtC7Es8bpk5HpBF6YLgEqB9CQU7scmf
         XLKGETg+gvfwQ/3vIK2nDBH9GUewEyTA+wZonkJx4DDqfRJaO4cU3mQBB6idP5IB1mep
         Hw+g==
X-Forwarded-Encrypted: i=1; AJvYcCXMPjsPXXatSVDH641eiZD9Tylx5ujw2zvU8pLsO9HYR1XJhfBDwIOO8cDOnkZQvsFw51iNGrNYsj+ZOC9s/nmtelqQeBg/s4CmUPCyx03PDGJu4fX5flrhGr2i0fu9s/8eCySMSfdAa696W6WVC4RItEDieQnLUtLc
X-Gm-Message-State: AOJu0YxogawIyIXt1FmwtLXKYPIfA7/NqcoJp2+CkbXskVq401KWqBS9
	dv/uHIbm1VAuF/Vdv+59bCR/JaF94WfnbXteVNB+T1wBqWVEkaHONlAM1xQ2s4fdMV8thx39cxA
	tPcarlYh9vw0yYnOBdeRY+OsGAlI=
X-Google-Smtp-Source: AGHT+IGeaymGC7cAQwieQg4TakZq0ARBnpQFix3PExtV6ez87eomevGZHhs6eDxl1CtxiB/HrZm8Uq2a8idogtbdJIc=
X-Received: by 2002:a2e:8612:0:b0:2d6:a5ce:b261 with SMTP id
 a18-20020a2e8612000000b002d6a5ceb261mr2175202lji.25.1711789271815; Sat, 30
 Mar 2024 02:01:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329094906.18147-1-ubizjak@gmail.com> <20240329094906.18147-3-ubizjak@gmail.com>
 <CAADnVQ+6D++hCXaP=aK+Q5wienMzhHo3h9YCvpA_7sHjMt+q6A@mail.gmail.com>
In-Reply-To: <CAADnVQ+6D++hCXaP=aK+Q5wienMzhHo3h9YCvpA_7sHjMt+q6A@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sat, 30 Mar 2024 10:01:04 +0100
Message-ID: <CAFULd4b6juiw3wC3Z61V9=-UnA+NGyUt4231vC14UnGAATk6tA@mail.gmail.com>
Subject: Re: [PATCH RESEND bpf 2/2] x86/bpf: Fix IP for relocating call depth accounting
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: X86 ML <x86@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	=?UTF-8?Q?Joan_Bruguera_Mic=C3=B3?= <joanbrugueram@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-Path: linux-kernel+bounces-125632-steffen.klassert=secunet.com@vger.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 30 Mar 2024 09:01:43.0950
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 728bc2a0-e193-4119-8421-08dc5098051f
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.secunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=cas-essen-01.secunet.de:TOTAL-FE=0.010|SMR=0.009(SMRPI=0.007(SMRPI-FrontendProxyAgent=0.007));2024-03-30T09:01:43.105Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-OriginalSize: 16312
X-MS-Exchange-Organization-Transport-Properties: DeliveryPriority=Low
X-MS-Exchange-Organization-Prioritization: 2:ShadowRedundancy
X-MS-Exchange-Organization-IncludeInSla: False:ShadowRedundancy

On Fri, Mar 29, 2024 at 10:53=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Mar 29, 2024 at 2:49=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> w=
rote:
> >
> > From: Joan Bruguera Mic=C3=B3 <joanbrugueram@gmail.com>
> >
> > The recently introduced support for %rip-relative relocations in the
> > call thunk template assumes that the code is being patched in-place,
> > so the destination of the relocation matches the address of the code.
> > This is not true for the call depth accounting emitted by the BPF JIT,
> > so the calculated address is wrong and usually causes a page fault.
>
> Could you share the link to what this 'rip-relative' relocation is ?

Please see the "RIP relative addressing" section in [1].

[1] https://compas.cs.stonybrook.edu/~nhonarmand/courses/sp17/cse506/ref/as=
sembly.html

In our case:

The callthunks patching creates a call thunk template in the .rodata
section (please see arch/x86/kernel/callthunks.c)  that is later
copied to the .text section at the correct place. The template uses
X86_call_depth in the pcpu_hot structure. Previously, the template
used absolute location for X86_call_depth and the linker resolved the
address in the template to this absolute location. There is no issue
when this template is copied to the various places in the .text
section.

When we want to use PC relative relocations (to reduce the code size),
then the linker calculates the address of the variable in the template
according to the PC in the .rodata section. If we want to copy the
template to its final location, then the address of X86_call_depth,
relative to the PC, has to be adjusted, as explained in
arch/x86/kernel/alternative.c, in the comment above apply_reloc_n
macro.

Uros.

> > Pass the destination IP when the BPF JIT emits call depth accounting.
> >
> > Fixes: 17bce3b2ae2d ("x86/callthunks: Handle %rip-relative relocations =
in call thunk template")
>
> Ohh. It's buried inside that patch.
> Pls make commit log a bit more clear that that commit 17bce3b2ae2d
> broke x86_call_depth_emit_accounting logic.
>
> > Signed-off-by: Joan Bruguera Mic=C3=B3 <joanbrugueram@gmail.com>
> > Reviewed-by: Uros Bizjak <ubizjak@gmail.com>
> > Acked-by: Ingo Molnar <mingo@kernel.org>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > ---
> >  arch/x86/include/asm/alternative.h |  4 ++--
> >  arch/x86/kernel/callthunks.c       |  4 ++--
> >  arch/x86/net/bpf_jit_comp.c        | 19 ++++++++-----------
> >  3 files changed, 12 insertions(+), 15 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/=
alternative.h
> > index fcd20c6dc7f9..67b68d0d17d1 100644
> > --- a/arch/x86/include/asm/alternative.h
> > +++ b/arch/x86/include/asm/alternative.h
> > @@ -117,7 +117,7 @@ extern void callthunks_patch_builtin_calls(void);
> >  extern void callthunks_patch_module_calls(struct callthunk_sites *site=
s,
> >                                           struct module *mod);
> >  extern void *callthunks_translate_call_dest(void *dest);
> > -extern int x86_call_depth_emit_accounting(u8 **pprog, void *func);
> > +extern int x86_call_depth_emit_accounting(u8 **pprog, void *func, void=
 *ip);
> >  #else
> >  static __always_inline void callthunks_patch_builtin_calls(void) {}
> >  static __always_inline void
> > @@ -128,7 +128,7 @@ static __always_inline void *callthunks_translate_c=
all_dest(void *dest)
> >         return dest;
> >  }
> >  static __always_inline int x86_call_depth_emit_accounting(u8 **pprog,
> > -                                                         void *func)
> > +                                                         void *func, v=
oid *ip)
> >  {
> >         return 0;
> >  }
> > diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.=
c
> > index 30335182b6b0..e92ff0c11db8 100644
> > --- a/arch/x86/kernel/callthunks.c
> > +++ b/arch/x86/kernel/callthunks.c
> > @@ -314,7 +314,7 @@ static bool is_callthunk(void *addr)
> >         return !bcmp(pad, insn_buff, tmpl_size);
> >  }
> >
> > -int x86_call_depth_emit_accounting(u8 **pprog, void *func)
> > +int x86_call_depth_emit_accounting(u8 **pprog, void *func, void *ip)
> >  {
> >         unsigned int tmpl_size =3D SKL_TMPL_SIZE;
> >         u8 insn_buff[MAX_PATCH_LEN];
> > @@ -327,7 +327,7 @@ int x86_call_depth_emit_accounting(u8 **pprog, void=
 *func)
> >                 return 0;
> >
> >         memcpy(insn_buff, skl_call_thunk_template, tmpl_size);
> > -       apply_relocation(insn_buff, tmpl_size, *pprog,
> > +       apply_relocation(insn_buff, tmpl_size, ip,
>
> Did the logic inside apply_relocation() change to have
> a new meaning for 'dest' and 'src'?
> Answering to myself... yes. in that commit.
> Better commit log would have made the code review so much easier.
>
> >                          skl_call_thunk_template, tmpl_size);
> >
> >         memcpy(*pprog, insn_buff, tmpl_size);
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 09f7dc9d4d65..f2e8769f5eee 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -481,7 +481,7 @@ static int emit_rsb_call(u8 **pprog, void *func, vo=
id *ip)
> >  {
> >         void *adjusted_ip;
> >         OPTIMIZER_HIDE_VAR(func);
> > -       adjusted_ip =3D ip + x86_call_depth_emit_accounting(pprog, func=
);
> > +       adjusted_ip =3D ip + x86_call_depth_emit_accounting(pprog, func=
, ip);
>
> Now I see why you added extra var in the previous patch.
> Should have mentioned it in the commit log.
>
> >         return emit_patch(pprog, func, adjusted_ip, 0xE8);
> >  }
> >
> > @@ -1973,20 +1973,17 @@ st:                     if (is_imm8(insn->off))
> >
> >                         /* call */
> >                 case BPF_JMP | BPF_CALL: {
> > -                       int offs;
> > +                       u8 *ip =3D image + addrs[i - 1];
> >
> >                         func =3D (u8 *) __bpf_call_base + imm32;
> >                         if (tail_call_reachable) {
> >                                 RESTORE_TAIL_CALL_CNT(bpf_prog->aux->st=
ack_depth);
> > -                               if (!imm32)
> > -                                       return -EINVAL;
> > -                               offs =3D 7 + x86_call_depth_emit_accoun=
ting(&prog, func);
> > -                       } else {
> > -                               if (!imm32)
> > -                                       return -EINVAL;
> > -                               offs =3D x86_call_depth_emit_accounting=
(&prog, func);
> > +                               ip +=3D 7;
> >                         }
> > -                       if (emit_call(&prog, func, image + addrs[i - 1]=
 + offs))
> > +                       if (!imm32)
> > +                               return -EINVAL;
> > +                       ip +=3D x86_call_depth_emit_accounting(&prog, f=
unc, ip);
> > +                       if (emit_call(&prog, func, ip))
> >                                 return -EINVAL;
> >                         break;
> >                 }
> > @@ -2836,7 +2833,7 @@ static int __arch_prepare_bpf_trampoline(struct b=
pf_tramp_image *im, void *rw_im
> >                  * Direct-call fentry stub, as such it needs accounting=
 for the
> >                  * __fentry__ call.
> >                  */
> > -               x86_call_depth_emit_accounting(&prog, NULL);
> > +               x86_call_depth_emit_accounting(&prog, NULL, image);
>
> Overall it all makes sense.
> Pls respin with more precise commit logs.


