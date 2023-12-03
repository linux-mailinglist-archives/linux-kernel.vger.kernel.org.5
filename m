Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477B7802136
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 07:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbjLCGHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 01:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbjLCGHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 01:07:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EF711A
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 22:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701583668; x=1733119668;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FvYuCQgoETlscpP3SdlpxI2DQw9k0aKMx7tUnP2NsYY=;
  b=nPqILi1LvIJZBEG+kWnPaIZFsg5raAvkf6yyQ1CAhAcjgIqickGrZBxS
   1r2oXly9kE4FgLJC8At0Adh1luec3zSZX5tQzdNP6srnXcDvAQ/MLD9dn
   UxNoSOwR6vgsLdbowOnnoetvmyNsXeSUB40uKwQSy0XnQDnKJ04xe2PVR
   YqSbOthH2cENbC1DZrubxSD4kJlH1DPiSMnBgTrnW/g03e47UkOhlLHcN
   0s0hpCuqHnkuhs7rtvogC1S+3V60ewET0srAIOdBfjUx4M4capE/2iZIa
   X5Xh9anoZ35nYASvr42LyWnjGSK7o1dT26XEDA+rWJqSIMbCqmLdSLnBy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="373049297"
X-IronPort-AV: E=Sophos;i="6.04,246,1695711600"; 
   d="scan'208";a="373049297"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 22:07:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="770187870"
X-IronPort-AV: E=Sophos;i="6.04,246,1695711600"; 
   d="scan'208";a="770187870"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 02 Dec 2023 22:07:43 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9fdl-0006IJ-0Q;
        Sun, 03 Dec 2023 06:07:41 +0000
Date:   Sun, 3 Dec 2023 14:07:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/mtd/ubi/fastmap.c:1014:17: sparse: sparse: incorrect type in
 assignment (different base types)
Message-ID: <202312021813.Xs1iEQjX-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   815fb87b753055df2d9e50f6cd80eb10235fe3e9
commit: 7322dd755e7dd34bc5359aa27abeed1687e0f628 byteswap: try to avoid __builtin_constant_p gcc bug
date:   8 years ago
config: x86_64-randconfig-123-20231101 (https://download.01.org/0day-ci/archive/20231202/202312021813.Xs1iEQjX-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231202/202312021813.Xs1iEQjX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312021813.Xs1iEQjX-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/mtd/ubi/fastmap.c:620:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long max_sqnum @@     got restricted __be64 [usertype] sqnum @@
   drivers/mtd/ubi/fastmap.c:620:23: sparse:     expected unsigned long long max_sqnum
   drivers/mtd/ubi/fastmap.c:620:23: sparse:     got restricted __be64 [usertype] sqnum
>> drivers/mtd/ubi/fastmap.c:1014:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] tmp_crc @@     got unsigned int [usertype] @@
   drivers/mtd/ubi/fastmap.c:1014:17: sparse:     expected restricted __be32 [usertype] tmp_crc
   drivers/mtd/ubi/fastmap.c:1014:17: sparse:     got unsigned int [usertype]
   drivers/mtd/ubi/fastmap.c:1016:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] crc @@     got unsigned int @@
   drivers/mtd/ubi/fastmap.c:1016:13: sparse:     expected restricted __be32 [usertype] crc
   drivers/mtd/ubi/fastmap.c:1016:13: sparse:     got unsigned int
   drivers/mtd/ubi/fastmap.c:1025:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be64 [usertype] sqnum @@     got unsigned long long [assigned] sqnum @@
   drivers/mtd/ubi/fastmap.c:1025:22: sparse:     expected restricted __be64 [usertype] sqnum
   drivers/mtd/ubi/fastmap.c:1025:22: sparse:     got unsigned long long [assigned] sqnum
   In file included from include/linux/kobject.h:21,
                    from include/linux/cdev.h:4,
                    from drivers/mtd/ubi/ubi.h:34,
                    from drivers/mtd/ubi/fastmap.c:18:
   include/linux/sysfs.h: In function 'sysfs_get_dirent':
   include/linux/sysfs.h:517:44: warning: pointer targets in passing argument 2 of 'kernfs_find_and_get' differ in signedness [-Wpointer-sign]
     517 |         return kernfs_find_and_get(parent, name);
         |                                            ^~~~
         |                                            |
         |                                            const unsigned char *
   In file included from include/linux/sysfs.h:15,
                    from include/linux/kobject.h:21,
                    from include/linux/cdev.h:4,
                    from drivers/mtd/ubi/ubi.h:34,
                    from drivers/mtd/ubi/fastmap.c:18:
   include/linux/kernfs.h:437:57: note: expected 'const char *' but argument is of type 'const unsigned char *'
     437 | kernfs_find_and_get(struct kernfs_node *kn, const char *name)
         |                                             ~~~~~~~~~~~~^~~~
   drivers/mtd/ubi/fastmap.c: In function 'ubi_attach_fastmap':
   drivers/mtd/ubi/fastmap.c:806:38: warning: taking address of packed member of 'struct ubi_fm_scan_pool' may result in an unaligned pointer value [-Waddress-of-packed-member]
     806 |         ret = scan_pool(ubi, ai, fmpl->pebs, pool_size, &max_sqnum, &free);
         |                                  ~~~~^~~~~~
   drivers/mtd/ubi/fastmap.c:810:41: warning: taking address of packed member of 'struct ubi_fm_scan_pool' may result in an unaligned pointer value [-Waddress-of-packed-member]
     810 |         ret = scan_pool(ubi, ai, fmpl_wl->pebs, wl_pool_size, &max_sqnum, &free);
         |                                  ~~~~~~~^~~~~~

vim +1014 drivers/mtd/ubi/fastmap.c

dbb7d2a88d2a7b Richard Weinberger 2012-09-26   851  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   852  /**
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   853   * ubi_scan_fastmap - scan the fastmap.
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   854   * @ubi: UBI device object
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   855   * @ai: UBI attach info to be filled
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   856   * @fm_anchor: The fastmap starts at this PEB
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   857   *
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   858   * Returns 0 on success, UBI_NO_FASTMAP if no fastmap was found,
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   859   * UBI_BAD_FASTMAP if one was found but is not usable.
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   860   * < 0 indicates an internal error.
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   861   */
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   862  int ubi_scan_fastmap(struct ubi_device *ubi, struct ubi_attach_info *ai,
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   863  		     int fm_anchor)
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   864  {
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   865  	struct ubi_fm_sb *fmsb, *fmsb2;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   866  	struct ubi_vid_hdr *vh;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   867  	struct ubi_ec_hdr *ech;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   868  	struct ubi_fastmap_layout *fm;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   869  	int i, used_blocks, pnum, ret = 0;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   870  	size_t fm_size;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   871  	__be32 crc, tmp_crc;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   872  	unsigned long long sqnum = 0;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   873  
111ab0b26fc1bf Richard Weinberger 2014-11-10   874  	down_write(&ubi->fm_protect);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   875  	memset(ubi->fm_buf, 0, ubi->fm_size);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   876  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   877  	fmsb = kmalloc(sizeof(*fmsb), GFP_KERNEL);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   878  	if (!fmsb) {
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   879  		ret = -ENOMEM;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   880  		goto out;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   881  	}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   882  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   883  	fm = kzalloc(sizeof(*fm), GFP_KERNEL);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   884  	if (!fm) {
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   885  		ret = -ENOMEM;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   886  		kfree(fmsb);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   887  		goto out;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   888  	}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   889  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   890  	ret = ubi_io_read(ubi, fmsb, fm_anchor, ubi->leb_start, sizeof(*fmsb));
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   891  	if (ret && ret != UBI_IO_BITFLIPS)
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   892  		goto free_fm_sb;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   893  	else if (ret == UBI_IO_BITFLIPS)
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   894  		fm->to_be_tortured[0] = 1;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   895  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   896  	if (be32_to_cpu(fmsb->magic) != UBI_FM_SB_MAGIC) {
326087033108e7 Tanya Brokhman     2014-10-20   897  		ubi_err(ubi, "bad super block magic: 0x%x, expected: 0x%x",
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   898  			be32_to_cpu(fmsb->magic), UBI_FM_SB_MAGIC);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   899  		ret = UBI_BAD_FASTMAP;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   900  		goto free_fm_sb;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   901  	}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   902  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   903  	if (fmsb->version != UBI_FM_FMT_VERSION) {
326087033108e7 Tanya Brokhman     2014-10-20   904  		ubi_err(ubi, "bad fastmap version: %i, expected: %i",
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   905  			fmsb->version, UBI_FM_FMT_VERSION);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   906  		ret = UBI_BAD_FASTMAP;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   907  		goto free_fm_sb;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   908  	}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   909  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   910  	used_blocks = be32_to_cpu(fmsb->used_blocks);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   911  	if (used_blocks > UBI_FM_MAX_BLOCKS || used_blocks < 1) {
326087033108e7 Tanya Brokhman     2014-10-20   912  		ubi_err(ubi, "number of fastmap blocks is invalid: %i",
326087033108e7 Tanya Brokhman     2014-10-20   913  			used_blocks);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   914  		ret = UBI_BAD_FASTMAP;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   915  		goto free_fm_sb;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   916  	}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   917  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   918  	fm_size = ubi->leb_size * used_blocks;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   919  	if (fm_size != ubi->fm_size) {
326087033108e7 Tanya Brokhman     2014-10-20   920  		ubi_err(ubi, "bad fastmap size: %zi, expected: %zi",
326087033108e7 Tanya Brokhman     2014-10-20   921  			fm_size, ubi->fm_size);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   922  		ret = UBI_BAD_FASTMAP;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   923  		goto free_fm_sb;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   924  	}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   925  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   926  	ech = kzalloc(ubi->ec_hdr_alsize, GFP_KERNEL);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   927  	if (!ech) {
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   928  		ret = -ENOMEM;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   929  		goto free_fm_sb;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   930  	}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   931  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   932  	vh = ubi_zalloc_vid_hdr(ubi, GFP_KERNEL);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   933  	if (!vh) {
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   934  		ret = -ENOMEM;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   935  		goto free_hdr;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   936  	}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   937  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   938  	for (i = 0; i < used_blocks; i++) {
c22301ad4fa0f4 Richard Genoud     2013-09-28   939  		int image_seq;
c22301ad4fa0f4 Richard Genoud     2013-09-28   940  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   941  		pnum = be32_to_cpu(fmsb->block_loc[i]);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   942  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   943  		if (ubi_io_is_bad(ubi, pnum)) {
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   944  			ret = UBI_BAD_FASTMAP;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   945  			goto free_hdr;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   946  		}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   947  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   948  		ret = ubi_io_read_ec_hdr(ubi, pnum, ech, 0);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   949  		if (ret && ret != UBI_IO_BITFLIPS) {
326087033108e7 Tanya Brokhman     2014-10-20   950  			ubi_err(ubi, "unable to read fastmap block# %i EC (PEB: %i)",
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   951  				i, pnum);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   952  			if (ret > 0)
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   953  				ret = UBI_BAD_FASTMAP;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   954  			goto free_hdr;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   955  		} else if (ret == UBI_IO_BITFLIPS)
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   956  			fm->to_be_tortured[i] = 1;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   957  
c22301ad4fa0f4 Richard Genoud     2013-09-28   958  		image_seq = be32_to_cpu(ech->image_seq);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   959  		if (!ubi->image_seq)
c22301ad4fa0f4 Richard Genoud     2013-09-28   960  			ubi->image_seq = image_seq;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   961  
c22301ad4fa0f4 Richard Genoud     2013-09-28   962  		/*
c22301ad4fa0f4 Richard Genoud     2013-09-28   963  		 * Older UBI implementations have image_seq set to zero, so
c22301ad4fa0f4 Richard Genoud     2013-09-28   964  		 * we shouldn't fail if image_seq == 0.
c22301ad4fa0f4 Richard Genoud     2013-09-28   965  		 */
c22301ad4fa0f4 Richard Genoud     2013-09-28   966  		if (image_seq && (image_seq != ubi->image_seq)) {
326087033108e7 Tanya Brokhman     2014-10-20   967  			ubi_err(ubi, "wrong image seq:%d instead of %d",
c22301ad4fa0f4 Richard Genoud     2013-09-28   968  				be32_to_cpu(ech->image_seq), ubi->image_seq);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   969  			ret = UBI_BAD_FASTMAP;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   970  			goto free_hdr;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   971  		}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   972  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   973  		ret = ubi_io_read_vid_hdr(ubi, pnum, vh, 0);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   974  		if (ret && ret != UBI_IO_BITFLIPS) {
326087033108e7 Tanya Brokhman     2014-10-20   975  			ubi_err(ubi, "unable to read fastmap block# %i (PEB: %i)",
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   976  				i, pnum);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   977  			goto free_hdr;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   978  		}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   979  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   980  		if (i == 0) {
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   981  			if (be32_to_cpu(vh->vol_id) != UBI_FM_SB_VOLUME_ID) {
326087033108e7 Tanya Brokhman     2014-10-20   982  				ubi_err(ubi, "bad fastmap anchor vol_id: 0x%x, expected: 0x%x",
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   983  					be32_to_cpu(vh->vol_id),
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   984  					UBI_FM_SB_VOLUME_ID);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   985  				ret = UBI_BAD_FASTMAP;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   986  				goto free_hdr;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   987  			}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   988  		} else {
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   989  			if (be32_to_cpu(vh->vol_id) != UBI_FM_DATA_VOLUME_ID) {
326087033108e7 Tanya Brokhman     2014-10-20   990  				ubi_err(ubi, "bad fastmap data vol_id: 0x%x, expected: 0x%x",
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   991  					be32_to_cpu(vh->vol_id),
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   992  					UBI_FM_DATA_VOLUME_ID);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   993  				ret = UBI_BAD_FASTMAP;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   994  				goto free_hdr;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   995  			}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   996  		}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   997  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   998  		if (sqnum < be64_to_cpu(vh->sqnum))
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   999  			sqnum = be64_to_cpu(vh->sqnum);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1000  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1001  		ret = ubi_io_read(ubi, ubi->fm_buf + (ubi->leb_size * i), pnum,
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1002  				  ubi->leb_start, ubi->leb_size);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1003  		if (ret && ret != UBI_IO_BITFLIPS) {
326087033108e7 Tanya Brokhman     2014-10-20  1004  			ubi_err(ubi, "unable to read fastmap block# %i (PEB: %i, "
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1005  				"err: %i)", i, pnum, ret);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1006  			goto free_hdr;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1007  		}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1008  	}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1009  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1010  	kfree(fmsb);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1011  	fmsb = NULL;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1012  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1013  	fmsb2 = (struct ubi_fm_sb *)(ubi->fm_buf);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26 @1014  	tmp_crc = be32_to_cpu(fmsb2->data_crc);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1015  	fmsb2->data_crc = 0;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1016  	crc = crc32(UBI_CRC32_INIT, ubi->fm_buf, fm_size);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1017  	if (crc != tmp_crc) {
326087033108e7 Tanya Brokhman     2014-10-20  1018  		ubi_err(ubi, "fastmap data CRC is invalid");
326087033108e7 Tanya Brokhman     2014-10-20  1019  		ubi_err(ubi, "CRC should be: 0x%x, calc: 0x%x",
326087033108e7 Tanya Brokhman     2014-10-20  1020  			tmp_crc, crc);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1021  		ret = UBI_BAD_FASTMAP;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1022  		goto free_hdr;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1023  	}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1024  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1025  	fmsb2->sqnum = sqnum;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1026  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1027  	fm->used_blocks = used_blocks;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1028  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1029  	ret = ubi_attach_fastmap(ubi, ai, fm);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1030  	if (ret) {
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1031  		if (ret > 0)
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1032  			ret = UBI_BAD_FASTMAP;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1033  		goto free_hdr;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1034  	}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1035  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1036  	for (i = 0; i < used_blocks; i++) {
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1037  		struct ubi_wl_entry *e;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1038  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1039  		e = kmem_cache_alloc(ubi_wl_entry_slab, GFP_KERNEL);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1040  		if (!e) {
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1041  			while (i--)
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1042  				kfree(fm->e[i]);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1043  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1044  			ret = -ENOMEM;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1045  			goto free_hdr;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1046  		}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1047  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1048  		e->pnum = be32_to_cpu(fmsb2->block_loc[i]);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1049  		e->ec = be32_to_cpu(fmsb2->block_ec[i]);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1050  		fm->e[i] = e;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1051  	}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1052  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1053  	ubi->fm = fm;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1054  	ubi->fm_pool.max_size = ubi->fm->max_pool_size;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1055  	ubi->fm_wl_pool.max_size = ubi->fm->max_wl_pool_size;
326087033108e7 Tanya Brokhman     2014-10-20  1056  	ubi_msg(ubi, "attached by fastmap");
326087033108e7 Tanya Brokhman     2014-10-20  1057  	ubi_msg(ubi, "fastmap pool size: %d", ubi->fm_pool.max_size);
326087033108e7 Tanya Brokhman     2014-10-20  1058  	ubi_msg(ubi, "fastmap WL pool size: %d",
326087033108e7 Tanya Brokhman     2014-10-20  1059  		ubi->fm_wl_pool.max_size);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1060  	ubi->fm_disabled = 0;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1061  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1062  	ubi_free_vid_hdr(ubi, vh);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1063  	kfree(ech);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1064  out:
111ab0b26fc1bf Richard Weinberger 2014-11-10  1065  	up_write(&ubi->fm_protect);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1066  	if (ret == UBI_BAD_FASTMAP)
326087033108e7 Tanya Brokhman     2014-10-20  1067  		ubi_err(ubi, "Attach by fastmap failed, doing a full scan!");
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1068  	return ret;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1069  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1070  free_hdr:
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1071  	ubi_free_vid_hdr(ubi, vh);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1072  	kfree(ech);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1073  free_fm_sb:
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1074  	kfree(fmsb);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1075  	kfree(fm);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1076  	goto out;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1077  }
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1078  

:::::: The code at line 1014 was first introduced by commit
:::::: dbb7d2a88d2a7bd3624e090bee42cdee048d9290 UBI: Add fastmap core

:::::: TO: Richard Weinberger <richard@nod.at>
:::::: CC: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
