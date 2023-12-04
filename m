Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43512803E97
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbjLDTlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbjLDTlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:41:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F4B109
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701718910; x=1733254910;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=N4IABidXLCDgGx2ggOP6a6/JI5fLeYZ35dtg43Hk+Xs=;
  b=JkwkaYEc3JxcCVAjRN/YHWVLcHKeoSpaWV/2/m3Iz6Lgkn8iHbPZayfm
   S2t/vm8fuqb3Oh4WgMptCqSIUlP2XxbLs5+dSNiyuXYyWGu8JpJTehvV6
   NwUWsJqp7t05iYKSJmc7cGb3QFn5rGUgyTGQc8lR5sUtpDQEfxW+5VRDV
   hwppyXBKDUFuYvv4/q/dCPk67IWkhPXiJ+vJYRrHwwtAOQPIreRpwRx5f
   m+IQ5DgD3+ZOykDd4wx++tv9o7mzCUlPe0Gq/usVGz4/qVGkWRqEsFayR
   +5exw4JB7tpq4GZmi4bJFKUHISAwaXMMi9J6tjNgxoWt6SfAHtMe/qmVf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="460281348"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="460281348"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 11:41:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="720426405"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="720426405"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 04 Dec 2023 11:41:48 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAEp3-00081z-2l;
        Mon, 04 Dec 2023 19:41:43 +0000
Date:   Tue, 5 Dec 2023 03:40:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/freevxfs/vxfs_immed.c:67: warning: Function parameter or member
 'fp' not described in 'vxfs_immed_read_folio'
Message-ID: <202312050334.bmiUtFL0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
commit: 42d7a524e9ee13f6ea8b1539a293a365db2ba2f5 freevxfs: Convert vxfs_immed to read_folio
date:   1 year, 7 months ago
config: x86_64-buildonly-randconfig-004-20231010 (https://download.01.org/0day-ci/archive/20231205/202312050334.bmiUtFL0-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231205/202312050334.bmiUtFL0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312050334.bmiUtFL0-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/freevxfs/vxfs_immed.c:67: warning: Function parameter or member 'fp' not described in 'vxfs_immed_read_folio'
>> fs/freevxfs/vxfs_immed.c:67: warning: Excess function parameter 'file' description in 'vxfs_immed_read_folio'


vim +67 fs/freevxfs/vxfs_immed.c

^1da177e4c3f41 Linus Torvalds          2005-04-16  49  
^1da177e4c3f41 Linus Torvalds          2005-04-16  50  /**
42d7a524e9ee13 Matthew Wilcox (Oracle  2022-04-29  51)  * vxfs_immed_read_folio - read part of an immed inode into pagecache
^1da177e4c3f41 Linus Torvalds          2005-04-16  52   * @file:	file context (unused)
42d7a524e9ee13 Matthew Wilcox (Oracle  2022-04-29  53)  * @folio:	folio to fill in.
^1da177e4c3f41 Linus Torvalds          2005-04-16  54   *
^1da177e4c3f41 Linus Torvalds          2005-04-16  55   * Description:
42d7a524e9ee13 Matthew Wilcox (Oracle  2022-04-29  56)  *   vxfs_immed_read_folio reads a part of the immed area of the
^1da177e4c3f41 Linus Torvalds          2005-04-16  57   *   file that hosts @pp into the pagecache.
^1da177e4c3f41 Linus Torvalds          2005-04-16  58   *
^1da177e4c3f41 Linus Torvalds          2005-04-16  59   * Returns:
^1da177e4c3f41 Linus Torvalds          2005-04-16  60   *   Zero on success, else a negative error code.
^1da177e4c3f41 Linus Torvalds          2005-04-16  61   *
^1da177e4c3f41 Linus Torvalds          2005-04-16  62   * Locking status:
42d7a524e9ee13 Matthew Wilcox (Oracle  2022-04-29  63)  *   @folio is locked and will be unlocked.
^1da177e4c3f41 Linus Torvalds          2005-04-16  64   */
^1da177e4c3f41 Linus Torvalds          2005-04-16  65  static int
42d7a524e9ee13 Matthew Wilcox (Oracle  2022-04-29  66) vxfs_immed_read_folio(struct file *fp, struct folio *folio)
^1da177e4c3f41 Linus Torvalds          2005-04-16 @67  {

:::::: The code at line 67 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
