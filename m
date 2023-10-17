Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1A47CC626
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344061AbjJQOr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbjJQOrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:47:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF291B0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697554043; x=1729090043;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GbV91QQ0fZsJEzBokfgSUNLl3uhKc/V/f5oCxATlZ1U=;
  b=QDpVkXvGX9O/hhdt9GdpAErTo0csUk6a+4Xo6AGnXHroopmW35/HowYJ
   /sDFIRWY49WwibQpO/VeThLK9Xdo+f/qZ3+C7cXhRhIuDElKatVgk+eG+
   qPidVUQ2om4es6ISnfmZlyeFQ1R6sCYgaEBUdCIPSiBBKhk5BKjGaDW4D
   Kc/AAwoRubaNW+V3izaVVlLf5pdwwnRzAD3VUkZNtS/uoeM1UXofCmyH0
   87gnigulSV88q2oZIIuj2CF9K8Inlk7I126bguPaQic8PgqV/Kw8N4MoH
   rTsxjE1grnwwKzvbZJuPQGt6n6xDxJ4EndPmdSqJWBzb7V2r08c6a43VM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="4396913"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="4396913"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 07:47:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="791249568"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="791249568"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 17 Oct 2023 07:47:20 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qslLp-0009gn-3A;
        Tue, 17 Oct 2023 14:47:17 +0000
Date:   Tue, 17 Oct 2023 22:47:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>
Subject: fs/gfs2/super.c:767: warning: Function parameter or member 'who' not
 described in 'gfs2_freeze_super'
Message-ID: <202310172247.ihJFHycv-lkp@intel.com>
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

Hi Darrick,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   213f891525c222e8ed145ce1ce7ae1f47921cb9c
commit: 880b9577855edddda1e732748e849c63199d489b fs: distinguish between user initiated freeze and kernel initiated freeze
date:   3 months ago
config: x86_64-buildonly-randconfig-001-20231012 (https://download.01.org/0day-ci/archive/20231017/202310172247.ihJFHycv-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231017/202310172247.ihJFHycv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310172247.ihJFHycv-lkp@intel.com/

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
