Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5DF77F6F2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351014AbjHQM5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351008AbjHQM4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:56:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F932D5F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692277005; x=1723813005;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=un1/FGje3nkweq9S6E3sAc/wBe4HMtaj6LBemeqLbpk=;
  b=bFvoaD3Qs6fkJlEXi6JNqfliMTTgJ/q+cAM1D0Jy3V665ZQ3yACql5hU
   yubZ97y3Lx3AR3c0u0wHwdTgp52pIMVjbbVpECzNj+jYfRyUt+14yprE7
   LFR7jqDir0HIjnQf6958scVSDhKLGVo1W5tr2Ul5mbUNhFzf8BlxeNBUk
   WCYL58A7dz/8fYFFR8dZufnh7YNdju3ZMo6hKCw5gi87T17lZAnw0ruGY
   sTb68WZ12/xRm4yuHlKF2Yded37qa1vIpzTQ2MJh7IvlHf9nCLEOfNmeW
   ZQd4DAsE/lh6c2c+vP7I3j0AwXDBhZYxr+njVeH+e1f07bhJsrmz2z7SS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="370269217"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="370269217"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 05:56:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="764069137"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="764069137"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 17 Aug 2023 05:56:39 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWcYH-000195-0u;
        Thu, 17 Aug 2023 12:56:37 +0000
Date:   Thu, 17 Aug 2023 20:56:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: kernel/user_namespace.c:239: warning: Function parameter or member
 'map_up' not described in 'idmap_key'
Message-ID: <202308172003.O1QB7TgB-lkp@intel.com>
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
head:   4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
commit: e227db4d4f125efb1cae2f1337da85bc10b3185e userns: fix a struct's kernel-doc notation
date:   7 months ago
config: parisc64-defconfig (https://download.01.org/0day-ci/archive/20230817/202308172003.O1QB7TgB-lkp@intel.com/config)
compiler: hppa64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308172003.O1QB7TgB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308172003.O1QB7TgB-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/user_namespace.c:239: warning: Function parameter or member 'map_up' not described in 'idmap_key'
>> kernel/user_namespace.c:239: warning: Function parameter or member 'id' not described in 'idmap_key'
>> kernel/user_namespace.c:239: warning: Function parameter or member 'count' not described in 'idmap_key'
   kernel/user_namespace.c:246: warning: Function parameter or member 'k' not described in 'cmp_map_id'
   kernel/user_namespace.c:246: warning: Function parameter or member 'e' not described in 'cmp_map_id'
   kernel/user_namespace.c:277: warning: Function parameter or member 'extents' not described in 'map_id_range_down_max'
   kernel/user_namespace.c:277: warning: Function parameter or member 'map' not described in 'map_id_range_down_max'
   kernel/user_namespace.c:277: warning: Function parameter or member 'id' not described in 'map_id_range_down_max'
   kernel/user_namespace.c:277: warning: Function parameter or member 'count' not described in 'map_id_range_down_max'
   kernel/user_namespace.c:295: warning: Function parameter or member 'extents' not described in 'map_id_range_down_base'
   kernel/user_namespace.c:295: warning: Function parameter or member 'map' not described in 'map_id_range_down_base'
   kernel/user_namespace.c:295: warning: Function parameter or member 'id' not described in 'map_id_range_down_base'
   kernel/user_namespace.c:295: warning: Function parameter or member 'count' not described in 'map_id_range_down_base'
   kernel/user_namespace.c:344: warning: Function parameter or member 'extents' not described in 'map_id_up_base'
   kernel/user_namespace.c:344: warning: Function parameter or member 'map' not described in 'map_id_up_base'
   kernel/user_namespace.c:344: warning: Function parameter or member 'id' not described in 'map_id_up_base'
   kernel/user_namespace.c:364: warning: Function parameter or member 'extents' not described in 'map_id_up_max'
   kernel/user_namespace.c:364: warning: Function parameter or member 'map' not described in 'map_id_up_max'
   kernel/user_namespace.c:364: warning: Function parameter or member 'id' not described in 'map_id_up_max'
   kernel/user_namespace.c:776: warning: Function parameter or member 'map' not described in 'insert_extent'
   kernel/user_namespace.c:776: warning: Function parameter or member 'extent' not described in 'insert_extent'
   kernel/user_namespace.c:844: warning: Function parameter or member 'map' not described in 'sort_idmaps'


vim +239 kernel/user_namespace.c

5c1469de7545a3 Eric W. Biederman 2010-06-13  230  
6397fac4915ab3 Christian Brauner 2017-10-25  231  /**
e227db4d4f125e Randy Dunlap      2023-01-07  232   * struct idmap_key - holds the information necessary to find an idmapping in a
6397fac4915ab3 Christian Brauner 2017-10-25  233   * sorted idmap array. It is passed to cmp_map_id() as first argument.
6397fac4915ab3 Christian Brauner 2017-10-25  234   */
6397fac4915ab3 Christian Brauner 2017-10-25  235  struct idmap_key {
6397fac4915ab3 Christian Brauner 2017-10-25  236  	bool map_up; /* true  -> id from kid; false -> kid from id */
6397fac4915ab3 Christian Brauner 2017-10-25  237  	u32 id; /* id to find */
6397fac4915ab3 Christian Brauner 2017-10-25  238  	u32 count; /* == 0 unless used with map_id_range_down() */
6397fac4915ab3 Christian Brauner 2017-10-25 @239  };
6397fac4915ab3 Christian Brauner 2017-10-25  240  

:::::: The code at line 239 was first introduced by commit
:::::: 6397fac4915ab3002dc15aae751455da1a852f25 userns: bump idmap limits to 340

:::::: TO: Christian Brauner <christian.brauner@ubuntu.com>
:::::: CC: Eric W. Biederman <ebiederm@xmission.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
