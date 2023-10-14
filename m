Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD2B7C9543
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 18:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbjJNQNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 12:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjJNQNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 12:13:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F930A9
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 09:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697300019; x=1728836019;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xLfeTQCQ7ajxjNnSRfaer1IfCFto5evvHy3co4Bzopo=;
  b=W9CGXzT0OtrNv9e5m0R66echQOU3JNRrQn9BbhGUG6tt6OY0IavloDqQ
   ed2/f+AuwH25P2oEFzk8ivMK50iYDl5BNIMdOOV+DY7mD0BoAFca5S8eJ
   GqTzYKlDapQoCe6jzB1UGVmPyFDJ2wVqMUQKrBnyWBb3sGuYqlyoNCsgm
   YGT/hxAoVBcRNVwcO5XV2oHx5EXihQFl1g5oPgOeToF1n99qdfG8SCYtl
   OCtOJzwWuz9QPHYnc9xkKru+cdA92LAwcqpZiBnM4d5wZusDonCvbsrba
   AgPPSycGX591RUzBQgHbRCIMfFxFt6tvV8of/bqvqXmW+P+XBdqwqvEJj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="389193959"
X-IronPort-AV: E=Sophos;i="6.03,224,1694761200"; 
   d="scan'208";a="389193959"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2023 09:13:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="758833720"
X-IronPort-AV: E=Sophos;i="6.03,224,1694761200"; 
   d="scan'208";a="758833720"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 14 Oct 2023 09:13:37 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qrhGg-0006M0-1l;
        Sat, 14 Oct 2023 16:13:34 +0000
Date:   Sun, 15 Oct 2023 00:13:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: kernel/stacktrace.c:138: warning: Function parameter or member 'tsk'
 not described in 'stack_trace_save_tsk'
Message-ID: <202310150022.FUVBk7ng-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   727fb83765049981e342db4c5a8b51aca72201d8
commit: 214d8ca6ee854f696f75e75511fe66b409e656db stacktrace: Provide common infrastructure
date:   4 years, 6 months ago
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20231015/202310150022.FUVBk7ng-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231015/202310150022.FUVBk7ng-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310150022.FUVBk7ng-lkp@intel.com/

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
