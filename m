Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAAF57DAA8A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 03:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjJ2Cly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 22:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ2Clx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 22:41:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E1BC9
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 19:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698547311; x=1730083311;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gJgl0Tbuq1PMUqtQZsw8Ijx0YJdzZNS1T/3zAvMYNg8=;
  b=AHSnGWPWKzJBQovRrejFRGVRGiLaq1VhO8a83DuT+eGN6kq80p8CGtni
   8KJHtDKGO1pSI4MymxzaUPwldqM+1QWTpazyHxkVJsecqa8PYxLcdNXac
   IdoZf+SQsy+udQcQjwZdLVVL3hzJvrdbTsZhwRrhc0tPwMP747SajJ2k/
   HmJ9xvu8RI4eSvjwEagpfb29YY802zF46zGgoVki9N/6eoNPCnbptUhrE
   Cz2+TEQzAAGGQxgM7U1wIOkPWeFrpR+i3vIcTgDCZaHczdbtcMOCpYNCr
   KvLmpw5DLjjXIFs0br2hiHhwrGd0vFewwjkNGeWILvo6kYrgRFj7ANO2k
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10877"; a="390789892"
X-IronPort-AV: E=Sophos;i="6.03,260,1694761200"; 
   d="scan'208";a="390789892"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2023 19:41:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10877"; a="933464643"
X-IronPort-AV: E=Sophos;i="6.03,260,1694761200"; 
   d="scan'208";a="933464643"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Oct 2023 19:41:47 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qwvkG-000CHP-2r;
        Sun, 29 Oct 2023 02:41:44 +0000
Date:   Sun, 29 Oct 2023 10:41:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     York Jasper Niebuhr <yjnworkstation@gmail.com>,
        akpm@linux-foundation.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        York Jasper Niebuhr <yjnworkstation@gmail.com>
Subject: Re: [PATCH] Added empty sys_ememz
Message-ID: <202310291059.qzvihDY2-lkp@intel.com>
References: <20231028204046.11258-1-yjnworkstation@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028204046.11258-1-yjnworkstation@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi York,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on tip/x86/asm linus/master v6.6-rc7]
[cannot apply to arnd-asm-generic/master next-20231027]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/York-Jasper-Niebuhr/Added-empty-sys_ememz/20231029-044215
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231028204046.11258-1-yjnworkstation%40gmail.com
patch subject: [PATCH] Added empty sys_ememz
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231029/202310291059.qzvihDY2-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231029/202310291059.qzvihDY2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310291059.qzvihDY2-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> <stdin>:1573:2: warning: #warning syscall ememz not implemented [-Wcpp]
--
>> <stdin>:1573:2: warning: #warning syscall ememz not implemented [-Wcpp]
--
   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
>> <stdin>:1573:2: warning: #warning syscall ememz not implemented [-Wcpp]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
