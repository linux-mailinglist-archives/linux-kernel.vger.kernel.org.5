Return-Path: <linux-kernel+bounces-125602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E49E89297D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 06:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB4FD283653
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 05:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B7E8F45;
	Sat, 30 Mar 2024 05:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GN4+msc8"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383B53D72;
	Sat, 30 Mar 2024 05:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711776381; cv=none; b=lGKNB8goLkr0inwPEFslt2Djv0Zr2KkSsWcD0meivrA/35jClBVwayGi8hS+ErW1reoPGW7X9Os8Zn+ogmy3vmznOZLPy6qPifOPxEyb/01DQt7op7so+8V1pY3WHkzzA77Q5DatowU36XH83eQfOT4G0mzH/UEqO0BwrxiXix4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711776381; c=relaxed/simple;
	bh=R4uEnCRlj88KzPLr6vgP7yZCgXZb47BMcR7LTW/2v1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j0dHt2TDuLUXN1notK1USiVC63Sh7Z2JjhDgDWFOp7Lh2zEwFByM+/Ngn9EQ6+gmG63IpUWf87xoi8JF4j8EZQRBhdWcdpDblAXXK1KL2sGUgKjiANctfO07YbClm3bWv8B/YTiRAmvcal+2BMafbrcyApC+QCUBejiL+MnGbh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GN4+msc8; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so1877684a12.0;
        Fri, 29 Mar 2024 22:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711776379; x=1712381179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yk/FPG0n7iLAV5RAWcv5+G81BG/7yzbReiD+PtHL5ic=;
        b=GN4+msc8x9NsrzZ0EePBPpPVaaMnHmO/eT9xaf5SMkvzl2EHYJACcI9A15zRdObN02
         +JvqlvFceux79ewNSK/oTibcw3uC1MbWe+qLMDdKufM5vzNd7BLsia6cWPAVdl4yHULB
         ebSBmu4VI5WH39ddqQ8FI5aY4oaGSlCZEPGT2MTONbx10v2riKCYRLJqxpYy39MgmPDf
         YP1FHI43WynAn9l7NIp+NfRe93tbaFW/dhkrV1q+jmJMcy7PI6ntYU+vBZrAs2bprkXB
         cdfoJSPdz74mRH/8tTCY3X37TcxTSR3askWIywgO22l0QHUbm135lgybnLmdxWe/q1BF
         FesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711776379; x=1712381179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yk/FPG0n7iLAV5RAWcv5+G81BG/7yzbReiD+PtHL5ic=;
        b=nLKihq8WZvhbeEopJkNQDnEa6yTdQaMtMhWeGoX+0KUMztzaLhYguRVZ2nMxcMJqwc
         zMlRWcxCCpS4SYVymSJ1b7hp6vH0gs7ZFRA3FzrD/l4aC6DOwEgL3surMG0JRf2VCXOZ
         qvwFgmx1kGzenjLExK3ukAGuxp+03ra80COflsDiXcB1rQRZ1chsePcQJwg5NU6/7VK4
         ln3jxj0EfIu7y9Pw+aqn2tk2MjtW+MTMqTaVQoAjeNfDxLBzBC/uXWi9PoVxAIBRwLJU
         R89a1fFSC3buPc5QgWaD15svMLvzn4dpCwxQrPTPoowiQB8CYmJJcTn38zZuUjt9nK++
         /c0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXw22613bTAqf+i4WKVeMfZyCMa0a2e1u3SpB+p1ORTm6NLxbcubpsNeKucAq2KVbytw9LE2DBFoQjIADajjQSmDoSRTFOTdBXjS5Z/ID1RESS2wK5gSq7M6hRO7HCzdJPZcHFIfXzR0QT33uajZb9tXl9osVq/Gbulyz3bsDp+DYsZYUayR7M63e75373VoUaSNUG31JG02MdBqukNj0z/Ft8aGQHfYg==
X-Gm-Message-State: AOJu0Ywzr2Z6OtyyH4tY2R4Iis9xgRXOuBJSwzq3+gckYn2PgolB2OeH
	CrPMhz7YMFjVO07nRUCGrqU3SOgM3VhLeDtACweBtB1PiUjVOzsE9SGhl61w49sRZ3qZbxzhzet
	LI+0vQnPYFdt4EzXavgwStSaddtA=
X-Google-Smtp-Source: AGHT+IH9CE6X+fmi88GhWTi6znpBejJSJOZ4Qj2oMCA3jj73V2Nhoa/54pooFgNkpqrrjo3i6x7xyO8JUlG+lyAX3LA=
X-Received: by 2002:a05:6a21:6d89:b0:1a3:6051:987b with SMTP id
 wl9-20020a056a216d8900b001a36051987bmr4228895pzb.43.1711776379347; Fri, 29
 Mar 2024 22:26:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321145736.2373846-1-jonathan.haslam@gmail.com>
 <20240325120323.ec3248d330b2755e73a6571e@kernel.org> <CAEf4BzZS_QCsSY0oGY_3pGveGfXKK_TkVURyNq=UQXVXSqi2Fw@mail.gmail.com>
 <20240327084245.a890ae12e579f0be1902ae4a@kernel.org> <54jakntmdyedadce7yrf6kljcjapbwyoqqt26dnllrqvs3pg7x@itra4a2ikgqw>
 <20240328091841.ce9cc613db375536de843cfb@kernel.org> <CAEf4BzYCJWXAzdV3q5ex+8hj5ZFCnu5CT=w8eDbZCGqm+CGYOQ@mail.gmail.com>
 <CAEf4BzbSvMa2+hdTifMKTsNiOL6X=P7eor4LpPKfHM=Y9-71fw@mail.gmail.com> <20240330093631.72273967ba818cb16aeb58b6@kernel.org>
In-Reply-To: <20240330093631.72273967ba818cb16aeb58b6@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 29 Mar 2024 22:26:07 -0700
Message-ID: <CAEf4BzZtu_f39OF35M7-cY+Ua2CaRGtATgnzWO9_r3csStK=TQ@mail.gmail.com>
Subject: Re: [PATCH] uprobes: reduce contention on uprobes_tree access
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonthan Haslam <jonathan.haslam@gmail.com>, linux-trace-kernel@vger.kernel.org, 
	andrii@kernel.org, bpf@vger.kernel.org, rostedt@goodmis.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 5:36=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Fri, 29 Mar 2024 10:33:57 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > On Wed, Mar 27, 2024 at 5:45=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Mar 27, 2024 at 5:18=E2=80=AFPM Masami Hiramatsu <mhiramat@ke=
rnel.org> wrote:
> > > >
> > > > On Wed, 27 Mar 2024 17:06:01 +0000
> > > > Jonthan Haslam <jonathan.haslam@gmail.com> wrote:
> > > >
> > > > > > > Masami,
> > > > > > >
> > > > > > > Given the discussion around per-cpu rw semaphore and need for
> > > > > > > (internal) batched attachment API for uprobes, do you think y=
ou can
> > > > > > > apply this patch as is for now? We can then gain initial impr=
ovements
> > > > > > > in scalability that are also easy to backport, and Jonathan w=
ill work
> > > > > > > on a more complete solution based on per-cpu RW semaphore, as
> > > > > > > suggested by Ingo.
> > > > > >
> > > > > > Yeah, it is interesting to use per-cpu rw semaphore on uprobe.
> > > > > > I would like to wait for the next version.
> > > > >
> > > > > My initial tests show a nice improvement on the over RW spinlocks=
 but
> > > > > significant regression in acquiring a write lock. I've got a few =
days
> > > > > vacation over Easter but I'll aim to get some more formalised res=
ults out
> > > > > to the thread toward the end of next week.
> > > >
> > > > As far as the write lock is only on the cold path, I think you can =
choose
> > > > per-cpu RW semaphore. Since it does not do busy wait, the total sys=
tem
> > > > performance impact will be small.
> > >
> > > No, Masami, unfortunately it's not as simple. In BPF we have BPF
> > > multi-uprobe, which can be used to attach to thousands of user
> > > functions. It currently creates one uprobe at a time, as we don't
> > > really have a batched API. If each such uprobe registration will now
> > > take a (relatively) long time, when multiplied by number of attach-to
> > > user functions, it will be a horrible regression in terms of
> > > attachment/detachment performance.
>
> Ah, got it. So attachment/detachment performance should be counted.
>
> > >
> > > So when we switch to per-CPU rw semaphore, we'll need to provide an
> > > internal batch uprobe attach/detach API to make sure that attaching t=
o
> > > multiple uprobes is still fast.
>
> Yeah, we need such interface like register_uprobes(...).
>
> > >
> > > Which is why I was asking to land this patch as is, as it relieves th=
e
> > > scalability pains in production and is easy to backport to old
> > > kernels. And then we can work on batched APIs and switch to per-CPU r=
w
> > > semaphore.
>
> OK, then I'll push this to for-next at this moment.

Great, thanks a lot!

> Please share if you have a good idea for the batch interface which can be
> backported. I guess it should involve updating userspace changes too.
>

Yep, we'll investigate a best way to provide batch interface for
uprobes and will send patches.

> Thank you!
>
> > >
> > > So I hope you can reconsider and accept improvements in this patch,
> > > while Jonathan will keep working on even better final solution.
> > > Thanks!
> > >
> > > > I look forward to your formalized results :)
> > > >
> >
> > BTW, as part of BPF selftests, we have a multi-attach test for uprobes
> > and USDTs, reporting attach/detach timings:
> > $ sudo ./test_progs -v -t uprobe_multi_test/bench
> > bpf_testmod.ko is already unloaded.
> > Loading bpf_testmod.ko...
> > Successfully loaded bpf_testmod.ko.
> > test_bench_attach_uprobe:PASS:uprobe_multi_bench__open_and_load 0 nsec
> > test_bench_attach_uprobe:PASS:uprobe_multi_bench__attach 0 nsec
> > test_bench_attach_uprobe:PASS:uprobes_count 0 nsec
> > test_bench_attach_uprobe: attached in   0.120s
> > test_bench_attach_uprobe: detached in   0.092s
> > #400/5   uprobe_multi_test/bench_uprobe:OK
> > test_bench_attach_usdt:PASS:uprobe_multi__open 0 nsec
> > test_bench_attach_usdt:PASS:bpf_program__attach_usdt 0 nsec
> > test_bench_attach_usdt:PASS:usdt_count 0 nsec
> > test_bench_attach_usdt: attached in   0.124s
> > test_bench_attach_usdt: detached in   0.064s
> > #400/6   uprobe_multi_test/bench_usdt:OK
> > #400     uprobe_multi_test:OK
> > Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
> > Successfully unloaded bpf_testmod.ko.
> >
> > So it should be easy for Jonathan to validate his changes with this.
> >
> > > > Thank you,
> > > >
> > > > >
> > > > > Jon.
> > > > >
> > > > > >
> > > > > > Thank you,
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > BTW, how did you measure the overhead? I think spinlock ove=
rhead
> > > > > > > > will depend on how much lock contention happens.
> > > > > > > >
> > > > > > > > Thank you,
> > > > > > > >
> > > > > > > > >
> > > > > > > > > [0] https://docs.kernel.org/locking/spinlocks.html
> > > > > > > > >
> > > > > > > > > Signed-off-by: Jonathan Haslam <jonathan.haslam@gmail.com=
>
> > > > > > > > > ---
> > > > > > > > >  kernel/events/uprobes.c | 22 +++++++++++-----------
> > > > > > > > >  1 file changed, 11 insertions(+), 11 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/kernel/events/uprobes.c b/kernel/events/upro=
bes.c
> > > > > > > > > index 929e98c62965..42bf9b6e8bc0 100644
> > > > > > > > > --- a/kernel/events/uprobes.c
> > > > > > > > > +++ b/kernel/events/uprobes.c
> > > > > > > > > @@ -39,7 +39,7 @@ static struct rb_root uprobes_tree =3D =
RB_ROOT;
> > > > > > > > >   */
> > > > > > > > >  #define no_uprobe_events()   RB_EMPTY_ROOT(&uprobes_tree=
)
> > > > > > > > >
> > > > > > > > > -static DEFINE_SPINLOCK(uprobes_treelock);    /* serializ=
e rbtree access */
> > > > > > > > > +static DEFINE_RWLOCK(uprobes_treelock);      /* serializ=
e rbtree access */
> > > > > > > > >
> > > > > > > > >  #define UPROBES_HASH_SZ      13
> > > > > > > > >  /* serialize uprobe->pending_list */
> > > > > > > > > @@ -669,9 +669,9 @@ static struct uprobe *find_uprobe(str=
uct inode *inode, loff_t offset)
> > > > > > > > >  {
> > > > > > > > >       struct uprobe *uprobe;
> > > > > > > > >
> > > > > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > > > > +     read_lock(&uprobes_treelock);
> > > > > > > > >       uprobe =3D __find_uprobe(inode, offset);
> > > > > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > > > > +     read_unlock(&uprobes_treelock);
> > > > > > > > >
> > > > > > > > >       return uprobe;
> > > > > > > > >  }
> > > > > > > > > @@ -701,9 +701,9 @@ static struct uprobe *insert_uprobe(s=
truct uprobe *uprobe)
> > > > > > > > >  {
> > > > > > > > >       struct uprobe *u;
> > > > > > > > >
> > > > > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > > > > +     write_lock(&uprobes_treelock);
> > > > > > > > >       u =3D __insert_uprobe(uprobe);
> > > > > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > > > > +     write_unlock(&uprobes_treelock);
> > > > > > > > >
> > > > > > > > >       return u;
> > > > > > > > >  }
> > > > > > > > > @@ -935,9 +935,9 @@ static void delete_uprobe(struct upro=
be *uprobe)
> > > > > > > > >       if (WARN_ON(!uprobe_is_active(uprobe)))
> > > > > > > > >               return;
> > > > > > > > >
> > > > > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > > > > +     write_lock(&uprobes_treelock);
> > > > > > > > >       rb_erase(&uprobe->rb_node, &uprobes_tree);
> > > > > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > > > > +     write_unlock(&uprobes_treelock);
> > > > > > > > >       RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_a=
ctive() */
> > > > > > > > >       put_uprobe(uprobe);
> > > > > > > > >  }
> > > > > > > > > @@ -1298,7 +1298,7 @@ static void build_probe_list(struct=
 inode *inode,
> > > > > > > > >       min =3D vaddr_to_offset(vma, start);
> > > > > > > > >       max =3D min + (end - start) - 1;
> > > > > > > > >
> > > > > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > > > > +     read_lock(&uprobes_treelock);
> > > > > > > > >       n =3D find_node_in_range(inode, min, max);
> > > > > > > > >       if (n) {
> > > > > > > > >               for (t =3D n; t; t =3D rb_prev(t)) {
> > > > > > > > > @@ -1316,7 +1316,7 @@ static void build_probe_list(struct=
 inode *inode,
> > > > > > > > >                       get_uprobe(u);
> > > > > > > > >               }
> > > > > > > > >       }
> > > > > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > > > > +     read_unlock(&uprobes_treelock);
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > >  /* @vma contains reference counter, not the probed instr=
uction. */
> > > > > > > > > @@ -1407,9 +1407,9 @@ vma_has_uprobes(struct vm_area_stru=
ct *vma, unsigned long start, unsigned long e
> > > > > > > > >       min =3D vaddr_to_offset(vma, start);
> > > > > > > > >       max =3D min + (end - start) - 1;
> > > > > > > > >
> > > > > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > > > > +     read_lock(&uprobes_treelock);
> > > > > > > > >       n =3D find_node_in_range(inode, min, max);
> > > > > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > > > > +     read_unlock(&uprobes_treelock);
> > > > > > > > >
> > > > > > > > >       return !!n;
> > > > > > > > >  }
> > > > > > > > > --
> > > > > > > > > 2.43.0
> > > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > >
> > > >
> > > > --
> > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

