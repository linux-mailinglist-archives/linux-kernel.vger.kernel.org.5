Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F337DFE1C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 03:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343859AbjKCCmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 22:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjKCCmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 22:42:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C205419D;
        Thu,  2 Nov 2023 19:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698979363; x=1730515363;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=A12jr/Fr5ti9ffyJx+eCxY4/gYdHcgsiea0V3zc8/9E=;
  b=kr3W4i67wNKzzKZkKTj2eDN4k527oAN85BmP8XHbWgdntcqYZEardMi+
   MyaVFtP7LFOVmvUIljMZ+xJ5Bts0TwxeJ2b88PdxWOc7HiF7HgkBxWIrZ
   KQDlWE+Zl7MxbDwU7gEQhiK9PbJyyk2kzGfziMpemxC+HQlCPI22mI20I
   J/8GL3SWp6Wvkes5N3j4nmPTJi5/vP9HcpH4RhhUEeFMa+NWQ6Eel4Yic
   SvtK1zi8EPgbkbQpZ59rdSg/Wt4xRktjyhnyT57yHEaNhzEHeQgm7KyfK
   zsMSB9ADVo3o9FVWGgj22gMIaciU8R8eySJTx4HXES9A7JF7dWzj368VG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="7501649"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="7501649"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 19:42:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="852135977"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="852135977"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Nov 2023 19:42:40 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyk8s-00027w-1N;
        Fri, 03 Nov 2023 02:42:38 +0000
Date:   Fri, 3 Nov 2023 10:41:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kent Overstreet <kmo@daterainc.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Brian Foster <bfoster@redhat.com>,
        linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [linux-next:master 15635/16110] fs/bcachefs/disk_groups.c:534:6:
 sparse: sparse: symbol 'bch2_target_to_text_sb' was not declared. Should it
 be static?
Message-ID: <202311031030.xZT1XBXd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
head:   ab57716449b3438c0136f6f412a2e59e0cf037a9
commit: bf0d9e89de2e62fe9967ebb77b68d58d3812e4db [15635/16110] bcachefs: Split apart bch2_target_to_text(), bch2_target_to_text_sb()
config: i386-randconfig-061-20231102 (https://download.01.org/0day-ci/archive/20231103/202311031030.xZT1XBXd-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231103/202311031030.xZT1XBXd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311031030.xZT1XBXd-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   fs/bcachefs/disk_groups.c: note: in included file:
   fs/bcachefs/bcachefs.h:957:9: sparse: sparse: array of flexible structures
>> fs/bcachefs/disk_groups.c:534:6: sparse: sparse: symbol 'bch2_target_to_text_sb' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
