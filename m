Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9A67E177B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 23:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjKEW53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 17:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEW51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 17:57:27 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC58B3
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 14:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699225045; x=1730761045;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=glK1SiwI1UEmmcdUNs3R7jUvO7wXogohjSlz/ZsasnQ=;
  b=hPCexgDYEcIef2pVb7JYwu/lzGERonYj94/QPIQIbbSlELtTwnGRvbXj
   CES23ipRY3c29Vdf0aVoZg9NiuKgEHqbQbKI22uq41PXoIaLvnCxiTziU
   5zS4SmyiaYKEW7Y12+9+8jM8FkEo99gTq/MW41xOHo9rxBe+rDny+P5jT
   5p0H2YakXj3eh+SPpewOJ68LlVCs09wo3ctiqXLB0jcM4oWKwtm0FwERG
   u1OOtqdLcTJJi13K8fo2ADVALPm/pBCnaqE9fjlrouTEFZoWMCqNe34b0
   XCx6r9fceyAk7OkKXwCpjQh/AAeigHHeqThPd5gtJ3QeXgbao7UKfQ9l0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="393080988"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="393080988"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 14:57:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="879264838"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="879264838"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 05 Nov 2023 14:57:22 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzm3U-0005rU-1d;
        Sun, 05 Nov 2023 22:57:20 +0000
Date:   Mon, 6 Nov 2023 06:56:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Serge Ayoun <serge.ayoun@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: arch/x86/kernel/cpu/sgx/main.c:124: warning: Function parameter or
 member 'low' not described in 'sgx_calc_section_metric'
Message-ID: <202311060610.IeqWTTWK-lkp@intel.com>
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
head:   77fa2fbe87fc605c4bfa87dff87be9bfded0e9a3
commit: e7e0545299d8cb0fd6fe3ba50401b7f5c3937362 x86/sgx: Initialize metadata for Enclave Page Cache (EPC) sections
date:   3 years ago
config: x86_64-randconfig-004-20230909 (https://download.01.org/0day-ci/archive/20231106/202311060610.IeqWTTWK-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231106/202311060610.IeqWTTWK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311060610.IeqWTTWK-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/cpu/sgx/main.c:124: warning: Function parameter or member 'low' not described in 'sgx_calc_section_metric'
>> arch/x86/kernel/cpu/sgx/main.c:124: warning: Function parameter or member 'high' not described in 'sgx_calc_section_metric'
>> arch/x86/kernel/cpu/sgx/main.c:124: warning: expecting prototype for A section metric is concatenated in a way that @low bits 12(). Prototype was for sgx_calc_section_metric() instead


vim +124 arch/x86/kernel/cpu/sgx/main.c

   117	
   118	/**
   119	 * A section metric is concatenated in a way that @low bits 12-31 define the
   120	 * bits 12-31 of the metric and @high bits 0-19 define the bits 32-51 of the
   121	 * metric.
   122	 */
   123	static inline u64 __init sgx_calc_section_metric(u64 low, u64 high)
 > 124	{
   125		return (low & GENMASK_ULL(31, 12)) +
   126		       ((high & GENMASK_ULL(19, 0)) << 32);
   127	}
   128	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
