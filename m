Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE177A3A79
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 22:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240364AbjIQUEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 16:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240362AbjIQUE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 16:04:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08232EE;
        Sun, 17 Sep 2023 13:04:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82733C433C8;
        Sun, 17 Sep 2023 20:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981057;
        bh=l3oce+9MEzwIElq0AzttGocASlETSCwNXbyIlAllr6g=;
        h=From:To:Cc:Subject:Date:From;
        b=pM8SvgfouYKEF/dj3GBHUm/v+FuOjUKQTfiiKbig43paMrGrrVgPm8f/+CQeFcK06
         YLGN6VHGT6q3PFHrcexNickh4zbnD/mzNyyVH71FfZ2fDWrTjZvk0hG5q4IXSz3rQN
         rCes1EN4LVVhDR2hrnhnQVQuvUbVQAdvA2ptpvYs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 5.15 000/511] 5.15.132-rc1 review
Date:   Sun, 17 Sep 2023 21:07:07 +0200
Message-ID: <20230917191113.831992765@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.132-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.132-rc1
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

This is the start of the stable review cycle for the 5.15.132 release.
There are 511 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.132-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.132-rc1

Wesley Chalmers <wesley.chalmers@amd.com>
    drm/amd/display: Fix a bug when searching for insert_above_mpcc

Maciej W. Rozycki <macro@orcam.me.uk>
    MIPS: Only fiddle with CHECKFLAGS if `need-compiler'

Kuniyuki Iwashima <kuniyu@amazon.com>
    kcm: Fix error handling for SOCK_DGRAM in kcm_sendmsg().

Vadim Fedorenko <vadim.fedorenko@linux.dev>
    ixgbe: fix timestamp configuration code

Eric Dumazet <edumazet@google.com>
    ipv6: fix ip6_sock_set_addr_preferences() typo

Liu Jian <liujian56@huawei.com>
    net/tls: do not free tls_rec on async operation in bpf_exec_tx_verdict()

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
    net: dsa: sja1105: hide all multicast addresses from "bridge fdb show"

Ziyang Xuan <william.xuanziyang@huawei.com>
    hsr: Fix uninit-value access in fill_frame_info()

Hangyu Hua <hbh25y@gmail.com>
    net: ethernet: mtk_eth_soc: fix possible NULL pointer dereference in mtk_hwlro_get_fdir_all()

Hangyu Hua <hbh25y@gmail.com>
    net: ethernet: mvpp2_main: fix possible OOB write in mvpp2_ethtool_get_rxnfc()

Guangguan Wang <guangguan.wang@linux.alibaba.com>
    net/smc: use smc_lgr_list.lock to protect smc_lgr_list.list iterate in smcr_port_add

Björn Töpel <bjorn@rivosinc.com>
    kselftest/runner.sh: Propagate SIGTERM to runner child

Liu Jian <liujian56@huawei.com>
    net: ipv4: fix one memleak in __inet_del_ifa()

Aleksey Nasibulin <alealexpro100@ya.ru>
    ARM: dts: BCM5301X: Extend RAM to full 256MB for Linksys EA6500 V2

Paul Cercueil <paul@crapouillou.net>
    ARM: dts: samsung: exynos4210-i9100: Fix LCD screen's physical size

Li Lingfeng <lilingfeng3@huawei.com>
    block: don't add or resize partition on the disk with GENHD_FL_NO_PART

Christoph Hellwig <hch@lst.de>
    block: rename GENHD_FL_NO_PART_SCAN to GENHD_FL_NO_PART

Christoph Hellwig <hch@lst.de>
    block: move GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE to disk->event_flags

Christoph Hellwig <hch@lst.de>
    block: move GENHD_FL_NATIVE_CAPACITY to disk->state

Christoph Hellwig <hch@lst.de>
    pcd: cleanup initialization

Christoph Hellwig <hch@lst.de>
    pcd: move the identify buffer into pcd_identify

Namhyung Kim <namhyung@kernel.org>
    perf hists browser: Fix the number of entries for 'e' key

Namhyung Kim <namhyung@kernel.org>
    perf tools: Handle old data in PERF_RECORD_ATTR

Namhyung Kim <namhyung@kernel.org>
    perf hists browser: Fix hierarchy mode header

Maciej W. Rozycki <macro@orcam.me.uk>
    MIPS: Fix CONFIG_CPU_DADDI_WORKAROUNDS `modules_install' regression

Hamza Mahfooz <hamza.mahfooz@amd.com>
    drm/amd/display: prevent potential division by zero errors

William Zhang <william.zhang@broadcom.com>
    mtd: rawnand: brcmnand: Fix potential false time out warning

William Zhang <william.zhang@broadcom.com>
    mtd: rawnand: brcmnand: Fix potential out-of-bounds access in oob write

William Zhang <william.zhang@broadcom.com>
    mtd: rawnand: brcmnand: Fix crash during the panic_write

Anand Jain <anand.jain@oracle.com>
    btrfs: use the correct superblock to compare fsid in btrfs_validate_super

Filipe Manana <fdmanana@suse.com>
    btrfs: don't start transaction when joining with TRANS_JOIN_NOSTART

Boris Burkov <boris@bur.io>
    btrfs: free qgroup rsv on io failure

ruanmeisi <ruan.meisi@zte.com.cn>
    fuse: nlookup missing decrement in fuse_direntplus_link

Damien Le Moal <dlemoal@kernel.org>
    ata: pata_ftide010: Add missing MODULE_DESCRIPTION

Damien Le Moal <dlemoal@kernel.org>
    ata: sata_gemini: Add missing MODULE_DESCRIPTION

Michael Schmitz <schmitzmic@gmail.com>
    ata: pata_falcon: fix IO base selection for Q40

Nathan Chancellor <nathan@kernel.org>
    lib: test_scanf: Add explicit type cast to result initialization in test_number_prefix()

Wang Jianjian <wangjianjian0@foxmail.com>
    ext4: add correct group descriptors and reserved GDT blocks to system zone

Zhihao Cheng <chengzhihao1@huawei.com>
    jbd2: check 'jh->b_transaction' before removing it from checkpoint

Zhang Yi <yi.zhang@huawei.com>
    jbd2: fix checkpoint cleanup performance regression

Hien Huynh <hien.huynh.px@renesas.com>
    dmaengine: sh: rz-dmac: Fix destination and source data size setting

Pavel Kozlov <pavel.kozlov@synopsys.com>
    ARC: atomics: Add compiler barrier to atomic operations...

Saeed Mahameed <saeedm@nvidia.com>
    net/mlx5: Free IRQ rmap and notifier on kernel shutdown

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

Wander Lairson Costa <wander@redhat.com>
    netfilter: nfnetlink_osf: avoid OOB read

Florian Westphal <fw@strlen.de>
    netfilter: nftables: exthdr: fix 4-byte stack OOB write

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

Oleksij Rempel <linux@rempel-privat.de>
    net: phy: micrel: Correct bit assignments for phy_device flags

Alex Henrie <alexhenrie24@gmail.com>
    net: ipv6/addrconf: avoid integer underflow in ipv6_create_tempaddr

Liang Chen <liangchen.linux@gmail.com>
    veth: Fixing transmit return status for dropped packets

Corinna Vinschen <vinschen@redhat.com>
    igb: disable virtualization features on 82580

Sriram Yagnaraman <sriram.yagnaraman@est.tech>
    ipv4: ignore dst hint for multipath routes

Sean Christopherson <seanjc@google.com>
    drm/i915/gvt: Drop unused helper intel_vgpu_reset_gtt()

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

Vladimir Zapolskiy <vz@mleia.com>
    pwm: lpc32xx: Remove handling of PWM channels

Raag Jadav <raag.jadav@intel.com>
    watchdog: intel-mid_wdt: add MODULE_ALIAS() to allow auto-load

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf top: Don't pass an ERR_PTR() directly to perf_session__delete()

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

Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
    kconfig: fix possible buffer overflow

Andreas Gruenbacher <agruenba@redhat.com>
    gfs2: low-memory forced flush fixes

Andreas Gruenbacher <agruenba@redhat.com>
    gfs2: Switch to wait_event in gfs2_logd

Masahiro Yamada <masahiroy@kernel.org>
    kbuild: do not run depmod for 'make modules_sign'

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

Chris Lew <quic_clew@quicinc.com>
    soc: qcom: qmi_encdec: Restrict string length in decode

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    clk: qcom: gcc-mdm9615: use proper parent for pll0_vote clock

Ahmad Fatoum <a.fatoum@pengutronix.de>
    clk: imx: pll14xx: dynamically configure PLL for 393216000/361267200Hz

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    dt-bindings: clock: xlnx,versal-clk: drop select:false

Raag Jadav <raag.jadav@intel.com>
    pinctrl: cherryview: fix address_space_handler() argument

Helge Deller <deller@gmx.de>
    parisc: led: Reduce CPU overhead for disk & lan LED computation

Helge Deller <deller@gmx.de>
    parisc: led: Fix LAN receive and transmit LEDs

Andrew Donnellan <ajd@linux.ibm.com>
    lib/test_meminit: allocate pages up to order MAX_ORDER

Johan Hovold <johan+linaro@kernel.org>
    clk: qcom: turingcc-qcs404: fix missing resume during probe

Thomas Zimmermann <tzimmermann@suse.de>
    drm/ast: Fix DRAM init on AST2200

Johan Hovold <johan+linaro@kernel.org>
    clk: qcom: camcc-sc7180: fix async resume during probe

Thomas Zimmermann <tzimmermann@suse.de>
    fbdev/ep93xx-fb: Do not assign to struct fb_info.dev

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

Pavel Begunkov <asml.silence@gmail.com>
    io_uring: break iopolling on signal

Pavel Begunkov <asml.silence@gmail.com>
    io_uring: break out of iowq iopoll on teardown

Pavel Begunkov <asml.silence@gmail.com>
    io_uring: always lock in io_apoll_task_func

Quan Tian <qtian@vmware.com>
    net/ipv6: SKB symmetric hash should incorporate transport ports

Tom Rix <trix@redhat.com>
    udf: initialize newblock to 0

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "drm/amdgpu: install stub fence into potential unused fence pointers"

Yu Kuai <yukuai3@huawei.com>
    md/md-bitmap: remove unnecessary local variable in backlog_store()

Brian Foster <bfoster@redhat.com>
    tracing: Zero the pipe cpumask on alloc to avoid spurious -EBUSY

Kan Liang <kan.liang@linux.intel.com>
    perf/x86/uncore: Correct the number of CHAs on EMR

Jack Wang <jinpu.wang@ionos.com>
    x86/sgx: Break up long non-preemptible delays in sgx_vepc_release()

Alan Stern <stern@rowland.harvard.edu>
    USB: core: Fix oversight in SuperSpeed initialization

Alan Stern <stern@rowland.harvard.edu>
    USB: core: Fix race by not overwriting udev->descriptor in hub_port_init()

Alan Stern <stern@rowland.harvard.edu>
    USB: core: Change usb_get_device_descriptor() API

Alan Stern <stern@rowland.harvard.edu>
    USB: core: Unite old scheme and new scheme descriptor reads

RD Babiera <rdbabiera@google.com>
    usb: typec: bus: verify partner exists in typec_altmode_attention

RD Babiera <rdbabiera@google.com>
    usb: typec: tcpm: set initial svdm version based on pd revision

Gustavo A. R. Silva <gustavoars@kernel.org>
    cpufreq: brcmstb-avs-cpufreq: Fix -Warray-bounds bug

Thomas Bourgoin <thomas.bourgoin@foss.st.com>
    crypto: stm32 - fix loop iterating through scatterlist for DMA

Sven Schnelle <svens@linux.ibm.com>
    s390/ipl: add missing secure/has_secure file to ipl type 'unknown'

D Scott Phillips <scott@os.amperecomputing.com>
    arm64: sdei: abort running SDEI handlers during crash

Enlin Mu <enlin.mu@unisoc.com>
    pstore/ram: Check start of empty przs during init

Wolfram Sang <wsa+renesas@sang-engineering.com>
    mmc: renesas_sdhi: register irqs before registering controller

Eric Biggers <ebiggers@google.com>
    fsverity: skip PKCS#7 parser when keyring is empty

Nicolas Dichtel <nicolas.dichtel@6wind.com>
    net: handle ARPHRD_PPP in dev_is_mac_header_xmit()

Thore Sommer <public@thson.de>
    X.509: if signature is unsupported skip validation

Jann Horn <jannh@google.com>
    dccp: Fix out of bounds access in DCCP error handler

Alexander Aring <aahringo@redhat.com>
    dlm: fix plock lookup when using multiple lockspaces

Yafang Shao <laoar.shao@gmail.com>
    bpf: Fix issue in verifying allow_ptr_leaks

Helge Deller <deller@gmx.de>
    parisc: Fix /proc/cpuinfo output for lscpu

Aleksa Sarai <cyphar@cyphar.com>
    procfs: block chmod on /proc/thread-self/comm

Bjorn Helgaas <bhelgaas@google.com>
    Revert "PCI: Mark NVIDIA T4 GPUs to avoid bus reset"

Dave Jiang <dave.jiang@intel.com>
    ntb: Fix calculation ntb_transport_tx_free_entry()

Dave Jiang <dave.jiang@intel.com>
    ntb: Clean up tx tail index on link down

Dave Jiang <dave.jiang@intel.com>
    ntb: Drop packets when qp link is down

Ranjan Kumar <ranjan.kumar@broadcom.com>
    scsi: mpt3sas: Perform additional retries if doorbell read returns 0

Nilesh Javali <njavali@marvell.com>
    Revert "scsi: qla2xxx: Fix buffer overrun"

Konrad Dybcio <konrad.dybcio@linaro.org>
    media: venus: hfi_venus: Write to VIDC_CTRL_INIT after unmasking interrupts

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    media: dvb: symbol fixup for dvb_attach()

Will Deacon <will@kernel.org>
    arm64: csum: Fix OoB access in IP checksum code for negative lengths

Frank Li <Frank.Li@nxp.com>
    i3c: master: svc: fix probe failure when no i3c device exist

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: PMU: fix base address for the newer hardware

Thomas Zimmermann <tzimmermann@suse.de>
    backlight/lv5207lp: Compare against struct fb_info.device

Thomas Zimmermann <tzimmermann@suse.de>
    backlight/bd6107: Compare against struct fb_info.device

Thomas Zimmermann <tzimmermann@suse.de>
    backlight/gpio_backlight: Compare against struct fb_info.device

Gustavo A. R. Silva <gustavoars@kernel.org>
    ARM: OMAP2+: Fix -Warray-bounds warning in _pwrdm_state_switch()

Yi Yang <yiyang13@huawei.com>
    ipmi_si: fix a memleak in try_smi_init()

Rick Wertenbroek <rick.wertenbroek@gmail.com>
    PCI: rockchip: Use 64-bit mask on MSI 64-bit PCI address

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: i2c: ccs: Check rules is non-NULL

Joel Fernandes (Google) <joel@joelfernandes.org>
    mm/vmalloc: add a safer version of find_vm_area() for debug

Bart Van Assche <bvanassche@acm.org>
    scsi: core: Fix the scsi_set_resid() documentation

Kees Cook <keescook@chromium.org>
    printk: ringbuffer: Fix truncating buffer size min_t cast

Zqiang <qiang.zhang1211@gmail.com>
    rcu: dump vmalloc memory info safely

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Fix missing fixup call in compat hw_refine ioctl

Boris Brezillon <boris.brezillon@collabora.com>
    PM / devfreq: Fix leak in devfreq_dev_release()

Radoslaw Tyl <radoslawx.tyl@intel.com>
    igb: set max size RX buffer when store bad packet is enabled

Mohamed Khalfella <mkhalfella@purestorage.com>
    skbuff: skb_segment, Call zero copy functions before using skbuff frags

Wander Lairson Costa <wander@redhat.com>
    netfilter: xt_sctp: validate the flag_info count

Wander Lairson Costa <wander@redhat.com>
    netfilter: xt_u32: validate user space input

Kyle Zeng <zengyhkyle@gmail.com>
    netfilter: ipset: add the missing IP_SET_HASH_WITH_NET0 macro for ip_set_hash_netportnet.c

Eric Dumazet <edumazet@google.com>
    igmp: limit igmpv3_newpack() packet size to IP_MAX_MTU

Yuan Yao <yuanyaogoog@chromium.org>
    virtio_ring: fix avail_wrap_counter in virtqueue_add_packed

Liao Chang <liaochang1@huawei.com>
    cpufreq: Fix the race condition while updating the transition_task of policy

ruanjinjie <ruanjinjie@huawei.com>
    dmaengine: ste_dma40: Add missing IRQ check in d40_probe

Randy Dunlap <rdunlap@infradead.org>
    um: Fix hostaudio build errors

Yi Yang <yiyang13@huawei.com>
    mtd: rawnand: fsmc: handle clk prepare error in fsmc_nand_resume()

Hsin-Yi Wang <hsinyi@chromium.org>
    mtd: spi-nor: Check bus width while setting QE bit

Marek Behún <kabel@kernel.org>
    leds: trigger: tty: Do not use LED_ON/OFF constants, use led_blink_set_oneshot instead

Marek Behún <kabel@kernel.org>
    leds: Fix BUG_ON check for LED_COLOR_ID_MULTI that is always false

Marek Behún <kabel@kernel.org>
    leds: multicolor: Use rounded division when calculating color components

Dan Carpenter <dan.carpenter@linaro.org>
    leds: pwm: Fix error code in led_pwm_create_fwnode()

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    rpmsg: glink: Add check for kstrdup

Jonas Karlman <jonas@kwiboo.se>
    phy/rockchip: inno-hdmi: do not power on rk3328 post pll on reg write

Zheng Yang <zhengyang@rock-chips.com>
    phy/rockchip: inno-hdmi: round fractal pixclock in rk3328 recalc_rate

Jonas Karlman <jonas@kwiboo.se>
    phy/rockchip: inno-hdmi: use correct vco_div_5 macro on rk3328

William Zhang <william.zhang@broadcom.com>
    mtd: rawnand: brcmnand: Fix mtd oobsize

Zheng Yejian <zhengyejian1@huawei.com>
    tracing: Fix race issue between cpu buffer write and swap

Mikhail Kobuk <m.kobuk@ispras.ru>
    tracing: Remove extra space at the end of hwlat_detector/mode

Dave Hansen <dave.hansen@linux.intel.com>
    x86/speculation: Mark all Skylake CPUs as vulnerable to GDS

Rahul Rameshbabu <sergeantsagara@protonmail.com>
    HID: multitouch: Correct devm device reference for hidinput input_dev name

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    HID: logitech-dj: Fix error handling in logi_dj_recv_switch_to_dj_mode()

Leon Romanovsky <leon@kernel.org>
    Revert "IB/isert: Fix incorrect release of isert connection"

Peng Fan <peng.fan@nxp.com>
    amba: bus: fix refcount leak

Yi Yang <yiyang13@huawei.com>
    serial: tegra: handle clk prepare error in tegra_uart_hw_init()

Chengfeng Ye <dg573847474@gmail.com>
    scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock

Tony Battersby <tonyb@cybernetics.com>
    scsi: core: Use 32-bit hostnum in scsi_host_lookup()

Lu Jialin <lujialin4@huawei.com>
    cgroup:namespace: Remove unused cgroup_namespaces_init()

Jacopo Mondi <jacopo.mondi@ideasonboard.com>
    media: i2c: rdacm21: Fix uninitialized value

Hans de Goede <hdegoede@redhat.com>
    media: ov2680: Fix regulators being left enabled on ov2680_power_on() errors

Hans de Goede <hdegoede@redhat.com>
    media: ov2680: Fix ov2680_set_fmt() which == V4L2_SUBDEV_FORMAT_TRY not working

Hans de Goede <hdegoede@redhat.com>
    media: ov2680: Add ov2680_fill_format() helper function

Hans de Goede <hdegoede@redhat.com>
    media: ov2680: Don't take the lock for try_fmt calls

Hans de Goede <hdegoede@redhat.com>
    media: ov2680: Remove VIDEO_V4L2_SUBDEV_API ifdef-s

Hans de Goede <hdegoede@redhat.com>
    media: ov2680: Fix vflip / hflip set functions

Hans de Goede <hdegoede@redhat.com>
    media: ov2680: Fix ov2680_bayer_order()

Hans de Goede <hdegoede@redhat.com>
    media: ov2680: Remove auto-gain and auto-exposure controls

Dave Stevenson <dave.stevenson@raspberrypi.com>
    media: i2c: ov2680: Set V4L2_CTRL_FLAG_MODIFY_LAYOUT on flips

Marek Vasut <marex@denx.de>
    media: ov5640: Enable MIPI interface in ov5640_set_power_mipi()

Alan Stern <stern@rowland.harvard.edu>
    USB: gadget: f_mass_storage: Fix unused variable warning

Konrad Dybcio <konrad.dybcio@linaro.org>
    media: venus: hfi_venus: Only consider sys_idle_indicator on V1

Colin Ian King <colin.i.king@gmail.com>
    media: go7007: Remove redundant if statement

Armin Wolf <W_Armin@gmx.de>
    platform/x86: dell-sysman: Fix reference leak

Yanfei Xu <yanfei.xu@intel.com>
    iommu/vt-d: Fix to flush cache of PASID directory table

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    iommu/qcom: Disable and reset context bank before programming

Eddie James <eajames@linux.ibm.com>
    fsi: aspeed: Reset master errors after CFAM reset

Xiang Yang <xiangyang3@huawei.com>
    IB/uverbs: Fix an potential error pointer dereference

Chengchang Tang <tangchengchang@huawei.com>
    RDMA/hns: Fix CQ and QP cache affinity

Junxian Huang <huangjunxian6@hisilicon.com>
    RDMA/hns: Fix incorrect post-send with direct wqe of wr-list

Chengchang Tang <tangchengchang@huawei.com>
    RDMA/hns: Fix port active speed

Jason Gunthorpe <jgg@ziepe.ca>
    iommu/sprd: Add missing force_aperture

Dan Carpenter <dan.carpenter@linaro.org>
    driver core: test_async: fix an error code

Rob Clark <robdclark@chromium.org>
    dma-buf/sync_file: Fix docs syntax

Ruidong Tian <tianruidong@linux.alibaba.com>
    coresight: tmc: Explicit type conversions to prevent integer overflow

Gustavo A. R. Silva <gustavoars@kernel.org>
    RDMA/irdma: Replace one-element array with flexible-array member

Oleksandr Natalenko <oleksandr@redhat.com>
    scsi: qedf: Do not touch __user pointer in qedf_dbg_fp_int_cmd_read() directly

Oleksandr Natalenko <oleksandr@redhat.com>
    scsi: qedf: Do not touch __user pointer in qedf_dbg_debug_cmd_read() directly

Oleksandr Natalenko <oleksandr@redhat.com>
    scsi: qedf: Do not touch __user pointer in qedf_dbg_stop_io_on_error_cmd_read() directly

Randy Dunlap <rdunlap@infradead.org>
    x86/APM: drop the duplicate APM_MINOR_DEV macro

Chunyan Zhang <chunyan.zhang@unisoc.com>
    serial: sprd: Fix DMA buffer leak issue

Chunyan Zhang <chunyan.zhang@unisoc.com>
    serial: sprd: Assign sprd_port after initialized to avoid wrong access

Lin Ma <linma@zju.edu.cn>
    scsi: qla4xxx: Add length check when parsing nlattrs

Lin Ma <linma@zju.edu.cn>
    scsi: be2iscsi: Add length check when parsing nlattrs

Lin Ma <linma@zju.edu.cn>
    scsi: iscsi: Add strlen() check in iscsi_if_set{_host}_param()

Lin Ma <linma@zju.edu.cn>
    scsi: iscsi: Add length check for nlattr payload

Wenchao Hao <haowenchao@huawei.com>
    scsi: iscsi: Rename iscsi_set_param() to iscsi_if_set_param()

Bart Van Assche <bvanassche@acm.org>
    scsi: RDMA/srp: Fix residual handling

Xu Yang <xu.yang_2@nxp.com>
    usb: phy: mxs: fix getting wrong state with mxs_phy_is_otg_host()

Irui Wang <irui.wang@mediatek.com>
    media: mediatek: vcodec: Return NULL if no vdec_fb is found

Benjamin Gaignard <benjamin.gaignard@collabora.com>
    media: rkvdec: increase max supported height for H.264

Xingui Yang <yangxingui@huawei.com>
    scsi: hisi_sas: Fix normally completed I/O analysed as failed

Xingui Yang <yangxingui@huawei.com>
    scsi: hisi_sas: Fix warnings detected by sparse

Xingui Yang <yangxingui@huawei.com>
    scsi: hisi_sas: Modify v3 HW SATA completion error processing

Xingui Yang <yangxingui@huawei.com>
    scsi: hisi_sas: Modify v3 HW SSP underflow error processing

Daniil Dulov <d.dulov@aladdin.ru>
    media: cx24120: Add retval check for cx24120_message_send()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    media: dvb-usb: m920x: Fix a potential memory leak in m920x_i2c_xfer()

Daniil Dulov <d.dulov@aladdin.ru>
    media: dib7000p: Fix potential division by zero

Dongliang Mu <dzm91@hust.edu.cn>
    drivers: usb: smsusb: fix error handling code in smsusb_init_device

Jonas Karlman <jonas@kwiboo.se>
    iommu: rockchip: Fix directory table address encoding

Daniel Marcovitch <dmarcovitch@nvidia.com>
    iommu/amd/iommu_v2: Fix pasid_state refcount dec hit 0 warning on pasid unbind

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    media: v4l2-core: Fix a potential resource leak in v4l2_fwnode_parse_link()

Claudiu Beznea <claudiu.beznea@microchip.com>
    media: i2c: tvp5150: check return value of devm_kasprintf()

Hans de Goede <hdegoede@redhat.com>
    media: ad5820: Drop unsupported ad5823 from i2c_ and of_device_id tables

Minjie Du <duminjie@vivo.com>
    RDMA/qedr: Remove a duplicate assignment in irdma_query_ah()

Anna Schumaker <Anna.Schumaker@Netapp.com>
    pNFS: Fix assignment of xprtdata.cred

Olga Kornievskaia <kolga@netapp.com>
    NFSv4.2: fix handling of COPY ERR_OFFLOAD_NO_REQ

Benjamin Coddington <bcodding@redhat.com>
    NFS: Guard against READDIR loop when entry names exceed MAXNAMELEN

Chuck Lever <chuck.lever@oracle.com>
    NFSD: da_addr_body field missing in some GETDEVICEINFO replies

Su Hui <suhui@nfschina.com>
    fs: lockd: avoid possible wrong NULL parameter

Alexei Filippov <halip0503@gmail.com>
    jfs: validate max amount of blocks before allocation.

Zhihao Cheng <chengzhihao1@huawei.com>
    ext4: fix unttached inode after power cut with orphan file feature enabled

Russell Currey <ruscur@russell.cc>
    powerpc/iommu: Fix notifiers being shared by PCI and VIO buses

Dan Carpenter <dan.carpenter@linaro.org>
    nfs/blocklayout: Use the passed in gfp flags

Russell Currey <ruscur@russell.cc>
    powerpc/pseries: Rework lppaca_shared_proc() to avoid DEBUG_PREEMPT

Michael Ellerman <mpe@ellerman.id.au>
    powerpc: Don't include lppaca.h in paca.h

Xiaowei Bao <xiaowei.bao@nxp.com>
    PCI: layerscape: Add workaround for lost link capabilities during reset

Frank Li <Frank.Li@nxp.com>
    PCI: layerscape: Add the endpoint linkup notifier support

Serge Semin <Sergey.Semin@baikalelectronics.ru>
    PCI: dwc: Add start_link/stop_link inlines

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    wifi: ath10k: Use RMW accessors for changing LNKCTL

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    wifi: ath11k: Use RMW accessors for changing LNKCTL

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    net/mlx5: Use RMW accessors for changing LNKCTL

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    drm/radeon: Use RMW accessors for changing LNKCTL

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    drm/amdgpu: Use RMW accessors for changing LNKCTL

Christophe Leroy <christophe.leroy@csgroup.eu>
    powerpc/perf: Convert fsl_emb notifier to state machine callbacks

Sourabh Jain <sourabhjain@linux.ibm.com>
    powerpc/fadump: reset dump area size if fadump memory reserve fails

Stefan Hajnoczi <stefanha@redhat.com>
    vfio/type1: fix cap_migration information leak

Christophe Leroy <christophe.leroy@csgroup.eu>
    powerpc/radix: Move some functions into #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE

Ahmad Fatoum <a.fatoum@pengutronix.de>
    clk: imx: composite-8m: fix clock pauses when set_rate would be a no-op

Marco Felsch <m.felsch@pengutronix.de>
    clk: imx8mp: fix sai4 clock

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    PCI/ASPM: Use RMW accessors for changing LNKCTL

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    PCI: pciehp: Use RMW accessors for changing LNKCTL

Claudiu Beznea <claudiu.beznea@microchip.com>
    pinctrl: mcp23s08: check return value of devm_kasprintf()

Wu Zongyong <wuzongyong@linux.alibaba.com>
    PCI: Mark NVIDIA T4 GPUs to avoid bus reset

Daire McNamara <daire.mcnamara@microchip.com>
    PCI: microchip: Correct the DED and SEC interrupt bit offsets

Luca Weiss <luca.weiss@fairphone.com>
    clk: qcom: gcc-sm6350: Fix gcc_sdcc2_apps_clk_src

Konrad Dybcio <konrad.dybcio@linaro.org>
    clk: qcom: reset: Use the correct type of sleep/delay based on length

Patrick Whewell <patrick.whewell@sightlineapplications.com>
    clk: qcom: gcc-sm8250: Fix gcc_sdcc2_apps_clk_src

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: avoid potential data overflow in next_linear_group

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: correct grp validation in ext4_mb_good_group

Qiuxu Zhuo <qiuxu.zhuo@intel.com>
    EDAC/igen6: Fix the issue of no error events

David Wronek <davidwronek@gmail.com>
    clk: qcom: gcc-sc7180: Fix up gcc_sdcc2_apps_clk_src

Zhang Jianhua <chris.zjh@huawei.com>
    clk: sunxi-ng: Modify mismatched function name

Minjie Du <duminjie@vivo.com>
    drivers: clk: keystone: Fix parameter judgment in _of_pll_clk_init()

Corey Minyard <minyard@acm.org>
    ipmi:ssif: Fix a memory leak when scanning for an adapter

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    ipmi:ssif: Add check for kstrdup

Su Hui <suhui@nfschina.com>
    ALSA: ac97: Fix possible error value of *rac97

Geert Uytterhoeven <geert+renesas@glider.be>
    of: unittest: Fix overlay type in apply/revert check

Geert Uytterhoeven <geert+renesas@glider.be>
    of: overlay: Call of_changeset_init() early

David Jeffery <djeffery@redhat.com>
    md: raid0: account for split bio in iostat accounting

Jan Kara <jack@suse.cz>
    md/raid0: Fix performance regression for large sequential writes

Jan Kara <jack@suse.cz>
    md/raid0: Factor out helper for mapping and submitting a bio

Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
    md: add error_handlers for raid0 and linear

Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
    md: Set MD_BROKEN for RAID1 and RAID10

Tony Lindgren <tony@atomide.com>
    bus: ti-sysc: Fix cast to enum warning

Bryan O'Donoghue <bryan.odonoghue@linaro.org>
    arm64: dts: qcom: apq8016-sbc: Fix ov5640 regulator supply names

Sui Jingfeng <suijingfeng@loongson.cn>
    drm/mediatek: Fix potential memory leak if vmap() fail

Jason-JH.Lin <jason-jh.lin@mediatek.com>
    drm/mediatek: Remove freeing not dynamic allocated memory

Tony Lindgren <tony@atomide.com>
    bus: ti-sysc: Fix build warning for 64-bit build

Pavel Begunkov <asml.silence@gmail.com>
    io_uring: fix drain stalls by invalid SQE

Gaosheng Cui <cuigaosheng1@huawei.com>
    audit: fix possible soft lockup in __audit_inode_child()

Fabio Estevam <festevam@denx.de>
    drm/msm/a2xx: Call adreno_gpu_init() earlier

Yang Wang <kevinyang.wang@amd.com>
    drm/amd/pm: fix variable dereferenced issue in amdgpu_device_attr_create()

Dan Carpenter <dan.carpenter@linaro.org>
    smackfs: Prevent underflow in smk_set_cipso()

Zhang Shurong <zhang_shurong@foxmail.com>
    firmware: meson_sm: fix to avoid potential NULL pointer dereference

Daniel Vetter <daniel.vetter@ffwll.ch>
    drm/msm/mdp5: Don't leak some plane state

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    drm: xlnx: zynqmp_dpsub: Add missing check for dma_set_mask

Nayna Jain <nayna@linux.ibm.com>
    ima: Remove deprecated IMA_TRUSTED_KEYRING Kconfig

Marek Vasut <marex@denx.de>
    drm/panel: simple: Add missing connector type and pixel format for AUO T215HVN01

Geert Uytterhoeven <geert+renesas@glider.be>
    drm/armada: Fix off-by-one error in armada_overlay_get_property()

Zeyan Li <qaz6750@outlook.com>
    arm64: dts: qcom: sm8150: Fix the I2C7 interrupt

Ruan Jinjie <ruanjinjie@huawei.com>
    of: unittest: fix null pointer dereferencing in of_unittest_find_node_by_name()

Yangtao Li <frank.li@vivo.com>
    drm/tegra: dpaux: Fix incorrect return value of platform_get_irq

Ryan McCann <quic_rmccann@quicinc.com>
    drm/msm: Update dev core dump to not print backwards

Yu Kuai <yukuai3@huawei.com>
    md/md-bitmap: hold 'reconfig_mutex' in backlog_store()

Guoqing Jiang <guoqing.jiang@linux.dev>
    md/bitmap: don't set max_write_behind if there is no write mostly device

Li Nan <linan122@huawei.com>
    md/raid10: use dereference_rdev_and_rrdev() to get devices

Li Nan <linan122@huawei.com>
    md/raid10: factor out dereference_rdev_and_rrdev()

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amdgpu: Update min() to min_t() in 'amdgpu_info_ioctl'

Manivannan Sadhasivam <mani@kernel.org>
    arm64: dts: qcom: sdm845: Fix the min frequency of "ice_core_clk"

Manivannan Sadhasivam <mani@kernel.org>
    arm64: dts: qcom: sdm845: Add missing RPMh power domain to GCC

Rafał Miłecki <rafal@milecki.pl>
    ARM: dts: BCM53573: Fix Ethernet info for Luxul devices

Bogdan Togorean <bogdan.togorean@analog.com>
    drm: adv7511: Fix low refresh rate register for ADV7533/5

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: samsung: s5pv210-smdkv210: correct ethernet reg addresses (split)

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: s5pv210: add dummy 5V regulator for backlight on SMDKv210

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: samsung: s3c6410-mini6410: correct ethernet reg addresses (split)

Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
    ARM: dts: s3c64xx: align pinctrl with dtschema

Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
    x86/mm: Fix PAT bit missing from page protection modify mask

Lucas Stach <l.stach@pengutronix.de>
    drm/etnaviv: fix dumping of active MMU context

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: pmi8994: Add missing OVP interrupt

Marijn Suijten <marijn.suijten@somainline.org>
    arm64: dts: qcom: Move WLED num-strings from pmi8994 to sony-xperia-tone

Marijn Suijten <marijn.suijten@somainline.org>
    arm64: dts: qcom: pmi8994: Remove hardcoded linear WLED enabled-strings

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: pm660l: Add missing short interrupt

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: correct SPMI WLED register range encoding

AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
    arm64: dts: qcom: pmi8998: Add node for WLED

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sm8250-sony-xperia: correct GPIO keys wakeup again

Rafał Miłecki <rafal@milecki.pl>
    ARM: dts: BCM53573: Use updated "spi-gpio" binding properties

Rafał Miłecki <rafal@milecki.pl>
    ARM: dts: BCM53573: Add cells sizes to PCIe node

Arnd Bergmann <arnd@arndb.de>
    drm/amdgpu: avoid integer overflow warning in amdgpu_device_resize_fb_bar()

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: sm8250: Mark PCIe hosts as DMA coherent

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    arm64: dts: qcom: pmk8350: fix ADC-TM compatible string

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: sm8350: Use proper CPU compatibles

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: sm8350: Add missing LMH interrupts to cpufreq

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: msm8996: Add missing interrupt to the USB2 controller

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: sm8250-edo: Rectify gpio-keys

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: sm8250-edo: Add GPIO line names for PMIC GPIOs

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: sm8250-edo: Add gpio line names for TLMM

Vincent Guittot <vincent.guittot@linaro.org>
    arm64: dts: qcom: sm8250: correct dynamic power coefficients

Luca Weiss <luca@z3ntu.xyz>
    soc: qcom: ocmem: Fix NUM_PORTS & NUM_MACROS macros

Luca Weiss <luca@z3ntu.xyz>
    soc: qcom: ocmem: Add OCMEM hardware version print

Randy Dunlap <rdunlap@infradead.org>
    ASoC: stac9766: fix build errors with REGMAP_AC97

Baokun Li <libaokun1@huawei.com>
    quota: fix dqput() to follow the guarantees dquot_srcu should provide

Baokun Li <libaokun1@huawei.com>
    quota: add new helper dquot_active()

Baokun Li <libaokun1@huawei.com>
    quota: rename dquot_active() to inode_quota_active()

Baokun Li <libaokun1@huawei.com>
    quota: factor out dquot_write_dquot()

Marek Vasut <marex@denx.de>
    drm/bridge: tc358764: Fix debug print parameter order

Kuniyuki Iwashima <kuniyu@amazon.com>
    netrom: Deny concurrent connect().

Budimir Markovic <markovicbudimir@gmail.com>
    net/sched: sch_hfsc: Ensure inner classes have fsc curve

Biju Das <biju.das.jz@bp.renesas.com>
    hwmon: (tmp513) Fix the channel number in tmp51x_is_visible()

Vadim Pasternak <vadimp@nvidia.com>
    mlxsw: i2c: Limit single transaction buffer size

Vadim Pasternak <vadimp@nvidia.com>
    mlxsw: i2c: Fix chunk size setting in output mailbox buffer

Jinjie Ruan <ruanjinjie@huawei.com>
    net: arcnet: Do not call kfree_skb() under local_irq_disable()

Wang Ming <machel@vivo.com>
    wifi: ath9k: use IS_ERR() with debugfs_create_dir()

Jinjie Ruan <ruanjinjie@huawei.com>
    Bluetooth: btusb: Do not call kfree_skb() under spin_lock_irqsave()

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: mwifiex: avoid possible NULL skb pointer dereference

Lin Ma <linma@zju.edu.cn>
    wifi: nl80211/cfg80211: add forgotten nla_policy for BSS color attribute

Fedor Pchelkin <pchelkin@ispras.ru>
    wifi: ath9k: protect WMI command response buffer replacement with a lock

Fedor Pchelkin <pchelkin@ispras.ru>
    wifi: ath9k: fix races between ath9k_wmi_cmd and ath9k_wmi_ctrl_rx

Daniel T. Lee <danieltimlee@gmail.com>
    samples/bpf: fix broken map lookup probe

Polaris Pi <pinkperfect2021@gmail.com>
    wifi: mwifiex: Fix missed return in oob checks failed path

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: mwifiex: fix memory leak in mwifiex_histogram_read()

Artem Chernyshev <artem.chernyshev@red-soft.ru>
    fs: ocfs2: namei: check return value of ocfs2_add_entry()

Yan Zhai <yan@cloudflare.com>
    lwt: Check LWTUNNEL_XMIT_CONTINUE strictly

Yan Zhai <yan@cloudflare.com>
    lwt: Fix return values of BPF xmit ops

Florian Fainelli <florian.fainelli@broadcom.com>
    hwrng: iproc-rng200 - Implement suspend and resume calls

Gaurav Jain <gaurav.jain@nxp.com>
    crypto: caam - fix unchecked return value error

Przemek Kitszel <przemyslaw.kitszel@intel.com>
    ice: ice_aq_check_events: fix off-by-one check when filling buffer

Abel Wu <wuyun.abel@bytedance.com>
    net-memcg: Fix scope of sockmem pressure indicators

Yipeng Zou <zouyipeng@huawei.com>
    selftests/bpf: Clean up fmod_ret in bench_rename test script

Menglong Dong <imagedong@tencent.com>
    net: tcp: fix unexcepted socket die when snd_wnd is 0

Min Li <lm0963hack@gmail.com>
    Bluetooth: Fix potential use-after-free when clear keys

Yuanjun Gong <ruc_gongyuanjun@163.com>
    Bluetooth: nokia: fix value check in nokia_bluetooth_serdev_probe()

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: api - Use work queue in crypto_destroy_instance

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    crypto: stm32 - Properly handle pm_runtime_get failing

Alan Maguire <alan.maguire@oracle.com>
    selftests/bpf: fix static assert compilation issue for test_cls_*.c

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: mwifiex: fix error recovery in PCIE buffer descriptor management

Polaris Pi <pinkperfect2021@gmail.com>
    wifi: mwifiex: Fix OOB and integer underflow when rx packets

Ryder Lee <ryder.lee@mediatek.com>
    wifi: mt76: mt7915: fix power-limits while chan_switch

Marc Kleine-Budde <mkl@pengutronix.de>
    can: gs_usb: gs_usb_receive_bulk_callback(): count RX overflow errors also in case of OOM

Zhang Shurong <zhang_shurong@foxmail.com>
    spi: tegra20-sflash: fix to check return value of platform_get_irq() in tegra_sflash_probe()

Lin Ma <linma@zju.edu.cn>
    wifi: mt76: testmode: add nla_policy for MT76_TM_ATTR_TX_LENGTH

David Ahern <dsahern@kernel.org>
    ipv6: Add reasons for skb drops to __udp6_lib_rcv

Lorenz Bauer <lmb@isovalent.com>
    bpf: reject unhashed sockets in bpf_sk_assign

Lorenz Bauer <lmb@isovalent.com>
    udp: re-score reuseport groups when connected sockets are present

Dan Carpenter <dan.carpenter@linaro.org>
    regmap: rbtree: Use alloc_flags for memory allocations

Martin Kaiser <martin@kaiser.cx>
    hwrng: pic32 - use devm_clk_get_enabled

Martin Kaiser <martin@kaiser.cx>
    hwrng: nomadik - keep clock enabled while hwrng is registered

Eric Dumazet <edumazet@google.com>
    tcp: tcp_enter_quickack_mode() should be static

Yafang Shao <laoar.shao@gmail.com>
    bpf: Clear the probe_addr for uprobe

Alexander Lobakin <alobakin@pm.me>
    bpftool: Use a local bpf_perf_event_value to fix accessing its fields

Liao Chang <liaochang1@huawei.com>
    cpufreq: powernow-k8: Use related_cpus instead of cpus in driver.exit()

Mikel Rychliski <mikel@mikelr.com>
    x86/efistub: Fix PCI ROM preservation in mixed mode

Mario Limonciello <mario.limonciello@amd.com>
    ACPI: x86: s2idle: Fix a logic error parsing AMD constraints table

Mario Limonciello <mario.limonciello@amd.com>
    ACPI: x86: s2idle: Post-increment variables when getting constraints

Holger Dengler <dengler@linux.ibm.com>
    s390/paes: fix PKEY_TYPE_EP11_AES handling for secure keyblobs

Holger Dengler <dengler@linux.ibm.com>
    s390/pkey: fix/harmonize internal keyblob headers

Nysal Jan K.A <nysal@linux.ibm.com>
    selftests/futex: Order calls to futex_lock_pi

Xu Yang <xu.yang_2@nxp.com>
    perf/imx_ddr: don't enable counter0 if none of 4 counters are used

Ard Biesheuvel <ardb@kernel.org>
    x86/decompressor: Don't rely on upper 32 bits of GPRs being preserved

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    selftests/resctrl: Close perf value read fd on errors

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    selftests/resctrl: Unmount resctrl FS if child fails to run benchmark

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    selftests/resctrl: Don't leak buffer in fill_cache()

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    selftests/resctrl: Add resctrl.h into build deps

Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
    selftests/resctrl: Make resctrl_tests run using kselftest framework

Manivannan Sadhasivam <mani@kernel.org>
    OPP: Fix passing 0 to PTR_ERR in _opp_attach_genpd()

Waiman Long <longman@redhat.com>
    refscale: Fix uninitalized use of wait_queue_head_t

Kees Cook <keescook@chromium.org>
    ARM: ptrace: Restore syscall skipping for tracers

Kees Cook <keescook@chromium.org>
    ARM: ptrace: Restore syscall restart tracing

Kees Cook <keescook@chromium.org>
    selftests/harness: Actually report SKIP for signal tests

Christian Brauner <brauner@kernel.org>
    tmpfs: verify {g,u}id mount options correctly

Wang Ming <machel@vivo.com>
    fs: Fix error checking for d_hash_and_lookup()

Wen Yang <wenyang.linux@foxmail.com>
    eventfd: prevent underflow for eventfd semaphores

Matthew Wilcox <willy@infradead.org>
    reiserfs: Check the return value from __getblk()

Sabrina Dubroca <sd@queasysnail.net>
    Revert "net: macsec: preserve ingress frame ordering"

Jan Kara <jack@suse.cz>
    udf: Handle error when adding extent to a file

Vladislav Efanov <VEfanov@ispras.ru>
    udf: Check consistency of Space Bitmap Descriptor

Nathan Chancellor <nathan@kernel.org>
    of: kexec: Mark ima_{free,stable}_kexec_buffer() as __init

Jordan Rife <jrife@google.com>
    net: Avoid address overwrite in kernel_connect

Joey Gouly <joey.gouly@arm.com>
    arm64: lib: Import latest version of Arm Optimized Routines' strncmp

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: rsa-pkcs1pad - Use helper to set reqsize

Shih-Yi Chen <shihyic@nvidia.com>
    platform/mellanox: Fix mlxbf-tmfifo not handling all virtio CONSOLE notifications

Zheng Yejian <zhengyejian1@huawei.com>
    tracing: Introduce pipe_cpumask to avoid race on trace_pipes

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: oss: Fix racy open/close of MIDI devices

Justin Tee <justintee8345@gmail.com>
    scsi: lpfc: Fix incorrect big endian type assignment in bsg loopback path

Michael Kelley <mikelley@microsoft.com>
    scsi: storvsc: Always set no_report_opcodes

Dan Carpenter <dan.carpenter@linaro.org>
    sctp: handle invalid error codes without calling BUG()

David Christensen <drc@linux.vnet.ibm.com>
    bnx2x: fix page fault following EEH recovery

Dmitry Mastykin <dmastykin@astralinux.ru>
    netlabel: fix shift wrapping bug in netlbl_catmap_setlong()

Lijo Lazar <lijo.lazar@amd.com>
    drm/amdgpu: Match against exact bootloader status

Jian Shen <shenjian15@huawei.com>
    net: hns3: restore user pause configure when disable autoneg

Chengfeng Ye <dg573847474@gmail.com>
    scsi: qedi: Fix potential deadlock on &qedi_percpu->p_work_lock

Justin Tee <justin.tee@broadcom.com>
    scsi: lpfc: Remove reftag check in DIF paths

Baoquan He <bhe@redhat.com>
    idmaengine: make FSL_EDMA and INTEL_IDMA64 depends on HAS_IOMEM

Hans de Goede <hdegoede@redhat.com>
    wifi: brcmfmac: Fix field-spanning write in brcmf_scan_params_v2_to_v1()

Martin Kohn <m.kohn@welotec.com>
    net: usb: qmi_wwan: add Quectel EM05GV2

Ani Sinha <anisinha@redhat.com>
    vmbus_testing: fix wrong python syntax for integer value comparison

Baoquan He <bhe@redhat.com>
    clk: fixed-mmio: make COMMON_CLK_FIXED_MMIO depend on HAS_IOMEM

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    kprobes: Prohibit probing on CFI preamble symbol

Christian Göttsche <cgzones@googlemail.com>
    security: keys: perform capable check only on privileged operations

Minjie Du <duminjie@vivo.com>
    ata: pata_arasan_cf: Use dev_err_probe() instead dev_err() in data_xfer()

Eric Snowberg <eric.snowberg@oracle.com>
    ovl: Always reevaluate the file signature for IMA

Leo Chen <sancchen@amd.com>
    drm/amd/display: Exit idle optimizations before attempt to access PHY

Konstantin Shelekhin <k.shelekhin@ftml.net>
    platform/x86: huawei-wmi: Silence ambient light sensor

Maxim Mikityanskiy <maxtram95@gmail.com>
    platform/x86/intel/hid: Add HP Dragonfly G2 to VGBS DMI quirks

Hans de Goede <hdegoede@redhat.com>
    platform/x86: intel: hid: Always call BTNL ACPI method

Guiting Shen <aarongt.shen@gmail.com>
    ASoC: atmel: Fix the 8K sample parameter in I2SC master

Shuming Fan <shumingf@realtek.com>
    ASoC: rt711-sdca: fix for JD event handling in ClockStop Mode0

Shuming Fan <shumingf@realtek.com>
    ASoC: rt711: fix for JD event handling in ClockStop Mode0

Edgar <ljijcj@163.com>
    ASoc: codecs: ES8316: Fix DMIC config

Shuming Fan <shumingf@realtek.com>
    ASoC: rt5682-sdw: fix for JD event handling in ClockStop Mode0

Winston Wen <wentao@uniontech.com>
    fs/nls: make load_nls() take a const parameter

Stefan Haberland <sth@linux.ibm.com>
    s390/dasd: fix hanging device after request requeue

Stefan Haberland <sth@linux.ibm.com>
    s390/dasd: use correct number of retries for ERP requests

Ben Hutchings <benh@debian.org>
    m68k: Fix invalid .section syntax

Jiri Benc <jbenc@redhat.com>
    vxlan: generalize vxlan_parse_gpe_hdr and remove unused args

Yuanjun Gong <ruc_gongyuanjun@163.com>
    ethernet: atheros: fix return value check in atl1c_tso_csum()

Dmytro Maluka <dmy@semihalf.com>
    ASoC: da7219: Check for failure reading AAD IRQ events

Dmytro Maluka <dmy@semihalf.com>
    ASoC: da7219: Flush pending AAD IRQ when suspending

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: no response from compound read

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix out of bounds in smb3_decrypt_req()

Dominique Martinet <asmadeus@codewreck.org>
    9p: virtio: make sure 'offs' is initialized in zc_request

Nikolay Burykin <burikin@ivk.ru>
    media: pci: cx23885: fix error handling for cx23885 ATSC boards

Dmitry Antipov <dmantipov@yandex.ru>
    media: pulse8-cec: handle possible ping error

Adrien Thierry <athierry@redhat.com>
    phy: qcom-snps-femto-v2: use qcom_snps_hsphy_suspend/resume error code

Xiaolei Wang <xiaolei.wang@windriver.com>
    ARM: dts: imx: Set default tuning step for imx7d usdhc

Stefan Wahren <stefan.wahren@i2se.com>
    ARM: dts: imx: Adjust dma-apbh node name

Marek Vasut <marex@denx.de>
    ARM: dts: imx7s: Drop dma-apb interrupt-names

Joy Zou <joy.zou@nxp.com>
    ARM: dts: imx: update sdma node name format


-------------

Diffstat:

 .../devicetree/bindings/clock/xlnx,versal-clk.yaml |   2 -
 Documentation/scsi/scsi_mid_low_api.rst            |   4 +-
 Makefile                                           |   6 +-
 arch/arc/include/asm/atomic-llsc.h                 |   6 +-
 arch/arc/include/asm/atomic64-arcv2.h              |   6 +-
 arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts    |   3 +-
 arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts      |  13 +
 arch/arm/boot/dts/bcm47189-luxul-xap-810.dts       |  13 +
 arch/arm/boot/dts/bcm53573.dtsi                    |   3 +
 arch/arm/boot/dts/bcm947189acdbmr.dts              |   6 +-
 arch/arm/boot/dts/exynos4210-i9100.dts             |   4 +-
 arch/arm/boot/dts/imx23.dtsi                       |   2 +-
 arch/arm/boot/dts/imx25.dtsi                       |   2 +-
 arch/arm/boot/dts/imx28.dtsi                       |   2 +-
 arch/arm/boot/dts/imx31.dtsi                       |   2 +-
 arch/arm/boot/dts/imx35.dtsi                       |   2 +-
 arch/arm/boot/dts/imx50.dtsi                       |   2 +-
 arch/arm/boot/dts/imx51.dtsi                       |   2 +-
 arch/arm/boot/dts/imx53.dtsi                       |   2 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |   4 +-
 arch/arm/boot/dts/imx6sl.dtsi                      |   2 +-
 arch/arm/boot/dts/imx6sx.dtsi                      |   4 +-
 arch/arm/boot/dts/imx6ul.dtsi                      |   4 +-
 arch/arm/boot/dts/imx7s.dtsi                       |  11 +-
 arch/arm/boot/dts/s3c6410-mini6410.dts             |   6 +-
 arch/arm/boot/dts/s3c64xx-pinctrl.dtsi             | 210 ++++++-------
 arch/arm/boot/dts/s5pv210-smdkv210.dts             |  10 +-
 arch/arm/include/asm/syscall.h                     |   3 +
 arch/arm/kernel/entry-common.S                     |   1 +
 arch/arm/kernel/ptrace.c                           |   5 +-
 arch/arm/mach-omap2/powerdomain.c                  |   2 +-
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts           |   6 +-
 .../boot/dts/qcom/msm8996-sony-xperia-tone.dtsi    |   1 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |   3 +
 arch/arm64/boot/dts/qcom/pm660l.dtsi               |   7 +-
 arch/arm64/boot/dts/qcom/pmi8994.dtsi              |  10 +-
 arch/arm64/boot/dts/qcom/pmi8998.dtsi              |  12 +
 arch/arm64/boot/dts/qcom/pmk8350.dtsi              |   2 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |   3 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |   2 +-
 .../dts/qcom/sm8250-sony-xperia-edo-pdx203.dts     | 233 ++++++++++++++
 .../dts/qcom/sm8250-sony-xperia-edo-pdx206.dts     | 243 ++++++++++++++
 .../boot/dts/qcom/sm8250-sony-xperia-edo.dtsi      |  54 +++-
 arch/arm64/boot/dts/qcom/sm8250.dtsi               |  11 +-
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |  23 +-
 arch/arm64/include/asm/sdei.h                      |   6 +
 arch/arm64/kernel/entry.S                          |  27 +-
 arch/arm64/kernel/sdei.c                           |   3 +
 arch/arm64/kernel/smp.c                            |   8 +-
 arch/arm64/lib/csum.c                              |   2 +-
 arch/arm64/lib/strncmp.S                           | 234 ++++++++------
 arch/m68k/fpsp040/skeleton.S                       |   4 +-
 arch/m68k/ifpsp060/os.S                            |   4 +-
 arch/m68k/kernel/relocate_kernel.S                 |   4 +-
 arch/mips/Makefile                                 |   6 +-
 arch/parisc/include/asm/led.h                      |   4 +-
 arch/parisc/kernel/processor.c                     |  13 +-
 arch/powerpc/include/asm/lppaca.h                  |  13 +-
 arch/powerpc/include/asm/paca.h                    |   6 +-
 arch/powerpc/include/asm/paravirt.h                |   1 +
 arch/powerpc/include/asm/plpar_wrappers.h          |   1 +
 arch/powerpc/kernel/fadump.c                       |   1 +
 arch/powerpc/kernel/iommu.c                        |  17 +-
 arch/powerpc/kvm/book3s_hv_ras.c                   |   1 +
 arch/powerpc/mm/book3s64/radix_tlb.c               | 240 +++++++-------
 arch/powerpc/mm/book3s64/slb.c                     |   1 +
 arch/powerpc/perf/core-fsl-emb.c                   |   8 +-
 arch/powerpc/platforms/pseries/lpar.c              |  10 +-
 arch/powerpc/platforms/pseries/lparcfg.c           |   4 +-
 arch/powerpc/platforms/pseries/setup.c             |   2 +-
 arch/powerpc/xmon/xmon.c                           |   1 +
 arch/s390/crypto/paes_s390.c                       |   2 +-
 arch/s390/kernel/ipl.c                             |   2 +
 arch/sh/boards/mach-ap325rxa/setup.c               |   2 +-
 arch/sh/boards/mach-ecovec24/setup.c               |   6 +-
 arch/sh/boards/mach-kfr2r09/setup.c                |   2 +-
 arch/sh/boards/mach-migor/setup.c                  |   2 +-
 arch/sh/boards/mach-se/7724/setup.c                |   6 +-
 arch/um/configs/i386_defconfig                     |   1 +
 arch/um/configs/x86_64_defconfig                   |   1 +
 arch/um/drivers/Kconfig                            |  16 +-
 arch/um/drivers/Makefile                           |   2 +-
 arch/x86/boot/compressed/head_64.S                 |  30 +-
 arch/x86/events/intel/uncore_snbep.c               |  12 +-
 arch/x86/include/asm/pgtable_types.h               |  11 +-
 arch/x86/include/asm/virtext.h                     |   6 -
 arch/x86/kernel/apm_32.c                           |   6 -
 arch/x86/kernel/cpu/common.c                       |   8 +-
 arch/x86/kernel/cpu/sgx/virt.c                     |   3 +
 arch/xtensa/include/asm/core.h                     |   9 +
 arch/xtensa/kernel/perf_event.c                    |  17 +-
 block/bdev.c                                       |   2 +-
 block/genhd.c                                      |   2 +-
 block/ioctl.c                                      |   2 +
 block/partitions/core.c                            |  15 +-
 crypto/algapi.c                                    |  16 +-
 crypto/asymmetric_keys/x509_public_key.c           |   5 +
 crypto/rsa-pkcs1pad.c                              |   5 +-
 drivers/acpi/x86/s2idle.c                          |  39 +--
 drivers/amba/bus.c                                 |   1 +
 drivers/ata/pata_arasan_cf.c                       |   3 +-
 drivers/ata/pata_falcon.c                          |  50 +--
 drivers/ata/pata_ftide010.c                        |   1 +
 drivers/ata/sata_gemini.c                          |   1 +
 drivers/base/regmap/regcache-rbtree.c              |  10 +-
 drivers/base/test/test_async_driver_probe.c        |   2 +-
 drivers/block/loop.c                               |   8 +-
 drivers/block/n64cart.c                            |   2 +-
 drivers/block/paride/pcd.c                         | 298 ++++++++----------
 drivers/bluetooth/btusb.c                          |   2 +-
 drivers/bluetooth/hci_nokia.c                      |   6 +-
 drivers/bus/mhi/host/pm.c                          |   5 +
 drivers/bus/ti-sysc.c                              |   2 +-
 drivers/char/hw_random/iproc-rng200.c              |  25 ++
 drivers/char/hw_random/nomadik-rng.c               |  12 +-
 drivers/char/hw_random/pic32-rng.c                 |  19 +-
 drivers/char/ipmi/ipmi_si_intf.c                   |   5 +
 drivers/char/ipmi/ipmi_ssif.c                      |   7 +-
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/imx/clk-composite-8m.c                 |  12 +-
 drivers/clk/imx/clk-imx8mp.c                       |   5 -
 drivers/clk/imx/clk-pll14xx.c                      |   2 -
 drivers/clk/keystone/pll.c                         |   2 +-
 drivers/clk/qcom/camcc-sc7180.c                    |   2 +-
 drivers/clk/qcom/gcc-mdm9615.c                     |   2 +-
 drivers/clk/qcom/gcc-sc7180.c                      |   1 +
 drivers/clk/qcom/gcc-sm6350.c                      |   1 +
 drivers/clk/qcom/gcc-sm8250.c                      |   1 +
 drivers/clk/qcom/mss-sc7180.c                      |  13 +-
 drivers/clk/qcom/q6sstop-qcs404.c                  |  15 +-
 drivers/clk/qcom/reset.c                           |   3 +-
 drivers/clk/qcom/turingcc-qcs404.c                 |  13 +-
 drivers/clk/sunxi-ng/ccu_mmc_timing.c              |   2 +-
 drivers/cpufreq/brcmstb-avs-cpufreq.c              |   6 +-
 drivers/cpufreq/cpufreq.c                          |   2 +
 drivers/cpufreq/powernow-k8.c                      |   3 +-
 drivers/cpuidle/cpuidle-pseries.c                  |   8 +-
 drivers/crypto/caam/caampkc.c                      |   4 +-
 drivers/crypto/stm32/stm32-hash.c                  |   9 +-
 drivers/devfreq/devfreq.c                          |   1 +
 drivers/dma/Kconfig                                |   2 +
 drivers/dma/sh/rz-dmac.c                           |  11 +-
 drivers/dma/ste_dma40.c                            |   4 +
 drivers/edac/igen6_edac.c                          |   8 +-
 drivers/firmware/arm_sdei.c                        |  19 ++
 drivers/firmware/efi/libstub/x86-stub.c            |   2 +-
 drivers/firmware/meson/meson_sm.c                  |   2 +
 drivers/fsi/fsi-master-aspeed.c                    |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   6 +-
 drivers/gpu/drm/amd/amdgpu/cik.c                   |  36 +--
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c             |  15 +-
 drivers/gpu/drm/amd/amdgpu/si.c                    |  36 +--
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |   3 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c   |   5 +-
 .../drm/amd/display/modules/freesync/freesync.c    |   9 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |  10 +-
 drivers/gpu/drm/armada/armada_overlay.c            |   6 +-
 drivers/gpu/drm/ast/ast_post.c                     |   2 +-
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |   9 +-
 drivers/gpu/drm/bridge/tc358764.c                  |   2 +-
 drivers/gpu/drm/etnaviv/etnaviv_dump.c             |  14 +-
 drivers/gpu/drm/i915/gvt/gtt.c                     |  18 --
 drivers/gpu/drm/i915/gvt/gtt.h                     |   1 -
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |   7 +-
 drivers/gpu/drm/mediatek/mtk_drm_gem.c             |   6 +-
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c              |   8 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c         |   3 +-
 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c  |   2 +-
 drivers/gpu/drm/panel/panel-simple.c               |   4 +-
 drivers/gpu/drm/radeon/cik.c                       |  36 +--
 drivers/gpu/drm/radeon/si.c                        |  37 +--
 drivers/gpu/drm/tegra/dpaux.c                      |   2 +-
 drivers/gpu/drm/xlnx/zynqmp_dpsub.c                |   4 +-
 drivers/hid/hid-logitech-dj.c                      |   5 +-
 drivers/hid/hid-multitouch.c                       |  13 +-
 drivers/hwmon/tmp513.c                             |   2 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |   2 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |   5 +-
 drivers/hwtracing/coresight/coresight-tmc.h        |   2 +-
 drivers/i3c/master/svc-i3c-master.c                |  14 +-
 .../infiniband/core/uverbs_std_types_counters.c    |   2 +
 drivers/infiniband/hw/hns/hns_roce_device.h        |   1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |   3 +-
 drivers/infiniband/hw/hns/hns_roce_main.c          |   7 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c            |  28 +-
 drivers/infiniband/hw/irdma/main.h                 |   2 +-
 drivers/infiniband/hw/irdma/verbs.c                |   1 -
 drivers/infiniband/ulp/isert/ib_isert.c            |   2 +
 drivers/infiniband/ulp/srp/ib_srp.c                |   4 -
 drivers/input/keyboard/tca6416-keypad.c            |  31 +-
 drivers/iommu/amd/iommu_v2.c                       |   4 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c            |   7 +
 drivers/iommu/intel/pasid.c                        |   2 +-
 drivers/iommu/rockchip-iommu.c                     |  43 +--
 drivers/iommu/sprd-iommu.c                         |   1 +
 drivers/leds/led-class-multicolor.c                |   8 +-
 drivers/leds/led-core.c                            |   8 +-
 drivers/leds/leds-pwm.c                            |   2 +-
 drivers/leds/trigger/ledtrig-tty.c                 |  12 +-
 drivers/md/md-bitmap.c                             |  28 +-
 drivers/md/md-linear.c                             |  14 +-
 drivers/md/md.c                                    |  30 +-
 drivers/md/md.h                                    |  72 ++---
 drivers/md/raid0.c                                 |  96 +++---
 drivers/md/raid1.c                                 |  43 ++-
 drivers/md/raid10.c                                |  82 +++--
 drivers/media/cec/usb/pulse8/pulse8-cec.c          |   7 +-
 drivers/media/dvb-frontends/ascot2e.c              |   2 +-
 drivers/media/dvb-frontends/atbm8830.c             |   2 +-
 drivers/media/dvb-frontends/au8522_dig.c           |   2 +-
 drivers/media/dvb-frontends/bcm3510.c              |   2 +-
 drivers/media/dvb-frontends/cx22700.c              |   2 +-
 drivers/media/dvb-frontends/cx22702.c              |   2 +-
 drivers/media/dvb-frontends/cx24110.c              |   2 +-
 drivers/media/dvb-frontends/cx24113.c              |   2 +-
 drivers/media/dvb-frontends/cx24116.c              |   2 +-
 drivers/media/dvb-frontends/cx24120.c              |   6 +-
 drivers/media/dvb-frontends/cx24123.c              |   2 +-
 drivers/media/dvb-frontends/cxd2820r_core.c        |   2 +-
 drivers/media/dvb-frontends/cxd2841er.c            |   4 +-
 drivers/media/dvb-frontends/cxd2880/cxd2880_top.c  |   2 +-
 drivers/media/dvb-frontends/dib0070.c              |   2 +-
 drivers/media/dvb-frontends/dib0090.c              |   4 +-
 drivers/media/dvb-frontends/dib3000mb.c            |   2 +-
 drivers/media/dvb-frontends/dib3000mc.c            |   2 +-
 drivers/media/dvb-frontends/dib7000m.c             |   2 +-
 drivers/media/dvb-frontends/dib7000p.c             |   4 +-
 drivers/media/dvb-frontends/dib8000.c              |   2 +-
 drivers/media/dvb-frontends/dib9000.c              |   2 +-
 drivers/media/dvb-frontends/drx39xyj/drxj.c        |   2 +-
 drivers/media/dvb-frontends/drxd_hard.c            |   2 +-
 drivers/media/dvb-frontends/drxk_hard.c            |   2 +-
 drivers/media/dvb-frontends/ds3000.c               |   2 +-
 drivers/media/dvb-frontends/dvb-pll.c              |   2 +-
 drivers/media/dvb-frontends/ec100.c                |   2 +-
 drivers/media/dvb-frontends/helene.c               |   4 +-
 drivers/media/dvb-frontends/horus3a.c              |   2 +-
 drivers/media/dvb-frontends/isl6405.c              |   2 +-
 drivers/media/dvb-frontends/isl6421.c              |   2 +-
 drivers/media/dvb-frontends/isl6423.c              |   2 +-
 drivers/media/dvb-frontends/itd1000.c              |   2 +-
 drivers/media/dvb-frontends/ix2505v.c              |   2 +-
 drivers/media/dvb-frontends/l64781.c               |   2 +-
 drivers/media/dvb-frontends/lg2160.c               |   2 +-
 drivers/media/dvb-frontends/lgdt3305.c             |   2 +-
 drivers/media/dvb-frontends/lgdt3306a.c            |   2 +-
 drivers/media/dvb-frontends/lgdt330x.c             |   2 +-
 drivers/media/dvb-frontends/lgs8gxx.c              |   2 +-
 drivers/media/dvb-frontends/lnbh25.c               |   2 +-
 drivers/media/dvb-frontends/lnbp21.c               |   4 +-
 drivers/media/dvb-frontends/lnbp22.c               |   2 +-
 drivers/media/dvb-frontends/m88ds3103.c            |   2 +-
 drivers/media/dvb-frontends/m88rs2000.c            |   2 +-
 drivers/media/dvb-frontends/mb86a16.c              |   2 +-
 drivers/media/dvb-frontends/mb86a20s.c             |   2 +-
 drivers/media/dvb-frontends/mt312.c                |   2 +-
 drivers/media/dvb-frontends/mt352.c                |   2 +-
 drivers/media/dvb-frontends/nxt200x.c              |   2 +-
 drivers/media/dvb-frontends/nxt6000.c              |   2 +-
 drivers/media/dvb-frontends/or51132.c              |   2 +-
 drivers/media/dvb-frontends/or51211.c              |   2 +-
 drivers/media/dvb-frontends/s5h1409.c              |   2 +-
 drivers/media/dvb-frontends/s5h1411.c              |   2 +-
 drivers/media/dvb-frontends/s5h1420.c              |   2 +-
 drivers/media/dvb-frontends/s5h1432.c              |   2 +-
 drivers/media/dvb-frontends/s921.c                 |   2 +-
 drivers/media/dvb-frontends/si21xx.c               |   2 +-
 drivers/media/dvb-frontends/sp887x.c               |   2 +-
 drivers/media/dvb-frontends/stb0899_drv.c          |   2 +-
 drivers/media/dvb-frontends/stb6000.c              |   2 +-
 drivers/media/dvb-frontends/stb6100.c              |   2 +-
 drivers/media/dvb-frontends/stv0288.c              |   2 +-
 drivers/media/dvb-frontends/stv0297.c              |   2 +-
 drivers/media/dvb-frontends/stv0299.c              |   2 +-
 drivers/media/dvb-frontends/stv0367.c              |   6 +-
 drivers/media/dvb-frontends/stv0900_core.c         |   2 +-
 drivers/media/dvb-frontends/stv090x.c              |   2 +-
 drivers/media/dvb-frontends/stv6110.c              |   2 +-
 drivers/media/dvb-frontends/stv6110x.c             |   2 +-
 drivers/media/dvb-frontends/tda10021.c             |   2 +-
 drivers/media/dvb-frontends/tda10023.c             |   2 +-
 drivers/media/dvb-frontends/tda10048.c             |   2 +-
 drivers/media/dvb-frontends/tda1004x.c             |   4 +-
 drivers/media/dvb-frontends/tda10086.c             |   2 +-
 drivers/media/dvb-frontends/tda665x.c              |   2 +-
 drivers/media/dvb-frontends/tda8083.c              |   2 +-
 drivers/media/dvb-frontends/tda8261.c              |   2 +-
 drivers/media/dvb-frontends/tda826x.c              |   2 +-
 drivers/media/dvb-frontends/ts2020.c               |   2 +-
 drivers/media/dvb-frontends/tua6100.c              |   2 +-
 drivers/media/dvb-frontends/ves1820.c              |   2 +-
 drivers/media/dvb-frontends/ves1x93.c              |   2 +-
 drivers/media/dvb-frontends/zl10036.c              |   2 +-
 drivers/media/dvb-frontends/zl10039.c              |   2 +-
 drivers/media/dvb-frontends/zl10353.c              |   2 +-
 drivers/media/i2c/ad5820.c                         |   2 -
 drivers/media/i2c/ccs/ccs-data.c                   | 101 +++---
 drivers/media/i2c/ov2680.c                         | 332 +++++---------------
 drivers/media/i2c/ov5640.c                         |   4 +-
 drivers/media/i2c/rdacm21.c                        |   2 +-
 drivers/media/i2c/tvp5150.c                        |   4 +
 drivers/media/pci/bt8xx/dst.c                      |   2 +-
 drivers/media/pci/bt8xx/dst_ca.c                   |   2 +-
 drivers/media/pci/cx23885/cx23885-dvb.c            |  12 -
 drivers/media/pci/ddbridge/ddbridge-dummy-fe.c     |   2 +-
 .../media/platform/mtk-vcodec/vdec/vdec_vp9_if.c   |   5 +-
 drivers/media/platform/qcom/venus/hfi_venus.c      |  20 +-
 drivers/media/tuners/fc0011.c                      |   2 +-
 drivers/media/tuners/fc0012.c                      |   2 +-
 drivers/media/tuners/fc0013.c                      |   2 +-
 drivers/media/tuners/max2165.c                     |   2 +-
 drivers/media/tuners/mc44s803.c                    |   2 +-
 drivers/media/tuners/mt2060.c                      |   2 +-
 drivers/media/tuners/mt2131.c                      |   2 +-
 drivers/media/tuners/mt2266.c                      |   2 +-
 drivers/media/tuners/mxl5005s.c                    |   2 +-
 drivers/media/tuners/qt1010.c                      |   2 +-
 drivers/media/tuners/tda18218.c                    |   2 +-
 drivers/media/tuners/xc4000.c                      |   2 +-
 drivers/media/tuners/xc5000.c                      |   2 +-
 drivers/media/usb/dvb-usb/m920x.c                  |   5 +-
 drivers/media/usb/go7007/go7007-i2c.c              |   2 -
 drivers/media/usb/siano/smsusb.c                   |  21 +-
 drivers/media/v4l2-core/v4l2-fwnode.c              |  18 +-
 drivers/mmc/core/block.c                           |   4 +-
 drivers/mmc/host/renesas_sdhi_core.c               |  10 +-
 drivers/mtd/nand/raw/brcmnand/brcmnand.c           |  45 ++-
 drivers/mtd/nand/raw/fsmc_nand.c                   |   7 +-
 drivers/mtd/spi-nor/core.c                         |  19 +-
 drivers/net/arcnet/arcnet.c                        |   2 +-
 drivers/net/can/usb/gs_usb.c                       |   5 +-
 drivers/net/dsa/sja1105/sja1105.h                  |   2 +
 drivers/net/dsa/sja1105/sja1105_main.c             |  62 +++-
 drivers/net/dsa/sja1105/sja1105_spi.c              |   4 +
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c    |   7 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |   9 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   1 +
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |   7 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |   2 -
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |   4 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c |  20 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c |  14 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  10 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |   2 -
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  |   2 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h  |   1 +
 drivers/net/ethernet/intel/ice/ice_main.c          |  13 +-
 drivers/net/ethernet/intel/igb/igb.h               |   4 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |  16 +-
 drivers/net/ethernet/intel/igbvf/igbvf.h           |   4 +-
 drivers/net/ethernet/intel/igc/igc.h               |   4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c       |  28 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |   5 +
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |  21 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |   3 +
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c |   9 +-
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c  |  17 +-
 drivers/net/ethernet/mellanox/mlxsw/i2c.c          |   5 +-
 drivers/net/macsec.c                               |   3 +-
 drivers/net/usb/qmi_wwan.c                         |   1 +
 drivers/net/usb/r8152.c                            |   3 +
 drivers/net/veth.c                                 |   4 +-
 drivers/net/vxlan/vxlan_core.c                     |  58 ++--
 drivers/net/wireless/ath/ath10k/pci.c              |   9 +-
 drivers/net/wireless/ath/ath11k/pci.c              |  10 +-
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c     |   2 +-
 drivers/net/wireless/ath/ath9k/wmi.c               |  20 +-
 .../broadcom/brcm80211/brcmfmac/fwil_types.h       |   7 +-
 drivers/net/wireless/marvell/mwifiex/debugfs.c     |   9 +-
 drivers/net/wireless/marvell/mwifiex/pcie.c        |  25 +-
 drivers/net/wireless/marvell/mwifiex/sta_rx.c      |  12 +-
 drivers/net/wireless/marvell/mwifiex/uap_txrx.c    |  30 +-
 drivers/net/wireless/marvell/mwifiex/util.c        |  10 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   |   3 +-
 drivers/net/wireless/mediatek/mt76/testmode.c      |   1 +
 drivers/ntb/ntb_transport.c                        |  19 +-
 drivers/of/kexec.c                                 |   2 +-
 drivers/of/overlay.c                               |   3 +-
 drivers/of/unittest.c                              |  12 +-
 drivers/opp/core.c                                 |   2 +-
 drivers/parisc/led.c                               |   4 +-
 drivers/pci/controller/dwc/pci-layerscape-ep.c     | 123 +++++++-
 drivers/pci/controller/dwc/pcie-designware-ep.c    |   8 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  |  10 +-
 drivers/pci/controller/dwc/pcie-designware-plat.c  |  10 -
 drivers/pci/controller/dwc/pcie-designware.h       |  14 +
 drivers/pci/controller/pcie-microchip-host.c       |   8 +-
 drivers/pci/controller/pcie-rockchip.h             |   6 +-
 drivers/pci/hotplug/pciehp_hpc.c                   |  12 +-
 drivers/pci/pcie/aspm.c                            |  30 +-
 drivers/perf/fsl_imx8_ddr_perf.c                   |  24 +-
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c      |   6 +-
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c      |  18 +-
 drivers/pinctrl/intel/pinctrl-cherryview.c         |   5 +-
 drivers/pinctrl/pinctrl-mcp23s08_spi.c             |  10 +
 drivers/platform/mellanox/mlxbf-pmc.c              |  41 +--
 drivers/platform/mellanox/mlxbf-tmfifo.c           |  91 ++++--
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c |   9 +-
 drivers/platform/x86/huawei-wmi.c                  |   2 +
 drivers/platform/x86/intel/hid.c                   |  27 +-
 drivers/pwm/pwm-atmel-tcb.c                        |  70 ++---
 drivers/pwm/pwm-lpc32xx.c                          |  16 +-
 drivers/rpmsg/qcom_glink_native.c                  |   4 +
 drivers/s390/block/dasd.c                          | 125 +++-----
 drivers/s390/block/dasd_3990_erp.c                 |   2 +-
 drivers/s390/crypto/pkey_api.c                     |   2 +-
 drivers/s390/crypto/zcrypt_api.c                   |   1 +
 drivers/s390/crypto/zcrypt_ep11misc.c              |   4 +-
 drivers/s390/crypto/zcrypt_ep11misc.h              |   9 +-
 drivers/scsi/be2iscsi/be_iscsi.c                   |   4 +
 drivers/scsi/fcoe/fcoe_ctlr.c                      |  20 +-
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c             |  11 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c             |  55 +++-
 drivers/scsi/hosts.c                               |   4 +-
 drivers/scsi/lpfc/lpfc_bsg.c                       |   8 +-
 drivers/scsi/lpfc/lpfc_scsi.c                      |  20 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c                |  46 ++-
 drivers/scsi/mpt3sas/mpt3sas_base.h                |   1 +
 drivers/scsi/qedf/qedf_dbg.h                       |   2 +
 drivers/scsi/qedf/qedf_debugfs.c                   |  35 ++-
 drivers/scsi/qedi/qedi_main.c                      |   5 +-
 drivers/scsi/qla2xxx/qla_attr.c                    |   2 -
 drivers/scsi/qla2xxx/qla_dbg.c                     |   2 +-
 drivers/scsi/qla2xxx/qla_def.h                     |  21 +-
 drivers/scsi/qla2xxx/qla_dfs.c                     |  10 +
 drivers/scsi/qla2xxx/qla_gbl.h                     |   1 +
 drivers/scsi/qla2xxx/qla_init.c                    | 236 +++++++++-----
 drivers/scsi/qla2xxx/qla_inline.h                  |  57 +++-
 drivers/scsi/qla2xxx/qla_iocb.c                    |   1 +
 drivers/scsi/qla2xxx/qla_isr.c                     |   7 +-
 drivers/scsi/qla2xxx/qla_mbx.c                     |   7 +-
 drivers/scsi/qla2xxx/qla_nvme.c                    |   3 +-
 drivers/scsi/qla2xxx/qla_os.c                      |  26 +-
 drivers/scsi/qla2xxx/qla_target.c                  |  14 +-
 drivers/scsi/qla4xxx/ql4_os.c                      |  15 +
 drivers/scsi/scsi_transport_iscsi.c                |  80 +++--
 drivers/scsi/sr.c                                  |   5 +-
 drivers/scsi/storvsc_drv.c                         |   2 +
 drivers/soc/qcom/ocmem.c                           |  14 +-
 drivers/soc/qcom/qmi_encdec.c                      |   4 +-
 drivers/spi/spi-tegra20-sflash.c                   |   6 +-
 drivers/staging/media/av7110/sp8870.c              |   2 +-
 drivers/staging/media/rkvdec/rkvdec.c              |   2 +-
 drivers/tty/serial/serial-tegra.c                  |   6 +-
 drivers/tty/serial/sprd_serial.c                   |  30 +-
 drivers/usb/core/hcd.c                             |  10 +-
 drivers/usb/core/hub.c                             | 349 ++++++++++++---------
 drivers/usb/core/message.c                         |  29 +-
 drivers/usb/core/usb.h                             |   4 +-
 drivers/usb/gadget/function/f_mass_storage.c       |   2 +-
 drivers/usb/phy/phy-mxs-usb.c                      |  10 +-
 drivers/usb/typec/bus.c                            |  12 +-
 drivers/usb/typec/tcpm/tcpm.c                      |  38 ++-
 drivers/vfio/vfio_iommu_type1.c                    |   2 +-
 drivers/video/backlight/bd6107.c                   |   2 +-
 drivers/video/backlight/gpio_backlight.c           |   5 +-
 drivers/video/backlight/lv5207lp.c                 |   2 +-
 drivers/video/fbdev/ep93xx-fb.c                    |   1 -
 drivers/virtio/virtio_ring.c                       |   2 +-
 drivers/watchdog/intel-mid_wdt.c                   |   1 +
 fs/btrfs/disk-io.c                                 |   5 +-
 fs/btrfs/inode.c                                   |   7 +
 fs/btrfs/transaction.c                             |   7 +-
 fs/dlm/plock.c                                     |   6 +-
 fs/eventfd.c                                       |   2 +-
 fs/ext4/balloc.c                                   |  15 +-
 fs/ext4/block_validity.c                           |   8 +-
 fs/ext4/ext4.h                                     |   2 +
 fs/ext4/mballoc.c                                  |   7 +-
 fs/ext4/namei.c                                    |   3 +
 fs/fuse/readdir.c                                  |  10 +-
 fs/gfs2/aops.c                                     |   4 +-
 fs/gfs2/log.c                                      |  25 +-
 fs/jbd2/checkpoint.c                               |  22 +-
 fs/jfs/jfs_extent.c                                |   5 +
 fs/ksmbd/smb2pdu.c                                 |   8 +-
 fs/lockd/mon.c                                     |   3 +
 fs/namei.c                                         |   2 +-
 fs/nfs/blocklayout/dev.c                           |   4 +-
 fs/nfs/direct.c                                    |  20 +-
 fs/nfs/nfs2xdr.c                                   |   2 +-
 fs/nfs/nfs3xdr.c                                   |   2 +-
 fs/nfs/nfs42proc.c                                 |   5 +-
 fs/nfs/pnfs_dev.c                                  |   2 +-
 fs/nfs/pnfs_nfs.c                                  |   2 +-
 fs/nfsd/blocklayoutxdr.c                           |   9 +
 fs/nfsd/flexfilelayoutxdr.c                        |   9 +
 fs/nfsd/nfs4xdr.c                                  |  25 +-
 fs/nls/nls_base.c                                  |   4 +-
 fs/ocfs2/namei.c                                   |   4 +
 fs/overlayfs/super.c                               |   2 +-
 fs/proc/base.c                                     |   3 +-
 fs/pstore/ram_core.c                               |   2 +-
 fs/quota/dquot.c                                   | 174 ++++++----
 fs/reiserfs/journal.c                              |   4 +-
 fs/udf/balloc.c                                    |  31 +-
 fs/udf/inode.c                                     |  45 ++-
 fs/verity/signature.c                              |  16 +
 include/crypto/algapi.h                            |   3 +
 include/linux/arm_sdei.h                           |   2 +
 include/linux/ceph/ceph_fs.h                       |  24 +-
 include/linux/genhd.h                              |  27 +-
 include/linux/if_arp.h                             |   4 +
 include/linux/memcontrol.h                         |   9 +-
 include/linux/micrel_phy.h                         |   6 +-
 include/linux/nls.h                                |   2 +-
 include/linux/of.h                                 |   2 +-
 include/linux/tca6416_keypad.h                     |   1 -
 include/linux/trace_events.h                       |   3 +-
 include/linux/usb/typec_altmode.h                  |   2 +-
 include/net/ip.h                                   |   1 +
 include/net/ip6_fib.h                              |   5 +-
 include/net/ip_fib.h                               |   5 +-
 include/net/ip_tunnels.h                           |  15 +-
 include/net/ipv6.h                                 |   2 +-
 include/net/lwtunnel.h                             |   5 +-
 include/net/tcp.h                                  |   1 -
 include/scsi/scsi_host.h                           |   2 +-
 include/uapi/linux/sync_file.h                     |   2 +-
 io_uring/io-wq.c                                   |  10 +
 io_uring/io-wq.h                                   |   1 +
 io_uring/io_uring.c                                |  11 +-
 kernel/auditsc.c                                   |   2 +
 kernel/bpf/verifier.c                              |  17 +-
 kernel/cgroup/namespace.c                          |   6 -
 kernel/kprobes.c                                   |  14 +-
 kernel/printk/printk_ringbuffer.c                  |   2 +-
 kernel/rcu/refscale.c                              |   3 +-
 kernel/trace/bpf_trace.c                           |   2 +-
 kernel/trace/trace.c                               |  72 ++++-
 kernel/trace/trace.h                               |   2 +
 kernel/trace/trace_hwlat.c                         |   2 +-
 kernel/trace/trace_uprobe.c                        |   3 +-
 lib/idr.c                                          |   2 +-
 lib/test_meminit.c                                 |   2 +-
 lib/test_scanf.c                                   |   2 +-
 mm/shmem.c                                         |  28 +-
 mm/util.c                                          |   4 +-
 mm/vmalloc.c                                       |  26 +-
 mm/vmpressure.c                                    |   8 +
 net/9p/trans_virtio.c                              |   2 +-
 net/bluetooth/hci_core.c                           |  16 +-
 net/core/filter.c                                  |   2 +
 net/core/flow_dissector.c                          |   3 +-
 net/core/lwt_bpf.c                                 |   7 +-
 net/core/skbuff.c                                  |  34 +-
 net/core/sock.c                                    |   9 +-
 net/dccp/ipv4.c                                    |  13 +-
 net/dccp/ipv6.c                                    |  15 +-
 net/hsr/hsr_forward.c                              |   1 +
 net/ipv4/devinet.c                                 |  10 +-
 net/ipv4/fib_semantics.c                           |   5 +-
 net/ipv4/fib_trie.c                                |   3 +-
 net/ipv4/igmp.c                                    |   3 +-
 net/ipv4/ip_input.c                                |   3 +-
 net/ipv4/ip_output.c                               |   2 +-
 net/ipv4/route.c                                   |   1 +
 net/ipv4/tcp_input.c                               |   3 +-
 net/ipv4/tcp_timer.c                               |  18 +-
 net/ipv4/udp.c                                     |  20 +-
 net/ipv6/addrconf.c                                |   2 +-
 net/ipv6/ip6_output.c                              |   2 +-
 net/ipv6/udp.c                                     |  30 +-
 net/kcm/kcmsock.c                                  |  15 +-
 net/netfilter/ipset/ip_set_hash_netportnet.c       |   1 +
 net/netfilter/nfnetlink_osf.c                      |   8 +
 net/netfilter/nft_exthdr.c                         |  22 +-
 net/netfilter/xt_sctp.c                            |   2 +
 net/netfilter/xt_u32.c                             |  21 ++
 net/netlabel/netlabel_kapi.c                       |   3 +-
 net/netrom/af_netrom.c                             |   5 +
 net/sched/sch_fq_pie.c                             |  27 +-
 net/sched/sch_hfsc.c                               |   4 +
 net/sched/sch_plug.c                               |   2 +-
 net/sched/sch_qfq.c                                |  22 +-
 net/sctp/proc.c                                    |   2 +-
 net/sctp/sm_sideeffect.c                           |   5 +-
 net/sctp/socket.c                                  |  10 +-
 net/smc/smc_core.c                                 |   2 +
 net/socket.c                                       |   6 +-
 net/tls/tls_sw.c                                   |   4 +-
 net/unix/af_unix.c                                 |   2 +-
 net/unix/scm.c                                     |   6 +-
 net/wireless/nl80211.c                             |   1 +
 net/xdp/xsk_diag.c                                 |   3 +
 samples/bpf/tracex6_kern.c                         |  17 +-
 scripts/kconfig/preprocess.c                       |   3 +
 security/integrity/ima/Kconfig                     |  12 -
 security/integrity/ima/ima.h                       |   2 +-
 security/integrity/ima/ima_kexec.c                 |   2 +-
 security/keys/keyctl.c                             |  11 +-
 security/smack/smackfs.c                           |   2 +-
 sound/Kconfig                                      |   2 +-
 sound/core/pcm_compat.c                            |   8 +-
 sound/core/seq/oss/seq_oss_midi.c                  |  35 ++-
 sound/pci/ac97/ac97_codec.c                        |   5 +-
 sound/soc/atmel/atmel-i2s.c                        |   5 +-
 sound/soc/codecs/Kconfig                           |   1 +
 sound/soc/codecs/da7219-aad.c                      |  12 +-
 sound/soc/codecs/es8316.c                          |   2 +-
 sound/soc/codecs/rt5682-sdw.c                      |   9 +-
 sound/soc/codecs/rt711-sdca-sdw.c                  |  10 +-
 sound/soc/codecs/rt711-sdw.c                       |   9 +-
 tools/bpf/bpftool/skeleton/profiler.bpf.c          |  27 +-
 tools/hv/vmbus_testing                             |   4 +-
 tools/perf/builtin-top.c                           |   1 +
 tools/perf/builtin-trace.c                         |  15 +-
 .../pmu-events/arch/powerpc/power10/cache.json     |   4 +-
 .../arch/powerpc/power10/floating_point.json       |   7 -
 .../pmu-events/arch/powerpc/power10/frontend.json  |  30 +-
 .../pmu-events/arch/powerpc/power10/marked.json    |  30 +-
 .../pmu-events/arch/powerpc/power10/memory.json    |   6 +-
 .../pmu-events/arch/powerpc/power10/others.json    |  53 ++--
 .../pmu-events/arch/powerpc/power10/pipeline.json  |  30 +-
 .../perf/pmu-events/arch/powerpc/power10/pmc.json  |   4 +-
 .../arch/powerpc/power10/translation.json          |  11 +-
 tools/perf/ui/browsers/hists.c                     |  60 ++--
 tools/perf/util/annotate.c                         |  10 +-
 tools/perf/util/header.c                           |  11 +-
 tools/testing/selftests/Makefile                   |   1 +
 .../selftests/bpf/benchs/run_bench_rename.sh       |   2 +-
 .../selftests/bpf/progs/test_cls_redirect.h        |   9 +
 .../futex/functional/futex_wait_timeout.c          |   7 +
 tools/testing/selftests/kselftest/runner.sh        |   3 +-
 tools/testing/selftests/kselftest_harness.h        |  11 +-
 tools/testing/selftests/resctrl/Makefile           |  17 +-
 tools/testing/selftests/resctrl/cache.c            |  18 +-
 tools/testing/selftests/resctrl/fill_buf.c         |   3 +-
 tools/testing/selftests/resctrl/resctrl.h          |   1 +
 631 files changed, 5111 insertions(+), 3232 deletions(-)


