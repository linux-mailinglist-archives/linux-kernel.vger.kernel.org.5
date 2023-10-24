Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDD47D46B3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 06:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjJXEZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 00:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJXEZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 00:25:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDF0110
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 21:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698121541; x=1729657541;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=joxdzBUwtflcA3bZmxV5y2f+maB+lG0uVrl+Sgf1ltI=;
  b=ikeMYXbZQisL+w9lys+Ro1Pz/eZVU8xTIH6jXyphrglePHV8D+ruLdml
   QXaejRpmqM6ExxMOZs0dHSBb3NrS4yJhik9slDu7DiChZjFCHewcboNUk
   OheDK77c1IEgm8PzoykiGLr4crfZSoEEiQ1H+Af41GIkbJdnQgQUSD9/8
   WJcWiAWxT+ZQ5DN+zGqN16UEkSogf52WbfaceleO6O2X7/wZC8M7eK3D1
   3YyzI1H0kgB6UOT3Rr+8XkHrcTQUsFw4WaLr6SSSGczxrDIwrI56i/ps6
   iwha+RqYc+d4TLeVG82tp3qPPJ+nLjO9ZAxlatAhUIvxXfcW9tK+Opyvu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="473211296"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="473211296"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 21:25:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="793365037"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="793365037"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 23 Oct 2023 21:25:39 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qv8z2-0007ZB-2N;
        Tue, 24 Oct 2023 04:25:36 +0000
Date:   Tue, 24 Oct 2023 12:25:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/proc/proc_net.c:130: warning: Function parameter or member
 'state_size' not described in 'proc_create_net_data_write'
Message-ID: <202310241246.dzzRFPr2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   84186fcb834ecc55604efaf383e17e6b5e9baa50
commit: 564def71765caf65040f926c0783b9c27cc6c087 proc: Add a way to make network proc files writable
date:   5 years ago
config: x86_64-randconfig-x012-20230629 (https://download.01.org/0day-ci/archive/20231024/202310241246.dzzRFPr2-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231024/202310241246.dzzRFPr2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310241246.dzzRFPr2-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/x86/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from arch/x86/include/asm/paravirt.h:15,
                    from arch/x86/include/asm/irqflags.h:65,
                    from include/linux/irqflags.h:16,
                    from include/linux/rcupdate.h:39,
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
   fs/proc/proc_net.o: warning: objtool: get_proc_task_net()+0x110: sibling call from callable instruction with modified stack frame


vim +130 fs/proc/proc_net.c

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
