Return-Path: <linux-kernel+bounces-88671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1E786E50F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 399A0B23CF9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC7170CB1;
	Fri,  1 Mar 2024 16:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NDzNuBrz"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0561870030
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709309572; cv=none; b=S01lgJ9Y1FFjSZG/VSRGXZKBhJhh2TEKJFXBNyAV5qFs+QqGmNvX26jzJseT8D9fuzpr29ANRudM0tMpgdY3TrWelzlh8VtL7fg5N29+dAqnyjehw+QwPqOAPLF+vfvE/nrdOZ3DW8o1vN2ph4/1TKEyb0D54ENHAVi0LF34ULs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709309572; c=relaxed/simple;
	bh=vDh09+dZ3VBmJF68aeZGfTWrikih0aY1G6yd5Dg8oO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GO2JJzzhXTUDg6t0e6NIjXVtNoMh3CO+AutBSKoOmJi21IwcM9aWJAGwQ7HF01d83Fer3xebcPcCIgHZU+8JUrsnrb9axwRdte4jBs+5gcwT2Byl78iI8mJgpf9zu766AnkeuezYBin5rBsus4X6FuAvftYhWF06FqfQJMe/4EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NDzNuBrz; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 30A8240E0185;
	Fri,  1 Mar 2024 16:12:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7ioUtbWqE6Q9; Fri,  1 Mar 2024 16:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709309566; bh=wJEN0joQiYmuo6Ze0sGnkJl0zJ3wbOy6dvxMTyKWEa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NDzNuBrz9Xbn608O1fqBcbogJkQGMUN/1nMKmo2AV/Ex8UuybWZMkypFvAXDog1jU
	 uAVsXlSgi5QtOPycs/jQ6jiI8ocLJa2JXk9OVs0ZpI4qa3J4vqr1ZnTUaARtLDU8xu
	 NUOFDvKzQk4XHSZx+vCMQjmPlsibe6KURvY85pEeDsG++6hm5XlEYopzqGpmaru0w0
	 1/c20Tb5JjFPAVGzHQNxTXpKzJqRp48QKbaHRoKPjpwrq7GGHIiAcOmLhaRKUPTSWw
	 Q3bbZ1WI/My9XEA9lnmppRLh9Tr5sQ9nErecKTyg0+p83RGeT3qRjRiN6H0qjPAiYT
	 QQkHSP8y4BSWE237neLwfqH2f7Rie55Suy3jl5GnAfF8vY38N2MfW3yhqFSH5P60Iy
	 JYmujTeGKdCNPhuaCBqZwws8aT6+BU2+GyOpfMW/DuLwJxZKEN9GkW8o/fypRgwa3W
	 JAP8BNmcaBoKvj8+Rw+PjJjJXNeWF36WflhJ2Pok6CSWeCafmNQmNtPGhcBgPYZqb4
	 jcxrgn4ivlo4/+8aQG0URuJHfxoMML/trPkgTC3PmGWi20fyek3zaxRLAbFTxaUyD+
	 yQCGcdivkq1cV9KUsHg+whvwOw4nyqirnLTfVy6sw7BEw80mqIpDdO8b3eD85axZmV
	 Fw/epio9qqARIYDGnE07LvH8=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1E17940E0028;
	Fri,  1 Mar 2024 16:12:35 +0000 (UTC)
Date: Fri, 1 Mar 2024 17:12:34 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>
Subject: Re: [PATCH v7 4/9] x86/startup_64: Simplify virtual switch on
 primary boot
Message-ID: <20240301161234.GCZeH-co78aShifhAN@fat_crate.local>
References: <20240227151907.387873-11-ardb+git@google.com>
 <20240227151907.387873-15-ardb+git@google.com>
 <20240229103740.GKZeBedEybE0IeOXUG@fat_crate.local>
 <CAMj1kXEwRgbVtnNA2_Ewt0p2azpx=MBnc94fNWVZrzr4aH2EkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXEwRgbVtnNA2_Ewt0p2azpx=MBnc94fNWVZrzr4aH2EkQ@mail.gmail.com>

On Thu, Feb 29, 2024 at 11:36:01PM +0100, Ard Biesheuvel wrote:
> Because we enter with a 1:1 mapping, and so we can only switch to
> another set of page tables that also includes this 1:1 mapping. Once
> we are running from the kernel mapping, we can drop the 1:1 mapping
> but we still need it.
> 
> What we could do for robustness is reduce this 1:1 mapping to text +
> rodata, and make it read-only, but I'm not sure it's worth the churn.

Yeah, I was experimenting a bit with some shenanigans with those two
pagetables yesterday and arrived to a similar conclusion - there's no
point in trying to unify them.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

