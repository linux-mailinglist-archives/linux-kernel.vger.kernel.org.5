Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBD57E8C51
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 20:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjKKTU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 14:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKKTUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 14:20:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40A7258E
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 11:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699730450; x=1731266450;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NbOIT+RDvuqSVD9FkD+kLts4kZoWLcH7vk25oq8H7bY=;
  b=GsaejA8ZUZEnxUlSFGL6S9NDuXXrSE9ZTXAys2UFZ6M/1PRFGl9HsWBj
   gocyZEdG2vfJLI9sSaS13iiKOui47PZYBWgGgInAaseboAy2EWL9Crglz
   HN2h4ICNxQ/h6b7qaIM5sEiGl888oO4Nxlz9wXkY682n5MXBy4uWRlVD+
   iW+0BOOj0XT+pQa3Iu2YRTQzQNZ2fVSr5SH0gavRjOKojU4jhEOizphW+
   EfZceXuOAZnQRuQoBdnoTTgI7JKJjTM44eyyvcbsEEchfCLy8plWMtlmv
   DWaeaavIy0wDN5g7WyhR+2l4iKH5N1VAZ54DvyjSOI5LwlwX6Zveqdfhg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="8938693"
X-IronPort-AV: E=Sophos;i="6.03,295,1694761200"; 
   d="scan'208";a="8938693"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 11:20:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="798839136"
X-IronPort-AV: E=Sophos;i="6.03,295,1694761200"; 
   d="scan'208";a="798839136"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 11 Nov 2023 11:20:47 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1tXB-000Ahl-09;
        Sat, 11 Nov 2023 19:20:45 +0000
Date:   Sun, 12 Nov 2023 03:19:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: fs/file.c:351:17: sparse: sparse: incompatible types in comparison
 expression (different address spaces):
Message-ID: <202311120246.W8nrgLDN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3ca112b71f35dd5d99fc4571a56b5fc6f0c15814
commit: 423a86a610cad121742ebe698ef98a3b4c87b5dd rcu: Add sparse check to rcu_assign_pointer()
date:   4 years, 10 months ago
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20231112/202311120246.W8nrgLDN-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231112/202311120246.W8nrgLDN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311120246.W8nrgLDN-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   fs/file.c:335:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file **old_fds @@     got struct file [noderef] <asn:4> **fd @@
   fs/file.c:335:17: sparse:     expected struct file **old_fds
   fs/file.c:335:17: sparse:     got struct file [noderef] <asn:4> **fd
   fs/file.c:336:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file **new_fds @@     got struct file [noderef] <asn:4> **fd @@
   fs/file.c:336:17: sparse:     expected struct file **new_fds
   fs/file.c:336:17: sparse:     got struct file [noderef] <asn:4> **fd
>> fs/file.c:351:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/file.c:351:17: sparse:    struct file [noderef] <asn:4> *
>> fs/file.c:351:17: sparse:    struct file *
   fs/file.c:386:54: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct file *file @@     got struct file [noderef] <asn:4> *[assigned] __ret @@
   fs/file.c:386:54: sparse:     expected struct file *file
   fs/file.c:386:54: sparse:     got struct file [noderef] <asn:4> *[assigned] __ret
   fs/file.c:451:28: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fdtable [noderef] <asn:4> *fdt @@     got struct fdtable * @@
   fs/file.c:451:28: sparse:     expected struct fdtable [noderef] <asn:4> *fdt
   fs/file.c:451:28: sparse:     got struct fdtable *
   fs/file.c:629:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *file @@     got struct file [noderef] <asn:4> * @@
   fs/file.c:629:14: sparse:     expected struct file *file
   fs/file.c:629:14: sparse:     got struct file [noderef] <asn:4> *
   fs/file.c:656:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *file @@     got struct file [noderef] <asn:4> * @@
   fs/file.c:656:14: sparse:     expected struct file *file
   fs/file.c:656:14: sparse:     got struct file [noderef] <asn:4> *
   fs/file.c:693:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *file @@     got struct file [noderef] <asn:4> * @@
   fs/file.c:693:30: sparse:     expected struct file *file
   fs/file.c:693:30: sparse:     got struct file [noderef] <asn:4> *
   fs/file.c:859:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *tofree @@     got struct file [noderef] <asn:4> * @@
   fs/file.c:859:16: sparse:     expected struct file *tofree
   fs/file.c:859:16: sparse:     got struct file [noderef] <asn:4> *
--
   kernel/notifier.c:27:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:27:20: sparse:     expected struct notifier_block **nl
   kernel/notifier.c:27:20: sparse:     got struct notifier_block [noderef] <asn:4> **
   kernel/notifier.c:29:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct notifier_block [noderef] <asn:4> *next @@     got struct notifier_block * @@
   kernel/notifier.c:29:17: sparse:     expected struct notifier_block [noderef] <asn:4> *next
   kernel/notifier.c:29:17: sparse:     got struct notifier_block *
>> kernel/notifier.c:30:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/notifier.c:30:9: sparse:    struct notifier_block [noderef] <asn:4> *
>> kernel/notifier.c:30:9: sparse:    struct notifier_block *
   kernel/notifier.c:42:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:42:20: sparse:     expected struct notifier_block **nl
   kernel/notifier.c:42:20: sparse:     got struct notifier_block [noderef] <asn:4> **
   kernel/notifier.c:44:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct notifier_block [noderef] <asn:4> *next @@     got struct notifier_block * @@
   kernel/notifier.c:44:17: sparse:     expected struct notifier_block [noderef] <asn:4> *next
   kernel/notifier.c:44:17: sparse:     got struct notifier_block *
   kernel/notifier.c:45:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/notifier.c:45:9: sparse:    struct notifier_block [noderef] <asn:4> *
   kernel/notifier.c:45:9: sparse:    struct notifier_block *
   kernel/notifier.c:54:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/notifier.c:54:25: sparse:    struct notifier_block [noderef] <asn:4> *
   kernel/notifier.c:54:25: sparse:    struct notifier_block *
   kernel/notifier.c:128:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:150:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:183:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:224:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:227:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:250:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:277:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:280:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:317:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:350:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:367:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:394:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:432:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:435:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:462:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:465:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:498:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
--
   lib/rbtree.c: note: in included file:
>> include/linux/rbtree_augmented.h:153:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rbtree_augmented.h:153:25: sparse:    struct rb_node [noderef] <asn:4> *
>> include/linux/rbtree_augmented.h:153:25: sparse:    struct rb_node *
   include/linux/rbtree_augmented.h:155:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rbtree_augmented.h:155:25: sparse:    struct rb_node [noderef] <asn:4> *
   include/linux/rbtree_augmented.h:155:25: sparse:    struct rb_node *
   include/linux/rbtree_augmented.h:157:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rbtree_augmented.h:157:17: sparse:    struct rb_node [noderef] <asn:4> *
   include/linux/rbtree_augmented.h:157:17: sparse:    struct rb_node *

vim +351 fs/file.c

02afc6267f6d55 Al Viro         2008-05-08  266  
02afc6267f6d55 Al Viro         2008-05-08  267  /*
02afc6267f6d55 Al Viro         2008-05-08  268   * Allocate a new files structure and copy contents from the
02afc6267f6d55 Al Viro         2008-05-08  269   * passed in files structure.
02afc6267f6d55 Al Viro         2008-05-08  270   * errorp will be valid only when the returned files_struct is NULL.
02afc6267f6d55 Al Viro         2008-05-08  271   */
02afc6267f6d55 Al Viro         2008-05-08  272  struct files_struct *dup_fd(struct files_struct *oldf, int *errorp)
02afc6267f6d55 Al Viro         2008-05-08  273  {
02afc6267f6d55 Al Viro         2008-05-08  274  	struct files_struct *newf;
02afc6267f6d55 Al Viro         2008-05-08  275  	struct file **old_fds, **new_fds;
9b80a184eaadc1 Alexey Dobriyan 2016-09-02  276  	unsigned int open_files, i;
02afc6267f6d55 Al Viro         2008-05-08  277  	struct fdtable *old_fdt, *new_fdt;
02afc6267f6d55 Al Viro         2008-05-08  278  
02afc6267f6d55 Al Viro         2008-05-08  279  	*errorp = -ENOMEM;
afbec7fff4928c Al Viro         2008-05-08  280  	newf = kmem_cache_alloc(files_cachep, GFP_KERNEL);
02afc6267f6d55 Al Viro         2008-05-08  281  	if (!newf)
02afc6267f6d55 Al Viro         2008-05-08  282  		goto out;
02afc6267f6d55 Al Viro         2008-05-08  283  
afbec7fff4928c Al Viro         2008-05-08  284  	atomic_set(&newf->count, 1);
afbec7fff4928c Al Viro         2008-05-08  285  
afbec7fff4928c Al Viro         2008-05-08  286  	spin_lock_init(&newf->file_lock);
8a81252b774b53 Eric Dumazet    2015-06-30  287  	newf->resize_in_progress = false;
8a81252b774b53 Eric Dumazet    2015-06-30  288  	init_waitqueue_head(&newf->resize_wait);
afbec7fff4928c Al Viro         2008-05-08  289  	newf->next_fd = 0;
afbec7fff4928c Al Viro         2008-05-08  290  	new_fdt = &newf->fdtab;
afbec7fff4928c Al Viro         2008-05-08  291  	new_fdt->max_fds = NR_OPEN_DEFAULT;
1fd36adcd98c14 David Howells   2012-02-16  292  	new_fdt->close_on_exec = newf->close_on_exec_init;
1fd36adcd98c14 David Howells   2012-02-16  293  	new_fdt->open_fds = newf->open_fds_init;
f3f86e33dc3da4 Linus Torvalds  2015-10-30  294  	new_fdt->full_fds_bits = newf->full_fds_bits_init;
afbec7fff4928c Al Viro         2008-05-08  295  	new_fdt->fd = &newf->fd_array[0];
afbec7fff4928c Al Viro         2008-05-08  296  
02afc6267f6d55 Al Viro         2008-05-08  297  	spin_lock(&oldf->file_lock);
02afc6267f6d55 Al Viro         2008-05-08  298  	old_fdt = files_fdtable(oldf);
02afc6267f6d55 Al Viro         2008-05-08  299  	open_files = count_open_files(old_fdt);
02afc6267f6d55 Al Viro         2008-05-08  300  
02afc6267f6d55 Al Viro         2008-05-08  301  	/*
02afc6267f6d55 Al Viro         2008-05-08  302  	 * Check whether we need to allocate a larger fd array and fd set.
02afc6267f6d55 Al Viro         2008-05-08  303  	 */
adbecb128cd2cc Al Viro         2008-05-08  304  	while (unlikely(open_files > new_fdt->max_fds)) {
02afc6267f6d55 Al Viro         2008-05-08  305  		spin_unlock(&oldf->file_lock);
9dec3c4d306b09 Al Viro         2008-05-08  306  
a892e2d7dcdfa6 Changli Gao     2010-08-10  307  		if (new_fdt != &newf->fdtab)
a892e2d7dcdfa6 Changli Gao     2010-08-10  308  			__free_fdtable(new_fdt);
adbecb128cd2cc Al Viro         2008-05-08  309  
9dec3c4d306b09 Al Viro         2008-05-08  310  		new_fdt = alloc_fdtable(open_files - 1);
9dec3c4d306b09 Al Viro         2008-05-08  311  		if (!new_fdt) {
9dec3c4d306b09 Al Viro         2008-05-08  312  			*errorp = -ENOMEM;
02afc6267f6d55 Al Viro         2008-05-08  313  			goto out_release;
9dec3c4d306b09 Al Viro         2008-05-08  314  		}
9dec3c4d306b09 Al Viro         2008-05-08  315  
9dec3c4d306b09 Al Viro         2008-05-08  316  		/* beyond sysctl_nr_open; nothing to do */
9dec3c4d306b09 Al Viro         2008-05-08  317  		if (unlikely(new_fdt->max_fds < open_files)) {
a892e2d7dcdfa6 Changli Gao     2010-08-10  318  			__free_fdtable(new_fdt);
9dec3c4d306b09 Al Viro         2008-05-08  319  			*errorp = -EMFILE;
9dec3c4d306b09 Al Viro         2008-05-08  320  			goto out_release;
9dec3c4d306b09 Al Viro         2008-05-08  321  		}
9dec3c4d306b09 Al Viro         2008-05-08  322  
02afc6267f6d55 Al Viro         2008-05-08  323  		/*
02afc6267f6d55 Al Viro         2008-05-08  324  		 * Reacquire the oldf lock and a pointer to its fd table
02afc6267f6d55 Al Viro         2008-05-08  325  		 * who knows it may have a new bigger fd table. We need
02afc6267f6d55 Al Viro         2008-05-08  326  		 * the latest pointer.
02afc6267f6d55 Al Viro         2008-05-08  327  		 */
02afc6267f6d55 Al Viro         2008-05-08  328  		spin_lock(&oldf->file_lock);
02afc6267f6d55 Al Viro         2008-05-08  329  		old_fdt = files_fdtable(oldf);
adbecb128cd2cc Al Viro         2008-05-08  330  		open_files = count_open_files(old_fdt);
02afc6267f6d55 Al Viro         2008-05-08  331  	}
02afc6267f6d55 Al Viro         2008-05-08  332  
ea5c58e70c3a14 Eric Biggers    2015-11-06  333  	copy_fd_bitmaps(new_fdt, old_fdt, open_files);
ea5c58e70c3a14 Eric Biggers    2015-11-06  334  
02afc6267f6d55 Al Viro         2008-05-08  335  	old_fds = old_fdt->fd;
02afc6267f6d55 Al Viro         2008-05-08  336  	new_fds = new_fdt->fd;
02afc6267f6d55 Al Viro         2008-05-08  337  
02afc6267f6d55 Al Viro         2008-05-08  338  	for (i = open_files; i != 0; i--) {
02afc6267f6d55 Al Viro         2008-05-08  339  		struct file *f = *old_fds++;
02afc6267f6d55 Al Viro         2008-05-08  340  		if (f) {
02afc6267f6d55 Al Viro         2008-05-08  341  			get_file(f);
02afc6267f6d55 Al Viro         2008-05-08  342  		} else {
02afc6267f6d55 Al Viro         2008-05-08  343  			/*
02afc6267f6d55 Al Viro         2008-05-08  344  			 * The fd may be claimed in the fd bitmap but not yet
02afc6267f6d55 Al Viro         2008-05-08  345  			 * instantiated in the files array if a sibling thread
02afc6267f6d55 Al Viro         2008-05-08  346  			 * is partway through open().  So make sure that this
02afc6267f6d55 Al Viro         2008-05-08  347  			 * fd is available to the new process.
02afc6267f6d55 Al Viro         2008-05-08  348  			 */
1dce27c5aa6770 David Howells   2012-02-16  349  			__clear_open_fd(open_files - i, new_fdt);
02afc6267f6d55 Al Viro         2008-05-08  350  		}
02afc6267f6d55 Al Viro         2008-05-08 @351  		rcu_assign_pointer(*new_fds++, f);
02afc6267f6d55 Al Viro         2008-05-08  352  	}
02afc6267f6d55 Al Viro         2008-05-08  353  	spin_unlock(&oldf->file_lock);
02afc6267f6d55 Al Viro         2008-05-08  354  
ea5c58e70c3a14 Eric Biggers    2015-11-06  355  	/* clear the remainder */
ea5c58e70c3a14 Eric Biggers    2015-11-06  356  	memset(new_fds, 0, (new_fdt->max_fds - open_files) * sizeof(struct file *));
02afc6267f6d55 Al Viro         2008-05-08  357  
afbec7fff4928c Al Viro         2008-05-08  358  	rcu_assign_pointer(newf->fdt, new_fdt);
afbec7fff4928c Al Viro         2008-05-08  359  
02afc6267f6d55 Al Viro         2008-05-08  360  	return newf;
02afc6267f6d55 Al Viro         2008-05-08  361  
02afc6267f6d55 Al Viro         2008-05-08  362  out_release:
02afc6267f6d55 Al Viro         2008-05-08  363  	kmem_cache_free(files_cachep, newf);
02afc6267f6d55 Al Viro         2008-05-08  364  out:
02afc6267f6d55 Al Viro         2008-05-08  365  	return NULL;
02afc6267f6d55 Al Viro         2008-05-08  366  }
02afc6267f6d55 Al Viro         2008-05-08  367  

:::::: The code at line 351 was first introduced by commit
:::::: 02afc6267f6d55d47aba9fcafdbd1b7230d2294a [PATCH] dup_fd() fixes, part 1

:::::: TO: Al Viro <viro@zeniv.linux.org.uk>
:::::: CC: Al Viro <viro@zeniv.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
