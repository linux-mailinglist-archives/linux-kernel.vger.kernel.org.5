Return-Path: <linux-kernel+bounces-32147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5A683573F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 19:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0A2B1C20E50
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 18:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B319A38383;
	Sun, 21 Jan 2024 18:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AUFIZ7Hk"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590C138382
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 18:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705861306; cv=none; b=TpJDM4NW9LA5BxOl8OLDwXPhWtN+INWffd80Fr9yXuRbxp9UgJKsYP1fhXrWf5EMe7RC3e0XXlTFF8A4arwcuDvKhx1msAer1xsVJRFnvgwalo5hefSVXfjOE7Em8lbsVQY9a6ldgNJj3E4R99Sn5h5vwoB8PSzapCOvytB9/Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705861306; c=relaxed/simple;
	bh=RQcsOSgWEkebJ4aFw/hm8jeagskSK6NIf06EChLFEFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLvbj49R0aj5xfDVCXw+4ocWKQSvJDknNKlvV9btSYDsvLE0zWgzNKj/rlRuHQwhUbVzcSFfxQFXN09eRPmnNOktMVL0qRAUzVcBuVpLwKb5wHsrG7D0ZsBCEXJTaEkFCJsraAPzs5Iaj3YDcDb4RBVv/LYaNLEc/CRGykiZ7wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=AUFIZ7Hk; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0BC2C40E0196;
	Sun, 21 Jan 2024 18:21:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VCM38jTVkex4; Sun, 21 Jan 2024 18:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1705861298; bh=2hNU8iQHcvaHyKkIctC4wY2bSsuo5SQCshNeksB3b9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AUFIZ7Hk5hJYAryXMjEguN4LPCmbfR1Nng9ffvRWSHC+bsGYm64r6JfARdgqXJlFD
	 Y/PYUqLriC0c9MrHq/sdO1CWZ7yBH6xyibOXFi1lDlNGzA6a+mB1CNOTL+VWvvKL73
	 8RtnMSA2MszsvHeBMiMXZZ+Hf7atcfj2+K9S30DuYm9sMvDGmABj+SPLLBLhn35G4t
	 F6VtYrIjqwQCEliQn3z6mTBXo3PvZ0Xg0a88ROqVayPGTLaoq91BgqmJ/lsR30pwQr
	 Nu9MMyWiHp6mOz+JsS286w1D31wCvvxolniMU93s7OEOzs1kuaQo9YVH8U531CMvv4
	 UruUYm6xk/NrFUcqP4mNTJN+6PBuAZpjR4wSDFJTBu4hSGj94vMuWVLkZnMuZc25YX
	 8jscNfujSdUHFqzD7bMM7gzxUEaJ5aO/3I6if/dfH+zSbpoZH8gtkAXFdAtvCAa39/
	 xzy327AuL5qiWo7Bvg/5JVj71/9ImNaAwepirfWi7O+IZ9ViEqSo2LL88nW5NZsZwM
	 mTN7hsgPAPDuDeY/4UP2GKwgUKv+Qxo5ymGNeJFm2x6g7qhSURXocC+JDHSNi57w43
	 pKX0LkDP3B+aHAcHthXCwl0wtKc4W5yZFjtU84endp4cn6q/bFIUbUEct31LRjZpUF
	 Hzi1fCAvqvSzE3lnVRanRmXo=
Received: from zn.tnic (pd953099d.dip0.t-ipconnect.de [217.83.9.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0F8A840E016C;
	Sun, 21 Jan 2024 18:20:54 +0000 (UTC)
Date: Sun, 21 Jan 2024 19:20:40 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>, Peter Gonda <pgonda@google.com>
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
	Jacob Xu <jacobhxu@google.com>,
	Sidharth Telang <sidtelang@google.com>
Subject: Re: [RFC PATCH v2] x86/sev: enforce RIP-relative accesses in early
 SEV/SME code
Message-ID: <20240121182040.GBZa1geI5NxWSslvt0@fat_crate.local>
References: <ZZ7YuEexYSaZYmLK@tassilo>
 <20240111223650.3502633-1-kevinloughlin@google.com>
 <20240115204634.GHZaWZqsVyU_fvn_RW@fat_crate.local>
 <CAMj1kXH=k26nNyB+LQJ7WUJgbD2f3PREyjCzSngMCGc+72XJ6w@mail.gmail.com>
 <20240117130557.GDZafQtfRyeVFbBUXA@fat_crate.local>
 <CAMj1kXEML99u7a8mZMhiWXXozsJYhVPaaTzYkegiSJcLw2pNJg@mail.gmail.com>
 <CAMj1kXGO68zBNXtdxDXbcQ0U7NRFe4m9bF4L_qFmYZ6mkOvmww@mail.gmail.com>
 <20240121153702.GAZa06Hvt8b0hQ4LjR@fat_crate.local>
 <CAMj1kXFMe6WqKXJsK1Lqk++naM8D=MZADhgpO_FjUd0RuFQU2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFMe6WqKXJsK1Lqk++naM8D=MZADhgpO_FjUd0RuFQU2w@mail.gmail.com>

On Sun, Jan 21, 2024 at 05:49:44PM +0100, Ard Biesheuvel wrote:
> Yeah. I have been trying to find people internally at Google that can
> help me set up some CI that I can throw kernel builds at and they will
> be test booted in a SEV guest, but so far progress has been slow.

Dunno, if you have some internal access to GCE, it does support SEV
guests so you could test that side at least. Peter Gonda is on Cc, he
should have an idea what to do, lemme move him to To.

> -fPIE -mcmodel=small should work fine afaik. The only problem i
> encountered is that it changes the default per-CPU base register to FS
> but that can be overridden on the command line.

Yeah, there's a gcc switch - I hope clang supports it too.

> The problem with building the entire kernel -fPIE is that it increases
> code size: RIP-relative LEA instructions are 1 byte longer than
> absolute 32-bit MOVs.

Right, but the folks who started this thread are already doing that
anyway so...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

