Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095AE7C40C3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343885AbjJJUF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbjJJUEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:04:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020A11AE;
        Tue, 10 Oct 2023 13:04:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0087DC433C8;
        Tue, 10 Oct 2023 20:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696968260;
        bh=ntAjcUu1OhTunGKjKvp/+hcCteiyCQO9kp8AbYJiajE=;
        h=From:To:Cc:Subject:Date:From;
        b=AZYsgNM0dTnHJkylDuAcqCCgp27h8fnmyWbqO+N77F93qA1Og2XI2M82vXpqGU8h3
         Ce0gRD61FOEoJaVepDRoALSEpH4gue3+f/7Pnmh5Pl3PZKUhK/iU/zedFxh04JuF/g
         Yuwcpzyxe6gkfVmWO/e5DmtnWlmZMtdwymy/pqfk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.135
Date:   Tue, 10 Oct 2023 22:04:09 +0200
Message-ID: <2023101010-mobilize-enclose-80b7@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 5.15.135 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                             |    2 
 arch/arm64/include/asm/cpufeature.h                  |    6 
 arch/arm64/include/asm/cputype.h                     |    2 
 arch/parisc/include/asm/ldcw.h                       |   36 -
 arch/parisc/include/asm/spinlock_types.h             |    5 
 block/blk-core.c                                     |    2 
 block/blk-sysfs.c                                    |    2 
 drivers/base/regmap/regcache-rbtree.c                |    3 
 drivers/block/rbd.c                                  |  412 ++++++++++---------
 drivers/clk/imx/clk-pll14xx.c                        |    2 
 drivers/gpio/gpio-aspeed.c                           |    2 
 drivers/gpio/gpio-pxa.c                              |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c           |    2 
 drivers/hid/hid-sony.c                               |    2 
 drivers/hid/intel-ish-hid/ipc/pci-ish.c              |    8 
 drivers/infiniband/core/cma.c                        |    2 
 drivers/infiniband/core/cma_configfs.c               |    2 
 drivers/infiniband/core/nldev.c                      |    1 
 drivers/infiniband/core/uverbs_main.c                |    2 
 drivers/infiniband/hw/mlx4/sysfs.c                   |    2 
 drivers/infiniband/hw/mlx5/main.c                    |    2 
 drivers/infiniband/sw/siw/siw_cm.c                   |   16 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c          |   18 
 drivers/md/dm-zoned-target.c                         |   15 
 drivers/mtd/ubi/build.c                              |    7 
 drivers/net/dsa/mv88e6xxx/chip.c                     |    6 
 drivers/net/dsa/mv88e6xxx/global1.c                  |   31 -
 drivers/net/dsa/mv88e6xxx/global1.h                  |    1 
 drivers/net/dsa/mv88e6xxx/global2.c                  |    2 
 drivers/net/dsa/mv88e6xxx/global2.h                  |    1 
 drivers/net/ethernet/ibm/ibmveth.c                   |   25 -
 drivers/net/ethernet/qlogic/qed/qed_ll2.h            |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c    |    7 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c             |    1 
 drivers/net/usb/smsc75xx.c                           |    4 
 drivers/net/wan/fsl_ucc_hdlc.c                       |   12 
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c          |    2 
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h   |    6 
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c          |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c     |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c          |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c          |    4 
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c        |    4 
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c        |    2 
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h   |    2 
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c         |    2 
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c      |    2 
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c         |    2 
 drivers/net/wireless/intel/iwlwifi/queue/tx.c        |    6 
 drivers/net/wireless/intel/iwlwifi/queue/tx.h        |    2 
 drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c |    4 
 drivers/net/wireless/marvell/mwifiex/sta_rx.c        |   16 
 drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c  |    7 
 drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c   |   13 
 drivers/of/dynamic.c                                 |    6 
 drivers/ptp/ptp_ocp.c                                |    1 
 drivers/s390/scsi/zfcp_aux.c                         |    9 
 drivers/spi/spi-zynqmp-gqspi.c                       |   18 
 drivers/target/target_core_device.c                  |   11 
 drivers/vhost/vringh.c                               |   12 
 drivers/xen/events/events_base.c                     |   87 ++--
 fs/ksmbd/smb2pdu.c                                   |    4 
 fs/nfs/nfs4proc.c                                    |    4 
 fs/nfs/nfs4state.c                                   |   47 +-
 fs/nfs/sysfs.c                                       |   16 
 include/linux/bpf.h                                  |    2 
 include/linux/netfilter/nf_conntrack_sctp.h          |    1 
 include/net/tcp.h                                    |    6 
 kernel/trace/ring_buffer.c                           |   32 -
 net/core/neighbour.c                                 |    4 
 net/core/sock_map.c                                  |    4 
 net/ipv4/route.c                                     |    2 
 net/ipv4/tcp_input.c                                 |   13 
 net/ipv4/tcp_output.c                                |    7 
 net/l2tp/l2tp_ip6.c                                  |    2 
 net/netfilter/ipvs/ip_vs_sync.c                      |    4 
 net/netfilter/nf_conntrack_proto_sctp.c              |   43 +
 net/netfilter/nft_set_rbtree.c                       |   46 +-
 net/nfc/llcp_core.c                                  |    2 
 net/rds/tcp_connect.c                                |    2 
 net/sctp/associola.c                                 |    3 
 net/sctp/socket.c                                    |    1 
 net/socket.c                                         |   29 +
 net/tipc/crypto.c                                    |    4 
 scripts/mod/file2alias.c                             |    2 
 security/integrity/ima/Kconfig                       |   22 -
 sound/soc/soc-utils.c                                |    1 
 sound/soc/tegra/tegra_audio_graph_card.c             |   30 -
 88 files changed, 690 insertions(+), 513 deletions(-)

Alexandra Diupina (1):
      drivers/net: process the result of hdlc_open() and add call of hdlc_close() in uhdlc_close()

Arnd Bergmann (2):
      wifi: iwlwifi: dbg_ini: fix structure packing
      ima: rework CONFIG_IMA dependency block

Bartosz Golaszewski (1):
      gpio: aspeed: fix the GPIO number passed to pinctrl_gpio_set_config()

Ben Wolsieffer (1):
      net: stmmac: dwmac-stm32: fix resume on STM32 MCU

Benjamin Coddington (2):
      NFS: Cleanup unused rpc_clnt variable
      NFS: rename nfs_client_kset to nfs_kset

Benjamin Poirier (1):
      ipv4: Set offload_failed flag in fibmatch results

Bernard Metzler (1):
      RDMA/siw: Fix connection failure handling

Chengfeng Ye (1):
      tipc: fix a potential deadlock on &tx->lock

Christophe JAILLET (3):
      HID: sony: Fix a potential memory leak in sony_probe()
      wifi: iwlwifi: mvm: Fix a memory corruption issue
      IB/mlx4: Fix the size of a buffer in add_port_entries()

Dan Carpenter (2):
      net: ethernet: ti: am65-cpsw: Fix error code in am65_cpsw_nuss_init_tx_chns()
      of: dynamic: Fix potential memory leak in of_changeset_action()

David Howells (1):
      ipv4, ipv6: Fix handling of transhdrlen in __ip{,6}_append_data()

David Wilder (1):
      ibmveth: Remove condition to recompute TCP header checksum.

Dinghao Liu (2):
      scsi: zfcp: Fix a double put in zfcp_port_enqueue()
      ptp: ocp: Fix error handling in ptp_ocp_device_init

Duje Mihanović (1):
      gpio: pxa: disable pinctrl calls for MMP_GPIO

Eric Dumazet (1):
      net: fix possible store tearing in neigh_periodic_work()

Fabio Estevam (1):
      net: dsa: mv88e6xxx: Avoid EEPROM timeout when EEPROM is absent

Fedor Pchelkin (1):
      dm zoned: free dmz->ddev array in dmz_put_zoned_devices

Felix Fietkau (1):
      wifi: mt76: mt76x02: fix MT76x0 external LNA gain handling

Florian Westphal (1):
      netfilter: nf_tables: nft_set_rbtree: fix spurious insertion failure

Gabriel Krisman Bertazi (1):
      arm64: Avoid repeated AA64MMFR1_EL1 register read on pagefault path

Greg Kroah-Hartman (2):
      Revert "clk: imx: pll14xx: dynamically configure PLL for 393216000/361267200Hz"
      Linux 5.15.135

Gustavo A. R. Silva (2):
      qed/red_ll2: Fix undefined behavior bug in struct qed_ll2_info
      wifi: mwifiex: Fix tlv_buf_left calculation

Ilya Dryomov (4):
      rbd: move rbd_dev_refresh() definition
      rbd: decouple header read-in from updating rbd_dev->header
      rbd: decouple parent info read-in from updating rbd_dev
      rbd: take header_rwsem in rbd_dev_refresh() only when updating

Jakub Sitnicki (1):
      bpf, sockmap: Reject sk_msg egress redirects to non-TCP sockets

Jeremy Cline (1):
      net: nfc: llcp: Add lock when modifying device list

Jiri Kosina (1):
      HID: sony: remove duplicate NULL check before calling usb_free_urb()

Johan Hovold (1):
      spi: zynqmp-gqspi: fix clock imbalance on probe failure

Johannes Berg (1):
      iwlwifi: avoid void pointer arithmetic

John David Anglin (1):
      parisc: Restore __ldcw_align for PA-RISC 2.0 processors

Jordan Rife (2):
      net: replace calls to sock->ops->connect() with kernel_connect()
      net: prevent rewrite of msg_name in sock_sendmsg()

Juergen Gross (1):
      xen/events: replace evtchn_rwlock with RCU

Junxiao Bi (1):
      scsi: target: core: Fix deadlock due to recursive locking

Konstantin Meskhidze (1):
      RDMA/uverbs: Fix typo of sizeof argument

Leon Hwang (1):
      bpf: Fix tr dereferencing

Leon Romanovsky (2):
      RDMA/core: Require admin capabilities to set system parameters
      RDMA/cma: Fix truncation compilation warning in make_cma_ports

Mario Limonciello (1):
      drm/amd: Fix detection of _PR3 on the PCIe root port

Mark Zhang (1):
      RDMA/cma: Initialize ib_sa_multicast structure to 0 when join

Mauricio Faria de Oliveira (1):
      modpost: add missing else to the "of" check

Ming Lei (1):
      block: fix use-after-free of q->q_usage_counter

Neal Cardwell (2):
      tcp: fix quick-ack counting to count actual ACKs of new data
      tcp: fix delayed ACKs for MSS boundary condition

Oleksandr Tymoshenko (1):
      ima: Finish deprecation of IMA_TRUSTED_KEYRING Kconfig

Pin-yen Lin (1):
      wifi: mwifiex: Fix oob check condition in mwifiex_process_rx_packet

Richard Fitzgerald (1):
      regmap: rbtree: Fix wrong register marked as in-cache when creating new node

Rob Herring (1):
      arm64: Add Cortex-A520 CPU part definition

Robin Murphy (2):
      iommu/arm-smmu-v3: Set TTL invalidation hint better
      iommu/arm-smmu-v3: Avoid constructing invalid range commands

Sameer Pujar (2):
      ASoC: soc-utils: Export snd_soc_dai_is_dummy() symbol
      ASoC: tegra: Fix redundant PLLA and PLLA_OUT0 updates

Shay Drory (1):
      RDMA/mlx5: Fix NULL string error

Shigeru Yoshida (1):
      net: usb: smsc75xx: Fix uninit-value access in __smsc75xx_read_reg

Srinivas Pandruvada (1):
      HID: intel-ish-hid: ipc: Disable and reenable ACPI GPE bit

Stefano Garzarella (1):
      vringh: don't use vringh_kiov_advance() in vringh_iov_xfer()

Trond Myklebust (2):
      NFSv4: Fix a state manager thread deadlock regression
      NFSv4: Fix a nfs4_state_manager() race

Uwe Kleine-König (1):
      spi: zynqmp-gqspi: Convert to platform remove callback returning void

Vlastimil Babka (1):
      ring-buffer: remove obsolete comment for free_buffer_page()

Xin Long (3):
      netfilter: handle the connecting collision properly in nf_conntrack_proto_sctp
      sctp: update transport state when processing a dupcook packet
      sctp: update hb timer immediately after users change hb_interval

Zheng Yejian (1):
      ring-buffer: Fix bytes info in per_cpu buffer stats

Zhihao Cheng (1):
      ubi: Refuse attaching if mtd's erasesize is 0

luosili (1):
      ksmbd: fix uaf in smb20_oplock_break_ack

