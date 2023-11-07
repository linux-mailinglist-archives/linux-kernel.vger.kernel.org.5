Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F84A7E4913
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 20:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343759AbjKGTTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 14:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbjKGTTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 14:19:47 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A622D10CE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 11:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699384785; x=1730920785;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ey6mMZSS50+XcIbiBxZUVaica+lG7Ql2zmbRMzN42mo=;
  b=DfxNt4Pd8EIjnW7QJ66m4vLyc72aDwS9eVhCWV0o38C0XCwY27os/cJy
   W2i7uTFOjdR3l6LA7m5HGdI+1ZODHnTYRDlh8ZyixZscjiWDqtaLGDEO7
   bxgx0Y4rH2Xc5RUVme4mP9YDozQ2ftv0hNOzOOjKIFlmb3hn9wOFEfVTf
   YP7jsJDmvhAEzqMsaC4yGuJ3mSsBvwC0MpeBbv3ixbGCBSb0zfQK/j1bL
   b07+xoIgbgpeSs2a6tp2yqRi+e7NMSCcSzqhtxrI9FqNUAYMTE7Y52OS4
   qgeIgNYA9eW3t1Y4eFmWyJRMLEe0yzZpsVn8511nZXX3bPNcJta75WVjE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="392469681"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="392469681"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 11:19:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="906519722"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="906519722"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 07 Nov 2023 11:19:42 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r0Rbw-0007LU-1v;
        Tue, 07 Nov 2023 19:19:40 +0000
Date:   Wed, 8 Nov 2023 03:18:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     dslab@lzu.edu.cn, jaegeuk@kernel.org, chao@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yang Hubin <yanghb2019@lzu.edu.cn>
Subject: Re: [PATCH] f2fs: the name of a struct is wrong in a comment.
Message-ID: <202311080247.0hkA0mLH-lkp@intel.com>
References: <20231106121418.3675-1-dslab@lzu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106121418.3675-1-dslab@lzu.edu.cn>
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
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20231108/202311080247.0hkA0mLH-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231108/202311080247.0hkA0mLH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311080247.0hkA0mLH-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/f2fs/dir.c:10:
>> include/linux/f2fs_fs.h:501:16: error: expected ']'
           __u8 reserved[NAT_JOURNAL_RESERVED];
                         ^
   include/linux/f2fs_fs.h:474:38: note: expanded from macro 'NAT_JOURNAL_RESERVED'
                                   sizeof(struct nat_journal_entry))SIT_JOURNA
                                                                    ^
   include/linux/f2fs_fs.h:501:15: note: to match this '['
           __u8 reserved[NAT_JOURNAL_RESERVED];
                        ^
   1 error generated.


vim +501 include/linux/f2fs_fs.h

dd31866b0d55c9 Jaegeuk Kim 2012-11-02  498  
dd31866b0d55c9 Jaegeuk Kim 2012-11-02  499  struct nat_journal {
dd31866b0d55c9 Jaegeuk Kim 2012-11-02  500  	struct nat_journal_entry entries[NAT_JOURNAL_ENTRIES];
dd31866b0d55c9 Jaegeuk Kim 2012-11-02 @501  	__u8 reserved[NAT_JOURNAL_RESERVED];
dd31866b0d55c9 Jaegeuk Kim 2012-11-02  502  } __packed;
dd31866b0d55c9 Jaegeuk Kim 2012-11-02  503  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
