Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BD67A3A47
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 22:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240331AbjIQUCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 16:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240403AbjIQUBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 16:01:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E785CCA;
        Sun, 17 Sep 2023 13:00:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B74FC433CC;
        Sun, 17 Sep 2023 20:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980848;
        bh=Hwko1v1rvzx3iQJ0L5N/a4dMUqzXy6Rf1z/pKrBKUeY=;
        h=From:To:Cc:Subject:Date:From;
        b=bt15MK3wayTGqEU9eG58QufmmxkXEldRQBy30EgAgLdf7AfY5N7g5S5tbfbQp3r+p
         qcEBdOhiqlDqU6XnSstbDuBhXW50ivyGH2K/V2owUdKc/QKS4H6r3iif7JevYzPEAq
         h4HBbfhwmIJJ8qgoH+U7YOsoAvV8PCy6bXPIP7EU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 6.1 000/219] 6.1.54-rc1 review
Date:   Sun, 17 Sep 2023 21:12:07 +0200
Message-ID: <20230917191040.964416434@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.54-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.54-rc1
X-KernelTest-Deadline: 2023-09-19T19:10+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 6.1.54 release.
There are 219 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.54-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.54-rc1

Wesley Chalmers <wesley.chalmers@amd.com>
    drm/amd/display: Fix a bug when searching for insert_above_mpcc

Maciej W. Rozycki <macro@orcam.me.uk>
    MIPS: Only fiddle with CHECKFLAGS if `need-compiler'

Kuniyuki Iwashima <kuniyu@amazon.com>
    kcm: Fix error handling for SOCK_DGRAM in kcm_sendmsg().

Vadim Fedorenko <vadim.fedorenko@linux.dev>
    ixgbe: fix timestamp configuration code

Kuniyuki Iwashima <kuniyu@amazon.com>
    tcp: Fix bind() regression for v4-mapped-v6 non-wildcard address.

Kuniyuki Iwashima <kuniyu@amazon.com>
    tcp: Fix bind() regression for v4-mapped-v6 wildcard address.

Kuniyuki Iwashima <kuniyu@amazon.com>
    tcp: Factorise sk_family-independent comparison in inet_bind2_bucket_match(_addr_any).

Kuniyuki Iwashima <kuniyu@amazon.com>
    ipv6: Remove in6addr_any alternatives.

Eric Dumazet <edumazet@google.com>
    ipv6: fix ip6_sock_set_addr_preferences() typo

Sascha Hauer <s.hauer@pengutronix.de>
    net: macb: fix sleep inside spinlock

Harini Katakam <harini.katakam@xilinx.com>
    net: macb: Enable PTP unicast

Liu Jian <liujian56@huawei.com>
    net/tls: do not free tls_rec on async operation in bpf_exec_tx_verdict()

Geert Uytterhoeven <geert+renesas@glider.be>
    platform/mellanox: NVSW_SN2201 should depend on ACPI

Shravan Kumar Ramani <shravankr@nvidia.com>
    platform/mellanox: mlxbf-pmc: Fix reading of unprogrammed events

Shravan Kumar Ramani <shravankr@nvidia.com>
    platform/mellanox: mlxbf-pmc: Fix potential buffer overflows

Liming Sun <limings@nvidia.com>
    platform/mellanox: mlxbf-tmfifo: Drop jumbo frames

Liming Sun <limings@nvidia.com>
    platform/mellanox: mlxbf-tmfifo: Drop the Rx packet if no more descriptors

Shigeru Yoshida <syoshida@redhat.com>
    kcm: Fix memory leak in error path of kcm_sendmsg()

Hayes Wang <hayeswang@realtek.com>
    r8152: check budget for r8152_poll()

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: dsa: sja1105: block FDB accesses that are concurrent with a switch reset

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: dsa: sja1105: serialize sja1105_port_mcast_flood() with other FDB accesses

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: dsa: sja1105: fix multicast forwarding working only for last added mdb entry

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: dsa: sja1105: propagate exact error code from sja1105_dynamic_config_poll_valid()

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: dsa: sja1105: hide all multicast addresses from "bridge fdb show"

Ciprian Regus <ciprian.regus@analog.com>
    net:ethernet:adi:adin1110: Fix forwarding offload

Yang Yingliang <yangyingliang@huawei.com>
    net: ethernet: adi: adin1110: use eth_broadcast_addr() to assign broadcast address

Ziyang Xuan <william.xuanziyang@huawei.com>
    hsr: Fix uninit-value access in fill_frame_info()

Hangyu Hua <hbh25y@gmail.com>
    net: ethernet: mtk_eth_soc: fix possible NULL pointer dereference in mtk_hwlro_get_fdir_all()

Hangyu Hua <hbh25y@gmail.com>
    net: ethernet: mvpp2_main: fix possible OOB write in mvpp2_ethtool_get_rxnfc()

Vincent Whitchurch <vincent.whitchurch@axis.com>
    net: stmmac: fix handling of zero coalescing tx-usecs

Guangguan Wang <guangguan.wang@linux.alibaba.com>
    net/smc: use smc_lgr_list.lock to protect smc_lgr_list.list iterate in smcr_port_add

Björn Töpel <bjorn@rivosinc.com>
    selftests: Keep symlinks, when possible

Björn Töpel <bjorn@rivosinc.com>
    kselftest/runner.sh: Propagate SIGTERM to runner child

Liu Jian <liujian56@huawei.com>
    net: ipv4: fix one memleak in __inet_del_ifa()

Jinjie Ruan <ruanjinjie@huawei.com>
    kunit: Fix wild-memory-access bug in kunit_free_suite_set()

Hamza Mahfooz <hamza.mahfooz@amd.com>
    drm/amdgpu: register a dirty framebuffer callback for fbcon

Gabe Teeger <gabe.teeger@amd.com>
    drm/amd/display: Remove wait while locked

Wenjing Liu <wenjing.liu@amd.com>
    drm/amd/display: always switch off ODM before committing more streams

Namhyung Kim <namhyung@kernel.org>
    perf hists browser: Fix the number of entries for 'e' key

Namhyung Kim <namhyung@kernel.org>
    perf tools: Handle old data in PERF_RECORD_ATTR

Namhyung Kim <namhyung@kernel.org>
    perf test shell stat_bpf_counters: Fix test on Intel

Namhyung Kim <namhyung@kernel.org>
    perf hists browser: Fix hierarchy mode header

Maciej W. Rozycki <macro@orcam.me.uk>
    MIPS: Fix CONFIG_CPU_DADDI_WORKAROUNDS `modules_install' regression

Sean Christopherson <seanjc@google.com>
    KVM: SVM: Skip VMSA init in sev_es_init_vmcb() if pointer is NULL

Sean Christopherson <seanjc@google.com>
    KVM: SVM: Set target pCPU during IRTE update if target vCPU is running

Sean Christopherson <seanjc@google.com>
    KVM: nSVM: Load L1's TSC multiplier based on L1 state, not L2 state

Sean Christopherson <seanjc@google.com>
    KVM: nSVM: Check instead of asserting on nested TSC scaling support

Sean Christopherson <seanjc@google.com>
    KVM: SVM: Get source vCPUs from source VM for SEV-ES intrahost migration

Sean Christopherson <seanjc@google.com>
    KVM: SVM: Don't inject #UD if KVM attempts to skip SEV guest insn

Sean Christopherson <seanjc@google.com>
    KVM: SVM: Take and hold ir_list_lock when updating vCPU's Physical ID entry

Hamza Mahfooz <hamza.mahfooz@amd.com>
    drm/amd/display: prevent potential division by zero errors

Melissa Wen <mwen@igalia.com>
    drm/amd/display: enable cursor degamma for DCN3+ DRM legacy gamma

William Zhang <william.zhang@broadcom.com>
    mtd: rawnand: brcmnand: Fix ECC level field setting for v7.2 controller

William Zhang <william.zhang@broadcom.com>
    mtd: rawnand: brcmnand: Fix potential false time out warning

Linus Walleij <linus.walleij@linaro.org>
    mtd: spi-nor: Correct flags for Winbond w25q128

William Zhang <william.zhang@broadcom.com>
    mtd: rawnand: brcmnand: Fix potential out-of-bounds access in oob write

William Zhang <william.zhang@broadcom.com>
    mtd: rawnand: brcmnand: Fix crash during the panic_write

Liu Ying <victor.liu@nxp.com>
    drm/mxsfb: Disable overlay plane in mxsfb_plane_overlay_atomic_disable()

Anand Jain <anand.jain@oracle.com>
    btrfs: use the correct superblock to compare fsid in btrfs_validate_super

Naohiro Aota <naohiro.aota@wdc.com>
    btrfs: zoned: re-enable metadata over-commit for zoned mode

Josef Bacik <josef@toxicpanda.com>
    btrfs: set page extent mapped after read_folio in relocate_one_page

Filipe Manana <fdmanana@suse.com>
    btrfs: don't start transaction when joining with TRANS_JOIN_NOSTART

Boris Burkov <boris@bur.io>
    btrfs: free qgroup rsv on io failure

Boris Burkov <boris@bur.io>
    btrfs: fix start transaction qgroup rsv double free

Naohiro Aota <naohiro.aota@wdc.com>
    btrfs: zoned: do not zone finish data relocation block group

ruanmeisi <ruan.meisi@zte.com.cn>
    fuse: nlookup missing decrement in fuse_direntplus_link

Damien Le Moal <dlemoal@kernel.org>
    ata: pata_ftide010: Add missing MODULE_DESCRIPTION

Damien Le Moal <dlemoal@kernel.org>
    ata: sata_gemini: Add missing MODULE_DESCRIPTION

Michael Schmitz <schmitzmic@gmail.com>
    ata: pata_falcon: fix IO base selection for Q40

Werner Fischer <devlists@wefi.net>
    ata: ahci: Add Elkhart Lake AHCI controller

Christian Marangi <ansuelsmth@gmail.com>
    hwspinlock: qcom: add missing regmap config for SFPB MMIO implementation

Nathan Chancellor <nathan@kernel.org>
    lib: test_scanf: Add explicit type cast to result initialization in test_number_prefix()

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: avoid false alarm of circular locking

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: flush inode if atomic file is aborted

Luís Henriques <lhenriques@suse.de>
    ext4: fix memory leaks in ext4_fname_{setup_filename,prepare_lookup}

Wang Jianjian <wangjianjian0@foxmail.com>
    ext4: add correct group descriptors and reserved GDT blocks to system zone

Zhang Yi <yi.zhang@huawei.com>
    jbd2: correct the end of the journal recovery scan range

Zhihao Cheng <chengzhihao1@huawei.com>
    jbd2: check 'jh->b_transaction' before removing it from checkpoint

Zhang Yi <yi.zhang@huawei.com>
    jbd2: fix checkpoint cleanup performance regression

Hien Huynh <hien.huynh.px@renesas.com>
    dmaengine: sh: rz-dmac: Fix destination and source data size setting

Walter Chang <walter.chang@mediatek.com>
    clocksource/drivers/arm_arch_timer: Disable timer before programming CVAL

Pavel Kozlov <pavel.kozlov@synopsys.com>
    ARC: atomics: Add compiler barrier to atomic operations...

Saeed Mahameed <saeedm@nvidia.com>
    net/mlx5: Free IRQ rmap and notifier on kernel shutdown

Kalesh Singh <kaleshsingh@google.com>
    Multi-gen LRU: avoid race in inc_min_seq()

Petr Tesarik <petr.tesarik.ext@huawei.com>
    sh: boards: Fix CEU buffer size passed to dma_declare_coherent_memory()

Jie Wang <wangjie125@huawei.com>
    net: hns3: remove GSO partial feature bit

Yisen Zhuang <yisen.zhuang@huawei.com>
    net: hns3: fix the port information display when sfp is absent

Jijie Shao <shaojijie@huawei.com>
    net: hns3: fix invalid mutex between tc qdisc and dcb ets command issue

Hao Chen <chenhao418@huawei.com>
    net: hns3: fix debugfs concurrency issue between kfree buffer and read

Hao Chen <chenhao418@huawei.com>
    net: hns3: fix byte order conversion issue in hclge_dbg_fd_tcam_read()

Jian Shen <shenjian15@huawei.com>
    net: hns3: fix tx timeout issue

Wander Lairson Costa <wander@redhat.com>
    netfilter: nfnetlink_osf: avoid OOB read

Florian Westphal <fw@strlen.de>
    netfilter: nftables: exthdr: fix 4-byte stack OOB write

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    bpf: Assign bpf_tramp_run_ctx::saved_run_ctx before recursion check.

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    bpf: Invoke __bpf_prog_exit_sleepable_recur() on recursion in kern_sys_bpf().

Martin KaFai Lau <martin.lau@kernel.org>
    bpf: Remove prog->active check for bpf_lsm and bpf_iter

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: dsa: sja1105: complete tc-cbs offload support on SJA1110

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: dsa: sja1105: fix -ENOSPC when replacing the same tc-cbs too many times

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: dsa: sja1105: fix bandwidth discrepancy between tc-cbs software and offload

Eric Dumazet <edumazet@google.com>
    ip_tunnels: use DEV_STATS_INC()

Ariel Marcovitch <arielmarcovitch@gmail.com>
    idr: fix param name in idr_alloc_cyclic() doc

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    s390/zcrypt: don't leak memory if dev_set_name() fails

Olga Zaborska <olga.zaborska@intel.com>
    igb: Change IGB_MIN to allow set rx/tx value between 64 and 80

Olga Zaborska <olga.zaborska@intel.com>
    igbvf: Change IGBVF_MIN to allow set rx/tx value between 64 and 80

Olga Zaborska <olga.zaborska@intel.com>
    igc: Change IGC_MIN to allow set rx/tx value between 64 and 80

Geetha sowjanya <gakula@marvell.com>
    octeontx2-af: Fix truncation of smq in CN10K NIX AQ enqueue mbox handler

Shigeru Yoshida <syoshida@redhat.com>
    kcm: Destroy mutex in kcm_exit_net()

valis <sec@valis.email>
    net: sched: sch_qfq: Fix UAF in qfq_dequeue()

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Fix data race around sk->sk_err.

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Fix data-races around sk->sk_shutdown.

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Fix data-race around unix_tot_inflight.

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Fix data-races around user->unix_inflight.

John Fastabend <john.fastabend@gmail.com>
    bpf, sockmap: Fix skb refcnt race after locking changes

Oleksij Rempel <linux@rempel-privat.de>
    net: phy: micrel: Correct bit assignments for phy_device flags

Alex Henrie <alexhenrie24@gmail.com>
    net: ipv6/addrconf: avoid integer underflow in ipv6_create_tempaddr

Liang Chen <liangchen.linux@gmail.com>
    veth: Fixing transmit return status for dropped packets

Eric Dumazet <edumazet@google.com>
    gve: fix frag_list chaining

Corinna Vinschen <vinschen@redhat.com>
    igb: disable virtualization features on 82580

Sriram Yagnaraman <sriram.yagnaraman@est.tech>
    ipv6: ignore dst hint for multipath routes

Sriram Yagnaraman <sriram.yagnaraman@est.tech>
    ipv4: ignore dst hint for multipath routes

Eric Dumazet <edumazet@google.com>
    mptcp: annotate data-races around msk->rmem_fwd_alloc

Eric Dumazet <edumazet@google.com>
    net: annotate data-races around sk->sk_forward_alloc

Eric Dumazet <edumazet@google.com>
    net: use sk_forward_alloc_get() in sk_get_meminfo()

Sean Christopherson <seanjc@google.com>
    drm/i915/gvt: Drop unused helper intel_vgpu_reset_gtt()

Sean Christopherson <seanjc@google.com>
    drm/i915/gvt: Put the page reference obtained by KVM's gfn_to_pfn()

Sean Christopherson <seanjc@google.com>
    drm/i915/gvt: Verify pfn is "valid" before dereferencing "struct page"

Xiubo Li <xiubli@redhat.com>
    ceph: make members in struct ceph_mds_request_args_ext a union

Magnus Karlsson <magnus.karlsson@intel.com>
    xsk: Fix xsk_diag use-after-free error during socket cleanup

Florian Westphal <fw@strlen.de>
    net: fib: avoid warn splat in flow dissector

Eric Dumazet <edumazet@google.com>
    net: read sk->sk_family once in sk_mc_loop()

Eric Dumazet <edumazet@google.com>
    ipv4: annotate data-races around fi->fib_dead

Eric Dumazet <edumazet@google.com>
    sctp: annotate data-races around sk->sk_wmem_queued

Eric Dumazet <edumazet@google.com>
    net/sched: fq_pie: avoid stalls in fq_pie_timer()

Katya Orlova <e.orlova@ispras.ru>
    smb: propagate error code of extract_sharename()

Paulo Alcantara <pc@cjr.nz>
    cifs: use fs_context for automounts

Yu Kuai <yukuai3@huawei.com>
    blk-throttle: consider 'carryover_ios/bytes' in throtl_trim_slice()

Yu Kuai <yukuai3@huawei.com>
    blk-throttle: use calculate_io/bytes_allowed() for throtl_trim_slice()

Andrzej Hajda <andrzej.hajda@intel.com>
    drm/i915: mark requests for GuC virtual engines to avoid use-after-free

Namhyung Kim <namhyung@kernel.org>
    perf test stat_bpf_counters_cgrp: Enhance perf stat cgroup BPF counter test

Kajol Jain <kjain@linux.ibm.com>
    perf test stat_bpf_counters_cgrp: Fix shellcheck issue about logical operators

Vladimir Zapolskiy <vz@mleia.com>
    pwm: lpc32xx: Remove handling of PWM channels

Raag Jadav <raag.jadav@intel.com>
    watchdog: intel-mid_wdt: add MODULE_ALIAS() to allow auto-load

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf top: Don't pass an ERR_PTR() directly to perf_session__delete()

Kajol Jain <kjain@linux.ibm.com>
    perf vendor events: Drop STORES_PER_INST metric event for power10 platform

Kajol Jain <kjain@linux.ibm.com>
    perf vendor events: Drop some of the JSON/events for power10 platform

Kajol Jain <kjain@linux.ibm.com>
    perf vendor events: Update the JSON/events descriptions for power10 platform

Sean Christopherson <seanjc@google.com>
    x86/virt: Drop unnecessary check on extended CPUID level in cpu_has_svm()

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf annotate bpf: Don't enclose non-debug code with an assert()

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: tca6416-keypad - fix interrupt enable disbalance

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: tca6416-keypad - always expect proper IRQ number in i2c client

Ying Liu <victor.liu@nxp.com>
    backlight: gpio_backlight: Drop output GPIO direction check for initial power state

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    pwm: atmel-tcb: Fix resource freeing in error path and remove

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    pwm: atmel-tcb: Harmonize resource allocation order

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    pwm: atmel-tcb: Convert to platform remove callback returning void

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf trace: Really free the evsel->priv area

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf trace: Use zfree() to reduce chances of use after free

Jeff LaBundy <jeff@labundy.com>
    Input: iqs7222 - configure power mode before triggering ATI

Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
    kconfig: fix possible buffer overflow

Jonathan Marek <jonathan@marek.ca>
    mailbox: qcom-ipcc: fix incorrect num_chans counting

Andreas Gruenbacher <agruenba@redhat.com>
    gfs2: low-memory forced flush fixes

Andreas Gruenbacher <agruenba@redhat.com>
    gfs2: Switch to wait_event in gfs2_logd

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    tpm_crb: Fix an error handling path in crb_acpi_add()

Masahiro Yamada <masahiroy@kernel.org>
    kbuild: do not run depmod for 'make modules_sign'

Masahiro Yamada <masahiroy@kernel.org>
    kbuild: rpm-pkg: define _arch conditionally

Eric Dumazet <edumazet@google.com>
    net: deal with integer overflows in kmalloc_reserve()

Eric Dumazet <edumazet@google.com>
    net: factorize code in kmalloc_reserve()

Eric Dumazet <edumazet@google.com>
    net: remove osize variable in __alloc_skb()

Eric Dumazet <edumazet@google.com>
    net: add SKB_HEAD_ALIGN() helper

Qiang Yu <quic_qianyu@quicinc.com>
    bus: mhi: host: Skip MHI reset if device is in RDDM

Fedor Pchelkin <pchelkin@ispras.ru>
    NFSv4/pnfs: minor fix for cleanup path in nfs4_get_device_info

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFS: Fix a potential data corruption

Johan Hovold <johan+linaro@kernel.org>
    clk: qcom: mss-sc7180: fix missing resume during probe

Johan Hovold <johan+linaro@kernel.org>
    clk: qcom: q6sstop-qcs404: fix missing resume during probe

Johan Hovold <johan+linaro@kernel.org>
    clk: qcom: lpasscc-sc7280: fix missing resume during probe

Johan Hovold <johan+linaro@kernel.org>
    clk: qcom: dispcc-sm8450: fix runtime PM imbalance on probe errors

Chris Lew <quic_clew@quicinc.com>
    soc: qcom: qmi_encdec: Restrict string length in decode

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    clk: qcom: gcc-mdm9615: use proper parent for pll0_vote clock

Marco Felsch <m.felsch@pengutronix.de>
    clk: imx: pll14xx: align pdiv with reference manual

Ahmad Fatoum <a.fatoum@pengutronix.de>
    clk: imx: pll14xx: dynamically configure PLL for 393216000/361267200Hz

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    dt-bindings: clock: xlnx,versal-clk: drop select:false

Raag Jadav <raag.jadav@intel.com>
    pinctrl: cherryview: fix address_space_handler() argument

Bharath SM <bharathsm@microsoft.com>
    cifs: update desired access while requesting for directory lease

Helge Deller <deller@gmx.de>
    parisc: led: Reduce CPU overhead for disk & lan LED computation

Helge Deller <deller@gmx.de>
    parisc: led: Fix LAN receive and transmit LEDs

Andrew Donnellan <ajd@linux.ibm.com>
    lib/test_meminit: allocate pages up to order MAX_ORDER

Muchun Song <muchun.song@linux.dev>
    mm: hugetlb_vmemmap: fix a race between vmemmap pmd split

Michal Hocko <mhocko@suse.com>
    memcg: drop kmem.limit_in_bytes

Steve French <stfrench@microsoft.com>
    send channel sequence number in SMB3 requests after reconnects

Chris Paterson <chris.paterson2@renesas.com>
    arm64: dts: renesas: rzg2l: Fix txdv-skew-psec typos

Johan Hovold <johan+linaro@kernel.org>
    clk: qcom: turingcc-qcs404: fix missing resume during probe

Sheetal <sheetal@nvidia.com>
    ASoC: tegra: Fix SFC conversion for few rates

Thomas Zimmermann <tzimmermann@suse.de>
    drm/ast: Fix DRAM init on AST2200

Johan Hovold <johan+linaro@kernel.org>
    clk: qcom: camcc-sc7180: fix async resume during probe

Thomas Zimmermann <tzimmermann@suse.de>
    fbdev/ep93xx-fb: Do not assign to struct fb_info.dev

Chengming Zhou <zhouchengming@bytedance.com>
    null_blk: fix poll request timeout handling

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Fix firmware resource tracking

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Error code did not return to upper layer

Nilesh Javali <njavali@marvell.com>
    scsi: qla2xxx: Fix smatch warn for qla_init_iocb_limit()

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Flush mailbox commands on chip reset

Manish Rangankar <mrangankar@marvell.com>
    scsi: qla2xxx: Remove unsupported ql2xenabledif option

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Fix TMF leak through

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Fix session hang in gnl

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Turn off noisy message log

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Fix erroneous link up failure

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Fix command flush during TMF

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: fix inconsistent TMF timeout

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Fix deletion race condition

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Limit TMF to 8 per function

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Adjust IOCB resource on qpair create

Gurchetan Singh <gurchetansingh@chromium.org>
    drm/virtio: Conditionally allocate virtio_gpu_fence

Pavel Begunkov <asml.silence@gmail.com>
    io_uring: Don't set affinity on a dying sqpoll thread

Pavel Begunkov <asml.silence@gmail.com>
    io_uring/sqpoll: fix io-wq affinity when IORING_SETUP_SQPOLL is used

Pavel Begunkov <asml.silence@gmail.com>
    io_uring: break out of iowq iopoll on teardown

Pavel Begunkov <asml.silence@gmail.com>
    io_uring/net: don't overflow multishot accept

Pavel Begunkov <asml.silence@gmail.com>
    io_uring: revert "io_uring fix multishot accept ordering"

Pavel Begunkov <asml.silence@gmail.com>
    io_uring: always lock in io_apoll_task_func

Kalesh Singh <kaleshsingh@google.com>
    Multi-gen LRU: fix per-zone reclaim

Yu Zhao <yuzhao@google.com>
    mm: multi-gen LRU: rename lrugen->lists[] to lrugen->folios[]

Quan Tian <qtian@vmware.com>
    net/ipv6: SKB symmetric hash should incorporate transport ports


-------------

Diffstat:

 Documentation/admin-guide/cgroup-v1/memory.rst     |   2 -
 .../devicetree/bindings/clock/xlnx,versal-clk.yaml |   2 -
 Documentation/mm/multigen_lru.rst                  |   8 +-
 Makefile                                           |   6 +-
 arch/arc/include/asm/atomic-llsc.h                 |   6 +-
 arch/arc/include/asm/atomic64-arcv2.h              |   6 +-
 arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi   |   4 +-
 arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi  |   2 +-
 arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi  |   4 +-
 arch/arm64/net/bpf_jit_comp.c                      |   9 +-
 arch/mips/Makefile                                 |   6 +-
 arch/parisc/include/asm/led.h                      |   4 +-
 arch/sh/boards/mach-ap325rxa/setup.c               |   2 +-
 arch/sh/boards/mach-ecovec24/setup.c               |   6 +-
 arch/sh/boards/mach-kfr2r09/setup.c                |   2 +-
 arch/sh/boards/mach-migor/setup.c                  |   2 +-
 arch/sh/boards/mach-se/7724/setup.c                |   6 +-
 arch/x86/include/asm/virtext.h                     |   6 -
 arch/x86/kvm/svm/avic.c                            |  59 +++++-
 arch/x86/kvm/svm/nested.c                          |   9 +-
 arch/x86/kvm/svm/sev.c                             |   9 +-
 arch/x86/kvm/svm/svm.c                             |  35 ++-
 arch/x86/net/bpf_jit_comp.c                        |  19 +-
 block/blk-throttle.c                               |  99 ++++-----
 drivers/ata/ahci.c                                 |   2 +
 drivers/ata/pata_falcon.c                          |  50 +++--
 drivers/ata/pata_ftide010.c                        |   1 +
 drivers/ata/sata_gemini.c                          |   1 +
 drivers/block/null_blk/main.c                      |  12 +-
 drivers/bus/mhi/host/pm.c                          |   5 +
 drivers/char/tpm/tpm_crb.c                         |   5 +-
 drivers/clk/imx/clk-pll14xx.c                      |  13 +-
 drivers/clk/qcom/camcc-sc7180.c                    |   2 +-
 drivers/clk/qcom/dispcc-sm8450.c                   |  13 +-
 drivers/clk/qcom/gcc-mdm9615.c                     |   2 +-
 drivers/clk/qcom/lpasscc-sc7280.c                  |  16 +-
 drivers/clk/qcom/mss-sc7180.c                      |  13 +-
 drivers/clk/qcom/q6sstop-qcs404.c                  |  15 +-
 drivers/clk/qcom/turingcc-qcs404.c                 |  13 +-
 drivers/clocksource/arm_arch_timer.c               |   7 +
 drivers/dma/sh/rz-dmac.c                           |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |  26 ++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |   7 +
 drivers/gpu/drm/amd/display/dc/Makefile            |   1 +
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  68 ++++--
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c   |   5 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |  11 -
 .../drm/amd/display/modules/freesync/freesync.c    |   9 +-
 drivers/gpu/drm/ast/ast_post.c                     |   2 +-
 drivers/gpu/drm/i915/gt/intel_engine_types.h       |   1 +
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c  |   3 +
 drivers/gpu/drm/i915/gvt/gtt.c                     |  27 +--
 drivers/gpu/drm/i915/gvt/gtt.h                     |   1 -
 drivers/gpu/drm/i915/i915_request.c                |   7 +-
 drivers/gpu/drm/mxsfb/mxsfb_kms.c                  |   9 +
 drivers/gpu/drm/virtio/virtgpu_ioctl.c             |  30 +--
 drivers/hwspinlock/qcom_hwspinlock.c               |   9 +
 drivers/input/keyboard/tca6416-keypad.c            |  31 +--
 drivers/input/misc/iqs7222.c                       |   8 +-
 drivers/mailbox/qcom-ipcc.c                        |   4 +-
 drivers/mtd/nand/raw/brcmnand/brcmnand.c           | 112 ++++++----
 drivers/mtd/spi-nor/winbond.c                      |   5 +-
 drivers/net/dsa/sja1105/sja1105.h                  |   4 +
 drivers/net/dsa/sja1105/sja1105_dynamic_config.c   |  93 ++++----
 drivers/net/dsa/sja1105/sja1105_main.c             | 120 ++++++++---
 drivers/net/dsa/sja1105/sja1105_spi.c              |   4 +
 drivers/net/ethernet/adi/adin1110.c                |  10 +-
 drivers/net/ethernet/cadence/macb.h                |   4 +
 drivers/net/ethernet/cadence/macb_main.c           |  18 +-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c       |   5 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   1 +
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |   7 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  19 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |   4 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c |  20 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c |  14 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   5 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |   2 -
 drivers/net/ethernet/intel/igb/igb.h               |   4 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |   5 +-
 drivers/net/ethernet/intel/igbvf/igbvf.h           |   4 +-
 drivers/net/ethernet/intel/igc/igc.h               |   4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c       |  28 +--
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |   5 +
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |  21 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |   3 +
 .../ethernet/mellanox/mlx5/core/en/tc_tun_encap.c  |   5 +-
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c  |  26 ++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  10 +-
 drivers/net/usb/r8152.c                            |   3 +
 drivers/net/veth.c                                 |   4 +-
 drivers/parisc/led.c                               |   4 +-
 drivers/pinctrl/intel/pinctrl-cherryview.c         |   5 +-
 drivers/platform/mellanox/Kconfig                  |   4 +-
 drivers/platform/mellanox/mlxbf-pmc.c              |  41 ++--
 drivers/platform/mellanox/mlxbf-tmfifo.c           |  90 +++++---
 drivers/pwm/pwm-atmel-tcb.c                        |  70 +++---
 drivers/pwm/pwm-lpc32xx.c                          |  16 +-
 drivers/s390/crypto/zcrypt_api.c                   |   1 +
 drivers/scsi/qla2xxx/qla_attr.c                    |   2 -
 drivers/scsi/qla2xxx/qla_dbg.c                     |   2 +-
 drivers/scsi/qla2xxx/qla_def.h                     |  21 +-
 drivers/scsi/qla2xxx/qla_dfs.c                     |  10 +
 drivers/scsi/qla2xxx/qla_gbl.h                     |   1 +
 drivers/scsi/qla2xxx/qla_init.c                    | 234 +++++++++++++--------
 drivers/scsi/qla2xxx/qla_inline.h                  |  57 ++++-
 drivers/scsi/qla2xxx/qla_iocb.c                    |   1 +
 drivers/scsi/qla2xxx/qla_isr.c                     |   7 +-
 drivers/scsi/qla2xxx/qla_mbx.c                     |   7 +-
 drivers/scsi/qla2xxx/qla_nvme.c                    |   3 +-
 drivers/scsi/qla2xxx/qla_os.c                      |  26 ++-
 drivers/scsi/qla2xxx/qla_target.c                  |  14 +-
 drivers/soc/qcom/qmi_encdec.c                      |   4 +-
 drivers/video/backlight/gpio_backlight.c           |   3 +-
 drivers/video/fbdev/ep93xx-fb.c                    |   1 -
 drivers/watchdog/intel-mid_wdt.c                   |   1 +
 fs/btrfs/disk-io.c                                 |   5 +-
 fs/btrfs/extent-tree.c                             |  43 ++--
 fs/btrfs/inode.c                                   |   7 +
 fs/btrfs/relocation.c                              |  12 +-
 fs/btrfs/space-info.c                              |   6 +-
 fs/btrfs/transaction.c                             |  26 ++-
 fs/btrfs/zoned.c                                   |  16 +-
 fs/ext4/balloc.c                                   |  15 +-
 fs/ext4/block_validity.c                           |   8 +-
 fs/ext4/crypto.c                                   |   4 +
 fs/ext4/ext4.h                                     |   2 +
 fs/f2fs/f2fs.h                                     |  24 ++-
 fs/f2fs/inline.c                                   |   3 +-
 fs/f2fs/segment.c                                  |   2 +
 fs/fuse/readdir.c                                  |  10 +-
 fs/gfs2/aops.c                                     |   4 +-
 fs/gfs2/log.c                                      |  25 +--
 fs/jbd2/checkpoint.c                               |  22 +-
 fs/jbd2/recovery.c                                 |  12 +-
 fs/nfs/direct.c                                    |  20 +-
 fs/nfs/pnfs_dev.c                                  |   2 +-
 fs/smb/client/cached_dir.c                         |   2 +-
 fs/smb/client/cifs_dfs_ref.c                       | 100 ++++-----
 fs/smb/client/cifsglob.h                           |   1 +
 fs/smb/client/connect.c                            |   1 +
 fs/smb/client/fscache.c                            |   2 +-
 fs/smb/client/smb2ops.c                            |  11 +-
 fs/smb/client/smb2pdu.c                            |  11 +
 fs/smb/common/smb2pdu.h                            |  22 ++
 include/linux/bpf.h                                |  24 +--
 include/linux/bpf_verifier.h                       |  13 ++
 include/linux/ceph/ceph_fs.h                       |  24 ++-
 include/linux/ipv6.h                               |   1 +
 include/linux/micrel_phy.h                         |   6 +-
 include/linux/mm_inline.h                          |   4 +-
 include/linux/mmzone.h                             |   8 +-
 include/linux/skbuff.h                             |   8 +
 include/linux/tca6416_keypad.h                     |   1 -
 include/net/ip.h                                   |   1 +
 include/net/ip6_fib.h                              |  14 +-
 include/net/ip_fib.h                               |   5 +-
 include/net/ip_tunnels.h                           |  15 +-
 include/net/ipv6.h                                 |   7 +-
 include/net/sock.h                                 |  12 +-
 include/trace/events/fib.h                         |   5 +-
 include/trace/events/fib6.h                        |   5 +-
 io_uring/io-wq.c                                   |  17 +-
 io_uring/io-wq.h                                   |   3 +-
 io_uring/io_uring.c                                |  31 ++-
 io_uring/net.c                                     |   8 +-
 io_uring/poll.c                                    |   3 +-
 io_uring/sqpoll.c                                  |  17 ++
 io_uring/sqpoll.h                                  |   1 +
 kernel/bpf/syscall.c                               |   7 +-
 kernel/bpf/trampoline.c                            |  81 +++++--
 lib/idr.c                                          |   2 +-
 lib/kunit/test.c                                   |   3 +-
 lib/test_meminit.c                                 |   2 +-
 lib/test_scanf.c                                   |   2 +-
 mm/hugetlb_vmemmap.c                               |  34 ++-
 mm/memcontrol.c                                    |  10 -
 mm/vmscan.c                                        |  50 +++--
 net/core/flow_dissector.c                          |   3 +-
 net/core/skbuff.c                                  |  49 ++---
 net/core/skmsg.c                                   |  12 +-
 net/core/sock.c                                    |  19 +-
 net/ethtool/ioctl.c                                |  10 +-
 net/hsr/hsr_forward.c                              |   1 +
 net/ipv4/devinet.c                                 |  10 +-
 net/ipv4/fib_semantics.c                           |   5 +-
 net/ipv4/fib_trie.c                                |   3 +-
 net/ipv4/inet_hashtables.c                         |  43 ++--
 net/ipv4/ip_input.c                                |   3 +-
 net/ipv4/route.c                                   |   1 +
 net/ipv4/tcp_output.c                              |   2 +-
 net/ipv4/udp.c                                     |   6 +-
 net/ipv6/addrconf.c                                |   2 +-
 net/ipv6/ip6_input.c                               |   3 +-
 net/ipv6/route.c                                   |   3 +
 net/kcm/kcmsock.c                                  |  15 +-
 net/mptcp/protocol.c                               |  23 +-
 net/netfilter/nfnetlink_osf.c                      |   8 +
 net/netfilter/nft_exthdr.c                         |  22 +-
 net/sched/sch_fq_pie.c                             |  27 ++-
 net/sched/sch_plug.c                               |   2 +-
 net/sched/sch_qfq.c                                |  22 +-
 net/sctp/proc.c                                    |   2 +-
 net/sctp/socket.c                                  |  10 +-
 net/smc/smc_core.c                                 |   2 +
 net/tls/tls_sw.c                                   |   4 +-
 net/unix/af_unix.c                                 |   2 +-
 net/unix/scm.c                                     |   6 +-
 net/xdp/xsk_diag.c                                 |   3 +
 scripts/kconfig/preprocess.c                       |   3 +
 scripts/package/mkspec                             |   2 +-
 sound/soc/tegra/tegra210_sfc.c                     |  31 ++-
 sound/soc/tegra/tegra210_sfc.h                     |   4 +-
 tools/perf/builtin-top.c                           |   1 +
 tools/perf/builtin-trace.c                         |  15 +-
 .../pmu-events/arch/powerpc/power10/cache.json     |   4 +-
 .../arch/powerpc/power10/floating_point.json       |   7 -
 .../pmu-events/arch/powerpc/power10/frontend.json  |  30 +--
 .../pmu-events/arch/powerpc/power10/marked.json    |  30 +--
 .../pmu-events/arch/powerpc/power10/memory.json    |   6 +-
 .../pmu-events/arch/powerpc/power10/metrics.json   |   6 -
 .../pmu-events/arch/powerpc/power10/others.json    |  53 +++--
 .../pmu-events/arch/powerpc/power10/pipeline.json  |  30 +--
 .../perf/pmu-events/arch/powerpc/power10/pmc.json  |   4 +-
 .../arch/powerpc/power10/translation.json          |  11 +-
 tools/perf/tests/shell/stat_bpf_counters.sh        |   4 +-
 tools/perf/tests/shell/stat_bpf_counters_cgrp.sh   |  28 ++-
 tools/perf/ui/browsers/hists.c                     |  60 +++---
 tools/perf/util/annotate.c                         |  10 +-
 tools/perf/util/header.c                           |  11 +-
 tools/testing/selftests/kselftest/runner.sh        |   3 +-
 tools/testing/selftests/lib.mk                     |   4 +-
 232 files changed, 2129 insertions(+), 1340 deletions(-)


