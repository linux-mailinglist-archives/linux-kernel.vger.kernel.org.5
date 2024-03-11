Return-Path: <linux-kernel+bounces-99599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0035B878AA0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C754CB212A9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653025732E;
	Mon, 11 Mar 2024 22:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwEAyRcR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED2057304
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 22:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710195477; cv=none; b=Vo93jhIiA+P+q8G0KKO9+hGfugrgklfGOoSI7HsWb0QUV4sj1h6Yp4Grm4v2mbkmYVE5dmKMxXSolTD2QhD+NGQ4pgi9SV8IZ3m5f9Da8euh7/bXK951OEFTWpRHyPCK6c+KoyFq3R3yhdOPoPAnQXWVJ/kIuIIs1NnAM5rVV90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710195477; c=relaxed/simple;
	bh=95Rl3G56TtuRLu2KqQRFkwTWeE+G21kYpTqUOyjv934=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:
	 Subject:Content-Type; b=qYq7+/hKlF8Q6cg0WGluz2SeG+Qjct8fbEiP9AMIwc1J2dOCZNfPbg8MiJssA/LMdxXRY740DI78oQ0qb/4cU1VuYrAAwJMMx9caJn0JSzkqWa9M/dLIVLkRCownLyad50ltDSAo2QhJrDwEMiZyz21NIPuPyyx2qlyUUybT1OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwEAyRcR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407C2C433F1;
	Mon, 11 Mar 2024 22:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710195477;
	bh=95Rl3G56TtuRLu2KqQRFkwTWeE+G21kYpTqUOyjv934=;
	h=In-Reply-To:References:Date:From:To:Subject:From;
	b=rwEAyRcR099GDXQJj6g1xLzxxxHxBG7IDgx6JAzIhQHMbPr/CwVJCBOrXHNJEKxp/
	 VNLmSsDC3Wdrp+TBmdNSl/HzEFjxosIMnIr1DEd5nE/PSWpSkTaa0gXIg62wQSrYqV
	 Tz/2Oijf7baCG7UAPrPzcB+/xXD3ob9BdoPhIY0FxSfIvk4kcYY8dpZOtYOBpVzOcI
	 gcokVb8znsJdrrZKYiBqzCXIQvda95ca6yTBBRoDpLZHMbvOckSYOtUAtmFEeODuhT
	 HKcqpqDUfpig60EZlDcgE1j52i+WpfDrhgj8Z0E4J1xNy7O5cSO5WYXMzjmtJaR9oK
	 HrCd1E6+p5s3A==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 1CC811200043;
	Mon, 11 Mar 2024 18:17:55 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Mon, 11 Mar 2024 18:17:55 -0400
X-ME-Sender: <xms:EYPvZXvzAiKovbA9ZsuRufawdf_ynW9Yc0OO4_WDEUMz21AaU44yjA>
    <xme:EYPvZYdJXImm_o-7xXYqRFQnN3q-dL5Qy1GnFr829Mhrtxf1EzqeAZC_uaI3UzJs2
    9QFD8Aq38xJXIXPUJM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedugdduheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepjeeggfeiudeuvdffteduvdfghfffjeelgfffhfeggeeikeeujeeh
    ledvtedtvdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:EYPvZazwLjgDXzYpzQtQiHhZ1FIbKK30SYYnX_ytA-h4fbhLe1lSrQ>
    <xmx:EYPvZWNtqmMzwYk8tUrJq2zqIrHazK4ZYoZMlyinyUFuckXUgJ7ofA>
    <xmx:EYPvZX9JX3vX-Ib807zBAwyS14iUubHaoY8WSgln3lgbs5i1jaCQdg>
    <xmx:E4PvZU-J3JhYfgq5U26F9p9hd9KQ_0hvgHTE9DN6sTTUeu_iz98BaPlIIKN7_0rP>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 27DB131A0065; Mon, 11 Mar 2024 18:17:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3e180c07-53db-4acb-a75c-1a33447d81af@app.fastmail.com>
In-Reply-To: <20240311164638.2015063-12-pasha.tatashin@soleen.com>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <20240311164638.2015063-12-pasha.tatashin@soleen.com>
Date: Mon, 11 Mar 2024 15:17:28 -0700
From: "Andy Lutomirski" <luto@kernel.org>
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 linux-mm@kvack.org, "Andrew Morton" <akpm@linux-foundation.org>,
 "the arch/x86 maintainers" <x86@kernel.org>,
 "Borislav Petkov" <bp@alien8.de>,
 "Christian Brauner" <brauner@kernel.org>, bristot@redhat.com,
 "Ben Segall" <bsegall@google.com>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, dianders@chromium.org,
 dietmar.eggemann@arm.com, eric.devolder@oracle.com, hca@linux.ibm.com,
 "hch@infradead.org" <hch@infradead.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, jpoimboe@kernel.org,
 "Joerg Roedel" <jroedel@suse.de>, juri.lelli@redhat.com,
 "Kent Overstreet" <kent.overstreet@linux.dev>, kinseyho@google.com,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 lstoakes@gmail.com, mgorman@suse.de, mic@digikod.net,
 michael.christie@oracle.com, "Ingo Molnar" <mingo@redhat.com>,
 mjguzik@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Petr Mladek" <pmladek@suse.com>,
 "Rick P Edgecombe" <rick.p.edgecombe@intel.com>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Suren Baghdasaryan" <surenb@google.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Uladzislau Rezki" <urezki@gmail.com>, vincent.guittot@linaro.org,
 vschneid@redhat.com
Subject: Re: [RFC 11/14] x86: add support for Dynamic Kernel Stacks
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



On Mon, Mar 11, 2024, at 9:46 AM, Pasha Tatashin wrote:
> Add dynamic_stack_fault() calls to the kernel faults, and also declare
> HAVE_ARCH_DYNAMIC_STACK =3D y, so that dynamic kernel stacks can be
> enabled on x86 architecture.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  arch/x86/Kconfig        | 1 +
>  arch/x86/kernel/traps.c | 3 +++
>  arch/x86/mm/fault.c     | 3 +++
>  3 files changed, 7 insertions(+)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 5edec175b9bf..9bb0da3110fa 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -197,6 +197,7 @@ config X86
>  	select HAVE_ARCH_USERFAULTFD_WP         if X86_64 && USERFAULTFD
>  	select HAVE_ARCH_USERFAULTFD_MINOR	if X86_64 && USERFAULTFD
>  	select HAVE_ARCH_VMAP_STACK		if X86_64
> +	select HAVE_ARCH_DYNAMIC_STACK		if X86_64
>  	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
>  	select HAVE_ARCH_WITHIN_STACK_FRAMES
>  	select HAVE_ASM_MODVERSIONS
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index c3b2f863acf0..cc05401e729f 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -413,6 +413,9 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
>  	}
>  #endif
>=20
> +	if (dynamic_stack_fault(current, address))
> +		return;
> +

Sorry, but no, you can't necessarily do this.  I say this as the person =
who write this code, and I justified my code on the basis that we are no=
t recovering -- we're jumping out to a different context, and we won't c=
rash if the origin context for the fault is corrupt.  The SDM is really =
quite unambiguous about it: we're in an "abort" context, and returning i=
s not allowed.  And I this may well be is the real deal -- the microcode=
 does not promise to have the return frame and the actual faulting conte=
xt matched up here, and there's is no architectural guarantee that retur=
ning will do the right thing.

Now we do have some history of getting a special exception, e.g. for esp=
fix64.  But espfix64 is a very special case, and the situation you're lo=
oking at is very general.  So unless Intel and AMD are both wiling to pu=
blicly document that it's okay to handle stack overflow, where any instr=
uction in the ISA may have caused the overflow, like this, then we're no=
t going to do it.

There are some other options: you could pre-map=20

Also, I think the whole memory allocation concept in this whole series i=
s a bit odd.  Fundamentally, we *can't* block on these stack faults -- w=
e may be in a context where blocking will deadlock.  We may be in the pa=
ge allocator.  Panicing due to kernel stack allocation would be very unp=
leasant.  But perhaps we could have a rule that a task can only be sched=
uled in if there is sufficient memory available for its stack.  And perh=
aps we could avoid every page-faulting by filling in the PTEs for the po=
tential stack pages but leaving them un-accessed.  I *think* that all x8=
6 implementations won't fill the TLB for a non-accessed page without als=
o setting the accessed bit, so the performance hit of filling the PTEs, =
running the task, and then doing the appropriate synchronization to clea=
r the PTEs and read the accessed bit on schedule-out to release the page=
s may not be too bad.  But you would need to do this cautiously in the s=
cheduler, possibly in the *next* task but before the prev task is actual=
ly released enough to be run on a different CPU.  It's going to be messy=
.

