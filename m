Return-Path: <linux-kernel+bounces-2837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B59168162AA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 22:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D438C1C20BB0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C334E49F6F;
	Sun, 17 Dec 2023 21:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zjw/HFEc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A4948CF2
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 21:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702850091; x=1734386091;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ruftUwBRsHNXjoRkF26yVWBvKqqiYe3A4fYw/yYFOrg=;
  b=Zjw/HFEcpOCuO36ule4WODFQOO706QgSr6vMbT5229mGBy6bnhyvuuJu
   RZeRnxnw8myH+Uf9mMohm2PmA9ZtkBqt6vFAVZsn2dwnhxPgkob2Rizlg
   AKS2OJ18dWFwf2E0rf/fZnGnULRzRhpGGmktIdIq9qpcLGFrPYnpCit0d
   iJRBkIhvzVRCQK7bfbiyoMmpN39HpmfWIohv1OsNwolX3NJIt8zk74FjD
   YII18VVeoatGy6xTynXLDGVwh59jTjvc+hYxMh5KcuSXM+B1+z1FlHGAe
   8+TzoutFzUhSELYodxX+NKVgBbc2GpURQbzRSuwoAdNEtDyDMJf48wy6k
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="392603613"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="392603613"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 13:54:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="809604902"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="809604902"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 17 Dec 2023 13:54:48 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEz5y-0003Rm-2H;
	Sun, 17 Dec 2023 21:54:46 +0000
Date: Mon, 18 Dec 2023 05:53:57 +0800
From: kernel test robot <lkp@intel.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: kernel/trace/ftrace.c:1256: warning: Function parameter or struct
 member 'ops' not described in 'ftrace_free_filter'
Message-ID: <202312180518.X6fRyDSN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0e389834672c723435a44818ed2cabc4dad24429
commit: 8be9fbd5345da52f4a74f7f81d55ff9fa0a2958e ftrace: Export ftrace_free_filter() to modules
date:   11 months ago
config: i386-randconfig-054-20231216 (https://download.01.org/0day-ci/archive/20231218/202312180518.X6fRyDSN-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231218/202312180518.X6fRyDSN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312180518.X6fRyDSN-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/trace/ftrace.c:1256: warning: Function parameter or struct member 'ops' not described in 'ftrace_free_filter'
   kernel/trace/ftrace.c:5709: warning: Function parameter or struct member 'addr' not described in 'unregister_ftrace_direct_multi'
   kernel/trace/ftrace.c:5854: warning: Function parameter or struct member 'ops' not described in 'ftrace_set_filter_ip'
   kernel/trace/ftrace.c:5854: warning: Function parameter or struct member 'ip' not described in 'ftrace_set_filter_ip'
   kernel/trace/ftrace.c:5854: warning: Function parameter or struct member 'remove' not described in 'ftrace_set_filter_ip'
   kernel/trace/ftrace.c:5854: warning: Function parameter or struct member 'reset' not described in 'ftrace_set_filter_ip'
   kernel/trace/ftrace.c:5877: warning: Function parameter or struct member 'ops' not described in 'ftrace_set_filter_ips'
   kernel/trace/ftrace.c:5877: warning: Function parameter or struct member 'ips' not described in 'ftrace_set_filter_ips'
   kernel/trace/ftrace.c:5877: warning: Function parameter or struct member 'cnt' not described in 'ftrace_set_filter_ips'
   kernel/trace/ftrace.c:5877: warning: Function parameter or struct member 'remove' not described in 'ftrace_set_filter_ips'
   kernel/trace/ftrace.c:5877: warning: Function parameter or struct member 'reset' not described in 'ftrace_set_filter_ips'
   kernel/trace/ftrace.c:5891: warning: Function parameter or struct member 'ops' not described in 'ftrace_ops_set_global_filter'
   kernel/trace/ftrace.c:5923: warning: Function parameter or struct member 'ops' not described in 'ftrace_set_filter'
   kernel/trace/ftrace.c:5923: warning: Function parameter or struct member 'buf' not described in 'ftrace_set_filter'
   kernel/trace/ftrace.c:5923: warning: Function parameter or struct member 'len' not described in 'ftrace_set_filter'
   kernel/trace/ftrace.c:5923: warning: Function parameter or struct member 'reset' not described in 'ftrace_set_filter'
   kernel/trace/ftrace.c:5946: warning: Function parameter or struct member 'ops' not described in 'ftrace_set_notrace'
   kernel/trace/ftrace.c:5946: warning: Function parameter or struct member 'buf' not described in 'ftrace_set_notrace'
   kernel/trace/ftrace.c:5946: warning: Function parameter or struct member 'len' not described in 'ftrace_set_notrace'
   kernel/trace/ftrace.c:5946: warning: Function parameter or struct member 'reset' not described in 'ftrace_set_notrace'
   kernel/trace/ftrace.c:5961: warning: Function parameter or struct member 'buf' not described in 'ftrace_set_global_filter'
   kernel/trace/ftrace.c:5961: warning: Function parameter or struct member 'len' not described in 'ftrace_set_global_filter'
   kernel/trace/ftrace.c:5961: warning: Function parameter or struct member 'reset' not described in 'ftrace_set_global_filter'
   kernel/trace/ftrace.c:5977: warning: Function parameter or struct member 'buf' not described in 'ftrace_set_global_notrace'
   kernel/trace/ftrace.c:5977: warning: Function parameter or struct member 'len' not described in 'ftrace_set_global_notrace'
   kernel/trace/ftrace.c:5977: warning: Function parameter or struct member 'reset' not described in 'ftrace_set_global_notrace'


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

