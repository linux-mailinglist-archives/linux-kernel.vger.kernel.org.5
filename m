Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B803E7F467D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344142AbjKVMm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344132AbjKVMmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:42:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A61E197
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 04:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700656970; x=1732192970;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xoNT5F/PSZM2K7z4lm0TbxulDLaA68zFM55Mt/TqWdY=;
  b=OLQoC4pIfQYbDhEEe/a/jc9GVtRvY38IAuWdwGiTJUhNox14yuSlwssx
   g25tp85mpn0gaeaOrsiRjmBnnDGShBJeTZ/fe2+pmVvWl3a8UKQ6vvZVP
   uRIQSJZmE0GCji2kdQRsnDFyGvc6RLRzcK5NjQQxYKqa9kt32fneByHwM
   v9OeJmDCOrRvwvkesV1XEALYqVdxQVpd+1ZEHY4jk6I8Gn5Ez5/MPvpBn
   nza2pN3VrkU/SMfxmpKrOYmrO6Wd9tK4vWKDVrz+Li61tVPB7x5mOXvai
   iDPvXRkgDl5RB2yUBDTVlyg7ii8chu9ENs1zs5y90WdIkYL2MlhmJo2O3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="391815116"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="391815116"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 04:42:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="910779570"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="910779570"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Nov 2023 04:42:48 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5mZ4-0000T8-1M;
        Wed, 22 Nov 2023 12:42:46 +0000
Date:   Wed, 22 Nov 2023 20:40:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Naveen N Rao <naveen@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: arch/powerpc/include/asm/ftrace.h:28 ftrace_call_adjust() warn:
 inconsistent indenting
Message-ID: <202311221731.alUwTDIm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c2d5304e6c648ebcf653bace7e51e0e6742e46c8
commit: 0f71dcfb4aef6043da6cc509e7a7f6a3ae87c12d powerpc/ftrace: Add support for -fpatchable-function-entry
date:   3 months ago
config: powerpc-randconfig-r071-20231122 (https://download.01.org/0day-ci/archive/20231122/202311221731.alUwTDIm-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231122/202311221731.alUwTDIm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311221731.alUwTDIm-lkp@intel.com/

smatch warnings:
arch/powerpc/include/asm/ftrace.h:28 ftrace_call_adjust() warn: inconsistent indenting

vim +28 arch/powerpc/include/asm/ftrace.h

8fd6e5a8c81e2e Steven Rostedt 2008-11-14  22  
8fd6e5a8c81e2e Steven Rostedt 2008-11-14  23  static inline unsigned long ftrace_call_adjust(unsigned long addr)
8fd6e5a8c81e2e Steven Rostedt 2008-11-14  24  {
0f71dcfb4aef60 Naveen N Rao   2023-06-19  25  	if (IS_ENABLED(CONFIG_ARCH_USING_PATCHABLE_FUNCTION_ENTRY))
0f71dcfb4aef60 Naveen N Rao   2023-06-19  26  		addr += MCOUNT_INSN_SIZE;
0f71dcfb4aef60 Naveen N Rao   2023-06-19  27  
8fd6e5a8c81e2e Steven Rostedt 2008-11-14 @28         return addr;
8fd6e5a8c81e2e Steven Rostedt 2008-11-14  29  }
8fd6e5a8c81e2e Steven Rostedt 2008-11-14  30  

:::::: The code at line 28 was first introduced by commit
:::::: 8fd6e5a8c81e2e9b912ea33c8425a10729db469b powerpc: ftrace, convert to new dynamic ftrace arch API

:::::: TO: Steven Rostedt <srostedt@redhat.com>
:::::: CC: Steven Rostedt <srostedt@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
