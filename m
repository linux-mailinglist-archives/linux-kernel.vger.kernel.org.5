Return-Path: <linux-kernel+bounces-2838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED7F8162AB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 22:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B38FC1C2130A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3743E49F79;
	Sun, 17 Dec 2023 21:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4lLRFMI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54051481DA
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 21:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702850091; x=1734386091;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ps8nCaMb6NvWCzLIGWgbLWLYwfJl5PhO4jP5eM8uaHw=;
  b=R4lLRFMIVqTgnoMivo2nj2yrvKqXtihHEjOFswXnfMbmhA3qXgssXsiz
   q2lj1Al0O0rknle4lxII3hMoisb/3Kn76wn2CNtp+cHqTfhrKNhzUmppb
   52gt6po/0Vb+59LyllTLVg+OGx2c7NK5JZh7WhL3ETolByAE1kSSozExn
   IbkhAXsmnBxZht/UXOPrmLlkt/Nu6Z0NjS2wlPj/h4vg7y6z3pE2BLEMC
   PsjUSQBIteF/d1VJVelq7QGbDPwmBMEGa0c6PDLaxpju9I5U81v6Y6zL2
   2v+j1YPvJMCL7s50s7KiRiYmFXCP3j9cRNb/yeRwdf8QULWdd6S1tKOy5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="399266611"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="399266611"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 13:54:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="804336576"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="804336576"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 17 Dec 2023 13:54:48 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEz5y-0003Rj-27;
	Sun, 17 Dec 2023 21:54:46 +0000
Date: Mon, 18 Dec 2023 05:53:59 +0800
From: kernel test robot <lkp@intel.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Dave Chinner <dchinner@redhat.com>,
	Jan Kara <jack@suse.cz>
Subject: fs/gfs2/super.c:767: warning: Function parameter or struct member
 'who' not described in 'gfs2_freeze_super'
Message-ID: <202312180520.sGLQEPXk-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0e389834672c723435a44818ed2cabc4dad24429
commit: 880b9577855edddda1e732748e849c63199d489b fs: distinguish between user initiated freeze and kernel initiated freeze
date:   5 months ago
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20231218/202312180520.sGLQEPXk-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231218/202312180520.sGLQEPXk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312180520.sGLQEPXk-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/gfs2/super.c:767: warning: Function parameter or struct member 'who' not described in 'gfs2_freeze_super'
>> fs/gfs2/super.c:822: warning: Function parameter or struct member 'who' not described in 'gfs2_thaw_super'


vim +767 fs/gfs2/super.c

2e60d7683c8d2ea Benjamin Marzinski  2014-11-13  759  
9e6e0a128bca0a1 Steven Whitehouse   2009-05-22  760  /**
097cca525adf10f Andreas Gruenbacher 2022-11-14  761   * gfs2_freeze_super - prevent further writes to the filesystem
9e6e0a128bca0a1 Steven Whitehouse   2009-05-22  762   * @sb: the VFS structure for the filesystem
9e6e0a128bca0a1 Steven Whitehouse   2009-05-22  763   *
9e6e0a128bca0a1 Steven Whitehouse   2009-05-22  764   */
9e6e0a128bca0a1 Steven Whitehouse   2009-05-22  765  
880b9577855eddd Darrick J. Wong     2023-07-17  766  static int gfs2_freeze_super(struct super_block *sb, enum freeze_holder who)
9e6e0a128bca0a1 Steven Whitehouse   2009-05-22 @767  {
9e6e0a128bca0a1 Steven Whitehouse   2009-05-22  768  	struct gfs2_sbd *sdp = sb->s_fs_info;
ff132c5f93c06bd Bob Peterson        2021-03-25  769  	int error;
9e6e0a128bca0a1 Steven Whitehouse   2009-05-22  770  
b77b4a4815a9651 Andreas Gruenbacher 2022-11-14  771  	if (!mutex_trylock(&sdp->sd_freeze_mutex))
b77b4a4815a9651 Andreas Gruenbacher 2022-11-14  772  		return -EBUSY;
ff132c5f93c06bd Bob Peterson        2021-03-25  773  	error = -EBUSY;
5432af15f8772d5 Andreas Gruenbacher 2022-08-18  774  	if (test_bit(SDF_FROZEN, &sdp->sd_flags))
2e60d7683c8d2ea Benjamin Marzinski  2014-11-13  775  		goto out;
2e60d7683c8d2ea Benjamin Marzinski  2014-11-13  776  
60528afa78667ba Bob Peterson        2019-11-14  777  	for (;;) {
b77b4a4815a9651 Andreas Gruenbacher 2022-11-14  778  		error = gfs2_freeze_locally(sdp);
b77b4a4815a9651 Andreas Gruenbacher 2022-11-14  779  		if (error) {
b77b4a4815a9651 Andreas Gruenbacher 2022-11-14  780  			fs_info(sdp, "GFS2: couldn't freeze filesystem: %d\n",
b77b4a4815a9651 Andreas Gruenbacher 2022-11-14  781  				error);
2e60d7683c8d2ea Benjamin Marzinski  2014-11-13  782  			goto out;
2e60d7683c8d2ea Benjamin Marzinski  2014-11-13  783  		}
9e6e0a128bca0a1 Steven Whitehouse   2009-05-22  784  
52b1cdcb7a84a4a Bob Peterson        2019-11-15  785  		error = gfs2_lock_fs_check_clean(sdp);
9e6e0a128bca0a1 Steven Whitehouse   2009-05-22  786  		if (!error)
b77b4a4815a9651 Andreas Gruenbacher 2022-11-14  787  			break;  /* success */
b77b4a4815a9651 Andreas Gruenbacher 2022-11-14  788  
b77b4a4815a9651 Andreas Gruenbacher 2022-11-14  789  		error = gfs2_do_thaw(sdp);
b77b4a4815a9651 Andreas Gruenbacher 2022-11-14  790  		if (error)
b77b4a4815a9651 Andreas Gruenbacher 2022-11-14  791  			goto out;
9e6e0a128bca0a1 Steven Whitehouse   2009-05-22  792  
55317f5b00f0dc0 Bob Peterson        2019-04-29  793  		if (error == -EBUSY)
9e6e0a128bca0a1 Steven Whitehouse   2009-05-22  794  			fs_err(sdp, "waiting for recovery before freeze\n");
52b1cdcb7a84a4a Bob Peterson        2019-11-15  795  		else if (error == -EIO) {
52b1cdcb7a84a4a Bob Peterson        2019-11-15  796  			fs_err(sdp, "Fatal IO error: cannot freeze gfs2 due "
52b1cdcb7a84a4a Bob Peterson        2019-11-15  797  			       "to recovery error.\n");
52b1cdcb7a84a4a Bob Peterson        2019-11-15  798  			goto out;
52b1cdcb7a84a4a Bob Peterson        2019-11-15  799  		} else {
9e6e0a128bca0a1 Steven Whitehouse   2009-05-22  800  			fs_err(sdp, "error freezing FS: %d\n", error);
52b1cdcb7a84a4a Bob Peterson        2019-11-15  801  		}
9e6e0a128bca0a1 Steven Whitehouse   2009-05-22  802  		fs_err(sdp, "retrying...\n");
9e6e0a128bca0a1 Steven Whitehouse   2009-05-22  803  		msleep(1000);
9e6e0a128bca0a1 Steven Whitehouse   2009-05-22  804  	}
b77b4a4815a9651 Andreas Gruenbacher 2022-11-14  805  
2e60d7683c8d2ea Benjamin Marzinski  2014-11-13  806  out:
b77b4a4815a9651 Andreas Gruenbacher 2022-11-14  807  	if (!error) {
b77b4a4815a9651 Andreas Gruenbacher 2022-11-14  808  		set_bit(SDF_FREEZE_INITIATOR, &sdp->sd_flags);
5432af15f8772d5 Andreas Gruenbacher 2022-08-18  809  		set_bit(SDF_FROZEN, &sdp->sd_flags);
b77b4a4815a9651 Andreas Gruenbacher 2022-11-14  810  	}
2e60d7683c8d2ea Benjamin Marzinski  2014-11-13  811  	mutex_unlock(&sdp->sd_freeze_mutex);
2e60d7683c8d2ea Benjamin Marzinski  2014-11-13  812  	return error;
9e6e0a128bca0a1 Steven Whitehouse   2009-05-22  813  }
9e6e0a128bca0a1 Steven Whitehouse   2009-05-22  814  
9e6e0a128bca0a1 Steven Whitehouse   2009-05-22  815  /**
097cca525adf10f Andreas Gruenbacher 2022-11-14  816   * gfs2_thaw_super - reallow writes to the filesystem
9e6e0a128bca0a1 Steven Whitehouse   2009-05-22  817   * @sb: the VFS structure for the filesystem
9e6e0a128bca0a1 Steven Whitehouse   2009-05-22  818   *
9e6e0a128bca0a1 Steven Whitehouse   2009-05-22  819   */
9e6e0a128bca0a1 Steven Whitehouse   2009-05-22  820  
880b9577855eddd Darrick J. Wong     2023-07-17  821  static int gfs2_thaw_super(struct super_block *sb, enum freeze_holder who)
9e6e0a128bca0a1 Steven Whitehouse   2009-05-22 @822  {
d564053f074634e Steven Whitehouse   2013-01-11  823  	struct gfs2_sbd *sdp = sb->s_fs_info;
b77b4a4815a9651 Andreas Gruenbacher 2022-11-14  824  	int error;
d564053f074634e Steven Whitehouse   2013-01-11  825  
b77b4a4815a9651 Andreas Gruenbacher 2022-11-14  826  	if (!mutex_trylock(&sdp->sd_freeze_mutex))
b77b4a4815a9651 Andreas Gruenbacher 2022-11-14  827  		return -EBUSY;
b77b4a4815a9651 Andreas Gruenbacher 2022-11-14  828  	error = -EINVAL;
b77b4a4815a9651 Andreas Gruenbacher 2022-11-14  829  	if (!test_bit(SDF_FREEZE_INITIATOR, &sdp->sd_flags))
b77b4a4815a9651 Andreas Gruenbacher 2022-11-14  830  		goto out;
b77b4a4815a9651 Andreas Gruenbacher 2022-11-14  831  
b77b4a4815a9651 Andreas Gruenbacher 2022-11-14  832  	gfs2_freeze_unlock(&sdp->sd_freeze_gh);
b77b4a4815a9651 Andreas Gruenbacher 2022-11-14  833  
b77b4a4815a9651 Andreas Gruenbacher 2022-11-14  834  	error = gfs2_do_thaw(sdp);
b77b4a4815a9651 Andreas Gruenbacher 2022-11-14  835  
b77b4a4815a9651 Andreas Gruenbacher 2022-11-14  836  	if (!error) {
b77b4a4815a9651 Andreas Gruenbacher 2022-11-14  837  		clear_bit(SDF_FREEZE_INITIATOR, &sdp->sd_flags);
5432af15f8772d5 Andreas Gruenbacher 2022-08-18  838  		clear_bit(SDF_FROZEN, &sdp->sd_flags);
b77b4a4815a9651 Andreas Gruenbacher 2022-11-14  839  	}
b77b4a4815a9651 Andreas Gruenbacher 2022-11-14  840  out:
2e60d7683c8d2ea Benjamin Marzinski  2014-11-13  841  	mutex_unlock(&sdp->sd_freeze_mutex);
b77b4a4815a9651 Andreas Gruenbacher 2022-11-14  842  	return error;
2e60d7683c8d2ea Benjamin Marzinski  2014-11-13  843  }
2e60d7683c8d2ea Benjamin Marzinski  2014-11-13  844  

:::::: The code at line 767 was first introduced by commit
:::::: 9e6e0a128bca0a151d8d3fbd9459b22fc21cfebb GFS2: Merge mount.c and ops_super.c into super.c

:::::: TO: Steven Whitehouse <swhiteho@redhat.com>
:::::: CC: Steven Whitehouse <swhiteho@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

