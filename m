Return-Path: <linux-kernel+bounces-156284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 878368B00C8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4E71B2281E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF083155352;
	Wed, 24 Apr 2024 05:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YvNsIbv9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708FB328DB;
	Wed, 24 Apr 2024 05:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713935046; cv=none; b=CZrI+9l71vSwZnPS1JHjnrTVnU32LGRy1U6jdKsjx/JewJ6x+sKWdL1xEIG5T6tBvuTHWjsbpxoxPGa0skf7c9LVS0qaLwk5zFODuTqArZSpO/q7kBjkuhAY5RaP7Gko0ebwC8GRywEXFQgZMzo6Cg7UcwscnKqlIzJKrCbQHYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713935046; c=relaxed/simple;
	bh=Sa+pwedhqK7zbwcOMl4PDUIP9usEgvzK4TfQqOq9ndc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFTzaE8JfkI85LVadA6bn45U42qhmiJ6U/3xZVx7ZTyXX7wNB9dHCVW0NNoeaewslgRgHnYMhYZDbdcj6bgaZEpdmdqS/KlDqNtzWtKyB4r5QPmzzzlXyJUC+VjS0WSYGlmxaiRS6kXtsuokzx9JEjf0SrWWJ5b0raza1Y2iM1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YvNsIbv9; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713935044; x=1745471044;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Sa+pwedhqK7zbwcOMl4PDUIP9usEgvzK4TfQqOq9ndc=;
  b=YvNsIbv9nH2D27+F4+d1Q2OHy/5CNFc0JqDYwKz0Ip2hIiP7Le/7BvWf
   WZul6MT6n+lwDnZrW0b9Ooc15KIS1npvDb4XuXmPfsvSCE727F9iar+wb
   hi4U+BtEHJZN/INZuMIc9olb5iFni8M4tQ1JkiieH4qdq0cmLVzsBg8hB
   rLnGpliYkgAU6GfdmwExZFA/Y4Hm+MuGQmhetBpG5czvKf9kO626L8BHq
   ShcIFNNzesNCNRCz+/RWkzvvyhTEpMDvd9usQtv9eNFjcIZxuHkcKKkIN
   yZMN7pZ6zCBzybAM3u4za3cRVxHI0U8FBQu9IiGCTSkMKoiKV4uNn+R5f
   w==;
X-CSE-ConnectionGUID: 7yX27tH/QC61BGAXmf2MVg==
X-CSE-MsgGUID: kinJfxcjQwWGNlXWxdwG+g==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27062050"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="27062050"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 22:04:03 -0700
X-CSE-ConnectionGUID: lKywX25nTL2GHttoopxsjA==
X-CSE-MsgGUID: 15mZKhYgSG29vP307jN2nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="62045622"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 23 Apr 2024 22:03:58 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rzUnT-0000se-1S;
	Wed, 24 Apr 2024 05:03:55 +0000
Date: Wed, 24 Apr 2024 13:03:08 +0800
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
Message-ID: <202404241238.E14kFCXA-lkp@intel.com>
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
config: arc-randconfig-002-20240424 (https://download.01.org/0day-ci/archive/20240424/202404241238.E14kFCXA-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240424/202404241238.E14kFCXA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404241238.E14kFCXA-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/phy/samsung/phy-exynos5-usbdrd.c: In function 'exynos850_usbdrd_utmi_init':
>> drivers/phy/samsung/phy-exynos5-usbdrd.c:798:24: error: implicit declaration of function 'FIELD_PREP_CONST' [-Werror=implicit-function-declaration]
     798 |                 reg |= FIELD_PREP_CONST(SSPPLLCTL_FSEL, 7);
         |                        ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


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

