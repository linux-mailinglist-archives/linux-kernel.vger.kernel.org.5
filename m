Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFEC783879
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 05:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbjHVD1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 23:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjHVD1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 23:27:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9B2193
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 20:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692674851; x=1724210851;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IwJzSR7uDbs6Xber6UHm659PvkD4vRpo0wTgUCJ6Wa8=;
  b=J4tQQoeThMvJUsPftxfdJ6rA6kroru8aiQRgfDqYDD7veRnREEph/uzD
   SPp1tuepc81wlsQZng63jWrT/Q4LwLR14gJLsJJVG0afa7tcHkJUzgwTt
   FasjBF5xAk1bYZLRcU8KBL8fuoyiWPse8X4bA02JdDorS0pDXSCmwgdqu
   RMQbRu8AxmsfMpJ1YeK4ZV20W2AxpE3PnW395UIwDnbql55bUr6YgKOo4
   P5YFdGYhlRi2GNve6YfcoFUfF/FR8fuDdUhiVvv7qE1lzs9oMg8wWoAp4
   6YchdTnOUYzd9Sk7uKOnPZxc1q9vgFO4qSy3Ti1UI/bNOUV7gul843FO1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="377521358"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="377521358"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 20:27:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="909941044"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="909941044"
Received: from lkp-server02.sh.intel.com (HELO 6809aa828f2a) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 21 Aug 2023 20:27:25 -0700
Received: from kbuild by 6809aa828f2a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYI2w-0001IV-2b;
        Tue, 22 Aug 2023 03:27:14 +0000
Date:   Tue, 22 Aug 2023 11:24:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/kernel/idle_64e.o: warning: objtool: .text+0x2c:
 unannotated intra-function call
Message-ID: <202308221112.q0HxcarD-lkp@intel.com>
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

Hi Nicholas,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f7757129e3dea336c407551c98f50057c22bb266
commit: aec0ba7472a7b0c1c293932e7978197f1489a332 powerpc/64: Use -mprofile-kernel for big endian ELFv2 kernels
date:   10 weeks ago
config: powerpc64-randconfig-r036-20230822 (https://download.01.org/0day-ci/archive/20230822/202308221112.q0HxcarD-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230822/202308221112.q0HxcarD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308221112.q0HxcarD-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/powerpc/kernel/idle_64e.o: warning: objtool: .text+0x2c: unannotated intra-function call

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
