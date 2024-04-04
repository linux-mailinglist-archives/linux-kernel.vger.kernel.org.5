Return-Path: <linux-kernel+bounces-131351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2285789869A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23BA1F26CD0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D37084FDC;
	Thu,  4 Apr 2024 11:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7f8X9Eg"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5978883CDE;
	Thu,  4 Apr 2024 11:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712231930; cv=none; b=pRDCPeCn4jxgjj3NunGHoNeL3Xmi3j2+yKSB5sy5/tO2EfCB20Y5LyS41rNTbZD1pObWRm/yLnw6OoRqGD4VV+2PRjdfwLcg9Rh2tbBUKgREZguS/ylHX7plsw88ZPVlKIi7/2KjxOqeOBOVoavt5Py9s0DZsfRUAfxl/XzvrtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712231930; c=relaxed/simple;
	bh=I4S4xPsrmiZqgxMo8An3Q4s4/0gCW+VeyLvu4PCz+QM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HS0NVz8MpKeMPMVfh3+VPEgDtEFjD/PCCpK/lEzl3PG80f4Kr3IcYSjg8cyBMTxNWIWLf6nKCCEpFY7UK/y1tkEn4hSv3VPASEdm4XP6zQ4Pmg47hlFjEAhv/01WmF3OPZGPW3gfdgRoAguvL2+NtYFxex7ox3lio1VrN9BRNIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7f8X9Eg; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a47385a4379so380302866b.0;
        Thu, 04 Apr 2024 04:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712231926; x=1712836726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qsRNsoYGonWs9F3wm/xwAs0YUtd7nB9bkZE8SBzuHdw=;
        b=a7f8X9Eg/qkjuS0RXdEw2FigBgyJc84tsrb4BcHrnNBugTq2DEQJ81pIwdGFYw1DQw
         TngFSCvKshJHRxQRDGRKihDrQMJ3YmnyOkEaXREFufO6cjSUOyHxk5W2TX6nKYpuqbvS
         E994cXVwnlFEb3mWN0nuKK3A1I/3e4xgVQmSjBdLqPYZs6OXRzaJDMCj0WIEucOOA/5N
         7eNczt0qTrg+zh/P2jm6f9JeFuCgvOaxks0myzR+X/cYnbG0WlMoJcsvBiwQ4iRQeEVP
         dQVa3GyIBKsVQ8zKoSsZXTd6yJPxMkpENkTf1jVQKxG7JtbyBzrcDLwFL3ejTDAcmQiL
         ZFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712231926; x=1712836726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsRNsoYGonWs9F3wm/xwAs0YUtd7nB9bkZE8SBzuHdw=;
        b=vM7MMjwj62Z7nWhWoH8ttF2jMFLT7CWgip6hZLVOh8cHIkdKFXVUQL4VbQR9h+IC0+
         TvWsWdmNdKrHZX/ee6wWe01b8dRZtppQeQMaOBPF3rras2CHrN1TiZPLNu+xQPBEZl+r
         NZHV81LGLDJHu94zjtM3yk73ZerIhKGmJZhTZ8IvyNTQ7p8g9u44zLKaeDqxXYCuKaCr
         tiEMjrfETM7abqyRFFzzWueCFsMbxa13UOhT3wM//cfHLqTACHzuiqQtd3d5hDWJdsM/
         6iBVgPd5jfR1Qc6ypfnzv6q6u+E2XdptakZ3JwpnA0ppfkRguvZe+c4Wwk2favvu/J8y
         zCGA==
X-Forwarded-Encrypted: i=1; AJvYcCVrqQLfFyI0lCWEotjKSDzQViZSNNENuYtwjUSoTluNyniU28yNDWLbVi09MflnE1BzcRuj/CvBKZ+s5iWManRnoUSHt/H2M+qskxVZ56zqEvD/Ip3Dyw2A5BDvfj02ZVOB57YTAtW6qlrvkNEEbIMocgQ7SN3dS7wMhFVjFWQR5d/ug/kJ
X-Gm-Message-State: AOJu0YwYYTzz1Tc7hXyjt6mD5sAM3ZtqmgWKwR5utJLjXVONACeQogtF
	kUAbJ4S/K6HU5LhQCaW3qUBu7GYBX8aBpj9nNJS/WkEDtT/TfhgR
X-Google-Smtp-Source: AGHT+IHd7nPhPfR8+dEIdU9lXVEWpv390SUK05ck+5jbxmVDFBpWRITJjq4jHfVI8EDOciClvgu7tg==
X-Received: by 2002:a17:906:f912:b0:a4e:13ee:5dec with SMTP id lc18-20020a170906f91200b00a4e13ee5decmr4826565ejb.17.1712231926323;
        Thu, 04 Apr 2024 04:58:46 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id t5-20020a170906a10500b00a46af5f023bsm8913599ejy.202.2024.04.04.04.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 04:58:45 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 4 Apr 2024 13:58:43 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <olsajiri@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: Re: [PATCHv2 1/3] uprobe: Add uretprobe syscall to speed up return
 probe
Message-ID: <Zg6V8y2-OP_9at2l@krava>
References: <20240402093302.2416467-1-jolsa@kernel.org>
 <20240402093302.2416467-2-jolsa@kernel.org>
 <20240403100708.233575a8ac2a5bac2192d180@kernel.org>
 <Zg0lvUIB4WdRUGw_@krava>
 <20240403230937.c3bd47ee47c102cd89713ee8@kernel.org>
 <CAEf4BzZ2RFfz8PNgJ4ENZ0us4uX=DWhYFimXdtWms-VvGXOjgQ@mail.gmail.com>
 <20240404095829.ec5db177f29cd29e849169fa@kernel.org>
 <CAEf4BzYH60TwvBipHWB_kUqZZ6D-iUVnnFsBv06imRikK3o-bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYH60TwvBipHWB_kUqZZ6D-iUVnnFsBv06imRikK3o-bg@mail.gmail.com>

On Wed, Apr 03, 2024 at 07:00:07PM -0700, Andrii Nakryiko wrote:

SNIP

> Check rt_sigreturn syscall (manpage at [0], for example).
> 
>        sigreturn() exists only to allow the implementation of signal
>        handlers.  It should never be called directly.  (Indeed, a simple
>        sigreturn() wrapper in the GNU C library simply returns -1, with
>        errno set to ENOSYS.)  Details of the arguments (if any) passed
>        to sigreturn() vary depending on the architecture.  (On some
>        architectures, such as x86-64, sigreturn() takes no arguments,
>        since all of the information that it requires is available in the
>        stack frame that was previously created by the kernel on the
>        user-space stack.)
> 
> This is a very similar use case. Also, check its source code in
> arch/x86/kernel/signal_64.c. It sends SIGSEGV to the calling process
> on any sign of something not being right. It's exactly the same with
> sys_uretprobe.
> 
>   [0] https://man7.org/linux/man-pages/man2/sigreturn.2.html
> 
> > And the number of syscalls are limited resource.
> 
> We have almost 500 of them, it didn't seems like adding 1-2 for good
> reasons would be a problem. Can you please point to where the limits
> on syscalls as a resource are described? I'm curious to learn.
> 
> >
> > I'm actually not sure how much we need to care of it, but adding a new
> > syscall is worth to be discussed carefully because all of them are
> > user-space compatibility.
> 
> Absolutely, it's a good discussion to have.
> 
> >
> > > > > > Also, we should run syzkaller on this syscall. And if uretprobe is
> > > > >
> > > > > right, I'll check on syzkaller
> > > > >
> > > > > > set in the user function, what happen if the user function directly
> > > > > > calls this syscall? (maybe it consumes shadow stack?)
> > > > >
> > > > > the process should receive SIGILL if there's no pending uretprobe for
> > > > > the current task, or it will trigger uretprobe if there's one pending
> > > >
> > > > No, that is too aggressive and not safe. Since the syscall is exposed to
> > > > user program, it should return appropriate error code instead of SIGILL.
> > > >
> > >
> > > This is the way it is today with uretprobes even through interrupt.
> >
> > I doubt that the interrupt (exception) and syscall should be handled
> > differently. Especially, this exception is injected by uprobes but
> > syscall will be caused by itself. But syscall can be called from user
> > program (of couse this works as sys_kill(self, SIGILL)).
> 
> Yep, I'd keep the behavior the same between uretprobes implemented
> through int3 and sys_uretprobe.

+1 

> 
> >
> > > E.g., it could happen that user process is using fibers and is
> > > replacing stack pointer without kernel realizing this, which will
> > > trigger some defensive checks in uretprobe handling code and kernel
> > > will send SIGILL because it can't support such cases. This is
> > > happening today already, and it works fine in practice (except for
> > > applications that manually change stack pointer, too bad, you can't
> > > trace them with uretprobes, unfortunately).
> >
> > OK, we at least need to document it.
> 
> +1, yep
> 
> >
> > >
> > > So I think it's absolutely adequate to have this behavior if the user
> > > process is *intentionally* abusing this API.
> >
> > Of course user expected that it is abusing. So at least we need to
> > add a document that this syscall number is reserved to uprobes and
> > user program must not use it.
> >
> 
> Totally agree about documenting this.

ok there's map page on sigreturn.. do you think we should add man page
for uretprobe or you can think of some other place to document it?

> 
> > >
> > > > >
> > > > > but we could limit the syscall to be executed just from the trampoline,
> > > > > that should prevent all the user space use cases, I'll do that in next
> > > > > version and add more tests for that
> > > >
> > > > Why not limit? :) The uprobe_handle_trampoline() expects it is called
> > > > only from the trampoline, so it is natural to check the caller address.
> > > > (and uprobe should know where is the trampoline)
> > > >
> > > > Since the syscall is always exposed to the user program, it should
> > > > - Do nothing and return an error unless it is properly called.
> > > > - check the prerequisites for operation strictly.
> > > > I concern that new system calls introduce vulnerabilities.
> > > >
> > >
> > > As Oleg and Jiri mentioned, this syscall can't harm kernel or other
> > > processes, only the process that is abusing the API. So any extra
> > > checks that would slow down this approach is an unnecessary overhead
> > > and complication that will never be useful in practice.
> >
> > I think at least it should check the caller address to ensure the
> > address is in the trampoline.
> > But anyway, uprobes itself can break the target process, so no one
> > might care if this system call breaks the process now.
> 
> If we already have an expected range of addresses, then I think it's
> fine to do a quick unlikely() check. I'd be more concerned if we need
> to do another lookup or search to just validate this. I'm sure Jiri
> will figure it out.

Oleg mentioned the trampoline address check could race with another
thread's mremap call, however trap is using that check as well, it
still seems like good idea to do it also in the uretprobe syscall

jirka

