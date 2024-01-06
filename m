Return-Path: <linux-kernel+bounces-18595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AB4825FD5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 15:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 838A0283CDE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 14:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EAE749F;
	Sat,  6 Jan 2024 14:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PoT7BIJr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08EC79C0
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 14:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704550861; x=1736086861;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J32pNbHx4eCAF5TgFGtIrHKvO3JZS9G3y9WWPqc5nsQ=;
  b=PoT7BIJrFE8wtuu7vZNA0dGh6nfHaHs1o5WhBU7hRvro9Q03nCaCELhi
   vcsVynJ9hWBx1ImY2bRBc8NmtJt/T6P7xBM/KxmcBvQiagulHWwp+3RGL
   u6G111jdqAysol7Y8uA09t5M34qUBR23zsZFcY2N0a6QYZt1ao+NZWc/v
   xlzVuqfgbFAf417KUeMsrVQWasgGimqFF9NtwJqUjGd1fQ4zsKJJZUPw6
   E7ypoey7ZK6yTG4NySqQKdkJqRvcWQRsrlk7NcHZqNrtzV+NNnp1uA/20
   J7TlrltRoMSrvdV8GCNfsF7H6PLLkwIpmB+71bBEgPzRTQHNWVvnR6WNP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="4753205"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="4753205"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 06:21:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="774085010"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="774085010"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 06 Jan 2024 06:20:57 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rM7Xj-0002Z6-06;
	Sat, 06 Jan 2024 14:20:55 +0000
Date: Sat, 6 Jan 2024 22:20:44 +0800
From: kernel test robot <lkp@intel.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>
Subject: fs/gfs2/super.c:767: warning: Function parameter or member 'who' not
 described in 'gfs2_freeze_super'
Message-ID: <202401062234.7PYISnio-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Darrick,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   95c8a35f1c017327eab3b6a2ff5c04255737c856
commit: 880b9577855edddda1e732748e849c63199d489b fs: distinguish between user initiated freeze and kernel initiated freeze
date:   6 months ago
config: x86_64-randconfig-075-20240105 (https://download.01.org/0day-ci/archive/20240106/202401062234.7PYISnio-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240106/202401062234.7PYISnio-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401062234.7PYISnio-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/gfs2/super.c:767: warning: Function parameter or member 'who' not described in 'gfs2_freeze_super'
>> fs/gfs2/super.c:822: warning: Function parameter or member 'who' not described in 'gfs2_thaw_super'


vim +767 fs/gfs2/super.c

2e60d7683c8d2e Benjamin Marzinski  2014-11-13  759  
9e6e0a128bca0a Steven Whitehouse   2009-05-22  760  /**
097cca525adf10 Andreas Gruenbacher 2022-11-14  761   * gfs2_freeze_super - prevent further writes to the filesystem
9e6e0a128bca0a Steven Whitehouse   2009-05-22  762   * @sb: the VFS structure for the filesystem
9e6e0a128bca0a Steven Whitehouse   2009-05-22  763   *
9e6e0a128bca0a Steven Whitehouse   2009-05-22  764   */
9e6e0a128bca0a Steven Whitehouse   2009-05-22  765  
880b9577855edd Darrick J. Wong     2023-07-17  766  static int gfs2_freeze_super(struct super_block *sb, enum freeze_holder who)
9e6e0a128bca0a Steven Whitehouse   2009-05-22 @767  {
9e6e0a128bca0a Steven Whitehouse   2009-05-22  768  	struct gfs2_sbd *sdp = sb->s_fs_info;
ff132c5f93c06b Bob Peterson        2021-03-25  769  	int error;
9e6e0a128bca0a Steven Whitehouse   2009-05-22  770  
b77b4a4815a965 Andreas Gruenbacher 2022-11-14  771  	if (!mutex_trylock(&sdp->sd_freeze_mutex))
b77b4a4815a965 Andreas Gruenbacher 2022-11-14  772  		return -EBUSY;
ff132c5f93c06b Bob Peterson        2021-03-25  773  	error = -EBUSY;
5432af15f8772d Andreas Gruenbacher 2022-08-18  774  	if (test_bit(SDF_FROZEN, &sdp->sd_flags))
2e60d7683c8d2e Benjamin Marzinski  2014-11-13  775  		goto out;
2e60d7683c8d2e Benjamin Marzinski  2014-11-13  776  
60528afa78667b Bob Peterson        2019-11-14  777  	for (;;) {
b77b4a4815a965 Andreas Gruenbacher 2022-11-14  778  		error = gfs2_freeze_locally(sdp);
b77b4a4815a965 Andreas Gruenbacher 2022-11-14  779  		if (error) {
b77b4a4815a965 Andreas Gruenbacher 2022-11-14  780  			fs_info(sdp, "GFS2: couldn't freeze filesystem: %d\n",
b77b4a4815a965 Andreas Gruenbacher 2022-11-14  781  				error);
2e60d7683c8d2e Benjamin Marzinski  2014-11-13  782  			goto out;
2e60d7683c8d2e Benjamin Marzinski  2014-11-13  783  		}
9e6e0a128bca0a Steven Whitehouse   2009-05-22  784  
52b1cdcb7a84a4 Bob Peterson        2019-11-15  785  		error = gfs2_lock_fs_check_clean(sdp);
9e6e0a128bca0a Steven Whitehouse   2009-05-22  786  		if (!error)
b77b4a4815a965 Andreas Gruenbacher 2022-11-14  787  			break;  /* success */
b77b4a4815a965 Andreas Gruenbacher 2022-11-14  788  
b77b4a4815a965 Andreas Gruenbacher 2022-11-14  789  		error = gfs2_do_thaw(sdp);
b77b4a4815a965 Andreas Gruenbacher 2022-11-14  790  		if (error)
b77b4a4815a965 Andreas Gruenbacher 2022-11-14  791  			goto out;
9e6e0a128bca0a Steven Whitehouse   2009-05-22  792  
55317f5b00f0dc Bob Peterson        2019-04-29  793  		if (error == -EBUSY)
9e6e0a128bca0a Steven Whitehouse   2009-05-22  794  			fs_err(sdp, "waiting for recovery before freeze\n");
52b1cdcb7a84a4 Bob Peterson        2019-11-15  795  		else if (error == -EIO) {
52b1cdcb7a84a4 Bob Peterson        2019-11-15  796  			fs_err(sdp, "Fatal IO error: cannot freeze gfs2 due "
52b1cdcb7a84a4 Bob Peterson        2019-11-15  797  			       "to recovery error.\n");
52b1cdcb7a84a4 Bob Peterson        2019-11-15  798  			goto out;
52b1cdcb7a84a4 Bob Peterson        2019-11-15  799  		} else {
9e6e0a128bca0a Steven Whitehouse   2009-05-22  800  			fs_err(sdp, "error freezing FS: %d\n", error);
52b1cdcb7a84a4 Bob Peterson        2019-11-15  801  		}
9e6e0a128bca0a Steven Whitehouse   2009-05-22  802  		fs_err(sdp, "retrying...\n");
9e6e0a128bca0a Steven Whitehouse   2009-05-22  803  		msleep(1000);
9e6e0a128bca0a Steven Whitehouse   2009-05-22  804  	}
b77b4a4815a965 Andreas Gruenbacher 2022-11-14  805  
2e60d7683c8d2e Benjamin Marzinski  2014-11-13  806  out:
b77b4a4815a965 Andreas Gruenbacher 2022-11-14  807  	if (!error) {
b77b4a4815a965 Andreas Gruenbacher 2022-11-14  808  		set_bit(SDF_FREEZE_INITIATOR, &sdp->sd_flags);
5432af15f8772d Andreas Gruenbacher 2022-08-18  809  		set_bit(SDF_FROZEN, &sdp->sd_flags);
b77b4a4815a965 Andreas Gruenbacher 2022-11-14  810  	}
2e60d7683c8d2e Benjamin Marzinski  2014-11-13  811  	mutex_unlock(&sdp->sd_freeze_mutex);
2e60d7683c8d2e Benjamin Marzinski  2014-11-13  812  	return error;
9e6e0a128bca0a Steven Whitehouse   2009-05-22  813  }
9e6e0a128bca0a Steven Whitehouse   2009-05-22  814  
9e6e0a128bca0a Steven Whitehouse   2009-05-22  815  /**
097cca525adf10 Andreas Gruenbacher 2022-11-14  816   * gfs2_thaw_super - reallow writes to the filesystem
9e6e0a128bca0a Steven Whitehouse   2009-05-22  817   * @sb: the VFS structure for the filesystem
9e6e0a128bca0a Steven Whitehouse   2009-05-22  818   *
9e6e0a128bca0a Steven Whitehouse   2009-05-22  819   */
9e6e0a128bca0a Steven Whitehouse   2009-05-22  820  
880b9577855edd Darrick J. Wong     2023-07-17  821  static int gfs2_thaw_super(struct super_block *sb, enum freeze_holder who)
9e6e0a128bca0a Steven Whitehouse   2009-05-22 @822  {
d564053f074634 Steven Whitehouse   2013-01-11  823  	struct gfs2_sbd *sdp = sb->s_fs_info;
b77b4a4815a965 Andreas Gruenbacher 2022-11-14  824  	int error;
d564053f074634 Steven Whitehouse   2013-01-11  825  
b77b4a4815a965 Andreas Gruenbacher 2022-11-14  826  	if (!mutex_trylock(&sdp->sd_freeze_mutex))
b77b4a4815a965 Andreas Gruenbacher 2022-11-14  827  		return -EBUSY;
b77b4a4815a965 Andreas Gruenbacher 2022-11-14  828  	error = -EINVAL;
b77b4a4815a965 Andreas Gruenbacher 2022-11-14  829  	if (!test_bit(SDF_FREEZE_INITIATOR, &sdp->sd_flags))
b77b4a4815a965 Andreas Gruenbacher 2022-11-14  830  		goto out;
b77b4a4815a965 Andreas Gruenbacher 2022-11-14  831  
b77b4a4815a965 Andreas Gruenbacher 2022-11-14  832  	gfs2_freeze_unlock(&sdp->sd_freeze_gh);
b77b4a4815a965 Andreas Gruenbacher 2022-11-14  833  
b77b4a4815a965 Andreas Gruenbacher 2022-11-14  834  	error = gfs2_do_thaw(sdp);
b77b4a4815a965 Andreas Gruenbacher 2022-11-14  835  
b77b4a4815a965 Andreas Gruenbacher 2022-11-14  836  	if (!error) {
b77b4a4815a965 Andreas Gruenbacher 2022-11-14  837  		clear_bit(SDF_FREEZE_INITIATOR, &sdp->sd_flags);
5432af15f8772d Andreas Gruenbacher 2022-08-18  838  		clear_bit(SDF_FROZEN, &sdp->sd_flags);
b77b4a4815a965 Andreas Gruenbacher 2022-11-14  839  	}
b77b4a4815a965 Andreas Gruenbacher 2022-11-14  840  out:
2e60d7683c8d2e Benjamin Marzinski  2014-11-13  841  	mutex_unlock(&sdp->sd_freeze_mutex);
b77b4a4815a965 Andreas Gruenbacher 2022-11-14  842  	return error;
2e60d7683c8d2e Benjamin Marzinski  2014-11-13  843  }
2e60d7683c8d2e Benjamin Marzinski  2014-11-13  844  

:::::: The code at line 767 was first introduced by commit
:::::: 9e6e0a128bca0a151d8d3fbd9459b22fc21cfebb GFS2: Merge mount.c and ops_super.c into super.c

:::::: TO: Steven Whitehouse <swhiteho@redhat.com>
:::::: CC: Steven Whitehouse <swhiteho@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

