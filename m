Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DAC802135
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 07:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbjLCGHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 01:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbjLCGHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 01:07:43 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36140119
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 22:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701583669; x=1733119669;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OIFQCS8L757AxAPDyMhAY7hznLFvAEiZ3v2yO7c2P2M=;
  b=gYQ+3k3HSFu9K+KAPr8sMov0tydWPJEaJS+QMF5J79cYOG6VcEHuoMwV
   ZVgyQMwsvSyEOGBF4RhWcvBfVNTKS53wxqfhq/PFORkhzSAFDOF+OimGF
   CTLckzkoYaXxVex/EpzsDX/xlJK9u93qyjIxzS7gpNLyOFlV8Nu891Ra0
   PL/hIvaGNH8sV46FeytDmAr4iUMpCE6ZueekO/K6UIkJJ7s1tIppeVZye
   xEMye6iR+EJ7RaLqwb/HXmfGDTx94jtuTivR8eDzp7AYeg2GBscOHoOlX
   m2IXVvHM5IDXudfufQ4zpjJv5cYBEzxx1/zmkVQVEwjDkLPigjkYsnpzp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="373049300"
X-IronPort-AV: E=Sophos;i="6.04,246,1695711600"; 
   d="scan'208";a="373049300"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 22:07:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="770187873"
X-IronPort-AV: E=Sophos;i="6.04,246,1695711600"; 
   d="scan'208";a="770187873"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 02 Dec 2023 22:07:43 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9fdk-0006IA-39;
        Sun, 03 Dec 2023 06:07:40 +0000
Date:   Sun, 3 Dec 2023 14:07:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Calvin Owens <calvinowens@fb.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: fs/proc/base.c:1980:25: sparse: sparse: cast to restricted fmode_t
Message-ID: <202312021548.6AW6t0c8-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   815fb87b753055df2d9e50f6cd80eb10235fe3e9
commit: bdb4d100afe9818aebd1d98ced575c5ef143456c procfs: always expose /proc/<pid>/map_files/ and make it readable
date:   8 years ago
config: x86_64-alldefconfig (https://download.01.org/0day-ci/archive/20231202/202312021548.6AW6t0c8-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231202/202312021548.6AW6t0c8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312021548.6AW6t0c8-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/proc/base.c:1980:25: sparse: sparse: cast to restricted fmode_t
>> fs/proc/base.c:2039:42: sparse: sparse: cast from restricted fmode_t
   fs/proc/base.c:2138:48: sparse: sparse: cast from restricted fmode_t
   fs/proc/base.c:1033:24: sparse: sparse: context imbalance in 'oom_adj_read' - different lock contexts for basic block
   fs/proc/base.c:1136:24: sparse: sparse: context imbalance in 'oom_score_adj_read' - different lock contexts for basic block
   fs/proc/base.c:2166:13: sparse: sparse: context imbalance in 'timers_start' - wrong count at exit
   fs/proc/base.c:2192:36: sparse: sparse: context imbalance in 'timers_stop' - unexpected unlock
   fs/proc/base.c:3290:19: sparse: sparse: self-comparison always evaluates to false
   In file included from include/linux/kobject.h:21,
                    from include/linux/device.h:17,
                    from include/linux/node.h:17,
                    from include/linux/swap.h:10,
                    from fs/proc/base.c:66:
   include/linux/sysfs.h: In function 'sysfs_get_dirent':
   include/linux/sysfs.h:496:44: warning: pointer targets in passing argument 2 of 'kernfs_find_and_get' differ in signedness [-Wpointer-sign]
     496 |         return kernfs_find_and_get(parent, name);
         |                                            ^~~~
         |                                            |
         |                                            const unsigned char *
   In file included from include/linux/cgroup.h:19,
                    from include/linux/memcontrol.h:22,
                    from include/linux/swap.h:8:
   include/linux/kernfs.h:424:57: note: expected 'const char *' but argument is of type 'const unsigned char *'
     424 | kernfs_find_and_get(struct kernfs_node *kn, const char *name)
         |                                             ~~~~~~~~~~~~^~~~
   In file included from fs/proc/base.c:94:
   fs/proc/internal.h: In function 'name_to_int':
   fs/proc/internal.h:117:28: warning: pointer targets in initialization of 'const char *' from 'const unsigned char *' differ in signedness [-Wpointer-sign]
     117 |         const char *name = qstr->name;
         |                            ^~~~
   In file included from include/linux/fs.h:7,
                    from include/linux/proc_fs.h:8,
                    from fs/proc/base.c:54:
   fs/proc/base.c: In function 'proc_fill_cache':
   fs/proc/base.c:1814:39: warning: pointer targets in initialization of 'const unsigned char *' from 'const char *' differ in signedness [-Wpointer-sign]
    1814 |         struct qstr qname = QSTR_INIT(name, len);
         |                                       ^~~~
   include/linux/dcache.h:54:52: note: in definition of macro 'QSTR_INIT'
      54 | #define QSTR_INIT(n,l) { { { .len = l } }, .name = n }
         |                                                    ^
   fs/proc/base.c:1814:39: note: (near initialization for 'qname.name')
    1814 |         struct qstr qname = QSTR_INIT(name, len);
         |                                       ^~~~
   include/linux/dcache.h:54:52: note: in definition of macro 'QSTR_INIT'
      54 | #define QSTR_INIT(n,l) { { { .len = l } }, .name = n }
         |                                                    ^
   fs/proc/base.c: In function 'dname_to_vma_addr':
   fs/proc/base.c:1846:34: warning: pointer targets in passing argument 1 of 'sscanf' differ in signedness [-Wpointer-sign]
    1846 |         if (sscanf(dentry->d_name.name, "%lx-%lx", start, end) != 2)
         |                    ~~~~~~~~~~~~~~^~~~~
         |                                  |
         |                                  const unsigned char *
   In file included from include/asm-generic/bug.h:13,
                    from arch/x86/include/asm/bug.h:35,
                    from include/linux/bug.h:4,
                    from include/linux/thread_info.h:11,
                    from arch/x86/include/asm/uaccess.h:8,
                    from fs/proc/base.c:50:
   include/linux/kernel.h:418:12: note: expected 'const char *' but argument is of type 'const unsigned char *'
     418 | int sscanf(const char *, const char *, ...);
         |            ^~~~~~~~~~~~
   fs/proc/base.c: In function 'proc_map_files_readdir':
   fs/proc/base.c:2123:49: warning: pointer targets in passing argument 1 of 'snprintf' differ in signedness [-Wpointer-sign]
    2123 |                         info.len = snprintf(info.name,
         |                                             ~~~~^~~~~
         |                                                 |
         |                                                 unsigned char *
   include/linux/kernel.h:405:20: note: expected 'char *' but argument is of type 'unsigned char *'
     405 | int snprintf(char *buf, size_t size, const char *fmt, ...);
         |              ~~~~~~^~~
   fs/proc/base.c:2135:40: warning: pointer targets in passing argument 3 of 'proc_fill_cache' differ in signedness [-Wpointer-sign]
    2135 |                                       p->name, p->len,
         |                                       ~^~~~~~
         |                                        |
         |                                        unsigned char *
   fs/proc/base.c:1810:21: note: expected 'const char *' but argument is of type 'unsigned char *'
    1810 |         const char *name, int len,
         |         ~~~~~~~~~~~~^~~~
   fs/proc/base.c: In function 'proc_flush_task_mnt':
   fs/proc/base.c:2876:19: warning: pointer targets in assignment from 'char *' to 'const unsigned char *' differ in signedness [-Wpointer-sign]
    2876 |         name.name = buf;
         |                   ^
   fs/proc/base.c:2888:19: warning: pointer targets in assignment from 'char *' to 'const unsigned char *' differ in signedness [-Wpointer-sign]
    2888 |         name.name = buf;
         |                   ^
   fs/proc/base.c:2894:19: warning: pointer targets in assignment from 'char *' to 'const unsigned char *' differ in signedness [-Wpointer-sign]
    2894 |         name.name = "task";
         |                   ^
   fs/proc/base.c:2895:31: warning: pointer targets in passing argument 1 of 'strlen' differ in signedness [-Wpointer-sign]
    2895 |         name.len = strlen(name.name);
         |                           ~~~~^~~~~
         |                               |
         |                               const unsigned char *
   In file included from arch/x86/include/asm/string.h:4,
                    from include/linux/string.h:17,
                    from include/linux/dynamic_debug.h:111,
                    from include/linux/printk.h:277,
                    from include/linux/kernel.h:13:
   arch/x86/include/asm/string_64.h:64:27: note: expected 'const char *' but argument is of type 'const unsigned char *'
      64 | size_t strlen(const char *s);
         |               ~~~~~~~~~~~~^
   fs/proc/base.c:2900:19: warning: pointer targets in assignment from 'char *' to 'const unsigned char *' differ in signedness [-Wpointer-sign]

vim +1980 fs/proc/base.c

bdb4d100afe981 Calvin Owens         2015-09-09  1975  
c52a47ace7ef58 Al Viro              2013-06-15  1976  static int
640708a2cff7f8 Pavel Emelyanov      2012-01-10  1977  proc_map_files_instantiate(struct inode *dir, struct dentry *dentry,
640708a2cff7f8 Pavel Emelyanov      2012-01-10  1978  			   struct task_struct *task, const void *ptr)
640708a2cff7f8 Pavel Emelyanov      2012-01-10  1979  {
7b540d0646ce12 Al Viro              2012-08-27 @1980  	fmode_t mode = (fmode_t)(unsigned long)ptr;
640708a2cff7f8 Pavel Emelyanov      2012-01-10  1981  	struct proc_inode *ei;
640708a2cff7f8 Pavel Emelyanov      2012-01-10  1982  	struct inode *inode;
640708a2cff7f8 Pavel Emelyanov      2012-01-10  1983  
640708a2cff7f8 Pavel Emelyanov      2012-01-10  1984  	inode = proc_pid_make_inode(dir->i_sb, task);
640708a2cff7f8 Pavel Emelyanov      2012-01-10  1985  	if (!inode)
c52a47ace7ef58 Al Viro              2013-06-15  1986  		return -ENOENT;
640708a2cff7f8 Pavel Emelyanov      2012-01-10  1987  
640708a2cff7f8 Pavel Emelyanov      2012-01-10  1988  	ei = PROC_I(inode);
640708a2cff7f8 Pavel Emelyanov      2012-01-10  1989  	ei->op.proc_get_link = proc_map_files_get_link;
640708a2cff7f8 Pavel Emelyanov      2012-01-10  1990  
bdb4d100afe981 Calvin Owens         2015-09-09  1991  	inode->i_op = &proc_map_files_link_inode_operations;
640708a2cff7f8 Pavel Emelyanov      2012-01-10  1992  	inode->i_size = 64;
640708a2cff7f8 Pavel Emelyanov      2012-01-10  1993  	inode->i_mode = S_IFLNK;
640708a2cff7f8 Pavel Emelyanov      2012-01-10  1994  
7b540d0646ce12 Al Viro              2012-08-27  1995  	if (mode & FMODE_READ)
640708a2cff7f8 Pavel Emelyanov      2012-01-10  1996  		inode->i_mode |= S_IRUSR;
7b540d0646ce12 Al Viro              2012-08-27  1997  	if (mode & FMODE_WRITE)
640708a2cff7f8 Pavel Emelyanov      2012-01-10  1998  		inode->i_mode |= S_IWUSR;
640708a2cff7f8 Pavel Emelyanov      2012-01-10  1999  
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2000  	d_set_d_op(dentry, &tid_map_files_dentry_operations);
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2001  	d_add(dentry, inode);
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2002  
c52a47ace7ef58 Al Viro              2013-06-15  2003  	return 0;
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2004  }
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2005  
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2006  static struct dentry *proc_map_files_lookup(struct inode *dir,
00cd8dd3bf95f2 Al Viro              2012-06-10  2007  		struct dentry *dentry, unsigned int flags)
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2008  {
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2009  	unsigned long vm_start, vm_end;
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2010  	struct vm_area_struct *vma;
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2011  	struct task_struct *task;
c52a47ace7ef58 Al Viro              2013-06-15  2012  	int result;
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2013  	struct mm_struct *mm;
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2014  
c52a47ace7ef58 Al Viro              2013-06-15  2015  	result = -ENOENT;
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2016  	task = get_proc_task(dir);
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2017  	if (!task)
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2018  		goto out;
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2019  
c52a47ace7ef58 Al Viro              2013-06-15  2020  	result = -EACCES;
eb94cd96e05d6c Cyrill Gorcunov      2012-05-17  2021  	if (!ptrace_may_access(task, PTRACE_MODE_READ))
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2022  		goto out_put_task;
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2023  
c52a47ace7ef58 Al Viro              2013-06-15  2024  	result = -ENOENT;
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2025  	if (dname_to_vma_addr(dentry, &vm_start, &vm_end))
eb94cd96e05d6c Cyrill Gorcunov      2012-05-17  2026  		goto out_put_task;
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2027  
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2028  	mm = get_task_mm(task);
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2029  	if (!mm)
eb94cd96e05d6c Cyrill Gorcunov      2012-05-17  2030  		goto out_put_task;
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2031  
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2032  	down_read(&mm->mmap_sem);
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2033  	vma = find_exact_vma(mm, vm_start, vm_end);
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2034  	if (!vma)
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2035  		goto out_no_vma;
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2036  
05f564849d4949 Stanislav Kinsbursky 2012-11-26  2037  	if (vma->vm_file)
7b540d0646ce12 Al Viro              2012-08-27  2038  		result = proc_map_files_instantiate(dir, dentry, task,
7b540d0646ce12 Al Viro              2012-08-27 @2039  				(void *)(unsigned long)vma->vm_file->f_mode);
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2040  
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2041  out_no_vma:
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2042  	up_read(&mm->mmap_sem);
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2043  	mmput(mm);
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2044  out_put_task:
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2045  	put_task_struct(task);
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2046  out:
c52a47ace7ef58 Al Viro              2013-06-15  2047  	return ERR_PTR(result);
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2048  }
640708a2cff7f8 Pavel Emelyanov      2012-01-10  2049  

:::::: The code at line 1980 was first introduced by commit
:::::: 7b540d0646ce122f0ba4520412be91e530719742 proc_map_files_readdir(): don't bother with grabbing files

:::::: TO: Al Viro <viro@zeniv.linux.org.uk>
:::::: CC: Al Viro <viro@zeniv.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
