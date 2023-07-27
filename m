Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F9876487C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbjG0HYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbjG0HW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:22:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3C56195;
        Thu, 27 Jul 2023 00:14:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 002CB61D67;
        Thu, 27 Jul 2023 07:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA519C433C7;
        Thu, 27 Jul 2023 07:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690442057;
        bh=GeVcPiL2XQCTLOQG7qUixtd5Ie/7XfttBJZoIQrwlcU=;
        h=From:To:Cc:Subject:Date:From;
        b=fhcFEQq/F6GM5eVR0tuhybiwPpjzsAv3oldVAKLMAU0y3sqmVuZpT8e2u6hM/cNN9
         1cSbcE+COtZpwUzIAkkzeq9J+L6xBKa8PCe0Xifpfd7OOnIh8zo66TysInt+4hIb8k
         NMlfzFSVIC5FfdebJWmmnPRDbb9C2Pbvr5ZWnW4Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.4.7
Date:   Thu, 27 Jul 2023 09:13:56 +0200
Message-ID: <2023072756-rundown-dubiously-6cc3@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.4.7 kernel.

All users of the 6.4 kernel series must upgrade.

The updated 6.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                     |    2 
 arch/arm64/include/asm/exception.h                           |    5 
 arch/arm64/include/asm/kvm_host.h                            |    2 
 arch/arm64/include/asm/kvm_pgtable.h                         |   26 -
 arch/arm64/kernel/fpsimd.c                                   |   33 +
 arch/arm64/kvm/arch_timer.c                                  |    6 
 arch/arm64/kvm/arm.c                                         |   19 
 arch/arm64/kvm/hyp/pgtable.c                                 |   47 +
 arch/arm64/kvm/mmu.c                                         |   18 
 arch/arm64/kvm/vgic/vgic-v3.c                                |    2 
 arch/arm64/kvm/vgic/vgic-v4.c                                |    7 
 arch/arm64/mm/mmu.c                                          |    4 
 arch/arm64/net/bpf_jit_comp.c                                |    8 
 arch/arm64/tools/sysreg                                      |   12 
 arch/ia64/kernel/sys_ia64.c                                  |    2 
 arch/mips/include/asm/dec/prom.h                             |    2 
 arch/parisc/kernel/sys_parisc.c                              |   15 
 block/blk-mq.c                                               |   10 
 drivers/accel/qaic/qaic_control.c                            |   39 +
 drivers/acpi/button.c                                        |    9 
 drivers/acpi/resource.c                                      |   60 --
 drivers/acpi/video_detect.c                                  |   24 +
 drivers/acpi/x86/utils.c                                     |   26 -
 drivers/base/regmap/regmap-i2c.c                             |    8 
 drivers/base/regmap/regmap-spi-avmm.c                        |    2 
 drivers/base/regmap/regmap.c                                 |    6 
 drivers/bluetooth/btusb.c                                    |    1 
 drivers/dma-buf/dma-resv.c                                   |   13 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c                     |    5 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c            |  264 ++++-------
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h            |    7 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c       |   12 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c  |  110 ++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h  |   11 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c |    5 
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c    |    3 
 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c      |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c      |    8 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c         |    2 
 drivers/gpu/drm/drm_client_modeset.c                         |    6 
 drivers/gpu/drm/i915/i915_perf.c                             |    1 
 drivers/gpu/drm/nouveau/dispnv50/disp.c                      |    4 
 drivers/gpu/drm/nouveau/include/nvkm/subdev/i2c.h            |    4 
 drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c             |   27 -
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c               |   11 
 drivers/gpu/drm/radeon/radeon_cs.c                           |    3 
 drivers/gpu/drm/ttm/ttm_resource.c                           |    5 
 drivers/hid/hid-ids.h                                        |    1 
 drivers/hid/hid-quirks.c                                     |    1 
 drivers/iommu/iommu-sva.c                                    |    3 
 drivers/md/md.c                                              |   14 
 drivers/md/raid10.c                                          |    2 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c               |   10 
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h                    |    1 
 drivers/net/can/usb/gs_usb.c                                 |  130 +++--
 drivers/net/dsa/microchip/ksz8795.c                          |    8 
 drivers/net/dsa/microchip/ksz_common.c                       |    8 
 drivers/net/dsa/microchip/ksz_common.h                       |    7 
 drivers/net/dsa/mv88e6xxx/chip.c                             |    7 
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c           |   31 +
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c   |   29 +
 drivers/net/ethernet/intel/iavf/iavf.h                       |   16 
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c               |   39 -
 drivers/net/ethernet/intel/iavf/iavf_main.c                  |  223 ++++++---
 drivers/net/ethernet/intel/iavf/iavf_txrx.c                  |   43 -
 drivers/net/ethernet/intel/iavf/iavf_txrx.h                  |    4 
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c              |    5 
 drivers/net/ethernet/intel/ice/ice_base.c                    |    2 
 drivers/net/ethernet/intel/ice/ice_ethtool.c                 |   13 
 drivers/net/ethernet/intel/ice/ice_lib.c                     |   27 -
 drivers/net/ethernet/intel/ice/ice_main.c                    |   10 
 drivers/net/ethernet/intel/igb/igb_main.c                    |    5 
 drivers/net/ethernet/intel/igc/igc_main.c                    |   12 
 drivers/net/ethernet/litex/litex_liteeth.c                   |   19 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c         |    5 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                  |   29 -
 drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c              |    2 
 drivers/net/ethernet/realtek/r8169_main.c                    |   18 
 drivers/net/ethernet/ti/cpsw_ale.c                           |   24 -
 drivers/net/phy/phy_device.c                                 |   21 
 drivers/net/vrf.c                                            |   12 
 drivers/net/wireless/ath/ath11k/core.c                       |   53 +-
 drivers/net/wireless/ath/ath11k/mac.c                        |    3 
 drivers/net/wireless/ath/ath11k/wmi.c                        |    5 
 drivers/net/wireless/ath/ath12k/mac.c                        |    1 
 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c             |    9 
 drivers/net/wireless/intel/iwlwifi/mvm/power.c               |   14 
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c                 |    2 
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c                |    4 
 drivers/net/wireless/realtek/rtw88/sdio.c                    |   24 -
 drivers/net/wireless/virtual/mac80211_hwsim.c                |    4 
 drivers/of/platform.c                                        |    2 
 drivers/pinctrl/renesas/pinctrl-rzg2l.c                      |   28 -
 drivers/pinctrl/renesas/pinctrl-rzv2m.c                      |   28 -
 drivers/regulator/da9063-regulator.c                         |    3 
 drivers/s390/crypto/zcrypt_msgtype6.c                        |   35 +
 drivers/scsi/sg.c                                            |   10 
 drivers/spi/spi-bcm63xx.c                                    |    2 
 drivers/spi/spi-cadence-quadspi.c                            |   19 
 drivers/spi/spi-dw-mmio.c                                    |   22 
 drivers/spi/spi-s3c64xx.c                                    |    2 
 drivers/video/fbdev/au1200fb.c                               |    3 
 drivers/video/fbdev/imxfb.c                                  |    5 
 fs/btrfs/block-group.c                                       |    1 
 fs/btrfs/ctree.c                                             |   10 
 fs/btrfs/disk-io.c                                           |    3 
 fs/btrfs/extent_io.c                                         |   33 -
 fs/btrfs/inode.c                                             |   35 -
 fs/btrfs/qgroup.c                                            |    1 
 fs/btrfs/raid56.c                                            |   11 
 fs/btrfs/volumes.c                                           |   17 
 fs/erofs/zdata.c                                             |    2 
 fs/ext4/xattr.c                                              |   14 
 fs/fuse/dir.c                                                |    2 
 fs/fuse/inode.c                                              |    8 
 fs/fuse/ioctl.c                                              |   21 
 fs/jbd2/checkpoint.c                                         |  102 +---
 fs/jfs/jfs_dmap.c                                            |    3 
 fs/jfs/jfs_txnmgr.c                                          |    5 
 fs/jfs/namei.c                                               |    5 
 fs/overlayfs/ovl_entry.h                                     |    9 
 fs/quota/dquot.c                                             |    5 
 fs/smb/client/connect.c                                      |   19 
 fs/smb/client/dfs.c                                          |   26 -
 fs/smb/client/smb2transport.c                                |    2 
 fs/udf/unicode.c                                             |    2 
 include/kvm/arm_vgic.h                                       |    2 
 include/linux/psi.h                                          |    5 
 include/linux/psi_types.h                                    |    3 
 include/linux/sched/signal.h                                 |    2 
 include/linux/tcp.h                                          |    2 
 include/net/bluetooth/hci_core.h                             |    5 
 include/net/ip.h                                             |    2 
 include/net/tcp.h                                            |   31 +
 include/uapi/linux/fuse.h                                    |    3 
 io_uring/io_uring.c                                          |   50 +-
 kernel/bpf/bpf_lru_list.c                                    |   21 
 kernel/bpf/bpf_lru_list.h                                    |    7 
 kernel/bpf/btf.c                                             |   19 
 kernel/bpf/log.c                                             |    3 
 kernel/bpf/syscall.c                                         |    3 
 kernel/bpf/verifier.c                                        |   32 +
 kernel/cgroup/cgroup.c                                       |    2 
 kernel/kallsyms.c                                            |    5 
 kernel/rcu/tasks.h                                           |    5 
 kernel/rcu/tree_exp.h                                        |    2 
 kernel/rcu/tree_plugin.h                                     |    4 
 kernel/sched/fair.c                                          |    4 
 kernel/sched/psi.c                                           |   29 -
 kernel/sys.c                                                 |   10 
 kernel/time/posix-timers.c                                   |   31 -
 kernel/trace/trace_events_hist.c                             |    3 
 lib/iov_iter.c                                               |    2 
 lib/maple_tree.c                                             |    3 
 mm/mlock.c                                                   |    9 
 net/bluetooth/hci_conn.c                                     |   14 
 net/bluetooth/hci_core.c                                     |   42 +
 net/bluetooth/hci_event.c                                    |   15 
 net/bluetooth/hci_sync.c                                     |  117 ++++
 net/bluetooth/iso.c                                          |   53 +-
 net/bluetooth/mgmt.c                                         |   26 -
 net/bluetooth/sco.c                                          |   23 
 net/bridge/br_stp_if.c                                       |    3 
 net/can/bcm.c                                                |   12 
 net/devlink/health.c                                         |    2 
 net/devlink/leftover.c                                       |    5 
 net/ipv4/esp4.c                                              |    2 
 net/ipv4/inet_connection_sock.c                              |    2 
 net/ipv4/inet_hashtables.c                                   |   17 
 net/ipv4/inet_timewait_sock.c                                |    8 
 net/ipv4/ip_output.c                                         |    4 
 net/ipv4/tcp.c                                               |   57 +-
 net/ipv4/tcp_fastopen.c                                      |    6 
 net/ipv4/tcp_ipv4.c                                          |   27 -
 net/ipv4/tcp_minisocks.c                                     |   11 
 net/ipv4/tcp_output.c                                        |    6 
 net/ipv4/udp_offload.c                                       |   16 
 net/ipv6/ip6_gre.c                                           |    3 
 net/ipv6/tcp_ipv6.c                                          |    4 
 net/ipv6/udp_offload.c                                       |    3 
 net/llc/llc_input.c                                          |    3 
 net/netfilter/nf_tables_api.c                                |   12 
 net/netfilter/nft_set_pipapo.c                               |    6 
 net/sched/cls_bpf.c                                          |   99 +---
 net/sched/cls_matchall.c                                     |   35 -
 net/sched/cls_u32.c                                          |   48 +-
 net/wireless/wext-core.c                                     |    6 
 scripts/Makefile.build                                       |    5 
 scripts/Makefile.host                                        |    6 
 scripts/kallsyms.c                                           |    6 
 security/keys/request_key.c                                  |   35 +
 security/keys/trusted-keys/trusted_tpm2.c                    |    2 
 sound/pci/emu10k1/emufx.c                                    |  112 ----
 sound/pci/hda/patch_realtek.c                                |  100 +++-
 sound/soc/amd/acp/amd.h                                      |    7 
 sound/soc/codecs/Kconfig                                     |    1 
 sound/soc/codecs/cs42l51-i2c.c                               |    6 
 sound/soc/codecs/cs42l51.c                                   |    7 
 sound/soc/codecs/cs42l51.h                                   |    1 
 sound/soc/codecs/rt5640.c                                    |   12 
 sound/soc/codecs/wcd-mbhc-v2.c                               |   57 +-
 sound/soc/codecs/wcd934x.c                                   |   12 
 sound/soc/codecs/wcd938x.c                                   |   86 +++
 sound/soc/fsl/fsl_sai.c                                      |    8 
 sound/soc/fsl/fsl_sai.h                                      |    1 
 sound/soc/qcom/qdsp6/q6apm.c                                 |    7 
 sound/soc/qcom/qdsp6/topology.c                              |    4 
 sound/soc/sof/ipc3-dtrace.c                                  |    9 
 sound/soc/tegra/tegra210_adx.c                               |   34 -
 sound/soc/tegra/tegra210_amx.c                               |   40 -
 tools/include/nolibc/stackprotector.h                        |    5 
 tools/perf/Makefile.config                                   |    4 
 tools/perf/tests/shell/test_uprobe_from_different_cu.sh      |   77 +++
 tools/perf/util/dwarf-aux.c                                  |    4 
 tools/testing/radix-tree/maple.c                             |    6 
 tools/testing/selftests/mm/mkdirty.c                         |    2 
 tools/testing/selftests/tc-testing/config                    |    2 
 tools/testing/selftests/tc-testing/settings                  |    1 
 218 files changed, 2456 insertions(+), 1482 deletions(-)

Abe Kohandel (2):
      spi: dw: Add compatible for Intel Mount Evans SoC
      spi: dw: Remove misleading comment for Mount Evans SoC

Aditi Ghag (1):
      bpf: tcp: Avoid taking fast sock lock in iterator

Ahmed Zaki (3):
      iavf: use internal state to free traffic IRQs
      iavf: fix a deadlock caused by rtnl and driver's lock circular dependencies
      iavf: fix reset task race with iavf_remove()

Alex Deucher (2):
      drm/amdgpu/pm: make gfxclock consistent for sienna cichlid
      drm/amdgpu/pm: make mclk consistent for smu 13.0.7

Alexander Duyck (1):
      bpf, arm64: Fix BTI type used for freplace attached functions

Andrii Nakryiko (1):
      bpf: drop unnecessary user-triggerable WARN_ONCE in verifierl log

Andrzej Hajda (1):
      drm/i915/perf: add sentinel to xehp_oa_b_counters

Antoine Tenart (1):
      net: ipv4: use consistent txhash in TIME_WAIT and SYN_RECV

Balamurugan S (1):
      wifi: ath12k: Avoid NULL pointer access during management transmit cleanup

Ben Skeggs (3):
      drm/nouveau/disp: PIOR DP uses GPIO for HPD, not PMGR AUX interrupts
      drm/nouveau/kms/nv50-: init hpd_irq_lock for PIOR DP
      drm/nouveau/i2c: fix number of aux event slots

Bernd Schubert (1):
      fuse: Apply flags2 only when userspace set the FUSE_INIT_EXT

Biju Das (1):
      pinctrl: renesas: rzg2l: Handle non-unique subnode names

Brad Larson (1):
      spi: cadence-quadspi: Add compatible for AMD Pensando Elba SoC

Christian Brauner (1):
      ovl: check type and offset of struct vfsmount in ovl_entry

Christoffer Sandberg (1):
      ALSA: hda/realtek: Add quirk for Clevo NS70AU

Christoph Hellwig (2):
      btrfs: don't check PageError in __extent_writepage
      btrfs: be a bit more careful when setting mirror_num_ret in btrfs_map_block

Colin Ian King (1):
      selftests/mm: mkdirty: fix incorrect position of #endif

Dan Carpenter (6):
      accel/qaic: Fix a leak in map_user_pages()
      accel/qaic: tighten bounds checking in encode_message()
      accel/qaic: tighten bounds checking in decode_message()
      accel/qaic: Add consistent integer overflow checks
      iommu/sva: Fix signedness bug in iommu_sva_alloc_pasid()
      ASoC: SOF: ipc3-dtrace: uninitialized data in dfsentry_trace_filter_write()

Daniel Golle (2):
      net: ethernet: mtk_eth_soc: handle probe deferral
      net: ethernet: mtk_eth_soc: always mtk_get_ib1_pkt_type

David Sterba (1):
      btrfs: add xxhash to fast checksum implementations

Ding Hui (2):
      iavf: Fix use-after-free in free_netdev
      iavf: Fix out-of-bounds when setting channels on remove

Douglas Anderson (1):
      Bluetooth: hci_sync: Avoid use-after-free in dbg for hci_remove_adv_monitor()

Eric Dumazet (13):
      tcp: annotate data-races around tcp_rsk(req)->txhash
      tcp: annotate data-races around tcp_rsk(req)->ts_recent
      tcp: annotate data-races around tp->tcp_tx_delay
      tcp: annotate data-races around tp->tsoffset
      tcp: annotate data-races around tp->keepalive_time
      tcp: annotate data-races around tp->keepalive_intvl
      tcp: annotate data-races around tp->keepalive_probes
      tcp: annotate data-races around icsk->icsk_syn_retries
      tcp: annotate data-races around tp->linger2
      tcp: annotate data-races around rskq_defer_accept
      tcp: annotate data-races around tp->notsent_lowat
      tcp: annotate data-races around icsk->icsk_user_timeout
      tcp: annotate data-races around fastopenq.max_qlen

Eric Whitney (1):
      ext4: correct inline offset when handling xattrs in inode body

Fabio Estevam (1):
      ASoC: fsl_sai: Revert "ASoC: fsl_sai: Enable MCTL_MCLK_EN bit for master mode"

Fedor Ross (1):
      can: mcp251xfd: __mcp251xfd_chip_set_mode(): increase poll timeout

Filipe Manana (5):
      btrfs: fix iput() on error pointer after error during orphan cleanup
      btrfs: fix warning when putting transaction with qgroups enabled after abort
      btrfs: fix double iput() on inode after an error during orphan cleanup
      btrfs: zoned: fix memory leak after finding block group with super blocks
      btrfs: abort transaction at update_ref_for_cow() when ref count is zero

Florian Kauer (1):
      igc: Prevent garbled TX queue with XDP ZEROCOPY

Florian Westphal (3):
      netfilter: nf_tables: fix spurious set element insertion failure
      netfilter: nf_tables: can't schedule in nft_chain_validate
      netfilter: nft_set_pipapo: fix improper element removal

Geert Uytterhoeven (1):
      pinctrl: renesas: rzv2m: Handle non-unique subnode names

Geetha sowjanya (1):
      octeontx2-pf: Dont allocate BPIDs for LBK interfaces

Georg Müller (2):
      perf probe: Add test for regression introduced by switch to die_get_decl_file()
      perf probe: Read DWARF files from the correct CU

Greg Kroah-Hartman (1):
      Linux 6.4.7

Gregory Greenman (1):
      wifi: iwlwifi: mvm: fix potential array out of bounds access

Guchun Chen (1):
      drm/amdgpu/vkms: relax timer deactivation by hrtimer_try_to_cancel

Gustavo A. R. Silva (2):
      MIPS: dec: prom: Address -Warray-bounds warning
      wifi: wext-core: Fix -Wstringop-overflow warning in ioctl_standard_iw_point()

Hans de Goede (6):
      ACPI: x86: Add skip i2c clients quirk for Nextbook Ares 8A
      ACPI: button: Add lid disable DMI quirk for Nextbook Ares 8A
      ACPI: x86: Add ACPI_QUIRK_UART1_SKIP for Lenovo Yoga Book yb1-x90f/l
      ACPI: video: Add backlight=native DMI quirk for Apple iMac11,3
      ACPI: video: Add backlight=native DMI quirk for Lenovo ThinkPad X131e (3371 AMD version)
      ACPI: video: Add backlight=native DMI quirk for Dell Studio 1569

Hao Chen (1):
      net: hns3: fix strncpy() not using dest-buf length as length issue

Harald Freudenberger (1):
      s390/zcrypt: fix reply buffer calculations for CCA replies

Heiner Kallweit (2):
      Revert "r8169: disable ASPM during NAPI poll"
      r8169: fix ASPM-related problem for chip version 42 and 43

Helge Deller (2):
      io_uring: Fix io_uring mmap() by using architecture-provided get_unmapped_area()
      ia64: mmap: Consider pgoff when searching for free mapping

Hersen Wu (1):
      Revert "drm/amd/display: edp do not add non-edid timings"

Ido Schimmel (1):
      vrf: Fix lockdep splat in output path

Ilan Peer (1):
      wifi: mac80211_hwsim: Fix possible NULL dereference

Immad Mir (2):
      FS: JFS: Fix null-ptr-deref Read in txBegin
      FS: JFS: Check for read-only mounted filesystem in txBegin

Jaewon Kim (1):
      spi: s3c64xx: clear loopback bit after loopback test

Jakub Kicinski (1):
      devlink: make health report on unregistered instance warn just once

James Clark (1):
      perf build: Fix library not found error when using CSLIBS

Jan Kara (2):
      quota: Properly disable quotas when add_dquot_ref() fails
      udf: Fix uninitialized array access for some pathnames

Jens Axboe (1):
      io_uring: treat -EAGAIN for REQ_F_NOWAIT as final for io-wq

Jiapeng Chong (1):
      security: keys: Modify mismatched function name

Jisheng Zhang (1):
      net: ethernet: litex: add support for 64 bit stats

Jocelyn Falempe (2):
      drm/client: Fix memory leak in drm_client_target_cloned
      drm/client: Fix memory leak in drm_client_modeset_probe

Johan Hovold (9):
      ASoC: codecs: wcd938x: fix missing clsh ctrl error handling
      ASoC: codecs: wcd-mbhc-v2: fix resource leaks on component remove
      ASoC: qdsp6: audioreach: fix topology probe deferral
      ASoC: codecs: wcd938x: fix resource leaks on component remove
      ASoC: codecs: wcd938x: fix missing mbhc init error handling
      ASoC: codecs: wcd934x: fix resource leaks on component remove
      ASoC: codecs: wcd938x: fix codec initialisation race
      ASoC: codecs: wcd938x: fix soundwire initialisation race
      ASoC: codecs: wcd938x: fix mbhc impedance loglevel

Johannes Berg (1):
      wifi: iwlwifi: mvm: avoid baid size integer overflow

Jonas Gorski (1):
      spi: bcm63xx: fix max prepend length

Josef Bacik (2):
      btrfs: set_page_extent_mapped after read_folio in btrfs_cont_expand
      btrfs: fix race between balance and cancel/pause

Kailang Yang (1):
      ALSA: hda/realtek - remove 3k pull low procedure

Kui-Feng Lee (1):
      bpf: Print a warning only if writing to unprivileged_bpf_disabled.

Kumar Kartikeya Dwivedi (2):
      bpf: Fix subprog idx logic in check_max_stack_depth
      bpf: Repeat check_max_stack_depth for async callbacks

Kuniyuki Iwashima (3):
      bridge: Add extack warning when enabling STP in netns.
      Revert "tcp: avoid the lookup process failing to get sk in ehash table"
      llc: Don't drop packet from non-root netns.

Kurt Kanzenbach (1):
      igc: Avoid transmit queue timeout for XDP

Liam R. Howlett (2):
      mm/mlock: fix vma iterator conversion of apply_vma_lock_flags()
      maple_tree: fix node allocation testing on 32 bit

Linus Walleij (1):
      dsa: mv88e6xxx: Do a final check before timing out

Luka Guzenko (1):
      ALSA: hda/realtek: Enable Mute LED on HP Laptop 15s-eq2xxx

Marc Kleine-Budde (2):
      can: gs_usb: gs_can_open(): improve error handling
      can: gs_usb: fix time stamp counter initialization

Marc Zyngier (4):
      KVM: arm64: timers: Use CNTHCTL_EL2 when setting non-CNTKCTL_EL1 bits
      KVM: arm64: Disable preemption in kvm_arch_hardware_enable()
      KVM: arm64: vgic-v4: Make the doorbell request robust w.r.t preemption
      arm64: Fix HFGxTR_EL2 field naming

Marcin Szycik (1):
      iavf: Wait for reset in callbacks which trigger it

Marco Morandini (1):
      HID: add quirk for 03f0:464a HP Elite Presenter Mouse

Mario Limonciello (1):
      ACPI: resource: Remove "Zen" specific match and quirks

Mark Brown (3):
      regmap: Drop initial version of maximum transfer length fixes
      regmap: Account for register length in SMBus I/O limits
      arm64/fpsimd: Ensure SME storage is allocated after SVE VL changes

Mark Rutland (1):
      arm64: mm: fix VA-range sanity check

Martin Blumenstingl (1):
      wifi: rtw88: sdio: Check the HISR RX_REQUEST bit in rtw_sdio_rx_isr()

Martin Fuzzey (1):
      regulator: da9063: fix null pointer deref with partial DT config

Martin KaFai Lau (1):
      bpf: Address KCSAN report on bpf_lru_list

Martin Kaiser (1):
      fbdev: imxfb: warn about invalid left/right margin

Matthew Anderson (1):
      ALSA: hda/realtek: Add quirks for ROG ALLY CS35l41 audio

Matthieu Baerts (3):
      selftests: tc: set timeout to 15 minutes
      selftests: tc: add 'ct' action kconfig dep
      selftests: tc: add ConnTrack procfs kconfig

Matus Gajdos (1):
      ASoC: fsl_sai: Disable bit clock with transmitter

Maxime Bizon (1):
      wifi: ath11k: fix registration of 6Ghz-only phy without the full channel range

Miaohe Lin (1):
      sched/fair: Use recent_used_cpu to test p->cpus_ptr

Michal Swiatkowski (1):
      ice: prevent NULL pointer deref during reload

Miguel Ojeda (2):
      prctl: move PR_GET_AUXV out of PR_MCE_KILL
      kbuild: rust: avoid creating temporary files

Miklos Szeredi (3):
      fuse: revalidate: don't invalidate if interrupted
      fuse: add feature flag for expire-only
      fuse: ioctl: translate ENOSYS in outarg

Ming Lei (1):
      blk-mq: fix NULL dereference on q->elevator in blk_mq_elv_switch_none

Mohamed Khalfella (1):
      tracing/histograms: Return an error if we fail to add histogram to hist_vars list

Mukesh Sisodiya (2):
      wifi: iwlwifi: mvm: Add NULL check before dereferencing the pointer
      wifi: iwlwifi: Add support for new PCI Id

Nathan Chancellor (1):
      ASoC: cs35l45: Select REGMAP_IRQ

Nicholas Kazlauskas (1):
      drm/amd/display: Keep PHY active for DP displays on DCN31

Oliver Upton (1):
      KVM: arm64: Correctly handle page aging notifiers for unaligned memslot

Oswald Buddenhagen (1):
      ALSA: emu10k1: roll up loops in DSP setup code for Audigy

P Praneesh (1):
      wifi: ath11k: fix memory leak in WMI firmware stats

Pablo Neira Ayuso (2):
      netfilter: nf_tables: skip bound chain in netns release path
      netfilter: nf_tables: skip bound chain on rule flush

Paul E. McKenney (1):
      rcu: Mark additional concurrent load from ->cpu_no_qs.b.exp

Pauli Virtanen (4):
      Bluetooth: use RCU for hci_conn_params and iterate safely in hci_sync
      Bluetooth: hci_event: call disconnect callback before deleting conn
      Bluetooth: ISO: fix iso_conn related locking and validity issues
      Bluetooth: SCO: fix sco_conn related locking and validity issues

Paulo Alcantara (1):
      smb: client: fix missed ses refcounting

Peng Zhang (1):
      maple_tree: set the node limit when creating a new root node

Peter Zijlstra (1):
      iov_iter: Mark copy_iovec_from_user() noclone

Petr Oros (2):
      devlink: report devlink_port_type_warn source device
      ice: Unregister netdev and devlink_port only once

Petr Pavlu (1):
      keys: Fix linking a duplicate key to a keyring's assoc_array

Przemek Kitszel (1):
      iavf: make functions static where possible

Qu Wenruo (1):
      btrfs: raid56: always verify the P/Q contents for scrub

Rob Herring (1):
      of: Preserve "of-display" device name for compatibility

Sameer Pujar (1):
      ASoC: rt5640: Fix sleep in atomic context

Sandeep Dhavale (1):
      erofs: Fix detection of atomic context

Sheetal (2):
      ASoC: tegra: Fix ADX byte map
      ASoC: tegra: Fix AMX byte map

Shigeru Yoshida (1):
      rcu-tasks: Avoid pr_info() with spin lock in cblist_init_generic()

Shyam Prasad N (1):
      cifs: fix mid leak during reconnection after timeout threshold

Siddh Raman Pant (1):
      Bluetooth: hci_conn: return ERR_PTR instead of NULL when there is no link

Simon Ser (1):
      drm/amd/display: only accept async flips for fast updates

Srinivas Kandagatla (2):
      ASoC: codecs: wcd938x: fix dB range for HPHL and HPHR
      ASoC: qcom: q6apm: do not close GPR port before closing graph

Srinivasan Shanmugam (1):
      drm/amd/display: Clean up errors & warnings in amdgpu_dm.c

Suren Baghdasaryan (1):
      sched/psi: use kernfs polling functions for PSI trigger polling

Taimur Hassan (1):
      drm/amd/display: check TG is non-null before checking if enabled

Tanmay Patil (1):
      net: ethernet: ti: cpsw_ale: Fix cpsw_ale_get_field()/cpsw_ale_set_field()

Thomas Gleixner (1):
      posix-timers: Ensure timer ID search-loop limit is valid

Thomas Petazzoni (1):
      ASoC: cs42l51: fix driver to properly autoload with automatic module loading

Thomas Weißschuh (1):
      tools/nolibc: ensure stack protector guard is never zero

Tomasz Moń (1):
      Bluetooth: btusb: Fix bluetooth on Intel Macbook 2014

Tristram Ha (1):
      net: dsa: microchip: correct KSZ8795 static MAC table access

Victor Nogueira (4):
      net: sched: cls_matchall: Undo tcf_bind_filter in case of failure after mall_set_parms
      net: sched: cls_u32: Undo tcf_bind_filter if u32_replace_hw_knode
      net: sched: cls_u32: Undo refcount decrement in case update failed
      net: sched: cls_bpf: Undo tcf_bind_filter in case of an error

Vijendar Mukunda (1):
      ASoC: amd: acp: fix for invalid dai id handling in acp_get_byte_count()

Ville Syrjälä (1):
      dma-buf/dma-resv: Stop leaking on krealloc() failure

Vitaly Rodionov (1):
      ALSA: hda/realtek: Fix generic fixup definition for cs35l41 amp

Vladimir Oltean (1):
      net: phy: prevent stale pointer dereference in phy_init()

Wang Ming (1):
      net: ipv4: Use kfree_sensitive instead of kfree

Wayne Lin (1):
      drm/amd/display: Add polling method to handle MST reply packet

Wen Gong (1):
      wifi: ath11k: add support default regdb while searching board-2.bin for WCN6855

Yan Zhai (1):
      gso: fix dodgy bit handling for GSO_UDP_L4

Yangtao Li (1):
      fbdev: imxfb: Removed unneeded release_mem_region

Ye Bin (1):
      quota: fix warning in dqgrab()

Yi Kuo (1):
      wifi: iwlwifi: pcie: add device id 51F1 for killer 1675

Yicong Yang (1):
      sched/fair: Don't balance task to its current running CPU

Ying Hsu (1):
      igb: Fix igb_down hung on surprise removal

Yogesh (1):
      fs: jfs: Fix UBSAN: array-index-out-of-bounds in dbAllocDmapLev

Yonghong Song (2):
      bpf: Silence a warning in btf_type_id_size()
      kallsyms: strip LTO-only suffixes from promoted global functions

Youngmin Nam (1):
      arm64: set __exception_irq_entry with __irq_entry as a default

Yu Kuai (5):
      md: fix data corruption for raid456 when reshape restart while grow up
      md/raid10: prevent soft lockup while flush writes
      scsi: sg: fix blktrace debugfs entries leakage
      scsi/sg: don't grab scsi host module reference
      scsi: sg: Fix checking return value of blk_get_queue()

Yuanjun Gong (1):
      net:ipv6: check return value of pskb_trim()

YueHaibing (1):
      can: bcm: Fix UAF in bcm_proc_show()

Yunxiang Li (1):
      drm/ttm: fix bulk_move corruption when adding a entry

Zhang Shurong (1):
      fbdev: au1200fb: Fix missing IRQ check in au1200fb_drv_probe

Zhang Yi (1):
      jbd2: recheck chechpointing non-dirty buffer

Zhikai Zhai (1):
      drm/amd/display: Disable MPC split by default on special asic

hackyzh002 (1):
      drm/radeon: Fix integer overflow in radeon_cs_parser_init

