Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E2675513F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 21:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjGPTyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 15:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjGPTyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 15:54:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E719F199;
        Sun, 16 Jul 2023 12:54:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E98C60EB7;
        Sun, 16 Jul 2023 19:54:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905B3C433C8;
        Sun, 16 Jul 2023 19:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537252;
        bh=eHf8dyKaYH6W3yv8bB82doaRgoxvGeFhjmifN9gea8M=;
        h=From:To:Cc:Subject:Date:From;
        b=D0+M2Vn9fxZZjcpn9+zg+6k/vPM43heRZrG/Jw1lDlIz3pMd2gbyYDnTRwORdcMs1
         6X621M1bD1yTquLuervHHocPHjzoihqNA8wVUDtileJanySaDvcuyBB4FOhB1YxQcH
         O0ESemnf39KRINDu6CgVaJhBJ/Cqvgf5stBYW1u0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 6.4 000/800] 6.4.4-rc1 review
Date:   Sun, 16 Jul 2023 21:37:33 +0200
Message-ID: <20230716194949.099592437@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.4-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.4.4-rc1
X-KernelTest-Deadline: 2023-07-18T19:50+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 6.4.4 release.
There are 800 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Tue, 18 Jul 2023 19:48:07 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.4-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.4.4-rc1

Andres Freund <andres@anarazel.de>
    io_uring: Use io_schedule* in cqring wait

Sherry Sun <sherry.sun@nxp.com>
    tty: serial: fsl_lpuart: add earlycon for imx8ulp platform

Jason A. Donenfeld <Jason@zx2c4.com>
    wireguard: netlink: send staged packets when setting initial private key

Jason A. Donenfeld <Jason@zx2c4.com>
    wireguard: queueing: use saner cpu selection wrapping

Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
    netfilter: nf_tables: prevent OOB access in nft_byteorder_eval

Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
    netfilter: nf_tables: do not ignore genmask when looking up chain by id

Florent Revest <revest@chromium.org>
    netfilter: conntrack: Avoid nf_ct_helper_hash uses after free

Tao Zhou <tao.zhou1@amd.com>
    drm/amdgpu: check RAS irq existence for VCN/JPEG

Kenneth Feng <kenneth.feng@amd.com>
    drm/amd/pm: add abnormal fan detection for smu 13.0.0

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu/sdma4: set align mask to 255

Evan Quan <evan.quan@amd.com>
    drm/amd/pm: revise the ASPM settings for thunderbolt attached scenario

Jiadong Zhu <Jiadong.Zhu@amd.com>
    drm/amdgpu: Skip mark offset for high priority rings

Christian König <christian.koenig@amd.com>
    drm/amdgpu: make sure that BOs have a backing store

Christian König <christian.koenig@amd.com>
    drm/amdgpu: make sure BOs are locked in amdgpu_vm_get_memory

WANG Xuerui <git@xen0n.name>
    LoongArch: Include KBUILD_CPPFLAGS in CHECKFLAGS invocation

Zhihao Cheng <chengzhihao1@huawei.com>
    ovl: fix null pointer dereference in ovl_get_acl_rcu()

Zhihao Cheng <chengzhihao1@huawei.com>
    ovl: let helper ovl_i_path_real() return the realinode

Zhihao Cheng <chengzhihao1@huawei.com>
    ovl: fix null pointer dereference in ovl_permission()

Masahiro Yamada <masahiroy@kernel.org>
    kbuild: add $(CLANG_FLAGS) to KBUILD_CPPFLAGS

Nathan Chancellor <nathan@kernel.org>
    kbuild: Add KBUILD_CPPFLAGS to as-option invocation

Nathan Chancellor <nathan@kernel.org>
    kbuild: Add CLANG_FLAGS to as-instr

Nathan Chancellor <nathan@kernel.org>
    powerpc/vdso: Include CLANG_FLAGS explicitly in ldflags-y

Nathan Chancellor <nathan@kernel.org>
    mips: Include KBUILD_CPPFLAGS in CHECKFLAGS invocation

Arnd Bergmann <arnd@arndb.de>
    Input: ads7846 - fix pointer cast warning

Jan Kara <jack@suse.cz>
    fs: no need to check source

Yu Kuai <yukuai3@huawei.com>
    md/raid1-10: fix casting from randomized structure in raid1_submit_write()

Linus Walleij <linus.walleij@linaro.org>
    Input: ads7846 - Fix usage of match data

Yu Kuai <yukuai3@huawei.com>
    blktrace: use inline function for blk_trace_remove() while blktrace is disabled

Christian Marangi <ansuelsmth@gmail.com>
    leds: trigger: netdev: Recheck NETDEV_LED_MODE_LINKUP on dev rename

Arnd Bergmann <arnd@arndb.de>
    ARM: orion5x: fix d2net gpio initialization

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: qcom: ipq4019: fix broken NAND controller properties override

Linus Walleij <linus.walleij@linaro.org>
    ARM: dts: qcom: msm8660: Fix regulator node names

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    regulator: tps65219: Fix matching interrupts for their regulators

Ricardo Ribalda Delgado <ribalda@chromium.org>
    ASoC: mediatek: mt8173: Fix snd_soc_component_initialize error path

Ricardo Ribalda Delgado <ribalda@chromium.org>
    ASoC: mediatek: mt8173: Fix irq error path

Filipe Manana <fdmanana@suse.com>
    btrfs: do not BUG_ON() on tree mod log failure at __btrfs_cow_block()

Filipe Manana <fdmanana@suse.com>
    btrfs: fix extent buffer leak after tree mod log failure at split_node()

Filipe Manana <fdmanana@suse.com>
    btrfs: add missing error handling when logging operation while COWing extent buffer

Filipe Manana <fdmanana@suse.com>
    btrfs: fix race when deleting quota root from the dirty cow roots list

Naohiro Aota <naota@elisp.net>
    btrfs: move out now unused BG from the reclaim list

Naohiro Aota <naota@elisp.net>
    btrfs: reinsert BGs failed to reclaim

David Sterba <dsterba@suse.com>
    btrfs: add block-group tree to lockdep classes

Naohiro Aota <naota@elisp.net>
    btrfs: bail out reclaim process if filesystem is read-only

Naohiro Aota <naota@elisp.net>
    btrfs: delete unused BGs while reclaiming BGs

Boris Burkov <boris@bur.io>
    btrfs: warn on invalid slot in tree mod log rewind

Boris Burkov <boris@bur.io>
    btrfs: insert tree mod log move in push_node_left

Christoph Hellwig <hch@lst.de>
    btrfs: fix dirty_metadata_bytes for redirtied buffers

Matt Corallo <blnxfsl@bluematt.me>
    btrfs: add handling for RAID1C23/DUP to btrfs_reduce_alloc_profile

Abhijeet Rastogi <abhijeet.1989@gmail.com>
    ipvs: increase ip_vs_conn_tab_bits range for 64BIT

Mario Limonciello <mario.limonciello@amd.com>
    usb: typec: ucsi: Mark dGPUs as DEVICE scope

Jan Kara <jack@suse.cz>
    fs: Lock moved directories

Jan Kara <jack@suse.cz>
    fs: Establish locking order for unrelated directories

Jan Kara <jack@suse.cz>
    Revert "udf: Protect rename against modification of moved directory"

Jan Kara <jack@suse.cz>
    Revert "f2fs: fix potential corruption when moving a directory"

Jan Kara <jack@suse.cz>
    ext4: Remove ext4 locking of moved directory

Thomas Weißschuh <linux@weissschuh.net>
    fs: avoid empty option when generating legacy mount string

Fabian Frederick <fabf@skynet.be>
    jffs2: reduce stack usage in jffs2_build_xattr_subsystem()

Christian Brauner <brauner@kernel.org>
    nfsd: use vfs setgid helper

Roberto Sassu <roberto.sassu@huawei.com>
    shmem: use ramfs_kill_sb() for kill_sb method of ramfs-based tmpfs

Ryan Roberts <ryan.roberts@arm.com>
    mm/damon/ops-common: atomically test and clear young on ptes and pmds

Arnd Bergmann <arnd@arndb.de>
    autofs: use flexible array in ioctl structure

Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
    integrity: Fix possible multiple allocation in integrity_inode_get()

Kees Cook <keescook@chromium.org>
    um: Use HOST_DIR for mrproper

Siddh Raman Pant <code@siddh.me>
    watch_queue: prevent dangling pipe pointer

Zheng Wang <zyytlz.wz@163.com>
    bcache: Fix __bch_btree_node_alloc to make the failure behavior consistent

Zheng Wang <zyytlz.wz@163.com>
    bcache: Remove unnecessary NULL point check in node allocations

Mingzhe Zou <mingzhe.zou@easystack.cn>
    bcache: fixup btree_cache_wait list damage

Quan Zhou <quan.zhou@mediatek.com>
    wifi: mt76: mt7921e: fix init command fail with enabled device

Felix Fietkau <nbd@nbd.name>
    wifi: cfg80211: fix receiving mesh packets without RFC1042 header

Alexander Wetzel <alexander@wetzel-home.de>
    wifi: ath10k: Serialize wake_tx_queue ops

Johannes Berg <johannes.berg@intel.com>
    wifi: cfg80211: fix regulatory disconnect for non-MLO

Chevron Li <chevron.li@bayhubtech.com>
    mmc: sdhci: fix DMA configure compatibility issue when 64bit DMA mode is used.

Ulf Hansson <ulf.hansson@linaro.org>
    mmc: mmci: Set PROBE_PREFER_ASYNCHRONOUS

Robert Marko <robimarko@gmail.com>
    mmc: core: disable TRIM on Micron MTFC4GACAJCN-1M

Robert Marko <robimarko@gmail.com>
    mmc: core: disable TRIM on Kingston EMMC04G-M627

Yu Zhao <yuzhao@google.com>
    mm/mglru: make memcg_lru->lock irq safe

Jens Axboe <axboe@kernel.dk>
    io_uring: wait interruptibly for request completions on exit

Jianmin Lv <lvjianmin@loongson.cn>
    irqchip/loongson-pch-pic: Fix initialization of HT vector register

Dai Ngo <dai.ngo@oracle.com>
    NFSD: add encoding of op_recall flag for write delegation

Liu Peibao <liupeibao@loongson.cn>
    irqchip/loongson-pch-pic: Fix potential incorrect hwirq assignment

Jeff Layton <jlayton@kernel.org>
    nfsd: move init of percpu reply_cache_stats counters back to nfsd_init_net

Jianmin Lv <lvjianmin@loongson.cn>
    irqchip/loongson-liointc: Fix IRQ trigger polarity

Mark Brown <broonie@kernel.org>
    arm64/signal: Restore TPIDR2 register rather than memory state

Daniel Miess <daniel.miess@amd.com>
    Revert "drm/amd/display: Move DCN314 DOMAIN power control to DMCUB"

Geert Uytterhoeven <geert+renesas@glider.be>
    lib: dhry: fix sleeping allocations inside non-preemptable section

Matthew Wilcox (Oracle) <willy@infradead.org>
    writeback: account the number of pages written back

Robert Hancock <robert.hancock@calian.com>
    i2c: xiic: Don't try to handle more interrupt events after error

John Johansen <john.johansen@canonical.com>
    apparmor: fix profile verification and enable it

John Johansen <john.johansen@canonical.com>
    apparmor: fix policy_compat permission remap with extended permissions

John Johansen <john.johansen@canonical.com>
    apparmor: add missing failure check in compute_xmatch_perms

Danila Chernetsov <listdansp@mail.ru>
    apparmor: fix missing error check for rhashtable_insert_fast

Artur Rojek <contact@artur-rojek.eu>
    sh: dma: Fix DMA channel offset calculation

Marc Zyngier <maz@kernel.org>
    risc-v: Fix order of IPI enablement vs RCU startup

Thorsten Winkler <twinkler@linux.ibm.com>
    s390/qeth: Fix vipa deletion

David Howells <dhowells@redhat.com>
    afs: Fix accidental truncation when storing data

Hariprasad Kelam <hkelam@marvell.com>
    octeontx-af: fix hardware timestamp configuration

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: dsa: sja1105: always enable the send_meta options

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: dsa: tag_sja1105: fix MAC DA patching from meta frames

Guillaume Nault <gnault@redhat.com>
    pptp: Fix fib lookup calls.

Woody Zhang <woodylab@foxmail.com>
    riscv: move memblock_allow_resize() after linear mapping is ready

Amir Goldstein <amir73il@gmail.com>
    fanotify: disallow mount/sb marks on kernel internal pseudo fs

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915/psr: Fix BDW PSR AUX CH data register offsets

Lin Ma <linma@zju.edu.cn>
    net/sched: act_pedit: Add size check for TCA_PEDIT_PARMS_EX

Ilya Maximets <i.maximets@ovn.org>
    xsk: Honor SO_BINDTODEVICE on bind

SeongJae Park <sj@kernel.org>
    bpf, btf: Warn but return no error for NULL btf from __register_btf_kfunc_id_set()

Maxime Coquelin <maxime.coquelin@redhat.com>
    vduse: fix NULL pointer dereference

Eric Dumazet <edumazet@google.com>
    tcp: annotate data races in __tcp_oow_rate_limited()

Eric Dumazet <edumazet@google.com>
    net: fix net_dev_start_xmit trace event vs skb_transport_offset()

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: dsa: tag_sja1105: fix source port decoding in vlan_filtering=0 bridge mode

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: bridge: keep ports without IFF_UNICAST_FLT in BR_PROMISC mode

Pali Rohár <pali@kernel.org>
    powerpc: dts: turris1x.dts: Fix PCIe MEM size for pci2 node

Randy Dunlap <rdunlap@infradead.org>
    powerpc: allow PPC_EARLY_DEBUG_CPM only when SERIAL_CPM=y

Zeng Heng <zengheng4@huawei.com>
    ntfs: Fix panic about slab-out-of-bounds caused by ntfs_listxattr()

Hariprasad Kelam <hkelam@marvell.com>
    octeontx2-af: Reset MAC features in FLR

Hariprasad Kelam <hkelam@marvell.com>
    octeontx2-af: Add validation before accessing cgx and lmac

Hariprasad Kelam <hkelam@marvell.com>
    octeontx2-af: Fix mapping for NIX block from CGX connection

Hariprasad Kelam <hkelam@marvell.com>
    octeontx2-af: cn10kb: fix interrupt csr addresses

Chao Yu <chao@kernel.org>
    f2fs: fix error path handling in truncate_dnode()

Nishanth Menon <nm@ti.com>
    mailbox: ti-msgmgr: Fill non-message tx data fields with 0x0

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Don't try to enable secure display TA multiple times

Christian König <christian.koenig@amd.com>
    drm/amdgpu: fix number of fence calculations

Jonas Gorski <jonas.gorski@gmail.com>
    spi: bcm-qspi: return error if neither hif_mspi nor mspi is available

Zhengchao Shao <shaozhengchao@huawei.com>
    mlxsw: minimal: fix potential memory leak in mlxsw_m_linecards_init

Pawel Dembicki <paweldembicki@gmail.com>
    net: dsa: vsc73xx: fix MTU configuration

Nick Child <nnac123@linux.ibm.com>
    ibmvnic: Do not reset dql stats on NON_FATAL err

Martin Habets <habetsm.xilinx@gmail.com>
    sfc: support for devlink port requires MAE access

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: MGMT: Fix marking SCAN_RSP as not connectable

Pauli Virtanen <pav@iki.fi>
    Bluetooth: ISO: use hci_sync for setting CIG parameters

Johan Hovold <johan+linaro@kernel.org>
    Bluetooth: fix invalid-bdaddr quirk for non-persistent setup

Tobias Heider <me@tobhe.de>
    Add MODULE_FIRMWARE() for FIRMWARE_TG357766.

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: dsa: tag_sja1105: always prefer source port information from INCL_SRCPT

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: dsa: sja1105: always enable the INCL_SRCPT option

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: dsa: felix: don't drop PTP frames with tag_8021q when RX timestamping is disabled

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: mscc: ocelot: don't keep PTP configuration of all ports in single structure

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: mscc: ocelot: don't report that RX timestamping is enabled by default

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    spi: spi-geni-qcom: enable SPI_CONTROLLER_MUST_TX for GPI DMA mode

Florian Westphal <fw@strlen.de>
    net/sched: act_ipt: zero skb->cb before calling target

Florian Westphal <fw@strlen.de>
    net/sched: act_ipt: add sanity checks on skb before calling target

Florian Westphal <fw@strlen.de>
    net/sched: act_ipt: add sanity checks on table name and hook locations

Chengfeng Ye <dg573847474@gmail.com>
    sctp: fix potential deadlock on &net->sctp.addr_wq_lock

Randy Dunlap <rdunlap@infradead.org>
    media: cec: i2c: ch7322: also select REGMAP

Arnd Bergmann <arnd@arndb.de>
    media: tc358746: select CONFIG_GENERIC_PHY

Peng Fan <peng.fan@nxp.com>
    tools/virtio: fix build break for aarch64

Dragos Tatulea <dtatulea@nvidia.com>
    virtio-vdpa: Fix unchecked call to NULL set_vq_affinity

Chao Yu <chao@kernel.org>
    f2fs: check return value of freeze_super()

Vinay Belgaumkar <vinay.belgaumkar@intel.com>
    drm/i915/guc/slpc: Apply min softlimit correctly

Jouni Högander <jouni.hogander@intel.com>
    drm/i915/psr: Use hw.adjusted mode when calculating io/fast wake times

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    rtc: st-lpc: Release some resources in st_rtc_probe() in case of error

Jinke Han <hanjinke.666@bytedance.com>
    blk-throttle: Fix io statistics for cgroup v1

Ian Rogers <irogers@google.com>
    perf bpf: Move the declaration of struct rq

Li Nan <linan122@huawei.com>
    md/raid10: fix the condition to call bio_end_io_acct()

Shuijing Li <shuijing.li@mediatek.com>
    pwm: mtk_disp: Fix the disable flow of disp_pwm

Dan Carpenter <dan.carpenter@linaro.org>
    pwm: ab8500: Fix error code in probe()

Marek Vasut <marex@denx.de>
    pwm: sysfs: Do not apply state to already disabled PWMs

Fancy Fang <chen.fang@nxp.com>
    pwm: imx-tpm: force 'real_period' to be zero in suspend

Yury Norov <yury.norov@gmail.com>
    lib/bitmap: drop optimization of bitmap_{from,to}_arr64

Claudiu Beznea <claudiu.beznea@microchip.com>
    phy: tegra: xusb: check return value of devm_kzalloc()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    mfd: stmpe: Only disable the regulators if they are enabled

Neil Armstrong <neil.armstrong@linaro.org>
    phy: qcom: qmp-combo: fix Display Port PHY configuration for SM8550

Yicong Yang <yangyicong@hisilicon.com>
    hwtracing: hisi_ptt: Fix potential sleep in atomic context

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    clk: qcom: mmcc-msm8974: fix MDSS_GDSC power flags

Claudiu Beznea <claudiu.beznea@microchip.com>
    misc: fastrpc: check return value of devm_kasprintf()

Daniel Golle <daniel@makrotopia.org>
    cpufreq: mediatek: correct voltages for MT7622 and MT7623

Christian Borntraeger <borntraeger@linux.ibm.com>
    KVM: s390/diag: fix racy access of physical cpu number in diag 9c handler

Pierre Morel <pmorel@linux.ibm.com>
    KVM: s390: vsie: fix the length of APCB bitmap

Amelie Delaunay <amelie.delaunay@foss.st.com>
    mfd: stmfx: Nullify stmfx->vdd in case of error

Amelie Delaunay <amelie.delaunay@foss.st.com>
    mfd: stmfx: Fix error path in stmfx_chip_init

Laurentiu Tudor <laurentiu.tudor@nxp.com>
    bus: fsl-mc: don't assume child devices are all fsl-mc devices

Phil Elwell <phil@raspberrypi.com>
    nvmem: rmem: Use NVMEM_DEVID_AUTO

Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
    test_firmware: return ENOMEM instead of ENOSPC on failed memory allocation

Alexander Stein <alexander.stein@ew.tq-group.com>
    nvmem: imx-ocotp: Reverse MAC addresses on all i.MX derivates

Yi Yingao <m202271736@hust.edu.cn>
    nvmem: sunplus-ocotp: release otp->clk before return

Nipun Gupta <nipun.gupta@amd.com>
    cdx: fix driver managed dma support

Matti Vaittinen <mazziesaccount@gmail.com>
    drivers: fwnode: fix fwnode_irq_get[_byname]()

Tony Lindgren <tony@atomide.com>
    serial: 8250_omap: Use force_suspend and resume for system suspend

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "usb: common: usb-conn-gpio: Set last role to unknown before initial detection"

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    mfd: intel-lpss: Add missing check for platform_get_resource

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    mfd: wcd934x: Fix an error handling path in wcd934x_slim_probe()

Daniel Bristot de Oliveira <bristot@kernel.org>
    rtla/hwnoise: Reduce runtime to 75%

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    usb: dwc3-meson-g12a: Fix an error handling path in dwc3_meson_g12a_probe()

Prashanth K <quic_prashk@quicinc.com>
    usb: common: usb-conn-gpio: Set last role to unknown before initial detection

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    usb: dwc3: qcom: Fix an error handling path in dwc3_qcom_probe()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    usb: dwc3: qcom: Release the correct resources in dwc3_qcom_remove()

Nico Boehr <nrb@linux.ibm.com>
    KVM: s390: fix KVM_S390_GET_CMMA_BITS for GFNs in memslot holes

Chao Yu <chao@kernel.org>
    f2fs: flush error flags in workqueue

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: fix the wrong condition to determine atomic context

Chao Yu <chao@kernel.org>
    f2fs: support errors=remount-ro|continue|panic mountoption

Chao Yu <chao@kernel.org>
    f2fs: fix to avoid NULL pointer dereference f2fs_write_end_io()

Chao Yu <chao@kernel.org>
    f2fs: fix potential deadlock due to unpaired node_write lock use

Bob Peterson <rpeterso@redhat.com>
    gfs2: Fix duplicate should_fault_in_pages() call

Sergey Shtylyov <s.shtylyov@omp.ru>
    sh: Avoid using IRQ0 on SH3 and SH4

Hans de Goede <hdegoede@redhat.com>
    media: atomisp: ov2680: Stop using half pixelclock for binned modes

Dan Carpenter <dan.carpenter@linaro.org>
    media: atomisp: gmin_platform: fix out_len in gmin_get_config_dsm_var()

Hans de Goede <hdegoede@redhat.com>
    media: atomisp: gc0310: Fix double free in gc0310_remove()

Rikard Falkeborn <rikard.falkeborn@gmail.com>
    media: venus: helpers: Fix ALIGN() of non power of two

Stephan Gerhold <stephan@gerhold.net>
    mfd: rt5033: Drop rt5033-battery sub-device

ChiYuan Huang <cy_huang@richtek.com>
    power: supply: rt9467: Make charger-enable control as logic level

Mike Leach <mike.leach@linaro.org>
    coresight: etm4x: Fix missing trctraceidr file in sysfs

James Clark <james.clark@arm.com>
    coresight: Fix loss of connection info when a module is unloaded

Clark Wang <xiaoning.wang@nxp.com>
    i3c: master: svc: fix cpu schedule in spin lock

Yue Zhao <findns94@gmail.com>
    lkdtm: replace ll_rw_block with submit_bh

Muchun Song <muchun.song@linux.dev>
    kernfs: fix missing kernfs_idr_lock to remove an ID from the IDR

John Ogness <john.ogness@linutronix.de>
    serial: 8250: lock port for UART_IER access in omap8250_irq()

John Ogness <john.ogness@linutronix.de>
    serial: core: lock port for start_rx() in uart_resume_port()

John Ogness <john.ogness@linutronix.de>
    serial: 8250: lock port for stop_rx() in omap8250_irq()

John Ogness <john.ogness@linutronix.de>
    serial: core: lock port for stop_rx() in uart_suspend_port()

Bhupesh Sharma <bhupesh.sharma@linaro.org>
    usb: misc: eud: Fix eud sysfs path (use 'qcom_eud')

Arnd Bergmann <arnd@arndb.de>
    usb: hide unused usbfs_notify_suspend/resume functions

Li Yang <lidaxian@hust.edu.cn>
    usb: phy: phy-tahvo: fix memory leak in tahvo_usb_probe()

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    extcon: Fix kernel doc of property capability fields to avoid warnings

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    extcon: Fix kernel doc of property fields to avoid warnings

Prashanth K <quic_prashk@quicinc.com>
    usb: gadget: u_serial: Add null pointer check in gserial_suspend

Vladislav Efanov <VEfanov@ispras.ru>
    usb: dwc3: qcom: Fix potential memory leak

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    soundwire: debugfs: fix unbalanced pm_runtime_put()

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    soundwire: qcom: fix unbalanced pm_runtime_put()

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    soundwire: qcom: use consistently 'ctrl' as state variable name

Arnd Bergmann <arnd@arndb.de>
    staging: vchiq_arm: mark vchiq_platform_init() static

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    clk: qcom: mmcc-msm8974: use clk_rcg2_shared_ops for mdp_clk_src clock

Kathiravan T <quic_kathirav@quicinc.com>
    clk: qcom: ipq5332: fix the order of SLEEP_CLK and XO clock

Kathiravan T <quic_kathirav@quicinc.com>
    clk: qcom: ipq5332: fix the src parameter in ftbl_gcc_apss_axi_clk_src

Konrad Dybcio <konrad.dybcio@linaro.org>
    clk: qcom: dispcc-qcm2290: Fix GPLL0_OUT_DIV handling

Konrad Dybcio <konrad.dybcio@linaro.org>
    clk: qcom: dispcc-qcm2290: Fix BI_TCXO_AO handling

Robert Marko <robimarko@gmail.com>
    clk: qcom: ipq6018: fix networking resets

Yunfei Dong <yunfei.dong@mediatek.com>
    media: mediatek: vcodec: using decoder status instead of core work count

Martin Kepplinger <martink@posteo.de>
    media: hi846: fix usage of pm_runtime_get_if_in_use()

Geert Uytterhoeven <geert+renesas@glider.be>
    media: renesas: fdp1: Identify R-Car Gen2 versions

Daniel Scally <dan.scally@ideasonboard.com>
    media: i2c: Correct format propagation for st-mipid02

Dan Carpenter <error27@gmail.com>
    media: i2c: imx296: fix error checking in imx296_read_temperature()

Duoming Zhou <duoming@zju.edu.cn>
    media: usb: siano: Fix warning due to null work_func_t function pointer

Marek Vasut <marex@denx.de>
    media: videodev2.h: Fix struct v4l2_input tuner index comment

Ming Qian <ming.qian@nxp.com>
    media: amphion: initiate a drain of the capture queue in dynamic resolution change

Daniel Lundberg Pedersen <dlp@qtec.com>
    media: videodev2.h: Fix p_s32 and p_s64 pointer types

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    media: common: saa7146: Avoid a leak in vmalloc_to_sg()

Ming Qian <ming.qian@nxp.com>
    media: amphion: drop repeated codec data for vc1g format

Ming Qian <ming.qian@nxp.com>
    media: amphion: drop repeated codec data for vc1l format

Daniil Dulov <d.dulov@aladdin.ru>
    media: usb: Check az6007_read() return value

Konrad Dybcio <konrad.dybcio@linaro.org>
    clk: qcom: gcc-qcm2290: Mark RCGs shared where applicable

Mantas Pucka <mantas@8devices.com>
    clk: qcom: gcc-ipq6018: Use floor ops for sdcc clocks

Taniya Das <quic_tdas@quicinc.com>
    clk: qcom: camcc-sc7180: Add parent dependency to all camera GDSCs

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    clk: qcom: mmcc-msm8974: remove oxili_ocmemgx_clk

Kathiravan T <quic_kathirav@quicinc.com>
    clk: qcom: gcc: ipq5332: Use floor ops for SDCC clocks

Konrad Dybcio <konrad.dybcio@linaro.org>
    interconnect: qcom: rpm: Don't use clk_get_optional for bus clocks anymore

Konrad Dybcio <konrad.dybcio@linaro.org>
    interconnect: qcom: rpm: Rename icc provider num_clocks to num_bus_clocks

Tony Lindgren <tony@atomide.com>
    serial: 8250: omap: Fix freeing of resources on failed register

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    usb: dwc2: Fix some error handling paths

Basavaraj Natikar <Basavaraj.Natikar@amd.com>
    xhci: Improve the XHCI system resume time

Basavaraj Natikar <Basavaraj.Natikar@amd.com>
    USB: Extend pci resume function to handle PM events

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    cpufreq: tegra194: Fix an error handling path in tegra194_cpufreq_probe()

John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
    sh: j2: Use ioremap() to translate device tree address into kernel memory

Yangtao Li <frank.li@vivo.com>
    f2fs: do not allow to defragment files have FI_COMPRESS_RELEASED

Konrad Dybcio <konrad.dybcio@linaro.org>
    dt-bindings: power: reset: qcom-pon: Only allow reboot-mode pre-pmk8350

Dan Carpenter <error27@gmail.com>
    w1: fix loop in w1_fini()

Stefan Wahren <stefan.wahren@i2se.com>
    w1: w1_therm: fix locking behavior in convert_t

Thomas Gleixner <tglx@linutronix.de>
    x86/efi: Make efi_set_virtual_address_map IBT safe

Will Deacon <will@kernel.org>
    arm64: sme: Use STR P to clear FFR context field in streaming SVE mode

Arnd Bergmann <arnd@arndb.de>
    ksmbd: avoid field overflow warning

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix shared DFS root mounts with different prefixes

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix broken file attrs with nodfs mounts

Shyam Prasad N <sprasad@microsoft.com>
    cifs: do all necessary checks for credits within or before locking

Shyam Prasad N <sprasad@microsoft.com>
    cifs: prevent use-after-free by freeing the cfile later

Ard Biesheuvel <ardb@kernel.org>
    efi/libstub: Disable PCI DMA before grabbing the EFI memory map

Masahiro Yamada <masahiroy@kernel.org>
    kbuild: deb-pkg: remove the CONFIG_MODULES check in buildeb

Josh Triplett <josh@joshtriplett.org>
    kbuild: builddeb: always make modules_install, to install modules.builtin*

Vishal Verma <vishal.l.verma@intel.com>
    tools/testing/cxl: Fix command effects for inject/clear poison

Dan Williams <dan.j.williams@intel.com>
    cxl/region: Fix state transitions after reset failure

Dan Williams <dan.j.williams@intel.com>
    cxl/region: Flag partially torn down regions as unusable

Dan Williams <dan.j.williams@intel.com>
    cxl/region: Move cache invalidation before region teardown, and before setup

Sami Tolvanen <samitolvanen@google.com>
    kbuild: Disable GCOV for *.mod.o

Sami Tolvanen <samitolvanen@google.com>
    kbuild: Fix CFI failures with GCOV

Ding Hui <dinghui@sangfor.com.cn>
    SUNRPC: Fix UAF in svc_tcp_listen_data_ready()

Filipe Manana <fdmanana@suse.com>
    btrfs: do not BUG_ON() on tree mod log failure at balance_level()

Filipe Manana <fdmanana@suse.com>
    btrfs: fix race when deleting free space root from the dirty cow roots list

Christian Loehle <CLoehle@hyperstone.com>
    mmc: block: ioctl: do write error check for spi

Demi Marie Obenour <demi@invisiblethingslab.com>
    block: increment diskseq on all media change events

Michael Schmitz <schmitzmic@gmail.com>
    block: change all __u32 annotations to __be32 in affs_hardblocks.h

Michael Schmitz <schmitzmic@gmail.com>
    block: add overflow checks for Amiga partition support

Michael Schmitz <schmitzmic@gmail.com>
    block: fix signed int overflow in Amiga partition support

John Johansen <john.johansen@canonical.com>
    apparmor: fix: kzalloc perms tables for shared dfas

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Fix potential data race at PCM memory allocation helpers

Takashi Iwai <tiwai@suse.de>
    ALSA: jack: Fix mutex call in snd_jack_report()

Werner Sembach <wse@tuxedocomputers.com>
    ALSA: hda/realtek: Add quirk for Clevo NPx0SNx

Andy Chi <andy.chi@canonical.com>
    ALSA: hda/realtek: Enable mute/micmute LEDs and limit mic boost on EliteBook

Martin Kaiser <martin@kaiser.cx>
    hwrng: st - keep clock enabled while hwrng is registered

Tarun Sahu <tsahu@linux.ibm.com>
    dax/kmem: Pass valid argument to memory_group_register_static

Dan Williams <dan.j.williams@intel.com>
    dax: Introduce alloc_dev_dax_id()

Dan Williams <dan.j.williams@intel.com>
    dax: Fix dax_mapping_release() use after free

Bharath SM <bharathsm@microsoft.com>
    SMB3: Do not send lease break acknowledgment if all file handles have been closed

Olga Kornievskaia <kolga@netapp.com>
    NFSv4.1: freeze the session table upon receiving NFS4ERR_BADSESSION

Qi Zheng <zhengqi.arch@bytedance.com>
    NFSv4.2: fix wrong shrinker_id

Hareshx Sankar Raj <hareshx.sankar.raj@intel.com>
    crypto: qat - unmap buffers before free for RSA

Hareshx Sankar Raj <hareshx.sankar.raj@intel.com>
    crypto: qat - unmap buffer before free for DH

Masahiro Yamada <masahiroy@kernel.org>
    ARC: define ASM_NL and __ALIGN(_STR) outside #ifdef __ASSEMBLY__ guard

Dan Carpenter <dan.carpenter@linaro.org>
    modpost: fix off by one in is_executable_section()

Pierre-Clément Tosi <ptosi@google.com>
    scripts/mksysmap: Fix badly escaped '$'

Bhupesh Sharma <bhupesh.sharma@linaro.org>
    dt-bindings: qcom-qce: Fix compatible combinations for SM8150 and IPQ4019 SoCs

Stephan Müller <smueller@chronox.de>
    crypto: jitter - correct health test during initialization

Arnd Bergmann <arnd@arndb.de>
    crypto: marvell/cesa - Fix type mismatch warning

Masahiro Yamada <masahiroy@kernel.org>
    modpost: fix section mismatch message for R_ARM_{PC24,CALL,JUMP24}

Masahiro Yamada <masahiroy@kernel.org>
    modpost: fix section mismatch message for R_ARM_ABS32

Randy Dunlap <rdunlap@infradead.org>
    crypto: nx - fix build warnings when DEBUG_FS is not enabled

Masahiro Yamada <masahiroy@kernel.org>
    modpost: remove broken calculation of exception_table_entry size

Herbert Xu <herbert@gondor.apana.org.au>
    hwrng: virtio - Fix race on data_avail and actual data

Eric Farman <farman@linux.ibm.com>
    vfio/mdev: Move the compat_class initialization to module init

Xinghui Li <korantli@tencent.com>
    PCI: vmd: Fix uninitialized variable usage in vmd_enable_domain()

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    PCI: endpoint: functions/pci-epf-test: Fix dma_chan direction

Shunsuke Mie <mie@igel.co.jp>
    PCI: endpoint: Fix a Kconfig prompt of vNTB driver

Song Shuai <songshuaishuai@tinylab.org>
    riscv: hibernate: remove WARN_ON in save_processor_state

Namhyung Kim <namhyung@kernel.org>
    perf test: Set PERF_EXEC_PATH for script execution

Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
    powerpc/mm/dax: Fix the condition when checking if altmap vmemap can cross-boundary

Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
    powerpc/book3s64/mm: Fix DirectMap stats in /proc/meminfo

Tiezhu Yang <yangtiezhu@loongson.cn>
    riscv: uprobes: Restore thread.bad_cause

Xi Pardee <xi.pardee@intel.com>
    platform/x86:intel/pmc: Update maps for Meteor Lake P/M platforms

Manivannan Sadhasivam <mani@kernel.org>
    PCI: qcom: Disable write access to read only registers for IP v2.9.0

Manivannan Sadhasivam <mani@kernel.org>
    PCI: qcom: Use DWC helpers for modifying the read-only DBI registers

Song Shuai <songshuaishuai@tinylab.org>
    riscv: hibernation: Remove duplicate call of suspend_restore_csrs

Aditya Gupta <adityag@linux.ibm.com>
    powerpc: update ppc_save_regs to save current r1 in pt_regs

Colin Ian King <colin.i.king@gmail.com>
    powerpc/powernv/sriov: perform null check on iov before dereferencing iov

Stanley Chu <stanley.chu@mediatek.com>
    scsi: ufs: core: mcq: Fix the incorrect OCS value for the device command

Bart Van Assche <bvanassche@acm.org>
    scsi: ufs: core: Remove a ufshcd_add_command_trace() call

Namhyung Kim <namhyung@kernel.org>
    perf stat: Reset aggr stats for each run

Claudiu Beznea <claudiu.beznea@microchip.com>
    pinctrl: at91-pio4: check return value of devm_kasprintf()

Claudiu Beznea <claudiu.beznea@microchip.com>
    pinctrl: microchip-sgpio: check return value of devm_kasprintf()

Xiaolei Wang <xiaolei.wang@windriver.com>
    pinctrl: freescale: Fix a memory out of bounds when num_configs is 1

Nicholas Piggin <npiggin@gmail.com>
    powerpc/64s: Fix VAS mm use after free

Ian Rogers <irogers@google.com>
    perf tool x86: Fix perf_env memory leak

Ravi Bangoria <ravi.bangoria@amd.com>
    perf tool x86: Consolidate is_amd check into single function

Michal Wilczynski <michal.wilczynski@intel.com>
    platform/x86/dell/dell-rbtn: Fix resources leaking on error path

Aditya Gupta <adityag@linux.ibm.com>
    perf tests task_analyzer: Skip tests if no libtraceevent support

Aditya Gupta <adityag@linux.ibm.com>
    perf tests task_analyzer: Fix bad substitution ${$1}

Kan Liang <kan.liang@linux.intel.com>
    perf metric: Fix no group check

Namhyung Kim <namhyung@kernel.org>
    perf dwarf-aux: Fix off-by-one in die_get_varname()

David E. Box <david.e.box@linux.intel.com>
    platform/x86/intel/pmc/mtl: Put devices in D3 during resume

David E. Box <david.e.box@linux.intel.com>
    platform/x86/intel/pmc: Add resume callback

Mark Pearson <mpearson-lenovo@squebb.ca>
    platform/x86: thinkpad_acpi: Fix lkp-tests warnings for platform profiles

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf script: Fix allocation of evsel->priv related to per-event dump files

Christophe Leroy <christophe.leroy@csgroup.eu>
    powerpc/signal32: Force inlining of __unsafe_save_user_regs() and save_tm_user_regs_unsafe()

Christophe Leroy <christophe.leroy@csgroup.eu>
    powerpc/interrupt: Don't read MSR from interrupt_exit_kernel_prepare()

Christophe Leroy <christophe.leroy@csgroup.eu>
    kcsan: Don't expect 64 bits atomic builtins from 32 bits architectures

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    pinctrl: npcm7xx: Add missing check for ioremap

Wells Lu <wellslutw@gmail.com>
    pinctrl:sunplus: Add check for kmalloc

Mark Pearson <mpearson-lenovo@squebb.ca>
    platform/x86: think-lmi: Correct NVME password handling

Mark Pearson <mpearson-lenovo@squebb.ca>
    platform/x86: think-lmi: Correct System password interface

Mark Pearson <mpearson-lenovo@squebb.ca>
    platform/x86: think-lmi: mutex protection around multiple WMI calls

Xi Pardee <xi.pardee@intel.com>
    platform/x86:intel/pmc: Remove Meteor Lake S platform support

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    pinctrl: cherryview: Return correct value if pin in push-pull mode

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf bench: Add missing setlocale() call to allow usage of %'d style formatting

Thierry Reding <treding@nvidia.com>
    pinctrl: tegra: Duplicate pinmux functions table

Bart Van Assche <bvanassche@acm.org>
    scsi: ufs: core: Fix handling of lrbp->cmd

Bart Van Assche <bvanassche@acm.org>
    scsi: ufs: core: Increase the START STOP UNIT timeout from one to ten seconds

Justin Tee <justin.tee@broadcom.com>
    scsi: lpfc: Revise NPIV ELS unsol rcv cmpl logic to drop ndlp based on nlp_state

Sui Jingfeng <suijingfeng@loongson.cn>
    PCI: Add pci_clear_master() stub for non-CONFIG_PCI

Bart Van Assche <bvanassche@acm.org>
    scsi: ufs: Declare ufshcd_{hold,release}() once

Wells Lu <wellslutw@gmail.com>
    pinctrl: sunplus: Add check for kmalloc

Junyan Ye <yejunyan@hust.edu.cn>
    PCI: ftpci100: Release the clock resources

Ian Rogers <irogers@google.com>
    perf evsel: Don't let for_each_group() treat the head of the list as one of its nodes

Rongguang Wei <weirongguang@kylinos.cn>
    PCI: pciehp: Cancel bringup sequence if card is not present

Dan Carpenter <dan.carpenter@linaro.org>
    pinctrl: at91: fix a couple NULL vs IS_ERR() checks

Yuchen Yang <u202114568@hust.edu.cn>
    scsi: 3w-xxxx: Add error handling for initialization failure in tw_probe()

Ding Hui <dinghui@sangfor.com.cn>
    PCI/ASPM: Disable ASPM on MFD function removal to avoid use-after-free

Hans de Goede <hdegoede@redhat.com>
    platform/x86: lenovo-yogabook: Set default keyboard backligh brightness on probe()

Hans de Goede <hdegoede@redhat.com>
    platform/x86: lenovo-yogabook: Reprobe devices on remove()

Hans de Goede <hdegoede@redhat.com>
    platform/x86: lenovo-yogabook: Fix work race on remove()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    pinctrl: bcm2835: Handle gpiochip_add_pin_range() errors

Jinhong Zhu <jinhongzhu@hust.edu.cn>
    scsi: qedf: Fix NULL dereference in error handling

Nirmal Patel <nirmal.patel@linux.intel.com>
    PCI: vmd: Reset VMD config register between soft reboots

Siddharth Vadapalli <s-vadapalli@ti.com>
    PCI: cadence: Fix Gen2 Link Retraining process

Jason Gunthorpe <jgg@ziepe.ca>
    iommufd: Call iopt_area_contig_done() under the lock

Jason Gunthorpe <jgg@ziepe.ca>
    iommufd: Do not access the area pointer after unlocking

Paul Cercueil <paul@crapouillou.net>
    MIPS: DTS: CI20: Raise VDDCORE voltage to 1.125 volts

Paul Cercueil <paul@crapouillou.net>
    MIPS: DTS: CI20: Add parent supplies to ACT8600 regulators

Syed Saba Kareem <Syed.SabaKareem@amd.com>
    ASoC: amd: acp: clear pdm dma interrupt mask

Michael Walle <mwalle@kernel.org>
    ARM: dts: lan966x: kontron-d10: fix SPI CS

Michael Walle <mwalle@kernel.org>
    ARM: dts: lan966x: kontron-d10: fix board reset

Fei Shao <fshao@chromium.org>
    clk: Fix memory leak in devm_clk_notifier_register()

Claudiu Beznea <claudiu.beznea@microchip.com>
    ASoC: imx-audmix: check return value of devm_kasprintf()

Amir Goldstein <amir73il@gmail.com>
    ovl: update of dentry revalidate flags after copy up

Alexey Romanov <avromanov@sberdevices.ru>
    drivers: meson: secure-pwrc: always enable DMA domain

Claudiu Beznea <claudiu.beznea@microchip.com>
    clk: clocking-wizard: check return value of devm_kasprintf()

Claudiu Beznea <claudiu.beznea@microchip.com>
    clk: ti: clkctrl: check return value of kasprintf()

Claudiu Beznea <claudiu.beznea@microchip.com>
    clk: keystone: sci-clk: check return value of kasprintf()

Claudiu Beznea <claudiu.beznea@microchip.com>
    clk: si5341: free unused memory on probe failure

Claudiu Beznea <claudiu.beznea@microchip.com>
    clk: si5341: check return value of {devm_}kasprintf()

Claudiu Beznea <claudiu.beznea@microchip.com>
    clk: si5341: return error if one synth clock registration fails

Claudiu Beznea <claudiu.beznea@microchip.com>
    clk: cdce925: check return value of kasprintf()

Claudiu Beznea <claudiu.beznea@microchip.com>
    clk: vc5: check memory returned by kasprintf()

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    clk: mediatek: clk-mt8173-apmixedsys: Fix iomap not released issue

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    clk: mediatek: clk-mt8173-apmixedsys: Fix return value for of_iomap() error

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    clk: mediatek: clk-mtk: Grab iomem pointer for divider clocks

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/dpu: correct MERGE_3D length

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/dpu: fix sc7280 and sc7180 PINGPONG done interrupts

Marijn Suijten <marijn.suijten@somainline.org>
    drm/msm/dpu: Disable pingpong TE on DPU 5.0.0 and above

Marijn Suijten <marijn.suijten@somainline.org>
    drm/msm/dpu: Move autorefresh disable from CMD encoder to pingpong

Marijn Suijten <marijn.suijten@somainline.org>
    drm/msm/dpu: Drop unused poll_timeout_wr_ptr PINGPONG callback

Luben Tuikov <luben.tuikov@amd.com>
    drm/amdgpu: Fix usage of UMC fill record in RAS

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amdgpu: Fix memcpy() in sienna_cichlid_append_powerplay_table function.

Daniel Golle <daniel@makrotopia.org>
    arm64: dts: mt7986: increase bl2 partition on NAND of Bananapi R3

Nícolas F. R. A. Prado <nfraprado@collabora.com>
    arm64: dts: mediatek: mt8192: Fix CPUs capacity-dmips-mhz

Allen-KH Cheng <allen-kh.cheng@mediatek.com>
    arm64: dts: mediatek: Add cpufreq nodes for MT8192

Bjorn Andersson <quic_bjorande@quicinc.com>
    drm/msm/dp: Free resources after unregistering them

Bjorn Andersson <quic_bjorande@quicinc.com>
    drm/msm/dp: Drop aux devices together with DP controller

Jessica Zhang <quic_jesszhan@quicinc.com>
    drm/msm/dsi: Remove incorrect references to slice_count

Jessica Zhang <quic_jesszhan@quicinc.com>
    drm/msm/dpu: Fix slice_last_group_size calculation

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/dpu: do not enable color-management if DSPPs are not available

Su Hui <suhui@nfschina.com>
    ALSA: ac97: Fix possible NULL dereference in snd_ac97_mixer

Nishanth Menon <nm@ti.com>
    arm64: dts: ti: k3-am69-sk: Fix main_i2c0 alias

Thejasvi Konduru <t-konduru@ti.com>
    arm64: dts: ti: k3-j784s4: Fix wakeup pinmux range and pinctrl node offsets

Nishanth Menon <nm@ti.com>
    arm64: dts: ti: k3-j784s4-evm: Fix main_i2c0 alias

Andrew Davis <afd@ti.com>
    arm64: dts: ti: k3-j721e-beagleboneai64: Fix mailbox node status

Yuan Can <yuancan@huawei.com>
    clk: tegra: tegra124-emc: Fix potential memory leak

Dan Carpenter <dan.carpenter@linaro.org>
    clk: clocking-wizard: Fix Oops in clk_wzrd_register_divider()

Dan Carpenter <dan.carpenter@linaro.org>
    clk: bcm: rpi: Fix off by one in raspberrypi_discover_clocks()

Abel Vesa <abel.vesa@linaro.org>
    arm64: dts: qcom: sm8550: Add missing interconnect path to USB HC

Marijn Suijten <marijn.suijten@somainline.org>
    arm64: dts: qcom: sm8250-edo: Panel framebuffer is 2.5k instead of 4k

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: sm8550: Flush RSC sleep & wake votes

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: sdm845: Flush RSC sleep & wake votes

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: sdm670: Flush RSC sleep & wake votes

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: qdu1000: Flush RSC sleep & wake votes

Bosi Zhang <u201911157@hust.edu.cn>
    clk: mediatek: fix of_iomap memory leak

Yuxing Liu <lyx2022@hust.edu.cn>
    clk: imx: clk-imx8mp: improve error handling in imx8mp_clocks_probe()

Zhanhao Hu <zero12113@hust.edu.cn>
    clk: imx93: fix memory leak and missing unwind goto in imx93_clocks_probe

Hao Luo <m202171776@hust.edu.cn>
    clk: imx: clk-imx8mn: fix memory leak in imx8mn_clocks_probe

Kai Ma <kaima@hust.edu.cn>
    clk: imx: clk-imxrt1050: fix memory leak in imxrt1050_clocks_probe

Adam Ford <aford173@gmail.com>
    clk: imx: composite-8m: Add imx8m_divider_determine_rate

Kashyap Desai <kashyap.desai@broadcom.com>
    RDMA/bnxt_re: Avoid calling wake_up threads from spin_lock context

Kashyap Desai <kashyap.desai@broadcom.com>
    RDMA/bnxt_re: wraparound mbox producer index

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/a5xx: really check for A510 in a5xx_gpu_init

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/a6xx: don't set IO_PGTABLE_QUIRK_ARM_OUTER_WBWA with coherent SMMU

Chia-I Wu <olvaffe@gmail.com>
    amdgpu: validate offset_in_bo of drm_amdgpu_gem_va

Bob Pearson <rpearsonhpe@gmail.com>
    RDMA/rxe: Fix access checks in rxe_check_bind_mw

Geert Uytterhoeven <geert+renesas@glider.be>
    HID: uclogic: Modular KUnit tests should not depend on KUNIT=y

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    drm/radeon: fix possible division-by-zero errors

Aurabindo Pillai <aurabindo.pillai@amd.com>
    drm/amd/display: Fix artifacting on eDP panels when engaging freesync video mode

Chen-Yu Tsai <wenst@chromium.org>
    soc: mediatek: SVS: Fix MT8192 GPU node name

Daniil Dulov <d.dulov@aladdin.ru>
    drm/amdkfd: Fix potential deallocation of previously deallocated memory.

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    drm/amd/display: Fix a test dml32_rq_dlg_get_rq_reg()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    drm/amd/display: Fix a test CalculatePrefetchSchedule()

Paul Cercueil <paul@crapouillou.net>
    MIPS: DTS: CI20: Fix ACT8600 regulator node names

Maxime Ripard <maxime@cerno.tech>
    clk: Export clk_hw_forward_rate_request()

Christian Lamparter <chunkeey@gmail.com>
    ARM: dts: BCM5301X: fix duplex-full => full-duplex

Guenter Roeck <linux@roeck-us.net>
    hwmon: (pmbus/adm1275) Fix problems with temperature monitoring on ADM1272

Tim Harvey <tharvey@gateworks.com>
    hwmon: (gsc-hwmon) fix fan pwm temperature scaling

Olivier Moysan <olivier.moysan@foss.st.com>
    ARM: dts: stm32: fix i2s endpoint format property for stm32mp15xx-dkx

Dan Carpenter <dan.carpenter@linaro.org>
    accel/habanalabs: fix gaudi2_get_tpc_idle_status() return

Marek Vasut <marex@denx.de>
    ARM: dts: stm32: Fix audio routing on STM32MP15xx DHCOM PDK2

Chris Morgan <macromorgan@hotmail.com>
    arm64: dts: rockchip: Fix compatible for Bluetooth on rk3566-anbernic

Caleb Connolly <caleb.connolly@linaro.org>
    Input: pm8941-powerkey - fix debounce on gen2+ PMICs

Keerthy <j-keerthy@ti.com>
    arm64: dts: ti: k3-j7200: Fix physical address of pin

Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
    arm64: dts: rockchip: Assign ES8316 MCLK rate on rk3588-rock-5b

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: No 10bit gamma on desktop gen3 parts

Matt Roper <matthew.d.roper@intel.com>
    drm/i915/display: Make display responsible for probing its own IP

Matt Roper <matthew.d.roper@intel.com>
    drm/i915/display: Move display runtime info to display structure

Matt Roper <matthew.d.roper@intel.com>
    drm/i915: Convert INTEL_INFO()->display to a pointer

Matt Roper <matthew.d.roper@intel.com>
    drm/i915/display: Move display device info to header under display/

Jani Nikula <jani.nikula@intel.com>
    drm/i915: hide mkwrite_device_info() better

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Fix limited range csc matrix

Bjorn Andersson <quic_bjorande@quicinc.com>
    dt-bindings: arm-smmu: Fix SC8280XP Adreno binding

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    fbdev: omapfb: lcd_mipid: Fix an error handling path in mipid_spi_probe()

Kuogee Hsieh <quic_khsieh@quicinc.com>
    drm/msm/dpu: always clear every individual pending flush mask

Kuogee Hsieh <quic_khsieh@quicinc.com>
    drm/msm/dpu: set DSC flush bit correctly at MDP CTL flush register

Wolfram Sang <wsa+renesas@sang-engineering.com>
    arm64: dts: renesas: ulcb-kf: Remove flow control for SCIF1

Geert Uytterhoeven <geert+renesas@glider.be>
    ARM: dts: iwg20d-q7-common: Fix backlight pwm specifier

Chengchang Tang <tangchengchang@huawei.com>
    RDMA/hns: Fix hns_roce_table_get return value

Brendan Cunningham <bcunningham@cornelisnetworks.com>
    IB/hfi1: Fix wrong mmu_node used for user SDMA packet after invalidate

Arnd Bergmann <arnd@arndb.de>
    RDMA/irdma: avoid fortify-string warning in irdma_clr_wqes

Randy Dunlap <rdunlap@infradead.org>
    soc/fsl/qe: fix usb.c build errors

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    ARM: dts: meson8: correct uart_B and uart_C clock references

Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
    ASoC: es8316: Do not set rate constraints for unsupported MCLKs

Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
    ASoC: es8316: Increment max value for ALC Capture Target Volume control

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    ARM: dts: qcom: apq8074-dragonboard: Set DMA as remotely controlled

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    memory: brcmstb_dpfe: fix testing array offset after use

Marek Vasut <marex@denx.de>
    ARM: dts: stm32: Shorten the AV96 HDMI sound card name

Douglas Anderson <dianders@chromium.org>
    arm64: dts: mediatek: mt8195: Add mediatek,broken-save-restore-fw to cherry

Douglas Anderson <dianders@chromium.org>
    arm64: dts: mediatek: mt8192: Add mediatek,broken-save-restore-fw to asurada

Douglas Anderson <dianders@chromium.org>
    arm64: dts: mediatek: mt8183: Add mediatek,broken-save-restore-fw to kukui

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: apq8096: fix fixed regulator name property

Luca Weiss <luca.weiss@fairphone.com>
    arm64: dts: qcom: pm7250b: add missing spmi-vadc include

Arnd Bergmann <arnd@arndb.de>
    ARM: omap2: fix missing tick_broadcast() prototype

Arnd Bergmann <arnd@arndb.de>
    ARM: ep93xx: fix missing-prototype warnings

Dario Binacchi <dario.binacchi@amarulasolutions.com>
    drm/panel: simple: fix active size for Ampire AM-480272H3TMQW-T01H

Adam Ford <aford173@gmail.com>
    drm: bridge: samsung-dsim: Fix PMS Calculator on imx8m[mnp]

Frieder Schrempf <frieder.schrempf@kontron.de>
    drm/bridge: ti-sn65dsi83: Fix enable/disable flow to meet spec

Stephan Gerhold <stephan@gerhold.net>
    arm64: dts: qcom: apq8016-sbc: Fix 1.8V power rail on LS expansion

Stephan Gerhold <stephan@gerhold.net>
    arm64: dts: qcom: apq8016-sbc: Fix regulator constraints

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sdm845-polaris: add missing touchscreen child node reg

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sm8550: correct pinctrl unit address

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sm8550: correct crypto unit address

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sm8350: correct USB phy unit address

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sm8350: correct PCI phy unit address

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sm8350: correct DMA controller unit address

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sm6115: correct thermal-sensor unit address

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sdm845: correct camss unit address

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sdm630: correct camss unit address

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: msm8996: correct camss unit address

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: msm8994: correct SPMI unit address

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: msm8976: correct MMC unit address

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: msm8953: correct WCNSS unit address

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: msm8953: correct IOMMU unit address

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: msm8916: correct WCNSS unit address

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: msm8916: correct MMC unit address

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: msm8916: correct camss unit address

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: ipq6018: correct qrng unit address

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    arm64: dts: qcom: pm8998: don't use GIC_SPI for SPMI interrupts

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: qcom: msm8974: do not use underscore in node name (again)

Linus Walleij <linus.walleij@linaro.org>
    ARM/musb: omap2: Remove global GPIO numbers from TUSB6010

Linus Walleij <linus.walleij@linaro.org>
    ARM: omap2: Rewrite WLAN quirk to use GPIO descriptors

Linus Walleij <linus.walleij@linaro.org>
    ARM: omap2: Get USB hub reset GPIO from descriptor

Linus Walleij <linus.walleij@linaro.org>
    ARM/gpio: Push OMAP2 quirk down into TWL4030 driver

Linus Walleij <linus.walleij@linaro.org>
    ARM: omap1: Exorcise the legacy GPIO header

Linus Walleij <linus.walleij@linaro.org>
    ARM: omap1: Make serial wakeup GPIOs use descriptors

Linus Walleij <linus.walleij@linaro.org>
    ARM: omap1: Fix up the Nokia 770 board device IRQs

Linus Walleij <linus.walleij@linaro.org>
    ARM/mmc: Convert old mmci-omap to GPIO descriptors

Linus Walleij <linus.walleij@linaro.org>
    Input: ads7846 - Convert to use software nodes

Linus Walleij <linus.walleij@linaro.org>
    ARM: omap1: Remove reliance on GPIO numbers from SX1

Linus Walleij <linus.walleij@linaro.org>
    ARM: omap1: Remove reliance on GPIO numbers from PalmTE

Linus Walleij <linus.walleij@linaro.org>
    ARM: omap1: Drop header on AMS Delta

Linus Walleij <linus.walleij@linaro.org>
    ARM/mfd/gpio: Fixup TPS65010 regression on OMAP1 OSK1

Nícolas F. R. A. Prado <nfraprado@collabora.com>
    drm/bridge: anx7625: Prevent endless probe loop

Bhupesh Sharma <bhupesh.sharma@linaro.org>
    arm64: dts: qcom: qrb4210-rb2: Fix CD gpio for SDHC2

Tony Lindgren <tony@atomide.com>
    ARM: dts: gta04: Move model property out of pinctrl node

Biju Das <biju.das.jz@bp.renesas.com>
    clk: renesas: rzg2l: Fix CPG_SIPLL5_CLK1 register write

Jean-Philippe Brucker <jean-philippe@linaro.org>
    iommu/virtio: Return size mapped for a detached domain

Jean-Philippe Brucker <jean-philippe@linaro.org>
    iommu/virtio: Detach domain on endpoint release

Arnd Bergmann <arnd@arndb.de>
    drm/nouveau: dispnv50: fix missing-prototypes warning

Konrad Dybcio <konrad.dybcio@linaro.org>
    drm/msm/dpu: Set DPU_DATA_HCTL_EN for in INTF_SC7180_MASK

Marijn Suijten <marijn.suijten@somainline.org>
    drm/msm/dpu: Use V4.0 PCC DSPP sub-block in SC7[12]80

Arnaud Vrac <avrac@freebox.fr>
    drm/msm/dpu: fix cursor block register bit offset in msm8998 hw catalog

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/dsi: don't allow enabling 14nm VCO with unprogrammed rate

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/dpu: enable DSPP_2/3 for LM_2/3 on sm8450

Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
    RDMA/bnxt_re: Fix to remove an unnecessary log

Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
    RDMA/bnxt_re: Remove a redundant check inside bnxt_re_update_gid

Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
    RDMA/bnxt_re: Use unique names while registering interrupts

Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
    RDMA/bnxt_re: Fix to remove unnecessary return labels

Selvin Xavier <selvin.xavier@broadcom.com>
    RDMA/bnxt_re: Disable/kill tasklet only if it is enabled

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    hwmon: (f71882fg) prevent possible division by zero

Dan Carpenter <dan.carpenter@linaro.org>
    clk: imx: scu: use _safe list iterator to avoid a use after free

Devi Priya <quic_devipriy@quicinc.com>
    arm64: dts: qcom: ipq9574: Update the size of GICC & GICV regions

Alexander Stein <alexander.stein@ew.tq-group.com>
    drm/bridge: tc358767: Switch to devm MIPI-DSI helpers

Robert Marko <robert.marko@sartura.hr>
    arm64: dts: microchip: sparx5: do not use PSCI on reference boards

Tony Lindgren <tony@atomide.com>
    bus: ti-sysc: Fix dispc quirk masking bool variables

Marek Vasut <marex@denx.de>
    ARM: dts: stm32: Move ethernet MAC EEPROM from SoM to carrier boards

Maíra Canal <mcanal@igalia.com>
    drm/vkms: Fix RGB565 pixel conversion

Maíra Canal <mcanal@igalia.com>
    drm: Add fixed-point helper to get rounded integer values

Maíra Canal <mcanal@igalia.com>
    drm/vkms: isolate pixel conversion functionality

Bard Liao <yung-chuan.liao@linux.intel.com>
    ASoC: Intel: sof_sdw: start set codec init function with an adr index

Bard Liao <yung-chuan.liao@linux.intel.com>
    ASoC: Intel: sof_sdw: remove SOF_SDW_TGL_HDMI for MeteorLake devices

Trevor Wu <trevor.wu@mediatek.com>
    ASoC: dt-bindings: mediatek,mt8188-afe: correct clock name

Dan Carpenter <dan.carpenter@linaro.org>
    driver: soc: xilinx: use _safe loop iterator to avoid a use after free

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/panel: sharp-ls043t1le01: adjust mode settings

XuDong Liu <m202071377@hust.edu.cn>
    drm: sun4i_tcon: use devm_clk_get_enabled in `sun4i_tcon_init_clocks`

Marek Vasut <marex@denx.de>
    Input: adxl34x - do not hardcode interrupt trigger type

Marek Vasut <marek.vasut+renesas@mailbox.org>
    clk: rs9: Fix .driver_data content in i2c_device_id

Marek Vasut <marek.vasut+renesas@mailbox.org>
    clk: vc7: Fix .driver_data content in i2c_device_id

Marek Vasut <marek.vasut+renesas@mailbox.org>
    clk: vc5: Fix .driver_data content in i2c_device_id

hfdevel@gmx.net <hfdevel@gmx.net>
    ARM: dts: meson8b: correct uart_B and uart_C clock references

Rafał Miłecki <rafal@milecki.pl>
    ARM: dts: BCM5301X: Drop "clock-names" from the SPI node

Luc Ma <luc@sietium.com>
    drm/vram-helper: fix function names in vram helper doc

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: tests - fix input_test_match_device_id test

Francesco Dolcini <francesco.dolcini@toradex.com>
    drm/bridge: tc358768: fix THS_TRAILCNT computation

Francesco Dolcini <francesco.dolcini@toradex.com>
    drm/bridge: tc358768: fix TXTAGOCNT computation

Francesco Dolcini <francesco.dolcini@toradex.com>
    drm/bridge: tc358768: fix THS_ZEROCNT computation

Francesco Dolcini <francesco.dolcini@toradex.com>
    drm/bridge: tc358768: fix TCLK_TRAILCNT computation

Francesco Dolcini <francesco.dolcini@toradex.com>
    drm/bridge: tc358768: Add atomic_get_input_bus_fmts() implementation

Francesco Dolcini <francesco.dolcini@toradex.com>
    drm/bridge: tc358768: fix TCLK_ZEROCNT computation

Francesco Dolcini <francesco.dolcini@toradex.com>
    drm/bridge: tc358768: fix PLL target frequency

Francesco Dolcini <francesco.dolcini@toradex.com>
    drm/bridge: tc358768: fix PLL parameters computation

Francesco Dolcini <francesco.dolcini@toradex.com>
    drm/bridge: tc358768: always enable HS video mode

Alexander Stein <alexander.stein@ew.tq-group.com>
    drm/bridge: ti-sn65dsi83: Fix enable error path

Geert Uytterhoeven <geert+renesas@glider.be>
    Input: tests - modular KUnit tests should not depend on KUNIT=y

Geert Uytterhoeven <geert+renesas@glider.be>
    Input: tests - fix use-after-free and refcount underflow in input_test_exit()

Duoming Zhou <duoming@zju.edu.cn>
    Input: cyttsp4_core - change del_timer_sync() to timer_shutdown_sync()

Luca Weiss <luca@z3ntu.xyz>
    Input: drv260x - sleep between polling GO bit

Markus Elfring <elfring@users.sourceforge.net>
    drm/bridge: it6505: Move a variable assignment behind a null pointer check in receive_timing_debugfs_show()

Vinay Belgaumkar <vinay.belgaumkar@intel.com>
    drm/i915/guc/slpc: Provide sysfs for efficient freq

Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
    drm/amd/display: Explicitly specify update type per plane info change

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    radeon: avoid double free in ci_dpm_init()

Arnd Bergmann <arnd@arndb.de>
    drm/amd/display: fix is_timing_changed() prototype

Wesley Chalmers <Wesley.Chalmers@amd.com>
    drm/amd/display: Add logging for display MALL refresh setting

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amd/display: Unconditionally print when DP sink power state fails

Dan Carpenter <error27@gmail.com>
    drm/imx/lcdc: fix a NULL vs IS_ERR() bug in probe

Kuniyuki Iwashima <kuniyu@amazon.com>
    netlink: Add __sock_i_ino() for __netlink_diag_dump().

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: dsa: avoid suspicious RCU usage for synced VLAN-aware MAC addresses

Cambda Zhu <cambda@linux.alibaba.com>
    ipvlan: Fix return value of ipvlan_queue_xmit()

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: fix underflow in chain reference counter

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: unbind non-anonymous set if rule construction fails

Ilia.Gavrilov <Ilia.Gavrilov@infotecs.ru>
    netfilter: nf_conntrack_sip: fix the ct_sip_parse_numerical_param() return value.

Florian Westphal <fw@strlen.de>
    netfilter: conntrack: dccp: copy entire header to stack buffer, not just basic one

Jeremy Sowden <jeremy@azazel.net>
    lib/ts_bm: reset initial match offset for every block of text

Lin Ma <linma@zju.edu.cn>
    net: nfc: Fix use-after-free caused by nfc_llcp_find_local

Edward Cree <ecree.xilinx@gmail.com>
    sfc: fix crash when reading stats while NIC is resetting

David Howells <dhowells@redhat.com>
    ocfs2: Fix use of slab data with sendpage

Maxim Kochetkov <fido_max@inbox.ru>
    net: axienet: Move reset before 64-bit DMA detection

Kuniyuki Iwashima <kuniyu@amazon.com>
    gtp: Fix use-after-free in __gtp_encap_destroy().

Sabrina Dubroca <sd@queasysnail.net>
    selftests: rtnetlink: remove netdevsim device after ipsec offload test

Eric Dumazet <edumazet@google.com>
    sch_netem: fix issues in netem_change() vs get_dist_table()

Eric Dumazet <edumazet@google.com>
    bonding: do not assume skb mac_header is set

Eric Dumazet <edumazet@google.com>
    netlink: do not hard code device address lenth in fdb dumps

Eric Dumazet <edumazet@google.com>
    netlink: fix potential deadlock in netlink_set_err()

Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
    net: stmmac: fix double serdes powerdown

Vinicius Costa Gomes <vinicius.gomes@intel.com>
    igc: Work around HW bug causing missing timestamps

Vinicius Costa Gomes <vinicius.gomes@intel.com>
    igc: Retrieve TX timestamp during interrupt handling

Vinicius Costa Gomes <vinicius.gomes@intel.com>
    igc: Check if hardware TX timestamping is enabled earlier

Vinicius Costa Gomes <vinicius.gomes@intel.com>
    igc: Fix race condition in PTP tx code

Jimmy Assarsson <extja@kvaser.com>
    can: kvaser_pciefd: Set hardware timestamp on transmitted packets

Jimmy Assarsson <extja@kvaser.com>
    can: kvaser_pciefd: Add function to set skb hwtstamps

Vincent Mailhol <mailhol.vincent@wanadoo.fr>
    can: length: fix bitstuffing count

Gilad Sever <gilad9366@gmail.com>
    bpf: Fix bpf socket lookup from tc/xdp to respect socket VRF bindings

Gilad Sever <gilad9366@gmail.com>
    bpf: Call __bpf_sk_lookup()/__bpf_skc_lookup() directly via TC hookpoint

Gilad Sever <gilad9366@gmail.com>
    bpf: Factor out socket lookup functions for the TC hookpoint.

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: ath9k: convert msecs to jiffies where needed

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: mvm: check only affected links

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: mvm: indicate HW decrypt for beacon protection

Marek Vasut <marex@denx.de>
    mmc: Add MMC_QUIRK_BROKEN_SD_CACHE for Kingston Canvas Go Plus from 11/2019

Douglas Anderson <dianders@chromium.org>
    watchdog/hardlockup: keep kernel.nmi_watchdog sysctl as 0444 if probe fails

Lecopzer Chen <lecopzer.chen@mediatek.com>
    watchdog/perf: adapt the watchdog_perf interface for async model

Douglas Anderson <dianders@chromium.org>
    watchdog/hardlockup: rename some "NMI watchdog" constants/function

Douglas Anderson <dianders@chromium.org>
    watchdog/hardlockup: move perf hardlockup checking/panic to common watchdog.c

Lecopzer Chen <lecopzer.chen@mediatek.com>
    watchdog/hardlockup: change watchdog_nmi_enable() to void

Lecopzer Chen <lecopzer.chen@mediatek.com>
    watchdog: remove WATCHDOG_DEFAULT

Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    mm: move mm_count into its own cache line

Ilan Peer <ilan.peer@intel.com>
    wifi: ieee80211: Fix the common size calculation for reconfiguration ML

Johannes Berg <johannes.berg@intel.com>
    wifi: cfg80211: fix regulatory disconnect with OCB/NAN

Benjamin Berg <benjamin.berg@intel.com>
    wifi: cfg80211: drop incorrect nontransmitted BSS update code

Benjamin Berg <benjamin.berg@intel.com>
    wifi: cfg80211: rewrite merging of inherited elements

Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
    wifi: mac80211: Remove "Missing iftype sband data/EHT cap" spam

Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
    wifi: iwlwifi: pcie: fix NULL pointer dereference in iwl_pcie_irq_rx_msix_handler()

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: pull from TXQs with softirqs disabled

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: mvm: correctly access HE/EHT sband capa

Gregory Greenman <gregory.greenman@intel.com>
    wifi: iwlwifi: mvm: add support for Extra EHT LTF

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: add helpers to access sband iftype data

Ziyang Huang <hzyitc@outlook.com>
    wifi: ath11k: Add missing hw_ops->get_ring_selector() for IPQ5018

Ziyang Huang <hzyitc@outlook.com>
    wifi: ath11k: Restart firmware after cold boot calibration for IPQ5018

Ziyang Huang <hzyitc@outlook.com>
    wifi: ath11k: Add missing ops config for IPQ5018 in ath11k_ahb_probe()

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    wifi: ath11k: Add missing check for ioremap

Edwin Peer <edwin.peer@broadcom.com>
    rtnetlink: extend RTEXT_FILTER_SKIP_STATS to IFLA_VF_INFO

Mukesh Sisodiya <mukesh.sisodiya@intel.com>
    wifi: iwlwifi: fw: print PC register value instead of address

Mukesh Sisodiya <mukesh.sisodiya@intel.com>
    wifi: iwlwifi: mvm: Handle return value for iwl_mvm_sta_init

Ilan Peer <ilan.peer@intel.com>
    wifi: mac80211: Fix permissions for valid_links debugfs entry

Eduard Zingerman <eddyz87@gmail.com>
    bpf: Verify scalar ids mapping in regsafe() using check_ids()

Eduard Zingerman <eddyz87@gmail.com>
    bpf: Use scalar ids in mark_chain_precision()

Remi Pommarel <repk@triplefau.lt>
    wifi: ath9k: Fix possible stall on ath9k_txq_list_has_key()

Eduard Zingerman <eddyz87@gmail.com>
    selftests/bpf: Fix invalid pointer check in get_xlated_program()

Arnd Bergmann <arnd@arndb.de>
    memstick r592: make memstick_debug_get_tpc_name() static

Douglas Anderson <dianders@chromium.org>
    mmc: mediatek: Avoid ugly error message when SDIO wakeup IRQ isn't used

Zhen Lei <thunder.leizhen@huawei.com>
    kexec: fix a memory leak in crash_shrink_memory()

Douglas Anderson <dianders@chromium.org>
    watchdog/perf: more properly prevent false positives with turbo modes

Douglas Anderson <dianders@chromium.org>
    watchdog/perf: define dummy watchdog_update_hrtimer_threshold() on correct config

Haifeng Xu <haifeng.xu@shopee.com>
    selftests: cgroup: fix unexpected failure on test_memcg_low

Karol Kolacinski <karol.kolacinski@intel.com>
    ice: handle extts in the miscellaneous interrupt thread

Marek Vasut <marex@denx.de>
    wifi: rsi: Do not set MMC_PM_KEEP_POWER in shutdown

Marek Vasut <marex@denx.de>
    wifi: rsi: Do not configure WoWlan in shutdown hook if not enabled

Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
    spi: spi-geni-qcom: Do not do DMA map/unmap inside driver, use framework instead

Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
    soc: qcom: geni-se: Add interfaces geni_se_tx_init_dma() and geni_se_rx_init_dma()

Jesper Dangaard Brouer <brouer@redhat.com>
    selftests/bpf: Fix check_mtu using wrong variable type

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: recalc min chandef for new STA links

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: mvm: send time sync only if needed

Viktor Malik <vmalik@redhat.com>
    tools/resolve_btfids: Fix setting HOSTCFLAGS

Dave Marchevsky <davemarchevsky@fb.com>
    bpf: Make bpf_refcount_acquire fallible for non-owning refs

Dave Marchevsky <davemarchevsky@fb.com>
    bpf: Fix __bpf_{list,rbtree}_add's beginning-of-node calculation

Dave Marchevsky <davemarchevsky@fb.com>
    bpf: Set kptr_struct_meta for node param to list and rbtree insert funcs

Dave Marchevsky <davemarchevsky@fb.com>
    bpf: Remove anonymous union in bpf_kfunc_call_arg_meta

Youghandhar Chintala <quic_youghand@quicinc.com>
    wifi: ath10k: Trigger STA disconnect after reconfig complete on hardware restart

Jesper Dangaard Brouer <brouer@redhat.com>
    samples/bpf: xdp1 and xdp2 reduce XDPBUFSIZE to 60

Sascha Hauer <s.hauer@pengutronix.de>
    wifi: rtw88: usb: silence log flooding error message

Fedor Pchelkin <pchelkin@ispras.ru>
    wifi: ath9k: don't allow to overwrite ENDPOINT0 attributes

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    wifi: ray_cs: Fix an error handling path in ray_probe()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    wifi: wl3501_cs: Fix an error handling path in wl3501_probe()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    wifi: atmel: Fix an error handling path in atmel_probe()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    wifi: orinoco: Fix an error handling path in orinoco_cs_probe()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    wifi: orinoco: Fix an error handling path in spectrum_cs_probe()

Geert Uytterhoeven <geert+renesas@glider.be>
    regulator: core: Streamline debugfs operations

Geert Uytterhoeven <geert+renesas@glider.be>
    regulator: core: Fix more error checking for debugfs_create_dir()

Sebastian Reichel <sebastian.reichel@collabora.com>
    regulator: rk808: fix asynchronous probing

Alexey Gladkov <legion@kernel.org>
    selftests/bpf: Do not use sign-file as testcase

Yafang Shao <laoar.shao@gmail.com>
    bpf: Fix memleak due to fentry attach failure

Yafang Shao <laoar.shao@gmail.com>
    bpf: Remove bpf trampoline selector

Alan Maguire <alan.maguire@oracle.com>
    bpftool: JIT limited misreported as negative value on aarch64

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    nfc: llcp: fix possible use of uninitialized variable in nfc_llcp_send_connect()

Joy Chakraborty <joychakr@google.com>
    spi: dw: Round of n_bytes to power of 2

Stanislav Fomichev <sdf@google.com>
    bpf: Don't EFAULT for {g,s}setsockopt with wrong optlen

Andrii Nakryiko <andrii@kernel.org>
    libbpf: fix offsetof() and container_of() to work with CO-RE

Edward Cree <ecree.xilinx@gmail.com>
    sfc: release encap match in efx_tc_flow_free()

Alexander Mikhalitsyn <alexander@mihalicyn.com>
    sctp: add bpf_bypass_getsockopt proto callback

Chuck Lever <chuck.lever@oracle.com>
    net/handshake: Unpin sock->file if a handshake is cancelled

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    wifi: mwifiex: Fix the size of a memory allocation in mwifiex_ret_802_11_scan()

Dan Carpenter <dan.carpenter@linaro.org>
    wifi: rtw88: unlock on error path in rtw_ops_add_interface()

Amisha Patel <amisha.patel@microchip.com>
    wifi: wilc1000: fix for absent RSN capabilities WFA testcase

Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
    spi: spi-geni-qcom: Correct CS_TOGGLE bit in SPI_TRANS_CFG

Pengcheng Yang <yangpc@wangsu.com>
    samples/bpf: Fix buffer overflow in tcp_basertt

Dan Carpenter <dan.carpenter@linaro.org>
    wifi: rtw89: fix rtw89_read_chip_ver() for RTL8852B and RTL8851B

Andrii Nakryiko <andrii@kernel.org>
    bpf: fix propagate_precision() logic for inner frames

Andrii Nakryiko <andrii@kernel.org>
    bpf: maintain bitmasks across all active frames in __mark_chain_precision

Andrii Nakryiko <andrii@kernel.org>
    bpf: improve precision backtrack logging

Andrii Nakryiko <andrii@kernel.org>
    bpf: encapsulate precision backtracking bookkeeping

Martin KaFai Lau <martin.lau@kernel.org>
    libbpf: btf_dump_type_data_check_overflow needs to consider BTF_MEMBER_BITFIELD_SIZE

Fedor Pchelkin <pchelkin@ispras.ru>
    wifi: ath9k: avoid referencing uninit memory in ath9k_wmi_ctrl_rx

Peter Seiderer <ps.report@gmx.net>
    wifi: ath9k: fix AR9003 mac hardware hang check register offset calculation

Jesper Dangaard Brouer <brouer@redhat.com>
    igc: Enable and fix RX hash usage by netstack

Hao Jia <jiahao.os@bytedance.com>
    sched/core: Avoid multiple calling update_rq_clock() in __cfsb_csd_unthrottle()

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    pstore/ram: Add check for kstrdup

Roberto Sassu <roberto.sassu@huawei.com>
    ima: Fix build warnings

Roberto Sassu <roberto.sassu@huawei.com>
    evm: Fix build warnings

Roberto Sassu <roberto.sassu@huawei.com>
    evm: Complete description of evm_inode_setattr()

Mark Rutland <mark.rutland@arm.com>
    locking/atomic: arm: fix sync ops

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    reiserfs: Initialize sec->length in reiserfs_security_init().

Juergen Gross <jgross@suse.com>
    x86/mm: Fix __swp_entry_to_pte() for Xen PV guests

Ravi Bangoria <ravi.bangoria@amd.com>
    perf/ibs: Fix interface via core pmu events

Mark Brown <broonie@kernel.org>
    selftests/ftace: Fix KTAP output ordering

Colin Ian King <colin.i.king@gmail.com>
    kselftest: vDSO: Fix accumulation of uninitialized ret when CLOCK_REALTIME is undefined

Thomas Weißschuh <linux@weissschuh.net>
    tools/nolibc: ensure fast64 integer types have 64 bits

Juergen Gross <jgross@suse.com>
    x86/xen: Set MTRR state when running as Xen PV initial domain

Juergen Gross <jgross@suse.com>
    x86/mtrr: Replace size_or_mask and size_and_mask with a much easier concept

Juergen Gross <jgross@suse.com>
    x86/hyperv: Set MTRR state when running as SEV-SNP Hyper-V guest

Juergen Gross <jgross@suse.com>
    x86/mtrr: Support setting MTRR state for software defined MTRRs

Juergen Gross <jgross@suse.com>
    x86/mtrr: Remove physical address size calculation

Qiuxu Zhuo <qiuxu.zhuo@intel.com>
    rcu/rcuscale: Stop kfree_scale_thread thread(s) after unloading rcuscale

Qiuxu Zhuo <qiuxu.zhuo@intel.com>
    rcu/rcuscale: Move rcu_scale_*() after kfree_scale_cleanup()

Paul E. McKenney <paulmck@kernel.org>
    rcutorture: Correct name of use_softirq module parameter

Paul E. McKenney <paulmck@kernel.org>
    rcu-tasks: Stop rcu_tasks_invoke_cbs() from using never-onlined CPUs

Paul E. McKenney <paulmck@kernel.org>
    rcu: Make rcu_cpu_starting() rely on interrupts being disabled

Daniel Latypov <dlatypov@google.com>
    kunit: tool: undo type subscripts for subprocess.Popen

Peng Fan <peng.fan@nxp.com>
    thermal/drivers/qoriq: Only enable supported sensors

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    thermal/drivers/sun8i: Fix some error handling paths in sun8i_ths_probe()

Stephan Gerhold <stephan.gerhold@kernkonzept.com>
    thermal/drivers/qcom/tsens-v0_1: Add mdm9607 correction offsets

Stephan Gerhold <stephan.gerhold@kernkonzept.com>
    thermal/drivers/qcom/tsens-v0_1: Fix mdm9607 slope values

Matti Lehtimäki <matti.lehtimaki@gmail.com>
    thermal/drivers/qcom/tsens-v0_1: Add support for MSM8226

Tero Kristo <tero.kristo@linux.intel.com>
    cpufreq: intel_pstate: Fix energy_performance_preference for passive

Arnd Bergmann <arnd@arndb.de>
    ARM: 9303/1: kprobes: avoid missing-declaration warnings

Ulf Hansson <ulf.hansson@linaro.org>
    PM: domains: Move the verification of in-params from genpd_add_device()

Zhang Rui <rui.zhang@intel.com>
    powercap: RAPL: Fix CONFIG_IOSF_MBI dependency

Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
    powercap: RAPL: fix invalid initialization for pl4_supported field

Li Yang <leoyang.li@nxp.com>
    APEI: GHES: correctly return NULL for ghes_get_devices()

Robin Murphy <robin.murphy@arm.com>
    perf/arm_cspmu: Fix event attribute type

Ilkka Koskinen <ilkka@os.amperecomputing.com>
    perf: arm_cspmu: Set irq affinitiy only if overflow interrupt is used

Junhao He <hejunhao3@huawei.com>
    drivers/perf: hisi: Don't migrate perf to the CPU going to teardown

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    x86/tdx: Fix race between set_memory_encrypted() and load_unaligned_zeropad()

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    x86/mm: Allow guest.enc_status_change_prepare() to fail

Marc Zyngier <maz@kernel.org>
    drivers/perf: apple_m1: Force 63bit counters for M2 CPUs

Robin Murphy <robin.murphy@arm.com>
    perf/arm-cmn: Fix DTC reset

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    PM: domains: fix integer overflow issues in genpd_parse_state()

Feng Mingxi <m202271825@hust.edu.cn>
    clocksource/drivers/cadence-ttc: Fix memory leak in ttc_timer_probe

Ming Lei <ming.lei@redhat.com>
    blk-mq: don't insert passthrough request into sw queue

Christoph Hellwig <hch@lst.de>
    btrfs: fix file_offset for REQ_BTRFS_ONE_ORDERED bios that get split

Christoph Hellwig <hch@lst.de>
    btrfs: don't treat zoned writeback as being from an async helper thread

Christoph Hellwig <hch@lst.de>
    btrfs: only call __extent_writepage_io from extent_write_locked_range

Christoph Hellwig <hch@lst.de>
    btrfs: don't fail writeback when allocating the compression context fails

Christoph Hellwig <hch@lst.de>
    btrfs: fix range_end calculation in extent_write_locked_range

Christoph Hellwig <hch@lst.de>
    btrfs: submit a writeback bio per extent_buffer

Christoph Hellwig <hch@lst.de>
    btrfs: return bool from lock_extent_buffer_for_io

Christoph Hellwig <hch@lst.de>
    btrfs: don't use btrfs_bio_ctrl for extent buffer reading

Christoph Hellwig <hch@lst.de>
    btrfs: always read the entire extent_buffer

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    tracing/timer: Add missing hrtimer modes to decode_hrtimer_mode().

Wen Yang <wenyang.linux@foxmail.com>
    tick/rcu: Fix bogus ratelimit condition

Thomas Gleixner <tglx@linutronix.de>
    posix-timers: Prevent RT livelock in itimer_delete()

Gao Xiang <xiang@kernel.org>
    erofs: fix compact 4B support for 16k block size

Chuck Lever <chuck.lever@oracle.com>
    svcrdma: Prevent page release when nothing was received

John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
    irqchip/jcore-aic: Fix missing allocation of IRQ descriptors

Antonio Borneo <antonio.borneo@foss.st.com>
    irqchip/stm32-exti: Fix warning on initialized field overwritten

Christoph Hellwig <hch@lst.de>
    splice: don't call file_accessed in copy_splice_read

Jianmin Lv <lvjianmin@loongson.cn>
    irqchip/loongson-eiointc: Fix irq affinity setting during resume

Yu Kuai <yukuai3@huawei.com>
    block: fix blktrace debugfs entries leakage

Yu Kuai <yukuai3@huawei.com>
    md/raid1-10: submit write io directly if bitmap is not enabled

Yu Kuai <yukuai3@huawei.com>
    md/raid1-10: factor out a helper to submit normal write

Yu Kuai <yukuai3@huawei.com>
    md/raid1-10: factor out a helper to add bio to plug

Li Nan <linan122@huawei.com>
    md/raid10: fix io loss while replacement replace rdev

Li Nan <linan122@huawei.com>
    md/raid10: fix null-ptr-deref of mreplace in raid10_sync_request

Li Nan <linan122@huawei.com>
    md/raid10: fix wrong setting of max_corr_read_errors

Li Nan <linan122@huawei.com>
    md/raid10: fix overflow of md/safe_mode_delay

Li Nan <linan122@huawei.com>
    md/raid10: check slab-out-of-bounds in md_bitmap_get_counter

Chaitanya Kulkarni <kch@nvidia.com>
    nvme-core: fix dev_pm_qos memleak

Chaitanya Kulkarni <kch@nvidia.com>
    nvme-core: add missing fault-injection cleanup

Chaitanya Kulkarni <kch@nvidia.com>
    nvme-core: fix memory leak in dhchap_ctrl_secret

Chaitanya Kulkarni <kch@nvidia.com>
    nvme-core: fix memory leak in dhchap_secret_store

NeilBrown <neilb@suse.de>
    lockd: drop inappropriate svc_get() from locked_get()

Yu Kuai <yukuai3@huawei.com>
    blk-mq: fix potential io hang by wrong 'wake_batch'

Arnd Bergmann <arnd@arndb.de>
    virt: sevguest: Add CONFIG_CRYPTO dependency

Waiman Long <longman@redhat.com>
    blk-cgroup: Reinit blkg_iostat_set after clearing in blkcg_reset_stats()

Tom Lendacky <thomas.lendacky@amd.com>
    x86/sev: Fix calculation of end address based on number of pages

Li Nan <linan122@huawei.com>
    blk-iocost: use spin_lock_irqsave in adjust_inuse_and_calc_cost

Eric Biggers <ebiggers@google.com>
    fsverity: don't use bio_first_page_all() in fsverity_verify_bio()

Eric Biggers <ebiggers@google.com>
    fsverity: use shash API instead of ahash API

Shawn Wang <shawnwang@linux.alibaba.com>
    x86/resctrl: Only show tasks' pid in current pid namespace

Gao Xiang <xiang@kernel.org>
    erofs: kill hooked chains to avoid loops on deduplicated compressed images

David Howells <dhowells@redhat.com>
    splice: Fix filemap_splice_read() to use the correct inode

Yu Kuai <yukuai3@huawei.com>
    block/rq_qos: protect rq_qos apis with a new lock

Bart Van Assche <bvanassche@acm.org>
    block: Fix the type of the second bdev_op_is_zoned_write() argument

Ming Lei <ming.lei@redhat.com>
    blk-mq: don't queue plugged passthrough requests into scheduler

Alexander Gordeev <agordeev@linux.ibm.com>
    s390/kasan: fix insecure W+X mapping warning

Arnd Bergmann <arnd@arndb.de>
    fs: pipe: reveal missing function protoypes

Hersen Wu <hersenxs.wu@amd.com>
    Revert "drm/amd/display: edp do not add non-edid timings"

Sean Nyekjaer <sean@geanix.com>
    iio: accel: fxls8962af: fixup buffer scan element type

Sean Nyekjaer <sean@geanix.com>
    iio: accel: fxls8962af: errata bug only applicable for FXLS8962AF

Fabrizio Lamarque <fl.scratchpad@gmail.com>
    iio: adc: ad7192: Fix internal/external clock selection

Fabrizio Lamarque <fl.scratchpad@gmail.com>
    iio: adc: ad7192: Fix null ad7192_state pointer access

Rasmus Villemoes <linux@rasmusvillemoes.dk>
    iio: addac: ad74413: don't set DIN_SINK for functions other than digital input

Fabrizio Lamarque <fl.scratchpad@gmail.com>
    dt-bindings: iio: ad7192: Add mandatory reference voltage source

Alvin Šipraga <alsi@bang-olufsen.dk>
    extcon: usbc-tusb320: Unregister typec port on driver removal

EJ Hsu <ejh@nvidia.com>
    phy: tegra: xusb: Clear the driver reference in usb-phy dev

Krishna Kurapati <quic_kriskura@quicinc.com>
    usb: dwc3: gadget: Propagate core init errors to UDC during pullup

Davide Tronchin <davide.tronchin.94@gmail.com>
    USB: serial: option: add LARA-R6 01B PIDs

ndesaulniers@google.com <ndesaulniers@google.com>
    start_kernel: Add __no_stack_protector function attribute


-------------

Diffstat:

 Documentation/ABI/testing/sysfs-driver-eud         |   2 +-
 .../devicetree/bindings/crypto/qcom-qce.yaml       |   6 +
 .../devicetree/bindings/iio/adc/adi,ad7192.yaml    |   5 +
 .../devicetree/bindings/iommu/arm,smmu.yaml        |   6 +-
 .../devicetree/bindings/power/reset/qcom,pon.yaml  |   4 +-
 .../bindings/sound/mediatek,mt8188-afe.yaml        |  36 +-
 Documentation/fault-injection/provoke-crashes.rst  |   2 +-
 Documentation/filesystems/autofs-mount-control.rst |   2 +-
 Documentation/filesystems/autofs.rst               |   2 +-
 Documentation/filesystems/directory-locking.rst    |  26 +-
 Documentation/filesystems/f2fs.rst                 |  16 +
 Documentation/networking/af_xdp.rst                |   9 +
 Makefile                                           |   4 +-
 arch/arc/include/asm/linkage.h                     |   8 +-
 arch/arm/boot/dts/bcm53015-meraki-mr26.dts         |   2 +-
 arch/arm/boot/dts/bcm53016-meraki-mr32.dts         |   2 +-
 arch/arm/boot/dts/bcm5301x.dtsi                    |   1 -
 arch/arm/boot/dts/iwg20d-q7-common.dtsi            |   2 +-
 .../boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi  |  16 +-
 arch/arm/boot/dts/meson8.dtsi                      |   4 +-
 arch/arm/boot/dts/meson8b.dtsi                     |   4 +-
 arch/arm/boot/dts/omap3-gta04a5one.dts             |   4 +-
 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts     |   4 +-
 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts     |   4 +
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts    |   8 +-
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi      |  10 +-
 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi      |  12 +-
 arch/arm/boot/dts/qcom-msm8974.dtsi                |   2 +-
 arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi      |  11 +-
 arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi |   8 +-
 .../boot/dts/stm32mp15xx-dhcor-drc-compact.dtsi    |   6 +
 arch/arm/boot/dts/stm32mp15xx-dhcor-som.dtsi       |   6 -
 arch/arm/boot/dts/stm32mp15xx-dhcor-testbench.dtsi |   8 +
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi             |   2 +-
 arch/arm/include/asm/assembler.h                   |  17 +
 arch/arm/include/asm/sync_bitops.h                 |  29 +-
 arch/arm/lib/bitops.h                              |  14 +-
 arch/arm/lib/testchangebit.S                       |   4 +
 arch/arm/lib/testclearbit.S                        |   4 +
 arch/arm/lib/testsetbit.S                          |   4 +
 arch/arm/mach-ep93xx/timer-ep93xx.c                |   3 +-
 arch/arm/mach-omap1/board-ams-delta.c              |   1 -
 arch/arm/mach-omap1/board-nokia770.c               | 207 +++---
 arch/arm/mach-omap1/board-osk.c                    | 146 +++--
 arch/arm/mach-omap1/board-palmte.c                 |  51 +-
 arch/arm/mach-omap1/board-sx1-mmc.c                |   1 -
 arch/arm/mach-omap1/board-sx1.c                    |  40 +-
 arch/arm/mach-omap1/devices.c                      |   1 -
 arch/arm/mach-omap1/gpio15xx.c                     |   1 -
 arch/arm/mach-omap1/gpio16xx.c                     |   1 -
 arch/arm/mach-omap1/irq.c                          |   1 -
 arch/arm/mach-omap1/serial.c                       |  30 +-
 arch/arm/mach-omap2/board-generic.c                |   1 +
 arch/arm/mach-omap2/board-n8x0.c                   | 156 ++---
 arch/arm/mach-omap2/omap_device.c                  |   1 -
 arch/arm/mach-omap2/pdata-quirks.c                 | 132 ++--
 arch/arm/mach-omap2/usb-tusb6010.c                 |  20 +-
 arch/arm/mach-omap2/usb-tusb6010.h                 |  12 +
 arch/arm/mach-orion5x/board-dt.c                   |   3 +
 arch/arm/mach-orion5x/common.h                     |   6 +
 arch/arm/mach-pxa/spitz.c                          |  11 +-
 arch/arm/probes/kprobes/checkers-common.c          |   2 +-
 arch/arm/probes/kprobes/core.c                     |   2 +-
 arch/arm/probes/kprobes/opt-arm.c                  |   2 -
 arch/arm/probes/kprobes/test-core.c                |   2 +-
 arch/arm/probes/kprobes/test-core.h                |   4 +
 .../dts/mediatek/mt7986a-bananapi-bpi-r3-nand.dtso |   6 +-
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi     |   4 +
 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi   |   4 +
 arch/arm64/boot/dts/mediatek/mt8192.dtsi           |  22 +-
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi    |   4 +
 arch/arm64/boot/dts/microchip/sparx5.dtsi          |   2 +-
 .../boot/dts/microchip/sparx5_pcb_common.dtsi      |  12 +
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts           |  78 ++-
 arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts       |   4 +-
 arch/arm64/boot/dts/qcom/ipq6018.dtsi              |   2 +-
 arch/arm64/boot/dts/qcom/ipq9574.dtsi              |   6 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   8 +-
 arch/arm64/boot/dts/qcom/msm8953.dtsi              |   4 +-
 arch/arm64/boot/dts/qcom/msm8976.dtsi              |   6 +-
 arch/arm64/boot/dts/qcom/msm8994.dtsi              |   2 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |   2 +-
 arch/arm64/boot/dts/qcom/pm7250b.dtsi              |   1 +
 arch/arm64/boot/dts/qcom/pm8998.dtsi               |   2 +-
 arch/arm64/boot/dts/qcom/qdu1000.dtsi              |   1 +
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts           |   3 +-
 arch/arm64/boot/dts/qcom/sdm630.dtsi               |   2 +-
 arch/arm64/boot/dts/qcom/sdm670.dtsi               |   1 +
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts |   1 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |   3 +-
 arch/arm64/boot/dts/qcom/sm6115.dtsi               |   2 +-
 .../boot/dts/qcom/sm8250-sony-xperia-edo.dtsi      |   7 +-
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |   6 +-
 arch/arm64/boot/dts/qcom/sm8550.dtsi               |   9 +-
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi           |   3 +-
 .../boot/dts/rockchip/rk3566-anbernic-rgxx3.dtsi   |   2 +-
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts    |   2 +
 arch/arm64/boot/dts/ti/k3-am69-sk.dts              |   2 +-
 .../boot/dts/ti/k3-j7200-common-proc-board.dts     |  28 +-
 arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts |   5 +
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts           |  32 +-
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi   |  29 +-
 arch/arm64/include/asm/fpsimdmacros.h              |   6 +-
 arch/arm64/kernel/signal.c                         |   2 +-
 arch/loongarch/Makefile                            |   2 +-
 arch/mips/Makefile                                 |   2 +-
 arch/mips/alchemy/devboards/db1000.c               |  11 +-
 arch/mips/boot/dts/ingenic/ci20.dts                |  38 +-
 arch/powerpc/Kconfig.debug                         |   2 +-
 arch/powerpc/boot/dts/turris1x.dts                 |   6 +-
 arch/powerpc/include/asm/nmi.h                     |   4 +-
 arch/powerpc/kernel/interrupt.c                    |   3 +-
 arch/powerpc/kernel/ppc_save_regs.S                |   6 +-
 arch/powerpc/kernel/signal_32.c                    |  15 +-
 arch/powerpc/kernel/smp.c                          |   1 +
 arch/powerpc/kernel/vdso/Makefile                  |   2 +-
 arch/powerpc/kernel/watchdog.c                     |  12 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c           |  34 +-
 arch/powerpc/mm/init_64.c                          |   2 +-
 arch/powerpc/platforms/powernv/pci-sriov.c         |   6 +-
 arch/powerpc/platforms/powernv/vas-window.c        |   2 +-
 arch/powerpc/platforms/pseries/mobility.c          |   4 +-
 arch/powerpc/platforms/pseries/vas.c               |   2 +-
 arch/riscv/kernel/hibernate-asm.S                  |   1 -
 arch/riscv/kernel/hibernate.c                      |   1 -
 arch/riscv/kernel/probes/uprobes.c                 |   2 +
 arch/riscv/kernel/smpboot.c                        |   5 +-
 arch/riscv/mm/init.c                               |   4 +-
 arch/s390/kvm/diag.c                               |   8 +-
 arch/s390/kvm/kvm-s390.c                           |   4 +
 arch/s390/kvm/vsie.c                               |   6 +-
 arch/s390/mm/vmem.c                                |  14 +-
 arch/sh/drivers/dma/dma-sh.c                       |  37 +-
 arch/sh/include/mach-common/mach/highlander.h      |   2 +-
 arch/sh/include/mach-common/mach/r2d.h             |   2 +-
 arch/sh/include/mach-dreamcast/mach/sysasic.h      |   2 +-
 arch/sh/include/mach-se/mach/se7724.h              |   2 +-
 arch/sh/kernel/cpu/sh2/probe.c                     |   2 +-
 arch/sh/kernel/cpu/sh3/entry.S                     |   4 +-
 arch/sparc/kernel/nmi.c                            |  10 +-
 arch/um/Makefile                                   |   2 +-
 arch/x86/coco/tdx/tdx.c                            |  51 +-
 arch/x86/events/amd/core.c                         |   2 +-
 arch/x86/events/amd/ibs.c                          |  53 +-
 arch/x86/hyperv/ivm.c                              |   4 +
 arch/x86/include/asm/mtrr.h                        |  40 +-
 arch/x86/include/asm/perf_event.h                  |   2 +
 arch/x86/include/asm/pgtable_64.h                  |   4 +-
 arch/x86/include/asm/sev.h                         |  16 +-
 arch/x86/include/asm/x86_init.h                    |   2 +-
 arch/x86/include/uapi/asm/mtrr.h                   |   8 -
 arch/x86/kernel/cpu/mtrr/cleanup.c                 |  18 +-
 arch/x86/kernel/cpu/mtrr/generic.c                 | 124 +++-
 arch/x86/kernel/cpu/mtrr/mtrr.c                    |  73 +--
 arch/x86/kernel/cpu/mtrr/mtrr.h                    |   4 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c             |   8 +-
 arch/x86/kernel/setup.c                            |   2 +
 arch/x86/kernel/sev.c                              |  14 +-
 arch/x86/kernel/x86_init.c                         |   2 +-
 arch/x86/mm/mem_encrypt_amd.c                      |   4 +-
 arch/x86/mm/pat/set_memory.c                       |   3 +-
 arch/x86/platform/efi/efi_64.c                     |   6 +-
 arch/x86/xen/enlighten_pv.c                        |  52 ++
 block/blk-cgroup.c                                 |  20 +-
 block/blk-core.c                                   |   1 +
 block/blk-iocost.c                                 |   7 +-
 block/blk-mq-debugfs.c                             |   2 +-
 block/blk-mq-tag.c                                 |  15 +-
 block/blk-mq.c                                     |  13 +-
 block/blk-mq.h                                     |   3 +-
 block/blk-rq-qos.c                                 |  20 +-
 block/blk-throttle.c                               |   6 -
 block/blk-throttle.h                               |   9 +
 block/blk-wbt.c                                    |   2 +
 block/disk-events.c                                |   1 +
 block/genhd.c                                      |   5 +-
 block/partitions/amiga.c                           | 102 ++-
 crypto/jitterentropy.c                             |   9 +-
 drivers/accel/habanalabs/gaudi2/gaudi2.c           |   2 +-
 drivers/acpi/apei/ghes.c                           |   2 +
 drivers/base/power/domain.c                        |  15 +-
 drivers/base/property.c                            |  12 +-
 drivers/bus/fsl-mc/dprc-driver.c                   |   6 +
 drivers/bus/ti-sysc.c                              |   4 +-
 drivers/cdx/cdx.c                                  |  18 +
 drivers/char/hw_random/st-rng.c                    |  21 +-
 drivers/char/hw_random/virtio-rng.c                |  10 +-
 drivers/clk/bcm/clk-raspberrypi.c                  |   4 +-
 drivers/clk/clk-cdce925.c                          |  12 +
 drivers/clk/clk-renesas-pcie.c                     |   4 +-
 drivers/clk/clk-si5341.c                           |  38 +-
 drivers/clk/clk-versaclock5.c                      |  45 +-
 drivers/clk/clk-versaclock7.c                      |   2 +-
 drivers/clk/clk.c                                  |   2 +
 drivers/clk/imx/clk-composite-8m.c                 |  31 +
 drivers/clk/imx/clk-imx8mn.c                       |   8 +-
 drivers/clk/imx/clk-imx8mp.c                       |  24 +-
 drivers/clk/imx/clk-imx93.c                        |  15 +-
 drivers/clk/imx/clk-imxrt1050.c                    |  22 +-
 drivers/clk/imx/clk-scu.c                          |   4 +-
 drivers/clk/keystone/sci-clk.c                     |   2 +
 drivers/clk/mediatek/clk-mt8173-apmixedsys.c       |   7 +-
 drivers/clk/mediatek/clk-mtk.c                     |  13 +-
 drivers/clk/qcom/camcc-sc7180.c                    |  19 +-
 drivers/clk/qcom/dispcc-qcm2290.c                  |  12 +-
 drivers/clk/qcom/gcc-ipq5332.c                     |   6 +-
 drivers/clk/qcom/gcc-ipq6018.c                     |  34 +-
 drivers/clk/qcom/gcc-qcm2290.c                     |  62 +-
 drivers/clk/qcom/mmcc-msm8974.c                    |  23 +-
 drivers/clk/renesas/rzg2l-cpg.c                    |   6 +-
 drivers/clk/renesas/rzg2l-cpg.h                    |   3 -
 drivers/clk/tegra/clk-tegra124-emc.c               |   2 +
 drivers/clk/ti/clkctrl.c                           |   7 +
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c         |   7 +-
 drivers/clocksource/timer-cadence-ttc.c            |  19 +-
 drivers/cpufreq/intel_pstate.c                     |   2 +
 drivers/cpufreq/mediatek-cpufreq.c                 |  13 +-
 drivers/cpufreq/tegra194-cpufreq.c                 |   6 +-
 .../crypto/intel/qat/qat_common/qat_asym_algs.c    |  14 +-
 drivers/crypto/marvell/cesa/cipher.c               |   2 +-
 drivers/crypto/nx/Makefile                         |   2 +-
 drivers/crypto/nx/nx.h                             |   4 +-
 drivers/cxl/core/region.c                          | 102 +--
 drivers/cxl/cxl.h                                  |  16 +-
 drivers/dax/bus.c                                  |  61 +-
 drivers/dax/dax-private.h                          |   4 +-
 drivers/dax/kmem.c                                 |   2 +-
 drivers/extcon/extcon-usbc-tusb320.c               |  42 +-
 drivers/extcon/extcon.c                            |   8 +
 drivers/firmware/efi/libstub/efi-stub-helper.c     |   6 +-
 drivers/gpio/gpio-twl4030.c                        |  52 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c       |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  85 +--
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c             |  11 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |   4 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c           |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |  13 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  10 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |   5 +-
 .../dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c       |   3 +
 drivers/gpu/drm/amd/display/dc/core/dc.c           |   3 -
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   6 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |   3 +
 .../gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c   |  23 -
 .../gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h   |   2 -
 .../gpu/drm/amd/display/dc/dcn314/dcn314_init.c    |   2 +-
 .../amd/display/dc/dml/dcn21/display_mode_vba_21.c |   2 +-
 .../display/dc/dml/dcn32/display_rq_dlg_calc_32.c  |   2 +-
 .../display/dc/link/protocols/link_dp_capability.c |   4 +-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |  18 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |   1 +
 drivers/gpu/drm/bridge/analogix/anx7625.c          | 128 ++--
 drivers/gpu/drm/bridge/ite-it6505.c                |   3 +-
 drivers/gpu/drm/bridge/samsung-dsim.c              |  22 +-
 drivers/gpu/drm/bridge/tc358767.c                  |   4 +-
 drivers/gpu/drm/bridge/tc358768.c                  |  93 ++-
 drivers/gpu/drm/bridge/ti-sn65dsi83.c              |  20 +-
 drivers/gpu/drm/drm_gem_vram_helper.c              |   6 +-
 drivers/gpu/drm/i915/Makefile                      |   2 +
 drivers/gpu/drm/i915/display/intel_color.c         |  36 +-
 drivers/gpu/drm/i915/display/intel_crtc.c          |   2 +-
 drivers/gpu/drm/i915/display/intel_cursor.c        |   4 +-
 drivers/gpu/drm/i915/display/intel_display.c       |   2 +-
 drivers/gpu/drm/i915/display/intel_display.h       |  10 +-
 .../gpu/drm/i915/display/intel_display_device.c    | 728 +++++++++++++++++++++
 .../gpu/drm/i915/display/intel_display_device.h    |  86 +++
 drivers/gpu/drm/i915/display/intel_display_power.c |   6 +-
 .../gpu/drm/i915/display/intel_display_reg_defs.h  |  14 +-
 drivers/gpu/drm/i915/display/intel_fb_pin.c        |   2 +-
 drivers/gpu/drm/i915/display/intel_fbc.c           |   6 +-
 drivers/gpu/drm/i915/display/intel_hdcp.c          |   2 +-
 drivers/gpu/drm/i915/display/intel_hti.c           |   2 +-
 drivers/gpu/drm/i915/display/intel_psr.c           |   4 +-
 drivers/gpu/drm/i915/display/intel_psr_regs.h      |   2 +-
 drivers/gpu/drm/i915/display/skl_universal_plane.c |   2 +-
 drivers/gpu/drm/i915/display/skl_watermark.c       |   8 +-
 drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c        |  35 +
 drivers/gpu/drm/i915/gt/uc/intel_guc_slpc.c        |  40 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_slpc.h        |   1 +
 drivers/gpu/drm/i915/gt/uc/intel_guc_slpc_types.h  |   1 +
 drivers/gpu/drm/i915/i915_driver.c                 |  12 +-
 drivers/gpu/drm/i915/i915_drv.h                    |  52 +-
 drivers/gpu/drm/i915/i915_pci.c                    | 384 +----------
 drivers/gpu/drm/i915/i915_reg.h                    |  33 -
 drivers/gpu/drm/i915/intel_device_info.c           | 140 ++--
 drivers/gpu/drm/i915/intel_device_info.h           |  69 +-
 drivers/gpu/drm/i915/intel_step.c                  |   8 +-
 drivers/gpu/drm/imx/lcdc/imx-lcdc.c                |   4 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |   3 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |   3 +-
 .../drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h    |  12 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h |   8 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h |  12 +-
 .../drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h    |  12 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h |  12 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h |  10 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h |   2 +-
 .../drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h    |   2 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h |  18 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h |   4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |   5 +-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c   |  60 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |  36 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c         |   5 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c         |   5 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c    |  75 ++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h    |  31 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h            |   4 +
 drivers/gpu/drm/msm/dp/dp_display.c                |  16 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |  26 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c         |   3 +
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |   1 +
 drivers/gpu/drm/nouveau/nv50_display.h             |   4 +-
 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c    |  11 +-
 drivers/gpu/drm/panel/panel-simple.c               |   4 +-
 drivers/gpu/drm/radeon/ci_dpm.c                    |  28 +-
 drivers/gpu/drm/radeon/cypress_dpm.c               |   8 +-
 drivers/gpu/drm/radeon/ni_dpm.c                    |   8 +-
 drivers/gpu/drm/radeon/rv740_dpm.c                 |   8 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |  19 +-
 drivers/gpu/drm/vkms/vkms_composer.c               |   4 +-
 drivers/gpu/drm/vkms/vkms_drv.h                    |   4 +-
 drivers/gpu/drm/vkms/vkms_formats.c                | 131 ++--
 drivers/gpu/drm/vkms/vkms_formats.h                |   2 +-
 drivers/gpu/drm/vkms/vkms_plane.c                  |   2 +-
 drivers/hid/Kconfig                                |   2 +-
 drivers/hwmon/f71882fg.c                           |   7 +-
 drivers/hwmon/gsc-hwmon.c                          |   6 +-
 drivers/hwmon/pmbus/adm1275.c                      |  52 +-
 drivers/hwtracing/coresight/coresight-core.c       |   9 +-
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    |  27 +-
 drivers/hwtracing/ptt/hisi_ptt.c                   |  12 +-
 drivers/hwtracing/ptt/hisi_ptt.h                   |   2 +
 drivers/i2c/busses/i2c-designware-pcidrv.c         |  13 +-
 drivers/i2c/busses/i2c-nvidia-gpu.c                |   3 +
 drivers/i2c/busses/i2c-xiic.c                      |   2 +
 drivers/i3c/master/svc-i3c-master.c                |  19 +-
 drivers/iio/accel/fxls8962af-core.c                |   8 +-
 drivers/iio/adc/ad7192.c                           |   8 +-
 drivers/iio/addac/ad74413r.c                       |  11 +-
 drivers/infiniband/hw/bnxt_re/main.c               |  20 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |  40 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.h           |   2 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c         |  46 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h         |   1 +
 drivers/infiniband/hw/hfi1/ipoib_tx.c              |   4 +-
 drivers/infiniband/hw/hfi1/mmu_rb.c                | 101 +--
 drivers/infiniband/hw/hfi1/mmu_rb.h                |   3 +
 drivers/infiniband/hw/hfi1/sdma.c                  |  23 +-
 drivers/infiniband/hw/hfi1/sdma.h                  |  47 +-
 drivers/infiniband/hw/hfi1/sdma_txreq.h            |   2 +
 drivers/infiniband/hw/hfi1/user_sdma.c             | 137 ++--
 drivers/infiniband/hw/hfi1/user_sdma.h             |   1 -
 drivers/infiniband/hw/hfi1/vnic_sdma.c             |   4 +-
 drivers/infiniband/hw/hns/hns_roce_hem.c           |   7 +-
 drivers/infiniband/hw/irdma/uk.c                   |  10 +-
 drivers/infiniband/sw/rxe/rxe_mw.c                 |  17 +-
 drivers/input/Kconfig                              |   2 +-
 drivers/input/misc/adxl34x.c                       |   3 +-
 drivers/input/misc/drv260x.c                       |   1 +
 drivers/input/misc/pm8941-pwrkey.c                 |  19 +-
 drivers/input/tests/input_test.c                   |   6 +-
 drivers/input/touchscreen/ads7846.c                | 114 ++--
 drivers/input/touchscreen/cyttsp4_core.c           |   3 +-
 drivers/interconnect/qcom/icc-rpm.c                |  12 +-
 drivers/interconnect/qcom/icc-rpm.h                |   4 +-
 drivers/iommu/iommufd/device.c                     |   2 +-
 drivers/iommu/iommufd/io_pagetable.c               |  14 +-
 drivers/iommu/virtio-iommu.c                       |  57 +-
 drivers/irqchip/irq-jcore-aic.c                    |   7 +
 drivers/irqchip/irq-loongson-eiointc.c             |   2 +-
 drivers/irqchip/irq-loongson-liointc.c             |  12 +-
 drivers/irqchip/irq-loongson-pch-pic.c             |  10 +-
 drivers/irqchip/irq-stm32-exti.c                   |  12 +
 drivers/leds/trigger/ledtrig-netdev.c              |   3 +
 drivers/mailbox/ti-msgmgr.c                        |  12 +-
 drivers/md/bcache/btree.c                          |  25 +-
 drivers/md/bcache/btree.h                          |   1 +
 drivers/md/bcache/super.c                          |   4 +-
 drivers/md/bcache/writeback.c                      |  10 +
 drivers/md/md-bitmap.c                             |  21 +-
 drivers/md/md-bitmap.h                             |   7 +
 drivers/md/md.c                                    |   9 +-
 drivers/md/raid1-10.c                              |  42 ++
 drivers/md/raid1.c                                 |  25 +-
 drivers/md/raid10.c                                |  75 +--
 drivers/media/cec/i2c/Kconfig                      |   1 +
 drivers/media/common/saa7146/saa7146_core.c        |   6 +-
 drivers/media/i2c/Kconfig                          |   1 +
 drivers/media/i2c/hi846.c                          |   3 +-
 drivers/media/i2c/imx296.c                         |   4 +-
 drivers/media/i2c/st-mipid02.c                     |   9 +-
 drivers/media/platform/amphion/vdec.c              |   7 +-
 drivers/media/platform/amphion/venc.c              |   4 +-
 drivers/media/platform/amphion/vpu_malone.c        |  12 +
 drivers/media/platform/amphion/vpu_v4l2.c          |   5 +-
 drivers/media/platform/amphion/vpu_v4l2.h          |   2 +-
 .../platform/mediatek/vcodec/vdec_msg_queue.c      |  33 +-
 .../platform/mediatek/vcodec/vdec_msg_queue.h      |  16 +-
 drivers/media/platform/qcom/venus/helpers.c        |   4 +-
 drivers/media/platform/renesas/rcar_fdp1.c         |   5 +
 drivers/media/usb/dvb-usb-v2/az6007.c              |   3 +-
 drivers/media/usb/siano/smsusb.c                   |   3 +-
 drivers/memory/brcmstb_dpfe.c                      |   4 +-
 drivers/memstick/host/r592.c                       |   4 +-
 drivers/mfd/intel-lpss-acpi.c                      |   3 +
 drivers/mfd/rt5033.c                               |   3 -
 drivers/mfd/stmfx.c                                |   7 +-
 drivers/mfd/stmpe.c                                |   4 +-
 drivers/mfd/tps65010.c                             |  14 +-
 drivers/mfd/wcd934x.c                              |   9 +-
 drivers/misc/fastrpc.c                             |   3 +
 drivers/misc/lkdtm/core.c                          |   2 +-
 drivers/mmc/core/block.c                           |   6 +
 drivers/mmc/core/card.h                            |  30 +-
 drivers/mmc/core/quirks.h                          |  27 +
 drivers/mmc/core/sd.c                              |   2 +-
 drivers/mmc/host/mmci.c                            |   1 +
 drivers/mmc/host/mtk-sd.c                          |   2 +-
 drivers/mmc/host/omap.c                            |  46 +-
 drivers/mmc/host/sdhci.c                           |   4 +-
 drivers/net/bonding/bond_main.c                    |   2 +-
 drivers/net/can/kvaser_pciefd.c                    |  39 +-
 drivers/net/dsa/ocelot/felix.c                     |  12 +
 drivers/net/dsa/sja1105/sja1105.h                  |   2 +-
 drivers/net/dsa/sja1105/sja1105_main.c             |  14 +-
 drivers/net/dsa/sja1105/sja1105_ptp.c              |  48 +-
 drivers/net/dsa/vitesse-vsc73xx-core.c             |   6 +-
 drivers/net/ethernet/broadcom/tg3.c                |   1 +
 drivers/net/ethernet/ibm/ibmvnic.c                 |   9 +-
 drivers/net/ethernet/intel/ice/ice.h               |   7 +
 drivers/net/ethernet/intel/ice/ice_main.c          |  29 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c           |  12 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h           |   4 +-
 drivers/net/ethernet/intel/igc/igc.h               |  36 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |  45 +-
 drivers/net/ethernet/intel/igc/igc_ptp.c           | 142 ++--
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c    |  33 +-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.h    |   2 +
 .../ethernet/marvell/octeontx2/af/lmac_common.h    |   3 +
 drivers/net/ethernet/marvell/octeontx2/af/rpm.c    |  32 +-
 drivers/net/ethernet/marvell/octeontx2/af/rpm.h    |   5 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |   1 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |  12 +
 .../net/ethernet/marvell/octeontx2/af/rvu_cgx.c    |  22 +-
 drivers/net/ethernet/mellanox/mlxsw/minimal.c      |   1 +
 drivers/net/ethernet/mscc/ocelot.c                 |   1 -
 drivers/net/ethernet/mscc/ocelot_ptp.c             |  66 +-
 drivers/net/ethernet/sfc/ef10.c                    |  13 +-
 drivers/net/ethernet/sfc/efx_devlink.c             |   3 +
 drivers/net/ethernet/sfc/tc.c                      |  32 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   6 -
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |  10 +-
 drivers/net/gtp.c                                  |   2 +
 drivers/net/ipvlan/ipvlan_core.c                   |   9 +-
 drivers/net/ppp/pptp.c                             |  31 +-
 drivers/net/wireguard/netlink.c                    |  14 +-
 drivers/net/wireguard/queueing.c                   |   1 +
 drivers/net/wireguard/queueing.h                   |  25 +-
 drivers/net/wireguard/receive.c                    |   2 +-
 drivers/net/wireguard/send.c                       |   2 +-
 drivers/net/wireless/ath/ath10k/core.c             |  12 +-
 drivers/net/wireless/ath/ath10k/core.h             |   3 +
 drivers/net/wireless/ath/ath10k/mac.c              |  13 +-
 drivers/net/wireless/ath/ath11k/ahb.c              |   1 +
 drivers/net/wireless/ath/ath11k/core.c             |   1 +
 drivers/net/wireless/ath/ath11k/hw.c               |   2 +-
 drivers/net/wireless/ath/ath11k/qmi.c              |   5 +
 drivers/net/wireless/ath/ath9k/ar9003_hw.c         |  27 +-
 drivers/net/wireless/ath/ath9k/htc_hst.c           |   8 +-
 drivers/net/wireless/ath/ath9k/main.c              |  11 +-
 drivers/net/wireless/ath/ath9k/wmi.c               |   4 +
 drivers/net/wireless/atmel/atmel_cs.c              |  13 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rs.h     |   2 +
 drivers/net/wireless/intel/iwlwifi/fw/dump.c       |   7 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |   2 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |  10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c     |  58 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |   9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |   2 +
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |   5 +-
 drivers/net/wireless/intersil/orinoco/orinoco_cs.c |  13 +-
 .../net/wireless/intersil/orinoco/spectrum_cs.c    |  13 +-
 drivers/net/wireless/legacy/ray_cs.c               |  16 +-
 drivers/net/wireless/legacy/wl3501_cs.c            |  16 +-
 drivers/net/wireless/marvell/mwifiex/scan.c        |   6 +-
 drivers/net/wireless/mediatek/mt76/mt7921/dma.c    |   4 -
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    |   8 -
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    |   8 +
 drivers/net/wireless/microchip/wilc1000/hif.c      |   8 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c      |   4 +-
 drivers/net/wireless/realtek/rtw88/usb.c           |   2 +-
 drivers/net/wireless/realtek/rtw89/core.c          |   2 +-
 drivers/net/wireless/rsi/rsi_91x_sdio.c            |   9 +-
 drivers/nvme/host/core.c                           |  16 +-
 drivers/nvmem/imx-ocotp.c                          |   8 +-
 drivers/nvmem/rmem.c                               |   1 +
 drivers/nvmem/sunplus-ocotp.c                      |   9 +-
 drivers/pci/controller/cadence/pcie-cadence-host.c |  27 +
 drivers/pci/controller/dwc/pcie-qcom.c             |  11 +-
 drivers/pci/controller/pci-ftpci100.c              |  14 +-
 drivers/pci/controller/vmd.c                       |  11 +-
 drivers/pci/endpoint/functions/Kconfig             |   2 +-
 drivers/pci/endpoint/functions/pci-epf-test.c      |   2 +-
 drivers/pci/hotplug/pciehp_ctrl.c                  |   8 +
 drivers/pci/pcie/aspm.c                            |  21 +-
 drivers/perf/apple_m1_cpu_pmu.c                    |  30 +-
 drivers/perf/arm-cmn.c                             |   7 +-
 drivers/perf/arm_cspmu/arm_cspmu.c                 |  11 +-
 drivers/perf/arm_pmu.c                             |   2 +
 drivers/perf/hisilicon/hisi_pcie_pmu.c             |   2 +-
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c          |   8 +-
 drivers/phy/tegra/xusb.c                           |   4 +
 drivers/pinctrl/bcm/pinctrl-bcm2835.c              |   6 +-
 drivers/pinctrl/freescale/pinctrl-scu.c            |   3 +-
 drivers/pinctrl/intel/pinctrl-cherryview.c         |  15 +-
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c          |   2 +
 drivers/pinctrl/pinctrl-at91-pio4.c                |   2 +
 drivers/pinctrl/pinctrl-at91.c                     |   8 +-
 drivers/pinctrl/pinctrl-microchip-sgpio.c          |   3 +
 drivers/pinctrl/sunplus/sppctl.c                   |  23 +-
 drivers/pinctrl/tegra/pinctrl-tegra.c              |  15 +-
 drivers/pinctrl/tegra/pinctrl-tegra.h              |   3 +-
 drivers/pinctrl/tegra/pinctrl-tegra114.c           |   7 +-
 drivers/pinctrl/tegra/pinctrl-tegra124.c           |   7 +-
 drivers/pinctrl/tegra/pinctrl-tegra194.c           |   7 +-
 drivers/pinctrl/tegra/pinctrl-tegra20.c            |   7 +-
 drivers/pinctrl/tegra/pinctrl-tegra210.c           |   7 +-
 drivers/pinctrl/tegra/pinctrl-tegra30.c            |   7 +-
 drivers/platform/x86/dell/dell-rbtn.c              |  13 +-
 drivers/platform/x86/intel/pmc/core.c              |  15 +-
 drivers/platform/x86/intel/pmc/core.h              |  31 +-
 drivers/platform/x86/intel/pmc/mtl.c               | 475 +++++++++++++-
 drivers/platform/x86/lenovo-yogabook-wmi.c         |  34 +-
 drivers/platform/x86/think-lmi.c                   |  20 +-
 drivers/platform/x86/thinkpad_acpi.c               |   6 +-
 drivers/power/supply/rt9467-charger.c              |   2 +-
 drivers/powercap/Kconfig                           |   4 +-
 drivers/powercap/intel_rapl_msr.c                  |  17 +-
 drivers/pwm/pwm-ab8500.c                           |   2 +-
 drivers/pwm/pwm-imx-tpm.c                          |   7 +
 drivers/pwm/pwm-mtk-disp.c                         |  13 +-
 drivers/pwm/sysfs.c                                |  17 +
 drivers/regulator/core.c                           |  30 +-
 drivers/regulator/rk808-regulator.c                |   1 +
 drivers/regulator/tps65219-regulator.c             |   6 +-
 drivers/rtc/rtc-st-lpc.c                           |   2 +-
 drivers/s390/net/qeth_l3_sys.c                     |   2 +-
 drivers/scsi/3w-xxxx.c                             |   4 +-
 drivers/scsi/lpfc/lpfc_els.c                       |  14 +-
 drivers/scsi/qedf/qedf_main.c                      |   3 +-
 drivers/soc/amlogic/meson-secure-pwrc.c            |   2 +-
 drivers/soc/fsl/qe/Kconfig                         |   1 +
 drivers/soc/mediatek/mtk-svs.c                     |   4 +-
 drivers/soc/qcom/qcom-geni-se.c                    |  67 +-
 drivers/soc/xilinx/xlnx_event_manager.c            |   6 +-
 drivers/soundwire/debugfs.c                        |   3 +-
 drivers/soundwire/qcom.c                           | 179 ++---
 drivers/spi/spi-bcm-qspi.c                         |  10 +-
 drivers/spi/spi-dw-core.c                          |   5 +-
 drivers/spi/spi-geni-qcom.c                        | 111 ++--
 drivers/staging/media/atomisp/i2c/atomisp-gc0310.c |   2 +-
 drivers/staging/media/atomisp/i2c/atomisp-ov2680.c |   8 +-
 drivers/staging/media/atomisp/i2c/ov2680.h         |   1 +
 .../media/atomisp/pci/atomisp_gmin_platform.c      |   2 +-
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |   4 +-
 drivers/thermal/qcom/tsens-v0_1.c                  |  56 +-
 drivers/thermal/qcom/tsens.c                       |  19 +-
 drivers/thermal/qcom/tsens.h                       |   6 +-
 drivers/thermal/qoriq_thermal.c                    |  30 +-
 drivers/thermal/sun8i_thermal.c                    |  55 +-
 drivers/tty/serial/8250/8250_omap.c                |  25 +-
 drivers/tty/serial/fsl_lpuart.c                    |   1 +
 drivers/tty/serial/serial_core.c                   |  10 +-
 drivers/ufs/core/ufshcd-priv.h                     |   3 -
 drivers/ufs/core/ufshcd.c                          |  21 +-
 drivers/usb/core/devio.c                           |   2 +
 drivers/usb/core/hcd-pci.c                         |  24 +-
 drivers/usb/dwc2/platform.c                        |  16 +-
 drivers/usb/dwc3/dwc3-meson-g12a.c                 |   5 +-
 drivers/usb/dwc3/dwc3-qcom.c                       |  17 +-
 drivers/usb/dwc3/gadget.c                          |   4 +-
 drivers/usb/gadget/function/u_serial.c             |  13 +-
 drivers/usb/host/ehci-pci.c                        |   3 +-
 drivers/usb/host/ohci-pci.c                        |   8 +-
 drivers/usb/host/uhci-pci.c                        |   7 +-
 drivers/usb/host/xhci-histb.c                      |   2 +-
 drivers/usb/host/xhci-pci.c                        |   4 +-
 drivers/usb/host/xhci-plat.c                       |   4 +-
 drivers/usb/host/xhci-tegra.c                      |   2 +-
 drivers/usb/host/xhci.c                            |   5 +-
 drivers/usb/host/xhci.h                            |   2 +-
 drivers/usb/musb/musb_core.c                       |   1 -
 drivers/usb/musb/musb_core.h                       |   2 -
 drivers/usb/musb/tusb6010.c                        |  53 +-
 drivers/usb/phy/phy-tahvo.c                        |   2 +-
 drivers/usb/serial/option.c                        |   4 +
 drivers/usb/typec/ucsi/psy.c                       |  14 +
 drivers/vdpa/vdpa_user/vduse_dev.c                 |   6 +-
 drivers/vfio/mdev/mdev_core.c                      |  23 +-
 drivers/video/fbdev/omap/lcd_mipid.c               |  16 +-
 drivers/virt/coco/sev-guest/Kconfig                |   1 +
 drivers/virtio/virtio_vdpa.c                       |   4 +-
 drivers/w1/slaves/w1_therm.c                       |  31 +-
 drivers/w1/w1.c                                    |   4 +-
 fs/afs/write.c                                     |   8 +-
 fs/btrfs/bio.c                                     |   3 +-
 fs/btrfs/block-group.c                             |  41 +-
 fs/btrfs/ctree.c                                   |  49 +-
 fs/btrfs/disk-io.c                                 |   7 +-
 fs/btrfs/extent_io.c                               | 333 ++++------
 fs/btrfs/extent_io.h                               |   5 +-
 fs/btrfs/free-space-tree.c                         |   3 +
 fs/btrfs/inode.c                                   |  92 ++-
 fs/btrfs/locking.c                                 |   5 +-
 fs/btrfs/qgroup.c                                  |   2 +
 fs/btrfs/tree-mod-log.c                            | 115 +++-
 fs/erofs/zdata.c                                   |  72 +-
 fs/erofs/zmap.c                                    |   6 +-
 fs/ext4/namei.c                                    |  17 +-
 fs/f2fs/checkpoint.c                               |   7 +-
 fs/f2fs/compress.c                                 |  11 +-
 fs/f2fs/data.c                                     |  11 +-
 fs/f2fs/f2fs.h                                     |  23 +-
 fs/f2fs/file.c                                     |  13 +-
 fs/f2fs/gc.c                                       |  27 +-
 fs/f2fs/namei.c                                    |  16 +-
 fs/f2fs/node.c                                     |   7 +-
 fs/f2fs/super.c                                    | 160 ++++-
 fs/fs_context.c                                    |   3 +-
 fs/gfs2/file.c                                     |   2 +-
 fs/inode.c                                         |  42 ++
 fs/internal.h                                      |   2 +
 fs/jffs2/build.c                                   |   5 +-
 fs/jffs2/xattr.c                                   |  13 +-
 fs/jffs2/xattr.h                                   |   4 +-
 fs/kernfs/dir.c                                    |   2 +
 fs/lockd/svc.c                                     |   1 -
 fs/namei.c                                         |  25 +-
 fs/nfs/nfs42xattr.c                                |  79 ++-
 fs/nfs/nfs4proc.c                                  |   1 +
 fs/nfsd/cache.h                                    |   2 +
 fs/nfsd/nfs4xdr.c                                  |   2 +-
 fs/nfsd/nfscache.c                                 |  25 +-
 fs/nfsd/nfsctl.c                                   |  10 +-
 fs/nfsd/vfs.c                                      |   4 +-
 fs/notify/fanotify/fanotify_user.c                 |  14 +
 fs/ntfs3/xattr.c                                   |   3 +
 fs/ocfs2/cluster/tcp.c                             |  23 +-
 fs/overlayfs/copy_up.c                             |   2 +
 fs/overlayfs/dir.c                                 |   3 +-
 fs/overlayfs/export.c                              |   3 +-
 fs/overlayfs/inode.c                               |  17 +-
 fs/overlayfs/namei.c                               |   3 +-
 fs/overlayfs/overlayfs.h                           |   8 +-
 fs/overlayfs/super.c                               |   2 +-
 fs/overlayfs/util.c                                |  31 +-
 fs/pstore/ram_core.c                               |   2 +
 fs/ramfs/inode.c                                   |   2 +-
 fs/reiserfs/xattr_security.c                       |   1 +
 fs/smb/client/cifs_debug.c                         |  16 +-
 fs/smb/client/cifsglob.h                           |  10 +-
 fs/smb/client/cifsproto.h                          |   2 +-
 fs/smb/client/connect.c                            |  70 +-
 fs/smb/client/dfs.c                                |  55 +-
 fs/smb/client/dfs.h                                |  19 +-
 fs/smb/client/dfs_cache.c                          |   8 +-
 fs/smb/client/file.c                               |  25 +-
 fs/smb/client/misc.c                               |  38 +-
 fs/smb/client/smb2inode.c                          |   9 +-
 fs/smb/client/smb2ops.c                            |  19 +-
 fs/smb/client/transport.c                          |  20 +-
 fs/smb/server/smb_common.c                         |   2 +-
 fs/splice.c                                        |   1 -
 fs/udf/namei.c                                     |  14 +-
 fs/verity/enable.c                                 |  19 +-
 fs/verity/fsverity_private.h                       |  13 +-
 fs/verity/hash_algs.c                              | 131 +---
 fs/verity/verify.c                                 | 113 ++--
 include/drm/bridge/samsung-dsim.h                  |   3 +
 include/drm/drm_fixed.h                            |   6 +
 include/linux/bitmap.h                             |   8 +-
 include/linux/blk-mq.h                             |   3 +-
 include/linux/blkdev.h                             |   3 +-
 include/linux/blktrace_api.h                       |   6 +-
 include/linux/bpf.h                                |   1 -
 include/linux/bpf_verifier.h                       |  52 +-
 include/linux/can/length.h                         |  14 +-
 include/linux/compiler_attributes.h                |  12 +
 include/linux/dsa/sja1105.h                        |   4 -
 include/linux/ieee80211.h                          |   6 +-
 include/linux/mfd/tps65010.h                       |  11 +-
 include/linux/mfd/twl.h                            |   3 -
 include/linux/mm_types.h                           |  23 +-
 include/linux/mmc/card.h                           |   1 +
 include/linux/netdevice.h                          |   9 +
 include/linux/nmi.h                                |  35 +-
 include/linux/pci.h                                |   1 +
 include/linux/perf/arm_pmu.h                       |   2 +
 include/linux/pipe_fs_i.h                          |   4 -
 include/linux/platform_data/lcd-mipid.h            |   2 -
 include/linux/platform_data/mmc-omap.h             |   2 -
 include/linux/ramfs.h                              |   1 +
 include/linux/sh_intc.h                            |   6 +-
 include/linux/soc/qcom/geni-se.h                   |   4 +
 include/linux/spi/ads7846.h                        |   2 -
 include/linux/usb/hcd.h                            |   2 +-
 include/linux/usb/musb.h                           |  13 -
 include/linux/watch_queue.h                        |   3 +-
 include/net/bluetooth/mgmt.h                       |   1 +
 include/net/dsa.h                                  |  12 +-
 include/net/mac80211.h                             |  44 +-
 include/net/regulatory.h                           |  13 +-
 include/net/sock.h                                 |   1 +
 include/soc/mscc/ocelot.h                          |  10 +-
 include/trace/events/net.h                         |   3 +-
 include/trace/events/timer.h                       |   6 +-
 include/uapi/linux/affs_hardblocks.h               |  68 +-
 include/uapi/linux/auto_dev-ioctl.h                |   2 +-
 include/uapi/linux/videodev2.h                     |   6 +-
 include/ufs/ufshcd.h                               |   1 -
 init/Makefile                                      |   1 +
 init/main.c                                        |   3 +-
 io_uring/io_uring.c                                |  35 +-
 kernel/bpf/btf.c                                   |   6 +-
 kernel/bpf/cgroup.c                                |  15 +
 kernel/bpf/helpers.c                               |  12 +-
 kernel/bpf/trampoline.c                            |  32 +-
 kernel/bpf/verifier.c                              | 716 +++++++++++++++-----
 kernel/kcsan/core.c                                |   2 +
 kernel/kexec_core.c                                |   5 +-
 kernel/rcu/rcu.h                                   |   6 +
 kernel/rcu/rcuscale.c                              | 199 +++---
 kernel/rcu/tasks.h                                 |   7 +-
 kernel/rcu/tree.c                                  |  23 +-
 kernel/sched/fair.c                                |  18 +
 kernel/sched/sched.h                               |  22 +
 kernel/time/posix-timers.c                         |  43 +-
 kernel/time/tick-sched.c                           |   2 +-
 kernel/watch_queue.c                               |  12 +-
 kernel/watchdog.c                                  | 302 ++++++---
 kernel/watchdog_hld.c                              |  48 +-
 lib/bitmap.c                                       |   2 +-
 lib/dhry_1.c                                       |  11 +-
 lib/test_firmware.c                                |  12 +-
 lib/ts_bm.c                                        |   4 +-
 mm/damon/ops-common.c                              |  16 +-
 mm/damon/ops-common.h                              |   4 +-
 mm/damon/paddr.c                                   |   4 +-
 mm/damon/vaddr.c                                   |   4 +-
 mm/filemap.c                                       |   4 +-
 mm/page-writeback.c                                |   8 +-
 mm/shmem.c                                         |   2 +-
 mm/vmscan.c                                        |  13 +-
 net/bluetooth/hci_conn.c                           |  47 +-
 net/bluetooth/hci_event.c                          |  15 +-
 net/bluetooth/hci_sync.c                           |  28 +-
 net/bridge/br_if.c                                 |   5 +-
 net/core/filter.c                                  | 126 +++-
 net/core/rtnetlink.c                               | 104 +--
 net/core/sock.c                                    |  17 +-
 net/dsa/dsa.c                                      |   2 +-
 net/dsa/slave.c                                    |  84 ++-
 net/dsa/switch.c                                   |   4 +-
 net/dsa/switch.h                                   |   3 +
 net/dsa/tag_sja1105.c                              |  90 +--
 net/handshake/handshake.h                          |   1 +
 net/handshake/request.c                            |   4 +
 net/ipv4/tcp_input.c                               |  12 +-
 net/mac80211/debugfs_netdev.c                      |   2 +-
 net/mac80211/eht.c                                 |   5 +-
 net/mac80211/he.c                                  |   3 +-
 net/mac80211/mlme.c                                |  30 +-
 net/mac80211/sta_info.c                            |   2 +
 net/mac80211/util.c                                |  15 +-
 net/netfilter/ipvs/Kconfig                         |  27 +-
 net/netfilter/ipvs/ip_vs_conn.c                    |   4 +-
 net/netfilter/nf_conntrack_helper.c                |   4 +
 net/netfilter/nf_conntrack_proto_dccp.c            |  52 +-
 net/netfilter/nf_conntrack_sip.c                   |   2 +-
 net/netfilter/nf_tables_api.c                      |  17 +-
 net/netfilter/nft_byteorder.c                      |  14 +-
 net/netlink/af_netlink.c                           |   5 +-
 net/netlink/diag.c                                 |   7 +-
 net/nfc/llcp.h                                     |   1 -
 net/nfc/llcp_commands.c                            |  15 +-
 net/nfc/llcp_core.c                                |  49 +-
 net/nfc/llcp_sock.c                                |  18 +-
 net/nfc/netlink.c                                  |  20 +-
 net/nfc/nfc.h                                      |   1 +
 net/sched/act_ipt.c                                |  70 +-
 net/sched/act_pedit.c                              |   1 +
 net/sched/sch_netem.c                              |  59 +-
 net/sctp/socket.c                                  |  22 +-
 net/sunrpc/svcsock.c                               |  23 +-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c            |  12 +-
 net/wireless/core.c                                |  16 -
 net/wireless/reg.c                                 |  16 +-
 net/wireless/scan.c                                | 367 ++++-------
 net/wireless/util.c                                |   2 +
 net/xdp/xsk.c                                      |   5 +
 samples/bpf/tcp_basertt_kern.c                     |   2 +-
 samples/bpf/xdp1_kern.c                            |   2 +-
 samples/bpf/xdp2_kern.c                            |   2 +-
 scripts/Makefile.clang                             |   3 +-
 scripts/Makefile.compiler                          |   4 +-
 scripts/Makefile.modfinal                          |   2 +-
 scripts/Makefile.vmlinux                           |   1 +
 scripts/mksysmap                                   |   4 +-
 scripts/mod/modpost.c                              |  86 +--
 scripts/package/builddeb                           |  14 +-
 security/apparmor/policy.c                         |  13 +
 security/apparmor/policy_compat.c                  |  20 +-
 security/apparmor/policy_unpack.c                  | 100 +--
 security/integrity/evm/evm_crypto.c                |   2 +-
 security/integrity/evm/evm_main.c                  |   4 +-
 security/integrity/iint.c                          |  15 +-
 security/integrity/ima/ima_modsig.c                |   3 +
 security/integrity/ima/ima_policy.c                |   3 +-
 sound/core/jack.c                                  |  15 +-
 sound/core/pcm_memory.c                            |  44 +-
 sound/pci/ac97/ac97_codec.c                        |   4 +-
 sound/pci/hda/patch_realtek.c                      |   7 +-
 sound/soc/amd/acp/acp-pdm.c                        |   2 +-
 sound/soc/codecs/es8316.c                          |  23 +-
 sound/soc/fsl/imx-audmix.c                         |   9 +
 sound/soc/intel/boards/sof_sdw.c                   |  18 +-
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c         |  13 +-
 tools/bpf/bpftool/feature.c                        |  24 +-
 tools/bpf/resolve_btfids/Makefile                  |   4 +-
 tools/include/nolibc/stdint.h                      |  10 +-
 tools/lib/bpf/bpf_helpers.h                        |  15 +-
 tools/lib/bpf/btf_dump.c                           |  22 +-
 tools/perf/arch/x86/util/Build                     |   1 +
 tools/perf/arch/x86/util/env.c                     |  19 +
 tools/perf/arch/x86/util/env.h                     |   7 +
 tools/perf/arch/x86/util/evsel.c                   |  16 +-
 tools/perf/arch/x86/util/mem-events.c              |  19 +-
 tools/perf/builtin-bench.c                         |   2 +
 tools/perf/builtin-script.c                        |  16 +-
 tools/perf/builtin-stat.c                          |   2 +
 tools/perf/tests/shell/test_task_analyzer.sh       |  26 +-
 tools/perf/util/bpf_skel/lock_contention.bpf.c     |   2 -
 tools/perf/util/bpf_skel/vmlinux.h                 |  10 +
 tools/perf/util/dwarf-aux.c                        |   2 +-
 tools/perf/util/evsel.h                            |  24 +-
 tools/perf/util/evsel_fprintf.c                    |   1 +
 tools/perf/util/metricgroup.c                      |   2 +-
 tools/testing/cxl/test/mem.c                       |   4 +-
 tools/testing/kunit/kunit_kernel.py                |   6 +-
 tools/testing/kunit/mypy.ini                       |   6 +
 tools/testing/kunit/run_checks.py                  |   2 +-
 tools/testing/selftests/bpf/Makefile               |   3 +-
 tools/testing/selftests/bpf/prog_tests/check_mtu.c |   2 +-
 .../testing/selftests/bpf/progs/refcounted_kptr.c  |   2 +
 .../selftests/bpf/progs/refcounted_kptr_fail.c     |   4 +-
 tools/testing/selftests/bpf/test_verifier.c        |  24 +-
 tools/testing/selftests/bpf/verifier/precise.c     | 106 +--
 tools/testing/selftests/cgroup/test_memcontrol.c   |   4 +-
 tools/testing/selftests/ftrace/ftracetest          |   2 +-
 tools/testing/selftests/net/rtnetlink.sh           |   1 +
 tools/testing/selftests/nolibc/nolibc-test.c       |   6 +-
 .../rcutorture/configs/rcu/BUSTED-BOOST.boot       |   2 +-
 .../selftests/rcutorture/configs/rcu/TREE03.boot   |   2 +-
 .../selftests/vDSO/vdso_test_clock_getres.c        |   4 +-
 tools/testing/selftests/wireguard/netns.sh         |  30 +-
 tools/tracing/rtla/src/osnoise_top.c               |   8 +-
 tools/virtio/Makefile                              |  13 +-
 877 files changed, 10447 insertions(+), 6356 deletions(-)


