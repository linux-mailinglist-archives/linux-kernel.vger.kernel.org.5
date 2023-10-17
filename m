Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD84A7CBE41
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbjJQI6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234763AbjJQI6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:58:17 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6165F93
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:58:14 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-49dc95be894so1558915e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697533093; x=1698137893; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WTi7aJ8Y9jVyiAr3Hx7uz4pRlTR+SQvTtfZ6MRXVjRc=;
        b=w31llEKTvGRPad4ONBMFCHLLX/ATBXKPMc4WGZlRpYXzkoeU4vMN2aK0pTzt1AibtC
         xIhMuTMtWLgdnAfWVFOwUR8zFlG3tRhX3Ls3BFU2BSBUwNnJdmeV0zBpRBNEz4I3/+Rn
         7yeMLQd7z2dvH6Qh82blwisBZWUGBQ1qX6X35cDsCBKSSiA6rCvFw0pAPJaS+o4KDlGX
         seQZ1+Td4VSdoH+a2Vjr8KlCQfhYob5jkjJO6MwPQrCQ7mEkEHCJ+2Vy+jMIV27Bpbvl
         RB7JMKGMRocKYP5WsNspkz63HAVvtBXqwT4e4Toh9VOkxoL294olGhaelzsAwGOczQyp
         N1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697533093; x=1698137893;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WTi7aJ8Y9jVyiAr3Hx7uz4pRlTR+SQvTtfZ6MRXVjRc=;
        b=sr7Y+2J9SSLTQkrSSSpG8fvjRROlHyCNDx8LllB9GDLpY4v4RKL+g0cwrt0f3mOJX1
         9FfDg2bZ5xrlFrOmG5YblEjpeucArnqlZF8DIc5yOKkw9Ni+5xBDljjIdNSXUVyClpDi
         dUbbH2CuEBgTzzUplyvrvi4IJmfGQ0Rz44Gmpci5vpwPuHVKx/WGsUgjenWThvWqJw3a
         XiJ8FDEAa/OokYx0NSbtIftWAqwivWHgRHbG5FFJuAJ8Uph+hdw0jyEHtyCVHXhNCb5H
         6PozdIVl2Ch4DQpflh4yVsimOgztF+j06zwVyBJN7DVjl8dxpJvTLDTMPRnlb4kkiTMV
         Dm0g==
X-Gm-Message-State: AOJu0YxZ50mAUxJ6fMXR8dS5TQVhq+6gEdZ1JhNk1Ru4St1EcgaR4C/+
        CPpmimMpLz+nBTJEuAIc99zGLEZm+Bb720xsxIakUQ==
X-Google-Smtp-Source: AGHT+IEB/3AKEOW0vsHpmt4f5Lluta/tRaOYOOhgFRblHJz5YrDfbFVQhkYsPum2zYLhR6xZFzdQfY0PVmZLrj4Zwsc=
X-Received: by 2002:a05:6122:17a3:b0:4a0:6fa5:b08a with SMTP id
 o35-20020a05612217a300b004a06fa5b08amr1586183vkf.8.1697533093299; Tue, 17 Oct
 2023 01:58:13 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 17 Oct 2023 14:28:02 +0530
Message-ID: <CA+G9fYswykTGdK+L9Z8yJACVZMoWvgRFdG58VLKN9o73AiZh+w@mail.gmail.com>
Subject: Qemu-arm64: kvm-unit-tests: WARNING: at kernel/events/core.c:244 event_function
To:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, linux-stable <stable@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
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

Following kernel warning noticed while running kvm-unit-tests on qemu-arm64
running stable-rc 6.1.56 kernel.

This kernel warning occurs intermittently on qemu-arm64 with kernel command
line option "kvm-arm.mode=protected".

Boot log:
[    0.000000] Linux version 6.1.56 (tuxmake@tuxmake)
(aarch64-linux-gnu-gcc (Debian 13.2.0-2) 13.2.0, GNU ld (GNU Binutils
for Debian) 2.41) #1 SMP PREEMPT @1696601727
[    0.000000] random: crng init done
[    0.000000] Machine model: linux,dummy-virt
...
<6>[    0.204459] CPU features: detected: Protected KVM
...
<6>[    1.439501] kvm [1]: IPA Size Limit: 48 bits
<6>[    1.620529] kvm [1]: GICv3: no GICV resource entry
<6>[    1.623060] kvm [1]: disabling GICv2 emulation
<6>[    1.624247] kvm [1]: GIC system register CPU interface enabled
<6>[    1.626934] kvm [1]: vgic interrupt IRQ9
<6>[    1.632519] kvm [1]: Protected nVHE mode initialized successfully


Test log:
---------
+ ./run_tests.sh -a -v
+ tee -a /lava-1/0/tests/0_kvm-unit-tests/automated/linux/kvm-unit-tests/output/result_log.txt
<31>[   68.843857] systemd[1]: systemd-udevd.service: Got notification
message from PID 226 (WATCHDOG=1)
<31>[   97.299940] systemd[1]: Received SIGCHLD from PID 351 (bash).
<31>[   97.320211] systemd[1]: Child 351 (bash) died (code=exited,
status=0/SUCCESS)
<31>[   97.352577] systemd[1]: Child 352 (grep) died (code=exited,
status=1/FAILURE)
<4>[  100.375043] ------------[ cut here ]------------
<4>[ 100.376812] WARNING: CPU: 0 PID: 356 at kernel/events/core.c:244
event_function (kernel/events/core.c:244 (discriminator 1))
<4>[  100.378656] Modules linked in: fuse drm dm_mod ip_tables x_tables
<4>[  100.381530] CPU: 0 PID: 356 Comm: qemu-system-aar Not tainted 6.1.56 #1
<4>[  100.382823] Hardware name: linux,dummy-virt (DT)
<4>[  100.384931] pstate: 624000c5 (nZCv daIF +PAN -UAO +TCO -DIT
-SSBS BTYPE=--)
<4>[ 100.386199] pc : event_function (kernel/events/core.c:244
(discriminator 1))
<4>[ 100.387840] lr : event_function (kernel/events/core.c:168
kernel/events/core.c:226)
<4>[  100.388527] sp : ffff80000858b750
<4>[  100.389629] x29: ffff80000858b750 x28: 0000000000000000 x27:
ffffad552ce81c00
<4>[  100.391419] x26: ffff0000c4f90000 x25: ffff80000858b8d0 x24:
ffff0000c4f90000
<4>[  100.392473] x23: ffff0000ff7ba9e8 x22: 0000000000000000 x21:
ffff0000c3ddca00
<4>[  100.393558] x20: ffff80000858b8d0 x19: ffff0000ff7ba9e0 x18:
0000000000000000
<4>[  100.394601] x17: 0000000000000000 x16: 0000000000000000 x15:
0000000000000000
<4>[  100.395660] x14: 0000000000000000 x13: ffff0000c03a0031 x12:
3430376239633038
<4>[  100.396686] x11: 0000002042c35bc1 x10: aff705512bd33e45 x9 :
ffffad552df9bb24
<4>[  100.397603] x8 : ffff80000858b708 x7 : 0000000000000000 x6 :
0000000000000001
<4>[  100.398525] x5 : ffff80000858c000 x4 : ffff800008588000 x3 :
0000000000000000
<4>[  100.399502] x2 : 0000000000000001 x1 : ffff0000c4d21080 x0 :
0000000000000000
<4>[  100.400742] Call trace:
<4>[ 100.401070] event_function (kernel/events/core.c:244 (discriminator 1))
<4>[ 100.401781] remote_function (kernel/events/core.c:92
(discriminator 1) kernel/events/core.c:72 (discriminator 1))
<4>[ 100.402355] generic_exec_single
(arch/arm64/include/asm/irqflags.h:85 kernel/smp.c:522)
<4>[ 100.403777] smp_call_function_single (kernel/smp.c:773)
<4>[ 100.404283] event_function_call (kernel/events/core.c:123
kernel/events/core.c:289)
<4>[ 100.405433] perf_event_disable (kernel/events/core.c:1321
kernel/events/core.c:2499)
<4>[ 100.405816] kvm_pmu_probe_armpmu (arch/arm64/kvm/pmu-emul.c:711)
<4>[ 100.406563] kvm_arm_pmu_v3_set_attr
(arch/arm64/kvm/pmu-emul.c:890 (discriminator 1))
<4>[ 100.407333] kvm_arm_vcpu_arch_set_attr (arch/arm64/kvm/guest.c:955)
<4>[ 100.407774] kvm_arch_vcpu_ioctl (arch/arm64/kvm/arm.c:1386
(discriminator 1))
<4>[ 100.408360] kvm_vcpu_ioctl
(arch/arm64/kvm/../../../virt/kvm/kvm_main.c:4081)
<4>[ 100.409176] __arm64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:870
fs/ioctl.c:856 fs/ioctl.c:856)
<4>[ 100.409796] invoke_syscall (arch/arm64/include/asm/current.h:19
arch/arm64/kernel/syscall.c:57)
<4>[ 100.410395] el0_svc_common.constprop.0
(arch/arm64/include/asm/daifflags.h:28
arch/arm64/kernel/syscall.c:150)
<4>[ 100.411070] do_el0_svc (arch/arm64/kernel/syscall.c:207)
<4>[ 100.411603] el0_svc (arch/arm64/include/asm/daifflags.h:28
arch/arm64/kernel/entry-common.c:133
arch/arm64/kernel/entry-common.c:142
arch/arm64/kernel/entry-common.c:638)
<4>[ 100.412158] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:656)
<4>[ 100.412574] el0t_64_sync (arch/arm64/kernel/entry.S:581)
<4>[  100.413766] ---[ end trace 0000000000000000 ]---
<4>[  100.414762] ------------[ cut here ]------------
<4>[ 100.415317] WARNING: CPU: 0 PID: 356 at kernel/events/core.c:249
event_function (kernel/events/core.c:249 (discriminator 1))
<4>[  100.416404] Modules linked in: fuse drm dm_mod ip_tables x_tables
<4>[  100.417743] CPU: 0 PID: 356 Comm: qemu-system-aar Tainted: G
   W          6.1.56 #1
<4>[  100.418745] Hardware name: linux,dummy-virt (DT)
<4>[  100.419503] pstate: a24000c5 (NzCv daIF +PAN -UAO +TCO -DIT
-SSBS BTYPE=--)
<4>[ 100.420538] pc : event_function (kernel/events/core.c:249
(discriminator 1))
<4>[ 100.421156] lr : event_function (kernel/events/core.c:168
kernel/events/core.c:226)
<4>[  100.422364] sp : ffff80000858b750
<4>[  100.422967] x29: ffff80000858b750 x28: 0000000000000000 x27:
ffffad552ce81c00
<4>[  100.424161] x26: ffff0000c4f90000 x25: ffff80000858b8d0 x24:
ffff0000c4f90000
<4>[  100.424839] x23: ffff0000ff7ba9e8 x22: 0000000000000000 x21:
ffff0000c3ddca00
<4>[  100.425502] x20: ffff80000858b8d0 x19: ffff0000ff7ba9e0 x18:
0000000000000000
<4>[  100.426185] x17: 0000000000000000 x16: 0000000000000000 x15:
0000000000000000
<4>[  100.428958] x14: 0000000000000000 x13: ffff0000c03a0031 x12:
3430376239633038
<4>[  100.429930] x11: 0000002042c35bc1 x10: aff705512bd33e45 x9 :
ffffad552df9bb24
<4>[  100.430938] x8 : ffff80000858b708 x7 : 0000000000000000 x6 :
0000000000000001
<4>[  100.431829] x5 : ffff80000858c000 x4 : ffff800008588000 x3 :
0000000000000000
<4>[  100.432767] x2 : 0000000000000001 x1 : ffff0000c4d21080 x0 :
0000000000000000
<4>[  100.433677] Call trace:
<4>[ 100.434167] event_function (kernel/events/core.c:249 (discriminator 1))
<4>[ 100.435066] remote_function (kernel/events/core.c:92
(discriminator 1) kernel/events/core.c:72 (discriminator 1))
<4>[ 100.435497] generic_exec_single
(arch/arm64/include/asm/irqflags.h:85 kernel/smp.c:522)
<4>[ 100.435875] smp_call_function_single (kernel/smp.c:773)
<4>[ 100.436758] event_function_call (kernel/events/core.c:123
kernel/events/core.c:289)
<4>[ 100.437374] perf_event_disable (kernel/events/core.c:1321
kernel/events/core.c:2499)
<4>[ 100.438024] kvm_pmu_probe_armpmu (arch/arm64/kvm/pmu-emul.c:711)
<4>[ 100.438834] kvm_arm_pmu_v3_set_attr
(arch/arm64/kvm/pmu-emul.c:890 (discriminator 1))
<4>[ 100.439329] kvm_arm_vcpu_arch_set_attr (arch/arm64/kvm/guest.c:955)
<4>[ 100.439981] kvm_arch_vcpu_ioctl (arch/arm64/kvm/arm.c:1386
(discriminator 1))
<4>[ 100.440393] kvm_vcpu_ioctl
(arch/arm64/kvm/../../../virt/kvm/kvm_main.c:4081)
<4>[ 100.441150] __arm64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:870
fs/ioctl.c:856 fs/ioctl.c:856)
<4>[ 100.441766] invoke_syscall (arch/arm64/include/asm/current.h:19
arch/arm64/kernel/syscall.c:57)
<4>[ 100.442312] el0_svc_common.constprop.0
(arch/arm64/include/asm/daifflags.h:28
arch/arm64/kernel/syscall.c:150)
<4>[ 100.442801] do_el0_svc (arch/arm64/kernel/syscall.c:207)
<4>[ 100.443590] el0_svc (arch/arm64/include/asm/daifflags.h:28
arch/arm64/kernel/entry-common.c:133
arch/arm64/kernel/entry-common.c:142
arch/arm64/kernel/entry-common.c:638)
<4>[ 100.444125] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:656)
<4>[ 100.444779] el0t_64_sync (arch/arm64/kernel/entry.S:581)
<4>[  100.445155] ---[ end trace 0000000000000000 ]---


Links:
- https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2WOQiJhgccWJ1UTjge0VQWINEgG
- https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.56/testrun/20294213/suite/log-parser-test/tests/
- https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.56/testrun/20294213/suite/log-parser-test/test/check-kernel-exception-1c1a9bb72134660eb4c5af3558fbbda6c3a8e1827dcf791ce1cc0e2e5aa9aaba/log

Buid:
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2WOQgZEtR7bb2LJfBNhOZzbaZZY/


--
Linaro LKFT
https://lkft.linaro.org
