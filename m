Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D32979D53D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbjILPqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjILPqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:46:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BA910DE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 08:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694533558; x=1726069558;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kUe+U5qKIETKaSIt+mF0u9eBRsOQSXVG3S3n9gypS3g=;
  b=GmAlxwLMyjI34yaGYo5E9k8bSapo0oXKFFfV4wIXMAexkwFqCH6JODb+
   Ta5ndKkMlrER+lBbIlOk/+qq96LlArqEM3WOGJ3gVtuLjY4pg0XfhTBAR
   9kdCzFt8jpe23oJM0ups14VrR1GVzqbHsZEDpCarDAVTeDcD+tPgE4yD4
   uXUxcznkhaffB/6b87xbCQIhViTYIk14WQPKc2iJ0xdTAcucTEGo73eKC
   OlEaA+2jkka/l3qcA4dnY+uJu3EYBaz6iywZWNBdQu0hNpdVha/+C5pIR
   Tq3aHhVcbnCU0kaqYBvKdnfcTH96zAld5fOLRq6XQS0xGj4yDlFRfFZZ+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="464786538"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="464786538"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 08:45:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="773082269"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="773082269"
Received: from lkp-server02.sh.intel.com (HELO 0a6943a0b3e1) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 12 Sep 2023 08:45:55 -0700
Received: from kbuild by 0a6943a0b3e1 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qg5aG-000083-2I;
        Tue, 12 Sep 2023 15:45:50 +0000
Date:   Tue, 12 Sep 2023 23:38:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: arch/microblaze/kernel/unwind.c:168: warning: Function parameter or
 member 'loglvl' not described in 'unwind_trap'
Message-ID: <202309122318.VLgfp802-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0bb80ecc33a8fb5a682236443c1e740d5c917d1d
commit: 77530a5277bcab0433d0f68af11e04a5c4d79039 microblaze: add loglvl to microblaze_unwind_inner()
date:   3 years, 3 months ago
config: microblaze-alldefconfig (https://download.01.org/0day-ci/archive/20230912/202309122318.VLgfp802-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230912/202309122318.VLgfp802-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309122318.VLgfp802-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/microblaze/kernel/unwind.c:168: warning: Function parameter or member 'task' not described in 'unwind_trap'
   arch/microblaze/kernel/unwind.c:168: warning: Function parameter or member 'pc' not described in 'unwind_trap'
   arch/microblaze/kernel/unwind.c:168: warning: Function parameter or member 'fp' not described in 'unwind_trap'
   arch/microblaze/kernel/unwind.c:168: warning: Function parameter or member 'trace' not described in 'unwind_trap'
>> arch/microblaze/kernel/unwind.c:168: warning: Function parameter or member 'loglvl' not described in 'unwind_trap'


vim +168 arch/microblaze/kernel/unwind.c

ce3266c0473894 Steven J. Magnani 2010-04-27  153  
ce3266c0473894 Steven J. Magnani 2010-04-27  154  static void microblaze_unwind_inner(struct task_struct *task,
ce3266c0473894 Steven J. Magnani 2010-04-27  155  				    unsigned long pc, unsigned long fp,
ce3266c0473894 Steven J. Magnani 2010-04-27  156  				    unsigned long leaf_return,
77530a5277bcab Dmitry Safonov    2020-06-08  157  				    struct stack_trace *trace,
77530a5277bcab Dmitry Safonov    2020-06-08  158  				    const char *loglvl);
ce3266c0473894 Steven J. Magnani 2010-04-27  159  
ce3266c0473894 Steven J. Magnani 2010-04-27  160  /**
ce3266c0473894 Steven J. Magnani 2010-04-27  161   * unwind_trap - Unwind through a system trap, that stored previous state
ce3266c0473894 Steven J. Magnani 2010-04-27  162   *		 on the stack.
ce3266c0473894 Steven J. Magnani 2010-04-27  163   */
ce3266c0473894 Steven J. Magnani 2010-04-27  164  #ifdef CONFIG_MMU
ce3266c0473894 Steven J. Magnani 2010-04-27  165  static inline void unwind_trap(struct task_struct *task, unsigned long pc,
77530a5277bcab Dmitry Safonov    2020-06-08  166  				unsigned long fp, struct stack_trace *trace,
77530a5277bcab Dmitry Safonov    2020-06-08  167  				const char *loglvl)
ce3266c0473894 Steven J. Magnani 2010-04-27 @168  {
ce3266c0473894 Steven J. Magnani 2010-04-27  169  	/* To be implemented */
ce3266c0473894 Steven J. Magnani 2010-04-27  170  }
ce3266c0473894 Steven J. Magnani 2010-04-27  171  #else
ce3266c0473894 Steven J. Magnani 2010-04-27  172  static inline void unwind_trap(struct task_struct *task, unsigned long pc,
77530a5277bcab Dmitry Safonov    2020-06-08  173  				unsigned long fp, struct stack_trace *trace,
77530a5277bcab Dmitry Safonov    2020-06-08  174  				const char *loglvl)
ce3266c0473894 Steven J. Magnani 2010-04-27  175  {
ce3266c0473894 Steven J. Magnani 2010-04-27  176  	const struct pt_regs *regs = (const struct pt_regs *) fp;
77530a5277bcab Dmitry Safonov    2020-06-08  177  	microblaze_unwind_inner(task, regs->pc, regs->r1, regs->r15, trace, loglvl);
ce3266c0473894 Steven J. Magnani 2010-04-27  178  }
ce3266c0473894 Steven J. Magnani 2010-04-27  179  #endif
ce3266c0473894 Steven J. Magnani 2010-04-27  180  

:::::: The code at line 168 was first introduced by commit
:::::: ce3266c047389443d5f433d605c769e878cbe46e microblaze: Add stack unwinder

:::::: TO: Steven J. Magnani <steve@digidescorp.com>
:::::: CC: Michal Simek <monstr@monstr.eu>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
