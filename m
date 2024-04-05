Return-Path: <linux-kernel+bounces-133562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D60789A5A5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037A5283B49
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBD4174EDC;
	Fri,  5 Apr 2024 20:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INsAG9/U"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4BD171077;
	Fri,  5 Apr 2024 20:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712348926; cv=none; b=P8f4tRpKwLDCeMGSrOkYs9qCTc4TkaNhtYSLyrblAvHbGjIPSdhhYWXeg9yRptJZv+fT/GksOMJqbviuRVE5wcdK4vnoegWe5oA7kkggr40HxgWoo3XssqmHmCz/xDBdoLHJW0i1VNz0d/vC79KOIMTN22aj79gJ7C7I0ynXrj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712348926; c=relaxed/simple;
	bh=SRk1BAyFbO7xlNckhNzLlmX4edRBAotwNcUvm9mn+Dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MmPNWf3T9nizC4rMQf+a5IpeSUSuB8zIeHgyRqJOi6Xo9R4qkmo0CWULAbxZsOGVK5b9qKaEgDD46nDOAfltujujBjUoaJtiqVj1jt1t58jKPkOjjtjeUkpdx01SZ9WQlLZ/y04cjzfyUvGW6XkDSma/CLcWHbwzxBDOjftKr3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INsAG9/U; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2a2f82ded89so1153236a91.1;
        Fri, 05 Apr 2024 13:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712348924; x=1712953724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KHiRz2MEVl6qNeBBl7ut0Lqj346TjDrch4NCQyug9w=;
        b=INsAG9/U3eFBAZPqy+PgaI37Br6TXkpFrSyWVtK9HmQ0cA1+T/8JdEhiRoUZPMFtfh
         l+gjX4aXzoH+PrPP/nVWMRO7gcMC3kkFK7mgcVitqt7LdwSdatFda5TMcytxZAo8nitN
         70k1SYwd7+sZhGjsnTKkbRIKxWCezMz4Lmta7x6gxlQAdw9SCZGAUel1lKTu/xJxJlGu
         kLL8c6BcUuxLPo6O7aVADtOFpzIHHbfzBUlG0c5R/ntVgRzqQhcRx1JJxz0KqkQ/INHd
         qHSx2FP11k1xryqLv9xzlvW0GGsWtwGbf2A1GnEF7sQxCzmUxZR8ncVM96mF+YO+MAVw
         LEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712348924; x=1712953724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/KHiRz2MEVl6qNeBBl7ut0Lqj346TjDrch4NCQyug9w=;
        b=qsF7rNn9nOY7nbgRFChWcugEMhHGIq0X9F23NnWU2EssWWHK60sZ/IRh6o18ybZrrU
         sEsh1exNqmOlQIKDBBuyiAizY6iW/PtlcMIgzMd/ee6aPfjwpRY2sS7kfYNQ9p34Seah
         ECzhb7S9AQAApX1yiGCMfuY+bLV7Q0J4vfVIqmUWn9u6DtZJvb/w5D2+1UsIDmwSJ9Hy
         KngHa08RrUvTJZgf5PAdwAjVqqUdtMUJHImUgM7IKfJ4VQsvNi4fd4BXpOaLVnESDZ7V
         iKe+uB0tK6nDJ3Pk2yiNrBgbiERTZM14FgwK+O+11luTqQX9dR+EEQqlaSvu1IMDymuB
         NIkw==
X-Forwarded-Encrypted: i=1; AJvYcCU2jAPnUburRJx8tPbp5ccLMQB/9VL+v7Kn8ukoRnwaF+pXcQGvwWiXGc9/h7z7vVmxeMLqVhQhIkxJnMYSHf6npSPzAbdvpLSVFfhWWUuuf6zhEeatNSSH0XtXTbeoXCr7L/MwdBytxQ6QwW9n7k8ALMml/vJYi5C2ReK5BBpTQ+q86g+7rA6kSJsh18DPyOev98rG2L3oGOplYr4mUhfc
X-Gm-Message-State: AOJu0YwuQZDgR+xdJYMFQJ+6ouRClXrLlWJClXXXznw3ZjHN+Cj/6veC
	19K3X2RE41j1ue8wUBVruN36WU9RDWXsOvyvhhsrvMQ2AvIfgauDd8zRkRzF4WhiEjU1wSZ68bm
	xfQP3uDT1Py5naBI0fCi1CHyo3FI=
X-Google-Smtp-Source: AGHT+IEB17rUN/p90piyyO2Fh5+5Y5JCRNaDz+2U2dzLD5suRIg39op7NfkR+8THwcH3RleE5jqbr98eGeCYB6CxcAk=
X-Received: by 2002:a17:90a:f0c8:b0:2a2:21a7:48bf with SMTP id
 fa8-20020a17090af0c800b002a221a748bfmr2697144pjb.14.1712348924104; Fri, 05
 Apr 2024 13:28:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404190146.1898103-1-elver@google.com> <CAADnVQKc+Z39k9wbU2MHf-fPFma+9QsyOugmmmGq3ynQCTVfCw@mail.gmail.com>
 <CANpmjNN+rR1PWKbx6RBWhOjnmAP+jUDzc3TLcwTnmfd=ft03dg@mail.gmail.com>
In-Reply-To: <CANpmjNN+rR1PWKbx6RBWhOjnmAP+jUDzc3TLcwTnmfd=ft03dg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Apr 2024 13:28:32 -0700
Message-ID: <CAEf4BzZCj=3hevf+Je=oed9Nisctotp_CX00NrLaO6_7+-0LSQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Introduce bpf_probe_write_user_registered()
To: Marco Elver <elver@google.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, bpf <bpf@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 1:28=E2=80=AFAM Marco Elver <elver@google.com> wrote=
:
>
> On Fri, 5 Apr 2024 at 01:23, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Apr 4, 2024 at 12:02=E2=80=AFPM Marco Elver <elver@google.com> =
wrote:
> > >
> > > With all the known caveats, tracing BPF programs may directly write t=
o
> > > user-space memory with the bpf_probe_write_user() helper. Memory safe=
ty
> > > is an obvious problem when using this helper, since it is too easy to
> > > overwrite memory across all running processes that user space did not
> > > expect to be touched (neither the verifier nor the kernel knows what =
may
> > > be touched). While it is possible to come up with mechanisms to safel=
y
> > > communicate to the BPF program which memory region may be written to,
> > > there are no built-in guarantees of safety. For this reason, the help=
er
> > > produces a warning in the kernel log, and in newer kernels it is
> > > possible to disallow use of the helper since 51e1bb9eeaf7 ("bpf: Add
> > > lockdown check for probe_write_user helper").
> >
> > So is it a fix or a feature?
>
> Feature. The above paragraph is just an intro. Remove it?
>
> > > Nevertheless, direct user-space memory writes from BPF programs can b=
e
> > > useful to efficiently manipulate and communicate with cooperating use=
r
> > > space processes.
> >
> > But there are many different ways for bpf to communicate with user spac=
e:
> > perf ringbuf, bpf ringbug, various maps including mmap-ed array and are=
na.
> > The commit log doesn't explain why we need another one.
> >
> > > For example, one of our use cases are for events that happen relative=
ly
> > > frequently in the kernel (e.g. specific scheduler events), but a set =
of
> > > user space threads want to check for such events in very hot code pat=
hs
> > > to make more optimal decisions (the cost of such a check can be no mo=
re
> > > than a load and compare). The types of events and heuristics used may
> > > change based on system environment and application, and a BPF program
> > > provides the best trade-offs in terms of performance and deployment.
> >
> > and the tasks can use mmaped array shared across all or unique to each
> > process.
> > And both bpf and user space can read/write them with a single instructi=
on.
>
> That's BPF_F_MMAPABLE, right?
>
> That does not work because the mmapped region is global. Our requirements=
 are:
>
> 1. Single tracing BPF program.
>
> 2. Per-process (per VM) memory region (here it's per-thread, but each
> thread just registers the same process-wide region).  No sharing
> between processes.
>
> 3. From #2 it follows: exec unregisters the registered memory region;
> fork gets a cloned region.
>
> 4. Unprivileged processes can do prctl(REGISTER). Some of them might
> not be able to use the bpf syscall.
>
> The reason for #2 is that each user space process also writes to the
> memory region (read by the BPF program to make updates depending on
> what state it finds), and having shared state between processes
> doesn't work here.
>
> Is there any reasonable BPF facility that can do this today? (If
> BPF_F_MMAPABLE could do it while satisfying requirements 2-4, I'd be a
> happy camper.)

You could simulate something like this with multi-element ARRAY +
BPF_F_MMAPABLE, though you'd need to pre-allocate up to max number of
processes, so it's not an exact fit.

But what seems to be much closer is using BPF task-local storage, if
we support mmap()'ing its memory into user-space. We've had previous
discussions on how to achieve this (the simplest being that
mmap(task_local_map_fd, ...) maps current thread's part of BPF task
local storage). You won't get automatic cloning (you'd have to do that
from the BPF program on fork/exec tracepoint, for example), and within
the process you'd probably want to have just one thread (main?) to
mmap() initially and just share the pointer across all relevant
threads. But this is a more generic building block, IMO. This relying
on BPF map also means pinning is possible and all the other BPF map
abstraction benefits.


>
> bpf_probe_write_user() can, but safety is not built in, along with
> getting fork + exec right is brittle.
>
> > > To achieve better safety, introduce tagged user writable regions, tha=
t
> > > must explicitly be registered before tracing BPF programs may use the=
m:
> > >
> > >  1. The prctl() option PR_BPF_REGISTER_WRITABLE allows any user space
> > >     process (that is allowed to use prctl()) to register tagged writa=
ble
> > >     memory regions for the current thread.
> > >
> > >  2. Conversely, the prctl() option PR_BPF_UNREGISTER_WRITABLE allows =
a
> > >     user space process to unregister a writable memory region that wa=
s
> > >     previously registered from the current thread. This must be done
> > >     before freeing memory if the thread that registered a region is
> > >     still running.
> > >
> > >  3. Tracing BPF programs may write to any registered region in the
> > >     current thread with bpf_probe_write_user_registered(). If the mem=
ory
> > >     region has been tagged with a non-zero value, the BPF program mus=
t
> > >     provide a matching tag.
> > >
> > > Admin capabilities are still required to attach BPF programs that use
> > > the new bpf_probe_write_user_registered() helper.
> >
> > We stopped adding new helpers ~2 years ago.
> > Only new kfuncs are allowed.
>
> Sure.
>
> > >
> > > With this interface, user space threads are guaranteed that no writes
> > > happen to regions that they did not explicitly register. Tagging can =
be
> > > used to associate additional semantics with the memory region.
> > >
> > > A note on tag allocation: Since such programs can only be installed b=
y
> > > the local system administrator, tag allocation may be done by the sys=
tem
> > > administrator. For example, by providing headers with tag definitions=
,
> > > or a central service to distribute tags to the BPF program loader and=
 to
> > > user applications.
> >
> > Not clear how that's achieved in practice.
> > To do prctl(REGSISTER, ... tag)
> > the process will just pass this u32 tag.
> > There is no way for the admin or other process to enforce certain
> > tag usage.
> > Since there is no way to enforce extra tag seems like a weak
> > protection against something? What in particular?
>
> The main goal is to a) avoid accidental writes into areas the user
> space program doesn't want writing to, along with 2) weakly
> associating "type" via a tag. As soon as the user space program does
> prctl(REGISTER, tag) it wants writes to happen. It's the user space
> program's fault if it uses random tags, because in practice, we know
> exactly which BPF programs are running in production and which tags
> they service. The programs we do _care_ about are reviewed and do use
> the right tags. The mechanism is not for protecting BPF programs or
> what data they communicate, but for the benefit of the user space
> program itself to bound the memory that could be touched in its own
> address space (use the wrong region/tag .. tough luck).

