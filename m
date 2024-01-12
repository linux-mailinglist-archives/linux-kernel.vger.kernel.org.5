Return-Path: <linux-kernel+bounces-24541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9C982BE18
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5459B1C24714
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FC95D8F8;
	Fri, 12 Jan 2024 10:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G4VkxnWc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731215C8FE;
	Fri, 12 Jan 2024 10:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705054140; x=1736590140;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bV4IN0b/G8R1husc/OfF1oeJ/jVmXduJ0psSV6tsinc=;
  b=G4VkxnWct9nh63D5gZqltMTcpV8ySjmeVWvcJGjLnExW5SJj+b5oGvc9
   s9U4F1ys9UnSRr5743YlcGU0/99qn0F3OA2EKyLXVNW2Ah+TAexRGMqn0
   6NOnq54BdgQXr2Z3vCcaBohZMrZAkR8hOjbtV0d3ejmgktixts3+tEF5s
   hm1Eey7PHw5Jg3dcICTxYfTWwRjDagMTrjBRo6kv51EGIUilVLNDv6dAZ
   F1nrcmIIpSnu7X5pZqQKQE2rQVtvPeDDrQ+53CVVDKF0KAPDSM8pdbwZP
   KOZGBR1UUQcvX56VPPbLRrRliXg15r5orhzJlmLMyBElFAyx+Bfp7JZ0O
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="12619026"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="12619026"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 02:08:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="775963086"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="775963086"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 12 Jan 2024 02:08:57 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOET8-0009Jy-33;
	Fri, 12 Jan 2024 10:08:54 +0000
Date: Fri, 12 Jan 2024 18:07:56 +0800
From: kernel test robot <lkp@intel.com>
To: Elad Nachman <enachman@marvell.com>, stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, enachman@marvell.com
Subject: Re: [PATCH v2] usb: host: Add ac5 to EHCI Orion
Message-ID: <202401121725.FpeXW8tE-lkp@intel.com>
References: <20240108175457.4113480-1-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108175457.4113480-1-enachman@marvell.com>

Hi Elad,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus westeri-thunderbolt/next linus/master v6.7 next-20240111]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Elad-Nachman/usb-host-Add-ac5-to-EHCI-Orion/20240109-020241
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20240108175457.4113480-1-enachman%40marvell.com
patch subject: [PATCH v2] usb: host: Add ac5 to EHCI Orion
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240112/202401121725.FpeXW8tE-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240112/202401121725.FpeXW8tE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401121725.FpeXW8tE-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/8390/8390.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/8390/hydra.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/8390/8390p.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/8390/zorro8390.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/amd/a2065.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/amd/ariadne.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/amd/atarilance.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/amd/hplance.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/amd/7990.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/amd/mvme147.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/amd/sun3lance.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/broadcom/bcm4908_enet.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/broadcom/bgmac.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/broadcom/bgmac-bcma.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/broadcom/bgmac-bcma-mdio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/broadcom/bgmac-platform.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/cirrus/ep93xx_eth.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/cirrus/mac89x0.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/ezchip/nps_enet.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/freescale/fec.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/freescale/fsl_pq_mdio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/litex/litex_liteeth.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/microchip/encx24j600-regmap.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/mscc/mscc_ocelot_switch_lib.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/qualcomm/emac/qcom-emac.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/qualcomm/rmnet/rmnet.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/smsc/smc9194.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/smsc/smc91x.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/smsc/smsc911x.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/stmicro/stmmac/dwmac-altr-socfpga.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/synopsys/dwc-xlgmac.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wan/slic_ds26522.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/ath/ar5523/ar5523.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/ath/wcn36xx/wcn36xx.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/brcmfmac-wcc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/brcmfmac-cyw.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/brcmfmac-bca.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/intersil/p54/p54spi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/mediatek/mt76/mt76.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/mediatek/mt76/mt76-usb.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/mediatek/mt76/mt76-sdio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/mediatek/mt76/mt76x02-lib.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/mediatek/mt76/mt76x02-usb.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/mediatek/mt76/mt76-connac-lib.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/mediatek/mt76/mt792x-lib.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/mediatek/mt76/mt792x-usb.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0u.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0-common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2-common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2u.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/mediatek/mt76/mt7615/mt7615-common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/mediatek/mt76/mt7615/mt7663-usb-sdio-common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/mediatek/mt76/mt7615/mt7663u.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/mediatek/mt76/mt7615/mt7663s.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/mediatek/mt76/mt7921/mt7921-common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/mediatek/mt76/mt7921/mt7921s.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/mediatek/mt76/mt7921/mt7921u.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/mediatek/mt76/mt7925/mt7925-common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/mediatek/mt76/mt7925/mt7925u.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/microchip/wilc1000/wilc1000.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/microchip/wilc1000/wilc1000-sdio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/microchip/wilc1000/wilc1000-spi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/ti/wlcore/wlcore.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/ti/wlcore/wlcore_spi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/ti/wlcore/wlcore_sdio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/ti/wl12xx/wl12xx.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/ti/wl1251/wl1251_spi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/ti/wl1251/wl1251_sdio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/wireless/ti/wl18xx/wl18xx.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ipvlan/ipvtap.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/arcnet.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/rfc1201.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/rfc1051.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/arc-rawmode.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/capmode.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/com90xx.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/com90io.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/arc-rimi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/com20020.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/com20020-isa.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/com20020_cs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/dsa/dsa_loop_bdinfo.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/plip/plip.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ppp/ppp_generic.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ppp/ppp_async.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ppp/bsd_comp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ppp/ppp_deflate.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ppp/ppp_synctty.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/slip/slip.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/slip/slhc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ieee802154/fakelb.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firewire/firewire-uapi-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cdrom/cdrom.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/auxdisplay/charlcd.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/auxdisplay/hd44780_common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/auxdisplay/line-display.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/phy/phy-am335x-control.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/phy/phy-am335x.o
drivers/usb/host/ehci-orion: struct of_device_id is 196 bytes.  The last of 3 is:
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x6d 0x61 0x72 0x76 0x65 0x6c 0x6c 0x2c 0x61 0x63 0x35 0x2d 0x65 0x68 0x63 0x69 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>> FATAL: modpost: drivers/usb/host/ehci-orion: struct of_device_id is not terminated with a NULL entry!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

