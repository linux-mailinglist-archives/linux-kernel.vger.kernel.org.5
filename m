Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CF77BCFFD
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 22:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344550AbjJHUIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 16:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjJHUIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 16:08:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9491599
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 13:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696795696; x=1728331696;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SbWbcrrNmeBqA9BQqzmtaXxtcav7MKoPuFe4Z8z/M9w=;
  b=OtGbY/bwYygQqaGWVrkEq9JEH9vm+QcC4g+1tAXpeuy+fSBfZ4LIvayu
   wb0876bC3HlcDzX5KtTP5XoJmdKhFkX32ujaWSngrC+fQEUWfo0yF/qcq
   2WfJgypkxyVwC0C/DbJ4NM+bht+ph6ArM0rzjnkJvCiX1c2xZjFrhffXF
   qY/X36ecgh63oNjoowa6shr/IKs3qnIWbxLQdnEISlDVPNHmW7M9WeZ9J
   Wylvk2Ua8DbNFbkoHjJkAqOkUWSQcKHa48xnl1FrpHlYqMv+n6SEF6v/h
   CwsOg2jw3KEmgzbLXf6AsLqIK8nY4NdR8Fuhm8svbrL9t6cRKPWOyyV4y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="381296767"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="381296767"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 13:08:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="787956763"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="787956763"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 08 Oct 2023 13:08:14 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qpa4S-0005iX-0I;
        Sun, 08 Oct 2023 20:08:12 +0000
Date:   Mon, 9 Oct 2023 04:08:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Karsten Graul <kgraul@linux.ibm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: net/smc/smc_llc.c:40:1: warning: alignment 1 of 'struct smc_llc_hdr'
 is less than 4
Message-ID: <202310090453.06oMLpnk-lkp@intel.com>
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

Hi Karsten,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b9ddbb0cde2adcedda26045cc58f31316a492215
commit: b4ba4652b3f8b7c9bbb5786f8acf4724bdab2196 net/smc: extend LLC layer for SMC-Rv2
date:   2 years ago
config: arm-randconfig-002-20231002 (https://download.01.org/0day-ci/archive/20231009/202310090453.06oMLpnk-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231009/202310090453.06oMLpnk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310090453.06oMLpnk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/gfp.h:6,
                    from include/linux/xarray.h:14,
                    from include/linux/radix-tree.h:19,
                    from include/linux/fs.h:15,
                    from include/linux/highmem.h:5,
                    from include/linux/bvec.h:10,
                    from include/linux/skbuff.h:17,
                    from include/linux/tcp.h:17,
                    from include/net/tcp.h:20,
                    from net/smc/smc_llc.c:13:
   include/linux/mmzone.h: In function '__nr_to_section':
   include/linux/mmzone.h:1349:13: warning: the comparison will always evaluate as 'true' for the address of 'mem_section' will never be NULL [-Waddress]
    1349 |         if (!mem_section[SECTION_NR_TO_ROOT(nr)])
         |             ^
   include/linux/mmzone.h:1335:27: note: 'mem_section' declared here
    1335 | extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
         |                           ^~~~~~~~~~~
   net/smc/smc_llc.c: At top level:
>> net/smc/smc_llc.c:40:1: warning: alignment 1 of 'struct smc_llc_hdr' is less than 4 [-Wpacked-not-aligned]
      40 | } __packed;             /* format defined in
         | ^
   In file included from <command-line>:
   In function 'smc_llc_add_pending_send',
       inlined from 'smc_llc_send_message' at net/smc/smc_llc.c:760:7:
   include/linux/compiler_types.h:322:45: error: call to '__compiletime_assert_569' declared with attribute error: must increase SMC_WR_BUF_SIZE to at least sizeof(struct smc_llc_msg)
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:303:25: note: in definition of macro '__compiletime_assert'
     303 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:322:9: note: in expansion of macro '_compiletime_assert'
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   net/smc/smc_llc.c:409:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     409 |         BUILD_BUG_ON_MSG(
         |         ^~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:322:45: error: call to '__compiletime_assert_570' declared with attribute error: must adapt SMC_WR_TX_SIZE to sizeof(struct smc_llc_msg); if not all smc_wr upper layer protocols use the same message size any more, must start to set link->wr_tx_sges[i].length on each individual smc_wr_tx_send()
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:303:25: note: in definition of macro '__compiletime_assert'
     303 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:322:9: note: in expansion of macro '_compiletime_assert'
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   net/smc/smc_llc.c:412:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     412 |         BUILD_BUG_ON_MSG(
         |         ^~~~~~~~~~~~~~~~
   In function 'smc_llc_add_pending_send',
       inlined from 'smc_llc_send_confirm_rkey' at net/smc/smc_llc.c:492:7:
   include/linux/compiler_types.h:322:45: error: call to '__compiletime_assert_569' declared with attribute error: must increase SMC_WR_BUF_SIZE to at least sizeof(struct smc_llc_msg)
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:303:25: note: in definition of macro '__compiletime_assert'
     303 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:322:9: note: in expansion of macro '_compiletime_assert'
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   net/smc/smc_llc.c:409:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     409 |         BUILD_BUG_ON_MSG(
         |         ^~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:322:45: error: call to '__compiletime_assert_570' declared with attribute error: must adapt SMC_WR_TX_SIZE to sizeof(struct smc_llc_msg); if not all smc_wr upper layer protocols use the same message size any more, must start to set link->wr_tx_sges[i].length on each individual smc_wr_tx_send()
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:303:25: note: in definition of macro '__compiletime_assert'
     303 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:322:9: note: in expansion of macro '_compiletime_assert'
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   net/smc/smc_llc.c:412:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     412 |         BUILD_BUG_ON_MSG(
         |         ^~~~~~~~~~~~~~~~
   In function 'smc_llc_add_pending_send',
       inlined from 'smc_llc_add_link_cont' at net/smc/smc_llc.c:833:7:
   include/linux/compiler_types.h:322:45: error: call to '__compiletime_assert_569' declared with attribute error: must increase SMC_WR_BUF_SIZE to at least sizeof(struct smc_llc_msg)
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:303:25: note: in definition of macro '__compiletime_assert'
     303 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:322:9: note: in expansion of macro '_compiletime_assert'
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   net/smc/smc_llc.c:409:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     409 |         BUILD_BUG_ON_MSG(
         |         ^~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:322:45: error: call to '__compiletime_assert_570' declared with attribute error: must adapt SMC_WR_TX_SIZE to sizeof(struct smc_llc_msg); if not all smc_wr upper layer protocols use the same message size any more, must start to set link->wr_tx_sges[i].length on each individual smc_wr_tx_send()
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:303:25: note: in definition of macro '__compiletime_assert'
     303 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:322:9: note: in expansion of macro '_compiletime_assert'
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   net/smc/smc_llc.c:412:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     412 |         BUILD_BUG_ON_MSG(
         |         ^~~~~~~~~~~~~~~~
   In function 'smc_llc_add_pending_send',


vim +40 net/smc/smc_llc.c

    23	
    24	struct smc_llc_hdr {
    25		struct smc_wr_rx_hdr common;
    26		union {
    27			struct {
    28				u8 length;	/* 44 */
    29		#if defined(__BIG_ENDIAN_BITFIELD)
    30				u8 reserved:4,
    31				   add_link_rej_rsn:4;
    32	#elif defined(__LITTLE_ENDIAN_BITFIELD)
    33				u8 add_link_rej_rsn:4,
    34				   reserved:4;
    35	#endif
    36			};
    37			u16 length_v2;	/* 44 - 8192*/
    38		};
    39		u8 flags;
  > 40	} __packed;		/* format defined in
    41				 * IBM Shared Memory Communications Version 2
    42				 * (https://www.ibm.com/support/pages/node/6326337)
    43				 */
    44	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
