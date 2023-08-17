Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EB177F16C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 09:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348524AbjHQHpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 03:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348530AbjHQHop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 03:44:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C512D59
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 00:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692258283; x=1723794283;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eZRNGcl/S6vO0JOxwMIBLxe49aSmUcB0L18OPr7lpIA=;
  b=XMYsLGiY1+zROjc8dkFi4j7ErF2EoDm+kos6ZuEeQ427XM5mK9AYFgcA
   AjmFcibeQRdeXG1fADA7T7CLK7gJLtINYsQFqqn4dgXeu0KXnLRqayX8l
   qC9ahVB3JhL1N6Q/J/q3IPn56yjlnwtuklm2ZaaE3HH3BfcF70qlX377f
   gIQVrLTcwt+cZWsYHnhzxJ4K079nCL+FRWNKFddhmxxsPIAgpYiWqS14s
   rno5yIjo2XPi+9v16wjn0a393wd67yBhoo9UvbDJNLngmnPVrNJU2aS7M
   kxozlvrpu0CRCT80cSppPINYLyRmbbPTaL60/cR9f+/lGCPPdp10mJOYd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="376476992"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="376476992"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 00:44:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="737601629"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="737601629"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 17 Aug 2023 00:44:39 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWXgM-0000uu-30;
        Thu, 17 Aug 2023 07:44:38 +0000
Date:   Thu, 17 Aug 2023 15:44:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: fs/nilfs2/ioctl.c:133: warning: Function parameter or member 'idmap'
 not described in 'nilfs_fileattr_set'
Message-ID: <202308171521.rNg7eaw1-lkp@intel.com>
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

Hi Christian,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
commit: 8782a9aea3ab4d697ad67d1f8ebca38a4e1c24ab fs: port ->fileattr_set() to pass mnt_idmap
date:   7 months ago
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230817/202308171521.rNg7eaw1-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308171521.rNg7eaw1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308171521.rNg7eaw1-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/nilfs2/ioctl.c:120: warning: Function parameter or member 'dentry' not described in 'nilfs_fileattr_get'
   fs/nilfs2/ioctl.c:120: warning: Function parameter or member 'fa' not described in 'nilfs_fileattr_get'
>> fs/nilfs2/ioctl.c:133: warning: Function parameter or member 'idmap' not described in 'nilfs_fileattr_set'
   fs/nilfs2/ioctl.c:133: warning: Function parameter or member 'dentry' not described in 'nilfs_fileattr_set'
   fs/nilfs2/ioctl.c:133: warning: Function parameter or member 'fa' not described in 'nilfs_fileattr_set'
   fs/nilfs2/ioctl.c:164: warning: Function parameter or member 'inode' not described in 'nilfs_ioctl_getversion'
   fs/nilfs2/ioctl.c:164: warning: Function parameter or member 'argp' not described in 'nilfs_ioctl_getversion'


vim +133 fs/nilfs2/ioctl.c

cde98f0f84ccff Ryusuke Konishi    2011-01-20  127  
d623a9420c9ae2 Vyacheslav Dubeyko 2014-01-23  128  /**
7c7c436e14b863 Miklos Szeredi     2021-04-07  129   * nilfs_fileattr_set - ioctl to support chattr
d623a9420c9ae2 Vyacheslav Dubeyko 2014-01-23  130   */
8782a9aea3ab4d Christian Brauner  2023-01-13  131  int nilfs_fileattr_set(struct mnt_idmap *idmap,
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

:::::: The code at line 133 was first introduced by commit
:::::: cde98f0f84ccff78e87235cb7b551747d6ad00de nilfs2: implement FS_IOC_GETFLAGS/SETFLAGS/GETVERSION

:::::: TO: Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>
:::::: CC: Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
