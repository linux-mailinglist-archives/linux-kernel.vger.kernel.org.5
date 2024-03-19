Return-Path: <linux-kernel+bounces-107531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5563C87FDBA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B8501F22162
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F161A5A4CA;
	Tue, 19 Mar 2024 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Et3Hm9Ji"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62295A4C7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710852350; cv=none; b=dac2UqG0XZ673uH0Ds5t3oC7XS0Ng3gWBEHCGL/P0ZBHN6+BLzk9pJ+hDhVUodsdzhvqcBvMtNPbmK2+ourj8OXUVBbQ6Ds3yl1P4gQhwsh+Tx36AaO6RKDRsEGEl7uchmkYe2KSOj7y873usi5EUgVB2r7LKnXrk31Y+Z7+M34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710852350; c=relaxed/simple;
	bh=Vq5FfZgwtJTnS/zN0GAF3T/ikNNPCy9YkKCxgLh4tTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwSALvW7wICGYZcz1HV/KzHApY0ZyrFTZvGqnzTWQyPollCBWGgwcahDrW+/RM8sf4hnxWQyNSCVGH84Ke4zvDWt0nFxPBSDkm3ix+Z/7Kg2xTrS35gnKDZoOyQNc6koOdMrOyMF9wHqTQlTzaYA32o2tSk8ZMavqeDPd6LtcPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Et3Hm9Ji; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DC2BC40E016C;
	Tue, 19 Mar 2024 12:45:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RQzMyzj0HghI; Tue, 19 Mar 2024 12:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1710852340; bh=QCnVQ6eF8q7c3H5K7fRMGpDCEN2zvByN9L+V6LcZ1Jk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Et3Hm9JiolA9aI76GMPr2Avio38cnEMabndlqy6Ti3VdhnvqlJXlnbfI6T6nlXjqN
	 oS/TroIo1tLAQzBUP4eJCc9dDy7UkxAuZI8zWa3S9eRzcdzcEyHOSQVimzYpCn3Vfh
	 8AxMDUj6w/UQSLMW5bgyV8IEVACukmVQBORWFM4p8/xi6hXa+pS2RvDPX9gYuodp+F
	 2JoA7K+G+gONWmCwZrpRn9T89w8g92i6hj7HIMV+goEkqv3rat0+z2ssjjBZI6ggOt
	 yNhQ+L8+4L5KGpaYXZTfDLnVhbkJ7CrsZSxJzNAu5ed4YmyumsRn1sLaR5H1H+P9sv
	 SN0A2+UH4u1EVi6OlCrSMka3IrPPI4RrsrSp33Ggj1Lacl9A8lkjrVsciXyMdZ+/oC
	 i3ZtPW+NP8Ha/LExRJrw8R6fFOxwwttGAMhDQkX/uQWXYPGqSKPlez8MZ5mtXjmd5j
	 zS5jXoEX7j8EZ0y1a8BTOdJAoL5ATN1gTExjJPphZf+S6VDkG+fyk/USHMttSslkM6
	 JF0EEM9Q6pyjXP39qun77l5ntLt9JigHZhvmeCREPi67Ywa4x+1dBdutf/J4rFppNN
	 1/bns/P5R/BMxN808sizeMGAcedQ1zwx+nTgTp4lqttCDocM5pLWyqyNNQhBRQdQRS
	 m+a5lGCGG7bVBNkQ5LBlrdtk=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 69EEC40E0140;
	Tue, 19 Mar 2024 12:45:29 +0000 (UTC)
Date: Tue, 19 Mar 2024 13:45:24 +0100
From: Borislav Petkov <bp@alien8.de>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH -tip 0/3] x86/asm: Use generic asm operand modifiers
 instead of %P in asm templates
Message-ID: <20240319124524.GBZfmI5IWLaioPcOUz@fat_crate.local>
References: <20240319104418.284519-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240319104418.284519-1-ubizjak@gmail.com>

On Tue, Mar 19, 2024 at 11:40:11AM +0100, Uros Bizjak wrote:
> The "P" asm operand modifier is a x86 target-specific modifier.
> 
> For x86_64, when used with a symbol reference, the "P" modifier
> emits "sym" instead of "sym(%rip)". When used with a constant, the
> "P" modifier emits "cst" instead of "$cst". This property is used to
> emit bare symbol references and bare constants without all
> syntax-specific prefixes.
> 
> The generic "c", "n" and "a" operand modifiers should be used instead.
> The following table shows the modifiers supported by all targets and
> their effects:
> 
> Modifier    Description
> -----------------------------------------------------------
> 'c'         Require a constant operand and print the
>             constant expression with no punctuation.
> 'n'         Like '%c' except that the value of the constant
>             is negated before printing.
> 'a'         Substitute a memory reference, with the actual
>             operand treated as the address.  This may be
>             useful when outputting a "load address"
>             instruction, because often the assembler syntax
>             for such an instruction requires you to write
>             the operand as if it were a memory reference.
> 
> Also note that unlike GCC, clang emits %rip-relative symbol
> reference with "P" asm operand modifier, so the patch also unifies
> symbol handling with both compilers.

FTR, I really appreciate the clear explanations of the operand modifiers
along with an example in the commit messages. What they really do and
what they mean have caused some serious head-scratching in the past, up
to the point where I went through gcc sources with Matz' help to figure
out what some of them do.

So thanks!

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

