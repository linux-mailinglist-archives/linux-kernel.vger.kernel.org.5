Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3DE78C198
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjH2Jgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbjH2Jgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:36:41 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44369AB
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:36:36 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-44d58933a17so1409942137.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693301795; x=1693906595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w5xvrieLOK3LATrvtHI2uL1hu6MTeFqDcK1n5JFJjnA=;
        b=H0hYXg9yeLZdQu02NDa/D6uThJK0frIhcBNPDgg1QFSE3FRAbO4yY+KtIWyZcGXfKs
         yBj66ZNz1HcDNN28OZDYerOgN8Ip+ZSDiJQCVOaZoq0kFGMV8zyrz02RuFtITJOQk8ES
         dTVX48VZ3xVFVhFi6PFtD1PNmcr2l+4FEH1zmO1OQ5mPw8pKWYESYjPM8VtapKrkZ9s2
         5bT1lrT4ocUFJtUUGpdca/f0MKCLtHOSPK6FBe0m8CEuXhT1AxtxcuSYgi+L8iegR9C1
         dM/ECKLXlDQfl8sGIj1oadojIUu70wgFZ2pE9PQbn4gRPjR19Nya3/QlVekDPf/EDnu5
         UUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693301795; x=1693906595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w5xvrieLOK3LATrvtHI2uL1hu6MTeFqDcK1n5JFJjnA=;
        b=gzM6v1YGKuz7YojtTPdYJTuwn+i9Wd2yNlJblObBxHNygkHZ5BpV320RqA1KdpaDnn
         Bxswy84XayBWUHLCNNDSaTNnA/encRCV0EYW6n4LmrTsuRq5BQWgHS7uu6DbiYOH0Ttj
         qqAt73Ijn6AwCJ0Fc1p+n4EnlF1Qmoqfiu5hMN8Kmbn2ZmwFzksvguBKiFm4QyNHm4Te
         c+UObgtlRy1pG7KGrPIdaPUMPm99VhHfuFW/qW1FhZM2ELYw9hsFrk3V8UTtE1WPHS3k
         mGtdHwf9lXUQOv28hS1+3v2NT3/uFNF9/F2y6WARRyNOslxW1zBaN92zEzO4z6NKOirr
         uhaw==
X-Gm-Message-State: AOJu0Yyr+ggknuuU+AG73ZwxdpZFNE5XTRqDDOld7kg1DaY3yKEqg/9n
        u7CVM2Ij9124s8tsFmu/2+Pt+glmqrS3oPSg30/6xw==
X-Google-Smtp-Source: AGHT+IGCJJA+yJ49ZrBnmfmNj8YUx6qRjUI1QkTkROvhaeha/uhg8BAetbfyDlLXt5OH6wUeVxeL6BL61x34FNRqmA0=
X-Received: by 2002:a67:ec57:0:b0:443:6deb:2b4 with SMTP id
 z23-20020a67ec57000000b004436deb02b4mr24391706vso.2.1693301795239; Tue, 29
 Aug 2023 02:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230828101150.163430842@linuxfoundation.org>
In-Reply-To: <20230828101150.163430842@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 29 Aug 2023 15:06:24 +0530
Message-ID: <CA+G9fYv9xTu4bKJGy=e=KZSG5pZ+tJAmfZr=0dbuKNs=9OOKhA@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/89] 5.15.129-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, rcu <rcu@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 at 16:13, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.129 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.129-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


NOTE:
Following kernel deadlock / rcu warnings noticed while booting
on arm64 Rpi4 and db401 booting with kselftests merge configs builds.

Kernel is built with selftests/*/configs merge.

FYI,
After this kernel warning the system is stable and ran selftests and got passed.
Build and config details provided at the bottom of this email.

Boot log:
------
[    0.000000] Linux version 5.15.129-rc1 (tuxmake@tuxmake)
(aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils
for Debian) 2.40) #1 SMP PREEMPT @1693218307
[    0.000000] Machine model: Raspberry Pi 4 Model B
...
[   32.487474] platform regulatory.0: Direct firmware load for
regulatory.db failed with error -2
[   32.496495] platform regulatory.0: Falling back to sysfs fallback
for: regulatory.db
[   32.509253] [drm] Initialized vc4 0.0.0 20140616 for gpu on minor 0
[   32.513018]
[   32.513049]
[   32.513053] ======================================================
[   32.513056] WARNING: possible circular locking dependency detected
[   32.513060] 5.15.129-rc1 #1 Not tainted
[   32.513068] ------------------------------------------------------
[   32.513071] (udev-worker)/241 is trying to acquire lock:
[   32.513078] ffff80000aac6be0 ((console_sem).lock){..-.}-{2:2}, at:
down_trylock+0x20/0x50
[   32.513120]
[   32.513120] but task is already holding lock:
[   32.513122] ffff0000f77d41d8 (&rq->__lock){-.-.}-{2:2}, at:
task_rq_lock+0x94/0x1c4
[   32.513151]
[   32.513151] which lock already depends on the new lock.
[   32.513151]
[   32.513153]
[   32.513153] the existing dependency chain (in reverse order) is:
[   32.513156]
[   32.513156] -> #2 (&rq->__lock){-.-.}-{2:2}:
[   32.513170]        _raw_spin_lock_nested+0x74/0xb0
[   32.513188]        raw_spin_rq_lock_nested+0x48/0x160
[   32.513200]        task_fork_fair+0x44/0x180
[   32.513209]        sched_cgroup_fork+0xdc/0x140
[   32.513218]        copy_process+0xdb8/0x2054
[   32.513227]        kernel_clone+0xa4/0x47c
[   32.513234]        kernel_thread+0x74/0xa4
[   32.513241]        rest_init+0x3c/0x2e0
[   32.513254]        arch_call_rest_init+0x18/0x24
[   32.513266]        start_kernel+0x734/0x774
[   32.513275]        __primary_switched+0xbc/0xc4
[   32.513284]
[   32.513284] -> #1 (&p->pi_lock){-.-.}-{2:2}:
[   32.513299]        _raw_spin_lock_irqsave+0x84/0xec
[   32.513310]        try_to_wake_up+0x5c/0x640
[   32.513317]        wake_up_process+0x20/0x30
[   32.513324]        __up.isra.0+0x58/0x70
[   32.513333]        up+0x64/0x80
[   32.513342]        __up_console_sem+0x48/0x7c
[   32.513355]        console_unlock+0x21c/0x630
[   32.513367]        vprintk_emit+0x114/0x2e0
[   32.513379]        vprintk_default+0x40/0x50
[   32.513391]        vprintk+0xdc/0x100
[   32.513398]        _printk+0x64/0x8c
[   32.513410]        drm_master_internal_acquire+0x8/0x64 [drm]
[   32.513662]        devm_aperture_acquire_from_firmware+0x3c/0x1f0 [drm]
[   32.513891]        do_one_initcall+0x90/0x340
[   32.513902]        do_init_module+0x50/0x28c
[   32.513913]        load_module+0x2148/0x26f0
[   32.513922]        __do_sys_finit_module+0xa8/0x11c
[   32.513932]        __arm64_sys_finit_module+0x28/0x34
[   32.513941]        invoke_syscall+0x78/0x100
[   32.513954]        el0_svc_common.constprop.0+0x68/0x124
[   32.513967]        do_el0_svc+0x2c/0xa0
[   32.513978]        el0_svc+0x54/0x110
[   32.513990]        el0t_64_sync_handler+0xe8/0x114
[   32.514001]        el0t_64_sync+0x1a0/0x1a4
[   32.514009]
[   32.514009] -> #0 ((console_sem).lock){..-.}-{2:2}:
[   32.514022]        __lock_acquire+0x12f0/0x2090
[   32.514036]        lock_acquire+0x208/0x320
[   32.514048]        _raw_spin_lock_irqsave+0x84/0xec
[   32.514059]        down_trylock+0x20/0x50
[   32.514069]        __down_trylock_console_sem+0x44/0xc0
[   32.514082]        console_trylock+0x44/0x100
[   32.514094]        vprintk_emit+0x10c/0x2e0
[   32.514105]        vprintk_default+0x40/0x50
[   32.514117]        vprintk+0xdc/0x100
[   32.514124]        _printk+0x64/0x8c
[   32.514135]        lockdep_rcu_suspicious+0x34/0x10c
[   32.514146]        inc_dl_tasks_cs+0xc0/0xd0
[   32.514154]        switched_to_dl+0x38/0x2dc
[   32.514165]        __sched_setscheduler+0x228/0xaf0
[   32.514174]        sched_setattr_nocheck+0x20/0x30
[   32.514182]        sugov_init+0x140/0x370
[   32.514191]        cpufreq_init_governor+0x78/0x120
[   32.514203]        cpufreq_set_policy+0x290/0x430
[   32.514212]        cpufreq_online+0x3a0/0xa70
[   32.514221]        cpufreq_add_dev+0xd0/0xf0
[   32.514231]        subsys_interface_register+0x13c/0x164
[   32.514242]        cpufreq_register_driver+0x17c/0x2e0
[   32.514251]        dt_cpufreq_probe+0x350/0x4b4
[   32.514265]        platform_probe+0x70/0xe0
[   32.514277]        really_probe+0xcc/0x470
[   32.514286]        __driver_probe_device+0x114/0x170
[   32.514296]        driver_probe_device+0x48/0x140
[   32.514305]        __device_attach_driver+0xd8/0x180
[   32.514314]        bus_for_each_drv+0x84/0xe0
[   32.514322]        __device_attach+0xa4/0x1d0
[   32.514331]        device_initial_probe+0x1c/0x30
[   32.514341]        bus_probe_device+0xa4/0xb0
[   32.514350]        device_add+0x3e8/0x920
[   32.514357]        platform_device_add+0x108/0x290
[   32.514368]        platform_device_register_full+0xe4/0x17c
[   32.514381]        raspberrypi_cpufreq_probe+0x13c/0x1e0
[raspberrypi_cpufreq]
[   32.514397]        platform_probe+0x70/0xe0
[   32.514408]        really_probe+0xcc/0x470
[   32.514417]        __driver_probe_device+0x114/0x170
[   32.514427]        driver_probe_device+0x48/0x140
[   32.514436]        __driver_attach+0x12c/0x220
[   32.514445]        bus_for_each_dev+0x7c/0xdc
[   32.514453]        driver_attach+0x2c/0x40
[   32.514461]        bus_add_driver+0x168/0x274
[   32.514470]        driver_register+0x80/0x13c
[   32.514479]        __platform_driver_register+0x30/0x40
[   32.514490]        raspberrypi_cpufreq_driver_init+0x28/0x1000
[raspberrypi_cpufreq]
[   32.514506]        do_one_initcall+0x90/0x340
[   32.514514]        do_init_module+0x50/0x28c
[   32.514524]        load_module+0x2148/0x26f0
[   32.514533]        __do_sys_finit_module+0xa8/0x11c
[   32.514542]        __arm64_sys_finit_module+0x28/0x34
[   32.514551]        invoke_syscall+0x78/0x100
[   32.514563]        el0_svc_common.constprop.0+0x104/0x124
[   32.514575]        do_el0_svc+0x2c/0xa0
[   32.514586]        el0_svc+0x54/0x110
[   32.514596]        el0t_64_sync_handler+0xe8/0x114
[   32.514607]        el0t_64_sync+0x1a0/0x1a4
[   32.514615]
[   32.514615] other info that might help us debug this:
[   32.514615]
[   32.514618] Chain exists of:
[   32.514618]   (console_sem).lock --> &p->pi_lock --> &rq->__lock
[   32.514618]
[   32.514634]  Possible unsafe locking scenario:
[   32.514634]
[   32.514636]        CPU0                    CPU1
[   32.514638]        ----                    ----
[   32.514640]   lock(&rq->__lock);
[   32.514646]                                lock(&p->pi_lock);
[   32.514653]                                lock(&rq->__lock);
[   32.514659]   lock((console_sem).lock);
[   32.514665]
[   32.514665]  *** DEADLOCK ***
[   32.514665]
[   32.514667] 8 locks held by (udev-worker)/241:
[   32.514673]  #0: ffff0000438af188 (&dev->mutex){....}-{3:3}, at:
__driver_attach+0x120/0x220
[   32.514699]  #1: ffff0000438ab188 (&dev->mutex){....}-{3:3}, at:
__device_attach+0x40/0x1d0
[   32.514722]  #2: ffff80000aab0d68 (cpu_hotplug_lock){++++}-{0:0},
at: cpus_read_lock+0x18/0x24
[   32.514748]  #3: ffff0000409e4918 (subsys mutex#9){+.+.}-{3:3}, at:
subsys_interface_register+0x68/0x164
[   32.514773]  #4: ffff000048999bc8 (&policy->rwsem){+.+.}-{3:3}, at:
cpufreq_online+0x5e4/0xa70
[   32.514797]  #5: ffff80000ab501d0 (cpuset_mutex){+.+.}-{3:3}, at:
cpuset_lock+0x28/0x34
[   32.514818]  #6: ffff00004a7ad608 (&p->pi_lock){-.-.}-{2:2}, at:
task_rq_lock+0x50/0x1c4
[   32.514844]  #7: ffff0000f77d41d8 (&rq->__lock){-.-.}-{2:2}, at:
task_rq_lock+0x94/0x1c4
[   32.514867]
[   32.514867] stack backtrace:
[   32.514872] CPU: 2 PID: 241 Comm: (udev-worker) Not tainted 5.15.129-rc1 #1
[   32.514882] Hardware name: Raspberry Pi 4 Model B (DT)
[   32.514887] Call trace:
[   32.514890]  dump_backtrace+0x0/0x200
[   32.514898]  show_stack+0x20/0x30
[   32.514905]  dump_stack_lvl+0x88/0xb4
[   32.514913]  dump_stack+0x18/0x34
[   32.514920]  print_circular_bug+0x1f8/0x200
[   32.514933]  check_noncircular+0x140/0x154
[   32.514945]  __lock_acquire+0x12f0/0x2090
[   32.514957]  lock_acquire+0x208/0x320
[   32.514968]  _raw_spin_lock_irqsave+0x84/0xec
[   32.514980]  down_trylock+0x20/0x50
[   32.514990]  __down_trylock_console_sem+0x44/0xc0
[   32.515003]  console_trylock+0x44/0x100
[   32.515015]  vprintk_emit+0x10c/0x2e0
[   32.515027]  vprintk_default+0x40/0x50
[   32.515039]  vprintk+0xdc/0x100
[   32.515046]  _printk+0x64/0x8c
[   32.515057]  lockdep_rcu_suspicious+0x34/0x10c
[   32.515068]  inc_dl_tasks_cs+0xc0/0xd0
[   32.515076]  switched_to_dl+0x38/0x2dc
[   32.515086]  __sched_setscheduler+0x228/0xaf0
[   32.515096]  sched_setattr_nocheck+0x20/0x30
[   32.515104]  sugov_init+0x140/0x370
[   32.515113]  cpufreq_init_governor+0x78/0x120
[   32.515123]  cpufreq_set_policy+0x290/0x430
[   32.515132]  cpufreq_online+0x3a0/0xa70
[   32.515142]  cpufreq_add_dev+0xd0/0xf0
[   32.515152]  subsys_interface_register+0x13c/0x164
[   32.515161]  cpufreq_register_driver+0x17c/0x2e0
[   32.515170]  dt_cpufreq_probe+0x350/0x4b4
[   32.515182]  platform_probe+0x70/0xe0
[   32.515194]  really_probe+0xcc/0x470
[   32.515203]  __driver_probe_device+0x114/0x170
[   32.515213]  driver_probe_device+0x48/0x140
[   32.515222]  __device_attach_driver+0xd8/0x180
[   32.515232]  bus_for_each_drv+0x84/0xe0
[   32.515240]  __device_attach+0xa4/0x1d0
[   32.515249]  device_initial_probe+0x1c/0x30
[   32.515259]  bus_probe_device+0xa4/0xb0
[   32.515268]  device_add+0x3e8/0x920
[   32.515275]  platform_device_add+0x108/0x290
[   32.515286]  platform_device_register_full+0xe4/0x17c
[   32.515298]  raspberrypi_cpufreq_probe+0x13c/0x1e0 [raspberrypi_cpufreq]
[   32.515312]  platform_probe+0x70/0xe0
[   32.515324]  really_probe+0xcc/0x470
[   32.515333]  __driver_probe_device+0x114/0x170
[   32.515343]  driver_probe_device+0x48/0x140
[   32.515352]  __driver_attach+0x12c/0x220
[   32.515361]  bus_for_each_dev+0x7c/0xdc
[   32.515369]  driver_attach+0x2c/0x40
[   32.515378]  bus_add_driver+0x168/0x274
[   32.515386]  driver_register+0x80/0x13c
[   32.515396]  __platform_driver_register+0x30/0x40
[   32.515408]  raspberrypi_cpufreq_driver_init+0x28/0x1000
[raspberrypi_cpufreq]
[   32.515421]  do_one_initcall+0x90/0x340
[   32.515430]  do_init_module+0x50/0x28c
[   32.515440]  load_module+0x2148/0x26f0
[   32.515449]  __do_sys_finit_module+0xa8/0x11c
[   32.515458]  __arm64_sys_finit_module+0x28/0x34
[   32.515468]  invoke_syscall+0x78/0x100
[   32.515480]  el0_svc_common.constprop.0+0x104/0x124
[   32.515492]  do_el0_svc+0x2c/0xa0
[   32.515503]  el0_svc+0x54/0x110
[   32.515514]  el0t_64_sync_handler+0xe8/0x114
[   32.515525]  el0t_64_sync+0x1a0/0x1a4
[   32.519795] vc4-drm gpu: [drm] Cannot find any crtc or sizes
[   32.524928] =============================
[   32.524933] WARNING: suspicious RCU usage
[   32.524937] 5.15.129-rc1 #1 Not tainted
[   32.524944] -----------------------------
[   32.524948] include/linux/cgroup.h:495 suspicious
rcu_dereference_check() usage!
[   32.524955]
[   32.524955] other info that might help us debug this:
[   32.524955]
[   32.524960]
[   32.524960] rcu_scheduler_active = 2, debug_locks = 1
[   32.524967] 8 locks held by (udev-worker)/241:
[   32.524974]  #0: ffff0000438af188 (&dev->mutex){....}-{3:3}, at:
__driver_attach+0x120/0x220
[   33.499420]  #1: ffff0000438ab188 (&dev->mutex){....}-{3:3}, at:
__device_attach+0x40/0x1d0
[   33.499454]  #2: ffff80000aab0d68 (cpu_hotplug_lock){++++}-{0:0},
at: cpus_read_lock+0x18/0x24
[   33.507960]  #3: ffff0000409e4918 (subsys mutex#9){+.+.}-{3:3}, at:
subsys_interface_register+0x68/0x164
[   33.516727]  #4: ffff000048999bc8 (&policy->rwsem){+.+.}-{3:3}, at:
cpufreq_online+0x5e4/0xa70
[   33.535105]  #5: ffff80000ab501d0 (cpuset_mutex){+.+.}-{3:3}, at:
cpuset_lock+0x28/0x34
[   33.535137]  #6: ffff00004a7ad608 (&p->pi_lock){-.-.}-{2:2}, at:
task_rq_lock+0x50/0x1c4
[   33.535171]  #7: ffff0000f77d41d8 (&rq->__lock){-.-.}-{2:2}, at:
task_rq_lock+0x94/0x1c4
[   33.559715]
[   33.559715] stack backtrace:
[   33.559720] CPU: 2 PID: 241 Comm: (udev-worker) Not tainted 5.15.129-rc1 #1
[   33.559731] Hardware name: Raspberry Pi 4 Model B (DT)
[   33.559738] Call trace:
[   33.559742]  dump_backtrace+0x0/0x200
[   33.582598]  show_stack+0x20/0x30
[   33.582608]  dump_stack_lvl+0x88/0xb4
[   33.582618]  dump_stack+0x18/0x34
[   33.582626]  lockdep_rcu_suspicious+0xf8/0x10c
[   33.597545]  inc_dl_tasks_cs+0xc0/0xd0
[   33.597555]  switched_to_dl+0x38/0x2dc
[   33.597569]  __sched_setscheduler+0x228/0xaf0
[   33.609577]  sched_setattr_nocheck+0x20/0x30
[   33.609588]  sugov_init+0x140/0x370
[   33.609600]  cpufreq_init_governor+0x78/0x120
[   33.621874]  cpufreq_set_policy+0x290/0x430
[   33.621886]  cpufreq_online+0x3a0/0xa70
[   33.621897]  cpufreq_add_dev+0xd0/0xf0
[   33.633818]  subsys_interface_register+0x13c/0x164
[   33.633830]  cpufreq_register_driver+0x17c/0x2e0
[   33.633841]  dt_cpufreq_probe+0x350/0x4b4
[   33.647440]  platform_probe+0x70/0xe0
[   33.647454]  really_probe+0xcc/0x470
[   33.647465]  __driver_probe_device+0x114/0x170
[   33.659295]  driver_probe_device+0x48/0x140
[   33.659307]  __device_attach_driver+0xd8/0x180
[   33.659319]  bus_for_each_drv+0x84/0xe0
[   33.671945]  __device_attach+0xa4/0x1d0
[   33.671956]  device_initial_probe+0x1c/0x30
[   33.671968]  bus_probe_device+0xa4/0xb0
[   33.671978]  device_add+0x3e8/0x920
[   33.671987]  platform_device_add+0x108/0x290
[   33.672000]  platform_device_register_full+0xe4/0x17c
[   33.696975]  raspberrypi_cpufreq_probe+0x13c/0x1e0 [raspberrypi_cpufreq]
[   33.696992]  platform_probe+0x70/0xe0
[   33.707506]  really_probe+0xcc/0x470
[   33.707518]  __driver_probe_device+0x114/0x170
[   33.707529]  driver_probe_device+0x48/0x140
[   33.719888]  __driver_attach+0x12c/0x220
[   33.719899]  bus_for_each_dev+0x7c/0xdc
[   33.719909]  driver_attach+0x2c/0x40
[   33.731394]  bus_add_driver+0x168/0x274
[   33.731405]  driver_register+0x80/0x13c
[   33.731416]  __platform_driver_register+0x30/0x40
[   33.743954]  raspberrypi_cpufreq_driver_init+0x28/0x1000
[raspberrypi_cpufreq]
[   33.743969]  do_one_initcall+0x90/0x340
[   33.743980]  do_init_module+0x50/0x28c
[   33.758981]  load_module+0x2148/0x26f0
[   33.758993]  __do_sys_finit_module+0xa8/0x11c
[   33.759005]  __arm64_sys_finit_module+0x28/0x34
[   33.759016]  invoke_syscall+0x78/0x100
[   33.775606]  el0_svc_common.constprop.0+0x104/0x124
[   33.775621]  do_el0_svc+0x2c/0xa0
[   33.783932]  el0_svc+0x54/0x110
[   33.783946]  el0t_64_sync_handler+0xe8/0x114
[   33.791460]  el0t_64_sync+0x1a0/0x1a4


Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.128-90-g948d61e1588b/testrun/19421242/suite/log-parser-boot/tests/

metadata:
  git_ref: linux-5.15.y
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
  git_sha: 948d61e1588b9442fe7390e694431478159553bc
  git_describe: v5.15.128-90-g948d61e1588b
  kernel_version: 5.15.129-rc1
  kernel-config:
    https://storage.tuxsuite.com/public/linaro/lkft/builds/2Ubp9wnZ2x6rGWiSymzDbRIVGxr/config
  artifact-location:
    https://storage.tuxsuite.com/public/linaro/lkft/builds/2Ubp9wnZ2x6rGWiSymzDbRIVGxr/
  toolchain: gcc-12
  build_name: gcc-12-lkftconfig-kselftest-kernel


--
Linaro LKFT
https://lkft.linaro.org
