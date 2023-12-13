Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30984810660
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbjLMARA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235358AbjLMAQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:16:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2909A1739
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 16:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702426576; x=1733962576;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jCwo7htVGdpQGQD8H1W2egMMeA0lgSVeTPb7gUmilwQ=;
  b=UeK2Ydu/d+SB7CKCV6kYJgKUOVohT4Hi8ETBW4nuD+RmwsIyW/J5nhmb
   o+jD3xi3Rh8bqsVKUSXP0iEKkXWh6XTqS7XAxkU6OZQFn+9Clek5NkCgp
   2SeouWstrbdf6eeB8lUJYfJ4f3TuOrJIIy4/MduCxAZfwp796Z10ym1is
   GUpc5cJ5MhyfVBXVIWKMxSfg2bTzJbXlULGT001QhkpyVrXa7gj/p+YV+
   W39p4imDkd1ZKpJzi8fiaiyBA8ODsFPVvnMwfiIR9LEIrZYtT1xg2lVpW
   s8MMEHfIoCqBrXq0tgCnz7+J6vXcrLbJui3i6C+XLWYqnfRoCzaWukBZ0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1968138"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="1968138"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 16:16:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="21727157"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 12 Dec 2023 16:16:13 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDCv5-000Jsp-0z;
        Wed, 13 Dec 2023 00:16:11 +0000
Date:   Wed, 13 Dec 2023 08:15:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: arch/x86/platform/intel-quark/imr_selftest.c:30: warning: Function
 parameter or member '2' not described in '__printf'
Message-ID: <202312130848.I9egksGx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cf52eed70e555e864120cfaf280e979e2a035c66
commit: 9120cf4fd9ae77245ce9137869bcbd16575cc633 x86/platform/intel/quark: Add printf attribute to imr_self_test_result()
date:   7 years ago
config: i386-randconfig-012-20231117 (https://download.01.org/0day-ci/archive/20231213/202312130848.I9egksGx-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231213/202312130848.I9egksGx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312130848.I9egksGx-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:11,
                    from include/asm-generic/bug.h:13,
                    from arch/x86/include/asm/bug.h:35,
                    from include/linux/bug.h:4,
                    from include/linux/mmdebug.h:4,
                    from include/linux/mm.h:8,
                    from arch/x86/platform/intel-quark/imr_selftest.c:17:
   include/linux/log2.h:22:1: warning: ignoring attribute 'noreturn' because it conflicts with attribute 'const' [-Wattributes]
      22 | int ____ilog2_NaN(void);
         | ^~~
>> arch/x86/platform/intel-quark/imr_selftest.c:30: warning: Function parameter or member '2' not described in '__printf'
   arch/x86/platform/intel-quark/imr_selftest.c:30: warning: Function parameter or member '3' not described in '__printf'
>> arch/x86/platform/intel-quark/imr_selftest.c:30: warning: Excess function parameter 'res' description in '__printf'
>> arch/x86/platform/intel-quark/imr_selftest.c:30: warning: Excess function parameter 'fmt' description in '__printf'
   arch/x86/platform/intel-quark/imr_selftest.c:126: warning: Function parameter or member 'imr_self_test_init' not described in 'device_initcall'


vim +30 arch/x86/platform/intel-quark/imr_selftest.c

28a375df16c2b6 Bryan O'Donoghue 2015-01-30  19  
28a375df16c2b6 Bryan O'Donoghue 2015-01-30  20  #define SELFTEST KBUILD_MODNAME ": "
28a375df16c2b6 Bryan O'Donoghue 2015-01-30  21  /**
28a375df16c2b6 Bryan O'Donoghue 2015-01-30  22   * imr_self_test_result - Print result string for self test.
28a375df16c2b6 Bryan O'Donoghue 2015-01-30  23   *
28a375df16c2b6 Bryan O'Donoghue 2015-01-30  24   * @res:	result code - true if test passed false otherwise.
28a375df16c2b6 Bryan O'Donoghue 2015-01-30  25   * @fmt:	format string.
28a375df16c2b6 Bryan O'Donoghue 2015-01-30  26   * ...		variadic argument list.
28a375df16c2b6 Bryan O'Donoghue 2015-01-30  27   */
9120cf4fd9ae77 Nicolas Iooss    2016-12-19  28  static __printf(2, 3)
9120cf4fd9ae77 Nicolas Iooss    2016-12-19  29  void __init imr_self_test_result(int res, const char *fmt, ...)
28a375df16c2b6 Bryan O'Donoghue 2015-01-30 @30  {
28a375df16c2b6 Bryan O'Donoghue 2015-01-30  31  	va_list vlist;
28a375df16c2b6 Bryan O'Donoghue 2015-01-30  32  
28a375df16c2b6 Bryan O'Donoghue 2015-01-30  33  	/* Print pass/fail. */
28a375df16c2b6 Bryan O'Donoghue 2015-01-30  34  	if (res)
28a375df16c2b6 Bryan O'Donoghue 2015-01-30  35  		pr_info(SELFTEST "pass ");
28a375df16c2b6 Bryan O'Donoghue 2015-01-30  36  	else
28a375df16c2b6 Bryan O'Donoghue 2015-01-30  37  		pr_info(SELFTEST "fail ");
28a375df16c2b6 Bryan O'Donoghue 2015-01-30  38  
28a375df16c2b6 Bryan O'Donoghue 2015-01-30  39  	/* Print variable string. */
28a375df16c2b6 Bryan O'Donoghue 2015-01-30  40  	va_start(vlist, fmt);
28a375df16c2b6 Bryan O'Donoghue 2015-01-30  41  	vprintk(fmt, vlist);
28a375df16c2b6 Bryan O'Donoghue 2015-01-30  42  	va_end(vlist);
28a375df16c2b6 Bryan O'Donoghue 2015-01-30  43  
28a375df16c2b6 Bryan O'Donoghue 2015-01-30  44  	/* Optional warning. */
28a375df16c2b6 Bryan O'Donoghue 2015-01-30  45  	WARN(res == 0, "test failed");
28a375df16c2b6 Bryan O'Donoghue 2015-01-30  46  }
28a375df16c2b6 Bryan O'Donoghue 2015-01-30  47  #undef SELFTEST
28a375df16c2b6 Bryan O'Donoghue 2015-01-30  48  

:::::: The code at line 30 was first introduced by commit
:::::: 28a375df16c2b6d01227541f3956568995aa5fda x86/intel/quark: Add Isolated Memory Regions for Quark X1000

:::::: TO: Bryan O'Donoghue <pure.logic@nexus-software.ie>
:::::: CC: Ingo Molnar <mingo@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
