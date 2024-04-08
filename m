Return-Path: <linux-kernel+bounces-135939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C2B89CD8D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F901C22423
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C8C1487CF;
	Mon,  8 Apr 2024 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QOOdY4eR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7301474DB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 21:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712611508; cv=none; b=hccJ9S0H7NrqpwGfZBlqkyXz95pvyThjgjtX9SCQM0juGVsB8sOnWxDLQGiinEGtCrMkSxmkR5Pv+09pvBBdp+/EZ7SvldjgmyHwQnbU4bJpeHiUefhs/Yquc3RFpvRyLg9f6BOwm1vkqtFdpN8z679nt4n5cN6V7R62Co2n/+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712611508; c=relaxed/simple;
	bh=Cq3DsQlqiV7ail5ix0XUsou1KwHuNKNIe9gx3ewKcIg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LoMYb11CFJdXKs9K6iaOj4jaXATNzy5S+q8nLrvxTrs/NDDWnKjIrkmnLqtnZV1DFOFj2SCh4d71BeFJ4b6PRD/ka/sRMEDauxHtgTRdSTJoJ3MJeiu3QtgM7K78YD7A83F4Md09Jr6+44tbRKFPK7xuLmIkzVU98y25MJQcwj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QOOdY4eR; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712611506; x=1744147506;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Cq3DsQlqiV7ail5ix0XUsou1KwHuNKNIe9gx3ewKcIg=;
  b=QOOdY4eRg8XcOZrRBMQO6jVAKfdscrtVz5ptMG4Yd2yPWd6WAaESrZJc
   HbWpm4Zu67+9GwMdXob34uEY+e8Vi1h/5n6bhWNNcrJ7VsyVmWSLJKk2l
   8++B8VZC1c1hVynnobr0bhY/DGLg6C1iUH9O5rDTAju69uYxj9RTdZNuB
   znKR6zmfXJ5KGJei+yUbpxicgCA3SiDTw+jzU3HYQuY7S9HdvweWFYGU7
   o5TXs5zxatXz8lv/znpJzRh6Yqg6Uv8dYNe8fAw8UuNDmHS4l3juAmIlp
   fL/aaN2HONT6CveJeDnUywjdRfA41vskJVSi4tSoCiF0NEx2SCl/nI1P0
   Q==;
X-CSE-ConnectionGUID: 11+8utkkTIqGuv7CsvTz8Q==
X-CSE-MsgGUID: jrovb+FdQaO71+lcbnytbQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7777032"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="7777032"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 14:25:05 -0700
X-CSE-ConnectionGUID: rx0GHVBCTt+TDmIf4tTpFg==
X-CSE-MsgGUID: snlLtfdoSHKM6YuRWS5zaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="20446909"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 08 Apr 2024 14:25:04 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rtwU9-0005VE-2m;
	Mon, 08 Apr 2024 21:25:01 +0000
Date: Tue, 9 Apr 2024 05:24:12 +0800
From: kernel test robot <lkp@intel.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Algea Cao <algea.cao@rock-chips.com>
Subject: phy-rockchip-samsung-hdptx.c:undefined reference to
 `rational_best_approximation'
Message-ID: <202404090540.2l1TEkDF-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fec50db7033ea478773b159e0e2efb135270e3b7
commit: 553be2830c5f33308483e8118de748a2c69fe593 phy: rockchip: Add Samsung HDMI/eDP Combo PHY driver
date:   8 weeks ago
config: sh-randconfig-002-20240409 (https://download.01.org/0day-ci/archive/20240409/202404090540.2l1TEkDF-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240409/202404090540.2l1TEkDF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404090540.2l1TEkDF-lkp@intel.com/

All errors (new ones prefixed by >>):

   sh4-linux-ld: drivers/phy/rockchip/phy-rockchip-samsung-hdptx.o: in function `rk_hdptx_ropll_tmds_cmn_config':
>> phy-rockchip-samsung-hdptx.c:(.text+0x950): undefined reference to `rational_best_approximation'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

