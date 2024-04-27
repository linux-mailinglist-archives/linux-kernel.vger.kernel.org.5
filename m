Return-Path: <linux-kernel+bounces-160934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 086FD8B44C3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 09:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A0561F22F62
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 07:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027C542061;
	Sat, 27 Apr 2024 07:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stlKKaU2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4601E3BBD2
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 07:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714202469; cv=none; b=RMJnVrjnPmgaqFVtivnK8RssSLZA0/VB16S0r/vSRXaKgkytIPAI7C2p5Apy5jzTtipZpJGK7bds/kqm0j2kI/fhxe31gJLjMGsu37UmPR6k9q8KUT3YX2nFxqpo3h8et766TP6bv/9YW/EhMgDFQBDySg+m5t1yJX7pJiRsQrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714202469; c=relaxed/simple;
	bh=fIKMQoy1qd6Gq+28Yk3Ch3hYiaG++Dtnw8dmDRpSlkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdc5CCyjpNVUHPG4n3t0vQJ1RGSS2hKRezS5Zl8PW6r9wxyiiX3s446RDy69GU/MsPOxijy5+hovrYI5rL+XJuVQdE6VXTecfTYe2QxYB5biI3+B4f7F5E2qI5j078OlnfVCWNiCbkQLOr9J2BXTY5N88IBWfOiTmXPn1WAnjMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stlKKaU2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1435C116B1
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 07:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714202468;
	bh=fIKMQoy1qd6Gq+28Yk3Ch3hYiaG++Dtnw8dmDRpSlkQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=stlKKaU2j2DjJyYwRzVaqC0juIAcGM+d33oITQw3cy+Zc7YSQlzZ7diR8n3WxvUyX
	 e5wzdmswmkwiXhdYRu2Hk8k5hSnIB7JqNSVT1s42uUHIOLLeZpRCE4Fxm2PkdFPFtc
	 oNxkk8sTHSlsuW+hpZSJFDNQwQovKgO4nuhW+S0RspLOAgX8dxf7kq/b4HIK36UKDN
	 oj3mHBkom6uAInCMYAvtfdLngn0AdgYaD+GgVOVjaX5OolroPrtTxJJUrn2VlQzash
	 xfZzZPJURQL459Pg7s+tA9u3fKVrtfeq8LNaQK0TGXEs2u8K7VObylbkCkZ61mtbda
	 cTYDNB7931BGA==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a587831809eso332646666b.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 00:21:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFufQ/CBMKjcu8YM1DXeb/s/hndU//A+wAWmKyvCf+VLUoV83BhoxrVhmTDKITG9WiMfW/TIPssaLCIkfZZNEWD7pMRG/gbLnAthXS
X-Gm-Message-State: AOJu0YzLfabcGaM+QTuIqTJc2qNPmhuKQTT+LKTbcOA9R9uckzMSbpXc
	SF3ELIZsuek7ih4BcAi0FbRrV8wfSLTp2ZWlDmcV2SbqbPp4BJeKbPDfezrGXVlhG/Yuh25/Jjj
	bMS6x60X5e3qD42Uhk4M3dFDQYxg=
X-Google-Smtp-Source: AGHT+IERNGO0O077Rbp+jM0YFOExBijTH2r3fxwSSGP/zOihb5L2+1soR8d5Hjmf0QZ0gefOQxQo01YVKKaB6OplKrc=
X-Received: by 2002:a17:906:f348:b0:a52:6e3e:c55c with SMTP id
 hg8-20020a170906f34800b00a526e3ec55cmr3117324ejb.70.1714202467397; Sat, 27
 Apr 2024 00:21:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426121442.882029-1-xry111@xry111.site> <CAAhV-H74cQ4XdDez5PipCxUZTpfS=CA6azL5qob=jGGebobD6g@mail.gmail.com>
 <dfdc9823a0b89c8582587fa75448bba5c3a7e15e.camel@xry111.site> <56414029e179d219442bde9b8eae81fa3e3ceec4.camel@xry111.site>
In-Reply-To: <56414029e179d219442bde9b8eae81fa3e3ceec4.camel@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 27 Apr 2024 15:20:55 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5vrCrBFhDKjTXchCGABWHT6Wxz1JK6hNsarOwp+vfHpg@mail.gmail.com>
Message-ID: <CAAhV-H5vrCrBFhDKjTXchCGABWHT6Wxz1JK6hNsarOwp+vfHpg@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Provide __lshrti3, __ashrti3, and __ashrti3
To: Xi Ruoyao <xry111@xry111.site>
Cc: WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 27, 2024 at 12:13=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wro=
te:
>
> On Sat, 2024-04-27 at 12:00 +0800, Xi Ruoyao wrote:
> > On Sat, 2024-04-27 at 10:50 +0800, Huacai Chen wrote:
> > > Hi, Ruoyao,
> > >
> > > I don't think #ifdef CONFIG_ARCH_SUPPORTS_INT128 is needed here.
> > > S390/ARM64/RISCV all built it unconditionally.
> >
> > The problem here is RISCV and ARM64 are using an incorrect prototype fo=
r
> > these functions in asm-prototypes.h:
> >
> > long long __lshrti3(long long a, int b);
> > long long __ashrti3(long long a, int b);
> > long long __ashlti3(long long a, int b);
> >
> > where "long long" is not 128-bit.  Despite this seems working for RISC-=
V
> > and ARM64 I really dislike it.
> >
> > S390 seems assuming CONFIG_ARCH_SUPPORTS_INT128 is always true, but I
> > don't think we can assume it too (at least it'll likely to be false for
> > LA32, so doing so will cause trouble when we add LA32 support).
> >
> > So if we don't want to check CONFIG_ARCH_SUPPORTS_INT128 and still use =
a
> > correct prototype, we'll do:
> >
> > diff --git a/arch/loongarch/include/asm/asm-prototypes.h b/arch/loongar=
ch/include/asm/asm-prototypes.h
> > index 51f224bcfc65..0a57db01116d 100644
> > --- a/arch/loongarch/include/asm/asm-prototypes.h
> > +++ b/arch/loongarch/include/asm/asm-prototypes.h
> > @@ -7,8 +7,6 @@
> >  #include <asm/ftrace.h>
> >  #include <asm-generic/asm-prototypes.h>
> >
> > -#ifdef CONFIG_ARCH_SUPPORTS_INT128
> > -__int128_t __ashlti3(__int128_t a, int b);
> > -__int128_t __ashrti3(__int128_t a, int b);
> > -__int128_t __lshrti3(__int128_t a, int b);
> > -#endif
> > +struct { u64 lo, hi; } __ashlti3(u64 lo, u64 hi, int b);
> > +struct { u64 lo, hi; } __ashrti3(u64 lo, u64 hi, int b);
> > +struct { u64 lo, hi; } __lshrti3(u64 lo, u64 hi, int b);
>
> Whoops.  This is still incorrect for LA32.  On LA32 an "int128" (if it
> ever exists) should be passed as a pointer, but this is passing it in 4
> GPRs.  So if we want to keep the prototype correct we need to either use
> "struct { u64 lo, hi; }" in the parameter list too, or guard it with
> #ifdef CONFIG_64BIT.
>
> So to me checking CONFIG_ARCH_SUPPORTS_INT128 is just easier.
>
> If you insists on not checking CONFIG_ARCH_SUPPORTS_INT128 I'll just use
> an incorrect prototype like RISC-V but put a comment here, like:
>
> /* The prototypes are incorrect but this file is only used by
>    modpost which does not care.  */
> long long __ashlti3(long long a, int b);
> long long __ashrti3(long long a, int b);
> long long __lshrti3(long long a, int b);
>
> How do you think?
OK, then just keep the original status.


Huacai
>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University
>

