Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB937BDE21
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376936AbjJINQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376431AbjJINQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:16:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA139D;
        Mon,  9 Oct 2023 06:16:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AD7C433C8;
        Mon,  9 Oct 2023 13:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857363;
        bh=RdNtMeV1UtAvDONvbVU2rXMiCc1JJH5N58MRnvzvdxI=;
        h=From:To:Cc:Subject:Date:From;
        b=t1NUvguRqYLRAIZpW5oMiCyUEh8tQPn9b4ltzTm6b2dDGxVUPYq2aXdHUL200mZG4
         a3X+gNTgJF6IA+NSm2aqy5cQ60Lcmxj3yLK7h/QgVK/Gfd8+yVqfx7E2yE3V6GeQ4d
         bN08zlX61Z8gTTNwmK+LoCrNkdbU1QZm+mwUckco=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 6.1 000/162] 6.1.57-rc1 review
Date:   Mon,  9 Oct 2023 14:59:41 +0200
Message-ID: <20231009130122.946357448@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.57-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.57-rc1
X-KernelTest-Deadline: 2023-10-11T13:01+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 6.1.57 release.
There are 162 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.57-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.57-rc1

Jakub Kicinski <kuba@kernel.org>
    netlink: remove the flex array from struct nlmsghdr

Filipe Manana <fdmanana@suse.com>
    btrfs: fix fscrypt name leak after failure to join log transaction

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    btrfs: fix an error handling path in btrfs_rename()

Ido Schimmel <idosch@nvidia.com>
    vrf: Fix lockdep splat in output path

Eric Dumazet <edumazet@google.com>
    ipv6: remove nexthop_fib6_nh_bh()

John David Anglin <dave@parisc-linux.org>
    parisc: Restore __ldcw_align for PA-RISC 2.0 processors

luosili <rootlab@huawei.com>
    ksmbd: fix uaf in smb20_oplock_break_ack

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix race condition between session lookup and expire

Tom Lendacky <thomas.lendacky@amd.com>
    x86/sev: Use the GHCB protocol when available for SNP CPUID requests

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Fixed two speaker platform

Colin Ian King <colin.i.king@gmail.com>
    ALSA: hda/realtek: Fix spelling mistake "powe" -> "power"

Shay Drory <shayd@nvidia.com>
    RDMA/mlx5: Fix NULL string error

Hamdan Igbaria <hamdani@nvidia.com>
    RDMA/mlx5: Fix mutex unlocking on error flow for steering anchor creation

Bernard Metzler <bmt@zurich.ibm.com>
    RDMA/siw: Fix connection failure handling

Bart Van Assche <bvanassche@acm.org>
    RDMA/srp: Do not call scsi_done() from srp_abort()

Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
    RDMA/uverbs: Fix typo of sizeof argument

Leon Romanovsky <leon@kernel.org>
    RDMA/cma: Fix truncation compilation warning in make_cma_ports

Mark Zhang <markzhang@nvidia.com>
    RDMA/cma: Initialize ib_sa_multicast structure to 0 when join

Duje Mihanović <duje.mihanovic@skole.hr>
    gpio: pxa: disable pinctrl calls for MMP_GPIO

Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
    gpio: aspeed: fix the GPIO number passed to pinctrl_gpio_set_config()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    IB/mlx4: Fix the size of a buffer in add_port_entries()

Dan Carpenter <dan.carpenter@linaro.org>
    of: dynamic: Fix potential memory leak in of_changeset_action()

Leon Romanovsky <leon@kernel.org>
    RDMA/core: Require admin capabilities to set system parameters

Fedor Pchelkin <pchelkin@ispras.ru>
    dm zoned: free dmz->ddev array in dmz_put_zoned_devices

Helge Deller <deller@gmx.de>
    parisc: Fix crash with nr_cpus=1 option

Jordan Rife <jrife@google.com>
    smb: use kernel_connect() and kernel_bind()

Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
    intel_idle: add Emerald Rapids Xeon support

Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
    HID: intel-ish-hid: ipc: Disable and reenable ACPI GPE bit

Jiri Kosina <jkosina@suse.cz>
    HID: sony: remove duplicate NULL check before calling usb_free_urb()

Eric Dumazet <edumazet@google.com>
    netlink: annotate data-races around sk->sk_err

Tao Chen <chentao.kernel@linux.alibaba.com>
    netlink: Fix potential skb memleak in netlink_ack

Jakub Kicinski <kuba@kernel.org>
    netlink: split up copies in the ack construction

Xin Long <lucien.xin@gmail.com>
    sctp: update hb timer immediately after users change hb_interval

Xin Long <lucien.xin@gmail.com>
    sctp: update transport state when processing a dupcook packet

Neal Cardwell <ncardwell@google.com>
    tcp: fix delayed ACKs for MSS boundary condition

Neal Cardwell <ncardwell@google.com>
    tcp: fix quick-ack counting to count actual ACKs of new data

Chengfeng Ye <dg573847474@gmail.com>
    tipc: fix a potential deadlock on &tx->lock

Ben Wolsieffer <ben.wolsieffer@hefring.com>
    net: stmmac: dwmac-stm32: fix resume on STM32 MCU

Benjamin Poirier <bpoirier@nvidia.com>
    ipv4: Set offload_failed flag in fibmatch results

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: nft_set_rbtree: fix spurious insertion failure

Phil Sutter <phil@nwl.cc>
    netfilter: nf_tables: Deduplicate nft_register_obj audit logs

Phil Sutter <phil@nwl.cc>
    selftests: netfilter: Extend nft_audit.sh

Phil Sutter <phil@nwl.cc>
    selftests: netfilter: Test nf_tables audit logging

Xin Long <lucien.xin@gmail.com>
    netfilter: handle the connecting collision properly in nf_conntrack_proto_sctp

David Wilder <dwilder@us.ibm.com>
    ibmveth: Remove condition to recompute TCP header checksum.

Dan Carpenter <dan.carpenter@linaro.org>
    net: ethernet: ti: am65-cpsw: Fix error code in am65_cpsw_nuss_init_tx_chns()

Jeremy Cline <jeremy@jcline.org>
    net: nfc: llcp: Add lock when modifying device list

Shigeru Yoshida <syoshida@redhat.com>
    net: usb: smsc75xx: Fix uninit-value access in __smsc75xx_read_reg

Ilya Maximets <i.maximets@ovn.org>
    ipv6: tcp: add a missing nf_reset_ct() in 3WHS handling

Fabio Estevam <festevam@denx.de>
    net: dsa: mv88e6xxx: Avoid EEPROM timeout when EEPROM is absent

Dinghao Liu <dinghao.liu@zju.edu.cn>
    ptp: ocp: Fix error handling in ptp_ocp_device_init

David Howells <dhowells@redhat.com>
    ipv4, ipv6: Fix handling of transhdrlen in __ip{,6}_append_data()

Eric Dumazet <edumazet@google.com>
    neighbour: fix data-races around n->output

Eric Dumazet <edumazet@google.com>
    neighbour: switch to standard rcu, instead of rcu_bh

Eric Dumazet <edumazet@google.com>
    neighbour: annotate lockless accesses to n->nud_state

Martin KaFai Lau <martin.lau@kernel.org>
    bpf: Add BPF_FIB_LOOKUP_SKIP_NEIGH for bpf_fib_lookup

Eric Dumazet <edumazet@google.com>
    net: fix possible store tearing in neigh_periodic_work()

Mauricio Faria de Oliveira <mfo@canonical.com>
    modpost: add missing else to the "of" check

Jakub Sitnicki <jakub@cloudflare.com>
    bpf, sockmap: Reject sk_msg egress redirects to non-TCP sockets

John Fastabend <john.fastabend@gmail.com>
    bpf, sockmap: Do not inc copied_seq when PEEK flag set

John Fastabend <john.fastabend@gmail.com>
    bpf: tcp_read_skb needs to pop skb regardless of seq

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFSv4: Fix a nfs4_state_manager() race

Arnd Bergmann <arnd@arndb.de>
    ima: rework CONFIG_IMA dependency block

Junxiao Bi <junxiao.bi@oracle.com>
    scsi: target: core: Fix deadlock due to recursive locking

Oleksandr Tymoshenko <ovt@google.com>
    ima: Finish deprecation of IMA_TRUSTED_KEYRING Kconfig

Michał Mirosław <mirq-linux@rere.qmqm.pl>
    regulator/core: regulator_register: set device->class earlier

Yong Wu <yong.wu@mediatek.com>
    iommu/mediatek: Fix share pgtable for iova over 4GB

Breno Leitao <leitao@debian.org>
    perf/x86/amd: Do not WARN() on every IRQ

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: fix potential key use-after-free

Richard Fitzgerald <rf@opensource.cirrus.com>
    regmap: rbtree: Fix wrong register marked as in-cache when creating new node

Sandipan Das <sandipan.das@amd.com>
    perf/x86/amd/core: Fix overflow reset on hotplug

Felix Fietkau <nbd@nbd.name>
    wifi: mt76: mt76x02: fix MT76x0 external LNA gain handling

Alexandra Diupina <adiupina@astralinux.ru>
    drivers/net: process the result of hdlc_open() and add call of hdlc_close() in uhdlc_close()

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: ISO: Fix handling of listen for unicast

Yao Xiao <xiaoyao@rock-chips.com>
    Bluetooth: Delete unused hci_req_prepare_suspend() declaration

Chen-Yu Tsai <wenst@chromium.org>
    regulator: mt6358: split ops for buck and linear range LDO regulators

Chen-Yu Tsai <wenst@chromium.org>
    regulator: mt6358: Use linear voltage helpers for single range regulators

Chen-Yu Tsai <wenst@chromium.org>
    regulator: mt6358: Drop *_SSHUB regulators

Leon Hwang <hffilwlqm@gmail.com>
    bpf: Fix tr dereferencing

Marek Behún <kabel@kernel.org>
    leds: Drop BUG_ON check for LED_COLOR_ID_MULTI

Pin-yen Lin <treapking@chromium.org>
    wifi: mwifiex: Fix oob check condition in mwifiex_process_rx_packet

Johannes Berg <johannes.berg@intel.com>
    wifi: cfg80211: add missing kernel-doc for cqm_rssi_work

Johannes Berg <johannes.berg@intel.com>
    wifi: cfg80211: fix cqm_config access race

Johannes Berg <johannes.berg@intel.com>
    wifi: cfg80211: add a work abstraction with special semantics

Johannes Berg <johannes.berg@intel.com>
    wifi: cfg80211: move wowlan disable under locks

Johannes Berg <johannes.berg@intel.com>
    wifi: cfg80211: hold wiphy lock in auto-disconnect

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    wifi: iwlwifi: mvm: Fix a memory corruption issue

Arnd Bergmann <arnd@arndb.de>
    wifi: iwlwifi: dbg_ini: fix structure packing

Gao Xiang <xiang@kernel.org>
    erofs: fix memory leak of LZMA global compressed deduplication

Zhihao Cheng <chengzhihao1@huawei.com>
    ubi: Refuse attaching if mtd's erasesize is 0

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    HID: sony: Fix a potential memory leak in sony_probe()

Rob Herring <robh@kernel.org>
    arm64: errata: Add Cortex-A520 speculative unprivileged load workaround

Rob Herring <robh@kernel.org>
    arm64: Add Cortex-A520 CPU part definition

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Fix logic error in sienna_cichlid_update_pcie_parameters()

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Fix detection of _PR3 on the PCIe root port

Jordan Rife <jrife@google.com>
    net: prevent rewrite of msg_name in sock_sendmsg()

Qu Wenruo <wqu@suse.com>
    btrfs: reject unknown mount options early

Jordan Rife <jrife@google.com>
    net: replace calls to sock->ops->connect() with kernel_connect()

Sricharan Ramabadhran <quic_srichara@quicinc.com>
    PCI: qcom: Fix IPQ8074 enumeration

David Jeffery <djeffery@redhat.com>
    md/raid5: release batch_last before waiting for another stripe_head

Gustavo A. R. Silva <gustavoars@kernel.org>
    wifi: mwifiex: Fix tlv_buf_left calculation

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_sync: Fix handling of HCI_QUIRK_STRICT_DUPLICATE_FILTER

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_codec: Fix leaking content of local_codecs

Gustavo A. R. Silva <gustavoars@kernel.org>
    qed/red_ll2: Fix undefined behavior bug in struct qed_ll2_info

Geliang Tang <geliang.tang@suse.com>
    mptcp: userspace pm allow creating id 0 subflow

Christian Marangi <ansuelsmth@gmail.com>
    net: ethernet: mediatek: disable irq before schedule napi

Stefano Garzarella <sgarzare@redhat.com>
    vringh: don't use vringh_kiov_advance() in vringh_iov_xfer()

Zhang Rui <rui.zhang@intel.com>
    iommu/vt-d: Avoid memory allocation in iommu_suspend()

Dinghao Liu <dinghao.liu@zju.edu.cn>
    scsi: zfcp: Fix a double put in zfcp_port_enqueue()

Yajun Deng <yajun.deng@linux.dev>
    i40e: fix the wrong PTP frequency calculation

Aleksandr Mezin <mezin.alexander@gmail.com>
    hwmon: (nzxt-smart2) add another USB ID

Herman Fries <baracoder@googlemail.com>
    hwmon: (nzxt-smart2) Add device id

Ming Lei <ming.lei@redhat.com>
    block: fix use-after-free of q->q_usage_counter

Ilya Dryomov <idryomov@gmail.com>
    rbd: take header_rwsem in rbd_dev_refresh() only when updating

Ilya Dryomov <idryomov@gmail.com>
    rbd: decouple parent info read-in from updating rbd_dev

Ilya Dryomov <idryomov@gmail.com>
    rbd: decouple header read-in from updating rbd_dev->header

Ilya Dryomov <idryomov@gmail.com>
    rbd: move rbd_dev_refresh() definition

Robin Murphy <robin.murphy@arm.com>
    iommu/arm-smmu-v3: Avoid constructing invalid range commands

Robin Murphy <robin.murphy@arm.com>
    iommu/arm-smmu-v3: Set TTL invalidation hint better

Wayne Lin <wayne.lin@amd.com>
    drm/amd/display: Adjust the MST resume flow

Kristina Martsenko <kristina.martsenko@arm.com>
    arm64: cpufeature: Fix CLRBHB and BC detection

Patrick Rohr <prohr@google.com>
    net: release reference to inet6_dev pointer

Patrick Rohr <prohr@google.com>
    net: change accept_ra_min_rtr_lft to affect all RA lifetimes

Patrick Rohr <prohr@google.com>
    net: add sysctl accept_ra_min_rtr_lft

Gabriel Krisman Bertazi <krisman@suse.de>
    arm64: Avoid repeated AA64MMFR1_EL1 register read on pagefault path

Benjamin Coddington <bcodding@redhat.com>
    Revert "NFSv4: Retry LOCK on OLD_STATEID during delegation return"

Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
    btrfs: use struct fscrypt_str instead of struct qstr

Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
    btrfs: setup qstr from dentrys using fscrypt helper

Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
    btrfs: use struct qstr instead of name and namelen pairs

Zheng Yejian <zhengyejian1@huawei.com>
    ring-buffer: Fix bytes info in per_cpu buffer stats

Vlastimil Babka <vbabka@suse.cz>
    ring-buffer: remove obsolete comment for free_buffer_page()

Johannes Weiner <hannes@cmpxchg.org>
    mm: page_alloc: fix CMA and HIGHATOMIC landing on the wrong buddy list

Mel Gorman <mgorman@techsingularity.net>
    mm/page_alloc: leave IRQs enabled for per-cpu page allocations

Mel Gorman <mgorman@techsingularity.net>
    mm/page_alloc: always remove pages from temporary list

Yang Shi <yang@os.amperecomputing.com>
    mm: mempolicy: keep VMA walk if both MPOL_MF_STRICT and MPOL_MF_MOVE are specified

Vishal Moola (Oracle) <vishal.moola@gmail.com>
    mm/mempolicy: convert migrate_page_add() to migrate_folio_add()

Vishal Moola (Oracle) <vishal.moola@gmail.com>
    mm/mempolicy: convert queue_pages_pte_range() to queue_folios_pte_range()

Vishal Moola (Oracle) <vishal.moola@gmail.com>
    mm/mempolicy: convert queue_pages_pmd() to queue_folios_pmd()

Vishal Moola (Oracle) <vishal.moola@gmail.com>
    mm/memory: add vm_normal_folio()

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFSv4: Fix a state manager thread deadlock regression

Benjamin Coddington <bcodding@redhat.com>
    NFS: rename nfs_client_kset to nfs_kset

Benjamin Coddington <bcodding@redhat.com>
    NFS: Cleanup unused rpc_clnt variable

Damien Le Moal <dlemoal@kernel.org>
    ata: libata-scsi: Fix delayed scsi_rescan_device() execution

Damien Le Moal <dlemoal@kernel.org>
    scsi: Do not attempt to rescan suspended devices

Bart Van Assche <bvanassche@acm.org>
    scsi: core: Improve type safety of scsi_rescan_device()

Damien Le Moal <dlemoal@kernel.org>
    scsi: sd: Do not issue commands to suspended disks on shutdown

Damien Le Moal <dlemoal@kernel.org>
    scsi: sd: Differentiate system and runtime start/stop management

Damien Le Moal <dlemoal@kernel.org>
    ata,scsi: do not issue START STOP UNIT on resume

Paolo Abeni <pabeni@redhat.com>
    mptcp: process pending subflow error on close

Paolo Abeni <pabeni@redhat.com>
    mptcp: move __mptcp_error_report in protocol.c

Eric Dumazet <edumazet@google.com>
    mptcp: annotate lockless accesses to sk->sk_err

Paolo Abeni <pabeni@redhat.com>
    mptcp: fix dangling connection hang-up

Paolo Abeni <pabeni@redhat.com>
    mptcp: rename timer related helper to less confusing names

Sameer Pujar <spujar@nvidia.com>
    ASoC: tegra: Fix redundant PLLA and PLLA_OUT0 updates

Sameer Pujar <spujar@nvidia.com>
    ASoC: soc-utils: Export snd_soc_dai_is_dummy() symbol

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - ALC287 Realtek I2S speaker platform support

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - ALC287 I2S speaker platform support

Fabian Vogt <fabian@ritter-vogt.de>
    ALSA: hda/realtek: Add quirk for mute LEDs on HP ENVY x360 15-eu0xxx

SungHwan Jung <onenowy@gmail.com>
    ALSA: hda/realtek: Add quirk for HP Victus 16-d1xxx to enable mute LED

Shenghao Ding <shenghao-ding@ti.com>
    ALSA: hda/tas2781: Add tas2781 HDA driver

Johan Hovold <johan+linaro@kernel.org>
    spi: zynqmp-gqspi: fix clock imbalance on probe failure

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    spi: zynqmp-gqspi: Convert to platform remove callback returning void


-------------

Diffstat:

 Documentation/arm64/silicon-errata.rst             |   2 +
 Documentation/networking/ip-sysctl.rst             |   8 +
 Makefile                                           |   4 +-
 arch/arm64/Kconfig                                 |  13 +
 arch/arm64/include/asm/cpufeature.h                |   8 +-
 arch/arm64/include/asm/cputype.h                   |   2 +
 arch/arm64/kernel/cpu_errata.c                     |   8 +
 arch/arm64/kernel/cpufeature.c                     |   3 +-
 arch/arm64/kernel/entry.S                          |   4 +
 arch/arm64/tools/cpucaps                           |   1 +
 arch/arm64/tools/sysreg                            |   6 +-
 arch/parisc/include/asm/ldcw.h                     |  36 +-
 arch/parisc/include/asm/spinlock_types.h           |   5 -
 arch/parisc/kernel/smp.c                           |   4 +-
 arch/x86/events/amd/core.c                         |  24 +-
 arch/x86/kernel/sev-shared.c                       |  69 +++-
 block/blk-sysfs.c                                  |   3 +-
 drivers/ata/libata-core.c                          |  16 +
 drivers/ata/libata-scsi.c                          |  43 ++-
 drivers/base/regmap/regcache-rbtree.c              |   3 +-
 drivers/block/rbd.c                                | 412 +++++++++++----------
 drivers/firewire/sbp2.c                            |   9 +-
 drivers/gpio/gpio-aspeed.c                         |   2 +-
 drivers/gpio/gpio-pxa.c                            |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  93 ++++-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |  41 +-
 drivers/hid/hid-sony.c                             |   2 +
 drivers/hid/intel-ish-hid/ipc/pci-ish.c            |   8 +
 drivers/hwmon/nzxt-smart2.c                        |   2 +
 drivers/idle/intel_idle.c                          |   2 +
 drivers/infiniband/core/cma.c                      |   2 +-
 drivers/infiniband/core/cma_configfs.c             |   2 +-
 drivers/infiniband/core/nldev.c                    |   1 +
 drivers/infiniband/core/uverbs_main.c              |   2 +-
 drivers/infiniband/hw/mlx4/sysfs.c                 |   2 +-
 drivers/infiniband/hw/mlx5/fs.c                    |   2 +-
 drivers/infiniband/hw/mlx5/main.c                  |   2 +-
 drivers/infiniband/sw/siw/siw_cm.c                 |  16 +-
 drivers/infiniband/ulp/srp/ib_srp.c                |  16 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |  18 +-
 drivers/iommu/intel/iommu.c                        |  16 -
 drivers/iommu/intel/iommu.h                        |   2 +-
 drivers/iommu/mtk_iommu.c                          |   9 +-
 drivers/leds/led-core.c                            |   4 -
 drivers/md/dm-zoned-target.c                       |  15 +-
 drivers/md/raid5.c                                 |   7 +
 drivers/mtd/ubi/build.c                            |   7 +
 drivers/net/dsa/mv88e6xxx/chip.c                   |   6 +-
 drivers/net/dsa/mv88e6xxx/global1.c                |  31 --
 drivers/net/dsa/mv88e6xxx/global1.h                |   1 -
 drivers/net/dsa/mv88e6xxx/global2.c                |   2 +-
 drivers/net/dsa/mv88e6xxx/global2.h                |   1 +
 drivers/net/ethernet/ibm/ibmveth.c                 |  25 +-
 drivers/net/ethernet/intel/i40e/i40e_ptp.c         |   4 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |   4 +-
 drivers/net/ethernet/qlogic/qed/qed_ll2.h          |   2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c  |   7 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |   1 +
 drivers/net/usb/smsc75xx.c                         |   4 +-
 drivers/net/vrf.c                                  |  12 +-
 drivers/net/vxlan/vxlan_core.c                     |   4 +-
 drivers/net/wan/fsl_ucc_hdlc.c                     |  12 +-
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |   2 +-
 .../net/wireless/marvell/mwifiex/11n_rxreorder.c   |   4 +-
 drivers/net/wireless/marvell/mwifiex/sta_rx.c      |  16 +-
 .../net/wireless/mediatek/mt76/mt76x02_eeprom.c    |   7 -
 drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c |  13 +-
 drivers/of/dynamic.c                               |   6 +-
 drivers/pci/controller/dwc/pcie-qcom.c             |   4 +-
 drivers/ptp/ptp_ocp.c                              |   1 -
 drivers/regulator/core.c                           |   4 +-
 drivers/regulator/mt6358-regulator.c               | 153 +++-----
 drivers/s390/scsi/zfcp_aux.c                       |   9 +-
 drivers/scsi/aacraid/commsup.c                     |   2 +-
 drivers/scsi/mvumi.c                               |   2 +-
 drivers/scsi/scsi_lib.c                            |   2 +-
 drivers/scsi/scsi_priv.h                           |   1 -
 drivers/scsi/scsi_scan.c                           |  20 +-
 drivers/scsi/scsi_sysfs.c                          |   4 +-
 drivers/scsi/sd.c                                  | 110 ++++--
 drivers/scsi/sd.h                                  |   1 +
 drivers/scsi/smartpqi/smartpqi_init.c              |   2 +-
 drivers/scsi/storvsc_drv.c                         |   2 +-
 drivers/scsi/virtio_scsi.c                         |   2 +-
 drivers/spi/spi-zynqmp-gqspi.c                     |  18 +-
 drivers/target/target_core_device.c                |  11 +-
 drivers/vhost/vringh.c                             |  12 +-
 fs/btrfs/ctree.h                                   |  28 +-
 fs/btrfs/dir-item.c                                |  50 ++-
 fs/btrfs/inode-item.c                              |  73 ++--
 fs/btrfs/inode-item.h                              |  20 +-
 fs/btrfs/inode.c                                   | 267 ++++++++-----
 fs/btrfs/ioctl.c                                   |   7 +-
 fs/btrfs/root-tree.c                               |  19 +-
 fs/btrfs/send.c                                    |  12 +-
 fs/btrfs/super.c                                   |   7 +-
 fs/btrfs/transaction.c                             |  40 +-
 fs/btrfs/tree-log.c                                | 279 +++++++-------
 fs/btrfs/tree-log.h                                |   4 +-
 fs/erofs/decompressor_lzma.c                       |   5 +-
 fs/nfs/nfs4proc.c                                  |  10 +-
 fs/nfs/nfs4state.c                                 |  47 ++-
 fs/nfs/sysfs.c                                     |  16 +-
 fs/smb/client/connect.c                            |  10 +-
 fs/smb/server/connection.c                         |   2 +
 fs/smb/server/connection.h                         |   1 +
 fs/smb/server/mgmt/user_session.c                  |  10 +-
 fs/smb/server/smb2pdu.c                            |   4 +-
 include/linux/bpf.h                                |   2 +-
 include/linux/ipv6.h                               |   1 +
 include/linux/mm.h                                 |   2 +
 include/linux/netfilter/nf_conntrack_sctp.h        |   1 +
 include/linux/regulator/mt6358-regulator.h         |   4 -
 include/net/arp.h                                  |   8 +-
 include/net/cfg80211.h                             |  99 ++++-
 include/net/ndisc.h                                |  12 +-
 include/net/neighbour.h                            |  10 +-
 include/net/netlink.h                              |  21 ++
 include/net/nexthop.h                              |  23 --
 include/net/tcp.h                                  |   6 +-
 include/scsi/scsi_device.h                         |   6 +-
 include/scsi/scsi_host.h                           |   2 +-
 include/uapi/linux/bpf.h                           |   6 +
 include/uapi/linux/ipv6.h                          |   1 +
 kernel/trace/ring_buffer.c                         |  32 +-
 mm/memory.c                                        |  10 +
 mm/mempolicy.c                                     | 122 +++---
 mm/page_alloc.c                                    | 138 ++++---
 net/bluetooth/hci_core.c                           |   1 +
 net/bluetooth/hci_event.c                          |   1 +
 net/bluetooth/hci_request.h                        |   2 -
 net/bluetooth/hci_sync.c                           |  14 +-
 net/bluetooth/iso.c                                |   9 +-
 net/bridge/br_arp_nd_proxy.c                       |   4 +-
 net/bridge/br_netfilter_hooks.c                    |   5 +-
 net/core/filter.c                                  |  59 +--
 net/core/neighbour.c                               | 106 +++---
 net/core/sock_map.c                                |   4 +
 net/ipv4/arp.c                                     |   8 +-
 net/ipv4/fib_semantics.c                           |   8 +-
 net/ipv4/ip_output.c                               |   6 +-
 net/ipv4/nexthop.c                                 |  12 +-
 net/ipv4/route.c                                   |   8 +-
 net/ipv4/tcp.c                                     |  10 +-
 net/ipv4/tcp_bpf.c                                 |   4 +-
 net/ipv4/tcp_input.c                               |  13 +
 net/ipv4/tcp_output.c                              |   7 +-
 net/ipv6/addrconf.c                                |  27 +-
 net/ipv6/ip6_fib.c                                 |  16 +-
 net/ipv6/ip6_output.c                              |  12 +-
 net/ipv6/ndisc.c                                   |  17 +-
 net/ipv6/route.c                                   |  14 +-
 net/ipv6/tcp_ipv6.c                                |  10 +-
 net/l2tp/l2tp_ip6.c                                |   2 +-
 net/mac80211/cfg.c                                 |   3 +
 net/mac80211/key.c                                 |   2 +-
 net/mptcp/pm_netlink.c                             |   2 +-
 net/mptcp/pm_userspace.c                           |   6 -
 net/mptcp/protocol.c                               | 177 +++++----
 net/mptcp/protocol.h                               |  24 +-
 net/mptcp/subflow.c                                |  41 +-
 net/netfilter/ipvs/ip_vs_sync.c                    |   4 +-
 net/netfilter/nf_conntrack_proto_sctp.c            |  43 ++-
 net/netfilter/nf_tables_api.c                      |  44 ++-
 net/netfilter/nft_set_rbtree.c                     |  46 ++-
 net/netlink/af_netlink.c                           |  37 +-
 net/nfc/llcp_core.c                                |   2 +
 net/rds/tcp_connect.c                              |   2 +-
 net/sctp/associola.c                               |   3 +-
 net/sctp/socket.c                                  |   1 +
 net/socket.c                                       |  29 +-
 net/tipc/crypto.c                                  |   4 +-
 net/wireless/core.c                                | 150 +++++++-
 net/wireless/core.h                                |  14 +-
 net/wireless/nl80211.c                             |  93 +++--
 net/wireless/sme.c                                 |   4 +-
 net/wireless/sysfs.c                               |   8 +-
 scripts/mod/file2alias.c                           |   2 +-
 security/integrity/ima/Kconfig                     |  22 +-
 sound/pci/hda/patch_realtek.c                      | 154 +++++++-
 sound/soc/soc-utils.c                              |   1 +
 sound/soc/tegra/tegra_audio_graph_card.c           |  30 +-
 tools/include/uapi/linux/bpf.h                     |   6 +
 tools/testing/selftests/netfilter/.gitignore       |   1 +
 tools/testing/selftests/netfilter/Makefile         |   4 +-
 tools/testing/selftests/netfilter/audit_logread.c  | 165 +++++++++
 tools/testing/selftests/netfilter/config           |   1 +
 tools/testing/selftests/netfilter/nft_audit.sh     | 193 ++++++++++
 190 files changed, 2961 insertions(+), 1642 deletions(-)


