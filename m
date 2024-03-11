Return-Path: <linux-kernel+bounces-99664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7073C878B8D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C87DB282074
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B35259B4A;
	Mon, 11 Mar 2024 23:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0r/aVsP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6B559B40
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 23:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710200077; cv=none; b=J/fpOXAQEEsWnAeuSiazhM+wUNdDR0DDkmU/NIbSxZKI7kCsx7+oTGf/K+XTG6Rjj8mhoiagJnY3OfNUQqRD/Zd6IPJ2aBnr4VTapM4lV4bLBDzwl4PYMyayPNGL1Sep5AZ03eEuDiFPhyoG7DfMgWzZ2mIaeB7JjXM+qNU+VAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710200077; c=relaxed/simple;
	bh=ej4S/4faguy0dKqkF25qAMIA8oIYdtEceu7HJBeeSnE=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=AOPWNoKD+nWOPQgLfrHVS5nMhNhRUimaXAGdBxF+s1ARCIR/IPI7hl53PYyiC7xq9I+5pFU+1+dC3i4ixhSjWFtV6l5ANsmKruyRJRafHOvSy/n/C13bgvJ4QPs1MDe79uGeOEwWmSP95bzsJk7hA4VH89yvwfT899KP3ESi+sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0r/aVsP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39E2C433F1;
	Mon, 11 Mar 2024 23:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710200076;
	bh=ej4S/4faguy0dKqkF25qAMIA8oIYdtEceu7HJBeeSnE=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=i0r/aVsPcIXgUCiJ6GTuIIoKVb9V0Dm+Ienhc3QJCKRRjl0OMEPG526qx6/8/x+VF
	 IHowXplEtc8oCupHhVpEWYf8geOBdhR1yQPnXC10dltARSMoCxfU8bL+Yxt3uTgl8a
	 jTinUJJmQh7CcwFqdus+oRidqaQpUeDWJCc8cHQ7/I/h79jcl9zCpPcOxeWAnks7X9
	 VyJx55+vGpQwFWbaODBMqcUveSAbwJKSPTmIEWQdTE/QAuQzMH3ULJAZygrfVlOxXp
	 bMXZB5q4iioWkV0Yt2zB+XKO3s4VQKVKCkm1CMizXZp85ysh4ams3Er0GedUhWvcW/
	 oHQ6+vTcGab9A==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 9E34E1200043;
	Mon, 11 Mar 2024 19:34:34 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Mon, 11 Mar 2024 19:34:34 -0400
X-ME-Sender: <xms:CZXvZSuob1DfOXMKAaYrsWLtKGZmZp2GYr6hxdWBmeC4cMwk5deCfA>
    <xme:CZXvZXdYOyrSqDqhcbw_mF_nRDbof5ppM1oF5R_bACQwu-HnlhYKaW_4iYlMeACj0
    SB3NX-3bc6CMtNDHoU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedvgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudevffdvgedvfefhgeejjeelgfdtffeukedugfekuddvtedvudei
    leeugfejgefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:CZXvZdzs0wNorA5qOtF_RdPja_POV01oHMsMvL7b3yNUC4jcUhlSPg>
    <xmx:CZXvZdPtvG8iXQ6tzDyrZ4xrqGLhGNBm64TPzpcU_v1AZg4Ou8uhlA>
    <xmx:CZXvZS-Z5MWXlB9Nsl-Y3k-uYeb3ijf5gA5fVRE2_GTym-lf-_uOnw>
    <xmx:CpXvZT9sPWITwIn0fN8UpDRkwW2I69viwgXtKzBQ2q1iJOR1nCQfQOiXQJUfdTY9>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0777331A0065; Mon, 11 Mar 2024 19:34:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1ac305b1-d28f-44f6-88e5-c85d9062f9e8@app.fastmail.com>
In-Reply-To: 
 <CA+CK2bA22AP2jrbHjdN8nYFbYX2xJXQt+=4G3Rjw_Lyn5NOyKA@mail.gmail.com>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <20240311164638.2015063-12-pasha.tatashin@soleen.com>
 <3e180c07-53db-4acb-a75c-1a33447d81af@app.fastmail.com>
 <CA+CK2bA22AP2jrbHjdN8nYFbYX2xJXQt+=4G3Rjw_Lyn5NOyKA@mail.gmail.com>
Date: Mon, 11 Mar 2024 16:34:11 -0700
From: "Andy Lutomirski" <luto@kernel.org>
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
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
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024, at 4:10 PM, Pasha Tatashin wrote:
> On Mon, Mar 11, 2024 at 6:17=E2=80=AFPM Andy Lutomirski <luto@kernel.o=
rg> wrote:
>>
>>
>>
>> On Mon, Mar 11, 2024, at 9:46 AM, Pasha Tatashin wrote:
>> > Add dynamic_stack_fault() calls to the kernel faults, and also decl=
are
>> > HAVE_ARCH_DYNAMIC_STACK =3D y, so that dynamic kernel stacks can be
>> > enabled on x86 architecture.
>> >
>> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>> > ---
>> >  arch/x86/Kconfig        | 1 +
>> >  arch/x86/kernel/traps.c | 3 +++
>> >  arch/x86/mm/fault.c     | 3 +++
>> >  3 files changed, 7 insertions(+)
>> >
>> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> > index 5edec175b9bf..9bb0da3110fa 100644
>> > --- a/arch/x86/Kconfig
>> > +++ b/arch/x86/Kconfig
>> > @@ -197,6 +197,7 @@ config X86
>> >       select HAVE_ARCH_USERFAULTFD_WP         if X86_64 && USERFAUL=
TFD
>> >       select HAVE_ARCH_USERFAULTFD_MINOR      if X86_64 && USERFAUL=
TFD
>> >       select HAVE_ARCH_VMAP_STACK             if X86_64
>> > +     select HAVE_ARCH_DYNAMIC_STACK          if X86_64
>> >       select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
>> >       select HAVE_ARCH_WITHIN_STACK_FRAMES
>> >       select HAVE_ASM_MODVERSIONS
>> > diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
>> > index c3b2f863acf0..cc05401e729f 100644
>> > --- a/arch/x86/kernel/traps.c
>> > +++ b/arch/x86/kernel/traps.c
>> > @@ -413,6 +413,9 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
>> >       }
>> >  #endif
>> >
>> > +     if (dynamic_stack_fault(current, address))
>> > +             return;
>> > +
>>
>> Sorry, but no, you can't necessarily do this.  I say this as the pers=
on who write this code, and I justified my code on the basis that we are=
 not recovering -- we're jumping out to a different context, and we won'=
t crash if the origin context for the fault is corrupt.  The SDM is real=
ly quite unambiguous about it: we're in an "abort" context, and returnin=
g is not allowed.  And I this may well be is the real deal -- the microc=
ode does not promise to have the return frame and the actual faulting co=
ntext matched up here, and there's is no architectural guarantee that re=
turning will do the right thing.
>>
>> Now we do have some history of getting a special exception, e.g. for =
espfix64.  But espfix64 is a very special case, and the situation you're=
 looking at is very general.  So unless Intel and AMD are both wiling to=
 publicly document that it's okay to handle stack overflow, where any in=
struction in the ISA may have caused the overflow, like this, then we're=
 not going to do it.
>
> Hi Andy,
>
> Thank you for the insightful feedback.
>
> I'm somewhat confused about why we end up in exc_double_fault() in the
> first place. My initial assumption was that dynamic_stack_fault()
> would only be needed within do_kern_addr_fault(). However, while
> testing in QEMU, I found that when using memset() on a stack variable,
> code like this:
>
> rep stos %rax,%es:(%rdi)
>
> causes a double fault instead of a regular fault. I added it to
> exc_double_fault() as a result, but I'm curious if you have any
> insights into why this behavior occurs.
>

Imagine you're a CPU running kernel code, on a fairly traditional archit=
ecture like x86.  The code tries to access some swapped out user memory.=
  You say "sorry, that memory is not present" and generate a page fault.=
  You save the current state *to the stack* and chance the program count=
er to point to the page fault handler.  The page fault handler does its =
thing, then pops the old state off the stack and resumes the faulting co=
de.

A few microseconds later, the kernel fills up its stack and then does:

PUSH something

but that would write to a not-present stack page, because you already fi=
lled the stack.  Okay, a page fault -- no big deal, we know how to handl=
e that.  So you push the current state to the stack.  On wait, you *can'=
t* push the current state to the stack, because that would involve writi=
ng to an unmapped page of memory.

So you trigger a double-fault.  You push some state to the double-fault =
handler's special emergency stack.  But wait, *what* state do you push? =
 Is it the state that did the "PUSH something" and overflowed the stack?=
  Or is some virtual state that's a mixture of that and the failed page =
fault handler?  What if the stack wasn't quite full and you actually suc=
ceeded in pushing the old stack pointer but not the old program counter?=
  What saved state goes where?

This is a complicated mess, so the people who designed all this said 'he=
y, wait a minute, let's not call double faults a "fault" -- let's call t=
hem an "abort"' so we can stop confusing ourselves and ship CPUs to cust=
omers.  And "abort" means "the saved state is not well defined -- don't =
rely on it having any particular meaning".

So, until a few years ago, we would just print something like "PANIC: do=
uble fault" and kill the whole system.  A few years ago, I decided this =
was lame, and I wanted to have stack guard pages, so i added real fancy =
new logic: instead, we do our best to display the old state, but it's a =
guess and all we're doing with it is printk -- if it's wrong, it's annoy=
ing, but that's all.  And then we kill the running thread -- instead of =
trying to return (and violating our sacred contract with the x86 archite=
cture), we *reset* the current crashing thread's state to a known-good s=
tate.  Then we return to *that* state.  Now we're off the emergency stac=
k and we're running something resembling normal kernel code, but we can'=
t return, as there is nowhere to return to.  But that's fine -- instead =
we kill the current thread, kind of like _exit().  That never returns, s=
o it's okay that we can't return.

But your patch adds a return statement to this whole mess, which will re=
turn to the moderately-likely-to-be-corrupt state that caused a double f=
ault inside the microcode for the page fault path, and you have stepped =
outside the well-defined path in the x86 architecture, and you've trigge=
red something akin to Undefined Behavior.  The CPU won't catch fire, but=
 it reserves the right to execute from an incorrect RSP and/or RIP, to b=
e in the middle of an instruction, etc.

(For that matter, what if there was exactly enough room to enter the pag=
e fault handler, but the very first instruction of the page fault handle=
r overflowed the stack?  Then you allocate more memory, get lucky and su=
ccessfully resume the page fault handler, and then promptly OOPS because=
 you run the page fault handler and it thinks you got a kernel page faul=
t?  My OOPS code handles that, but, again, it's not trying to recover.)

>> There are some other options: you could pre-map
>
> Pre-mapping would be expensive. It would mean pre-mapping the dynamic
> pages for every scheduled thread, and we'd still need to check the
> access bit every time a thread leaves the CPU.

That's a write to four consecutive words in memory, with no locking requ=
ired.

> Dynamic thread faults
> should be considered rare events and thus shouldn't significantly
> affect the performance of normal context switch operations. With 8K
> stacks, we might encounter only 0.00001% of stacks requiring an extra
> page, and even fewer needing 16K.

Well yes, but if you crash 0.0001% of the time due to the microcode not =
liking you, you lose. :)

>
>> Also, I think the whole memory allocation concept in this whole serie=
s is a bit odd.  Fundamentally, we *can't* block on these stack faults -=
- we may be in a context where blocking will deadlock.  We may be in the=
 page allocator.  Panicing due to kernel stack allocation  would be very=
 unpleasant.
>
> We never block during handling stack faults. There's a per-CPU page
> pool, guaranteeing availability for the faulting thread. The thread
> simply takes pages from this per-CPU data structure and refills the
> pool when leaving the CPU. The faulting routine is efficient,
> requiring a fixed number of loads without any locks, stalling, or even
> cmpxchg operations.

You can't block when scheduling, either.  What if you can't refill the p=
ool?

