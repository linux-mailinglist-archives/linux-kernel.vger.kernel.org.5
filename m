Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358867C50B7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346404AbjJKLB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbjJKLBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:01:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A933ECA;
        Wed, 11 Oct 2023 04:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697022106; x=1728558106;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FFVqrovjDvv5Jh/zjHox4ZbBkiWZwIlMQABP5KPnY+w=;
  b=igbfSeQ/POtYXAIL6PT77+4AUwrb8Poxn3QlUlAkbVl6+9aOlBhlLNNP
   auPmqYYwW9BF/+k6oRTtV7fd55HwmIkUDOnPZE51m8j5zvWB/kRbRv9N4
   Kb+tsRJG5VwiUw16TWX2mb4n5k9juDnbS5Sda8Hbn6AvzESuxlXAatc5h
   dXlHmsSgeLW6wgGhumWgDGcNusgqVcC2RNiwVd99mQVDQnY7TImjZve1u
   rYeat9xo3gOG2fXwUjD5uEiHkHxBWe89XxS6w1sVDawwMl4owMUykLvoR
   5CR8uU+dzlTeurRGuM6DSMA/MT6uDSCe1Djw3h7umL8HVDAFLjLSrv12E
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="388502215"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="388502215"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 04:01:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="783206041"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="783206041"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 11 Oct 2023 04:01:43 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qqWyD-00028X-1J;
        Wed, 11 Oct 2023 11:01:41 +0000
Date:   Wed, 11 Oct 2023 19:01:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Joey Jiao <quic_jiangenj@quicinc.com>,
        linux-modules@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, quic_jiangenj@quicinc.com,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] module: Add CONFIG_MODULE_LOAD_IN_SEQUENCE option
Message-ID: <202310111840.ufGoxyfM-lkp@intel.com>
References: <20231011074438.6098-1-quic_jiangenj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011074438.6098-1-quic_jiangenj@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joey,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mcgrof/modules-next]
[also build test WARNING on linus/master v6.6-rc5 next-20231011]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joey-Jiao/module-Add-CONFIG_MODULE_LOAD_IN_SEQUENCE-option/20231011-154640
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git modules-next
patch link:    https://lore.kernel.org/r/20231011074438.6098-1-quic_jiangenj%40quicinc.com
patch subject: [PATCH v2] module: Add CONFIG_MODULE_LOAD_IN_SEQUENCE option
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231011/202310111840.ufGoxyfM-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231011/202310111840.ufGoxyfM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310111840.ufGoxyfM-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/module/main.c: In function 'do_init_module':
   kernel/module/main.c:2627:12: error: invalid storage class for function 'may_init_module'
    2627 | static int may_init_module(void)
         |            ^~~~~~~~~~~~~~~
   kernel/module/main.c:2636:13: error: invalid storage class for function 'finished_loading'
    2636 | static bool finished_loading(const char *name)
         |             ^~~~~~~~~~~~~~~~
   kernel/module/main.c:2657:12: error: invalid storage class for function 'module_patient_check_exists'
    2657 | static int module_patient_check_exists(const char *name,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/module/main.c:2701:12: error: invalid storage class for function 'add_unformed_module'
    2701 | static int add_unformed_module(struct module *mod)
         |            ^~~~~~~~~~~~~~~~~~~
   kernel/module/main.c:2722:12: error: invalid storage class for function 'complete_formation'
    2722 | static int complete_formation(struct module *mod, struct load_info *info)
         |            ^~~~~~~~~~~~~~~~~~
   kernel/module/main.c:2755:12: error: invalid storage class for function 'prepare_coming_module'
    2755 | static int prepare_coming_module(struct module *mod)
         |            ^~~~~~~~~~~~~~~~~~~~~
   kernel/module/main.c:2773:12: error: invalid storage class for function 'unknown_module_param_cb'
    2773 | static int unknown_module_param_cb(char *param, char *val, const char *modname,
         |            ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/module/main.c:2793:12: error: invalid storage class for function 'early_mod_check'
    2793 | static int early_mod_check(struct load_info *info, int flags)
         |            ^~~~~~~~~~~~~~~
   kernel/module/main.c:2829:12: error: invalid storage class for function 'load_module'
    2829 | static int load_module(struct load_info *info, const char __user *uargs,
         |            ^~~~~~~~~~~
   In file included from include/linux/compiler_types.h:125,
                    from <command-line>:
>> include/linux/compiler-gcc.h:132:33: warning: 'alias' attribute ignored [-Wattributes]
     132 | #define __diag(s)               _Pragma(__diag_str(GCC diagnostic s))
         |                                 ^~~~~~~
   include/linux/compiler-gcc.h:135:33: note: in expansion of macro '__diag'
     135 | #define __diag_GCC_8(s)         __diag(s)
         |                                 ^~~~~~
   include/linux/compiler-gcc.h:123:9: note: in expansion of macro '__diag_GCC_8'
     123 |         __diag_GCC_ ## version(__diag_GCC_ ## severity s)
         |         ^~~~~~~~~~~
   include/linux/compiler_types.h:416:9: note: in expansion of macro '__diag_GCC'
     416 |         __diag_ ## compiler(version, ignore, option)
         |         ^~~~~~~
   include/linux/syscalls.h:242:9: note: in expansion of macro '__diag_ignore'
     242 |         __diag_ignore(GCC, 8, "-Wattribute-alias",                      \
         |         ^~~~~~~~~~~~~
   include/linux/syscalls.h:230:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     230 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:221:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     221 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/module/main.c:3039:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    3039 | SYSCALL_DEFINE3(init_module, void __user *, umod,
         | ^~~~~~~~~~~~~~~
   In file included from kernel/module/main.c:26:
   include/linux/syscalls.h:247:28: error: invalid storage class for function '__do_sys_init_module'
     247 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
         |                            ^~~~~~~~
   include/linux/syscalls.h:230:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     230 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:221:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     221 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/module/main.c:3039:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    3039 | SYSCALL_DEFINE3(init_module, void __user *, umod,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:249:25: error: static declaration of '__se_sys_init_module' follows non-static declaration
     249 |         asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))  \
         |                         ^~~~~~~~
   include/linux/syscalls.h:230:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     230 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:221:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     221 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/module/main.c:3039:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    3039 | SYSCALL_DEFINE3(init_module, void __user *, umod,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:248:25: note: previous declaration of '__se_sys_init_module' with type 'long int(long int,  long int,  long int)'
     248 |         asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)); \
         |                         ^~~~~~~~
   include/linux/syscalls.h:230:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     230 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:221:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     221 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/module/main.c:3039:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    3039 | SYSCALL_DEFINE3(init_module, void __user *, umod,
         | ^~~~~~~~~~~~~~~
   kernel/module/main.c: In function '__se_sys_init_module':
   include/linux/syscalls.h:251:28: error: implicit declaration of function '__do_sys_init_module'; did you mean '__se_sys_init_module'? [-Werror=implicit-function-declaration]
     251 |                 long ret = __do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));\
         |                            ^~~~~~~~
   include/linux/syscalls.h:230:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     230 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:221:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     221 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/module/main.c:3039:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    3039 | SYSCALL_DEFINE3(init_module, void __user *, umod,
         | ^~~~~~~~~~~~~~~
   kernel/module/main.c: In function 'do_init_module':
   include/linux/syscalls.h:257:28: error: invalid storage class for function '__do_sys_init_module'
     257 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
         |                            ^~~~~~~~
   include/linux/syscalls.h:230:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     230 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:221:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     221 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/module/main.c:3039:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    3039 | SYSCALL_DEFINE3(init_module, void __user *, umod,
         | ^~~~~~~~~~~~~~~
   kernel/module/main.c:3073:13: error: invalid storage class for function 'idempotent'
    3073 | static bool idempotent(struct idempotent *u, const void *cookie)
         |             ^~~~~~~~~~
   kernel/module/main.c:3104:12: error: invalid storage class for function 'idempotent_complete'
    3104 | static int idempotent_complete(struct idempotent *u, int ret)
         |            ^~~~~~~~~~~~~~~~~~~
   kernel/module/main.c:3124:12: error: invalid storage class for function 'init_module_from_file'
    3124 | static int init_module_from_file(struct file *f, const char __user * uargs, int flags)
         |            ^~~~~~~~~~~~~~~~~~~~~
   kernel/module/main.c:3152:12: error: invalid storage class for function 'idempotent_init_module'
    3152 | static int idempotent_init_module(struct file *f, const char __user * uargs, int flags)
         |            ^~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler-gcc.h:132:33: warning: 'alias' attribute ignored [-Wattributes]
     132 | #define __diag(s)               _Pragma(__diag_str(GCC diagnostic s))
         |                                 ^~~~~~~
   include/linux/compiler-gcc.h:135:33: note: in expansion of macro '__diag'
     135 | #define __diag_GCC_8(s)         __diag(s)
         |                                 ^~~~~~
   include/linux/compiler-gcc.h:123:9: note: in expansion of macro '__diag_GCC_8'
     123 |         __diag_GCC_ ## version(__diag_GCC_ ## severity s)
         |         ^~~~~~~~~~~
   include/linux/compiler_types.h:416:9: note: in expansion of macro '__diag_GCC'
     416 |         __diag_ ## compiler(version, ignore, option)
         |         ^~~~~~~
   include/linux/syscalls.h:242:9: note: in expansion of macro '__diag_ignore'
     242 |         __diag_ignore(GCC, 8, "-Wattribute-alias",                      \
         |         ^~~~~~~~~~~~~
   include/linux/syscalls.h:230:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     230 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:221:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     221 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/module/main.c:3170:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    3170 | SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:247:28: error: invalid storage class for function '__do_sys_finit_module'
     247 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
         |                            ^~~~~~~~
   include/linux/syscalls.h:230:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     230 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:221:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     221 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/module/main.c:3170:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    3170 | SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:249:25: error: static declaration of '__se_sys_finit_module' follows non-static declaration
     249 |         asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))  \
         |                         ^~~~~~~~
   include/linux/syscalls.h:230:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     230 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:221:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     221 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/module/main.c:3170:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    3170 | SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:248:25: note: previous declaration of '__se_sys_finit_module' with type 'long int(long int,  long int,  long int)'
     248 |         asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)); \
         |                         ^~~~~~~~
   include/linux/syscalls.h:230:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     230 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:221:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     221 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/module/main.c:3170:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    3170 | SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
         | ^~~~~~~~~~~~~~~
   kernel/module/main.c: In function '__se_sys_finit_module':
   include/linux/syscalls.h:251:28: error: implicit declaration of function '__do_sys_finit_module'; did you mean '__do_sys_init_module'? [-Werror=implicit-function-declaration]
     251 |                 long ret = __do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));\
         |                            ^~~~~~~~
   include/linux/syscalls.h:230:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     230 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:221:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     221 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/module/main.c:3170:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    3170 | SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
         | ^~~~~~~~~~~~~~~
   kernel/module/main.c: In function 'do_init_module':
   include/linux/syscalls.h:257:28: error: invalid storage class for function '__do_sys_finit_module'
     257 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
         |                            ^~~~~~~~
   include/linux/syscalls.h:230:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     230 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:221:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     221 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/module/main.c:3170:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    3170 | SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
         | ^~~~~~~~~~~~~~~
   kernel/module/main.c:3361:12: error: invalid storage class for function 'module_debugfs_init'
    3361 | static int module_debugfs_init(void)
         |            ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/printk.h:6,
                    from include/asm-generic/bug.h:22,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from arch/m68k/include/asm/irqflags.h:6,
                    from include/linux/irqflags.h:17,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:7,
                    from include/linux/mm_types_task.h:13,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from include/linux/moduleloader.h:6,
                    from kernel/module/main.c:12:
   kernel/module/main.c:3366:13: error: initializer element is not constant
    3366 | module_init(module_debugfs_init);
         |             ^~~~~~~~~~~~~~~~~~~
   include/linux/init.h:270:55: note: in definition of macro '____define_initcall'
     270 |                 __attribute__((__section__(__sec))) = fn;
         |                                                       ^~
   include/linux/init.h:280:9: note: in expansion of macro '__unique_initcall'
     280 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:282:35: note: in expansion of macro '___define_initcall'
     282 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:311:41: note: in expansion of macro '__define_initcall'
     311 | #define device_initcall(fn)             __define_initcall(fn, 6)
         |                                         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:316:24: note: in expansion of macro 'device_initcall'
     316 | #define __initcall(fn) device_initcall(fn)
         |                        ^~~~~~~~~~~~~~~
   include/linux/module.h:88:25: note: in expansion of macro '__initcall'
      88 | #define module_init(x)  __initcall(x);
         |                         ^~~~~~~~~~
   kernel/module/main.c:3366:1: note: in expansion of macro 'module_init'
    3366 | module_init(module_debugfs_init);
         | ^~~~~~~~~~~
   kernel/module/main.c:3366:1: error: expected declaration or statement at end of input
>> kernel/module/main.c:3359:16: warning: variable 'mod_debugfs_root' set but not used [-Wunused-but-set-variable]
    3359 | struct dentry *mod_debugfs_root;
         |                ^~~~~~~~~~~~~~~~
   kernel/module/main.c: At top level:
>> kernel/module/main.c:3336:6: warning: 'print_modules' defined but not used [-Wunused-function]
    3336 | void print_modules(void)
         |      ^~~~~~~~~~~~~
>> kernel/module/main.c:3323:16: warning: '__module_text_address' defined but not used [-Wunused-function]
    3323 | struct module *__module_text_address(unsigned long addr)
         |                ^~~~~~~~~~~~~~~~~~~~~
>> kernel/module/main.c:3305:6: warning: 'is_module_text_address' defined but not used [-Wunused-function]
    3305 | bool is_module_text_address(unsigned long addr)
         |      ^~~~~~~~~~~~~~~~~~~~~~
>> kernel/module/main.c:3253:6: warning: 'is_module_address' defined but not used [-Wunused-function]
    3253 | bool is_module_address(unsigned long addr)
         |      ^~~~~~~~~~~~~~~~~
>> kernel/module/main.c:3220:37: warning: 'search_module_extables' defined but not used [-Wunused-function]
    3220 | const struct exception_table_entry *search_module_extables(unsigned long addr)
         |                                     ^~~~~~~~~~~~~~~~~~~~~~
>> include/linux/syscalls.h:249:25: warning: '__se_sys_finit_module' defined but not used [-Wunused-function]
     249 |         asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))  \
         |                         ^~~~~~~~
   include/linux/syscalls.h:230:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     230 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:221:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     221 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/module/main.c:3170:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    3170 | SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
         | ^~~~~~~~~~~~~~~
>> include/linux/syscalls.h:249:25: warning: '__se_sys_init_module' defined but not used [-Wunused-function]
     249 |         asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))  \
         |                         ^~~~~~~~
   include/linux/syscalls.h:230:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     230 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:221:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     221 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/module/main.c:3039:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    3039 | SYSCALL_DEFINE3(init_module, void __user *, umod,
         | ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/mod_debugfs_root +3359 kernel/module/main.c

fa3ba2e81ea23416 kernel/module.c      Florin Malita    2006-10-11  3218  
^1da177e4c3f4152 kernel/module.c      Linus Torvalds   2005-04-16  3219  /* Given an address, look for it in the module exception tables. */
^1da177e4c3f4152 kernel/module.c      Linus Torvalds   2005-04-16 @3220  const struct exception_table_entry *search_module_extables(unsigned long addr)
^1da177e4c3f4152 kernel/module.c      Linus Torvalds   2005-04-16  3221  {
^1da177e4c3f4152 kernel/module.c      Linus Torvalds   2005-04-16  3222  	const struct exception_table_entry *e = NULL;
^1da177e4c3f4152 kernel/module.c      Linus Torvalds   2005-04-16  3223  	struct module *mod;
^1da177e4c3f4152 kernel/module.c      Linus Torvalds   2005-04-16  3224  
24da1cbff9cfce50 kernel/module.c      Rusty Russell    2007-07-15  3225  	preempt_disable();
5ff22646d246e23b kernel/module.c      Peter Zijlstra   2017-02-08  3226  	mod = __module_address(addr);
5ff22646d246e23b kernel/module.c      Peter Zijlstra   2017-02-08  3227  	if (!mod)
5ff22646d246e23b kernel/module.c      Peter Zijlstra   2017-02-08  3228  		goto out;
5ff22646d246e23b kernel/module.c      Peter Zijlstra   2017-02-08  3229  
5ff22646d246e23b kernel/module.c      Peter Zijlstra   2017-02-08  3230  	if (!mod->num_exentries)
5ff22646d246e23b kernel/module.c      Peter Zijlstra   2017-02-08  3231  		goto out;
^1da177e4c3f4152 kernel/module.c      Linus Torvalds   2005-04-16  3232  
^1da177e4c3f4152 kernel/module.c      Linus Torvalds   2005-04-16  3233  	e = search_extable(mod->extable,
a94c33dd1f677d16 kernel/module.c      Thomas Meyer     2017-07-10  3234  			   mod->num_exentries,
^1da177e4c3f4152 kernel/module.c      Linus Torvalds   2005-04-16  3235  			   addr);
5ff22646d246e23b kernel/module.c      Peter Zijlstra   2017-02-08  3236  out:
24da1cbff9cfce50 kernel/module.c      Rusty Russell    2007-07-15  3237  	preempt_enable();
^1da177e4c3f4152 kernel/module.c      Linus Torvalds   2005-04-16  3238  
5ff22646d246e23b kernel/module.c      Peter Zijlstra   2017-02-08  3239  	/*
5ff22646d246e23b kernel/module.c      Peter Zijlstra   2017-02-08  3240  	 * Now, if we found one, we are running inside it now, hence
5ff22646d246e23b kernel/module.c      Peter Zijlstra   2017-02-08  3241  	 * we cannot unload the module, hence no refcnt needed.
5ff22646d246e23b kernel/module.c      Peter Zijlstra   2017-02-08  3242  	 */
^1da177e4c3f4152 kernel/module.c      Linus Torvalds   2005-04-16  3243  	return e;
^1da177e4c3f4152 kernel/module.c      Linus Torvalds   2005-04-16  3244  }
^1da177e4c3f4152 kernel/module.c      Linus Torvalds   2005-04-16  3245  
2541743e99c301f9 kernel/module.c      Sergey Shtylyov  2020-11-04  3246  /**
2541743e99c301f9 kernel/module.c      Sergey Shtylyov  2020-11-04  3247   * is_module_address() - is this address inside a module?
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3248   * @addr: the address to check.
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3249   *
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3250   * See is_module_text_address() if you simply want to see if the address
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3251   * is code (not data).
4d435f9d8ff01ae7 kernel/module.c      Ingo Molnar      2006-07-03  3252   */
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31 @3253  bool is_module_address(unsigned long addr)
4d435f9d8ff01ae7 kernel/module.c      Ingo Molnar      2006-07-03  3254  {
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3255  	bool ret;
4d435f9d8ff01ae7 kernel/module.c      Ingo Molnar      2006-07-03  3256  
24da1cbff9cfce50 kernel/module.c      Rusty Russell    2007-07-15  3257  	preempt_disable();
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3258  	ret = __module_address(addr) != NULL;
24da1cbff9cfce50 kernel/module.c      Rusty Russell    2007-07-15  3259  	preempt_enable();
4d435f9d8ff01ae7 kernel/module.c      Ingo Molnar      2006-07-03  3260  
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3261  	return ret;
4d435f9d8ff01ae7 kernel/module.c      Ingo Molnar      2006-07-03  3262  }
4d435f9d8ff01ae7 kernel/module.c      Ingo Molnar      2006-07-03  3263  
2541743e99c301f9 kernel/module.c      Sergey Shtylyov  2020-11-04  3264  /**
2541743e99c301f9 kernel/module.c      Sergey Shtylyov  2020-11-04  3265   * __module_address() - get the module which contains an address.
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3266   * @addr: the address.
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3267   *
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3268   * Must be called with preempt disabled or module mutex held so that
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3269   * module doesn't get freed during this.
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3270   */
714f83d5d9f7c785 kernel/module.c      Linus Torvalds   2009-04-05  3271  struct module *__module_address(unsigned long addr)
^1da177e4c3f4152 kernel/module.c      Linus Torvalds   2005-04-16  3272  {
^1da177e4c3f4152 kernel/module.c      Linus Torvalds   2005-04-16  3273  	struct module *mod;
^1da177e4c3f4152 kernel/module.c      Linus Torvalds   2005-04-16  3274  
01dc0386efb76905 kernel/module/main.c Christophe Leroy 2022-02-23  3275  	if (addr >= mod_tree.addr_min && addr <= mod_tree.addr_max)
ac3b432839234409 kernel/module/main.c Song Liu         2023-02-06  3276  		goto lookup;
ac3b432839234409 kernel/module/main.c Song Liu         2023-02-06  3277  
01dc0386efb76905 kernel/module/main.c Christophe Leroy 2022-02-23  3278  #ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
ac3b432839234409 kernel/module/main.c Song Liu         2023-02-06  3279  	if (addr >= mod_tree.data_addr_min && addr <= mod_tree.data_addr_max)
ac3b432839234409 kernel/module/main.c Song Liu         2023-02-06  3280  		goto lookup;
01dc0386efb76905 kernel/module/main.c Christophe Leroy 2022-02-23  3281  #endif
ac3b432839234409 kernel/module/main.c Song Liu         2023-02-06  3282  
3a642e99babe0617 kernel/module.c      Rusty Russell    2008-07-22  3283  	return NULL;
3a642e99babe0617 kernel/module.c      Rusty Russell    2008-07-22  3284  
ac3b432839234409 kernel/module/main.c Song Liu         2023-02-06  3285  lookup:
0be964be0d450842 kernel/module.c      Peter Zijlstra   2015-05-27  3286  	module_assert_mutex_or_preempt();
0be964be0d450842 kernel/module.c      Peter Zijlstra   2015-05-27  3287  
ac3b432839234409 kernel/module/main.c Song Liu         2023-02-06  3288  	mod = mod_find(addr, &mod_tree);
93c2e105f6bcee23 kernel/module.c      Peter Zijlstra   2015-05-27  3289  	if (mod) {
93c2e105f6bcee23 kernel/module.c      Peter Zijlstra   2015-05-27  3290  		BUG_ON(!within_module(addr, mod));
0d21b0e3477395e7 kernel/module.c      Rusty Russell    2013-01-12  3291  		if (mod->state == MODULE_STATE_UNFORMED)
93c2e105f6bcee23 kernel/module.c      Peter Zijlstra   2015-05-27  3292  			mod = NULL;
0d21b0e3477395e7 kernel/module.c      Rusty Russell    2013-01-12  3293  	}
93c2e105f6bcee23 kernel/module.c      Peter Zijlstra   2015-05-27  3294  	return mod;
^1da177e4c3f4152 kernel/module.c      Linus Torvalds   2005-04-16  3295  }
^1da177e4c3f4152 kernel/module.c      Linus Torvalds   2005-04-16  3296  
2541743e99c301f9 kernel/module.c      Sergey Shtylyov  2020-11-04  3297  /**
2541743e99c301f9 kernel/module.c      Sergey Shtylyov  2020-11-04  3298   * is_module_text_address() - is this address inside module code?
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3299   * @addr: the address to check.
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3300   *
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3301   * See is_module_address() if you simply want to see if the address is
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3302   * anywhere in a module.  See kernel_text_address() for testing if an
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3303   * address corresponds to kernel or module code.
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3304   */
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31 @3305  bool is_module_text_address(unsigned long addr)
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3306  {
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3307  	bool ret;
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3308  
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3309  	preempt_disable();
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3310  	ret = __module_text_address(addr) != NULL;
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3311  	preempt_enable();
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3312  
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3313  	return ret;
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3314  }
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3315  
2541743e99c301f9 kernel/module.c      Sergey Shtylyov  2020-11-04  3316  /**
2541743e99c301f9 kernel/module.c      Sergey Shtylyov  2020-11-04  3317   * __module_text_address() - get the module whose code contains an address.
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3318   * @addr: the address.
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3319   *
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3320   * Must be called with preempt disabled or module mutex held so that
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3321   * module doesn't get freed during this.
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3322   */
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31 @3323  struct module *__module_text_address(unsigned long addr)
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3324  {
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3325  	struct module *mod = __module_address(addr);
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3326  	if (mod) {
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3327  		/* Make sure it's within the text section. */
ac3b432839234409 kernel/module/main.c Song Liu         2023-02-06  3328  		if (!within_module_mem_type(addr, mod, MOD_TEXT) &&
ac3b432839234409 kernel/module/main.c Song Liu         2023-02-06  3329  		    !within_module_mem_type(addr, mod, MOD_INIT_TEXT))
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3330  			mod = NULL;
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3331  	}
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3332  	return mod;
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3333  }
e610499e2656e619 kernel/module.c      Rusty Russell    2009-03-31  3334  
^1da177e4c3f4152 kernel/module.c      Linus Torvalds   2005-04-16  3335  /* Don't grab lock, we're oopsing. */
^1da177e4c3f4152 kernel/module.c      Linus Torvalds   2005-04-16 @3336  void print_modules(void)
^1da177e4c3f4152 kernel/module.c      Linus Torvalds   2005-04-16  3337  {
^1da177e4c3f4152 kernel/module.c      Linus Torvalds   2005-04-16  3338  	struct module *mod;
7fd8329ba502ef76 kernel/module.c      Petr Mladek      2016-09-21  3339  	char buf[MODULE_FLAGS_BUF_SIZE];
^1da177e4c3f4152 kernel/module.c      Linus Torvalds   2005-04-16  3340  
b231125af7811a2f kernel/module.c      Linus Torvalds   2009-06-16  3341  	printk(KERN_DEFAULT "Modules linked in:");
d72b37513cdfbd3f kernel/module.c      Andi Kleen       2008-08-30  3342  	/* Most callers should already have preempt disabled, but make sure */
d72b37513cdfbd3f kernel/module.c      Andi Kleen       2008-08-30  3343  	preempt_disable();
0d21b0e3477395e7 kernel/module.c      Rusty Russell    2013-01-12  3344  	list_for_each_entry_rcu(mod, &modules, list) {
0d21b0e3477395e7 kernel/module.c      Rusty Russell    2013-01-12  3345  		if (mod->state == MODULE_STATE_UNFORMED)
0d21b0e3477395e7 kernel/module.c      Rusty Russell    2013-01-12  3346  			continue;
17dd25c29cda98c3 kernel/module/main.c Aaron Tomlin     2022-07-14  3347  		pr_cont(" %s%s", mod->name, module_flags(mod, buf, true));
0d21b0e3477395e7 kernel/module.c      Rusty Russell    2013-01-12  3348  	}
99bd9956551b27cb kernel/module/main.c Aaron Tomlin     2022-05-02  3349  
99bd9956551b27cb kernel/module/main.c Aaron Tomlin     2022-05-02  3350  	print_unloaded_tainted_modules();
d72b37513cdfbd3f kernel/module.c      Andi Kleen       2008-08-30  3351  	preempt_enable();
6f1dae1d84b6d085 kernel/module/main.c Aaron Tomlin     2022-07-14  3352  	if (last_unloaded_module.name[0])
6f1dae1d84b6d085 kernel/module/main.c Aaron Tomlin     2022-07-14  3353  		pr_cont(" [last unloaded: %s%s]", last_unloaded_module.name,
6f1dae1d84b6d085 kernel/module/main.c Aaron Tomlin     2022-07-14  3354  			last_unloaded_module.taints);
27bba4d6bb3779a6 kernel/module.c      Jiri Slaby       2014-02-03  3355  	pr_cont("\n");
^1da177e4c3f4152 kernel/module.c      Linus Torvalds   2005-04-16  3356  }
df3e764d8e5cd416 kernel/module/main.c Luis Chamberlain 2023-03-28  3357  
df3e764d8e5cd416 kernel/module/main.c Luis Chamberlain 2023-03-28  3358  #ifdef CONFIG_MODULE_DEBUGFS
df3e764d8e5cd416 kernel/module/main.c Luis Chamberlain 2023-03-28 @3359  struct dentry *mod_debugfs_root;
df3e764d8e5cd416 kernel/module/main.c Luis Chamberlain 2023-03-28  3360  
df3e764d8e5cd416 kernel/module/main.c Luis Chamberlain 2023-03-28  3361  static int module_debugfs_init(void)
df3e764d8e5cd416 kernel/module/main.c Luis Chamberlain 2023-03-28  3362  {
df3e764d8e5cd416 kernel/module/main.c Luis Chamberlain 2023-03-28  3363  	mod_debugfs_root = debugfs_create_dir("modules", NULL);
df3e764d8e5cd416 kernel/module/main.c Luis Chamberlain 2023-03-28  3364  	return 0;
df3e764d8e5cd416 kernel/module/main.c Luis Chamberlain 2023-03-28  3365  }
df3e764d8e5cd416 kernel/module/main.c Luis Chamberlain 2023-03-28 @3366  module_init(module_debugfs_init);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
