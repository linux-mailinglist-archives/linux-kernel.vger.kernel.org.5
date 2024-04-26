Return-Path: <linux-kernel+bounces-159444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BE28B2EAF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79A201C21DD2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587584685;
	Fri, 26 Apr 2024 02:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l0LNDu3E"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3968C380;
	Fri, 26 Apr 2024 02:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714098537; cv=none; b=GoBg9xGWIjbHLBXaO6g6Udt6FdiUaES0lc9FsAz5MwJxvsfVTvo0mhYKQOoCfD+nQr3jB+arPMP+o8lawhLOKptB99ZnYYfbCpPtIADrAaFkqTXod/m4CG1HGGmkQfNc7iqIOjU/v9sTN+jgXQtYkG0GABC2p3sBIyn+76ZGjcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714098537; c=relaxed/simple;
	bh=a7GCnBwqMy29DV7yfejurYzqI+BjrI2g+dPqUPElVxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVCCFARkj6E/oWAnxm4e/BGtbHrx4cgaKxjSWJWsyey11uYAXGUxkFSNnWxz90j1asJw8rFXGYZyCmwK3+X6Oc/C8yOc4hjFhKmb77ALxx3u5nwbKkjzoHzjzLNlWJ0ej3skevEcp1rhPBIqcoRgTti/Eqq9nDBH6qHVdczNhzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l0LNDu3E; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714098536; x=1745634536;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a7GCnBwqMy29DV7yfejurYzqI+BjrI2g+dPqUPElVxY=;
  b=l0LNDu3ENfzD8sji4boNkWXyhRMv9xr7pCn/FGqSRhO8s7LGJFDC/Lu3
   qYvlB7NmPbVMCxLeQgGD2FHIlMZn/VQnDIWv/4s5e+8PobqduwYEp1yaJ
   IMGY+20j5qmZFr/XyqVulquxbISKu9PdawCNN2RqhEPeuDT0tV5+qk4Oq
   VboqpGNRJC1d/CrVmANsZhrrdPGb5sdW+qZsLpwoVMy4xA8opHfXJUCt/
   Cl6w0oKtmQSs0B5MIoQ9USURdYdext40IxjuDXCu+taR92+aaFaEmVoxG
   rsXtUFmhed9l64e7Jd4cCMp7yi0TFf8ZhX6q2A5eFiWmhy6rIg1FbUxMk
   A==;
X-CSE-ConnectionGUID: gsWHkqZUQj2JqeahzfbR0w==
X-CSE-MsgGUID: AmkGWUU1TOyie4FUSE4MLg==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="9658984"
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="9658984"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 19:28:31 -0700
X-CSE-ConnectionGUID: Muomi0QGS/GUkiANgz9eDA==
X-CSE-MsgGUID: i31M9VSMRcKlVW3m4otSoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="25276471"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 25 Apr 2024 19:28:27 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s0BK4-0003Ai-29;
	Fri, 26 Apr 2024 02:28:24 +0000
Date: Fri, 26 Apr 2024 10:27:38 +0800
From: kernel test robot <lkp@intel.com>
To: Sky Huang <SkyLake.Huang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Steven Liu <Steven.Liu@mediatek.com>,
	"SkyLake.Huang" <skylake.huang@mediatek.com>
Subject: Re: [PATCH 1/3] net: phy: mediatek: Re-organize MediaTek ethernet
 phy drivers
Message-ID: <202404261047.Dx118RCc-lkp@intel.com>
References: <20240425023325.15586-2-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425023325.15586-2-SkyLake.Huang@mediatek.com>

Hi Sky,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20240424]
[cannot apply to net-next/main net/main linus/master v6.9-rc5 v6.9-rc4 v6.9-rc3 v6.9-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sky-Huang/net-phy-mediatek-Re-organize-MediaTek-ethernet-phy-drivers/20240425-103608
base:   next-20240424
patch link:    https://lore.kernel.org/r/20240425023325.15586-2-SkyLake.Huang%40mediatek.com
patch subject: [PATCH 1/3] net: phy: mediatek: Re-organize MediaTek ethernet phy drivers
config: i386-kismet-CONFIG_NVMEM_MTK_EFUSE-CONFIG_MEDIATEK_GE_SOC_PHY-0-0 (https://download.01.org/0day-ci/archive/20240426/202404261047.Dx118RCc-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20240426/202404261047.Dx118RCc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404261047.Dx118RCc-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for NVMEM_MTK_EFUSE when selected by MEDIATEK_GE_SOC_PHY
   WARNING: unmet direct dependencies detected for NVMEM_MTK_EFUSE
     Depends on [n]: NVMEM [=n] && (ARCH_MEDIATEK || COMPILE_TEST [=y]) && HAS_IOMEM [=y]
     Selected by [y]:
     - MEDIATEK_GE_SOC_PHY [=y] && NETDEVICES [=y] && PHYLIB [=y] && (ARM64 && ARCH_MEDIATEK || COMPILE_TEST [=y])

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

