Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CCF7A390A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 21:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239926AbjIQToD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 15:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239932AbjIQTnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 15:43:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC7EE7;
        Sun, 17 Sep 2023 12:43:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A732C433C8;
        Sun, 17 Sep 2023 19:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979805;
        bh=oqV4BXE+MadN+X1rBjj513Bu3jbLcePdiqQXyUrOdbE=;
        h=From:To:Cc:Subject:Date:From;
        b=HZRgBCAExL6WgdgXDErXdIi+v8GmfLvFpgDMNaAVmp9yt4jI+YuIGCoI2VAHjrAPE
         T/dAf25+Jo4jBPdrmEWgpAWSVVz6dNrR4grgO/6/kuNoN4ooJ9oWfkF7fTYEkDn5kR
         msgeMnd8hHNF2aQQGqOXj6IrIFc2nMr4nfNGSQPI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 6.5 000/285] 6.5.4-rc1 review
Date:   Sun, 17 Sep 2023 21:10:00 +0200
Message-ID: <20230917191051.639202302@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.4-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.5.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.5.4-rc1
X-KernelTest-Deadline: 2023-09-19T19:11+00:00
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

This is the start of the stable review cycle for the 6.5.4 release.
There are 285 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.4-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.5.4-rc1

Wesley Chalmers <wesley.chalmers@amd.com>
    drm/amd/display: Fix a bug when searching for insert_above_mpcc

Linus Torvalds <torvalds@linux-foundation.org>
    vm: fix move_vma() memory accounting being off

Kuniyuki Iwashima <kuniyu@amazon.com>
    kcm: Fix error handling for SOCK_DGRAM in kcm_sendmsg().

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    net: renesas: rswitch: Fix unmasking irq condition

Corinna Vinschen <vinschen@redhat.com>
    igb: clean up in all error paths when enabling SR-IOV

Vadim Fedorenko <vadim.fedorenko@linux.dev>
    ixgbe: fix timestamp configuration code

Kuniyuki Iwashima <kuniyu@amazon.com>
    selftest: tcp: Fix address length in bind_wildcard.c.

Kuniyuki Iwashima <kuniyu@amazon.com>
    tcp: Fix bind() regression for v4-mapped-v6 non-wildcard address.

Kuniyuki Iwashima <kuniyu@amazon.com>
    tcp: Fix bind() regression for v4-mapped-v6 wildcard address.

Kuniyuki Iwashima <kuniyu@amazon.com>
    tcp: Factorise sk_family-independent comparison in inet_bind2_bucket_match(_addr_any).

Eric Dumazet <edumazet@google.com>
    ipv6: fix ip6_sock_set_addr_preferences() typo

Toke Høiland-Jørgensen <toke@redhat.com>
    veth: Update XDP feature set when bringing up device

Sascha Hauer <s.hauer@pengutronix.de>
    net: macb: fix sleep inside spinlock

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

Ratheesh Kannoth <rkannoth@marvell.com>
    octeontx2-pf: Fix page pool cache index corruption.

Jinjie Ruan <ruanjinjie@huawei.com>
    net: microchip: vcap api: Fix possible memory leak for vcap_dup_rule()

Naveen N Rao <naveen@kernel.org>
    selftests/ftrace: Fix dependencies for some of the synthetic event tests

Björn Töpel <bjorn@rivosinc.com>
    selftests: Keep symlinks, when possible

Björn Töpel <bjorn@rivosinc.com>
    kselftest/runner.sh: Propagate SIGTERM to runner child

Liu Jian <liujian56@huawei.com>
    net: ipv4: fix one memleak in __inet_del_ifa()

Jinjie Ruan <ruanjinjie@huawei.com>
    kunit: Fix wild-memory-access bug in kunit_free_suite_set()

Helge Deller <deller@gmx.de>
    parisc: sba_iommu: Fix build warning if procfs if disabled

Biju Das <biju.das.jz@bp.renesas.com>
    regulator: raa215300: Fix resource leak in case of error

Biju Das <biju.das.jz@bp.renesas.com>
    regulator: raa215300: Change the scope of the variables {clkin_name, xin_name}

Arnd Bergmann <arnd@arndb.de>
    bpf: fix bpf_probe_read_kernel prototype mismatch

Hamza Mahfooz <hamza.mahfooz@amd.com>
    drm/amdgpu: register a dirty framebuffer callback for fbcon

Jay Cornwall <jay.cornwall@amd.com>
    drm/amdkfd: Add missing gfx11 MQD manager callbacks

Gabe Teeger <gabe.teeger@amd.com>
    drm/amd/display: Remove wait while locked

Wenjing Liu <wenjing.liu@amd.com>
    drm/amd/display: always switch off ODM before committing more streams

Namhyung Kim <namhyung@kernel.org>
    perf hists browser: Fix the number of entries for 'e' key

Namhyung Kim <namhyung@kernel.org>
    perf build: Include generated header files properly

Namhyung Kim <namhyung@kernel.org>
    perf tools: Handle old data in PERF_RECORD_ATTR

Namhyung Kim <namhyung@kernel.org>
    perf test shell stat_bpf_counters: Fix test on Intel

Namhyung Kim <namhyung@kernel.org>
    perf build: Update build rule for generated files

Namhyung Kim <namhyung@kernel.org>
    perf hists browser: Fix hierarchy mode header

Maciej W. Rozycki <macro@orcam.me.uk>
    MIPS: Fix CONFIG_CPU_DADDI_WORKAROUNDS `modules_install' regression

Maciej W. Rozycki <macro@orcam.me.uk>
    MIPS: Only fiddle with CHECKFLAGS if `need-compiler'

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

Sean Christopherson <seanjc@google.com>
    KVM: VMX: Refresh available regs and IDT vectoring info before NMI handling

Hamza Mahfooz <hamza.mahfooz@amd.com>
    drm/amd/display: prevent potential division by zero errors

Hamza Mahfooz <hamza.mahfooz@amd.com>
    drm/amd/display: limit the v_startup workaround to ASICs older than DCN3.1

Melissa Wen <mwen@igalia.com>
    drm/amd/display: enable cursor degamma for DCN3+ DRM legacy gamma

Hamza Mahfooz <hamza.mahfooz@amd.com>
    Revert "drm/amd/display: Remove v_startup workaround for dcn3+"

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

Qu Wenruo <wqu@suse.com>
    btrfs: scrub: fix grouping of read IO

Qu Wenruo <wqu@suse.com>
    btrfs: scrub: avoid unnecessary csum tree search preparing stripes

Qu Wenruo <wqu@suse.com>
    btrfs: scrub: avoid unnecessary extent tree search preparing stripes

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

Johannes Weiner <hannes@cmpxchg.org>
    memcontrol: ensure memcg acquired by id is properly set up

Christian Marangi <ansuelsmth@gmail.com>
    hwspinlock: qcom: add missing regmap config for SFPB MMIO implementation

Nathan Chancellor <nathan@kernel.org>
    lib: test_scanf: Add explicit type cast to result initialization in test_number_prefix()

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: avoid false alarm of circular locking

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: flush inode if atomic file is aborted

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: get out of a repeat loop when getting a locked data page

Brian Foster <bfoster@redhat.com>
    ext4: drop dio overwrite only flag and associated warning

Luís Henriques <lhenriques@suse.de>
    ext4: fix memory leaks in ext4_fname_{setup_filename,prepare_lookup}

Wang Jianjian <wangjianjian0@foxmail.com>
    ext4: add correct group descriptors and reserved GDT blocks to system zone

Baokun Li <libaokun1@huawei.com>
    ext4: fix slab-use-after-free in ext4_es_insert_extent()

Zhang Yi <yi.zhang@huawei.com>
    jbd2: correct the end of the journal recovery scan range

Zhihao Cheng <chengzhihao1@huawei.com>
    jbd2: check 'jh->b_transaction' before removing it from checkpoint

Zhang Yi <yi.zhang@huawei.com>
    jbd2: fix checkpoint cleanup performance regression

Ekansh Gupta <quic_ekangupt@quicinc.com>
    misc: fastrpc: Fix incorrect DMA mapping unmap request

Ekansh Gupta <quic_ekangupt@quicinc.com>
    misc: fastrpc: Fix remote heap allocation request

Hien Huynh <hien.huynh.px@renesas.com>
    dmaengine: sh: rz-dmac: Fix destination and source data size setting

Walter Chang <walter.chang@mediatek.com>
    clocksource/drivers/arm_arch_timer: Disable timer before programming CVAL

Pavel Kozlov <pavel.kozlov@synopsys.com>
    ARC: atomics: Add compiler barrier to atomic operations...

Fangzhi Zuo <jerry.zuo@amd.com>
    drm/amd/display: Temporary Disable MST DP Colorspace Property

Florent CARLI <fcarli@gmail.com>
    watchdog: advantech_ec_wdt: fix Kconfig dependencies

Masahiro Yamada <masahiroy@kernel.org>
    linux/export: fix reference to exported functions for parisc64

Duoming Zhou <duoming@zju.edu.cn>
    sh: push-switch: Reorder cleanup operations to avoid use-after-free bug

Petr Tesarik <petr.tesarik.ext@huawei.com>
    sh: boards: Fix CEU buffer size passed to dma_declare_coherent_memory()

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: enetc: distinguish error from valid pointers in enetc_fixup_clear_rss_rfs()

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

Lukasz Majewski <lukma@denx.de>
    net: phy: Provide Module 4 KSZ9477 errata (DS80000754C)

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: Unbreak audit log reset

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_set_rbtree: skip sync GC for new elements in this transaction

Wander Lairson Costa <wander@redhat.com>
    netfilter: nfnetlink_osf: avoid OOB read

Florian Westphal <fw@strlen.de>
    netfilter: nftables: exthdr: fix 4-byte stack OOB write

Martin KaFai Lau <martin.lau@kernel.org>
    bpf: bpf_sk_storage: Fix the missing uncharge in sk_omem_alloc

Martin KaFai Lau <martin.lau@kernel.org>
    bpf: bpf_sk_storage: Fix invalid wait context lockdep report

Ilya Leoshkevich <iii@linux.ibm.com>
    s390/bpf: Pass through tail call counter in trampolines

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    bpf: Assign bpf_tramp_run_ctx::saved_run_ctx before recursion check.

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    bpf: Invoke __bpf_prog_exit_sleepable_recur() on recursion in kern_sys_bpf().

Jakub Kicinski <kuba@kernel.org>
    net: phylink: fix sphinx complaint about invalid literal

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: dsa: sja1105: complete tc-cbs offload support on SJA1110

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: dsa: sja1105: fix -ENOSPC when replacing the same tc-cbs too many times

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: dsa: sja1105: fix bandwidth discrepancy between tc-cbs software and offload

Bodong Wang <bodong@nvidia.com>
    mlx5/core: E-Switch, Create ACL FT for eswitch manager in switchdev mode

Jiri Pirko <jiri@resnulli.us>
    net/mlx5: Push devlink port PF/VF init/cleanup calls out of devlink_port_register/unregister()

Jiri Pirko <jiri@resnulli.us>
    net/mlx5: Rework devlink port alloc/free into init/cleanup

Jiri Pirko <jiri@resnulli.us>
    net/mlx5: Give esw_offloads_load/unload_rep() "mlx5_" prefix

Jianbo Liu <jianbol@nvidia.com>
    net/mlx5e: Clear mirred devices array if the rule is split

Eric Dumazet <edumazet@google.com>
    ip_tunnels: use DEV_STATS_INC()

Ariel Marcovitch <arielmarcovitch@gmail.com>
    idr: fix param name in idr_alloc_cyclic() doc

Jerome Neanne <jneanne@baylibre.com>
    regulator: tps6594-regulator: Fix random kernel crash

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

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Fix msg_controllen test in scm_pidfd_recv() for MSG_CMSG_COMPAT.

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

Xu Kuohai <xukuohai@huawei.com>
    selftests/bpf: Fix a CI failure caused by vsock write

Sriram Yagnaraman <sriram.yagnaraman@est.tech>
    ipv6: ignore dst hint for multipath routes

Sriram Yagnaraman <sriram.yagnaraman@est.tech>
    ipv4: ignore dst hint for multipath routes

Eric Dumazet <edumazet@google.com>
    net: annotate data-races around sk->sk_bind_phc

Eric Dumazet <edumazet@google.com>
    net: annotate data-races around sk->sk_tsflags

Eric Dumazet <edumazet@google.com>
    mptcp: annotate data-races around msk->rmem_fwd_alloc

Eric Dumazet <edumazet@google.com>
    net: annotate data-races around sk->sk_forward_alloc

Eric Dumazet <edumazet@google.com>
    net: use sk_forward_alloc_get() in sk_get_meminfo()

Eric Dumazet <edumazet@google.com>
    net/handshake: fix null-ptr-deref in handshake_nl_done_doit()

Hamza Mahfooz <hamza.mahfooz@amd.com>
    drm/amd/display: fix mode scaling (RMX_.*)

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

Phil Sutter <phil@nwl.cc>
    netfilter: nf_tables: Audit log rule reset

Phil Sutter <phil@nwl.cc>
    netfilter: nf_tables: Audit log setelem reset

Yu Kuai <yukuai3@huawei.com>
    blk-throttle: consider 'carryover_ios/bytes' in throtl_trim_slice()

Yu Kuai <yukuai3@huawei.com>
    blk-throttle: use calculate_io/bytes_allowed() for throtl_trim_slice()

Andrzej Hajda <andrzej.hajda@intel.com>
    drm/i915: mark requests for GuC virtual engines to avoid use-after-free

Yonghong Song <yonghong.song@linux.dev>
    selftests/bpf: Fix flaky cgroup_iter_sleepable subtest

Vincent Whitchurch <vincent.whitchurch@axis.com>
    regulator: tps6287x: Fix n_voltages

Namhyung Kim <namhyung@kernel.org>
    perf test stat_bpf_counters_cgrp: Enhance perf stat cgroup BPF counter test

Kajol Jain <kjain@linux.ibm.com>
    perf test stat_bpf_counters_cgrp: Fix shellcheck issue about logical operators

Miquel Raynal <miquel.raynal@bootlin.com>
    i3c: master: svc: Describe member 'saved_regs'

Ian Rogers <irogers@google.com>
    perf header: Fix missing PMU caps

Justin Stitt <justinstitt@google.com>
    accel/ivpu: refactor deprecated strncpy

Vladimir Zapolskiy <vz@mleia.com>
    pwm: lpc32xx: Remove handling of PWM channels

Ilkka Koskinen <ilkka@os.amperecomputing.com>
    perf vendor events arm64: Remove L1D_CACHE_LMISS from AmpereOne list

Raag Jadav <raag.jadav@intel.com>
    watchdog: intel-mid_wdt: add MODULE_ALIAS() to allow auto-load

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf lock: Don't pass an ERR_PTR() directly to perf_session__delete()

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf top: Don't pass an ERR_PTR() directly to perf_session__delete()

Kajol Jain <kjain@linux.ibm.com>
    perf vendor events: Update metric event names for power10 platform

Kajol Jain <kjain@linux.ibm.com>
    perf vendor events: Move JSON/events to appropriate files for power10 platform

Kajol Jain <kjain@linux.ibm.com>
    perf vendor events: Drop STORES_PER_INST metric event for power10 platform

Kajol Jain <kjain@linux.ibm.com>
    perf vendor events: Drop some of the JSON/events for power10 platform

Kajol Jain <kjain@linux.ibm.com>
    perf vendor events: Update the JSON/events descriptions for power10 platform

Adrian Hunter <adrian.hunter@intel.com>
    perf dlfilter: Add al_cleanup()

Arnaldo Carvalho de Melo <acme@kernel.org>
    perf dlfilter: Initialize addr_location before passing it to thread__find_symbol_fb()

Namhyung Kim <namhyung@kernel.org>
    perf bpf-filter: Fix sample flag check with ||

Ivan Babrou <ivan@cloudflare.com>
    perf script: Print "cgroup" field on the same line as "comm"

Sean Christopherson <seanjc@google.com>
    x86/virt: Drop unnecessary check on extended CPUID level in cpu_has_svm()

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf annotate bpf: Don't enclose non-debug code with an assert()

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: tca6416-keypad - fix interrupt enable disbalance

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: tca6416-keypad - always expect proper IRQ number in i2c client

Sean Christopherson <seanjc@google.com>
    KVM: SVM: Don't defer NMI unblocking until next exit for SEV-ES guests

Ian Rogers <irogers@google.com>
    perf parse-events: Additional error reporting

Ian Rogers <irogers@google.com>
    perf parse-events: Separate ENOMEM memory handling

Ian Rogers <irogers@google.com>
    perf parse-events: Move instances of YYABORT to YYNOMEM

Ian Rogers <irogers@google.com>
    perf parse-events: Separate YYABORT and YYNOMEM cases

Ying Liu <victor.liu@nxp.com>
    backlight: gpio_backlight: Drop output GPIO direction check for initial power state

Artur Weber <aweber.kernel@gmail.com>
    backlight: lp855x: Initialize PWM state on first brightness change

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    pwm: atmel-tcb: Fix resource freeing in error path and remove

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    pwm: atmel-tcb: Harmonize resource allocation order

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf trace: Really free the evsel->priv area

Jeff LaBundy <jeff@labundy.com>
    Input: iqs7222 - configure power mode before triggering ATI

Xie XiuQi <xiexiuqi@huawei.com>
    tools/mm: fix undefined reference to pthread_once

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

Jiri Slaby <jirislaby@kernel.org>
    kbuild: dummy-tools: make MPROFILE_KERNEL checks work on BE

Masahiro Yamada <masahiroy@kernel.org>
    kbuild: do not run depmod for 'make modules_sign'

Masahiro Yamada <masahiroy@kernel.org>
    kbuild: rpm-pkg: define _arch conditionally

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
    clk: qcom: dispcc-sm8550: fix runtime PM imbalance on probe errors

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

Kalesh Singh <kaleshsingh@google.com>
    Multi-gen LRU: avoid race in inc_min_seq()

Andrew Donnellan <ajd@linux.ibm.com>
    lib/test_meminit: allocate pages up to order MAX_ORDER

Muchun Song <muchun.song@linux.dev>
    mm: hugetlb_vmemmap: fix a race between vmemmap pmd split

Michal Hocko <mhocko@suse.com>
    memcg: drop kmem.limit_in_bytes

Steve French <stfrench@microsoft.com>
    send channel sequence number in SMB3 requests after reconnects

Aleksey Nasibulin <alealexpro100@ya.ru>
    ARM: dts: BCM5301X: Extend RAM to full 256MB for Linksys EA6500 V2

Chris Paterson <chris.paterson2@renesas.com>
    arm64: dts: renesas: rzg2l: Fix txdv-skew-psec typos

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: qcom: msm8974pro-castor: correct touchscreen syna,nosleep-mode

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: qcom: msm8974pro-castor: correct touchscreen function names

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: msm8953-vince: drop duplicated touschreen parent interrupt

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: qcom: msm8974pro-castor: correct inverted X of touchscreen

Johan Hovold <johan+linaro@kernel.org>
    clk: qcom: turingcc-qcs404: fix missing resume during probe

Sameer Pujar <spujar@nvidia.com>
    arm64: tegra: Update AHUB clock parent and rate

Sheetal <sheetal@nvidia.com>
    arm64: tegra: Update AHUB clock parent and rate on Tegra234

Paul Cercueil <paul@crapouillou.net>
    ARM: dts: samsung: exynos4210-i9100: Fix LCD screen's physical size

Sheetal <sheetal@nvidia.com>
    ASoC: tegra: Fix SFC conversion for few rates

Thomas Zimmermann <tzimmermann@suse.de>
    drm/ast: Fix DRAM init on AST2200

Johan Hovold <johan+linaro@kernel.org>
    clk: qcom: camcc-sc7180: fix async resume during probe

Thomas Zimmermann <tzimmermann@suse.de>
    fbdev/ep93xx-fb: Do not assign to struct fb_info.dev

Ian Kent <raven@themaw.net>
    kernfs: fix missing kernfs_iattr_rwsem locking

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

Bean Huo <beanhuo@micron.com>
    scsi: ufs: core: Add advanced RPMB support where UFSHCI 4.0 does not support EHS length in UTRD

Gurchetan Singh <gurchetansingh@chromium.org>
    drm/virtio: Conditionally allocate virtio_gpu_fence

Quan Tian <qtian@vmware.com>
    net/ipv6: SKB symmetric hash should incorporate transport ports


-------------

Diffstat:

 Documentation/admin-guide/cgroup-v1/memory.rst     |   2 -
 .../devicetree/bindings/clock/xlnx,versal-clk.yaml |   2 -
 Makefile                                           |   6 +-
 arch/arc/include/asm/atomic-llsc.h                 |   6 +-
 arch/arc/include/asm/atomic64-arcv2.h              |   6 +-
 .../dts/broadcom/bcm4708-linksys-ea6500-v2.dts     |   3 +-
 .../qcom-msm8974pro-sony-xperia-shinano-castor.dts |   8 +-
 arch/arm/boot/dts/samsung/exynos4210-i9100.dts     |   4 +-
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |   3 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |   3 +-
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |   3 +-
 arch/arm64/boot/dts/nvidia/tegra234.dtsi           |   3 +-
 arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts  |   1 -
 arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi   |   4 +-
 arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi  |   2 +-
 arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi  |   4 +-
 arch/mips/Makefile                                 |   6 +-
 arch/parisc/include/asm/led.h                      |   4 +-
 arch/parisc/include/asm/mckinley.h                 |   8 -
 arch/s390/net/bpf_jit_comp.c                       |  10 +
 arch/sh/boards/mach-ap325rxa/setup.c               |   2 +-
 arch/sh/boards/mach-ecovec24/setup.c               |   6 +-
 arch/sh/boards/mach-kfr2r09/setup.c                |   2 +-
 arch/sh/boards/mach-migor/setup.c                  |   2 +-
 arch/sh/boards/mach-se/7724/setup.c                |   6 +-
 arch/sh/drivers/push-switch.c                      |   2 +-
 arch/x86/include/asm/virtext.h                     |   6 -
 arch/x86/kvm/svm/avic.c                            |  59 +++-
 arch/x86/kvm/svm/nested.c                          |   9 +-
 arch/x86/kvm/svm/sev.c                             |  14 +-
 arch/x86/kvm/svm/svm.c                             |  45 ++-
 arch/x86/kvm/vmx/vmx.c                             |  21 +-
 block/blk-throttle.c                               |  99 +++---
 drivers/accel/ivpu/ivpu_jsm_msg.c                  |   3 +-
 drivers/ata/ahci.c                                 |   2 +
 drivers/ata/pata_falcon.c                          |  50 +--
 drivers/ata/pata_ftide010.c                        |   1 +
 drivers/ata/sata_gemini.c                          |   1 +
 drivers/block/null_blk/main.c                      |  12 +-
 drivers/bus/mhi/host/pm.c                          |   5 +
 drivers/char/tpm/tpm_crb.c                         |   5 +-
 drivers/clk/imx/clk-pll14xx.c                      |  13 +-
 drivers/clk/qcom/camcc-sc7180.c                    |   2 +-
 drivers/clk/qcom/dispcc-sm8450.c                   |  13 +-
 drivers/clk/qcom/dispcc-sm8550.c                   |  13 +-
 drivers/clk/qcom/gcc-mdm9615.c                     |   2 +-
 drivers/clk/qcom/lpasscc-sc7280.c                  |  16 +-
 drivers/clk/qcom/mss-sc7180.c                      |  13 +-
 drivers/clk/qcom/q6sstop-qcs404.c                  |  15 +-
 drivers/clk/qcom/turingcc-qcs404.c                 |  13 +-
 drivers/clocksource/arm_arch_timer.c               |   7 +
 drivers/dma/sh/rz-dmac.c                           |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |  26 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   |   3 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   4 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |   7 +
 drivers/gpu/drm/amd/display/dc/Makefile            |   1 +
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  68 ++--
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c   |   5 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |  11 -
 .../gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c   |  25 +-
 .../drm/amd/display/modules/freesync/freesync.c    |   9 +-
 drivers/gpu/drm/ast/ast_post.c                     |   2 +-
 drivers/gpu/drm/i915/gt/intel_engine_types.h       |   1 +
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c  |   3 +
 drivers/gpu/drm/i915/gvt/gtt.c                     |  27 +-
 drivers/gpu/drm/i915/gvt/gtt.h                     |   1 -
 drivers/gpu/drm/i915/i915_request.c                |   7 +-
 drivers/gpu/drm/mxsfb/mxsfb_kms.c                  |   9 +
 drivers/gpu/drm/virtio/virtgpu_submit.c            |  32 +-
 drivers/hwspinlock/qcom_hwspinlock.c               |   9 +
 drivers/i3c/master/svc-i3c-master.c                |   1 +
 drivers/input/keyboard/tca6416-keypad.c            |  31 +-
 drivers/input/misc/iqs7222.c                       |   8 +-
 drivers/mailbox/qcom-ipcc.c                        |   4 +-
 drivers/misc/fastrpc.c                             |  22 +-
 drivers/mtd/nand/raw/brcmnand/brcmnand.c           | 112 ++++--
 drivers/mtd/spi-nor/winbond.c                      |   5 +-
 drivers/net/dsa/microchip/ksz_common.c             |  16 +-
 drivers/net/dsa/sja1105/sja1105.h                  |   4 +
 drivers/net/dsa/sja1105/sja1105_dynamic_config.c   |  93 +++--
 drivers/net/dsa/sja1105/sja1105_main.c             | 120 +++++--
 drivers/net/dsa/sja1105/sja1105_spi.c              |   4 +
 drivers/net/ethernet/adi/adin1110.c                |  10 +-
 drivers/net/ethernet/cadence/macb_main.c           |   5 +-
 drivers/net/ethernet/freescale/enetc/enetc_pf.c    |   2 +-
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
 drivers/net/ethernet/intel/igb/igb_main.c          |  10 +-
 drivers/net/ethernet/intel/igbvf/igbvf.h           |   4 +-
 drivers/net/ethernet/intel/igc/igc.h               |   4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c       |  28 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |   5 +
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |  21 +-
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c |   6 +-
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.h |   2 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |  43 +--
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |   3 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   7 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |  30 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.h |   4 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |   3 +
 .../net/ethernet/mellanox/mlx5/core/en/tc/act/ct.c |   4 +-
 .../ethernet/mellanox/mlx5/core/en/tc/act/mirred.c |   1 +
 .../ethernet/mellanox/mlx5/core/en/tc/act/pedit.c  |   4 +-
 .../mlx5/core/en/tc/act/redirect_ingress.c         |   1 +
 .../ethernet/mellanox/mlx5/core/en/tc/act/vlan.c   |   1 +
 .../mellanox/mlx5/core/en/tc/act/vlan_mangle.c     |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |   1 +
 .../ethernet/mellanox/mlx5/core/esw/devlink_port.c |  62 ++--
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |  64 +++-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |   8 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |  75 ++--
 drivers/net/ethernet/microchip/vcap/vcap_api.c     |  18 +-
 drivers/net/ethernet/renesas/rswitch.c             |   8 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  10 +-
 drivers/net/phy/micrel.c                           |   9 +-
 drivers/net/usb/r8152.c                            |   3 +
 drivers/net/veth.c                                 |   6 +-
 drivers/parisc/led.c                               |   4 +-
 drivers/parisc/sba_iommu.c                         |  10 +-
 drivers/pinctrl/intel/pinctrl-cherryview.c         |   5 +-
 drivers/platform/mellanox/Kconfig                  |   4 +-
 drivers/platform/mellanox/mlxbf-pmc.c              |  41 +--
 drivers/platform/mellanox/mlxbf-tmfifo.c           |  90 +++--
 drivers/pwm/pwm-atmel-tcb.c                        |  64 ++--
 drivers/pwm/pwm-lpc32xx.c                          |  16 +-
 drivers/regulator/raa215300.c                      |  32 +-
 drivers/regulator/tps6287x-regulator.c             |   2 +-
 drivers/regulator/tps6594-regulator.c              |  31 +-
 drivers/s390/crypto/zcrypt_api.c                   |   1 +
 drivers/scsi/qla2xxx/qla_attr.c                    |   2 -
 drivers/scsi/qla2xxx/qla_dbg.c                     |   2 +-
 drivers/scsi/qla2xxx/qla_def.h                     |  21 +-
 drivers/scsi/qla2xxx/qla_dfs.c                     |  10 +
 drivers/scsi/qla2xxx/qla_gbl.h                     |   1 +
 drivers/scsi/qla2xxx/qla_init.c                    | 234 ++++++++-----
 drivers/scsi/qla2xxx/qla_inline.h                  |  57 +++-
 drivers/scsi/qla2xxx/qla_iocb.c                    |   1 +
 drivers/scsi/qla2xxx/qla_isr.c                     |   7 +-
 drivers/scsi/qla2xxx/qla_mbx.c                     |   7 +-
 drivers/scsi/qla2xxx/qla_nvme.c                    |   3 +-
 drivers/scsi/qla2xxx/qla_os.c                      |  26 +-
 drivers/scsi/qla2xxx/qla_target.c                  |  14 +-
 drivers/soc/qcom/qmi_encdec.c                      |   4 +-
 drivers/ufs/core/ufs_bsg.c                         |   3 +-
 drivers/ufs/core/ufshcd.c                          |  10 +-
 drivers/video/backlight/gpio_backlight.c           |   3 +-
 drivers/video/backlight/lp855x_bl.c                |  20 +-
 drivers/video/fbdev/ep93xx-fb.c                    |   1 -
 drivers/watchdog/Kconfig                           |   2 +
 drivers/watchdog/intel-mid_wdt.c                   |   1 +
 fs/btrfs/disk-io.c                                 |   5 +-
 fs/btrfs/extent-tree.c                             |  43 +--
 fs/btrfs/file-item.c                               |  34 +-
 fs/btrfs/file-item.h                               |   6 +-
 fs/btrfs/inode.c                                   |   7 +
 fs/btrfs/raid56.c                                  |   4 +-
 fs/btrfs/relocation.c                              |  12 +-
 fs/btrfs/scrub.c                                   | 152 ++++++---
 fs/btrfs/space-info.c                              |   6 +-
 fs/btrfs/transaction.c                             |  26 +-
 fs/btrfs/zoned.c                                   |  16 +-
 fs/ext4/balloc.c                                   |  15 +-
 fs/ext4/block_validity.c                           |   8 +-
 fs/ext4/crypto.c                                   |   4 +
 fs/ext4/ext4.h                                     |   2 +
 fs/ext4/extents_status.c                           |  44 ++-
 fs/ext4/file.c                                     |  25 +-
 fs/f2fs/data.c                                     |   8 +-
 fs/f2fs/f2fs.h                                     |  24 +-
 fs/f2fs/inline.c                                   |   3 +-
 fs/f2fs/segment.c                                  |   2 +
 fs/fuse/readdir.c                                  |  10 +-
 fs/gfs2/aops.c                                     |   4 +-
 fs/gfs2/log.c                                      |  25 +-
 fs/jbd2/checkpoint.c                               |  22 +-
 fs/jbd2/recovery.c                                 |  12 +-
 fs/kernfs/dir.c                                    |   4 +
 fs/nfs/direct.c                                    |  20 +-
 fs/nfs/pnfs_dev.c                                  |   2 +-
 fs/smb/client/cached_dir.c                         |   2 +-
 fs/smb/client/cifsglob.h                           |   1 +
 fs/smb/client/connect.c                            |   1 +
 fs/smb/client/fscache.c                            |   2 +-
 fs/smb/client/smb2ops.c                            |  11 +-
 fs/smb/client/smb2pdu.c                            |  11 +
 fs/smb/common/smb2pdu.h                            |  22 ++
 include/linux/audit.h                              |   2 +
 include/linux/bpf.h                                |  12 +
 include/linux/ceph/ceph_fs.h                       |  24 +-
 include/linux/export-internal.h                    |   2 +
 include/linux/ipv6.h                               |   1 +
 include/linux/micrel_phy.h                         |   7 +-
 include/linux/phylink.h                            |   4 +-
 include/linux/tca6416_keypad.h                     |   1 -
 include/net/ip.h                                   |   3 +-
 include/net/ip6_fib.h                              |   5 +-
 include/net/ip_fib.h                               |   5 +-
 include/net/ip_tunnels.h                           |  15 +-
 include/net/ipv6.h                                 |   7 +-
 include/net/scm.h                                  |  14 +-
 include/net/sock.h                                 |  29 +-
 kernel/auditsc.c                                   |   2 +
 kernel/bpf/bpf_local_storage.c                     |  49 +--
 kernel/bpf/core.c                                  |  10 +-
 kernel/bpf/syscall.c                               |   2 +-
 kernel/bpf/trampoline.c                            |   5 +-
 kernel/trace/bpf_trace.c                           |  11 -
 lib/idr.c                                          |   2 +-
 lib/kunit/test.c                                   |   3 +-
 lib/test_meminit.c                                 |   2 +-
 lib/test_scanf.c                                   |   2 +-
 mm/hugetlb_vmemmap.c                               |  34 +-
 mm/memcontrol.c                                    |  32 +-
 mm/mremap.c                                        |   2 +-
 mm/vmscan.c                                        |  13 +-
 net/can/j1939/socket.c                             |  10 +-
 net/core/flow_dissector.c                          |   3 +-
 net/core/skbuff.c                                  |  10 +-
 net/core/skmsg.c                                   |  12 +-
 net/core/sock.c                                    |  27 +-
 net/handshake/netlink.c                            |  18 +-
 net/hsr/hsr_forward.c                              |   1 +
 net/ipv4/devinet.c                                 |  10 +-
 net/ipv4/fib_semantics.c                           |   5 +-
 net/ipv4/fib_trie.c                                |   3 +-
 net/ipv4/inet_hashtables.c                         |  36 +-
 net/ipv4/ip_input.c                                |   3 +-
 net/ipv4/ip_output.c                               |   2 +-
 net/ipv4/ip_sockglue.c                             |   2 +-
 net/ipv4/route.c                                   |   1 +
 net/ipv4/tcp.c                                     |   4 +-
 net/ipv4/tcp_output.c                              |   2 +-
 net/ipv4/udp.c                                     |   6 +-
 net/ipv6/addrconf.c                                |   2 +-
 net/ipv6/ip6_input.c                               |   3 +-
 net/ipv6/ip6_output.c                              |   2 +-
 net/ipv6/ping.c                                    |   2 +-
 net/ipv6/raw.c                                     |   2 +-
 net/ipv6/route.c                                   |   3 +
 net/ipv6/udp.c                                     |   2 +-
 net/kcm/kcmsock.c                                  |  15 +-
 net/mptcp/protocol.c                               |  23 +-
 net/netfilter/nf_tables_api.c                      |  54 ++-
 net/netfilter/nfnetlink_osf.c                      |   8 +
 net/netfilter/nft_exthdr.c                         |  22 +-
 net/netfilter/nft_set_rbtree.c                     |   8 +-
 net/sched/sch_fq_pie.c                             |  27 +-
 net/sched/sch_plug.c                               |   2 +-
 net/sched/sch_qfq.c                                |  22 +-
 net/sctp/proc.c                                    |   2 +-
 net/sctp/socket.c                                  |  10 +-
 net/smc/smc_core.c                                 |   2 +
 net/socket.c                                       |  15 +-
 net/tls/tls_sw.c                                   |   4 +-
 net/unix/af_unix.c                                 |   2 +-
 net/unix/scm.c                                     |   6 +-
 net/xdp/xsk_diag.c                                 |   3 +
 scripts/dummy-tools/gcc                            |   3 +-
 scripts/kconfig/preprocess.c                       |   3 +
 scripts/mod/modpost.c                              |   9 +
 scripts/package/mkspec                             |   2 +-
 sound/soc/tegra/tegra210_sfc.c                     |  31 +-
 sound/soc/tegra/tegra210_sfc.h                     |   4 +-
 tools/build/Makefile.build                         |  10 +
 tools/mm/Makefile                                  |   4 +-
 tools/perf/Documentation/perf-dlfilter.txt         |  22 +-
 tools/perf/Makefile.perf                           |   2 +-
 tools/perf/builtin-lock.c                          |   1 +
 tools/perf/builtin-script.c                        |  22 +-
 tools/perf/builtin-top.c                           |   1 +
 tools/perf/builtin-trace.c                         |   9 +-
 tools/perf/dlfilters/dlfilter-test-api-v2.c        | 377 +++++++++++++++++++++
 tools/perf/include/perf/perf_dlfilter.h            |  11 +-
 tools/perf/pmu-events/Build                        |   6 +
 .../arch/arm64/ampere/ampereone/cache.json         |   3 -
 .../pmu-events/arch/powerpc/power10/cache.json     |  47 +--
 .../arch/powerpc/power10/floating_point.json       |  66 +++-
 .../pmu-events/arch/powerpc/power10/frontend.json  | 188 +---------
 .../pmu-events/arch/powerpc/power10/marked.json    | 194 ++++++++---
 .../pmu-events/arch/powerpc/power10/memory.json    |  91 +----
 .../pmu-events/arch/powerpc/power10/metrics.json   |  56 ++-
 .../pmu-events/arch/powerpc/power10/others.json    | 209 ++----------
 .../pmu-events/arch/powerpc/power10/pipeline.json  | 269 +++++++++++----
 .../perf/pmu-events/arch/powerpc/power10/pmc.json  | 193 ++++++++++-
 .../arch/powerpc/power10/translation.json          |  42 +--
 tools/perf/pmu-events/jevents.py                   |   2 +-
 tools/perf/tests/dlfilter-test.c                   |  38 ++-
 tools/perf/tests/shell/stat_bpf_counters.sh        |   4 +-
 tools/perf/tests/shell/stat_bpf_counters_cgrp.sh   |  28 +-
 tools/perf/ui/browsers/hists.c                     |  60 ++--
 tools/perf/util/annotate.c                         |  10 +-
 tools/perf/util/bpf-filter.c                       |  14 +-
 tools/perf/util/dlfilter.c                         |  30 ++
 tools/perf/util/expr.c                             |   4 +-
 tools/perf/util/header.c                           |  42 +--
 tools/perf/util/parse-events.c                     |   4 +-
 tools/perf/util/parse-events.y                     | 256 +++++++++-----
 tools/perf/util/pmu.c                              |   4 +-
 .../selftests/bpf/prog_tests/bpf_obj_pinning.c     |   5 +-
 .../selftests/bpf/prog_tests/sockmap_helpers.h     |  26 ++
 .../selftests/bpf/prog_tests/sockmap_listen.c      |   7 +
 .../trigger-synthetic-event-dynstring.tc           |   2 +-
 .../trigger-synthetic_event_syntax_errors.tc       |   2 +-
 tools/testing/selftests/kselftest/runner.sh        |   3 +-
 tools/testing/selftests/lib.mk                     |   4 +-
 tools/testing/selftests/net/bind_wildcard.c        |   2 +-
 316 files changed, 3898 insertions(+), 2319 deletions(-)


