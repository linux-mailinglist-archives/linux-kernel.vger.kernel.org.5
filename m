Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38E57F04EF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 10:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjKSJPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 04:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjKSJPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 04:15:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DC211D
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 01:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700385330; x=1731921330;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=flqMUmVuAHhG654sA1Eyl9RYq+1fEgGbOSuC/BvCcC0=;
  b=TYDCPH8QIg46tcQxhQsj3uk3ENbQPqGo0A3u/uTSBwrT/NQJC8mwtFdk
   kGwoIVtElX5vG0PFQmaZWDyapKSrQs1BARr1qwkofiM8r2crS6OdmkiT2
   qvYy97OCSiHGfa/ArcyuHzxgo20CehWfFR14329fFsL9mCfeWRCDBFyM2
   iy2YPhodF57XeVJm5fdENuMapnbsHTu1zIoEIJ1cYu9fCQSDDVz8Yz2jH
   aEdd3fqa8qu3NOTOPbVFMhuXalMdCuz3NUD8anTkZSBK/2cu+lzpB1Ijn
   Kbe4752vM0pn4wRHScNEIioVh3SD8Z6PSYdRCFPQ9N0Sw5B3UpW9Tm8DX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="376519704"
X-IronPort-AV: E=Sophos;i="6.04,210,1695711600"; 
   d="scan'208";a="376519704"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 01:15:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="1013324274"
X-IronPort-AV: E=Sophos;i="6.04,210,1695711600"; 
   d="scan'208";a="1013324274"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 19 Nov 2023 01:15:27 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4dtl-0004tj-29;
        Sun, 19 Nov 2023 09:15:25 +0000
Date:   Sun, 19 Nov 2023 17:14:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>
Subject: clang: warning: argument unused during compilation:
 '-mbranch-protection=none'
Message-ID: <202311191730.HjiepeUh-lkp@intel.com>
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
head:   037266a5f7239ead1530266f7d7af153d2a867fa
commit: 26e7aacb83dfd04330673c5c9ac336560da52bb3 riscv: Allow to downgrade paging mode from the command line
date:   7 months ago
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20231119/202311191730.HjiepeUh-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231119/202311191730.HjiepeUh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311191730.HjiepeUh-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> clang: warning: argument unused during compilation: '-mbranch-protection=none' [-Wunused-command-line-argument]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
