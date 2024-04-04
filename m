Return-Path: <linux-kernel+bounces-130825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94234897D8F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 04:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19182285C2A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3851BF37;
	Thu,  4 Apr 2024 02:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXcsqUTn"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDA018C38;
	Thu,  4 Apr 2024 02:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712196024; cv=none; b=ptLCv0YYf4Baz+nj4p7MRlDrLqhXD0FXSiob3E1FZEIwWmDQuzOBa5x4AmNgUBuUmrt86A2lDcFnHtZGq4MOYaA8BUJxS0XiKVmJgBNGinTXC0tS0K/2XDNa8pgLNf9Dh0Z4FToyAt+b+7Lixsl62Z0uGFEoHymTzxHKbrEFBq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712196024; c=relaxed/simple;
	bh=q8gkWHc5kCbkRF/ybUez70chd5eKVNTJQmZ2vKIyeFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJwsE1G457ta76lJdVz8p0bUb+0ap09ZOXoZwzBt/tiWCBQfqzJvhQpvqJ9uDSyvqlA/a9XCmoixRgBEhqhdvph2Imkx5YPML2FaYRbR6YFxSiM7mV2LPmcSz5DC++/reCCxbQSk87klTzg1ggNiv46sBPLHefYuAkt32aELtT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXcsqUTn; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e73e8bdea2so409873b3a.0;
        Wed, 03 Apr 2024 19:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712196022; x=1712800822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKh3sxyoRv9cKZKOIDktP1/7vp4+1mfdVBqbgg7wNjk=;
        b=MXcsqUTnWON7Bjh/sScClAHXjMwQPDKr0hrMK2zNbx0nMdR1HvKrZNaohfBhDwXAJq
         KY+RA4J2bZKl1mGJQID7b28qX74fXRtlrogv7g6wEDMRJ8fvulEYBKlAiNLAnsp7PI3S
         E/cA0eW6b6fASV2sxE9U0n495hUb8vAbjimV8UN+HKmedEJTCbNWM6URLL6xXWmC9rmv
         Rwkh5RRZsiYZ+mbvOzqf+YbsDJVKp1eQTkEOmGfLgYiWwVKSf7Zy58XSBgOGfErhxYWh
         qlik+gOHdFb52fTa9X51owmxpF2J7k4cJ44Pbn/2vs2gIe6URmGJzrJGqaKNeDR+hq8c
         3PLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712196022; x=1712800822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nKh3sxyoRv9cKZKOIDktP1/7vp4+1mfdVBqbgg7wNjk=;
        b=T+HRKIY4Jpgua/b3fBnALAh9BIL2kP55TwGeEsCKiyW169xJdXw5Tpsa7X4J6jp4UY
         RAcf+TzARoIiBcvll6KBXVpkYLLnHXsGMrYBxwvRuOt6aXVrsJ30xbEnErAF8YDztPwb
         HMEPlxP1PhS89GilkH2cFMtxzff3M9i7ateirGYo0LgHBi24KuX4Le2XHeGSxEJJ7gzP
         tDNhp5QcZucA467jO0goK1t9pMTIX7RCo++DQlBj3PUco5ZjenQ1TyE4OCI4Kjm2pJmA
         i2f8wNly3mybW88rEtcVcQDNxfCLmNEW+44uQo4pe61UldVXwA2hlpzAMiPjFM1jMdtU
         7SIg==
X-Forwarded-Encrypted: i=1; AJvYcCVRYCgJDaqKbvz+0UEbxPLVm8qRFTo+/nEQwDLk3HIYHpmxyp4hCzM4XZ8uN4XuwZO1W6AqcEegD/wgfKu5KrnPfdlnnkAeHXHEe1y92AKSriUwpV9OfGKDvuwbSMl+eoN0a9k4f0HdF4+PYILsArtoPYHSS8+PHJX7IwJn27X9REyIoBnR
X-Gm-Message-State: AOJu0Yyq1B5lE9HW7Hvk0aMC8CjHlURWGmoURTQaGcBkaSyNFkZZr+ho
	oOkLg2MiKmiZyfrjAfcitGVDEJEaJqiWV0ZVabq272RmovYH+ttx1JDUSbud81HKDTPG+6Nxzoe
	HmHFsuNbjHEj7bU+Pokzdgda9klM=
X-Google-Smtp-Source: AGHT+IERid2KJeMPn9+jPclOZQkCtCIvdoXkTbp0nd54fwPPZTTj0iSLVyRSOiWrN6O1Efy4p8ubNUzmbqJlFRrYrhw=
X-Received: by 2002:a05:6a20:748e:b0:1a3:6a74:2e6a with SMTP id
 p14-20020a056a20748e00b001a36a742e6amr1591455pzd.14.1712196019685; Wed, 03
 Apr 2024 19:00:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402093302.2416467-1-jolsa@kernel.org> <20240402093302.2416467-2-jolsa@kernel.org>
 <20240403100708.233575a8ac2a5bac2192d180@kernel.org> <Zg0lvUIB4WdRUGw_@krava>
 <20240403230937.c3bd47ee47c102cd89713ee8@kernel.org> <CAEf4BzZ2RFfz8PNgJ4ENZ0us4uX=DWhYFimXdtWms-VvGXOjgQ@mail.gmail.com>
 <20240404095829.ec5db177f29cd29e849169fa@kernel.org>
In-Reply-To: <20240404095829.ec5db177f29cd29e849169fa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Apr 2024 19:00:07 -0700
Message-ID: <CAEf4BzYH60TwvBipHWB_kUqZZ6D-iUVnnFsBv06imRikK3o-bg@mail.gmail.com>
Subject: Re: [PATCHv2 1/3] uprobe: Add uretprobe syscall to speed up return probe
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 5:58=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Wed, 3 Apr 2024 09:58:12 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > On Wed, Apr 3, 2024 at 7:09=E2=80=AFAM Masami Hiramatsu <mhiramat@kerne=
l.org> wrote:
> > >
> > > On Wed, 3 Apr 2024 11:47:41 +0200
> > > Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > > On Wed, Apr 03, 2024 at 10:07:08AM +0900, Masami Hiramatsu wrote:
> > > > > Hi Jiri,
> > > > >
> > > > > On Tue,  2 Apr 2024 11:33:00 +0200
> > > > > Jiri Olsa <jolsa@kernel.org> wrote:
> > > > >
> > > > > > Adding uretprobe syscall instead of trap to speed up return pro=
be.
> > > > >
> > > > > This is interesting approach. But I doubt we need to add addition=
al
> > > > > syscall just for this purpose. Can't we use another syscall or io=
ctl?
> > > >
> > > > so the plan is to optimize entry uprobe in a similar way and given
> > > > the syscall is not a scarce resource I wanted to add another syscal=
l
> > > > for that one as well
> > > >
> > > > tbh I'm not sure sure which syscall or ioctl to reuse for this, it'=
s
> > > > possible to do that, the trampoline will just have to save one or
> > > > more additional registers, but adding new syscall seems cleaner to =
me
> > >
> > > Hmm, I think a similar syscall is ptrace? prctl may also be a candida=
te.
> >
> > I think both ptrace and prctl are for completely different use cases
> > and it would be an abuse of existing API to reuse them for uretprobe
> > tracing. Also, keep in mind, that any extra argument that has to be
> > passed into this syscall means that we need to complicate and slow
> > generated assembly code that is injected into user process (to
> > save/restore registers) and also kernel-side (again, to deal with all
> > the extra registers that would be stored/restored on stack).
> >
> > Given syscalls are not some kind of scarce resources, what's the
> > downside to have a dedicated and simple syscall?
>
> Syscalls are explicitly exposed to user space, thus, even if it is used
> ONLY for a very specific situation, it is an official kernel interface,
> and need to care about the compatibility. (If it causes SIGILL unless
> a specific use case, I don't know there is a "compatibility".)

Check rt_sigreturn syscall (manpage at [0], for example).

       sigreturn() exists only to allow the implementation of signal
       handlers.  It should never be called directly.  (Indeed, a simple
       sigreturn() wrapper in the GNU C library simply returns -1, with
       errno set to ENOSYS.)  Details of the arguments (if any) passed
       to sigreturn() vary depending on the architecture.  (On some
       architectures, such as x86-64, sigreturn() takes no arguments,
       since all of the information that it requires is available in the
       stack frame that was previously created by the kernel on the
       user-space stack.)

This is a very similar use case. Also, check its source code in
arch/x86/kernel/signal_64.c. It sends SIGSEGV to the calling process
on any sign of something not being right. It's exactly the same with
sys_uretprobe.

  [0] https://man7.org/linux/man-pages/man2/sigreturn.2.html

> And the number of syscalls are limited resource.

We have almost 500 of them, it didn't seems like adding 1-2 for good
reasons would be a problem. Can you please point to where the limits
on syscalls as a resource are described? I'm curious to learn.

>
> I'm actually not sure how much we need to care of it, but adding a new
> syscall is worth to be discussed carefully because all of them are
> user-space compatibility.

Absolutely, it's a good discussion to have.

>
> > > > > Also, we should run syzkaller on this syscall. And if uretprobe i=
s
> > > >
> > > > right, I'll check on syzkaller
> > > >
> > > > > set in the user function, what happen if the user function direct=
ly
> > > > > calls this syscall? (maybe it consumes shadow stack?)
> > > >
> > > > the process should receive SIGILL if there's no pending uretprobe f=
or
> > > > the current task, or it will trigger uretprobe if there's one pendi=
ng
> > >
> > > No, that is too aggressive and not safe. Since the syscall is exposed=
 to
> > > user program, it should return appropriate error code instead of SIGI=
LL.
> > >
> >
> > This is the way it is today with uretprobes even through interrupt.
>
> I doubt that the interrupt (exception) and syscall should be handled
> differently. Especially, this exception is injected by uprobes but
> syscall will be caused by itself. But syscall can be called from user
> program (of couse this works as sys_kill(self, SIGILL)).

Yep, I'd keep the behavior the same between uretprobes implemented
through int3 and sys_uretprobe.

>
> > E.g., it could happen that user process is using fibers and is
> > replacing stack pointer without kernel realizing this, which will
> > trigger some defensive checks in uretprobe handling code and kernel
> > will send SIGILL because it can't support such cases. This is
> > happening today already, and it works fine in practice (except for
> > applications that manually change stack pointer, too bad, you can't
> > trace them with uretprobes, unfortunately).
>
> OK, we at least need to document it.

+1, yep

>
> >
> > So I think it's absolutely adequate to have this behavior if the user
> > process is *intentionally* abusing this API.
>
> Of course user expected that it is abusing. So at least we need to
> add a document that this syscall number is reserved to uprobes and
> user program must not use it.
>

Totally agree about documenting this.

> >
> > > >
> > > > but we could limit the syscall to be executed just from the trampol=
ine,
> > > > that should prevent all the user space use cases, I'll do that in n=
ext
> > > > version and add more tests for that
> > >
> > > Why not limit? :) The uprobe_handle_trampoline() expects it is called
> > > only from the trampoline, so it is natural to check the caller addres=
s.
> > > (and uprobe should know where is the trampoline)
> > >
> > > Since the syscall is always exposed to the user program, it should
> > > - Do nothing and return an error unless it is properly called.
> > > - check the prerequisites for operation strictly.
> > > I concern that new system calls introduce vulnerabilities.
> > >
> >
> > As Oleg and Jiri mentioned, this syscall can't harm kernel or other
> > processes, only the process that is abusing the API. So any extra
> > checks that would slow down this approach is an unnecessary overhead
> > and complication that will never be useful in practice.
>
> I think at least it should check the caller address to ensure the
> address is in the trampoline.
> But anyway, uprobes itself can break the target process, so no one
> might care if this system call breaks the process now.

If we already have an expected range of addresses, then I think it's
fine to do a quick unlikely() check. I'd be more concerned if we need
to do another lookup or search to just validate this. I'm sure Jiri
will figure it out.

>
> >
> > Also note that sys_uretprobe is a kind of internal and unstable API
> > and it is explicitly called out that its contract can change at any
> > time and user space shouldn't rely on it. It's purely for the kernel's
> > own usage.
>
> Is that OK to use a syscall as "internal" and "unstable" API?

See above about rt_sigreturn. It seems like yes, for some highly
specialized syscalls it is the case already.
>
> >
> > So let's please keep it fast and simple.
> >
> >
> > > Thank you,
> > >
> > >
> > > >
> > > > thanks,
> > > > jirka
> > > >
> > > >
> > > > >
> >
> > [...]
>
>
> ([OT] If we can add syscall so casually, I would like to add sys_traceeve=
nt
> for recording user space events :-) .)

Have you proposed this upstream? :) I have no clue and no opinion about it.=
.

>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

