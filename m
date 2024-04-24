Return-Path: <linux-kernel+bounces-156336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3D08B0164
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33BC71C229D9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DE715688A;
	Wed, 24 Apr 2024 05:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y2lbvw0v"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963451422A4;
	Wed, 24 Apr 2024 05:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713938168; cv=none; b=QqD26DnddGnBYTPKc8d8HP8i9kymT/mSFbGk77LEDbKkMOkEYBWwIHuJ2CJkLckcrRIoSQ7hGBx0DKT3pdJ8eCcmkMw3WAEouOMBjjd0Ih+xUfVou4auM3zhd9T+zXsRyjmSUnF1yZIVZCNDRlbviPzL56So6TeuxNMggv8+kNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713938168; c=relaxed/simple;
	bh=MmFvorY7gdBLyILy8HsnyPUc10sAeQ2JHQgtvJRFK64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2b93WET8By1YtX5+/x9HhsuAcegzwEbx1aAjSjbEQFtfN4GZYE7J9d45RXAYMx/C4oYgwjGZTUZIsR/6IfFQTceLjumV/PCfquzMrnJqCVgn+Fi8uNJ1LNr2Wkipjyuw7Xa3HvQm0KYRn2xnwIKFZXHlE/Fpr+sxVjwexwL1uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y2lbvw0v; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713938165; x=1745474165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=MmFvorY7gdBLyILy8HsnyPUc10sAeQ2JHQgtvJRFK64=;
  b=Y2lbvw0vrnITP/upmCwy+Feupd8Og5L3KMEvKHHoDFgG4rlC/d4dNJJT
   DKKgQfrJKuYa7NuDKtn2ZKnVml1QnZNbNskyd10kKYS12DzoUFmDqWS4K
   MfIVAoangaTuagouYtZmnRu1nAGA+wQ+Xw2x/LFB2+6FXcv2fKekXzTok
   eMk7SkNQC1JLtUHJ5y1/q5O9OAmIgsa6OFf1a9WvyH5vBDffAqOe7W1uA
   6ErZXycOAs018eeVvLaD6F/S6f+tOseaK9PTt/xBo+LECYZIDpNnxDQrP
   46G0IWHhnNv9dMEaxdtESys5J/SYwUy5Ni0IWFFoIEz02mQd7uy4fn+cw
   Q==;
X-CSE-ConnectionGUID: oM/7P6OjRpe0XZVhHrZ9qw==
X-CSE-MsgGUID: pA53GZPiSECrM4d9CWQjew==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9711398"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="9711398"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 22:56:04 -0700
X-CSE-ConnectionGUID: IEp0NPycSwC2Q10qHl6C7g==
X-CSE-MsgGUID: 1qTgJxvsSta4ObBy1k4UNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="55560223"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 23 Apr 2024 22:55:59 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rzVbo-0000vA-29;
	Wed, 24 Apr 2024 05:55:56 +0000
Date: Wed, 24 Apr 2024 13:55:01 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Sam Protsenko <semen.protsenko@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>,
	Roy Luo <royluo@google.com>, kernel-team@android.com,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Subject: Re: [PATCH 7/7] phy: exynos5-usbdrd: support Exynos USBDRD 3.1 combo
 phy (HS & SS)
Message-ID: <202404241343.bJvpqJob-lkp@intel.com>
References: <20240423-usb-phy-gs101-v1-7-ebdcb3ac174d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240423-usb-phy-gs101-v1-7-ebdcb3ac174d@linaro.org>

Hi André,

kernel test robot noticed the following build errors:

[auto build test ERROR on a59668a9397e7245b26e9be85d23f242ff757ae8]

url:    https://github.com/intel-lab-lkp/linux/commits/Andr-Draszik/dt-bindings-phy-samsung-usb3-drd-phy-add-gs101-compatible/20240424-011137
base:   a59668a9397e7245b26e9be85d23f242ff757ae8
patch link:    https://lore.kernel.org/r/20240423-usb-phy-gs101-v1-7-ebdcb3ac174d%40linaro.org
patch subject: [PATCH 7/7] phy: exynos5-usbdrd: support Exynos USBDRD 3.1 combo phy (HS & SS)
config: arc-randconfig-002-20240424 (https://download.01.org/0day-ci/archive/20240424/202404241343.bJvpqJob-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240424/202404241343.bJvpqJob-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404241343.bJvpqJob-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/phy/samsung/phy-exynos5-usbdrd.c: In function 'exynos5_usbdrd_usbdp_g2_v4_ctrl_pma_ready':
   drivers/phy/samsung/phy-exynos5-usbdrd.c:615:16: error: implicit declaration of function 'FIELD_PREP_CONST' [-Werror=implicit-function-declaration]
     615 |         reg |= FIELD_PREP_CONST(SECPMACTL_PMA_REF_FREQ_SEL, 1);
         |                ^~~~~~~~~~~~~~~~
   drivers/phy/samsung/phy-exynos5-usbdrd.c: In function 'exynos850_usbdrd_utmi_init':
>> drivers/phy/samsung/phy-exynos5-usbdrd.c:1147:20: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
    1147 |         ss_ports = FIELD_GET(LINKPORT_HOST_NUM_U3, reg);
         |                    ^~~~~~~~~
   drivers/phy/samsung/phy-exynos5-usbdrd.c: At top level:
>> drivers/phy/samsung/phy-exynos5-usbdrd.c:302:24: error: initializer element is not constant
     302 |                 .val = (v),             \
         |                        ^
   drivers/phy/samsung/phy-exynos5-usbdrd.c:1411:9: note: in expansion of macro 'PHY_TUNING_ENTRY_PHY'
    1411 |         PHY_TUNING_ENTRY_PHY(EXYNOS850_DRD_HSPPARACON,
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/phy/samsung/phy-exynos5-usbdrd.c:302:24: note: (near initialization for 'gs101_tunes_utmi_postinit[0].val')
     302 |                 .val = (v),             \
         |                        ^
   drivers/phy/samsung/phy-exynos5-usbdrd.c:1411:9: note: in expansion of macro 'PHY_TUNING_ENTRY_PHY'
    1411 |         PHY_TUNING_ENTRY_PHY(EXYNOS850_DRD_HSPPARACON,
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/phy/samsung/phy-exynos5-usbdrd.c:309:24: error: initializer element is not constant
     309 |                 .val = (v),             \
         |                        ^
   drivers/phy/samsung/phy-exynos5-usbdrd.c:1483:9: note: in expansion of macro 'PHY_TUNING_ENTRY_PCS'
    1483 |         PHY_TUNING_ENTRY_PCS(EXYNOS9_PCS_NS_VEC_PS1_N1, -1,
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/phy/samsung/phy-exynos5-usbdrd.c:309:24: note: (near initialization for 'gs101_tunes_pipe3_init[3].val')
     309 |                 .val = (v),             \
         |                        ^
   drivers/phy/samsung/phy-exynos5-usbdrd.c:1483:9: note: in expansion of macro 'PHY_TUNING_ENTRY_PCS'
    1483 |         PHY_TUNING_ENTRY_PCS(EXYNOS9_PCS_NS_VEC_PS1_N1, -1,
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/phy/samsung/phy-exynos5-usbdrd.c:309:24: error: initializer element is not constant
     309 |                 .val = (v),             \
         |                        ^
   drivers/phy/samsung/phy-exynos5-usbdrd.c:1487:9: note: in expansion of macro 'PHY_TUNING_ENTRY_PCS'
    1487 |         PHY_TUNING_ENTRY_PCS(EXYNOS9_PCS_NS_VEC_PS2_N0, -1,
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/phy/samsung/phy-exynos5-usbdrd.c:309:24: note: (near initialization for 'gs101_tunes_pipe3_init[4].val')
     309 |                 .val = (v),             \
         |                        ^
   drivers/phy/samsung/phy-exynos5-usbdrd.c:1487:9: note: in expansion of macro 'PHY_TUNING_ENTRY_PCS'
    1487 |         PHY_TUNING_ENTRY_PCS(EXYNOS9_PCS_NS_VEC_PS2_N0, -1,
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/phy/samsung/phy-exynos5-usbdrd.c:309:24: error: initializer element is not constant
     309 |                 .val = (v),             \
         |                        ^
   drivers/phy/samsung/phy-exynos5-usbdrd.c:1493:9: note: in expansion of macro 'PHY_TUNING_ENTRY_PCS'
    1493 |         PHY_TUNING_ENTRY_PCS(EXYNOS9_PCS_NS_VEC_PS3_N0, -1,
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/phy/samsung/phy-exynos5-usbdrd.c:309:24: note: (near initialization for 'gs101_tunes_pipe3_init[5].val')
     309 |                 .val = (v),             \
         |                        ^
   drivers/phy/samsung/phy-exynos5-usbdrd.c:1493:9: note: in expansion of macro 'PHY_TUNING_ENTRY_PCS'
    1493 |         PHY_TUNING_ENTRY_PCS(EXYNOS9_PCS_NS_VEC_PS3_N0, -1,
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/phy/samsung/phy-exynos5-usbdrd.c:309:24: error: initializer element is not constant
     309 |                 .val = (v),             \
         |                        ^
   drivers/phy/samsung/phy-exynos5-usbdrd.c:1504:9: note: in expansion of macro 'PHY_TUNING_ENTRY_PCS'
    1504 |         PHY_TUNING_ENTRY_PCS(EXYNOS9_PCS_RX_CONTROL_DEBUG,
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/phy/samsung/phy-exynos5-usbdrd.c:309:24: note: (near initialization for 'gs101_tunes_pipe3_init[8].val')
     309 |                 .val = (v),             \
         |                        ^
   drivers/phy/samsung/phy-exynos5-usbdrd.c:1504:9: note: in expansion of macro 'PHY_TUNING_ENTRY_PCS'
    1504 |         PHY_TUNING_ENTRY_PCS(EXYNOS9_PCS_RX_CONTROL_DEBUG,
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/phy/samsung/phy-exynos5-usbdrd.c:309:24: error: initializer element is not constant
     309 |                 .val = (v),             \
         |                        ^
   drivers/phy/samsung/phy-exynos5-usbdrd.c:1514:9: note: in expansion of macro 'PHY_TUNING_ENTRY_PCS'
    1514 |         PHY_TUNING_ENTRY_PCS(EXYNOS9_PCS_HS_TX_COEF_MAP_0,
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/phy/samsung/phy-exynos5-usbdrd.c:309:24: note: (near initialization for 'gs101_tunes_pipe3_init[9].val')
     309 |                 .val = (v),             \
         |                        ^
   drivers/phy/samsung/phy-exynos5-usbdrd.c:1514:9: note: in expansion of macro 'PHY_TUNING_ENTRY_PCS'
    1514 |         PHY_TUNING_ENTRY_PCS(EXYNOS9_PCS_HS_TX_COEF_MAP_0,
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/phy/samsung/phy-exynos5-usbdrd.c:309:24: error: initializer element is not constant
     309 |                 .val = (v),             \
         |                        ^
   drivers/phy/samsung/phy-exynos5-usbdrd.c:1521:9: note: in expansion of macro 'PHY_TUNING_ENTRY_PCS'
    1521 |         PHY_TUNING_ENTRY_PCS(EXYNOS9_PCS_LOCAL_COEF,
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/phy/samsung/phy-exynos5-usbdrd.c:309:24: note: (near initialization for 'gs101_tunes_pipe3_init[10].val')
     309 |                 .val = (v),             \
         |                        ^
   drivers/phy/samsung/phy-exynos5-usbdrd.c:1521:9: note: in expansion of macro 'PHY_TUNING_ENTRY_PCS'
    1521 |         PHY_TUNING_ENTRY_PCS(EXYNOS9_PCS_LOCAL_COEF,
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/phy/samsung/phy-exynos5-usbdrd.c:309:24: error: initializer element is not constant
     309 |                 .val = (v),             \
         |                        ^
   drivers/phy/samsung/phy-exynos5-usbdrd.c:1527:9: note: in expansion of macro 'PHY_TUNING_ENTRY_PCS'
    1527 |         PHY_TUNING_ENTRY_PCS(EXYNOS9_PCS_EBUF_PARAM,
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/phy/samsung/phy-exynos5-usbdrd.c:309:24: note: (near initialization for 'gs101_tunes_pipe3_init[12].val')
     309 |                 .val = (v),             \
         |                        ^
   drivers/phy/samsung/phy-exynos5-usbdrd.c:1527:9: note: in expansion of macro 'PHY_TUNING_ENTRY_PCS'
    1527 |         PHY_TUNING_ENTRY_PCS(EXYNOS9_PCS_EBUF_PARAM,
         |         ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/FIELD_GET +1147 drivers/phy/samsung/phy-exynos5-usbdrd.c

  1130	
  1131	static void exynos850_usbdrd_utmi_init(struct exynos5_usbdrd_phy *phy_drd)
  1132	{
  1133		void __iomem *regs_base = phy_drd->reg_phy;
  1134		u32 reg;
  1135		u32 ss_ports;
  1136	
  1137		/*
  1138		 * Disable HWACG (hardware auto clock gating control). This will force
  1139		 * QACTIVE signal in Q-Channel interface to HIGH level, to make sure
  1140		 * the PHY clock is not gated by the hardware.
  1141		 */
  1142		reg = readl(regs_base + EXYNOS850_DRD_LINKCTRL);
  1143		reg |= LINKCTRL_FORCE_QACT;
  1144		writel(reg, regs_base + EXYNOS850_DRD_LINKCTRL);
  1145	
  1146		reg = readl(regs_base + EXYNOS850_DRD_LINKPORT);
> 1147		ss_ports = FIELD_GET(LINKPORT_HOST_NUM_U3, reg);
  1148	
  1149		/* Start PHY Reset (POR=high) */
  1150		reg = readl(regs_base + EXYNOS850_DRD_CLKRST);
  1151		if (ss_ports) {
  1152			reg |= CLKRST_PHY20_SW_POR;
  1153			reg |= CLKRST_PHY20_SW_POR_SEL;
  1154			reg |= CLKRST_PHY_RESET_SEL;
  1155		}
  1156		reg |= CLKRST_PHY_SW_RST;
  1157		writel(reg, regs_base + EXYNOS850_DRD_CLKRST);
  1158	
  1159		/* Enable UTMI+ */
  1160		reg = readl(regs_base + EXYNOS850_DRD_UTMI);
  1161		reg &= ~(UTMI_FORCE_SUSPEND | UTMI_FORCE_SLEEP | UTMI_DP_PULLDOWN |
  1162			 UTMI_DM_PULLDOWN);
  1163		writel(reg, regs_base + EXYNOS850_DRD_UTMI);
  1164	
  1165		/* Set PHY clock and control HS PHY */
  1166		reg = readl(regs_base + EXYNOS850_DRD_HSP);
  1167		reg |= HSP_EN_UTMISUSPEND | HSP_COMMONONN;
  1168		writel(reg, regs_base + EXYNOS850_DRD_HSP);
  1169	
  1170		/* Set VBUS Valid and D+ pull-up control by VBUS pad usage */
  1171		reg = readl(regs_base + EXYNOS850_DRD_LINKCTRL);
  1172		reg |= LINKCTRL_BUS_FILTER_BYPASS(0xf);
  1173		writel(reg, regs_base + EXYNOS850_DRD_LINKCTRL);
  1174	
  1175		reg = readl(regs_base + EXYNOS850_DRD_UTMI);
  1176		reg |= UTMI_FORCE_BVALID | UTMI_FORCE_VBUSVALID;
  1177		writel(reg, regs_base + EXYNOS850_DRD_UTMI);
  1178	
  1179		reg = readl(regs_base + EXYNOS850_DRD_HSP);
  1180		reg |= HSP_VBUSVLDEXT | HSP_VBUSVLDEXTSEL;
  1181		writel(reg, regs_base + EXYNOS850_DRD_HSP);
  1182	
  1183		reg = readl(regs_base + EXYNOS850_DRD_SSPPLLCTL);
  1184		reg &= ~SSPPLLCTL_FSEL;
  1185		switch (phy_drd->extrefclk) {
  1186		case EXYNOS5_FSEL_50MHZ:
  1187			reg |= FIELD_PREP_CONST(SSPPLLCTL_FSEL, 7);
  1188			break;
  1189		case EXYNOS5_FSEL_26MHZ:
  1190			reg |= FIELD_PREP_CONST(SSPPLLCTL_FSEL, 6);
  1191			break;
  1192		case EXYNOS5_FSEL_24MHZ:
  1193			reg |= FIELD_PREP_CONST(SSPPLLCTL_FSEL, 2);
  1194			break;
  1195		case EXYNOS5_FSEL_20MHZ:
  1196			reg |= FIELD_PREP_CONST(SSPPLLCTL_FSEL, 1);
  1197			break;
  1198		case EXYNOS5_FSEL_19MHZ2:
  1199			reg |= FIELD_PREP_CONST(SSPPLLCTL_FSEL, 0);
  1200			break;
  1201		default:
  1202			dev_warn(phy_drd->dev, "unsupported ref clk: %#.2x\n",
  1203				 phy_drd->extrefclk);
  1204			break;
  1205		}
  1206		writel(reg, regs_base + EXYNOS850_DRD_SSPPLLCTL);
  1207	
  1208		/* Power up PHY analog blocks */
  1209		reg = readl(regs_base + EXYNOS850_DRD_HSP_TEST);
  1210		reg &= ~HSP_TEST_SIDDQ;
  1211		writel(reg, regs_base + EXYNOS850_DRD_HSP_TEST);
  1212	
  1213		/* Finish PHY reset (POR=low) */
  1214		udelay(10); /* required before doing POR=low */
  1215		reg = readl(regs_base + EXYNOS850_DRD_CLKRST);
  1216		if (ss_ports) {
  1217			reg |= CLKRST_PHY20_SW_POR_SEL;
  1218			reg &= ~CLKRST_PHY20_SW_POR;
  1219		}
  1220		reg &= ~(CLKRST_PHY_SW_RST | CLKRST_PORT_RST);
  1221		writel(reg, regs_base + EXYNOS850_DRD_CLKRST);
  1222		udelay(75); /* required after POR=low for guaranteed PHY clock */
  1223	
  1224		/* Disable single ended signal out */
  1225		reg = readl(regs_base + EXYNOS850_DRD_HSP);
  1226		reg &= ~HSP_FSV_OUT_EN;
  1227		writel(reg, regs_base + EXYNOS850_DRD_HSP);
  1228	
  1229		if (ss_ports)
  1230			exynos5_usbdrd_usb_v3p1_pipe_override(phy_drd);
  1231	
  1232		if (phy_drd->drv_data->phy_tunes)
  1233			exynos5_usbdrd_apply_phy_tunes(phy_drd,
  1234						       PTS_UTMI_POSTINIT);
  1235	}
  1236	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

