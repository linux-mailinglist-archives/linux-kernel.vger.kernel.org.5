Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7395C752709
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbjGMP3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234067AbjGMP3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:29:20 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1D22127
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689262141; x=1720798141;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xux1JYmAbMREnLahnAwC5Ie7sNJtHyUdLX33J5c/Lxk=;
  b=SqSg9amHUNa29LhTvIDrtUrIkmqlzz6oZnVUY2qoKANU2NvqMtiS7f1+
   uUu1hvLhAsdunNHmefqQxTeKq+aRNvQySpjCcz+Hjo6DKr4HiH+dJLVMM
   YCbsU9Uwl5NbueH3QSrPj2jSAvPT9/eHilQEFS3eVcYdfWFHKj/ZwZgA9
   8MIf9fbiK4/Q8UhK2o8J9kIC1mNCOE5cPIAJw7Kbh00jMXItQCDsjK8Lk
   8V8Qy9XSP5Su4B3zhfBEkgcCnYERNOWWsVB10GOfVsR72/Zt9sAHZDutj
   HTuDx3FsPFVSd32edAdc9Pej0TBTZUpo6F4/5czFHQ9qnqJIfh6GQmCjo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="396026668"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="396026668"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 08:29:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="757204899"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="757204899"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 13 Jul 2023 08:28:59 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qJyFX-0006i8-0t;
        Thu, 13 Jul 2023 15:28:59 +0000
Date:   Thu, 13 Jul 2023 23:28:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jan Kara <jack@suse.cz>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: fs/ext4/inode.c:2715:12: warning: stack frame size (1392) exceeds
 limit (1024) in 'ext4_do_writepages'
Message-ID: <202307132338.YXtPr5BN-lkp@intel.com>
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

Hi Jan,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   eb26cbb1a754ccde5d4d74527dad5ba051808fad
commit: 15648d599cd1c15cc678039dcab65599276fe407 ext4: provide ext4_do_writepages()
date:   7 months ago
config: riscv-randconfig-r003-20230713 (https://download.01.org/0day-ci/archive/20230713/202307132338.YXtPr5BN-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce: (https://download.01.org/0day-ci/archive/20230713/202307132338.YXtPr5BN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307132338.YXtPr5BN-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/ext4/inode.c:2715:12: warning: stack frame size (1392) exceeds limit (1024) in 'ext4_do_writepages' [-Wframe-larger-than]
   static int ext4_do_writepages(struct mpage_da_data *mpd)
              ^
   1 warning generated.


vim +/ext4_do_writepages +2715 fs/ext4/inode.c

  2714	
> 2715	static int ext4_do_writepages(struct mpage_da_data *mpd)
  2716	{
  2717		struct writeback_control *wbc = mpd->wbc;
  2718		pgoff_t	writeback_index = 0;
  2719		long nr_to_write = wbc->nr_to_write;
  2720		int range_whole = 0;
  2721		int cycled = 1;
  2722		handle_t *handle = NULL;
  2723		struct inode *inode = mpd->inode;
  2724		struct address_space *mapping = inode->i_mapping;
  2725		int needed_blocks, rsv_blocks = 0, ret = 0;
  2726		struct ext4_sb_info *sbi = EXT4_SB(mapping->host->i_sb);
  2727		struct blk_plug plug;
  2728		bool give_up_on_write = false;
  2729	
  2730		if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
  2731			return -EIO;
  2732	
  2733		percpu_down_read(&sbi->s_writepages_rwsem);
  2734		trace_ext4_writepages(inode, wbc);
  2735	
  2736		/*
  2737		 * No pages to write? This is mainly a kludge to avoid starting
  2738		 * a transaction for special inodes like journal inode on last iput()
  2739		 * because that could violate lock ordering on umount
  2740		 */
  2741		if (!mapping->nrpages || !mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
  2742			goto out_writepages;
  2743	
  2744		if (ext4_should_journal_data(inode)) {
  2745			ret = generic_writepages(mapping, wbc);
  2746			goto out_writepages;
  2747		}
  2748	
  2749		/*
  2750		 * If the filesystem has aborted, it is read-only, so return
  2751		 * right away instead of dumping stack traces later on that
  2752		 * will obscure the real source of the problem.  We test
  2753		 * EXT4_MF_FS_ABORTED instead of sb->s_flag's SB_RDONLY because
  2754		 * the latter could be true if the filesystem is mounted
  2755		 * read-only, and in that case, ext4_writepages should
  2756		 * *never* be called, so if that ever happens, we would want
  2757		 * the stack trace.
  2758		 */
  2759		if (unlikely(ext4_forced_shutdown(EXT4_SB(mapping->host->i_sb)) ||
  2760			     ext4_test_mount_flag(inode->i_sb, EXT4_MF_FS_ABORTED))) {
  2761			ret = -EROFS;
  2762			goto out_writepages;
  2763		}
  2764	
  2765		/*
  2766		 * If we have inline data and arrive here, it means that
  2767		 * we will soon create the block for the 1st page, so
  2768		 * we'd better clear the inline data here.
  2769		 */
  2770		if (ext4_has_inline_data(inode)) {
  2771			/* Just inode will be modified... */
  2772			handle = ext4_journal_start(inode, EXT4_HT_INODE, 1);
  2773			if (IS_ERR(handle)) {
  2774				ret = PTR_ERR(handle);
  2775				goto out_writepages;
  2776			}
  2777			BUG_ON(ext4_test_inode_state(inode,
  2778					EXT4_STATE_MAY_INLINE_DATA));
  2779			ext4_destroy_inline_data(handle, inode);
  2780			ext4_journal_stop(handle);
  2781		}
  2782	
  2783		if (ext4_should_dioread_nolock(inode)) {
  2784			/*
  2785			 * We may need to convert up to one extent per block in
  2786			 * the page and we may dirty the inode.
  2787			 */
  2788			rsv_blocks = 1 + ext4_chunk_trans_blocks(inode,
  2789							PAGE_SIZE >> inode->i_blkbits);
  2790		}
  2791	
  2792		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
  2793			range_whole = 1;
  2794	
  2795		if (wbc->range_cyclic) {
  2796			writeback_index = mapping->writeback_index;
  2797			if (writeback_index)
  2798				cycled = 0;
  2799			mpd->first_page = writeback_index;
  2800			mpd->last_page = -1;
  2801		} else {
  2802			mpd->first_page = wbc->range_start >> PAGE_SHIFT;
  2803			mpd->last_page = wbc->range_end >> PAGE_SHIFT;
  2804		}
  2805	
  2806		ext4_io_submit_init(&mpd->io_submit, wbc);
  2807	retry:
  2808		if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
  2809			tag_pages_for_writeback(mapping, mpd->first_page,
  2810						mpd->last_page);
  2811		blk_start_plug(&plug);
  2812	
  2813		/*
  2814		 * First writeback pages that don't need mapping - we can avoid
  2815		 * starting a transaction unnecessarily and also avoid being blocked
  2816		 * in the block layer on device congestion while having transaction
  2817		 * started.
  2818		 */
  2819		mpd->do_map = 0;
  2820		mpd->scanned_until_end = 0;
  2821		mpd->io_submit.io_end = ext4_init_io_end(inode, GFP_KERNEL);
  2822		if (!mpd->io_submit.io_end) {
  2823			ret = -ENOMEM;
  2824			goto unplug;
  2825		}
  2826		ret = mpage_prepare_extent_to_map(mpd);
  2827		/* Unlock pages we didn't use */
  2828		mpage_release_unused_pages(mpd, false);
  2829		/* Submit prepared bio */
  2830		ext4_io_submit(&mpd->io_submit);
  2831		ext4_put_io_end_defer(mpd->io_submit.io_end);
  2832		mpd->io_submit.io_end = NULL;
  2833		if (ret < 0)
  2834			goto unplug;
  2835	
  2836		while (!mpd->scanned_until_end && wbc->nr_to_write > 0) {
  2837			/* For each extent of pages we use new io_end */
  2838			mpd->io_submit.io_end = ext4_init_io_end(inode, GFP_KERNEL);
  2839			if (!mpd->io_submit.io_end) {
  2840				ret = -ENOMEM;
  2841				break;
  2842			}
  2843	
  2844			WARN_ON_ONCE(!mpd->can_map);
  2845			/*
  2846			 * We have two constraints: We find one extent to map and we
  2847			 * must always write out whole page (makes a difference when
  2848			 * blocksize < pagesize) so that we don't block on IO when we
  2849			 * try to write out the rest of the page. Journalled mode is
  2850			 * not supported by delalloc.
  2851			 */
  2852			BUG_ON(ext4_should_journal_data(inode));
  2853			needed_blocks = ext4_da_writepages_trans_blocks(inode);
  2854	
  2855			/* start a new transaction */
  2856			handle = ext4_journal_start_with_reserve(inode,
  2857					EXT4_HT_WRITE_PAGE, needed_blocks, rsv_blocks);
  2858			if (IS_ERR(handle)) {
  2859				ret = PTR_ERR(handle);
  2860				ext4_msg(inode->i_sb, KERN_CRIT, "%s: jbd2_start: "
  2861				       "%ld pages, ino %lu; err %d", __func__,
  2862					wbc->nr_to_write, inode->i_ino, ret);
  2863				/* Release allocated io_end */
  2864				ext4_put_io_end(mpd->io_submit.io_end);
  2865				mpd->io_submit.io_end = NULL;
  2866				break;
  2867			}
  2868			mpd->do_map = 1;
  2869	
  2870			trace_ext4_da_write_pages(inode, mpd->first_page, wbc);
  2871			ret = mpage_prepare_extent_to_map(mpd);
  2872			if (!ret && mpd->map.m_len)
  2873				ret = mpage_map_and_submit_extent(handle, mpd,
  2874						&give_up_on_write);
  2875			/*
  2876			 * Caution: If the handle is synchronous,
  2877			 * ext4_journal_stop() can wait for transaction commit
  2878			 * to finish which may depend on writeback of pages to
  2879			 * complete or on page lock to be released.  In that
  2880			 * case, we have to wait until after we have
  2881			 * submitted all the IO, released page locks we hold,
  2882			 * and dropped io_end reference (for extent conversion
  2883			 * to be able to complete) before stopping the handle.
  2884			 */
  2885			if (!ext4_handle_valid(handle) || handle->h_sync == 0) {
  2886				ext4_journal_stop(handle);
  2887				handle = NULL;
  2888				mpd->do_map = 0;
  2889			}
  2890			/* Unlock pages we didn't use */
  2891			mpage_release_unused_pages(mpd, give_up_on_write);
  2892			/* Submit prepared bio */
  2893			ext4_io_submit(&mpd->io_submit);
  2894	
  2895			/*
  2896			 * Drop our io_end reference we got from init. We have
  2897			 * to be careful and use deferred io_end finishing if
  2898			 * we are still holding the transaction as we can
  2899			 * release the last reference to io_end which may end
  2900			 * up doing unwritten extent conversion.
  2901			 */
  2902			if (handle) {
  2903				ext4_put_io_end_defer(mpd->io_submit.io_end);
  2904				ext4_journal_stop(handle);
  2905			} else
  2906				ext4_put_io_end(mpd->io_submit.io_end);
  2907			mpd->io_submit.io_end = NULL;
  2908	
  2909			if (ret == -ENOSPC && sbi->s_journal) {
  2910				/*
  2911				 * Commit the transaction which would
  2912				 * free blocks released in the transaction
  2913				 * and try again
  2914				 */
  2915				jbd2_journal_force_commit_nested(sbi->s_journal);
  2916				ret = 0;
  2917				continue;
  2918			}
  2919			/* Fatal error - ENOMEM, EIO... */
  2920			if (ret)
  2921				break;
  2922		}
  2923	unplug:
  2924		blk_finish_plug(&plug);
  2925		if (!ret && !cycled && wbc->nr_to_write > 0) {
  2926			cycled = 1;
  2927			mpd->last_page = writeback_index - 1;
  2928			mpd->first_page = 0;
  2929			goto retry;
  2930		}
  2931	
  2932		/* Update index */
  2933		if (wbc->range_cyclic || (range_whole && wbc->nr_to_write > 0))
  2934			/*
  2935			 * Set the writeback_index so that range_cyclic
  2936			 * mode will write it back later
  2937			 */
  2938			mapping->writeback_index = mpd->first_page;
  2939	
  2940	out_writepages:
  2941		trace_ext4_writepages_result(inode, wbc, ret,
  2942					     nr_to_write - wbc->nr_to_write);
  2943		percpu_up_read(&sbi->s_writepages_rwsem);
  2944		return ret;
  2945	}
  2946	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
