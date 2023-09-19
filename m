Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A57F7A6627
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjISOG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjISOG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:06:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD11A83
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 07:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695132380; x=1726668380;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9+GvekgfENrYzVidm0lyZ2c5l8kTNlJD6Wn5zKhHpM8=;
  b=BrJMvHIStoA2f1tpICxEycCYTu5tJ9tRyQDnOrFXpofYFHYmU5VM1uHr
   NwSnKom1QTWkwiI62ar3AkWN1oo9tFKaGmjcT4LVvJbc4pxlCOl3rGiPD
   7tvyvo4+02PPqqK/FSMWU7S/xky63P7STLpJmqOsAFtHQdS8+1rZKHETj
   xcTHcEMKWyvX7I5iCSUoM2OtHbOApopWYjIO6qSUpPj2i8hOUa9XYrDpI
   BsS2ZRRI/GF0r2N8/0nM7iUwstM26xQ1qxCT3GOZWyI25bIayfH75IB2h
   vUP9SgREJXxKQSVVHr8z1bjn+ucFRzjfLFIVyefyBP2otLpn/PYHwap0C
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="370265675"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="370265675"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 07:06:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="889510962"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="889510962"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 19 Sep 2023 07:05:31 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qibMk-0007Qa-2F;
        Tue, 19 Sep 2023 14:06:14 +0000
Date:   Tue, 19 Sep 2023 22:05:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Terrell <terrelln@fb.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: ERROR: modpost: "__ld_r13_to_r21_ret" [lib/zstd/zstd_decompress.ko]
 undefined!
Message-ID: <202309192139.AknLkasI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2cf0f715623872823a72e451243bbf555d10d032
commit: 2aa14b1ab2c41a4fe41efae80d58bb77da91f19f zstd: import usptream v1.5.2
date:   11 months ago
config: arc-buildonly-randconfig-r005-20230119 (https://download.01.org/0day-ci/archive/20230919/202309192139.AknLkasI-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230919/202309192139.AknLkasI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309192139.AknLkasI-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: "__st_r13_to_r22" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__st_r13_to_r17" [lib/zstd/zstd_decompress.ko] undefined!
>> ERROR: modpost: "__ld_r13_to_r21_ret" [lib/zstd/zstd_decompress.ko] undefined!
>> ERROR: modpost: "__ld_r13_to_r19_ret" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__ld_r13_to_r22_ret" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__st_r13_to_r25" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__st_r13_to_r24" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__ld_r13_to_r17_ret" [lib/zstd/zstd_decompress.ko] undefined!
>> ERROR: modpost: "__st_r13_to_r21" [lib/zstd/zstd_decompress.ko] undefined!
>> ERROR: modpost: "__st_r13_to_r19" [lib/zstd/zstd_decompress.ko] undefined!
WARNING: modpost: suppressed 6 unresolved symbol warnings because there were too many)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
