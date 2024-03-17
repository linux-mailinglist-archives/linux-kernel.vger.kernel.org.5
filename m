Return-Path: <linux-kernel+bounces-105465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4F887DE44
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 17:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EB171F21826
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83961CD11;
	Sun, 17 Mar 2024 16:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="FQEoQIP9"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E436B1C695
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710692161; cv=none; b=rkVQXKPbW1Cgc7Ed2v1i1RfafbQuoyBc5zLOB8ltbFsqDiKppwUmoObTpQRRy4WyJcqJE+1xWk0vLVWCgd1r/MPce0gDZGufy+NPAcAMHjUreefAPcIyCNeLYyQXbkSaLmj3OJyzXHuo4ejWeXChuChMhMj8x5H5rsRgLTCsIzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710692161; c=relaxed/simple;
	bh=tLfIIw20PS9MSFbQVCs4oZzImvnwmDeTcFfoBZmjYno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rWh9LIc4I0LlAyFwlhjy/EUCssgncwruO4HzzLjshYrCz+3pO85+biDnJBTZfkgPjcl1GuUKA1zIWAN8na7SsH4S1eizZiEEr1hajCb0UNyrcg0BL55B9qC3vnUmyigmeIeCJPvWGMZu31NCpr2hEX6q2dcxHXC4Nabue9U5dKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=FQEoQIP9; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42e323a2e39so32423301cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 09:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710692158; x=1711296958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PM5k/cKWKO9/pzejbqRuQgA1mwwRpjQHEmGbCSxdmsg=;
        b=FQEoQIP92GHHNzFJlIibERE6qs/EFmgayhY0C051eY+Qp3edv+BnoJYoaHln4SpFFd
         Lj+GGkRLz2rDx5Xqas3CgJewKkvxBrTMlvS+nfFfCrEz45a2k/pQyCRusZ9HfVh41vHz
         Xqix/SNk+0NzhTz1kVnU0srIwJT0+2e9k+S6zsvnYTXnHL5iO1D3+I4rSfSHC3gpCN3i
         XbjC9pp4WWBrh4+BXLnVuJefQPsfg0qHAP5hIZ2zOjZecfV0CdDIbP7RFm/pz4vULbeY
         gS81YBqd5k1iz1ZnlR3ihly62RCi/m6/pNwtPQrLzfUoPttO1lG1OxM562rUMZvmDNR+
         owUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710692158; x=1711296958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PM5k/cKWKO9/pzejbqRuQgA1mwwRpjQHEmGbCSxdmsg=;
        b=vbmgFVs9N/L/zENRi9m4fv2NCDnliLCF5+5lJ+nY11dbVuOoY94Ggzb8lcZ9n0nWnT
         SMnF9I7cNqov8SBfcsscl7fESfI299INaqR2Kg1o3yfyyQLzTlHsQZEuA2YqWDN8ppW1
         XynEUGbJOM0YJhDJu0Gv/EBaeK6BeQAuD4GX11OUG+btwvC0ejc29ZoUOGjzoqXIVxQq
         P6/RDb2YdEVsrfZTf7/2/SbWFxnz/lKIGGkVvFNd5jY9Mq1ycyZhsDPEVk/AHMl71AKm
         1cAXE73Bqq5h95PBYv28j6E5AwJc7Bbche7f86weVD8cUW1HaCvHQllIHKRheQDZPCPQ
         uOIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOIK1dWxIlh34t3OxTLvzHVmKSRXzqBx2MECVPnkrSOSHpIOFWgDUwTO25H80TPdNnXvyzqzMPkW8IS252C2bIJ4a0ZTHjtQvRpq53
X-Gm-Message-State: AOJu0YzdS1+ee8XYQ+cB20IijGqpx590gHQ/SeI2Y2ap3eiLVXvSSUln
	phE6R3JCtpkDEtaJn6Uj7k8FGewDx8Rx8he3C7gfRZuf8oMBgHoo9RtdBrnogHaH7VhFFBPXFxK
	y/qV6xiHLA37dDclqkUud2+q/p6b7QbT2qPFqRA==
X-Google-Smtp-Source: AGHT+IHeM36xTBpJfnVvFsWgP9FrEMuP+RzB6eCLw1k9E2wycoMLf0nlLLPrAgvLw8C45WQP13d++rsG9oTWBmVvrfU=
X-Received: by 2002:a05:622a:1a9a:b0:430:b0db:5b1 with SMTP id
 s26-20020a05622a1a9a00b00430b0db05b1mr13762235qtc.3.1710692158643; Sun, 17
 Mar 2024 09:15:58 -0700 (PDT)
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
 <CAMzpN2hZgEpJcyLqPhEqKSHy33j1G=FjzrOvnLPqiDeijanM=w@mail.gmail.com>
In-Reply-To: <CAMzpN2hZgEpJcyLqPhEqKSHy33j1G=FjzrOvnLPqiDeijanM=w@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sun, 17 Mar 2024 12:15:21 -0400
Message-ID: <CA+CK2bBTrrJerZMdJrKhg683H4VmnqbgkGu2VG2UuirWNm1TnA@mail.gmail.com>
Subject: Re: [RFC 00/14] Dynamic Kernel Stacks
To: Brian Gerst <brgerst@gmail.com>
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

On Sun, Mar 17, 2024 at 10:43=E2=80=AFAM Brian Gerst <brgerst@gmail.com> wr=
ote:
>
> On Sat, Mar 16, 2024 at 3:18=E2=80=AFPM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > On Thu, Mar 14, 2024 at 11:40=E2=80=AFPM H. Peter Anvin <hpa@zytor.com>=
 wrote:
> > >
> > > On March 14, 2024 8:13:56 PM PDT, Pasha Tatashin <pasha.tatashin@sole=
en.com> wrote:
> > > >On Thu, Mar 14, 2024 at 3:57=E2=80=AFPM Matthew Wilcox <willy@infrad=
ead.org> wrote:
> > > >>
> > > >> On Thu, Mar 14, 2024 at 03:53:39PM -0400, Kent Overstreet wrote:
> > > >> > On Thu, Mar 14, 2024 at 07:43:06PM +0000, Matthew Wilcox wrote:
> > > >> > > On Tue, Mar 12, 2024 at 10:18:10AM -0700, H. Peter Anvin wrote=
:
> > > >> > > > Second, non-dynamic kernel memory is one of the core design =
decisions in
> > > >> > > > Linux from early on. This means there are lot of deeply embe=
dded assumptions
> > > >> > > > which would have to be untangled.
> > > >> > >
> > > >> > > I think there are other ways of getting the benefit that Pasha=
 is seeking
> > > >> > > without moving to dynamically allocated kernel memory.  One ic=
ky thing
> > > >> > > that XFS does is punt work over to a kernel thread in order to=
 use more
> > > >> > > stack!  That breaks a number of things including lockdep (beca=
use the
> > > >> > > kernel thread doesn't own the lock, the thread waiting for the=
 kernel
> > > >> > > thread owns the lock).
> > > >> > >
> > > >> > > If we had segmented stacks, XFS could say "I need at least 6kB=
 of stack",
> > > >> > > and if less than that was available, we could allocate a tempo=
rary
> > > >> > > stack and switch to it.  I suspect Google would also be able t=
o use this
> > > >> > > API for their rare cases when they need more than 8kB of kerne=
l stack.
> > > >> > > Who knows, we might all be able to use such a thing.
> > > >> > >
> > > >> > > I'd been thinking about this from the point of view of allocat=
ing more
> > > >> > > stack elsewhere in kernel space, but combining what Pasha has =
done here
> > > >> > > with this idea might lead to a hybrid approach that works bett=
er; allocate
> > > >> > > 32kB of vmap space per kernel thread, put 12kB of memory at th=
e top of it,
> > > >> > > rely on people using this "I need more stack" API correctly, a=
nd free the
> > > >> > > excess pages on return to userspace.  No complicated "switch s=
tacks" API
> > > >> > > needed, just an "ensure we have at least N bytes of stack rema=
ining" API.
> > > >
> > > >I like this approach! I think we could also consider having permanen=
t
> > > >big stacks for some kernel only threads like kvm-vcpu. A cooperative
> > > >stack increase framework could work well and wouldn't negatively
> > > >impact the performance of context switching. However, thorough
> > > >analysis would be necessary to proactively identify potential stack
> > > >overflow situations.
> > > >
> > > >> > Why would we need an "I need more stack" API? Pasha's approach s=
eems
> > > >> > like everything we need for what you're talking about.
> > > >>
> > > >> Because double faults are hard, possibly impossible, and the FRED =
approach
> > > >> Peter described has extra overhead?  This was all described up-thr=
ead.
> > > >
> > > >Handling faults in #DF is possible. It requires code inspection to
> > > >handle race conditions such as what was shown by tglx. However, as
> > > >Andy pointed out, this is not supported by SDM as it is an abort
> > > >context (yet we return from it because of ESPFIX64, so return is
> > > >possible).
> > > >
> > > >My question, however, if we ignore memory savings and only consider
> > > >reliability aspect of this feature.  What is better unconditionally
> > > >crashing the machine because a guard page was reached, or printing a
> > > >huge warning with a backtracing information about the offending stac=
k,
> > > >handling the fault, and survive? I know that historically Linus
> > > >preferred WARN() to BUG() [1]. But, this is a somewhat different
> > > >scenario compared to simple BUG vs WARN.
> > > >
> > > >Pasha
> > > >
> > > >[1] https://lore.kernel.org/all/Pine.LNX.4.44.0209091832160.1714-100=
000@home.transmeta.com
> > > >
> > >
> > > The real issue with using #DF is that if the event that caused it was=
 asynchronous, you could lose the event.
> >
> > Got it. So, using a #DF handler for stack page faults isn't feasible.
> > I suppose the only way for this to work would be to use a dedicated
> > Interrupt Stack Table (IST) entry for page faults (#PF), but I suspect
> > that might introduce other complications.
> >
> > Expanding on Mathew's idea of an interface for dynamic kernel stack
> > sizes, here's what I'm thinking:
> >
> > - Kernel Threads: Create all kernel threads with a fully populated
> > THREAD_SIZE stack.  (i.e. 16K)
> > - User Threads: Create all user threads with THREAD_SIZE kernel stack
> > but only the top page mapped. (i.e. 4K)
> > - In enter_from_user_mode(): Expand the thread stack to 16K by mapping
> > three additional pages from the per-CPU stack cache. This function is
> > called early in kernel entry points.
> > - exit_to_user_mode(): Unmap the extra three pages and return them to
> > the per-CPU cache. This function is called late in the kernel exit
> > path.
> >
> > Both of the above hooks are called with IRQ disabled on all kernel
> > entries whether through interrupts and syscalls, and they are called
> > early/late enough that 4K is enough to handle the rest of entry/exit.

Hi Brian,

> This proposal will not have the memory savings that you are looking
> for, since sleeping tasks would still have a fully allocated stack.

The tasks that were descheduled while running in user mode should not
increase their stack. The potential saving is greater than the
origianl proposal, because in the origianl proposal we never shrink
stacks after faults.

> This also would add extra overhead to each entry and exit (including
> syscalls) that can happen multiple times before a context switch.  It
> also doesn't make much sense because a task running in user mode will
> quickly need those stack pages back when it returns to kernel mode.
> Even if it doesn't make a syscall, the timer interrupt will kick it
> out of user mode.
>
> What should happen is that the unused stack is reclaimed when a task
> goes to sleep.  The kernel does not use a red zone, so any stack pages
> below the saved stack pointer of a sleeping task (task->thread.sp) can
> be safely discarded.  Before context switching to a task, fully

Excellent observation, this makes Andy Lutomirski per-map proposal [1]
usable without tracking dirty/accessed bits. More reliable, and also
platform independent.

> populate its task stack.  After context switching from a task, reclaim
> its unused stack.  This way, the task stack in use is always fully
> allocated and we don't have to deal with page faults.
>
> To make this happen, __switch_to() would have to be split into two
> parts, to cleanly separate what happens before and after the stack
> switch.  The first part saves processor context for the previous task,
> and prepares the next task.

By knowing the stack requirements of __switch_to(), can't we actually
do all that in the common code in context_switch() right before
__switch_to()? We would do an arch specific call to get the
__switch_to() stack requirement, and use that to change the value of
task->thread.sp to know where the stack is going to be while sleeping.
At this time we can do the unmapping of the stack pages from the
previous task, and mapping the pages to the next task.

> Populating the next task's stack would
> happen here.  Then it would return to the assembly code to do the
> stack switch.  The second part then loads the context of the next
> task, and finalizes any work for the previous task.  Reclaiming the
> unused stack pages of the previous task would happen here.

The problem with this (and the origianl Andy's approach), is that we
cannot sleep here. What happens if we get per-cpu stack cache
exhausted because several threads sleep while having deep stacks? How
can we schedule the next task? This is probably a corner case, but it
needs to have a proper handling solution. One solution is while in
schedule() and while interrupts are still enabled before going to
switch_to() we must pre-allocate 3-page in the per-cpu. However, what
if the pre-allocation itself calls cond_resched() because it enters
page allocator slowpath?

Other than the above concern, I concur, this approach looks to be the
best so far. I will think more about it.

Thank you,
Pasha

[1] https://lore.kernel.org/all/3e180c07-53db-4acb-a75c-1a33447d81af@app.fa=
stmail.com

