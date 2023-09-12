Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1859B79C1A4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 03:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbjILB2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 21:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234909AbjILB2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 21:28:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84841194EE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694481184; x=1726017184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tGzkG5QJfkRexOBDeMPfPnpMWd67HwQMNA7xHo3Cbvs=;
  b=RuZfQUe9STuC2q4rMDmIC6k3ZXX1NZ+3fYN+W9pg2w2U1CAAWYaF/7NR
   fQoKStZFWcXnSIzOnWVOfzDr5bAsYbBi3p6FVKbHbZLnJqXwsLUBC2YGB
   4HnDKewFzvl475ZK3hi+1jEVsDH3c1jfR1QyBts/g8Avs1Tv+locgQ6nv
   O1MKVE5a6aKv7xNHw8mLdGae8uBOtoqnPTn7VPGRHgoFa28LDHK2mwc1/
   OMjRtwNPZ7ZcnKhlG05WsBn7F/A0GYvK5yOlxVFBL1fh2zG2VOQo7hX8B
   vn8klmMYXqVQNc0dv5k0lURgGo95Ub4vuoeh1IBYjmkDiplfGXfwAof+p
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="464616354"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="464616354"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 18:10:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="867162249"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="867162249"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 11 Sep 2023 18:10:05 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qfruk-00071x-2c;
        Tue, 12 Sep 2023 01:10:02 +0000
Date:   Tue, 12 Sep 2023 09:09:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 4/8] staging: rtl8192e: Use standard function in
 rtllib_rx_check_duplicate()
Message-ID: <202309120956.6aSRBSxJ-lkp@intel.com>
References: <c636aadd4cf4898c57c348a1d789790c5a459749.1694282907.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c636aadd4cf4898c57c348a1d789790c5a459749.1694282907.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

kernel test robot noticed the following build warnings:

[auto build test WARNING on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Philipp-Hortmann/staging-rtl8192e-Remove-useless-equation-in-debug-output/20230910-022154
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/c636aadd4cf4898c57c348a1d789790c5a459749.1694282907.git.philipp.g.hortmann%40gmail.com
patch subject: [PATCH 4/8] staging: rtl8192e: Use standard function in rtllib_rx_check_duplicate()
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20230912/202309120956.6aSRBSxJ-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230912/202309120956.6aSRBSxJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309120956.6aSRBSxJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/staging/rtl8192e/rtllib_rx.c:925:9: warning: variable 'fc' is uninitialized when used here [-Wuninitialized]
                           if ((fc & (1 << 11)) && (frag == pRxTS->rx_last_frag_num) &&
                                ^~
   drivers/staging/rtl8192e/rtllib_rx.c:906:8: note: initialize the variable 'fc' to silence this warning
           u16 fc, sc;
                 ^
                  = 0
   1 warning generated.


vim +/fc +925 drivers/staging/rtl8192e/rtllib_rx.c

94a799425eee82 Larry Finger       2011-08-23  901  
49aab5fd9df153 Larry Finger       2011-08-25  902  static int rtllib_rx_check_duplicate(struct rtllib_device *ieee,
49aab5fd9df153 Larry Finger       2011-08-25  903  				     struct sk_buff *skb, u8 multicast)
94a799425eee82 Larry Finger       2011-08-23  904  {
94a799425eee82 Larry Finger       2011-08-23  905  	struct rtllib_hdr_4addr *hdr = (struct rtllib_hdr_4addr *)skb->data;
94a799425eee82 Larry Finger       2011-08-23  906  	u16 fc, sc;
ffed9955529a37 Philipp Hortmann   2023-09-09  907  	u8 frag;
94a799425eee82 Larry Finger       2011-08-23  908  
94a799425eee82 Larry Finger       2011-08-23  909  	sc = le16_to_cpu(hdr->seq_ctl);
94a799425eee82 Larry Finger       2011-08-23  910  	frag = WLAN_GET_SEQ_FRAG(sc);
94a799425eee82 Larry Finger       2011-08-23  911  
ccdbe14b77a5e3 Philipp Hortmann   2022-11-13  912  	if (!ieee->ht_info->cur_rx_reorder_enable ||
94a799425eee82 Larry Finger       2011-08-23  913  		!ieee->current_network.qos_data.active ||
94a799425eee82 Larry Finger       2011-08-23  914  		!IsDataFrame(skb->data) ||
94a799425eee82 Larry Finger       2011-08-23  915  		IsLegacyDataFrame(skb->data)) {
ffed9955529a37 Philipp Hortmann   2023-09-09  916  		if (!ieee80211_is_beacon(hdr->frame_ctl)) {
db8971b618ed96 Larry Finger       2011-08-25  917  			if (is_duplicate_packet(ieee, hdr))
94a799425eee82 Larry Finger       2011-08-23  918  				return -1;
94a799425eee82 Larry Finger       2011-08-23  919  		}
94a799425eee82 Larry Finger       2011-08-23  920  	} else {
2c47ae282a4bba Larry Finger       2011-07-18  921  		struct rx_ts_record *pRxTS = NULL;
3a6b70c3f3558a Matthew Casey      2014-08-22  922  
74724de1c40192 Larry Finger       2011-07-18  923  		if (GetTs(ieee, (struct ts_common_info **)&pRxTS, hdr->addr2,
94a799425eee82 Larry Finger       2011-08-23  924  			(u8)Frame_QoSTID((u8 *)(skb->data)), RX_DIR, true)) {
3b32b210c0717d William Durand     2021-03-01 @925  			if ((fc & (1 << 11)) && (frag == pRxTS->rx_last_frag_num) &&
6d852649821da7 William Durand     2021-03-01  926  			    (WLAN_GET_SEQ_SEQ(sc) == pRxTS->rx_last_seq_num))
94a799425eee82 Larry Finger       2011-08-23  927  				return -1;
3b32b210c0717d William Durand     2021-03-01  928  			pRxTS->rx_last_frag_num = frag;
6d852649821da7 William Durand     2021-03-01  929  			pRxTS->rx_last_seq_num = WLAN_GET_SEQ_SEQ(sc);
94a799425eee82 Larry Finger       2011-08-23  930  		} else {
11e672c3e2d2a1 Mateusz Kulikowski 2015-05-31  931  			netdev_warn(ieee->dev, "%s(): No TS! Skip the check!\n",
11e672c3e2d2a1 Mateusz Kulikowski 2015-05-31  932  				    __func__);
94a799425eee82 Larry Finger       2011-08-23  933  			return -1;
94a799425eee82 Larry Finger       2011-08-23  934  		}
94a799425eee82 Larry Finger       2011-08-23  935  	}
94a799425eee82 Larry Finger       2011-08-23  936  
94a799425eee82 Larry Finger       2011-08-23  937  	return 0;
94a799425eee82 Larry Finger       2011-08-23  938  }
db8971b618ed96 Larry Finger       2011-08-25  939  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
