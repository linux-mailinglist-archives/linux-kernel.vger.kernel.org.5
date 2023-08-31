Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B413478EEF6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 15:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243933AbjHaNu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 09:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbjHaNu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 09:50:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E341A4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 06:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693489854; x=1725025854;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N85EnEaXiLtQtxjld34WqGm5n58PqJ8msGjdV7kug+w=;
  b=eJsTJHAgfsYx7LYoorPiEFvcJplXJ3l23zW4uyTN+mJZLFb948zAVsrG
   XnOwLUHS/JR4tyyJiC0/fwQmbGxjylX4LYL9Xxfw38Ls2qlmXPE7EpWfJ
   JzgMbAICKZhrAewJVLP6xGDkEUxxypSUsDk1QOtzcyw6TrZVl+AP7FuhH
   v9B/2XEJZR7Zvg3DVIT/Lz8yDRWssr/BwzVHxvf+YQZUNAu4vVNqpiyvh
   +PpFjk/y/VgF6UWuAJm7gb/eIpCCC0tb8Y2skQt3QhovaKMcA4G7+r68t
   GBgUMu0o5zERPZpdKZBFgGb9hT1rx1/8ewGocZz8uhiCnqyjHb+CyfEGI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="375892723"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="375892723"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 06:50:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="733105342"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="733105342"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 31 Aug 2023 06:50:51 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qbi4P-0000Ck-1W;
        Thu, 31 Aug 2023 13:50:49 +0000
Date:   Thu, 31 Aug 2023 21:50:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Naresh Solanki <naresh.solanki@9elements.com>, broonie@kernel.org,
        zev@bewilderbeest.net, Liam Girdwood <lgirdwood@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] regulator: Add uapi header
Message-ID: <202308312120.dESwyZdm-lkp@intel.com>
References: <20230831121412.2359239-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831121412.2359239-1-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naresh,

kernel test robot noticed the following build errors:

[auto build test ERROR on 35d0d2350d774fecf596cfb2fb050559fe5e1850]

url:    https://github.com/intel-lab-lkp/linux/commits/Naresh-Solanki/regulator-userspace-consumer-Add-regulator-event-support/20230831-201619
base:   35d0d2350d774fecf596cfb2fb050559fe5e1850
patch link:    https://lore.kernel.org/r/20230831121412.2359239-1-Naresh.Solanki%409elements.com
patch subject: [PATCH 1/3] regulator: Add uapi header
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230831/202308312120.dESwyZdm-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230831/202308312120.dESwyZdm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308312120.dESwyZdm-lkp@intel.com/

All errors (new ones prefixed by >>):

   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
>> error: include/uapi/linux/regulator.h: missing "WITH Linux-syscall-note" for SPDX-License-Identifier
   make[3]: *** [scripts/Makefile.headersinst:63: usr/include/linux/regulator.h] Error 1
   make[3]: Target '__headers' not remade because of errors.
   make[2]: *** [Makefile:1383: headers] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:234: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:234: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
