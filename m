Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA337E3554
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 07:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjKGGmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 01:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjKGGma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 01:42:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6006810F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 22:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699339347; x=1730875347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eHKi3cWMbNTKD8oTr73ZVJofUYlGiNX/ZJ7LuaMkJsU=;
  b=nmPjaHPdZ4LC9H6Jbjeo3pOshQTuRVUE6Vf6abDuC4C0A2kAU/tgFsIL
   Pr3TaI/F4xZwg2EjWDWhGghues4dii3Zm30/3VXzv1AQYubGIxk1yS57O
   FmD50KnqAx+6VovwJfWyPOq/QsbbjMtLK8uLQrEwpCdABhPMuZg4Kxx+5
   SEKzKKA3Xf2aFez7nFoL24zp8njuVBfeOQo9e2tXRgQlxlINYLSvNATlE
   e8sPwK/VmYUYi6TUH/h96TUZbtQ7bia07oGWpFvbvtNudgtM1GK4vXg/R
   RUIdroIE9hFxKyu1Beg/C4IJh7wxExRaCdzxh0EykVaEPO4U7D59EU6HG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="8091596"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="8091596"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 22:42:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="936052345"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="936052345"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 06 Nov 2023 22:42:24 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r0Fn4-0006y4-0X;
        Tue, 07 Nov 2023 06:42:22 +0000
Date:   Tue, 7 Nov 2023 14:42:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     dslab@lzu.edu.cn, jaegeuk@kernel.org, chao@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yang Hubin <yanghb2019@lzu.edu.cn>
Subject: Re: [PATCH] f2fs: the name of a struct is wrong in a comment.
Message-ID: <202311071353.SmED46lo-lkp@intel.com>
References: <20231106121418.3675-1-dslab@lzu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106121418.3675-1-dslab@lzu.edu.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on jaegeuk-f2fs/dev-test]
[also build test ERROR on jaegeuk-f2fs/dev linus/master v6.6 next-20231107]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/dslab-lzu-edu-cn/f2fs-the-name-of-a-struct-is-wrong-in-a-comment/20231106-201822
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
patch link:    https://lore.kernel.org/r/20231106121418.3675-1-dslab%40lzu.edu.cn
patch subject: [PATCH] f2fs: the name of a struct is wrong in a comment.
config: parisc-randconfig-001-20231107 (https://download.01.org/0day-ci/archive/20231107/202311071353.SmED46lo-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231107/202311071353.SmED46lo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311071353.SmED46lo-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from fs/f2fs/segment.c:9:
>> include/linux/f2fs_fs.h:474:66: error: expected ']' before 'SIT_JOURNA'
     474 |                                 sizeof(struct nat_journal_entry))SIT_JOURNA
         |                                                                  ^~~~~~~~~~
   include/linux/f2fs_fs.h:501:23: note: in expansion of macro 'NAT_JOURNAL_RESERVED'
     501 |         __u8 reserved[NAT_JOURNAL_RESERVED];
         |                       ^~~~~~~~~~~~~~~~~~~~
>> include/linux/f2fs_fs.h:502:1: warning: no semicolon at end of struct or union
     502 | } __packed;
         | ^


vim +474 include/linux/f2fs_fs.h

   468	
   469	#define SUM_JOURNAL_SIZE	(F2FS_BLKSIZE - SUM_FOOTER_SIZE -\
   470					SUM_ENTRY_SIZE)
   471	#define NAT_JOURNAL_ENTRIES	((SUM_JOURNAL_SIZE - 2) /\
   472					sizeof(struct nat_journal_entry))
   473	#define NAT_JOURNAL_RESERVED	((SUM_JOURNAL_SIZE - 2) %\
 > 474					sizeof(struct nat_journal_entry))SIT_JOURNA
   475	#define SIT_JOURNAL_ENTRIES	((SUM_JOURNAL_SIZE - 2) /\
   476					sizeof(struct sit_journal_entry))
   477	#define SIT_JOURNAL_RESERVED	((SUM_JOURNAL_SIZE - 2) %\
   478					sizeof(struct sit_journal_entry))
   479	
   480	/* Reserved area should make size of f2fs_extra_info equals to
   481	 * that of nat_journal and sit_journal.
   482	 */
   483	#define EXTRA_INFO_RESERVED	(SUM_JOURNAL_SIZE - 2 - 8)
   484	
   485	/*
   486	 * frequently updated NAT/SIT entries can be stored in the spare area in
   487	 * summary blocks
   488	 */
   489	enum {
   490		NAT_JOURNAL = 0,
   491		SIT_JOURNAL
   492	};
   493	
   494	struct nat_journal_entry {
   495		__le32 nid;
   496		struct f2fs_nat_entry ne;
   497	} __packed;
   498	
   499	struct nat_journal {
   500		struct nat_journal_entry entries[NAT_JOURNAL_ENTRIES];
   501		__u8 reserved[NAT_JOURNAL_RESERVED];
 > 502	} __packed;
   503	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
