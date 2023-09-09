Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D657996A5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 08:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245393AbjIIGq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 02:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbjIIGqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 02:46:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869BB1BF5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 23:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694242009; x=1725778009;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Xn7OE06zqZduM86QXmKVoVAB5OUjU/oj0BbHDr28KEY=;
  b=huRUgIL7dsvgcPbVzxug7jeWxr71mHL6hhDbPmEBbhmUpiT/myqUeU2n
   V7kF0oWHl/rugALzdBVEocN+rdh6AltHqbbgWG/eK+j4ory6KlkH8zE6e
   0fivJUaOrWOtlive8pV44tjO5CpW4rW8WVCpkYa6sCK1mafnd3JvAsMpr
   wXVVpziGuaQ4TxI+9fNIO5lGUAbfUeStvJCUJ2Lc3PdMXtfyLVZommlET
   OubvL1G2ni5XF9LQdoF1nbdrmEW81aNGyrp9F348So0SsVmSrwBKkIn2N
   XTYJcjjhtGDX8Gt8gOE2FMsRYsbAAkzYHy6L030hhtvdTL0y7NRyugYjY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="441809881"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="441809881"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 23:46:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="916420653"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="916420653"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 Sep 2023 23:46:47 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qerjx-00031C-1a;
        Sat, 09 Sep 2023 06:46:45 +0000
Date:   Sat, 9 Sep 2023 14:46:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florent Revest <revest@chromium.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: kernel/trace/ftrace.c:5417: warning: Function parameter or member
 'addr' not described in 'unregister_ftrace_direct'
Message-ID: <202309091444.zCUyz2Ia-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florent,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6099776f9f268e61fe5ecd721f994a8cfce5306f
commit: da8bdfbd422333fbb7c85ac1d7f18592d17d6665 ftrace: Rename _ftrace_direct_multi APIs to _ftrace_direct APIs
date:   6 months ago
config: s390-defconfig (https://download.01.org/0day-ci/archive/20230909/202309091444.zCUyz2Ia-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230909/202309091444.zCUyz2Ia-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309091444.zCUyz2Ia-lkp@intel.com/

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

f64dd4627ec6ed Jiri Olsa      2021-10-08  5401  
f64dd4627ec6ed Jiri Olsa      2021-10-08  5402  /**
da8bdfbd422333 Florent Revest 2023-03-21  5403   * unregister_ftrace_direct - Remove calls to custom trampoline
da8bdfbd422333 Florent Revest 2023-03-21  5404   * previously registered by register_ftrace_direct for @ops object.
f64dd4627ec6ed Jiri Olsa      2021-10-08  5405   * @ops: The address of the struct ftrace_ops object
f64dd4627ec6ed Jiri Olsa      2021-10-08  5406   *
f64dd4627ec6ed Jiri Olsa      2021-10-08  5407   * This is used to remove a direct calls to @addr from the nop locations
f64dd4627ec6ed Jiri Olsa      2021-10-08  5408   * of the functions registered in @ops (with by ftrace_set_filter_ip
f64dd4627ec6ed Jiri Olsa      2021-10-08  5409   * function).
f64dd4627ec6ed Jiri Olsa      2021-10-08  5410   *
f64dd4627ec6ed Jiri Olsa      2021-10-08  5411   * Returns:
f64dd4627ec6ed Jiri Olsa      2021-10-08  5412   *  0 on success
f64dd4627ec6ed Jiri Olsa      2021-10-08  5413   *  -EINVAL - The @ops object was not properly registered.
f64dd4627ec6ed Jiri Olsa      2021-10-08  5414   */
da8bdfbd422333 Florent Revest 2023-03-21  5415  int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr,
59495740f79524 Florent Revest 2023-03-21  5416  			     bool free_filters)
f64dd4627ec6ed Jiri Olsa      2021-10-08 @5417  {
f64dd4627ec6ed Jiri Olsa      2021-10-08  5418  	struct ftrace_hash *hash = ops->func_hash->filter_hash;
f64dd4627ec6ed Jiri Olsa      2021-10-08  5419  	int err;
f64dd4627ec6ed Jiri Olsa      2021-10-08  5420  
f64dd4627ec6ed Jiri Olsa      2021-10-08  5421  	if (check_direct_multi(ops))
f64dd4627ec6ed Jiri Olsa      2021-10-08  5422  		return -EINVAL;
f64dd4627ec6ed Jiri Olsa      2021-10-08  5423  	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
f64dd4627ec6ed Jiri Olsa      2021-10-08  5424  		return -EINVAL;
f64dd4627ec6ed Jiri Olsa      2021-10-08  5425  
f64dd4627ec6ed Jiri Olsa      2021-10-08  5426  	mutex_lock(&direct_mutex);
f64dd4627ec6ed Jiri Olsa      2021-10-08  5427  	err = unregister_ftrace_function(ops);
f64dd4627ec6ed Jiri Olsa      2021-10-08  5428  	remove_direct_functions_hash(hash, addr);
f64dd4627ec6ed Jiri Olsa      2021-10-08  5429  	mutex_unlock(&direct_mutex);
fea3ffa48c6d42 Jiri Olsa      2021-12-06  5430  
fea3ffa48c6d42 Jiri Olsa      2021-12-06  5431  	/* cleanup for possible another register call */
fea3ffa48c6d42 Jiri Olsa      2021-12-06  5432  	ops->func = NULL;
fea3ffa48c6d42 Jiri Olsa      2021-12-06  5433  	ops->trampoline = 0;
59495740f79524 Florent Revest 2023-03-21  5434  
59495740f79524 Florent Revest 2023-03-21  5435  	if (free_filters)
59495740f79524 Florent Revest 2023-03-21  5436  		ftrace_free_filter(ops);
f64dd4627ec6ed Jiri Olsa      2021-10-08  5437  	return err;
f64dd4627ec6ed Jiri Olsa      2021-10-08  5438  }
da8bdfbd422333 Florent Revest 2023-03-21  5439  EXPORT_SYMBOL_GPL(unregister_ftrace_direct);
ccf5a89efd6f0a Jiri Olsa      2021-10-08  5440  

:::::: The code at line 5417 was first introduced by commit
:::::: f64dd4627ec6edc39bf1430fe6dbc923d2300a88 ftrace: Add multi direct register/unregister interface

:::::: TO: Jiri Olsa <jolsa@redhat.com>
:::::: CC: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
