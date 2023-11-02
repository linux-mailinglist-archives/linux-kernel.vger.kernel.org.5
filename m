Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F90D7DF6EC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347621AbjKBPrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbjKBPrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:47:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5BC137
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698940030; x=1730476030;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HNI3x3MYh/j6wySXSOikcO/9VddS9p/hNBuGdysRtcM=;
  b=mHw+4qOVx2vBsfRLzwZUIsvSXEz4HT8KuNUQixWuro9Z6fZ/vDBQrOm3
   aQeZxpd98UF5H7Bh25l1kfK854og1XbgSF9D9dAV5aa/O4LV5IWp/A/JK
   Ns9CfuxGbp7hqivzAwotfgaP/UceOv92+KkqBDnTwtCt4rwt9HPIOP/CL
   hc0DVi/kKaABNCKMK3tK03cdTAAKI3Xt5oB+Kkuobf6qvyMpub798PlzH
   sojl9Rw2vpgoVb/C0fbccBfWb4h/OVW45zbdK3mu/IYplbDa1f1tZxB0u
   RYISMLBtp+Wkwd0FG6H/rriwgMFtgq0iWZ7L9e7bDbBc7I7tivkPlJqku
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="368950282"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="368950282"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 08:46:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="711186730"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="711186730"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 Nov 2023 08:46:39 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyZu1-0001b6-0v;
        Thu, 02 Nov 2023 15:46:37 +0000
Date:   Thu, 2 Nov 2023 23:46:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: lib/maple_tree.c:4327:20: warning: stack frame size (1112) exceeds
 limit (1024) in 'mas_wr_modify'
Message-ID: <202311022317.B3t8ONbL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   21e80f3841c01aeaf32d7aee7bbc87b3db1aa0c6
commit: 54a611b605901c7d5d05b6b8f5d04a6ceb0962aa Maple Tree: add new data structure
date:   1 year, 1 month ago
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20231102/202311022317.B3t8ONbL-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231102/202311022317.B3t8ONbL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311022317.B3t8ONbL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   lib/maple_tree.c:330:20: warning: unused function 'mte_set_full' [-Wunused-function]
     330 | static inline void mte_set_full(const struct maple_enode *node)
         |                    ^
   lib/maple_tree.c:335:20: warning: unused function 'mte_clear_full' [-Wunused-function]
     335 | static inline void mte_clear_full(const struct maple_enode *node)
         |                    ^
   lib/maple_tree.c:3958:19: warning: stack frame size (1032) exceeds limit (1024) in 'mas_wr_spanning_store' [-Wframe-larger-than]
    3958 | static inline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
         |                   ^
>> lib/maple_tree.c:4327:20: warning: stack frame size (1112) exceeds limit (1024) in 'mas_wr_modify' [-Wframe-larger-than]
    4327 | static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
         |                    ^
   4 warnings generated.


vim +/mas_wr_modify +4327 lib/maple_tree.c

  4326	
> 4327	static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
  4328	{
  4329		unsigned char node_slots;
  4330		unsigned char node_size;
  4331		struct ma_state *mas = wr_mas->mas;
  4332	
  4333		/* Direct replacement */
  4334		if (wr_mas->r_min == mas->index && wr_mas->r_max == mas->last) {
  4335			rcu_assign_pointer(wr_mas->slots[mas->offset], wr_mas->entry);
  4336			if (!!wr_mas->entry ^ !!wr_mas->content)
  4337				mas_update_gap(mas);
  4338			return;
  4339		}
  4340	
  4341		/* Attempt to append */
  4342		node_slots = mt_slots[wr_mas->type];
  4343		node_size = wr_mas->node_end - wr_mas->offset_end + mas->offset + 2;
  4344		if (mas->max == ULONG_MAX)
  4345			node_size++;
  4346	
  4347		/* slot and node store will not fit, go to the slow path */
  4348		if (unlikely(node_size >= node_slots))
  4349			goto slow_path;
  4350	
  4351		if (wr_mas->entry && (wr_mas->node_end < node_slots - 1) &&
  4352		    (mas->offset == wr_mas->node_end) && mas_wr_append(wr_mas)) {
  4353			if (!wr_mas->content || !wr_mas->entry)
  4354				mas_update_gap(mas);
  4355			return;
  4356		}
  4357	
  4358		if ((wr_mas->offset_end - mas->offset <= 1) && mas_wr_slot_store(wr_mas))
  4359			return;
  4360		else if (mas_wr_node_store(wr_mas))
  4361			return;
  4362	
  4363		if (mas_is_err(mas))
  4364			return;
  4365	
  4366	slow_path:
  4367		mas_wr_bnode(wr_mas);
  4368	}
  4369	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
