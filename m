Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AE7752FDB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjGNDRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234845AbjGNDRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:17:21 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D7F30C3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 20:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689304633; x=1720840633;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3vjrBGuntp7lEx8CYlhUTCyMW8/To8SeAOuZ7EMQM2I=;
  b=XhUI1SMeMmIDdvXibKcEHfvA/AhhWGfA6Ih9R/HVinAcSjCw68713WMm
   +0IN+LxY9TEZFeshMA011VsODBISvkWaltwALscPAKN4LyKWa9sgSumWq
   DSkQiAc094COikeGBrnb2L1C4rdW1f5cMwlN9hicVEbqC8Qk8g2Kqi7P/
   bpN5J73yUSuRSWfRhk1TsSYz4atwFfXNOxzO/FxF7lt/vVZnnxd4Lr22B
   mOnNW6XFXmWC3JYF93SkjH0SXprulbwfWvv1sPeXwKeZl+dOV94ylrUZ2
   I2MrGgGie7n+ociCduvJPujO0w/RTpwfrMzjv7+nG92J7JBpZpU9F9JG/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="451739235"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="451739235"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 20:16:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="699521154"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="699521154"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 13 Jul 2023 20:16:20 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qK9I4-000787-0A;
        Fri, 14 Jul 2023 03:16:20 +0000
Date:   Fri, 14 Jul 2023 11:16:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>
Subject: fs/f2fs/gc.c:744:5: warning: stack frame size (1712) exceeds limit
 (1024) in 'f2fs_get_victim'
Message-ID: <202307141107.xoC7milY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4b810bf037e524b54669acbe4e0df54b15d87ea1
commit: 19e0e21a51183d4e0784602f27e4db7b965077be f2fs: remove struct victim_selection default_v_ops
date:   3 months ago
config: riscv-randconfig-r003-20230713 (https://download.01.org/0day-ci/archive/20230714/202307141107.xoC7milY-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce: (https://download.01.org/0day-ci/archive/20230714/202307141107.xoC7milY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307141107.xoC7milY-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/f2fs/gc.c:744:5: warning: stack frame size (1712) exceeds limit (1024) in 'f2fs_get_victim' [-Wframe-larger-than]
   int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
       ^
   1 warning generated.


vim +/f2fs_get_victim +744 fs/f2fs/gc.c

   735	
   736	/*
   737	 * This function is called from two paths.
   738	 * One is garbage collection and the other is SSR segment selection.
   739	 * When it is called during GC, it just gets a victim segment
   740	 * and it does not remove it from dirty seglist.
   741	 * When it is called from SSR segment selection, it finds a segment
   742	 * which has minimum valid blocks and removes it from dirty seglist.
   743	 */
 > 744	int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
   745				int gc_type, int type, char alloc_mode,
   746				unsigned long long age)
   747	{
   748		struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
   749		struct sit_info *sm = SIT_I(sbi);
   750		struct victim_sel_policy p;
   751		unsigned int secno, last_victim;
   752		unsigned int last_segment;
   753		unsigned int nsearched;
   754		bool is_atgc;
   755		int ret = 0;
   756	
   757		mutex_lock(&dirty_i->seglist_lock);
   758		last_segment = MAIN_SECS(sbi) * sbi->segs_per_sec;
   759	
   760		p.alloc_mode = alloc_mode;
   761		p.age = age;
   762		p.age_threshold = sbi->am.age_threshold;
   763	
   764	retry:
   765		select_policy(sbi, gc_type, type, &p);
   766		p.min_segno = NULL_SEGNO;
   767		p.oldest_age = 0;
   768		p.min_cost = get_max_cost(sbi, &p);
   769	
   770		is_atgc = (p.gc_mode == GC_AT || p.alloc_mode == AT_SSR);
   771		nsearched = 0;
   772	
   773		if (is_atgc)
   774			SIT_I(sbi)->dirty_min_mtime = ULLONG_MAX;
   775	
   776		if (*result != NULL_SEGNO) {
   777			if (!get_valid_blocks(sbi, *result, false)) {
   778				ret = -ENODATA;
   779				goto out;
   780			}
   781	
   782			if (sec_usage_check(sbi, GET_SEC_FROM_SEG(sbi, *result)))
   783				ret = -EBUSY;
   784			else
   785				p.min_segno = *result;
   786			goto out;
   787		}
   788	
   789		ret = -ENODATA;
   790		if (p.max_search == 0)
   791			goto out;
   792	
   793		if (__is_large_section(sbi) && p.alloc_mode == LFS) {
   794			if (sbi->next_victim_seg[BG_GC] != NULL_SEGNO) {
   795				p.min_segno = sbi->next_victim_seg[BG_GC];
   796				*result = p.min_segno;
   797				sbi->next_victim_seg[BG_GC] = NULL_SEGNO;
   798				goto got_result;
   799			}
   800			if (gc_type == FG_GC &&
   801					sbi->next_victim_seg[FG_GC] != NULL_SEGNO) {
   802				p.min_segno = sbi->next_victim_seg[FG_GC];
   803				*result = p.min_segno;
   804				sbi->next_victim_seg[FG_GC] = NULL_SEGNO;
   805				goto got_result;
   806			}
   807		}
   808	
   809		last_victim = sm->last_victim[p.gc_mode];
   810		if (p.alloc_mode == LFS && gc_type == FG_GC) {
   811			p.min_segno = check_bg_victims(sbi);
   812			if (p.min_segno != NULL_SEGNO)
   813				goto got_it;
   814		}
   815	
   816		while (1) {
   817			unsigned long cost, *dirty_bitmap;
   818			unsigned int unit_no, segno;
   819	
   820			dirty_bitmap = p.dirty_bitmap;
   821			unit_no = find_next_bit(dirty_bitmap,
   822					last_segment / p.ofs_unit,
   823					p.offset / p.ofs_unit);
   824			segno = unit_no * p.ofs_unit;
   825			if (segno >= last_segment) {
   826				if (sm->last_victim[p.gc_mode]) {
   827					last_segment =
   828						sm->last_victim[p.gc_mode];
   829					sm->last_victim[p.gc_mode] = 0;
   830					p.offset = 0;
   831					continue;
   832				}
   833				break;
   834			}
   835	
   836			p.offset = segno + p.ofs_unit;
   837			nsearched++;
   838	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
