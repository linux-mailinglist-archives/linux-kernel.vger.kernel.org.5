Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFF580BA0E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 11:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjLJKBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 05:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjLJKBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 05:01:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08C9E8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 02:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702202500; x=1733738500;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zzWhk8O2avZ8zbbXZq8tD7ZF0iPAsFXXNjRL5ZsfeA0=;
  b=C4gH5S9EpWGvcvuV2guanvTC27eaamsjPzEm+aFKU9oqQWsAHvVIlxtf
   yBG/0IowEbB1M9/d5Vv6taHfebDgz4zfinUIZzLcYjD8az9tylGd/IH7K
   XqNoxluHHMSaWetsEJtPZb7S8z9kbcYNBp6/IdYcyGoAHAPxf6uJeNOjE
   C3CW5R7gK9S2JkCr4UJf7mOeqoiE1x6fo2VB8JU2s9gRAH3z8omJqDJ5d
   9JhHz/3EOCk+tF7DbAI6R1+Cv1sXAcqZ1TL70kqEX+frhso1014oCSB/8
   BdWKK63V8ow/syD+UmUDSrklJTXWyf2Hw9UyzpU8f2QdYLMK3iWd+j5Zm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="391717117"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="391717117"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 02:01:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="843131661"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="843131661"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 10 Dec 2023 02:01:39 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rCGcz-000GgW-04;
        Sun, 10 Dec 2023 10:01:37 +0000
Date:   Sun, 10 Dec 2023 18:00:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: drivers/net/wireless/intel/iwlwifi/mvm/time-event.c:705
 iwl_mvm_get_session_prot_id() warn: unsigned 'link_id' is never less than
 zero.
Message-ID: <202312101708.68txSnLI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c527f5606aa545233a4d2c6d5c636ed82b8633ef
commit: 1350658373106eace418eea673a058a0285f8334 wifi: iwlwifi: support link_id in SESSION_PROTECTION cmd
date:   7 weeks ago
config: powerpc-randconfig-r071-20231126 (https://download.01.org/0day-ci/archive/20231210/202312101708.68txSnLI-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231210/202312101708.68txSnLI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312101708.68txSnLI-lkp@intel.com/

smatch warnings:
drivers/net/wireless/intel/iwlwifi/mvm/time-event.c:705 iwl_mvm_get_session_prot_id() warn: unsigned 'link_id' is never less than zero.

vim +/link_id +705 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c

   691	
   692	/* Determine whether mac or link id should be used, and validate the link id */
   693	static int iwl_mvm_get_session_prot_id(struct iwl_mvm *mvm,
   694					       struct ieee80211_vif *vif,
   695					       u32 link_id)
   696	{
   697		struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
   698		int ver = iwl_fw_lookup_cmd_ver(mvm->fw,
   699						WIDE_ID(MAC_CONF_GROUP,
   700							SESSION_PROTECTION_CMD), 1);
   701	
   702		if (ver < 2)
   703			return mvmvif->id;
   704	
 > 705		if (WARN(link_id < 0 || !mvmvif->link[link_id],
   706			 "Invalid link ID for session protection: %u\n", link_id))
   707			return -EINVAL;
   708	
   709		if (WARN(ieee80211_vif_is_mld(vif) &&
   710			 !(vif->active_links & BIT(link_id)),
   711			 "Session Protection on an inactive link: %u\n", link_id))
   712			return -EINVAL;
   713	
   714		return mvmvif->link[link_id]->fw_link_id;
   715	}
   716	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
