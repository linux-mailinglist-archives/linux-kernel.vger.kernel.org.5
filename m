Return-Path: <linux-kernel+bounces-91957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7E8871903
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F6EB1F2410D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C1655761;
	Tue,  5 Mar 2024 09:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rf7cJAhD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35E852F9A;
	Tue,  5 Mar 2024 09:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629567; cv=none; b=LeP4I7rUnM/GRUC2zY4d+t5jY7YtcQOSR6XDBPod9ybf7hHFRJCSEgmdUC5tg++Xj9o8Bh6ykOesf2JMAcyz53d7F5nl0w0JiqyHWF47KYKO+8QksO+j72VhZQYu1ERxt7wgfRbP0xDej4MBCi1PFU6gNDC7mGrzF/UkoDXPkco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629567; c=relaxed/simple;
	bh=YzV4B+Up6v+BrjYEAn1oYFeF+XNimEJyLgWYFag+kg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QdtKsQo9W5AwthmgsSFKuNA9DuwWclOAggv5s77cp1XlHEl/N+SM8iqFIIbBBpiiS3NAy0tKS7ESSMGMrzPvchgRqr24E8kB0FMGfadsVgDR0+QrDnA90W70Z8wLefNU/hGxXbEK2nIlXALnUbl6DFxui2hn/RbEgwOF3B1pmU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rf7cJAhD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA6EC43399;
	Tue,  5 Mar 2024 09:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709629566;
	bh=YzV4B+Up6v+BrjYEAn1oYFeF+XNimEJyLgWYFag+kg0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rf7cJAhDiGVJ3PvWeBfrFH70vWt4F4bKhCaZ4EFuWaduH1InHdtrNVED+Tx1idvIl
	 RBx5nJWC5+duOyMxAb/m2stRvdl7zj4c5vHhdrvShtOYtYojKXb3ufkMGTAzVZ78cR
	 Cpsfqp4EQQe8iobc939KDkKN1F1IkqI7EEahLql5K4xii6+uaHWLvxWTamUycrSl48
	 Kz5+hN8LO4jUXsEC59qK1TMZtcszcqcgivExwTb9eG6huW9Gebg+SildJoxu4xNZ5e
	 pu2YZHy0uSYmHtes7ldsnYokbIcNVkI47rtMC9FKjFgw11p4I+xCK/FwcuqLkrKfXl
	 DU0ttH87XXLNA==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5649c25369aso7622536a12.2;
        Tue, 05 Mar 2024 01:06:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWGT2WVDO+yW4h4JcLgI2di4F93WD/vlim4EqEz0XoFJz5mgMfoWsszdTSF2I3QQIbwBlnb21oa3KC2tiRV0jykjuJSMcDykcLWPPGPK6b0Qpt4jVEvlsttngR0qPz6MXBAQuCOtwCKaghV6zzyWQ==
X-Gm-Message-State: AOJu0YwrgyXMDG81711nw+9vDQFijc4+DGKhA/YUzlj9KeEVRqvi/58P
	uwrfS1QYhHqfqmJ60TZOrJSj1gBr6E1ddh5bV5hVn8vd1d/ZgoCw5G2FJ11pRxge7svB87Ap3lK
	Tfla7PoWK4HfmR5KbaNuMwVQJMq4=
X-Google-Smtp-Source: AGHT+IF5y655SF1UzLRsjTx9W5mW+QUjX8QIDiU5KBYSOletC+9OgP61ceg0UZp63i2DDNELlJrk0YDIHBk+nz2dF+g=
X-Received: by 2002:a17:906:40d0:b0:a44:9e7e:64c3 with SMTP id
 a16-20020a17090640d000b00a449e7e64c3mr8218278ejk.10.1709629564827; Tue, 05
 Mar 2024 01:06:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f477329e-4ecf-4c6c-82b1-1e9b84443902@roeck-us.net> <CANpmjNMZD7-HY9FNGKnWTzHJ+Kibf2++rHj=j+3UTFKZ+Hr+EQ@mail.gmail.com>
In-Reply-To: <CANpmjNMZD7-HY9FNGKnWTzHJ+Kibf2++rHj=j+3UTFKZ+Hr+EQ@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 5 Mar 2024 17:05:56 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4KoFLM1Kf-42CuWbkvRuHOJkBzkudWUNpAY0KMUBqUkA@mail.gmail.com>
Message-ID: <CAAhV-H4KoFLM1Kf-42CuWbkvRuHOJkBzkudWUNpAY0KMUBqUkA@mail.gmail.com>
Subject: Re: hw_breakpoint unit test failures with various architectures/platforms
 in qemu
To: Marco Elver <elver@google.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Peter Zijlstra <peterz@infradead.org>, 
	Dmitry Vyukov <dvyukov@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Marco,

On Tue, Mar 5, 2024 at 4:34=E2=80=AFAM Marco Elver <elver@google.com> wrote=
:
>
> On Mon, 4 Mar 2024 at 19:12, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Hi,
> >
> > I see a number of failures and tracebacks when running the hw_breakpoin=
t
> > unit tests on various architectures in qemu. Some examples are below.
> >
> > Is this a potential problem with the unit tests, with the hardware,
> > or with the qemu emulation of that hardware ?
>
> The test is testing the accounting logic (allocating/deallocating HW
> breakpoints), not actually using the breakpoints. That requires that
> the architecture reports the correct number of HW breakpoints
> available. It looks like it's not doing that.
>
> > In other words, is it worthwhile to look into this further, or would
> > it make more sense to just disable those tests if they fail on a
> > given hardware/platform ?
>
> It's an arch bug:
> https://lore.kernel.org/lkml/Ytl9L0Zn1PVuL1cB@FVFF77S0Q05N.cambridge.arm.=
com/
>
> Back then we decided to leave the test as-is, given it's reporting an
> actual issue. However, since then nothing has changed and the test
> continues to exist as a reminder the arch code needs fixing. I suspect
> none of us have the time to get to that soon, so we can either leave
> things as is, or skip the test on all the broken architectures.
>
> No idea what's going on with loongarch.
LoongArch's problem comes from QEMU, I have tested on real machine.

[    7.222500] KTAP version 1
[    7.226067] 1..1
[    7.228795]     KTAP version 1
[    7.232737]     # Subtest: hw_breakpoint
[    7.237512]     # module: hw_breakpoint_test
[    7.237520]     1..9
[    7.442899]     ok 1 test_one_cpu
[    7.443912]     ok 2 test_many_cpus
[    7.451298]     ok 3 test_one_task_on_all_cpus
[    7.456486]     ok 4 test_two_tasks_on_all_cpus
[    7.462291]     ok 5 test_one_task_on_one_cpu
[    7.468293]     ok 6 test_one_task_mixed
[    7.474405]     ok 7 test_two_tasks_on_one_cpu
[    7.479884]     ok 8 test_two_tasks_on_one_all_cpus
[    7.485699]     ok 9 test_task_on_all_and_one_cpu
[    7.491488] # hw_breakpoint: pass:9 fail:0 skip:0 total:9
[    7.496985] # Totals: pass:9 fail:0 skip:0 total:9
[    7.503179] ok 1 hw_breakpoint

Huacai

>
> Thanks,
> -- Marco
>
> > Thanks,
> > Guenter
> >
> > ---
> > arm:smdkc210:
> >
> > [    9.515572]     ok 2 test_many_cpus
> > [    9.519425] ########### searching unregister_test_bp
> > [    9.519989] ------------[ cut here ]------------
> > [    9.520995] ########### searching test_one_task_on_all_cpus
> > [    9.521318] WARNING: CPU: 1 PID: 63 at kernel/events/hw_breakpoint_t=
est.c:49 test_one_task_on_all_cpus+0x90/0x1c4
> > [    9.521921] Modules linked in:
> > [    9.522532] CPU: 1 PID: 63 Comm: kunit_try_catch Tainted: G         =
        N 6.8.0-rc7-00028-g624465c9abd6 #1
> > [    9.523102] Hardware name: Samsung Exynos (Flattened Device Tree)
> > [    9.523610]  unwind_backtrace from show_stack+0x10/0x14
> > [    9.523936]  show_stack from dump_stack_lvl+0x68/0x90
> > [    9.524191]  dump_stack_lvl from __warn+0xbc/0x21c
> > [    9.524429]  __warn from warn_slowpath_fmt+0x1a8/0x1b0
> > [    9.524674]  warn_slowpath_fmt from test_one_task_on_all_cpus+0x90/0=
x1c4
> > [    9.524971]  test_one_task_on_all_cpus from kunit_try_run_case+0x58/=
0x18c
> > [    9.525273]  kunit_try_run_case from kunit_generic_run_threadfn_adap=
ter+0x14/0x20
> > [    9.525593]  kunit_generic_run_threadfn_adapter from kthread+0x118/0=
x124
> > [    9.525889]  kthread from ret_from_fork+0x14/0x28
> > [    9.526200] Exception stack(0xf0ad5fb0 to 0xf0ad5ff8)
> > [    9.526663] 5fa0:                                     00000000 00000=
000 00000000 00000000
> > [    9.527112] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000=
000 00000000 00000000
> > [    9.527449] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000=
000
> > [    9.527876] irq event stamp: 113
> > [    9.528088] hardirqs last  enabled at (121): [<c01adfb4>] console_un=
lock+0x114/0x130
> > [    9.529049] hardirqs last disabled at (140): [<c01adfa0>] console_un=
lock+0x100/0x130
> > [    9.529501] softirqs last  enabled at (138): [<c010168c>] __do_softi=
rq+0x340/0x520
> > [    9.529892] softirqs last disabled at (129): [<c012f23c>] irq_exit+0=
x190/0x1c0
> > [    9.530227] ---[ end trace 0000000000000000 ]---
> > [    9.531752]     # test_one_task_on_all_cpus: ASSERTION FAILED at ker=
nel/events/hw_breakpoint_test.c:70
> > [    9.531752]     Expected IS_ERR(bp) to be false, but is true
> > [    9.537757]     not ok 3 test_one_task_on_all_cpus
> >
> > ---
> > arm:raspi2b (and others):
> >
> > [   14.718608]     # Subtest: hw_breakpoint
> > [   14.719351]     # module: hw_breakpoint_test
> > [   14.722275]     1..9
> > [   14.737927]     # test_one_cpu: ASSERTION FAILED at kernel/events/hw=
_breakpoint_test.c:70
> > [   14.737927]     Expected IS_ERR(bp) to be false, but is true
> > [   14.745960]     not ok 1 test_one_cpu
> > [   14.750052]     # test_many_cpus: ASSERTION FAILED at kernel/events/=
hw_breakpoint_test.c:70
> > [   14.750052]     Expected IS_ERR(bp) to be false, but is true
> > [   14.791453]     not ok 2 test_many_cpus
> > [   14.805964]     # test_one_task_on_all_cpus: ASSERTION FAILED at ker=
nel/events/hw_breakpoint_test.c:70
> > [   14.805964]     Expected IS_ERR(bp) to be false, but is true
> > [   14.822662]     not ok 3 test_one_task_on_all_cpus
> > [   14.836897]     # test_two_tasks_on_all_cpus: ASSERTION FAILED at ke=
rnel/events/hw_breakpoint_test.c:70
> > [   14.836897]     Expected IS_ERR(bp) to be false, but is true
> > [   14.869770]     not ok 4 test_two_tasks_on_all_cpus
> > [   14.913412]     # test_one_task_on_one_cpu: ASSERTION FAILED at kern=
el/events/hw_breakpoint_test.c:70
> > [   14.913412]     Expected IS_ERR(bp) to be false, but is true
> > [   14.929852]     not ok 5 test_one_task_on_one_cpu
> > [   14.939676]     # test_one_task_mixed: ASSERTION FAILED at kernel/ev=
ents/hw_breakpoint_test.c:70
> > [   14.939676]     Expected IS_ERR(bp) to be false, but is true
> > [   14.953670]     not ok 6 test_one_task_mixed
> > [   14.964403]     # test_two_tasks_on_one_cpu: ASSERTION FAILED at ker=
nel/events/hw_breakpoint_test.c:70
> > [   14.964403]     Expected IS_ERR(bp) to be false, but is true
> > [   14.997262]     not ok 7 test_two_tasks_on_one_cpu
> > [   15.012825]     # test_two_tasks_on_one_all_cpus: ASSERTION FAILED a=
t kernel/events/hw_breakpoint_test.c:70
> > [   15.012825]     Expected IS_ERR(bp) to be false, but is true
> > [   15.045472]     not ok 8 test_two_tasks_on_one_all_cpus
> > [   15.070033]     # test_task_on_all_and_one_cpu: ASSERTION FAILED at =
kernel/events/hw_breakpoint_test.c:70
> > [   15.070033]     Expected IS_ERR(bp) to be false, but is true
> > [   15.077092]     not ok 9 test_task_on_all_and_one_cpu
> >
> > ---
> > arm64:virt:
> >
> > [    7.753199]     ok 2 test_many_cpus
> > [    7.766356]     # test_one_task_on_all_cpus: ASSERTION FAILED at ker=
nel/events/hw_breakpoint_test.c:70
> > [    7.766356]     Expected IS_ERR(bp) to be false, but is true
> > [    7.775897]     not ok 3 test_one_task_on_all_cpus
> > [    7.786604]     # test_two_tasks_on_all_cpus: ASSERTION FAILED at ke=
rnel/events/hw_breakpoint_test.c:70
> > [    7.786604]     Expected IS_ERR(bp) to be false, but is true
> > [    7.793878]     not ok 4 test_two_tasks_on_all_cpus
> > [    7.799954]     # test_one_task_on_one_cpu: ASSERTION FAILED at kern=
el/events/hw_breakpoint_test.c:70
> > [    7.799954]     Expected IS_ERR(bp) to be false, but is true
> > [    7.811446]     not ok 5 test_one_task_on_one_cpu
> > [    7.823706]     # test_one_task_mixed: ASSERTION FAILED at kernel/ev=
ents/hw_breakpoint_test.c:70
> > [    7.823706]     Expected IS_ERR(bp) to be false, but is true
> > [    7.838892]     not ok 6 test_one_task_mixed
> > [    7.843594]     # test_two_tasks_on_one_cpu: ASSERTION FAILED at ker=
nel/events/hw_breakpoint_test.c:70
> > [    7.843594]     Expected IS_ERR(bp) to be false, but is true
> > [    7.862087]     not ok 7 test_two_tasks_on_one_cpu
> > [    7.869706]     # test_two_tasks_on_one_all_cpus: ASSERTION FAILED a=
t kernel/events/hw_breakpoint_test.c:70
> > [    7.869706]     Expected IS_ERR(bp) to be false, but is true
> > [    7.874499]     not ok 8 test_two_tasks_on_one_all_cpus
> > [    7.878321]     # test_task_on_all_and_one_cpu: ASSERTION FAILED at =
kernel/events/hw_breakpoint_test.c:70
> > [    7.878321]     Expected IS_ERR(bp) to be false, but is true
> > [    7.894138]     not ok 9 test_task_on_all_and_one_cpu
> > [    7.894501] # hw_breakpoint: pass:2 fail:7 skip:0 total:9
> > [    7.894911] # Totals: pass:2 fail:7 skip:0 total:9
> >
> > ---
> > loongarch:
> >
> > [    7.327439]     ok 2 test_many_cpus
> > [    7.330144] ------------[ cut here ]------------
> > [    7.330849] WARNING: CPU: 1 PID: 87 at kernel/events/hw_breakpoint_t=
est.c:49 test_one_task_on_all_cpus+0x204/0x210
>

