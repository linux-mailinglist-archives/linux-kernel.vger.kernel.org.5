Return-Path: <linux-kernel+bounces-88418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3110886E152
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81034B22B71
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447A640859;
	Fri,  1 Mar 2024 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QD43T5sS"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9534384;
	Fri,  1 Mar 2024 12:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709297462; cv=none; b=jVPZRPnfYC7TH/jeY6glQoxOpPSwRDSQwbuNFxVNDPBwUzsOVN+EQlJ1FISZwZmsKUibOrXGPe8WLO8GllJURi9ZCl0sqFKxVF9n3J7RB2Fjsgrhajov916z25T3jg/nHFBcAST15ssVHE88rv3rVLdCEfoehuQ2D3ya/jfvsjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709297462; c=relaxed/simple;
	bh=VT5DENfcjK5kbV+MqzU5qzIwn6hsKvuBbB+SHtYB5J0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XaIEycf57KZm2EREIjwahDnLFfvheR4/B17tnrSdOyGokYmAEoh76nObJ26GNdVnaon/VLmxkb3a4UqusjtbMh9nVIfCSn9poV2FFUkrhw66er92haUeBC7i9pmAJVtl65iDUE5zAI14IiYRVcM15ysPITUAyHuNyNtZfsZJjV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QD43T5sS; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d2991e8c12so20505531fa.0;
        Fri, 01 Mar 2024 04:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709297459; x=1709902259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zY1b3d2Tl1giP5yVHQEYhQx4eA8VNmtdQMtJe0Gl634=;
        b=QD43T5sSZzNamQL4QDQRVV/BjIeHwZ+75qAkrj/vBA2u00KckYzBLjiOr3HYd29x3r
         bq9GxGBVlnEtlwI94IetXtuiB7GU9oGaUbDEC+AZkIzMQFQIKDkLnLIZZjYEP8olX9Sz
         JickUeucm3+4WZwVkseH2G4zKrSf7SeMutJ1O+r1Idlj/EFChKDRU3PLEeEEiZuOWFIS
         4CAgz6ApQ+vQkTHE7i7vbd+jzRhGhQHI5yL9rRWJ4+dTcOZBBiXZWkylwBMHJtN28Q6/
         rw2cML1joVnnfYvLSS1/frUAnqNTBdIJvisjB5vsd3UM2gHNxzIpXWDm5Q04O91oMSON
         qw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709297459; x=1709902259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zY1b3d2Tl1giP5yVHQEYhQx4eA8VNmtdQMtJe0Gl634=;
        b=PL/K9mcse7NDWQiq+ws9MW2jrTmB+nLhx4EB+pKXVYnC0DOqJGfiYQ8mr1BOSXGEoE
         4s+UD/fkq/G7HbyNd7iFhuIJoVjquKVeRohiDrGjlk83CgRDtudxy6DytqFtTQ6gPtJM
         p4R1+1hB3cgvtxqwMrCrKGYVwIlHhshqlgCbig+BODgwmPzNrNJJ7km5BVsttQtyyZwI
         4XaRH3KKu1YjDfVIxGCtcaHYSiCUjf1aG1v9Noe1/gqlfxKncT92VonvfhB8EruATUCo
         eXKoIxPMZ2G7mb24qH90qOCkWAbVqIJxV9TMq66dHiiPCsTEMxcnhxt9nxUly39rfw7n
         Oz9A==
X-Forwarded-Encrypted: i=1; AJvYcCXJhCXx4Xr3XPiIkNuyi0lApXERjYlDyes5PeEKEOHRSR0ZraFdEZPSS5EOWzLCedSnuLLyffRXknHUiTmUp75YLk3ILblTEOehVSOOY4Pm/1Q=
X-Gm-Message-State: AOJu0YzllUD4varDUi9gfgFDIHS6nNu25Jssa2Boz9A6uNidGNiMUbl5
	G+GCMQXWWNPg6hlF/nFrTz2NKWHoZDs0KLzNTM5VD/uz5rkD2Ii9H7TdaCIH680SodLsF/Kih3V
	x7FdVkivgu4OIo7YUQ4V4Fhsb87Y=
X-Google-Smtp-Source: AGHT+IF/okBHsdWykvOzA9eQeCMVyiM6SOfIo5iiI2kr/Lp3p/82mLUnGCMM40kQ8VNQAoRqmHKFVpGvJ1+1OLQ6xbQ=
X-Received: by 2002:a05:651c:113:b0:2d2:28a3:eb38 with SMTP id
 a19-20020a05651c011300b002d228a3eb38mr1937940ljb.8.1709297458632; Fri, 01 Mar
 2024 04:50:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124103859.611372-1-ubizjak@gmail.com> <170929679278.398.4143931058196373559.tip-bot2@tip-bot2>
 <CAMj1kXGc5_AM2AkE+h8EcvYjAGHqeDWRyVRYUGfBjeubeUmJ6Q@mail.gmail.com>
In-Reply-To: <CAMj1kXGc5_AM2AkE+h8EcvYjAGHqeDWRyVRYUGfBjeubeUmJ6Q@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 1 Mar 2024 13:50:47 +0100
Message-ID: <CAFULd4a1sv7LZyT4CMCCsCxi+F9Rm0qAmSV-s=1re_1h71SB7g@mail.gmail.com>
Subject: Re: [tip: x86/boot] x86/boot: Use 32-bit XOR to clear registers
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, 
	Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 1:45=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
> On Fri, 1 Mar 2024 at 13:39, tip-bot2 for Uros Bizjak
> <tip-bot2@linutronix.de> wrote:
> >
> > The following commit has been merged into the x86/boot branch of tip:
> >
> > Commit-ID:     721f791ce1cddfa5f2bf524ac14741bfa0f72697
> > Gitweb:        https://git.kernel.org/tip/721f791ce1cddfa5f2bf524ac1474=
1bfa0f72697
> > Author:        Uros Bizjak <ubizjak@gmail.com>
> > AuthorDate:    Wed, 24 Jan 2024 11:38:59 +01:00
> > Committer:     Ingo Molnar <mingo@kernel.org>
> > CommitterDate: Fri, 01 Mar 2024 12:47:37 +01:00
> >
> > x86/boot: Use 32-bit XOR to clear registers
> >
> > x86_64 zero extends 32-bit operations, so for 64-bit operands,
> > XORL r32,r32 is functionally equal to XORQ r64,r64, but avoids
> > a REX prefix byte when legacy registers are used.
> >
>
> ... and so this change is pointless churn when not using legacy
> registers, right?

Although there is no code size change with REX registers, it would
look weird to use XORQ with REX registers and XORL with legacy regs.
Please see arch/x86/kvm/{vmx,svm}/vmenter.S where this approach is
also used.

Uros.

> > Slightly smaller code generated, no change in functionality.
> >
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Brian Gerst <brgerst@gmail.com>
> > Cc: Denys Vlasenko <dvlasenk@redhat.com>
> > Cc: H. Peter Anvin <hpa@zytor.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Link: https://lore.kernel.org/r/20240124103859.611372-1-ubizjak@gmail.c=
om
> > ---
> >  arch/x86/kernel/head_64.S         | 6 +++---
> >  arch/x86/kernel/sev_verify_cbit.S | 2 +-
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> > index d295bf6..86136a7 100644
> > --- a/arch/x86/kernel/head_64.S
> > +++ b/arch/x86/kernel/head_64.S
> > @@ -169,7 +169,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM=
_L_GLOBAL)
> >         ANNOTATE_NOENDBR
> >
> >         /* Clear %R15 which holds the boot_params pointer on the boot C=
PU */
> > -       xorq    %r15, %r15
> > +       xorl    %r15d, %r15d
> >
>
>    0: 4d 31 ff              xor    %r15,%r15
>    3: 45 31 ff              xor    %r15d,%r15d
>
>
> >         /*
> >          * Retrieve the modifier (SME encryption mask if SME is active)=
 to be
> > @@ -178,7 +178,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM=
_L_GLOBAL)
> >  #ifdef CONFIG_AMD_MEM_ENCRYPT
> >         movq    sme_me_mask, %rax
> >  #else
> > -       xorq    %rax, %rax
> > +       xorl    %eax, %eax
> >  #endif
> >
>
> This conflicts with my RIP-relative boot cleanup series.
>
> >         /* Form the CR3 value being sure to include the CR3 modifier */
> > @@ -295,7 +295,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM=
_L_GLOBAL)
> >
> >  .Llookup_AP:
> >         /* EAX contains the APIC ID of the current CPU */
> > -       xorq    %rcx, %rcx
> > +       xorl    %ecx, %ecx
> >         leaq    cpuid_to_apicid(%rip), %rbx
> >
> >  .Lfind_cpunr:
> > diff --git a/arch/x86/kernel/sev_verify_cbit.S b/arch/x86/kernel/sev_ve=
rify_cbit.S
> > index 3355e27..1ab65f6 100644
> > --- a/arch/x86/kernel/sev_verify_cbit.S
> > +++ b/arch/x86/kernel/sev_verify_cbit.S
> > @@ -77,7 +77,7 @@ SYM_FUNC_START(sev_verify_cbit)
> >          * The check failed, prevent any forward progress to prevent RO=
P
> >          * attacks, invalidate the stack and go into a hlt loop.
> >          */
> > -       xorq    %rsp, %rsp
> > +       xorl    %esp, %esp
> >         subq    $0x1000, %rsp
> >  2:     hlt
> >         jmp 2b

