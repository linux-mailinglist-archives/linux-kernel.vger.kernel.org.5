Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D0B7E2F62
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 23:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjKFWEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 17:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjKFWEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 17:04:21 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0596710A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 14:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699308259; x=1730844259;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DHdBm2pLkPhJr9UAZMbl35Z/fyBQIhnPChy3iWSGc0M=;
  b=hz3NY5xGeBQeiFCElE4tIuBppeLdcRNm9G9STYY54Xp+L64jydjhVDlQ
   iqNl7xDekRoMdFMH/pqxsp133XRnDD6Lv8brJmBP4vYvaTrexd/CoQLYI
   lJFPdvFu//CUaplXwVUJ/vXr8CyUUVLO2oqbrkex8fR+CYg27J3FYxLAC
   US7ZbmK4e7gnzjZvW0kYwBHRVzrMQuqZu+VGMjDagdaNOLLxGhJVypVfk
   ZFn/I9QpFn5sR7s6Eb62rpLMe3xEeLxs0tCbrF+VHJWe/W2j8FI13Qbw8
   CgmNp7iRVG0oAAiLz6LIlcLuxj2JrUksrE7kRe2w4IzE+FOTr+TAUXfqS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="379770936"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="379770936"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 14:04:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="3760794"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 06 Nov 2023 14:04:16 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r07he-0006lA-1C;
        Mon, 06 Nov 2023 22:04:14 +0000
Date:   Tue, 7 Nov 2023 06:03:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: kismet: WARNING: unmet direct dependencies detected for
 PINCTRL_SINGLE when selected by ARCH_DAVINCI
Message-ID: <202311070548.0f6XfBrh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d2f51b3516dade79269ff45eae2a7668ae711b25
commit: f962396ce29244d9a64f241481fa73fa370404c3 ARM: davinci: support multiplatform build for ARM v5
date:   4 years, 2 months ago
config: arm-kismet-CONFIG_PINCTRL_SINGLE-CONFIG_ARCH_DAVINCI-0-0 (https://download.01.org/0day-ci/archive/20231107/202311070548.0f6XfBrh-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20231107/202311070548.0f6XfBrh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311070548.0f6XfBrh-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for PINCTRL_SINGLE when selected by ARCH_DAVINCI
   .config:6824:warning: symbol value 'ONFIG_ARCH_MMAP_RND_BITS_MI' invalid for ARCH_MMAP_RND_BITS
   
   WARNING: unmet direct dependencies detected for PINCTRL_SINGLE
     Depends on [n]: PINCTRL [=n] && OF [=y] && HAS_IOMEM [=y]
     Selected by [y]:
     - ARCH_DAVINCI [=y] && ARCH_MULTI_V5 [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
