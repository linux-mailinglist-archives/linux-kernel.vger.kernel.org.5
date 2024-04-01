Return-Path: <linux-kernel+bounces-126956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA758944ED
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F06182826A8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41564778B;
	Mon,  1 Apr 2024 18:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzCIsVIk"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7F41FBA;
	Mon,  1 Apr 2024 18:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711996698; cv=none; b=Sj0Rys6jwDTV6UeYpGOgsWhmGgHnUpcx3obgYi3oza1xTZbJwtkCI5vkkSGtBnUOx5IU+p571M9uotPYW7BFC0bpJCwy1AncOUd04Qzd0eaFgxvS0I0iHrInbS49ILn3xwkg0O6I7iUz1wCDwRZDNwiEP1/BoIT9vH8u3J42MCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711996698; c=relaxed/simple;
	bh=j4ehAdE/QzkOJbJysQusRVbWuR621qTwZB8WUIcsxsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpwS+uiKuhNnArROkYap0ZfWUz02cW8WZ7+JLQmBPB3laEeQtZeLYKNJrI3t8KfeRBSwZPvpg1PMbed4+hxwyKOb2riZaanj3FFGoa3CgftJmHl4/UhfZMfoZSnBb1Ssd2lULE/EBGssHMyALc17BoTnWybl2mfMf6GbXrEUyNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzCIsVIk; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d4360ab3daso55683221fa.3;
        Mon, 01 Apr 2024 11:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711996695; x=1712601495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25Kv1l4+GlOP5k18RqpZVh0+lNMaMtcidh6hzpsaBak=;
        b=TzCIsVIkFBIYmd6lhddaF8WuMzI5S2udeZra5rBygiAv8VFlypnpGYEi/OumShbvJE
         BEeok54HBbNsliZpcD0nClXV1SX06rCxh8c7A074guFBozZY9NUyzAtDG+3YHo4XUX1T
         nWe6jljdsIiJur09c/et+5pXkb8ANDPYasF20aQzwEeBRIA6UIz+/jRD6YhIpTzgO25W
         x3lzm322GN8HRXLEQlrVsyJq7T9o/uggadNCQZWsVvxGtgaB2b3yA24nWyo7CxDVuOvl
         Zclea6FITscJXh49/jp7eiTLiufImPBuV76LuyUJU0fFG9iSKYGG6ptxOCnOSa6jQh2U
         pqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711996695; x=1712601495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25Kv1l4+GlOP5k18RqpZVh0+lNMaMtcidh6hzpsaBak=;
        b=XDM/xFEEL2qfCG/eacvn3oJ1IaD3CAwh+AF1WCmef7oDsMOsbVF7WPfglvDYPaIXKb
         Eh7T8Ck8qqEx+4dmXa0slFWRb8Pjy0DJRi8SyRndwaT4cJjmoj41OKgXAWUz78bOPx3O
         8lEsLkvfDNYICeSDOH+DCo/W8ihKGPHPFYW1bSTyKkXGBKBD+fQgSHEx3XDKr1GtWhoQ
         PZ7Qq3rB0zez0rhGk69+i67QElFyB8Cp4Bmur83z0eglZfpoQiuZT4hQHcH8al4RBhKO
         yNP9Mm/pDr9H4NDvNYEBM15l3CBIFs2/uWJqgfM5YTKgu46APBq2+fzKb7+O/ClEian3
         0ulg==
X-Forwarded-Encrypted: i=1; AJvYcCXNxljV/mz4AxAf4aLO5XAkyOHns20x6q/Ke81+Yx4H76efBMl/devKSz1eMZFXhZLYqAL3hFnv4NwuKBbFE7hCpgpA4SeOZtAw29tKK+uuL+GeP0AixGOurHZ4H8MjUWgvqodlNpNK9beqoxasY818bLQM1zm/nIYg
X-Gm-Message-State: AOJu0YwWL1J51CyPgnlY2Qy8embTgmh+2FVk2p6TkhFThct8VK0aQxgZ
	J0kClWCVlpaxLhREOl9HjVhwaD2VQ6xrGq4x/9oBUldp2Wd3eCSv044hxFvPmuTWDnKaiZFup5m
	g5Xunu12NIlcgdu2UVC0mXXxxG56wi9ZF
X-Google-Smtp-Source: AGHT+IElc/m9n7djfQT2DrLm/RbZ2i8dNVd8JGzSbLCeNy1615HXBpUXl481rv7ld4/uhvoGh0j/FwsarpbeXFAE84E=
X-Received: by 2002:a2e:8513:0:b0:2d8:127f:e3f with SMTP id
 j19-20020a2e8513000000b002d8127f0e3fmr2648439lji.45.1711996694363; Mon, 01
 Apr 2024 11:38:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329094906.18147-1-ubizjak@gmail.com> <20240329094906.18147-3-ubizjak@gmail.com>
 <CAADnVQ+6D++hCXaP=aK+Q5wienMzhHo3h9YCvpA_7sHjMt+q6A@mail.gmail.com>
 <CAFULd4b6juiw3wC3Z61V9=-UnA+NGyUt4231vC14UnGAATk6tA@mail.gmail.com> <CAADnVQKqxQxLLQ6OwZCWni8==-fioeOZ_AH7YVjjCwvYNYmCqg@mail.gmail.com>
In-Reply-To: <CAADnVQKqxQxLLQ6OwZCWni8==-fioeOZ_AH7YVjjCwvYNYmCqg@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 1 Apr 2024 20:38:02 +0200
Message-ID: <CAFULd4ZvxSesz0QhMB7FWS-_H_PpEZhkfqHJ0kmhQUkgL=ASfQ@mail.gmail.com>
Subject: Re: [PATCH RESEND bpf 2/2] x86/bpf: Fix IP for relocating call depth accounting
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: X86 ML <x86@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	=?UTF-8?Q?Joan_Bruguera_Mic=C3=B3?= <joanbrugueram@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 8:03=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Mar 30, 2024 at 2:01=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> w=
rote:
> >
> > On Fri, Mar 29, 2024 at 10:53=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Mar 29, 2024 at 2:49=E2=80=AFAM Uros Bizjak <ubizjak@gmail.co=
m> wrote:
> > > >
> > > > From: Joan Bruguera Mic=C3=B3 <joanbrugueram@gmail.com>
> > > >
> > > > The recently introduced support for %rip-relative relocations in th=
e
> > > > call thunk template assumes that the code is being patched in-place=
,
> > > > so the destination of the relocation matches the address of the cod=
e.
> > > > This is not true for the call depth accounting emitted by the BPF J=
IT,
> > > > so the calculated address is wrong and usually causes a page fault.
> > >
> > > Could you share the link to what this 'rip-relative' relocation is ?
> >
> > Please see the "RIP relative addressing" section in [1].
> >
> > [1] https://compas.cs.stonybrook.edu/~nhonarmand/courses/sp17/cse506/re=
f/assembly.html
> >
> > In our case:
> >
> > The callthunks patching creates a call thunk template in the .rodata
> > section (please see arch/x86/kernel/callthunks.c)  that is later
> > copied to the .text section at the correct place. The template uses
> > X86_call_depth in the pcpu_hot structure. Previously, the template
> > used absolute location for X86_call_depth and the linker resolved the
> > address in the template to this absolute location. There is no issue
> > when this template is copied to the various places in the .text
> > section.
> >
> > When we want to use PC relative relocations (to reduce the code size),
> > then the linker calculates the address of the variable in the template
> > according to the PC in the .rodata section. If we want to copy the
> > template to its final location, then the address of X86_call_depth,
> > relative to the PC, has to be adjusted, as explained in
> > arch/x86/kernel/alternative.c, in the comment above apply_reloc_n
> > macro.
>
> I didn't mean to ask for info about the definition of rip-relative,
> but how it's used in this case and what you've been trying
> to achieve with commit 17bce3b2ae2d that broke call depth accounting.
> And the whole sequence of events that caused this breakage.
> Something like:
> commit 59bec00ace28 ("x86/percpu: Introduce %rip-relative addressing
> to PER_CPU_VAR()")
> made PER_CPU_VAR() to use rip-relative addressing,
> hence INCREMENT_CALL_DEPTH macro and skl_call_thunk_template
> got rip-relative asm code inside of it.
> Hence x86_call_depth_emit_accounting() was changed
> in commit 17bce3b2ae2d ("x86/callthunks: Handle %rip-relative
> relocations in call thunk template") to use apply_relocation(),
> but it was mistakenly made to use *pprog as dest ip,
> so jit-ed bpf progs on kernels with call depth tracking got broken.
> Such details should be in the commit log.

Oh, I was not sure that all those x86 specific details should be in
the commit log, since x86 maintainers already acked the patch. Sure,
I'll add your description of the fix to the patch commit message, it
really describes the problem in a way, understandable also to non-x86
people.

Thanks,
Uros.

