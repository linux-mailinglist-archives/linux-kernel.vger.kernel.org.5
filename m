Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48E67BADAC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 23:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjJEVhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 17:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjJEVhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 17:37:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AE595
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 14:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696541831; x=1728077831;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RUUpuLhJ5XKZ1tuXjOeo39ERh3dlU7kmgjoWLsjBoRs=;
  b=jc0HI00IWcJkkMXmuNjalmKSOXAAtWBRyiD0SlljNNRpMFgPXRN8JRJS
   UjU4+vVHjmau29z0ey0nSkp8Nsh8LUucWVUh1XchcCsyTrupwbpPliUbu
   6XZbKdmzxzuivzSe/VhcjxRAbYA4XdG1lMuR00FSQlaw3RfOPeY8IFU36
   ekhqP9HsnU3ASFwmqJByiF74vM1JCbihAsX0lQCYbBV6gufzWSZMMcUG/
   D/ym/njCJeAAp7sNL2QxmjZILhtyeAT6Zz8BYjG2nePPBtFEuwmDlJOw0
   zZmRgVrOkVvV0plyh8MrnW9O0h8+cldKnLvyuzCKFJJYcL/s0NPg0GxKb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="363904855"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="363904855"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 14:37:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="817776212"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="817776212"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 05 Oct 2023 14:37:08 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qoW1q-000LvQ-15;
        Thu, 05 Oct 2023 21:37:06 +0000
Date:   Fri, 6 Oct 2023 05:36:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     oe-kbuild-all@lists.linux.dev, shr@devkernel.io,
        akpm@linux-foundation.org, david@redhat.com, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 2/4] mm/ksm: add sysfs knobs for advisor
Message-ID: <202310060504.eMl8wb3o-lkp@intel.com>
References: <20231004190249.829015-3-shr@devkernel.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004190249.829015-3-shr@devkernel.io>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

kernel test robot noticed the following build errors:

[auto build test ERROR on 12d04a7bf0da67321229d2bc8b1a7074d65415a9]

url:    https://github.com/intel-lab-lkp/linux/commits/Stefan-Roesch/mm-ksm-add-ksm-advisor/20231005-030402
base:   12d04a7bf0da67321229d2bc8b1a7074d65415a9
patch link:    https://lore.kernel.org/r/20231004190249.829015-3-shr%40devkernel.io
patch subject: [PATCH v1 2/4] mm/ksm: add sysfs knobs for advisor
config: arm-randconfig-001-20231006 (https://download.01.org/0day-ci/archive/20231006/202310060504.eMl8wb3o-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231006/202310060504.eMl8wb3o-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310060504.eMl8wb3o-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: mm/ksm.o: in function `run_advisor':
>> ksm.c:(.text+0x21e8): undefined reference to `__aeabi_ldivmod'
>> arm-linux-gnueabi-ld: ksm.c:(.text+0x2290): undefined reference to `__aeabi_ldivmod'
   arm-linux-gnueabi-ld: ksm.c:(.text+0x22cc): undefined reference to `__aeabi_ldivmod'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
