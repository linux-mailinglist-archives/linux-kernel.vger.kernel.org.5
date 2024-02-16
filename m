Return-Path: <linux-kernel+bounces-68937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D41858220
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2306B2167D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1850D12FB0F;
	Fri, 16 Feb 2024 16:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="Zcqc9q7K"
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173B778B5C;
	Fri, 16 Feb 2024 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708099702; cv=none; b=k4o3vH9MjVmRIPMpwYzqpiC6BjaaBhJ0SFMVqy6NJDCVpuy0zEAjG3cFslIZrH8DAzIGW5MBECr8YG5KB6VUjQrnx0QVwgMjC8xB+Ots4BDbq9M0rPHqv9ifT6CKxn88uWMLT566Se7MTduDVBC7lVC3ntkAe5BLzn21M+EYqsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708099702; c=relaxed/simple;
	bh=XZFqH1AHH+zywN7bCiDB54cVqBQHS1vAHNy2hjesWnU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W9p/1cNVC8TaQuW5Z9YNk3ERdT2mu2cUs9CIf50zmno7mPjxS3eaTHLvK5qj9Ee9+y+MdGkqBtBJWpbKfCP13d4rPzi1ky3do6EtotgJoF2fCyXQV6qXSS3NL8UBhEbT0b6NiS42kGbotHbJmxFa32qhP/jB1sb3LE1KEsNGWhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=Zcqc9q7K; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 5AAA51A8CE2;
	Fri, 16 Feb 2024 17:08:07 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1708099687; bh=DKX/6lJWnQLEOT1m3g58ZZW/atm/xKbGax5uWE14zqU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zcqc9q7KWchJwmvx0t4vSX1KyUPURQZe1OK75OB/21bUMdJEzk/HvdVz24nddVkD0
	 CNVRqHQo7B4zrf1kvFcF4tB/aOZSV6aairJvFO88QqAjAo3zFBmlkHbsZhNXlaV3t2
	 3BGih5r1MNlJeVPSsIhL7OwD7mgro5Ji5mLvxWoIUlSzHTjHQ65MAiJhJPwu86I/JH
	 Y9FkETzAokazd09YWhYTQARYxGfZgBRA0iIZrGCwLBhekdPJObp8DVQRuVfWTYdf/Q
	 rsLVpYSY13y+czJnxT7X7w7GUzCSq0Ui0Ej8FHtQilHx2Q0qlkgoAWtgp5Cr+ZX9PA
	 N+eT8KYvOnZmw==
Date: Fri, 16 Feb 2024 17:08:05 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Petr Tesarik <petrtesarik@huaweicloud.com>, Jonathan Corbet
 <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andy
 Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Xin Li <xin3.li@intel.com>, Arnd Bergmann
 <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Kees Cook <keescook@chromium.org>, "Masami
 Hiramatsu (Google)" <mhiramat@kernel.org>, Pengfei Xu
 <pengfei.xu@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Ze Gao
 <zegao2021@gmail.com>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Kai Huang <kai.huang@intel.com>, David
 Woodhouse <dwmw@amazon.co.uk>, Brian Gerst <brgerst@gmail.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <jroedel@suse.de>, "Mike Rapoport
 (IBM)" <rppt@kernel.org>, Tina Zhang <tina.zhang@intel.com>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>, David Howells
 <dhowells@redhat.com>, Petr Tesarik <petr.tesarik1@huawei-partners.com>
Subject: Re: [RFC 0/8] PGP key parser using SandBox Mode
Message-ID: <20240216170805.0d0decd5@meshulam.tesarici.cz>
In-Reply-To: <c65eb8f1-2903-4043-a3ab-945d880043b5@intel.com>
References: <fb4a40c7-af9a-406a-95ab-406595f3ffe5@intel.com>
	<20240216152435.1575-1-petrtesarik@huaweicloud.com>
	<c65eb8f1-2903-4043-a3ab-945d880043b5@intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 07:38:30 -0800
Dave Hansen <dave.hansen@intel.com> wrote:

> On 2/16/24 07:24, Petr Tesarik wrote:
> > While I started working on my development branch to illustrate how
> > SandBox Mode could be enhanced to allow dynamic memory allocation and
> > other features necessary to convert some existing code, my colleague
> > Roberto Sassu set out and adapted a PGP key parser to run in a sandbox.
> > 
> > Disclaimer:
> > 
> > The code had to be rearranged in order to avoid memory allocations
> > and crypto operations in the sandbox. The code might contain errors.  
> 
> I'm confused by this.  The kernel doesn't (appear to) have a PGP parser
> today.  So are you saying that it *should* have one and it's only
> feasible if its confined in a sandbox?

I'm sorry if this is confusing. Yes, your understanding is correct.
This patch series demonstrates that SBM (even in the initial version
that was submitted) allows to write a PGP parser which can survive
memory safety bugs withoug compromising the rest of the kernel.

> A much more powerful example would be to take something that the kernel
> has already and put it in a sandbox.  That would show us how difficult
> it is to sandbox something versus just doing it _normally_ in the kernel.

That's what I have also tested as a PoC with an earlier version of my
patch series and a few quick hacks on top. As it happens, that code
on top needs to be adapted for the current patch series, so I cannot
post it just yet. Please, stay tuned.

> As it stands, I fear this was just the largest chunk of sandbox code
> that was laying around and it seemed like a good idea to just chuck
> ~1400 lines of code over the wall at a huge cc list.

You asked for some real-world scenarios, and this should be one.
Another is on the way, but see above why it takes a bit of time.

I am not trying to claim I'm the smartest person on this planet. I can
accept it if there is a fundamental flaw in my approach. Yet, I'd be
glad if somebody can make me a favor and at least hint at what exactly
is the issue with it. I have to admit this thing is still not quite
clear to me. I would be sad if I couldn't learn from this experience.

Petr T

