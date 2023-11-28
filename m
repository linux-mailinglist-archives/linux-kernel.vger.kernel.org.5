Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C31C7FC9F5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 23:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345747AbjK1WvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 17:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjK1WvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 17:51:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920DF1998
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 14:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701211873; x=1732747873;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wM3wen/zQ5ZSPTjW+74T4zK4X2a83GPNtOy766NaVcA=;
  b=RUylDj0/lAPettv1dgNsKJsKjOFhXW728GSLGH6rwjbK00jQSZWhaSV3
   RhXE7H8LuSgcG23YqKLp2K32LoyrvkGy0WCayv3tix4Aatzbrmdm1wcXp
   Kcbo/ZPLNIxEw32lmsL5p5x9oHPSkEg50YGWipGzhE3N9m7AqFASXBjZk
   aWE3Z9eFRzlT7Hcs9oNmX5c6LR9+dnSJNcVhsB92zHd/85V24m8E2atMK
   7OyIjBxkYHdXGBhbXDS6GGxv0a5zQhmxWd8yZW34OkrsLPhxVCF7aoRjQ
   RgmereshMeQjgc193V0Hi6s6kU9gdb1t4qBoNEXSuwkTJfpKo80m3US/D
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="6304168"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="6304168"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 14:51:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="839215225"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="839215225"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 28 Nov 2023 14:51:09 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r86v5-0008EB-1M;
        Tue, 28 Nov 2023 22:51:07 +0000
Date:   Wed, 29 Nov 2023 06:50:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wentong Wu <wentong.wu@intel.com>, gregkh@linuxfoundation.org,
        tomas.winkler@intel.com, hdegoede@redhat.com
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        oe-kbuild-all@lists.linux.dev, andriy.shevchenko@linux.intel.com,
        sakari.ailus@linux.intel.com, alexander.usyskin@intel.com,
        zhifeng.wang@intel.com, linux-kernel@vger.kernel.org,
        Wentong Wu <wentong.wu@intel.com>
Subject: Re: [PATCH 2/2] mei: Add MEI hardware support for IVSC device
Message-ID: <202311290342.lucjHsTH-lkp@intel.com>
References: <1701174846-16316-3-git-send-email-wentong.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1701174846-16316-3-git-send-email-wentong.wu@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wentong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.7-rc3 next-20231128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wentong-Wu/mei-Add-transport-driver-for-IVSC-device/20231128-203609
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/1701174846-16316-3-git-send-email-wentong.wu%40intel.com
patch subject: [PATCH 2/2] mei: Add MEI hardware support for IVSC device
config: x86_64-kismet-CONFIG_INTEL_MEI_VSC_HW-CONFIG_INTEL_MEI_VSC-0-0 (https://download.01.org/0day-ci/archive/20231129/202311290342.lucjHsTH-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20231129/202311290342.lucjHsTH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311290342.lucjHsTH-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for INTEL_MEI_VSC_HW when selected by INTEL_MEI_VSC
   
   WARNING: unmet direct dependencies detected for INTEL_MEI_VSC_HW
     Depends on [n]: ACPI [=y] && SPI [=y] && (GPIOLIB [=n] || COMPILE_TEST [=n])
     Selected by [y]:
     - INTEL_MEI_VSC [=y] && INTEL_MEI [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
