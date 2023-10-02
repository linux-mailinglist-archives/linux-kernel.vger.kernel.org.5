Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB507B4AFC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 06:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjJBEOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 00:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJBEOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 00:14:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903A3B8;
        Sun,  1 Oct 2023 21:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696220059; x=1727756059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+SbMEiP/nQq9jUEuPEvZs/+si7/UMTULLo1o542jqPM=;
  b=nB0ksuQASYsg2CHkNkSE/x7Cm4FvcPRBoo5q8w33WGAFGC2KfWkD/Vk3
   zjISeyhtdYVA1uMQcuKZvJ509mqPytBhyRTmmoaGaACj87kv4RBc9aKcI
   N7qn30stK9seQ4c12aq5MNgdBGKwaaKrt82mzYHpOKUbJiTH10K+ievW1
   T1qN311kRvVo2OfBl7oRP27aklXzgOoAkwJT4/JkpEetPAgv9rZLmkHf/
   jSLAmLl5XI1SDhw+mUEs4cPJTRS1LnGsHlQGsGh3q9f7/kHTwS6Gg2+38
   MfexjBRLGBW2qdjDTJNGAOxMpUY6CDDoaDoVYEE0KCWesVPIlTD5e4jDV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="381463401"
X-IronPort-AV: E=Sophos;i="6.03,193,1694761200"; 
   d="scan'208";a="381463401"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2023 21:14:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,193,1694761200"; 
   d="scan'208";a="1407423"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 01 Oct 2023 21:13:37 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qnAJy-0005ki-2q;
        Mon, 02 Oct 2023 04:14:14 +0000
Date:   Mon, 2 Oct 2023 12:13:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: Re: [PATCH 4/4] tty: serial: 8250: Add support for MOXA PCIe boards
 to switch interface between RS422/RS485
Message-ID: <202310021202.xDwDImQv-lkp@intel.com>
References: <20231002015702.30509-5-crescentcy.hsieh@moxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002015702.30509-5-crescentcy.hsieh@moxa.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Crescent,

kernel test robot noticed the following build errors:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on tty/tty-next tty/tty-linus usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.6-rc4 next-20230929]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Crescent-CY-Hsieh/tty-serial-8250-Cleanup-MOXA-configurations-in-8250_pci-c/20231002-095945
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20231002015702.30509-5-crescentcy.hsieh%40moxa.com
patch subject: [PATCH 4/4] tty: serial: 8250: Add support for MOXA PCIe boards to switch interface between RS422/RS485
config: sparc-allnoconfig (https://download.01.org/0day-ci/archive/20231002/202310021202.xDwDImQv-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231002/202310021202.xDwDImQv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310021202.xDwDImQv-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/tty/serial/serial_core.c: In function 'uart_check_rs485_flags':
>> drivers/tty/serial/serial_core.c:1302:60: error: 'SER_RS422_ENALBED' undeclared (first use in this function); did you mean 'SER_RS422_ENABLED'?
    1302 |                                  SER_RS485_TERMINATE_BUS | SER_RS422_ENALBED)
         |                                                            ^~~~~~~~~~~~~~~~~
   drivers/tty/serial/serial_core.c:1309:19: note: in expansion of macro 'SER_RS485_LEGACY_FLAGS'
    1309 |         flags &= ~SER_RS485_LEGACY_FLAGS;
         |                   ^~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/serial_core.c:1302:60: note: each undeclared identifier is reported only once for each function it appears in
    1302 |                                  SER_RS485_TERMINATE_BUS | SER_RS422_ENALBED)
         |                                                            ^~~~~~~~~~~~~~~~~
   drivers/tty/serial/serial_core.c:1309:19: note: in expansion of macro 'SER_RS485_LEGACY_FLAGS'
    1309 |         flags &= ~SER_RS485_LEGACY_FLAGS;
         |                   ^~~~~~~~~~~~~~~~~~~~~~


vim +1302 drivers/tty/serial/serial_core.c

  1299	
  1300	#define SER_RS485_LEGACY_FLAGS	(SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | \
  1301					 SER_RS485_RTS_AFTER_SEND | SER_RS485_RX_DURING_TX | \
> 1302					 SER_RS485_TERMINATE_BUS | SER_RS422_ENALBED)
  1303	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
