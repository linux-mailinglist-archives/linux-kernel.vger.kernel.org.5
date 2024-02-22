Return-Path: <linux-kernel+bounces-76031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCAE85F22D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3272F284D87
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E25179B8;
	Thu, 22 Feb 2024 07:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="48Ma/MOW"
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD0A79EA;
	Thu, 22 Feb 2024 07:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708588397; cv=none; b=HmP5fMNwHrVQX5JECTau9BSdKzA0FF9ISlMNewMSyb44lT+GmthHQv9QQgDHny6PGAEAYs0abMLmsqfz6zLwG0niPSHG9/GoR7bG2xfZEg5/ueq0JUjz/inyDKd6VryM25JjIbE2ASifsgFGObM71/Wl5LbkjKKI4/oSyBXDAYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708588397; c=relaxed/simple;
	bh=0zMsYUy5KRhlXCfw9bBZkJji1fZijcebCOvNn9DUhEA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sIi+IoTHGYsH60EYFujXkgGR+iBLqrDjMFU+uiqVuEGqi/j+ckCEkRF+8GartfoYMHCrl4shqxJ0x3QaCxgj6dQVUM55KwHW0r3d8F6t5KoVYD6/iirwNQPTipDmHWzcFf4PiJ9RosWWCuV7RMl198GUBky1Jrld+X9BA2WhZUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=48Ma/MOW; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id A76911B31AB;
	Thu, 22 Feb 2024 08:53:03 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1708588384; bh=dQNS4/WSFVGWaxYuywyIICob7fj4jpwBwAktHw9C3OY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=48Ma/MOWj94u96LTX/qi6HQoXEWA87EwZimAZJ25syYh13rZwsJUIoy84O3hH0nNY
	 EJS0J2ib0oEIfGOdlPx5tmR+K6jRGrHMFg9Cm81tBPTUrMIMTJ0TeyFILLNUenfbdO
	 WI3wgiY3JKdJP6VcRQew17omRZySED6EkYCH2GvxDoT6Y9H/fMyQstL9DMGx7RoBwD
	 59k4YaAKLIjNPGmvqGeGx+MFlOJlEfKqukm8AK4zwkPAPSOVEG/H3WTjL5hHCb7Iim
	 QIlWBnTbKu9sravsxmfQB1sw/GC1GghddPohWL0ZzhRYoeMXD3aDHhARRnCV4EiPCN
	 zc1a96I4YTmbw==
Date: Thu, 22 Feb 2024 08:53:02 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Petr Tesarik <petr.tesarik1@huawei-partners.com>, Roberto Sassu
 <roberto.sassu@huaweicloud.com>, Matthew Wilcox <willy@infradead.org>, Petr
 Tesarik <petrtesarik@huaweicloud.com>, Dave Hansen <dave.hansen@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>, Oleg Nesterov
 <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Xin Li
 <xin3.li@intel.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton
 <akpm@linux-foundation.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Kees Cook <keescook@chromium.org>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Pengfei Xu <pengfei.xu@intel.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Ze Gao <zegao2021@gmail.com>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Kai Huang <kai.huang@intel.com>, David
 Woodhouse <dwmw@amazon.co.uk>, Brian Gerst <brgerst@gmail.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <jroedel@suse.de>, "Mike Rapoport
 (IBM)" <rppt@kernel.org>, Tina Zhang <tina.zhang@intel.com>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 David Howells <dhowells@redhat.com>
Subject: Re: [RFC 6/8] KEYS: PGP data parser
Message-ID: <20240222085302.35f3a2c3@meshulam.tesarici.cz>
In-Reply-To: <70F9F1E7-4803-46C8-AB6E-AC1CF345F03E@zytor.com>
References: <fb4a40c7-af9a-406a-95ab-406595f3ffe5@intel.com>
	<20240216152435.1575-1-petrtesarik@huaweicloud.com>
	<20240216152435.1575-7-petrtesarik@huaweicloud.com>
	<Zc-Q5pVHjngq9lpX@casper.infradead.org>
	<5916fa3ac3d0ce2ade71e7ed1c9eb6923e374c1f.camel@huaweicloud.com>
	<EC53BCED-0D4C-4561-9041-584378326DD5@zytor.com>
	<773dd9fb-e668-4652-8b24-712553bb7ab1@huawei-partners.com>
	<70F9F1E7-4803-46C8-AB6E-AC1CF345F03E@zytor.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Feb 2024 06:02:30 -0800
"H. Peter Anvin" <hpa@zytor.com> wrote:

> On February 20, 2024 2:55:12 AM PST, Petr Tesarik <petr.tesarik1@huawei-partners.com> wrote:
> >On 2/16/2024 6:08 PM, H. Peter Anvin wrote:  
> >> On February 16, 2024 8:53:01 AM PST, Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:  
> >>> On Fri, 2024-02-16 at 16:44 +0000, Matthew Wilcox wrote:  
> >>>> On Fri, Feb 16, 2024 at 04:24:33PM +0100, Petr Tesarik wrote:  
> >>>>> From: David Howells <dhowells@redhat.com>
> >>>>>
> >>>>> Implement a PGP data parser for the crypto key type to use when
> >>>>> instantiating a key.
> >>>>>
> >>>>> This parser attempts to parse the instantiation data as a PGP packet
> >>>>> sequence (RFC 4880) and if it parses okay, attempts to extract a public-key
> >>>>> algorithm key or subkey from it.  
> >>>>
> >>>> I don't understand why we want to do this in-kernel instead of in
> >>>> userspace and then pass in the actual key.  
> >>>
> >>> Sigh, this is a long discussion.
> >>>
> >>> PGP keys would be used as a system-wide trust anchor to verify RPM
> >>> package headers, which already contain file digests that can be used as
> >>> reference values for kernel-enforced integrity appraisal.
> >>>
> >>> With the assumptions that:
> >>>
> >>> - In a locked-down system the kernel has more privileges than root
> >>> - The kernel cannot offload this task to an user space process due to
> >>>  insufficient isolation
> >>>
> >>> the only available option is to do it in the kernel (that is what I got
> >>> as suggestion).
> >>>
> >>> Roberto
> >>>
> >>>  
> >> 
> >> Ok, at least one of those assumptions is false, and *definitely* this approach seems to be a solution in search of a problem.  
> >
> >As a matter of fact, there is some truth to this observation.
> >
> >The frustrating story of Roberto's PGP parser sparked the idea, but it
> >would clearly be overkill to add all this code just for this one parser.
> >I started looking around if there are other potential uses of a sandbox
> >mode, which might justify the effort. I quickly found out that it is
> >difficult to find a self-contained part of the kernel.
> >
> >Now I believe that these dependencies among different parts of the
> >kernel present an issue, both to kernel security and to maintainability
> >of the source code. Even if sandbox mode as such is rejected (hopefully
> >with an explanation of the reasons), I believe that it is good to split
> >the kernel into smaller parts and reduce their interdependencies. In
> >this sense, sandbox mode is a way to express and enforce the remaining
> >dependencies.
> >
> >Petr T  
> 
> Congratulations. You just reinvented the microkernel.

Oh, I have never claimed that the idea is completely new. There is a
lot of prior research in this field; the most advanced project is
probably Lightweight Execution Domains (LXDs), presented at USENIX ATC
in 2019 [1]. This one even adds a full-blown microkernel...

However, these projects have not gone anywhere, for some reason. I
tried to understand the reason and it seems to me that it is not the
underlying concept. I believe the main issue is that it would require
extremely intrusive changes in the overall design of the kernel. For
example LXDs run their microkernel on a dedicated CPU core and it uses
IDL to generate the glue code which passes data between Linux and this
newly introduced microkernel...

Our development process is more suited to incremental changes. This is
reflected by SandBox Mode. It allows to start small, keep the existing
overall design, and chip off only a few selected parts.

In short, SBM does borrow some ideas from microkernels but it does not
turn Linux into a microkernel. OTOH it enhances your freedom of
choice. If you change your mind and decide to make a Linux microkernel
after all, SBM will be able to help you during the transition.

Petr T

[1] https://www.usenix.org/system/files/atc19-narayanan.pdf

