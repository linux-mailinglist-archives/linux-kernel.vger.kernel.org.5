Return-Path: <linux-kernel+bounces-156498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3C88B035F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DB3C1C2307C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0592A15820E;
	Wed, 24 Apr 2024 07:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OSWGF7hB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225341581E4;
	Wed, 24 Apr 2024 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713944531; cv=none; b=bFpp3BVtzDz1VFJxoq3EmmjIO9SpQU63Ku5OcO+ObwYcaQYvYFj8sV1JsmYErUTa9ivUZc9fXEwp+/R6k2F/lRQpdJQRVHPPkU4yp1NeInm85PUKOBv+Dvzrx6JLyI94uRmNNugCQoTuihzzJGK9zKxn36X/Bm6x7c0DjOQ62Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713944531; c=relaxed/simple;
	bh=ifFeTKdxYgYlphUeuvIFx+Dv+oAd/73UKyLH3o1TNbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4gULGQP7HeUDrJOmIW5P3QMI79o3CVb5alW77/svjvvFndQAHKOgZLES38z4htbSzNUJe7IkCPBBOMT2IwkWd1xef900Fu22GcLT2/Ikp7Fr4BQO1Bt1qesM6fDpOLZ/ocCogBOryJPZzIMk2ckI80Ucitzy7Up4bHSjqZUtY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OSWGF7hB; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713944529; x=1745480529;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ifFeTKdxYgYlphUeuvIFx+Dv+oAd/73UKyLH3o1TNbk=;
  b=OSWGF7hB8rANZLgptV+yZEV71UJzebmz6o/CalukMQyXmFwAMypx3JQm
   of6mvRzsH2VlL428VuzYSSL2TVMUsm5WBYtm7MS2TGnqT9zBJll65bZPg
   mAg3RW6eZ6Q9d0UyaVGhF2fBtYl6sVBQIwEIdNRVr/tWhiWcFM2ydvNzu
   3S0TeUW0QdchDHpmL0ywZSUTM02ywErAWF7tY1fF9D4pRTHqLBitVUOdb
   6aGNcfdDAmwyjfv38jp4POUsOo5ar5MtVS+SzGIjq7TqW6YQW40RRc87s
   3jpHPWzN3A8UJnvAP47Jqt65pOfGuP+S2dLfQU2a4rGYD6sAY4gLPFvP6
   Q==;
X-CSE-ConnectionGUID: M2RdbmPaROSCZP1d96XDNg==
X-CSE-MsgGUID: hKUI3I5iTL288PPcJf6MUQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9390861"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="9390861"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 00:42:07 -0700
X-CSE-ConnectionGUID: zIrYEmJQTtywSUHadvP5bw==
X-CSE-MsgGUID: vmWh2OsmQvu5mTjoxh3LlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24692451"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 24 Apr 2024 00:42:02 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rzXGR-000104-2d;
	Wed, 24 Apr 2024 07:41:59 +0000
Date: Wed, 24 Apr 2024 15:41:58 +0800
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
Subject: Re: [PATCH 4/7] phy: exynos5-usbdrd: set ref clk freq in
 exynos850_usbdrd_utmi_init()
Message-ID: <202404241533.iud4U7SP-lkp@intel.com>
References: <20240423-usb-phy-gs101-v1-4-ebdcb3ac174d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240423-usb-phy-gs101-v1-4-ebdcb3ac174d@linaro.org>

Hi André,

kernel test robot noticed the following build errors:

[auto build test ERROR on a59668a9397e7245b26e9be85d23f242ff757ae8]

url:    https://github.com/intel-lab-lkp/linux/commits/Andr-Draszik/dt-bindings-phy-samsung-usb3-drd-phy-add-gs101-compatible/20240424-011137
base:   a59668a9397e7245b26e9be85d23f242ff757ae8
patch link:    https://lore.kernel.org/r/20240423-usb-phy-gs101-v1-4-ebdcb3ac174d%40linaro.org
patch subject: [PATCH 4/7] phy: exynos5-usbdrd: set ref clk freq in exynos850_usbdrd_utmi_init()
config: hexagon-randconfig-r123-20240424 (https://download.01.org/0day-ci/archive/20240424/202404241533.iud4U7SP-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20240424/202404241533.iud4U7SP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404241533.iud4U7SP-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/phy/samsung/phy-exynos5-usbdrd.c:13:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/phy/samsung/phy-exynos5-usbdrd.c:13:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/phy/samsung/phy-exynos5-usbdrd.c:13:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> drivers/phy/samsung/phy-exynos5-usbdrd.c:798:10: error: call to undeclared function 'FIELD_PREP_CONST'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   reg |= FIELD_PREP_CONST(SSPPLLCTL_FSEL, 7);
                          ^
   6 warnings and 1 error generated.


vim +/FIELD_PREP_CONST +798 drivers/phy/samsung/phy-exynos5-usbdrd.c

   750	
   751	static void exynos850_usbdrd_utmi_init(struct exynos5_usbdrd_phy *phy_drd)
   752	{
   753		void __iomem *regs_base = phy_drd->reg_phy;
   754		u32 reg;
   755	
   756		/*
   757		 * Disable HWACG (hardware auto clock gating control). This will force
   758		 * QACTIVE signal in Q-Channel interface to HIGH level, to make sure
   759		 * the PHY clock is not gated by the hardware.
   760		 */
   761		reg = readl(regs_base + EXYNOS850_DRD_LINKCTRL);
   762		reg |= LINKCTRL_FORCE_QACT;
   763		writel(reg, regs_base + EXYNOS850_DRD_LINKCTRL);
   764	
   765		/* Start PHY Reset (POR=high) */
   766		reg = readl(regs_base + EXYNOS850_DRD_CLKRST);
   767		reg |= CLKRST_PHY_SW_RST;
   768		writel(reg, regs_base + EXYNOS850_DRD_CLKRST);
   769	
   770		/* Enable UTMI+ */
   771		reg = readl(regs_base + EXYNOS850_DRD_UTMI);
   772		reg &= ~(UTMI_FORCE_SUSPEND | UTMI_FORCE_SLEEP | UTMI_DP_PULLDOWN |
   773			 UTMI_DM_PULLDOWN);
   774		writel(reg, regs_base + EXYNOS850_DRD_UTMI);
   775	
   776		/* Set PHY clock and control HS PHY */
   777		reg = readl(regs_base + EXYNOS850_DRD_HSP);
   778		reg |= HSP_EN_UTMISUSPEND | HSP_COMMONONN;
   779		writel(reg, regs_base + EXYNOS850_DRD_HSP);
   780	
   781		/* Set VBUS Valid and D+ pull-up control by VBUS pad usage */
   782		reg = readl(regs_base + EXYNOS850_DRD_LINKCTRL);
   783		reg |= LINKCTRL_BUS_FILTER_BYPASS(0xf);
   784		writel(reg, regs_base + EXYNOS850_DRD_LINKCTRL);
   785	
   786		reg = readl(regs_base + EXYNOS850_DRD_UTMI);
   787		reg |= UTMI_FORCE_BVALID | UTMI_FORCE_VBUSVALID;
   788		writel(reg, regs_base + EXYNOS850_DRD_UTMI);
   789	
   790		reg = readl(regs_base + EXYNOS850_DRD_HSP);
   791		reg |= HSP_VBUSVLDEXT | HSP_VBUSVLDEXTSEL;
   792		writel(reg, regs_base + EXYNOS850_DRD_HSP);
   793	
   794		reg = readl(regs_base + EXYNOS850_DRD_SSPPLLCTL);
   795		reg &= ~SSPPLLCTL_FSEL;
   796		switch (phy_drd->extrefclk) {
   797		case EXYNOS5_FSEL_50MHZ:
 > 798			reg |= FIELD_PREP_CONST(SSPPLLCTL_FSEL, 7);
   799			break;
   800		case EXYNOS5_FSEL_26MHZ:
   801			reg |= FIELD_PREP_CONST(SSPPLLCTL_FSEL, 6);
   802			break;
   803		case EXYNOS5_FSEL_24MHZ:
   804			reg |= FIELD_PREP_CONST(SSPPLLCTL_FSEL, 2);
   805			break;
   806		case EXYNOS5_FSEL_20MHZ:
   807			reg |= FIELD_PREP_CONST(SSPPLLCTL_FSEL, 1);
   808			break;
   809		case EXYNOS5_FSEL_19MHZ2:
   810			reg |= FIELD_PREP_CONST(SSPPLLCTL_FSEL, 0);
   811			break;
   812		default:
   813			dev_warn(phy_drd->dev, "unsupported ref clk: %#.2x\n",
   814				 phy_drd->extrefclk);
   815			break;
   816		}
   817		writel(reg, regs_base + EXYNOS850_DRD_SSPPLLCTL);
   818	
   819		/* Power up PHY analog blocks */
   820		reg = readl(regs_base + EXYNOS850_DRD_HSP_TEST);
   821		reg &= ~HSP_TEST_SIDDQ;
   822		writel(reg, regs_base + EXYNOS850_DRD_HSP_TEST);
   823	
   824		/* Finish PHY reset (POR=low) */
   825		udelay(10); /* required before doing POR=low */
   826		reg = readl(regs_base + EXYNOS850_DRD_CLKRST);
   827		reg &= ~(CLKRST_PHY_SW_RST | CLKRST_PORT_RST);
   828		writel(reg, regs_base + EXYNOS850_DRD_CLKRST);
   829		udelay(75); /* required after POR=low for guaranteed PHY clock */
   830	
   831		/* Disable single ended signal out */
   832		reg = readl(regs_base + EXYNOS850_DRD_HSP);
   833		reg &= ~HSP_FSV_OUT_EN;
   834		writel(reg, regs_base + EXYNOS850_DRD_HSP);
   835	}
   836	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

