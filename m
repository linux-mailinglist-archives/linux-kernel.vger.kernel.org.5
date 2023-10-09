Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD377BDF03
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376688AbjJINZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376491AbjJINZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:25:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F9294;
        Mon,  9 Oct 2023 06:25:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841DFC433C8;
        Mon,  9 Oct 2023 13:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857925;
        bh=73fBPGRNZoL475Ceb3S2rbdjPZA+FslAA6Hl6Q5Y0dk=;
        h=From:To:Cc:Subject:Date:From;
        b=W3+v7s2+fJenLFBgb5QsD0D1vd42q/raqJphg4fBTEnzmhEzoICOCiZ4y7XKsaoyH
         3QG7lNqpG4AvXDQYLeuxeXXoD3IpD8/Ofkn3Ohf3ESjcpOyPNEMl2si4qqyMw0jw7l
         RdA0vkrQjkjDs/LhCDhwaxJsccgdeElXS1ScWh7U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 5.15 00/75] 5.15.135-rc1 review
Date:   Mon,  9 Oct 2023 15:01:22 +0200
Message-ID: <20231009130111.200710898@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.135-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.135-rc1
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

This is the start of the stable review cycle for the 5.15.135 release.
There are 75 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.135-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.135-rc1

John David Anglin <dave@parisc-linux.org>
    parisc: Restore __ldcw_align for PA-RISC 2.0 processors

luosili <rootlab@huawei.com>
    ksmbd: fix uaf in smb20_oplock_break_ack

Shay Drory <shayd@nvidia.com>
    RDMA/mlx5: Fix NULL string error

Bernard Metzler <bmt@zurich.ibm.com>
    RDMA/siw: Fix connection failure handling

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

Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
    HID: intel-ish-hid: ipc: Disable and reenable ACPI GPE bit

Jiri Kosina <jkosina@suse.cz>
    HID: sony: remove duplicate NULL check before calling usb_free_urb()

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

Fabio Estevam <festevam@denx.de>
    net: dsa: mv88e6xxx: Avoid EEPROM timeout when EEPROM is absent

Dinghao Liu <dinghao.liu@zju.edu.cn>
    ptp: ocp: Fix error handling in ptp_ocp_device_init

David Howells <dhowells@redhat.com>
    ipv4, ipv6: Fix handling of transhdrlen in __ip{,6}_append_data()

Eric Dumazet <edumazet@google.com>
    net: fix possible store tearing in neigh_periodic_work()

Mauricio Faria de Oliveira <mfo@canonical.com>
    modpost: add missing else to the "of" check

Jakub Sitnicki <jakub@cloudflare.com>
    bpf, sockmap: Reject sk_msg egress redirects to non-TCP sockets

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFSv4: Fix a nfs4_state_manager() race

Arnd Bergmann <arnd@arndb.de>
    ima: rework CONFIG_IMA dependency block

Junxiao Bi <junxiao.bi@oracle.com>
    scsi: target: core: Fix deadlock due to recursive locking

Oleksandr Tymoshenko <ovt@google.com>
    ima: Finish deprecation of IMA_TRUSTED_KEYRING Kconfig

Richard Fitzgerald <rf@opensource.cirrus.com>
    regmap: rbtree: Fix wrong register marked as in-cache when creating new node

Felix Fietkau <nbd@nbd.name>
    wifi: mt76: mt76x02: fix MT76x0 external LNA gain handling

Alexandra Diupina <adiupina@astralinux.ru>
    drivers/net: process the result of hdlc_open() and add call of hdlc_close() in uhdlc_close()

Leon Hwang <hffilwlqm@gmail.com>
    bpf: Fix tr dereferencing

Pin-yen Lin <treapking@chromium.org>
    wifi: mwifiex: Fix oob check condition in mwifiex_process_rx_packet

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    wifi: iwlwifi: mvm: Fix a memory corruption issue

Johannes Berg <johannes.berg@intel.com>
    iwlwifi: avoid void pointer arithmetic

Arnd Bergmann <arnd@arndb.de>
    wifi: iwlwifi: dbg_ini: fix structure packing

Zhihao Cheng <chengzhihao1@huawei.com>
    ubi: Refuse attaching if mtd's erasesize is 0

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    HID: sony: Fix a potential memory leak in sony_probe()

Rob Herring <robh@kernel.org>
    arm64: Add Cortex-A520 CPU part definition

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Fix detection of _PR3 on the PCIe root port

Jordan Rife <jrife@google.com>
    net: prevent rewrite of msg_name in sock_sendmsg()

Qu Wenruo <wqu@suse.com>
    btrfs: reject unknown mount options early

Jordan Rife <jrife@google.com>
    net: replace calls to sock->ops->connect() with kernel_connect()

Gustavo A. R. Silva <gustavoars@kernel.org>
    wifi: mwifiex: Fix tlv_buf_left calculation

Gustavo A. R. Silva <gustavoars@kernel.org>
    qed/red_ll2: Fix undefined behavior bug in struct qed_ll2_info

Stefano Garzarella <sgarzare@redhat.com>
    vringh: don't use vringh_kiov_advance() in vringh_iov_xfer()

Dinghao Liu <dinghao.liu@zju.edu.cn>
    scsi: zfcp: Fix a double put in zfcp_port_enqueue()

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "clk: imx: pll14xx: dynamically configure PLL for 393216000/361267200Hz"

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

Gabriel Krisman Bertazi <krisman@suse.de>
    arm64: Avoid repeated AA64MMFR1_EL1 register read on pagefault path

Zheng Yejian <zhengyejian1@huawei.com>
    ring-buffer: Fix bytes info in per_cpu buffer stats

Vlastimil Babka <vbabka@suse.cz>
    ring-buffer: remove obsolete comment for free_buffer_page()

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFSv4: Fix a state manager thread deadlock regression

Benjamin Coddington <bcodding@redhat.com>
    NFS: rename nfs_client_kset to nfs_kset

Benjamin Coddington <bcodding@redhat.com>
    NFS: Cleanup unused rpc_clnt variable

Sameer Pujar <spujar@nvidia.com>
    ASoC: tegra: Fix redundant PLLA and PLLA_OUT0 updates

Sameer Pujar <spujar@nvidia.com>
    ASoC: soc-utils: Export snd_soc_dai_is_dummy() symbol

Johan Hovold <johan+linaro@kernel.org>
    spi: zynqmp-gqspi: fix clock imbalance on probe failure

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    spi: zynqmp-gqspi: Convert to platform remove callback returning void


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm64/include/asm/cpufeature.h                |   6 +-
 arch/arm64/include/asm/cputype.h                   |   2 +
 arch/parisc/include/asm/ldcw.h                     |  36 +-
 arch/parisc/include/asm/spinlock_types.h           |   5 -
 block/blk-core.c                                   |   2 -
 block/blk-sysfs.c                                  |   2 +
 drivers/base/regmap/regcache-rbtree.c              |   3 +-
 drivers/block/rbd.c                                | 412 +++++++++++----------
 drivers/clk/imx/clk-pll14xx.c                      |   2 +
 drivers/gpio/gpio-aspeed.c                         |   2 +-
 drivers/gpio/gpio-pxa.c                            |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   2 +-
 drivers/hid/hid-sony.c                             |   2 +
 drivers/hid/intel-ish-hid/ipc/pci-ish.c            |   8 +
 drivers/infiniband/core/cma.c                      |   2 +-
 drivers/infiniband/core/cma_configfs.c             |   2 +-
 drivers/infiniband/core/nldev.c                    |   1 +
 drivers/infiniband/core/uverbs_main.c              |   2 +-
 drivers/infiniband/hw/mlx4/sysfs.c                 |   2 +-
 drivers/infiniband/hw/mlx5/main.c                  |   2 +-
 drivers/infiniband/sw/siw/siw_cm.c                 |  16 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |  18 +-
 drivers/md/dm-zoned-target.c                       |  15 +-
 drivers/mtd/ubi/build.c                            |   7 +
 drivers/net/dsa/mv88e6xxx/chip.c                   |   6 +-
 drivers/net/dsa/mv88e6xxx/global1.c                |  31 --
 drivers/net/dsa/mv88e6xxx/global1.h                |   1 -
 drivers/net/dsa/mv88e6xxx/global2.c                |   2 +-
 drivers/net/dsa/mv88e6xxx/global2.h                |   1 +
 drivers/net/ethernet/ibm/ibmveth.c                 |  25 +-
 drivers/net/ethernet/qlogic/qed/qed_ll2.h          |   2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c  |   7 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |   1 +
 drivers/net/usb/smsc75xx.c                         |   4 +-
 drivers/net/wan/fsl_ucc_hdlc.c                     |  12 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       |   2 +-
 drivers/net/wireless/intel/iwlwifi/queue/tx.c      |   6 +-
 drivers/net/wireless/intel/iwlwifi/queue/tx.h      |   2 +-
 .../net/wireless/marvell/mwifiex/11n_rxreorder.c   |   4 +-
 drivers/net/wireless/marvell/mwifiex/sta_rx.c      |  16 +-
 .../net/wireless/mediatek/mt76/mt76x02_eeprom.c    |   7 -
 drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c |  13 +-
 drivers/of/dynamic.c                               |   6 +-
 drivers/ptp/ptp_ocp.c                              |   1 -
 drivers/s390/scsi/zfcp_aux.c                       |   9 +-
 drivers/spi/spi-zynqmp-gqspi.c                     |  18 +-
 drivers/target/target_core_device.c                |  11 +-
 drivers/vhost/vringh.c                             |  12 +-
 fs/btrfs/super.c                                   |   4 +
 fs/ksmbd/smb2pdu.c                                 |   4 +-
 fs/nfs/nfs4proc.c                                  |   4 +-
 fs/nfs/nfs4state.c                                 |  47 ++-
 fs/nfs/sysfs.c                                     |  16 +-
 include/linux/bpf.h                                |   2 +-
 include/linux/netfilter/nf_conntrack_sctp.h        |   1 +
 include/net/tcp.h                                  |   6 +-
 kernel/trace/ring_buffer.c                         |  32 +-
 net/core/neighbour.c                               |   4 +-
 net/core/sock_map.c                                |   4 +
 net/ipv4/route.c                                   |   2 +
 net/ipv4/tcp_input.c                               |  13 +
 net/ipv4/tcp_output.c                              |   7 +-
 net/l2tp/l2tp_ip6.c                                |   2 +-
 net/netfilter/ipvs/ip_vs_sync.c                    |   4 +-
 net/netfilter/nf_conntrack_proto_sctp.c            |  43 ++-
 net/netfilter/nft_set_rbtree.c                     |  46 ++-
 net/nfc/llcp_core.c                                |   2 +
 net/rds/tcp_connect.c                              |   2 +-
 net/sctp/associola.c                               |   3 +-
 net/sctp/socket.c                                  |   1 +
 net/socket.c                                       |  29 +-
 net/tipc/crypto.c                                  |   4 +-
 scripts/mod/file2alias.c                           |   2 +-
 security/integrity/ima/Kconfig                     |  22 +-
 sound/soc/soc-utils.c                              |   1 +
 sound/soc/tegra/tegra_audio_graph_card.c           |  30 +-
 88 files changed, 649 insertions(+), 473 deletions(-)


