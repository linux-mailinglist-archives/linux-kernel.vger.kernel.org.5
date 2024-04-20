Return-Path: <linux-kernel+bounces-152315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C948ABC43
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 17:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ABEF1C20757
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 15:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C1D27453;
	Sat, 20 Apr 2024 15:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EIYxWUYF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94010168CC
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713628507; cv=none; b=XPMznenUMpHiSL3AR5vZbQL6rX1+CC25SGbjTb//zDoO7NxdUUOMg7Rs/BnzxXUvkO1biBePvG5kdJ9Q6kxUcCcLJJnggJRBlZ43H7TvAa2kPlUiJhjsyOkLygKnwW3STT7rjandTwCDj02Db1q3V5zITty6BO42ZaRyCgAYrmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713628507; c=relaxed/simple;
	bh=biDWX6OBDMi0fP/6udXrp+R5rd6nZD2fv8fcwF5e+ww=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CHhU91Yd7l7hOXPrp8cmyvrB6nscP6fH1Qc+MfLJO9nK+aSBXf+NUyIfVlifIM4fua0lg3NBXdwELpivjJZhCuWaKuWrSW4Wtut7PSthfEhjHe2A5DT542Hr2VLbgoIE8sY6CwITJjPx96fpOSyzHEiDO4z8tYpbd7xKaakkf2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EIYxWUYF; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713628505; x=1745164505;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=biDWX6OBDMi0fP/6udXrp+R5rd6nZD2fv8fcwF5e+ww=;
  b=EIYxWUYF6IKO2TFNePyAYV35AScQk14qTqIudsxKjK1bJkCpVI370t/X
   BgbzD3WTpFgz69rL/VOXbaFhMZFOxwXjFRmhSU1Ip+iBiScvm90EXRU6b
   O7SixUOgedMFghwZclIfJiT//PX6LPuPEmBk/vw/rIlK63aZsKckNqy+w
   balXx/1whbF8RBuWHfNxpGKs7iU8tPvuhVFgDzg+vALr+wn1rHsVOCGEA
   XoXBc9sLfydfCuCIfd/ggEFVUlCo1uZ0w01BP2Iq3naHqfarVrSNGicns
   4HQkXDQfKADyCYIJmkRYsxS9ahKEqsXWrlv9nFQq1o68j6KADDETH1/p6
   g==;
X-CSE-ConnectionGUID: +v+xFypZSKWcrRiKMeEkvg==
X-CSE-MsgGUID: FdaTlhbdTZGYdDR2DCtKpQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11050"; a="26738578"
X-IronPort-AV: E=Sophos;i="6.07,216,1708416000"; 
   d="scan'208";a="26738578"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2024 08:55:05 -0700
X-CSE-ConnectionGUID: LfbKN0ZFSj+nP2A1L0Cnfw==
X-CSE-MsgGUID: RRq52PlVQ0O4kWSPtL+Nrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,216,1708416000"; 
   d="scan'208";a="61050530"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 20 Apr 2024 08:55:03 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ryD3L-000BFM-39;
	Sat, 20 Apr 2024 15:54:59 +0000
Date: Sat, 20 Apr 2024 23:54:44 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leonro@nvidia.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Simon Horman <simon.horman@corigine.com>
Subject: WARNING: modpost: "__udelay"
 [drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko] has no CRC!
Message-ID: <202404202353.aHJoumc9-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Leon,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   13a2e429f644691fca70049ea1c75f135957c788
commit: a128f9d4c1227dfcf7f2328070760cb7ed1ec08d net/mlx5e: Fix scheduling of IPsec ASO query while in atomic
date:   10 months ago
config: sparc-randconfig-c024-20221211 (https://download.01.org/0day-ci/archive/20240420/202404202353.aHJoumc9-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240420/202404202353.aHJoumc9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404202353.aHJoumc9-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: "__ndelay" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "__udelay" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/bus/mhi/host/mhi.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [drivers/bus/mhi/host/mhi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/hisilicon/phy-hi3670-pcie.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/intel/phy-intel-keembay-usb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/marvell/phy-pxa-usb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/ralink/phy-ralink-usb.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/pwm/pwm-atmel.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/pwm/pwm-atmel.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/pwm/pwm-renesas-tpu.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/pwm/pwm-renesas-tpu.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/pwm/pwm-stm32-lp.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/pci/controller/pcie-altera.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/core/fb_ddc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/cyber2000fb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/matrox/matroxfb_DAC1064.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/matrox/matroxfb_Ti3026.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/aty/aty128fb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/aty/radeonfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/cirrusfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/broadsheetfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/s1d13xxxfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/carminefb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/sh/usb-dmac.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/ti/omap-dma.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/xilinx/xilinx_dpdma.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/altera-msgdma.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/tegra20-apb-dma.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/soc/qcom/qcom_rpmh.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/virtio/virtio.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/virtio/virtio.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/virtio/virtio_ring.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/bcm63xx_uart.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/tty/serial/sccnxp.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/jsm/jsm.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/qcom_geni_serial.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/omap-serial.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/stm32-usart.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/ks-sa-rng.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/misc/eeprom/eeprom_93cx6.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/ti-st/st_drv.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/hpilo.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/c2port/core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/axp20x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/si476x-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/atmel-hlcdc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/rn5t618.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/acer-ec-a500.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-loopback-test.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-cadence.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/spi/spi-cadence-quadspi.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/spi/spi-fsi.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/spi/spi-fsi.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/spi/spi-mtk-nor.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/spi/spi-mtk-nor.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-orion.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-st-ssc4.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-tegra114.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-tegra20-sflash.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/spi/spi-zynq-qspi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spmi/hisi-spmi-controller.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/phy/sfp.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/phy/bcm7xxx.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/net/phy/nxp-c45-tja11xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/mdio/mdio-mscc-miim.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/mdio/mdio-xgene.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/arcnet/com20020.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/net/can/dev/can-dev.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/can/spi/mcp251x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/can/c_can/c_can.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/can/c_can/c_can_platform.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/net/can/flexcan/flexcan.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/can/flexcan/flexcan.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/net/can/flexcan/flexcan.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/can/grcan.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/can/sja1000/plx_pci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/can/sja1000/sja1000.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/net/ethernet/alacritech/slicoss.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/alacritech/slicoss.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/alteon/acenic.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/amd/sunlance.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/atheros/atlx/atl1.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/atheros/atl1e/atl1e.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/atheros/atl1c/atl1c.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/net/ethernet/chelsio/cxgb4/cxgb4.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/chelsio/cxgb4/cxgb4.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [drivers/net/ethernet/chelsio/cxgb4/cxgb4.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/dec/tulip/winbond-840.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/dlink/dl2k.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/emulex/benet/be2net.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/net/ethernet/emulex/benet/be2net.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/engleder/tsnep.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/net/ethernet/engleder/tsnep.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/net/ethernet/mellanox/mlxsw/mlxsw_pci.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/net/ethernet/mellanox/mlxsw/mlxsw_pci.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko] has no CRC!
>> WARNING: modpost: "__udelay" [drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/micrel/ks8851_common.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/micrel/ksz884x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/net/ethernet/qlogic/qed/qed.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/qlogic/qed/qed.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/net/ethernet/qlogic/qed/qed.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/sis/sis190.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/socionext/sni_ave.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/stmicro/stmmac/dwmac-rk.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/stmicro/stmmac/dwmac-altr-socfpga.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/ti/tlan.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/ti/ti_cpsw.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/xilinx/ll_temac.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/apm/xgene/xgene-enet.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/calxeda/xgmac.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/net/ethernet/dnet.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/korina.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/fealnx.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [drivers/net/ppp/ppp_synctty.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/admtek/adm8211.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/ath/ath5k/ath5k.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/ath/ath9k/ath9k_hw.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/ath/ath6kl/ath6kl_core.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/net/wireless/ath/wil6210/wil6210.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/ath/wil6210/wil6210.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/net/wireless/ath/ath11k/ath11k.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/net/wireless/broadcom/b43/b43.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/broadcom/b43/b43.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/net/wireless/broadcom/b43/b43.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/net/wireless/broadcom/b43legacy/b43legacy.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/broadcom/b43legacy/b43legacy.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/broadcom/brcm80211/brcmfmac/brcmfmac.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcmsmac.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/intel/ipw2x00/ipw2100.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/intel/iwlegacy/iwlegacy.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/net/wireless/intel/iwlegacy/iwl4965.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/intel/iwlegacy/iwl4965.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/net/wireless/intel/iwlegacy/iwl4965.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/intel/iwlegacy/iwl3945.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/mediatek/mt76/mt76.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/net/wireless/mediatek/mt76/mt76x02-lib.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/mediatek/mt76/mt76x02-lib.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/net/wireless/mediatek/mt76/mt76x02-lib.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0-common.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/net/wireless/mediatek/mt76/mt7615/mt7615-common.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/mediatek/mt76/mt7615/mt7615-common.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/net/wireless/mediatek/mt76/mt7615/mt7615-common.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/net/wireless/mediatek/mt76/mt7915/mt7915e.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/mediatek/mt76/mt7915/mt7915e.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/net/wireless/mediatek/mt76/mt7921/mt7921-common.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/mediatek/mt76/mt7921/mt7921-common.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/ralink/rt2x00/rt2x00mmio.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/ralink/rt2x00/rt2500pci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/ti/wlcore/wlcore.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/ti/wl18xx/wl18xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wwan/t7xx/mtk_t7xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/vfio/platform/reset/vfio_platform_bcmflexrm.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/serio/i8042.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/serio/apbps2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/keyboard/matrix_keypad.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/input/joystick/cobra.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/rmi4/rmi_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-stm32.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/algos/i2c-algo-bit.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-amd8111.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-altera.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-bcm-iproc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-davinci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-digicolor.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-imx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-jz4780.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-mt65xx.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/i2c/busses/i2c-mt65xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-mv64xxx.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/i2c/busses/i2c-mv64xxx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-ocores.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-pnx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-pxa.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-qup.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-sh_mobile.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-stm32f4.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-tegra.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-rcar.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/muxes/i2c-arb-gpio-challenge.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/muxes/i2c-mux-ltc4306.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/muxes/i2c-mux-pca954x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/i2c-core.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/i2c/i2c-core.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/media/rc/rc-core.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/media/rc/rc-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ptp/ptp_idt82p33.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/w1/masters/ds2482.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/w1/masters/sgi_w1.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/power/supply/sc27xx_fuel_gauge.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/hwmon/ad7418.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/hwmon/ltc2947-core.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/hwmon/ltc2947-core.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

