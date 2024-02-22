Return-Path: <linux-kernel+bounces-77021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB06860032
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179AC1C24235
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DC414601C;
	Thu, 22 Feb 2024 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="4Bl7iyQ4"
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AC6155A56;
	Thu, 22 Feb 2024 17:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624673; cv=none; b=FeFASWyk9PraZOl4cJDPO9rHn/jL425Q+5KYDGLtPmTXLL0WJCbkVVDzOJoUdR85vY+/qGoLRyB2PEAilMJccd2/Us57JicZhTP7gTECDT64ehMWKpxiTb7RespnleOFU7fjP+cL1p7mkmk/07Ds2a2/nFxm4CmZfawSK+6h+EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624673; c=relaxed/simple;
	bh=bm5WhP92TE9F7brDXB57F1j5zC3T11LrP8BxYsw4a3w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZIWBVGfvEwsDHIiaEeSyicYuMZm1G45qqZb/9GXOXrJdVXIUn0/I3yLA5DrsomixjYD2hQgMMR6gDL+AYDZZzsDhaLXNrBAk8iP9Udzthd6h0VyfYfVhyx38tKWrP+ZDrqeXUMDR/x1kyfO1AlvO09DEdouLb1T3Ca5Q6hiozVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=4Bl7iyQ4; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id EB4591B4022;
	Thu, 22 Feb 2024 18:57:45 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1708624666; bh=+9ZwYH6ktombumemqSFUuCawnd03QAa+vgaZnNMK24s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=4Bl7iyQ401acRfW9Hr0ywLRMgn053gjtAl1Bd2EVFRUuJGXxprp0o2biPdalr8Hpp
	 gFYlYfLCW7CA5mCVaMwygOPrt4Mvxkiu1JR2xKuFolNLA9uJS1FLvgFNIYY56GTOjq
	 NGiSoDt46lz05HN4CehhE1xCurdE5HLh+nmFV2a3t5GXqMj81DkQPlFAwI31mtS+MD
	 EWBDPqpvzapQgFGS1uo/70knNjr1Ot7L/NHGTUo0h5mpIb+2mOKlFcnR3V1chDzHuC
	 me2obwFWFUKhSLlW7uLRuDAYb75gNhBc16k/27pRJconBNTQzsdSwFTxTG4pk06Tis
	 sB+Gq9wbRD6qw==
Date: Thu, 22 Feb 2024 18:57:44 +0100
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
 Roberto Sassu <roberto.sassu@huaweicloud.com>, John Johansen
 <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, Petr
 Tesarik <petr.tesarik1@huawei-partners.com>
Subject: Re: [RFC 4/5] sbm: fix up calls to dynamic memory allocators
Message-ID: <20240222185744.509e4958@meshulam.tesarici.cz>
In-Reply-To: <f6135f2c-bc8f-41c3-9c6a-8346d685e4dc@intel.com>
References: <fb4a40c7-af9a-406a-95ab-406595f3ffe5@intel.com>
	<20240222131230.635-1-petrtesarik@huaweicloud.com>
	<20240222131230.635-5-petrtesarik@huaweicloud.com>
	<f6135f2c-bc8f-41c3-9c6a-8346d685e4dc@intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Feb 2024 07:51:00 -0800
Dave Hansen <dave.hansen@intel.com> wrote:

> On 2/22/24 05:12, Petr Tesarik wrote:
> >  static const struct sbm_fixup fixups[] =
> >  {
> > +	/* kmalloc() and friends */
> > +	{ kmalloc_trace, proxy_alloc3 },
> > +	{ __kmalloc, proxy_alloc1 },
> > +	{ __kmalloc_node, proxy_alloc1 },
> > +	{ __kmalloc_node_track_caller, proxy_alloc1 },
> > +	{ kmalloc_large, proxy_alloc1 },
> > +	{ kmalloc_large_node, proxy_alloc1 },
> > +	{ krealloc, proxy_alloc2 },
> > +	{ kfree, proxy_free },
> > +
> > +	/* vmalloc() and friends */
> > +	{ vmalloc, proxy_alloc1 },
> > +	{ __vmalloc, proxy_alloc1 },
> > +	{ __vmalloc_node, proxy_alloc1 },
> > +	{ vzalloc, proxy_alloc1 },
> > +	{ vfree, proxy_free },
> > +
> >  	{ }
> >  };  
> 
> Petr, thanks for sending this.  This _is_ a pretty concise example of
> what it means to convert kernel code to run in your sandbox mode.  But,
> from me, it's still "no thanks".
> 
> Establishing and maintaining this proxy list will be painful.  Folks
> will change the code to call something new and break this *constantly*.
> 
> That goes for infrastructure like the allocators and for individual
> sandbox instances like apparmor.

Understood.

OTOH the proxy list is here for the PoC so I could send something that
builds and runs without making it an overly big patch series. As
explained in patch 5/5, the goal is not to make a global list. Instead,
each instance should define what it needs and that way define its
specific policy of interfacing with the rest of the kernel.

To give an example, these AppArmor fixups would be added only to the
sandbox which runs aa_unpack(), but not to the one which runs
unpack_to_rootfs(), which is another PoC I did (but required porting
more patches).

If more fixups are needed after you change your code, you know you've
just added a new dependency. It's then up to you to decide if it was
intentional.

> It's also telling that sandboxing a bit of apparmor took four fixups.
> That tells me we're probably still only looking at the tip of the icebeg
> if we were to convert a bunch more sites.

Yes, it is the cost paid for getting code and data flows under control.

In your opinion this kind of memory safety is not worth the effort of
explicitly defining the interface between a sandboxed component and the
rest of the kernel, because it increases maintenance costs. Correct?

> That's on top of everything I was concerned about before.

Good, I think I can understand the new concern, but regarding
everything you were concerned about before, this part is still not
quite clear to me. I'll try to summarize the points:

* Running code in ring-0 is inherently safer than running code in
  ring-3.

  Since what I'm trying to do is protect kernel data structures
  from memory safety bugs in another part of the kernel, it roughly
  translates to: "Kernel data structures are better protected from
  rogue kernel modules than from userspace applications." This cannot
  possibly be what you are trying to say.

* SMAP, SMEP and/or LASS can somehow protect one part of the kernel
  from memory safety bugs in another part of the kernel.

  I somehow can't see how that is the case. I have always thought that:

  * SMEP prevents the kernel to execute code from user pages.
  * SMAP prevents the kernel to read from or write into user pages.
  * LASS does pretty much the same job as SMEP+SMAP, but instead of
    using page table protection bits, it uses the highest bit of the
    virtual address because that's much faster.

* Hardware designers are adding (other) hardware security defenses to
  ring-0 that are not applied to ring-3.

  Could you give an example of these other security defenses, please?

* Ring-3 is more exposed to attacks.

  This statement sounds a bit too vague on its own. What attack vectors
  are we talking about? The primary attack vector that SBM is trying to
  address are exploits of kernel code vulnerabilities triggered by data
  from sources outside the kernel (boot loader, userspace, etc.).

H. Peter Anvin added a few other points:

* SBM has all the downsides of a microkernel without the upsides.

  I can only guess what would be the downsides and upsides...

  One notorious downside is performance. Agreed, there is some overhead.
  I'm not promoting SBM for time-critical operations. But compared to
  user-mode helpers (which was suggested as an alternative for one of
  the proposed scenarios), the overhead of SBM is at least an order of
  magnitude less.

  IPC and the need to define how servers interact with each other is
  another downside I can think of. Yes, there is a bit of it in SBM, as
  you have correctly noted above.

* SBM introduces architectural changes that are most definitely *very*
  harmful both to maintainers and users.

  It is very difficult to learn something from this statement. Could
  you give some examples of how SBM harms either group, please?

* SBM feels like paravirtualization all over again.

  All right, hpa, you've had lots of pain with paravirtualization. I
  feel with you, I've had my part of it too. Can you imagine how much
  trouble I could have spared myself for the libkdumpfile project if I
  didn't have to deal with the difference between "physical addresses"
  and "machine addresses"?

  However, this is hardly a relevant point. The Linux kernel community
  is respected for making decisions based on facts, not feelings.

* SBM exposes kernel memory to user space.

  This is a misunderstanding. Sandbox mode does not share anything at
  all with user mode. It does share some CPU state with kernel mode,
  but not with user mode. If "user space" was intended to mean "Ring-3",
  then it doesn't explain how that is a really bad idea.

* SBM is not needed, because there is already eBPF.

  Well, yes, but I believe they work on a different level. For example,
  eBPF needs a verifier to ensure memory safety. If you run eBPF code
  itself in a sandbox instead, that verifier is not needed, because
  memory safety is enforced by CPU hardware.

When hpa says that SandBox Mode is "an enormous step in the wrong
direction", I want to understand why this direction is wrong, so I can
take a step in the right direction next time.

So far there has been only one objective concern: the need to track code
(and data) dependencies explicitly. AFAICS this is an inherent drawback
of any kind of program decomposition.

Is decomposition considered harmful?

Petr T

