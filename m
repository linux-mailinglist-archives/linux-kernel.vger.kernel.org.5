Return-Path: <linux-kernel+bounces-105564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A80E87E05C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 22:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2D0DB212AA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 21:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D95208BA;
	Sun, 17 Mar 2024 21:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUBkIZq6"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B531C6BC
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 21:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710711046; cv=none; b=jurVU74+F41uosOn/vUX23a1T2CBcO/NNK7/ZusmyLBFsyosXZRtydrcr1HRAy6w2WpBdz/PRgcIrUbHNKiZZXRXB4BcitvStShTRmOjuHT1B52zRIntpP6eqHkXOwwEFPrKFocLv4TePUuC76KS+Eos/xPdvIm9SIvOpSXK+cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710711046; c=relaxed/simple;
	bh=sKNNDSxdVmmDDOalB0MDyvcQol4tPjD3reKOMjvbmuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8fo5ODGVWW+MsCDfu/WT8Wb0Noi7enmcqdeL0MAwB1ZTDogFhs0qW0BlNVTKfCGt8mQqbKFX5ngZCA02UFeMUPH/QIeeUsW+YEM4d3J8/wtmBwhVZNOPbWALwUxaRPwosegTyEjw+qAtQHSJ4aqRms707X4A7Uk3Deeccu5RmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUBkIZq6; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d46dd5f222so41287861fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 14:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710711042; x=1711315842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RB9Yx9eY5jYX8PX6GpKT4tDKSK1Ladoxrcta15yab4Q=;
        b=AUBkIZq6uCKVK+GdbhA0GD/ChOq1ZLTlXLTKJ1Fx9D5ed6aVgxG0g8s4cQGKZIFwdF
         deosXWbltQPhkM3g0vveLdU8zGXv1OYuiLgxIThna8S0TfJz6XhEr3aIWGZQaGDCsfmn
         ZpIvKq8PGGKHofsGkyO+lMJA22J8H0QXeJZ1cHgB3aJfHgq4B7uOnE3lVFIHxReZyyc7
         rD9nNcrGPcdvmfGez8oerOqZW8PuVCRL7JHQqalADckD8QdoS9TjBWO8WmmHJ4adKke9
         +hyZ1ZNc9MahKFuHKyoNfZp4FDe3I6k+qXMJTAbAjRrjBsDTBa/zPfFFzAYIIqeooYe4
         ihkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710711042; x=1711315842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RB9Yx9eY5jYX8PX6GpKT4tDKSK1Ladoxrcta15yab4Q=;
        b=AWFGm1avf3VLMUb4Y0V0OEVWqEvgZ/qsEVWIE0i0s3c+s0arMBzSB0n/iLm0aXrk3t
         UqcWuuoal0AIfIX18P1tl3f6x3bBgsYVJfmJQg8gz1BVU49hP3NBwxUf1YwaaxTWspPj
         UfhQQuG/ovPuU7gO4TdwT7vcPKM7pBs3ihGi+RAcr4Nst9ip+2Yjsx8jwYUE9d2FQtXz
         6h3LlbsTXo0PX24zVp25wwXUONXhdbjJKBBvVT5PDVf5tuEEvlpzdQ1MzYM8QFzs4nAG
         ED7j9F2J3YDKk1ZVa2EGC6GUm14qfAUhci3IQ41F4TNRxgw5c4+OIL4hXMWsnIIfWWzB
         7IOg==
X-Forwarded-Encrypted: i=1; AJvYcCVDwHemLnv2usQS/z4L6L3qI+3o+BNd3z1AWcI1dTO8FFi/4NOkoo9utXVT1HRt9bBZl4dDRhAjSBsbM61uWiboDnCFJewK6cHv2UpY
X-Gm-Message-State: AOJu0YzsLskMR/5MsdTE5o1dCYqFmj/RBpgWMKd0FYaTXYqL+pmEyG+7
	a+R25xpAn2crhAa2x0pPIxkanBA4EAvZ+WGh0h6WAGw7Vyp7L5zQy+CHBMgApQrbq7wMbChf2H8
	ccP8w8VUM15pkexHZmJYaTmletQ==
X-Google-Smtp-Source: AGHT+IHl1h1I3nVn2sdWL3YEaMVKQSVeUwKtpWFndlr9o+JYWm04ptb1L9Hz+JDpxv6wdhtcmOUFrmLieiV/4lWl324=
X-Received: by 2002:a2e:b8d2:0:b0:2d4:375e:9e43 with SMTP id
 s18-20020a2eb8d2000000b002d4375e9e43mr7496720ljp.27.1710711041777; Sun, 17
 Mar 2024 14:30:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <2cb8f02d-f21e-45d2-afe2-d1c6225240f3@zytor.com> <ZfNTSjfE_w50Otnz@casper.infradead.org>
 <2qp4uegb4kqkryihqyo6v3fzoc2nysuhltc535kxnh6ozpo5ni@isilzw7nth42>
 <ZfNWojLB7qjjB0Zw@casper.infradead.org> <CA+CK2bAmOj2J10szVijNikexFZ1gmA913vvxnqW4DJKWQikwqQ@mail.gmail.com>
 <39F17EC4-7844-4111-BF7D-FFC97B05D9FA@zytor.com> <CA+CK2bDothmwdJ86K1LiKWDKdWdYDjg5WCwdbapL9c3Y_Sf+kg@mail.gmail.com>
 <CAMzpN2hZgEpJcyLqPhEqKSHy33j1G=FjzrOvnLPqiDeijanM=w@mail.gmail.com> <CA+CK2bBTrrJerZMdJrKhg683H4VmnqbgkGu2VG2UuirWNm1TnA@mail.gmail.com>
In-Reply-To: <CA+CK2bBTrrJerZMdJrKhg683H4VmnqbgkGu2VG2UuirWNm1TnA@mail.gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Sun, 17 Mar 2024 17:30:30 -0400
Message-ID: <CAMzpN2jmQoG9Cw56JOh7t_Y21Fax3bA9iAEA2B7TLnYs5ycdJQ@mail.gmail.com>
Subject: Re: [RFC 00/14] Dynamic Kernel Stacks
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Matthew Wilcox <willy@infradead.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, x86@kernel.org, bp@alien8.de, 
	brauner@kernel.org, bristot@redhat.com, bsegall@google.com, 
	dave.hansen@linux.intel.com, dianders@chromium.org, dietmar.eggemann@arm.com, 
	eric.devolder@oracle.com, hca@linux.ibm.com, hch@infradead.org, 
	jacob.jun.pan@linux.intel.com, jgg@ziepe.ca, jpoimboe@kernel.org, 
	jroedel@suse.de, juri.lelli@redhat.com, kinseyho@google.com, 
	kirill.shutemov@linux.intel.com, lstoakes@gmail.com, luto@kernel.org, 
	mgorman@suse.de, mic@digikod.net, michael.christie@oracle.com, 
	mingo@redhat.com, mjguzik@gmail.com, mst@redhat.com, npiggin@gmail.com, 
	peterz@infradead.org, pmladek@suse.com, rick.p.edgecombe@intel.com, 
	rostedt@goodmis.org, surenb@google.com, tglx@linutronix.de, urezki@gmail.com, 
	vincent.guittot@linaro.org, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2024 at 12:15=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Sun, Mar 17, 2024 at 10:43=E2=80=AFAM Brian Gerst <brgerst@gmail.com> =
wrote:
> >
> > On Sat, Mar 16, 2024 at 3:18=E2=80=AFPM Pasha Tatashin
> > <pasha.tatashin@soleen.com> wrote:
> > >
> > > On Thu, Mar 14, 2024 at 11:40=E2=80=AFPM H. Peter Anvin <hpa@zytor.co=
m> wrote:
> > > >
> > > > On March 14, 2024 8:13:56 PM PDT, Pasha Tatashin <pasha.tatashin@so=
leen.com> wrote:
> > > > >On Thu, Mar 14, 2024 at 3:57=E2=80=AFPM Matthew Wilcox <willy@infr=
adead.org> wrote:
> > > > >>
> > > > >> On Thu, Mar 14, 2024 at 03:53:39PM -0400, Kent Overstreet wrote:
> > > > >> > On Thu, Mar 14, 2024 at 07:43:06PM +0000, Matthew Wilcox wrote=
:
> > > > >> > > On Tue, Mar 12, 2024 at 10:18:10AM -0700, H. Peter Anvin wro=
te:
> > > > >> > > > Second, non-dynamic kernel memory is one of the core desig=
n decisions in
> > > > >> > > > Linux from early on. This means there are lot of deeply em=
bedded assumptions
> > > > >> > > > which would have to be untangled.
> > > > >> > >
> > > > >> > > I think there are other ways of getting the benefit that Pas=
ha is seeking
> > > > >> > > without moving to dynamically allocated kernel memory.  One =
icky thing
> > > > >> > > that XFS does is punt work over to a kernel thread in order =
to use more
> > > > >> > > stack!  That breaks a number of things including lockdep (be=
cause the
> > > > >> > > kernel thread doesn't own the lock, the thread waiting for t=
he kernel
> > > > >> > > thread owns the lock).
> > > > >> > >
> > > > >> > > If we had segmented stacks, XFS could say "I need at least 6=
kB of stack",
> > > > >> > > and if less than that was available, we could allocate a tem=
porary
> > > > >> > > stack and switch to it.  I suspect Google would also be able=
 to use this
> > > > >> > > API for their rare cases when they need more than 8kB of ker=
nel stack.
> > > > >> > > Who knows, we might all be able to use such a thing.
> > > > >> > >
> > > > >> > > I'd been thinking about this from the point of view of alloc=
ating more
> > > > >> > > stack elsewhere in kernel space, but combining what Pasha ha=
s done here
> > > > >> > > with this idea might lead to a hybrid approach that works be=
tter; allocate
> > > > >> > > 32kB of vmap space per kernel thread, put 12kB of memory at =
the top of it,
> > > > >> > > rely on people using this "I need more stack" API correctly,=
 and free the
> > > > >> > > excess pages on return to userspace.  No complicated "switch=
 stacks" API
> > > > >> > > needed, just an "ensure we have at least N bytes of stack re=
maining" API.
> > > > >
> > > > >I like this approach! I think we could also consider having perman=
ent
> > > > >big stacks for some kernel only threads like kvm-vcpu. A cooperati=
ve
> > > > >stack increase framework could work well and wouldn't negatively
> > > > >impact the performance of context switching. However, thorough
> > > > >analysis would be necessary to proactively identify potential stac=
k
> > > > >overflow situations.
> > > > >
> > > > >> > Why would we need an "I need more stack" API? Pasha's approach=
 seems
> > > > >> > like everything we need for what you're talking about.
> > > > >>
> > > > >> Because double faults are hard, possibly impossible, and the FRE=
D approach
> > > > >> Peter described has extra overhead?  This was all described up-t=
hread.
> > > > >
> > > > >Handling faults in #DF is possible. It requires code inspection to
> > > > >handle race conditions such as what was shown by tglx. However, as
> > > > >Andy pointed out, this is not supported by SDM as it is an abort
> > > > >context (yet we return from it because of ESPFIX64, so return is
> > > > >possible).
> > > > >
> > > > >My question, however, if we ignore memory savings and only conside=
r
> > > > >reliability aspect of this feature.  What is better unconditionall=
y
> > > > >crashing the machine because a guard page was reached, or printing=
 a
> > > > >huge warning with a backtracing information about the offending st=
ack,
> > > > >handling the fault, and survive? I know that historically Linus
> > > > >preferred WARN() to BUG() [1]. But, this is a somewhat different
> > > > >scenario compared to simple BUG vs WARN.
> > > > >
> > > > >Pasha
> > > > >
> > > > >[1] https://lore.kernel.org/all/Pine.LNX.4.44.0209091832160.1714-1=
00000@home.transmeta.com
> > > > >
> > > >
> > > > The real issue with using #DF is that if the event that caused it w=
as asynchronous, you could lose the event.
> > >
> > > Got it. So, using a #DF handler for stack page faults isn't feasible.
> > > I suppose the only way for this to work would be to use a dedicated
> > > Interrupt Stack Table (IST) entry for page faults (#PF), but I suspec=
t
> > > that might introduce other complications.
> > >
> > > Expanding on Mathew's idea of an interface for dynamic kernel stack
> > > sizes, here's what I'm thinking:
> > >
> > > - Kernel Threads: Create all kernel threads with a fully populated
> > > THREAD_SIZE stack.  (i.e. 16K)
> > > - User Threads: Create all user threads with THREAD_SIZE kernel stack
> > > but only the top page mapped. (i.e. 4K)
> > > - In enter_from_user_mode(): Expand the thread stack to 16K by mappin=
g
> > > three additional pages from the per-CPU stack cache. This function is
> > > called early in kernel entry points.
> > > - exit_to_user_mode(): Unmap the extra three pages and return them to
> > > the per-CPU cache. This function is called late in the kernel exit
> > > path.
> > >
> > > Both of the above hooks are called with IRQ disabled on all kernel
> > > entries whether through interrupts and syscalls, and they are called
> > > early/late enough that 4K is enough to handle the rest of entry/exit.
>
> Hi Brian,
>
> > This proposal will not have the memory savings that you are looking
> > for, since sleeping tasks would still have a fully allocated stack.
>
> The tasks that were descheduled while running in user mode should not
> increase their stack. The potential saving is greater than the
> origianl proposal, because in the origianl proposal we never shrink
> stacks after faults.

A task has to enter kernel mode in order to be rescheduled.  If it
doesn't make a syscall or hit an exception, then the timer interrupt
will eventually kick it out of user mode.  At some point schedule() is
called, the task is put to sleep and context is switched to the next
task.  A sleeping task will always be using some amount of kernel
stack.  How much depends a lot on what caused the task to sleep.  If
the timeslice expired it could switch right before the return to user
mode.  A page fault could go deep into filesystem and device code
waiting on an I/O operation.

> > This also would add extra overhead to each entry and exit (including
> > syscalls) that can happen multiple times before a context switch.  It
> > also doesn't make much sense because a task running in user mode will
> > quickly need those stack pages back when it returns to kernel mode.
> > Even if it doesn't make a syscall, the timer interrupt will kick it
> > out of user mode.
> >
> > What should happen is that the unused stack is reclaimed when a task
> > goes to sleep.  The kernel does not use a red zone, so any stack pages
> > below the saved stack pointer of a sleeping task (task->thread.sp) can
> > be safely discarded.  Before context switching to a task, fully
>
> Excellent observation, this makes Andy Lutomirski per-map proposal [1]
> usable without tracking dirty/accessed bits. More reliable, and also
> platform independent.

This is x86-specific.  Other architectures will likely have differences.

> > populate its task stack.  After context switching from a task, reclaim
> > its unused stack.  This way, the task stack in use is always fully
> > allocated and we don't have to deal with page faults.
> >
> > To make this happen, __switch_to() would have to be split into two
> > parts, to cleanly separate what happens before and after the stack
> > switch.  The first part saves processor context for the previous task,
> > and prepares the next task.
>
> By knowing the stack requirements of __switch_to(), can't we actually
> do all that in the common code in context_switch() right before
> __switch_to()? We would do an arch specific call to get the
> __switch_to() stack requirement, and use that to change the value of
> task->thread.sp to know where the stack is going to be while sleeping.
> At this time we can do the unmapping of the stack pages from the
> previous task, and mapping the pages to the next task.

task->thread.sp is set in __switch_to_asm(), and is pretty much the
last thing done in the context of the previous task.  Trying to
predict that value ahead of time is way too fragile.  Also, the key
point I was trying to make is that you cannot safely shrink the active
stack.  It can only be done after the stack switch to the new task.

> > Populating the next task's stack would
> > happen here.  Then it would return to the assembly code to do the
> > stack switch.  The second part then loads the context of the next
> > task, and finalizes any work for the previous task.  Reclaiming the
> > unused stack pages of the previous task would happen here.
>
> The problem with this (and the origianl Andy's approach), is that we
> cannot sleep here. What happens if we get per-cpu stack cache
> exhausted because several threads sleep while having deep stacks? How
> can we schedule the next task? This is probably a corner case, but it
> needs to have a proper handling solution. One solution is while in
> schedule() and while interrupts are still enabled before going to
> switch_to() we must pre-allocate 3-page in the per-cpu. However, what
> if the pre-allocation itself calls cond_resched() because it enters
> page allocator slowpath?

You would have to keep extra pages in reserve for allocation failures.
mempool could probably help with that.

Brian Gerst

