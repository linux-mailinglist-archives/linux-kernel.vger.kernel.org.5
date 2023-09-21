Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C8E7AA3D0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbjIUV72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjIUV7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:59:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC4D10927
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 14:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695333302; x=1726869302;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IPLP5m2v91RG6PGUczslDNsEu18LnwwC7FtT9LegcG0=;
  b=fKHJzghNTi6H3lNP/T6D0iyvr6J9fhBweD+GTzpHp2MAUoFY16T2RIdm
   XXNB5Vj0UXo7dKHaYF9YO6Xf29TEDlEIAoDP8+JUJGIpxt9czBcYC6v+P
   r/hYKs5rvv2lFskDleO58ocDGL6nIYaYjom8W7jmAqnWafuZjbG47NxXw
   H4KzG59O1XhessJfCwy4o/1lRw4tfL6ChpC7+ujrrQKVRv5og455BrTxx
   KOvLb/JjybckObJI2IwjM3WjZzpZ1dc7GmLFJVolYSt7SucU78WL4Zi8h
   4ONNmkcpvPZ2sRa+r0CFgUgc558IlwosrznVLhpjZere2VzofDFMTmzAr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="379552790"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="379552790"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 14:55:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="782388257"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="782388257"
Received: from lkp-server02.sh.intel.com (HELO b77866e22201) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 21 Sep 2023 14:54:59 -0700
Received: from kbuild by b77866e22201 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qjRdP-0000SD-2G;
        Thu, 21 Sep 2023 21:54:56 +0000
Date:   Fri, 22 Sep 2023 05:54:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oliver Glitta <glittao@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: kernel/stacktrace.c:138: warning: Function parameter or member 'tsk'
 not described in 'stack_trace_save_tsk'
Message-ID: <202309220545.NEMzjh18-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   27bbf45eae9ca98877a2d52a92a188147cd61b07
commit: 5cf909c553e9efed573811de4b3f5172898d5515 mm/slub: use stackdepot to save stack trace in objects
date:   1 year, 6 months ago
config: csky-allnoconfig (https://download.01.org/0day-ci/archive/20230922/202309220545.NEMzjh18-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230922/202309220545.NEMzjh18-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309220545.NEMzjh18-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/stacktrace.c:138: warning: Function parameter or member 'tsk' not described in 'stack_trace_save_tsk'
>> kernel/stacktrace.c:138: warning: Excess function parameter 'task' description in 'stack_trace_save_tsk'


vim +138 kernel/stacktrace.c

214d8ca6ee854f6 Thomas Gleixner 2019-04-25  126  
214d8ca6ee854f6 Thomas Gleixner 2019-04-25  127  /**
214d8ca6ee854f6 Thomas Gleixner 2019-04-25  128   * stack_trace_save_tsk - Save a task stack trace into a storage array
214d8ca6ee854f6 Thomas Gleixner 2019-04-25  129   * @task:	The task to examine
214d8ca6ee854f6 Thomas Gleixner 2019-04-25  130   * @store:	Pointer to storage array
214d8ca6ee854f6 Thomas Gleixner 2019-04-25  131   * @size:	Size of the storage array
214d8ca6ee854f6 Thomas Gleixner 2019-04-25  132   * @skipnr:	Number of entries to skip at the start of the stack trace
214d8ca6ee854f6 Thomas Gleixner 2019-04-25  133   *
214d8ca6ee854f6 Thomas Gleixner 2019-04-25  134   * Return: Number of trace entries stored.
214d8ca6ee854f6 Thomas Gleixner 2019-04-25  135   */
214d8ca6ee854f6 Thomas Gleixner 2019-04-25  136  unsigned int stack_trace_save_tsk(struct task_struct *tsk, unsigned long *store,
214d8ca6ee854f6 Thomas Gleixner 2019-04-25  137  				  unsigned int size, unsigned int skipnr)
214d8ca6ee854f6 Thomas Gleixner 2019-04-25 @138  {
214d8ca6ee854f6 Thomas Gleixner 2019-04-25  139  	stack_trace_consume_fn consume_entry = stack_trace_consume_entry_nosched;
214d8ca6ee854f6 Thomas Gleixner 2019-04-25  140  	struct stacktrace_cookie c = {
214d8ca6ee854f6 Thomas Gleixner 2019-04-25  141  		.store	= store,
214d8ca6ee854f6 Thomas Gleixner 2019-04-25  142  		.size	= size,
b0c51f158455e31 Jiri Slaby      2019-10-30  143  		/* skip this function if they are tracing us */
4b48512c2e9c63b Jiri Slaby      2019-11-11  144  		.skip	= skipnr + (current == tsk),
214d8ca6ee854f6 Thomas Gleixner 2019-04-25  145  	};
214d8ca6ee854f6 Thomas Gleixner 2019-04-25  146  
214d8ca6ee854f6 Thomas Gleixner 2019-04-25  147  	if (!try_get_task_stack(tsk))
214d8ca6ee854f6 Thomas Gleixner 2019-04-25  148  		return 0;
214d8ca6ee854f6 Thomas Gleixner 2019-04-25  149  
214d8ca6ee854f6 Thomas Gleixner 2019-04-25  150  	arch_stack_walk(consume_entry, &c, tsk, NULL);
214d8ca6ee854f6 Thomas Gleixner 2019-04-25  151  	put_task_stack(tsk);
214d8ca6ee854f6 Thomas Gleixner 2019-04-25  152  	return c.len;
214d8ca6ee854f6 Thomas Gleixner 2019-04-25  153  }
214d8ca6ee854f6 Thomas Gleixner 2019-04-25  154  

:::::: The code at line 138 was first introduced by commit
:::::: 214d8ca6ee854f696f75e75511fe66b409e656db stacktrace: Provide common infrastructure

:::::: TO: Thomas Gleixner <tglx@linutronix.de>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
