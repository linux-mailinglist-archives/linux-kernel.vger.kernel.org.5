Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B601E7CC31B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbjJQM0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbjJQMZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:25:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39ACD13A
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697545555; x=1729081555;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iucYjIIqzqA1Wm7baiOzI1aZ+TJNHOMMwwQ51enpVhU=;
  b=UNPbaF/+AZS4w+cD98QcPVXxiIHX9ZBjD+z1bxqb9lNghKg6vRhZRwcL
   /sXi+6JZ9wJFttFLI+k++k7Pwm/lgCT2dPhkWD7qu4f/8ND3EK14vbVQg
   I4ZNvGXSMK/eHkP9eB9rwsIsHTGiTRvrtkFf6KP1HNuk6xTyvgo016SF1
   1Fq/9q+TZEwlaGTiBdmHFGKL9SPwN2suDrjirelJ5IPu6KbRgeFt22nUx
   1UdGr0q6Vl37kRhYvow5qiiOB4b0WJmNwz25VxCqBls38srQYJLnRoCp4
   tU+nOGt5uPUkWCXLwDAuhx7vITwLMPPQVRq5PnYJGC/psMOW17JhCHWqp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="416854118"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="416854118"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 05:25:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="846804680"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="846804680"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Oct 2023 05:25:53 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsj8w-0009aB-2N;
        Tue, 17 Oct 2023 12:25:50 +0000
Date:   Tue, 17 Oct 2023 20:25:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: kernel/user_namespace.c:239: warning: Function parameter or member
 'map_up' not described in 'idmap_key'
Message-ID: <202310172019.KFiYMz7T-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   213f891525c222e8ed145ce1ce7ae1f47921cb9c
commit: e227db4d4f125efb1cae2f1337da85bc10b3185e userns: fix a struct's kernel-doc notation
date:   9 months ago
config: x86_64-buildonly-randconfig-001-20231012 (https://download.01.org/0day-ci/archive/20231017/202310172019.KFiYMz7T-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231017/202310172019.KFiYMz7T-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310172019.KFiYMz7T-lkp@intel.com/

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

5c1469de7545a35 Eric W. Biederman 2010-06-13  230  
6397fac4915ab30 Christian Brauner 2017-10-25  231  /**
e227db4d4f125ef Randy Dunlap      2023-01-07  232   * struct idmap_key - holds the information necessary to find an idmapping in a
6397fac4915ab30 Christian Brauner 2017-10-25  233   * sorted idmap array. It is passed to cmp_map_id() as first argument.
6397fac4915ab30 Christian Brauner 2017-10-25  234   */
6397fac4915ab30 Christian Brauner 2017-10-25  235  struct idmap_key {
6397fac4915ab30 Christian Brauner 2017-10-25  236  	bool map_up; /* true  -> id from kid; false -> kid from id */
6397fac4915ab30 Christian Brauner 2017-10-25  237  	u32 id; /* id to find */
6397fac4915ab30 Christian Brauner 2017-10-25  238  	u32 count; /* == 0 unless used with map_id_range_down() */
6397fac4915ab30 Christian Brauner 2017-10-25 @239  };
6397fac4915ab30 Christian Brauner 2017-10-25  240  

:::::: The code at line 239 was first introduced by commit
:::::: 6397fac4915ab3002dc15aae751455da1a852f25 userns: bump idmap limits to 340

:::::: TO: Christian Brauner <christian.brauner@ubuntu.com>
:::::: CC: Eric W. Biederman <ebiederm@xmission.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
