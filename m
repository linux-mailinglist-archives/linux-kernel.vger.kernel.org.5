Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCE17C7605
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 20:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379718AbjJLSgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 14:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379733AbjJLSgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 14:36:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11013FF;
        Thu, 12 Oct 2023 11:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697135802; x=1728671802;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6wiLdHXcPfCAQWiMUzrSl2SEsXA6Klv0yLsHRhTSamc=;
  b=FJF/cBPUqymS6thW9zTfJOKfjfAo2VXO6MVuE/8xFzfBKIeQaeOgk+Rx
   d0vqa1XI36I+ght9UspYj0axqAmy4hHmRQDUAH2nknDQlAugDFkQTEUkQ
   I6+TPcDsEPWBqHRS3stiHq1qUcjdyz+bzdgsnhGhkAZ+mNxI2luOrA7L8
   RBeze89nuB0kZwWeEAwuxIDc3GKHhLvAU/uMi81tzjO1Sos8cBhPRgTxK
   NG6kn1G4Sb1X4INn6M6z0eYfF73E4t7DzUXqxw8qoHnVhEXXj+EUR3W9b
   SfWQQ0Qb2HiucRd4Wu/GXNH61wJl/QFUsY0ZaaFfju0Nd79ISLI4+pF+O
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="375358036"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="375358036"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 11:36:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="928101192"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="928101192"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 12 Oct 2023 11:36:39 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qr0Xs-0003k1-0m;
        Thu, 12 Oct 2023 18:36:31 +0000
Date:   Fri, 13 Oct 2023 02:35:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Joey Jiao <quic_jiangenj@quicinc.com>,
        linux-modules@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, quic_jiangenj@quicinc.com,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] module: Add CONFIG_MODULE_LOAD_IN_SEQUENCE option
Message-ID: <202310130206.F778HuNp-lkp@intel.com>
References: <20231011074438.6098-1-quic_jiangenj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011074438.6098-1-quic_jiangenj@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joey,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mcgrof/modules-next]
[also build test WARNING on linus/master v6.6-rc5 next-20231012]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joey-Jiao/module-Add-CONFIG_MODULE_LOAD_IN_SEQUENCE-option/20231011-154640
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git modules-next
patch link:    https://lore.kernel.org/r/20231011074438.6098-1-quic_jiangenj%40quicinc.com
patch subject: [PATCH v2] module: Add CONFIG_MODULE_LOAD_IN_SEQUENCE option
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20231013/202310130206.F778HuNp-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231013/202310130206.F778HuNp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310130206.F778HuNp-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/module/main.c: In function 'do_init_module':
   kernel/module/main.c:2627:12: error: invalid storage class for function 'may_init_module'
    static int may_init_module(void)
               ^~~~~~~~~~~~~~~
   kernel/module/main.c:2636:13: error: invalid storage class for function 'finished_loading'
    static bool finished_loading(const char *name)
                ^~~~~~~~~~~~~~~~
   kernel/module/main.c:2657:12: error: invalid storage class for function 'module_patient_check_exists'
    static int module_patient_check_exists(const char *name,
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/module/main.c:2701:12: error: invalid storage class for function 'add_unformed_module'
    static int add_unformed_module(struct module *mod)
               ^~~~~~~~~~~~~~~~~~~
   kernel/module/main.c:2722:12: error: invalid storage class for function 'complete_formation'
    static int complete_formation(struct module *mod, struct load_info *info)
               ^~~~~~~~~~~~~~~~~~
   kernel/module/main.c:2755:12: error: invalid storage class for function 'prepare_coming_module'
    static int prepare_coming_module(struct module *mod)
               ^~~~~~~~~~~~~~~~~~~~~
   kernel/module/main.c:2773:12: error: invalid storage class for function 'unknown_module_param_cb'
    static int unknown_module_param_cb(char *param, char *val, const char *modname,
               ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/module/main.c:2793:12: error: invalid storage class for function 'early_mod_check'
    static int early_mod_check(struct load_info *info, int flags)
               ^~~~~~~~~~~~~~~
   kernel/module/main.c:2829:12: error: invalid storage class for function 'load_module'
    static int load_module(struct load_info *info, const char __user *uargs,
               ^~~~~~~~~~~
>> kernel/module/main.c:3039:1: warning: 'alias' attribute ignored [-Wattributes]
    SYSCALL_DEFINE3(init_module, void __user *, umod,
    ^~~~~~~~~~~~~~~
   In file included from kernel/module/main.c:26:0:
   include/linux/syscalls.h:247:21: error: invalid storage class for function '__do_sys_init_module'
     static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
                        ^
   include/linux/syscalls.h:230:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:221:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   kernel/module/main.c:3039:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    SYSCALL_DEFINE3(init_module, void __user *, umod,
    ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:249:18: error: static declaration of '__se_sys_init_module' follows non-static declaration
     asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                     ^
   include/linux/syscalls.h:230:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:221:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   kernel/module/main.c:3039:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    SYSCALL_DEFINE3(init_module, void __user *, umod,
    ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:248:18: note: previous declaration of '__se_sys_init_module' was here
     asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)); \
                     ^
   include/linux/syscalls.h:230:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:221:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   kernel/module/main.c:3039:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    SYSCALL_DEFINE3(init_module, void __user *, umod,
    ^~~~~~~~~~~~~~~
   kernel/module/main.c: In function '__se_sys_init_module':
   include/linux/syscalls.h:251:14: error: implicit declaration of function '__do_sys_init_module'; did you mean '__se_sys_init_module'? [-Werror=implicit-function-declaration]
      long ret = __do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));\
                 ^
   include/linux/syscalls.h:230:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:221:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   kernel/module/main.c:3039:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    SYSCALL_DEFINE3(init_module, void __user *, umod,
    ^~~~~~~~~~~~~~~
   kernel/module/main.c: In function 'do_init_module':
   include/linux/syscalls.h:257:21: error: invalid storage class for function '__do_sys_init_module'
     static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
                        ^
   include/linux/syscalls.h:230:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:221:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   kernel/module/main.c:3039:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    SYSCALL_DEFINE3(init_module, void __user *, umod,
    ^~~~~~~~~~~~~~~
   kernel/module/main.c:3073:13: error: invalid storage class for function 'idempotent'
    static bool idempotent(struct idempotent *u, const void *cookie)
                ^~~~~~~~~~
   kernel/module/main.c:3104:12: error: invalid storage class for function 'idempotent_complete'
    static int idempotent_complete(struct idempotent *u, int ret)
               ^~~~~~~~~~~~~~~~~~~
   kernel/module/main.c:3124:12: error: invalid storage class for function 'init_module_from_file'
    static int init_module_from_file(struct file *f, const char __user * uargs, int flags)
               ^~~~~~~~~~~~~~~~~~~~~
   kernel/module/main.c:3152:12: error: invalid storage class for function 'idempotent_init_module'
    static int idempotent_init_module(struct file *f, const char __user * uargs, int flags)
               ^~~~~~~~~~~~~~~~~~~~~~
   kernel/module/main.c:3170:1: warning: 'alias' attribute ignored [-Wattributes]
    SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
    ^~~~~~~~~~~~~~~
   In file included from kernel/module/main.c:26:0:
   include/linux/syscalls.h:247:21: error: invalid storage class for function '__do_sys_finit_module'
     static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
                        ^
   include/linux/syscalls.h:230:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:221:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   kernel/module/main.c:3170:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
    ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:249:18: error: static declaration of '__se_sys_finit_module' follows non-static declaration
     asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                     ^
   include/linux/syscalls.h:230:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:221:36: note: in expansion of macro 'SYSCALL_DEFINEx'


vim +/alias +3039 kernel/module/main.c

b99b87f70c7785 kernel/module.c      Peter Oberparleiter 2009-06-17  3038  
17da2bd90abf42 kernel/module.c      Heiko Carstens      2009-01-14 @3039  SYSCALL_DEFINE3(init_module, void __user *, umod,
17da2bd90abf42 kernel/module.c      Heiko Carstens      2009-01-14  3040  		unsigned long, len, const char __user *, uargs)
^1da177e4c3f41 kernel/module.c      Linus Torvalds      2005-04-16  3041  {
34e1169d996ab1 kernel/module.c      Kees Cook           2012-10-16  3042  	int err;
34e1169d996ab1 kernel/module.c      Kees Cook           2012-10-16  3043  	struct load_info info = { };
^1da177e4c3f41 kernel/module.c      Linus Torvalds      2005-04-16  3044  
34e1169d996ab1 kernel/module.c      Kees Cook           2012-10-16  3045  	err = may_init_module();
34e1169d996ab1 kernel/module.c      Kees Cook           2012-10-16  3046  	if (err)
34e1169d996ab1 kernel/module.c      Kees Cook           2012-10-16  3047  		return err;
^1da177e4c3f41 kernel/module.c      Linus Torvalds      2005-04-16  3048  
34e1169d996ab1 kernel/module.c      Kees Cook           2012-10-16  3049  	pr_debug("init_module: umod=%p, len=%lu, uargs=%p\n",
34e1169d996ab1 kernel/module.c      Kees Cook           2012-10-16  3050  	       umod, len, uargs);
^1da177e4c3f41 kernel/module.c      Linus Torvalds      2005-04-16  3051  
34e1169d996ab1 kernel/module.c      Kees Cook           2012-10-16  3052  	err = copy_module_from_user(umod, len, &info);
df3e764d8e5cd4 kernel/module/main.c Luis Chamberlain    2023-03-28  3053  	if (err) {
df3e764d8e5cd4 kernel/module/main.c Luis Chamberlain    2023-03-28  3054  		mod_stat_inc(&failed_kreads);
df3e764d8e5cd4 kernel/module/main.c Luis Chamberlain    2023-03-28  3055  		mod_stat_add_long(len, &invalid_kread_bytes);
34e1169d996ab1 kernel/module.c      Kees Cook           2012-10-16  3056  		return err;
df3e764d8e5cd4 kernel/module/main.c Luis Chamberlain    2023-03-28  3057  	}
^1da177e4c3f41 kernel/module.c      Linus Torvalds      2005-04-16  3058  
2f3238aebedb24 kernel/module.c      Rusty Russell       2012-10-22  3059  	return load_module(&info, uargs, 0);
e24e2e64c468c8 kernel/module.c      Alexey Dobriyan     2008-03-10  3060  }
94462ad3b14739 kernel/module.c      Steven Rostedt      2010-11-29  3061  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
