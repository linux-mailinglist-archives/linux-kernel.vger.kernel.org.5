Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AA680BC88
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 19:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjLJSRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 13:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJSRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 13:17:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9297FCE
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 10:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702232225; x=1733768225;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hitiKMVu0mAuCQUKM+GjRpWkQ52QLtnGnEX7vaEYxmg=;
  b=ZRb7DColILPsPZtROxd4NBQaPRf+SyEAmaGzNanehsRk6848eFG86tRJ
   /kXucHdCATxOBsYGT+hyao/+47lTL29X5V+qYJF3JyGTbdy0unB9YWrLW
   nynhEGXTTU9wjqDogxXVoPe2wo6s45NOlwBr5S4aEqd6bbeB14R+vT4n7
   HlEIRtqzh40esnhwccSIHuYZUIB5KMEU3LV3RHZ7NS7F36S8KQIn4nrrD
   72saF0Hk/sT/jx3kfNVqgycoxCzMiO6YR50RIjRbx5c1Bsl/q//ajoZAG
   Rtt5daMqWKiuIfQG3QhF3tsjbf3V6TRsqIOy69TavwDvyyKg37AusGkYj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="7926045"
X-IronPort-AV: E=Sophos;i="6.04,266,1695711600"; 
   d="scan'208";a="7926045"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 10:17:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="896159770"
X-IronPort-AV: E=Sophos;i="6.04,266,1695711600"; 
   d="scan'208";a="896159770"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 10 Dec 2023 10:17:00 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rCOMM-000H9K-1Y;
        Sun, 10 Dec 2023 18:16:58 +0000
Date:   Mon, 11 Dec 2023 02:16:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/edac/i7300_edac.c:591: warning: No description found for
 parameter 'dimm'
Message-ID: <202312110215.PEi8XY6K-lkp@intel.com>
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
head:   c527f5606aa545233a4d2c6d5c636ed82b8633ef
commit: e3c4ff6d8c949fa9a9ea1bd005bf1967efe09d5d EDAC: Remove EDAC_MM_EDAC
date:   7 years ago
config: i386-buildonly-randconfig-006-20231120 (https://download.01.org/0day-ci/archive/20231211/202312110215.PEi8XY6K-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231211/202312110215.PEi8XY6K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312110215.PEi8XY6K-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/edac/i7300_edac.c:591: warning: No description found for parameter 'dimm'
   drivers/edac/i7300_edac.c:591: warning: Excess function parameter 'p_csrow' description in 'decode_mtr'
>> drivers/edac/i7300_edac.c:826: warning: No description found for parameter 'mir_no'
--
>> drivers/edac/amd76x_edac.c:231: warning: No description found for parameter 'pdev'


vim +/dimm +591 drivers/edac/i7300_edac.c

5de6e07ed75ee2 Mauro Carvalho Chehab 2010-08-27  573  
5de6e07ed75ee2 Mauro Carvalho Chehab 2010-08-27  574  /************************************************
5de6e07ed75ee2 Mauro Carvalho Chehab 2010-08-27  575   * i7300 Functions related to memory enumberation
5de6e07ed75ee2 Mauro Carvalho Chehab 2010-08-27  576   ************************************************/
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  577  
d091a6eb177dd3 Mauro Carvalho Chehab 2010-08-27  578  /**
d091a6eb177dd3 Mauro Carvalho Chehab 2010-08-27  579   * decode_mtr() - Decodes the MTR descriptor, filling the edac structs
d091a6eb177dd3 Mauro Carvalho Chehab 2010-08-27  580   * @pvt: pointer to the private data struct used by i7300 driver
d091a6eb177dd3 Mauro Carvalho Chehab 2010-08-27  581   * @slot: DIMM slot (0 to 7)
d091a6eb177dd3 Mauro Carvalho Chehab 2010-08-27  582   * @ch: Channel number within the branch (0 or 1)
d091a6eb177dd3 Mauro Carvalho Chehab 2010-08-27  583   * @branch: Branch number (0 or 1)
d091a6eb177dd3 Mauro Carvalho Chehab 2010-08-27  584   * @dinfo: Pointer to DIMM info where dimm size is stored
d091a6eb177dd3 Mauro Carvalho Chehab 2010-08-27  585   * @p_csrow: Pointer to the struct csrow_info that corresponds to that element
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  586   */
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  587  static int decode_mtr(struct i7300_pvt *pvt,
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  588  		      int slot, int ch, int branch,
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  589  		      struct i7300_dimm_info *dinfo,
a895bf8b1e1ea4 Mauro Carvalho Chehab 2012-01-28  590  		      struct dimm_info *dimm)
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24 @591  {
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  592  	int mtr, ans, addrBits, channel;
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  593  
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  594  	channel = to_channel(ch, branch);
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  595  
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  596  	mtr = pvt->mtr[slot][branch];
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  597  	ans = MTR_DIMMS_PRESENT(mtr) ? 1 : 0;
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  598  
956b9ba156dbfd Joe Perches           2012-04-29  599  	edac_dbg(2, "\tMTR%d CH%d: DIMMs are %sPresent (mtr)\n",
956b9ba156dbfd Joe Perches           2012-04-29  600  		 slot, channel, ans ? "" : "NOT ");
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  601  
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  602  	/* Determine if there is a DIMM present in this DIMM slot */
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  603  	if (!ans)
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  604  		return 0;
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  605  
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  606  	/* Start with the number of bits for a Bank
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  607  	* on the DRAM */
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  608  	addrBits = MTR_DRAM_BANKS_ADDR_BITS;
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  609  	/* Add thenumber of ROW bits */
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  610  	addrBits += MTR_DIMM_ROWS_ADDR_BITS(mtr);
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  611  	/* add the number of COLUMN bits */
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  612  	addrBits += MTR_DIMM_COLS_ADDR_BITS(mtr);
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  613  	/* add the number of RANK bits */
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  614  	addrBits += MTR_DIMM_RANKS(mtr);
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  615  
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  616  	addrBits += 6;	/* add 64 bits per DIMM */
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  617  	addrBits -= 20;	/* divide by 2^^20 */
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  618  	addrBits -= 3;	/* 8 bits per bytes */
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  619  
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  620  	dinfo->megabytes = 1 << addrBits;
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  621  
956b9ba156dbfd Joe Perches           2012-04-29  622  	edac_dbg(2, "\t\tWIDTH: x%d\n", MTR_DRAM_WIDTH(mtr));
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  623  
956b9ba156dbfd Joe Perches           2012-04-29  624  	edac_dbg(2, "\t\tELECTRICAL THROTTLING is %s\n",
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  625  		 MTR_DIMMS_ETHROTTLE(mtr) ? "enabled" : "disabled");
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  626  
956b9ba156dbfd Joe Perches           2012-04-29  627  	edac_dbg(2, "\t\tNUMBANK: %d bank(s)\n", MTR_DRAM_BANKS(mtr));
956b9ba156dbfd Joe Perches           2012-04-29  628  	edac_dbg(2, "\t\tNUMRANK: %s\n",
956b9ba156dbfd Joe Perches           2012-04-29  629  		 MTR_DIMM_RANKS(mtr) ? "double" : "single");
956b9ba156dbfd Joe Perches           2012-04-29  630  	edac_dbg(2, "\t\tNUMROW: %s\n",
7e881856eee8b8 Joe Perches           2012-04-28  631  		 MTR_DIMM_ROWS(mtr) == 0 ? "8,192 - 13 rows" :
7e881856eee8b8 Joe Perches           2012-04-28  632  		 MTR_DIMM_ROWS(mtr) == 1 ? "16,384 - 14 rows" :
7e881856eee8b8 Joe Perches           2012-04-28  633  		 MTR_DIMM_ROWS(mtr) == 2 ? "32,768 - 15 rows" :
7e881856eee8b8 Joe Perches           2012-04-28  634  		 "65,536 - 16 rows");
956b9ba156dbfd Joe Perches           2012-04-29  635  	edac_dbg(2, "\t\tNUMCOL: %s\n",
7e881856eee8b8 Joe Perches           2012-04-28  636  		 MTR_DIMM_COLS(mtr) == 0 ? "1,024 - 10 columns" :
7e881856eee8b8 Joe Perches           2012-04-28  637  		 MTR_DIMM_COLS(mtr) == 1 ? "2,048 - 11 columns" :
7e881856eee8b8 Joe Perches           2012-04-28  638  		 MTR_DIMM_COLS(mtr) == 2 ? "4,096 - 12 columns" :
7e881856eee8b8 Joe Perches           2012-04-28  639  		 "reserved");
956b9ba156dbfd Joe Perches           2012-04-29  640  	edac_dbg(2, "\t\tSIZE: %d MB\n", dinfo->megabytes);
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  641  
116389ed21e4ad Mauro Carvalho Chehab 2010-08-26  642  	/*
15154c57c62494 Mauro Carvalho Chehab 2010-08-27  643  	 * The type of error detection actually depends of the
116389ed21e4ad Mauro Carvalho Chehab 2010-08-26  644  	 * mode of operation. When it is just one single memory chip, at
116389ed21e4ad Mauro Carvalho Chehab 2010-08-26  645  	 * socket 0, channel 0, it uses 8-byte-over-32-byte SECDED+ code.
15154c57c62494 Mauro Carvalho Chehab 2010-08-27  646  	 * In normal or mirrored mode, it uses Lockstep mode,
116389ed21e4ad Mauro Carvalho Chehab 2010-08-26  647  	 * with the possibility of using an extended algorithm for x8 memories
116389ed21e4ad Mauro Carvalho Chehab 2010-08-26  648  	 * See datasheet Sections 7.3.6 to 7.3.8
116389ed21e4ad Mauro Carvalho Chehab 2010-08-26  649  	 */
15154c57c62494 Mauro Carvalho Chehab 2010-08-27  650  
a895bf8b1e1ea4 Mauro Carvalho Chehab 2012-01-28  651  	dimm->nr_pages = MiB_TO_PAGES(dinfo->megabytes);
084a4fccef39ac Mauro Carvalho Chehab 2012-01-27  652  	dimm->grain = 8;
084a4fccef39ac Mauro Carvalho Chehab 2012-01-27  653  	dimm->mtype = MEM_FB_DDR2;
15154c57c62494 Mauro Carvalho Chehab 2010-08-27  654  	if (IS_SINGLE_MODE(pvt->mc_settings_a)) {
084a4fccef39ac Mauro Carvalho Chehab 2012-01-27  655  		dimm->edac_mode = EDAC_SECDED;
956b9ba156dbfd Joe Perches           2012-04-29  656  		edac_dbg(2, "\t\tECC code is 8-byte-over-32-byte SECDED+ code\n");
15154c57c62494 Mauro Carvalho Chehab 2010-08-27  657  	} else {
956b9ba156dbfd Joe Perches           2012-04-29  658  		edac_dbg(2, "\t\tECC code is on Lockstep mode\n");
28c2ce7c8b275a Mauro Carvalho Chehab 2010-08-27  659  		if (MTR_DRAM_WIDTH(mtr) == 8)
084a4fccef39ac Mauro Carvalho Chehab 2012-01-27  660  			dimm->edac_mode = EDAC_S8ECD8ED;
15154c57c62494 Mauro Carvalho Chehab 2010-08-27  661  		else
084a4fccef39ac Mauro Carvalho Chehab 2012-01-27  662  			dimm->edac_mode = EDAC_S4ECD4ED;
15154c57c62494 Mauro Carvalho Chehab 2010-08-27  663  	}
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  664  
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  665  	/* ask what device type on this row */
28c2ce7c8b275a Mauro Carvalho Chehab 2010-08-27  666  	if (MTR_DRAM_WIDTH(mtr) == 8) {
956b9ba156dbfd Joe Perches           2012-04-29  667  		edac_dbg(2, "\t\tScrub algorithm for x8 is on %s mode\n",
d7de2bdb0e15c5 Mauro Carvalho Chehab 2010-08-27  668  			 IS_SCRBALGO_ENHANCED(pvt->mc_settings) ?
d7de2bdb0e15c5 Mauro Carvalho Chehab 2010-08-27  669  			 "enhanced" : "normal");
d7de2bdb0e15c5 Mauro Carvalho Chehab 2010-08-27  670  
084a4fccef39ac Mauro Carvalho Chehab 2012-01-27  671  		dimm->dtype = DEV_X8;
d7de2bdb0e15c5 Mauro Carvalho Chehab 2010-08-27  672  	} else
084a4fccef39ac Mauro Carvalho Chehab 2012-01-27  673  		dimm->dtype = DEV_X4;
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  674  
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  675  	return mtr;
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  676  }
fcaf780b2ad352 Mauro Carvalho Chehab 2010-08-24  677  

:::::: The code at line 591 was first introduced by commit
:::::: fcaf780b2ad352edaeb1d1c07a6da053266b1eed i7300_edac: start a driver for i7300 chipset (Clarksboro)

:::::: TO: Mauro Carvalho Chehab <mchehab@redhat.com>
:::::: CC: Mauro Carvalho Chehab <mchehab@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
