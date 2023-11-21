Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354F37F275E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 09:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjKUIWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 03:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjKUIW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 03:22:27 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BBB112
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 00:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700554943; x=1732090943;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2bk+MohBt7VWNyb3vo6oERzidJvVZ7qVhb4jpAvV8UA=;
  b=B27LXM00oif5TrOiUFCkQp2anS9nN6vQhm5g8gsLPabsWE4Gc2roP9SN
   8HNEdA4IjwQgjtw5MxgEPO4nsLulZ46XPWKmeer7tXX0NUdkCS2ILMiCk
   RjvTPqN+h6Gd//LqJ5FTJoJq1noDFgjQwVt12YH+7Li/pcxPrF3VxaU0X
   5g0WbBlXrM7M/vGL3OXmKHCV9eAgAv9cZgBEh1gqd35Yct9mIiMXvWfvi
   WUpNOz9KekKlrXmqjXHe9bT6hDIJLHvjOuTgW30TW6TxXxgshhKRVCnfy
   LmrItQKxrQFzHOJhlkP0FGCc3RnJXArmxp3YWrUVPxpqE5me6YRn5uaYU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="456127183"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="456127183"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 00:22:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="884121199"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="884121199"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 21 Nov 2023 00:22:21 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5M16-0007Yn-2g;
        Tue, 21 Nov 2023 08:22:05 +0000
Date:   Tue, 21 Nov 2023 16:21:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/proc/proc_net.c:130: warning: Function parameter or member
 'state_size' not described in 'proc_create_net_data_write'
Message-ID: <202311211605.jYnwq7JO-lkp@intel.com>
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

Hi David,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   98b1cc82c4affc16f5598d4fa14b1858671b2263
commit: 564def71765caf65040f926c0783b9c27cc6c087 proc: Add a way to make network proc files writable
date:   6 years ago
config: x86_64-buildonly-randconfig-001-20231012 (https://download.01.org/0day-ci/archive/20231121/202311211605.jYnwq7JO-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311211605.jYnwq7JO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311211605.jYnwq7JO-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/x86/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:12,
                    from arch/x86/include/asm/preempt.h:7,
                    from include/linux/preempt.h:81,
                    from include/linux/rcupdate.h:40,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/uaccess.h:5,
                    from fs/proc/proc_net.c:11:
   fs/proc/proc_net.c: In function 'seq_open_net':
   fs/proc/proc_net.c:47:33: warning: comparison is always false due to limited range of data type [-Wtype-limits]
      47 |         WARN_ON_ONCE(state_size < sizeof(*p));
         |                                 ^
   include/asm-generic/bug.h:69:32: note: in definition of macro 'WARN_ON_ONCE'
      69 |         int __ret_warn_on = !!(condition);                      \
         |                                ^~~~~~~~~
>> fs/proc/proc_net.c:130: warning: Function parameter or member 'state_size' not described in 'proc_create_net_data_write'


vim +130 fs/proc/proc_net.c

  > 11	#include <linux/uaccess.h>
    12	
    13	#include <linux/errno.h>
    14	#include <linux/time.h>
    15	#include <linux/proc_fs.h>
    16	#include <linux/stat.h>
    17	#include <linux/slab.h>
    18	#include <linux/init.h>
    19	#include <linux/sched.h>
    20	#include <linux/sched/task.h>
    21	#include <linux/module.h>
    22	#include <linux/bitops.h>
    23	#include <linux/mount.h>
    24	#include <linux/nsproxy.h>
    25	#include <linux/uidgid.h>
    26	#include <net/net_namespace.h>
    27	#include <linux/seq_file.h>
    28	
    29	#include "internal.h"
    30	
    31	static inline struct net *PDE_NET(struct proc_dir_entry *pde)
    32	{
    33		return pde->parent->data;
    34	}
    35	
    36	static struct net *get_proc_net(const struct inode *inode)
    37	{
    38		return maybe_get_net(PDE_NET(PDE(inode)));
    39	}
    40	
    41	static int seq_open_net(struct inode *inode, struct file *file)
    42	{
    43		unsigned int state_size = PDE(inode)->state_size;
    44		struct seq_net_private *p;
    45		struct net *net;
    46	
    47		WARN_ON_ONCE(state_size < sizeof(*p));
    48	
    49		if (file->f_mode & FMODE_WRITE && !PDE(inode)->write)
    50			return -EACCES;
    51	
    52		net = get_proc_net(inode);
    53		if (!net)
    54			return -ENXIO;
    55	
    56		p = __seq_open_private(file, PDE(inode)->seq_ops, state_size);
    57		if (!p) {
    58			put_net(net);
    59			return -ENOMEM;
    60		}
    61	#ifdef CONFIG_NET_NS
    62		p->net = net;
    63	#endif
    64		return 0;
    65	}
    66	
    67	static int seq_release_net(struct inode *ino, struct file *f)
    68	{
    69		struct seq_file *seq = f->private_data;
    70	
    71		put_net(seq_file_net(seq));
    72		seq_release_private(ino, f);
    73		return 0;
    74	}
    75	
    76	static const struct file_operations proc_net_seq_fops = {
    77		.open		= seq_open_net,
    78		.read		= seq_read,
    79		.write		= proc_simple_write,
    80		.llseek		= seq_lseek,
    81		.release	= seq_release_net,
    82	};
    83	
    84	struct proc_dir_entry *proc_create_net_data(const char *name, umode_t mode,
    85			struct proc_dir_entry *parent, const struct seq_operations *ops,
    86			unsigned int state_size, void *data)
    87	{
    88		struct proc_dir_entry *p;
    89	
    90		p = proc_create_reg(name, mode, &parent, data);
    91		if (!p)
    92			return NULL;
    93		p->proc_fops = &proc_net_seq_fops;
    94		p->seq_ops = ops;
    95		p->state_size = state_size;
    96		return proc_register(parent, p);
    97	}
    98	EXPORT_SYMBOL_GPL(proc_create_net_data);
    99	
   100	/**
   101	 * proc_create_net_data_write - Create a writable net_ns-specific proc file
   102	 * @name: The name of the file.
   103	 * @mode: The file's access mode.
   104	 * @parent: The parent directory in which to create.
   105	 * @ops: The seq_file ops with which to read the file.
   106	 * @write: The write method which which to 'modify' the file.
   107	 * @data: Data for retrieval by PDE_DATA().
   108	 *
   109	 * Create a network namespaced proc file in the @parent directory with the
   110	 * specified @name and @mode that allows reading of a file that displays a
   111	 * series of elements and also provides for the file accepting writes that have
   112	 * some arbitrary effect.
   113	 *
   114	 * The functions in the @ops table are used to iterate over items to be
   115	 * presented and extract the readable content using the seq_file interface.
   116	 *
   117	 * The @write function is called with the data copied into a kernel space
   118	 * scratch buffer and has a NUL appended for convenience.  The buffer may be
   119	 * modified by the @write function.  @write should return 0 on success.
   120	 *
   121	 * The @data value is accessible from the @show and @write functions by calling
   122	 * PDE_DATA() on the file inode.  The network namespace must be accessed by
   123	 * calling seq_file_net() on the seq_file struct.
   124	 */
   125	struct proc_dir_entry *proc_create_net_data_write(const char *name, umode_t mode,
   126							  struct proc_dir_entry *parent,
   127							  const struct seq_operations *ops,
   128							  proc_write_t write,
   129							  unsigned int state_size, void *data)
 > 130	{
   131		struct proc_dir_entry *p;
   132	
   133		p = proc_create_reg(name, mode, &parent, data);
   134		if (!p)
   135			return NULL;
   136		p->proc_fops = &proc_net_seq_fops;
   137		p->seq_ops = ops;
   138		p->state_size = state_size;
   139		p->write = write;
   140		return proc_register(parent, p);
   141	}
   142	EXPORT_SYMBOL_GPL(proc_create_net_data_write);
   143	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
