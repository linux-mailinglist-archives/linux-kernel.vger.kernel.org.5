Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E737D596E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 19:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344057AbjJXRI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 13:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344034AbjJXRIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 13:08:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EF8118
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 10:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698167295; x=1729703295;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sM6+O0fzhiFyTcyu7JWPedeSbTHayWTeM/XS3k819T8=;
  b=cHJrV+7+fK4E9GTYkaHcq0bA/T3UWEZhMPNXFOm+x2Ps+Iee7M6DpNQz
   uAq4bTVkfuFOC4zIp+HC38kE2rY4+b3EWK/OPHAK2kcYsqKDYMep2THmh
   cRUbyqlvcrCFHc0YOTHM9qBYBnQHNkRLwNfPf1CTwpk9cXdRw68kPX3Zt
   smF1Jvnxnz1ewwqQoK+a+jUD8vZ+UcLToAKrUURv9qwwd1IbrFTmmc71V
   a0Ssrx2+07+kdm/ohGPiKM5bj0vYZziDwXi2EvZYUAvvjDMEonxu0ZcDM
   80T9PsVuA6C1Ppmyl2ZEgqP4s+nH4kvaT0XbnfvYtYdLUqK43Jmg3A72A
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="453588210"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="453588210"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 10:08:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="6242168"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 24 Oct 2023 10:06:55 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qvKt0-00084B-2u;
        Tue, 24 Oct 2023 17:08:10 +0000
Date:   Wed, 25 Oct 2023 01:08:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Raju Rangoju <Raju.Rangoju@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>
Subject: {standard input}:1101: Error: value of fffffbf6 too large for field
 of 1 byte at 00000412
Message-ID: <202310250050.3uYduLnl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,WEIRD_PORT autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d88520ad73b79e71e3ddf08de335b8520ae41c5c
commit: 07445f3c7ca1cfe490353be52bda91d9e6745ef4 amd-xgbe: Add support for 10 Mbps speed
date:   10 months ago
config: arc-randconfig-r001-20221214 (https://download.01.org/0day-ci/archive/20231025/202310250050.3uYduLnl-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231025/202310250050.3uYduLnl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310250050.3uYduLnl-lkp@intel.com/

All errors (new ones prefixed by >>):

   during RTL pass: final
   drivers/net/ethernet/amd/xgbe/xgbe-mdio.c: In function 'xgbe_change_mode':
   drivers/net/ethernet/amd/xgbe/xgbe-mdio.c:339:1: internal compiler error: in arc_ccfsm_record_condition, at config/arc/arc.cc:5521
     339 | }
         | ^
   0x5b785d arc_ccfsm_record_condition(rtx_def*, bool, rtx_insn*, arc_ccfsm*)
   	/tmp/build-crosstools-gcc-13.2.0-binutils-2.41/gcc/gcc-13.2.0/gcc/config/arc/arc.cc:5521
   0x11def27 output_183
   	/tmp/build-crosstools-gcc-13.2.0-binutils-2.41/gcc/gcc-13.2.0/gcc/config/arc/arc.md:4843
   0x82d6e9 final_scan_insn_1
   	/tmp/build-crosstools-gcc-13.2.0-binutils-2.41/gcc/gcc-13.2.0/gcc/final.cc:2774
   0x82db3b final_scan_insn(rtx_insn*, _IO_FILE*, int, int, int*)
   	/tmp/build-crosstools-gcc-13.2.0-binutils-2.41/gcc/gcc-13.2.0/gcc/final.cc:2887
   0x82ddc5 final_1
   	/tmp/build-crosstools-gcc-13.2.0-binutils-2.41/gcc/gcc-13.2.0/gcc/final.cc:1979
   0x82e5e2 rest_of_handle_final
   	/tmp/build-crosstools-gcc-13.2.0-binutils-2.41/gcc/gcc-13.2.0/gcc/final.cc:4240
   0x82e5e2 execute
   	/tmp/build-crosstools-gcc-13.2.0-binutils-2.41/gcc/gcc-13.2.0/gcc/final.cc:4318
   Please submit a full bug report, with preprocessed source (by using -freport-bug).
   Please include the complete backtrace with any bug report.
   See <https://gcc.gnu.org/bugs/> for instructions.
   {standard input}: Assembler messages:
   {standard input}: Error: open CFI at the end of file; missing .cfi_endproc directive
>> {standard input}:1101: Error: value of fffffbf6 too large for field of 1 byte at 00000412

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
