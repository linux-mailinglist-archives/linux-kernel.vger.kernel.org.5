Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C40787914
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 22:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243411AbjHXUHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 16:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243410AbjHXUGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 16:06:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695FC170F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 13:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692907604; x=1724443604;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IQfaHD+DuyVsbsv8z1qkTOosiOK8pcjMsTTt+TvyONE=;
  b=W6+buFcjIu5VeAo7PmV5kF3cxV6s5UW2bD02sQYH/CwNO8EIK7lEeOiM
   hOgpcj750/eBheYI5PwrWOiXLf4YeB3FL+dTtu5CBZxIMtQ1QE+AgaX5N
   HgkYMfGM51io7ZK1u7/ToHPXsIqNYfiVY0N43uzlQuhOJ+udvB6YuyXin
   UlA64+rz9wP9v3tw6J4Ndt4ot6mD9vgKWR1A+UdrZYRyNQm2Ovk2X/fjV
   PiNej8x1W2Qf44uDJcWwCNrgyvsnbCGuIiszjxGSpPO7nbgJyRmLEKGhR
   lg3/hR+exCVivRTNt748VaXxaQ83itMXRNgFEPiFLGNP6WgyV7GISFxdt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="373422294"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="373422294"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 13:06:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="1067965430"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="1067965430"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 24 Aug 2023 13:06:25 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZGb2-0002wa-1G;
        Thu, 24 Aug 2023 20:06:24 +0000
Date:   Fri, 25 Aug 2023 04:05:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: test_set_error_stamp: rm
 /kbuild/obj/consumer/parisc-randconfig-r016-20230825/.reduce_errors/drivers-mtd-nand-raw-nand_base.c:internal-compiler-error:in-maybe_record_trace_start-at-dwarf2cfi.cc
Message-ID: <202308250338.Upxr6yeb-lkp@intel.com>
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
head:   b5cc3833f13ace75e26e3f7b51cd7b6da5e9cf17
commit: 43c249ea0b1e10baac4a1264a25d69723ce5d2c2 compiler-gcc.h: remove ancient workaround for gcc PR 58670
date:   1 year, 1 month ago
config: parisc-randconfig-r016-20230825 (https://download.01.org/0day-ci/archive/20230825/202308250338.Upxr6yeb-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230825/202308250338.Upxr6yeb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308250338.Upxr6yeb-lkp@intel.com/

All errors (new ones prefixed by >>):

   during RTL pass: dwarf2
   drivers/mtd/nand/raw/nand_base.c: In function 'nand_do_write_ops':
>> drivers/mtd/nand/raw/nand_base.c:4370:1: internal compiler error: in maybe_record_trace_start, at dwarf2cfi.cc:2539
    4370 | }
         | ^
   0x788517 maybe_record_trace_start
   	/tmp/build-crosstools-gcc-13.2.0-binutils-2.41/gcc/gcc-13.2.0/gcc/dwarf2cfi.cc:2539
   0x788a5a create_trace_edges
   	/tmp/build-crosstools-gcc-13.2.0-binutils-2.41/gcc/gcc-13.2.0/gcc/dwarf2cfi.cc:2687
   0x788d8e scan_trace
   	/tmp/build-crosstools-gcc-13.2.0-binutils-2.41/gcc/gcc-13.2.0/gcc/dwarf2cfi.cc:2911
   0x789127 create_cfi_notes
   	/tmp/build-crosstools-gcc-13.2.0-binutils-2.41/gcc/gcc-13.2.0/gcc/dwarf2cfi.cc:2938
   0x789127 execute_dwarf2_frame
   	/tmp/build-crosstools-gcc-13.2.0-binutils-2.41/gcc/gcc-13.2.0/gcc/dwarf2cfi.cc:3309
   0x789127 execute
   	/tmp/build-crosstools-gcc-13.2.0-binutils-2.41/gcc/gcc-13.2.0/gcc/dwarf2cfi.cc:3799
   Please submit a full bug report, with preprocessed source (by using -freport-bug).
   Please include the complete backtrace with any bug report.
   See <https://gcc.gnu.org/bugs/> for instructions.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
