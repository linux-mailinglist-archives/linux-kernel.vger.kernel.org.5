Return-Path: <linux-kernel+bounces-149816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D8B8A9639
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E178282A9C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0D915B10E;
	Thu, 18 Apr 2024 09:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lLH5vGFV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7A5158868
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432779; cv=none; b=M6e1Ki9nLhC1O2uO2vxr9OvKb6CMHrz0goH++QHdTlgpl06jMOIUZbdGeF6S3Ci+Q0v2CsiqvXWGsGQ0xEYWOwhdfPlZSy4Wib8XdwDiG5Hk9D6IQj3EnbhpZiyr89PKats4f6vipWuDgFhb/AO+IiT06k6JLcnYkaIuTb2if7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432779; c=relaxed/simple;
	bh=HYZcDLqT/Piw0lAAUfXxXRW3RYyd9LKjhlFgZPpFT5c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dulfDhBYnAgLcV255GU0Q6RMBFugl3Kko0X7CjHzLe5mAcpOsXGs91rLi4+pbZbrNv8VCTAP8wJ0nz7vH7mfClJ2mStTQaoWJfoJQ2MKq+HB72JE2LXUU/cje17BICIMGnyLw6s/X1A2OqbMza7odcm304GPGFum0yxQtBq8ewU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lLH5vGFV; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713432777; x=1744968777;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HYZcDLqT/Piw0lAAUfXxXRW3RYyd9LKjhlFgZPpFT5c=;
  b=lLH5vGFVSWIlvU44/C5KzvMxDwFq+OEG9/HPl8kv3oBGnACprgZ/8Ak3
   UJnyefFjWB7PUOvbHEZNRJ52dEEiisES5Xvc2sDHcMwF011Qw2DmiUzMI
   mu9jQD7Wg2p/dr6AG9pTz9pV6zdkJoZv218fIcoi6eruyGIyYruNQ5J3g
   ywDyHamm5RSMUKou1Rzv3xtt4+9ZKpEgBv83ZIjinxQdCnBQjBCSkesOG
   nKH5jG7FIOegn3U85hbrpEl4o6vGmN+NY18JD2cI7nYg9JiObJXi+/7TY
   EOGKDEgSThQIPRAvHto6erq9pj2swFpmDYXhtG4vHIsk4pSyCgVqu9kum
   w==;
X-CSE-ConnectionGUID: a4aQWUxuQl21bY33SmylJA==
X-CSE-MsgGUID: f5tNkeXFRhq6N8T9HWlJnA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="9190335"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="9190335"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 02:32:52 -0700
X-CSE-ConnectionGUID: B43Y1dyUROWCSTwK83skqA==
X-CSE-MsgGUID: pldL8T2zSrm6cdhJNSjuwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="22982919"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 18 Apr 2024 02:32:48 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rxO8M-0007SS-1q;
	Thu, 18 Apr 2024 09:32:46 +0000
Date: Thu, 18 Apr 2024 17:32:19 +0800
From: kernel test robot <lkp@intel.com>
To: Ciprian Regus <ciprian.regus@analog.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Nuno Sa <nuno.sa@analog.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: WARNING: modpost: "__udelay" [drivers/net/ethernet/adi/adin1110.ko]
 has no CRC!
Message-ID: <202404181703.iqYeTcsV-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8cd26fd90c1ad7acdcfb9f69ca99d13aa7b24561
commit: 2322467a0f5d6cf05752092938e6db1250a0b28e net: ethernet: adi: adin1110: Reduce the MDIO_TRDONE poll interval
date:   7 weeks ago
config: sparc-randconfig-r024-20230516 (https://download.01.org/0day-ci/archive/20240418/202404181703.iqYeTcsV-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240418/202404181703.iqYeTcsV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404181703.iqYeTcsV-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

Is "___rw_read_enter" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "___rw_read_exit" [vmlinux] version generation failed, symbol will not be versioned.
Is "___rw_read_exit" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "___rw_read_try" [vmlinux] version generation failed, symbol will not be versioned.
Is "___rw_read_try" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "___rw_write_enter" [vmlinux] version generation failed, symbol will not be versioned.
Is "___rw_write_enter" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "__lshrdi3" [vmlinux] version generation failed, symbol will not be versioned.
Is "__lshrdi3" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "__muldi3" [vmlinux] version generation failed, symbol will not be versioned.
Is "__muldi3" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: "__udelay" [kernel/rcu/rcutorture.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [fs/smb/server/ksmbd.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [fs/binfmt_misc.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [fs/udf/udf.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/ocfs2/ocfs2.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [fs/ocfs2/ocfs2.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [fs/ocfs2/ocfs2.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [fs/ocfs2/cluster/ocfs2_nodemanager.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/btrfs/btrfs.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [fs/btrfs/btrfs.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [fs/btrfs/btrfs.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [fs/btrfs/btrfs.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/gfs2/gfs2.ko] has no CRC!
WARNING: modpost: "empty_zero_page" [security/keys/encrypted-keys/encrypted-keys.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/bus/mhi/host/mhi.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [drivers/bus/mhi/host/mhi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/amlogic/phy-meson8b-usb2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/amlogic/phy-meson-g12a-usb2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/amlogic/phy-meson-axg-pcie.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/broadcom/phy-bcm-ns2-usbdrd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/cadence/phy-cadence-salvo.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/intel/phy-intel-keembay-emmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/intel/phy-intel-lgm-emmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/lantiq/phy-lantiq-vrx200-pcie.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/marvell/phy-armada38x-comphy.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/marvell/phy-pxa-usb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/mediatek/phy-mtk-ufs.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/rockchip/phy-rockchip-inno-dsidphy.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/rockchip/phy-rockchip-pcie.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/rockchip/phy-rockchip-snps-pcie3.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/backlight/ili9320.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/backlight/l4f00242t03.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/backlight/lms283gf05.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/backlight/vgg2432a4.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/video/backlight/ktd253-backlight.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/omap2/omapfb/dss/omapdss.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/omap2/omapfb/displays/panel-nec-nl8048hl11.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/broadsheetfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/s1d13xxxfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/sm501fb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/ipmi/ipmi_si.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/sh/rcar-dmac.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/sh/usb-dmac.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/mediatek/mtk-cqdma.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/qcom/qcom_adm.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/ti/omap-dma.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/altera-msgdma.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/soc/ixp4xx/ixp4xx-npe.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/soc/mediatek/mtk-mutex.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [drivers/vdpa/vdpa_user/vduse.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/regulator/qcom_spmi-regulator.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/8250/8250_base.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/tty/serial/8250/8250_base.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/8250/8250_dw.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/msm_serial.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/tty/serial/sccnxp.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/ba431-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/stm32-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/meson-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/ks-sa-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iommu/mtk_iommu.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/block/floppy.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/misc/eeprom/eeprom_93cx6.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/altera-stapl/altera-stapl.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/sm501.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/ene-kb3930.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/si476x-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/ssbi.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/scsi/sd_mod.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/nvme/host/nvme-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ata/ahci_imx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ata/pata_arasan_cf.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ata/sata_mv.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ata/sata_rcar.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ata/pata_ixp4xx_cf.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-armada-3700.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-davinci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-imx.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/spi/spi-pic32.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-sh.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-sprd-adi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-st-ssc4.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-tegra20-sflash.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/phy/sfp.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/phy/bcm7xxx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/phy/icplus.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/net/mdio/mdio-bitbang.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/mdio/mdio-mscc-miim.ko] has no CRC!
>> WARNING: modpost: "__udelay" [drivers/net/ethernet/adi/adin1110.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/broadcom/bcmsysport.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/freescale/gianfar_driver.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/marvell/mvmdio.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/marvell/mv643xx_eth.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/marvell/pxa168_eth.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/mediatek/mtk_eth.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/mediatek/mtk_star_emac.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/mscc/mscc_ocelot_switch_lib.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/renesas/sh_eth.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/renesas/ravb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/socionext/sni_ave.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/sun/sunqe.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/sunplus/sp7021_emac.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/wiznet/w5100.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/calxeda/xgmac.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/davicom/dm9000.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/korina.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [drivers/net/hamradio/mkiss.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [drivers/net/hamradio/6pack.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/ath/ath9k/ath9k_hw.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/ath/ath9k/ath9k_htc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/ath/ath10k/ath10k_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/ath/ath10k/ath10k_sdio.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/intersil/p54/p54usb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/mediatek/mt7601u/mt7601u.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/mediatek/mt76/mt76.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/mediatek/mt76/mt76x02-lib.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/mediatek/mt76/mt792x-lib.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2-common.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2u.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/microchip/wilc1000/wilc1000-spi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/ralink/rt2x00/rt2x00usb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/ralink/rt2x00/rt2500usb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/realtek/rtlwifi/rtlwifi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/realtek/rtlwifi/rtl8192c/rtl8192c-common.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/realtek/rtlwifi/rtl8192cu/rtl8192cu.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/realtek/rtw88/rtw88_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/realtek/rtw88/rtw88_8822b.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/realtek/rtw88/rtw88_8822c.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/realtek/rtw88/rtw88_8723d.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wireless/silabs/wfx/wfx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/usb/sr9800.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/usb/smsc75xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/dsa/b53/b53_common.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/dsa/mt7530.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/dsa/vitesse-vsc73xx-core.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [drivers/net/ppp/ppp_async.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [drivers/net/ppp/ppp_synctty.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/ehci-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/ehci-platform.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/ohci-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/ohci-s3c2410.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/xhci-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/xhci-rcar-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/xhci-mtk-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/sl811-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/ehci-fsl.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/ssb-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/typec/tipd/tps6598x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/dwc2/dwc2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/cdns3/cdns-usb-common.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/cdns3/cdns3.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/cdns3/cdns3-imx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/fotg210/fotg210.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/chipidea/ci_hdrc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/chipidea/ci_hdrc_msm.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/chipidea/ci_hdrc_tegra.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/renesas_usbhs/renesas_usbhs.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/gadget/udc/pxa27x_udc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/gadget/udc/m66592-udc.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/usb/gadget/udc/m66592-udc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/gadget/udc/renesas_usb3.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/gadget/udc/mv_udc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/gadget/udc/mv_u3d_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/gadget/udc/udc-xilinx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/gadget/udc/aspeed-vhub/aspeed-vhub.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/gadget/udc/bdc/bdc.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/usb/gadget/function/usb_f_mass_storage.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/usb/gadget/function/usb_f_mass_storage.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/serio/i8042.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/serio/olpc_apsp.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/keyboard/tegra-kbc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/mouse/vsxxxaa.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/joystick/as5011.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/joystick/analog.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/joystick/grip_mp.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/edt-ft5x06.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/elants_i2c.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/ili210x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/ilitek_ts_i2c.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/mms114.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/input/touchscreen/pixcir_i2c_ts.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/raydium_i2c_ts.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/sx8654.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/zforce_ts.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/rohm_bu21023.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/zinitix.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-meson.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-moxart.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

