Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756DE7FB94E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344274AbjK1LUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344168AbjK1LUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:20:09 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EAAD6;
        Tue, 28 Nov 2023 03:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701170415; x=1732706415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qSaDzPStYpOmYXay6eUAmLjv4q2mpAbM97NA9jiSQlw=;
  b=HcpUwaH94P4VmivoQgTJ+/ZNzBRDDIyHhp4Oz3i+tGRZ4NOKLDhefbZ1
   hjcxmZ5/JxcIoXrzz3TtjTOlMwBZstC8t0CElTFFKjmjVQ95lgP4BFr6D
   MzSM7VIAfeF2CjpEfeHzGGQU4EyKdaACwhyGsbhWsCMB8be8e6Sjwa9Ua
   119TNsDrv6QYTfQ1j6QB8W66GzjvofpJrbw03gCGnvMw2GCgX2r25m4kc
   WJH1MJetWiYU5V11DgQW4HUvWgL4YFp9Gv+SJtk3DnJ8SjaX0by1Au3gT
   fZaHSOeT72OUGLcTLAlJME7JSCGW5XF8PSSPdR+cJ6/vmmvrgFAt2qILk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="390055267"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="390055267"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 03:19:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="772274033"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="772274033"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 28 Nov 2023 03:19:40 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r7w7t-0007TE-39;
        Tue, 28 Nov 2023 11:19:37 +0000
Date:   Tue, 28 Nov 2023 19:18:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, Dave Chinner <dchinner@redhat.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        Zhang Tianci <zhangtianci.1997@bytedance.com>,
        Brian Foster <bfoster@redhat.com>, Ben Myers <bpm@sgi.com>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xieyongji@bytedance.com, me@jcix.top
Subject: Re: [PATCH 2/2] xfs: update dir3 leaf block metadata after swap
Message-ID: <202311281800.GTI1cgFY-lkp@intel.com>
References: <20231128053202.29007-3-zhangjiachen.jaycee@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128053202.29007-3-zhangjiachen.jaycee@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiachen,

kernel test robot noticed the following build errors:

[auto build test ERROR on xfs-linux/for-next]
[also build test ERROR on linus/master v6.7-rc3 next-20231128]
[cannot apply to djwong-xfs/djwong-devel]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiachen-Zhang/xfs-ensure-tmp_logflags-is-initialized-in-xfs_bmap_del_extent_real/20231128-135955
base:   https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git for-next
patch link:    https://lore.kernel.org/r/20231128053202.29007-3-zhangjiachen.jaycee%40bytedance.com
patch subject: [PATCH 2/2] xfs: update dir3 leaf block metadata after swap
config: powerpc64-randconfig-r081-20231128 (https://download.01.org/0day-ci/archive/20231128/202311281800.GTI1cgFY-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231128/202311281800.GTI1cgFY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311281800.GTI1cgFY-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/byteorder/big_endian.h:5,
                    from arch/powerpc/include/uapi/asm/byteorder.h:14,
                    from arch/powerpc/include/asm/qspinlock_types.h:6,
                    from arch/powerpc/include/asm/spinlock_types.h:10,
                    from include/linux/spinlock_types_raw.h:7,
                    from include/linux/ratelimit_types.h:7,
                    from include/linux/printk.h:9,
                    from include/asm-generic/bug.h:22,
                    from arch/powerpc/include/asm/bug.h:116,
                    from include/linux/bug.h:5,
                    from include/linux/fortify-string.h:5,
                    from include/linux/string.h:295,
                    from include/linux/uuid.h:11,
                    from fs/xfs/xfs_linux.h:10,
                    from fs/xfs/xfs.h:22,
                    from fs/xfs/libxfs/xfs_da_btree.c:7:
   fs/xfs/libxfs/xfs_da_btree.c: In function 'xfs_da3_swap_lastblock':
>> fs/xfs/libxfs/xfs_da_btree.c:2330:50: error: 'struct xfs_buf' has no member named 'b_bn'
    2330 |                 dap->blkno = cpu_to_be64(dead_buf->b_bn);
         |                                                  ^~
   include/uapi/linux/byteorder/big_endian.h:38:51: note: in definition of macro '__cpu_to_be64'
      38 | #define __cpu_to_be64(x) ((__force __be64)(__u64)(x))
         |                                                   ^
   fs/xfs/libxfs/xfs_da_btree.c:2330:30: note: in expansion of macro 'cpu_to_be64'
    2330 |                 dap->blkno = cpu_to_be64(dead_buf->b_bn);
         |                              ^~~~~~~~~~~


vim +2330 fs/xfs/libxfs/xfs_da_btree.c

  2254	
  2255	/*
  2256	 * Ick.  We need to always be able to remove a btree block, even
  2257	 * if there's no space reservation because the filesystem is full.
  2258	 * This is called if xfs_bunmapi on a btree block fails due to ENOSPC.
  2259	 * It swaps the target block with the last block in the file.  The
  2260	 * last block in the file can always be removed since it can't cause
  2261	 * a bmap btree split to do that.
  2262	 */
  2263	STATIC int
  2264	xfs_da3_swap_lastblock(
  2265		struct xfs_da_args	*args,
  2266		xfs_dablk_t		*dead_blknop,
  2267		struct xfs_buf		**dead_bufp)
  2268	{
  2269		struct xfs_da_blkinfo	*dead_info;
  2270		struct xfs_da_blkinfo	*sib_info;
  2271		struct xfs_da_intnode	*par_node;
  2272		struct xfs_da_intnode	*dead_node;
  2273		struct xfs_dir2_leaf	*dead_leaf2;
  2274		struct xfs_da_node_entry *btree;
  2275		struct xfs_da3_icnode_hdr par_hdr;
  2276		struct xfs_inode	*dp;
  2277		struct xfs_trans	*tp;
  2278		struct xfs_mount	*mp;
  2279		struct xfs_buf		*dead_buf;
  2280		struct xfs_buf		*last_buf;
  2281		struct xfs_buf		*sib_buf;
  2282		struct xfs_buf		*par_buf;
  2283		xfs_dahash_t		dead_hash;
  2284		xfs_fileoff_t		lastoff;
  2285		xfs_dablk_t		dead_blkno;
  2286		xfs_dablk_t		last_blkno;
  2287		xfs_dablk_t		sib_blkno;
  2288		xfs_dablk_t		par_blkno;
  2289		int			error;
  2290		int			w;
  2291		int			entno;
  2292		int			level;
  2293		int			dead_level;
  2294	
  2295		trace_xfs_da_swap_lastblock(args);
  2296	
  2297		dead_buf = *dead_bufp;
  2298		dead_blkno = *dead_blknop;
  2299		tp = args->trans;
  2300		dp = args->dp;
  2301		w = args->whichfork;
  2302		ASSERT(w == XFS_DATA_FORK);
  2303		mp = dp->i_mount;
  2304		lastoff = args->geo->freeblk;
  2305		error = xfs_bmap_last_before(tp, dp, &lastoff, w);
  2306		if (error)
  2307			return error;
  2308		if (XFS_IS_CORRUPT(mp, lastoff == 0))
  2309			return -EFSCORRUPTED;
  2310		/*
  2311		 * Read the last block in the btree space.
  2312		 */
  2313		last_blkno = (xfs_dablk_t)lastoff - args->geo->fsbcount;
  2314		error = xfs_da3_node_read(tp, dp, last_blkno, &last_buf, w);
  2315		if (error)
  2316			return error;
  2317		/*
  2318		 * Copy the last block into the dead buffer and log it.
  2319		 */
  2320		memcpy(dead_buf->b_addr, last_buf->b_addr, args->geo->blksize);
  2321		dead_info = dead_buf->b_addr;
  2322		/*
  2323		 * Update the moved block's blkno if it's a dir3 leaf block
  2324		 */
  2325		if (dead_info->magic == cpu_to_be16(XFS_DIR3_LEAF1_MAGIC) ||
  2326		    dead_info->magic == cpu_to_be16(XFS_DIR3_LEAFN_MAGIC) ||
  2327		    dead_info->magic == cpu_to_be16(XFS_ATTR3_LEAF_MAGIC)) {
  2328			struct xfs_da3_blkinfo *dap = (struct xfs_da3_blkinfo *)dead_info;
  2329	
> 2330			dap->blkno = cpu_to_be64(dead_buf->b_bn);
  2331		}
  2332		xfs_trans_log_buf(tp, dead_buf, 0, args->geo->blksize - 1);
  2333		/*
  2334		 * Get values from the moved block.
  2335		 */
  2336		if (dead_info->magic == cpu_to_be16(XFS_DIR2_LEAFN_MAGIC) ||
  2337		    dead_info->magic == cpu_to_be16(XFS_DIR3_LEAFN_MAGIC)) {
  2338			struct xfs_dir3_icleaf_hdr leafhdr;
  2339			struct xfs_dir2_leaf_entry *ents;
  2340	
  2341			dead_leaf2 = (xfs_dir2_leaf_t *)dead_info;
  2342			xfs_dir2_leaf_hdr_from_disk(dp->i_mount, &leafhdr,
  2343						    dead_leaf2);
  2344			ents = leafhdr.ents;
  2345			dead_level = 0;
  2346			dead_hash = be32_to_cpu(ents[leafhdr.count - 1].hashval);
  2347		} else {
  2348			struct xfs_da3_icnode_hdr deadhdr;
  2349	
  2350			dead_node = (xfs_da_intnode_t *)dead_info;
  2351			xfs_da3_node_hdr_from_disk(dp->i_mount, &deadhdr, dead_node);
  2352			btree = deadhdr.btree;
  2353			dead_level = deadhdr.level;
  2354			dead_hash = be32_to_cpu(btree[deadhdr.count - 1].hashval);
  2355		}
  2356		sib_buf = par_buf = NULL;
  2357		/*
  2358		 * If the moved block has a left sibling, fix up the pointers.
  2359		 */
  2360		if ((sib_blkno = be32_to_cpu(dead_info->back))) {
  2361			error = xfs_da3_node_read(tp, dp, sib_blkno, &sib_buf, w);
  2362			if (error)
  2363				goto done;
  2364			sib_info = sib_buf->b_addr;
  2365			if (XFS_IS_CORRUPT(mp,
  2366					   be32_to_cpu(sib_info->forw) != last_blkno ||
  2367					   sib_info->magic != dead_info->magic)) {
  2368				error = -EFSCORRUPTED;
  2369				goto done;
  2370			}
  2371			sib_info->forw = cpu_to_be32(dead_blkno);
  2372			xfs_trans_log_buf(tp, sib_buf,
  2373				XFS_DA_LOGRANGE(sib_info, &sib_info->forw,
  2374						sizeof(sib_info->forw)));
  2375			sib_buf = NULL;
  2376		}
  2377		/*
  2378		 * If the moved block has a right sibling, fix up the pointers.
  2379		 */
  2380		if ((sib_blkno = be32_to_cpu(dead_info->forw))) {
  2381			error = xfs_da3_node_read(tp, dp, sib_blkno, &sib_buf, w);
  2382			if (error)
  2383				goto done;
  2384			sib_info = sib_buf->b_addr;
  2385			if (XFS_IS_CORRUPT(mp,
  2386					   be32_to_cpu(sib_info->back) != last_blkno ||
  2387					   sib_info->magic != dead_info->magic)) {
  2388				error = -EFSCORRUPTED;
  2389				goto done;
  2390			}
  2391			sib_info->back = cpu_to_be32(dead_blkno);
  2392			xfs_trans_log_buf(tp, sib_buf,
  2393				XFS_DA_LOGRANGE(sib_info, &sib_info->back,
  2394						sizeof(sib_info->back)));
  2395			sib_buf = NULL;
  2396		}
  2397		par_blkno = args->geo->leafblk;
  2398		level = -1;
  2399		/*
  2400		 * Walk down the tree looking for the parent of the moved block.
  2401		 */
  2402		for (;;) {
  2403			error = xfs_da3_node_read(tp, dp, par_blkno, &par_buf, w);
  2404			if (error)
  2405				goto done;
  2406			par_node = par_buf->b_addr;
  2407			xfs_da3_node_hdr_from_disk(dp->i_mount, &par_hdr, par_node);
  2408			if (XFS_IS_CORRUPT(mp,
  2409					   level >= 0 && level != par_hdr.level + 1)) {
  2410				error = -EFSCORRUPTED;
  2411				goto done;
  2412			}
  2413			level = par_hdr.level;
  2414			btree = par_hdr.btree;
  2415			for (entno = 0;
  2416			     entno < par_hdr.count &&
  2417			     be32_to_cpu(btree[entno].hashval) < dead_hash;
  2418			     entno++)
  2419				continue;
  2420			if (XFS_IS_CORRUPT(mp, entno == par_hdr.count)) {
  2421				error = -EFSCORRUPTED;
  2422				goto done;
  2423			}
  2424			par_blkno = be32_to_cpu(btree[entno].before);
  2425			if (level == dead_level + 1)
  2426				break;
  2427			xfs_trans_brelse(tp, par_buf);
  2428			par_buf = NULL;
  2429		}
  2430		/*
  2431		 * We're in the right parent block.
  2432		 * Look for the right entry.
  2433		 */
  2434		for (;;) {
  2435			for (;
  2436			     entno < par_hdr.count &&
  2437			     be32_to_cpu(btree[entno].before) != last_blkno;
  2438			     entno++)
  2439				continue;
  2440			if (entno < par_hdr.count)
  2441				break;
  2442			par_blkno = par_hdr.forw;
  2443			xfs_trans_brelse(tp, par_buf);
  2444			par_buf = NULL;
  2445			if (XFS_IS_CORRUPT(mp, par_blkno == 0)) {
  2446				error = -EFSCORRUPTED;
  2447				goto done;
  2448			}
  2449			error = xfs_da3_node_read(tp, dp, par_blkno, &par_buf, w);
  2450			if (error)
  2451				goto done;
  2452			par_node = par_buf->b_addr;
  2453			xfs_da3_node_hdr_from_disk(dp->i_mount, &par_hdr, par_node);
  2454			if (XFS_IS_CORRUPT(mp, par_hdr.level != level)) {
  2455				error = -EFSCORRUPTED;
  2456				goto done;
  2457			}
  2458			btree = par_hdr.btree;
  2459			entno = 0;
  2460		}
  2461		/*
  2462		 * Update the parent entry pointing to the moved block.
  2463		 */
  2464		btree[entno].before = cpu_to_be32(dead_blkno);
  2465		xfs_trans_log_buf(tp, par_buf,
  2466			XFS_DA_LOGRANGE(par_node, &btree[entno].before,
  2467					sizeof(btree[entno].before)));
  2468		*dead_blknop = last_blkno;
  2469		*dead_bufp = last_buf;
  2470		return 0;
  2471	done:
  2472		if (par_buf)
  2473			xfs_trans_brelse(tp, par_buf);
  2474		if (sib_buf)
  2475			xfs_trans_brelse(tp, sib_buf);
  2476		xfs_trans_brelse(tp, last_buf);
  2477		return error;
  2478	}
  2479	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
