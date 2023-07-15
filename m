Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B07754C3E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 23:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjGOVtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 17:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjGOVtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 17:49:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D6D1FFC
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 14:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689457748; x=1720993748;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dWbob4Vhsn6kbSP2Xy0DcGFHiJMC4Zqa0BnJAm8qAyU=;
  b=LBcJvUvMHTyRr2G1GuUls4wOcj29qVKaNfdwpVoUQ8p7jDb8Lma8HKXL
   Fa8tCilfGoLe4B16e0DE6w7NUkQLEDsWJbR2wfolXziq7kzDKdKQfYtkm
   KgRAgt+JGOC46S5t8hwFh+gvKGtXntCFWjI8iSaUGbE6MzGmP7I1PBnDo
   uM9Y3qfq/F25jtblLDkI2wecCfe/+Q7DC1QGKn8oHGii3dGGf0r49cYUc
   g14qGCZ0/CyrCmgDrDQ+WJOit0CpBfI5KjIfTxSwHGlatN80avo5uiQSs
   iYnoG5Vlt6G+r5X80eIl4yhwk9Lk9KvCTn8J4Xy1BBogqC/8twOT6OHHC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10772"; a="350569831"
X-IronPort-AV: E=Sophos;i="6.01,209,1684825200"; 
   d="scan'208";a="350569831"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2023 14:49:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10772"; a="969386258"
X-IronPort-AV: E=Sophos;i="6.01,209,1684825200"; 
   d="scan'208";a="969386258"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 15 Jul 2023 14:49:07 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qKn8U-0008Ne-0M;
        Sat, 15 Jul 2023 21:49:06 +0000
Date:   Sun, 16 Jul 2023 05:48:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: net/mac80211/rx.c:4062:13: warning: stack frame size (10656) exceeds
 limit (8192) in 'ieee80211_rx_handlers'
Message-ID: <202307160536.eNpCzzGh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   831fe284d8275987596b7d640518dddba5735f61
commit: baa951a1c1771810f3a378a95fc93e81953027d5 mac80211: use the new drop reasons infrastructure
date:   3 months ago
config: riscv-randconfig-r021-20230716 (https://download.01.org/0day-ci/archive/20230716/202307160536.eNpCzzGh-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce: (https://download.01.org/0day-ci/archive/20230716/202307160536.eNpCzzGh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307160536.eNpCzzGh-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/mac80211/rx.c:4062:13: warning: stack frame size (10656) exceeds limit (8192) in 'ieee80211_rx_handlers' [-Wframe-larger-than]
   static void ieee80211_rx_handlers(struct ieee80211_rx_data *rx,
               ^
   1 warning generated.


vim +/ieee80211_rx_handlers +4062 net/mac80211/rx.c

aa0c86364f925c Christian Lamparter 2010-08-05  4061  
f9e124fbd8cbea Christian Lamparter 2013-02-04 @4062  static void ieee80211_rx_handlers(struct ieee80211_rx_data *rx,
f9e124fbd8cbea Christian Lamparter 2013-02-04  4063  				  struct sk_buff_head *frames)
aa0c86364f925c Christian Lamparter 2010-08-05  4064  {
aa0c86364f925c Christian Lamparter 2010-08-05  4065  	ieee80211_rx_result res = RX_DROP_MONITOR;
aa0c86364f925c Christian Lamparter 2010-08-05  4066  	struct sk_buff *skb;
8944b79fe9b1fe Johannes Berg       2008-01-31  4067  

:::::: The code at line 4062 was first introduced by commit
:::::: f9e124fbd8cbea974b5dc7e9dafddd17d21df7e2 mac80211: protect rx-path with spinlock

:::::: TO: Christian Lamparter <chunkeey@googlemail.com>
:::::: CC: Johannes Berg <johannes.berg@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
