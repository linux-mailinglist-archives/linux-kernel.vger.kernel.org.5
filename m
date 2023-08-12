Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888DA779CFB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 05:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbjHLD2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 23:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHLD2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 23:28:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AD7C5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 20:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691810883; x=1723346883;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/Iw+7cPS48OsAsAYSyfUfadF6H6W4Y5iQMbeSYSGwFw=;
  b=TCN7KyEQnn0xzd/MrWL+ojPhkt8GBi3+VsCoZEEDd91VbkCvVpHQaQp8
   j5dO1HOlYTW6YEwjiIiQwlPu6SoN2Rm22gx0BSNSeIKu379V7j048KOg7
   aIHpDVyQQ5IUH9jeATN3Ondf6lgQtAGOFH9kiVVU+Gh8oqkJiCSIetbY6
   qTHPyQk9/mMFoCuJcZGq+OViEMNnDC36mqZLwfFXaY1R2LjAIevBIElCm
   4swIoarMx3YXi95X06eL1CFWUlCX+UX5+KkYVcS/mNzHrMogsbcowXd5O
   b3PhjKw3igXIMq5aBCBVt048DFPEOx3FsvIdyJHAVmScZch97R8aemLt6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="370701154"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="370701154"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 20:28:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="732858418"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="732858418"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 11 Aug 2023 20:28:01 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUfIG-0008EK-2J;
        Sat, 12 Aug 2023 03:28:00 +0000
Date:   Sat, 12 Aug 2023 11:27:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Borislav Petkov (AMD)" <bp@alien8.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: ld.lld: error: ./arch/x86/kernel/vmlinux.lds:193: at least one side
 of the expression must be absolute
Message-ID: <202308121100.YW565NAg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   190bf7b14b0cf3df19c059061be032bd8994a597
commit: fb3bd914b3ec28f5fb697ac55c4846ac2d542855 x86/srso: Add a Speculative RAS Overflow mitigation
date:   2 weeks ago
config: x86_64-randconfig-x011-20230811 (https://download.01.org/0day-ci/archive/20230812/202308121100.YW565NAg-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230812/202308121100.YW565NAg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308121100.YW565NAg-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld.lld: error: ./arch/x86/kernel/vmlinux.lds:34: unable to move location counter backward for: .text
>> ld.lld: error: ./arch/x86/kernel/vmlinux.lds:193: at least one side of the expression must be absolute
   ld.lld: error: ./arch/x86/kernel/vmlinux.lds:192: at least one side of the expression must be absolute
   ld.lld: error: SRSO function pair won't alias
   ld.lld: error: ./arch/x86/kernel/vmlinux.lds:34: unable to move location counter backward for: .text
>> ld.lld: error: ./arch/x86/kernel/vmlinux.lds:193: at least one side of the expression must be absolute
   ld.lld: error: ./arch/x86/kernel/vmlinux.lds:192: at least one side of the expression must be absolute
   ld.lld: error: SRSO function pair won't alias
   ld.lld: error: ./arch/x86/kernel/vmlinux.lds:34: unable to move location counter backward for: .text
>> ld.lld: error: ./arch/x86/kernel/vmlinux.lds:193: at least one side of the expression must be absolute
   ld.lld: error: ./arch/x86/kernel/vmlinux.lds:192: at least one side of the expression must be absolute
   ld.lld: error: SRSO function pair won't alias

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
