Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F040A7EDA8C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 05:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344645AbjKPECM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Nov 2023 23:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjKPECK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 23:02:10 -0500
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01356194
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 20:02:05 -0800 (PST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cc23f2226bso4638375ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 20:02:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700107324; x=1700712124;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyibUagDJo2hyh6//Jp5SOQDyeyIdvVKzG/nfGjEbyo=;
        b=CXNEsd8/12TEKBwug33GgTlo784mVNrQaRfYFdjTVFFXo00qpRvjfcF+LamzRRwxyE
         sTTcRphpeHQGdN2fL0y48Hb+a0EBtDd+w77WFHoIhOAx+TnW0t+xRUsh4JZq9mZyNKZh
         mDdPEMuAswNnh267XSVkW3sBOloCdPAvsRvd31vB5nIh0y0MpdpZGWlvS4TyXARux5Ys
         hkQAVHSHYRzD7uMc/0lEflSvBZTmoSeTRWjGcEu1zV2o6FHSocebpPexMGaC3r+X2KnT
         KwMN88KIjOaClg6HLXnyxA+JfRj5/3B8E3GvM1PVKmMvK4fubUy9tQgc3PdYv/YPsY+q
         7JkA==
X-Gm-Message-State: AOJu0YxmF8SQLuoWJOcUWJAbhYVq1ADFsywyxnalz8yv+caQarSeJMZ6
        CKLVng1qUuKMVflQL7J3cH5acZQ6EODCyH1VB9tllNQbpQ33Lo4=
X-Google-Smtp-Source: AGHT+IHn0QEnnYEbL3ETPVgSmz3x42TqfO9NL73Bmouo4UcxBBFZsv3BWwM0n8V2wpC5UpCRppFlzVjwffgCTcoMbhG0PHMCB4Z8
MIME-Version: 1.0
X-Received: by 2002:a17:902:cec8:b0:1ca:8e79:53b7 with SMTP id
 d8-20020a170902cec800b001ca8e7953b7mr2262913plg.9.1700107324612; Wed, 15 Nov
 2023 20:02:04 -0800 (PST)
Date:   Wed, 15 Nov 2023 20:02:04 -0800
In-Reply-To: <CAGuQ_7jmT0_GAYyGHZc1JVfi0P_e4Rum2nLXVZjnsS2EOVo0kA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000029e61a060a3d1577@google.com>
Subject: Re: [syzbot] [dri?] divide error in drm_mode_debug_printmodeline
From:   syzbot <syzbot+2e93e6fb36e6fdc56574@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, mazinalhaddad05@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

gured (established 65536 bind 65536)
[    4.698580][    T1] MPTCP token hash table entries: 8192 (order: 7, 720896 bytes, vmalloc)
[    4.706186][    T1] UDP hash table entries: 4096 (order: 7, 655360 bytes, vmalloc)
[    4.712412][    T1] UDP-Lite hash table entries: 4096 (order: 7, 655360 bytes, vmalloc)
[    4.716658][    T1] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    4.722357][    T1] RPC: Registered named UNIX socket transport module.
[    4.724212][    T1] RPC: Registered udp transport module.
[    4.725069][    T1] RPC: Registered tcp transport module.
[    4.727091][    T1] RPC: Registered tcp-with-tls transport module.
[    4.729048][    T1] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    4.737515][    T1] NET: Registered PF_XDP protocol family
[    4.739697][    T1] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    4.741876][    T1] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    4.743898][    T1] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    4.745227][    T1] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfefff window]
[    4.748706][    T1] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    4.750117][    T1] PCI: CLS 0 bytes, default 64
[    4.759463][    T1] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    4.761040][    T1] software IO TLB: mapped [mem 0x00000000b5800000-0x00000000b9800000] (64MB)
[    4.762515][    T1] ACPI: bus type thunderbolt registered
[    4.770381][   T60] kworker/u4:2 (60) used greatest stack depth: 26296 bytes left
[    4.773156][    T1] RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters, 10737418240 ms ovfl timer
[    4.798952][    T1] kvm_amd: CPU 0 isn't AMD or Hygon
[    4.800516][    T1] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1fb6cbb9648, max_idle_ns: 440795209148 ns
[    4.802622][    T1] clocksource: Switched to clocksource tsc
[    4.834894][   T74] kworker/u4:4 (74) used greatest stack depth: 25160 bytes left
[    6.218409][    T1] Initialise system trusted keyrings
[    6.225315][    T1] workingset: timestamp_bits=40 max_order=21 bucket_order=0
[    6.234279][    T1] DLM installed
[    6.238005][    T1] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    6.244851][    T1] NFS: Registering the id_resolver key type
[    6.246129][    T1] Key type id_resolver registered
[    6.247316][    T1] Key type id_legacy registered
[    6.248729][    T1] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    6.250443][    T1] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
[    6.258315][    T1] Key type cifs.spnego registered
[    6.259636][    T1] Key type cifs.idmap registered
[    6.260830][    T1] ntfs: driver 2.1.32 [Flags: R/W].
[    6.261994][    T1] ntfs3: Max link count 4000
[    6.262684][    T1] ntfs3: Enabled Linux POSIX ACLs support
[    6.263806][    T1] ntfs3: Read-only LZX/Xpress compression included
[    6.265613][    T1] efs: 1.0a - http://aeschi.ch.eu.org/efs/
[    6.268103][    T1] jffs2: version 2.2. (NAND) (SUMMARY)  © 2001-2006 Red Hat, Inc.
[    6.271702][    T1] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
[    6.273229][    T1] QNX4 filesystem 0.2.3 registered.
[    6.275322][    T1] qnx6: QNX6 filesystem 1.0.0 registered.
[    6.277012][    T1] fuse: init (API version 7.39)
[    6.281606][    T1] orangefs_debugfs_init: called with debug mask: :none: :0:
[    6.284051][    T1] orangefs_init: module version upstream loaded
[    6.285490][    T1] JFS: nTxBlock = 8192, nTxLock = 65536
[    6.313750][    T1] SGI XFS with ACLs, security attributes, realtime, quota, no debug enabled
[    6.319015][    T1] 9p: Installing v9fs 9p2000 file system support
[    6.320322][    T1] NILFS version 2 loaded
[    6.321452][    T1] befs: version: 0.9.3
[    6.322601][    T1] ocfs2: Registered cluster interface o2cb
[    6.324174][    T1] ocfs2: Registered cluster interface user
[    6.325892][    T1] OCFS2 User DLM kernel interface loaded
[    6.341871][    T1] gfs2: GFS2 installed
[    6.353461][    T1] ceph: loaded (mds proto 32)
[    6.379550][    T1] NET: Registered PF_ALG protocol family
[    6.381038][    T1] xor: automatically using best checksumming function   avx       
[    6.382602][    T1] async_tx: api initialized (async)
[    6.383352][    T1] Key type asymmetric registered
[    6.384356][    T1] Asymmetric key parser 'x509' registered
[    6.385383][    T1] Asymmetric key parser 'pkcs8' registered
[    6.386451][    T1] Key type pkcs7_test registered
[    6.387489][    T1] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 239)
[    6.389957][    T1] io scheduler mq-deadline registered
[    6.390822][    T1] io scheduler kyber registered
[    6.391899][    T1] io scheduler bfq registered
[    6.402210][    T1] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    6.416990][    T1] ACPI: button: Power Button [PWRF]
[    6.420110][    T1] input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
[    6.423549][    T1] ACPI: button: Sleep Button [SLPF]
[    6.437563][    T1] ioatdma: Intel(R) QuickData Technology Driver 5.00
[    6.464441][    T1] ACPI: \_SB_.LNKC: Enabled at IRQ 11
[    6.467125][    T1] virtio-pci 0000:00:03.0: virtio_pci: leaving for legacy driver
[    6.493366][    T1] ACPI: \_SB_.LNKD: Enabled at IRQ 10
[    6.494395][    T1] virtio-pci 0000:00:04.0: virtio_pci: leaving for legacy driver
[    6.520948][    T1] ACPI: \_SB_.LNKB: Enabled at IRQ 10
[    6.522290][    T1] virtio-pci 0000:00:06.0: virtio_pci: leaving for legacy driver
[    6.542518][    T1] virtio-pci 0000:00:07.0: virtio_pci: leaving for legacy driver
[    6.681895][  T276] kworker/u4:4 (276) used greatest stack depth: 25000 bytes left
[    7.183861][    T1] N_HDLC line discipline registered with maxframe=4096
[    7.185565][    T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    7.191098][    T1] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    7.206122][    T1] 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    7.222125][    T1] 00:05: ttyS2 at I/O 0x3e8 (irq = 6, base_baud = 115200) is a 16550A
[    7.234572][    T1] 00:06: ttyS3 at I/O 0x2e8 (irq = 7, base_baud = 115200) is a 16550A
[    7.262180][    T1] Non-volatile memory driver v1.3
[    7.282424][    T1] Linux agpgart interface v0.103
[    7.296450][    T1] ACPI: bus type drm_connector registered
[    7.307285][    T1] [drm] Initialized vgem 1.0.0 20120112 for vgem on minor 0
[    7.319716][    T1] [drm] Initialized vkms 1.0.0 20180514 for vkms on minor 1
[    7.323524][    T1] general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
[    7.325256][    T1] KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
[    7.325646][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.7.0-rc1-syzkaller-00019-gc42d9eeef8e5-dirty #0
[    7.325646][    T1] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
[    7.325646][    T1] RIP: 0010:drm_mode_vrefresh+0x9e/0x360
[    7.325646][    T1] Code: e8 d7 d9 65 fc 45 85 f6 74 73 4c 89 e0 48 c1 e8 03 42 0f b6 04 28 84 c0 0f 85 f8 01 00 00 41 8b 04 24 89 44 24 04 44 0f af f5 <41> 0f b6 45 00 84 c0 0f 85 fd 01 00 00 44 89 34 25 00 00 00 00 4d
[    7.325646][    T1] RSP: 0000:ffffc90000067050 EFLAGS: 00010202
[    7.325646][    T1] RAX: 0000000000007b0c RBX: 0000000000000000 RCX: ffff888141668000
[    7.325646][    T1] RDX: ffff888141668000 RSI: 00000000000001bd RDI: 0000000000000000
[    7.325646][    T1] RBP: 0000000000000340 R08: ffffffff8528eb99 R09: 0000000000000000
[    7.325646][    T1] R10: ffffc90000067060 R11: fffff5200000ce0f R12: ffffffff8bce3120
[    7.325646][    T1] R13: dffffc0000000000 R14: 000000000005a640 R15: ffffffff8bce312e
[    7.325646][    T1] FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
[    7.325646][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.325646][    T1] CR2: ffff88823ffff000 CR3: 000000000d730000 CR4: 00000000003506f0
[    7.325646][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    7.325646][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    7.325646][    T1] Call Trace:
[    7.325646][    T1]  <TASK>
[    7.325646][    T1]  ? __die_body+0x8b/0xe0
[    7.325646][    T1]  ? die_addr+0xc9/0x100
[    7.325646][    T1]  ? exc_general_protection+0x3c2/0x5b0
[    7.325646][    T1]  ? asm_exc_general_protection+0x26/0x30
[    7.325646][    T1]  ? drm_mode_vrefresh+0x79/0x360
[    7.325646][    T1]  ? drm_mode_vrefresh+0x9e/0x360
[    7.325646][    T1]  drm_add_modes_noedid+0xb5/0x230
[    7.325646][    T1]  vkms_conn_get_modes+0x20/0x40
[    7.325646][    T1]  drm_helper_probe_single_connector_modes+0x7d9/0x11f0
[    7.325646][    T1]  ? drm_helper_probe_detect+0x4e0/0x4e0
[    7.325646][    T1]  ? drm_client_modeset_probe+0x32c/0x4790
[    7.325646][    T1]  ? rcu_is_watching+0x15/0xb0
[    7.325646][    T1]  ? __kmalloc+0xe6/0x230
[    7.325646][    T1]  ? drm_connector_list_iter_end+0xb5/0xd0
[    7.325646][    T1]  drm_client_modeset_probe+0x433/0x4790
[    7.325646][    T1]  ? verify_lock_unused+0x140/0x140
[    7.325646][    T1]  ? _raw_spin_unlock_irqrestore+0x8f/0x140
[    7.325646][    T1]  ? lockdep_hardirqs_on+0x98/0x140
[    7.325646][    T1]  ? drm_client_modeset_release+0x300/0x300
[    7.325646][    T1]  ? __mutex_trylock_common+0x182/0x2e0
[    7.325646][    T1]  ? __might_sleep+0xc0/0xc0
[    7.325646][    T1]  ? trace_raw_output_contention_end+0xd0/0xd0
[    7.325646][    T1]  ? __mutex_trylock_common+0x182/0x2e0
[    7.325646][    T1]  __drm_fb_helper_initial_config_and_unlock+0x112/0x1e20
[    7.325646][    T1]  ? __mutex_lock+0x2ee/0xd60
[    7.325646][    T1]  ? rcu_is_watching+0x15/0xb0
[    7.325646][    T1]  ? trace_contention_end+0x3c/0xf0
[    7.325646][    T1]  ? __mutex_lock+0x2ee/0xd60
[    7.325646][    T1]  ? drm_fb_helper_initial_config+0x35/0x50
[    7.325646][    T1]  ? drm_fb_helper_initial_config+0x50/0x50
[    7.325646][    T1]  ? drm_client_register+0x4e/0x210
[    7.325646][    T1]  ? mutex_lock_nested+0x20/0x20
[    7.325646][    T1]  ? drm_prime_init_file_private+0x39/0x40
[    7.325646][    T1]  drm_fbdev_generic_client_hotplug+0x166/0x210
[    7.325646][    T1]  drm_client_register+0x17e/0x210
[    7.325646][    T1]  vkms_init+0x5f1/0x730
[    7.325646][    T1]  ? vgem_init+0x290/0x290
[    7.325646][    T1]  ? vgem_init+0x290/0x290
[    7.325646][    T1]  do_one_initcall+0x234/0x800
[    7.325646][    T1]  ? vgem_init+0x290/0x290
[    7.325646][    T1]  ? IS_ERR_OR_NULL+0x20/0x20
[    7.325646][    T1]  ? lockdep_hardirqs_on_prepare+0x43c/0x7a0
[    7.325646][    T1]  ? parameq+0x220/0x220
[    7.325646][    T1]  ? slab_post_alloc_hook+0x6c/0x3c0
[    7.325646][    T1]  ? do_initcalls+0x1c/0x80
[    7.325646][    T1]  ? rcu_is_watching+0x15/0xb0
[    7.325646][    T1]  do_initcall_level+0x157/0x210
[    7.325646][    T1]  do_initcalls+0x3f/0x80
[    7.325646][    T1]  kernel_init_freeable+0x429/0x5c0
[    7.325646][    T1]  ? obsolete_checksetup+0x200/0x200
[    7.325646][    T1]  ? print_irqtrace_events+0x220/0x220
[    7.325646][    T1]  ? rest_init+0x300/0x300
[    7.325646][    T1]  ? rest_init+0x300/0x300
[    7.325646][    T1]  ? rest_init+0x300/0x300
[    7.325646][    T1]  kernel_init+0x1d/0x2a0
[    7.325646][    T1]  ret_from_fork+0x48/0x80
[    7.325646][    T1]  ? rest_init+0x300/0x300
[    7.325646][    T1]  ret_from_fork_asm+0x11/0x20
[    7.325646][    T1]  </TASK>
[    7.325646][    T1] Modules linked in:
[    7.439276][    T1] ---[ end trace 0000000000000000 ]---
[    7.440497][    T1] RIP: 0010:drm_mode_vrefresh+0x9e/0x360
[    7.441446][    T1] Code: e8 d7 d9 65 fc 45 85 f6 74 73 4c 89 e0 48 c1 e8 03 42 0f b6 04 28 84 c0 0f 85 f8 01 00 00 41 8b 04 24 89 44 24 04 44 0f af f5 <41> 0f b6 45 00 84 c0 0f 85 fd 01 00 00 44 89 34 25 00 00 00 00 4d
[    7.444309][    T1] RSP: 0000:ffffc90000067050 EFLAGS: 00010202
[    7.445225][    T1] RAX: 0000000000007b0c RBX: 0000000000000000 RCX: ffff888141668000
[    7.446748][    T1] RDX: ffff888141668000 RSI: 00000000000001bd RDI: 0000000000000000
[    7.448285][    T1] RBP: 0000000000000340 R08: ffffffff8528eb99 R09: 0000000000000000
[    7.450542][    T1] R10: ffffc90000067060 R11: fffff5200000ce0f R12: ffffffff8bce3120
[    7.451988][    T1] R13: dffffc0000000000 R14: 000000000005a640 R15: ffffffff8bce312e
[    7.453626][    T1] FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
[    7.454940][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.456230][    T1] CR2: ffff88823ffff000 CR3: 000000000d730000 CR4: 00000000003506f0
[    7.457734][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    7.459189][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    7.460386][    T1] Kernel panic - not syncing: Fatal exception
[    7.461513][    T1] Kernel Offset: disabled
[    7.462264][    T1] Rebooting in 86400 seconds..


syzkaller build log:
go env (err=<nil>)
GO111MODULE="auto"
GOARCH="amd64"
GOBIN=""
GOCACHE="/syzkaller/.cache/go-build"
GOENV="/syzkaller/.config/go/env"
GOEXE=""
GOEXPERIMENT=""
GOFLAGS=""
GOHOSTARCH="amd64"
GOHOSTOS="linux"
GOINSECURE=""
GOMODCACHE="/syzkaller/jobs-2/linux/gopath/pkg/mod"
GONOPROXY=""
GONOSUMDB=""
GOOS="linux"
GOPATH="/syzkaller/jobs-2/linux/gopath"
GOPRIVATE=""
GOPROXY="https://proxy.golang.org,direct"
GOROOT="/usr/local/go"
GOSUMDB="sum.golang.org"
GOTMPDIR=""
GOTOOLDIR="/usr/local/go/pkg/tool/linux_amd64"
GOVCS=""
GOVERSION="go1.20.1"
GCCGO="gccgo"
GOAMD64="v1"
AR="ar"
CC="gcc"
CXX="g++"
CGO_ENABLED="1"
GOMOD="/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.mod"
GOWORK=""
CGO_CFLAGS="-O2 -g"
CGO_CPPFLAGS=""
CGO_CXXFLAGS="-O2 -g"
CGO_FFLAGS="-O2 -g"
CGO_LDFLAGS="-O2 -g"
PKG_CONFIG="pkg-config"
GOGCCFLAGS="-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build76428843=/tmp/go-build -gno-record-gcc-switches"

git status (err=<nil>)
HEAD detached at 6d6dbf8ab
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:32: run command via tools/syz-env for best compatibility, see:
Makefile:33: https://github.com/google/syzkaller/blob/master/docs/contributing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
bin/syz-sysgen
touch .descriptions
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=6d6dbf8ab21a52df701946afac2a86f93a88fdc8 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20231111-003831'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer github.com/google/syzkaller/syz-fuzzer
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=6d6dbf8ab21a52df701946afac2a86f93a88fdc8 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20231111-003831'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=6d6dbf8ab21a52df701946afac2a86f93a88fdc8 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20231111-003831'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-larger-than=16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -static-pie -fpermissive -w -DGOOS_linux=1 -DGOARCH_amd64=1 \
	-DHOSTGOOS_linux=1 -DGIT_REVISION=\"6d6dbf8ab21a52df701946afac2a86f93a88fdc8\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=1266c2b8e80000


Tested on:

commit:         c42d9eee Merge tag 'hardening-v6.7-rc2' of git://git.k..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=b5bf1661f609e7f0
dashboard link: https://syzkaller.appspot.com/bug?extid=2e93e6fb36e6fdc56574
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1459d067680000

