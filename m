Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A687BEA8A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378273AbjJIT0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346671AbjJIT0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:26:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D46394
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 12:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696879602; x=1728415602;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=taLq4WF7cqgYx0Qy1UuRpVZnrwSgmYBEMGo5jZh7O6s=;
  b=ezEi1MyC8xsYyj+qRlSR6wHmmsav7xJ5LK8IS7UiOMDlM5/d93fN/EPj
   BzpMXCSMRW0iCNNaoEkL6rs16WBnKgvMfYT4hbmHVYIMGeJ06FP++xvsi
   +9OophzjxfKJFrAPosFml/DPQleIWqrfmd1hNfz7DUm/ms7f0UKwSXqH8
   F6Ow1rSPq+Z0FM1Oh5WyI6yhTDBGyheEjCKoypx6axWUjJaRYziWYKHoE
   yMWYREJD8VY39YVSsLU7b7CWlLnChWUHvazCvvKo/kUy6bup2tlwlQlvk
   sPVOE0SXExT4qBUm/hrLWKetRKuF2/JY/Ifcl1YysXrnnq4sKqfqEVk5z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="448424603"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="448424603"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 12:25:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="823449045"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="823449045"
Received: from lkp-server02.sh.intel.com (HELO 4ed589823ba4) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 09 Oct 2023 12:25:37 -0700
Received: from kbuild by 4ed589823ba4 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qpvsl-0000Zw-2Y;
        Mon, 09 Oct 2023 19:25:35 +0000
Date:   Tue, 10 Oct 2023 03:25:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/alpha/mm/init.c:265:1: error: no previous prototype for
 'srm_paging_stop'
Message-ID: <202310100311.WYXC5S24-lkp@intel.com>
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
head:   94f6f0550c625fab1f373bb86a6669b45e9748b3
commit: b1fbfcb4a20949df08dd995927cdc5ad220c128d kbuild: make single target builds even faster
date:   3 years, 11 months ago
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20231010/202310100311.WYXC5S24-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231010/202310100311.WYXC5S24-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310100311.WYXC5S24-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> init/main.c:494:20: warning: no previous prototype for 'arch_post_acpi_subsys_init' [-Wmissing-prototypes]
     494 | void __init __weak arch_post_acpi_subsys_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> init/main.c:506:20: warning: no previous prototype for 'mem_encrypt_init' [-Wmissing-prototypes]
     506 | void __init __weak mem_encrypt_init(void) { }
         |                    ^~~~~~~~~~~~~~~~
>> init/main.c:508:20: warning: no previous prototype for 'poking_init' [-Wmissing-prototypes]
     508 | void __init __weak poking_init(void) { }
         |                    ^~~~~~~~~~~
--
>> init/calibrate.c:261:37: warning: no previous prototype for 'calibrate_delay_is_known' [-Wmissing-prototypes]
     261 | unsigned long __attribute__((weak)) calibrate_delay_is_known(void)
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~
--
>> arch/alpha/mm/init.c:265:1: error: no previous prototype for 'srm_paging_stop' [-Werror=missing-prototypes]
     265 | srm_paging_stop (void)
         | ^~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
>> arch/alpha/mm/fault.c:84:1: error: no previous prototype for 'do_page_fault' [-Werror=missing-prototypes]
      84 | do_page_fault(unsigned long address, unsigned long mmcsr,
         | ^~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
>> kernel/fork.c:160:13: warning: no previous prototype for 'arch_release_task_struct' [-Wmissing-prototypes]
     160 | void __weak arch_release_task_struct(struct task_struct *tsk)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/fork.c:752:20: warning: no previous prototype for 'arch_task_cache_init' [-Wmissing-prototypes]
     752 | void __init __weak arch_task_cache_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~
>> kernel/fork.c:841:12: warning: no previous prototype for 'arch_dup_task_struct' [-Wmissing-prototypes]
     841 | int __weak arch_dup_task_struct(struct task_struct *dst,
         |            ^~~~~~~~~~~~~~~~~~~~
--
>> kernel/exit.c:1732:13: warning: no previous prototype for 'abort' [-Wmissing-prototypes]
    1732 | __weak void abort(void)
         |             ^~~~~
   In file included from include/linux/preempt.h:11,
                    from include/linux/spinlock.h:51,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:10,
                    from kernel/exit.c:8:
   In function '__list_add',
       inlined from 'list_add' at include/linux/list.h:79:2,
       inlined from 'exit_notify' at kernel/exit.c:677:3:
   include/linux/list.h:65:19: warning: storing the address of local variable 'dead' in '((struct list_head *)tsk)[44].prev' [-Wdangling-pointer=]
      65 |         new->prev = prev;
         |         ~~~~~~~~~~^~~~~~
   kernel/exit.c: In function 'exit_notify':
   kernel/exit.c:653:19: note: 'dead' declared here
     653 |         LIST_HEAD(dead);
         |                   ^~~~
   include/linux/list.h:24:26: note: in definition of macro 'LIST_HEAD'
      24 |         struct list_head name = LIST_HEAD_INIT(name)
         |                          ^~~~
   kernel/exit.c:649:45: note: 'tsk' declared here
     649 | static void exit_notify(struct task_struct *tsk, int group_dead)
         |                         ~~~~~~~~~~~~~~~~~~~~^~~
--
>> kernel/kallsyms.c:450:12: warning: no previous prototype for 'arch_get_kallsym' [-Wmissing-prototypes]
     450 | int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
         |            ^~~~~~~~~~~~~~~~
--
>> kernel/iomem.c:9:22: warning: no previous prototype for 'ioremap_cache' [-Wmissing-prototypes]
       9 | __weak void __iomem *ioremap_cache(resource_size_t offset, unsigned long size)
         |                      ^~~~~~~~~~~~~
--
>> fs/open.c:870: warning: Excess function parameter 'opened' description in 'finish_open'
>> fs/open.c:912: warning: Excess function parameter 'cred' description in 'vfs_open'
--
>> fs/read_write.c:88: warning: Function parameter or member 'maxsize' not described in 'generic_file_llseek_size'
>> fs/read_write.c:88: warning: Excess function parameter 'size' description in 'generic_file_llseek_size'
--
>> fs/d_path.c:311:7: warning: no previous prototype for 'simple_dname' [-Wmissing-prototypes]
     311 | char *simple_dname(struct dentry *dentry, char *buffer, int buflen)
         |       ^~~~~~~~~~~~
..


vim +/srm_paging_stop +265 arch/alpha/mm/init.c

^1da177e4c3f4152 Linus Torvalds 2005-04-16  262  
^1da177e4c3f4152 Linus Torvalds 2005-04-16  263  #if defined(CONFIG_ALPHA_GENERIC) || defined(CONFIG_ALPHA_SRM)
^1da177e4c3f4152 Linus Torvalds 2005-04-16  264  void
^1da177e4c3f4152 Linus Torvalds 2005-04-16 @265  srm_paging_stop (void)
^1da177e4c3f4152 Linus Torvalds 2005-04-16  266  {
^1da177e4c3f4152 Linus Torvalds 2005-04-16  267  	/* Move the vptb back to where the SRM console expects it.  */
^1da177e4c3f4152 Linus Torvalds 2005-04-16  268  	swapper_pg_dir[1] = swapper_pg_dir[1023];
^1da177e4c3f4152 Linus Torvalds 2005-04-16  269  	tbia();
^1da177e4c3f4152 Linus Torvalds 2005-04-16  270  	wrvptptr(0x200000000UL);
^1da177e4c3f4152 Linus Torvalds 2005-04-16  271  	hwrpb->vptb = 0x200000000UL;
^1da177e4c3f4152 Linus Torvalds 2005-04-16  272  	hwrpb_update_checksum(hwrpb);
^1da177e4c3f4152 Linus Torvalds 2005-04-16  273  
^1da177e4c3f4152 Linus Torvalds 2005-04-16  274  	/* Reload the page tables that the console had in use.  */
^1da177e4c3f4152 Linus Torvalds 2005-04-16  275  	load_PCB(&original_pcb);
^1da177e4c3f4152 Linus Torvalds 2005-04-16  276  	tbia();
^1da177e4c3f4152 Linus Torvalds 2005-04-16  277  }
^1da177e4c3f4152 Linus Torvalds 2005-04-16  278  #endif
^1da177e4c3f4152 Linus Torvalds 2005-04-16  279  

:::::: The code at line 265 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
