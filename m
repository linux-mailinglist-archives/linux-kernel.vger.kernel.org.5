Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3AE75A79C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjGTHSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjGTHSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:18:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C81AFD;
        Thu, 20 Jul 2023 00:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689837485; x=1721373485;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ctwPcolnlChySfEEHvIATfgLhsWOHS1eXrogNw0NAdA=;
  b=IZ7ZBB2PiyrHYCEKFieE2txYzZJdLUw7BQr0l7IuCYqysmWDYd9VDq6G
   XWbi6JpgTMZ5IBmJwglg/3+AaCcKnggUxDSS/pmcOl64YIoAAW3lJUGZp
   NNuleapiBqplY+cl7GVWG3wohHxwPv3G5SdxmNlBHtfxXVTiJd0k1bRBu
   Gxt47CtEsUsFHwmBM2ejGmDRMPQYtbR1CYKaZxIpkR3k478AGOSGJvkRm
   3yDV2vwrGoeYHm9pX+VP2bhKLmLpHa04qRwUPN0rpn6z8NKedpnaeOl5N
   PRP9KHGpl4KefVK5EN3W0HljdvYt0nFgUq72MQlJB74cPnYpI293nJrJF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="370225270"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="370225270"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 00:18:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="724291670"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="724291670"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 20 Jul 2023 00:18:02 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMNvG-0005sT-04;
        Thu, 20 Jul 2023 07:18:02 +0000
Date:   Thu, 20 Jul 2023 15:17:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     sunran001@208suo.com, mchehab@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hv: put parentheses on macros with complex values in
 hyperv.h
Message-ID: <202307201511.TvSDQJLn-lkp@intel.com>
References: <e4b504ab6a1534cd26be777c9cb0bb6a@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4b504ab6a1534cd26be777c9cb0bb6a@208suo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on sailus-media-tree/streams v6.5-rc2 next-20230720]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/sunran001-208suo-com/hv-put-parentheses-on-macros-with-complex-values-in-hyperv-h/20230720-110337
base:   linus/master
patch link:    https://lore.kernel.org/r/e4b504ab6a1534cd26be777c9cb0bb6a%40208suo.com
patch subject: [PATCH] hv: put parentheses on macros with complex values in hyperv.h
config: i386-randconfig-i013-20230720 (https://download.01.org/0day-ci/archive/20230720/202307201511.TvSDQJLn-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230720/202307201511.TvSDQJLn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307201511.TvSDQJLn-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/events/intel/core.c:17:
   In file included from include/linux/kvm_host.h:45:
   In file included from arch/x86/include/asm/kvm_host.h:27:
>> include/linux/hyperv.h:431:37: error: invalid token in macro parameter list
   #define VMPACKET_DATA_START_ADDRESS((__packet)  \
                                       ^
   1 error generated.


vim +431 include/linux/hyperv.h

   430	
 > 431	#define VMPACKET_DATA_START_ADDRESS((__packet)	\
   432		(void *)(((unsigned char *)__packet) +	\
   433		 ((struct vmpacket_descriptor)__packet)->offset8 * 8))
   434	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
