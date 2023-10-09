Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06ED87BDD1D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376678AbjJINHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376665AbjJINHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:07:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB9799;
        Mon,  9 Oct 2023 06:07:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132D0C433C8;
        Mon,  9 Oct 2023 13:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696856847;
        bh=gVVFRuyFuIM7x6w5QtoQdS8bUgWexwB3mjXDO3hrWF8=;
        h=From:To:Cc:Subject:Date:From;
        b=lhopa2R/bIKg3PS3FpR/lzbZrGWVr6PfLYW2bB/nMHGKg9lpcQ/i/Le6s77KnrMyz
         QgoAB2faIV+KdiXh8tDnTGL5zsOrzBhtqr4knxN0w8+/mtR8aSVxrSJUnOUiwj3Byp
         g0NNn+kiY2Aikrtoe3Oxt9Cao9ngU0p2CaK5XDIU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 6.5 000/163] 6.5.7-rc1 review
Date:   Mon,  9 Oct 2023 14:59:24 +0200
Message-ID: <20231009130124.021290599@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.7-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.5.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.5.7-rc1
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

This is the start of the stable review cycle for the 6.5.7 release.
There are 163 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.7-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.5.7-rc1

Leon Romanovsky <leon@kernel.org>
    RDMA/mlx5: Remove not-used cache disable flag

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix race condition from parallel smb2 lock requests

luosili <rootlab@huawei.com>
    ksmbd: fix uaf in smb20_oplock_break_ack

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix race condition between session lookup and expire

Tom Lendacky <thomas.lendacky@amd.com>
    x86/sev: Use the GHCB protocol when available for SNP CPUID requests

Tom Lendacky <thomas.lendacky@amd.com>
    x86/sev: Change npages to unsigned long in snp_accept_memory()

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Fixed two speaker platform

Colin Ian King <colin.i.king@gmail.com>
    ALSA: hda/realtek: Fix spelling mistake "powe" -> "power"

Shay Drory <shayd@nvidia.com>
    RDMA/mlx5: Fix NULL string error

Hamdan Igbaria <hamdani@nvidia.com>
    RDMA/mlx5: Fix mutex unlocking on error flow for steering anchor creation

Michael Guralnik <michaelgur@nvidia.com>
    RDMA/mlx5: Fix assigning access flags to cache mkeys

Shay Drory <shayd@nvidia.com>
    RDMA/mlx5: Fix mkey cache possible deadlock on cleanup

Bernard Metzler <bmt@zurich.ibm.com>
    RDMA/siw: Fix connection failure handling

Bart Van Assche <bvanassche@acm.org>
    RDMA/srp: Do not call scsi_done() from srp_abort()

Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
    RDMA/uverbs: Fix typo of sizeof argument

Selvin Xavier <selvin.xavier@broadcom.com>
    RDMA/bnxt_re: Fix the handling of control path response data

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

John David Anglin <dave@parisc-linux.org>
    parisc: Restore __ldcw_align for PA-RISC 2.0 processors

Randy Dunlap <rdunlap@infradead.org>
    net: lan743x: also select PHYLIB

Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
    HID: intel-ish-hid: ipc: Disable and reenable ACPI GPE bit

Jiri Kosina <jkosina@suse.cz>
    HID: sony: remove duplicate NULL check before calling usb_free_urb()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    HID: nvidia-shield: Fix a missing led_classdev_unregister() in the probe error handling path

Haiyang Zhang <haiyangz@microsoft.com>
    net: mana: Fix oversized sge0 for GSO packets

Haiyang Zhang <haiyangz@microsoft.com>
    net: mana: Fix the tso_bytes calculation

Eric Dumazet <edumazet@google.com>
    netlink: annotate data-races around sk->sk_err

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

Florian Westphal <fw@strlen.de>
    netfilter: nft_payload: rebuild vlan header on h_proto access

David Wilder <dwilder@us.ibm.com>
    ibmveth: Remove condition to recompute TCP header checksum.

Dan Carpenter <dan.carpenter@linaro.org>
    net: ethernet: ti: am65-cpsw: Fix error code in am65_cpsw_nuss_init_tx_chns()

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    rswitch: Fix PHY station management clock setting

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    net: renesas: rswitch: Add spin lock protection for irq {un}mask

Jeremy Cline <jeremy@jcline.org>
    net: nfc: llcp: Add lock when modifying device list

Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
    ethtool: plca: fix plca enable data type while parsing the value

Shigeru Yoshida <syoshida@redhat.com>
    net: usb: smsc75xx: Fix uninit-value access in __smsc75xx_read_reg

Ilya Maximets <i.maximets@ovn.org>
    ipv6: tcp: add a missing nf_reset_ct() in 3WHS handling

Al Viro <viro@zeniv.linux.org.uk>
    ovl: fetch inode once in ovl_dentry_revalidate_common()

Al Viro <viro@zeniv.linux.org.uk>
    ovl: move freeing ovl_entry past rcu delay

Fabio Estevam <festevam@denx.de>
    net: dsa: mv88e6xxx: Avoid EEPROM timeout when EEPROM is absent

Dinghao Liu <dinghao.liu@zju.edu.cn>
    ptp: ocp: Fix error handling in ptp_ocp_device_init

David Howells <dhowells@redhat.com>
    ipv4, ipv6: Fix handling of transhdrlen in __ip{,6}_append_data()

Eric Dumazet <edumazet@google.com>
    neighbour: fix data-races around n->output

Eric Dumazet <edumazet@google.com>
    net: fix possible store tearing in neigh_periodic_work()

Clark Wang <xiaoning.wang@nxp.com>
    net: stmmac: platform: fix the incorrect parameter

Mauricio Faria de Oliveira <mfo@canonical.com>
    modpost: add missing else to the "of" check

Jakub Sitnicki <jakub@cloudflare.com>
    bpf, sockmap: Reject sk_msg egress redirects to non-TCP sockets

John Fastabend <john.fastabend@gmail.com>
    bpf, sockmap: Do not inc copied_seq when PEEK flag set

John Fastabend <john.fastabend@gmail.com>
    bpf: tcp_read_skb needs to pop skb regardless of seq

Michal Schmidt <mschmidt@redhat.com>
    ice: always add legacy 32byte RXDID in supported_rxdids

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFSv4: Fix a nfs4_state_manager() race

Arnd Bergmann <arnd@arndb.de>
    ima: rework CONFIG_IMA dependency block

Junxiao Bi <junxiao.bi@oracle.com>
    scsi: target: core: Fix deadlock due to recursive locking

Ilan Peer <ilan.peer@intel.com>
    wifi: iwlwifi: mvm: Fix incorrect usage of scan API

Oleksandr Tymoshenko <ovt@google.com>
    ima: Finish deprecation of IMA_TRUSTED_KEYRING Kconfig

Michał Mirosław <mirq-linux@rere.qmqm.pl>
    regulator/core: regulator_register: set device->class earlier

Benjamin Berg <benjamin.berg@intel.com>
    wifi: mac80211: Create resources for disabled links

Yong Wu <yong.wu@mediatek.com>
    iommu/mediatek: Fix share pgtable for iova over 4GB

Breno Leitao <leitao@debian.org>
    perf/x86/amd: Do not WARN() on every IRQ

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: fix potential key use-after-free

Richard Fitzgerald <rf@opensource.cirrus.com>
    regmap: rbtree: Fix wrong register marked as in-cache when creating new node

Daniel Bristot de Oliveira <bristot@kernel.org>
    rtla/timerlat: Do not stop user-space if a cpu is offline

Sandipan Das <sandipan.das@amd.com>
    perf/x86/amd/core: Fix overflow reset on hotplug

Felix Fietkau <nbd@nbd.name>
    wifi: mt76: mt76x02: fix MT76x0 external LNA gain handling

Alexandra Diupina <adiupina@astralinux.ru>
    drivers/net: process the result of hdlc_open() and add call of hdlc_close() in uhdlc_close()

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: ISO: Fix handling of listen for unicast

Ying Hsu <yinghsu@chromium.org>
    Bluetooth: Fix hci_link_tx_to RCU lock usage

Yao Xiao <xiaoyao@rock-chips.com>
    Bluetooth: Delete unused hci_req_prepare_suspend() declaration

Chen-Yu Tsai <wenst@chromium.org>
    regulator: mt6358: split ops for buck and linear range LDO regulators

Andrii Nakryiko <andrii@kernel.org>
    bpf: unconditionally reset backtrack_state masks on global func exit

Leon Hwang <hffilwlqm@gmail.com>
    bpf: Fix tr dereferencing

Marek Behún <kabel@kernel.org>
    leds: Drop BUG_ON check for LED_COLOR_ID_MULTI

Song Liu <song@kernel.org>
    s390/bpf: Let arch_prepare_bpf_trampoline return program size

Jingbo Xu <jefflexu@linux.alibaba.com>
    erofs: allow empty device tags in flatdev mode

Randy Dunlap <rdunlap@infradead.org>
    HID: nvidia-shield: add LEDS_CLASS dependency

Pin-yen Lin <treapking@chromium.org>
    wifi: mwifiex: Fix oob check condition in mwifiex_process_rx_packet

Felix Fietkau <nbd@nbd.name>
    wifi: mac80211: fix mesh id corruption on 32 bit systems

Johannes Berg <johannes.berg@intel.com>
    wifi: cfg80211: add missing kernel-doc for cqm_rssi_work

Daniel Bristot de Oliveira <bristot@kernel.org>
    rtla/timerlat_aa: Fix previous IRQ delay for IRQs that happens after thread sample

Daniel Bristot de Oliveira <bristot@kernel.org>
    rtla/timerlat_aa: Fix negative IRQ delay

Daniel Bristot de Oliveira <bristot@kernel.org>
    rtla/timerlat_aa: Zero thread sum after every sample analysis

Johannes Berg <johannes.berg@intel.com>
    wifi: cfg80211: fix cqm_config access race

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    wifi: iwlwifi: mvm: Fix a memory corruption issue

Arnd Bergmann <arnd@arndb.de>
    wifi: iwlwifi: dbg_ini: fix structure packing

Gregory Greenman <gregory.greenman@intel.com>
    iwlwifi: mvm: handle PS changes in vif_cfg_changed

Wen Gong <quic_wgong@quicinc.com>
    wifi: cfg80211/mac80211: hold link BSSes when assoc fails for MLO connection

Gao Xiang <xiang@kernel.org>
    erofs: fix memory leak of LZMA global compressed deduplication

Zhihao Cheng <chengzhihao1@huawei.com>
    ubi: Refuse attaching if mtd's erasesize is 0

Lorenzo Bianconi <lorenzo@kernel.org>
    wifi: mt76: fix lock dependency problem for wed_lock

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

Nirmoy Das <nirmoy.das@intel.com>
    drm/i915: Don't set PIPE_CONTROL_FLUSH_L3 for aux inval

Jordan Rife <jrife@google.com>
    net: prevent rewrite of msg_name in sock_sendmsg()

Qu Wenruo <wqu@suse.com>
    btrfs: reject unknown mount options early

Filipe Manana <fdmanana@suse.com>
    btrfs: always print transaction aborted messages with an error level

Jens Axboe <axboe@kernel.dk>
    io_uring: ensure io_lockdep_assert_cq_locked() handles disabled rings

Jens Axboe <axboe@kernel.dk>
    io_uring/kbuf: don't allow registered buffer rings on highmem pages

Jordan Rife <jrife@google.com>
    net: replace calls to sock->ops->connect() with kernel_connect()

Jithu Joseph <jithu.joseph@intel.com>
    platform/x86/intel/ifs: release cpus_read_lock()

Sricharan Ramabadhran <quic_srichara@quicinc.com>
    PCI: qcom: Fix IPQ8074 enumeration

Mika Westerberg <mika.westerberg@linux.intel.com>
    PCI/PM: Mark devices disconnected if upstream PCIe link is down on resume

David Jeffery <djeffery@redhat.com>
    md/raid5: release batch_last before waiting for another stripe_head

Jens Axboe <axboe@kernel.dk>
    io_uring: don't allow IORING_SETUP_NO_MMAP rings on highmem pages

Gustavo A. R. Silva <gustavoars@kernel.org>
    wifi: mwifiex: Fix tlv_buf_left calculation

Sascha Hauer <s.hauer@pengutronix.de>
    wifi: rtw88: rtw8723d: Fix MAC address offset in EEPROM

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_sync: Fix handling of HCI_QUIRK_STRICT_DUPLICATE_FILTER

Juerg Haefliger <juerg.haefliger@canonical.com>
    wifi: brcmfmac: Replace 1-element arrays with flexible arrays

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_codec: Fix leaking content of local_codecs

Gustavo A. R. Silva <gustavoars@kernel.org>
    qed/red_ll2: Fix undefined behavior bug in struct qed_ll2_info

Geliang Tang <geliang.tang@suse.com>
    mptcp: userspace pm allow creating id 0 subflow

Paolo Abeni <pabeni@redhat.com>
    mptcp: fix delegated action races

Christian Marangi <ansuelsmth@gmail.com>
    net: ethernet: mediatek: disable irq before schedule napi

Stefano Garzarella <sgarzare@redhat.com>
    vringh: don't use vringh_kiov_advance() in vringh_iov_xfer()

Haiyang Zhang <haiyangz@microsoft.com>
    net: mana: Fix TX CQE error handling

Zhang Rui <rui.zhang@intel.com>
    iommu/vt-d: Avoid memory allocation in iommu_suspend()

Dinghao Liu <dinghao.liu@zju.edu.cn>
    scsi: zfcp: Fix a double put in zfcp_port_enqueue()

Hector Martin <marcan@marcan.st>
    iommu/apple-dart: Handle DMA_FQ domains in attach_dev()

Liam R. Howlett <Liam.Howlett@oracle.com>
    maple_tree: add MAS_UNDERFLOW and MAS_OVERFLOW states

Liam R. Howlett <Liam.Howlett@oracle.com>
    maple_tree: reduce resets during store setup

Robin Murphy <robin.murphy@arm.com>
    iommu/arm-smmu-v3: Avoid constructing invalid range commands

Patrick Rohr <prohr@google.com>
    net: release reference to inet6_dev pointer

Patrick Rohr <prohr@google.com>
    net: change accept_ra_min_rtr_lft to affect all RA lifetimes

Patrick Rohr <prohr@google.com>
    net: add sysctl accept_ra_min_rtr_lft

Kristina Martsenko <kristina.martsenko@arm.com>
    arm64: cpufeature: Fix CLRBHB and BC detection

Joey Gouly <joey.gouly@arm.com>
    arm64: add HWCAP for FEAT_HBC (hinted conditional branches)

Josef Bacik <josef@toxicpanda.com>
    btrfs: don't clear uptodate on write errors

Christoph Hellwig <hch@lst.de>
    btrfs: remove end_extent_writepage

Christoph Hellwig <hch@lst.de>
    btrfs: remove btrfs_writepage_endio_finish_ordered

Damien Le Moal <dlemoal@kernel.org>
    ata: libata-scsi: Fix delayed scsi_rescan_device() execution

Damien Le Moal <dlemoal@kernel.org>
    scsi: Do not attempt to rescan suspended devices

Bart Van Assche <bvanassche@acm.org>
    scsi: core: Improve type safety of scsi_rescan_device()

Paolo Abeni <pabeni@redhat.com>
    mptcp: fix dangling connection hang-up

Paolo Abeni <pabeni@redhat.com>
    mptcp: rename timer related helper to less confusing names

Kuniyuki Iwashima <kuniyu@amazon.com>
    mptcp: Remove unnecessary test for __mptcp_init_sock()

Liam R. Howlett <Liam.Howlett@oracle.com>
    maple_tree: add mas_is_active() to detect in-tree walks

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


-------------

Diffstat:

 Documentation/arch/arm64/silicon-errata.rst        |   2 +
 Documentation/networking/ip-sysctl.rst             |   8 +
 Makefile                                           |   4 +-
 arch/arm64/Kconfig                                 |  13 ++
 arch/arm64/include/asm/cpufeature.h                |   2 +-
 arch/arm64/include/asm/cputype.h                   |   2 +
 arch/arm64/include/asm/hwcap.h                     |   1 +
 arch/arm64/include/uapi/asm/hwcap.h                |   1 +
 arch/arm64/kernel/cpu_errata.c                     |   8 +
 arch/arm64/kernel/cpufeature.c                     |   4 +-
 arch/arm64/kernel/cpuinfo.c                        |   1 +
 arch/arm64/kernel/entry.S                          |   4 +
 arch/arm64/tools/cpucaps                           |   1 +
 arch/arm64/tools/sysreg                            |   6 +-
 arch/parisc/include/asm/ldcw.h                     |  37 ++--
 arch/parisc/include/asm/spinlock_types.h           |   5 -
 arch/parisc/kernel/smp.c                           |   4 +-
 arch/s390/net/bpf_jit_comp.c                       |   2 +-
 arch/x86/events/amd/core.c                         |  24 +-
 arch/x86/kernel/sev-shared.c                       |  69 ++++--
 arch/x86/kernel/sev.c                              |   3 +-
 drivers/ata/libata-core.c                          |  16 ++
 drivers/ata/libata-scsi.c                          |  33 ++-
 drivers/base/regmap/regcache-rbtree.c              |   3 +-
 drivers/gpio/gpio-aspeed.c                         |   2 +-
 drivers/gpio/gpio-pxa.c                            |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   2 +-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |  41 ++--
 drivers/gpu/drm/i915/gt/gen8_engine_cs.c           |  11 +-
 drivers/hid/Kconfig                                |   1 +
 drivers/hid/hid-nvidia-shield.c                    |   3 +-
 drivers/hid/hid-sony.c                             |   2 +
 drivers/hid/intel-ish-hid/ipc/pci-ish.c            |   8 +
 drivers/infiniband/core/cma.c                      |   2 +-
 drivers/infiniband/core/cma_configfs.c             |   2 +-
 drivers/infiniband/core/nldev.c                    |   1 +
 drivers/infiniband/core/uverbs_main.c              |   2 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c         |  11 +-
 drivers/infiniband/hw/mlx4/sysfs.c                 |   2 +-
 drivers/infiniband/hw/mlx5/fs.c                    |   2 +-
 drivers/infiniband/hw/mlx5/main.c                  |   2 +-
 drivers/infiniband/hw/mlx5/mr.c                    |  14 +-
 drivers/infiniband/sw/siw/siw_cm.c                 |  16 +-
 drivers/infiniband/ulp/srp/ib_srp.c                |  16 +-
 drivers/iommu/apple-dart.c                         |   3 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |  15 +-
 drivers/iommu/intel/iommu.c                        |  16 --
 drivers/iommu/intel/iommu.h                        |   2 +-
 drivers/iommu/mtk_iommu.c                          |   9 +-
 drivers/leds/led-core.c                            |   4 -
 drivers/md/dm-zoned-target.c                       |  15 +-
 drivers/md/raid5.c                                 |   7 +
 drivers/mtd/ubi/build.c                            |   7 +
 drivers/net/dsa/mv88e6xxx/chip.c                   |   6 +-
 drivers/net/dsa/mv88e6xxx/global1.c                |  31 ---
 drivers/net/dsa/mv88e6xxx/global1.h                |   1 -
 drivers/net/dsa/mv88e6xxx/global2.c                |   2 +-
 drivers/net/dsa/mv88e6xxx/global2.h                |   1 +
 drivers/net/ethernet/ibm/ibmveth.c                 |  25 +--
 drivers/net/ethernet/intel/ice/ice_virtchnl.c      |  12 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |   4 +-
 drivers/net/ethernet/microchip/Kconfig             |   1 +
 drivers/net/ethernet/microsoft/mana/mana_en.c      | 211 ++++++++++++------
 drivers/net/ethernet/qlogic/qed/qed_ll2.h          |   2 +-
 drivers/net/ethernet/renesas/rswitch.c             |  25 ++-
 drivers/net/ethernet/renesas/rswitch.h             |   4 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c  |   7 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |   2 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |   1 +
 drivers/net/usb/smsc75xx.c                         |   4 +-
 drivers/net/wan/fsl_ucc_hdlc.c                     |  12 +-
 .../broadcom/brcm80211/brcmfmac/fwil_types.h       |   9 +-
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  | 121 +++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |   2 +-
 .../net/wireless/marvell/mwifiex/11n_rxreorder.c   |   4 +-
 drivers/net/wireless/marvell/mwifiex/sta_rx.c      |  16 +-
 drivers/net/wireless/mediatek/mt76/dma.c           |   8 +-
 .../net/wireless/mediatek/mt76/mt76x02_eeprom.c    |   7 -
 drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c |  13 +-
 drivers/net/wireless/realtek/rtw88/rtw8723d.h      |   1 +
 drivers/of/dynamic.c                               |   6 +-
 drivers/pci/controller/dwc/pcie-qcom.c             |   4 +-
 drivers/pci/pci-driver.c                           |  14 +-
 drivers/platform/x86/intel/ifs/runtest.c           |   7 +-
 drivers/ptp/ptp_ocp.c                              |   1 -
 drivers/regulator/core.c                           |   4 +-
 drivers/regulator/mt6358-regulator.c               |  18 +-
 drivers/s390/scsi/zfcp_aux.c                       |   9 +-
 drivers/scsi/aacraid/commsup.c                     |   2 +-
 drivers/scsi/mvumi.c                               |   2 +-
 drivers/scsi/scsi_lib.c                            |   2 +-
 drivers/scsi/scsi_priv.h                           |   1 -
 drivers/scsi/scsi_scan.c                           |  20 +-
 drivers/scsi/scsi_sysfs.c                          |   4 +-
 drivers/scsi/smartpqi/smartpqi_init.c              |   2 +-
 drivers/scsi/storvsc_drv.c                         |   2 +-
 drivers/scsi/virtio_scsi.c                         |   2 +-
 drivers/target/target_core_device.c                |  11 +-
 drivers/vhost/vringh.c                             |  12 +-
 fs/btrfs/btrfs_inode.h                             |   3 -
 fs/btrfs/extent_io.c                               |  58 ++---
 fs/btrfs/extent_io.h                               |   2 -
 fs/btrfs/inode.c                                   |  47 ++--
 fs/btrfs/ordered-data.c                            |   4 +
 fs/btrfs/super.c                                   |   4 +
 fs/btrfs/transaction.h                             |   4 +-
 fs/erofs/decompressor_lzma.c                       |   5 +-
 fs/erofs/super.c                                   |   2 +-
 fs/nfs/nfs4state.c                                 |   7 +
 fs/overlayfs/super.c                               |   9 +-
 fs/smb/client/connect.c                            |  10 +-
 fs/smb/server/connection.c                         |   2 +
 fs/smb/server/connection.h                         |   1 +
 fs/smb/server/mgmt/user_session.c                  |  10 +-
 fs/smb/server/smb2pdu.c                            |  16 +-
 include/linux/bpf.h                                |   2 +-
 include/linux/ipv6.h                               |   1 +
 include/linux/maple_tree.h                         |  11 +
 include/linux/netfilter/nf_conntrack_sctp.h        |   1 +
 include/net/cfg80211.h                             |   6 +-
 include/net/mana/mana.h                            |   5 +-
 include/net/neighbour.h                            |   2 +-
 include/net/tcp.h                                  |   6 +-
 include/scsi/scsi_host.h                           |   2 +-
 include/uapi/linux/ipv6.h                          |   1 +
 io_uring/io_uring.c                                |  16 +-
 io_uring/io_uring.h                                |  41 ++--
 io_uring/kbuf.c                                    |  27 ++-
 kernel/bpf/verifier.c                              |   8 +-
 lib/maple_tree.c                                   | 246 +++++++++++++++------
 lib/test_maple_tree.c                              |  87 ++++++--
 net/bluetooth/hci_core.c                           |   6 +
 net/bluetooth/hci_event.c                          |   1 +
 net/bluetooth/hci_request.h                        |   2 -
 net/bluetooth/hci_sync.c                           |  14 +-
 net/bluetooth/iso.c                                |   9 +-
 net/bridge/br_netfilter_hooks.c                    |   2 +-
 net/core/neighbour.c                               |  14 +-
 net/core/sock_map.c                                |   4 +
 net/ethtool/plca.c                                 |  45 ++--
 net/ipv4/route.c                                   |   2 +
 net/ipv4/tcp.c                                     |  10 +-
 net/ipv4/tcp_bpf.c                                 |   4 +-
 net/ipv4/tcp_input.c                               |  13 ++
 net/ipv4/tcp_output.c                              |   7 +-
 net/ipv6/addrconf.c                                |  13 ++
 net/ipv6/ndisc.c                                   |  13 +-
 net/ipv6/tcp_ipv6.c                                |  10 +-
 net/l2tp/l2tp_ip6.c                                |   2 +-
 net/mac80211/cfg.c                                 |   3 +
 net/mac80211/ieee80211_i.h                         |   2 +-
 net/mac80211/key.c                                 |   2 +-
 net/mac80211/mesh.c                                |   8 +-
 net/mac80211/mlme.c                                |  18 +-
 net/mptcp/pm_userspace.c                           |   6 -
 net/mptcp/protocol.c                               | 161 +++++++-------
 net/mptcp/protocol.h                               |  59 +++--
 net/mptcp/subflow.c                                |  13 +-
 net/netfilter/ipvs/ip_vs_sync.c                    |   4 +-
 net/netfilter/nf_conntrack_proto_sctp.c            |  43 +++-
 net/netfilter/nf_tables_api.c                      |  44 ++--
 net/netfilter/nft_payload.c                        |  13 +-
 net/netfilter/nft_set_rbtree.c                     |  46 ++--
 net/netlink/af_netlink.c                           |   8 +-
 net/nfc/llcp_core.c                                |   2 +
 net/rds/tcp_connect.c                              |   2 +-
 net/sctp/associola.c                               |   3 +-
 net/sctp/socket.c                                  |   1 +
 net/socket.c                                       |  29 ++-
 net/tipc/crypto.c                                  |   4 +-
 net/wireless/core.c                                |  14 +-
 net/wireless/core.h                                |   7 +-
 net/wireless/mlme.c                                |   3 +-
 net/wireless/nl80211.c                             |  93 +++++---
 scripts/mod/file2alias.c                           |   2 +-
 security/integrity/ima/Kconfig                     |  22 +-
 sound/pci/hda/patch_realtek.c                      | 154 ++++++++++++-
 sound/soc/soc-utils.c                              |   1 +
 sound/soc/tegra/tegra_audio_graph_card.c           |  30 +--
 tools/testing/selftests/netfilter/.gitignore       |   1 +
 tools/testing/selftests/netfilter/Makefile         |   4 +-
 tools/testing/selftests/netfilter/audit_logread.c  | 165 ++++++++++++++
 tools/testing/selftests/netfilter/config           |   1 +
 tools/testing/selftests/netfilter/nft_audit.sh     | 193 ++++++++++++++++
 tools/tracing/rtla/src/timerlat_aa.c               |  32 ++-
 tools/tracing/rtla/src/timerlat_u.c                |   6 +-
 188 files changed, 2189 insertions(+), 962 deletions(-)


