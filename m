Return-Path: <linux-kernel+bounces-88436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EA986E196
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF218284583
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBC16A8AD;
	Fri,  1 Mar 2024 13:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJPItqIe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C94386;
	Fri,  1 Mar 2024 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709298643; cv=none; b=qLLM+OGZyK0Mm8NAl7r4esSMeVn4TSdaMxReFHLbuwQxPno56TKWJxDDAPYIKTvNtFijza2Md553PRvwlJKQ0ZSWjzxMUomoBuwbzVukMZ1vFso2/IjZ15CLUdWV8ncVj1+R+FUjEdnb0DSmaKrL00DAocvzIKXF81PdTJq9Ix8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709298643; c=relaxed/simple;
	bh=FWNZGALuy9LKHLCUIYnyrWDJYMY/EEJ8y7dNVTLrZmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ApJJU0NuKN0ogAAzOz651tJ9jwim97Clg8DYERedLHY7wwVyMVE2KIO32d0o255qu1i4BD4wxmWeMuuyLeqsC7nh2wbk0ykvTi+wFjAYgBuaOykOVCLhLnz7Uf4W7/pMkPxUWmIqfDW1OmsZG4XaYohe6UWDjGfAWmF6wMXduGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJPItqIe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB93C43399;
	Fri,  1 Mar 2024 13:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709298642;
	bh=FWNZGALuy9LKHLCUIYnyrWDJYMY/EEJ8y7dNVTLrZmI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GJPItqIeUcdzqZpY9D8XqX1OKP/U2pNSEbBwkzX1IhqBpUEbay83reMQ8R8aZJu/z
	 v6axSf2a9St3HNXCLzQYGfUSDqKCD9KSBw3or/CYrgC0yFct/lrPNRvAsJPIGFQEt/
	 550iH4Gwi1kxDWOCBo+p1eGkAqrFF4tOMsjwTxDpmBuu46aHpjl4qf2pY4RtYx01lP
	 DfQxXO7ZdL+U3sQOkxqgm6ELTvzSwuLMKvFpTYTdZSvJH50SbjdF4rWtGUkM+81N5l
	 I6FLCpy9XNskPreBN5Vwy76UCDYU8yhP2EbpD0G7JbMNIJQMlvwnoCcKPbdwzNAu2W
	 OdXFuDop6kfUw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5132181d54bso2331965e87.3;
        Fri, 01 Mar 2024 05:10:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVdj+4DsmeqFKqNMwvgqnz22OVsNyjtEO8rSz1n4dtLkuDTnB8baYQ7LMSV1wYzOe/NYs15QsbtCdwtvz/mnuPN4Jo89atlUFCahMuOLr4/9EE=
X-Gm-Message-State: AOJu0YyDPj+hYewLzUFW+A77I8Cj4MjQ0+in7C12w7PpdI2GU0Z/gAZE
	99tKHBXe0MbqG+Slg402mg4q2oB0uuq2/DjzDbNDrQNFE0fYwm1BOaJTumYkRoa0OXqDiYgIwvl
	WanhzTYKyJh6weMOZFv75FTX9T/0=
X-Google-Smtp-Source: AGHT+IHpVO6RoVQ73TeyBXeu0f37zENu/qnAfqhkOVwDUoSfHThYmDGNCFsr3QFzgc3nmOpV256AEVR3McVpcKKkyao=
X-Received: by 2002:a05:6512:402:b0:513:17bf:87d5 with SMTP id
 u2-20020a056512040200b0051317bf87d5mr1128782lfk.63.1709298640476; Fri, 01 Mar
 2024 05:10:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124103859.611372-1-ubizjak@gmail.com> <170929679278.398.4143931058196373559.tip-bot2@tip-bot2>
 <CAMj1kXGc5_AM2AkE+h8EcvYjAGHqeDWRyVRYUGfBjeubeUmJ6Q@mail.gmail.com> <CAFULd4a1sv7LZyT4CMCCsCxi+F9Rm0qAmSV-s=1re_1h71SB7g@mail.gmail.com>
In-Reply-To: <CAFULd4a1sv7LZyT4CMCCsCxi+F9Rm0qAmSV-s=1re_1h71SB7g@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 1 Mar 2024 14:10:28 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEg=mFe0pJyiLNVV2Am8NJadPR3M-2iAYYj1+jNyaHgBg@mail.gmail.com>
Message-ID: <CAMj1kXEg=mFe0pJyiLNVV2Am8NJadPR3M-2iAYYj1+jNyaHgBg@mail.gmail.com>
Subject: Re: [tip: x86/boot] x86/boot: Use 32-bit XOR to clear registers
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, 
	Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 1 Mar 2024 at 13:51, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> On Fri, Mar 1, 2024 at 1:45=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> w=
rote:
> >
> > On Fri, 1 Mar 2024 at 13:39, tip-bot2 for Uros Bizjak
> > <tip-bot2@linutronix.de> wrote:
> > >
> > > The following commit has been merged into the x86/boot branch of tip:
> > >
> > > Commit-ID:     721f791ce1cddfa5f2bf524ac14741bfa0f72697
> > > Gitweb:        https://git.kernel.org/tip/721f791ce1cddfa5f2bf524ac14=
741bfa0f72697
> > > Author:        Uros Bizjak <ubizjak@gmail.com>
> > > AuthorDate:    Wed, 24 Jan 2024 11:38:59 +01:00
> > > Committer:     Ingo Molnar <mingo@kernel.org>
> > > CommitterDate: Fri, 01 Mar 2024 12:47:37 +01:00
> > >
> > > x86/boot: Use 32-bit XOR to clear registers
> > >
> > > x86_64 zero extends 32-bit operations, so for 64-bit operands,
> > > XORL r32,r32 is functionally equal to XORQ r64,r64, but avoids
> > > a REX prefix byte when legacy registers are used.
> > >
> >
> > ... and so this change is pointless churn when not using legacy
> > registers, right?
>
> Although there is no code size change with REX registers, it would
> look weird to use XORQ with REX registers and XORL with legacy regs.

You are changing an isolated occurrence of XORQ into XORL on the basis
that XORQ 'looks weird', and would produce a longer opcode if the
occurrence in question would be using a different register than it
actually uses.

Apologies for the bluntness, but in my book, this really falls firmly
into the 'pointless churn' territory. The startup code is not
performance critical, neither in terms of size nor in speed, and so
I'd prefer to avoid these kinds of changes. Just my 2c, though - Ingo
has already merged the patch.

