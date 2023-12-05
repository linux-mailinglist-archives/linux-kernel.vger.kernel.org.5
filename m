Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B369080497D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 06:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344261AbjLEFxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 00:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjLEFxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 00:53:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FA4AA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 21:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701755617; x=1733291617;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mE1gyFvpkk11b5tZ16CddHWyiWvcWUPhBeSIBDJEF1w=;
  b=IpYbjEJgkOnwsT9BsjKPJ7DnyUCEiVcK6UuQJFxc1QBWGnDFf+VUr3QB
   uW3ieNL5wlWhPMqQeC0D6U3FwPhK1oa6tTiLUrM1OVrc2TVy1vPomDDzj
   z+7VTLrMnu9O6+pGAlV/2J9iTHuACTPgXckQkOKQtoj4uZoC+Ur87JscP
   ItwEO6FNk/44jHAR+n9Q1SoWo5R9YdzUxe5EPh9BE9tlqnECM8EIjPjSQ
   rp8AgvzW1Ti1fa/xNqyQtvvBIq5GcZWJPnntnCJWkuEIC1hdcMu8zGA2Y
   UZl5Ip2IlOvtrNBxxge1K0Du1tPfry8R7wCe0YA+ZMkpnl8Is0jjYZNOQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="425008169"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="425008169"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 21:53:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="841329821"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="841329821"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 04 Dec 2023 21:53:35 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAONA-0008PI-1z;
        Tue, 05 Dec 2023 05:53:32 +0000
Date:   Tue, 5 Dec 2023 13:53:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michal Marek <mmarek@suse.com>
Subject: fs/nilfs2/btree.c:1863: warning: No description found for parameter
 'btree'
Message-ID: <202312051316.CGxfBMux-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
commit: 4efca4ed05cbdfd13ec3e8cb623fb77d6e4ab187 kbuild: modversions for EXPORT_SYMBOL() for asm
date:   7 years ago
config: i386-buildonly-randconfig-005-20231120 (https://download.01.org/0day-ci/archive/20231205/202312051316.CGxfBMux-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231205/202312051316.CGxfBMux-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312051316.CGxfBMux-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/nilfs2/btree.c:1863: warning: No description found for parameter 'btree'
>> fs/nilfs2/btree.c:1863: warning: No description found for parameter 'key'
>> fs/nilfs2/btree.c:1863: warning: No description found for parameter 'ptr'
>> fs/nilfs2/btree.c:1863: warning: No description found for parameter 'keys'
>> fs/nilfs2/btree.c:1863: warning: No description found for parameter 'ptrs'
>> fs/nilfs2/btree.c:1863: warning: No description found for parameter 'n'
--
   arch/x86/include/asm/bitops.h: Assembler messages:
   arch/x86/include/asm/bitops.h:211: Warning: no instruction mnemonic suffix given and no register operands; using default for `bts'
   arch/x86/include/asm/bitops.h:211: Warning: no instruction mnemonic suffix given and no register operands; using default for `bts'
   arch/x86/include/asm/bitops.h:211: Warning: no instruction mnemonic suffix given and no register operands; using default for `bts'
   arch/x86/include/asm/bitops.h:211: Warning: no instruction mnemonic suffix given and no register operands; using default for `bts'
>> fs/nilfs2/btnode.c:167: warning: No description found for parameter 'btnc'
>> fs/nilfs2/btnode.c:167: warning: No description found for parameter 'ctxt'
   fs/nilfs2/btnode.c:237: warning: No description found for parameter 'btnc'
   fs/nilfs2/btnode.c:237: warning: No description found for parameter 'ctxt'
   fs/nilfs2/btnode.c:278: warning: No description found for parameter 'btnc'
   fs/nilfs2/btnode.c:278: warning: No description found for parameter 'ctxt'
--
>> fs/nilfs2/recovery.c:580: warning: No description found for parameter 'root'
--
>> fs/nilfs2/sufile.c:575: warning: No description found for parameter 'sustat'
   fs/nilfs2/sufile.c:575: warning: Excess function parameter 'stat' description in 'nilfs_sufile_get_stat'
--
>> fs/nilfs2/bmap.c:387: warning: No description found for parameter 'bh'
   fs/nilfs2/bmap.c:387: warning: Excess function parameter 'bhp' description in 'nilfs_bmap_assign'
--
   arch/x86/include/asm/bitops.h: Assembler messages:
   arch/x86/include/asm/bitops.h:211: Warning: no instruction mnemonic suffix given and no register operands; using default for `bts'
>> fs/nilfs2/ioctl.c:128: warning: No description found for parameter 'inode'
>> fs/nilfs2/ioctl.c:128: warning: No description found for parameter 'argp'
   fs/nilfs2/ioctl.c:139: warning: No description found for parameter 'inode'
>> fs/nilfs2/ioctl.c:139: warning: No description found for parameter 'filp'
   fs/nilfs2/ioctl.c:139: warning: No description found for parameter 'argp'
   fs/nilfs2/ioctl.c:193: warning: No description found for parameter 'inode'
   fs/nilfs2/ioctl.c:193: warning: No description found for parameter 'argp'
--
>> fs/nilfs2/super.c:124: warning: No description found for parameter 'sb'
>> fs/nilfs2/super.c:124: warning: No description found for parameter 'function'
>> fs/nilfs2/super.c:124: warning: No description found for parameter 'fmt'
--
   arch/x86/include/asm/bitops.h: Assembler messages:
   arch/x86/include/asm/bitops.h:257: Warning: no instruction mnemonic suffix given and no register operands; using default for `btr'
   arch/x86/include/asm/bitops.h:211: Warning: no instruction mnemonic suffix given and no register operands; using default for `bts'
>> fs/nilfs2/inode.c:81: warning: No description found for parameter 'inode'
>> fs/nilfs2/inode.c:81: warning: No description found for parameter 'blkoff'
>> fs/nilfs2/inode.c:81: warning: No description found for parameter 'bh_result'
>> fs/nilfs2/inode.c:81: warning: No description found for parameter 'create'
>> fs/nilfs2/inode.c:153: warning: No description found for parameter 'file'
>> fs/nilfs2/inode.c:153: warning: No description found for parameter 'page'
   fs/nilfs2/inode.c:167: warning: No description found for parameter 'file'
>> fs/nilfs2/inode.c:167: warning: No description found for parameter 'mapping'
>> fs/nilfs2/inode.c:167: warning: No description found for parameter 'pages'
>> fs/nilfs2/inode.c:167: warning: No description found for parameter 'nr_pages'
>> fs/nilfs2/inode.c:985: warning: No description found for parameter 'flags'
--
>> fs/nilfs2/cpfile.c:573: warning: No description found for parameter 'cpfile'
>> fs/nilfs2/cpfile.c:573: warning: No description found for parameter 'cnop'
>> fs/nilfs2/cpfile.c:573: warning: No description found for parameter 'mode'
>> fs/nilfs2/cpfile.c:573: warning: No description found for parameter 'buf'
>> fs/nilfs2/cpfile.c:573: warning: No description found for parameter 'cisz'
>> fs/nilfs2/cpfile.c:573: warning: No description found for parameter 'nci'
   fs/nilfs2/cpfile.c:590: warning: No description found for parameter 'cpfile'
>> fs/nilfs2/cpfile.c:590: warning: No description found for parameter 'cno'
   fs/nilfs2/cpfile.c:916: warning: No description found for parameter 'mode'
   fs/nilfs2/cpfile.c:916: warning: Excess function parameter 'status' description in 'nilfs_cpfile_change_cpmode'
>> fs/nilfs2/cpfile.c:955: warning: No description found for parameter 'cpstat'
   fs/nilfs2/cpfile.c:955: warning: Excess function parameter 'stat' description in 'nilfs_cpfile_get_stat'
--
   arch/x86/include/asm/bitops.h: Assembler messages:
   arch/x86/include/asm/bitops.h:211: Warning: no instruction mnemonic suffix given and no register operands; using default for `bts'
>> fs/nilfs2/gcinode.c:189: warning: No description found for parameter 'nilfs'
--
>> drivers/iio/dac/ad7303.c:50: warning: No description found for parameter 'vdd_reg'
>> drivers/iio/dac/ad7303.c:50: warning: No description found for parameter 'vref_reg'
>> drivers/iio/dac/ad7303.c:50: warning: No description found for parameter '____cacheline_aligned'
>> drivers/iio/dac/ad7303.c:50: warning: Excess struct/union/enum/typedef member 'data' description in 'ad7303_state'
..


vim +/btree +1863 fs/nilfs2/btree.c

17c76b0104e4a6 Koji Sato       2009-04-06  1850  
17c76b0104e4a6 Koji Sato       2009-04-06  1851  /**
17c76b0104e4a6 Koji Sato       2009-04-06  1852   * nilfs_btree_convert_and_insert -
17c76b0104e4a6 Koji Sato       2009-04-06  1853   * @bmap:
17c76b0104e4a6 Koji Sato       2009-04-06  1854   * @key:
17c76b0104e4a6 Koji Sato       2009-04-06  1855   * @ptr:
17c76b0104e4a6 Koji Sato       2009-04-06  1856   * @keys:
17c76b0104e4a6 Koji Sato       2009-04-06  1857   * @ptrs:
17c76b0104e4a6 Koji Sato       2009-04-06  1858   * @n:
17c76b0104e4a6 Koji Sato       2009-04-06  1859   */
e7c274f8083793 Ryusuke Konishi 2010-07-10  1860  int nilfs_btree_convert_and_insert(struct nilfs_bmap *btree,
17c76b0104e4a6 Koji Sato       2009-04-06  1861  				   __u64 key, __u64 ptr,
3033342a0b7604 Ryusuke Konishi 2009-05-24  1862  				   const __u64 *keys, const __u64 *ptrs, int n)
17c76b0104e4a6 Koji Sato       2009-04-06 @1863  {
4f05028f8d1af7 Ryusuke Konishi 2015-11-06  1864  	struct buffer_head *bh = NULL;
17c76b0104e4a6 Koji Sato       2009-04-06  1865  	union nilfs_bmap_ptr_req dreq, nreq, *di, *ni;
17c76b0104e4a6 Koji Sato       2009-04-06  1866  	struct nilfs_bmap_stats stats;
17c76b0104e4a6 Koji Sato       2009-04-06  1867  	int ret;
17c76b0104e4a6 Koji Sato       2009-04-06  1868  
17c76b0104e4a6 Koji Sato       2009-04-06  1869  	if (n + 1 <= NILFS_BTREE_ROOT_NCHILDREN_MAX) {
17c76b0104e4a6 Koji Sato       2009-04-06  1870  		di = &dreq;
17c76b0104e4a6 Koji Sato       2009-04-06  1871  		ni = NULL;
17c76b0104e4a6 Koji Sato       2009-04-06  1872  	} else if ((n + 1) <= NILFS_BTREE_NODE_NCHILDREN_MAX(
e7c274f8083793 Ryusuke Konishi 2010-07-10  1873  			   1 << btree->b_inode->i_blkbits)) {
17c76b0104e4a6 Koji Sato       2009-04-06  1874  		di = &dreq;
17c76b0104e4a6 Koji Sato       2009-04-06  1875  		ni = &nreq;
17c76b0104e4a6 Koji Sato       2009-04-06  1876  	} else {
17c76b0104e4a6 Koji Sato       2009-04-06  1877  		di = NULL;
17c76b0104e4a6 Koji Sato       2009-04-06  1878  		ni = NULL;
17c76b0104e4a6 Koji Sato       2009-04-06  1879  		BUG();
17c76b0104e4a6 Koji Sato       2009-04-06  1880  	}
17c76b0104e4a6 Koji Sato       2009-04-06  1881  
e7c274f8083793 Ryusuke Konishi 2010-07-10  1882  	ret = nilfs_btree_prepare_convert_and_insert(btree, key, di, ni, &bh,
17c76b0104e4a6 Koji Sato       2009-04-06  1883  						     &stats);
17c76b0104e4a6 Koji Sato       2009-04-06  1884  	if (ret < 0)
17c76b0104e4a6 Koji Sato       2009-04-06  1885  		return ret;
e7c274f8083793 Ryusuke Konishi 2010-07-10  1886  	nilfs_btree_commit_convert_and_insert(btree, key, ptr, keys, ptrs, n,
3033342a0b7604 Ryusuke Konishi 2009-05-24  1887  					      di, ni, bh);
be667377a8b8cd Ryusuke Konishi 2011-03-05  1888  	nilfs_inode_add_blocks(btree->b_inode, stats.bs_nblocks);
17c76b0104e4a6 Koji Sato       2009-04-06  1889  	return 0;
17c76b0104e4a6 Koji Sato       2009-04-06  1890  }
17c76b0104e4a6 Koji Sato       2009-04-06  1891  

:::::: The code at line 1863 was first introduced by commit
:::::: 17c76b0104e4a6513983777e1a17e0297a12b0c4 nilfs2: B-tree based block mapping

:::::: TO: Koji Sato <sato.koji@lab.ntt.co.jp>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
