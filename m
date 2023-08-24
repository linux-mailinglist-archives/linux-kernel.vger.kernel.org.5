Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CF9786FCB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbjHXM7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbjHXM7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:59:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CA7CEE;
        Thu, 24 Aug 2023 05:59:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1826261306;
        Thu, 24 Aug 2023 12:59:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E36C433C8;
        Thu, 24 Aug 2023 12:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692881972;
        bh=snPHD4c7d2aIY4YhqIfb16ZC3nzuCX0tPCe/yD5ges8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d/NVLj8nUYJGrpEJA1MYjylU33H+a4UPR4J+0mPcRIOPmFsNAIn/qCq01ZJwbvT0O
         CGBhRtGmZiuTD3IiHc+CEXNG+lW+Sb4yXcfPvqd9PqcNXozH9g72maBcpZ5m6SEj2d
         0q8jG96UrIQCsglJ4E90AYk+lCzGlG/j1p7VgraXWorSfrF3BLDJ0bEtdtPS4O5ipn
         XaJ2nSzbqz7/TeSUkowi+9B5QzmUbFefPdRVbO8bc2MQ141aFNZFgA+QrVqvlmDnX3
         xx8ro0LeKFpvvWsl/hy/KO4UHoe/u15u7j+2Py9kNB+TLj8oo6vqnL7VImxPlgxUlE
         mIwHFXOs5Mklg==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso102818481fa.1;
        Thu, 24 Aug 2023 05:59:32 -0700 (PDT)
X-Gm-Message-State: AOJu0YyOsZV4SceovcWdv0NIZp0RpP/WhdWbhYSroX71XcPwYiEqx60Z
        IvuF1hDPPDxH7RBwibxFYk3k/ICNoGr/gtdzgw==
X-Google-Smtp-Source: AGHT+IE26VdDO97jXusJ/BKAY46cdvlJP4w8205Z5cvIeq2QmJkb2CsQmCLK1upTBH90qdJx0zQQO+LdL8jCa8DGBro=
X-Received: by 2002:a2e:7008:0:b0:2bc:d8fd:13df with SMTP id
 l8-20020a2e7008000000b002bcd8fd13dfmr4641558ljc.41.1692881970476; Thu, 24 Aug
 2023 05:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <202308241628.feb8dbbf-oliver.sang@intel.com>
In-Reply-To: <202308241628.feb8dbbf-oliver.sang@intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 24 Aug 2023 07:59:17 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKFhsEMO9=rTRDiO=3CD1jOK4QuUDnKM+bSDgrYHSZHNA@mail.gmail.com>
Message-ID: <CAL_JsqKFhsEMO9=rTRDiO=3CD1jOK4QuUDnKM+bSDgrYHSZHNA@mail.gmail.com>
Subject: Re: [linus:master] [of] 74df14cd30: WARNING:at_lib/refcount.c:#refcount_warn_saturate
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 3:42=E2=80=AFAM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "WARNING:at_lib/refcount.c:#refcount_warn_satur=
ate" on:
>
> commit: 74df14cd301a1433947077e79ce2c610654a32e7 ("of: unittest: add node=
 lifecycle tests")

Perhaps that is the unittest which has a test to generate the WARN?
Not enough context from the log. It should be preceded by EXPECT
statements.

> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> [test failed on linux-next/master e3f80d3eae76c3557b3c9b5938ad01c0e6cf25e=
c]
>
> in testcase: boot
>
> compiler: gcc-7
> test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202308241628.feb8dbbf-oliver.san=
g@intel.com
>
>
> [   70.442557][    T1] ------------[ cut here ]------------
> [   70.443874][    T1] refcount_t: addition on 0; use-after-free.
> [ 70.445250][ T1] WARNING: CPU: 1 PID: 1 at lib/refcount.c:25 refcount_wa=
rn_saturate (lib/refcount.c:25 (discriminator 3))
> [   70.447754][    T1] Modules linked in:
> [   70.448750][    T1] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G          =
      TN 6.2.0-rc1-00057-g74df14cd301a #1 fcca16d7341229f468256f53411c1bbb3=
612d6fc
> [   70.451836][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 19=
96), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [ 70.454292][ T1] EIP: refcount_warn_saturate (lib/refcount.c:25 (discrim=
inator 3))
> [ 70.455655][ T1] Code: c6 05 3e 40 ed c3 01 e8 5d 62 97 ff 0f 0b eb 76 8=
0 3d 3d 40 ed c3 00 75 6e 68 f0 5a 54 c3 c6 05 3d 40 ed c3 01 e8 3f 62 97 f=
f <0f> 0b eb 58 80 3d 3c 40 ed c3 00 75 50 68 1c 5b 54 c3 c6 05 3c 40
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   c6 05 3e 40 ed c3 01    movb   $0x1,-0x3c12bfc2(%rip)        # 0x=
ffffffffc3ed4045
>    7:   e8 5d 62 97 ff          callq  0xffffffffff976269
>    c:   0f 0b                   ud2
>    e:   eb 76                   jmp    0x86
>   10:   80 3d 3d 40 ed c3 00    cmpb   $0x0,-0x3c12bfc3(%rip)        # 0x=
ffffffffc3ed4054
>   17:   75 6e                   jne    0x87
>   19:   68 f0 5a 54 c3          pushq  $0xffffffffc3545af0
>   1e:   c6 05 3d 40 ed c3 01    movb   $0x1,-0x3c12bfc3(%rip)        # 0x=
ffffffffc3ed4062
>   25:   e8 3f 62 97 ff          callq  0xffffffffff976269
>   2a:*  0f 0b                   ud2             <-- trapping instruction
>   2c:   eb 58                   jmp    0x86
>   2e:   80 3d 3c 40 ed c3 00    cmpb   $0x0,-0x3c12bfc4(%rip)        # 0x=
ffffffffc3ed4071
>   35:   75 50                   jne    0x87
>   37:   68 1c 5b 54 c3          pushq  $0xffffffffc3545b1c
>   3c:   c6                      .byte 0xc6
>   3d:   05                      .byte 0x5
>   3e:   3c 40                   cmp    $0x40,%al
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   0f 0b                   ud2
>    2:   eb 58                   jmp    0x5c
>    4:   80 3d 3c 40 ed c3 00    cmpb   $0x0,-0x3c12bfc4(%rip)        # 0x=
ffffffffc3ed4047
>    b:   75 50                   jne    0x5d
>    d:   68 1c 5b 54 c3          pushq  $0xffffffffc3545b1c
>   12:   c6                      .byte 0xc6
>   13:   05                      .byte 0x5
>   14:   3c 40                   cmp    $0x40,%al
> [   70.460090][    T1] EAX: 0000002a EBX: edf25dfc ECX: 00000000 EDX: 000=
00001
> [   70.461715][    T1] ESI: ffffffff EDI: edf20140 EBP: c5803c98 ESP: c58=
03c94
> [   70.463395][    T1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAG=
S: 00010082
> [   70.465280][    T1] CR0: 80050033 CR2: 00000000 CR3: 04312000 CR4: 000=
406f0
> [   70.466949][    T1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 000=
00000
> [   70.468627][    T1] DR6: fffe0ff0 DR7: 00000400
> [   70.469791][    T1] Call Trace:
> [ 70.470624][ T1] kobject_get (lib/kobject.c:630)
> [ 70.471657][ T1] of_node_get (drivers/of/dynamic.c:37)
> [ 70.472723][ T1] of_fwnode_get (drivers/of/property.c:866 (discriminator=
 4))
> [ 70.473833][ T1] fwnode_handle_get (drivers/base/property.c:822)
> [ 70.475019][ T1] fwnode_get_nth_parent (drivers/base/property.c:686)
> [ 70.476273][ T1] fwnode_full_name_string (lib/vsprintf.c:2091 (discrimin=
ator 3))
> [ 70.477560][ T1] device_node_string (lib/vsprintf.c:2143)
> [ 70.478752][ T1] ? sched_clock_cpu (kernel/sched/clock.c:364)
> [ 70.479932][ T1] ? __lock_acquire (kernel/locking/lockdep.c:3746 kernel/=
locking/lockdep.c:3799 kernel/locking/lockdep.c:5055)
> [ 70.481114][ T1] pointer (lib/vsprintf.c:2452)
> [ 70.482112][ T1] vsnprintf (lib/vsprintf.c:2800)
> [ 70.483212][ T1] vprintk_store (kernel/printk/printk.c:2241)
> [ 70.484369][ T1] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91)
> [ 70.485663][ T1] ? sched_clock (arch/x86/kernel/tsc.c:254)
> [ 70.486742][ T1] vprintk_emit (kernel/printk/printk.c:2338)
> [ 70.487814][ T1] vprintk_default (kernel/printk/printk.c:2369)
> [ 70.488983][ T1] vprintk (kernel/printk/printk_safe.c:51)
> [ 70.489980][ T1] _printk (kernel/printk/printk.c:2382)
> [ 70.490957][ T1] of_node_release (drivers/of/dynamic.c:343)
> [ 70.492067][ T1] kobject_release (lib/kobject.c:677 lib/kobject.c:704)
> [ 70.493179][ T1] kobject_put (include/linux/kref.h:65 lib/kobject.c:721)
> [ 70.494272][ T1] of_node_put (drivers/of/dynamic.c:49)
> [ 70.495302][ T1] of_unittest (drivers/of/unittest.c:3060 drivers/of/unit=
test.c:3650)
> [ 70.496497][ T1] ? of_unittest_changeset (drivers/of/unittest.c:3605)
> [ 70.497818][ T1] do_one_initcall (init/main.c:1306)
> [ 70.498945][ T1] ? rcu_read_lock_sched_held (kernel/rcu/update.c:125)
> [ 70.500257][ T1] ? trace_initcall_level (include/trace/events/initcall.h=
:10)
> [ 70.501552][ T1] ? kernel_init_freeable (init/main.c:1378 init/main.c:13=
95 init/main.c:1414 init/main.c:1634)
> [ 70.502817][ T1] kernel_init_freeable (init/main.c:1378 init/main.c:1395=
 init/main.c:1414 init/main.c:1634)
> [ 70.504101][ T1] ? rest_init (init/main.c:1514)
> [ 70.505225][ T1] kernel_init (init/main.c:1524)
> [ 70.506294][ T1] ret_from_fork (arch/x86/entry/entry_32.S:770)
> [   70.507381][    T1] irq event stamp: 2968680
> [ 70.508481][ T1] hardirqs last enabled at (2968679): kmem_cache_free (ar=
ch/x86/include/asm/irqflags.h:29 arch/x86/include/asm/irqflags.h:70 arch/x8=
6/include/asm/irqflags.h:130 mm/slab.c:3581 mm/slab.c:3605)
> [ 70.510605][ T1] hardirqs last disabled at (2968680): vprintk_store (arc=
h/x86/include/asm/preempt.h:27 (discriminator 3) kernel/printk/printk.c:206=
1 (discriminator 3) kernel/printk/printk.c:2221 (discriminator 3))
> [ 70.512664][ T1] softirqs last enabled at (2968660): __do_softirq (arch/=
x86/include/asm/preempt.h:27 kernel/softirq.c:415 kernel/softirq.c:600)
> [ 70.514774][ T1] softirqs last disabled at (2968651): do_softirq_own_sta=
ck (arch/x86/kernel/irq_32.c:57 arch/x86/kernel/irq_32.c:147)
> [   70.516984][    T1] ---[ end trace 0000000000000000 ]---
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20230824/202308241628.feb8dbbf-ol=
iver.sang@intel.com
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
