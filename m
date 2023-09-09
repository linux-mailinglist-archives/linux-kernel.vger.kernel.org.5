Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7E87997A2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 13:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344995AbjIILYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 07:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344931AbjIILYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 07:24:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB1ACF4
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 04:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694258656; x=1725794656;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+fwr+6gVgMAZRVn59IW+fGoEyT/Y/bI1An4vPYrtXcA=;
  b=STUwXE83uUGQ1B+M04IlKgpd7ol/N4pgaPndASbaB5vADkiqyH/XrXlL
   f7pVIcpaKOKuav9Ezh/ezhruVP9qRP71UNQqRSOrDZNZwp6SzCo9YJCJg
   zPkXzCh5dtD+oCwhVgyriJTU97A2YowNjhz8KKmGXjfopYESdaCkIgYyG
   gqzM72ZrC9ocqau/PWyYYqakmEEKLtHnxmn/rQ0UM/qQnHvCFE8zPe8Mx
   HeolzvbsEpnJenKfbJfD/ftyqDESQCl3x+cZnvnCEdNRQaRgChRyoL9EV
   icZQfOo02fiHE9zTlHphUJ4d8xEkjzc02KyxP/0d4n4ZxVPLqDKxQ0XZ/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="377724640"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="377724640"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2023 04:24:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="742796869"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="742796869"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 09 Sep 2023 04:24:15 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qew4S-0003PX-2g;
        Sat, 09 Sep 2023 11:24:12 +0000
Date:   Sat, 9 Sep 2023 19:23:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mike Tipton <quic_mdtipton@quicinc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Georgi Djakov <djakov@kernel.org>
Subject: fs/debugfs/file.c:942:9: sparse: sparse: incompatible types in
 comparison expression (different address spaces):
Message-ID: <202309091933.BRWlSnCq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6099776f9f268e61fe5ecd721f994a8cfce5306f
commit: 86b5488121db563b33684f56aafa62156f764be3 debugfs: Add write support to debugfs_create_str()
date:   3 weeks ago
config: i386-randconfig-061-20230909 (https://download.01.org/0day-ci/archive/20230909/202309091933.BRWlSnCq-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230909/202309091933.BRWlSnCq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309091933.BRWlSnCq-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/debugfs/file.c:942:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> fs/debugfs/file.c:942:9: sparse:    char [noderef] __rcu *
>> fs/debugfs/file.c:942:9: sparse:    char *

vim +942 fs/debugfs/file.c

   903	
   904	static ssize_t debugfs_write_file_str(struct file *file, const char __user *user_buf,
   905					      size_t count, loff_t *ppos)
   906	{
   907		struct dentry *dentry = F_DENTRY(file);
   908		char *old, *new = NULL;
   909		int pos = *ppos;
   910		int r;
   911	
   912		r = debugfs_file_get(dentry);
   913		if (unlikely(r))
   914			return r;
   915	
   916		old = *(char **)file->private_data;
   917	
   918		/* only allow strict concatenation */
   919		r = -EINVAL;
   920		if (pos && pos != strlen(old))
   921			goto error;
   922	
   923		r = -E2BIG;
   924		if (pos + count + 1 > PAGE_SIZE)
   925			goto error;
   926	
   927		r = -ENOMEM;
   928		new = kmalloc(pos + count + 1, GFP_KERNEL);
   929		if (!new)
   930			goto error;
   931	
   932		if (pos)
   933			memcpy(new, old, pos);
   934	
   935		r = -EFAULT;
   936		if (copy_from_user(new + pos, user_buf, count))
   937			goto error;
   938	
   939		new[pos + count] = '\0';
   940		strim(new);
   941	
 > 942		rcu_assign_pointer(*(char **)file->private_data, new);
   943		synchronize_rcu();
   944		kfree(old);
   945	
   946		debugfs_file_put(dentry);
   947		return count;
   948	
   949	error:
   950		kfree(new);
   951		debugfs_file_put(dentry);
   952		return r;
   953	}
   954	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
