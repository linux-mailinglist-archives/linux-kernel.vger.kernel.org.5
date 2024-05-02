Return-Path: <linux-kernel+bounces-166571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBEC8B9C8A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81BBBB209FF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13544153584;
	Thu,  2 May 2024 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BRgEHDNq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FCE153BC3;
	Thu,  2 May 2024 14:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714660702; cv=none; b=Wg4IRffcdSf5UYFWbUNkQVma2oLNgrJx3jVucVydJ3X/tk2ipbuY8sXYlT9ujh4dse+s6o3nPI5uRTrXYj3gnCp9PnD11w61Bp1BtmSM8zFynroyTe0cYXMQC6B7DHSSidmuHBLN87kC15YaFDSAMGmopVNKwg3wMn5MQcSocc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714660702; c=relaxed/simple;
	bh=YJo9iqD1FgPopzIZuhbCMmKMo0O1lGW/2U/Vm+KyC1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M712Tvx9vHxLwmrgu3V2TB6/I3O/6bra9Jd3NLApNMJFyK6wXwbIQchawSt/sJMR0ZpAyJ6DTx7P4HxCTInaSMDAfdqZfTpLwm9UCslaQdacp+2qWLUauRu0eRE84b1vGroTbQyHsFdRCShFu/0sWMp1mak1XE6Z0PrjmQZ+KhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BRgEHDNq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B821C4AF48;
	Thu,  2 May 2024 14:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714660702;
	bh=YJo9iqD1FgPopzIZuhbCMmKMo0O1lGW/2U/Vm+KyC1k=;
	h=From:To:Cc:Subject:Date:From;
	b=BRgEHDNqomwo+RfypnFEwpiCNhhe4Rido5ji9sWL6PMCRPDnQ0QrmvxytP2iv4/zk
	 5s87TnLVpdJ90g68m9zsBoizX0MdyhOxsUwpqxYKx1vUN+IaJAc46eJk47F9aW1n0+
	 xeI416Z84dmbDLyeiS0E+CRxGh6zT5q7Wnit89Ow=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.8.9
Date: Thu,  2 May 2024 16:38:14 +0200
Message-ID: <2024050214-overhaul-circulate-9b84@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.8.9 kernel.

All users of the 6.8 kernel series must upgrade.

The updated 6.8.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.8.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/sysctl/net.rst                      |    5 
 Documentation/devicetree/bindings/eeprom/at24.yaml            |    5 
 Makefile                                                      |    2 
 arch/Kconfig                                                  |    8 
 arch/arc/boot/dts/hsdk.dts                                    |    1 
 arch/arm/boot/dts/microchip/at91-sama7g5ek.dts                |    8 
 arch/arm/boot/dts/nxp/imx/imx6ull-tarragon-common.dtsi        |    1 
 arch/arm64/boot/dts/mediatek/mt2712-evb.dts                   |    8 
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi                     |    3 
 arch/arm64/boot/dts/mediatek/mt7622.dtsi                      |   34 -
 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts      |    6 
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi                     |  173 +++---
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi                |    1 
 arch/arm64/boot/dts/mediatek/mt8183.dtsi                      |    1 
 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi              |    6 
 arch/arm64/boot/dts/mediatek/mt8192.dtsi                      |    1 
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi               |   36 +
 arch/arm64/boot/dts/mediatek/mt8195.dtsi                      |    5 
 arch/arm64/boot/dts/qcom/sc7280.dtsi                          |    4 
 arch/arm64/boot/dts/qcom/sc8180x.dtsi                         |    2 
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi                        |   11 
 arch/arm64/boot/dts/qcom/sm6350.dtsi                          |    4 
 arch/arm64/boot/dts/qcom/sm6375.dtsi                          |    2 
 arch/arm64/boot/dts/qcom/sm8250.dtsi                          |    6 
 arch/arm64/boot/dts/qcom/sm8450.dtsi                          |   16 
 arch/arm64/boot/dts/qcom/x1e80100.dtsi                        |    4 
 arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts          |    1 
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi                 |   31 -
 arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts            |    6 
 arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi           |    4 
 arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts       |    3 
 arch/loongarch/include/asm/perf_event.h                       |    8 
 arch/loongarch/mm/fault.c                                     |    4 
 arch/riscv/include/asm/page.h                                 |    2 
 arch/riscv/include/asm/pgtable.h                              |    2 
 arch/riscv/include/uapi/asm/hwprobe.h                         |    2 
 arch/riscv/mm/init.c                                          |    2 
 arch/x86/Kconfig                                              |   11 
 arch/x86/include/asm/coco.h                                   |    1 
 arch/x86/include/asm/pgtable_types.h                          |    3 
 arch/x86/kernel/cpu/amd.c                                     |    3 
 arch/x86/kernel/process_64.c                                  |    2 
 arch/x86/kvm/pmu.c                                            |   30 +
 arch/x86/kvm/vmx/pmu_intel.c                                  |   16 
 block/bdev.c                                                  |    2 
 drivers/acpi/cppc_acpi.c                                      |   72 ++
 drivers/bluetooth/btmtk.c                                     |    7 
 drivers/bluetooth/btusb.c                                     |   11 
 drivers/bluetooth/hci_qca.c                                   |   27 
 drivers/cxl/core/mbox.c                                       |   38 -
 drivers/dma/idma64.c                                          |    4 
 drivers/dma/idxd/cdev.c                                       |    5 
 drivers/dma/idxd/debugfs.c                                    |    4 
 drivers/dma/idxd/device.c                                     |    8 
 drivers/dma/idxd/idxd.h                                       |    2 
 drivers/dma/idxd/init.c                                       |    2 
 drivers/dma/idxd/irq.c                                        |    4 
 drivers/dma/idxd/perfmon.c                                    |    9 
 drivers/dma/owl-dma.c                                         |    4 
 drivers/dma/pl330.c                                           |    3 
 drivers/dma/tegra186-gpc-dma.c                                |    3 
 drivers/dma/xilinx/xdma-regs.h                                |    3 
 drivers/dma/xilinx/xdma.c                                     |   28 -
 drivers/dma/xilinx/xilinx_dpdma.c                             |   13 
 drivers/dpll/dpll_core.c                                      |   61 +-
 drivers/firmware/qcom/qcom_qseecom_uefisecapp.c               |  137 +++--
 drivers/firmware/qcom/qcom_scm.c                              |   37 -
 drivers/gpio/gpio-tangier.c                                   |    9 
 drivers/gpio/gpio-tegra186.c                                  |   20 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c              |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                        |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c                    |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c                    |   33 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h                    |   28 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                       |   61 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h                       |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c                  |    3 
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c                      |    3 
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c                        |   26 
 drivers/gpu/drm/amd/amdkfd/kfd_process.c                      |   15 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c |   85 ++-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.h |    5 
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c |    4 
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                            |    7 
 drivers/gpu/drm/drm_gem_atomic_helper.c                       |    4 
 drivers/gpu/drm/gma500/Makefile                               |    1 
 drivers/gpu/drm/gma500/psb_device.c                           |    5 
 drivers/gpu/drm/gma500/psb_drv.h                              |    9 
 drivers/gpu/drm/gma500/psb_lid.c                              |   80 --
 drivers/gpu/drm/xe/xe_gt.c                                    |    4 
 drivers/gpu/drm/xe/xe_gt_ccs_mode.c                           |   19 
 drivers/gpu/drm/xe/xe_gt_ccs_mode.h                           |    2 
 drivers/gpu/drm/xe/xe_huc.c                                   |    9 
 drivers/hid/hid-logitech-dj.c                                 |    4 
 drivers/hid/i2c-hid/i2c-hid-core.c                            |   38 -
 drivers/hid/intel-ish-hid/ipc/ipc.c                           |    2 
 drivers/i2c/i2c-core-base.c                                   |   12 
 drivers/irqchip/irq-gic-v3-its.c                              |    9 
 drivers/misc/eeprom/at24.c                                    |   18 
 drivers/mmc/host/sdhci-msm.c                                  |   16 
 drivers/mmc/host/sdhci-of-dwcmshc.c                           |    1 
 drivers/mtd/mtdcore.c                                         |    2 
 drivers/mtd/nand/raw/diskonchip.c                             |    4 
 drivers/mtd/nand/raw/qcom_nandc.c                             |    7 
 drivers/net/dsa/mv88e6xxx/chip.c                              |   56 +-
 drivers/net/dsa/mv88e6xxx/port.h                              |   23 
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c              |   21 
 drivers/net/ethernet/broadcom/b44.c                           |   14 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                     |   82 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c                   |    6 
 drivers/net/ethernet/intel/iavf/iavf_main.c                   |   30 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c                   |   16 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c           |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c     |    1 
 drivers/net/ethernet/mellanox/mlxsw/core.c                    |    2 
 drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c   |   16 
 drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c      |    9 
 drivers/net/ethernet/mellanox/mlxsw/core_env.c                |   20 
 drivers/net/ethernet/mellanox/mlxsw/pci.c                     |   10 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c            |   11 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c       |  132 ++--
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.h       |    5 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c         |   15 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c      |    8 
 drivers/net/ethernet/ti/am65-cpts.c                           |    5 
 drivers/net/ethernet/ti/icssg/icssg_prueth.c                  |    8 
 drivers/net/ethernet/wangxun/libwx/wx_lib.c                   |    2 
 drivers/net/gtp.c                                             |    3 
 drivers/net/macsec.c                                          |   46 +
 drivers/net/phy/dp83869.c                                     |    3 
 drivers/net/phy/mediatek-ge-soc.c                             |   43 -
 drivers/net/usb/ax88179_178a.c                                |   11 
 drivers/net/vxlan/vxlan_core.c                                |    4 
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c        |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c                 |    3 
 drivers/net/wireless/virtual/mac80211_hwsim.c                 |    2 
 drivers/nfc/trf7970a.c                                        |   42 -
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c                    |    6 
 drivers/phy/marvell/phy-mvebu-a3700-comphy.c                  |    9 
 drivers/phy/qualcomm/phy-qcom-m31.c                           |    2 
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c                     |   12 
 drivers/phy/qualcomm/phy-qcom-qmp.h                           |    2 
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c            |   36 +
 drivers/phy/rockchip/phy-rockchip-snps-pcie3.c                |   31 -
 drivers/phy/ti/phy-tusb1210.c                                 |   23 
 drivers/soc/mediatek/mtk-svs.c                                |    7 
 drivers/soundwire/amd_manager.c                               |   15 
 drivers/soundwire/amd_manager.h                               |    3 
 drivers/usb/host/xhci-ring.c                                  |   94 +--
 drivers/video/fbdev/core/fb_defio.c                           |    2 
 fs/btrfs/backref.c                                            |   12 
 fs/btrfs/extent_map.c                                         |    2 
 fs/btrfs/inode.c                                              |   13 
 fs/btrfs/scrub.c                                              |   18 
 fs/btrfs/tests/extent-map-tests.c                             |    5 
 fs/netfs/buffered_write.c                                     |   23 
 fs/proc/page.c                                                |    7 
 fs/smb/client/cifsfs.c                                        |    1 
 fs/smb/client/cifsglob.h                                      |    2 
 fs/smb/client/cifspdu.h                                       |    4 
 fs/smb/client/fs_context.c                                    |   12 
 fs/smb/client/fs_context.h                                    |    2 
 fs/smb/client/fscache.c                                       |   13 
 fs/smb/client/misc.c                                          |    3 
 fs/smb/client/smb2pdu.h                                       |    2 
 fs/smb/client/transport.c                                     |    7 
 include/drm/drm_gem.h                                         |   13 
 include/linux/etherdevice.h                                   |   25 
 include/linux/firmware/qcom/qcom_qseecom.h                    |   55 +-
 include/linux/firmware/qcom/qcom_scm.h                        |   10 
 include/linux/mm.h                                            |    8 
 include/linux/page-flags.h                                    |  144 ++---
 include/net/af_unix.h                                         |    3 
 include/net/bluetooth/hci.h                                   |    8 
 include/net/bluetooth/hci_core.h                              |   38 +
 include/net/bluetooth/hci_sync.h                              |   20 
 include/net/bluetooth/l2cap.h                                 |    2 
 include/net/macsec.h                                          |    2 
 include/net/sock.h                                            |   39 -
 include/net/tls.h                                             |    3 
 include/trace/events/mmflags.h                                |    1 
 init/Kconfig                                                  |    2 
 kernel/bounds.c                                               |    2 
 kernel/cpu.c                                                  |    4 
 kernel/crash_core.c                                           |    5 
 kernel/sched/fair.c                                           |   34 -
 lib/stackdepot.c                                              |    4 
 mm/hugetlb.c                                                  |   29 -
 mm/zswap.c                                                    |   25 
 net/ax25/af_ax25.c                                            |    2 
 net/bluetooth/6lowpan.c                                       |    2 
 net/bluetooth/hci_conn.c                                      |  168 +-----
 net/bluetooth/hci_event.c                                     |   52 -
 net/bluetooth/hci_sync.c                                      |  274 +++++++++-
 net/bluetooth/iso.c                                           |   50 +
 net/bluetooth/l2cap_core.c                                    |   12 
 net/bluetooth/l2cap_sock.c                                    |   10 
 net/bluetooth/mgmt.c                                          |   27 
 net/bluetooth/sco.c                                           |   10 
 net/bridge/br_netlink.c                                       |    2 
 net/core/sock.c                                               |    1 
 net/core/sysctl_net_core.c                                    |    9 
 net/ethernet/eth.c                                            |   12 
 net/ipv4/icmp.c                                               |   12 
 net/ipv4/route.c                                              |    3 
 net/ipv4/tcp_ao.c                                             |    3 
 net/ipv4/udp.c                                                |    5 
 net/ipv6/udp.c                                                |    5 
 net/mac80211/mesh.c                                           |    8 
 net/mac80211/mesh.h                                           |   36 +
 net/mac80211/mesh_pathtbl.c                                   |   37 -
 net/mac80211/mlme.c                                           |    9 
 net/mac80211/rx.c                                             |   13 
 net/netfilter/ipvs/ip_vs_proto_sctp.c                         |    6 
 net/netfilter/nft_chain_filter.c                              |    4 
 net/openvswitch/conntrack.c                                   |    4 
 net/tls/tls.h                                                 |    2 
 net/tls/tls_strp.c                                            |    6 
 net/unix/garbage.c                                            |    2 
 rust/Makefile                                                 |    1 
 rust/kernel/init.rs                                           |   11 
 rust/kernel/lib.rs                                            |    2 
 rust/kernel/net/phy.rs                                        |    4 
 rust/macros/lib.rs                                            |   12 
 scripts/Makefile.build                                        |    2 
 tools/net/ynl/lib/ynl.py                                      |    1 
 tools/testing/selftests/riscv/hwprobe/cbo.c                   |    2 
 tools/testing/selftests/riscv/hwprobe/hwprobe.h               |   10 
 tools/testing/selftests/seccomp/seccomp_bpf.c                 |   41 +
 229 files changed, 2385 insertions(+), 1506 deletions(-)

Adam Li (1):
      net: make SK_MEMORY_PCPU_RESERV tunable

Akhil R (1):
      dmaengine: tegra186: Fix residual calculation

Alex Deucher (4):
      Revert "drm/amd/display: fix USB-C flag update after enc10 feature init"
      drm: add drm_gem_object_is_shared_for_memory_stats() helper
      drm/amdgpu: add shared fdinfo stats
      drm/amdgpu/sdma5.2: use legacy HDP flush for SDMA2/3

Alexey Brodkin (1):
      ARC: [plat-hsdk]: Remove misplaced interrupt-cells property

Alice Ryhl (1):
      rust: don't select CONSTRUCTORS

Amit Cohen (1):
      mlxsw: Use refcount_t for reference counting

Andrei Simion (1):
      ARM: dts: microchip: at91-sama7g5ek: Replace regulator-suspend-voltage with the valid property

Andrew Jones (1):
      RISC-V: selftests: cbo: Ensure asm operands match constraints, take 2

Andrey Ryabinin (1):
      stackdepot: respect __GFP_NOLOCKDEP allocation flag

Andy Shevchenko (2):
      gpio: tangier: Use correct type for the IRQ chip data
      idma64: Don't try to serve interrupts when device is powered off

Andy Yan (1):
      arm64: dts: rockchip: Fix the i2c address of es8316 on Cool Pi CM5

AngeloGioacchino Del Regno (1):
      soc: mediatek: mtk-svs: Append "-thermal" to thermal zone names

Arkadiusz Kubalewski (1):
      dpll: fix dpll_pin_on_pin_register() for multiple parent pins

Arnd Bergmann (2):
      mtd: diskonchip: work around ubsan link failure
      dmaengine: owl: fix register access functions

Arınç ÜNAL (1):
      arm64: dts: rockchip: set PHY address of MT7531 switch to 0x1f

Aswin Unnikrishnan (1):
      rust: remove `params` from `module` macro example

Avraham Stern (1):
      wifi: iwlwifi: mvm: remove old PASN station when adding a new one

Bartosz Golaszewski (1):
      Bluetooth: qca: set power_ctrl_enabled on NULL returned by gpiod_get_optional()

Christian König (1):
      drm/amdgpu: fix visible VRAM handling during faults

Christian Marangi (2):
      mtd: rawnand: qcom: Fix broken OP_RESET_DEVICE command in qcom_misc_cmd_type_exec()
      mtd: limit OTP NVMEM cell parse to non-NAND devices

Chun-Yi Lee (1):
      Bluetooth: hci_sync: Using hci_cmd_sync_submit when removing Adv Monitor

Clément Léger (1):
      riscv: hwprobe: fix invalid sign extension for RISCV_HWPROBE_EXT_ZVFHMIN

Colin Ian King (1):
      wifi: mac80211: clean up assignments to pointer cache.

Conor Dooley (1):
      rust: make mutually exclusive with CFI_CLANG

Dan Carpenter (1):
      net: ti: icssg-prueth: Fix signedness bug in prueth_init_rx_chns()

Dan Williams (1):
      cxl/core: Fix potential payload size confusion in cxl_mem_get_poison()

Daniel Golle (1):
      net: phy: mediatek-ge-soc: follow netdev LED trigger semantics

Daniel Okazaki (1):
      eeprom: at24: fix memory corruption race condition

David Bauer (1):
      vxlan: drop packets from invalid src-address

David Howells (3):
      cifs: Fix reacquisition of volume cookie on still-live connection
      netfs: Fix writethrough-mode error handling
      netfs: Fix the pre-flush when appending to a file in writethrough mode

David Kaplan (1):
      x86/cpu: Fix check for RDPKRU in __show_regs()

Dragan Simic (1):
      arm64: dts: rockchip: Remove unsupported node from the Pinebook Pro dts

Duanqiang Wen (1):
      net: libwx: fix alloc msix vectors failed

Duoming Zhou (1):
      ax25: Fix netdev refcount issue

Eric Dumazet (4):
      icmp: prevent possible NULL dereferences from icmp_build_probe()
      net: fix sk_memory_allocated_{add|sub} vs softirqs
      ipv4: check for NULL idev in ip_route_use_hint()
      net: usb: ax88179_178a: stop lying about skb->truesize

Erwan Velu (1):
      i40e: Report MFS in decimal base instead of hex

Felix Fietkau (1):
      wifi: mac80211: split mesh fast tx cache into local/proxied/forwarded

Felix Kuehling (2):
      drm/amdkfd: Fix rescheduling of restore worker
      drm/amdkfd: Fix eviction fence handling

Fenghua Yu (1):
      dmaengine: idxd: Fix oops during rmmod on single-CPU platforms

Gabor Juhos (1):
      phy: qcom: m31: match requested regulator name with dt schema

George Shen (1):
      drm/amd/display: Check DP Alt mode DPCS state via DMUB

Greg Kroah-Hartman (1):
      Linux 6.8.9

Guanrui Huang (1):
      irqchip/gic-v3-its: Prevent double free on error

Gustavo A. R. Silva (1):
      smb: client: Fix struct_group() usage in __packed structs

Hangbin Liu (1):
      bridge/br_netlink.c: no need to return void function

Hans de Goede (1):
      phy: ti: tusb1210: Resolve charger-det crash if charger psy is unregistered

Himal Prasad Ghimiray (2):
      drm/xe: Remove sysfs only once on action add failure
      drm/xe: call free_gsc_pkt only once on action add failure

Huacai Chen (1):
      LoongArch: Fix callchain parse error with kernel tracepoint events

Hyunwoo Kim (3):
      tcp: Fix Use-After-Free in tcp_ao_connect_init
      net: gtp: Fix Use-After-Free in gtp_dellink
      net: openvswitch: Fix Use-After-Free in ovs_ct_exit

Ido Schimmel (12):
      mlxsw: core: Unregister EMAD trap using FORWARD action
      mlxsw: core_env: Fix driver initialization with old firmware
      mlxsw: pci: Fix driver initialization with old firmware
      mlxsw: spectrum_acl_tcam: Fix race in region ID allocation
      mlxsw: spectrum_acl_tcam: Fix race during rehash delayed work
      mlxsw: spectrum_acl_tcam: Fix possible use-after-free during activity update
      mlxsw: spectrum_acl_tcam: Fix possible use-after-free during rehash
      mlxsw: spectrum_acl_tcam: Rate limit error message
      mlxsw: spectrum_acl_tcam: Fix memory leak during rehash
      mlxsw: spectrum_acl_tcam: Fix warning during rehash
      mlxsw: spectrum_acl_tcam: Fix incorrect list API usage
      mlxsw: spectrum_acl_tcam: Fix memory leak when canceling rehash work

Ikjoon Jang (1):
      arm64: dts: mediatek: mt8183: Add power-domains properity to mfgcfg

Iskander Amara (2):
      arm64: dts: rockchip: fix alphabetical ordering RK3399 puma
      arm64: dts: rockchip: enable internal pull-up for Q7_THRM# on RK3399 Puma

Ismael Luceno (1):
      ipvs: Fix checksumming on GSO of SCTP packets

Iulia Tanasescu (1):
      Bluetooth: ISO: Reassemble PA data for bcast sink

Jacob Keller (1):
      ice: fix LAG and VF lock dependency in ice_reset_vf()

Jakub Kicinski (2):
      tools: ynl: don't ignore errors in NLMSG_DONE messages
      eth: bnxt: fix counting packets discarded due to OOM and netpoll

Jarred White (2):
      ACPI: CPPC: Use access_width over bit_width for system memory accesses
      ACPI: CPPC: Fix bit_offset shift in MASK_VAL() macro

Jason Reeder (1):
      net: ethernet: ti: am65-cpts: Fix PTPv1 message type on TX packets

Jiantao Shan (1):
      LoongArch: Fix access error when read fault on a write-only VMA

Jiri Pirko (1):
      dpll: check that pin is registered in __dpll_pin_unregister()

Johan Hovold (4):
      Bluetooth: qca: fix NULL-deref on non-serdev suspend
      Bluetooth: qca: fix NULL-deref on non-serdev setup
      arm64: dts: qcom: sc8280xp: add missing PCIe minimum OPP
      phy: qcom: qmp-combo: fix VCO div offset on v5_5nm and v6

Johannes Berg (3):
      wifi: mac80211_hwsim: init peer measurement result
      wifi: mac80211: remove link before AP
      wifi: mac80211: fix unaligned le16 access

Johannes Thumshirn (1):
      btrfs: fix information leak in btrfs_ioctl_logical_to_ino()

Johannes Weiner (1):
      mm: zswap: fix shrinker NULL crash with cgroup_disable=memory

Jonas Dreßler (3):
      Bluetooth: hci_event: Use HCI error defines instead of magic values
      Bluetooth: hci_conn: Only do ACL connections sequentially
      Bluetooth: Remove pending ACL connection attempts

Jose Ignacio Tornos Martinez (1):
      arm64: dts: rockchip: regulator for sd needs to be always on for BPI-R2Pro

Justin Chen (1):
      net: bcmasp: fix memory leak when bringing down interface

Kenny Levinsen (1):
      HID: i2c-hid: Revert to await reset ACK before reading report descriptor

Kirill A. Shutemov (1):
      x86/tdx: Preserve shared bit on mprotect()

Kuniyuki Iwashima (1):
      af_unix: Suppress false-positive lockdep splat for spin_lock() in __unix_gc().

Laine Taffin Altman (1):
      rust: init: remove impl Zeroable for Infallible

Lang Yu (1):
      drm/amdgpu/umsch: don't execute umsch test when GPU is in reset/suspend

Lijo Lazar (1):
      drm/amdgpu: Assign correct bits for SDMA HDP flush

Louis Chauvet (1):
      dmaengine: xilinx: xdma: Fix synchronization issue

Luca Weiss (1):
      arm64: dts: qcom: Fix type of "wdog" IRQs for remoteprocs

Lucas Stach (1):
      drm/atomic-helper: fix parameter order in drm_format_conv_state_copy() call

Luiz Augusto von Dentz (10):
      Bluetooth: hci_conn: Always use sk_timeo as conn_timeout
      Bluetooth: hci_conn: Fix UAF Write in __hci_acl_create_connection_sync
      Bluetooth: hci_sync: Add helper functions to manipulate cmd_sync queue
      Bluetooth: hci_sync: Attempt to dequeue connection attempt
      Bluetooth: hci_sync: Use advertised PHYs on hci_le_ext_create_conn_sync
      Bluetooth: hci_event: Fix sending HCI_OP_READ_ENC_KEY_SIZE
      Bluetooth: MGMT: Fix failing to MGMT_OP_ADD_UUID/MGMT_OP_REMOVE_UUID
      Bluetooth: hci_sync: Fix UAF in hci_acl_create_conn_sync
      Bluetooth: hci_sync: Fix UAF on create_le_conn_complete
      Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync

MD Danish Anwar (1):
      net: phy: dp83869: Fix MII mode failure

Ma Jun (1):
      drm/amdgpu/pm: Remove gpu_od if it's an empty directory

Maksim Kiselev (1):
      mmc: sdhci-of-dwcmshc: th1520: Increase tuning loop count to 128

Manivannan Sadhasivam (1):
      arm64: dts: qcom: sm8450: Fix the msi-map entries

Mantas Pucka (1):
      mmc: sdhci-msm: pervent access to suspended controller

Marcel Ziswiler (1):
      phy: freescale: imx8m-pcie: fix pcie link-up instability

Mathias Nyman (1):
      xhci: move event processing for one interrupter to a separate function

Matthew Wilcox (Oracle) (4):
      mm: create FOLIO_FLAG_FALSE and FOLIO_TYPE_OPS macros
      mm: support page_mapcount() on page_has_type() pages
      mm: turn folio_test_hugetlb into a PageType
      bounds: Use the right number of bits for power-of-two CONFIG_NR_CPUS

Matthias Schiffer (1):
      net: dsa: mv88e6xx: fix supported_interfaces setup in mv88e6250_phylink_get_caps()

Maximilian Luz (2):
      arm64: dts: qcom: sc8180x: Fix ss_phy_irq for secondary USB controller
      firmware: qcom: uefisecapp: Fix memory related IO errors and crashes

Miaohe Lin (1):
      mm/hugetlb: fix DEBUG_LOCKS_WARN_ON(1) when dissolve_free_hugetlb_folio()

Michael Chan (1):
      bnxt_en: Fix error recovery for 5760X (P7) chips

Michael Heimpold (1):
      ARM: dts: imx6ull-tarragon: fix USB over-current polarity

Michal Tomek (1):
      phy: rockchip-snps-pcie3: fix bifurcation on rk3588

Miguel Ojeda (2):
      kbuild: rust: remove unneeded `@rustc_cfg` to avoid ICE
      kbuild: rust: force `alloc` extern to allow "empty" Rust files

Mikhail Kobuk (2):
      phy: marvell: a3700-comphy: Fix out of bounds read
      phy: marvell: a3700-comphy: Fix hardcoded array size

Miquel Raynal (1):
      dmaengine: xilinx: xdma: Fix wrong offsets in the buffers addresses in dma descriptor

Miri Korenblit (1):
      wifi: iwlwifi: mvm: return uid from iwl_mvm_build_scan_cmd

Muhammed Efe Cetin (1):
      arm64: dts: rockchip: mark system power controller and fix typo on orangepi-5-plus

Mukul Joshi (1):
      drm/amdgpu: Fix leak when GPU memory allocation fails

Nam Cao (2):
      HID: i2c-hid: remove I2C_HID_READ_PENDING flag to prevent lock-up
      fbdev: fix incorrect address computation in deferred IO

Naohiro Aota (1):
      btrfs: scrub: run relocation repair when/only needed

Nathan Chancellor (1):
      Bluetooth: Fix type of len in {l2cap,sco}_sock_getsockopt_old()

Nícolas F. R. A. Prado (5):
      arm64: dts: mediatek: mt8192: Add missing gce-client-reg to mutex
      arm64: dts: mediatek: mt8195: Add missing gce-client-reg to vpp/vdosys
      arm64: dts: mediatek: mt8195: Add missing gce-client-reg to mutex
      arm64: dts: mediatek: mt8195: Add missing gce-client-reg to mutex1
      arm64: dts: mediatek: cherry: Describe CPU supplies

Oliver Neukum (1):
      usb: xhci: correct return value in case of STS_HCE

Pablo Neira Ayuso (1):
      netfilter: nf_tables: honor table dormant flag from netdev release event path

Patrik Jakobsson (1):
      drm/gma500: Remove lid code

Paul Geurts (1):
      NFC: trf7970a: disable all regulators on removal

Paulo Alcantara (1):
      smb: client: fix rename(2) regression against samba

Peter Münster (1):
      net: b44: set pause params only when interface is up

Peter Xu (1):
      mm/hugetlb: fix missing hugetlb_lock for resv uncharge

Pin-yen Lin (3):
      arm64: dts: mediatek: mt8192-asurada: Update min voltage constraint for MT6315
      arm64: dts: mediatek: mt8195-cherry: Update min voltage constraint for MT6315
      arm64: dts: mediatek: mt8183-kukui: Use default min voltage for MT6358

Prathamesh Shete (1):
      gpio: tegra186: Fix tegra186_gpio_is_accessible() check

Qu Wenruo (1):
      btrfs: fix wrong block_start calculation for btrfs_drop_extent_map_range()

Quentin Schulz (2):
      arm64: dts: rockchip: enable internal pull-up on Q7_USB_ID for RK3399 Puma
      arm64: dts: rockchip: enable internal pull-up on PCIE_WAKE# for RK3399 Puma

Rafał Miłecki (11):
      arm64: dts: mediatek: mt7622: fix clock controllers
      arm64: dts: mediatek: mt7622: fix IR nodename
      arm64: dts: mediatek: mt7622: fix ethernet controller "compatible"
      arm64: dts: mediatek: mt7622: drop "reset-names" from thermal block
      arm64: dts: mediatek: mt7986: reorder properties
      arm64: dts: mediatek: mt7986: drop invalid properties from ethsys
      arm64: dts: mediatek: mt7986: drop "#reset-cells" from Ethernet controller
      arm64: dts: mediatek: mt7986: reorder nodes
      arm64: dts: mediatek: mt7986: drop invalid thermal block clock
      arm64: dts: mediatek: mt7986: prefix BPI-R3 cooling maps with "map-"
      arm64: dts: mediatek: mt2712: fix validation errors

Rahul Rameshbabu (4):
      net/mlx5e: Advertise mlx5 ethernet driver updates sk_buff md_dst for MACsec
      ethernet: Add helper for assigning packet type when dest address does not match device address
      macsec: Enable devices to advertise whether they update sk_buff md_dst during offloads
      macsec: Detect if Rx skb is macsec-related for offloading devices that update md_dst

Rajendra Nayak (1):
      arm64: dts: qcom: x1e80100: Fix the compatible for cluster idle states

Rex Zhang (1):
      dmaengine: idxd: Convert spinlock to mutex to lock evl workqueue

Rob Herring (1):
      dt-bindings: eeprom: at24: Fix ST M24C64-D compatible schema

Sabrina Dubroca (1):
      tls: fix lockless read of strp->msg_ready in ->poll

Samuel Holland (2):
      riscv: Fix TASK_SIZE on 64-bit NOMMU
      riscv: Fix loading 64-bit NOMMU kernels past the start of RAM

Sean Anderson (1):
      dma: xilinx_dpdma: Fix locking

Sean Christopherson (3):
      KVM: x86/pmu: Zero out PMU metadata on AMD if PMU is disabled
      KVM: x86/pmu: Set enable bits for GP counters in PERF_GLOBAL_CTRL at "RESET"
      cpu: Re-enable CPU mitigations by default for !X86 architectures

Sean Wang (1):
      Bluetooth: btusb: mediatek: Fix double free of skb in coredump

Sebastian Reichel (2):
      phy: rockchip-snps-pcie3: fix clearing PHP_GRF_PCIESEL_CON bits
      phy: rockchip: naneng-combphy: Fix mux on rk3588

Sindhu Devale (1):
      i40e: Do not use WQ_MEM_RECLAIM flag for workqueue

Stephen Boyd (2):
      phy: qcom: qmp-combo: Fix register base for QSERDES_DP_PHY_MODE
      phy: qcom: qmp-combo: Fix VCO div offset on v3

Steve French (2):
      smb3: missing lock when picking channel
      smb3: fix lock ordering potential deadlock in cifs_sync_mid_result

Su Hui (1):
      octeontx2-af: fix the double free in rvu_npc_freemem()

Sudheer Mogilappagari (1):
      iavf: Fix TC config comparison with existing adapter TC config

Sweet Tea Dorminy (1):
      btrfs: fallback if compressed IO fails for ENOSPC

Takayuki Nagata (1):
      cifs: reinstate original behavior again for forceuid/forcegid

Terry Tritton (3):
      selftests/seccomp: user_notification_addfd check nextfd is available
      selftests/seccomp: Change the syscall used in KILL_THREAD test
      selftests/seccomp: Handle EINVAL on unshare(CLONE_NEWPID)

Tianchen Ding (2):
      sched/eevdf: Always update V if se->on_rq when reweighting
      sched/eevdf: Fix miscalculation in reweight_entity() when se is not curr

Vanshidhar Konda (1):
      ACPI: CPPC: Fix access width used for PCC registers

Vijendar Mukunda (1):
      soundwire: amd: fix for wake interrupt handling for clockstop mode

Vikas Gupta (2):
      bnxt_en: refactor reset close code
      bnxt_en: Fix the PCI-AER routines

Vinod Koul (1):
      dmaengine: Revert "dmaengine: pl330: issue_pending waits until WFP state"

WangYuli (1):
      Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x0bda:0x4853

Wedson Almeida Filho (2):
      rust: phy: implement `Send` for `Registration`
      rust: kernel: require `Send` for `Module` implementations

Wenkuan Wang (1):
      x86/CPU/AMD: Add models 0x10-0x1f to the Zen5 range

Wolfram Sang (1):
      i2c: smbus: fix NULL function pointer dereference

Xuewen Yan (1):
      sched/eevdf: Prevent vlag from going out of bounds in reweight_eevdf()

Yaraslau Furman (1):
      HID: logitech-dj: allow mice to use all types of reports

Yick Xie (1):
      udp: preserve the connected status if only UDP cmsg

Yu Kuai (1):
      block: fix module reference leakage from bdev_open_by_dev error path

Zhang Lixu (1):
      HID: intel-ish-hid: ipc: Fix dev_err usage with uninitialized dev->devc

Zijun Hu (1):
      Bluetooth: btusb: Fix triggering coredump implementation for QCA


