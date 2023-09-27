Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193F37B0EDF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 00:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjI0WY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 18:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjI0WY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 18:24:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6A5102
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 15:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695853496; x=1727389496;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YjzeHyPShG7lZPDisNoxrMDErNZBhE6NBcHAI+ZvocM=;
  b=DOmG7bophElbos+RR/eT1hLdhLdQMXr4TgJKLN6twRQesJ0/iyeeCr3r
   bx3OQQnxtlSFdRYfp1ZewxYtERSnnDOX6OiIfh+4j7mjf81jVURpWGS90
   mw2JgYsS7ULY+ElIdJWjhkWr+vFDc33d6scpgKeTuRVN8N2ZBL/EW+8tz
   WwmG+LcCSedroTVylSE5a0+YhIbke9Igt+kg9ql9KJf7jW8oA8XVAPIlQ
   js1wN02cDfHgPvvzssoSey9V8axAgyR/eg9yrV/WxMjtnd02HcrgOyYPE
   zUQHg2uDbjiS1kMgtbI4VrdchToyrjtA/s/5SNSOVSxTmyDj9TtxvyIrq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="385804035"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="385804035"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 15:24:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="784471831"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="784471831"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 27 Sep 2023 15:24:54 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qlcxf-0000jF-2w;
        Wed, 27 Sep 2023 22:24:51 +0000
Date:   Thu, 28 Sep 2023 06:23:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: drivers/md/dm-cache-metadata.c:1705:9: warning: 'strncpy' specified
 bound 16 equals destination size
Message-ID: <202309280610.sLGSPkOG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   633b47cb009d09dc8f4ba9cdb3a0ca138809c7c7
commit: 23066c3f4e2146da8c7d1505729f4409f4d93d28 Compiler Attributes: enable -Wstringop-truncation on W=1 (gcc >= 8)
date:   5 years ago
config: arm-randconfig-002-20230928 (https://download.01.org/0day-ci/archive/20230928/202309280610.sLGSPkOG-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230928/202309280610.sLGSPkOG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309280610.sLGSPkOG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In function 'write_hints',
       inlined from 'dm_cache_write_hints' at drivers/md/dm-cache-metadata.c:1729:6:
>> drivers/md/dm-cache-metadata.c:1705:9: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]
    1705 |         strncpy(cmd->policy_name, policy_name, sizeof(cmd->policy_name));
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/strncpy +1705 drivers/md/dm-cache-metadata.c

4e781b498ee500 Joe Thornber 2016-09-15  1689  
4e781b498ee500 Joe Thornber 2016-09-15  1690  /*
4e781b498ee500 Joe Thornber 2016-09-15  1691   * It's quicker to always delete the hint array, and recreate with
4e781b498ee500 Joe Thornber 2016-09-15  1692   * dm_array_new().
4e781b498ee500 Joe Thornber 2016-09-15  1693   */
4e781b498ee500 Joe Thornber 2016-09-15  1694  static int write_hints(struct dm_cache_metadata *cmd, struct dm_cache_policy *policy)
c6b4fcbad044e6 Joe Thornber 2013-03-01  1695  {
c6b4fcbad044e6 Joe Thornber 2013-03-01  1696  	int r;
c6b4fcbad044e6 Joe Thornber 2013-03-01  1697  	size_t hint_size;
c6b4fcbad044e6 Joe Thornber 2013-03-01  1698  	const char *policy_name = dm_cache_policy_get_name(policy);
4e7f506f642963 Mike Snitzer 2013-03-20  1699  	const unsigned *policy_version = dm_cache_policy_get_version(policy);
c6b4fcbad044e6 Joe Thornber 2013-03-01  1700  
c6b4fcbad044e6 Joe Thornber 2013-03-01  1701  	if (!policy_name[0] ||
c6b4fcbad044e6 Joe Thornber 2013-03-01  1702  	    (strlen(policy_name) > sizeof(cmd->policy_name) - 1))
c6b4fcbad044e6 Joe Thornber 2013-03-01  1703  		return -EINVAL;
c6b4fcbad044e6 Joe Thornber 2013-03-01  1704  
c6b4fcbad044e6 Joe Thornber 2013-03-01 @1705  	strncpy(cmd->policy_name, policy_name, sizeof(cmd->policy_name));
4e7f506f642963 Mike Snitzer 2013-03-20  1706  	memcpy(cmd->policy_version, policy_version, sizeof(cmd->policy_version));
c6b4fcbad044e6 Joe Thornber 2013-03-01  1707  
c6b4fcbad044e6 Joe Thornber 2013-03-01  1708  	hint_size = dm_cache_policy_get_hint_size(policy);
c6b4fcbad044e6 Joe Thornber 2013-03-01  1709  	if (!hint_size)
c6b4fcbad044e6 Joe Thornber 2013-03-01  1710  		return 0; /* short-circuit hints initialization */
c6b4fcbad044e6 Joe Thornber 2013-03-01  1711  	cmd->policy_hint_size = hint_size;
c6b4fcbad044e6 Joe Thornber 2013-03-01  1712  
c6b4fcbad044e6 Joe Thornber 2013-03-01  1713  	if (cmd->hint_root) {
c6b4fcbad044e6 Joe Thornber 2013-03-01  1714  		r = dm_array_del(&cmd->hint_info, cmd->hint_root);
c6b4fcbad044e6 Joe Thornber 2013-03-01  1715  		if (r)
c6b4fcbad044e6 Joe Thornber 2013-03-01  1716  			return r;
c6b4fcbad044e6 Joe Thornber 2013-03-01  1717  	}
c6b4fcbad044e6 Joe Thornber 2013-03-01  1718  
4e781b498ee500 Joe Thornber 2016-09-15  1719  	return dm_array_new(&cmd->hint_info, &cmd->hint_root,
c6b4fcbad044e6 Joe Thornber 2013-03-01  1720  			    from_cblock(cmd->cache_blocks),
4e781b498ee500 Joe Thornber 2016-09-15  1721  			    get_hint, policy);
0596661f0a16d9 Joe Thornber 2014-04-03  1722  }
0596661f0a16d9 Joe Thornber 2014-04-03  1723  

:::::: The code at line 1705 was first introduced by commit
:::::: c6b4fcbad044e6fffcc75bba160e720eb8d67d17 dm: add cache target

:::::: TO: Joe Thornber <ejt@redhat.com>
:::::: CC: Alasdair G Kergon <agk@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
