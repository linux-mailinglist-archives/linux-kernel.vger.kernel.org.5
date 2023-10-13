Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149A07C8C16
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 19:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjJMRLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 13:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjJMRLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 13:11:14 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A823FAD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 10:11:12 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-49d6bd3610cso927175e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 10:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697217072; x=1697821872; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LCaH9FAxcQll+uhN0AKMs+mxsjgEJ8l5KA3S9uEcl4A=;
        b=xa7SOz3ImD/jJ9BHFgcTMf35+J6DxSOy9LwYeruewsefIzhsDW1iQoku3mwO9xKGU/
         sTmo8cYAgSSkAKQZWuWqA8mLkgcMTlYwZh4ImmMmq2wcyLi8muLeupaS0FYmrlrS+AaL
         /uUXMGcQXDA+IYPyvpG+2d77DJu5hYV5KeVgxiVJLZ/hhiD2BFEZfiofaESpiWFQYpT/
         f5wSZQ7Oen0+pLZBrke3u1rC3+1CoyTAUIqeZP8dEoHB40eGogsyoi2Iic/SKO38DbdE
         WW+87Kw1sqoqcBMRoziOS6OI1GzY4mN3VhtMtbxQ+iRtx2ffsxFXPdhT7cSDk48NJorL
         yM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697217072; x=1697821872;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LCaH9FAxcQll+uhN0AKMs+mxsjgEJ8l5KA3S9uEcl4A=;
        b=WcWkrlfu+ytbU+UYsHOKREzJ2US3MS68FiVV7vajyC1auGpyJ6D3UGHEzo23sd8v/Y
         uQ3J0CtWELM86c/8bBfDJTwAi6Qd5rtAQfu3Hv9ctUTkcUo1AskIfECxrpxLbT5q0pef
         Uyjezz6+iwFs/ZiwG0hgDwfwXuxum/ggsN836juKXEP38I93wBYWa9UDl3uJE2DToywG
         J0Lo7qlijyAYOjW1ScQ+DJe1r7PIU3JP3lzohS1S9qGquVBx2dBXPLrmxJw1TAbC0jOu
         kcA0vSSssEPcZiXWiPbjnbpucbcIzbbBATTPf3HpOSBFzedoKwntb5iYewumUejIb//8
         EZog==
X-Gm-Message-State: AOJu0Yy141258cDNrA9RXiRq+jVxyMiEb+E73nIBCDKCy2+iJmNqaDZM
        oNAqswbSa/qXWTEJvh5w3pfFBI3D6Mt9rA+H5I0aush++DMBHK0T9f7AxQ==
X-Google-Smtp-Source: AGHT+IHOQcE813YfP/iMX27AlZRWO0IvLUbkSTVcV/hLmWlwz9goai0MMXKoP5CmhUwHWKjXN1mkFEetWcaFy6yQgeA=
X-Received: by 2002:a1f:4b85:0:b0:49d:d73e:5d07 with SMTP id
 y127-20020a1f4b85000000b0049dd73e5d07mr18361683vka.16.1697217071583; Fri, 13
 Oct 2023 10:11:11 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 13 Oct 2023 22:41:00 +0530
Message-ID: <CA+G9fYvFkJy=e2-CZz_GhTRr2DBDA3-ZBBrASmF9nQMPf-KrQA@mail.gmail.com>
Subject: WARNING: possible circular locking dependency detected -
 clk_smd_rpm_set_rate (drivers/clk/qcom/clk-smd-rpm.c:321)
To:     linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        open list <linux-kernel@vger.kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following deadlock warning noticed on arm64 Qcom APQ 8016 SBC device with
a given config (kselftest merge configs) while booting.

This is almost always reproducible with a given config.
started happening from stable-rc v6.1.55.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Boot log:
-------
[   28.082133] ======================================================
[   28.082673] WARNING: possible circular locking dependency detected
[   28.088664] 6.1.55 #1 Not tainted
[   28.094813] ------------------------------------------------------
[   28.098211] (udev-worker)/278 is trying to acquire lock:
[   28.104285] ffff80000b2b2d30 (rpm_smd_clk_lock){+.+.}-{3:3}, at:
clk_smd_rpm_set_rate (drivers/clk/qcom/clk-smd-rpm.c:321)
[   28.109772]
[   28.109772] but task is already holding lock:
[   28.118525] ffff80000b49f3e0 (icc_bw_lock){+.+.}-{3:3}, at:
icc_node_add (drivers/interconnect/core.c:973)
[   28.124175]
[   28.124175] which lock already depends on the new lock.
[   28.124175]
[   28.131729]
[   28.131729] the existing dependency chain (in reverse order) is:
[   28.140058]
[   28.140058] -> #2 (icc_bw_lock){+.+.}-{3:3}:
[   28.147518] icc_init (drivers/interconnect/core.c:1159 (discriminator 1))
[   28.153235] do_one_initcall (init/main.c:1292)
[   28.156884] kernel_init_freeable (init/main.c:1364 (discriminator
3) init/main.c:1381 (discriminator 3) init/main.c:1400 (discriminator
3) init/main.c:1620 (discriminator 3))
[   28.161227] kernel_init (init/main.c:1510)
[   28.165910] ret_from_fork (arch/arm64/kernel/entry.S:861)
[   28.170077]
[   28.170077] -> #1 (fs_reclaim){+.+.}-{0:0}:
[   28.174079] fs_reclaim_acquire (mm/page_alloc.c:4700 mm/page_alloc.c:4691)
[   28.179890] __kmem_cache_alloc_node (include/linux/sched/mm.h:272
mm/slab.h:710 mm/slub.c:3318 mm/slub.c:3437)
[   28.184492] __kmalloc (mm/slab_common.c:956 mm/slab_common.c:968)
[   28.189434] qcom_rpm_smd_write (include/linux/slab.h:558
drivers/soc/qcom/smd-rpm.c:116)
[   28.193084] clk_smd_rpm_prepare (drivers/clk/qcom/clk-smd-rpm.c:192
drivers/clk/qcom/clk-smd-rpm.c:253)
[   28.197945] clk_core_prepare (drivers/clk/clk.c:971)
[   28.202545] clk_prepare (drivers/clk/clk.c:1004
drivers/clk/clk.c:1027 drivers/clk/clk.c:1022)
[   28.206881] amba_get_enable_pclk (include/linux/clk.h:1072
drivers/amba/bus.c:70)
[   28.211052] amba_read_periphid (drivers/amba/bus.c:146)
[   28.215653] amba_match (drivers/amba/bus.c:222)
[   28.220336] __device_attach_driver (drivers/base/base.h:147
(discriminator 1) drivers/base/dd.c:913 (discriminator 1))
[   28.223900] bus_for_each_drv (drivers/base/bus.c:427)
[   28.229106] __device_attach (drivers/base/dd.c:1017)
[   28.233359] device_initial_probe (drivers/base/dd.c:1065)
[   28.237699] bus_probe_device (drivers/base/bus.c:489)
[   28.242385] deferred_probe_work_func (drivers/base/dd.c:124)
[   28.246729] process_one_work (kernel/workqueue.c:2297)
[   28.251761] worker_thread (include/linux/list.h:292 (discriminator
2) kernel/workqueue.c:2352 (discriminator 2) kernel/workqueue.c:2444
(discriminator 2))
[   28.256186] kthread (kernel/kthread.c:376)
[   28.260697] ret_from_fork (arch/arm64/kernel/entry.S:861)
[   28.264258]
[   28.264258] -> #0 (rpm_smd_clk_lock){+.+.}-{3:3}:
[   28.268351] __lock_acquire (kernel/locking/lockdep.c:3091
(discriminator 1) kernel/locking/lockdep.c:3209 (discriminator 1)
kernel/locking/lockdep.c:3824 (discriminator 1)
kernel/locking/lockdep.c:5048 (discriminator 1))
[   28.274503] lock_acquire (arch/arm64/include/asm/percpu.h:40
kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5663
kernel/locking/lockdep.c:5626)
[   28.278929] __mutex_lock (kernel/locking/mutex.c:605
kernel/locking/mutex.c:747)
[   28.283095] mutex_lock_nested (kernel/locking/mutex.c:800)
[   28.287263] clk_smd_rpm_set_rate (drivers/clk/qcom/clk-smd-rpm.c:321)
[   28.291691] clk_change_rate (drivers/clk/clk.c:2278)
[   28.296464] clk_core_set_rate_nolock (drivers/clk/clk.c:2382
drivers/clk/clk.c:2340)
[   28.300895] clk_set_rate (drivers/clk/clk.c:2423 drivers/clk/clk.c:2410)
[   28.306012] qcom_icc_set+0x1d4/0x270 icc_smd_rpm
[   28.310186] icc_node_add (drivers/interconnect/core.c:994)
[   28.315561] qnoc_probe+0x240/0x420 icc_smd_rpm
[   28.319558] platform_probe (drivers/base/platform.c:1400)
[   28.324675] really_probe (drivers/base/dd.c:560 drivers/base/dd.c:639)
[   28.328841] __driver_probe_device (drivers/base/dd.c:785)
[   28.333011] driver_probe_device (drivers/base/dd.c:815)
[   28.337786] __driver_attach (drivers/base/dd.c:1202)
[   28.342646] bus_for_each_dev (drivers/base/bus.c:301)
[   28.346984] driver_attach (drivers/base/dd.c:1219)
[   28.351411] bus_add_driver (drivers/base/bus.c:618)
[   28.355404] driver_register (drivers/base/driver.c:246)
[   28.359832] __platform_driver_register (drivers/base/platform.c:868)
[   28.364177] msm8916_noc_driver_init+0x28/0x1000 qnoc_msm8916
[   28.369217] do_one_initcall (init/main.c:1292)
[   28.375804] do_init_module (kernel/module/main.c:2464)
[   28.380144] load_module (kernel/module/main.c:2873)
[   28.384485] __do_sys_finit_module (kernel/module/main.c:2973
(discriminator 1))
[   28.388742] __arm64_sys_finit_module (kernel/module/main.c:2940)
[   28.393342] invoke_syscall (arch/arm64/include/asm/current.h:19
arch/arm64/kernel/syscall.c:57)
[   28.398546] el0_svc_common.constprop.0 (arch/arm64/kernel/syscall.c:149)
[   28.402894] do_el0_svc (arch/arm64/kernel/syscall.c:207)
[   28.408179] el0_svc (arch/arm64/include/asm/daifflags.h:28
arch/arm64/kernel/entry-common.c:133
arch/arm64/kernel/entry-common.c:142
arch/arm64/kernel/entry-common.c:638)
[   28.411825] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:656)
[   28.415651] el0t_64_sync (arch/arm64/kernel/entry.S:581)
[   28.420248]
[   28.420248] other info that might help us debug this:
[   28.420248]
[   28.424438] Chain exists of:
[   28.424438]   rpm_smd_clk_lock --> fs_reclaim --> icc_bw_lock
[   28.424438]
[   28.432432]  Possible unsafe locking scenario:
[   28.432432]
[   28.442481]        CPU0                    CPU1
[   28.448374]        ----                    ----
[   28.452888]   lock(icc_bw_lock);
Linux runner-vwmj3eza-project-40964107-concurrent-0 6.1.55 #1 SMP
PREEMPT @1695871287 aarch6[   28.457396]
 lock(fs_reclaim);
4
[   28.475726]   lock(rpm_smd_clk_lock);
[   28.475770]
[   28.475770]  *** DEADLOCK ***
[   28.475770]
[   28.478630] 4 locks held by (udev-worker)/278:
[   28.484350] #0: ffff000004e968f8 (&dev->mutex){....}-{3:3}, at:
__driver_attach (drivers/base/dd.c:1201)
[   28.488885] #1: ffff80000b49f2e8 (icc_lock){+.+.}-{3:3}, at:
icc_node_add (drivers/interconnect/core.c:971)
[   28.497475] #2: ffff80000b49f3e0 (icc_bw_lock){+.+.}-{3:3}, at:
icc_node_add (drivers/interconnect/core.c:973)
[   28.505202] #3: ffff80000b23eeb8 (prepare_lock){+.+.}-{3:3}, at:
clk_prepare_lock (drivers/clk/clk.c:129 (discriminator 1))
[   28.513363]
[   28.513363] stack backtrace:
[   28.521766] CPU: 3 PID: 278 Comm: (udev-worker) Not tainted 6.1.55 #1
[   28.526028] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[   28.532453] Call trace:
[   28.539202] dump_backtrace (arch/arm64/kernel/stacktrace.c:160
arch/arm64/kernel/stacktrace.c:143)
[   28.541379] show_stack (arch/arm64/kernel/stacktrace.c:167)
[   28.545194] dump_stack_lvl (lib/dump_stack.c:107)
[   28.548582] dump_stack (lib/dump_stack.c:114)
[   28.552225] print_circular_bug (kernel/locking/lockdep.c:2048)
[   28.555529] check_noncircular (kernel/locking/lockdep.c:2173)
[   28.559521] __lock_acquire (kernel/locking/lockdep.c:3091
(discriminator 1) kernel/locking/lockdep.c:3209 (discriminator 1)
kernel/locking/lockdep.c:3824 (discriminator 1)
kernel/locking/lockdep.c:5048 (discriminator 1))
[   28.563687] lock_acquire (arch/arm64/include/asm/percpu.h:40
kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5663
kernel/locking/lockdep.c:5626)
[   28.567767] __mutex_lock (kernel/locking/mutex.c:605
kernel/locking/mutex.c:747)
[   28.571411] mutex_lock_nested (kernel/locking/mutex.c:800)
[   28.575059] clk_smd_rpm_set_rate (drivers/clk/qcom/clk-smd-rpm.c:321)
[   28.578968] clk_change_rate (drivers/clk/clk.c:2278)
[   28.583220] clk_core_set_rate_nolock (drivers/clk/clk.c:2382
drivers/clk/clk.c:2340)
[   28.587128] clk_set_rate (drivers/clk/clk.c:2423 drivers/clk/clk.c:2410)
[   28.591724] qcom_icc_set+0x1d4/0x270 icc_smd_rpm
[   28.595029] icc_node_add (drivers/interconnect/core.c:994)
[   28.599884] qnoc_probe+0x240/0x420 icc_smd_rpm
[   28.603709] platform_probe (drivers/base/platform.c:1400)
[   28.608305] really_probe (drivers/base/dd.c:560 drivers/base/dd.c:639)
[   28.611949] __driver_probe_device (drivers/base/dd.c:785)
[   28.615599] driver_probe_device (drivers/base/dd.c:815)
[   28.619851] __driver_attach (drivers/base/dd.c:1202)
[   28.623844] bus_for_each_dev (drivers/base/bus.c:301)
[   28.628010] driver_attach (drivers/base/dd.c:1219)
[   28.631568] bus_add_driver (drivers/base/bus.c:618)
[   28.635388] driver_register (drivers/base/driver.c:246)
[   28.638948] __platform_driver_register (drivers/base/platform.c:868)
[   28.642771] msm8916_noc_driver_init+0x28/0x1000 qnoc_msm8916
[   28.647638] do_one_initcall (init/main.c:1292)
[   28.653356] do_init_module (kernel/module/main.c:2464)
[   28.657176] load_module (kernel/module/main.c:2873)
[   28.660995] __do_sys_finit_module (kernel/module/main.c:2973
(discriminator 1))
[   28.664732] __arm64_sys_finit_module (kernel/module/main.c:2940)
[   28.669159] invoke_syscall (arch/arm64/include/asm/current.h:19
arch/arm64/kernel/syscall.c:57)
[   28.673496] el0_svc_common.constprop.0 (arch/arm64/kernel/syscall.c:149)
[   28.677321] do_el0_svc (arch/arm64/kernel/syscall.c:207)
[   28.682087] el0_svc (arch/arm64/include/asm/daifflags.h:28
arch/arm64/kernel/entry-common.c:133
arch/arm64/kernel/entry-common.c:142
arch/arm64/kernel/entry-common.c:638)
[   28.685558] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:656)
[   28.688516] el0t_64_sync (arch/arm64/kernel/entry.S:581)

Links:
 - https://lkft.validation.linaro.org/scheduler/job/6819688#L3326
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.57-7-g3fe61dd155ac/testrun/20473398/suite/log-parser-test/tests/

metadata:
  git_ref: linux-6.1.y
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
  git_sha: d23900f974e0fb995b36ef47283a5aa74ca25f51
  git_describe: v6.1.55
  kernel_version: 6.1.55
  kernel-config:
    https://storage.tuxsuite.com/public/linaro/lkft/builds/2W0YTi5jyhwfHW8YVU86FdmCI85/config
  artifact-location:
    https://storage.tuxsuite.com/public/linaro/lkft/builds/2W0YTi5jyhwfHW8YVU86FdmCI85/
  toolchain: gcc-13


--
Linaro LKFT
https://lkft.linaro.org
