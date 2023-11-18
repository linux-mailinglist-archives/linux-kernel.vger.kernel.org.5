Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A688D7F003F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 16:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjKRPMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 10:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjKRPMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 10:12:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0919A182
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 07:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700320357; x=1731856357;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tpmyZF1938wyoEZjrL2Y8WcTbQ6TTU/PtfnVmbaE6YM=;
  b=Ys1+MJodo5HJZlJvqp22FtQvyrT4konp9VzbUWmZ96/EhPy1Eyg46CCQ
   mZ3KomngZm+KEGZTngQV9w3l0TIatADB5zELHNgDq5EF2BqFdk2BdDkzS
   qNd8gVF4IrtodcRQnFJA8CtcMpubVSgHrI4KPPf3aL81fGp65tk1JRvJv
   +d3GyfHyiB1zVsTZAJR8mAfIi5k/rYgemmh+RbfiSeUSpHgX9ORe0h4TJ
   mjhJB6Yyq5901LMxc+BRKOaR/fvOQGCAUDfGvGaTsD/ssQCOiGrl8w69U
   xC3ozJtht2jKqGslbGH1MmKpH+1DUXJf+PFu4smPTPbY+r7dyRM7S7x5f
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="477646845"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="477646845"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2023 07:12:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="7129467"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 18 Nov 2023 07:12:36 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4Mzp-00040D-01;
        Sat, 18 Nov 2023 15:12:33 +0000
Date:   Sat, 18 Nov 2023 23:11:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: kernel/stacktrace.c:138: warning: Function parameter or member 'tsk'
 not described in 'stack_trace_save_tsk'
Message-ID: <202311182316.IieU4Dl1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   791c8ab095f71327899023223940dd52257a4173
commit: 214d8ca6ee854f696f75e75511fe66b409e656db stacktrace: Provide common infrastructure
date:   4 years, 7 months ago
config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20231118/202311182316.IieU4Dl1-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231118/202311182316.IieU4Dl1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311182316.IieU4Dl1-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/stacktrace.c:138: warning: Function parameter or member 'tsk' not described in 'stack_trace_save_tsk'
>> kernel/stacktrace.c:138: warning: Excess function parameter 'task' description in 'stack_trace_save_tsk'


vim +138 kernel/stacktrace.c

   126	
   127	/**
   128	 * stack_trace_save_tsk - Save a task stack trace into a storage array
   129	 * @task:	The task to examine
   130	 * @store:	Pointer to storage array
   131	 * @size:	Size of the storage array
   132	 * @skipnr:	Number of entries to skip at the start of the stack trace
   133	 *
   134	 * Return: Number of trace entries stored.
   135	 */
   136	unsigned int stack_trace_save_tsk(struct task_struct *tsk, unsigned long *store,
   137					  unsigned int size, unsigned int skipnr)
 > 138	{
   139		stack_trace_consume_fn consume_entry = stack_trace_consume_entry_nosched;
   140		struct stacktrace_cookie c = {
   141			.store	= store,
   142			.size	= size,
   143			.skip	= skipnr + 1,
   144		};
   145	
   146		if (!try_get_task_stack(tsk))
   147			return 0;
   148	
   149		arch_stack_walk(consume_entry, &c, tsk, NULL);
   150		put_task_stack(tsk);
   151		return c.len;
   152	}
   153	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
