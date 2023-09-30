Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894BC7B4088
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 15:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjI3NlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 09:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjI3NlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 09:41:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FB3E6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 06:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696081259; x=1727617259;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+YW7QREcswaXbcYD3cS3q5e9xIzFH5ykJ5V/BWCj1qg=;
  b=DsvmmWKhxp0uypD7EzCShjVf5EaoilAY/AUMP2l3+NzBoic60qngF4Ib
   MAjekjVsbC954ptkYxcKrsJUx1kcFb0/K+vJzGfeTis7aM5l89jvhclrQ
   uQS7fEdBB6KfFBkPGYO7NGekkRGpwuEAkJntMNhGHmr1GBSiIfcZ8xL1S
   mX8mP8MIJEF9atbj9wiH2boLbEfMDDWyIR/YSAl6AD5+ApzoAc2pmlNPG
   roib0bd/ggOC2MSlPDcDPZk9nYLWoW3nSr4eFnCkzZMpMpxV+ZrvuYKUi
   lPUbGMd2EyZTAwOCt/ezSe2LHN13HEfjI/I08tmk1jOVWfNrSQpxXOlSE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="381325985"
X-IronPort-AV: E=Sophos;i="6.03,190,1694761200"; 
   d="scan'208";a="381325985"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2023 06:40:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="743695318"
X-IronPort-AV: E=Sophos;i="6.03,190,1694761200"; 
   d="scan'208";a="743695318"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 30 Sep 2023 06:40:56 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qmaDG-0004B7-0h;
        Sat, 30 Sep 2023 13:40:54 +0000
Date:   Sat, 30 Sep 2023 21:40:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>
Subject: arch/powerpc/kernel/traps.c:1167:19: error: unused function
 '__parse_fpscr'
Message-ID: <202309302131.bsuutuxs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9f3ebbef746f89f860a90ced99a359202ea86fde
commit: ca13c130a43fe3ab625d22ada0a61e5c0b612229 powerpc/4xx: Remove WatchdogHandler() to fix no previous prototype error
date:   6 weeks ago
config: powerpc-kilauea_defconfig (https://download.01.org/0day-ci/archive/20230930/202309302131.bsuutuxs-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230930/202309302131.bsuutuxs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309302131.bsuutuxs-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/powerpc/kernel/traps.c:1167:19: error: unused function '__parse_fpscr' [-Werror,-Wunused-function]
    1167 | static inline int __parse_fpscr(unsigned long fpscr)
         |                   ^
   1 error generated.


vim +/__parse_fpscr +1167 arch/powerpc/kernel/traps.c

14cf11af6cf608 Paul Mackerras    2005-09-26  1166  
5fad293bcbd48d Kumar Gala        2007-02-07 @1167  static inline int __parse_fpscr(unsigned long fpscr)
dc1c1ca3dcd94c Stephen Rothwell  2005-10-01  1168  {
aeb1c0f6ff18f5 Eric W. Biederman 2018-04-17  1169  	int ret = FPE_FLTUNK;
dc1c1ca3dcd94c Stephen Rothwell  2005-10-01  1170  
dc1c1ca3dcd94c Stephen Rothwell  2005-10-01  1171  	/* Invalid operation */
dc1c1ca3dcd94c Stephen Rothwell  2005-10-01  1172  	if ((fpscr & FPSCR_VE) && (fpscr & FPSCR_VX))
5fad293bcbd48d Kumar Gala        2007-02-07  1173  		ret = FPE_FLTINV;
dc1c1ca3dcd94c Stephen Rothwell  2005-10-01  1174  
dc1c1ca3dcd94c Stephen Rothwell  2005-10-01  1175  	/* Overflow */
dc1c1ca3dcd94c Stephen Rothwell  2005-10-01  1176  	else if ((fpscr & FPSCR_OE) && (fpscr & FPSCR_OX))
5fad293bcbd48d Kumar Gala        2007-02-07  1177  		ret = FPE_FLTOVF;
dc1c1ca3dcd94c Stephen Rothwell  2005-10-01  1178  
dc1c1ca3dcd94c Stephen Rothwell  2005-10-01  1179  	/* Underflow */
dc1c1ca3dcd94c Stephen Rothwell  2005-10-01  1180  	else if ((fpscr & FPSCR_UE) && (fpscr & FPSCR_UX))
5fad293bcbd48d Kumar Gala        2007-02-07  1181  		ret = FPE_FLTUND;
dc1c1ca3dcd94c Stephen Rothwell  2005-10-01  1182  
dc1c1ca3dcd94c Stephen Rothwell  2005-10-01  1183  	/* Divide by zero */
dc1c1ca3dcd94c Stephen Rothwell  2005-10-01  1184  	else if ((fpscr & FPSCR_ZE) && (fpscr & FPSCR_ZX))
5fad293bcbd48d Kumar Gala        2007-02-07  1185  		ret = FPE_FLTDIV;
dc1c1ca3dcd94c Stephen Rothwell  2005-10-01  1186  
dc1c1ca3dcd94c Stephen Rothwell  2005-10-01  1187  	/* Inexact result */
dc1c1ca3dcd94c Stephen Rothwell  2005-10-01  1188  	else if ((fpscr & FPSCR_XE) && (fpscr & FPSCR_XX))
5fad293bcbd48d Kumar Gala        2007-02-07  1189  		ret = FPE_FLTRES;
5fad293bcbd48d Kumar Gala        2007-02-07  1190  
5fad293bcbd48d Kumar Gala        2007-02-07  1191  	return ret;
5fad293bcbd48d Kumar Gala        2007-02-07  1192  }
5fad293bcbd48d Kumar Gala        2007-02-07  1193  

:::::: The code at line 1167 was first introduced by commit
:::::: 5fad293bcbd48d9a2370020cf60e4b4a42559b12 [POWERPC] Fixup error handling when emulating a floating point instruction

:::::: TO: Kumar Gala <galak@kernel.crashing.org>
:::::: CC: Kumar Gala <galak@kernel.crashing.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
