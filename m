Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF45180666D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 06:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376674AbjLFFF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 00:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjLFFFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 00:05:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7851BC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 21:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701839159; x=1733375159;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GgrGMtahogPX+H5rTdS7tEecq4o4twOfkxbODauWoPs=;
  b=MiIlKKvlk6DPvkDmEu3SgkTMN8EAcXLRqDdxN76PsDP1FSVAtrtsgmQ4
   wtgkS89rZmcVH4uBb4wW7OtJF+GUmjCz++Hwf647ei4NHPlwLOC25UaAh
   0018PuxE2N94BkkvI3zDZybCuteTJPlBL3nRcj/Z4W4Ll50Gz/p/RSHUA
   7BTvVPjgw/b9k/1QBgpGSOyGmAr6fSja+ZcZ7DYQJ6VVMjRxEjeedvCkH
   aw+hOg95YLRU6UmxOx1xOBf5maBBV9YOo1DONujkPyG2R9KLf0EPrCbrG
   9FVM4qH7imY3e2kJH571JURIjdTJUeCb9yFpQMyDIWB46NRs/QwBoSpd/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="373468566"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="373468566"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 21:05:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="12566290"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 05 Dec 2023 21:05:57 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAk6c-000AJ8-1K;
        Wed, 06 Dec 2023 05:05:54 +0000
Date:   Wed, 6 Dec 2023 13:04:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: fs/xfs/xfs_trans.c:559:33: warning: variable 'error' set but not used
Message-ID: <202312061220.4FdkDRJD-lkp@intel.com>
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

Hi Dave,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
commit: dc3ffbb14060c943469d5e12900db3a60bc3fa64 xfs: gut error handling in xfs_trans_unreserve_and_mod_sb()
date:   3 years, 6 months ago
config: parisc-randconfig-m041-20230821 (https://download.01.org/0day-ci/archive/20231206/202312061220.4FdkDRJD-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20231206/202312061220.4FdkDRJD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312061220.4FdkDRJD-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/mm.h:95,
                    from fs/xfs/kmem.h:11,
                    from fs/xfs/xfs_linux.h:24,
                    from fs/xfs/xfs.h:22,
                    from fs/xfs/xfs_trans.c:7:
   include/asm-generic/pgtable.h: In function 'pte_clear_not_present_full':
   arch/parisc/include/asm/pgtable.h:96:23: warning: variable 'old_pte' set but not used [-Wunused-but-set-variable]
      96 |                 pte_t old_pte;                                  \
         |                       ^~~~~~~
   arch/parisc/include/asm/pgtable.h:322:34: note: in expansion of macro 'set_pte_at'
     322 | #define pte_clear(mm, addr, xp)  set_pte_at(mm, addr, xp, __pte(0))
         |                                  ^~~~~~~~~~
   include/asm-generic/pgtable.h:202:9: note: in expansion of macro 'pte_clear'
     202 |         pte_clear(mm, address, ptep);
         |         ^~~~~~~~~
   include/asm-generic/pgtable.h: In function '__ptep_modify_prot_commit':
   arch/parisc/include/asm/pgtable.h:96:23: warning: variable 'old_pte' set but not used [-Wunused-but-set-variable]
      96 |                 pte_t old_pte;                                  \
         |                       ^~~~~~~
   include/asm-generic/pgtable.h:641:9: note: in expansion of macro 'set_pte_at'
     641 |         set_pte_at(vma->vm_mm, addr, ptep, pte);
         |         ^~~~~~~~~~
   fs/xfs/xfs_trans.c: In function 'xfs_trans_unreserve_and_mod_sb':
>> fs/xfs/xfs_trans.c:559:33: warning: variable 'error' set but not used [-Wunused-but-set-variable]
     559 |         int                     error;
         |                                 ^~~~~


vim +/error +559 fs/xfs/xfs_trans.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  536  
^1da177e4c3f41 Linus Torvalds    2005-04-16  537  /*
dc3ffbb14060c9 Dave Chinner      2020-05-20  538   * xfs_trans_unreserve_and_mod_sb() is called to release unused reservations and
dc3ffbb14060c9 Dave Chinner      2020-05-20  539   * apply superblock counter changes to the in-core superblock.  The
45c34141126a89 David Chinner     2007-06-18  540   * t_res_fdblocks_delta and t_res_frextents_delta fields are explicitly NOT
45c34141126a89 David Chinner     2007-06-18  541   * applied to the in-core superblock.  The idea is that that has already been
45c34141126a89 David Chinner     2007-06-18  542   * done.
^1da177e4c3f41 Linus Torvalds    2005-04-16  543   *
45c34141126a89 David Chinner     2007-06-18  544   * If we are not logging superblock counters, then the inode allocated/free and
45c34141126a89 David Chinner     2007-06-18  545   * used block counts are not updated in the on disk superblock. In this case,
45c34141126a89 David Chinner     2007-06-18  546   * XFS_TRANS_SB_DIRTY will not be set when the transaction is updated but we
45c34141126a89 David Chinner     2007-06-18  547   * still need to update the incore superblock with the changes.
^1da177e4c3f41 Linus Torvalds    2005-04-16  548   */
71e330b593905e Dave Chinner      2010-05-21  549  void
^1da177e4c3f41 Linus Torvalds    2005-04-16  550  xfs_trans_unreserve_and_mod_sb(
0bd5ddedccca44 Dave Chinner      2015-02-23  551  	struct xfs_trans	*tp)
^1da177e4c3f41 Linus Torvalds    2005-04-16  552  {
0bd5ddedccca44 Dave Chinner      2015-02-23  553  	struct xfs_mount	*mp = tp->t_mountp;
0d485ada404b36 Dave Chinner      2015-02-23  554  	bool			rsvd = (tp->t_flags & XFS_TRANS_RESERVE) != 0;
45c34141126a89 David Chinner     2007-06-18  555  	int64_t			blkdelta = 0;
45c34141126a89 David Chinner     2007-06-18  556  	int64_t			rtxdelta = 0;
1b0407125f9a5b Christoph Hellwig 2010-09-30  557  	int64_t			idelta = 0;
1b0407125f9a5b Christoph Hellwig 2010-09-30  558  	int64_t			ifreedelta = 0;
0bd5ddedccca44 Dave Chinner      2015-02-23 @559  	int			error;
^1da177e4c3f41 Linus Torvalds    2005-04-16  560  
1b0407125f9a5b Christoph Hellwig 2010-09-30  561  	/* calculate deltas */
45c34141126a89 David Chinner     2007-06-18  562  	if (tp->t_blk_res > 0)
45c34141126a89 David Chinner     2007-06-18  563  		blkdelta = tp->t_blk_res;
45c34141126a89 David Chinner     2007-06-18  564  	if ((tp->t_fdblocks_delta != 0) &&
45c34141126a89 David Chinner     2007-06-18  565  	    (xfs_sb_version_haslazysbcount(&mp->m_sb) ||
45c34141126a89 David Chinner     2007-06-18  566  	     (tp->t_flags & XFS_TRANS_SB_DIRTY)))
45c34141126a89 David Chinner     2007-06-18  567  	        blkdelta += tp->t_fdblocks_delta;
45c34141126a89 David Chinner     2007-06-18  568  
45c34141126a89 David Chinner     2007-06-18  569  	if (tp->t_rtx_res > 0)
45c34141126a89 David Chinner     2007-06-18  570  		rtxdelta = tp->t_rtx_res;
45c34141126a89 David Chinner     2007-06-18  571  	if ((tp->t_frextents_delta != 0) &&
45c34141126a89 David Chinner     2007-06-18  572  	    (tp->t_flags & XFS_TRANS_SB_DIRTY))
45c34141126a89 David Chinner     2007-06-18  573  		rtxdelta += tp->t_frextents_delta;
45c34141126a89 David Chinner     2007-06-18  574  
1b0407125f9a5b Christoph Hellwig 2010-09-30  575  	if (xfs_sb_version_haslazysbcount(&mp->m_sb) ||
1b0407125f9a5b Christoph Hellwig 2010-09-30  576  	     (tp->t_flags & XFS_TRANS_SB_DIRTY)) {
1b0407125f9a5b Christoph Hellwig 2010-09-30  577  		idelta = tp->t_icount_delta;
1b0407125f9a5b Christoph Hellwig 2010-09-30  578  		ifreedelta = tp->t_ifree_delta;
^1da177e4c3f41 Linus Torvalds    2005-04-16  579  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  580  
1b0407125f9a5b Christoph Hellwig 2010-09-30  581  	/* apply the per-cpu counters */
1b0407125f9a5b Christoph Hellwig 2010-09-30  582  	if (blkdelta) {
0d485ada404b36 Dave Chinner      2015-02-23  583  		error = xfs_mod_fdblocks(mp, blkdelta, rsvd);
dc3ffbb14060c9 Dave Chinner      2020-05-20  584  		ASSERT(!error);
1b0407125f9a5b Christoph Hellwig 2010-09-30  585  	}
45c34141126a89 David Chinner     2007-06-18  586  
1b0407125f9a5b Christoph Hellwig 2010-09-30  587  	if (idelta) {
501ab323875339 Dave Chinner      2015-02-23  588  		error = xfs_mod_icount(mp, idelta);
dc3ffbb14060c9 Dave Chinner      2020-05-20  589  		ASSERT(!error);
^1da177e4c3f41 Linus Torvalds    2005-04-16  590  	}
1b0407125f9a5b Christoph Hellwig 2010-09-30  591  
1b0407125f9a5b Christoph Hellwig 2010-09-30  592  	if (ifreedelta) {
e88b64ea1f3da6 Dave Chinner      2015-02-23  593  		error = xfs_mod_ifree(mp, ifreedelta);
dc3ffbb14060c9 Dave Chinner      2020-05-20  594  		ASSERT(!error);
^1da177e4c3f41 Linus Torvalds    2005-04-16  595  	}
1b0407125f9a5b Christoph Hellwig 2010-09-30  596  
0bd5ddedccca44 Dave Chinner      2015-02-23  597  	if (rtxdelta == 0 && !(tp->t_flags & XFS_TRANS_SB_DIRTY))
0bd5ddedccca44 Dave Chinner      2015-02-23  598  		return;
0bd5ddedccca44 Dave Chinner      2015-02-23  599  
1b0407125f9a5b Christoph Hellwig 2010-09-30  600  	/* apply remaining deltas */
0bd5ddedccca44 Dave Chinner      2015-02-23  601  	spin_lock(&mp->m_sb_lock);
dc3ffbb14060c9 Dave Chinner      2020-05-20  602  	mp->m_sb.sb_frextents += rtxdelta;
dc3ffbb14060c9 Dave Chinner      2020-05-20  603  	mp->m_sb.sb_dblocks += tp->t_dblocks_delta;
dc3ffbb14060c9 Dave Chinner      2020-05-20  604  	mp->m_sb.sb_agcount += tp->t_agcount_delta;
dc3ffbb14060c9 Dave Chinner      2020-05-20  605  	mp->m_sb.sb_imax_pct += tp->t_imaxpct_delta;
dc3ffbb14060c9 Dave Chinner      2020-05-20  606  	mp->m_sb.sb_rextsize += tp->t_rextsize_delta;
dc3ffbb14060c9 Dave Chinner      2020-05-20  607  	mp->m_sb.sb_rbmblocks += tp->t_rbmblocks_delta;
dc3ffbb14060c9 Dave Chinner      2020-05-20  608  	mp->m_sb.sb_rblocks += tp->t_rblocks_delta;
dc3ffbb14060c9 Dave Chinner      2020-05-20  609  	mp->m_sb.sb_rextents += tp->t_rextents_delta;
dc3ffbb14060c9 Dave Chinner      2020-05-20  610  	mp->m_sb.sb_rextslog += tp->t_rextslog_delta;
0bd5ddedccca44 Dave Chinner      2015-02-23  611  	spin_unlock(&mp->m_sb_lock);
1b0407125f9a5b Christoph Hellwig 2010-09-30  612  
dc3ffbb14060c9 Dave Chinner      2020-05-20  613  	/*
dc3ffbb14060c9 Dave Chinner      2020-05-20  614  	 * Debug checks outside of the spinlock so they don't lock up the
dc3ffbb14060c9 Dave Chinner      2020-05-20  615  	 * machine if they fail.
dc3ffbb14060c9 Dave Chinner      2020-05-20  616  	 */
dc3ffbb14060c9 Dave Chinner      2020-05-20  617  	ASSERT(mp->m_sb.sb_imax_pct >= 0);
dc3ffbb14060c9 Dave Chinner      2020-05-20  618  	ASSERT(mp->m_sb.sb_rextslog >= 0);
1b0407125f9a5b Christoph Hellwig 2010-09-30  619  	return;
^1da177e4c3f41 Linus Torvalds    2005-04-16  620  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  621  

:::::: The code at line 559 was first introduced by commit
:::::: 0bd5ddedccca4451ac2390d1155b4ab74b990eff xfs: replace xfs_mod_incore_sb_batched

:::::: TO: Dave Chinner <dchinner@redhat.com>
:::::: CC: Dave Chinner <david@fromorbit.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
