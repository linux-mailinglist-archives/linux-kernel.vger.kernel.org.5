Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9E0761153
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbjGYKt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjGYKtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:49:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29C719A0;
        Tue, 25 Jul 2023 03:49:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 367D06167F;
        Tue, 25 Jul 2023 10:49:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E64C433C8;
        Tue, 25 Jul 2023 10:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282185;
        bh=wtdvrcB54WiG7Wkt51IlCLA2C9qV6h3u5J65yBFyuUU=;
        h=From:To:Cc:Subject:Date:From;
        b=zxJE3otkC8Z0UYnPP+763DcJQVZqKaVfquMKamZQSwC3hNl+uSJ+ZznlivLVOMPfE
         xbWdXvjneHETm3ku/k7MzxFjfFbUexoeQT3LnnVgUiCRYDn8cNctBvJe2XZKLb5jtm
         FwDTgi+lAqkIV6NiX9Xxgw0/Jy8xnzj9wPQDXv8U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 6.4 000/227] 6.4.7-rc1 review
Date:   Tue, 25 Jul 2023 12:42:47 +0200
Message-ID: <20230725104514.821564989@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.7-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.4.7-rc1
X-KernelTest-Deadline: 2023-07-27T10:45+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 6.4.7 release.
There are 227 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 27 Jul 2023 10:44:26 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.7-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.4.7-rc1

Wayne Lin <wayne.lin@amd.com>
    drm/amd/display: Add polling method to handle MST reply packet

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amd/display: Clean up errors & warnings in amdgpu_dm.c

Yu Kuai <yukuai3@huawei.com>
    scsi: sg: Fix checking return value of blk_get_queue()

Yu Kuai <yukuai3@huawei.com>
    scsi/sg: don't grab scsi host module reference

Abe Kohandel <abe.kohandel@intel.com>
    spi: dw: Remove misleading comment for Mount Evans SoC

Yunxiang Li <Yunxiang.Li@amd.com>
    drm/ttm: fix bulk_move corruption when adding a entry

Mohamed Khalfella <mkhalfella@purestorage.com>
    tracing/histograms: Return an error if we fail to add histogram to hist_vars list

Miguel Ojeda <ojeda@kernel.org>
    kbuild: rust: avoid creating temporary files

Zhang Yi <yi.zhang@huawei.com>
    jbd2: recheck chechpointing non-dirty buffer

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: phy: prevent stale pointer dereference in phy_init()

Eric Dumazet <edumazet@google.com>
    tcp: annotate data-races around fastopenq.max_qlen

Eric Dumazet <edumazet@google.com>
    tcp: annotate data-races around icsk->icsk_user_timeout

Eric Dumazet <edumazet@google.com>
    tcp: annotate data-races around tp->notsent_lowat

Eric Dumazet <edumazet@google.com>
    tcp: annotate data-races around rskq_defer_accept

Eric Dumazet <edumazet@google.com>
    tcp: annotate data-races around tp->linger2

Eric Dumazet <edumazet@google.com>
    tcp: annotate data-races around icsk->icsk_syn_retries

Eric Dumazet <edumazet@google.com>
    tcp: annotate data-races around tp->keepalive_probes

Eric Dumazet <edumazet@google.com>
    tcp: annotate data-races around tp->keepalive_intvl

Eric Dumazet <edumazet@google.com>
    tcp: annotate data-races around tp->keepalive_time

Eric Dumazet <edumazet@google.com>
    tcp: annotate data-races around tp->tsoffset

Eric Dumazet <edumazet@google.com>
    tcp: annotate data-races around tp->tcp_tx_delay

Tomasz Moń <tomasz.mon@nordicsemi.no>
    Bluetooth: btusb: Fix bluetooth on Intel Macbook 2014

Pauli Virtanen <pav@iki.fi>
    Bluetooth: SCO: fix sco_conn related locking and validity issues

Siddh Raman Pant <code@siddh.me>
    Bluetooth: hci_conn: return ERR_PTR instead of NULL when there is no link

Douglas Anderson <dianders@chromium.org>
    Bluetooth: hci_sync: Avoid use-after-free in dbg for hci_remove_adv_monitor()

Pauli Virtanen <pav@iki.fi>
    Bluetooth: ISO: fix iso_conn related locking and validity issues

Pauli Virtanen <pav@iki.fi>
    Bluetooth: hci_event: call disconnect callback before deleting conn

Pauli Virtanen <pav@iki.fi>
    Bluetooth: use RCU for hci_conn_params and iterate safely in hci_sync

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: skip bound chain on rule flush

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: skip bound chain in netns release path

Florian Westphal <fw@strlen.de>
    netfilter: nft_set_pipapo: fix improper element removal

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: can't schedule in nft_chain_validate

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: fix spurious set element insertion failure

Vitaly Rodionov <vitalyr@opensource.cirrus.com>
    ALSA: hda/realtek: Fix generic fixup definition for cs35l41 amp

Kuniyuki Iwashima <kuniyu@amazon.com>
    llc: Don't drop packet from non-root netns.

Zhang Shurong <zhang_shurong@foxmail.com>
    fbdev: au1200fb: Fix missing IRQ check in au1200fb_drv_probe

Daniel Golle <daniel@makrotopia.org>
    net: ethernet: mtk_eth_soc: always mtk_get_ib1_pkt_type

Kuniyuki Iwashima <kuniyu@amazon.com>
    Revert "tcp: avoid the lookup process failing to get sk in ehash table"

Yuanjun Gong <ruc_gongyuanjun@163.com>
    net:ipv6: check return value of pskb_trim()

Wang Ming <machel@vivo.com>
    net: ipv4: Use kfree_sensitive instead of kfree

Eric Dumazet <edumazet@google.com>
    tcp: annotate data-races around tcp_rsk(req)->ts_recent

Eric Dumazet <edumazet@google.com>
    tcp: annotate data-races around tcp_rsk(req)->txhash

Antoine Tenart <atenart@kernel.org>
    net: ipv4: use consistent txhash in TIME_WAIT and SYN_RECV

Florian Kauer <florian.kauer@linutronix.de>
    igc: Prevent garbled TX queue with XDP ZEROCOPY

Kurt Kanzenbach <kurt@linutronix.de>
    igc: Avoid transmit queue timeout for XDP

Alexander Duyck <alexanderduyck@fb.com>
    bpf, arm64: Fix BTI type used for freplace attached functions

Kumar Kartikeya Dwivedi <memxor@gmail.com>
    bpf: Repeat check_max_stack_depth for async callbacks

Kumar Kartikeya Dwivedi <memxor@gmail.com>
    bpf: Fix subprog idx logic in check_max_stack_depth

Geetha sowjanya <gakula@marvell.com>
    octeontx2-pf: Dont allocate BPIDs for LBK interfaces

Ido Schimmel <idosch@nvidia.com>
    vrf: Fix lockdep splat in output path

Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
    security: keys: Modify mismatched function name

Ahmed Zaki <ahmed.zaki@intel.com>
    iavf: fix reset task race with iavf_remove()

Ahmed Zaki <ahmed.zaki@intel.com>
    iavf: fix a deadlock caused by rtnl and driver's lock circular dependencies

Marcin Szycik <marcin.szycik@linux.intel.com>
    iavf: Wait for reset in callbacks which trigger it

Przemek Kitszel <przemyslaw.kitszel@intel.com>
    iavf: make functions static where possible

Ahmed Zaki <ahmed.zaki@intel.com>
    iavf: use internal state to free traffic IRQs

Ding Hui <dinghui@sangfor.com.cn>
    iavf: Fix out-of-bounds when setting channels on remove

Ding Hui <dinghui@sangfor.com.cn>
    iavf: Fix use-after-free in free_netdev

Andrzej Hajda <andrzej.hajda@intel.com>
    drm/i915/perf: add sentinel to xehp_oa_b_counters

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: fix ASPM-related problem for chip version 42 and 43

Tristram Ha <Tristram.Ha@microchip.com>
    net: dsa: microchip: correct KSZ8795 static MAC table access

Victor Nogueira <victor@mojatatu.com>
    net: sched: cls_bpf: Undo tcf_bind_filter in case of an error

Victor Nogueira <victor@mojatatu.com>
    net: sched: cls_u32: Undo refcount decrement in case update failed

Victor Nogueira <victor@mojatatu.com>
    net: sched: cls_u32: Undo tcf_bind_filter if u32_replace_hw_knode

Victor Nogueira <victor@mojatatu.com>
    net: sched: cls_matchall: Undo tcf_bind_filter in case of failure after mall_set_parms

Martin Fuzzey <martin.fuzzey@flowbird.group>
    regulator: da9063: fix null pointer deref with partial DT config

Dan Carpenter <dan.carpenter@linaro.org>
    ASoC: SOF: ipc3-dtrace: uninitialized data in dfsentry_trace_filter_write()

Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
    ice: prevent NULL pointer deref during reload

Petr Oros <poros@redhat.com>
    ice: Unregister netdev and devlink_port only once

Shyam Prasad N <nspmangalore@gmail.com>
    cifs: fix mid leak during reconnection after timeout threshold

Dan Carpenter <error27@gmail.com>
    iommu/sva: Fix signedness bug in iommu_sva_alloc_pasid()

Yan Zhai <yan@cloudflare.com>
    gso: fix dodgy bit handling for GSO_UDP_L4

Daniel Golle <daniel@makrotopia.org>
    net: ethernet: mtk_eth_soc: handle probe deferral

Kuniyuki Iwashima <kuniyu@amazon.com>
    bridge: Add extack warning when enabling STP in netns.

Tanmay Patil <t-patil@ti.com>
    net: ethernet: ti: cpsw_ale: Fix cpsw_ale_get_field()/cpsw_ale_set_field()

Linus Walleij <linus.walleij@linaro.org>
    dsa: mv88e6xxx: Do a final check before timing out

Marc Zyngier <maz@kernel.org>
    arm64: Fix HFGxTR_EL2 field naming

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix missed ses refcounting

Yonghong Song <yhs@fb.com>
    kallsyms: strip LTO-only suffixes from promoted global functions

Jaewon Kim <jaewon02.kim@samsung.com>
    spi: s3c64xx: clear loopback bit after loopback test

Christoph Hellwig <hch@lst.de>
    btrfs: be a bit more careful when setting mirror_num_ret in btrfs_map_block

James Clark <james.clark@arm.com>
    perf build: Fix library not found error when using CSLIBS

Yangtao Li <frank.li@vivo.com>
    fbdev: imxfb: Removed unneeded release_mem_region

Martin Kaiser <martin@kaiser.cx>
    fbdev: imxfb: warn about invalid left/right margin

Jonas Gorski <jonas.gorski@gmail.com>
    spi: bcm63xx: fix max prepend length

Biju Das <biju.das.jz@bp.renesas.com>
    pinctrl: renesas: rzg2l: Handle non-unique subnode names

Geert Uytterhoeven <geert+renesas@glider.be>
    pinctrl: renesas: rzv2m: Handle non-unique subnode names

Suren Baghdasaryan <surenb@google.com>
    sched/psi: use kernfs polling functions for PSI trigger polling

Miaohe Lin <linmiaohe@huawei.com>
    sched/fair: Use recent_used_cpu to test p->cpus_ptr

Peter Zijlstra <peterz@infradead.org>
    iov_iter: Mark copy_iovec_from_user() noclone

Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
    ASoC: qcom: q6apm: do not close GPR port before closing graph

Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
    ASoC: codecs: wcd938x: fix dB range for HPHL and HPHR

Johan Hovold <johan+linaro@kernel.org>
    ASoC: codecs: wcd938x: fix mbhc impedance loglevel

Vijendar Mukunda <Vijendar.Mukunda@amd.com>
    ASoC: amd: acp: fix for invalid dai id handling in acp_get_byte_count()

Hao Chen <chenhao418@huawei.com>
    net: hns3: fix strncpy() not using dest-buf length as length issue

Ying Hsu <yinghsu@chromium.org>
    igb: Fix igb_down hung on surprise removal

Yi Kuo <yi@yikuo.dev>
    wifi: iwlwifi: pcie: add device id 51F1 for killer 1675

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: mvm: avoid baid size integer overflow

Mukesh Sisodiya <mukesh.sisodiya@intel.com>
    wifi: iwlwifi: Add support for new PCI Id

Gustavo A. R. Silva <gustavoars@kernel.org>
    wifi: wext-core: Fix -Wstringop-overflow warning in ioctl_standard_iw_point()

Mukesh Sisodiya <mukesh.sisodiya@intel.com>
    wifi: iwlwifi: mvm: Add NULL check before dereferencing the pointer

Petr Oros <poros@redhat.com>
    devlink: report devlink_port_type_warn source device

Jisheng Zhang <jszhang@kernel.org>
    net: ethernet: litex: add support for 64 bit stats

Gregory Greenman <gregory.greenman@intel.com>
    wifi: iwlwifi: mvm: fix potential array out of bounds access

P Praneesh <quic_ppranees@quicinc.com>
    wifi: ath11k: fix memory leak in WMI firmware stats

Balamurugan S <quic_bselvara@quicinc.com>
    wifi: ath12k: Avoid NULL pointer access during management transmit cleanup

Abe Kohandel <abe.kohandel@intel.com>
    spi: dw: Add compatible for Intel Mount Evans SoC

Ilan Peer <ilan.peer@intel.com>
    wifi: mac80211_hwsim: Fix possible NULL dereference

Wen Gong <quic_wgong@quicinc.com>
    wifi: ath11k: add support default regdb while searching board-2.bin for WCN6855

Jakub Kicinski <kuba@kernel.org>
    devlink: make health report on unregistered instance warn just once

Yonghong Song <yhs@fb.com>
    bpf: Silence a warning in btf_type_id_size()

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    wifi: rtw88: sdio: Check the HISR RX_REQUEST bit in rtw_sdio_rx_isr()

Aditi Ghag <aditi.ghag@isovalent.com>
    bpf: tcp: Avoid taking fast sock lock in iterator

Andrii Nakryiko <andrii@kernel.org>
    bpf: drop unnecessary user-triggerable WARN_ONCE in verifierl log

Brad Larson <blarson@amd.com>
    spi: cadence-quadspi: Add compatible for AMD Pensando Elba SoC

Martin KaFai Lau <martin.lau@kernel.org>
    bpf: Address KCSAN report on bpf_lru_list

Kui-Feng Lee <thinker.li@gmail.com>
    bpf: Print a warning only if writing to unprivileged_bpf_disabled.

Maxime Bizon <mbizon@freebox.fr>
    wifi: ath11k: fix registration of 6Ghz-only phy without the full channel range

Yicong Yang <yangyicong@hisilicon.com>
    sched/fair: Don't balance task to its current running CPU

Thomas Weißschuh <linux@weissschuh.net>
    tools/nolibc: ensure stack protector guard is never zero

Paul E. McKenney <paulmck@kernel.org>
    rcu: Mark additional concurrent load from ->cpu_no_qs.b.exp

Shigeru Yoshida <syoshida@redhat.com>
    rcu-tasks: Avoid pr_info() with spin lock in cblist_init_generic()

Hans de Goede <hdegoede@redhat.com>
    ACPI: video: Add backlight=native DMI quirk for Dell Studio 1569

Mark Rutland <mark.rutland@arm.com>
    arm64: mm: fix VA-range sanity check

Youngmin Nam <youngmin.nam@samsung.com>
    arm64: set __exception_irq_entry with __irq_entry as a default

Mario Limonciello <mario.limonciello@amd.com>
    ACPI: resource: Remove "Zen" specific match and quirks

Hans de Goede <hdegoede@redhat.com>
    ACPI: video: Add backlight=native DMI quirk for Lenovo ThinkPad X131e (3371 AMD version)

Hans de Goede <hdegoede@redhat.com>
    ACPI: video: Add backlight=native DMI quirk for Apple iMac11,3

Hans de Goede <hdegoede@redhat.com>
    ACPI: x86: Add ACPI_QUIRK_UART1_SKIP for Lenovo Yoga Book yb1-x90f/l

Hans de Goede <hdegoede@redhat.com>
    ACPI: button: Add lid disable DMI quirk for Nextbook Ares 8A

Hans de Goede <hdegoede@redhat.com>
    ACPI: x86: Add skip i2c clients quirk for Nextbook Ares 8A

Sandeep Dhavale <dhavale@google.com>
    erofs: Fix detection of atomic context

Filipe Manana <fdmanana@suse.com>
    btrfs: abort transaction at update_ref_for_cow() when ref count is zero

Christoph Hellwig <hch@lst.de>
    btrfs: don't check PageError in __extent_writepage

David Sterba <dsterba@suse.com>
    btrfs: add xxhash to fast checksum implementations

Thomas Gleixner <tglx@linutronix.de>
    posix-timers: Ensure timer ID search-loop limit is valid

Ming Lei <ming.lei@redhat.com>
    blk-mq: fix NULL dereference on q->elevator in blk_mq_elv_switch_none

Yu Kuai <yukuai3@huawei.com>
    scsi: sg: fix blktrace debugfs entries leakage

Yu Kuai <yukuai3@huawei.com>
    md/raid10: prevent soft lockup while flush writes

Yu Kuai <yukuai3@huawei.com>
    md: fix data corruption for raid456 when reshape restart while grow up

Immad Mir <mirimmad17@gmail.com>
    FS: JFS: Check for read-only mounted filesystem in txBegin

Immad Mir <mirimmad17@gmail.com>
    FS: JFS: Fix null-ptr-deref Read in txBegin

Gustavo A. R. Silva <gustavoars@kernel.org>
    MIPS: dec: prom: Address -Warray-bounds warning

Yogesh <yogi.kernel@gmail.com>
    fs: jfs: Fix UBSAN: array-index-out-of-bounds in dbAllocDmapLev

Matthew Anderson <ruinairas1992@gmail.com>
    ALSA: hda/realtek: Add quirks for ROG ALLY CS35l41 audio

Jan Kara <jack@suse.cz>
    udf: Fix uninitialized array access for some pathnames

Christian Brauner <brauner@kernel.org>
    ovl: check type and offset of struct vfsmount in ovl_entry

Marco Morandini <marco.morandini@polimi.it>
    HID: add quirk for 03f0:464a HP Elite Presenter Mouse

Ye Bin <yebin10@huawei.com>
    quota: fix warning in dqgrab()

Jan Kara <jack@suse.cz>
    quota: Properly disable quotas when add_dquot_ref() fails

Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
    ALSA: emu10k1: roll up loops in DSP setup code for Audigy

hackyzh002 <hackyzh002@gmail.com>
    drm/radeon: Fix integer overflow in radeon_cs_parser_init

Eric Whitney <enwlinux@gmail.com>
    ext4: correct inline offset when handling xattrs in inode body

Marc Zyngier <maz@kernel.org>
    KVM: arm64: vgic-v4: Make the doorbell request robust w.r.t preemption

Marc Zyngier <maz@kernel.org>
    KVM: arm64: Disable preemption in kvm_arch_hardware_enable()

Oliver Upton <oliver.upton@linux.dev>
    KVM: arm64: Correctly handle page aging notifiers for unaligned memslot

Marc Zyngier <maz@kernel.org>
    KVM: arm64: timers: Use CNTHCTL_EL2 when setting non-CNTKCTL_EL1 bits

Johan Hovold <johan+linaro@kernel.org>
    ASoC: codecs: wcd938x: fix soundwire initialisation race

Johan Hovold <johan+linaro@kernel.org>
    ASoC: codecs: wcd938x: fix codec initialisation race

Johan Hovold <johan+linaro@kernel.org>
    ASoC: codecs: wcd934x: fix resource leaks on component remove

Johan Hovold <johan+linaro@kernel.org>
    ASoC: codecs: wcd938x: fix missing mbhc init error handling

Johan Hovold <johan+linaro@kernel.org>
    ASoC: codecs: wcd938x: fix resource leaks on component remove

Sheetal <sheetal@nvidia.com>
    ASoC: tegra: Fix AMX byte map

Johan Hovold <johan+linaro@kernel.org>
    ASoC: qdsp6: audioreach: fix topology probe deferral

Johan Hovold <johan+linaro@kernel.org>
    ASoC: codecs: wcd-mbhc-v2: fix resource leaks on component remove

Nathan Chancellor <nathan@kernel.org>
    ASoC: cs35l45: Select REGMAP_IRQ

Johan Hovold <johan+linaro@kernel.org>
    ASoC: codecs: wcd938x: fix missing clsh ctrl error handling

Thomas Petazzoni <thomas.petazzoni@bootlin.com>
    ASoC: cs42l51: fix driver to properly autoload with automatic module loading

Sameer Pujar <spujar@nvidia.com>
    ASoC: rt5640: Fix sleep in atomic context

Sheetal <sheetal@nvidia.com>
    ASoC: tegra: Fix ADX byte map

Fabio Estevam <festevam@denx.de>
    ASoC: fsl_sai: Revert "ASoC: fsl_sai: Enable MCTL_MCLK_EN bit for master mode"

Matus Gajdos <matuszpd@gmail.com>
    ASoC: fsl_sai: Disable bit clock with transmitter

Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
    drm/amd/display: Keep PHY active for DP displays on DCN31

Taimur Hassan <syed.hassan@amd.com>
    drm/amd/display: check TG is non-null before checking if enabled

Zhikai Zhai <zhikai.zhai@amd.com>
    drm/amd/display: Disable MPC split by default on special asic

Simon Ser <contact@emersion.fr>
    drm/amd/display: only accept async flips for fast updates

Jocelyn Falempe <jfalempe@redhat.com>
    drm/client: Fix memory leak in drm_client_modeset_probe

Jocelyn Falempe <jfalempe@redhat.com>
    drm/client: Fix memory leak in drm_client_target_cloned

Ben Skeggs <bskeggs@redhat.com>
    drm/nouveau/i2c: fix number of aux event slots

Ben Skeggs <bskeggs@redhat.com>
    drm/nouveau/kms/nv50-: init hpd_irq_lock for PIOR DP

Ben Skeggs <bskeggs@redhat.com>
    drm/nouveau/disp: PIOR DP uses GPIO for HPD, not PMGR AUX interrupts

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu/pm: make mclk consistent for smu 13.0.7

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu/pm: make gfxclock consistent for sienna cichlid

Guchun Chen <guchun.chen@amd.com>
    drm/amdgpu/vkms: relax timer deactivation by hrtimer_try_to_cancel

Ville Syrjälä <ville.syrjala@linux.intel.com>
    dma-buf/dma-resv: Stop leaking on krealloc() failure

Dan Carpenter <dan.carpenter@linaro.org>
    accel/qaic: Add consistent integer overflow checks

Dan Carpenter <dan.carpenter@linaro.org>
    accel/qaic: tighten bounds checking in decode_message()

Dan Carpenter <dan.carpenter@linaro.org>
    accel/qaic: tighten bounds checking in encode_message()

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: tc: add ConnTrack procfs kconfig

Heiner Kallweit <hkallweit1@gmail.com>
    Revert "r8169: disable ASPM during NAPI poll"

Marc Kleine-Budde <mkl@pengutronix.de>
    can: gs_usb: fix time stamp counter initialization

Marc Kleine-Budde <mkl@pengutronix.de>
    can: gs_usb: gs_can_open(): improve error handling

YueHaibing <yuehaibing@huawei.com>
    can: bcm: Fix UAF in bcm_proc_show()

Fedor Ross <fedor.ross@ifm.com>
    can: mcp251xfd: __mcp251xfd_chip_set_mode(): increase poll timeout

Mark Brown <broonie@kernel.org>
    arm64/fpsimd: Ensure SME storage is allocated after SVE VL changes

Helge Deller <deller@gmx.de>
    ia64: mmap: Consider pgoff when searching for free mapping

Mark Brown <broonie@kernel.org>
    regmap: Account for register length in SMBus I/O limits

Rob Herring <robh@kernel.org>
    of: Preserve "of-display" device name for compatibility

Harald Freudenberger <freude@linux.ibm.com>
    s390/zcrypt: fix reply buffer calculations for CCA replies

Mark Brown <broonie@kernel.org>
    regmap: Drop initial version of maximum transfer length fixes

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: tc: add 'ct' action kconfig dep

Dan Carpenter <dan.carpenter@linaro.org>
    accel/qaic: Fix a leak in map_user_pages()

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: tc: set timeout to 15 minutes

Josef Bacik <josef@toxicpanda.com>
    btrfs: fix race between balance and cancel/pause

Miklos Szeredi <mszeredi@redhat.com>
    fuse: ioctl: translate ENOSYS in outarg

Filipe Manana <fdmanana@suse.com>
    btrfs: zoned: fix memory leak after finding block group with super blocks

Filipe Manana <fdmanana@suse.com>
    btrfs: fix double iput() on inode after an error during orphan cleanup

Josef Bacik <josef@toxicpanda.com>
    btrfs: set_page_extent_mapped after read_folio in btrfs_cont_expand

Qu Wenruo <wqu@suse.com>
    btrfs: raid56: always verify the P/Q contents for scrub

Bernd Schubert <bschubert@ddn.com>
    fuse: Apply flags2 only when userspace set the FUSE_INIT_EXT

Miklos Szeredi <mszeredi@redhat.com>
    fuse: add feature flag for expire-only

Miklos Szeredi <mszeredi@redhat.com>
    fuse: revalidate: don't invalidate if interrupted

Filipe Manana <fdmanana@suse.com>
    btrfs: fix warning when putting transaction with qgroups enabled after abort

Filipe Manana <fdmanana@suse.com>
    btrfs: fix iput() on error pointer after error during orphan cleanup

Georg Müller <georgmueller@gmx.net>
    perf probe: Read DWARF files from the correct CU

Georg Müller <georgmueller@gmx.net>
    perf probe: Add test for regression introduced by switch to die_get_decl_file()

Miguel Ojeda <ojeda@kernel.org>
    prctl: move PR_GET_AUXV out of PR_MCE_KILL

Petr Pavlu <petr.pavlu@suse.com>
    keys: Fix linking a duplicate key to a keyring's assoc_array

Colin Ian King <colin.i.king@gmail.com>
    selftests/mm: mkdirty: fix incorrect position of #endif

Liam R. Howlett <Liam.Howlett@oracle.com>
    maple_tree: fix node allocation testing on 32 bit

Liam R. Howlett <Liam.Howlett@oracle.com>
    mm/mlock: fix vma iterator conversion of apply_vma_lock_flags()

Peng Zhang <zhangpeng.00@bytedance.com>
    maple_tree: set the node limit when creating a new root node

Luka Guzenko <l.guzenko@web.de>
    ALSA: hda/realtek: Enable Mute LED on HP Laptop 15s-eq2xxx

Christoffer Sandberg <cs@tuxedo.de>
    ALSA: hda/realtek: Add quirk for Clevo NS70AU

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - remove 3k pull low procedure

Helge Deller <deller@gmx.de>
    io_uring: Fix io_uring mmap() by using architecture-provided get_unmapped_area()

Jens Axboe <axboe@kernel.dk>
    io_uring: treat -EAGAIN for REQ_F_NOWAIT as final for io-wq


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm64/include/asm/exception.h                 |   5 -
 arch/arm64/include/asm/kvm_host.h                  |   2 +
 arch/arm64/include/asm/kvm_pgtable.h               |  26 +--
 arch/arm64/kernel/fpsimd.c                         |  33 ++-
 arch/arm64/kvm/arch_timer.c                        |   6 +-
 arch/arm64/kvm/arm.c                               |  19 +-
 arch/arm64/kvm/hyp/pgtable.c                       |  47 +++-
 arch/arm64/kvm/mmu.c                               |  18 +-
 arch/arm64/kvm/vgic/vgic-v3.c                      |   2 +-
 arch/arm64/kvm/vgic/vgic-v4.c                      |   7 +-
 arch/arm64/mm/mmu.c                                |   4 +-
 arch/arm64/net/bpf_jit_comp.c                      |   8 +-
 arch/arm64/tools/sysreg                            |  12 +-
 arch/ia64/kernel/sys_ia64.c                        |   2 +-
 arch/mips/include/asm/dec/prom.h                   |   2 +-
 arch/parisc/kernel/sys_parisc.c                    |  15 +-
 block/blk-mq.c                                     |  10 +-
 drivers/accel/qaic/qaic_control.c                  |  39 ++--
 drivers/acpi/button.c                              |   9 +
 drivers/acpi/resource.c                            |  60 -----
 drivers/acpi/video_detect.c                        |  24 ++
 drivers/acpi/x86/utils.c                           |  26 ++-
 drivers/base/regmap/regmap-i2c.c                   |   8 +-
 drivers/base/regmap/regmap-spi-avmm.c              |   2 +-
 drivers/base/regmap/regmap.c                       |   6 +-
 drivers/bluetooth/btusb.c                          |   1 +
 drivers/dma-buf/dma-resv.c                         |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |   5 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 256 +++++++++------------
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   7 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |  12 +
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    | 110 +++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.h    |  11 +
 .../amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c   |   5 +
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |   3 +-
 .../drm/amd/display/dc/dcn303/dcn303_resource.c    |   2 +-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |   8 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |   2 +-
 drivers/gpu/drm/drm_client_modeset.c               |   6 +
 drivers/gpu/drm/i915/i915_perf.c                   |   1 +
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |   4 +
 drivers/gpu/drm/nouveau/include/nvkm/subdev/i2c.h  |   4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c   |  27 ++-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c     |  11 +-
 drivers/gpu/drm/radeon/radeon_cs.c                 |   3 +-
 drivers/gpu/drm/ttm/ttm_resource.c                 |   5 +-
 drivers/hid/hid-ids.h                              |   1 +
 drivers/hid/hid-quirks.c                           |   1 +
 drivers/iommu/iommu-sva.c                          |   3 +-
 drivers/md/md.c                                    |  14 +-
 drivers/md/raid10.c                                |   2 +
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c     |  10 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h          |   1 +
 drivers/net/can/usb/gs_usb.c                       | 130 ++++++-----
 drivers/net/dsa/microchip/ksz8795.c                |   8 +-
 drivers/net/dsa/microchip/ksz_common.c             |   8 +-
 drivers/net/dsa/microchip/ksz_common.h             |   7 +
 drivers/net/dsa/mv88e6xxx/chip.c                   |   7 +
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |  33 ++-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c |  29 ++-
 drivers/net/ethernet/intel/iavf/iavf.h             |  16 +-
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |  39 ++--
 drivers/net/ethernet/intel/iavf/iavf_main.c        | 223 ++++++++++++------
 drivers/net/ethernet/intel/iavf/iavf_txrx.c        |  43 ++--
 drivers/net/ethernet/intel/iavf/iavf_txrx.h        |   4 -
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c    |   5 +-
 drivers/net/ethernet/intel/ice/ice_base.c          |   2 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |  13 +-
 drivers/net/ethernet/intel/ice/ice_lib.c           |  27 ---
 drivers/net/ethernet/intel/ice/ice_main.c          |  10 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |   5 +
 drivers/net/ethernet/intel/igc/igc_main.c          |  12 +-
 drivers/net/ethernet/litex/litex_liteeth.c         |  19 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   5 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |  29 +--
 drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c    |   2 +-
 drivers/net/ethernet/realtek/r8169_main.c          |  18 +-
 drivers/net/ethernet/ti/cpsw_ale.c                 |  24 +-
 drivers/net/phy/phy_device.c                       |  21 +-
 drivers/net/vrf.c                                  |  12 +-
 drivers/net/wireless/ath/ath11k/core.c             |  53 +++--
 drivers/net/wireless/ath/ath11k/mac.c              |   3 +-
 drivers/net/wireless/ath/ath11k/wmi.c              |   5 +
 drivers/net/wireless/ath/ath12k/mac.c              |   1 +
 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c   |   9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/power.c     |  14 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |   4 +
 drivers/net/wireless/realtek/rtw88/sdio.c          |  24 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c      |   4 +-
 drivers/of/platform.c                              |   2 +-
 drivers/pinctrl/renesas/pinctrl-rzg2l.c            |  28 ++-
 drivers/pinctrl/renesas/pinctrl-rzv2m.c            |  28 ++-
 drivers/regulator/da9063-regulator.c               |   3 +
 drivers/s390/crypto/zcrypt_msgtype6.c              |  33 ++-
 drivers/scsi/sg.c                                  |  10 +
 drivers/spi/spi-bcm63xx.c                          |   2 +-
 drivers/spi/spi-cadence-quadspi.c                  |  19 ++
 drivers/spi/spi-dw-mmio.c                          |  22 ++
 drivers/spi/spi-s3c64xx.c                          |   2 +
 drivers/video/fbdev/au1200fb.c                     |   3 +
 drivers/video/fbdev/imxfb.c                        |   5 +-
 fs/btrfs/block-group.c                             |   1 +
 fs/btrfs/ctree.c                                   |  10 +-
 fs/btrfs/disk-io.c                                 |   3 +
 fs/btrfs/extent_io.c                               |  33 +--
 fs/btrfs/inode.c                                   |  35 +--
 fs/btrfs/qgroup.c                                  |   1 +
 fs/btrfs/raid56.c                                  |  11 +-
 fs/btrfs/volumes.c                                 |  17 +-
 fs/erofs/zdata.c                                   |   2 +-
 fs/ext4/xattr.c                                    |  14 ++
 fs/fuse/dir.c                                      |   2 +-
 fs/fuse/inode.c                                    |   8 +-
 fs/fuse/ioctl.c                                    |  21 +-
 fs/jbd2/checkpoint.c                               | 102 +++-----
 fs/jfs/jfs_dmap.c                                  |   3 +
 fs/jfs/jfs_txnmgr.c                                |   5 +
 fs/jfs/namei.c                                     |   5 +
 fs/overlayfs/ovl_entry.h                           |   9 +
 fs/quota/dquot.c                                   |   5 +-
 fs/smb/client/connect.c                            |  19 +-
 fs/smb/client/dfs.c                                |  26 +--
 fs/smb/client/smb2transport.c                      |   2 +-
 fs/udf/unicode.c                                   |   2 +-
 include/kvm/arm_vgic.h                             |   2 +-
 include/linux/psi.h                                |   5 +-
 include/linux/psi_types.h                          |   3 +
 include/linux/sched/signal.h                       |   2 +-
 include/linux/tcp.h                                |   2 +-
 include/net/bluetooth/hci_core.h                   |   5 +
 include/net/ip.h                                   |   2 +-
 include/net/tcp.h                                  |  31 ++-
 include/uapi/linux/fuse.h                          |   3 +
 io_uring/io_uring.c                                |  52 ++---
 kernel/bpf/bpf_lru_list.c                          |  21 +-
 kernel/bpf/bpf_lru_list.h                          |   7 +-
 kernel/bpf/btf.c                                   |  23 +-
 kernel/bpf/log.c                                   |   3 -
 kernel/bpf/syscall.c                               |   3 +-
 kernel/bpf/verifier.c                              |  32 ++-
 kernel/cgroup/cgroup.c                             |   2 +-
 kernel/kallsyms.c                                  |   5 +-
 kernel/rcu/tasks.h                                 |   5 +-
 kernel/rcu/tree_exp.h                              |   2 +-
 kernel/rcu/tree_plugin.h                           |   4 +-
 kernel/sched/fair.c                                |   4 +-
 kernel/sched/psi.c                                 |  29 ++-
 kernel/sys.c                                       |  10 +-
 kernel/time/posix-timers.c                         |  31 +--
 kernel/trace/trace_events_hist.c                   |   3 +-
 lib/iov_iter.c                                     |   2 +-
 lib/maple_tree.c                                   |   3 +-
 mm/mlock.c                                         |   9 +-
 net/bluetooth/hci_conn.c                           |  14 +-
 net/bluetooth/hci_core.c                           |  42 +++-
 net/bluetooth/hci_event.c                          |  15 +-
 net/bluetooth/hci_sync.c                           | 121 ++++++++--
 net/bluetooth/iso.c                                |  55 +++--
 net/bluetooth/mgmt.c                               |  26 +--
 net/bluetooth/sco.c                                |  23 +-
 net/bridge/br_stp_if.c                             |   3 +
 net/can/bcm.c                                      |  12 +-
 net/devlink/health.c                               |   2 +-
 net/devlink/leftover.c                             |   5 +-
 net/ipv4/esp4.c                                    |   2 +-
 net/ipv4/inet_connection_sock.c                    |   2 +-
 net/ipv4/inet_hashtables.c                         |  17 +-
 net/ipv4/inet_timewait_sock.c                      |   8 +-
 net/ipv4/ip_output.c                               |   4 +-
 net/ipv4/tcp.c                                     |  57 ++---
 net/ipv4/tcp_fastopen.c                            |   6 +-
 net/ipv4/tcp_ipv4.c                                |  27 ++-
 net/ipv4/tcp_minisocks.c                           |  11 +-
 net/ipv4/tcp_output.c                              |   6 +-
 net/ipv4/udp_offload.c                             |  16 +-
 net/ipv6/ip6_gre.c                                 |   3 +-
 net/ipv6/tcp_ipv6.c                                |   4 +-
 net/ipv6/udp_offload.c                             |   3 +-
 net/llc/llc_input.c                                |   3 -
 net/netfilter/nf_tables_api.c                      |  12 +-
 net/netfilter/nft_set_pipapo.c                     |   6 +-
 net/sched/cls_bpf.c                                |  99 ++++----
 net/sched/cls_matchall.c                           |  35 +--
 net/sched/cls_u32.c                                |  48 +++-
 net/wireless/wext-core.c                           |   6 +
 scripts/Makefile.build                             |   5 +-
 scripts/Makefile.host                              |   6 +-
 scripts/kallsyms.c                                 |   6 +-
 security/keys/request_key.c                        |  35 ++-
 security/keys/trusted-keys/trusted_tpm2.c          |   2 +-
 sound/pci/emu10k1/emufx.c                          | 112 +--------
 sound/pci/hda/patch_realtek.c                      | 100 +++++++-
 sound/soc/amd/acp/amd.h                            |   7 +-
 sound/soc/codecs/Kconfig                           |   1 +
 sound/soc/codecs/cs42l51-i2c.c                     |   6 +
 sound/soc/codecs/cs42l51.c                         |   7 -
 sound/soc/codecs/cs42l51.h                         |   1 -
 sound/soc/codecs/rt5640.c                          |  12 +-
 sound/soc/codecs/wcd-mbhc-v2.c                     |  57 +++--
 sound/soc/codecs/wcd934x.c                         |  12 +
 sound/soc/codecs/wcd938x.c                         |  86 ++++++-
 sound/soc/fsl/fsl_sai.c                            |   8 +-
 sound/soc/fsl/fsl_sai.h                            |   1 +
 sound/soc/qcom/qdsp6/q6apm.c                       |   7 +-
 sound/soc/qcom/qdsp6/topology.c                    |   4 +-
 sound/soc/sof/ipc3-dtrace.c                        |   9 +-
 sound/soc/tegra/tegra210_adx.c                     |  34 ++-
 sound/soc/tegra/tegra210_amx.c                     |  40 ++--
 tools/include/nolibc/stackprotector.h              |   5 +-
 tools/perf/Makefile.config                         |   4 +-
 .../tests/shell/test_uprobe_from_different_cu.sh   |  77 +++++++
 tools/perf/util/dwarf-aux.c                        |   4 +-
 tools/testing/radix-tree/maple.c                   |   6 +-
 tools/testing/selftests/mm/mkdirty.c               |   2 +-
 tools/testing/selftests/tc-testing/config          |   2 +
 tools/testing/selftests/tc-testing/settings        |   1 +
 218 files changed, 2462 insertions(+), 1482 deletions(-)


