Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70A57CA535
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjJPKW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjJPKWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:22:24 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA342B4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 03:22:19 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-7ae19da7b79so1610464241.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 03:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697451738; x=1698056538; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=urvghqCQ914cVQFQkt+KKjUgox1ewzOXZ5Rj9OJC01U=;
        b=s9MSovafxCBcbIkynFKw6Pwt4DlzYDKF87HfYqV0YmF9wLntls9Irpra0GdEvIjT8X
         Jl5bS3tN6vJYwNcJJMrquiZQ6ILIa8NriXOBTbEbMrvVXFHYlrW3o3j/mZHCPLVthCfZ
         Op4RCcaIHHRoImhRtgiH/n9+4ywrIenjBL230arD5+SxBl5DNM6E4bavifEXTbO3JTrl
         4txmVcUp/dIQGnhfruwRi901i0Pwhub65iKf3lz206hDkXsD6P1ZHnmd8UEwKJLVdQtA
         6DAnXrCuztq9vdC5g42ZsnynfUR9AN40ymIX2CHNGX6ENtZjiOdIrN2h31uxzGzR3hUS
         ANuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697451738; x=1698056538;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=urvghqCQ914cVQFQkt+KKjUgox1ewzOXZ5Rj9OJC01U=;
        b=dh/3Hy1r9itF0jZ0J3JtOeFTceyXeTRas+OBMI9w4gTwOaqsFip2Qm+bMAGDENxGOR
         HEPuYxzD4SZh/pwbdqc7McSRHFGvaYXVPIJU4b9znrYyk5C7/DLwcUmIMaKVvkcwuzgo
         3yqouC7MHca24rwzN+WtOylJ/6NgrjXPyG1L7rFWzZ/zQyR6ihNW7yUuUGRWsF1GdUiA
         mHL59aVdyWKSsNXmcYmlcM2P1Ck6xqML5ERqnSj6vmjBq2ce4SMuKtsAxCfZi3K539th
         nWJrliXSDGFBZPaogk+vvu71Y8s1wo7bBlyOyi/nFysZhzSVK1jjeGonhCd90NLsAEc+
         pzzQ==
X-Gm-Message-State: AOJu0Yy/+I4WUVaoxmLWq1Zj3/DOSXMzWs1UaeIOZYjkLVsKsQzyKWVt
        FRC2cGO824RYNVeZeQBwERk9EC5mHyDERvg5kSamuDVSx+GKJv4Gyt04mw==
X-Google-Smtp-Source: AGHT+IEp0OQTbCULbibExS5sdPX6P4Bq/yeriFxOoz57HGDdHFQ9cqMAG7ybViIMfRsh3LJR6phUxTlV2mvHAPJxTkk=
X-Received: by 2002:a05:6102:204e:b0:457:dfe0:ee6e with SMTP id
 q14-20020a056102204e00b00457dfe0ee6emr2306436vsr.22.1697451738489; Mon, 16
 Oct 2023 03:22:18 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 16 Oct 2023 15:52:07 +0530
Message-ID: <CA+G9fYtL7wK-dE-Tnz4t-GWmQb50EPYa=TWGjpgYU2Z=oeAO_w@mail.gmail.com>
Subject: mm: Unable to handle kernel NULL pointer dereference at virtual
 address - mmap_region (include/linux/fs.h:580 mm/mmap.c:2946)
To:     open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, lkft-triage@lists.linaro.org
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        "Reviewed-by: Jan Kara" <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Hugh Dickins <hughd@google.com>, willy@infradead.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following kernel crash noticed while running LTP hugetlb and selftests on
qemu-x86_64 and qemu-arm64 running with Linux next 6.6.0-rc6-next-20231016.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Test Logs:
-----
<1>[   97.466617] Unable to handle kernel NULL pointer dereference at
virtual address 00000000000000d8
<1>[   97.469156] Mem abort info:
<1>[   97.469619]   ESR = 0x0000000097c08005
<1>[   97.470362]   EC = 0x25: DABT (current EL), IL = 32 bits
<1>[   97.471288]   SET = 0, FnV = 0
<1>[   97.472061]   EA = 0, S1PTW = 0
<1>[   97.473341]   FSC = 0x05: level 1 translation fault
<1>[   97.473935] Data abort info:
<1>[   97.474630]   Access size = 8 byte(s)
<1>[   97.475400]   SSE = 0, SRT = 0
<1>[   97.476583]   SF = 1, AR = 0
<1>[   97.477038]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
<1>[   97.477975]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
<1>[   97.478939] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000101c17000
<1>[   97.479949] [00000000000000d8] pgd=0800000101d5c003,
p4d=0800000101d5c003, pud=0000000000000000
<0>[   97.482922] Internal error: Oops: 0000000097c08005 [#1] PREEMPT SMP
<4>[   97.484136] Modules linked in: fuse drm backlight dm_mod
ip_tables x_tables
<4>[   97.486054] CPU: 0 PID: 342 Comm: hugemmap13 Not tainted
6.6.0-rc6-next-20231016 #1
<4>[   97.487075] Hardware name: linux,dummy-virt (DT)
<4>[   97.487955] pstate: 03400009 (nzcv daif +PAN -UAO +TCO +DIT
-SSBS BTYPE=--)
<4>[ 97.488901] pc : mmap_region (include/linux/fs.h:580 mm/mmap.c:2946)
<4>[ 97.490228] lr : mmap_region (mm/mmap.c:2945)
<4>[   97.490733] sp : ffff80008069bba0
<4>[   97.491176] x29: ffff80008069bbb0 x28: ffff0000c5d5e4d0 x27:
fffffffffffffff4
<4>[   97.492062] x26: 0000000000000000 x25: 0000000000000002 x24:
0000000000000001
<4>[   97.492989] x23: 0000000000000001 x22: 0000000000000000 x21:
ffff0000c20fcf00
<4>[   97.493771] x20: 00000002000000fb x19: 00000000fffff000 x18:
ffff80008069bc38
<4>[   97.494568] x17: 0000aaaae6247fff x16: 0000aaaade59cfff x15:
0000aaaade580fff
<4>[   97.495367] x14: 0000aaaade57ffff x13: 0000000000000000 x12:
00000000fffff000
<4>[   97.496172] x11: 0000000100000000 x10: 00000000000fffff x9 :
0000000000000000
<4>[   97.497004] x8 : 0000000000000001 x7 : 00000002000000fb x6 :
ffff0000c20fcf00
<4>[   97.497810] x5 : ffff0000c5d5e4d0 x4 : 00000000000001c4 x3 :
ffffb50d82f264f8
<4>[   97.498577] x2 : 0000000000000000 x1 : 00000000ffe00000 x0 :
0000000000000000
<4>[   97.499871] Call trace:
<4>[ 97.500288] mmap_region (include/linux/fs.h:580 mm/mmap.c:2946)
<4>[ 97.500814] do_mmap (mm/mmap.c:1379)
<4>[ 97.501243] vm_mmap_pgoff (mm/util.c:546)
<4>[ 97.501711] ksys_mmap_pgoff (mm/mmap.c:1425)
<4>[ 97.502166] __arm64_sys_mmap (arch/arm64/kernel/sys.c:21)
<4>[ 97.502634] invoke_syscall (arch/arm64/include/asm/current.h:19
arch/arm64/kernel/syscall.c:56)
<4>[ 97.503175] el0_svc_common.constprop.0
(include/linux/thread_info.h:127 (discriminator 2)
arch/arm64/kernel/syscall.c:144 (discriminator 2))
<4>[ 97.503763] do_el0_svc (arch/arm64/kernel/syscall.c:156)
<4>[ 97.504191] el0_svc (arch/arm64/include/asm/daifflags.h:28
arch/arm64/kernel/entry-common.c:133
arch/arm64/kernel/entry-common.c:144
arch/arm64/kernel/entry-common.c:679)
<4>[ 97.504640] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:697)
<4>[ 97.505159] el0t_64_sync (arch/arm64/kernel/entry.S:595)
<0>[ 97.505635] Code: 52800037 17fffe9f 93407c1b 17fffed1 (f9406ec0)
All code
========
   0: 52800037 mov w23, #0x1                    // #1
   4: 17fffe9f b 0xfffffffffffffa80
   8: 93407c1b sxtw x27, w0
   c: 17fffed1 b 0xfffffffffffffb50
  10:* f9406ec0 ldr x0, [x22, #216] <-- trapping instruction

Code starting with the faulting instruction
===========================================
   0: f9406ec0 ldr x0, [x22, #216]
<4>[   97.506697] ---[ end trace 0000000000000000 ]---


Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231016/testrun/20616666/suite/log-parser-test/test/check-kernel-oops/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231016/testrun/20616666/suite/log-parser-test/tests/

Build:
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2Wpo3Fqa5DhxsWQjZYBnbqMmD8X/vmlinux.xz
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2Wpo3Fqa5DhxsWQjZYBnbqMmD8X/System.map
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2Wpo3Fqa5DhxsWQjZYBnbqMmD8X/

Step to reproduce:
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2Wpo5DC7b6y3ZyDnxzj6rn5ZNlX/reproducer

 # To install tuxrun to your home directory at ~/.local/bin:
# pip3 install -U --user tuxrun==0.49.2
#
# Or install a deb/rpm depending on the running distribution
# See https://tuxmake.org/install-deb/ or
# https://tuxmake.org/install-rpm/
#
# See https://tuxrun.org/ for complete documentation.

tuxrun --runtime podman --device qemu-arm64 --boot-args rw --kernel
https://storage.tuxsuite.com/public/linaro/lkft/builds/2Wpo3Fqa5DhxsWQjZYBnbqMmD8X/Image.gz
--modules https://storage.tuxsuite.com/public/linaro/lkft/builds/2Wpo3Fqa5DhxsWQjZYBnbqMmD8X/modules.tar.xz
--rootfs https://storage.tuxboot.com/debian/bookworm/arm64/rootfs.ext4.xz
--parameters SKIPFILE=skipfile-lkft.yaml --image
docker.io/linaro/tuxrun-dispatcher:v0.49.2 --tests ltp-hugetlb
--timeouts boot=30 ltp-hugetlb=20 --overlay
https://storage.tuxboot.com/overlays/debian/bookworm/arm64/ltp/20230516/ltp.tar.xz

--
Linaro LKFT
https://lkft.linaro.org
