Return-Path: <linux-kernel+bounces-192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A8A813D4B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC703B21A7F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7AA66ABA;
	Thu, 14 Dec 2023 22:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eJ/fwR5Z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0541D2C69B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 22:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702593090; x=1734129090;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J/hErajCj0JrT9h+sFNznlkZGTjsSdHIWXTtKy8yVis=;
  b=eJ/fwR5ZGaRa5oTqyy4xXrOqJHzu+adRajtRO4IZvRRzcIJX99/k6pTg
   gA3a7vF4QuwwKSCfUs2VzoVxeWyYMz7c7w0N7CiK35dQtrrbQjfpm3aAG
   VwmMsDurNi0M4ONcdQUXFI7W/zzlHDIR8QUFDhkBdUccPGXx9o394QRua
   SiEcbbgsuT8BMIiydhZs4sCGb8+ILolsSBedmuNtWB5z2rI3y+nGYlh5m
   QR4klwh6i3emDDk1TGPsnjTtUf0XHaWMahhM/HcdIFfUp4A6ftM6AGmuc
   2l/TRmthiMHi9vNAtDOP3mcmPal/hgzD4tKtHL2aX8OB1J1hzNdpFQ+9b
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="426327502"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="426327502"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 14:31:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="750705320"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="750705320"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 14 Dec 2023 14:31:27 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDuEn-000MfB-14;
	Thu, 14 Dec 2023 22:31:25 +0000
Date: Fri, 15 Dec 2023 06:31:15 +0800
From: kernel test robot <lkp@intel.com>
To: Felix Fietkau <nbd@nbd.name>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/net/wireless/mediatek/mt76/mt7915/main.c:498:17: sparse:
 sparse: dubious: x & !y
Message-ID: <202312150611.uXOFKEPm-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c7402612e2e61b76177f22e6e7f705adcbecc6fe
commit: b2491018587a4aca6ea398bbad8f142306b8e086 wifi: mt76: mt7915: fix monitor mode issues
date:   3 months ago
config: i386-randconfig-063-20231025 (https://download.01.org/0day-ci/archive/20231215/202312150611.uXOFKEPm-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231215/202312150611.uXOFKEPm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312150611.uXOFKEPm-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/wireless/mediatek/mt76/mt7915/main.c:498:17: sparse: sparse: dubious: x & !y

vim +498 drivers/net/wireless/mediatek/mt76/mt7915/main.c

   452	
   453	static int mt7915_config(struct ieee80211_hw *hw, u32 changed)
   454	{
   455		struct mt7915_dev *dev = mt7915_hw_dev(hw);
   456		struct mt7915_phy *phy = mt7915_hw_phy(hw);
   457		int ret;
   458	
   459		if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
   460	#ifdef CONFIG_NL80211_TESTMODE
   461			if (phy->mt76->test.state != MT76_TM_STATE_OFF) {
   462				mutex_lock(&dev->mt76.mutex);
   463				mt76_testmode_reset(phy->mt76, false);
   464				mutex_unlock(&dev->mt76.mutex);
   465			}
   466	#endif
   467			ieee80211_stop_queues(hw);
   468			ret = mt7915_set_channel(phy);
   469			if (ret)
   470				return ret;
   471			ieee80211_wake_queues(hw);
   472		}
   473	
   474		if (changed & (IEEE80211_CONF_CHANGE_POWER |
   475			       IEEE80211_CONF_CHANGE_CHANNEL)) {
   476			ret = mt7915_mcu_set_txpower_sku(phy);
   477			if (ret)
   478				return ret;
   479		}
   480	
   481		mutex_lock(&dev->mt76.mutex);
   482	
   483		if (changed & IEEE80211_CONF_CHANGE_MONITOR) {
   484			bool enabled = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
   485			bool band = phy->mt76->band_idx;
   486			u32 rxfilter = phy->rxfilter;
   487	
   488			if (!enabled) {
   489				rxfilter |= MT_WF_RFCR_DROP_OTHER_UC;
   490				dev->monitor_mask &= ~BIT(band);
   491			} else {
   492				rxfilter &= ~MT_WF_RFCR_DROP_OTHER_UC;
   493				dev->monitor_mask |= BIT(band);
   494			}
   495	
   496			mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_RXD_G5_EN,
   497				       enabled);
 > 498			mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_MDP_DCR0_RX_HDR_TRANS_EN,
   499				       !dev->monitor_mask);
   500			mt76_testmode_reset(phy->mt76, true);
   501			mt76_wr(dev, MT_WF_RFCR(band), rxfilter);
   502		}
   503	
   504		mutex_unlock(&dev->mt76.mutex);
   505	
   506		return 0;
   507	}
   508	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

