Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46227CBECF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbjJQJSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343516AbjJQJSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:18:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29DEB0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697534295; x=1729070295;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=geiB9R0O3bffNISsQpTn9Hgj/cROMITGfEN0W4jWx5A=;
  b=Y0PkFJUZFySPnK6c/qi8msXKv/iKaIHxrbQ5ib3btrwkPlef8ngkucnF
   C/GVc05XMvgQCfislaVfNu3SVqQ1tQj5hgUsaAghT6nl1vqCtzStRi9RW
   TiT981W2q+qqlFcg3PGgFc3dVuwu07FHzEu82NeIjPYaLjMx4diNjOKSC
   /xNvC99YaNdeT0MskaFwR31Fd59nwlpgXuhVtc4j2zwHABlU+jEZnJO9Y
   c5fOgmK4ZT7DCXqwHk/JiaQxMxJWbTlve00zJ/f1oRJC6IiH6q/fpDDz+
   XqU1BK0B7zWLobvltke/3UrHx3AkXGyb8cwU4UgsvIBjM02qz3HBKfUlV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="376107714"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="376107714"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:18:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="791175263"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="791175263"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 17 Oct 2023 02:18:12 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsgDK-0009OZ-1U;
        Tue, 17 Oct 2023 09:18:10 +0000
Date:   Tue, 17 Oct 2023 17:17:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: kernel/trace/ftrace.c:1256: warning: Function parameter or member
 'ops' not described in 'ftrace_free_filter'
Message-ID: <202310171716.F4hyR2xg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   213f891525c222e8ed145ce1ce7ae1f47921cb9c
commit: 8be9fbd5345da52f4a74f7f81d55ff9fa0a2958e ftrace: Export ftrace_free_filter() to modules
date:   9 months ago
config: x86_64-buildonly-randconfig-001-20231012 (https://download.01.org/0day-ci/archive/20231017/202310171716.F4hyR2xg-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231017/202310171716.F4hyR2xg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310171716.F4hyR2xg-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/trace/ftrace.c:1256: warning: Function parameter or member 'ops' not described in 'ftrace_free_filter'
   kernel/trace/ftrace.c:5709: warning: Function parameter or member 'addr' not described in 'unregister_ftrace_direct_multi'
   kernel/trace/ftrace.c:5854: warning: Function parameter or member 'ops' not described in 'ftrace_set_filter_ip'
   kernel/trace/ftrace.c:5854: warning: Function parameter or member 'ip' not described in 'ftrace_set_filter_ip'
   kernel/trace/ftrace.c:5854: warning: Function parameter or member 'remove' not described in 'ftrace_set_filter_ip'
   kernel/trace/ftrace.c:5854: warning: Function parameter or member 'reset' not described in 'ftrace_set_filter_ip'
   kernel/trace/ftrace.c:5877: warning: Function parameter or member 'ops' not described in 'ftrace_set_filter_ips'
   kernel/trace/ftrace.c:5877: warning: Function parameter or member 'ips' not described in 'ftrace_set_filter_ips'
   kernel/trace/ftrace.c:5877: warning: Function parameter or member 'cnt' not described in 'ftrace_set_filter_ips'
   kernel/trace/ftrace.c:5877: warning: Function parameter or member 'remove' not described in 'ftrace_set_filter_ips'
   kernel/trace/ftrace.c:5877: warning: Function parameter or member 'reset' not described in 'ftrace_set_filter_ips'
   kernel/trace/ftrace.c:5891: warning: Function parameter or member 'ops' not described in 'ftrace_ops_set_global_filter'
   kernel/trace/ftrace.c:5923: warning: Function parameter or member 'ops' not described in 'ftrace_set_filter'
   kernel/trace/ftrace.c:5923: warning: Function parameter or member 'buf' not described in 'ftrace_set_filter'
   kernel/trace/ftrace.c:5923: warning: Function parameter or member 'len' not described in 'ftrace_set_filter'
   kernel/trace/ftrace.c:5923: warning: Function parameter or member 'reset' not described in 'ftrace_set_filter'
   kernel/trace/ftrace.c:5946: warning: Function parameter or member 'ops' not described in 'ftrace_set_notrace'
   kernel/trace/ftrace.c:5946: warning: Function parameter or member 'buf' not described in 'ftrace_set_notrace'
   kernel/trace/ftrace.c:5946: warning: Function parameter or member 'len' not described in 'ftrace_set_notrace'
   kernel/trace/ftrace.c:5946: warning: Function parameter or member 'reset' not described in 'ftrace_set_notrace'
   kernel/trace/ftrace.c:5961: warning: Function parameter or member 'buf' not described in 'ftrace_set_global_filter'
   kernel/trace/ftrace.c:5961: warning: Function parameter or member 'len' not described in 'ftrace_set_global_filter'
   kernel/trace/ftrace.c:5961: warning: Function parameter or member 'reset' not described in 'ftrace_set_global_filter'
   kernel/trace/ftrace.c:5977: warning: Function parameter or member 'buf' not described in 'ftrace_set_global_notrace'
   kernel/trace/ftrace.c:5977: warning: Function parameter or member 'len' not described in 'ftrace_set_global_notrace'
   kernel/trace/ftrace.c:5977: warning: Function parameter or member 'reset' not described in 'ftrace_set_global_notrace'


vim +1256 kernel/trace/ftrace.c

07fd5515f3b5c2 Steven Rostedt           2011-05-05  1250  
8be9fbd5345da5 Mark Rutland             2023-01-03  1251  /**
8be9fbd5345da5 Mark Rutland             2023-01-03  1252   * ftrace_free_filter - remove all filters for an ftrace_ops
8be9fbd5345da5 Mark Rutland             2023-01-03  1253   * @ops - the ops to remove the filters from
8be9fbd5345da5 Mark Rutland             2023-01-03  1254   */
5500fa51199aee Jiri Olsa                2012-02-15  1255  void ftrace_free_filter(struct ftrace_ops *ops)
5500fa51199aee Jiri Olsa                2012-02-15 @1256  {
f04f24fb7e48d4 Masami Hiramatsu         2013-05-09  1257  	ftrace_ops_init(ops);
33b7f99cf003ca Steven Rostedt (Red Hat  2014-08-15  1258) 	free_ftrace_hash(ops->func_hash->filter_hash);
33b7f99cf003ca Steven Rostedt (Red Hat  2014-08-15  1259) 	free_ftrace_hash(ops->func_hash->notrace_hash);
5500fa51199aee Jiri Olsa                2012-02-15  1260  }
8be9fbd5345da5 Mark Rutland             2023-01-03  1261  EXPORT_SYMBOL_GPL(ftrace_free_filter);
5500fa51199aee Jiri Olsa                2012-02-15  1262  

:::::: The code at line 1256 was first introduced by commit
:::::: 5500fa51199aee770ce53718853732600543619e ftrace, perf: Add filter support for function trace event

:::::: TO: Jiri Olsa <jolsa@redhat.com>
:::::: CC: Steven Rostedt <rostedt@goodmis.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
