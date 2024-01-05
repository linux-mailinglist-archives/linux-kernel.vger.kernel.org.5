Return-Path: <linux-kernel+bounces-17955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F4D825603
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092981F27BF0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369B33174D;
	Fri,  5 Jan 2024 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pFx4UHWc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8336B2E3F7;
	Fri,  5 Jan 2024 14:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05749C43395;
	Fri,  5 Jan 2024 14:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704465883;
	bh=W9QWUgYFc5W1UGvCj2r/tuzPHL6QRDCMN/REtrkovog=;
	h=From:To:Cc:Subject:Date:From;
	b=pFx4UHWcZZTvopc3wxb+OfUgojma9z2BWubUhoY6cuHP0TP9ZyLeoNC1Mhuy6G9SR
	 wjEfNxUFK1mTSBlE7TWHubO2d3ylrMlprpcH+NdZbdiUlwDakNAJsfDz8onfLlcagE
	 EeWNZsFfBLX6pUAj7ofPdxj3fNZ3a8dUD3PpgkXw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.146
Date: Fri,  5 Jan 2024 15:42:32 +0100
Message-ID: <2024010533-untrimmed-cure-1ca0@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.146 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml            |   10 
 Makefile                                                          |    2 
 arch/arm/boot/dts/am33xx.dtsi                                     |    1 
 arch/arm/boot/dts/dra7.dtsi                                       |    2 
 arch/arm/mach-omap2/id.c                                          |    5 
 arch/arm64/kvm/arm.c                                              |    2 
 arch/arm64/kvm/vgic/vgic-init.c                                   |    5 
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                                |    2 
 arch/arm64/kvm/vgic/vgic.h                                        |    1 
 arch/s390/include/asm/fpu/api.h                                   |    2 
 arch/x86/kernel/alternative.c                                     |    2 
 arch/x86/net/bpf_jit_comp.c                                       |   46 +
 drivers/base/property.c                                           |   13 
 drivers/bus/ti-sysc.c                                             |   18 
 drivers/gpio/gpio-dwapb.c                                         |   12 
 drivers/gpio/gpiolib-cdev.c                                       |   16 
 drivers/gpu/drm/i915/display/intel_atomic.c                       |  193 -------
 drivers/gpu/drm/i915/display/intel_atomic.h                       |    4 
 drivers/gpu/drm/i915/display/skl_scaler.c                         |  257 ++++++++++
 drivers/gpu/drm/i915/display/skl_scaler.h                         |   10 
 drivers/i2c/busses/i2c-aspeed.c                                   |   48 +
 drivers/iio/adc/ti_am335x_adc.c                                   |    4 
 drivers/iio/buffer/industrialio-triggered-buffer.c                |   10 
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c                    |    4 
 drivers/iio/imu/adis16475.c                                       |  117 ++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c                        |    4 
 drivers/input/keyboard/ipaq-micro-keys.c                          |    3 
 drivers/input/misc/soc_button_array.c                             |    5 
 drivers/interconnect/core.c                                       |    3 
 drivers/md/dm-integrity.c                                         |   11 
 drivers/net/ethernet/actions/owl-emac.c                           |    2 
 drivers/net/ethernet/adaptec/starfire.c                           |   10 
 drivers/net/ethernet/alacritech/slicoss.c                         |    2 
 drivers/net/ethernet/alteon/acenic.c                              |    4 
 drivers/net/ethernet/altera/altera_tse_main.c                     |    2 
 drivers/net/ethernet/amd/nmclan_cs.c                              |    3 
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c                          |    2 
 drivers/net/ethernet/amd/xgbe/xgbe.h                              |    2 
 drivers/net/ethernet/apm/xgene-v2/mac.c                           |    2 
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.c                    |    2 
 drivers/net/ethernet/apm/xgene/xgene_enet_sgmac.c                 |    2 
 drivers/net/ethernet/apm/xgene/xgene_enet_xgmac.c                 |    2 
 drivers/net/ethernet/apple/bmac.c                                 |    8 
 drivers/net/ethernet/aquantia/atlantic/aq_hw.h                    |    6 
 drivers/net/ethernet/aquantia/atlantic/aq_macsec.c                |    2 
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c         |    4 
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c         |    4 
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.h         |    2 
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c      |    4 
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c |    4 
 drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c          |    2 
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c                   |    5 
 drivers/net/ethernet/broadcom/b44.c                               |    6 
 drivers/net/ethernet/broadcom/bcmsysport.c                        |    2 
 drivers/net/ethernet/broadcom/bgmac.c                             |    2 
 drivers/net/ethernet/broadcom/bnx2.c                              |    2 
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h                       |    2 
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c                  |    4 
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.h                 |    3 
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c                  |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                         |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c                   |    4 
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.h                   |    2 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                    |    4 
 drivers/net/ethernet/calxeda/xgmac.c                              |    2 
 drivers/net/ethernet/chelsio/cxgb/gmac.h                          |    2 
 drivers/net/ethernet/chelsio/cxgb/pm3393.c                        |    2 
 drivers/net/ethernet/chelsio/cxgb/vsc7326.c                       |    2 
 drivers/net/ethernet/chelsio/cxgb3/common.h                       |    2 
 drivers/net/ethernet/chelsio/cxgb3/xgmac.c                        |    2 
 drivers/net/ethernet/cisco/enic/enic_pp.c                         |    2 
 drivers/net/ethernet/dlink/dl2k.c                                 |    2 
 drivers/net/ethernet/dnet.c                                       |    6 
 drivers/net/ethernet/emulex/benet/be_cmds.c                       |    2 
 drivers/net/ethernet/emulex/benet/be_cmds.h                       |    2 
 drivers/net/ethernet/emulex/benet/be_main.c                       |    2 
 drivers/net/ethernet/ethoc.c                                      |    2 
 drivers/net/ethernet/fealnx.c                                     |    2 
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c                    |    4 
 drivers/net/ethernet/freescale/fman/fman_dtsec.c                  |    8 
 drivers/net/ethernet/freescale/fman/fman_dtsec.h                  |    2 
 drivers/net/ethernet/freescale/fman/fman_memac.c                  |    8 
 drivers/net/ethernet/freescale/fman/fman_memac.h                  |    2 
 drivers/net/ethernet/freescale/fman/fman_tgec.c                   |    8 
 drivers/net/ethernet/freescale/fman/fman_tgec.h                   |    2 
 drivers/net/ethernet/freescale/fman/mac.h                         |    2 
 drivers/net/ethernet/hisilicon/hisi_femac.c                       |    2 
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c                     |    2 
 drivers/net/ethernet/hisilicon/hns/hnae.h                         |    2 
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c                 |    2 
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c                |    2 
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c                 |    2 
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h                 |    5 
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c               |    2 
 drivers/net/ethernet/hisilicon/hns3/hnae3.h                       |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c           |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c         |    2 
 drivers/net/ethernet/i825xx/sun3_82586.c                          |    2 
 drivers/net/ethernet/intel/i40e/i40e.h                            |    2 
 drivers/net/ethernet/intel/ixgb/ixgb_hw.c                         |    2 
 drivers/net/ethernet/intel/ixgb/ixgb_hw.h                         |    2 
 drivers/net/ethernet/marvell/mv643xx_eth.c                        |    2 
 drivers/net/ethernet/marvell/mvneta.c                             |    4 
 drivers/net/ethernet/marvell/pxa168_eth.c                         |    6 
 drivers/net/ethernet/mediatek/mtk_star_emac.c                     |    2 
 drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c          |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c       |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c               |   30 -
 drivers/net/ethernet/mellanox/mlx5/core/en_fs.c                   |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c                  |    2 
 drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c             |    2 
 drivers/net/ethernet/mellanox/mlx5/core/vport.c                   |    2 
 drivers/net/ethernet/micrel/ks8842.c                              |    2 
 drivers/net/ethernet/micrel/ks8851.h                              |    3 
 drivers/net/ethernet/micrel/ks8851_common.c                       |   20 
 drivers/net/ethernet/micrel/ks8851_spi.c                          |   42 +
 drivers/net/ethernet/micrel/ksz884x.c                             |    4 
 drivers/net/ethernet/microsoft/Kconfig                            |    1 
 drivers/net/ethernet/myricom/myri10ge/myri10ge.c                  |    3 
 drivers/net/ethernet/neterion/s2io.c                              |    2 
 drivers/net/ethernet/neterion/s2io.h                              |    2 
 drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c           |    6 
 drivers/net/ethernet/nxp/lpc_eth.c                                |    2 
 drivers/net/ethernet/qlogic/qed/qed_dev.c                         |    2 
 drivers/net/ethernet/qlogic/qed/qed_dev_api.h                     |    2 
 drivers/net/ethernet/qlogic/qed/qed_l2.c                          |    2 
 drivers/net/ethernet/qlogic/qed/qed_main.c                        |    2 
 drivers/net/ethernet/qlogic/qed/qed_mcp.c                         |    2 
 drivers/net/ethernet/qlogic/qed/qed_mcp.h                         |    2 
 drivers/net/ethernet/qlogic/qed/qed_rdma.c                        |    2 
 drivers/net/ethernet/qlogic/qed/qed_vf.c                          |    2 
 drivers/net/ethernet/qlogic/qed/qed_vf.h                          |    4 
 drivers/net/ethernet/qlogic/qede/qede_filter.c                    |    2 
 drivers/net/ethernet/qualcomm/emac/emac-mac.c                     |    2 
 drivers/net/ethernet/rdc/r6040.c                                  |   12 
 drivers/net/ethernet/samsung/sxgbe/sxgbe_common.h                 |    2 
 drivers/net/ethernet/samsung/sxgbe/sxgbe_core.c                   |    3 
 drivers/net/ethernet/sfc/ef10.c                                   |    4 
 drivers/net/ethernet/sfc/ef10_sriov.c                             |    2 
 drivers/net/ethernet/sfc/ef10_sriov.h                             |    6 
 drivers/net/ethernet/sfc/net_driver.h                             |    2 
 drivers/net/ethernet/sfc/siena_sriov.c                            |    2 
 drivers/net/ethernet/sfc/siena_sriov.h                            |    2 
 drivers/net/ethernet/sis/sis900.c                                 |    2 
 drivers/net/ethernet/smsc/smsc911x.c                              |    2 
 drivers/net/ethernet/smsc/smsc9420.c                              |    2 
 drivers/net/ethernet/stmicro/stmmac/common.h                      |    4 
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c                 |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c              |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c               |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c                 |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c                  |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c                   |    2 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c               |    3 
 drivers/net/ethernet/stmicro/stmmac/hwif.h                        |    3 
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c            |    4 
 drivers/net/ethernet/sun/sunbmac.c                                |    2 
 drivers/net/ethernet/sun/sunqe.c                                  |    2 
 drivers/net/ethernet/synopsys/dwc-xlgmac-hw.c                     |    2 
 drivers/net/ethernet/synopsys/dwc-xlgmac.h                        |    2 
 drivers/net/ethernet/ti/tlan.c                                    |    4 
 drivers/net/ethernet/toshiba/tc35815.c                            |    3 
 drivers/net/ethernet/xilinx/xilinx_emaclite.c                     |    7 
 drivers/net/ethernet/xircom/xirc2ps_cs.c                          |    2 
 drivers/net/phy/mscc/mscc_main.c                                  |    2 
 drivers/net/usb/aqc111.c                                          |    2 
 drivers/net/usb/ax88179_178a.c                                    |  224 ++++----
 drivers/net/usb/catc.c                                            |    2 
 drivers/net/usb/dm9601.c                                          |    3 
 drivers/net/usb/mcs7830.c                                         |    3 
 drivers/net/usb/sr9700.c                                          |    3 
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c                   |    4 
 drivers/pinctrl/pinctrl-at91-pio4.c                               |    8 
 drivers/reset/core.c                                              |    8 
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                                 |    9 
 drivers/scsi/scsi_error.c                                         |    2 
 drivers/spi/spi.c                                                 |   12 
 drivers/usb/host/fotg210-hcd.c                                    |    3 
 drivers/usb/serial/ftdi_sio.c                                     |    6 
 drivers/usb/serial/ftdi_sio_ids.h                                 |    6 
 drivers/usb/serial/option.c                                       |    5 
 fs/Kconfig                                                        |    4 
 fs/afs/cell.c                                                     |   67 +-
 fs/afs/cmservice.c                                                |    2 
 fs/afs/dynroot.c                                                  |   31 -
 fs/afs/internal.h                                                 |   18 
 fs/afs/proc.c                                                     |    6 
 fs/afs/rxrpc.c                                                    |   26 -
 fs/afs/server.c                                                   |   40 -
 fs/afs/vl_list.c                                                  |   19 
 fs/afs/volume.c                                                   |   47 +
 fs/cifs/misc.c                                                    |    4 
 fs/cifs/smb2misc.c                                                |   26 -
 fs/cifs/smb2ops.c                                                 |   26 -
 fs/cifs/smb2pdu.c                                                 |   29 -
 fs/cifs/smb2pdu.h                                                 |    2 
 fs/fuse/fuse_i.h                                                  |   15 
 fs/fuse/inode.c                                                   |   75 ++
 fs/ksmbd/oplock.c                                                 |  115 ++++
 fs/ksmbd/oplock.h                                                 |    8 
 fs/ksmbd/smb2misc.c                                               |   15 
 fs/ksmbd/smb2ops.c                                                |    9 
 fs/ksmbd/smb2pdu.c                                                |   61 +-
 fs/ksmbd/smb2pdu.h                                                |    1 
 fs/ksmbd/vfs.c                                                    |    3 
 fs/ksmbd/vfs_cache.c                                              |   13 
 fs/ksmbd/vfs_cache.h                                              |    3 
 include/linux/bpf.h                                               |    3 
 include/linux/key-type.h                                          |    1 
 include/linux/property.h                                          |    9 
 include/linux/qed/qed_eth_if.h                                    |    2 
 include/linux/qed/qed_if.h                                        |    2 
 include/linux/qed/qed_rdma_if.h                                   |    3 
 include/linux/spi/spi.h                                           |    3 
 include/net/bluetooth/hci_core.h                                  |    5 
 include/trace/events/afs.h                                        |   26 -
 kernel/bpf/arraymap.c                                             |   58 --
 kernel/trace/ring_buffer.c                                        |  136 +----
 kernel/trace/synth_event_gen_test.c                               |   11 
 kernel/trace/trace.c                                              |   20 
 lib/vsprintf.c                                                    |   11 
 mm/filemap.c                                                      |    9 
 net/8021q/vlan_core.c                                             |    9 
 net/9p/protocol.c                                                 |   17 
 net/bluetooth/af_bluetooth.c                                      |    7 
 net/bluetooth/hci_event.c                                         |    3 
 net/bluetooth/l2cap_core.c                                        |   21 
 net/bluetooth/mgmt.c                                              |   25 
 net/bluetooth/smp.c                                               |    7 
 net/core/dev.c                                                    |    3 
 net/dns_resolver/dns_key.c                                        |   10 
 net/ife/ife.c                                                     |    1 
 net/mac80211/mesh_plink.c                                         |   10 
 net/netfilter/nf_tables_api.c                                     |    2 
 net/rfkill/rfkill-gpio.c                                          |    8 
 net/rose/af_rose.c                                                |   39 +
 net/wireless/certs/wens.hex                                       |   87 +++
 security/keys/gc.c                                                |   31 -
 security/keys/internal.h                                          |   11 
 security/keys/key.c                                               |   15 
 security/keys/proc.c                                              |    2 
 sound/soc/codecs/hdmi-codec.c                                     |   12 
 sound/usb/quirks.c                                                |    4 
 243 files changed, 1795 insertions(+), 1078 deletions(-)

Alexander Atanasov (1):
      scsi: core: Always send batch on reset or error handling command

Alexis Lothoré (1):
      pinctrl: at91-pio4: use dedicated lock class for IRQ

Alper Ak (1):
      USB: serial: option: add Quectel EG912Y module support

Andrew Davis (1):
      ARM: dts: dra7: Fix DRA7 L3 NoC node register size

Andy Shevchenko (3):
      device property: Add const qualifier to device_get_match_data() parameter
      spi: Introduce spi_get_device_match_data() helper
      device property: Allow const parameter to dev_fwnode()

Baokun Li (1):
      mm/filemap: avoid buffered read/write race to read inconsistent data

Chen-Yu Tsai (1):
      wifi: cfg80211: Add my certificate

Christoffer Sandberg (1):
      Input: soc_button_array - add mapping for airplane mode button

Dan Carpenter (1):
      usb: fotg210-hcd: delete an incorrect bounds test

David Howells (6):
      afs: Fix the dynamic root's d_delete to always delete unused dentries
      afs: Fix dynamic root lookup DNS check
      keys, dns: Allow key types (eg. DNS) to be reclaimed immediately on expiry
      afs: Fix overwriting of result of DNS query
      afs: Use refcount_t rather than atomic_t
      afs: Fix use-after-free due to get/remove race in volume tree

David Lechner (1):
      iio: triggered-buffer: prevent possible freeing of wrong buffer

Dinghao Liu (1):
      net/mlx5e: fix a potential double-free in fs_udp_create_groups

Eric Dumazet (3):
      net: sched: ife: fix potential use-after-free
      net/rose: fix races in rose_kill_by_device()
      net: check dev->gso_max_size in gso_features_check()

Fabio Estevam (1):
      dt-bindings: nvmem: mxs-ocotp: Document fsl,ocotp

Fedor Pchelkin (1):
      net: 9p: avoid freeing uninit memory in p9pdu_vreadf

Frédéric Danis (1):
      Bluetooth: L2CAP: Send reject on command corrupted request

Geert Uytterhoeven (1):
      reset: Fix crash when freeing non-existent optional resets

Greg Kroah-Hartman (1):
      Linux 5.15.146

Haoran Liu (1):
      Input: ipaq-micro-keys - add error handling for devm_kmemdup

Heiko Carstens (1):
      s390/vx: fix save/restore of fpu kernel context

Herve Codina (1):
      lib/vsprintf: Fix %pfwf when current node refcount == 0

Hyunwoo Kim (1):
      Bluetooth: af_bluetooth: Fix Use-After-Free in bt_sock_recvmsg

Jakub Kicinski (1):
      ethernet: constify references to netdev->dev_addr in drivers

Javier Carrasco (1):
      iio: common: ms_sensors: ms_sensors_i2c: fix humidity conversion time table

Jeremie Knuesel (1):
      ALSA: usb-audio: Increase delay in MOTU M quirk

Jerome Brunet (1):
      ASoC: hdmi-codec: fix missing report for jack initial status

Jiri Olsa (1):
      bpf: Fix prog_array_map_poke_run map poke update

Johannes Berg (3):
      wifi: iwlwifi: pcie: add another missing bh-disable for rxq->lock
      wifi: mac80211: mesh_plink: fix matches_local logic
      wifi: cfg80211: fix certs build to not depend on file order

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: avoid failed operations when device is disconnected

Justin Chen (2):
      net: usb: ax88179_178a: clean up pm calls
      net: usb: ax88179_178a: wol optimizations

Kent Gibson (1):
      gpiolib: cdev: add gpio_device locking wrapper around gpio_ioctl()

Krister Johansen (1):
      fuse: share lookup state between submount and its parent

Kunwu Chan (1):
      ARM: OMAP2+: Fix null pointer dereference and memory leak in omap_soc_device_init

Liu Jian (1):
      net: check vlan filter feature in vlan_vids_add_by_dev() and vlan_vids_del_by_dev()

Luca Coelho (1):
      drm/i915/mtl: limit second scaler vertical scaling in ver >= 14

Luiz Augusto von Dentz (1):
      Bluetooth: hci_event: Fix not checking if HCI_OP_INQUIRY has been sent

Marc Zyngier (1):
      KVM: arm64: vgic: Force vcpu vgic teardown on vcpu destroy

Mark Glover (1):
      USB: serial: ftdi_sio: update Actisense PIDs constant names

Mike Tipton (1):
      interconnect: Treat xlate() returning NULL node as an error

Mikulas Patocka (1):
      dm-integrity: don't modify bio's immutable bio_vec in integrity_metadata()

Moshe Shemesh (1):
      net/mlx5: Fix fw tracer first block check

Namjae Jeon (10):
      ksmbd: fix wrong name of SMB2_CREATE_ALLOCATION_SIZE
      ksmbd: have a dependency on cifs ARC4
      ksmbd: set epoch in create context v2 lease
      ksmbd: set v2 lease capability
      ksmbd: downgrade RWH lease caching state to RH for directory
      ksmbd: send v2 lease break notification for directory
      ksmbd: lazy v2 lease break on smb2_write()
      ksmbd: avoid duplicate opinfo_put() call on error of smb21_lease_break_ack()
      ksmbd: fix wrong allocation size update in smb2_open()
      ksmbd: fix slab-out-of-bounds in smb_strndup_from_utf16()

Nuno Sa (1):
      iio: imu: adis16475: add spi_device_id table

Pablo Neira Ayuso (1):
      netfilter: nf_tables: skip set commit for deleted/destroyed sets

Paulo Alcantara (4):
      smb: client: fix NULL deref in asn1_ber_decoder()
      smb: client: fix OOB in smb2_query_reparse_point()
      smb: client: fix OOB in SMB2_query_info_init()
      smb: client: fix OOB in smbCalcSize()

Quan Nguyen (1):
      i2c: aspeed: Handle the coalesced stop conditions with the start conditions.

Rahul Rameshbabu (1):
      net/mlx5e: Correct snprintf truncation handling for fw_version buffer used by representors

Reinhard Speyerer (1):
      USB: serial: option: add Quectel RM500Q R13 firmware support

Ronald Wahl (1):
      net: ks8851: Fix TX stall caused by TX buffer overrun

Rouven Czerwinski (1):
      net: rfkill: gpio: set GPIO direction

Shifeng Li (1):
      net/mlx5e: Fix slab-out-of-bounds in mlx5_query_nic_vport_mac_list()

Slark Xiao (1):
      USB: serial: option: add Foxconn T99W265 with new baseline

Steven Rostedt (Google) (5):
      tracing / synthetic: Disable events after testing in synth_event_gen_test_init()
      ring-buffer: Fix wake ups when buffer_percent is set to 100
      tracing: Fix blocked reader of snapshot buffer
      ring-buffer: Remove useless update to write_stamp in rb_try_to_discard()
      ring-buffer: Fix slowpath of interrupted event

Su Hui (1):
      iio: imu: inv_mpu6050: fix an error code problem in inv_mpu6050_read_raw

Thomas Gleixner (1):
      x86/alternatives: Sync core before enabling interrupts

Tony Lindgren (2):
      bus: ti-sysc: Flush posted write only after srst_udelay
      ARM: dts: Fix occasional boot hang for am3 usb

Ville Syrjälä (2):
      drm/i915: Relocate intel_atomic_setup_scalers()
      drm/i915: Fix intel_atomic_setup_scalers() plane_state handling

Vlad Buslov (2):
      Revert "net/mlx5e: fix double free of encap_header in update funcs"
      Revert "net/mlx5e: fix double free of encap_header"

Wadim Egorov (1):
      iio: adc: ti_am335x_adc: Fix return value check of tiadc_request_dma()

Wei Yongjun (1):
      scsi: bnx2fc: Fix skb double free in bnx2fc_rcv()

Xiao Yao (1):
      Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/LE

Yury Norov (1):
      net: mana: select PAGE_POOL

Zhipeng Lu (1):
      ethernet: atheros: fix a memleak in atl1e_setup_ring_resources

xiongxin (1):
      gpio: dwapb: mask/unmask IRQ when disable/enale it


