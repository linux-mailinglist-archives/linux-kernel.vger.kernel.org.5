Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDADA7BBD34
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbjJFQru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbjJFQri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:47:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3D91A2;
        Fri,  6 Oct 2023 09:47:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C76C433C7;
        Fri,  6 Oct 2023 16:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696610853;
        bh=JLObAK4u+o/GPUHb3r4lwMVq0fFGrX+4xDzQeYHKrxM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=V7y74gIe11uWg//mGvyxu4087WTTxdxa42Pe7zFr4eSI5VbCa7hLb6fiIGZBvS2gY
         6nOom2Kj7+DC+iqQbhdTweH81PbEaTcAp/EauuX3BNkLfYREBxTkICQDlQC/cHozTn
         t6EinhQ1SsiOh3WK/Q2Zs9qOujg9cWQN6fuXBh+ggRQYojEuEMaKfygmi33/AO1opF
         n8apdgogCQvBqiilbVUWX/lMIemMy0vHXSIRFDas44fi7mFumrT9ja1xOIma7HcwTP
         Mkf9DIYCexQsGIRyb4pcDmjinUcjvzunnnWdVS8QH2nnndDD7ZIrTvlHN0htJB5Snw
         aN08QFm4TiZ5Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EC9CDCE0976; Fri,  6 Oct 2023 09:47:32 -0700 (PDT)
Date:   Fri, 6 Oct 2023 09:47:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Chengming Zhou <zhouchengming@bytedance.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ovidiu Panait <ovidiu.panait@windriver.com>,
        Ingo Molnar <mingo@kernel.org>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 5.15 000/183] 5.15.134-rc1 review
Message-ID: <57c1ff4d-f138-4f89-8add-c96fb3ba6701@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231004175203.943277832@linuxfoundation.org>
 <CA+G9fYunnEUT2evdabX1KOTiryP1heNHWDH4LWZCt2SVRmnKOA@mail.gmail.com>
 <20231006162038.d3q7sl34b4ouvjxf@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231006162038.d3q7sl34b4ouvjxf@revolver>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 12:20:38PM -0400, Liam R. Howlett wrote:
> * Naresh Kamboju <naresh.kamboju@linaro.org> [231005 13:49]:
> > On Wed, 4 Oct 2023 at 23:33, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 5.15.134 release.
> > > There are 183 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.134-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> > 
> > Results from Linaro’s test farm.
> > Regressions on x86.
> > 
> > Following kernel warning noticed on x86 while booting stable-rc 5.15.134-rc1
> > with selftest merge config built kernel.
> > 
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > 
> > Anyone noticed this kernel warning ?
> > 
> > This is always reproducible while booting x86 with a given config.
> 
> >From that config:
> #
> # RCU Subsystem
> #
> CONFIG_TREE_RCU=y
> # CONFIG_RCU_EXPERT is not set
> CONFIG_SRCU=y
> CONFIG_TREE_SRCU=y
> CONFIG_TASKS_RCU_GENERIC=y
> CONFIG_TASKS_RUDE_RCU=y
> CONFIG_TASKS_TRACE_RCU=y
> CONFIG_RCU_STALL_COMMON=y
> CONFIG_RCU_NEED_SEGCBLIST=y
> # end of RCU Subsystem    
> 
> #
> # RCU Debugging
> #
> CONFIG_PROVE_RCU=y
> # CONFIG_RCU_SCALE_TEST is not set
> # CONFIG_RCU_TORTURE_TEST is not set
> # CONFIG_RCU_REF_SCALE_TEST is not set
> CONFIG_RCU_CPU_STALL_TIMEOUT=21
> CONFIG_RCU_TRACE=y
> # CONFIG_RCU_EQS_DEBUG is not set
> # end of RCU Debugging
> 
> 
> > 
> > x86 boot log:
> > -----
> > [    0.000000] Linux version 5.15.134-rc1 (tuxmake@tuxmake)
> > (x86_64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils
> > for Debian) 2.40) #1 SMP @1696443178
> > ...
> > [    1.480701] ------------[ cut here ]------------
> > [    1.481296] WARNING: CPU: 0 PID: 13 at kernel/rcu/tasks.h:958
> > trc_inspect_reader+0x80/0xb0
> > [    1.481296] Modules linked in:
> > [    1.481296] CPU: 0 PID: 13 Comm: rcu_tasks_trace Not tainted 5.15.134-rc1 #1
> > [    1.481296] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> > 2.5 11/26/2020
> > [    1.481296] RIP: 0010:trc_inspect_reader+0x80/0xb0
> 
> This function has changed a lot, including the dropping of this
> WARN_ON_ONCE().  The warning was replaced in 897ba84dc5aa ("rcu-tasks:
> Handle idle tasks for recently offlined CPUs") with something that looks
> equivalent so I'm not sure why it would not trigger in newer revisions.
> 
> Obviously the behaviour I changed was the test for the task being idle.
> I am not sure how best to short-circuit that test from happening during
> boot as I am not familiar with the RCU code.

The usual test for RCU's notion of early boot being completed is
(rcu_scheduler_active != RCU_SCHEDULER_INIT).

Except that "ofl" should always be false that early in boot, at least
in mainline.

> It's also worth noting that the bug this fixes wasn't exposed until the
> maple tree (added in v6.1) was used for the IRQ descriptors (added in
> v6.5).

Lots of latent bugs, to be sure, even with rcutorture.  :-/

							Thanx, Paul

> > [    1.481296] Code: b6 83 45 04 00 00 84 c0 75 48 c6 83 45 04 00 00
> > 01 b8 01 00 00 00 5b 41 5c 5d c3 cc cc cc cc 0f 94 c0 eb b4 f6 43 2c
> > 02 75 02 <0f> 0b 48 83 05 36 f8 ee 02 01 b8 01 00 00 00 48 83 05 21 f8
> > ee 02
> > [    1.481296] RSP: 0000:ffffb25e000afd70 EFLAGS: 00010046
> > [    1.481296] RAX: 0000000000000000 RBX: ffff9b40c080d040 RCX: 0000000000000003
> > [    1.481296] RDX: ffff9b4427b80000 RSI: 0000000000000000 RDI: ffff9b40c080d040
> > [    1.481296] RBP: ffffb25e000afd80 R08: e32db91cdfdc3bef R09: 00000000035b89d4
> > [    1.481296] R10: 000000006a495065 R11: 0000000000000030 R12: ffffffffae692100
> > [    1.481296] R13: 0000000000000000 R14: ffff9b40c080d9a8 R15: 0000000000000000
> > [    1.481296] FS:  0000000000000000(0000) GS:ffff9b4427a00000(0000)
> > knlGS:0000000000000000
> > [    1.481296] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    1.481296] CR2: ffff9b4297201000 CR3: 00000002d5e26001 CR4: 00000000003706f0
> > [    1.481296] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [    1.481296] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [    1.481296] Call Trace:
> > [    1.481296]  <TASK>
> > [    1.481296]  ? show_regs.cold+0x1a/0x1f
> > [    1.481296]  ? __warn+0x88/0x120
> > [    1.481296]  ? trc_inspect_reader+0x80/0xb0
> > [    1.481296]  ? report_bug+0xa8/0xd0
> > [    1.481296]  ? handle_bug+0x40/0x70
> > [    1.481296]  ? exc_invalid_op+0x18/0x70
> > [    1.481296]  ? asm_exc_invalid_op+0x1b/0x20
> > [    1.481296]  ? rcu_tasks_kthread+0x250/0x250
> > [    1.481296]  ? trc_inspect_reader+0x80/0xb0
> > [    1.481296]  ? rcu_tasks_kthread+0x250/0x250
> > [    1.481296]  try_invoke_on_locked_down_task+0x109/0x120
> > [    1.481296]  trc_wait_for_one_reader.part.0+0x48/0x270
> > [    1.481296]  rcu_tasks_trace_postscan+0x76/0xb0
> > [    1.481296]  rcu_tasks_wait_gp+0x186/0x380
> > [    1.481296]  ? _raw_spin_unlock_irqrestore+0x35/0x50
> > [    1.481296]  rcu_tasks_kthread+0x145/0x250
> > [    1.481296]  ? do_wait_intr_irq+0xc0/0xc0
> > [    1.481296]  ? synchronize_rcu_tasks_rude+0x20/0x20
> > [    1.481296]  kthread+0x146/0x170
> > [    1.481296]  ? set_kthread_struct+0x50/0x50
> > [    1.481296]  ret_from_fork+0x1f/0x30
> > [    1.481296]  </TASK>
> > [    1.481296] irq event stamp: 132
> > [    1.481296] hardirqs last  enabled at (131): [<ffffffffaf7936a5>]
> > _raw_spin_unlock_irqrestore+0x35/0x50
> > [    1.481296] hardirqs last disabled at (132): [<ffffffffaf79345b>]
> > _raw_spin_lock_irqsave+0x5b/0x60
> > [    1.481296] softirqs last  enabled at (54): [<ffffffffae69201c>]
> > rcu_tasks_kthread+0x16c/0x250
> > [    1.481296] softirqs last disabled at (50): [<ffffffffae69201c>]
> > rcu_tasks_kthread+0x16c/0x250
> > [    1.481296] ---[ end trace 5a00c61d8412a9ac ]---
> > 
> > 
> > Links:
> > ----
> >  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.133-184-g6f28ecf24aef/testrun/20260259/suite/log-parser-boot/test/check-kernel-exception/log
> >  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.133-184-g6f28ecf24aef/testrun/20260259/suite/log-parser-boot/tests/
> >  Build: https://storage.tuxsuite.com/public/linaro/lkft/builds/2WJFhcfqqG69pqj6LWuI14kVoP5/
> > 
> > steps to reproduce:
> > --------
> >  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2WJFhcfqqG69pqj6LWuI14kVoP5/tuxmake_reproducer.sh
> > 
> > ## Build
> > * kernel: 5.15.134-rc1
> > * git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
> > * git branch: linux-5.15.y
> > * git commit: 6f28ecf24aef2896f4071dc6268d3fb5f8259c77
> > * git describe: v5.15.133-184-g6f28ecf24aef
> > * test details:
> > https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.133-184-g6f28ecf24aef
> > 
> > ## Test Regressions (compared to v5.15.133)
> > * x86, log-parser-boot
> >   - check-kernel-exception
> >   - check-kernel-warning
> > 
> > * x86, log-parser-test
> >   - check-kernel-exception
> >   - check-kernel-warning
> > 
> > 
> > ## Metric Regressions (compared to v5.15.133)
> > 
> > ## Test Fixes (compared to v5.15.133)
> > 
> > ## Metric Fixes (compared to v5.15.133)
> > 
> > ## Test result summary
> > total: 90392, pass: 71514, fail: 2557, skip: 16224, xfail: 97
> > 
> > ## Build Summary
> > * arc: 4 total, 4 passed, 0 failed
> > * arm: 114 total, 114 passed, 0 failed
> > * arm64: 42 total, 42 passed, 0 failed
> > * i386: 32 total, 31 passed, 1 failed
> > * mips: 27 total, 26 passed, 1 failed
> > * parisc: 4 total, 4 passed, 0 failed
> > * powerpc: 26 total, 25 passed, 1 failed
> > * riscv: 11 total, 11 passed, 0 failed
> > * s390: 12 total, 11 passed, 1 failed
> > * sh: 13 total, 11 passed, 2 failed
> > * sparc: 8 total, 8 passed, 0 failed
> > * x86_64: 38 total, 38 passed, 0 failed
> > 
> > ## Test suites summary
> > * boot
> > * kselftest-android
> > * kselftest-arm64
> > * kselftest-breakpoints
> > * kselftest-capabilities
> > * kselftest-cgroup
> > * kselftest-clone3
> > * kselftest-core
> > * kselftest-cpu-hotplug
> > * kselftest-cpufreq
> > * kselftest-drivers-dma-buf
> > * kselftest-efivarfs
> > * kselftest-exec
> > * kselftest-filesystems
> > * kselftest-filesystems-binderfs
> > * kselftest-filesystems-epoll
> > * kselftest-firmware
> > * kselftest-fpu
> > * kselftest-ftrace
> > * kselftest-futex
> > * kselftest-gpio
> > * kselftest-intel_pstate
> > * kselftest-ipc
> > * kselftest-ir
> > * kselftest-kcmp
> > * kselftest-kexec
> > * kselftest-kvm
> > * kselftest-lib
> > * kselftest-membarrier
> > * kselftest-memfd
> > * kselftest-memory-hotplug
> > * kselftest-mincore
> > * kselftest-mount
> > * kselftest-mqueue
> > * kselftest-net
> > * kselftest-net-forwarding
> > * kselftest-net-mptcp
> > * kselftest-netfilter
> > * kselftest-nsfs
> > * kselftest-openat2
> > * kselftest-pid_namespace
> > * kselftest-pidfd
> > * kselftest-proc
> > * kselftest-pstore
> > * kselftest-ptrace
> > * kselftest-rseq
> > * kselftest-rtc
> > * kselftest-seccomp
> > * kselftest-sigaltstack
> > * kselftest-size
> > * kselftest-splice
> > * kselftest-static_keys
> > * kselftest-sync
> > * kselftest-sysctl
> > * kselftest-tc-testing
> > * kselftest-timens
> > * kselftest-tmpfs
> > * kselftest-tpm2
> > * kselftest-user
> > * kselftest-user_events
> > * kselftest-vDSO
> > * kselftest-vm
> > * kselftest-watchdog
> > * kselftest-x86
> > * kselftest-zram
> > * kunit
> > * kvm-unit-tests
> > * libgpiod
> > * log-parser-boot
> > * log-parser-test
> > * ltp-cap_bounds
> > * ltp-commands
> > * ltp-containers
> > * ltp-controllers
> > * ltp-cpuhotplug
> > * ltp-crypto
> > * ltp-cve
> > * ltp-dio
> > * ltp-fcntl-locktests
> > * ltp-filecaps
> > * ltp-fs
> > * ltp-fs_bind
> > * ltp-fs_perms_simple
> > * ltp-fsx
> > * ltp-hugetlb
> > * ltp-io
> > * ltp-ipc
> > * ltp-math
> > * ltp-mm
> > * ltp-nptl
> > * ltp-pty
> > * ltp-sched
> > * ltp-securebits
> > * ltp-smoke
> > * ltp-syscalls
> > * ltp-tracing
> > * network-basic-tests
> > * perf
> > * rcutorture
> > * v4l2-compliance
> > 
> > --
> > Linaro LKFT
> > https://lkft.linaro.org
