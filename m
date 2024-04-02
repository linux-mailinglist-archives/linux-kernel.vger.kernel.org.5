Return-Path: <linux-kernel+bounces-128502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB7D895BBB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3455B283DFB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9CB15ADB0;
	Tue,  2 Apr 2024 18:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FBQBfQ7L"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C1615A48E;
	Tue,  2 Apr 2024 18:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712082405; cv=none; b=CjEEzZ2qL5jr9vylnu/9yFnjtyJI4uKsgZDX8vWjum9jJ5rfELSrBj/i3XL9gQDPeyXJq3I78Cd5x5mVpvzJ3ks/p0KJ+9rQFWOw6o5ZkYFYaG6vyEvhsYDvNke8Pfnp2CAsL6a0XUgo2bvWiJjXFS/1suJ2Wwv4mN7yAl7NcYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712082405; c=relaxed/simple;
	bh=sz+2d1gs1ehBN3Q4pGBpK6maDbOhiUQSkQL1PjdfiB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=godsXFBtLe+xNLqunUiY1wgf6Fs5g+RtaUZfUivaPglZecZrnqQb04tayws5awQcXJKyzgwMpRkpacQ8EbmlAhFLIlyb+kk9UMf+L3cxonjEoCJcqxSwdgYoXzQqE5XPfhc3CzuYadbk2dbDxBpTgIPnrJtJ1x+/VmeIJfjNuyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FBQBfQ7L; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712082404; x=1743618404;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sz+2d1gs1ehBN3Q4pGBpK6maDbOhiUQSkQL1PjdfiB0=;
  b=FBQBfQ7LZJUnMic61TiGsZU3+92kYtL1AXDgSo0d1n4wqVQtLMXh939R
   meXxdwLjrcpSlYZ/4ewhaVk2YWP9N0Khb0HBA9YQZpCpnzXnoJZwTbyBy
   ztWztTS8+tb+QeSWbzVbWXa+Xup/QhfQqojiJ4uAw7I+A7PSV9YtFfw/e
   C0kHM2usGv9j+EikdCuH3DVdefnh444vyMSWX+04srPH+47Rz/OANw5+u
   FCOMcsH0gXVnuZHI8TRlhk2bf8kGd+f7JgJH1dC/lGEIGqzBsGxiKg8Yf
   MJmXLQEot3KXHP5ZyXUGsSPgHcDuOlm5E8hJxfYEj3WJar0furnlFhVyi
   w==;
X-CSE-ConnectionGUID: gjasWSDTQxWkTKjE19uAxw==
X-CSE-MsgGUID: Ogh2Tf65RsOR4+M9XAJZpg==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="18635992"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="18635992"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 11:26:43 -0700
X-CSE-ConnectionGUID: JE8ygY+RRSuHgF03rDWXmg==
X-CSE-MsgGUID: fQuqhyGWTHWP9oNxtrYh5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="22898037"
Received: from lkp-server02.sh.intel.com (HELO 90ee3aa53dbd) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 02 Apr 2024 11:26:40 -0700
Received: from kbuild by 90ee3aa53dbd with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rriqD-0001Qm-14;
	Tue, 02 Apr 2024 18:26:37 +0000
Date: Wed, 3 Apr 2024 02:26:21 +0800
From: kernel test robot <lkp@intel.com>
To: Richard Zhu <hongxing.zhu@nxp.com>, vkoul@kernel.org, kishon@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	frank.li@nxp.com, conor+dt@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, hongxing.zhu@nxp.com,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, imx@lists.linux.dev
Subject: Re: [PATCH v2 3/3] phy: freescale: imx8q-hsio: Add i.MX8Q HSIO PHY
 driver support
Message-ID: <202404030236.zuDJQOtw-lkp@intel.com>
References: <1712036704-21064-4-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1712036704-21064-4-git-send-email-hongxing.zhu@nxp.com>

Hi Richard,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.9-rc2]
[cannot apply to next-20240402]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Richard-Zhu/dt-bindings-phy-phy-imx8-pcie-Add-binding-for-i-MX8Q-HSIO-SerDes-PHY/20240402-140347
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/1712036704-21064-4-git-send-email-hongxing.zhu%40nxp.com
patch subject: [PATCH v2 3/3] phy: freescale: imx8q-hsio: Add i.MX8Q HSIO PHY driver support
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20240403/202404030236.zuDJQOtw-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240403/202404030236.zuDJQOtw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404030236.zuDJQOtw-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/phy/freescale/phy-fsl-imx8q-hsio.c:34: warning: "MODE_MASK" redefined
      34 | #define MODE_MASK               GENMASK(20, 17)
         | 
   In file included from arch/arm/include/asm/ptrace.h:10,
                    from arch/arm/include/asm/irqflags.h:7,
                    from include/linux/irqflags.h:18,
                    from arch/arm/include/asm/bitops.h:28,
                    from include/linux/bitops.h:68,
                    from include/linux/kernel.h:23,
                    from include/linux/clk.h:13,
                    from drivers/phy/freescale/phy-fsl-imx8q-hsio.c:6:
   arch/arm/include/uapi/asm/ptrace.h:67: note: this is the location of the previous definition
      67 | #define MODE_MASK       0x0000001f
         | 


vim +/MODE_MASK +34 drivers/phy/freescale/phy-fsl-imx8q-hsio.c

    27	
    28	/* i.MX8Q HSIO registers */
    29	#define CTRL0			0x0
    30	#define APB_RSTN_0		BIT(0)
    31	#define APB_RSTN_1		BIT(1)
    32	#define PIPE_RSTN_0_MASK	GENMASK(25, 24)
    33	#define PIPE_RSTN_1_MASK	GENMASK(27, 26)
  > 34	#define MODE_MASK		GENMASK(20, 17)
    35	#define MODE_PCIE		0x0
    36	#define MODE_SATA		0x4
    37	#define DEVICE_TYPE_MASK	GENMASK(27, 24)
    38	#define EPCS_TXDEEMP		BIT(5)
    39	#define EPCS_TXDEEMP_SEL	BIT(6)
    40	#define EPCS_PHYRESET_N		BIT(7)
    41	#define RESET_N			BIT(12)
    42	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

