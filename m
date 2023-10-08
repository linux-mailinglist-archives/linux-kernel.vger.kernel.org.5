Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA27B7BCE9F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 15:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344816AbjJHNnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 09:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjJHNnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 09:43:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74074B9
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 06:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696772583; x=1728308583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3cGiRicZPXcPZghZ8JD3xHHPqvLLlplxPtzNWeJSZJ0=;
  b=bIUvpzlca5nEHrRKEzkdHX79gangWTAdC4a7rexdHeNTJq5NvwVLovUC
   NCHIxjS4xd3wLtbGs9ixglkAfU9551IUk1sFEnycXFY4TbNbVD1+4/DkX
   UbdBuWhdR9rk44FBUek8ZCgfLgOrV3lcCU06YebDRVp391yziwbC6kyIz
   TPwHfjDLE/whS7hH7W6qqJGVNH74Eig4NEsnm2D9Oc3LkK/5tLTNLjbnW
   OyvIAdkl3MLdRkiVdY2zNk+jHv65ieVaoCXhy39FRzUg29Z1vikcl4b7q
   3bzOwK3o5pY5NSj83B8rvddXk5CPNiZ89UmRReBJhVia/8Xt3TF6/b7B8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="386837861"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="386837861"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 06:43:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="926500647"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="926500647"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 Oct 2023 06:43:00 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qpU3e-0005SZ-1r;
        Sun, 08 Oct 2023 13:42:58 +0000
Date:   Sun, 8 Oct 2023 21:42:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "brookxu.cn" <brookxu.cn@gmail.com>, bsingharora@gmail.com,
        juri.lelli@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] delayacct: convert task->delays to a object
Message-ID: <202310082109.JOBtnIOu-lkp@intel.com>
References: <531ddc82793a39f4c09316d701a4b1170bcad4ab.1696761522.git.chunguang.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <531ddc82793a39f4c09316d701a4b1170bcad4ab.1696761522.git.chunguang.xu@shopee.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi brookxu.cn,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on linus/master v6.6-rc4 next-20231006]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/brookxu-cn/delayacct-introduce-delayacct_enabled-to-simplify-implement/20231008-185144
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/531ddc82793a39f4c09316d701a4b1170bcad4ab.1696761522.git.chunguang.xu%40shopee.com
patch subject: [PATCH 2/3] delayacct: convert task->delays to a object
config: riscv-randconfig-002-20231008 (https://download.01.org/0day-ci/archive/20231008/202310082109.JOBtnIOu-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231008/202310082109.JOBtnIOu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310082109.JOBtnIOu-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/riscv/include/asm/compat.h:12,
                    from arch/riscv/include/asm/pgtable.h:119,
                    from include/linux/pgtable.h:6,
                    from include/linux/kasan.h:33,
                    from include/linux/slab.h:180,
                    from include/linux/delayacct.h:62,
                    from include/linux/sched.h:40,
                    from include/linux/mm.h:28,
                    from arch/riscv/kernel/asm-offsets.c:10:
   include/linux/sched/task_stack.h: In function 'task_stack_page':
>> include/linux/sched/task_stack.h:21:20: error: invalid use of undefined type 'const struct task_struct'
      21 |         return task->stack;
         |                    ^~
   include/linux/sched/task_stack.h: In function 'end_of_stack':
   include/linux/sched/task_stack.h:31:20: error: invalid use of undefined type 'const struct task_struct'
      31 |         return task->stack;
         |                    ^~
   include/linux/sched/task_stack.h: In function 'try_get_task_stack':
>> include/linux/sched/task_stack.h:68:42: error: invalid use of undefined type 'struct task_struct'
      68 |         return refcount_inc_not_zero(&tsk->stack_refcount) ?
         |                                          ^~
   make[3]: *** [scripts/Makefile.build:116: arch/riscv/kernel/asm-offsets.s] Error 1 shuffle=2275994632
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1202: prepare0] Error 2 shuffle=2275994632
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:234: __sub-make] Error 2 shuffle=2275994632
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:234: __sub-make] Error 2 shuffle=2275994632
   make: Target 'prepare' not remade because of errors.


vim +21 include/linux/sched/task_stack.h

f3ac60671954c8 Ingo Molnar     2017-02-03  13  
f3ac60671954c8 Ingo Molnar     2017-02-03  14  /*
f3ac60671954c8 Ingo Molnar     2017-02-03  15   * When accessing the stack of a non-current task that might exit, use
f3ac60671954c8 Ingo Molnar     2017-02-03  16   * try_get_task_stack() instead.  task_stack_page will return a pointer
f3ac60671954c8 Ingo Molnar     2017-02-03  17   * that could get freed out from under you.
f3ac60671954c8 Ingo Molnar     2017-02-03  18   */
e87f4152e54261 Borislav Petkov 2022-03-23  19  static __always_inline void *task_stack_page(const struct task_struct *task)
f3ac60671954c8 Ingo Molnar     2017-02-03  20  {
f3ac60671954c8 Ingo Molnar     2017-02-03 @21  	return task->stack;
f3ac60671954c8 Ingo Molnar     2017-02-03  22  }
f3ac60671954c8 Ingo Molnar     2017-02-03  23  
f3ac60671954c8 Ingo Molnar     2017-02-03  24  #define setup_thread_stack(new,old)	do { } while(0)
f3ac60671954c8 Ingo Molnar     2017-02-03  25  
e0b081d17a9f4e Josh Poimboeuf  2023-04-12  26  static __always_inline unsigned long *end_of_stack(const struct task_struct *task)
f3ac60671954c8 Ingo Molnar     2017-02-03  27  {
9cc2fa4f4a92cc Helge Deller    2021-10-05  28  #ifdef CONFIG_STACK_GROWSUP
9cc2fa4f4a92cc Helge Deller    2021-10-05  29  	return (unsigned long *)((unsigned long)task->stack + THREAD_SIZE) - 1;
9cc2fa4f4a92cc Helge Deller    2021-10-05  30  #else
f3ac60671954c8 Ingo Molnar     2017-02-03  31  	return task->stack;
9cc2fa4f4a92cc Helge Deller    2021-10-05  32  #endif
f3ac60671954c8 Ingo Molnar     2017-02-03  33  }
f3ac60671954c8 Ingo Molnar     2017-02-03  34  
f3ac60671954c8 Ingo Molnar     2017-02-03  35  #elif !defined(__HAVE_THREAD_FUNCTIONS)
f3ac60671954c8 Ingo Molnar     2017-02-03  36  
f3ac60671954c8 Ingo Molnar     2017-02-03  37  #define task_stack_page(task)	((void *)(task)->stack)
f3ac60671954c8 Ingo Molnar     2017-02-03  38  
f3ac60671954c8 Ingo Molnar     2017-02-03  39  static inline void setup_thread_stack(struct task_struct *p, struct task_struct *org)
f3ac60671954c8 Ingo Molnar     2017-02-03  40  {
f3ac60671954c8 Ingo Molnar     2017-02-03  41  	*task_thread_info(p) = *task_thread_info(org);
f3ac60671954c8 Ingo Molnar     2017-02-03  42  	task_thread_info(p)->task = p;
f3ac60671954c8 Ingo Molnar     2017-02-03  43  }
f3ac60671954c8 Ingo Molnar     2017-02-03  44  
f3ac60671954c8 Ingo Molnar     2017-02-03  45  /*
f3ac60671954c8 Ingo Molnar     2017-02-03  46   * Return the address of the last usable long on the stack.
f3ac60671954c8 Ingo Molnar     2017-02-03  47   *
f3ac60671954c8 Ingo Molnar     2017-02-03  48   * When the stack grows down, this is just above the thread
f3ac60671954c8 Ingo Molnar     2017-02-03  49   * info struct. Going any lower will corrupt the threadinfo.
f3ac60671954c8 Ingo Molnar     2017-02-03  50   *
f3ac60671954c8 Ingo Molnar     2017-02-03  51   * When the stack grows up, this is the highest address.
f3ac60671954c8 Ingo Molnar     2017-02-03  52   * Beyond that position, we corrupt data on the next page.
f3ac60671954c8 Ingo Molnar     2017-02-03  53   */
f3ac60671954c8 Ingo Molnar     2017-02-03  54  static inline unsigned long *end_of_stack(struct task_struct *p)
f3ac60671954c8 Ingo Molnar     2017-02-03  55  {
f3ac60671954c8 Ingo Molnar     2017-02-03  56  #ifdef CONFIG_STACK_GROWSUP
f3ac60671954c8 Ingo Molnar     2017-02-03  57  	return (unsigned long *)((unsigned long)task_thread_info(p) + THREAD_SIZE) - 1;
f3ac60671954c8 Ingo Molnar     2017-02-03  58  #else
f3ac60671954c8 Ingo Molnar     2017-02-03  59  	return (unsigned long *)(task_thread_info(p) + 1);
f3ac60671954c8 Ingo Molnar     2017-02-03  60  #endif
f3ac60671954c8 Ingo Molnar     2017-02-03  61  }
f3ac60671954c8 Ingo Molnar     2017-02-03  62  
f3ac60671954c8 Ingo Molnar     2017-02-03  63  #endif
f3ac60671954c8 Ingo Molnar     2017-02-03  64  
f3ac60671954c8 Ingo Molnar     2017-02-03  65  #ifdef CONFIG_THREAD_INFO_IN_TASK
f3ac60671954c8 Ingo Molnar     2017-02-03  66  static inline void *try_get_task_stack(struct task_struct *tsk)
f3ac60671954c8 Ingo Molnar     2017-02-03  67  {
f0b89d3958d73c Elena Reshetova 2019-01-18 @68  	return refcount_inc_not_zero(&tsk->stack_refcount) ?
f3ac60671954c8 Ingo Molnar     2017-02-03  69  		task_stack_page(tsk) : NULL;
f3ac60671954c8 Ingo Molnar     2017-02-03  70  }
f3ac60671954c8 Ingo Molnar     2017-02-03  71  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
