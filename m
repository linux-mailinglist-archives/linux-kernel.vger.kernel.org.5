Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95057CD538
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjJRHI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjJRHI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:08:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FEFB6;
        Wed, 18 Oct 2023 00:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697612905; x=1729148905;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KgSL2A1x9+stQg/irIw9FE4bT7SCFkpCNfVoXiyeoZg=;
  b=KvEx3krSv7pq4NYglneUd/H2nOsJ/ShbCGRnPhPNC3c4JBr+wNSXk+C/
   Is/7f/YnGdxGTHVhS/wm9Dornp6ubEQAnyVaCWhk9pqbiGC44i2aaegcs
   yazcHglUWHo1NOlZpzyoVZo8vi64irSUEGH9bSxB0EWrf+yrclMjSsWZY
   ItWhuYjqhtYeOGQaVtzv77bLEmPYxKi15+X/k37ZdrZWWjh+HrvqukxqD
   xjNS3L+He3jfV0AmiyVymVyQP15yOBqQE1zCGZdTEcBStdkxE22TizDZZ
   iFeFOiWxVR0oYbNPORoOeky+9a2pGq1OFRIs0fz1BG6KpKAyyuWo9Ryjd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="452426789"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="452426789"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 00:08:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="872897877"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="872897877"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 18 Oct 2023 00:08:22 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qt0fD-00003E-2I;
        Wed, 18 Oct 2023 07:08:19 +0000
Date:   Wed, 18 Oct 2023 15:07:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     liuchang_125125@163.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, mark.tao@bayhubtech.com,
        shaper.liu@bayhubtech.com, thomas.hu@bayhubtech.com,
        chevron.li@bayhubtech.com, charl.liu@bayhubtech.com,
        Charl Liu <liuchang_125125@163.com>
Subject: Re: [PATCH 3/9] scsi: bht: card: Add the source files related to
 card initialization
Message-ID: <202310181344.qYDD470Q-lkp@intel.com>
References: <20231013083320.10279-1-liuchang_125125@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013083320.10279-1-liuchang_125125@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 401644852d0b2a278811de38081be23f74b5bb04]

url:    https://github.com/intel-lab-lkp/linux/commits/liuchang_125125-163-com/scsi-Update-Kconfig-and-Makefile-for-supporting-Bayhub-s-SD-MMC-Card-interface-driver/20231017-123349
base:   401644852d0b2a278811de38081be23f74b5bb04
patch link:    https://lore.kernel.org/r/20231013083320.10279-1-liuchang_125125%40163.com
patch subject: [PATCH 3/9] scsi: bht: card: Add the source files related to card initialization
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20231018/202310181344.qYDD470Q-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231018/202310181344.qYDD470Q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310181344.qYDD470Q-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> cc1: warning: /drivers/scsi: No such file or directory [-Wmissing-include-dirs]
   drivers/scsi/bht/card/cardcommon.c:20:10: fatal error: ../include/basic.h: No such file or directory
      20 | #include "../include/basic.h"
         |          ^~~~~~~~~~~~~~~~~~~~
   compilation terminated.
--
>> cc1: warning: /drivers/scsi: No such file or directory [-Wmissing-include-dirs]
   drivers/scsi/bht/card/cardinterface.c:22:10: fatal error: ../include/basic.h: No such file or directory
      22 | #include "../include/basic.h"
         |          ^~~~~~~~~~~~~~~~~~~~
   compilation terminated.
--
>> cc1: warning: /drivers/scsi: No such file or directory [-Wmissing-include-dirs]
   drivers/scsi/bht/card/mmc.c:19:10: fatal error: ../include/basic.h: No such file or directory
      19 | #include "../include/basic.h"
         |          ^~~~~~~~~~~~~~~~~~~~
   compilation terminated.
--
>> cc1: warning: /drivers/scsi: No such file or directory [-Wmissing-include-dirs]
   drivers/scsi/bht/card/sd.c:19:10: fatal error: ../include/basic.h: No such file or directory
      19 | #include "../include/basic.h"
         |          ^~~~~~~~~~~~~~~~~~~~
   compilation terminated.
--
>> cc1: warning: /drivers/scsi: No such file or directory [-Wmissing-include-dirs]
   drivers/scsi/bht/card/thermal.c:20:10: fatal error: ../include/basic.h: No such file or directory
      20 | #include "../include/basic.h"
         |          ^~~~~~~~~~~~~~~~~~~~
   compilation terminated.
--
>> cc1: warning: /drivers/scsi: No such file or directory [-Wmissing-include-dirs]
   drivers/scsi/bht/card/uhs2.c:20:10: fatal error: ../include/basic.h: No such file or directory
      20 | #include "../include/basic.h"
         |          ^~~~~~~~~~~~~~~~~~~~
   compilation terminated.
--
>> cc1: warning: /drivers/scsi: No such file or directory [-Wmissing-include-dirs]
   drivers/scsi/bht/card/card_ddr200_support.c:20:10: fatal error: ../include/basic.h: No such file or directory
      20 | #include "../include/basic.h"
         |          ^~~~~~~~~~~~~~~~~~~~
   compilation terminated.
--
>> cc1: warning: /drivers/scsi: No such file or directory [-Wmissing-include-dirs]
   drivers/scsi/bht/card/output_tuning.c:22:10: fatal error: ../include/basic.h: No such file or directory
      22 | #include "../include/basic.h"
         |          ^~~~~~~~~~~~~~~~~~~~
   compilation terminated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
