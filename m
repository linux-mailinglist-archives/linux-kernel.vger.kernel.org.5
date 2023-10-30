Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337C87DC25A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 23:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjJ3WPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 18:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjJ3WPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 18:15:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36FBBD
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 15:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698704135; x=1730240135;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=H9w8xJecpoH2IwaAPYxzSsK0ti7SF4yRAnJehfCtS10=;
  b=h4Eic9dAAgS0tpX4LghapEH2pABQa2wm1VfY4rr/x65iEod8iQOZq2dV
   SSg5AQDrD/DBbOX5Wi8cr4k10I4ZWiByUORNYoLSsKorwjUOxp5HTxc6B
   FClAQIjV0JtJgi8yrUAEcNRWCF7tH7uckwxzUNn9dFQZOixid0hg61RoF
   cdLeJz/IcLjtlWzXUDJq6iX540+bIH1z6ddrXsWYvka0OOpWkmR7zHVLK
   VEBLAYre8PN03TOrWgJ83ktE8+8fcxUACDBp1jvbQjMQ8jd9gs4BwwcW8
   uYbrn++tvIhI5DnEpmHd3K0P8bdeiGea8+FKhBdtX/EAvzHXKKHSuncPb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="1049375"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="1049375"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 15:15:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="764052546"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="764052546"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 30 Oct 2023 15:15:33 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qxaXi-000Db5-2L;
        Mon, 30 Oct 2023 22:15:30 +0000
Date:   Tue, 31 Oct 2023 06:15:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/sh/boot/compressed/misc.c:118:6: warning: no previous prototype
 for 'arch_ftrace_ops_list_func'
Message-ID: <202310310611.5RteDpO7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   14ab6d425e80674b6a0145f05719b11e82e64824
commit: 17b251a290ba84a0c2c5c82df9596cb2e7207ca6 ftrace/sh: Add arch_ftrace_ops_list_func stub to have compressed image still link
date:   2 years ago
config: sh-allnoconfig (https://download.01.org/0day-ci/archive/20231031/202310310611.5RteDpO7-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231031/202310310611.5RteDpO7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310310611.5RteDpO7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/sh/boot/compressed/misc.c:109:6: warning: no previous prototype for '__stack_chk_fail' [-Wmissing-prototypes]
     109 | void __stack_chk_fail(void)
         |      ^~~~~~~~~~~~~~~~
   arch/sh/boot/compressed/misc.c:115:6: warning: no previous prototype for 'ftrace_stub' [-Wmissing-prototypes]
     115 | void ftrace_stub(void)
         |      ^~~~~~~~~~~
>> arch/sh/boot/compressed/misc.c:118:6: warning: no previous prototype for 'arch_ftrace_ops_list_func' [-Wmissing-prototypes]
     118 | void arch_ftrace_ops_list_func(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/sh/boot/compressed/misc.c:128:6: warning: no previous prototype for 'decompress_kernel' [-Wmissing-prototypes]
     128 | void decompress_kernel(void)
         |      ^~~~~~~~~~~~~~~~~


vim +/arch_ftrace_ops_list_func +118 arch/sh/boot/compressed/misc.c

   113	
   114	/* Needed because vmlinux.lds.h references this */
   115	void ftrace_stub(void)
   116	{
   117	}
 > 118	void arch_ftrace_ops_list_func(void)
   119	{
   120	}
   121	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
