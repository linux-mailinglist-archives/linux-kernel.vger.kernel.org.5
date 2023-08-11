Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E99778DCC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbjHKLeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjHKLep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:34:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B7326A6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691753684; x=1723289684;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1rr3yebx3W+iRHCnt97A7V9khEv8xZn0/pa9wqV05YE=;
  b=Cm3elU7eOI7vLNZDwqFsUnRpqX0Sd6z/rhVbI4HEMsB+8+bAWh1aIAqz
   TPcPGsY1nRYHaR8rxS5E7TDlx0XX+M2SWng1A/H8Ax/n80bcxfahbxxc2
   F0tAfZd3PQmKXZD0/unABMI+nyQj1hcyKigLEgHdQpBWmtPXuBB/+ToHJ
   6iOf8ydkz7cEoro+TLba7S7BQzEpzsJnG3BuxsXnUb6Q4TTY0xdVpRBku
   Ku77KX6p9fbrSY64Jp6xVloH1vMEGfoZLfqrN6tFtQVEnoeUc7tEvtnHR
   ibBIvGM+JERHF3Gch9y4qIfnSv3C4c6yKAzVpv65mbZk7VyfyXA+OC2zJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="370553189"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="370553189"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 04:34:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="682505543"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="682505543"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 11 Aug 2023 04:34:41 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUQPg-0007lE-15;
        Fri, 11 Aug 2023 11:34:40 +0000
Date:   Fri, 11 Aug 2023 19:34:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ben Dooks <ben-linux@fluff.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Cannot find symbol for section 17: .text.setup_profiling_timer.
Message-ID: <202308111956.QRc8XJVr-lkp@intel.com>
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
head:   25aa0bebba72b318e71fe205bfd1236550cc9534
commit: 787dbea11a5d6843999ff71a3fb9aa1ed6d5d889 profile: setup_profiling_timer() is moslty not implemented
date:   1 year ago
config: mips-randconfig-r014-20230811 (https://download.01.org/0day-ci/archive/20230811/202308111956.QRc8XJVr-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230811/202308111956.QRc8XJVr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308111956.QRc8XJVr-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Cannot find symbol for section 17: .text.setup_profiling_timer.
   kernel/profile.o: failed

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
