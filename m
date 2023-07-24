Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E3975E60B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjGXBOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjGXBN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:13:59 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B1BE51
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 18:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690161235; x=1721697235;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9G6LMaW6rLpZXjpQhjDpwld66amXSycu18kSAl94i94=;
  b=eJhyzPAuDHHgohMrka6i/ko3AF2V5BV0s5Yn9sMYuqmmDsA3njOXqQpk
   Eai65XhNRygtd4VCg3tj8WkPVXld1/BEyaMDMorrlyPrS2Po23B1FhlSe
   DQefGXEyjqA+Q4uZtLD/LM6GJokbiWikJHtFkD3Y6uchCH2f4xEr61SeO
   xwSNmZazeGz2+19ZBylUpZPa1FkWCdREpL6jUBGp+6KObGT0q7qv4//8p
   o2m/0BWyXHxNlm6igTPN6pCBUtck7XvUUb6kdxP36TrZ8wv7fkgtZzZld
   QgfmvqYVurCh3oiFCXUW2y4GDz13tlGbTst6n2WV25aIMqM25gA34WuRB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="352219098"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="352219098"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2023 18:13:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="725521257"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="725521257"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 23 Jul 2023 18:13:53 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qNk92-0009NV-30;
        Mon, 24 Jul 2023 01:13:52 +0000
Date:   Mon, 24 Jul 2023 09:13:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: net/mac80211/util.c:2507:5: warning: stack frame size (2096) exceeds
 limit (2048) in 'ieee80211_reconfig'
Message-ID: <202307240925.c84SraKs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6eaae198076080886b9e7d57f4ae06fa782f90ef
commit: 61403414e1719f929386dda8fb954bb302628ef3 wifi: mac80211: implement proper AP MLD HW restart
date:   7 weeks ago
config: riscv-randconfig-r042-20230724 (https://download.01.org/0day-ci/archive/20230724/202307240925.c84SraKs-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230724/202307240925.c84SraKs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307240925.c84SraKs-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/mac80211/util.c:995:1: warning: stack frame size (2672) exceeds limit (2048) in '_ieee802_11_parse_elems_full' [-Wframe-larger-than]
     995 | _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
         | ^
>> net/mac80211/util.c:2507:5: warning: stack frame size (2096) exceeds limit (2048) in 'ieee80211_reconfig' [-Wframe-larger-than]
    2507 | int ieee80211_reconfig(struct ieee80211_local *local)
         |     ^
   2 warnings generated.


vim +/ieee80211_reconfig +2507 net/mac80211/util.c

61403414e1719f Johannes Berg        2023-05-04  2506  
f2753ddbadb087 Johannes Berg        2009-04-14 @2507  int ieee80211_reconfig(struct ieee80211_local *local)
f2753ddbadb087 Johannes Berg        2009-04-14  2508  {
f2753ddbadb087 Johannes Berg        2009-04-14  2509  	struct ieee80211_hw *hw = &local->hw;
f2753ddbadb087 Johannes Berg        2009-04-14  2510  	struct ieee80211_sub_if_data *sdata;
55de908ab292c0 Johannes Berg        2012-07-26  2511  	struct ieee80211_chanctx *ctx;
f2753ddbadb087 Johannes Berg        2009-04-14  2512  	struct sta_info *sta;
2683d65bb016a0 Eliad Peller         2011-07-14  2513  	int res, i;
d888130a024d1d Johannes Berg        2013-01-10  2514  	bool reconfig_due_to_wowlan = false;
d43c6b6e6f2fca David Spinadel       2013-12-08  2515  	struct ieee80211_sub_if_data *sched_scan_sdata;
6ea0a69ca21bbd Johannes Berg        2014-11-19  2516  	struct cfg80211_sched_scan_request *sched_scan_req;
d43c6b6e6f2fca David Spinadel       2013-12-08  2517  	bool sched_scan_stopped = false;
b0485e9f3defbe Eliad Peller         2015-07-08  2518  	bool suspended = local->suspended;
7d352ccf1e9935 Youghandhar Chintala 2022-03-08  2519  	bool in_reconfig = false;
d888130a024d1d Johannes Berg        2013-01-10  2520  
0f8b82456178d5 Eliad Peller         2014-12-14  2521  	/* nothing to do if HW shouldn't run */
0f8b82456178d5 Eliad Peller         2014-12-14  2522  	if (!local->open_count)
0f8b82456178d5 Eliad Peller         2014-12-14  2523  		goto wake_up;
0f8b82456178d5 Eliad Peller         2014-12-14  2524  

:::::: The code at line 2507 was first introduced by commit
:::::: f2753ddbadb0873a98421415882318251bbd9eaa mac80211: add hardware restart function

:::::: TO: Johannes Berg <johannes@sipsolutions.net>
:::::: CC: John W. Linville <linville@tuxdriver.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
