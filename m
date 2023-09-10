Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B92799C43
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 03:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344697AbjIJBsd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 9 Sep 2023 21:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbjIJBsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 21:48:32 -0400
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDCD1BF
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 18:48:26 -0700 (PDT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1c3a2f46244so8076635ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 18:48:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694310506; x=1694915306;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9+iOuaPRQ3WQ6FHRuCILzt8vhmj/+WunUIAP8UAdGM=;
        b=L2mc7oG/DocuxQ66rfHW7H+JdXmlKMKhSA0C9hbB4ohZMsgdY9FB5Z9AGCRn1Ac58w
         Ko2HmmEtZIkL6JVmCtyxgDk0N2h/bUKTXyX6kSLtHQgXUrgYEp6H8L34HvafgftDrIvy
         dqnz3sJNkF311QCRRI8ZoBqOnWGIHmrNe5EwOsKZ6ASzxDZr6OvgOzmMigNJNvSpPdgL
         6mypwjCa+pjtQK9Z5eVxQ52qfEAt00Uc37wPHFq9jvdNgcu6ZUehr7HwPvf9udrneNtk
         37PcUjnB0uB6vH6LR+MSfNltV3juBEGPx25iiHGlY9iYDHFPgmGmnnGr/cqqJFZXIHp2
         hlmg==
X-Gm-Message-State: AOJu0YwLvhTnfFYsMOSfJHCTNRWtkpsc5dMY2J3NHPUWjEXNA9+p5AWp
        USS35a0OXDqETLMd9oG6SMVN6/BGZ4j115Ia5zMspNeISJJS
X-Google-Smtp-Source: AGHT+IFe0nmy31SxPFgLgqbxOUt6gJALrYRGDwRFc+ZmIua35Gxy3p8lr+/6vJUX2a8T60nE4tKLSVur/EhfuJWDjnFFaGhUzE61
MIME-Version: 1.0
X-Received: by 2002:a17:902:f546:b0:1c3:83e2:d0ad with SMTP id
 h6-20020a170902f54600b001c383e2d0admr2089373plf.9.1694310506073; Sat, 09 Sep
 2023 18:48:26 -0700 (PDT)
Date:   Sat, 09 Sep 2023 18:48:25 -0700
In-Reply-To: <20230910012546.6049-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000da93b60604f767b6@google.com>
Subject: Re: [syzbot] [mm?] BUG: Bad page map (7)
From:   syzbot <syzbot+55cc72f8cc3a549119df@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

6128][    T1] Bluetooth: CMTP socket layer initialized
[   11.167105][    T1] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[   11.168195][    T1] Bluetooth: HIDP socket layer initialized
[   11.172202][    T1] NET: Registered PF_RXRPC protocol family
[   11.173221][    T1] Key type rxrpc registered
[   11.174103][    T1] Key type rxrpc_s registered
[   11.175373][    T1] NET: Registered PF_KCM protocol family
[   11.177012][    T1] lec:lane_module_init: lec.c: initialized
[   11.178099][    T1] mpoa:atm_mpoa_init: mpc.c: initialized
[   11.179340][    T1] l2tp_core: L2TP core driver, V2.0
[   11.180274][    T1] l2tp_ppp: PPPoL2TP kernel driver, V2.0
[   11.181142][    T1] l2tp_ip: L2TP IP encapsulation support (L2TPv3)
[   11.182523][    T1] l2tp_netlink: L2TP netlink interface
[   11.183484][    T1] l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
[   11.184413][    T1] l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2TPv3)
[   11.185606][    T1] NET: Registered PF_PHONET protocol family
[   11.186593][    T1] 8021q: 802.1Q VLAN Support v1.8
[   11.200112][    T1] DCCP: Activated CCID 2 (TCP-like)
[   11.201028][    T1] DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
[   11.202450][    T1] DCCP is deprecated and scheduled to be removed in 2025, please contact the netdev mailing list
[   11.204370][    T1] sctp: Hash tables configured (bind 32/56)
[   11.206695][    T1] NET: Registered PF_RDS protocol family
[   11.208580][    T1] Registered RDS/infiniband transport
[   11.209974][    T1] Registered RDS/tcp transport
[   11.210991][    T1] tipc: Activated (version 2.0.0)
[   11.211996][    T1] NET: Registered PF_TIPC protocol family
[   11.213362][    T1] tipc: Started in single node mode
[   11.215000][    T1] NET: Registered PF_SMC protocol family
[   11.216427][    T1] 9pnet: Installing 9P2000 support
[   11.218072][    T1] NET: Registered PF_CAIF protocol family
[   11.224698][    T1] NET: Registered PF_IEEE802154 protocol family
[   11.225896][    T1] Key type dns_resolver registered
[   11.227373][    T1] Key type ceph registered
[   11.228473][    T1] libceph: loaded (mon/osd proto 15/24)
[   11.230827][    T1] batman_adv: B.A.T.M.A.N. advanced 2023.3 (compatibility version 15) loaded
[   11.232604][    T1] openvswitch: Open vSwitch switching datapath
[   11.235717][    T1] NET: Registered PF_VSOCK protocol family
[   11.236769][    T1] mpls_gso: MPLS GSO support
[   11.243298][    T1] start plist test
[   11.247904][    T1] end plist test
[   11.253615][    T1] IPI shorthand broadcast: enabled
[   11.254447][    T1] AVX2 version of gcm_enc/dec engaged.
[   11.255539][    T1] AES CTR mode by8 optimization enabled
[   12.602761][    T1] sched_clock: Marking stable (12570027239, 29094014)->(12607351949, -8230696)
[   12.606252][    T1] registered taskstats version 1
[   12.616134][    T1] Loading compiled-in X.509 certificates
[   12.621456][    T1] Loaded X.509 cert 'Build time autogenerated kernel key: 0fcda5d31b9f9e23b67f9531e962fbe56b39254a'
[   12.627580][    T1] zswap: loaded using pool lzo/zbud
[   12.790353][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
[   14.931835][    T1] Key type .fscrypt registered
[   14.936714][    T1] Key type fscrypt-provisioning registered
[   14.948499][    T1] kAFS: Red Hat AFS client v0.1 registering.
[   14.968179][    T1] Btrfs loaded, assert=on, ref-verify=on, zoned=yes, fsverity=yes
[   14.976514][    T1] Key type big_key registered
[   14.983726][    T1] Key type encrypted registered
[   14.988784][    T1] ima: No TPM chip found, activating TPM-bypass!
[   14.995300][    T1] Loading compiled-in module X.509 certificates
[   15.004766][    T1] Loaded X.509 cert 'Build time autogenerated kernel key: 0fcda5d31b9f9e23b67f9531e962fbe56b39254a'
[   15.015603][    T1] ima: Allocated hash algorithm: sha256
[   15.021319][    T1] ima: No architecture policies found
[   15.026950][    T1] evm: Initialising EVM extended attributes:
[   15.032950][    T1] evm: security.selinux (disabled)
[   15.038150][    T1] evm: security.SMACK64
[   15.042312][    T1] evm: security.SMACK64EXEC
[   15.046787][    T1] evm: security.SMACK64TRANSMUTE
[   15.051729][    T1] evm: security.SMACK64MMAP
[   15.056388][    T1] evm: security.apparmor (disabled)
[   15.062008][    T1] evm: security.ima
[   15.065787][    T1] evm: security.capability
[   15.072963][    T1] evm: HMAC attrs: 0x1
[   15.078819][    T1] PM:   Magic number: 7:6:660
[   15.084338][    T1] block ram13: hash matches
[   15.088945][    T1] tty ptyeb: hash matches
[   15.095332][    T1] printk: console [netcon0] enabled
[   15.100612][    T1] netconsole: network logging started
[   15.106370][    T1] gtp: GTP module loaded (pdp ctx size 104 bytes)
[   15.113617][    T1] rdma_rxe: loaded
[   15.118018][    T1] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   15.128407][    T1] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   15.135560][   T27] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[   15.139271][    T1] clk: Disabling unused clocks
[   15.146516][   T27] platform regulatory.0: Falling back to sysfs fallback for: regulatory.db
[   15.149815][    T1] ALSA device list:
[   15.149823][    T1]   #0: Dummy 1
[   15.165921][    T1]   #1: Loopback 1
[   15.169835][    T1]   #2: Virtual MIDI Card 1
[   15.176161][    T1] md: Waiting for all devices to be available before autodetect
[   15.184171][    T1] md: If you don't use raid, use raid=noautodetect
[   15.190736][    T1] md: Autodetecting RAID arrays.
[   15.195704][    T1] md: autorun ...
[   15.199351][    T1] md: ... autorun DONE.
[   15.221012][    T1] EXT4-fs (sda1): mounted filesystem 5941fea2-f5fa-4b4e-b5ef-9af118b27b95 ro with ordered data mode. Quota mode: none.
[   15.233646][    T1] VFS: Mounted root (ext4 filesystem) readonly on device 8:1.
[   15.242842][    T1] devtmpfs: mounted
[   15.334482][    T1] Freeing unused kernel image (initmem) memory: 2888K
[   15.341305][    T1] Write protecting the kernel read-only data: 196608k
[   15.351574][    T1] Freeing unused kernel image (rodata/data gap) memory: 1744K
[   15.456635][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[   15.470328][    T1] Failed to set sysctl parameter 'max_rcu_stall_to_panic=1': parameter not found
[   15.480231][    T1] Run /sbin/init as init process
[   15.485161][    T1]   with arguments:
[   15.488944][    T1]     /sbin/init
[   15.492542][    T1]   with environment:
[   15.496505][    T1]     HOME=/
[   15.499813][    T1]     TERM=linux
[   15.503335][    T1]     spec_store_bypass_disable=prctl
[   15.508699][    T1]     BOOT_IMAGE=/boot/bzImage
[   15.527423][    T1] ------------[ cut here ]------------
[   15.533025][    T1] kernel BUG at mm/page_table_check.c:121!
[   15.538936][    T1] invalid opcode: 0000 [#1] PREEMPT SMP KASAN
[   15.544990][    T1] CPU: 1 PID: 1 Comm: init Not tainted 6.5.0-syzkaller-12921-ga3c57ab79a06-dirty #0
[   15.554359][    T1] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
[   15.564598][    T1] RIP: 0010:page_table_check_set+0x592/0x860
[   15.570694][    T1] Code: ff e8 22 c9 9a ff 48 ff cb e9 5d fd ff ff e8 15 c9 9a ff 48 ff cb 49 89 df e9 dd fd ff ff e8 05 c9 9a ff 0f 0b e8 fe c8 9a ff <0f> 0b e8 f7 c8 9a ff 0f 0b e8 f0 c8 9a ff 0f 0b e8 e9 c8 9a ff 0f
[   15.590306][    T1] RSP: 0000:ffffc90000067738 EFLAGS: 00010293
[   15.596503][    T1] RAX: ffffffff81f2ddf2 RBX: ffff88801aa3cec0 RCX: ffff888015e60000
[   15.604482][    T1] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
[   15.612475][    T1] RBP: 0000000000000001 R08: ffffffff81f2dc65 R09: 1ffff110035479d8
[   15.620471][    T1] R10: dffffc0000000000 R11: ffffed10035479d9 R12: ffff88801aa3ce80
[   15.628441][    T1] R13: 0000000000000020 R14: 1ffffffff23ec5fc R15: 0000000000000000
[   15.636433][    T1] FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
[   15.645376][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.651953][    T1] CR2: 00007fade5d58d20 CR3: 000000001b89b000 CR4: 00000000003506e0
[   15.659929][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   15.667892][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   15.675879][    T1] Call Trace:
[   15.679152][    T1]  <TASK>
[   15.682078][    T1]  ? __die_body+0x8b/0xe0
[   15.686493][    T1]  ? die+0xa1/0xd0
[   15.690250][    T1]  ? do_trap+0x153/0x380
[   15.694486][    T1]  ? page_table_check_set+0x592/0x860
[   15.699880][    T1]  ? do_error_trap+0x1dc/0x2c0
[   15.704670][    T1]  ? page_table_check_set+0x592/0x860
[   15.710059][    T1]  ? do_int3+0x50/0x50
[   15.714134][    T1]  ? handle_invalid_op+0x34/0x40
[   15.719095][    T1]  ? page_table_check_set+0x592/0x860
[   15.724474][    T1]  ? exc_invalid_op+0x33/0x50
[   15.729226][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[   15.734259][    T1]  ? page_table_check_set+0x405/0x860
[   15.739663][    T1]  ? page_table_check_set+0x592/0x860
[   15.745064][    T1]  ? page_table_check_set+0x592/0x860
[   15.750435][    T1]  ? page_table_check_set+0x592/0x860
[   15.755814][    T1]  __page_table_check_ptes_set+0x220/0x280
[   15.761624][    T1]  ? __page_table_check_pud_clear+0xb0/0xb0
[   15.767533][    T1]  ? folio_add_file_rmap_range+0x55e/0x840
[   15.773354][    T1]  set_pte_range+0x8fa/0x920
[   15.777936][    T1]  ? xas_find+0x339/0xaa0
[   15.782274][    T1]  ? mm_counter_file+0x2c0/0x2c0
[   15.787206][    T1]  ? next_uptodate_folio+0xa5d/0xb10
[   15.792473][    T1]  filemap_map_pages+0xc23/0x1560
[   15.797501][    T1]  ? filemap_read_folio+0x770/0x770
[   15.802683][    T1]  ? __lock_acquire+0x7f70/0x7f70
[   15.807696][    T1]  ? pte_offset_map_nolock+0x137/0x1e0
[   15.813228][    T1]  ? kasan_save_stack+0x4f/0x60
[   15.818073][    T1]  ? __kasan_record_aux_stack+0xad/0xc0
[   15.823601][    T1]  ? call_rcu+0x167/0xa70
[   15.827909][    T1]  ? task_work_run+0x24a/0x300
[   15.832656][    T1]  ? exit_to_user_mode_prepare+0xb1/0x140
[   15.838445][    T1]  ? filemap_read_folio+0x770/0x770
[   15.843648][    T1]  handle_mm_fault+0x47dd/0x6200
[   15.848599][    T1]  ? numa_migrate_prep+0x380/0x380
[   15.853694][    T1]  ? rcu_is_watching+0x15/0xb0
[   15.858436][    T1]  ? rcu_is_watching+0x15/0xb0
[   15.863180][    T1]  ? lock_release+0xbf/0x9d0
[   15.867781][    T1]  ? mtree_range_walk+0x6a0/0x7e0
[   15.872813][    T1]  ? __lock_acquire+0x7f70/0x7f70
[   15.877831][    T1]  ? lock_vma_under_rcu+0x2cf/0x6c0
[   15.883024][    T1]  ? __init_rwsem+0x160/0x160
[   15.887692][    T1]  ? mas_walk+0x224/0x260
[   15.892006][    T1]  ? lock_vma_under_rcu+0x5ab/0x6c0
[   15.897207][    T1]  ? rcu_is_watching+0x15/0xb0
[   15.901978][    T1]  exc_page_fault+0x455/0x860
[   15.906664][    T1]  asm_exc_page_fault+0x26/0x30
[   15.911500][    T1] RIP: 0033:0x7fade5d58d20
[   15.915921][    T1] Code: Unable to access opcode bytes at 0x7fade5d58cf6.
[   15.922916][    T1] RSP: 002b:00007fffac073220 EFLAGS: 00010202
[   15.928965][    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[   15.936940][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   15.944904][    T1] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[   15.952888][    T1] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   15.960847][    T1] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   15.968987][    T1]  </TASK>
[   15.972178][    T1] Modules linked in:
[   15.976221][    T1] ---[ end trace 0000000000000000 ]---
[   15.981728][    T1] RIP: 0010:page_table_check_set+0x592/0x860
[   15.987742][    T1] Code: ff e8 22 c9 9a ff 48 ff cb e9 5d fd ff ff e8 15 c9 9a ff 48 ff cb 49 89 df e9 dd fd ff ff e8 05 c9 9a ff 0f 0b e8 fe c8 9a ff <0f> 0b e8 f7 c8 9a ff 0f 0b e8 f0 c8 9a ff 0f 0b e8 e9 c8 9a ff 0f
[   16.007555][    T1] RSP: 0000:ffffc90000067738 EFLAGS: 00010293
[   16.013643][    T1] RAX: ffffffff81f2ddf2 RBX: ffff88801aa3cec0 RCX: ffff888015e60000
[   16.021641][    T1] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
[   16.029615][    T1] RBP: 0000000000000001 R08: ffffffff81f2dc65 R09: 1ffff110035479d8
[   16.037570][    T1] R10: dffffc0000000000 R11: ffffed10035479d9 R12: ffff88801aa3ce80
[   16.045595][    T1] R13: 0000000000000020 R14: 1ffffffff23ec5fc R15: 0000000000000000
[   16.053591][    T1] FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
[   16.062632][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.069231][    T1] CR2: 00007fade5d58cf6 CR3: 000000001b89b000 CR4: 00000000003506e0
[   16.077285][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   16.085270][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   16.093277][    T1] Kernel panic - not syncing: Fatal exception
[   16.099524][    T1] Kernel Offset: disabled
[   16.103871][    T1] Rebooting in 86400 seconds..


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
GOGCCFLAGS="-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build283487419=/tmp/go-build -gno-record-gcc-switches"

git status (err=<nil>)
HEAD detached at 8bc9053e8
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
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=8bc9053e88dacf57f5ce550da040d31895eb9626 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230904-115818'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer github.com/google/syzkaller/syz-fuzzer
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=8bc9053e88dacf57f5ce550da040d31895eb9626 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230904-115818'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=8bc9053e88dacf57f5ce550da040d31895eb9626 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230904-115818'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-larger-than=16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -static-pie -fpermissive -w -DGOOS_linux=1 -DGOARCH_amd64=1 \
	-DHOSTGOOS_linux=1 -DGIT_REVISION=\"8bc9053e88dacf57f5ce550da040d31895eb9626\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=14f77e1c680000


Tested on:

commit:         a3c57ab7 iov_iter: Kunit tests for page extraction
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=50ac7dadde9e1c0e
dashboard link: https://syzkaller.appspot.com/bug?extid=55cc72f8cc3a549119df
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15f413fc680000

