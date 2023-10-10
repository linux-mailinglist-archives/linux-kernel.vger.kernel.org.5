Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EAA7C40FC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbjJJURn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbjJJURj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:17:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB77198B;
        Tue, 10 Oct 2023 13:08:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724B0C433CA;
        Tue, 10 Oct 2023 20:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696968486;
        bh=nT7PjWC1BmwEIMjzSMQINXRGH6vPBZms3MTG7aHF4X0=;
        h=From:To:Cc:Subject:Date:From;
        b=sJdUgCtQ1FMGhKc+V8ZmtrWoLuxfI8pFX1iDcyf0tEhoc6aHd+LUuhH8ZaTAM8gSW
         y7MdN3tDTt1RfXVC6YJsgbjH+7Bdvo3SkKDncbPFkyaK2WuOHmKXUrVHD1NI3PytGx
         KxeqrqmEhEfFgb2pouJY7EMg3IJ89wAn8VhAyDBg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.57
Date:   Tue, 10 Oct 2023 22:08:02 +0200
Message-ID: <2023101003-ointment-overstay-26d2@gregkh>
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

I'm announcing the release of the 6.1.57 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/arm64/silicon-errata.rst                  |    2 
 Documentation/networking/ip-sysctl.rst                  |    8 
 Makefile                                                |    2 
 arch/arm64/Kconfig                                      |   13 
 arch/arm64/include/asm/cpufeature.h                     |    8 
 arch/arm64/include/asm/cputype.h                        |    2 
 arch/arm64/kernel/cpu_errata.c                          |    8 
 arch/arm64/kernel/cpufeature.c                          |    3 
 arch/arm64/kernel/entry.S                               |    4 
 arch/arm64/tools/cpucaps                                |    1 
 arch/arm64/tools/sysreg                                 |    6 
 arch/parisc/include/asm/ldcw.h                          |   36 -
 arch/parisc/include/asm/spinlock_types.h                |    5 
 arch/parisc/kernel/smp.c                                |    4 
 arch/x86/events/amd/core.c                              |   24 
 arch/x86/kernel/sev-shared.c                            |   69 ++
 block/blk-sysfs.c                                       |    3 
 drivers/ata/libata-core.c                               |   16 
 drivers/ata/libata-scsi.c                               |   43 -
 drivers/base/regmap/regcache-rbtree.c                   |    3 
 drivers/block/rbd.c                                     |  412 ++++++++--------
 drivers/firewire/sbp2.c                                 |    9 
 drivers/gpio/gpio-aspeed.c                              |    2 
 drivers/gpio/gpio-pxa.c                                 |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c              |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c       |   93 +++
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c |   41 -
 drivers/hid/hid-sony.c                                  |    2 
 drivers/hid/intel-ish-hid/ipc/pci-ish.c                 |    8 
 drivers/hwmon/nzxt-smart2.c                             |    2 
 drivers/idle/intel_idle.c                               |    2 
 drivers/infiniband/core/cma.c                           |    2 
 drivers/infiniband/core/cma_configfs.c                  |    2 
 drivers/infiniband/core/nldev.c                         |    1 
 drivers/infiniband/core/uverbs_main.c                   |    2 
 drivers/infiniband/hw/mlx4/sysfs.c                      |    2 
 drivers/infiniband/hw/mlx5/fs.c                         |    2 
 drivers/infiniband/hw/mlx5/main.c                       |    2 
 drivers/infiniband/sw/siw/siw_cm.c                      |   16 
 drivers/infiniband/ulp/srp/ib_srp.c                     |   16 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c             |   18 
 drivers/iommu/intel/iommu.c                             |   16 
 drivers/iommu/intel/iommu.h                             |    2 
 drivers/iommu/mtk_iommu.c                               |    9 
 drivers/leds/led-core.c                                 |    4 
 drivers/md/dm-zoned-target.c                            |   15 
 drivers/md/raid5.c                                      |    7 
 drivers/mtd/ubi/build.c                                 |    7 
 drivers/net/dsa/mv88e6xxx/chip.c                        |    6 
 drivers/net/dsa/mv88e6xxx/global1.c                     |   31 -
 drivers/net/dsa/mv88e6xxx/global1.h                     |    1 
 drivers/net/dsa/mv88e6xxx/global2.c                     |    2 
 drivers/net/dsa/mv88e6xxx/global2.h                     |    1 
 drivers/net/ethernet/ibm/ibmveth.c                      |   25 
 drivers/net/ethernet/intel/i40e/i40e_ptp.c              |    4 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c             |    4 
 drivers/net/ethernet/qlogic/qed/qed_ll2.h               |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c       |    7 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                |    1 
 drivers/net/usb/smsc75xx.c                              |    4 
 drivers/net/vrf.c                                       |   12 
 drivers/net/vxlan/vxlan_core.c                          |    4 
 drivers/net/wan/fsl_ucc_hdlc.c                          |   12 
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h      |    6 
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c             |    2 
 drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c    |    4 
 drivers/net/wireless/marvell/mwifiex/sta_rx.c           |   16 
 drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c     |    7 
 drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c      |   13 
 drivers/of/dynamic.c                                    |    6 
 drivers/pci/controller/dwc/pcie-qcom.c                  |    4 
 drivers/ptp/ptp_ocp.c                                   |    1 
 drivers/regulator/core.c                                |    4 
 drivers/regulator/mt6358-regulator.c                    |  153 ++---
 drivers/s390/scsi/zfcp_aux.c                            |    9 
 drivers/scsi/aacraid/commsup.c                          |    2 
 drivers/scsi/mvumi.c                                    |    2 
 drivers/scsi/scsi_lib.c                                 |    2 
 drivers/scsi/scsi_priv.h                                |    1 
 drivers/scsi/scsi_scan.c                                |   20 
 drivers/scsi/scsi_sysfs.c                               |    4 
 drivers/scsi/sd.c                                       |  110 +++-
 drivers/scsi/sd.h                                       |    1 
 drivers/scsi/smartpqi/smartpqi_init.c                   |    2 
 drivers/scsi/storvsc_drv.c                              |    2 
 drivers/scsi/virtio_scsi.c                              |    2 
 drivers/spi/spi-zynqmp-gqspi.c                          |   12 
 drivers/target/target_core_device.c                     |   11 
 drivers/vhost/vringh.c                                  |   12 
 drivers/xen/events/events_base.c                        |   87 +--
 fs/btrfs/ctree.h                                        |   28 -
 fs/btrfs/dir-item.c                                     |   50 -
 fs/btrfs/file.c                                         |   16 
 fs/btrfs/inode-item.c                                   |   73 +-
 fs/btrfs/inode-item.h                                   |   20 
 fs/btrfs/inode.c                                        |  267 ++++++----
 fs/btrfs/ioctl.c                                        |    7 
 fs/btrfs/root-tree.c                                    |   19 
 fs/btrfs/send.c                                         |   12 
 fs/btrfs/super.c                                        |    3 
 fs/btrfs/transaction.c                                  |   40 +
 fs/btrfs/tree-log.c                                     |  279 +++++-----
 fs/btrfs/tree-log.h                                     |    4 
 fs/erofs/decompressor_lzma.c                            |    5 
 fs/nfs/nfs4proc.c                                       |   10 
 fs/nfs/nfs4state.c                                      |   47 +
 fs/nfs/sysfs.c                                          |   16 
 fs/smb/client/connect.c                                 |   10 
 fs/smb/server/connection.c                              |    2 
 fs/smb/server/connection.h                              |    1 
 fs/smb/server/mgmt/user_session.c                       |   10 
 fs/smb/server/smb2pdu.c                                 |    4 
 include/linux/bpf.h                                     |    2 
 include/linux/ipv6.h                                    |    1 
 include/linux/mm.h                                      |    2 
 include/linux/netfilter/nf_conntrack_sctp.h             |    1 
 include/linux/regulator/mt6358-regulator.h              |    4 
 include/net/arp.h                                       |    8 
 include/net/cfg80211.h                                  |   99 +++
 include/net/ndisc.h                                     |   12 
 include/net/neighbour.h                                 |   10 
 include/net/netlink.h                                   |   21 
 include/net/nexthop.h                                   |   23 
 include/net/tcp.h                                       |    6 
 include/scsi/scsi_device.h                              |    6 
 include/scsi/scsi_host.h                                |    2 
 include/uapi/linux/bpf.h                                |    6 
 include/uapi/linux/ipv6.h                               |    1 
 kernel/trace/ring_buffer.c                              |   32 -
 mm/memory.c                                             |   10 
 mm/mempolicy.c                                          |  122 ++--
 mm/page_alloc.c                                         |  138 ++---
 net/bluetooth/hci_core.c                                |    1 
 net/bluetooth/hci_event.c                               |    1 
 net/bluetooth/hci_request.h                             |    2 
 net/bluetooth/hci_sync.c                                |   14 
 net/bluetooth/iso.c                                     |    9 
 net/bridge/br_arp_nd_proxy.c                            |    4 
 net/bridge/br_netfilter_hooks.c                         |    5 
 net/core/filter.c                                       |   59 +-
 net/core/neighbour.c                                    |  106 ++--
 net/core/sock_map.c                                     |    4 
 net/ipv4/arp.c                                          |    8 
 net/ipv4/fib_semantics.c                                |    8 
 net/ipv4/ip_output.c                                    |    6 
 net/ipv4/nexthop.c                                      |   12 
 net/ipv4/route.c                                        |    8 
 net/ipv4/tcp.c                                          |   10 
 net/ipv4/tcp_bpf.c                                      |    4 
 net/ipv4/tcp_input.c                                    |   13 
 net/ipv4/tcp_output.c                                   |    7 
 net/ipv6/addrconf.c                                     |   27 -
 net/ipv6/ip6_fib.c                                      |   16 
 net/ipv6/ip6_output.c                                   |   12 
 net/ipv6/ndisc.c                                        |   17 
 net/ipv6/route.c                                        |   22 
 net/ipv6/tcp_ipv6.c                                     |   10 
 net/l2tp/l2tp_ip6.c                                     |    2 
 net/mac80211/cfg.c                                      |    3 
 net/mac80211/key.c                                      |    2 
 net/mptcp/pm_netlink.c                                  |    2 
 net/mptcp/pm_userspace.c                                |    6 
 net/mptcp/protocol.c                                    |  177 ++++--
 net/mptcp/protocol.h                                    |   24 
 net/mptcp/subflow.c                                     |   41 -
 net/netfilter/ipvs/ip_vs_sync.c                         |    4 
 net/netfilter/nf_conntrack_proto_sctp.c                 |   43 +
 net/netfilter/nf_tables_api.c                           |   44 +
 net/netfilter/nft_set_rbtree.c                          |   46 +
 net/netlink/af_netlink.c                                |   37 -
 net/nfc/llcp_core.c                                     |    2 
 net/rds/tcp_connect.c                                   |    2 
 net/sctp/associola.c                                    |    3 
 net/sctp/socket.c                                       |    1 
 net/socket.c                                            |   29 -
 net/tipc/crypto.c                                       |    4 
 net/wireless/core.c                                     |  150 +++++
 net/wireless/core.h                                     |   14 
 net/wireless/nl80211.c                                  |   93 ++-
 net/wireless/sme.c                                      |    4 
 net/wireless/sysfs.c                                    |    8 
 scripts/mod/file2alias.c                                |    2 
 security/integrity/ima/Kconfig                          |   22 
 sound/soc/soc-utils.c                                   |    1 
 sound/soc/tegra/tegra_audio_graph_card.c                |   30 -
 tools/include/uapi/linux/bpf.h                          |    6 
 tools/testing/selftests/netfilter/.gitignore            |    1 
 tools/testing/selftests/netfilter/Makefile              |    4 
 tools/testing/selftests/netfilter/audit_logread.c       |  165 ++++++
 tools/testing/selftests/netfilter/config                |    1 
 tools/testing/selftests/netfilter/nft_audit.sh          |  193 +++++++
 191 files changed, 2867 insertions(+), 1681 deletions(-)

Aleksandr Mezin (1):
      hwmon: (nzxt-smart2) add another USB ID

Alexandra Diupina (1):
      drivers/net: process the result of hdlc_open() and add call of hdlc_close() in uhdlc_close()

Arnd Bergmann (2):
      wifi: iwlwifi: dbg_ini: fix structure packing
      ima: rework CONFIG_IMA dependency block

Artem Bityutskiy (1):
      intel_idle: add Emerald Rapids Xeon support

Bart Van Assche (2):
      scsi: core: Improve type safety of scsi_rescan_device()
      RDMA/srp: Do not call scsi_done() from srp_abort()

Bartosz Golaszewski (1):
      gpio: aspeed: fix the GPIO number passed to pinctrl_gpio_set_config()

Ben Wolsieffer (1):
      net: stmmac: dwmac-stm32: fix resume on STM32 MCU

Benjamin Coddington (3):
      NFS: Cleanup unused rpc_clnt variable
      NFS: rename nfs_client_kset to nfs_kset
      Revert "NFSv4: Retry LOCK on OLD_STATEID during delegation return"

Benjamin Poirier (1):
      ipv4: Set offload_failed flag in fibmatch results

Bernard Metzler (1):
      RDMA/siw: Fix connection failure handling

Bernd Schubert (1):
      btrfs: file_remove_privs needs an exclusive lock in direct io write

Breno Leitao (1):
      perf/x86/amd: Do not WARN() on every IRQ

Chen-Yu Tsai (3):
      regulator: mt6358: Drop *_SSHUB regulators
      regulator: mt6358: Use linear voltage helpers for single range regulators
      regulator: mt6358: split ops for buck and linear range LDO regulators

Chengfeng Ye (1):
      tipc: fix a potential deadlock on &tx->lock

Christian Marangi (1):
      net: ethernet: mediatek: disable irq before schedule napi

Christophe JAILLET (4):
      HID: sony: Fix a potential memory leak in sony_probe()
      wifi: iwlwifi: mvm: Fix a memory corruption issue
      IB/mlx4: Fix the size of a buffer in add_port_entries()
      btrfs: fix an error handling path in btrfs_rename()

Damien Le Moal (5):
      ata,scsi: do not issue START STOP UNIT on resume
      scsi: sd: Differentiate system and runtime start/stop management
      scsi: sd: Do not issue commands to suspended disks on shutdown
      scsi: Do not attempt to rescan suspended devices
      ata: libata-scsi: Fix delayed scsi_rescan_device() execution

Dan Carpenter (2):
      net: ethernet: ti: am65-cpsw: Fix error code in am65_cpsw_nuss_init_tx_chns()
      of: dynamic: Fix potential memory leak in of_changeset_action()

David Howells (1):
      ipv4, ipv6: Fix handling of transhdrlen in __ip{,6}_append_data()

David Jeffery (1):
      md/raid5: release batch_last before waiting for another stripe_head

David Wilder (1):
      ibmveth: Remove condition to recompute TCP header checksum.

Dinghao Liu (2):
      scsi: zfcp: Fix a double put in zfcp_port_enqueue()
      ptp: ocp: Fix error handling in ptp_ocp_device_init

Duje Mihanović (1):
      gpio: pxa: disable pinctrl calls for MMP_GPIO

Eric Dumazet (8):
      mptcp: annotate lockless accesses to sk->sk_err
      net: fix possible store tearing in neigh_periodic_work()
      neighbour: annotate lockless accesses to n->nud_state
      neighbour: switch to standard rcu, instead of rcu_bh
      neighbour: fix data-races around n->output
      netlink: annotate data-races around sk->sk_err
      ipv6: remove nexthop_fib6_nh_bh()
      ipv6: remove one read_lock()/read_unlock() pair in rt6_check_neigh()

Fabio Estevam (1):
      net: dsa: mv88e6xxx: Avoid EEPROM timeout when EEPROM is absent

Fedor Pchelkin (1):
      dm zoned: free dmz->ddev array in dmz_put_zoned_devices

Felix Fietkau (1):
      wifi: mt76: mt76x02: fix MT76x0 external LNA gain handling

Filipe Manana (1):
      btrfs: fix fscrypt name leak after failure to join log transaction

Florian Westphal (1):
      netfilter: nf_tables: nft_set_rbtree: fix spurious insertion failure

Gabriel Krisman Bertazi (1):
      arm64: Avoid repeated AA64MMFR1_EL1 register read on pagefault path

Gao Xiang (1):
      erofs: fix memory leak of LZMA global compressed deduplication

Geliang Tang (1):
      mptcp: userspace pm allow creating id 0 subflow

Greg Kroah-Hartman (1):
      Linux 6.1.57

Gustavo A. R. Silva (2):
      qed/red_ll2: Fix undefined behavior bug in struct qed_ll2_info
      wifi: mwifiex: Fix tlv_buf_left calculation

Hamdan Igbaria (1):
      RDMA/mlx5: Fix mutex unlocking on error flow for steering anchor creation

Helge Deller (1):
      parisc: Fix crash with nr_cpus=1 option

Herman Fries (1):
      hwmon: (nzxt-smart2) Add device id

Ido Schimmel (1):
      vrf: Fix lockdep splat in output path

Ilya Dryomov (4):
      rbd: move rbd_dev_refresh() definition
      rbd: decouple header read-in from updating rbd_dev->header
      rbd: decouple parent info read-in from updating rbd_dev
      rbd: take header_rwsem in rbd_dev_refresh() only when updating

Ilya Maximets (1):
      ipv6: tcp: add a missing nf_reset_ct() in 3WHS handling

Jakub Kicinski (2):
      netlink: split up copies in the ack construction
      netlink: remove the flex array from struct nlmsghdr

Jakub Sitnicki (1):
      bpf, sockmap: Reject sk_msg egress redirects to non-TCP sockets

Jeremy Cline (1):
      net: nfc: llcp: Add lock when modifying device list

Jiri Kosina (1):
      HID: sony: remove duplicate NULL check before calling usb_free_urb()

Johan Hovold (1):
      spi: zynqmp-gqspi: fix clock imbalance on probe failure

Johannes Berg (6):
      wifi: cfg80211: hold wiphy lock in auto-disconnect
      wifi: cfg80211: move wowlan disable under locks
      wifi: cfg80211: add a work abstraction with special semantics
      wifi: cfg80211: fix cqm_config access race
      wifi: cfg80211: add missing kernel-doc for cqm_rssi_work
      wifi: mac80211: fix potential key use-after-free

Johannes Weiner (1):
      mm: page_alloc: fix CMA and HIGHATOMIC landing on the wrong buddy list

John David Anglin (1):
      parisc: Restore __ldcw_align for PA-RISC 2.0 processors

John Fastabend (2):
      bpf: tcp_read_skb needs to pop skb regardless of seq
      bpf, sockmap: Do not inc copied_seq when PEEK flag set

Jordan Rife (3):
      net: replace calls to sock->ops->connect() with kernel_connect()
      net: prevent rewrite of msg_name in sock_sendmsg()
      smb: use kernel_connect() and kernel_bind()

Juergen Gross (1):
      xen/events: replace evtchn_rwlock with RCU

Junxiao Bi (1):
      scsi: target: core: Fix deadlock due to recursive locking

Konstantin Meskhidze (1):
      RDMA/uverbs: Fix typo of sizeof argument

Kristina Martsenko (1):
      arm64: cpufeature: Fix CLRBHB and BC detection

Leon Hwang (1):
      bpf: Fix tr dereferencing

Leon Romanovsky (2):
      RDMA/core: Require admin capabilities to set system parameters
      RDMA/cma: Fix truncation compilation warning in make_cma_ports

Luiz Augusto von Dentz (3):
      Bluetooth: hci_codec: Fix leaking content of local_codecs
      Bluetooth: hci_sync: Fix handling of HCI_QUIRK_STRICT_DUPLICATE_FILTER
      Bluetooth: ISO: Fix handling of listen for unicast

Marek Behún (1):
      leds: Drop BUG_ON check for LED_COLOR_ID_MULTI

Mario Limonciello (2):
      drm/amd: Fix detection of _PR3 on the PCIe root port
      drm/amd: Fix logic error in sienna_cichlid_update_pcie_parameters()

Mark Zhang (1):
      RDMA/cma: Initialize ib_sa_multicast structure to 0 when join

Martin KaFai Lau (1):
      bpf: Add BPF_FIB_LOOKUP_SKIP_NEIGH for bpf_fib_lookup

Mauricio Faria de Oliveira (1):
      modpost: add missing else to the "of" check

Mel Gorman (2):
      mm/page_alloc: always remove pages from temporary list
      mm/page_alloc: leave IRQs enabled for per-cpu page allocations

Michał Mirosław (1):
      regulator/core: regulator_register: set device->class earlier

Ming Lei (1):
      block: fix use-after-free of q->q_usage_counter

Namjae Jeon (1):
      ksmbd: fix race condition between session lookup and expire

Neal Cardwell (2):
      tcp: fix quick-ack counting to count actual ACKs of new data
      tcp: fix delayed ACKs for MSS boundary condition

Oleksandr Tymoshenko (1):
      ima: Finish deprecation of IMA_TRUSTED_KEYRING Kconfig

Paolo Abeni (4):
      mptcp: rename timer related helper to less confusing names
      mptcp: fix dangling connection hang-up
      mptcp: move __mptcp_error_report in protocol.c
      mptcp: process pending subflow error on close

Patrick Rohr (3):
      net: add sysctl accept_ra_min_rtr_lft
      net: change accept_ra_min_rtr_lft to affect all RA lifetimes
      net: release reference to inet6_dev pointer

Phil Sutter (3):
      selftests: netfilter: Test nf_tables audit logging
      selftests: netfilter: Extend nft_audit.sh
      netfilter: nf_tables: Deduplicate nft_register_obj audit logs

Pin-yen Lin (1):
      wifi: mwifiex: Fix oob check condition in mwifiex_process_rx_packet

Richard Fitzgerald (1):
      regmap: rbtree: Fix wrong register marked as in-cache when creating new node

Rob Herring (2):
      arm64: Add Cortex-A520 CPU part definition
      arm64: errata: Add Cortex-A520 speculative unprivileged load workaround

Robin Murphy (2):
      iommu/arm-smmu-v3: Set TTL invalidation hint better
      iommu/arm-smmu-v3: Avoid constructing invalid range commands

Sameer Pujar (2):
      ASoC: soc-utils: Export snd_soc_dai_is_dummy() symbol
      ASoC: tegra: Fix redundant PLLA and PLLA_OUT0 updates

Sandipan Das (1):
      perf/x86/amd/core: Fix overflow reset on hotplug

Shay Drory (1):
      RDMA/mlx5: Fix NULL string error

Shigeru Yoshida (1):
      net: usb: smsc75xx: Fix uninit-value access in __smsc75xx_read_reg

Sricharan Ramabadhran (1):
      PCI: qcom: Fix IPQ8074 enumeration

Srinivas Pandruvada (1):
      HID: intel-ish-hid: ipc: Disable and reenable ACPI GPE bit

Stefano Garzarella (1):
      vringh: don't use vringh_kiov_advance() in vringh_iov_xfer()

Sweet Tea Dorminy (3):
      btrfs: use struct qstr instead of name and namelen pairs
      btrfs: setup qstr from dentrys using fscrypt helper
      btrfs: use struct fscrypt_str instead of struct qstr

Tao Chen (1):
      netlink: Fix potential skb memleak in netlink_ack

Tom Lendacky (1):
      x86/sev: Use the GHCB protocol when available for SNP CPUID requests

Trond Myklebust (2):
      NFSv4: Fix a state manager thread deadlock regression
      NFSv4: Fix a nfs4_state_manager() race

Vishal Moola (Oracle) (4):
      mm/memory: add vm_normal_folio()
      mm/mempolicy: convert queue_pages_pmd() to queue_folios_pmd()
      mm/mempolicy: convert queue_pages_pte_range() to queue_folios_pte_range()
      mm/mempolicy: convert migrate_page_add() to migrate_folio_add()

Vlastimil Babka (1):
      ring-buffer: remove obsolete comment for free_buffer_page()

Wayne Lin (1):
      drm/amd/display: Adjust the MST resume flow

Xin Long (3):
      netfilter: handle the connecting collision properly in nf_conntrack_proto_sctp
      sctp: update transport state when processing a dupcook packet
      sctp: update hb timer immediately after users change hb_interval

Yajun Deng (1):
      i40e: fix the wrong PTP frequency calculation

Yang Shi (1):
      mm: mempolicy: keep VMA walk if both MPOL_MF_STRICT and MPOL_MF_MOVE are specified

Yao Xiao (1):
      Bluetooth: Delete unused hci_req_prepare_suspend() declaration

Yong Wu (1):
      iommu/mediatek: Fix share pgtable for iova over 4GB

Zhang Rui (1):
      iommu/vt-d: Avoid memory allocation in iommu_suspend()

Zheng Yejian (1):
      ring-buffer: Fix bytes info in per_cpu buffer stats

Zhihao Cheng (1):
      ubi: Refuse attaching if mtd's erasesize is 0

luosili (1):
      ksmbd: fix uaf in smb20_oplock_break_ack

