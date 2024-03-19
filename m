Return-Path: <linux-kernel+bounces-107682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E608E880006
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7368B1F22A67
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDB2651B4;
	Tue, 19 Mar 2024 14:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="k6VP0VIx"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F17A62818
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860217; cv=none; b=D756UhOhPqYO+4tLLgo25cCFcapFqzIldkjofkJjkkrssN/nXsfWrnoyGfprD8CM2sZ7UiUIhcdr/msiOQ9HBPYsrkCCfyVkg3x4dkjcorIaUrIuPuo/cGNrqzGSRMb2fJkNkbGx4I6tXOj949JolmH4PV8QXNk6S76SWxi+eyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860217; c=relaxed/simple;
	bh=3Vicja8+l2q2Ij746Qe6FPMVqRvymBLXOTTFcVqrZRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvqVfwNYLho0+2s36gaHEWSXR8vTl3Z+eHkNhTza7UEivatdjTCOFSeTSQJ6w8Ac915fDOtazKTkYwGLCNO4BYiTH1gXRsiOHoImBYhDguHfbu1ZRUZy9WTC+0WrIL+M00IlDnMhWLur4fglqFgkutar7VIhPfdkwtAWs2A4QoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=k6VP0VIx; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-429f53f0b0bso34864611cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 07:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710860214; x=1711465014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKpalR5cw9CXmhQ6CEPMwqOfzi/hbbVFb5st3efxJjo=;
        b=k6VP0VIxdvJWHvwTWPEdvPmh0Aw/IiHb8MHETomi0jRsszk0MwmbbinwZPsB+JJyeo
         q/walsjH2p7yICzHn+K3RX+Y8i8W8yJ+QkeV4KapfKFtAzAyptDa0kyaYY4By13e6yOa
         nLTFcRWf1iRpopjE/SEe/aiUUycjkwr6FtrN93/8GwobFudoIydGLo1ydgBHjxdIaHFY
         zR+SifYHQz2Qw8M2c6d/Qnm8AzW8ZB2Df8+cxOn19JW68m4WamuKSe3c0LZeOYlW7MQr
         w+llIgO320spbY76nSIUUKe6IbQi0Iv+4jSURQPQMMpz9mOIiLgEeny6uDnJt9ZH9V6L
         i+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710860214; x=1711465014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKpalR5cw9CXmhQ6CEPMwqOfzi/hbbVFb5st3efxJjo=;
        b=Lvs0b90fWawhkP489tlAMfVQKYJj2vRZkarEHlXnGyAgYzt/EwJETNQLhmkhIJ87UH
         t5nGLHqTcNjV24OVnnM+VmybMiMI3xnclSczWKIJVXyLwkg+HxwaSAv6yNOkNAblfVeM
         9ycw9nT+UwCKB26WYZIoZp9WOLPnB0D0W0xS3hp2puHFUnBVRnTurRHhYdQXdGBg9GYv
         a5ObBp2+SaxT2pM/Ad1JqUNIruS1bT9OtDwPumCriWQn8JjPYuYLdbAUBg1jLtvJWP96
         EjInawvgA2+Os/xxkKVuPWP6h2gTx8+GeOQQtY08iur+SvKa46J3707yd0wZstw2N34m
         MXaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVTA3T2KMfue62vh/AdjFJpxQG8WZry6MdAdci0eof6/Nsz2iz9DxSJCw9Zx64IudtjDnKNReo2tpJIodmTDiDdiHfvXfYpGZoEg67
X-Gm-Message-State: AOJu0Yz+U7ol0Cc5cIAQr0dIrGFvPWRk7MsOFOP3OBUBIC+M4KI+VixT
	AeqAi6hFtOO91W8OjH5b5dE+hxJ0GA2V8LXWvoHyRrEGVxHmv180u+r4GrzFTJE9+FuKSenM0q6
	WXfHP5ZF43O4BTWY75pWC5qPOKpZGXBwuMpqjsQ==
X-Google-Smtp-Source: AGHT+IHt2UGe10VsD0CiL4RMgWpq7Isv4MrWJZj3oEIRH84D189zTNzEiOdp0TjIx5SeiPdQawduKadS44XNQT9izDI=
X-Received: by 2002:a05:622a:1aa4:b0:430:b697:a8c9 with SMTP id
 s36-20020a05622a1aa400b00430b697a8c9mr14972686qtc.12.1710860213900; Tue, 19
 Mar 2024 07:56:53 -0700 (PDT)
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
 <CA+CK2bBTrrJerZMdJrKhg683H4VmnqbgkGu2VG2UuirWNm1TnA@mail.gmail.com>
 <CAMzpN2jmQoG9Cw56JOh7t_Y21Fax3bA9iAEA2B7TLnYs5ycdJQ@mail.gmail.com>
 <CA+CK2bDO=LV8nEFn=q6w3Pyna3aqKAiFEzHMb-d7xzMOThOXSQ@mail.gmail.com> <CAMzpN2i8SRkgUZ+XSj7wJrtRn=-mB=7v7=C8auES=FAW_MFN-Q@mail.gmail.com>
In-Reply-To: <CAMzpN2i8SRkgUZ+XSj7wJrtRn=-mB=7v7=C8auES=FAW_MFN-Q@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 19 Mar 2024 10:56:16 -0400
Message-ID: <CA+CK2bBX6HtP_=-GhTN3uV8mARZ1vjCWW+3-t-HFLiBcEMzmqg@mail.gmail.com>
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

On Mon, Mar 18, 2024 at 5:02=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wro=
te:
>
> On Mon, Mar 18, 2024 at 11:00=E2=80=AFAM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > On Sun, Mar 17, 2024 at 5:30=E2=80=AFPM Brian Gerst <brgerst@gmail.com>=
 wrote:
> > >
> > > On Sun, Mar 17, 2024 at 12:15=E2=80=AFPM Pasha Tatashin
> > > <pasha.tatashin@soleen.com> wrote:
> > > >
> > > > On Sun, Mar 17, 2024 at 10:43=E2=80=AFAM Brian Gerst <brgerst@gmail=
com> wrote:
> > > > >
> > > > > On Sat, Mar 16, 2024 at 3:18=E2=80=AFPM Pasha Tatashin
> > > > > <pasha.tatashin@soleen.com> wrote:
> > > > > >
> > > > > > On Thu, Mar 14, 2024 at 11:40=E2=80=AFPM H. Peter Anvin <hpa@zy=
tor.com> wrote:
> > > > > > >
> > > > > > > On March 14, 2024 8:13:56 PM PDT, Pasha Tatashin <pasha.tatas=
hin@soleen.com> wrote:
> > > > > > > >On Thu, Mar 14, 2024 at 3:57=E2=80=AFPM Matthew Wilcox <will=
y@infradead.org> wrote:
> > > > > > > >>
> > > > > > > >> On Thu, Mar 14, 2024 at 03:53:39PM -0400, Kent Overstreet =
wrote:
> > > > > > > >> > On Thu, Mar 14, 2024 at 07:43:06PM +0000, Matthew Wilcox=
 wrote:
> > > > > > > >> > > On Tue, Mar 12, 2024 at 10:18:10AM -0700, H. Peter Anv=
in wrote:
> > > > > > > >> > > > Second, non-dynamic kernel memory is one of the core=
 design decisions in
> > > > > > > >> > > > Linux from early on. This means there are lot of dee=
ply embedded assumptions
> > > > > > > >> > > > which would have to be untangled.
> > > > > > > >> > >
> > > > > > > >> > > I think there are other ways of getting the benefit th=
at Pasha is seeking
> > > > > > > >> > > without moving to dynamically allocated kernel memory.=
  One icky thing
> > > > > > > >> > > that XFS does is punt work over to a kernel thread in =
order to use more
> > > > > > > >> > > stack!  That breaks a number of things including lockd=
ep (because the
> > > > > > > >> > > kernel thread doesn't own the lock, the thread waiting=
 for the kernel
> > > > > > > >> > > thread owns the lock).
> > > > > > > >> > >
> > > > > > > >> > > If we had segmented stacks, XFS could say "I need at l=
east 6kB of stack",
> > > > > > > >> > > and if less than that was available, we could allocate=
 a temporary
> > > > > > > >> > > stack and switch to it.  I suspect Google would also b=
e able to use this
> > > > > > > >> > > API for their rare cases when they need more than 8kB =
of kernel stack.
> > > > > > > >> > > Who knows, we might all be able to use such a thing.
> > > > > > > >> > >
> > > > > > > >> > > I'd been thinking about this from the point of view of=
 allocating more
> > > > > > > >> > > stack elsewhere in kernel space, but combining what Pa=
sha has done here
> > > > > > > >> > > with this idea might lead to a hybrid approach that wo=
rks better; allocate
> > > > > > > >> > > 32kB of vmap space per kernel thread, put 12kB of memo=
ry at the top of it,
> > > > > > > >> > > rely on people using this "I need more stack" API corr=
ectly, and free the
> > > > > > > >> > > excess pages on return to userspace.  No complicated "=
switch stacks" API
> > > > > > > >> > > needed, just an "ensure we have at least N bytes of st=
ack remaining" API.
> > > > > > > >
> > > > > > > >I like this approach! I think we could also consider having =
permanent
> > > > > > > >big stacks for some kernel only threads like kvm-vcpu. A coo=
perative
> > > > > > > >stack increase framework could work well and wouldn't negati=
vely
> > > > > > > >impact the performance of context switching. However, thorou=
gh
> > > > > > > >analysis would be necessary to proactively identify potentia=
l stack
> > > > > > > >overflow situations.
> > > > > > > >
> > > > > > > >> > Why would we need an "I need more stack" API? Pasha's ap=
proach seems
> > > > > > > >> > like everything we need for what you're talking about.
> > > > > > > >>
> > > > > > > >> Because double faults are hard, possibly impossible, and t=
he FRED approach
> > > > > > > >> Peter described has extra overhead?  This was all describe=
d up-thread.
> > > > > > > >
> > > > > > > >Handling faults in #DF is possible. It requires code inspect=
ion to
> > > > > > > >handle race conditions such as what was shown by tglx. Howev=
er, as
> > > > > > > >Andy pointed out, this is not supported by SDM as it is an a=
bort
> > > > > > > >context (yet we return from it because of ESPFIX64, so retur=
n is
> > > > > > > >possible).
> > > > > > > >
> > > > > > > >My question, however, if we ignore memory savings and only c=
onsider
> > > > > > > >reliability aspect of this feature.  What is better uncondit=
ionally
> > > > > > > >crashing the machine because a guard page was reached, or pr=
inting a
> > > > > > > >huge warning with a backtracing information about the offend=
ing stack,
> > > > > > > >handling the fault, and survive? I know that historically Li=
nus
> > > > > > > >preferred WARN() to BUG() [1]. But, this is a somewhat diffe=
rent
> > > > > > > >scenario compared to simple BUG vs WARN.
> > > > > > > >
> > > > > > > >Pasha
> > > > > > > >
> > > > > > > >[1] https://lore.kernel.org/all/Pine.LNX.4.44.0209091832160.=
1714-100000@home.transmeta.com
> > > > > > > >
> > > > > > >
> > > > > > > The real issue with using #DF is that if the event that cause=
d it was asynchronous, you could lose the event.
> > > > > >
> > > > > > Got it. So, using a #DF handler for stack page faults isn't fea=
sible.
> > > > > > I suppose the only way for this to work would be to use a dedic=
ated
> > > > > > Interrupt Stack Table (IST) entry for page faults (#PF), but I =
suspect
> > > > > > that might introduce other complications.
> > > > > >
> > > > > > Expanding on Mathew's idea of an interface for dynamic kernel s=
tack
> > > > > > sizes, here's what I'm thinking:
> > > > > >
> > > > > > - Kernel Threads: Create all kernel threads with a fully popula=
ted
> > > > > > THREAD_SIZE stack.  (i.e. 16K)
> > > > > > - User Threads: Create all user threads with THREAD_SIZE kernel=
 stack
> > > > > > but only the top page mapped. (i.e. 4K)
> > > > > > - In enter_from_user_mode(): Expand the thread stack to 16K by =
mapping
> > > > > > three additional pages from the per-CPU stack cache. This funct=
ion is
> > > > > > called early in kernel entry points.
> > > > > > - exit_to_user_mode(): Unmap the extra three pages and return t=
hem to
> > > > > > the per-CPU cache. This function is called late in the kernel e=
xit
> > > > > > path.
> > > > > >
> > > > > > Both of the above hooks are called with IRQ disabled on all ker=
nel
> > > > > > entries whether through interrupts and syscalls, and they are c=
alled
> > > > > > early/late enough that 4K is enough to handle the rest of entry=
/exit.
> > > >
> > > > Hi Brian,
> > > >
> > > > > This proposal will not have the memory savings that you are looki=
ng
> > > > > for, since sleeping tasks would still have a fully allocated stac=
k.
> > > >
> > > > The tasks that were descheduled while running in user mode should n=
ot
> > > > increase their stack. The potential saving is greater than the
> > > > origianl proposal, because in the origianl proposal we never shrink
> > > > stacks after faults.
> > >
> > > A task has to enter kernel mode in order to be rescheduled.  If it
> > > doesn't make a syscall or hit an exception, then the timer interrupt
> > > will eventually kick it out of user mode.  At some point schedule() i=
s
> > > called, the task is put to sleep and context is switched to the next
> > > task.  A sleeping task will always be using some amount of kernel
> > > stack.  How much depends a lot on what caused the task to sleep.  If
> > > the timeslice expired it could switch right before the return to user
> > > mode.  A page fault could go deep into filesystem and device code
> > > waiting on an I/O operation.
> > >
> > > > > This also would add extra overhead to each entry and exit (includ=
ing
> > > > > syscalls) that can happen multiple times before a context switch.=
  It
> > > > > also doesn't make much sense because a task running in user mode =
will
> > > > > quickly need those stack pages back when it returns to kernel mod=
e.
> > > > > Even if it doesn't make a syscall, the timer interrupt will kick =
it
> > > > > out of user mode.
> > > > >
> > > > > What should happen is that the unused stack is reclaimed when a t=
ask
> > > > > goes to sleep.  The kernel does not use a red zone, so any stack =
pages
> > > > > below the saved stack pointer of a sleeping task (task->thread.sp=
) can
> > > > > be safely discarded.  Before context switching to a task, fully
> > > >
> > > > Excellent observation, this makes Andy Lutomirski per-map proposal =
[1]
> > > > usable without tracking dirty/accessed bits. More reliable, and als=
o
> > > > platform independent.
> > >
> > > This is x86-specific.  Other architectures will likely have differenc=
es.
> > >
> > > > > populate its task stack.  After context switching from a task, re=
claim
> > > > > its unused stack.  This way, the task stack in use is always full=
y
> > > > > allocated and we don't have to deal with page faults.
> > > > >
> > > > > To make this happen, __switch_to() would have to be split into tw=
o
> > > > > parts, to cleanly separate what happens before and after the stac=
k
> > > > > switch.  The first part saves processor context for the previous =
task,
> > > > > and prepares the next task.
> > > >
> > > > By knowing the stack requirements of __switch_to(), can't we actual=
ly
> > > > do all that in the common code in context_switch() right before
> > > > __switch_to()? We would do an arch specific call to get the
> > > > __switch_to() stack requirement, and use that to change the value o=
f
> > > > task->thread.sp to know where the stack is going to be while sleepi=
ng.
> > > > At this time we can do the unmapping of the stack pages from the
> > > > previous task, and mapping the pages to the next task.
> > >
> > > task->thread.sp is set in __switch_to_asm(), and is pretty much the
> > > last thing done in the context of the previous task.  Trying to
> > > predict that value ahead of time is way too fragile.
> >
> > We don't require an exact value, but rather an approximate upper
> > limit. To illustrate, subtract 1K from the current .sp, then determine
> > the corresponding page to decide the number of pages needing
> > unmapping. The primary advantage is that we can avoid
> > platform-specific ifdefs for DYNAMIC_STACKS within the arch-specific
> > switch_to() function. Instead, each platform can provide an
> > appropriate upper bound for switch_to() operations. We know the amount
> > of information is going to be stored on the stack by the routines, and
> > also since interrupts are disabled stacks are not used for anything
> > else there, so I do not see a problem with determining a reasonable
> > upper bound.
>
> The stack usage will vary depending on compiler version and
> optimization settings.  Making an educated guess is possible, but may
> not be enough in the future.
>
> What would be nice is to get some actual data on stack usage under
> various workloads, both maximum depth and depth at context switch.
>
> > >  Also, the key
> > > point I was trying to make is that you cannot safely shrink the activ=
e
> > > stack.  It can only be done after the stack switch to the new task.
> >
> > Can you please elaborate why this is so? If the lowest pages are not
> > used, and interrupts are disabled what is not safe about removing them
> > from the page table?
> >
> > I am not against the idea of unmapping in __switch_to(), I just want
> > to understand the reasons why more generic but perhaps not as precise
> > approach would not  work.
>
> As long as a wide buffer is given, it would probably be safe.  But it
> would still be safer and more precise if done after the switch.

Makes sense. Looks like using task->thread.sp during context is not
possible because the pages might have been shared with another CPU. We
would need to do ipi tlb invalidation, which would be too expensive
for the context switch. Therefore, using pte->accessed is more
reliable to determine which pages can be unmapped. However, we could
still use task->thread.sp in a garbage collector.

Pasha

