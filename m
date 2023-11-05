Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5943B7E126F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 08:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjKEHQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 02:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjKEHQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 02:16:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD8AFB
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 00:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699168569; x=1730704569;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cLcLuelFCVYvO9mDkJF8DMB0xsKO5rcDEG6g1qqQ8n0=;
  b=LpYfm3ws5Ki68rDJxoAERNWJ6mZg6eZ2cNLfXxp9rnF5DJrAZql+KAA+
   J7c+xdmLf/Z/JvAtINnSrA4LaNwSFzAhDM780PwHgVlRciFP9FYBKshDr
   6IKZGODt46yLHPw3db9x3IaCZ+DB4Om1QxIazmW+bFWqQASAXCwEy4VMA
   9E66SFgsWbfOyh/Muxtv9bGapF0dSusCRvvJIgC/790jFy3VHdIQz/KsK
   NnGP+7TsRFJEP0TpI5PEVefThrmLXL4+Yx0D7yT7YQQPnyfoySChq8dgF
   wCq4S0EGI7E8lPPlAmsHy6VygBfYFFfSP76FV7XRiOiq1dasx2VbnsjLy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="368464975"
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="368464975"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 00:16:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="762013632"
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="762013632"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 05 Nov 2023 00:16:07 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzXMb-00058m-0Y;
        Sun, 05 Nov 2023 07:16:05 +0000
Date:   Sun, 5 Nov 2023 15:15:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Paul Burton <paulburton@kernel.org>
Subject: arch/mips/sgi-ip30/ip30-setup.c:122:13: warning: no previous
 prototype for 'plat_mem_setup'
Message-ID: <202311051519.Wm6XIMdt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aea6bf908d730b01bd264a8821159db9463c111c
commit: 7505576d1c1ac0cfe85fdf90999433dd8b673012 MIPS: add support for SGI Octane (IP30)
date:   4 years ago
config: mips-randconfig-r016-20230221 (https://download.01.org/0day-ci/archive/20231105/202311051519.Wm6XIMdt-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231105/202311051519.Wm6XIMdt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311051519.Wm6XIMdt-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/mips/sgi-ip30/ip30-setup.c:122:13: warning: no previous prototype for 'plat_mem_setup' [-Wmissing-prototypes]
     122 | void __init plat_mem_setup(void)
         |             ^~~~~~~~~~~~~~


vim +/plat_mem_setup +122 arch/mips/sgi-ip30/ip30-setup.c

   118	
   119	/**
   120	 * plat_mem_setup - despite the name, misc setup happens here.
   121	 */
 > 122	void __init plat_mem_setup(void)
   123	{
   124		ip30_mem_init();
   125	
   126		/* XXX: Hard lock on /sbin/init if this flag isn't specified. */
   127		prom_flags |= PROM_FLAG_DONT_FREE_TEMP;
   128	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
