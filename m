Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B5A7C4101
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbjJJUST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234690AbjJJURn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:17:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AEB19B0;
        Tue, 10 Oct 2023 13:08:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190F7C433C8;
        Tue, 10 Oct 2023 20:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696968496;
        bh=Wny/TKaz27kS58nTTEA5bcUUHo64g7juPCpWpJnrJ1I=;
        h=From:To:Cc:Subject:Date:From;
        b=nsGDPYiMtifVMdyFAHdBORvBSROCi8YOTnSrj31HpdtfhiYXr+rcN3fZZyDFXTs4o
         pWFX14rw3w+u93Y29Hkrukn2Yw6pbzVKY/mpTpFAiG4OnyC/XviZTalwXEBAM1uBZy
         8j4Le/Pe8b9tO0BSkCVEvTV3p9GGvLATcsq5Z9kM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.5.7
Date:   Tue, 10 Oct 2023 22:08:08 +0200
Message-ID: <2023101009-thievish-improving-4453@gregkh>
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

I'm announcing the release of the 6.5.7 kernel.

All users of the 6.5 kernel series must upgrade.

The updated 6.5.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.5.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/arch/arm64/silicon-errata.rst                   |    2 
 Documentation/networking/ip-sysctl.rst                        |    8 
 Makefile                                                      |    2 
 arch/arm64/Kconfig                                            |   13 
 arch/arm64/include/asm/cpufeature.h                           |    2 
 arch/arm64/include/asm/cputype.h                              |    2 
 arch/arm64/include/asm/hwcap.h                                |    1 
 arch/arm64/include/uapi/asm/hwcap.h                           |    1 
 arch/arm64/kernel/cpu_errata.c                                |    8 
 arch/arm64/kernel/cpufeature.c                                |    4 
 arch/arm64/kernel/cpuinfo.c                                   |    1 
 arch/arm64/kernel/entry.S                                     |    4 
 arch/arm64/tools/cpucaps                                      |    1 
 arch/arm64/tools/sysreg                                       |    6 
 arch/parisc/include/asm/ldcw.h                                |   37 -
 arch/parisc/include/asm/spinlock_types.h                      |    5 
 arch/parisc/kernel/smp.c                                      |    4 
 arch/s390/net/bpf_jit_comp.c                                  |    2 
 arch/x86/events/amd/core.c                                    |   24 
 arch/x86/kernel/sev-shared.c                                  |   69 ++
 arch/x86/kernel/sev.c                                         |    3 
 drivers/ata/libata-core.c                                     |   16 
 drivers/ata/libata-scsi.c                                     |   33 -
 drivers/base/regmap/regcache-rbtree.c                         |    3 
 drivers/gpio/gpio-aspeed.c                                    |    2 
 drivers/gpio/gpio-pxa.c                                       |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                    |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c       |   41 -
 drivers/gpu/drm/i915/gt/gen8_engine_cs.c                      |   11 
 drivers/hid/Kconfig                                           |    1 
 drivers/hid/hid-nvidia-shield.c                               |    3 
 drivers/hid/hid-sony.c                                        |    2 
 drivers/hid/intel-ish-hid/ipc/pci-ish.c                       |    8 
 drivers/infiniband/core/cma.c                                 |    2 
 drivers/infiniband/core/cma_configfs.c                        |    2 
 drivers/infiniband/core/nldev.c                               |    1 
 drivers/infiniband/core/uverbs_main.c                         |    2 
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c                    |   11 
 drivers/infiniband/hw/mlx4/sysfs.c                            |    2 
 drivers/infiniband/hw/mlx5/fs.c                               |    2 
 drivers/infiniband/hw/mlx5/main.c                             |    2 
 drivers/infiniband/hw/mlx5/mr.c                               |   14 
 drivers/infiniband/sw/siw/siw_cm.c                            |   16 
 drivers/infiniband/ulp/srp/ib_srp.c                           |   16 
 drivers/iommu/apple-dart.c                                    |    3 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                   |   15 
 drivers/iommu/intel/iommu.c                                   |   16 
 drivers/iommu/intel/iommu.h                                   |    2 
 drivers/iommu/mtk_iommu.c                                     |    9 
 drivers/leds/led-core.c                                       |    4 
 drivers/md/dm-zoned-target.c                                  |   15 
 drivers/md/raid5.c                                            |    7 
 drivers/mtd/ubi/build.c                                       |    7 
 drivers/net/dsa/mv88e6xxx/chip.c                              |    6 
 drivers/net/dsa/mv88e6xxx/global1.c                           |   31 -
 drivers/net/dsa/mv88e6xxx/global1.h                           |    1 
 drivers/net/dsa/mv88e6xxx/global2.c                           |    2 
 drivers/net/dsa/mv88e6xxx/global2.h                           |    1 
 drivers/net/ethernet/ibm/ibmveth.c                            |   25 -
 drivers/net/ethernet/intel/ice/ice_virtchnl.c                 |   12 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                   |    4 
 drivers/net/ethernet/microchip/Kconfig                        |    1 
 drivers/net/ethernet/microsoft/mana/mana_en.c                 |  211 +++++---
 drivers/net/ethernet/qlogic/qed/qed_ll2.h                     |    2 
 drivers/net/ethernet/renesas/rswitch.c                        |   25 -
 drivers/net/ethernet/renesas/rswitch.h                        |    4 
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c             |    7 
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c         |    2 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                      |    1 
 drivers/net/usb/smsc75xx.c                                    |    4 
 drivers/net/wan/fsl_ucc_hdlc.c                                |   12 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h |    9 
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h            |    6 
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c                   |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c         |  121 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c                 |    2 
 drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c          |    4 
 drivers/net/wireless/marvell/mwifiex/sta_rx.c                 |   16 
 drivers/net/wireless/mediatek/mt76/dma.c                      |    8 
 drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c           |    7 
 drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c            |   13 
 drivers/net/wireless/realtek/rtw88/rtw8723d.h                 |    1 
 drivers/of/dynamic.c                                          |    6 
 drivers/pci/controller/dwc/pcie-qcom.c                        |    4 
 drivers/pci/pci-driver.c                                      |   14 
 drivers/platform/x86/intel/ifs/runtest.c                      |    7 
 drivers/ptp/ptp_ocp.c                                         |    1 
 drivers/regulator/core.c                                      |    4 
 drivers/regulator/mt6358-regulator.c                          |   18 
 drivers/s390/scsi/zfcp_aux.c                                  |    9 
 drivers/scsi/aacraid/commsup.c                                |    2 
 drivers/scsi/mvumi.c                                          |    2 
 drivers/scsi/scsi_lib.c                                       |    2 
 drivers/scsi/scsi_priv.h                                      |    1 
 drivers/scsi/scsi_scan.c                                      |   20 
 drivers/scsi/scsi_sysfs.c                                     |    4 
 drivers/scsi/smartpqi/smartpqi_init.c                         |    2 
 drivers/scsi/storvsc_drv.c                                    |    2 
 drivers/scsi/virtio_scsi.c                                    |    2 
 drivers/target/target_core_device.c                           |   11 
 drivers/vhost/vringh.c                                        |   12 
 drivers/xen/events/events_base.c                              |   87 +--
 fs/btrfs/btrfs_inode.h                                        |    3 
 fs/btrfs/extent_io.c                                          |   58 --
 fs/btrfs/extent_io.h                                          |    2 
 fs/btrfs/inode.c                                              |   47 -
 fs/btrfs/ordered-data.c                                       |    4 
 fs/btrfs/transaction.h                                        |    4 
 fs/erofs/decompressor_lzma.c                                  |    5 
 fs/erofs/super.c                                              |    2 
 fs/nfs/nfs4state.c                                            |    7 
 fs/overlayfs/super.c                                          |    9 
 fs/smb/client/connect.c                                       |   10 
 fs/smb/server/connection.c                                    |    2 
 fs/smb/server/connection.h                                    |    1 
 fs/smb/server/mgmt/user_session.c                             |   10 
 fs/smb/server/smb2pdu.c                                       |   16 
 include/linux/bpf.h                                           |    2 
 include/linux/ipv6.h                                          |    1 
 include/linux/maple_tree.h                                    |   11 
 include/linux/netfilter/nf_conntrack_sctp.h                   |    1 
 include/net/cfg80211.h                                        |    6 
 include/net/mana/mana.h                                       |    5 
 include/net/neighbour.h                                       |    2 
 include/net/tcp.h                                             |    6 
 include/scsi/scsi_host.h                                      |    2 
 include/uapi/linux/ipv6.h                                     |    1 
 io_uring/io_uring.c                                           |   16 
 io_uring/io_uring.h                                           |   41 +
 io_uring/kbuf.c                                               |   27 -
 kernel/bpf/verifier.c                                         |    8 
 lib/maple_tree.c                                              |  246 +++++++---
 lib/test_maple_tree.c                                         |   87 ++-
 net/bluetooth/hci_core.c                                      |    6 
 net/bluetooth/hci_event.c                                     |    1 
 net/bluetooth/hci_request.h                                   |    2 
 net/bluetooth/hci_sync.c                                      |   14 
 net/bluetooth/iso.c                                           |    9 
 net/bridge/br_netfilter_hooks.c                               |    2 
 net/core/neighbour.c                                          |   14 
 net/core/sock_map.c                                           |    4 
 net/ethtool/plca.c                                            |   45 +
 net/ipv4/route.c                                              |    2 
 net/ipv4/tcp.c                                                |   10 
 net/ipv4/tcp_bpf.c                                            |    4 
 net/ipv4/tcp_input.c                                          |   13 
 net/ipv4/tcp_output.c                                         |    7 
 net/ipv6/addrconf.c                                           |   13 
 net/ipv6/ndisc.c                                              |   13 
 net/ipv6/tcp_ipv6.c                                           |   10 
 net/l2tp/l2tp_ip6.c                                           |    2 
 net/mac80211/cfg.c                                            |    3 
 net/mac80211/ieee80211_i.h                                    |    2 
 net/mac80211/key.c                                            |    2 
 net/mac80211/mesh.c                                           |    8 
 net/mac80211/mlme.c                                           |   18 
 net/mptcp/pm_userspace.c                                      |    6 
 net/mptcp/protocol.c                                          |  161 +++---
 net/mptcp/protocol.h                                          |   59 +-
 net/mptcp/subflow.c                                           |   13 
 net/netfilter/ipvs/ip_vs_sync.c                               |    4 
 net/netfilter/nf_conntrack_proto_sctp.c                       |   43 +
 net/netfilter/nf_tables_api.c                                 |   44 +
 net/netfilter/nft_payload.c                                   |   13 
 net/netfilter/nft_set_rbtree.c                                |   46 +
 net/netlink/af_netlink.c                                      |    8 
 net/nfc/llcp_core.c                                           |    2 
 net/rds/tcp_connect.c                                         |    2 
 net/sctp/associola.c                                          |    3 
 net/sctp/socket.c                                             |    1 
 net/socket.c                                                  |   29 -
 net/tipc/crypto.c                                             |    4 
 net/wireless/core.c                                           |   14 
 net/wireless/core.h                                           |    7 
 net/wireless/mlme.c                                           |    3 
 net/wireless/nl80211.c                                        |   93 ++-
 scripts/mod/file2alias.c                                      |    2 
 security/integrity/ima/Kconfig                                |   22 
 sound/soc/soc-utils.c                                         |    1 
 sound/soc/tegra/tegra_audio_graph_card.c                      |   30 -
 tools/testing/selftests/netfilter/.gitignore                  |    1 
 tools/testing/selftests/netfilter/Makefile                    |    4 
 tools/testing/selftests/netfilter/audit_logread.c             |  165 ++++++
 tools/testing/selftests/netfilter/config                      |    1 
 tools/testing/selftests/netfilter/nft_audit.sh                |  193 +++++++
 tools/tracing/rtla/src/timerlat_aa.c                          |   32 +
 tools/tracing/rtla/src/timerlat_u.c                           |    6 
 187 files changed, 2079 insertions(+), 999 deletions(-)

Al Viro (2):
      ovl: move freeing ovl_entry past rcu delay
      ovl: fetch inode once in ovl_dentry_revalidate_common()

Alexandra Diupina (1):
      drivers/net: process the result of hdlc_open() and add call of hdlc_close() in uhdlc_close()

Andrii Nakryiko (1):
      bpf: unconditionally reset backtrack_state masks on global func exit

Arnd Bergmann (2):
      wifi: iwlwifi: dbg_ini: fix structure packing
      ima: rework CONFIG_IMA dependency block

Bart Van Assche (2):
      scsi: core: Improve type safety of scsi_rescan_device()
      RDMA/srp: Do not call scsi_done() from srp_abort()

Bartosz Golaszewski (1):
      gpio: aspeed: fix the GPIO number passed to pinctrl_gpio_set_config()

Ben Wolsieffer (1):
      net: stmmac: dwmac-stm32: fix resume on STM32 MCU

Benjamin Berg (1):
      wifi: mac80211: Create resources for disabled links

Benjamin Poirier (1):
      ipv4: Set offload_failed flag in fibmatch results

Bernard Metzler (1):
      RDMA/siw: Fix connection failure handling

Breno Leitao (1):
      perf/x86/amd: Do not WARN() on every IRQ

Chen-Yu Tsai (1):
      regulator: mt6358: split ops for buck and linear range LDO regulators

Chengfeng Ye (1):
      tipc: fix a potential deadlock on &tx->lock

Christian Marangi (1):
      net: ethernet: mediatek: disable irq before schedule napi

Christoph Hellwig (2):
      btrfs: remove btrfs_writepage_endio_finish_ordered
      btrfs: remove end_extent_writepage

Christophe JAILLET (4):
      HID: sony: Fix a potential memory leak in sony_probe()
      wifi: iwlwifi: mvm: Fix a memory corruption issue
      HID: nvidia-shield: Fix a missing led_classdev_unregister() in the probe error handling path
      IB/mlx4: Fix the size of a buffer in add_port_entries()

Clark Wang (1):
      net: stmmac: platform: fix the incorrect parameter

Damien Le Moal (2):
      scsi: Do not attempt to rescan suspended devices
      ata: libata-scsi: Fix delayed scsi_rescan_device() execution

Dan Carpenter (2):
      net: ethernet: ti: am65-cpsw: Fix error code in am65_cpsw_nuss_init_tx_chns()
      of: dynamic: Fix potential memory leak in of_changeset_action()

Daniel Bristot de Oliveira (4):
      rtla/timerlat_aa: Zero thread sum after every sample analysis
      rtla/timerlat_aa: Fix negative IRQ delay
      rtla/timerlat_aa: Fix previous IRQ delay for IRQs that happens after thread sample
      rtla/timerlat: Do not stop user-space if a cpu is offline

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

Eric Dumazet (3):
      net: fix possible store tearing in neigh_periodic_work()
      neighbour: fix data-races around n->output
      netlink: annotate data-races around sk->sk_err

Fabio Estevam (1):
      net: dsa: mv88e6xxx: Avoid EEPROM timeout when EEPROM is absent

Fedor Pchelkin (1):
      dm zoned: free dmz->ddev array in dmz_put_zoned_devices

Felix Fietkau (2):
      wifi: mac80211: fix mesh id corruption on 32 bit systems
      wifi: mt76: mt76x02: fix MT76x0 external LNA gain handling

Filipe Manana (1):
      btrfs: always print transaction aborted messages with an error level

Florian Westphal (2):
      netfilter: nft_payload: rebuild vlan header on h_proto access
      netfilter: nf_tables: nft_set_rbtree: fix spurious insertion failure

Gao Xiang (1):
      erofs: fix memory leak of LZMA global compressed deduplication

Geliang Tang (1):
      mptcp: userspace pm allow creating id 0 subflow

Greg Kroah-Hartman (1):
      Linux 6.5.7

Gregory Greenman (1):
      iwlwifi: mvm: handle PS changes in vif_cfg_changed

Gustavo A. R. Silva (2):
      qed/red_ll2: Fix undefined behavior bug in struct qed_ll2_info
      wifi: mwifiex: Fix tlv_buf_left calculation

Haiyang Zhang (3):
      net: mana: Fix TX CQE error handling
      net: mana: Fix the tso_bytes calculation
      net: mana: Fix oversized sge0 for GSO packets

Hamdan Igbaria (1):
      RDMA/mlx5: Fix mutex unlocking on error flow for steering anchor creation

Hector Martin (1):
      iommu/apple-dart: Handle DMA_FQ domains in attach_dev()

Helge Deller (1):
      parisc: Fix crash with nr_cpus=1 option

Ilan Peer (1):
      wifi: iwlwifi: mvm: Fix incorrect usage of scan API

Ilya Maximets (1):
      ipv6: tcp: add a missing nf_reset_ct() in 3WHS handling

Jakub Sitnicki (1):
      bpf, sockmap: Reject sk_msg egress redirects to non-TCP sockets

Jens Axboe (3):
      io_uring: don't allow IORING_SETUP_NO_MMAP rings on highmem pages
      io_uring/kbuf: don't allow registered buffer rings on highmem pages
      io_uring: ensure io_lockdep_assert_cq_locked() handles disabled rings

Jeremy Cline (1):
      net: nfc: llcp: Add lock when modifying device list

Jingbo Xu (1):
      erofs: allow empty device tags in flatdev mode

Jiri Kosina (1):
      HID: sony: remove duplicate NULL check before calling usb_free_urb()

Jithu Joseph (1):
      platform/x86/intel/ifs: release cpus_read_lock()

Joey Gouly (1):
      arm64: add HWCAP for FEAT_HBC (hinted conditional branches)

Johannes Berg (3):
      wifi: cfg80211: fix cqm_config access race
      wifi: cfg80211: add missing kernel-doc for cqm_rssi_work
      wifi: mac80211: fix potential key use-after-free

John David Anglin (1):
      parisc: Restore __ldcw_align for PA-RISC 2.0 processors

John Fastabend (2):
      bpf: tcp_read_skb needs to pop skb regardless of seq
      bpf, sockmap: Do not inc copied_seq when PEEK flag set

Jordan Rife (3):
      net: replace calls to sock->ops->connect() with kernel_connect()
      net: prevent rewrite of msg_name in sock_sendmsg()
      smb: use kernel_connect() and kernel_bind()

Josef Bacik (1):
      btrfs: don't clear uptodate on write errors

Juerg Haefliger (1):
      wifi: brcmfmac: Replace 1-element arrays with flexible arrays

Juergen Gross (1):
      xen/events: replace evtchn_rwlock with RCU

Junxiao Bi (1):
      scsi: target: core: Fix deadlock due to recursive locking

Konstantin Meskhidze (1):
      RDMA/uverbs: Fix typo of sizeof argument

Kristina Martsenko (1):
      arm64: cpufeature: Fix CLRBHB and BC detection

Kuniyuki Iwashima (1):
      mptcp: Remove unnecessary test for __mptcp_init_sock()

Leon Hwang (1):
      bpf: Fix tr dereferencing

Leon Romanovsky (3):
      RDMA/core: Require admin capabilities to set system parameters
      RDMA/cma: Fix truncation compilation warning in make_cma_ports
      RDMA/mlx5: Remove not-used cache disable flag

Liam R. Howlett (3):
      maple_tree: add mas_is_active() to detect in-tree walks
      maple_tree: reduce resets during store setup
      maple_tree: add MAS_UNDERFLOW and MAS_OVERFLOW states

Lorenzo Bianconi (1):
      wifi: mt76: fix lock dependency problem for wed_lock

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

Mauricio Faria de Oliveira (1):
      modpost: add missing else to the "of" check

Michael Guralnik (1):
      RDMA/mlx5: Fix assigning access flags to cache mkeys

Michal Schmidt (1):
      ice: always add legacy 32byte RXDID in supported_rxdids

Michał Mirosław (1):
      regulator/core: regulator_register: set device->class earlier

Mika Westerberg (1):
      PCI/PM: Mark devices disconnected if upstream PCIe link is down on resume

Namjae Jeon (2):
      ksmbd: fix race condition between session lookup and expire
      ksmbd: fix race condition from parallel smb2 lock requests

Neal Cardwell (2):
      tcp: fix quick-ack counting to count actual ACKs of new data
      tcp: fix delayed ACKs for MSS boundary condition

Nirmoy Das (1):
      drm/i915: Don't set PIPE_CONTROL_FLUSH_L3 for aux inval

Oleksandr Tymoshenko (1):
      ima: Finish deprecation of IMA_TRUSTED_KEYRING Kconfig

Paolo Abeni (3):
      mptcp: rename timer related helper to less confusing names
      mptcp: fix dangling connection hang-up
      mptcp: fix delegated action races

Parthiban Veerasooran (1):
      ethtool: plca: fix plca enable data type while parsing the value

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

Randy Dunlap (2):
      HID: nvidia-shield: add LEDS_CLASS dependency
      net: lan743x: also select PHYLIB

Richard Fitzgerald (1):
      regmap: rbtree: Fix wrong register marked as in-cache when creating new node

Rob Herring (2):
      arm64: Add Cortex-A520 CPU part definition
      arm64: errata: Add Cortex-A520 speculative unprivileged load workaround

Robin Murphy (1):
      iommu/arm-smmu-v3: Avoid constructing invalid range commands

Sameer Pujar (2):
      ASoC: soc-utils: Export snd_soc_dai_is_dummy() symbol
      ASoC: tegra: Fix redundant PLLA and PLLA_OUT0 updates

Sandipan Das (1):
      perf/x86/amd/core: Fix overflow reset on hotplug

Sascha Hauer (1):
      wifi: rtw88: rtw8723d: Fix MAC address offset in EEPROM

Selvin Xavier (1):
      RDMA/bnxt_re: Fix the handling of control path response data

Shay Drory (2):
      RDMA/mlx5: Fix mkey cache possible deadlock on cleanup
      RDMA/mlx5: Fix NULL string error

Shigeru Yoshida (1):
      net: usb: smsc75xx: Fix uninit-value access in __smsc75xx_read_reg

Song Liu (1):
      s390/bpf: Let arch_prepare_bpf_trampoline return program size

Sricharan Ramabadhran (1):
      PCI: qcom: Fix IPQ8074 enumeration

Srinivas Pandruvada (1):
      HID: intel-ish-hid: ipc: Disable and reenable ACPI GPE bit

Stefano Garzarella (1):
      vringh: don't use vringh_kiov_advance() in vringh_iov_xfer()

Tom Lendacky (2):
      x86/sev: Change npages to unsigned long in snp_accept_memory()
      x86/sev: Use the GHCB protocol when available for SNP CPUID requests

Trond Myklebust (1):
      NFSv4: Fix a nfs4_state_manager() race

Wen Gong (1):
      wifi: cfg80211/mac80211: hold link BSSes when assoc fails for MLO connection

Xin Long (3):
      netfilter: handle the connecting collision properly in nf_conntrack_proto_sctp
      sctp: update transport state when processing a dupcook packet
      sctp: update hb timer immediately after users change hb_interval

Yao Xiao (1):
      Bluetooth: Delete unused hci_req_prepare_suspend() declaration

Ying Hsu (1):
      Bluetooth: Fix hci_link_tx_to RCU lock usage

Yong Wu (1):
      iommu/mediatek: Fix share pgtable for iova over 4GB

Yoshihiro Shimoda (2):
      net: renesas: rswitch: Add spin lock protection for irq {un}mask
      rswitch: Fix PHY station management clock setting

Zhang Rui (1):
      iommu/vt-d: Avoid memory allocation in iommu_suspend()

Zhihao Cheng (1):
      ubi: Refuse attaching if mtd's erasesize is 0

luosili (1):
      ksmbd: fix uaf in smb20_oplock_break_ack

