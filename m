Return-Path: <linux-kernel+bounces-131789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD43898BCB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7B9E1F2228D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244E912AAF7;
	Thu,  4 Apr 2024 16:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+9LmoP/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397AA1BC46;
	Thu,  4 Apr 2024 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712246769; cv=none; b=t9AIG/wWdU2k49tF/s4A2vE5iXGTgK8mJ9RNJprZ9ogeIQN6v2JI/AAr19nav6o8AQ8I3hp3BlNv85cVKOS3FiHWqcplhW34MaTf0xs8DNAJX1szjDtSno0Wnit6YQnEYA7wtSad/cC4FsbGGI6GZXN1qirp5J0lOlJrPRueoqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712246769; c=relaxed/simple;
	bh=+5n1opxFvTrkkm7rzpBmiqYFvlJrF7IWFtBu70bBigs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=p6fT5hf2KqnF2T/RpHCCuL875l2tRM6PEc1eDJH9wOWbL2o86g32ZunSQu/LFx62qFhVxINayH4ENrpEJtMQEB58mx5QIGOJeas6HFmfZP5NEbO8WrE2M17rVQSn0C1vbUF6cGIWxgAMb46TNqwlrM/bi3BgRTAUFP12Qyti3Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+9LmoP/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79270C43390;
	Thu,  4 Apr 2024 16:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712246768;
	bh=+5n1opxFvTrkkm7rzpBmiqYFvlJrF7IWFtBu70bBigs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g+9LmoP/qNM5Fayaerz57GtxMTmBUXsjnSbxebbCkQxULEi3MCu4hJBJzVmLZzcVh
	 7jQ+YkTF0SnkK3uxx0dZGfgkxjvD7VvUIHQlTi3B/79sofEimfUjezt5UQZeOBDcEv
	 a3QRqDuXvPUbMBA9RcjPB4i4jHeB0A49dVYhg10xQzGOsr512khahosuoZi1iUgXF2
	 Ks0sl41DeIUiGVxyRGEW56kdBnFRb0AvRTsViKdufvUhNiMyfrV+L/vXWfTmPCDW2j
	 yipFk6iA39YdQpVPb8z83KsbJdxVev2nrESqvgGMIA8SsxCGFVtPtPfJIlOefQw+XB
	 MUE8BKBXFw8nQ==
Date: Fri, 5 Apr 2024 01:06:03 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-api@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Song Liu
 <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org
Subject: Re: [PATCHv2 1/3] uprobe: Add uretprobe syscall to speed up return
 probe
Message-Id: <20240405010603.58bd96cdf56d456103844e65@kernel.org>
In-Reply-To: <Zg6V8y2-OP_9at2l@krava>
References: <20240402093302.2416467-1-jolsa@kernel.org>
	<20240402093302.2416467-2-jolsa@kernel.org>
	<20240403100708.233575a8ac2a5bac2192d180@kernel.org>
	<Zg0lvUIB4WdRUGw_@krava>
	<20240403230937.c3bd47ee47c102cd89713ee8@kernel.org>
	<CAEf4BzZ2RFfz8PNgJ4ENZ0us4uX=DWhYFimXdtWms-VvGXOjgQ@mail.gmail.com>
	<20240404095829.ec5db177f29cd29e849169fa@kernel.org>
	<CAEf4BzYH60TwvBipHWB_kUqZZ6D-iUVnnFsBv06imRikK3o-bg@mail.gmail.com>
	<Zg6V8y2-OP_9at2l@krava>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Apr 2024 13:58:43 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Wed, Apr 03, 2024 at 07:00:07PM -0700, Andrii Nakryiko wrote:
> 
> SNIP
> 
> > Check rt_sigreturn syscall (manpage at [0], for example).
> > 
> >        sigreturn() exists only to allow the implementation of signal
> >        handlers.  It should never be called directly.  (Indeed, a simple
> >        sigreturn() wrapper in the GNU C library simply returns -1, with
> >        errno set to ENOSYS.)  Details of the arguments (if any) passed
> >        to sigreturn() vary depending on the architecture.  (On some
> >        architectures, such as x86-64, sigreturn() takes no arguments,
> >        since all of the information that it requires is available in the
> >        stack frame that was previously created by the kernel on the
> >        user-space stack.)
> > 
> > This is a very similar use case. Also, check its source code in
> > arch/x86/kernel/signal_64.c. It sends SIGSEGV to the calling process
> > on any sign of something not being right. It's exactly the same with
> > sys_uretprobe.
> > 
> >   [0] https://man7.org/linux/man-pages/man2/sigreturn.2.html
> > 
> > > And the number of syscalls are limited resource.
> > 
> > We have almost 500 of them, it didn't seems like adding 1-2 for good
> > reasons would be a problem. Can you please point to where the limits
> > on syscalls as a resource are described? I'm curious to learn.
> > 
> > >
> > > I'm actually not sure how much we need to care of it, but adding a new
> > > syscall is worth to be discussed carefully because all of them are
> > > user-space compatibility.
> > 
> > Absolutely, it's a good discussion to have.
> > 
> > >
> > > > > > > Also, we should run syzkaller on this syscall. And if uretprobe is
> > > > > >
> > > > > > right, I'll check on syzkaller
> > > > > >
> > > > > > > set in the user function, what happen if the user function directly
> > > > > > > calls this syscall? (maybe it consumes shadow stack?)
> > > > > >
> > > > > > the process should receive SIGILL if there's no pending uretprobe for
> > > > > > the current task, or it will trigger uretprobe if there's one pending
> > > > >
> > > > > No, that is too aggressive and not safe. Since the syscall is exposed to
> > > > > user program, it should return appropriate error code instead of SIGILL.
> > > > >
> > > >
> > > > This is the way it is today with uretprobes even through interrupt.
> > >
> > > I doubt that the interrupt (exception) and syscall should be handled
> > > differently. Especially, this exception is injected by uprobes but
> > > syscall will be caused by itself. But syscall can be called from user
> > > program (of couse this works as sys_kill(self, SIGILL)).
> > 
> > Yep, I'd keep the behavior the same between uretprobes implemented
> > through int3 and sys_uretprobe.
> 
> +1 
> 
> > 
> > >
> > > > E.g., it could happen that user process is using fibers and is
> > > > replacing stack pointer without kernel realizing this, which will
> > > > trigger some defensive checks in uretprobe handling code and kernel
> > > > will send SIGILL because it can't support such cases. This is
> > > > happening today already, and it works fine in practice (except for
> > > > applications that manually change stack pointer, too bad, you can't
> > > > trace them with uretprobes, unfortunately).
> > >
> > > OK, we at least need to document it.
> > 
> > +1, yep
> > 
> > >
> > > >
> > > > So I think it's absolutely adequate to have this behavior if the user
> > > > process is *intentionally* abusing this API.
> > >
> > > Of course user expected that it is abusing. So at least we need to
> > > add a document that this syscall number is reserved to uprobes and
> > > user program must not use it.
> > >
> > 
> > Totally agree about documenting this.
> 
> ok there's map page on sigreturn.. do you think we should add man page
> for uretprobe or you can think of some other place to document it?

I think it is better to have a man-page. Anyway, to discuss and explain
this syscall, the man-page is a good format to describe it.

> 
> > 
> > > >
> > > > > >
> > > > > > but we could limit the syscall to be executed just from the trampoline,
> > > > > > that should prevent all the user space use cases, I'll do that in next
> > > > > > version and add more tests for that
> > > > >
> > > > > Why not limit? :) The uprobe_handle_trampoline() expects it is called
> > > > > only from the trampoline, so it is natural to check the caller address.
> > > > > (and uprobe should know where is the trampoline)
> > > > >
> > > > > Since the syscall is always exposed to the user program, it should
> > > > > - Do nothing and return an error unless it is properly called.
> > > > > - check the prerequisites for operation strictly.
> > > > > I concern that new system calls introduce vulnerabilities.
> > > > >
> > > >
> > > > As Oleg and Jiri mentioned, this syscall can't harm kernel or other
> > > > processes, only the process that is abusing the API. So any extra
> > > > checks that would slow down this approach is an unnecessary overhead
> > > > and complication that will never be useful in practice.
> > >
> > > I think at least it should check the caller address to ensure the
> > > address is in the trampoline.
> > > But anyway, uprobes itself can break the target process, so no one
> > > might care if this system call breaks the process now.
> > 
> > If we already have an expected range of addresses, then I think it's
> > fine to do a quick unlikely() check. I'd be more concerned if we need
> > to do another lookup or search to just validate this. I'm sure Jiri
> > will figure it out.
> 
> Oleg mentioned the trampoline address check could race with another
> thread's mremap call, however trap is using that check as well, it
> still seems like good idea to do it also in the uretprobe syscall

Yeah, and also, can we add a stack pointer check if the trampoline is
shared with other probe points?

Thank you,

> 
> jirka


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

