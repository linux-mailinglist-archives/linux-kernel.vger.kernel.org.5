Return-Path: <linux-kernel+bounces-152356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD71A8ABCDD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 21:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45CE31F21197
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 19:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5413D96A;
	Sat, 20 Apr 2024 19:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MKzfkxtc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084BB205E01;
	Sat, 20 Apr 2024 19:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713640118; cv=none; b=HU61xexECO042OzjQRHsWkBRl38FB3Kk3L8eA1TPZ1UHxbyFk2q3vah6Wr4cA8+7y8ZDgy0vx/y9rgZeJhDadgpBaV2jDjzxETUFnlweNrjbx7k8vPU0BvqKBRFkPsaMnEJmSlQp0BQ3XS5T9dsUIRdM+VGJR7gv33w8NuC+70s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713640118; c=relaxed/simple;
	bh=DAWRxBbWwkIdn3sqEiU4w/Wb8Qe6Fk/DbaiAUfMnst8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgcs5WMMeFtUcKLvUwmmQfmZhfDymbYEbEZ/wF+3Vydm4oOTJFTNOZPMNTEHoLctQdSGPqTweCPHWACEGPkOpDM8NxZhvSpCH4XgUOSA6XKeYAiEQZB5isQjhf4jaWQp9TGyiLjOwX2sWPnvOUeLqHpJwtr/tzWK1nViZP7zY5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MKzfkxtc; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713640116; x=1745176116;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DAWRxBbWwkIdn3sqEiU4w/Wb8Qe6Fk/DbaiAUfMnst8=;
  b=MKzfkxtc7c8vXtWhKonznoQ2RLWjohjfiChYW7WXjs7qEkiBAMAuY9mR
   D3d99z2aLTphSBG4+W+G7JeUKh0lHyJU1sdb3sOh79+GBGNJ6TlDaxWvY
   hxxqD0EgfT6GAbvYBmdnoHZzF1Zx+DDLiapBTrEx6N1bcwvN3pwjOz4be
   /xPuHLsmC7fpJzilBU71yj9QbYlCViqVWmwax4v6ZwK5dmc1U6MkZwWpN
   dlH39Pcn+oF7g/kAcb1X6gXWxdpcTCTWQfbeGUa6BfguBbBBgbgByMXqG
   ljxO8paYob/GoAll8wGAkoac2+7lJOFznQw62QD5dXy8X0l7iyuhwKToF
   Q==;
X-CSE-ConnectionGUID: zRLBcZ9qRMGS4sV1Dp4mTQ==
X-CSE-MsgGUID: M4AjnZRxTVGgzqeM/yU2YA==
X-IronPort-AV: E=McAfee;i="6600,9927,11050"; a="13064051"
X-IronPort-AV: E=Sophos;i="6.07,217,1708416000"; 
   d="scan'208";a="13064051"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2024 12:08:35 -0700
X-CSE-ConnectionGUID: cJ9Qkz74RXu81siqOtt3yg==
X-CSE-MsgGUID: EjS+I7MQTmicvy6dYuLD2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,217,1708416000"; 
   d="scan'208";a="24249702"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 20 Apr 2024 12:08:28 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ryG4X-000BQl-1h;
	Sat, 20 Apr 2024 19:08:25 +0000
Date: Sun, 21 Apr 2024 03:07:56 +0800
From: kernel test robot <lkp@intel.com>
To: Dharma Balasubiramani <dharma.b@microchip.com>,
	"dmitry . baryshkov @ linaro . org" <dmitry.baryshkov@linaro.org>,
	"andrzej . hajda @ intel . com" <andrzej.hajda@intel.com>,
	"neil . armstrong @ linaro . org" <neil.armstrong@linaro.org>,
	"rfoss @ kernel . org" <rfoss@kernel.org>,
	"Laurent . pinchart @ ideasonboard . com" <Laurent.pinchart@ideasonboard.com>,
	"jonas @ kwiboo . se" <jonas@kwiboo.se>,
	"jernej . skrabec @ gmail . com" <jernej.skrabec@gmail.com>,
	"maarten . lankhorst @ linux . intel . com" <maarten.lankhorst@linux.intel.com>,
	"mripard @ kernel . org" <mripard@kernel.org>,
	"tzimmermann @ suse . de" <tzimmermann@suse.de>,
	"airlied @ gmail . com" <airlied@gmail.com>,
	"daniel @ ffwll . ch" <daniel@ffwll.ch>,
	"robh+dt @ kernel . org" <robh+dt@kernel.org>,
	"krzysztof . kozlowski+dt @ linaro . org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt @ kernel . org" <conor+dt@kernel.org>,
	"linux @ armlinux . org . uk" <linux@armlinux.org.uk>,
	"Nicolas . Ferre @ microchip . com" <Nicolas.Ferre@microchip.com>,
	"alexandre . belloni @ bootlin . com" <alexandre.belloni@bootlin.com>,
	"claudiu . beznea @ tuxon . dev" <claudiu.beznea@tuxon.dev>,
	"Manikandan . M @ microchip . com" <Manikandan.M@microchip.com>,
	"arnd @ arndb . de" <arnd@arndb.de>,
	"geert+renesas @ glider . be" <geert+renesas@glider.be>,
	"Jason @ zx2c4 . com" <Jason@zx2c4.com>,
	"mpe @ ellerman . id . au" <mpe@ellerman.id.au>,
	"gerg @ linux-m68k . org" <gerg@linux-m68k.org>,
	"rdunlap @ infradead . org" <rdunlap@infradead.org>,
	"vbabka @ suse . cz" <vbabka@suse.cz>,
	"dri-devel @ lists . freedesktop . org" <dri-devel@lists.freedesktop.org>,
	"devicetree @ vger . kernel . org" <devicetree@vger.kernel.org>,
	"linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v7 2/4] drm/bridge: add lvds controller support for sam9x7
Message-ID: <202404210232.jI4lxq3k-lkp@intel.com>
References: <20240418085725.373797-3-dharma.b@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418085725.373797-3-dharma.b@microchip.com>

Hi Dharma,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on linus/master v6.9-rc4 next-20240419]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dharma-Balasubiramani/dt-bindings-display-bridge-add-sam9x75-lvds-binding/20240418-170157
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20240418085725.373797-3-dharma.b%40microchip.com
patch subject: [PATCH v7 2/4] drm/bridge: add lvds controller support for sam9x7
config: arm-at91_dt_defconfig (https://download.01.org/0day-ci/archive/20240421/202404210232.jI4lxq3k-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 7089c359a3845323f6f30c44a47dd901f2edfe63)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240421/202404210232.jI4lxq3k-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404210232.jI4lxq3k-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/bridge/microchip-lvds.c:17:
   In file included from include/linux/phy/phy.h:17:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/gpu/drm/bridge/microchip-lvds.c:199:6: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
     199 |         if (ret < 0) {
         |             ^~~
   drivers/gpu/drm/bridge/microchip-lvds.c:154:9: note: initialize the variable 'ret' to silence this warning
     154 |         int ret;
         |                ^
         |                 = 0
   2 warnings generated.


vim +/ret +199 drivers/gpu/drm/bridge/microchip-lvds.c

   148	
   149	static int mchp_lvds_probe(struct platform_device *pdev)
   150	{
   151		struct device *dev = &pdev->dev;
   152		struct mchp_lvds *lvds;
   153		struct device_node *port;
   154		int ret;
   155	
   156		if (!dev->of_node)
   157			return -ENODEV;
   158	
   159		lvds = devm_kzalloc(&pdev->dev, sizeof(*lvds), GFP_KERNEL);
   160		if (!lvds)
   161			return -ENOMEM;
   162	
   163		lvds->dev = dev;
   164	
   165		lvds->regs = devm_ioremap_resource(lvds->dev,
   166				platform_get_resource(pdev, IORESOURCE_MEM, 0));
   167		if (IS_ERR(lvds->regs))
   168			return PTR_ERR(lvds->regs);
   169	
   170		lvds->pclk = devm_clk_get(lvds->dev, "pclk");
   171		if (IS_ERR(lvds->pclk))
   172			return dev_err_probe(lvds->dev, PTR_ERR(lvds->pclk),
   173					"could not get pclk_lvds\n");
   174	
   175		port = of_graph_get_remote_node(dev->of_node, 1, 0);
   176		if (!port) {
   177			dev_err(dev,
   178				"can't find port point, please init lvds panel port!\n");
   179			return -ENODEV;
   180		}
   181	
   182		lvds->panel = of_drm_find_panel(port);
   183		of_node_put(port);
   184	
   185		if (IS_ERR(lvds->panel))
   186			return -EPROBE_DEFER;
   187	
   188		lvds->panel_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 1, 0);
   189	
   190		if (IS_ERR(lvds->panel_bridge))
   191			return PTR_ERR(lvds->panel_bridge);
   192	
   193		lvds->bridge.of_node = dev->of_node;
   194		lvds->bridge.type = DRM_MODE_CONNECTOR_LVDS;
   195		lvds->bridge.funcs = &mchp_lvds_bridge_funcs;
   196	
   197		dev_set_drvdata(dev, lvds);
   198		devm_pm_runtime_enable(dev);
 > 199		if (ret < 0) {
   200			dev_err(lvds->dev, "failed to enable pm runtime: %d\n", ret);
   201			return ret;
   202		}
   203	
   204		drm_bridge_add(&lvds->bridge);
   205	
   206		return 0;
   207	}
   208	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

