Return-Path: <linux-kernel+bounces-22557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2588829FA0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E58FA1C22295
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAD94D12E;
	Wed, 10 Jan 2024 17:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2Er2Hd4C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC90B4CE17;
	Wed, 10 Jan 2024 17:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB2FC43390;
	Wed, 10 Jan 2024 17:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704908827;
	bh=AqZmRem0zXbOqCfauf34R9VPy0OzpnQxBEotnyVik3I=;
	h=From:To:Cc:Subject:Date:From;
	b=2Er2Hd4CjIBBFe3XxQYd75X/01sS5XUDiipB7fRH+93zEAxotVSznNE+fXD8LEGye
	 Xy9fnOVRCLDe6dap7l77IcSO3ShhTkIGzN6GBm5WbqOuujC3F3LY1EzOlke42nziSR
	 eDwoCEs6tZ/yU7848XgMZw/lkXLlkhxj/6mEJNUo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.11
Date: Wed, 10 Jan 2024 18:46:58 +0100
Message-ID: <2024011058-sheep-thrower-d2f8@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.11 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                                      |    2 
 arch/arm/mach-sunxi/mc_smp.c                                                  |    4 
 arch/powerpc/platforms/pseries/vas.c                                          |   51 +-
 arch/powerpc/platforms/pseries/vas.h                                          |    2 
 arch/riscv/kernel/cpufeature.c                                                |    4 
 arch/riscv/kvm/aia_imsic.c                                                    |   13 
 arch/s390/kvm/vsie.c                                                          |    4 
 arch/x86/events/intel/core.c                                                  |    7 
 arch/x86/kernel/kprobes/core.c                                                |    3 
 crypto/xts.c                                                                  |   23 
 drivers/accel/qaic/mhi_controller.c                                           |   15 
 drivers/accel/qaic/qaic_data.c                                                |    6 
 drivers/acpi/thermal.c                                                        |    4 
 drivers/clk/clk-si521xx.c                                                     |    4 
 drivers/clk/rockchip/clk-rk3128.c                                             |   22 
 drivers/crypto/hisilicon/qm.c                                                 |  105 +---
 drivers/crypto/intel/qat/qat_common/adf_aer.c                                 |    3 
 drivers/cxl/core/hdm.c                                                        |    9 
 drivers/cxl/core/mbox.c                                                       |    2 
 drivers/cxl/core/memdev.c                                                     |   31 +
 drivers/cxl/core/pmu.c                                                        |    2 
 drivers/cxl/core/port.c                                                       |    7 
 drivers/cxl/core/region.c                                                     |    5 
 drivers/cxl/cxl.h                                                             |    1 
 drivers/dma/fsl-edma-main.c                                                   |   12 
 drivers/dma/idxd/submit.c                                                     |   14 
 drivers/dma/ti/k3-psil-am62.c                                                 |   12 
 drivers/dma/ti/k3-psil-am62a.c                                                |   12 
 drivers/firewire/ohci.c                                                       |   51 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                                    |   11 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                             |   11 
 drivers/gpu/drm/amd/display/dc/dml/Makefile                                   |    4 
 drivers/gpu/drm/amd/display/dc/dml/dc_features.h                              |    2 
 drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c                          |  110 ++++
 drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c                 |   13 
 drivers/gpu/drm/bridge/parade-ps8640.c                                        |    7 
 drivers/gpu/drm/bridge/ti-sn65dsi86.c                                         |    4 
 drivers/gpu/drm/i915/display/intel_display.c                                  |    3 
 drivers/gpu/drm/i915/display/intel_dp.c                                       |    2 
 drivers/gpu/drm/i915/i915_perf.c                                              |   39 +
 drivers/gpu/drm/mgag200/mgag200_drv.h                                         |    5 
 drivers/gpu/drm/mgag200/mgag200_g200er.c                                      |    5 
 drivers/gpu/drm/mgag200/mgag200_g200ev.c                                      |    5 
 drivers/gpu/drm/mgag200/mgag200_g200se.c                                      |    5 
 drivers/gpu/drm/mgag200/mgag200_mode.c                                        |   10 
 drivers/i2c/i2c-core.h                                                        |    4 
 drivers/iio/imu/adis16475.c                                                   |    4 
 drivers/infiniband/hw/mlx5/mr.c                                               |    2 
 drivers/iommu/intel/iommu.c                                                   |    5 
 drivers/iommu/intel/iommu.h                                                   |    3 
 drivers/media/platform/qcom/camss/camss-csid-gen2.c                           |   14 
 drivers/media/platform/qcom/camss/camss.c                                     |   45 +
 drivers/mmc/core/block.c                                                      |    7 
 drivers/mmc/core/host.c                                                       |    1 
 drivers/mmc/host/meson-mx-sdhc-mmc.c                                          |   26 -
 drivers/mmc/host/sdhci-sprd.c                                                 |   10 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                                     |    4 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                                |    4 
 drivers/net/ethernet/intel/i40e/i40e_main.c                                   |   11 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c                            |   34 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h                            |    3 
 drivers/net/ethernet/intel/ice/ice_main.c                                     |   12 
 drivers/net/ethernet/intel/igc/igc.h                                          |    1 
 drivers/net/ethernet/intel/igc/igc_ethtool.c                                  |   42 +
 drivers/net/ethernet/intel/igc/igc_tsn.c                                      |    2 
 drivers/net/ethernet/marvell/octeontx2/af/npc.h                               |    4 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h                               |    1 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c                           |   17 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c                           |  118 ----
 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c                      |    9 
 drivers/net/ethernet/qlogic/qla3xxx.c                                         |    2 
 drivers/net/ethernet/realtek/r8169_main.c                                     |    2 
 drivers/net/ethernet/renesas/ravb_main.c                                      |   65 +-
 drivers/net/ethernet/sfc/rx_common.c                                          |    4 
 drivers/net/ethernet/wangxun/libwx/wx_lib.c                                   |   82 ---
 drivers/net/ethernet/wangxun/libwx/wx_type.h                                  |    1 
 drivers/net/usb/ax88172a.c                                                    |    4 
 drivers/net/virtio_net.c                                                      |   90 +--
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h                            |    4 
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c                                  |    8 
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c                               |   17 
 drivers/pci/pci.c                                                             |    6 
 drivers/pci/pci.h                                                             |    2 
 drivers/pci/pcie/aspm.c                                                       |   19 
 drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c                                |    2 
 drivers/phy/sunplus/phy-sunplus-usb2.c                                        |    2 
 drivers/phy/ti/phy-gmii-sel.c                                                 |    5 
 fs/dax.c                                                                      |   24 -
 fs/smb/client/cifsglob.h                                                      |    1 
 fs/smb/client/connect.c                                                       |    7 
 fs/smb/client/smb2ops.c                                                       |   34 -
 include/linux/dax.h                                                           |   10 
 include/linux/hisi_acc_qm.h                                                   |    1 
 include/net/netfilter/nf_tables_ipv4.h                                        |    2 
 include/net/sock.h                                                            |    4 
 include/net/tcp.h                                                             |    2 
 include/net/xdp_sock.h                                                        |    2 
 kernel/rcu/rcu.h                                                              |    2 
 kernel/rcu/tasks.h                                                            |   32 +
 kernel/rcu/tree.c                                                             |   43 +
 kernel/resource.c                                                             |    4 
 mm/memory-failure.c                                                           |   52 +-
 mm/memory.c                                                                   |    4 
 mm/vmscan.c                                                                   |   13 
 net/core/skbuff.c                                                             |    3 
 net/core/sock.c                                                               |   12 
 net/dns_resolver/dns_key.c                                                    |   19 
 net/ipv4/tcp.c                                                                |    3 
 net/ipv4/tcp_output.c                                                         |   16 
 net/mptcp/subflow.c                                                           |   13 
 net/netfilter/nf_nat_ovs.c                                                    |    3 
 net/netfilter/nf_tables_core.c                                                |    2 
 net/netfilter/nft_immediate.c                                                 |    2 
 net/nfc/llcp_core.c                                                           |   39 +
 net/sched/em_text.c                                                           |    4 
 net/smc/smc_diag.c                                                            |    3 
 net/socket.c                                                                  |    2 
 net/xdp/xsk.c                                                                 |    2 
 net/xdp/xsk_buff_pool.c                                                       |    3 
 samples/vfio-mdev/mtty.c                                                      |  239 ++++++---
 security/apparmor/apparmorfs.c                                                |    1 
 security/apparmor/mount.c                                                     |    4 
 sound/pci/hda/patch_realtek.c                                                 |    3 
 sound/pci/hda/tas2781_hda_i2c.c                                               |  240 +++++-----
 sound/soc/codecs/tas2781-comlib.c                                             |    4 
 sound/soc/codecs/tas2781-i2c.c                                                |    2 
 sound/soc/fsl/fsl_rpmsg.c                                                     |   10 
 sound/soc/mediatek/mt8186/mt8186-dai-adda.c                                   |    2 
 sound/soc/meson/g12a-toacodec.c                                               |    5 
 sound/soc/meson/g12a-tohdmitx.c                                               |    8 
 tools/bpf/bpftool/gen.c                                                       |   15 
 tools/testing/cxl/Kbuild                                                      |    1 
 tools/testing/cxl/cxl_core_exports.c                                          |    7 
 tools/testing/cxl/test/cxl.c                                                  |    5 
 tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh |    6 
 135 files changed, 1442 insertions(+), 837 deletions(-)

Aabish Malik (1):
      ALSA: hda/realtek: enable SND_PCI_QUIRK for hp pavilion 14-ec1xxx series

Adrian Cinal (1):
      net: bcmgenet: Fix FCS generation for fragmented skbuffs

Alex Bee (1):
      clk: rockchip: rk3128: Fix SCLK_SDMMC's clock name

Alex Deucher (3):
      drm/amd/display: Increase frame warning limit with KASAN or KCSAN in dml
      drm/amdgpu: skip gpu_info fw loading on navi12
      drm/amd/display: add nv12 bounding box

Alex Williamson (1):
      vfio/mtty: Overhaul mtty interrupt handling

Alison Schofield (3):
      cxl/core: Always hold region_rwsem while reading poison lists
      kernel/resource: Increment by align value in get_free_mem_region()
      cxl/memdev: Hold region_rwsem during inject and clear poison ops

Alvin Lee (1):
      drm/amd/display: Increase num voltage states to 40

Andrew Davis (1):
      phy: ti: gmii-sel: Fix register offset when parent is not a syscon node

Andrii Staikov (1):
      i40e: Restore VF MSI-X state during PCI reset

Andy Chi (1):
      ALSA: hda/realtek: fix mute/micmute LEDs for a HP ZBook

Benjamin Bara (1):
      i2c: core: Fix atomic xfer check for non-preempt config

Bjorn Helgaas (1):
      Revert "PCI/ASPM: Remove pcie_aspm_pm_state_change()"

Brad Cowie (1):
      netfilter: nf_nat: fix action not being set for all ct states

Bryan O'Donoghue (3):
      media: qcom: camss: Fix V4L2 async notifier error path
      media: qcom: camss: Fix genpd cleanup
      media: qcom: camss: Comment CSID dt_id field

Chancel Liu (1):
      ASoC: fsl_rpmsg: Fix error handler with pm_runtime_enable

Chen Ni (1):
      asix: Add check for usbnet_get_endpoints

Claudio Imbrenda (1):
      KVM: s390: vsie: fix wrong VIR 37 when MSO is used

Claudiu Beznea (1):
      net: ravb: Wait for operating mode to be applied

Dan Carpenter (1):
      ACPI: thermal: Fix acpi_thermal_unregister_thermal_zone() cleanup

Dave Jiang (3):
      cxl: Add cxl_decoders_committed() helper
      cxl: Add cxl_num_decoders_committed() usage to cxl_test
      cxl/hdm: Fix a benign lockdep splat

David Thompson (1):
      mlxbf_gige: fix receive packet race condition

Denys Zagorui (1):
      bpftool: Fix -Wcast-qual warning

Dinghao Liu (1):
      net/qla3xxx: fix potential memleak in ql_alloc_buffer_queues

Douglas Anderson (3):
      drm/bridge: parade-ps8640: Never store more than msg->size bytes in AUX xfer
      drm/bridge: ti-sn65dsi86: Never store more than msg->size bytes in AUX xfer
      drm/bridge: ps8640: Fix size mismatch warning w/ len

Edward Adam Davis (1):
      keys, dns: Fix missing size check of V1 server-list header

Eric Biggers (1):
      crypto: xts - use 'spawn' for underlying single-block cipher

Eric Dumazet (4):
      virtio_net: avoid data-races on dev->stats fields
      tcp: derive delack_max from rto_min
      net: prevent mss overflow in skb_segment()
      net: constify sk_dst_get() and __sk_dst_get() argument

Eugen Hristev (1):
      ASoC: mediatek: mt8186: fix AUD_PAD_TOP register and offset

Finley Xiao (1):
      clk: rockchip: rk3128: Fix aclk_peri_src's parent

Frederic Weisbecker (3):
      rcu: Introduce rcu_cpu_online()
      rcu/tasks: Handle new PF_IDLE semantics
      rcu/tasks-trace: Handle new PF_IDLE semantics

Geert Uytterhoeven (1):
      mmc: core: Cancel delayed work before releasing host

Gergo Koteles (3):
      ALSA: hda/tas2781: do not use regcache
      ALSA: hda/tas2781: move set_drv_data outside tasdevice_init
      ALSA: hda/tas2781: remove sound controls in unbind

Greg Kroah-Hartman (1):
      Linux 6.6.11

Guanjun (1):
      dmaengine: idxd: Protect int_handle field in hw descriptor

Hangbin Liu (1):
      selftests: bonding: do not set port down when adding to bond

Hangyu Hua (1):
      net: sched: em_text: fix possible memory leak in em_text_destroy()

Haren Myneni (1):
      powerpc/pseries/vas: Migration suspend waits for no in-progress open windows

Ian Rogers (1):
      bpftool: Align output skeleton ELF code

Ira Weiny (1):
      cxl/pmu: Ensure put_device on pmu devices

Jai Luthra (1):
      dmaengine: ti: k3-psil-am62a: Fix SPI PDMA data

Jeffrey Hugo (1):
      accel/qaic: Implement quirk for SOC_HW_VERSION

Jiajun Xie (1):
      mm: fix unmap_mapping_range high bits shift bug

Jinghao Jia (1):
      x86/kprobes: fix incorrect return address calculation in kprobe_emulate_call_indirect

Jisheng Zhang (1):
      riscv: don't probe unaligned access speed if already done

Jocelyn Falempe (1):
      drm/mgag200: Fix gamma lut not initialized for G200ER, G200EV, G200SE

Johannes Berg (1):
      wifi: iwlwifi: pcie: don't synchronize IRQs from IRQ

John Johansen (1):
      apparmor: Fix move_mount mediation by detecting if source is detached

Jorge Ramirez-Ortiz (1):
      mmc: rpmb: fixes pause retune on all RPMB partitions.

Joshua Ashton (1):
      drm/amd/display: Fix sending VSC (+ colorimetry) packets for DP/eDP displays without PSR

Jörn-Thorben Hinz (1):
      net: Implement missing getsockopt(SO_TIMESTAMPING_NEW)

Kai-Heng Feng (1):
      r8169: Fix PCI error on system resume

Katarzyna Wieczerzycka (1):
      ice: Fix link_down_on_close message

Ke Xiao (1):
      i40e: fix use-after-free in i40e_aqc_add_filters()

Khaled Almahallawy (1):
      drm/i915/dp: Fix passing the correct DPCD_REV for drm_dp_set_phy_test_pattern

Kurt Kanzenbach (3):
      igc: Report VLAN EtherType matching back to user
      igc: Check VLAN TCI mask
      igc: Check VLAN EtherType mask

Longfang Liu (1):
      crypto: hisilicon/qm - fix EQ/AEQ interrupt issue

Lu Baolu (1):
      iommu/vt-d: Support enforce_cache_coherency only for empty domains

Marc Dionne (1):
      net: Save and restore msg_namelen in sock_sendmsg

Marek Vasut (1):
      clk: si521xx: Increase stack based print buffer size in probe

Mark Brown (4):
      ASoC: meson: g12a-toacodec: Validate written enum values
      ASoC: meson: g12a-tohdmitx: Validate written enum values
      ASoC: meson: g12a-toacodec: Fix event generation
      ASoC: meson: g12a-tohdmitx: Fix event generation for S/PDIF mux

Matthew Wilcox (Oracle) (2):
      mm: convert DAX lock/unlock page to lock/unlock folio
      mm/memory-failure: pass the folio and the page to collect_procs()

Michael Chan (1):
      bnxt_en: Remove mis-applied code from bnxt_cfg_ntp_filters()

Michael Walle (1):
      phy: mediatek: mipi: mt8183: fix minimal supported frequency

Moshe Shemesh (1):
      RDMA/mlx5: Fix mkey cache WQ flush

Naveen Mamindlapalli (2):
      octeontx2-af: Always configure NIX TX link credits based on max frame size
      octeontx2-af: Re-enable MAC TX in otx2_stop processing

Ngai-Mint Kwan (1):
      ice: Shut down VSI with "link-down-on-close" enabled

Nuno Sa (1):
      iio: imu: adis16475: use bit numbers in assign_bit()

Pablo Neira Ayuso (2):
      netfilter: nf_tables: set transport offset from mac header for netdev/egress
      netfilter: nft_immediate: drop chain reference counter on error

Paolo Abeni (1):
      mptcp: prevent tcp diag from closing listener subflows

Paolo Bonzini (1):
      KVM: x86/pmu: fix masking logic for MSR_CORE_PERF_GLOBAL_CTRL

Peter Zijlstra (1):
      rcu: Break rcu_node_0 --> &rq->__lock order

Pranjal Ramajor Asha Kanojiya (1):
      accel/qaic: Fix GEM import path code

Rodrigo Cataldo (1):
      igc: Fix hicredit calculation

Ronald Wahl (1):
      dmaengine: ti: k3-psil-am62: Fix SPI PDMA data

Shyam Prasad N (2):
      cifs: cifs_chan_is_iface_active should be called with chan_lock held
      cifs: do not depend on release_iface for maintaining iface_list

Siddh Raman Pant (1):
      nfc: llcp_core: Hold a ref to llcp_local->dev when holding a ref to llcp_local

Siddhesh Dharme (1):
      ALSA: hda/realtek: Fix mute and mic-mute LEDs for HP ProBook 440 G6

Stefan Wahren (1):
      ARM: sun9i: smp: Fix array-index-out-of-bounds read in sunxi_mc_smp_init

Su Hui (1):
      phy: sunplus: return negative error code in sp_usb_phy_probe

Sudheer Mogilappagari (1):
      i40e: Fix filter input checks to prevent config with invalid values

Suman Ghosh (1):
      octeontx2-af: Fix marking couple of structure as __packed

Svyatoslav Pankratov (1):
      crypto: qat - fix double free during reset

Takashi Sakamoto (1):
      firewire: ohci: suppress unexpected system reboot in AMD Ryzen machines and ASM108x/VT630x PCIe cards

Thomas Lange (1):
      net: Implement missing SO_TIMESTAMPING_NEW cmsg support

Tirthendu Sarkar (1):
      xsk: add multi-buffer support for sockets sharing umem

Umesh Nerlige Ramappa (1):
      drm/i915/perf: Update handling of MMIO triggered reports

Ville Syrjälä (1):
      drm/i915: Call intel_pre_plane_updates() also for pipes getting enabled

Wayne Lin (1):
      drm/amd/display: pbn_div need be updated for hotplug event

Wen Gu (1):
      net/smc: fix invalid link access in dumping SMC-R connections

Wenchao Chen (1):
      mmc: sdhci-sprd: Fix eMMC init failure after hw reset

Xiaolei Wang (2):
      dmaengine: fsl-edma: Do not suspend and resume the masked dma channel when the system is sleeping
      dmaengine: fsl-edma: Add judgment on enabling round robin arbitration

Xuan Zhuo (1):
      virtio_net: fix missing dma unmap for resize

Yang Yingliang (1):
      dmaengine: fsl-edma: fix wrong pointer check in fsl_edma3_attach_pd()

Yong-Xuan Wang (1):
      RISCV: KVM: update external interrupt atomically for IMSIC swfile

Yu Zhao (1):
      mm/mglru: skip special VMAs in lru_gen_look_around()

Zhipeng Lu (1):
      sfc: fix a double-free bug in efx_probe_filters

Ziyang Huang (1):
      mmc: meson-mx-sdhc: Fix initialization frozen issue

duanqiangwen (1):
      net: libwx: fix memory leak on free page


