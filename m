Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F15803219
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343911AbjLDMDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbjLDMDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:03:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1280212F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701691373; x=1733227373;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AfoyPVRgdnYgARogzQH6MmY+YxG4vVbRFMl7FitYhUk=;
  b=fQhe5EY/ECdZIM72lJqfDRmnM6cKpIiNiHsorRUcap25YPXJ2j9Bg156
   q3XoAIoZT59YB3TExjgWv/Xxj1T2iogrL1CGTKjWko8S8j4APYsBbOgrA
   Il6cklzTmm+wcBeJ4zJ9uf6ss7KYra98MI9UxVr1cOtXlL1oLvNxpKmTJ
   FJT7+DhE5dXwTlMq9NUs0dOUZ/ED/zxIov16/9Azs3k4PW22DWC+t2rEh
   UDKwqh6/g6OubxXgK9KEg/0tBmWjp4MuU6R9bQP/2jM5oyBM0gglzjHVk
   bCEbkiCJ7WtWDhS0tboAvxw5wDPB9uNhHHb3zYKSk8ILzYxM/kNYIhw4p
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="373154179"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="373154179"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 04:02:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="1017826170"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="1017826170"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 04 Dec 2023 04:02:50 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rA7ey-0007i4-1e;
        Mon, 04 Dec 2023 12:02:48 +0000
Date:   Mon, 4 Dec 2023 20:02:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: kernel/context_tracking.c:80: warning: Function parameter or member
 'state' not described in '__ct_user_enter'
Message-ID: <202312041922.YZCcEPYD-lkp@intel.com>
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

Hi Frederic,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
commit: e67198cc05b8ecbb7b8e2d8ef9fb5c8d26821873 context_tracking: Take idle eqs entrypoints over RCU
date:   1 year, 5 months ago
config: x86_64-buildonly-randconfig-006-20230906 (https://download.01.org/0day-ci/archive/20231204/202312041922.YZCcEPYD-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231204/202312041922.YZCcEPYD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312041922.YZCcEPYD-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/context_tracking.c:80: warning: Function parameter or member 'state' not described in '__ct_user_enter'
>> kernel/context_tracking.c:184: warning: Function parameter or member 'state' not described in '__ct_user_exit'


vim +80 kernel/context_tracking.c

aed5ed47724f6a Frederic Weisbecker 2015-05-06   69  
4eacdf18374e5d Frederic Weisbecker 2013-01-16   70  /**
0ffc781a19ed30 Frederic Weisbecker 2022-06-08   71   * __ct_user_enter - Inform the context tracking that the CPU is going
0ffc781a19ed30 Frederic Weisbecker 2022-06-08   72   *		     to enter user or guest space mode.
4eacdf18374e5d Frederic Weisbecker 2013-01-16   73   *
4eacdf18374e5d Frederic Weisbecker 2013-01-16   74   * This function must be called right before we switch from the kernel
3aab4f50bff89b Rik van Riel        2015-02-10   75   * to user or guest space, when it's guaranteed the remaining kernel
3aab4f50bff89b Rik van Riel        2015-02-10   76   * instructions to execute won't use any RCU read side critical section
3aab4f50bff89b Rik van Riel        2015-02-10   77   * because this function sets RCU in extended quiescent state.
4eacdf18374e5d Frederic Weisbecker 2013-01-16   78   */
0ffc781a19ed30 Frederic Weisbecker 2022-06-08   79  void noinstr __ct_user_enter(enum ctx_state state)
91d1aa43d30505 Frederic Weisbecker 2012-11-27  @80  {
4eacdf18374e5d Frederic Weisbecker 2013-01-16   81  	/* Kernel threads aren't supposed to go to userspace */
91d1aa43d30505 Frederic Weisbecker 2012-11-27   82  	WARN_ON_ONCE(!current->mm);
91d1aa43d30505 Frederic Weisbecker 2012-11-27   83  
aed5ed47724f6a Frederic Weisbecker 2015-05-06   84  	if (!context_tracking_recursion_enter())
d0e536d89395ec Paolo Bonzini       2015-10-28   85  		return;
aed5ed47724f6a Frederic Weisbecker 2015-05-06   86  
3aab4f50bff89b Rik van Riel        2015-02-10   87  	if ( __this_cpu_read(context_tracking.state) != state) {
d65ec12127a5b6 Frederic Weisbecker 2013-07-11   88  		if (__this_cpu_read(context_tracking.active)) {
4eacdf18374e5d Frederic Weisbecker 2013-01-16   89  			/*
4eacdf18374e5d Frederic Weisbecker 2013-01-16   90  			 * At this stage, only low level arch entry code remains and
4eacdf18374e5d Frederic Weisbecker 2013-01-16   91  			 * then we'll run in userspace. We can assume there won't be
4eacdf18374e5d Frederic Weisbecker 2013-01-16   92  			 * any RCU read-side critical section until the next call to
4eacdf18374e5d Frederic Weisbecker 2013-01-16   93  			 * user_exit() or rcu_irq_enter(). Let's remove RCU's dependency
4eacdf18374e5d Frederic Weisbecker 2013-01-16   94  			 * on the tick.
4eacdf18374e5d Frederic Weisbecker 2013-01-16   95  			 */
19fdd98b625340 Rik van Riel        2015-02-10   96  			if (state == CONTEXT_USER) {
0372007f5a79d6 Thomas Gleixner     2020-03-04   97  				instrumentation_begin();
19fdd98b625340 Rik van Riel        2015-02-10   98  				trace_user_enter(0);
abf917cd91cbb7 Frederic Weisbecker 2012-07-25   99  				vtime_user_enter(current);
0372007f5a79d6 Thomas Gleixner     2020-03-04  100  				instrumentation_end();
19fdd98b625340 Rik van Riel        2015-02-10  101  			}
91d1aa43d30505 Frederic Weisbecker 2012-11-27  102  			rcu_user_enter();
d65ec12127a5b6 Frederic Weisbecker 2013-07-11  103  		}
d65ec12127a5b6 Frederic Weisbecker 2013-07-11  104  		/*
d65ec12127a5b6 Frederic Weisbecker 2013-07-11  105  		 * Even if context tracking is disabled on this CPU, because it's outside
d65ec12127a5b6 Frederic Weisbecker 2013-07-11  106  		 * the full dynticks mask for example, we still have to keep track of the
d65ec12127a5b6 Frederic Weisbecker 2013-07-11  107  		 * context transitions and states to prevent inconsistency on those of
d65ec12127a5b6 Frederic Weisbecker 2013-07-11  108  		 * other CPUs.
d65ec12127a5b6 Frederic Weisbecker 2013-07-11  109  		 * If a task triggers an exception in userspace, sleep on the exception
d65ec12127a5b6 Frederic Weisbecker 2013-07-11  110  		 * handler and then migrate to another CPU, that new CPU must know where
d65ec12127a5b6 Frederic Weisbecker 2013-07-11  111  		 * the exception returns by the time we call exception_exit().
d65ec12127a5b6 Frederic Weisbecker 2013-07-11  112  		 * This information can only be provided by the previous CPU when it called
d65ec12127a5b6 Frederic Weisbecker 2013-07-11  113  		 * exception_enter().
d65ec12127a5b6 Frederic Weisbecker 2013-07-11  114  		 * OTOH we can spare the calls to vtime and RCU when context_tracking.active
d65ec12127a5b6 Frederic Weisbecker 2013-07-11  115  		 * is false because we know that CPU is not tickless.
d65ec12127a5b6 Frederic Weisbecker 2013-07-11  116  		 */
3aab4f50bff89b Rik van Riel        2015-02-10  117  		__this_cpu_write(context_tracking.state, state);
91d1aa43d30505 Frederic Weisbecker 2012-11-27  118  	}
aed5ed47724f6a Frederic Weisbecker 2015-05-06  119  	context_tracking_recursion_exit();
d0e536d89395ec Paolo Bonzini       2015-10-28  120  }
0ffc781a19ed30 Frederic Weisbecker 2022-06-08  121  EXPORT_SYMBOL_GPL(__ct_user_enter);
d0e536d89395ec Paolo Bonzini       2015-10-28  122  
f67671baadf6db Frederic Weisbecker 2022-06-08  123  /*
f67671baadf6db Frederic Weisbecker 2022-06-08  124   * OBSOLETE:
f67671baadf6db Frederic Weisbecker 2022-06-08  125   * This function should be noinstr but the below local_irq_restore() is
f67671baadf6db Frederic Weisbecker 2022-06-08  126   * unsafe because it involves illegal RCU uses through tracing and lockdep.
f67671baadf6db Frederic Weisbecker 2022-06-08  127   * This is unlikely to be fixed as this function is obsolete. The preferred
f67671baadf6db Frederic Weisbecker 2022-06-08  128   * way is to call __context_tracking_enter() through user_enter_irqoff()
f67671baadf6db Frederic Weisbecker 2022-06-08  129   * or context_tracking_guest_enter(). It should be the arch entry code
f67671baadf6db Frederic Weisbecker 2022-06-08  130   * responsibility to call into context tracking with IRQs disabled.
f67671baadf6db Frederic Weisbecker 2022-06-08  131   */
fe98db1c6d1ad7 Frederic Weisbecker 2022-06-08  132  void ct_user_enter(enum ctx_state state)
d0e536d89395ec Paolo Bonzini       2015-10-28  133  {
d0e536d89395ec Paolo Bonzini       2015-10-28  134  	unsigned long flags;
d0e536d89395ec Paolo Bonzini       2015-10-28  135  
d0e536d89395ec Paolo Bonzini       2015-10-28  136  	/*
d0e536d89395ec Paolo Bonzini       2015-10-28  137  	 * Some contexts may involve an exception occuring in an irq,
d0e536d89395ec Paolo Bonzini       2015-10-28  138  	 * leading to that nesting:
d0e536d89395ec Paolo Bonzini       2015-10-28  139  	 * rcu_irq_enter() rcu_user_exit() rcu_user_exit() rcu_irq_exit()
d0e536d89395ec Paolo Bonzini       2015-10-28  140  	 * This would mess up the dyntick_nesting count though. And rcu_irq_*()
d0e536d89395ec Paolo Bonzini       2015-10-28  141  	 * helpers are enough to protect RCU uses inside the exception. So
d0e536d89395ec Paolo Bonzini       2015-10-28  142  	 * just return immediately if we detect we are in an IRQ.
d0e536d89395ec Paolo Bonzini       2015-10-28  143  	 */
d0e536d89395ec Paolo Bonzini       2015-10-28  144  	if (in_interrupt())
d0e536d89395ec Paolo Bonzini       2015-10-28  145  		return;
d0e536d89395ec Paolo Bonzini       2015-10-28  146  
d0e536d89395ec Paolo Bonzini       2015-10-28  147  	local_irq_save(flags);
0ffc781a19ed30 Frederic Weisbecker 2022-06-08  148  	__ct_user_enter(state);
91d1aa43d30505 Frederic Weisbecker 2012-11-27  149  	local_irq_restore(flags);
91d1aa43d30505 Frederic Weisbecker 2012-11-27  150  }
fe98db1c6d1ad7 Frederic Weisbecker 2022-06-08  151  NOKPROBE_SYMBOL(ct_user_enter);
fe98db1c6d1ad7 Frederic Weisbecker 2022-06-08  152  EXPORT_SYMBOL_GPL(ct_user_enter);
3aab4f50bff89b Rik van Riel        2015-02-10  153  
f163f0302ab697 Frederic Weisbecker 2022-06-08  154  /**
f163f0302ab697 Frederic Weisbecker 2022-06-08  155   * user_enter_callable() - Unfortunate ASM callable version of user_enter() for
f163f0302ab697 Frederic Weisbecker 2022-06-08  156   *			   archs that didn't manage to check the context tracking
f163f0302ab697 Frederic Weisbecker 2022-06-08  157   *			   static key from low level code.
f163f0302ab697 Frederic Weisbecker 2022-06-08  158   *
f163f0302ab697 Frederic Weisbecker 2022-06-08  159   * This OBSOLETE function should be noinstr but it unsafely calls
f163f0302ab697 Frederic Weisbecker 2022-06-08  160   * local_irq_restore(), involving illegal RCU uses through tracing and lockdep.
f67671baadf6db Frederic Weisbecker 2022-06-08  161   * This is unlikely to be fixed as this function is obsolete. The preferred
f67671baadf6db Frederic Weisbecker 2022-06-08  162   * way is to call user_enter_irqoff(). It should be the arch entry code
f67671baadf6db Frederic Weisbecker 2022-06-08  163   * responsibility to call into context tracking with IRQs disabled.
f67671baadf6db Frederic Weisbecker 2022-06-08  164   */
f163f0302ab697 Frederic Weisbecker 2022-06-08  165  void user_enter_callable(void)
3aab4f50bff89b Rik van Riel        2015-02-10  166  {
f70cd6b07e629f Paolo Bonzini       2015-10-28  167  	user_enter();
3aab4f50bff89b Rik van Riel        2015-02-10  168  }
f163f0302ab697 Frederic Weisbecker 2022-06-08  169  NOKPROBE_SYMBOL(user_enter_callable);
91d1aa43d30505 Frederic Weisbecker 2012-11-27  170  
4eacdf18374e5d Frederic Weisbecker 2013-01-16  171  /**
0ffc781a19ed30 Frederic Weisbecker 2022-06-08  172   * __ct_user_exit - Inform the context tracking that the CPU is
3aab4f50bff89b Rik van Riel        2015-02-10  173   *		    exiting user or guest mode and entering the kernel.
4eacdf18374e5d Frederic Weisbecker 2013-01-16  174   *
3aab4f50bff89b Rik van Riel        2015-02-10  175   * This function must be called after we entered the kernel from user or
3aab4f50bff89b Rik van Riel        2015-02-10  176   * guest space before any use of RCU read side critical section. This
3aab4f50bff89b Rik van Riel        2015-02-10  177   * potentially include any high level kernel code like syscalls, exceptions,
3aab4f50bff89b Rik van Riel        2015-02-10  178   * signal handling, etc...
4eacdf18374e5d Frederic Weisbecker 2013-01-16  179   *
4eacdf18374e5d Frederic Weisbecker 2013-01-16  180   * This call supports re-entrancy. This way it can be called from any exception
4eacdf18374e5d Frederic Weisbecker 2013-01-16  181   * handler without needing to know if we came from userspace or not.
4eacdf18374e5d Frederic Weisbecker 2013-01-16  182   */
0ffc781a19ed30 Frederic Weisbecker 2022-06-08  183  void noinstr __ct_user_exit(enum ctx_state state)
91d1aa43d30505 Frederic Weisbecker 2012-11-27 @184  {
aed5ed47724f6a Frederic Weisbecker 2015-05-06  185  	if (!context_tracking_recursion_enter())
d0e536d89395ec Paolo Bonzini       2015-10-28  186  		return;
aed5ed47724f6a Frederic Weisbecker 2015-05-06  187  
3aab4f50bff89b Rik van Riel        2015-02-10  188  	if (__this_cpu_read(context_tracking.state) == state) {
d65ec12127a5b6 Frederic Weisbecker 2013-07-11  189  		if (__this_cpu_read(context_tracking.active)) {
4eacdf18374e5d Frederic Weisbecker 2013-01-16  190  			/*
4eacdf18374e5d Frederic Weisbecker 2013-01-16  191  			 * We are going to run code that may use RCU. Inform
4eacdf18374e5d Frederic Weisbecker 2013-01-16  192  			 * RCU core about that (ie: we may need the tick again).
4eacdf18374e5d Frederic Weisbecker 2013-01-16  193  			 */
91d1aa43d30505 Frederic Weisbecker 2012-11-27  194  			rcu_user_exit();
19fdd98b625340 Rik van Riel        2015-02-10  195  			if (state == CONTEXT_USER) {
0372007f5a79d6 Thomas Gleixner     2020-03-04  196  				instrumentation_begin();
abf917cd91cbb7 Frederic Weisbecker 2012-07-25  197  				vtime_user_exit(current);
1b6a259aa5ab16 Frederic Weisbecker 2013-07-11  198  				trace_user_exit(0);
0372007f5a79d6 Thomas Gleixner     2020-03-04  199  				instrumentation_end();
d65ec12127a5b6 Frederic Weisbecker 2013-07-11  200  			}
19fdd98b625340 Rik van Riel        2015-02-10  201  		}
c467ea763fd5d8 Frederic Weisbecker 2015-03-04  202  		__this_cpu_write(context_tracking.state, CONTEXT_KERNEL);
91d1aa43d30505 Frederic Weisbecker 2012-11-27  203  	}
aed5ed47724f6a Frederic Weisbecker 2015-05-06  204  	context_tracking_recursion_exit();
d0e536d89395ec Paolo Bonzini       2015-10-28  205  }
0ffc781a19ed30 Frederic Weisbecker 2022-06-08  206  EXPORT_SYMBOL_GPL(__ct_user_exit);
d0e536d89395ec Paolo Bonzini       2015-10-28  207  

:::::: The code at line 80 was first introduced by commit
:::::: 91d1aa43d30505b0b825db8898ffc80a8eca96c7 context_tracking: New context tracking susbsystem

:::::: TO: Frederic Weisbecker <fweisbec@gmail.com>
:::::: CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
