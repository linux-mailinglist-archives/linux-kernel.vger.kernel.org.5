Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1720E7BFF81
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjJJOnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbjJJOna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:43:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AE199
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696949008; x=1728485008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zfROI6MBZCaI2oRWyyxyDo+yXZYPsEV+/hc81eUbxCc=;
  b=TXMHskQqdzRHo1CCPdn3JlN/6dguT1aRpSCT8KKzuXgegrRlbomzs66t
   ccmkB3UzXNZudoN/6FVS2bQwrAkSLhIWkESrUWEwRZoi1OvpVvoIlpThF
   AYqq6VLPEXtIE+oOvgYHJKPulraTxikumANu6m9LMRqjrIs4erlAdckuQ
   TIIBlx10M3xbvhfxAMt+hxLXP9SQk8Uu2w4O2yRdUl3o6EsOjX0NwTD4o
   bGa+IB6+ZZkH5H96akRyxw5pqlQ6WE7rhSLmxC/cTQIL0vofFv9K0QO8H
   T2qpqsuL5v2Hgm+ay3LDQZqa1uXYH+xRo5xUhSOuwtyie/5H14IVhDRi4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="383286060"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="383286060"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 07:43:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="897211695"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="897211695"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 10 Oct 2023 07:41:43 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qqDxD-0000aY-1x;
        Tue, 10 Oct 2023 14:43:23 +0000
Date:   Tue, 10 Oct 2023 22:43:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v2 8/8] LoongArch: Add ORC unwinder support
Message-ID: <202310102212.HoI1aH5d-lkp@intel.com>
References: <1696856590-30298-9-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696856590-30298-9-git-send-email-yangtiezhu@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tiezhu,

kernel test robot noticed the following build errors:

[auto build test ERROR on masahiroy-kbuild/for-next]
[also build test ERROR on masahiroy-kbuild/fixes linus/master v6.6-rc5 next-20231010]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tiezhu-Yang/objtool-LoongArch-Enable-objtool-to-be-built/20231009-210700
base:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git for-next
patch link:    https://lore.kernel.org/r/1696856590-30298-9-git-send-email-yangtiezhu%40loongson.cn
patch subject: [PATCH v2 8/8] LoongArch: Add ORC unwinder support
config: x86_64-randconfig-014-20231010 (https://download.01.org/0day-ci/archive/20231010/202310102212.HoI1aH5d-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231010/202310102212.HoI1aH5d-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310102212.HoI1aH5d-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from scripts/sorttable.c:201:
>> scripts/sorttable.h:96:10: fatal error: asm/orc_types.h: No such file or directory
      96 | #include <asm/orc_types.h>
         |          ^~~~~~~~~~~~~~~~~
   compilation terminated.
   make[3]: *** [scripts/Makefile.host:114: scripts/sorttable] Error 1 shuffle=2318162869
   make[3]: Target 'scripts/' not remade because of errors.
   make[2]: *** [Makefile:1186: scripts] Error 2 shuffle=2318162869
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:234: __sub-make] Error 2 shuffle=2318162869
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:234: __sub-make] Error 2 shuffle=2318162869
   make: Target 'prepare' not remade because of errors.


vim +96 scripts/sorttable.h

a79f248b9b309ebb scripts/sortextable.h David Daney 2012-04-19  93  
57fa1899428538e3 scripts/sorttable.h   Shile Zhang 2019-12-04  94  #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
57fa1899428538e3 scripts/sorttable.h   Shile Zhang 2019-12-04  95  /* ORC unwinder only support X86_64 */
57fa1899428538e3 scripts/sorttable.h   Shile Zhang 2019-12-04 @96  #include <asm/orc_types.h>
57fa1899428538e3 scripts/sorttable.h   Shile Zhang 2019-12-04  97  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
