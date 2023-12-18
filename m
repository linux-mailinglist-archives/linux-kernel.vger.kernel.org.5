Return-Path: <linux-kernel+bounces-3007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3442E816604
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86031F220CE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 05:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DE663C6;
	Mon, 18 Dec 2023 05:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dUBzrwlp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A664D63AE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 05:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702877007; x=1734413007;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ECkG5uggTH9duWrWc+G7ydY/UcTcu0osMq/FFgnPgJo=;
  b=dUBzrwlphErdmlcPCjOT+ELYKEVx9ktXnKXZ4wxgCUPxtok9CQxCn1s4
   yDTja0ettIzJkfzNc0If0XBlVGGCY1VsVIpcV/4Q06WF6kPdzf/X18mCF
   jMnvC1TU3fZDsxqN5TFhLBvJxpQ5NmG1pxfiPU65uOX2C8b58S5R7aa6f
   TJlLzRRPIQVhOgiPP5IJ+E1Se6gM4j//gb7a+Eds/wdNhoaNs+WkSsXoA
   Nyo8btJJhA+SEetG2SSs62B3rT+IUmoMkh2bIgtM4x7U7nWS26YlHCVdg
   NWWrC5yeJDZ3GByJr3+FNtGbr2u2Z2yOAyOqudRD9XlLM1XrsMHZ0wYJM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="2283898"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="2283898"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 21:23:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="1106801184"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="1106801184"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 17 Dec 2023 21:23:25 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rF667-0003nF-0R;
	Mon, 18 Dec 2023 05:23:23 +0000
Date: Mon, 18 Dec 2023 13:23:07 +0800
From: kernel test robot <lkp@intel.com>
To: Florent Revest <revest@chromium.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: kernel/trace/ftrace.c:5417: warning: Function parameter or struct
 member 'addr' not described in 'unregister_ftrace_direct'
Message-ID: <202312181320.e0OwUd0s-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Florent,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ceb6a6f023fd3e8b07761ed900352ef574010bcb
commit: da8bdfbd422333fbb7c85ac1d7f18592d17d6665 ftrace: Rename _ftrace_direct_multi APIs to _ftrace_direct APIs
date:   9 months ago
config: i386-randconfig-054-20231216 (https://download.01.org/0day-ci/archive/20231218/202312181320.e0OwUd0s-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231218/202312181320.e0OwUd0s-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312181320.e0OwUd0s-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/trace/ftrace.c:1283: warning: Function parameter or struct member 'ops' not described in 'ftrace_free_filter'
>> kernel/trace/ftrace.c:5417: warning: Function parameter or struct member 'addr' not described in 'unregister_ftrace_direct'
>> kernel/trace/ftrace.c:5417: warning: Function parameter or struct member 'free_filters' not described in 'unregister_ftrace_direct'
   kernel/trace/ftrace.c:5565: warning: Function parameter or struct member 'ops' not described in 'ftrace_set_filter_ip'
   kernel/trace/ftrace.c:5565: warning: Function parameter or struct member 'ip' not described in 'ftrace_set_filter_ip'
   kernel/trace/ftrace.c:5565: warning: Function parameter or struct member 'remove' not described in 'ftrace_set_filter_ip'
   kernel/trace/ftrace.c:5565: warning: Function parameter or struct member 'reset' not described in 'ftrace_set_filter_ip'
   kernel/trace/ftrace.c:5588: warning: Function parameter or struct member 'ops' not described in 'ftrace_set_filter_ips'
   kernel/trace/ftrace.c:5588: warning: Function parameter or struct member 'ips' not described in 'ftrace_set_filter_ips'
   kernel/trace/ftrace.c:5588: warning: Function parameter or struct member 'cnt' not described in 'ftrace_set_filter_ips'
   kernel/trace/ftrace.c:5588: warning: Function parameter or struct member 'remove' not described in 'ftrace_set_filter_ips'
   kernel/trace/ftrace.c:5588: warning: Function parameter or struct member 'reset' not described in 'ftrace_set_filter_ips'
   kernel/trace/ftrace.c:5602: warning: Function parameter or struct member 'ops' not described in 'ftrace_ops_set_global_filter'
   kernel/trace/ftrace.c:5634: warning: Function parameter or struct member 'ops' not described in 'ftrace_set_filter'
   kernel/trace/ftrace.c:5634: warning: Function parameter or struct member 'buf' not described in 'ftrace_set_filter'
   kernel/trace/ftrace.c:5634: warning: Function parameter or struct member 'len' not described in 'ftrace_set_filter'
   kernel/trace/ftrace.c:5634: warning: Function parameter or struct member 'reset' not described in 'ftrace_set_filter'
   kernel/trace/ftrace.c:5657: warning: Function parameter or struct member 'ops' not described in 'ftrace_set_notrace'
   kernel/trace/ftrace.c:5657: warning: Function parameter or struct member 'buf' not described in 'ftrace_set_notrace'
   kernel/trace/ftrace.c:5657: warning: Function parameter or struct member 'len' not described in 'ftrace_set_notrace'
   kernel/trace/ftrace.c:5657: warning: Function parameter or struct member 'reset' not described in 'ftrace_set_notrace'
   kernel/trace/ftrace.c:5672: warning: Function parameter or struct member 'buf' not described in 'ftrace_set_global_filter'
   kernel/trace/ftrace.c:5672: warning: Function parameter or struct member 'len' not described in 'ftrace_set_global_filter'
   kernel/trace/ftrace.c:5672: warning: Function parameter or struct member 'reset' not described in 'ftrace_set_global_filter'
   kernel/trace/ftrace.c:5688: warning: Function parameter or struct member 'buf' not described in 'ftrace_set_global_notrace'
   kernel/trace/ftrace.c:5688: warning: Function parameter or struct member 'len' not described in 'ftrace_set_global_notrace'
   kernel/trace/ftrace.c:5688: warning: Function parameter or struct member 'reset' not described in 'ftrace_set_global_notrace'


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

