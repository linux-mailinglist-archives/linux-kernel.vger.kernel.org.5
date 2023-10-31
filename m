Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E449B7DD7E6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 22:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345230AbjJaVtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 17:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344894AbjJaVtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 17:49:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466C7E8;
        Tue, 31 Oct 2023 14:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698788985; x=1730324985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8LmVIWxXOjxqP6+KababCGJaUptAGF2CRhq+6uxRgeo=;
  b=NK8z/4ys8IP8hnl8Mnfo3Yk9EtBc/APfBbVQqBHePTqN+FCVm56uHMsB
   QFyMo9TbWtmMeJTJkGpSNgOfWmkGkTgf4q7Niclj0+D1BxsoiShEyEEG3
   qfxjCOkW7gF47hkX1r4BL6m2gb1K+FA8abmUQPW/9rqt6DIlwg0HVsY4m
   Cks6WBa4JS3OIzFksp8WCBzvFyUJMGrQ0aVw26dtUbbmDAcuUjPf+lBtj
   LUykikYK7kNU3ISndA0v27LEKCbnnNhV+htJbMEc4AEO2gZQgZIOHPJlG
   KYxUbIVvGfKh7lmP/3r0SEIP+VXAjVoDPtu79OOTD1epXxgUxcVGJQ3wn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="454850509"
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="454850509"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 14:49:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="760748095"
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="760748095"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 31 Oct 2023 14:49:42 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qxwcG-0000PK-0e;
        Tue, 31 Oct 2023 21:49:40 +0000
Date:   Wed, 1 Nov 2023 05:49:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 2/3] MIPS: zboot: Add UHI semihosting debug print support
Message-ID: <202311010521.7YJZiVJm-lkp@intel.com>
References: <20231027182650.281405-7-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027182650.281405-7-jiaxun.yang@flygoat.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiaxun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus linus/master v6.6 next-20231030]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiaxun-Yang/MIPS-zboot-Add-UHI-semihosting-debug-print-support/20231028-032719
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20231027182650.281405-7-jiaxun.yang%40flygoat.com
patch subject: [PATCH 2/3] MIPS: zboot: Add UHI semihosting debug print support
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20231101/202311010521.7YJZiVJm-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231101/202311010521.7YJZiVJm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311010521.7YJZiVJm-lkp@intel.com/

Note: functions only called from assembly code should be annotated with the asmlinkage attribute
All warnings (new ones prefixed by >>):

>> arch/mips/boot/compressed/dbg-uhi.c:8:6: warning: no previous prototype for 'puts' [-Wmissing-prototypes]
       8 | void puts(const char *s)
         |      ^~~~


vim +/puts +8 arch/mips/boot/compressed/dbg-uhi.c

     7	
   > 8	void puts(const char *s)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
