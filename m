Return-Path: <linux-kernel+bounces-2872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B365816380
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 00:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9794F1C20A74
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 23:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171C84A9A1;
	Sun, 17 Dec 2023 23:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uoj4KLW4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182CA4A98F
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 23:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702857058; x=1734393058;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/ZY/U9DAXPmw1KIlN/Vpl9xY49TK7CGzPKPHbgHh3qY=;
  b=Uoj4KLW4D/GbtYbghFKrjFZnDm47M4jLeIrdCSxaizA5JGYzaNZxGKXN
   uYt+/mlflwEmvU7zw+GjBGteZFgSozAuhPk4miez/HSqjkQCuv0fxjbpz
   5cZMqCQZtbfuD/icCJW/8euCUaMTeY0PtX0zLbDYeel12YMGmYBg8sDip
   LtuFuvHNfm7aGwAmPjHCNOu4xSgY8kIZ+7vpVDza2VnVaIhXOcbgUdWX0
   dRK4srhpwPKCzKlnpP1TZ7uaARxeqMZiMaKK80F+hpxDWzgAnoMWCDVTw
   M1mReJr7xb1pe4g1seCRKdnEzh2XR3u1OYhhaswC3EqsDPUgPklIHG8RU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="380425322"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="380425322"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 15:50:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="919080613"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="919080613"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 17 Dec 2023 15:50:56 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rF0uM-0003X6-0B;
	Sun, 17 Dec 2023 23:50:54 +0000
Date: Mon, 18 Dec 2023 07:50:53 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Brauner <brauner@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: fs/nilfs2/ioctl.c:133: warning: Function parameter or struct member
 'idmap' not described in 'nilfs_fileattr_set'
Message-ID: <202312180712.fUp3kkLH-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Christian,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0e389834672c723435a44818ed2cabc4dad24429
commit: 8782a9aea3ab4d697ad67d1f8ebca38a4e1c24ab fs: port ->fileattr_set() to pass mnt_idmap
date:   11 months ago
config: i386-buildonly-randconfig-003-20231218 (https://download.01.org/0day-ci/archive/20231218/202312180712.fUp3kkLH-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231218/202312180712.fUp3kkLH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312180712.fUp3kkLH-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/nilfs2/ioctl.c:120: warning: Function parameter or struct member 'dentry' not described in 'nilfs_fileattr_get'
   fs/nilfs2/ioctl.c:120: warning: Function parameter or struct member 'fa' not described in 'nilfs_fileattr_get'
>> fs/nilfs2/ioctl.c:133: warning: Function parameter or struct member 'idmap' not described in 'nilfs_fileattr_set'
   fs/nilfs2/ioctl.c:133: warning: Function parameter or struct member 'dentry' not described in 'nilfs_fileattr_set'
   fs/nilfs2/ioctl.c:133: warning: Function parameter or struct member 'fa' not described in 'nilfs_fileattr_set'
   fs/nilfs2/ioctl.c:164: warning: Function parameter or struct member 'inode' not described in 'nilfs_ioctl_getversion'
   fs/nilfs2/ioctl.c:164: warning: Function parameter or struct member 'argp' not described in 'nilfs_ioctl_getversion'


vim +133 fs/nilfs2/ioctl.c

7942b919f7321f9 Koji Sato          2009-04-06  115  
d623a9420c9ae2b Vyacheslav Dubeyko 2014-01-23  116  /**
7c7c436e14b863c Miklos Szeredi     2021-04-07  117   * nilfs_fileattr_get - ioctl to support lsattr
d623a9420c9ae2b Vyacheslav Dubeyko 2014-01-23  118   */
7c7c436e14b863c Miklos Szeredi     2021-04-07  119  int nilfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
cde98f0f84ccff7 Ryusuke Konishi    2011-01-20 @120  {
7c7c436e14b863c Miklos Szeredi     2021-04-07  121  	struct inode *inode = d_inode(dentry);
cde98f0f84ccff7 Ryusuke Konishi    2011-01-20  122  
7c7c436e14b863c Miklos Szeredi     2021-04-07  123  	fileattr_fill_flags(fa, NILFS_I(inode)->i_flags & FS_FL_USER_VISIBLE);
7c7c436e14b863c Miklos Szeredi     2021-04-07  124  
7c7c436e14b863c Miklos Szeredi     2021-04-07  125  	return 0;
cde98f0f84ccff7 Ryusuke Konishi    2011-01-20  126  }
cde98f0f84ccff7 Ryusuke Konishi    2011-01-20  127  
d623a9420c9ae2b Vyacheslav Dubeyko 2014-01-23  128  /**
7c7c436e14b863c Miklos Szeredi     2021-04-07  129   * nilfs_fileattr_set - ioctl to support chattr
d623a9420c9ae2b Vyacheslav Dubeyko 2014-01-23  130   */
8782a9aea3ab4d6 Christian Brauner  2023-01-13  131  int nilfs_fileattr_set(struct mnt_idmap *idmap,
7c7c436e14b863c Miklos Szeredi     2021-04-07  132  		       struct dentry *dentry, struct fileattr *fa)
cde98f0f84ccff7 Ryusuke Konishi    2011-01-20 @133  {
7c7c436e14b863c Miklos Szeredi     2021-04-07  134  	struct inode *inode = d_inode(dentry);
cde98f0f84ccff7 Ryusuke Konishi    2011-01-20  135  	struct nilfs_transaction_info ti;
cde98f0f84ccff7 Ryusuke Konishi    2011-01-20  136  	unsigned int flags, oldflags;
cde98f0f84ccff7 Ryusuke Konishi    2011-01-20  137  	int ret;
cde98f0f84ccff7 Ryusuke Konishi    2011-01-20  138  
7c7c436e14b863c Miklos Szeredi     2021-04-07  139  	if (fileattr_has_fsx(fa))
7c7c436e14b863c Miklos Szeredi     2021-04-07  140  		return -EOPNOTSUPP;
cde98f0f84ccff7 Ryusuke Konishi    2011-01-20  141  
7c7c436e14b863c Miklos Szeredi     2021-04-07  142  	flags = nilfs_mask_flags(inode->i_mode, fa->flags);
cde98f0f84ccff7 Ryusuke Konishi    2011-01-20  143  
cde98f0f84ccff7 Ryusuke Konishi    2011-01-20  144  	ret = nilfs_transaction_begin(inode->i_sb, &ti, 0);
cde98f0f84ccff7 Ryusuke Konishi    2011-01-20  145  	if (ret)
7c7c436e14b863c Miklos Szeredi     2021-04-07  146  		return ret;
cde98f0f84ccff7 Ryusuke Konishi    2011-01-20  147  
7c7c436e14b863c Miklos Szeredi     2021-04-07  148  	oldflags = NILFS_I(inode)->i_flags & ~FS_FL_USER_MODIFIABLE;
7c7c436e14b863c Miklos Szeredi     2021-04-07  149  	NILFS_I(inode)->i_flags = oldflags | (flags & FS_FL_USER_MODIFIABLE);
cde98f0f84ccff7 Ryusuke Konishi    2011-01-20  150  
cde98f0f84ccff7 Ryusuke Konishi    2011-01-20  151  	nilfs_set_inode_flags(inode);
078cd8279e65998 Deepa Dinamani     2016-09-14  152  	inode->i_ctime = current_time(inode);
cde98f0f84ccff7 Ryusuke Konishi    2011-01-20  153  	if (IS_SYNC(inode))
cde98f0f84ccff7 Ryusuke Konishi    2011-01-20  154  		nilfs_set_transaction_flag(NILFS_TI_SYNC);
cde98f0f84ccff7 Ryusuke Konishi    2011-01-20  155  
cde98f0f84ccff7 Ryusuke Konishi    2011-01-20  156  	nilfs_mark_inode_dirty(inode);
7c7c436e14b863c Miklos Szeredi     2021-04-07  157  	return nilfs_transaction_commit(inode->i_sb);
cde98f0f84ccff7 Ryusuke Konishi    2011-01-20  158  }
cde98f0f84ccff7 Ryusuke Konishi    2011-01-20  159  

:::::: The code at line 133 was first introduced by commit
:::::: cde98f0f84ccff78e87235cb7b551747d6ad00de nilfs2: implement FS_IOC_GETFLAGS/SETFLAGS/GETVERSION

:::::: TO: Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>
:::::: CC: Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

