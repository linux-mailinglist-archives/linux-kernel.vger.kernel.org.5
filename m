Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEB77E84CA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346003AbjKJUxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344220AbjKJUxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:53:32 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F060EBC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 12:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699649609; x=1731185609;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pG/zny4q8LZPtCPE67yHT7WiAIhIEydSbJARI2VzDQA=;
  b=Af1JvyoGpgDIgKTv+MjY4GAAs80t6CRsih0PeZ8VOBQrXeogyu1iDqN8
   nOrcADymNs+kKB+uhbTz6lptivpEfuW3VEd5L0yx8DhWEn1SQk5ZiXjAU
   zwqo8dJjo2AwEvnTKVLFrbjDiFix6nce0wlG4xEBaT8qwHK/wG/XOVgpN
   MUnQPb766MlM9plyNv/EQJ8sJbcTlo5zZ9xQcZUU5dxnIyTvk7Lq7Nis1
   IvtVcsS7Dt58qjYySGlrfhmgM+ndSL9+nl5JPPrSoqlCNu+TkFzoDssFX
   bv+SDSjHw9ZlR0+t7RnIdiDbNQlw1x9UgY3HQ+dno9EQ8X1Cd3HBoviM7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="387395206"
X-IronPort-AV: E=Sophos;i="6.03,293,1694761200"; 
   d="scan'208";a="387395206"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 12:53:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="767413346"
X-IronPort-AV: E=Sophos;i="6.03,293,1694761200"; 
   d="scan'208";a="767413346"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 10 Nov 2023 12:53:28 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1YVK-0009tI-0e;
        Fri, 10 Nov 2023 20:53:26 +0000
Date:   Sat, 11 Nov 2023 04:52:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: ERROR: start_text address is c000000000000900, should be
 c000000000000200
Message-ID: <202311110405.PqH7IcX7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   89cdf9d556016a54ff6ddd62324aa5ec790c05cc
commit: cf536e185869d4815d506e777bcca6edd9966a6e Makefile: extend 32B aligned debug option to 64B aligned
date:   2 years, 6 months ago
config: powerpc64-buildonly-randconfig-r003-20211118 (https://download.01.org/0day-ci/archive/20231111/202311110405.PqH7IcX7-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231111/202311110405.PqH7IcX7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311110405.PqH7IcX7-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ERROR: start_text address is c000000000000900, should be c000000000000200
   ERROR: try to enable LD_HEAD_STUB_CATCH config option
   ERROR: see comments in arch/powerpc/tools/head_check.sh

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
