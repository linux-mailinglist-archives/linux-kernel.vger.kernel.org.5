Return-Path: <linux-kernel+bounces-143719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 403A98A3C96
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 13:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60DBF1C20F8E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 11:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E9D3FB1C;
	Sat, 13 Apr 2024 11:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WK9ogubX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8FB5103D;
	Sat, 13 Apr 2024 11:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713007593; cv=none; b=jyuWVtlWu4+e22st1uSYY0vb5uaDnsMVwI3CU74cmC503T0L6esy6cw3HQ1lCRvfecW7O910QeJBcg87kuDVKHqZzI5pd+pQXCuSHhqm883AtYmvYtndssayH1OXcWfN7l5yv6bwaXOpGCBs6GsZjEpjveivp8r2qwB4j2ii/CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713007593; c=relaxed/simple;
	bh=62ynfYKEbp1muvj8yjFYukLLongjZUxI7qEoCltQB/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gJiVSy/tgYXY7QbR6g4Ooduxwj2wMrLs/or2aZ7bBza+nDmU81Ewf0PwZdQr3KpydfCiMhk3RO4sE6SoeVQHuWhG/Ih5sHe/YkAAX3Aw1C7iqaPVMjlSF3U2bnMKnhTtW18xhf3FC3zNqbr31zUAG9nf8IZodKpp43tgfwUvf74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WK9ogubX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84216C4AF0A;
	Sat, 13 Apr 2024 11:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713007593;
	bh=62ynfYKEbp1muvj8yjFYukLLongjZUxI7qEoCltQB/E=;
	h=From:To:Cc:Subject:Date:From;
	b=WK9ogubX1sFxAXz//RnePveyaDG6f9j/o9bjd1UKPSiD19hcZu7EnalSF0LUVfwxP
	 FWUT3P5N3KigLIhvwPpH9H7EqbhgNsq+3ZrEzEbPL+RYNYcz0eVEkA7sBsNdQVllLt
	 x37/Hhumbh6F2Vp7bC9yMeV9ioeudHBHOWlJlgHU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.8.6
Date: Sat, 13 Apr 2024 13:26:28 +0200
Message-ID: <2024041329-trickster-conclude-0b20@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.8.6 kernel.

All users of the 6.8 kernel series must upgrade.

The updated 6.8.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.8.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                                     |    2 
 arch/arm/boot/dts/rockchip/rk322x.dtsi                                       |   16 +
 arch/arm/boot/dts/rockchip/rk3288.dtsi                                       |   16 +
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts                                     |   28 +++
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts                                 |   17 ++
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts                                     |   18 ++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi                                     |   11 +
 arch/arm64/boot/dts/rockchip/rk3399.dtsi                                     |   12 +
 arch/x86/entry/vdso/Makefile                                                 |   10 -
 arch/x86/events/amd/lbr.c                                                    |    6 
 arch/x86/include/asm/xen/hypervisor.h                                        |    5 
 arch/x86/pci/fixup.c                                                         |   48 +++++
 arch/x86/platform/pvh/enlighten.c                                            |    3 
 arch/x86/xen/enlighten.c                                                     |   32 +++
 arch/x86/xen/enlighten_pvh.c                                                 |   68 ++++++++
 arch/x86/xen/setup.c                                                         |   44 -----
 arch/x86/xen/xen-ops.h                                                       |   14 +
 block/blk-stat.c                                                             |    2 
 drivers/accel/habanalabs/common/habanalabs.h                                 |    2 
 drivers/acpi/resource.c                                                      |    7 
 drivers/acpi/sleep.c                                                         |   12 -
 drivers/acpi/x86/utils.c                                                     |   38 ++++
 drivers/bluetooth/btintel.c                                                  |    2 
 drivers/bluetooth/btmtk.c                                                    |    1 
 drivers/bluetooth/btmtk.h                                                    |    1 
 drivers/bluetooth/btusb.c                                                    |    1 
 drivers/bus/mhi/host/init.c                                                  |    1 
 drivers/bus/mhi/host/internal.h                                              |    9 -
 drivers/bus/mhi/host/pm.c                                                    |   20 ++
 drivers/cpufreq/cpufreq.c                                                    |   17 +-
 drivers/cpuidle/driver.c                                                     |    3 
 drivers/crypto/intel/iaa/iaa_crypto_main.c                                   |    4 
 drivers/firmware/tegra/bpmp-debugfs.c                                        |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c                                   |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                                   |   14 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                                      |    5 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                                     |    4 
 drivers/gpu/drm/amd/display/dc/dc.h                                          |    1 
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c                                 |    4 
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c                         |    2 
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c               |    1 
 drivers/gpu/drm/amd/display/modules/inc/mod_stats.h                          |    4 
 drivers/gpu/drm/ci/gitlab-ci.yml                                             |   14 +
 drivers/gpu/drm/ci/test.yml                                                  |    1 
 drivers/gpu/drm/drm_modeset_helper.c                                         |   19 +-
 drivers/gpu/drm/drm_panel_orientation_quirks.c                               |   12 +
 drivers/gpu/drm/drm_probe_helper.c                                           |   21 ++
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gm107.c                          |   12 -
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/r535.c                           |    1 
 drivers/gpu/drm/panel/panel-simple.c                                         |   20 ++
 drivers/gpu/drm/ttm/ttm_bo.c                                                 |    7 
 drivers/gpu/drm/vc4/vc4_plane.c                                              |    5 
 drivers/hid/hid-ids.h                                                        |    1 
 drivers/hid/hid-input.c                                                      |    2 
 drivers/i2c/busses/i2c-designware-core.h                                     |    2 
 drivers/infiniband/core/cm.c                                                 |   20 ++
 drivers/input/joystick/xpad.c                                                |    3 
 drivers/input/rmi4/rmi_driver.c                                              |    6 
 drivers/input/touchscreen/imagis.c                                           |   20 --
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                                  |   22 +-
 drivers/media/pci/sta2x11/sta2x11_vip.c                                      |    9 -
 drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c            |    8 
 drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c          |    5 
 drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h          |    2 
 drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c |    2 
 drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c                 |    2 
 drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c          |    5 
 drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h          |    2 
 drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c                 |    2 
 drivers/misc/vmw_vmci/vmci_datagram.c                                        |    6 
 drivers/net/dsa/qca/qca8k-8xxx.c                                             |    3 
 drivers/net/dummy.c                                                          |    1 
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c                              |    9 -
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c                          |    2 
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c                             |   14 -
 drivers/net/ethernet/intel/ice/ice_virtchnl.c                                |    9 -
 drivers/net/ethernet/intel/ice/ice_virtchnl.h                                |    9 +
 drivers/net/ethernet/pensando/ionic/ionic_lif.c                              |    5 
 drivers/net/ethernet/stmicro/stmmac/Kconfig                                  |    6 
 drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c                         |   32 +++
 drivers/net/geneve.c                                                         |    1 
 drivers/net/loopback.c                                                       |    1 
 drivers/net/pcs/pcs-xpcs.c                                                   |    4 
 drivers/net/phy/phy_device.c                                                 |   13 -
 drivers/net/veth.c                                                           |    1 
 drivers/net/vxlan/vxlan_core.c                                               |    1 
 drivers/net/wireless/ath/ath11k/mhi.c                                        |    2 
 drivers/net/wireless/ath/ath9k/antenna.c                                     |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c                       |    9 +
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c                               |    6 
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c                                  |    2 
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c                                  |   38 ++++
 drivers/net/wireless/intel/iwlwifi/iwl-config.h                              |    8 
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c                                |   16 +
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c                             |   45 ++++-
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h                           |    1 
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c                              |    5 
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c                             |   64 ++++---
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h                           |    3 
 drivers/net/wireless/realtek/rtw89/mac80211.c                                |    4 
 drivers/net/wireless/realtek/rtw89/pci.c                                     |   60 ++++++-
 drivers/net/wireless/realtek/rtw89/pci.h                                     |    6 
 drivers/net/wireless/realtek/rtw89/rtw8851be.c                               |    2 
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c                               |    1 
 drivers/net/wireless/realtek/rtw89/rtw8852be.c                               |    1 
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c                               |    1 
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c                               |    1 
 drivers/nvme/host/pci.c                                                      |    3 
 drivers/perf/hisilicon/hisi_uncore_uc_pmu.c                                  |   42 ++++
 drivers/pinctrl/renesas/core.c                                               |    4 
 drivers/platform/x86/acer-wmi.c                                              |   17 +-
 drivers/platform/x86/intel/hid.c                                             |    7 
 drivers/platform/x86/intel/vbtn.c                                            |    5 
 drivers/platform/x86/touchscreen_dmi.c                                       |    9 +
 drivers/pmdomain/imx/imx8mp-blk-ctrl.c                                       |   10 -
 drivers/pmdomain/ti/omap_prm.c                                               |    2 
 drivers/scsi/lpfc/lpfc_nportdisc.c                                           |    6 
 drivers/soundwire/dmi-quirks.c                                               |    8 
 drivers/thermal/thermal_of.c                                                 |   12 -
 drivers/thunderbolt/quirks.c                                                 |   14 +
 drivers/thunderbolt/tb.c                                                     |   49 +++++
 drivers/thunderbolt/tb.h                                                     |    4 
 drivers/thunderbolt/tunnel.c                                                 |   16 -
 drivers/tty/serial/8250/8250_of.c                                            |   44 ++++-
 drivers/tty/serial/8250/8250_port.c                                          |   24 --
 drivers/ufs/host/ufs-qcom.c                                                  |   13 +
 drivers/usb/gadget/function/uvc_video.c                                      |   10 -
 drivers/usb/host/sl811-hcd.c                                                 |    2 
 drivers/usb/typec/tcpm/tcpci.c                                               |    1 
 drivers/usb/typec/ucsi/ucsi.c                                                |   26 ++-
 drivers/usb/typec/ucsi/ucsi.h                                                |   11 +
 drivers/usb/typec/ucsi/ucsi_glink.c                                          |    1 
 drivers/video/fbdev/core/fbmon.c                                             |    7 
 drivers/video/fbdev/via/accel.c                                              |    4 
 drivers/xen/balloon.c                                                        |    2 
 fs/btrfs/export.c                                                            |    9 -
 fs/btrfs/send.c                                                              |   10 +
 fs/btrfs/volumes.c                                                           |   12 +
 fs/ext4/mballoc.c                                                            |    5 
 fs/ext4/super.c                                                              |   12 +
 fs/isofs/inode.c                                                             |   18 +-
 fs/kernfs/dir.c                                                              |   31 ++-
 fs/kernfs/kernfs-internal.h                                                  |    2 
 fs/orangefs/super.c                                                          |    2 
 fs/pstore/zone.c                                                             |    2 
 fs/sysv/itree.c                                                              |   10 -
 include/acpi/acpi_bus.h                                                      |   14 -
 include/linux/kernfs.h                                                       |    2 
 include/linux/overflow.h                                                     |   12 -
 include/linux/printk.h                                                       |    2 
 include/linux/randomize_kstack.h                                             |    2 
 include/linux/rcupdate.h                                                     |    4 
 include/linux/skbuff.h                                                       |   11 +
 include/linux/sunrpc/sched.h                                                 |    2 
 include/net/bluetooth/hci.h                                                  |    8 
 include/uapi/linux/input-event-codes.h                                       |    1 
 io_uring/io_uring.c                                                          |   25 +-
 kernel/dma/direct.c                                                          |    9 -
 kernel/panic.c                                                               |    8 
 kernel/printk/internal.h                                                     |    1 
 kernel/printk/printk.c                                                       |    3 
 kernel/rcu/tree_nocb.h                                                       |    2 
 kernel/trace/ring_buffer.c                                                   |    2 
 lib/dump_stack.c                                                             |   16 +
 net/bluetooth/hci_event.c                                                    |    3 
 net/core/netdev-genl.c                                                       |   15 -
 net/core/page_pool_user.c                                                    |    2 
 net/ipv4/ip_tunnel.c                                                         |    1 
 net/ipv6/ip6_gre.c                                                           |    2 
 net/ipv6/ip6_tunnel.c                                                        |    1 
 net/ipv6/ip6_vti.c                                                           |    1 
 net/ipv6/sit.c                                                               |    1 
 net/mpls/mpls_gso.c                                                          |    3 
 net/smc/smc_pnet.c                                                           |   10 +
 net/wireless/util.c                                                          |   14 +
 scripts/gcc-plugins/stackleak_plugin.c                                       |    2 
 scripts/mod/modpost.c                                                        |    4 
 sound/firewire/amdtp-stream.c                                                |   12 -
 sound/firewire/amdtp-stream.h                                                |    4 
 sound/pci/hda/patch_realtek.c                                                |   12 +
 sound/soc/amd/yc/acp6x-mach.c                                                |    7 
 sound/soc/intel/avs/board_selection.c                                        |   85 ++++++++++
 sound/soc/intel/boards/sof_rt5682.c                                          |   40 ----
 sound/soc/intel/boards/sof_sdw.c                                             |   11 +
 sound/soc/soc-core.c                                                         |    3 
 sound/soc/sof/amd/acp.c                                                      |    3 
 tools/iio/iio_utils.c                                                        |    2 
 tools/lib/perf/evlist.c                                                      |   18 +-
 tools/lib/perf/include/internal/evlist.h                                     |    4 
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c              |    1 
 tools/testing/ktest/ktest.pl                                                 |    1 
 191 files changed, 1530 insertions(+), 450 deletions(-)

Abhishek Pandit-Subedi (1):
      usb: typec: ucsi: Limit read size on v1.2

Adam Ford (1):
      pmdomain: imx8mp-blk-ctrl: imx8mp_blk: Add fdcc clock to hdmimix domain

Ahmad Rehman (1):
      drm/amdgpu: Init zone device and drm client after mode-1 reset on reload

Alban Boyé (1):
      platform/x86: touchscreen_dmi: Add an extra entry for a variant of the Chuwi Vi8 tablet

Aleksandr Burakov (1):
      fbdev: viafb: fix typo in hw_bitblt_1 and hw_bitblt_2

Alex Henrie (1):
      isofs: handle CDs with bad root inode but good Joliet root directory

Andre Werner (1):
      net: phy: phy_device: Prevent nullptr exceptions on ISR

Andy Shevchenko (1):
      serial: 8250_of: Drop quirk fot NPCM from 8250_port

Ard Biesheuvel (1):
      gcc-plugins/stackleak: Avoid .head.text section

Aric Cyr (1):
      drm/amd/display: Fix nanosec stat overflow

Arnd Bergmann (1):
      media: sta2x11: fix irq handler cast

Baochen Qiang (1):
      wifi: ath11k: decrease MHI channel buffer length to 8KB

Bjorn Andersson (1):
      arm64: dts: qcom: qcs6490-rb3gen2: Declare GCC clocks protected

Borislav Petkov (AMD) (1):
      x86/vdso: Fix rethunk patching for vdso-image-x32.o too

Brent Lu (1):
      ASoC: Intel: sof_rt5682: dmi quirk cleanup for mtl boards

C Cheng (1):
      cpuidle: Avoid potential overflow in integer multiplication

Cezary Rojewski (1):
      ASoC: Intel: avs: Populate board selection with new I2S entries

Chancel Liu (1):
      ASoC: soc-core.c: Skip dummy codec when adding platforms

Christian König (1):
      drm/ttm: return ENOSPC from ttm_bo_mem_space v3

Colin Ian King (1):
      usb: sl811-hcd: only defined function checkdone if QUIRK2 is defined

Cristian Ciocaltea (2):
      net: stmmac: dwmac-starfive: Add support for JH7100 SoC
      ASoC: SOF: amd: Optimize quirk for Valve Galileo

Dai Ngo (1):
      SUNRPC: increase size of rpc_wait_queue.qlen from unsigned short to unsigned int

Daniel Drake (2):
      PCI: Disable D3cold on Asus B1400 PCI-NVMe bridge
      Revert "ACPI: PM: Block ASUS B1400CEAE from suspend to idle by default"

Dave Airlie (2):
      amdkfd: use calloc instead of kzalloc to avoid integer overflow
      nouveau: fix devinit paths to only handle display on GSP.

David McFarland (1):
      platform/x86/intel/hid: Don't wake on 5-button releases

David Sterba (3):
      btrfs: handle chunk tree lookup error in btrfs_relocate_sys_chunks()
      btrfs: export: handle invalid inode or root reference in btrfs_get_parent()
      btrfs: send: handle path ref underflow in header iterate_inode_ref()

Dmitry Antipov (1):
      wifi: ath9k: fix LNA selection in ath_ant_try_scan()

Dmitry Baryshkov (1):
      arm64: dts: qcom: qrb2210-rb1: disable cluster power domains

Dmitry Torokhov (1):
      HID: input: avoid polling stylus battery on Chromebook Pompom

Duje Mihanović (1):
      Input: imagis - use FIELD_GET where applicable

Edward Adam Davis (1):
      Bluetooth: btintel: Fix null ptr deref in btintel_read_version

Eric Chanudet (1):
      scsi: ufs: qcom: Avoid re-init quirk when gears match

Eric Dumazet (2):
      net: add netdev_lockdep_set_classes() to virtual drivers
      net/smc: reduce rtnl pressure in smc_pnet_create_pnetids_list()

Florian Westphal (2):
      net: skbuff: add overflow debug check to pull/push helpers
      net: mpls: error out if inner headers are not set

Geert Uytterhoeven (1):
      pinctrl: renesas: checker: Limit cfg reg enum checks to provided IDs

Gergo Koteles (1):
      Input: allocate keycode for Display refresh rate toggle

Gil Fine (1):
      thunderbolt: Calculate DisplayPort tunnel bandwidth after DPRX capabilities read

Greg Kroah-Hartman (1):
      Linux 6.8.6

Gwendal Grignou (1):
      platform/x86: intel-vbtn: Update tablet mode switch at end of probe

Hans de Goede (3):
      wifi: brcmfmac: Add DMI nvram filename quirk for ACEPC W5 Pro
      ACPI: x86: Move acpi_quirk_skip_serdev_enumeration() out of CONFIG_X86_ANDROID_TABLETS
      ACPI: x86: Add DELL0501 handling to acpi_quirk_skip_serdev_enumeration()

Harshit Mogalapalli (1):
      VMCI: Fix memcpy() run-time warning in dg_dispatch_as_host()

Hui Liu (1):
      arm64: dts: qcom: qcm6490-idp: Add definition for three LEDs

Ian Rogers (1):
      libperf evlist: Avoid out-of-bounds access

Jacob Keller (1):
      ice: use relative VSI index for VFs instead of PF VSI number

Jakub Kicinski (1):
      netdev: let netlink core handle -EMSGSIZE errors

Jarkko Nikula (1):
      i2c: designware: Fix RX FIFO depth define on Wangxun 10Gb NIC

Jason Gunthorpe (1):
      iommu/arm-smmu-v3: Hold arm_smmu_asid_lock during all of attach_dev

Jeffrey Hugo (1):
      bus: mhi: host: Add MHI_PM_SYS_ERR_FAIL state

Jens Axboe (1):
      io_uring: clear opcode specific data for an early failure

Jiawei Fu (iBug) (1):
      drivers/nvme: Add quirks for device 126f:2262

Jichi Zhang (1):
      ALSA: hda/realtek: Add quirk for Lenovo Yoga 9 14IMH9

Johan Jonker (4):
      ARM: dts: rockchip: fix rk3288 hdmi ports node
      ARM: dts: rockchip: fix rk322x hdmi ports node
      arm64: dts: rockchip: fix rk3328 hdmi ports node
      arm64: dts: rockchip: fix rk3399 hdmi ports node

Johannes Berg (1):
      wifi: cfg80211: check A-MSDU format more carefully

John Ogness (3):
      printk: For @suppress_panic_printk check for other CPU in panic
      panic: Flush kernel log buffer at the end
      dump_stack: Do not get cpu_sync for panic CPU

Josh Poimboeuf (1):
      x86/vdso: Fix rethunk patching for vdso-image-{32,64}.o

Junhao He (1):
      drivers/perf: hisi: Enable HiSilicon Erratum 162700402 quirk for HIP09

Justin Tee (1):
      scsi: lpfc: Fix possible memory leak in lpfc_rcv_padisc()

Kees Cook (3):
      bnx2x: Fix firmware version string character counts
      overflow: Allow non-type arg to type_max() and type_min()
      randomize_kstack: Improve entropy diffusion

Koby Elbaz (1):
      accel/habanalabs: increase HL_MAX_STR to 64 bytes to avoid warnings

Konrad Dybcio (1):
      thermal/of: Assume polling-delay(-passive) 0 when absent

Kunwu Chan (3):
      pmdomain: ti: Add a null pointer check to the omap_prm_domain_init
      pstore/zone: Add a null pointer check to the psz_kmsg_read
      Input: synaptics-rmi4 - fail probing if memory allocation for "phys" fails

Luca Weiss (1):
      usb: typec: ucsi: Add qcm6490-pmic-glink as needing PDOS quirk

Luiz Augusto von Dentz (1):
      Bluetooth: btintel: Fixe build regression

M Cooley (1):
      ASoC: amd: yc: Fix non-functional mic on ASUS M7600RE

Ma Jun (1):
      Revert "drm/amd/amdgpu: Fix potential ioremap() memory leaks in amdgpu_device_init()"

Manjunath Patil (1):
      RDMA/cm: add timeout to cm_destroy_id wait

Marco Felsch (1):
      usb: typec: tcpci: add generic tcpci fallback compatible

Markus Elfring (1):
      firmware: tegra: bpmp: Return directly after a failed kzalloc() in get_filename()

Markuss Broks (1):
      input/touchscreen: imagis: Correct the maximum touch area value

Matt Scialabba (1):
      Input: xpad - add support for Snakebyte GAMEPADs

Max Kellermann (1):
      modpost: fix null pointer dereference

Maíra Canal (1):
      drm/vc4: don't check if plane->state->fb == state->fb

Michael Grzeschik (2):
      usb: gadget: uvc: refactor the check for a valid buffer in the pump worker
      usb: gadget: uvc: mark incomplete frames with UVC_STREAM_ERR

Mika Westerberg (1):
      thunderbolt: Keep the domain powered when USB4 port is in redrive mode

Mike Marshall (1):
      Julia Lawall reported this null pointer dereference, this should fix it.

Mukesh Sisodiya (2):
      wifi: iwlwifi: pcie: Add the PCI device id for new hardware
      wifi: iwlwifi: pcie: Add new PCI device id and CNVI

Nicholas Kazlauskas (1):
      drm/amd/display: Disable idle reallow as part of command/gpint execution

Nicolas Dufresne (1):
      media: mediatek: vcodec: Fix oops when HEVC init fails

Paul E. McKenney (1):
      rcu-tasks: Repair RCU Tasks Trace quiescence check

Peter Chiu (1):
      wifi: mt76: mt7996: disable AMSDU for non-data frames

Petre Rodan (1):
      tools: iio: replace seekdir() in iio_generic_buffer

Ping-Ke Shih (2):
      wifi: rtw89: pci: validate RX tag for RXQ and RPQ
      wifi: rtw89: pci: enlarge RX DMA buffer to consider size of RX descriptor

Po-Hao Huang (1):
      wifi: rtw89: fix null pointer access when abort scan

Ricardo B. Marliere (1):
      ktest: force $buildonly = 1 for 'make_warnings_file' test type

Rick Edgecombe (1):
      dma-direct: Leak pages on dma_set_decrypted() failure

Roger Pau Monne (1):
      x86/xen: attempt to inflate the memory balloon on PVH

Roman Smirnov (2):
      block: prevent division by zero in blk_rq_stat_sum()
      fbmon: prevent division by zero in fb_videomode_from_videomode()

Samasth Norway Ananda (1):
      tools/power x86_energy_perf_policy: Fix file leak in get_pkg_num()

Samuel Dionne-Riel (1):
      drm: panel-orientation-quirks: Add quirk for GPD Win Mini

Sandipan Das (1):
      perf/x86/amd/lbr: Discard erroneous branch entries

Serge Semin (1):
      net: pcs: xpcs: Return EINVAL in the internal methods

Shannon Nelson (1):
      ionic: set adminq irq affinity

Shayne Chen (2):
      wifi: mt76: mt7915: add locking for accessing mapped registers
      wifi: mt76: mt7996: add locking for accessing mapped registers

Shradha Gupta (2):
      drm: Check output polling initialized before disabling
      drm: Check polling initialized before enabling in drm_helper_probe_single_connector_modes

Sohaib Nadeem (1):
      drm/amd/display: increased min_dcfclk_mhz and min_fclk_mhz

Srinivasan Shanmugam (1):
      drm/amd/amdgpu: Fix potential ioremap() memory leaks in amdgpu_device_init()

Stanley.Yang (1):
      drm/amdgpu: Skip do PCI error slot reset during RAS recovery

SungHwan Jung (2):
      platform/x86: acer-wmi: Add support for Acer PH16-71
      platform/x86: acer-wmi: Add predator_v4 module parameter

Sviatoslav Harasymchuk (1):
      ACPI: resource: Add IRQ override quirk for ASUS ExpertBook B2502FBA

Takashi Iwai (2):
      wifi: iwlwifi: Add missing MODULE_FIRMWARE() for *.pnvm
      Bluetooth: btmtk: Add MODULE_FIRMWARE() for MT7922

Takashi Sakamoto (1):
      ALSA: firewire-lib: handle quirk to calculate payload quadlets as data block counter

Tejun Heo (1):
      kernfs: RCU protect kernfs_nodes and avoid kernfs_idr_lock in kernfs_find_and_get_node_by_id()

Tetsuo Handa (1):
      sysv: don't call sb_bread() with pointers_lock held

Tim Crawford (1):
      ALSA: hda/realtek: Add quirks for some Clevo laptops

Tom Zanussi (1):
      crypto: iaa - Fix async_disable descriptor leak

Tony Lindgren (1):
      drm/panel: simple: Add BOE BP082WX1-100 8.2" panel

Vasiliy Kovalev (1):
      VMCI: Fix possible memcpy() run-time warning in vmci_datagram_invoke_guest_handler()

Vignesh Raman (1):
      drm/ci: uprev mesa version: fix kdl commit fetch

Vinicius Peixoto (1):
      Bluetooth: Add new quirk for broken read key length on ATS2851

Viresh Kumar (1):
      cpufreq: Don't unregister cpufreq cooling on CPU hotplug

Vladimir Oltean (1):
      net: dsa: qca8k: put MDIO controller OF node if unavailable

Ye Bin (1):
      ext4: forbid commit inconsistent quota data when errors=remount-ro

Yunfei Dong (2):
      media: mediatek: vcodec: adding lock to protect decoder context list
      media: mediatek: vcodec: adding lock to protect encoder context list

Zhang Yi (1):
      ext4: add a hint for block bitmap corrupt state in mb_groups

Zqiang (1):
      rcu/nocb: Fix WARN_ON_ONCE() in the rcu_nocb_bypass_lock()

linke li (1):
      ring-buffer: use READ_ONCE() to read cpu_buffer->commit_page in concurrent environment

mosomate (1):
      ASoC: Intel: common: DMI remap for rebranded Intel NUC M15 (LAPRC710) laptops


