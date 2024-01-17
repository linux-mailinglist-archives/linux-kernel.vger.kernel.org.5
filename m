Return-Path: <linux-kernel+bounces-29003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CED8830697
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8E4287CD6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F67B1EB37;
	Wed, 17 Jan 2024 13:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="EgN/ZODz"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B9B1DDC9
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 13:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705496820; cv=none; b=sKrYxCoToF9Tx58rzAX9dx5i5ahE0FJVSE97h+1n17ewu3PWlYswLj1ethYBOMVXzRK+R45m5sTuJhsRRl20hsNd1AJocMKWHGX7RUqMx6wXsafAIaf9MUFaexHEABKm1vbWYCJWI0YATIi2xb2adRGcHZvNABE7Lry41VWzD6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705496820; c=relaxed/simple;
	bh=+iccQ9RDRKo+U5kOojUc8XJKb8fhdLp9mgj0tdfmQ0k=;
	h=Received:X-Virus-Scanned:Received:DKIM-Signature:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kpNu11zbrkvg5MfmwmyXyHedZcK4rCuWawsjqGWeJqjNdIC5ASclmPVr9xc1peCGjjOcVVTZFoMYVPOjKfsIBDc3o+nliGVgeS7hNk6aGZlDw284IZInuYQHY4BpcNg4g82By8eD9BYyOXHqP9fqWc7FT6gKn6+ZL8egpr5yaAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=EgN/ZODz; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8187840E01F9;
	Wed, 17 Jan 2024 13:06:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0UjbuZsisOSy; Wed, 17 Jan 2024 13:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1705496808; bh=XtdEgP6dOqkMXgOKRwFSLg/wNuK24wOiZgQ/zzNNgN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EgN/ZODzUr25dK36lZC4hinfYq3WyZn7sM3FM0/QtznryZKJKHIYoRX5jYsKGU+TM
	 wnpu4IxCGrerzDsmqTTP00384xIY9c1cB2YkT7fEFJ1Uv/TauCzURZQE/Pyn1jT0Xz
	 XGLvvbNUz3Niw5zzGVJIDgzsnSa4yvYbeJR2XAlPlSTe2goswsySiC1crcxMn0I7V+
	 86nzV6682Pos3k6D8iwZeN0QQPQLmXghfjOKU/s4t1JgTgVK1dcKGE1BxMNGjeM+y2
	 pSEhLepePpTPqscWXMLrzr2dyySlSY24YXeQ+p+7ATNaorcw3NeUFGuVeer1rFP349
	 /zREIybjklViYwKGK5Bwp9Vu+9CJ03NO+WRfM/TBZL3JGgL26gU7UuqqMyH/TyNdr6
	 qB2GUx+BqMrWy354WXbvpNPXoTzBjtLJFYZ6aFUi5BKDxF/8ep79xU7H3nPGR/v0Gx
	 cQQeObpn5VA2YjUbZ5inPvbSerNXQtr1bQFy1JQ1s8EkY2i7H3xEd8bSil/fwzCIul
	 h6MElaoZ5znMuv4CEbHC/sW03BZ5/daAl2qEVJwjrFOwNhK/MsqJ9bt6meUUKo0KuN
	 57fBl2DNO3Nkcc9VGpLTygX0Zf8FYEB9qubRYa+PLRlb0/igeW7Ef+krpNAIXx65R0
	 GFBWdqA3GAqJ0cyAjXak8Hjc=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A7CC840E01A9;
	Wed, 17 Jan 2024 13:06:03 +0000 (UTC)
Date: Wed, 17 Jan 2024 14:05:57 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Kevin Loughlin <kevinloughlin@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Arnd Bergmann <arnd@arndb.de>,
	Steve Rutherford <srutherford@google.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Hou Wenlong <houwenlong.hwl@antgroup.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>,
	Wang Jinchao <wangjinchao@xfusion.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Brian Gerst <brgerst@gmail.com>, Hugh Dickins <hughd@google.com>,
	Joerg Roedel <jroedel@suse.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-coco@lists.linux.dev, Ashish Kalra <ashish.kalra@amd.com>,
	Andi Kleen <ak@linux.intel.com>, Adam Dunlap <acdunlap@google.com>,
	Peter Gonda <pgonda@google.com>, Jacob Xu <jacobhxu@google.com>,
	Sidharth Telang <sidtelang@google.com>
Subject: Re: [RFC PATCH v2] x86/sev: enforce RIP-relative accesses in early
 SEV/SME code
Message-ID: <20240117130557.GDZafQtfRyeVFbBUXA@fat_crate.local>
References: <ZZ7YuEexYSaZYmLK@tassilo>
 <20240111223650.3502633-1-kevinloughlin@google.com>
 <20240115204634.GHZaWZqsVyU_fvn_RW@fat_crate.local>
 <CAMj1kXH=k26nNyB+LQJ7WUJgbD2f3PREyjCzSngMCGc+72XJ6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXH=k26nNyB+LQJ7WUJgbD2f3PREyjCzSngMCGc+72XJ6w@mail.gmail.com>

On Wed, Jan 17, 2024 at 11:59:14AM +0100, Ard Biesheuvel wrote:
> Fully agree. All this fiddling with RIP relative references from C
> code is going to be a maintenance burden going forward.

Yah.

> The proper way to do this is use PIC codegen for the objects that
> matter.

And we have arch/x86/mm/mem_encrypt_identity.c which is supposed to deal
with stuff running from the ident mappings and PA == VA.

We could put the rest of those special SEV things there or do a separate
TU to be built using something like PIE_FLAGS, as in your patch.

> I had a stab [0] at this a while ago (for the purpose of increasing
> the KASLR range, which requires PIE linking) but I didn't pursue it in
> the end.

FWIW, that looks a lot more like a natural kernel code with
__va_symbol() etc. Definitely better and we talked about it at some
point already as it does ring a bell.

> On arm64, we use a separate pseudo-namespace for code that can run
> safely at any offset, using the __pi_ prefix (for Position
> Independent). Using symbol prefixing at the linker level, we ensure
> that __pi_ code can only call other __pi_ code, or code that has been
> made available to it via an explicit __pi_ prefixed alias. (Happy to
> elaborate more but we should find a smaller audience - your cc list is
> a tad long). Perhaps this is something we should explore on x86 as
> well (note that the EFI stub does something similar for architectures
> that link the EFI stub into the core kernel rather than into the
> decompressor)

Grepping through the tree, is __pi_memcpy one example for that?

It sure looks like it with the alias and all. From a quick scan, that is
not that bad either. It gives you the clear distinction what that
symbol is and who can call it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

