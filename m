Return-Path: <linux-kernel+bounces-133461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB3089A40D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED28F1F230C3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E54172767;
	Fri,  5 Apr 2024 18:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="i0B2OSKK"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CC9171E47;
	Fri,  5 Apr 2024 18:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712341163; cv=none; b=SiityV3gQX6hh3X1GR/PFkUXgNk/uG5RQuPtc26T3epjPBQYI/b2Er+rJ2Ko4F672avpZvsoxkdgy8vflCRefJsB3HToQHWP7mtOPgQWHg4fwunhmzPMYSoxqvxyT6aWZ5gWYyFVcf2SlwoOGMjTOkGMuV2CEyQQTeCl/IacYxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712341163; c=relaxed/simple;
	bh=QCgEPH4wUkS+9dfZeNb/0z4fye0/PiFdlQxjbFRrVxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kn8TJ15EeDfztgvmZwVjzfSODonZMViEY+3HZ8C4PgPvDBdvh7yx/66H/FX8zG/o+eiTkyp7HOJmKOo5XVFk8Fh4tI3gtFMoJ+cIrQv57hpr2M4Jep2uKl9hCiDfZivmNjMLRdQPtWz6xMXnHfNMPUndHbD1P1ct3T69Rs+d6gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=i0B2OSKK; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=78zodIlf2id93sGgo87RUv6tjv4oQ4pNi83y08mn66s=; b=i0B2OSKKQ+YnkGLQ7fe+OSdfRU
	XcZvIyYdwQj4pbTuMMQ9CO5AY0fZl5Gnq93sDigw0Qyg59kyL+y6ayxo2+y5rYz8E4tsOAC44QQGI
	CQUAKeaQXCpN9nbUy6q12VP79A4e7A2qH5gjT93NxGYK91z5ONa2Wxs0aDS4EXfHzhRXP16hLxF/H
	7Gu2gYvmkBp/77WCASD9rLbVyK79lh3Dtq6dMdDKDxIjT0VtUl8OhyqBpyaShGjpLBNAJ8OM42gMX
	B+D4JXbo0yqGGSs9IeL+3XL/qAxsow0Djc8GntmOzBj3Ndv0QBOjo645RvO3oQg197pongk5ktcjC
	Gj1Kq83Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46188)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rso9g-0002jG-0U;
	Fri, 05 Apr 2024 19:19:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rso9e-0001a9-79; Fri, 05 Apr 2024 19:19:10 +0100
Date: Fri, 5 Apr 2024 19:19:10 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	syzbot <syzbot+186522670e6722692d86@syzkaller.appspotmail.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
	bpf <bpf@vger.kernel.org>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in
 copy_from_kernel_nofault (2)
Message-ID: <ZhBAnvLRfj/JW5bZ@shell.armlinux.org.uk>
References: <000000000000e9a8d80615163f2a@google.com>
 <20240403184149.0847a9d614f11b249529fd02@linux-foundation.org>
 <CAADnVQ+meL1kvXUehDT3iO2mxiZNeSUqeRKYx1C=3c0h=NSiqA@mail.gmail.com>
 <Zg_aTFoC2Pwakyl1@FVFF77S0Q05N>
 <Zg/iGQCDKa9bllyI@shell.armlinux.org.uk>
 <CAADnVQ+LKO2Y90DVZ4qQv3dXyuWKkvFqqJ0E_p_=qwscsvnaVg@mail.gmail.com>
 <CAEf4BzYNc-cxRu9qEe2DWdCBNwXAvpSBHKtUhXtoEhB_XNc1Gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYNc-cxRu9qEe2DWdCBNwXAvpSBHKtUhXtoEhB_XNc1Gg@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Apr 05, 2024 at 10:50:30AM -0700, Andrii Nakryiko wrote:
> On Fri, Apr 5, 2024 at 9:30 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Apr 5, 2024 at 4:36 AM Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Fri, Apr 05, 2024 at 12:02:36PM +0100, Mark Rutland wrote:
> > > > On Thu, Apr 04, 2024 at 03:57:04PM -0700, Alexei Starovoitov wrote:
> > > > > On Wed, Apr 3, 2024 at 6:56 PM Andrew Morton <akpm@linux-foundationorg> wrote:
> > > > > >
> > > > > > On Mon, 01 Apr 2024 22:19:25 -0700 syzbot <syzbot+186522670e6722692d86@syzkaller.appspotmail.com> wrote:
> > > > > >
> > > > > > > Hello,
> > > > > >
> > > > > > Thanks.  Cc: bpf@vger.kernel.org
> > > > >
> > > > > I suspect the issue is not on bpf side.
> > > > > Looks like the bug is somewhere in arm32 bits.
> > > > > copy_from_kernel_nofault() is called from lots of places.
> > > > > bpf is just one user that is easy for syzbot to fuzz.
> > > > > Interestingly arm defines copy_from_kernel_nofault_allowed()
> > > > > that should have filtered out user addresses.
> > > > > In this case ffffffe9 is probably a kernel address?
> > > >
> > > > It's at the end of the kernel range, and it's ERR_PTR(-EINVAL).
> > > >
> > > > 0xffffffe9 is -0x16, which is -22, which is -EINVAL.
> > > >
> > > > > But the kernel is doing a write?
> > > > > Which makes no sense, since copy_from_kernel_nofault is probe reading.
> > > >
> > > > It makes perfect sense; the read from 'src' happened, then the kernel tries to
> > > > write the result to 'dst', and that aligns with the disassembly in the report
> > > > below, which I beleive is:
> > > >
> > > >      8: e4942000        ldr     r2, [r4], #0  <-- Read of 'src', fault fixup is elsewhere
> > > >      c: e3530000        cmp     r3, #0
> > > >   * 10: e5852000        str     r2, [r5]      <-- Write to 'dst'
> > > >
> > > > As above, it looks like 'dst' is ERR_PTR(-EINVAL).
> > > >
> > > > Are you certain that BPF is passing a sane value for 'dst'? Where does that
> > > > come from in the first place?
> > >
> > > It looks to me like it gets passed in from the BPF program, and the
> > > "type" for the argument is set to ARG_PTR_TO_UNINIT_MEM. What that
> > > means for validation purposes, I've no idea, I'm not a BPF hacker.
> > >
> > > Obviously, if BPF is allowing copy_from_kernel_nofault() to be passed
> > > an arbitary destination address, that would be a huge security hole.
> >
> > If that's the case that's indeed a giant security hole,
> > but I doubt it. We would be crashing other archs as well.
> > I cannot really tell whether arm32 JIT is on.
> > If it is, it's likely a bug there.
> > Puranjay,
> > could you please take a look.
> >
> 
> I dumped the BPF program that repro.c is loading, it works on x86-64
> and there is nothing special there. We are probe-reading 5 bytes from
> somewhere into the stack. Everything is unaligned here, but stays
> within a well-defined memory slot.
> 
> Note the r3 = (s8)r1, that's a new-ish thing, maybe bug is somewhere
> there (but then it would be JIT, not verifier itself)
> 
>    0: (7a) *(u64 *)(r10 -8) = 896542069
>    1: (bf) r1 = r10
>    2: (07) r1 += -7
>    3: (b7) r2 = 5
>    4: (bf) r3 = (s8)r1
>    5: (85) call bpf_probe_read_kernel#-72390

Before jumping to conclusions, let's try to unravel what's going on
here.

We're calling bpf_probe_read_kernel(), and the arguments to this are:

	void *dst		; r1
	u32 size		; r2
	const void *unsafe_ptr	; r3

The problem that has been reported is that the _store_ in
copy_from_kernel_nofault(). Thus it's the destination pointer that's
the proble, and thus that is the value that ends up in r1.

What we can also see in the dump is that the address being read from
is the same as the address being written, and these are both
0xffffffe9 or -22. This would mean that both r3 and r1 contain the
same value.

Unwinding the code further, r1 comes from r10 - 7. So r10 probably
was -15.

Neither of these are valid stack addresses on 32-bit ARM.

Now, to repeat the same question. Is the BPF JIT on for this test?
This is a crucial piece of information, because it tells us whether
we need to look at the JIT or whether there's a problem with the
BPF interpreter. Please answer this question.

The next question to BPF people is... what is r10? Is that supposed
to be the read-only frame pointer? If so, why is it called r10 and
not something more readable? I'm guessing that the definition is
BPF_REG_FP, but I'm grasping at straws here (BPF people, fix your
debug so people who don't know BPF inside out can understand it!)

If the BPF JIT is being used, I think the next thing which needs to
happen is that the BPF JIT debug needs to be enabled. If
/proc/sys/net/core/bpf_jit_enable contains a value greater than 1,
then the ARM assembly will be hexdumped. One of the annoying things
is going to be piecing the hexdump together, converting it into a
form that can then be turned into a binary file, to then be
disassembled by objdump.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

