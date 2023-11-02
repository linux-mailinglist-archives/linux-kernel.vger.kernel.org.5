Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E947DEF21
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 10:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjKBJoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 05:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjKBJoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 05:44:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E33A6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 02:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698918250; x=1730454250;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ea9GVZRCrBex27NSc5HZBiLih1raUbhEfW1msJzzVrg=;
  b=NWA/w0oEqDDXwCAO9ia7Ashj1GSPVhiNCROLIrKNzU5Gv5KsLOnZylsc
   lWgC9+h8Az4bpGfAwF5LgJmtNiCN/CDrRIXgZNcVbgcaRC1QCjRkBeFK4
   S3vxFT+1eW3M4Vva89ztrFvHVTJv5kGIJ6Zu1yQa2unJlpsFWh68Tuh+O
   GM9+Z/lANweHKL56KsohXVDh5kmAgYM61Oj4umK7aBtwId8Z3QNHl2aDD
   Hw56ZeU8+i56wIF8qaxQgGR8cnbdHnfym5huVbafPJw+RjNmhZWF4NsCl
   NSuUpPgosOsjZIvUBGen7Mz73pTACdfzC9y1I+0dvyPk9rS63y/UjmWEO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="10204057"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="10204057"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 02:44:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="2378167"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 02 Nov 2023 02:44:09 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyUFC-0001LL-0O;
        Thu, 02 Nov 2023 09:44:06 +0000
Date:   Thu, 2 Nov 2023 17:43:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chuyi Zhou <zhouchuyi@bytedance.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: kernel/bpf/cgroup_iter.c:336:41: warning: no previous declaration
 for 'bpf_iter_css_next'
Message-ID: <202311021749.8NSp1DM4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   21e80f3841c01aeaf32d7aee7bbc87b3db1aa0c6
commit: 7251d0905e7518bcb990c8e9a3615b1bb23c78f2 bpf: Introduce css open-coded iterator kfuncs
date:   13 days ago
config: i386-randconfig-141-20231102 (https://download.01.org/0day-ci/archive/20231102/202311021749.8NSp1DM4-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231102/202311021749.8NSp1DM4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311021749.8NSp1DM4-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/bpf/cgroup_iter.c:312:17: warning: no previous declaration for 'bpf_iter_css_new' [-Wmissing-declarations]
    __bpf_kfunc int bpf_iter_css_new(struct bpf_iter_css *it,
                    ^~~~~~~~~~~~~~~~
>> kernel/bpf/cgroup_iter.c:336:41: warning: no previous declaration for 'bpf_iter_css_next' [-Wmissing-declarations]
    __bpf_kfunc struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css *it)
                                            ^~~~~~~~~~~~~~~~~
>> kernel/bpf/cgroup_iter.c:357:18: warning: no previous declaration for 'bpf_iter_css_destroy' [-Wmissing-declarations]
    __bpf_kfunc void bpf_iter_css_destroy(struct bpf_iter_css *it)
                     ^~~~~~~~~~~~~~~~~~~~


vim +/bpf_iter_css_next +336 kernel/bpf/cgroup_iter.c

   335	
 > 336	__bpf_kfunc struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css *it)
   337	{
   338		struct bpf_iter_css_kern *kit = (void *)it;
   339	
   340		if (!kit->start)
   341			return NULL;
   342	
   343		switch (kit->flags) {
   344		case BPF_CGROUP_ITER_DESCENDANTS_PRE:
   345			kit->pos = css_next_descendant_pre(kit->pos, kit->start);
   346			break;
   347		case BPF_CGROUP_ITER_DESCENDANTS_POST:
   348			kit->pos = css_next_descendant_post(kit->pos, kit->start);
   349			break;
   350		case BPF_CGROUP_ITER_ANCESTORS_UP:
   351			kit->pos = kit->pos ? kit->pos->parent : kit->start;
   352		}
   353	
   354		return kit->pos;
   355	}
   356	
 > 357	__bpf_kfunc void bpf_iter_css_destroy(struct bpf_iter_css *it)
   358	{
   359	}
   360	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
