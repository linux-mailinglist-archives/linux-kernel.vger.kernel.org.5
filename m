Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1EF7E1625
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 20:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjKET7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 14:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjKET72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 14:59:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BAEC0
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 11:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699214364; x=1730750364;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1E6owWMgcxki45LkgtMrEYNLMSfheD92EYWBXFh9qJI=;
  b=ddmkWMaodgCs6mhWzzHuljkLx/a1mqLjm63nXFuV4RcuoTP2CPLp1uWg
   LPhkIo7j2zW1Jq2cHZ7WlshZytS8nrGIK9O0ua2x7Z2BeGLKJNqZZJ40M
   uiV76e7GrMdArNKlc6HwHl4pS7y9RlmC8PbVMz7OPkUiG5YONAw4Ov2Vh
   8V2VleWmyuiJ41Ou3yNdE5pipcYIIJFL9ZOTb/c0rP0EoeGsW1u8Bu8Mb
   qEgGsZ4R+M7VEYpzAn/4pjICDuLnFED6taVNz+ssnVUaQWL4U7PDSvyEv
   zjCFfi4it/z7mjfYjJwPR8qBEA1SwkWAJ1wMyZs+y6ZwWSXbktU3UZ0f4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="379562648"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="379562648"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 11:59:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="9889589"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 05 Nov 2023 11:59:22 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzjH9-0005ke-10;
        Sun, 05 Nov 2023 19:59:20 +0000
Date:   Mon, 6 Nov 2023 03:58:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/nilfs2/ioctl.c:120: warning: Function parameter or member 'fa'
 not described in 'nilfs_fileattr_get'
Message-ID: <202311060311.sOn64IEs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1c41041124bd14dd6610da256a3da4e5b74ce6b1
commit: 7c7c436e14b863ce56d9983477d35e05e54a220b nilfs2: convert to fileattr
date:   2 years, 7 months ago
config: x86_64-randconfig-012-20231101 (https://download.01.org/0day-ci/archive/20231106/202311060311.sOn64IEs-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231106/202311060311.sOn64IEs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311060311.sOn64IEs-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/nilfs2/ioctl.c:120: warning: Function parameter or member 'dentry' not described in 'nilfs_fileattr_get'
>> fs/nilfs2/ioctl.c:120: warning: Function parameter or member 'fa' not described in 'nilfs_fileattr_get'
   fs/nilfs2/ioctl.c:133: warning: Function parameter or member 'mnt_userns' not described in 'nilfs_fileattr_set'
>> fs/nilfs2/ioctl.c:133: warning: Function parameter or member 'dentry' not described in 'nilfs_fileattr_set'
>> fs/nilfs2/ioctl.c:133: warning: Function parameter or member 'fa' not described in 'nilfs_fileattr_set'
   fs/nilfs2/ioctl.c:164: warning: Function parameter or member 'inode' not described in 'nilfs_ioctl_getversion'
   fs/nilfs2/ioctl.c:164: warning: Function parameter or member 'argp' not described in 'nilfs_ioctl_getversion'


vim +120 fs/nilfs2/ioctl.c

7942b919f7321f Koji Sato          2009-04-06  115  
d623a9420c9ae2 Vyacheslav Dubeyko 2014-01-23  116  /**
7c7c436e14b863 Miklos Szeredi     2021-04-07  117   * nilfs_fileattr_get - ioctl to support lsattr
d623a9420c9ae2 Vyacheslav Dubeyko 2014-01-23  118   */
7c7c436e14b863 Miklos Szeredi     2021-04-07  119  int nilfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
cde98f0f84ccff Ryusuke Konishi    2011-01-20 @120  {
7c7c436e14b863 Miklos Szeredi     2021-04-07  121  	struct inode *inode = d_inode(dentry);
cde98f0f84ccff Ryusuke Konishi    2011-01-20  122  
7c7c436e14b863 Miklos Szeredi     2021-04-07  123  	fileattr_fill_flags(fa, NILFS_I(inode)->i_flags & FS_FL_USER_VISIBLE);
7c7c436e14b863 Miklos Szeredi     2021-04-07  124  
7c7c436e14b863 Miklos Szeredi     2021-04-07  125  	return 0;
cde98f0f84ccff Ryusuke Konishi    2011-01-20  126  }
cde98f0f84ccff Ryusuke Konishi    2011-01-20  127  
d623a9420c9ae2 Vyacheslav Dubeyko 2014-01-23  128  /**
7c7c436e14b863 Miklos Szeredi     2021-04-07  129   * nilfs_fileattr_set - ioctl to support chattr
d623a9420c9ae2 Vyacheslav Dubeyko 2014-01-23  130   */
7c7c436e14b863 Miklos Szeredi     2021-04-07  131  int nilfs_fileattr_set(struct user_namespace *mnt_userns,
7c7c436e14b863 Miklos Szeredi     2021-04-07  132  		       struct dentry *dentry, struct fileattr *fa)
cde98f0f84ccff Ryusuke Konishi    2011-01-20 @133  {
7c7c436e14b863 Miklos Szeredi     2021-04-07  134  	struct inode *inode = d_inode(dentry);
cde98f0f84ccff Ryusuke Konishi    2011-01-20  135  	struct nilfs_transaction_info ti;
cde98f0f84ccff Ryusuke Konishi    2011-01-20  136  	unsigned int flags, oldflags;
cde98f0f84ccff Ryusuke Konishi    2011-01-20  137  	int ret;
cde98f0f84ccff Ryusuke Konishi    2011-01-20  138  
7c7c436e14b863 Miklos Szeredi     2021-04-07  139  	if (fileattr_has_fsx(fa))
7c7c436e14b863 Miklos Szeredi     2021-04-07  140  		return -EOPNOTSUPP;
cde98f0f84ccff Ryusuke Konishi    2011-01-20  141  
7c7c436e14b863 Miklos Szeredi     2021-04-07  142  	flags = nilfs_mask_flags(inode->i_mode, fa->flags);
cde98f0f84ccff Ryusuke Konishi    2011-01-20  143  
cde98f0f84ccff Ryusuke Konishi    2011-01-20  144  	ret = nilfs_transaction_begin(inode->i_sb, &ti, 0);
cde98f0f84ccff Ryusuke Konishi    2011-01-20  145  	if (ret)
7c7c436e14b863 Miklos Szeredi     2021-04-07  146  		return ret;
cde98f0f84ccff Ryusuke Konishi    2011-01-20  147  
7c7c436e14b863 Miklos Szeredi     2021-04-07  148  	oldflags = NILFS_I(inode)->i_flags & ~FS_FL_USER_MODIFIABLE;
7c7c436e14b863 Miklos Szeredi     2021-04-07  149  	NILFS_I(inode)->i_flags = oldflags | (flags & FS_FL_USER_MODIFIABLE);
cde98f0f84ccff Ryusuke Konishi    2011-01-20  150  
cde98f0f84ccff Ryusuke Konishi    2011-01-20  151  	nilfs_set_inode_flags(inode);
078cd8279e6599 Deepa Dinamani     2016-09-14  152  	inode->i_ctime = current_time(inode);
cde98f0f84ccff Ryusuke Konishi    2011-01-20  153  	if (IS_SYNC(inode))
cde98f0f84ccff Ryusuke Konishi    2011-01-20  154  		nilfs_set_transaction_flag(NILFS_TI_SYNC);
cde98f0f84ccff Ryusuke Konishi    2011-01-20  155  
cde98f0f84ccff Ryusuke Konishi    2011-01-20  156  	nilfs_mark_inode_dirty(inode);
7c7c436e14b863 Miklos Szeredi     2021-04-07  157  	return nilfs_transaction_commit(inode->i_sb);
cde98f0f84ccff Ryusuke Konishi    2011-01-20  158  }
cde98f0f84ccff Ryusuke Konishi    2011-01-20  159  

:::::: The code at line 120 was first introduced by commit
:::::: cde98f0f84ccff78e87235cb7b551747d6ad00de nilfs2: implement FS_IOC_GETFLAGS/SETFLAGS/GETVERSION

:::::: TO: Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>
:::::: CC: Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
