Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAE575A53C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 06:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjGTEyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 00:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjGTEyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 00:54:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06B51FCB;
        Wed, 19 Jul 2023 21:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689828843; x=1721364843;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QiS5bm5Wr54OTl7g03amoZLBDiWU2V5r0ntf9CEySao=;
  b=D2oj5GTfsSWGO/sOpiaUesX3RiLdP8fSPZukWCXcNTm6v5ccVv3Psy9U
   Oe9fItZH37SIcckk/gc5WUF+SMLEnYYFc14K70GVIdG0tcFa4sMa7/LCC
   W4prExLHT4cqz+TvYgFNmclKNElqMOKvpvEWKNoLs8xbQrnonVClVS3wm
   54OpmRSYGSB+4lCJ/DHz8P1MXIgACPRJTPeuW8nbQZJgmuOFaWou3KrCC
   1R4uOqM0WqbDWd6BJPI2UbNwa5AhSaKljRSMT/doYLwLbg9HXuE6MXMYw
   A6UxCP0YLX4Pmf9Dryzfq2MthXPLt1umHvqvzylTUhCw8tSsEuhJR5L5z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="432825891"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="432825891"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 21:54:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="814365862"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="814365862"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Jul 2023 21:54:01 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMLfs-0005m1-1C;
        Thu, 20 Jul 2023 04:54:00 +0000
Date:   Thu, 20 Jul 2023 12:53:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     sunran001@208suo.com, mchehab@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hv: put parentheses on macros with complex values in
 hyperv.h
Message-ID: <202307201238.b9lOd1rf-lkp@intel.com>
References: <e4b504ab6a1534cd26be777c9cb0bb6a@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4b504ab6a1534cd26be777c9cb0bb6a@208suo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on sailus-media-tree/streams v6.5-rc2 next-20230719]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/sunran001-208suo-com/hv-put-parentheses-on-macros-with-complex-values-in-hyperv-h/20230720-110337
base:   linus/master
patch link:    https://lore.kernel.org/r/e4b504ab6a1534cd26be777c9cb0bb6a%40208suo.com
patch subject: [PATCH] hv: put parentheses on macros with complex values in hyperv.h
config: x86_64-buildonly-randconfig-r003-20230720 (https://download.01.org/0day-ci/archive/20230720/202307201238.b9lOd1rf-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230720/202307201238.b9lOd1rf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307201238.b9lOd1rf-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/include/asm/kvm_host.h:27,
                    from include/linux/kvm_host.h:45,
                    from arch/x86/kvm/svm/nested.c:18:
>> include/linux/hyperv.h:431:37: error: expected parameter name, found "("
     431 | #define VMPACKET_DATA_START_ADDRESS((__packet)  \
         |                                     ^


vim +431 include/linux/hyperv.h

   430	
 > 431	#define VMPACKET_DATA_START_ADDRESS((__packet)	\
   432		(void *)(((unsigned char *)__packet) +	\
   433		 ((struct vmpacket_descriptor)__packet)->offset8 * 8))
   434	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
