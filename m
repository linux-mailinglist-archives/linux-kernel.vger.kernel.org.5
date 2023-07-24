Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2573675F315
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjGXK1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjGXK1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:27:24 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CF94686
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 03:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690194172; x=1721730172;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LcLqaFTdk7qX3bHjYaBWnXOJ5Env65VjbRzmFY3G56Y=;
  b=gSZL7ssX9qG6Pwmp1nW/I4+IlT/SNTYQsUVNAXpolR4NQdebpVIz0awd
   VouVGfytef8P8duN2m/Rmop9fkx1AUNXDbskXExGn/DFa6/xvvMRLRoJf
   qtMOR9e8AjEgB77yPQUB0J26a3ATV7NFgaxucPBdgPhuPAEOTblJOwODi
   9fIf8KjKrCciixvGSs+jbFNQ5tfQH3RyUXpZtfVvUCRbOz6leai1pIMRt
   T9pgGNt3FKBO9Db/YChGB3J+5H163/mErx5U5o8oARqoYakniCZpuAOoV
   mjszwdl/51As8AoKqwa2J/OmJXRKEAj+de0kvEk9++1XL7pO3CQZEsZOt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="347005505"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347005505"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 03:20:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="790907428"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="790907428"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jul 2023 03:20:53 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qNsgO-0009g8-3A;
        Mon, 24 Jul 2023 10:20:52 +0000
Date:   Mon, 24 Jul 2023 18:20:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: fs/buffer.c:2342:1: warning: the frame size of 2080 bytes is larger
 than 1024 bytes
Message-ID: <202307241811.WV6uvzLa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6eaae198076080886b9e7d57f4ae06fa782f90ef
commit: 4eeef098b43242ed145c83fba9989d586d707589 powerpc/44x: Remove STDBINUTILS kconfig option
date:   2 years, 6 months ago
config: powerpc-randconfig-r035-20230724 (https://download.01.org/0day-ci/archive/20230724/202307241811.WV6uvzLa-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230724/202307241811.WV6uvzLa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307241811.WV6uvzLa-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/buffer.c: In function 'block_read_full_page':
>> fs/buffer.c:2342:1: warning: the frame size of 2080 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    2342 | }
         | ^
--
   fs/exfat/fatent.c: In function 'exfat_zeroed_cluster':
>> fs/exfat/fatent.c:277:1: warning: the frame size of 2064 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     277 | }
         | ^
--
   fs/ext4/move_extent.c: In function 'mext_page_mkuptodate':
>> fs/ext4/move_extent.c:227:1: warning: the frame size of 2064 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     227 | }
         | ^
--
   fs/fat/dir.c: In function 'fat_alloc_new_dir':
>> fs/fat/dir.c:1195:1: warning: the frame size of 2064 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    1195 | }
         | ^
   fs/fat/dir.c: In function 'fat_add_new_entries':
   fs/fat/dir.c:1279:1: warning: the frame size of 2104 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    1279 | }
         | ^
--
   fs/fat/fatent.c: In function 'fat_free_clusters':
>> fs/fat/fatent.c:632:1: warning: the frame size of 2112 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     632 | }
         | ^
   fs/fat/fatent.c: In function 'fat_alloc_clusters':
   fs/fat/fatent.c:550:1: warning: the frame size of 2128 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     550 | }
         | ^
--
   fs/ntfs/mft.c: In function 'ntfs_sync_mft_mirror':
>> fs/ntfs/mft.c:627:1: warning: the frame size of 2120 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     627 | }
         | ^
   fs/ntfs/mft.c: In function 'write_mft_record_nolock':
   fs/ntfs/mft.c:839:1: warning: the frame size of 2128 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     839 | }
         | ^
--
   fs/ntfs/aops.c: In function 'ntfs_read_block':
>> fs/ntfs/aops.c:358:1: warning: the frame size of 2184 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     358 | }
         | ^
   fs/ntfs/aops.c: In function 'ntfs_write_mst_block':
   fs/ntfs/aops.c:1311:1: warning: the frame size of 4224 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    1311 | }
         | ^


vim +2342 fs/buffer.c

8ab22b9abb5c55 Hisashi Hifumi     2008-07-28  2251  
^1da177e4c3f41 Linus Torvalds     2005-04-16  2252  /*
^1da177e4c3f41 Linus Torvalds     2005-04-16  2253   * Generic "read page" function for block devices that have the normal
^1da177e4c3f41 Linus Torvalds     2005-04-16  2254   * get_block functionality. This is most of the block device filesystems.
^1da177e4c3f41 Linus Torvalds     2005-04-16  2255   * Reads the page asynchronously --- the unlock_buffer() and
^1da177e4c3f41 Linus Torvalds     2005-04-16  2256   * set/clear_buffer_uptodate() functions propagate buffer state into the
^1da177e4c3f41 Linus Torvalds     2005-04-16  2257   * page struct once IO has completed.
^1da177e4c3f41 Linus Torvalds     2005-04-16  2258   */
^1da177e4c3f41 Linus Torvalds     2005-04-16  2259  int block_read_full_page(struct page *page, get_block_t *get_block)
^1da177e4c3f41 Linus Torvalds     2005-04-16  2260  {
^1da177e4c3f41 Linus Torvalds     2005-04-16  2261  	struct inode *inode = page->mapping->host;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2262  	sector_t iblock, lblock;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2263  	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
45bce8f3e3436b Linus Torvalds     2012-11-29  2264  	unsigned int blocksize, bbits;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2265  	int nr, i;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2266  	int fully_mapped = 1;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2267  
45bce8f3e3436b Linus Torvalds     2012-11-29  2268  	head = create_page_buffers(page, inode, 0);
45bce8f3e3436b Linus Torvalds     2012-11-29  2269  	blocksize = head->b_size;
45bce8f3e3436b Linus Torvalds     2012-11-29  2270  	bbits = block_size_bits(blocksize);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2271  
09cbfeaf1a5a67 Kirill A. Shutemov 2016-04-01  2272  	iblock = (sector_t)page->index << (PAGE_SHIFT - bbits);
45bce8f3e3436b Linus Torvalds     2012-11-29  2273  	lblock = (i_size_read(inode)+blocksize-1) >> bbits;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2274  	bh = head;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2275  	nr = 0;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2276  	i = 0;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2277  
^1da177e4c3f41 Linus Torvalds     2005-04-16  2278  	do {
^1da177e4c3f41 Linus Torvalds     2005-04-16  2279  		if (buffer_uptodate(bh))
^1da177e4c3f41 Linus Torvalds     2005-04-16  2280  			continue;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2281  
^1da177e4c3f41 Linus Torvalds     2005-04-16  2282  		if (!buffer_mapped(bh)) {
c64610ba585fab Andrew Morton      2005-05-16  2283  			int err = 0;
c64610ba585fab Andrew Morton      2005-05-16  2284  
^1da177e4c3f41 Linus Torvalds     2005-04-16  2285  			fully_mapped = 0;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2286  			if (iblock < lblock) {
b0cf2321c65991 Badari Pulavarty   2006-03-26  2287  				WARN_ON(bh->b_size != blocksize);
c64610ba585fab Andrew Morton      2005-05-16  2288  				err = get_block(inode, iblock, bh, 0);
c64610ba585fab Andrew Morton      2005-05-16  2289  				if (err)
^1da177e4c3f41 Linus Torvalds     2005-04-16  2290  					SetPageError(page);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2291  			}
^1da177e4c3f41 Linus Torvalds     2005-04-16  2292  			if (!buffer_mapped(bh)) {
eebd2aa355692a Christoph Lameter  2008-02-04  2293  				zero_user(page, i * blocksize, blocksize);
c64610ba585fab Andrew Morton      2005-05-16  2294  				if (!err)
^1da177e4c3f41 Linus Torvalds     2005-04-16  2295  					set_buffer_uptodate(bh);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2296  				continue;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2297  			}
^1da177e4c3f41 Linus Torvalds     2005-04-16  2298  			/*
^1da177e4c3f41 Linus Torvalds     2005-04-16  2299  			 * get_block() might have updated the buffer
^1da177e4c3f41 Linus Torvalds     2005-04-16  2300  			 * synchronously
^1da177e4c3f41 Linus Torvalds     2005-04-16  2301  			 */
^1da177e4c3f41 Linus Torvalds     2005-04-16  2302  			if (buffer_uptodate(bh))
^1da177e4c3f41 Linus Torvalds     2005-04-16  2303  				continue;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2304  		}
^1da177e4c3f41 Linus Torvalds     2005-04-16  2305  		arr[nr++] = bh;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2306  	} while (i++, iblock++, (bh = bh->b_this_page) != head);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2307  
^1da177e4c3f41 Linus Torvalds     2005-04-16  2308  	if (fully_mapped)
^1da177e4c3f41 Linus Torvalds     2005-04-16  2309  		SetPageMappedToDisk(page);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2310  
^1da177e4c3f41 Linus Torvalds     2005-04-16  2311  	if (!nr) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  2312  		/*
^1da177e4c3f41 Linus Torvalds     2005-04-16  2313  		 * All buffers are uptodate - we can set the page uptodate
^1da177e4c3f41 Linus Torvalds     2005-04-16  2314  		 * as well. But not if get_block() returned an error.
^1da177e4c3f41 Linus Torvalds     2005-04-16  2315  		 */
^1da177e4c3f41 Linus Torvalds     2005-04-16  2316  		if (!PageError(page))
^1da177e4c3f41 Linus Torvalds     2005-04-16  2317  			SetPageUptodate(page);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2318  		unlock_page(page);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2319  		return 0;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2320  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  2321  
^1da177e4c3f41 Linus Torvalds     2005-04-16  2322  	/* Stage two: lock the buffers */
^1da177e4c3f41 Linus Torvalds     2005-04-16  2323  	for (i = 0; i < nr; i++) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  2324  		bh = arr[i];
^1da177e4c3f41 Linus Torvalds     2005-04-16  2325  		lock_buffer(bh);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2326  		mark_buffer_async_read(bh);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2327  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  2328  
^1da177e4c3f41 Linus Torvalds     2005-04-16  2329  	/*
^1da177e4c3f41 Linus Torvalds     2005-04-16  2330  	 * Stage 3: start the IO.  Check for uptodateness
^1da177e4c3f41 Linus Torvalds     2005-04-16  2331  	 * inside the buffer lock in case another process reading
^1da177e4c3f41 Linus Torvalds     2005-04-16  2332  	 * the underlying blockdev brought it uptodate (the sct fix).
^1da177e4c3f41 Linus Torvalds     2005-04-16  2333  	 */
^1da177e4c3f41 Linus Torvalds     2005-04-16  2334  	for (i = 0; i < nr; i++) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  2335  		bh = arr[i];
^1da177e4c3f41 Linus Torvalds     2005-04-16  2336  		if (buffer_uptodate(bh))
^1da177e4c3f41 Linus Torvalds     2005-04-16  2337  			end_buffer_async_read(bh, 1);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2338  		else
2a222ca992c35a Mike Christie      2016-06-05  2339  			submit_bh(REQ_OP_READ, 0, bh);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2340  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  2341  	return 0;
^1da177e4c3f41 Linus Torvalds     2005-04-16 @2342  }
1fe72eaa0f46a0 H Hartley Sweeten  2009-09-22  2343  EXPORT_SYMBOL(block_read_full_page);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2344  

:::::: The code at line 2342 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
