Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FF0803210
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjLDMDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjLDMD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:03:29 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45951BD5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701691372; x=1733227372;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iap4ZTFSpn/FsRg4pF+EFKebnBz9wjEd5NG/ftOdyvc=;
  b=ZZxJMVYWHXWDONyGG68NYYLBhJEawxFKdL4UWlTt7znXMLFncxw/TYlv
   SMu4y8ic3U4aswFIHQWRSwQpgq41n/FwyYB2ppdnLmnk/cj1B6/m40vKJ
   491TieMXi3Nvw7rtG9QO1ZCZOkE0IGD4QG2rbiIV3ddGQK1sIn6PWJTiS
   7zdsk7XnShZN/eaEfjjuBjn2XPZb1Rn3kagbHHi9/wEDCmd9yAYx98fUs
   bEVifDF8kmRVjt8092m0P09oPKVsOWyRCaAp1GczSNl8o4ZYWN+qeb2y8
   VyOu9+dIdUrtgZIo4IheulvdAw6ixk+VJIRE7EnVb17PdQFLiJbiQUDEQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="373154169"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="373154169"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 04:02:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="1017826172"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="1017826172"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 04 Dec 2023 04:02:50 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rA7ey-0007iA-29;
        Mon, 04 Dec 2023 12:02:48 +0000
Date:   Mon, 4 Dec 2023 20:02:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: pm.c:undefined reference to `i8042_command'
Message-ID: <202312041909.lwhcU35R-lkp@intel.com>
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
head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
commit: 7b4537199a4a8480b8c3ba37a2d44765ce76cd9b kbuild: link symbol CRCs at final link, removing CONFIG_MODULE_REL_CRCS
date:   1 year, 6 months ago
config: mips-randconfig-r001-20211012 (https://download.01.org/0day-ci/archive/20231204/202312041909.lwhcU35R-lkp@intel.com/config)
compiler: mips64el-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231204/202312041909.lwhcU35R-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312041909.lwhcU35R-lkp@intel.com/

All errors (new ones prefixed by >>):

   mips64el-linux-ld: arch/mips/loongson2ef/lemote-2f/pm.o: in function `setup_wakeup_events':
>> pm.c:(.text+0x118): undefined reference to `i8042_command'
>> mips64el-linux-ld: pm.c:(.text+0x154): undefined reference to `i8042_command'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
