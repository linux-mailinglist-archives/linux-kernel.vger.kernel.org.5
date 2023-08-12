Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5CE779D23
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 06:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjHLExO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 00:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjHLExM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 00:53:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DBC1736
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 21:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691815988; x=1723351988;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rizJ4PqVdeBbOLj83uv+7ejLAmRCgZnwdpA1u0ZQkVY=;
  b=dbBmedV8zQ/P7mJl9BvEm9pLPGEiGObSqt5SxGBrR09bPzkpADOezq45
   g8c6lNr9lmNB9ktcR1GzRb+enkJVE72f6YhwBd5/1QBwrdxmpcGBvfY7D
   FTXYWYjespEyBmQ1T8nBkT7Ioh4R4wroFZkKM6eHrIsYjWliLCGJBOotx
   sPFuVj/sN054aZAu+W7D7ufKraGIcqk+YXdI10dgMK6daVKEKTOmH/5Ce
   QdcNqVNWPwJ6Q1A8xLC/ePrx4Dfl4lXuQ+ZJ+nLjKc+oFVm8PqmAUmzmj
   d0SM9SGHSCBp91DZXxZwgCGjATD6WNpH5Qwd4PxaunmCyUG/DOiEGSpJQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="375513437"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="375513437"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 21:53:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="767871956"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="767871956"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 11 Aug 2023 21:53:03 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUgcY-0008Gj-0W;
        Sat, 12 Aug 2023 04:53:02 +0000
Date:   Sat, 12 Aug 2023 12:52:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Cannot find symbol for section 13: .text.release_thread.
Message-ID: <202308121246.0TYkHC1K-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f8de32cc060ba3f63171aaa0e8764d22d8c37978
commit: 2be9880dc87342dc7ae459c9ea5c9ee2a45b33d8 kernel: exit: cleanup release_thread()
date:   11 months ago
config: mips-randconfig-r014-20230811 (https://download.01.org/0day-ci/archive/20230812/202308121246.0TYkHC1K-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230812/202308121246.0TYkHC1K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308121246.0TYkHC1K-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Cannot find symbol for section 13: .text.release_thread.
   kernel/exit.o: failed

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
