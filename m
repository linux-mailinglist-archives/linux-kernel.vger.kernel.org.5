Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9419B7E8BD2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 18:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjKKRS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 12:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKKRS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 12:18:57 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CA93860
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 09:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699723134; x=1731259134;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Zl5wRSekfT4CTjRhGGwX7nkyFiIAdgWB12bwQ5UL76k=;
  b=NcZhUvfNqRyGhfl4KoeKu6aano/cfzKUrC7kzyEgX5ndQ6EGbRR1i1ZP
   3+9RUHsoUW111rJzUP3v8TfR4cFON5Zftk31vTHGMz0mqzeL4u9f6SeBk
   eue6jOTb4XcHyMvM6ct+K9GWwaXYAm2tXgpWf7y90Au/pF9UsIooFWTwC
   RiM09WnHrWgbzN50VS0cbyAFwXvhQ52IgnhImREQloZUh9E9WHtZgOqFL
   5G5/usUeiO21fZFpjpWmt1sGFrHqcKpE5f7Fde3P8YxBaS06Q8tcSjGt5
   GHLoOrBvAvsfNzz51CAWHUqofbd4CkC5Uu8wGu0CRShk3yIq/w19vovni
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="3345732"
X-IronPort-AV: E=Sophos;i="6.03,295,1694761200"; 
   d="scan'208";a="3345732"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 09:18:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,295,1694761200"; 
   d="scan'208";a="11701484"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 11 Nov 2023 09:18:51 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1rdB-000Adu-06;
        Sat, 11 Nov 2023 17:18:49 +0000
Date:   Sun, 12 Nov 2023 01:17:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/mtd/ubi/fastmap.c:1028:17: sparse: sparse: incorrect type in
 assignment (different base types)
Message-ID: <202311120122.miUV2XBw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3ca112b71f35dd5d99fc4571a56b5fc6f0c15814
commit: d991bb1c8da842a2a0b9dc83b1005e655783f861 include/linux/compiler-gcc.h: sparse can do constant folding of __builtin_bswap*()
date:   2 years, 6 months ago
config: i386-randconfig-062-20230912 (https://download.01.org/0day-ci/archive/20231112/202311120122.miUV2XBw-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231112/202311120122.miUV2XBw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311120122.miUV2XBw-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/mtd/ubi/fastmap.c:569:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long max_sqnum @@     got restricted __be64 [usertype] sqnum @@
   drivers/mtd/ubi/fastmap.c:569:23: sparse:     expected unsigned long long max_sqnum
   drivers/mtd/ubi/fastmap.c:569:23: sparse:     got restricted __be64 [usertype] sqnum
>> drivers/mtd/ubi/fastmap.c:1028:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] tmp_crc @@     got unsigned int [usertype] @@
   drivers/mtd/ubi/fastmap.c:1028:17: sparse:     expected restricted __be32 [usertype] tmp_crc
   drivers/mtd/ubi/fastmap.c:1028:17: sparse:     got unsigned int [usertype]
   drivers/mtd/ubi/fastmap.c:1030:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] crc @@     got unsigned int @@
   drivers/mtd/ubi/fastmap.c:1030:13: sparse:     expected restricted __be32 [usertype] crc
   drivers/mtd/ubi/fastmap.c:1030:13: sparse:     got unsigned int
   drivers/mtd/ubi/fastmap.c:1039:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be64 [usertype] sqnum @@     got unsigned long long [assigned] sqnum @@
   drivers/mtd/ubi/fastmap.c:1039:22: sparse:     expected restricted __be64 [usertype] sqnum
   drivers/mtd/ubi/fastmap.c:1039:22: sparse:     got unsigned long long [assigned] sqnum

vim +1028 drivers/mtd/ubi/fastmap.c

8a1435880f4524 Rabin Vincent      2017-04-03   838  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   839  /**
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   840   * ubi_scan_fastmap - scan the fastmap.
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   841   * @ubi: UBI device object
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   842   * @ai: UBI attach info to be filled
fdf10ed710c0aa Richard Weinberger 2016-06-14   843   * @scan_ai: UBI attach info from the first 64 PEBs,
fdf10ed710c0aa Richard Weinberger 2016-06-14   844   *           used to find the most recent Fastmap data structure
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   845   *
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   846   * Returns 0 on success, UBI_NO_FASTMAP if no fastmap was found,
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   847   * UBI_BAD_FASTMAP if one was found but is not usable.
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   848   * < 0 indicates an internal error.
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   849   */
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   850  int ubi_scan_fastmap(struct ubi_device *ubi, struct ubi_attach_info *ai,
fdf10ed710c0aa Richard Weinberger 2016-06-14   851  		     struct ubi_attach_info *scan_ai)
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   852  {
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   853  	struct ubi_fm_sb *fmsb, *fmsb2;
3291b52f9ff0ac Boris Brezillon    2016-09-16   854  	struct ubi_vid_io_buf *vb;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   855  	struct ubi_vid_hdr *vh;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   856  	struct ubi_ec_hdr *ech;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   857  	struct ubi_fastmap_layout *fm;
8a1435880f4524 Rabin Vincent      2017-04-03   858  	struct ubi_ainf_peb *aeb;
fdf10ed710c0aa Richard Weinberger 2016-06-14   859  	int i, used_blocks, pnum, fm_anchor, ret = 0;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   860  	size_t fm_size;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   861  	__be32 crc, tmp_crc;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   862  	unsigned long long sqnum = 0;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   863  
fdf10ed710c0aa Richard Weinberger 2016-06-14   864  	fm_anchor = find_fm_anchor(scan_ai);
fdf10ed710c0aa Richard Weinberger 2016-06-14   865  	if (fm_anchor < 0)
fdf10ed710c0aa Richard Weinberger 2016-06-14   866  		return UBI_NO_FASTMAP;
fdf10ed710c0aa Richard Weinberger 2016-06-14   867  
8a1435880f4524 Rabin Vincent      2017-04-03   868  	/* Copy all (possible) fastmap blocks into our new attach structure. */
8a1435880f4524 Rabin Vincent      2017-04-03   869  	list_for_each_entry(aeb, &scan_ai->fastmap, u.list) {
8a1435880f4524 Rabin Vincent      2017-04-03   870  		struct ubi_ainf_peb *new;
8a1435880f4524 Rabin Vincent      2017-04-03   871  
8a1435880f4524 Rabin Vincent      2017-04-03   872  		new = clone_aeb(ai, aeb);
8a1435880f4524 Rabin Vincent      2017-04-03   873  		if (!new)
8a1435880f4524 Rabin Vincent      2017-04-03   874  			return -ENOMEM;
8a1435880f4524 Rabin Vincent      2017-04-03   875  
8a1435880f4524 Rabin Vincent      2017-04-03   876  		list_add(&new->u.list, &ai->fastmap);
8a1435880f4524 Rabin Vincent      2017-04-03   877  	}
fdf10ed710c0aa Richard Weinberger 2016-06-14   878  
111ab0b26fc1bf Richard Weinberger 2014-11-10   879  	down_write(&ubi->fm_protect);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   880  	memset(ubi->fm_buf, 0, ubi->fm_size);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   881  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   882  	fmsb = kmalloc(sizeof(*fmsb), GFP_KERNEL);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   883  	if (!fmsb) {
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   884  		ret = -ENOMEM;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   885  		goto out;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   886  	}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   887  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   888  	fm = kzalloc(sizeof(*fm), GFP_KERNEL);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   889  	if (!fm) {
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   890  		ret = -ENOMEM;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   891  		kfree(fmsb);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   892  		goto out;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   893  	}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   894  
fcbb6af17bda4b Boris Brezillon    2016-09-16   895  	ret = ubi_io_read_data(ubi, fmsb, fm_anchor, 0, sizeof(*fmsb));
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   896  	if (ret && ret != UBI_IO_BITFLIPS)
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   897  		goto free_fm_sb;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   898  	else if (ret == UBI_IO_BITFLIPS)
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   899  		fm->to_be_tortured[0] = 1;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   900  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   901  	if (be32_to_cpu(fmsb->magic) != UBI_FM_SB_MAGIC) {
326087033108e7 Tanya Brokhman     2014-10-20   902  		ubi_err(ubi, "bad super block magic: 0x%x, expected: 0x%x",
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   903  			be32_to_cpu(fmsb->magic), UBI_FM_SB_MAGIC);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   904  		ret = UBI_BAD_FASTMAP;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   905  		goto free_fm_sb;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   906  	}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   907  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   908  	if (fmsb->version != UBI_FM_FMT_VERSION) {
326087033108e7 Tanya Brokhman     2014-10-20   909  		ubi_err(ubi, "bad fastmap version: %i, expected: %i",
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   910  			fmsb->version, UBI_FM_FMT_VERSION);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   911  		ret = UBI_BAD_FASTMAP;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   912  		goto free_fm_sb;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   913  	}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   914  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   915  	used_blocks = be32_to_cpu(fmsb->used_blocks);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   916  	if (used_blocks > UBI_FM_MAX_BLOCKS || used_blocks < 1) {
326087033108e7 Tanya Brokhman     2014-10-20   917  		ubi_err(ubi, "number of fastmap blocks is invalid: %i",
326087033108e7 Tanya Brokhman     2014-10-20   918  			used_blocks);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   919  		ret = UBI_BAD_FASTMAP;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   920  		goto free_fm_sb;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   921  	}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   922  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   923  	fm_size = ubi->leb_size * used_blocks;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   924  	if (fm_size != ubi->fm_size) {
326087033108e7 Tanya Brokhman     2014-10-20   925  		ubi_err(ubi, "bad fastmap size: %zi, expected: %zi",
326087033108e7 Tanya Brokhman     2014-10-20   926  			fm_size, ubi->fm_size);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   927  		ret = UBI_BAD_FASTMAP;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   928  		goto free_fm_sb;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   929  	}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   930  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   931  	ech = kzalloc(ubi->ec_hdr_alsize, GFP_KERNEL);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   932  	if (!ech) {
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   933  		ret = -ENOMEM;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   934  		goto free_fm_sb;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   935  	}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   936  
3291b52f9ff0ac Boris Brezillon    2016-09-16   937  	vb = ubi_alloc_vid_buf(ubi, GFP_KERNEL);
3291b52f9ff0ac Boris Brezillon    2016-09-16   938  	if (!vb) {
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   939  		ret = -ENOMEM;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   940  		goto free_hdr;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   941  	}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   942  
3291b52f9ff0ac Boris Brezillon    2016-09-16   943  	vh = ubi_get_vid_hdr(vb);
3291b52f9ff0ac Boris Brezillon    2016-09-16   944  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   945  	for (i = 0; i < used_blocks; i++) {
c22301ad4fa0f4 Richard Genoud     2013-09-28   946  		int image_seq;
c22301ad4fa0f4 Richard Genoud     2013-09-28   947  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   948  		pnum = be32_to_cpu(fmsb->block_loc[i]);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   949  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   950  		if (ubi_io_is_bad(ubi, pnum)) {
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   951  			ret = UBI_BAD_FASTMAP;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   952  			goto free_hdr;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   953  		}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   954  
5283ec72b0cca4 Richard Weinberger 2016-06-14   955  		if (i == 0 && pnum != fm_anchor) {
5283ec72b0cca4 Richard Weinberger 2016-06-14   956  			ubi_err(ubi, "Fastmap anchor PEB mismatch: PEB: %i vs. %i",
5283ec72b0cca4 Richard Weinberger 2016-06-14   957  				pnum, fm_anchor);
5283ec72b0cca4 Richard Weinberger 2016-06-14   958  			ret = UBI_BAD_FASTMAP;
5283ec72b0cca4 Richard Weinberger 2016-06-14   959  			goto free_hdr;
5283ec72b0cca4 Richard Weinberger 2016-06-14   960  		}
5283ec72b0cca4 Richard Weinberger 2016-06-14   961  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   962  		ret = ubi_io_read_ec_hdr(ubi, pnum, ech, 0);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   963  		if (ret && ret != UBI_IO_BITFLIPS) {
326087033108e7 Tanya Brokhman     2014-10-20   964  			ubi_err(ubi, "unable to read fastmap block# %i EC (PEB: %i)",
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   965  				i, pnum);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   966  			if (ret > 0)
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   967  				ret = UBI_BAD_FASTMAP;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   968  			goto free_hdr;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   969  		} else if (ret == UBI_IO_BITFLIPS)
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   970  			fm->to_be_tortured[i] = 1;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   971  
c22301ad4fa0f4 Richard Genoud     2013-09-28   972  		image_seq = be32_to_cpu(ech->image_seq);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   973  		if (!ubi->image_seq)
c22301ad4fa0f4 Richard Genoud     2013-09-28   974  			ubi->image_seq = image_seq;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   975  
c22301ad4fa0f4 Richard Genoud     2013-09-28   976  		/*
c22301ad4fa0f4 Richard Genoud     2013-09-28   977  		 * Older UBI implementations have image_seq set to zero, so
c22301ad4fa0f4 Richard Genoud     2013-09-28   978  		 * we shouldn't fail if image_seq == 0.
c22301ad4fa0f4 Richard Genoud     2013-09-28   979  		 */
c22301ad4fa0f4 Richard Genoud     2013-09-28   980  		if (image_seq && (image_seq != ubi->image_seq)) {
326087033108e7 Tanya Brokhman     2014-10-20   981  			ubi_err(ubi, "wrong image seq:%d instead of %d",
c22301ad4fa0f4 Richard Genoud     2013-09-28   982  				be32_to_cpu(ech->image_seq), ubi->image_seq);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   983  			ret = UBI_BAD_FASTMAP;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   984  			goto free_hdr;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   985  		}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   986  
3291b52f9ff0ac Boris Brezillon    2016-09-16   987  		ret = ubi_io_read_vid_hdr(ubi, pnum, vb, 0);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   988  		if (ret && ret != UBI_IO_BITFLIPS) {
326087033108e7 Tanya Brokhman     2014-10-20   989  			ubi_err(ubi, "unable to read fastmap block# %i (PEB: %i)",
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   990  				i, pnum);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   991  			goto free_hdr;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   992  		}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   993  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   994  		if (i == 0) {
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   995  			if (be32_to_cpu(vh->vol_id) != UBI_FM_SB_VOLUME_ID) {
326087033108e7 Tanya Brokhman     2014-10-20   996  				ubi_err(ubi, "bad fastmap anchor vol_id: 0x%x, expected: 0x%x",
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   997  					be32_to_cpu(vh->vol_id),
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   998  					UBI_FM_SB_VOLUME_ID);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26   999  				ret = UBI_BAD_FASTMAP;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1000  				goto free_hdr;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1001  			}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1002  		} else {
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1003  			if (be32_to_cpu(vh->vol_id) != UBI_FM_DATA_VOLUME_ID) {
326087033108e7 Tanya Brokhman     2014-10-20  1004  				ubi_err(ubi, "bad fastmap data vol_id: 0x%x, expected: 0x%x",
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1005  					be32_to_cpu(vh->vol_id),
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1006  					UBI_FM_DATA_VOLUME_ID);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1007  				ret = UBI_BAD_FASTMAP;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1008  				goto free_hdr;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1009  			}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1010  		}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1011  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1012  		if (sqnum < be64_to_cpu(vh->sqnum))
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1013  			sqnum = be64_to_cpu(vh->sqnum);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1014  
fcbb6af17bda4b Boris Brezillon    2016-09-16  1015  		ret = ubi_io_read_data(ubi, ubi->fm_buf + (ubi->leb_size * i),
fcbb6af17bda4b Boris Brezillon    2016-09-16  1016  				       pnum, 0, ubi->leb_size);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1017  		if (ret && ret != UBI_IO_BITFLIPS) {
326087033108e7 Tanya Brokhman     2014-10-20  1018  			ubi_err(ubi, "unable to read fastmap block# %i (PEB: %i, "
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1019  				"err: %i)", i, pnum, ret);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1020  			goto free_hdr;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1021  		}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1022  	}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1023  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1024  	kfree(fmsb);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1025  	fmsb = NULL;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1026  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1027  	fmsb2 = (struct ubi_fm_sb *)(ubi->fm_buf);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26 @1028  	tmp_crc = be32_to_cpu(fmsb2->data_crc);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1029  	fmsb2->data_crc = 0;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1030  	crc = crc32(UBI_CRC32_INIT, ubi->fm_buf, fm_size);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1031  	if (crc != tmp_crc) {
326087033108e7 Tanya Brokhman     2014-10-20  1032  		ubi_err(ubi, "fastmap data CRC is invalid");
326087033108e7 Tanya Brokhman     2014-10-20  1033  		ubi_err(ubi, "CRC should be: 0x%x, calc: 0x%x",
326087033108e7 Tanya Brokhman     2014-10-20  1034  			tmp_crc, crc);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1035  		ret = UBI_BAD_FASTMAP;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1036  		goto free_hdr;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1037  	}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1038  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1039  	fmsb2->sqnum = sqnum;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1040  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1041  	fm->used_blocks = used_blocks;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1042  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1043  	ret = ubi_attach_fastmap(ubi, ai, fm);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1044  	if (ret) {
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1045  		if (ret > 0)
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1046  			ret = UBI_BAD_FASTMAP;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1047  		goto free_hdr;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1048  	}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1049  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1050  	for (i = 0; i < used_blocks; i++) {
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1051  		struct ubi_wl_entry *e;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1052  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1053  		e = kmem_cache_alloc(ubi_wl_entry_slab, GFP_KERNEL);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1054  		if (!e) {
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1055  			while (i--)
af7bcee27652bb Pan Bian           2017-10-29  1056  				kmem_cache_free(ubi_wl_entry_slab, fm->e[i]);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1057  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1058  			ret = -ENOMEM;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1059  			goto free_hdr;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1060  		}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1061  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1062  		e->pnum = be32_to_cpu(fmsb2->block_loc[i]);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1063  		e->ec = be32_to_cpu(fmsb2->block_ec[i]);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1064  		fm->e[i] = e;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1065  	}
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1066  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1067  	ubi->fm = fm;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1068  	ubi->fm_pool.max_size = ubi->fm->max_pool_size;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1069  	ubi->fm_wl_pool.max_size = ubi->fm->max_wl_pool_size;
326087033108e7 Tanya Brokhman     2014-10-20  1070  	ubi_msg(ubi, "attached by fastmap");
326087033108e7 Tanya Brokhman     2014-10-20  1071  	ubi_msg(ubi, "fastmap pool size: %d", ubi->fm_pool.max_size);
326087033108e7 Tanya Brokhman     2014-10-20  1072  	ubi_msg(ubi, "fastmap WL pool size: %d",
326087033108e7 Tanya Brokhman     2014-10-20  1073  		ubi->fm_wl_pool.max_size);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1074  	ubi->fm_disabled = 0;
1900149c835ab5 Richard Weinberger 2016-04-26  1075  	ubi->fast_attach = 1;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1076  
3291b52f9ff0ac Boris Brezillon    2016-09-16  1077  	ubi_free_vid_buf(vb);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1078  	kfree(ech);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1079  out:
111ab0b26fc1bf Richard Weinberger 2014-11-10  1080  	up_write(&ubi->fm_protect);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1081  	if (ret == UBI_BAD_FASTMAP)
326087033108e7 Tanya Brokhman     2014-10-20  1082  		ubi_err(ubi, "Attach by fastmap failed, doing a full scan!");
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1083  	return ret;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1084  
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1085  free_hdr:
3291b52f9ff0ac Boris Brezillon    2016-09-16  1086  	ubi_free_vid_buf(vb);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1087  	kfree(ech);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1088  free_fm_sb:
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1089  	kfree(fmsb);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1090  	kfree(fm);
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1091  	goto out;
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1092  }
dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1093  

:::::: The code at line 1028 was first introduced by commit
:::::: dbb7d2a88d2a7bd3624e090bee42cdee048d9290 UBI: Add fastmap core

:::::: TO: Richard Weinberger <richard@nod.at>
:::::: CC: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
