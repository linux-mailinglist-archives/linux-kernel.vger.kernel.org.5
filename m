Return-Path: <linux-kernel+bounces-147786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFFF8A79AE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B0DD28641E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DBA7F8;
	Wed, 17 Apr 2024 00:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fKlcKsFO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583D2196;
	Wed, 17 Apr 2024 00:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713312689; cv=none; b=LoEZBZ3H2jV3BYY1CPbc+VykUchOR1hIN48EiJvAxcM5vxrT5lwpsBNP55UM24c/7f+Weqoe7bqlsjpsyT4WVJOPg8Q1/3K0xMq8TzeZN/yQpk2oarGlp1vjPh6oarldaztzJcv+BhsjFO2N7007DHWohsnPzPfG2KMCBDHSvbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713312689; c=relaxed/simple;
	bh=/0bQkhy6R6bkH+wNonZcUTdXypAMTB7A5B/WDE5cx2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMOqxl3bn5CIFFrqMyZXfOXMRwJd/mv2FIh2xhWDrkn3d32hGAZclv0ez1d9bI0otkkKz3flA93or3QsBokNj1jgyNF0oTMaGTUe/U5uQYJ4t60t+Tta5depH1FLuklgXQaj+DF6OhZtr0fTka85oEII8tQ3HRWkHz4JMIkSCsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fKlcKsFO; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713312686; x=1744848686;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/0bQkhy6R6bkH+wNonZcUTdXypAMTB7A5B/WDE5cx2w=;
  b=fKlcKsFOM3ZrWZgT7vqpksCXeWBH5Vm+FHKufl8SxtMcx1iE/e5U6sAj
   JJ6Pw9h4/Dbrpn9QQulbwsYN/JfE6EE6IuWatykTex7NXLU5FtI4br0mr
   5ZVPiGCIMyksp7Pugd9/hgRAKBeekQ2S18XGLJHsFmwOScetYbO7RMbpv
   pU38YZin6SGLROuN0y3xSRnDNSdHPf7si8YzDka3pUgIgw1V8ZGIh/WWB
   I/2vfdg+oNKzulI960zXEDd5GFfGfjC+oQWKxlA5t8aul0wPCYTDgflw9
   F6a4S9a7UlFoqemsB4J+r4A4UcJt+HBB0Ygf28MBJuG0aDkk7dpJL0mol
   g==;
X-CSE-ConnectionGUID: w9PpdUaDQiSLJ3FrUKyeRg==
X-CSE-MsgGUID: qkO2yps4THaVsET4wbcqwg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="34172018"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="34172018"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 17:11:25 -0700
X-CSE-ConnectionGUID: xk91JmxwTACj/hv/y9LImA==
X-CSE-MsgGUID: 4L3ApJL+QeOYTtVcltyO1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22485084"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 16 Apr 2024 17:11:18 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rwstP-0005sO-2j;
	Wed, 17 Apr 2024 00:11:15 +0000
Date: Wed, 17 Apr 2024 08:10:20 +0800
From: kernel test robot <lkp@intel.com>
To: Dharma Balasubiramani <dharma.b@microchip.com>,
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
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v5 3/4] MAINTAINERS: add SAM9X7 SoC's LVDS controller
Message-ID: <202404170727.UvHFX4sD-lkp@intel.com>
References: <20240405043536.274220-4-dharma.b@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405043536.274220-4-dharma.b@microchip.com>

Hi Dharma,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on linus/master v6.9-rc4 next-20240416]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dharma-Balasubiramani/dt-bindings-display-bridge-add-sam9x75-lvds-binding/20240405-123901
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20240405043536.274220-4-dharma.b%40microchip.com
patch subject: [PATCH v5 3/4] MAINTAINERS: add SAM9X7 SoC's LVDS controller
reproduce: (https://download.01.org/0day-ci/archive/20240417/202404170727.UvHFX4sD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404170727.UvHFX4sD-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/devicetree/bindings/power/wakeup-source.txt references a file that doesn't exist: Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
   Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
   Warning: Documentation/devicetree/bindings/sound/fsl-asoc-card.txt references a file that doesn't exist: Documentation/devicetree/bindings/sound/fsl,asrc.txt
   Warning: Documentation/gpu/amdgpu/display/display-contributing.rst references a file that doesn't exist: Documentation/GPU/amdgpu/display/mpo-overview.rst
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/display/bridge/microchip,sam9x7-lvds.yaml
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

