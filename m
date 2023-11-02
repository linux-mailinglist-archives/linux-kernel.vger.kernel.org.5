Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8B27DFC20
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 22:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377419AbjKBV7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 17:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKBV7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 17:59:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9076138
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 14:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698962339; x=1730498339;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pTweSs+CtYSdFVIrWwDAcAIizDXQHaAHL19W7wedEmI=;
  b=NArPVFvB0ZPVYSDxL9LL6rka4S4wo5nHx/A78cL/sRbRgpHoBQiPMz16
   P2+zKtxmGW9R9wFzaqw9DjGf5OHj68bckC+c8LRH65MULU/RHOTIPoXZQ
   7cfYtQMU1sUOFhFXUw4f3qC1y//+dKq3cIscO5Roj1uQzjUrFZ2lYRtEp
   Cj8QBRomPz2tVNw8QG3xBO1Yk3JdEil8yhy518IYjgR4N5p6dpC1mrZ05
   wxVBUhLSF7toCuUm5X+9Aj6olp2nAVlm+kG/SQZIcyYY4pRtb/Yuq1EG4
   OYDt3GEEeMBq1tzbEsRwKJ9sTVavaUV0UsM3hGErJ/59v2rs/6jG2jEJv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="475067717"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="475067717"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 14:58:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="1008609511"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="1008609511"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 02 Nov 2023 14:58:58 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyfiJ-0001to-2p;
        Thu, 02 Nov 2023 21:58:55 +0000
Date:   Fri, 3 Nov 2023 05:58:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florent Revest <revest@chromium.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: kernel/trace/ftrace.c:5417: warning: Function parameter or member
 'addr' not described in 'unregister_ftrace_direct'
Message-ID: <202311030542.ii73MaGe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florent,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4652b8e4f3ffa48c706ec334f048c217a7d9750d
commit: da8bdfbd422333fbb7c85ac1d7f18592d17d6665 ftrace: Rename _ftrace_direct_multi APIs to _ftrace_direct APIs
date:   8 months ago
config: s390-defconfig (https://download.01.org/0day-ci/archive/20231103/202311030542.ii73MaGe-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231103/202311030542.ii73MaGe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311030542.ii73MaGe-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/trace/ftrace.c:1283: warning: Function parameter or member 'ops' not described in 'ftrace_free_filter'
>> kernel/trace/ftrace.c:5417: warning: Function parameter or member 'addr' not described in 'unregister_ftrace_direct'
>> kernel/trace/ftrace.c:5417: warning: Function parameter or member 'free_filters' not described in 'unregister_ftrace_direct'
   kernel/trace/ftrace.c:5565: warning: Function parameter or member 'ops' not described in 'ftrace_set_filter_ip'
   kernel/trace/ftrace.c:5565: warning: Function parameter or member 'ip' not described in 'ftrace_set_filter_ip'
   kernel/trace/ftrace.c:5565: warning: Function parameter or member 'remove' not described in 'ftrace_set_filter_ip'
   kernel/trace/ftrace.c:5565: warning: Function parameter or member 'reset' not described in 'ftrace_set_filter_ip'
   kernel/trace/ftrace.c:5588: warning: Function parameter or member 'ops' not described in 'ftrace_set_filter_ips'
   kernel/trace/ftrace.c:5588: warning: Function parameter or member 'ips' not described in 'ftrace_set_filter_ips'
   kernel/trace/ftrace.c:5588: warning: Function parameter or member 'cnt' not described in 'ftrace_set_filter_ips'
   kernel/trace/ftrace.c:5588: warning: Function parameter or member 'remove' not described in 'ftrace_set_filter_ips'
   kernel/trace/ftrace.c:5588: warning: Function parameter or member 'reset' not described in 'ftrace_set_filter_ips'
   kernel/trace/ftrace.c:5602: warning: Function parameter or member 'ops' not described in 'ftrace_ops_set_global_filter'
   kernel/trace/ftrace.c:5634: warning: Function parameter or member 'ops' not described in 'ftrace_set_filter'
   kernel/trace/ftrace.c:5634: warning: Function parameter or member 'buf' not described in 'ftrace_set_filter'
   kernel/trace/ftrace.c:5634: warning: Function parameter or member 'len' not described in 'ftrace_set_filter'
   kernel/trace/ftrace.c:5634: warning: Function parameter or member 'reset' not described in 'ftrace_set_filter'
   kernel/trace/ftrace.c:5657: warning: Function parameter or member 'ops' not described in 'ftrace_set_notrace'
   kernel/trace/ftrace.c:5657: warning: Function parameter or member 'buf' not described in 'ftrace_set_notrace'
   kernel/trace/ftrace.c:5657: warning: Function parameter or member 'len' not described in 'ftrace_set_notrace'
   kernel/trace/ftrace.c:5657: warning: Function parameter or member 'reset' not described in 'ftrace_set_notrace'
   kernel/trace/ftrace.c:5672: warning: Function parameter or member 'buf' not described in 'ftrace_set_global_filter'
   kernel/trace/ftrace.c:5672: warning: Function parameter or member 'len' not described in 'ftrace_set_global_filter'
   kernel/trace/ftrace.c:5672: warning: Function parameter or member 'reset' not described in 'ftrace_set_global_filter'
   kernel/trace/ftrace.c:5688: warning: Function parameter or member 'buf' not described in 'ftrace_set_global_notrace'
   kernel/trace/ftrace.c:5688: warning: Function parameter or member 'len' not described in 'ftrace_set_global_notrace'
   kernel/trace/ftrace.c:5688: warning: Function parameter or member 'reset' not described in 'ftrace_set_global_notrace'


vim +5417 kernel/trace/ftrace.c

f64dd4627ec6edc Jiri Olsa      2021-10-08  5401  
f64dd4627ec6edc Jiri Olsa      2021-10-08  5402  /**
da8bdfbd422333f Florent Revest 2023-03-21  5403   * unregister_ftrace_direct - Remove calls to custom trampoline
da8bdfbd422333f Florent Revest 2023-03-21  5404   * previously registered by register_ftrace_direct for @ops object.
f64dd4627ec6edc Jiri Olsa      2021-10-08  5405   * @ops: The address of the struct ftrace_ops object
f64dd4627ec6edc Jiri Olsa      2021-10-08  5406   *
f64dd4627ec6edc Jiri Olsa      2021-10-08  5407   * This is used to remove a direct calls to @addr from the nop locations
f64dd4627ec6edc Jiri Olsa      2021-10-08  5408   * of the functions registered in @ops (with by ftrace_set_filter_ip
f64dd4627ec6edc Jiri Olsa      2021-10-08  5409   * function).
f64dd4627ec6edc Jiri Olsa      2021-10-08  5410   *
f64dd4627ec6edc Jiri Olsa      2021-10-08  5411   * Returns:
f64dd4627ec6edc Jiri Olsa      2021-10-08  5412   *  0 on success
f64dd4627ec6edc Jiri Olsa      2021-10-08  5413   *  -EINVAL - The @ops object was not properly registered.
f64dd4627ec6edc Jiri Olsa      2021-10-08  5414   */
da8bdfbd422333f Florent Revest 2023-03-21  5415  int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr,
59495740f79524b Florent Revest 2023-03-21  5416  			     bool free_filters)
f64dd4627ec6edc Jiri Olsa      2021-10-08 @5417  {
f64dd4627ec6edc Jiri Olsa      2021-10-08  5418  	struct ftrace_hash *hash = ops->func_hash->filter_hash;
f64dd4627ec6edc Jiri Olsa      2021-10-08  5419  	int err;
f64dd4627ec6edc Jiri Olsa      2021-10-08  5420  
f64dd4627ec6edc Jiri Olsa      2021-10-08  5421  	if (check_direct_multi(ops))
f64dd4627ec6edc Jiri Olsa      2021-10-08  5422  		return -EINVAL;
f64dd4627ec6edc Jiri Olsa      2021-10-08  5423  	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
f64dd4627ec6edc Jiri Olsa      2021-10-08  5424  		return -EINVAL;
f64dd4627ec6edc Jiri Olsa      2021-10-08  5425  
f64dd4627ec6edc Jiri Olsa      2021-10-08  5426  	mutex_lock(&direct_mutex);
f64dd4627ec6edc Jiri Olsa      2021-10-08  5427  	err = unregister_ftrace_function(ops);
f64dd4627ec6edc Jiri Olsa      2021-10-08  5428  	remove_direct_functions_hash(hash, addr);
f64dd4627ec6edc Jiri Olsa      2021-10-08  5429  	mutex_unlock(&direct_mutex);
fea3ffa48c6d42a Jiri Olsa      2021-12-06  5430  
fea3ffa48c6d42a Jiri Olsa      2021-12-06  5431  	/* cleanup for possible another register call */
fea3ffa48c6d42a Jiri Olsa      2021-12-06  5432  	ops->func = NULL;
fea3ffa48c6d42a Jiri Olsa      2021-12-06  5433  	ops->trampoline = 0;
59495740f79524b Florent Revest 2023-03-21  5434  
59495740f79524b Florent Revest 2023-03-21  5435  	if (free_filters)
59495740f79524b Florent Revest 2023-03-21  5436  		ftrace_free_filter(ops);
f64dd4627ec6edc Jiri Olsa      2021-10-08  5437  	return err;
f64dd4627ec6edc Jiri Olsa      2021-10-08  5438  }
da8bdfbd422333f Florent Revest 2023-03-21  5439  EXPORT_SYMBOL_GPL(unregister_ftrace_direct);
ccf5a89efd6f0a9 Jiri Olsa      2021-10-08  5440  

:::::: The code at line 5417 was first introduced by commit
:::::: f64dd4627ec6edc39bf1430fe6dbc923d2300a88 ftrace: Add multi direct register/unregister interface

:::::: TO: Jiri Olsa <jolsa@redhat.com>
:::::: CC: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
