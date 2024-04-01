Return-Path: <linux-kernel+bounces-126931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 024BC89449F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC49A282CF8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A300A4F200;
	Mon,  1 Apr 2024 18:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCqP7Tus"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4318E481C6;
	Mon,  1 Apr 2024 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711994594; cv=none; b=DVti2xeus4xPqCoYrgnTrNS5fpLfHcBdK/CdVmtj27KY+0sjWcLc7IHX9n19aAlYaDY3DX5+BtAtS0TT/Dgdov8dIZ9ZSBPAmZG1x8EsN2v3O2hzd77wosHLdXUoVC4G1Gy4IM6vm+FuZwHrTSWCNJ8yqCDxqAWTY8zSqQUEcBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711994594; c=relaxed/simple;
	bh=dJpGXu0C9rO7fmzbAKI1TioiM08l2gECNbt1RRXQXIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hd44rhaSBd5HkmWo85CIztYJX49fD3HUaCcfBz2xVN+Q+lHGn7ZlUYXpz1FQt0ytDXqdIQletN2/bsSs0f7H4XxRLiQEG+UtHDxGRndZJRn44uUroN/WnzYdTjFIOovLDgXzPtM8l4fYPMkNtqA5nudWawE3zYrpjo0mB6KOIDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCqP7Tus; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3434c6e1941so465941f8f.0;
        Mon, 01 Apr 2024 11:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711994591; x=1712599391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JaPPNMEgkwh4HfN+ukbZ/toOf6Bi9mBKsKcLnPIOUU=;
        b=TCqP7TusWZgzdoKmAF6d+BtqpVpiTtv4KhGRoHG0I8NxP5B3gjXLFHUifuCdk/nBj1
         KWpKAw/fqZMRfsMDJzR09CQ55bWFYsqh6xm8m/zteMhKtRXi66L39BVpaTRWFxnRXV9o
         ZYWX6MCHQwe5yyw5mF4jFLd4LNAKNWU69zn7Lf74e2CMrsP12ircEvhXeMxymPCgPVVi
         XZO4Gl66FU3UhHOky1pYI7FwHczQgigdNfmqr4sEIEVPR3SwTTz1Ot1HDFRfUCK8Xej/
         00j6ysC7aTiupRZI2y9JzoEpFGGbQoNGcA/x8SBU2Iwo69/yqeW0ChpsEe+qfWfOSl5Y
         NZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711994591; x=1712599391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JaPPNMEgkwh4HfN+ukbZ/toOf6Bi9mBKsKcLnPIOUU=;
        b=awAf5iIab2UnWSHquR32lLKDXkQ1mYIj/cQGZm2pD96m+Mke1pLpTGX0fiHNe+RsmM
         3Kn6D/sTRAa9D55KJs8UA+ut5p7Dc4v63Sv/oT1sA3UhhA8fY7gYnV7q7aiF/tkqqvSy
         /7A5HjKSiylZzZPIizb1AAR1PZMEFKsWuOBdeh5qaqHmaTdE33TNsGfG0GdtFaN6f7jm
         VEbFV2n+xPRv5lCgRQEihEccBxK5GkjnjJT9i8lUJghWgY53sGL3gig456R2nKxGVuyj
         K4jiMv0IUNDs7iiYc7zV96AvlcAfbKQKjDdraZIsvtaqHR8pMk7tVzmqrml3ac8H7o8p
         5BcA==
X-Forwarded-Encrypted: i=1; AJvYcCU+oyODtERkwcb2ESwsHFz8eIoGM5+h4UCGNNfRdmYGStRPbdz1Cw3UaVuw4QPXkvuwJc89PJzbPoXV1zSUgIqXmb+GFhwKrd0cKcJX/Ck+yfAK+evH1/QrlUAwlq0xOuRSNHRHYaoQaJB/Oc2Sr+EjMTtwUyENRMyD
X-Gm-Message-State: AOJu0YzRLaoeZRcF0j6fDCx3foBwgMdT4fWYGz5vNoF7EukWiD2uL0cZ
	HQxwNDTwihKUSd1eaoHYhLPiSbIdx/nz8E2chc8LKYtHAoDU4L2vT3ANmI8DAOLbCTsd4zNA18r
	i2YRcLAMol0M962+p1RijHjjurC0=
X-Google-Smtp-Source: AGHT+IHrNStCNtNQGmdjEnbKYU7NKwXc/9dP2cUhAQzSjTICwnMFZo4Sj7nLR7UnIZj7+3aq3HEl8pNjaGLzL+dDelI=
X-Received: by 2002:adf:edcc:0:b0:33e:40a3:22c8 with SMTP id
 v12-20020adfedcc000000b0033e40a322c8mr6490749wro.33.1711994591321; Mon, 01
 Apr 2024 11:03:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329094906.18147-1-ubizjak@gmail.com> <20240329094906.18147-3-ubizjak@gmail.com>
 <CAADnVQ+6D++hCXaP=aK+Q5wienMzhHo3h9YCvpA_7sHjMt+q6A@mail.gmail.com> <CAFULd4b6juiw3wC3Z61V9=-UnA+NGyUt4231vC14UnGAATk6tA@mail.gmail.com>
In-Reply-To: <CAFULd4b6juiw3wC3Z61V9=-UnA+NGyUt4231vC14UnGAATk6tA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 1 Apr 2024 11:02:59 -0700
Message-ID: <CAADnVQKqxQxLLQ6OwZCWni8==-fioeOZ_AH7YVjjCwvYNYmCqg@mail.gmail.com>
Subject: Re: [PATCH RESEND bpf 2/2] x86/bpf: Fix IP for relocating call depth accounting
To: Uros Bizjak <ubizjak@gmail.com>
Cc: X86 ML <x86@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	=?UTF-8?Q?Joan_Bruguera_Mic=C3=B3?= <joanbrugueram@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 2:01=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> On Fri, Mar 29, 2024 at 10:53=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Mar 29, 2024 at 2:49=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com>=
 wrote:
> > >
> > > From: Joan Bruguera Mic=C3=B3 <joanbrugueram@gmail.com>
> > >
> > > The recently introduced support for %rip-relative relocations in the
> > > call thunk template assumes that the code is being patched in-place,
> > > so the destination of the relocation matches the address of the code.
> > > This is not true for the call depth accounting emitted by the BPF JIT=
,
> > > so the calculated address is wrong and usually causes a page fault.
> >
> > Could you share the link to what this 'rip-relative' relocation is ?
>
> Please see the "RIP relative addressing" section in [1].
>
> [1] https://compas.cs.stonybrook.edu/~nhonarmand/courses/sp17/cse506/ref/=
assembly.html
>
> In our case:
>
> The callthunks patching creates a call thunk template in the .rodata
> section (please see arch/x86/kernel/callthunks.c)  that is later
> copied to the .text section at the correct place. The template uses
> X86_call_depth in the pcpu_hot structure. Previously, the template
> used absolute location for X86_call_depth and the linker resolved the
> address in the template to this absolute location. There is no issue
> when this template is copied to the various places in the .text
> section.
>
> When we want to use PC relative relocations (to reduce the code size),
> then the linker calculates the address of the variable in the template
> according to the PC in the .rodata section. If we want to copy the
> template to its final location, then the address of X86_call_depth,
> relative to the PC, has to be adjusted, as explained in
> arch/x86/kernel/alternative.c, in the comment above apply_reloc_n
> macro.

I didn't mean to ask for info about the definition of rip-relative,
but how it's used in this case and what you've been trying
to achieve with commit 17bce3b2ae2d that broke call depth accounting.
And the whole sequence of events that caused this breakage.
Something like:
commit 59bec00ace28 ("x86/percpu: Introduce %rip-relative addressing
to PER_CPU_VAR()")
made PER_CPU_VAR() to use rip-relative addressing,
hence INCREMENT_CALL_DEPTH macro and skl_call_thunk_template
got rip-relative asm code inside of it.
Hence x86_call_depth_emit_accounting() was changed
in commit 17bce3b2ae2d ("x86/callthunks: Handle %rip-relative
relocations in call thunk template") to use apply_relocation(),
but it was mistakenly made to use *pprog as dest ip,
so jit-ed bpf progs on kernels with call depth tracking got broken.
Such details should be in the commit log.

