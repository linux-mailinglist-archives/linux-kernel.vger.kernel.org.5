Return-Path: <linux-kernel+bounces-91073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB68F870938
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF08EB27A18
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896D56216C;
	Mon,  4 Mar 2024 18:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrOUBbJ9"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A21061689;
	Mon,  4 Mar 2024 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709575948; cv=none; b=Qv9P+1IESWTIzoESUUu3N+b/t146d6BD1nhD50MYkLm2EiDNFcEJH9jht4z6cgmYlIynQCTRjo9QifZ5ltZpZo/mmdL4tu7IQOg9SWTRjFO5MuKUx0CxTcAmTiXxQ8HGr8cpev5lnyOT1dN6loBJtfIqom58uf8zd/H8d7SZtT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709575948; c=relaxed/simple;
	bh=qeYlY2Z0mU54S66qPg2nUJeend2RtdaAizfdSPieXAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Aemdq8BKr9IkZsXyMlt0n6JsPHA0oglsHRlEmAxmnpJyQF2KedM4uu15ulO/835R8b4RKKEuylEEyg/I5rX8DfX5YsGLKaTHS5zVBqdcL+8MTlEYRpp53TuY2a40Y2zIwNYQvCm4lxgqFn57sh8yMrB3zbslP7I8VbyNhmA0NG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrOUBbJ9; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so4288086a12.1;
        Mon, 04 Mar 2024 10:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709575945; x=1710180745; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=uwRt3Nexw71wDlnI00M5EwbWOdRZcBxm4wPyc9Hkfck=;
        b=CrOUBbJ93nfN39/ebustOIq7cWIuiNjuKv1/POLcDvpJLjru50a4vjXFX7MOi6MQcN
         ydZjnbT8TeoTdTEpca3/ejykG7eni+db3QR0hUFwbYH/B5Eh0KlZ5Va8fMlbtBcYv3hi
         JIKekDtR4QYRu1LnzQwemeHjmdVR5b0yKrBYmRtOVNAK69aHg2bbF1js0gZicvzW1g0u
         WIFTbuHCjswCsC0UGPTJvkM3pPTXAODd0CdjT/vw+iuVBGWTRLVin7E9+EX3QOyEX3qL
         GhLnVCe6zKVja69HRhhWCcLNJ9g2kss6AD4diO2MT5ObV2/SGkXGbD3GS+H8VFLD7vto
         34WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709575945; x=1710180745;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uwRt3Nexw71wDlnI00M5EwbWOdRZcBxm4wPyc9Hkfck=;
        b=lwKUj8Jx6B1ThzrLObpyRNqbSnrk6KcvLwEBr0WXXG183+agRPWP6vT44CFFEsW1Hv
         2LEWlsOUIbYk10nI6kqBx/PRo8EGeun9/in3t28nQzZSMvti62KuYPFPqRe1yJ5NwqhU
         THt+bn2u59NXnta+AZualUcHRBrgp9kJ8vV5X+qToaNFVhykLe8d/G+Fzy8HSwTKzXvN
         TkcQNAz1dkmTAuXv1WHohOCoz2CgTeTJ518A1JDmVRnSLPgTMsw6f6Er+E2X4XusKgmP
         i0841Z63FP/7xfpUho0oyD5UK4qPyUy3gROdYCqBGMdo4S3d1nskPQAMZp7AtvJGgQgT
         2p7g==
X-Forwarded-Encrypted: i=1; AJvYcCVfloUQ4ORzCJDzDw93HK7RHa+7qOtyupV/l7p8wVfBu1RrPJMDrNjDOA1uyCHmGDx1Qtu2gnCHj1UReoNftiSKx6DoCdVAcXOnOGr+WBs0yCqvz45emHilAIoUEcLo/XL4h0TCGPDXqx8oj0HuuQ==
X-Gm-Message-State: AOJu0YyCDcJBN5oC7X8E1N0NcpdlBGrhu4dcHVoixhc2UhC5PlXGqHLK
	N+RDMKPjvDITWuIRcQKPh7mGg/fkXoUXmvxmmik9IpGwxOpomb5p
X-Google-Smtp-Source: AGHT+IFvjp2BDXPhLFljlarbH+iAAyjlCmFOsZ58WnJZzNiDqV8eNDS4TU0Ho2QFed6o7GIsPsk0vw==
X-Received: by 2002:a17:902:dad2:b0:1db:2ad9:9393 with SMTP id q18-20020a170902dad200b001db2ad99393mr14373996plx.48.1709575944963;
        Mon, 04 Mar 2024 10:12:24 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id mm6-20020a1709030a0600b001db67377e8dsm8819321plb.248.2024.03.04.10.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 10:12:24 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 4 Mar 2024 10:12:23 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: hw_breakpoint unit test failures with various
 architectures/platforms in qemu
Message-ID: <f477329e-4ecf-4c6c-82b1-1e9b84443902@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I see a number of failures and tracebacks when running the hw_breakpoint
unit tests on various architectures in qemu. Some examples are below.

Is this a potential problem with the unit tests, with the hardware,
or with the qemu emulation of that hardware ?

In other words, is it worthwhile to look into this further, or would
it make more sense to just disable those tests if they fail on a
given hardware/platform ?

Thanks,
Guenter

---
arm:smdkc210:

[    9.515572]     ok 2 test_many_cpus
[    9.519425] ########### searching unregister_test_bp
[    9.519989] ------------[ cut here ]------------
[    9.520995] ########### searching test_one_task_on_all_cpus
[    9.521318] WARNING: CPU: 1 PID: 63 at kernel/events/hw_breakpoint_test.c:49 test_one_task_on_all_cpus+0x90/0x1c4
[    9.521921] Modules linked in:
[    9.522532] CPU: 1 PID: 63 Comm: kunit_try_catch Tainted: G                 N 6.8.0-rc7-00028-g624465c9abd6 #1
[    9.523102] Hardware name: Samsung Exynos (Flattened Device Tree)
[    9.523610]  unwind_backtrace from show_stack+0x10/0x14
[    9.523936]  show_stack from dump_stack_lvl+0x68/0x90
[    9.524191]  dump_stack_lvl from __warn+0xbc/0x21c
[    9.524429]  __warn from warn_slowpath_fmt+0x1a8/0x1b0
[    9.524674]  warn_slowpath_fmt from test_one_task_on_all_cpus+0x90/0x1c4
[    9.524971]  test_one_task_on_all_cpus from kunit_try_run_case+0x58/0x18c
[    9.525273]  kunit_try_run_case from kunit_generic_run_threadfn_adapter+0x14/0x20
[    9.525593]  kunit_generic_run_threadfn_adapter from kthread+0x118/0x124
[    9.525889]  kthread from ret_from_fork+0x14/0x28
[    9.526200] Exception stack(0xf0ad5fb0 to 0xf0ad5ff8)
[    9.526663] 5fa0:                                     00000000 00000000 00000000 00000000
[    9.527112] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    9.527449] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    9.527876] irq event stamp: 113
[    9.528088] hardirqs last  enabled at (121): [<c01adfb4>] console_unlock+0x114/0x130
[    9.529049] hardirqs last disabled at (140): [<c01adfa0>] console_unlock+0x100/0x130
[    9.529501] softirqs last  enabled at (138): [<c010168c>] __do_softirq+0x340/0x520
[    9.529892] softirqs last disabled at (129): [<c012f23c>] irq_exit+0x190/0x1c0
[    9.530227] ---[ end trace 0000000000000000 ]---
[    9.531752]     # test_one_task_on_all_cpus: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
[    9.531752]     Expected IS_ERR(bp) to be false, but is true
[    9.537757]     not ok 3 test_one_task_on_all_cpus

---
arm:raspi2b (and others):

[   14.718608]     # Subtest: hw_breakpoint
[   14.719351]     # module: hw_breakpoint_test
[   14.722275]     1..9
[   14.737927]     # test_one_cpu: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
[   14.737927]     Expected IS_ERR(bp) to be false, but is true
[   14.745960]     not ok 1 test_one_cpu
[   14.750052]     # test_many_cpus: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
[   14.750052]     Expected IS_ERR(bp) to be false, but is true
[   14.791453]     not ok 2 test_many_cpus
[   14.805964]     # test_one_task_on_all_cpus: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
[   14.805964]     Expected IS_ERR(bp) to be false, but is true
[   14.822662]     not ok 3 test_one_task_on_all_cpus
[   14.836897]     # test_two_tasks_on_all_cpus: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
[   14.836897]     Expected IS_ERR(bp) to be false, but is true
[   14.869770]     not ok 4 test_two_tasks_on_all_cpus
[   14.913412]     # test_one_task_on_one_cpu: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
[   14.913412]     Expected IS_ERR(bp) to be false, but is true
[   14.929852]     not ok 5 test_one_task_on_one_cpu
[   14.939676]     # test_one_task_mixed: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
[   14.939676]     Expected IS_ERR(bp) to be false, but is true
[   14.953670]     not ok 6 test_one_task_mixed
[   14.964403]     # test_two_tasks_on_one_cpu: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
[   14.964403]     Expected IS_ERR(bp) to be false, but is true
[   14.997262]     not ok 7 test_two_tasks_on_one_cpu
[   15.012825]     # test_two_tasks_on_one_all_cpus: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
[   15.012825]     Expected IS_ERR(bp) to be false, but is true
[   15.045472]     not ok 8 test_two_tasks_on_one_all_cpus
[   15.070033]     # test_task_on_all_and_one_cpu: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
[   15.070033]     Expected IS_ERR(bp) to be false, but is true
[   15.077092]     not ok 9 test_task_on_all_and_one_cpu

---
arm64:virt:

[    7.753199]     ok 2 test_many_cpus
[    7.766356]     # test_one_task_on_all_cpus: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
[    7.766356]     Expected IS_ERR(bp) to be false, but is true
[    7.775897]     not ok 3 test_one_task_on_all_cpus
[    7.786604]     # test_two_tasks_on_all_cpus: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
[    7.786604]     Expected IS_ERR(bp) to be false, but is true
[    7.793878]     not ok 4 test_two_tasks_on_all_cpus
[    7.799954]     # test_one_task_on_one_cpu: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
[    7.799954]     Expected IS_ERR(bp) to be false, but is true
[    7.811446]     not ok 5 test_one_task_on_one_cpu
[    7.823706]     # test_one_task_mixed: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
[    7.823706]     Expected IS_ERR(bp) to be false, but is true
[    7.838892]     not ok 6 test_one_task_mixed
[    7.843594]     # test_two_tasks_on_one_cpu: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
[    7.843594]     Expected IS_ERR(bp) to be false, but is true
[    7.862087]     not ok 7 test_two_tasks_on_one_cpu
[    7.869706]     # test_two_tasks_on_one_all_cpus: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
[    7.869706]     Expected IS_ERR(bp) to be false, but is true
[    7.874499]     not ok 8 test_two_tasks_on_one_all_cpus
[    7.878321]     # test_task_on_all_and_one_cpu: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
[    7.878321]     Expected IS_ERR(bp) to be false, but is true
[    7.894138]     not ok 9 test_task_on_all_and_one_cpu
[    7.894501] # hw_breakpoint: pass:2 fail:7 skip:0 total:9
[    7.894911] # Totals: pass:2 fail:7 skip:0 total:9

---
loongarch:

[    7.327439]     ok 2 test_many_cpus
[    7.330144] ------------[ cut here ]------------
[    7.330849] WARNING: CPU: 1 PID: 87 at kernel/events/hw_breakpoint_test.c:49 test_one_task_on_all_cpus+0x204/0x210

