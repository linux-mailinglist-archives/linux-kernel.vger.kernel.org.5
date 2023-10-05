Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00237BA885
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjJER5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjJER5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:57:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17BE9B
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 10:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696528657; x=1728064657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HoO4PJ5IPDARcTkIkgFnhCks20ntXGOqz45QA7UBmbE=;
  b=ACGFDwCHOmVvE5oWembGI6NKqOYHaxTDw4J8jlzCHFuFKy5FloDaKESq
   Zmr7bDyqi9jCvogBEQu/tURn6zJV/gF1h7ImmIFeoYTiU5j7BZs7zqpjH
   tXuxdSICDN0uGMkTb+ORWj3F0mF6TB0oYn4+v9mCg5AfhW8Qjw0sIEBBe
   QjWScwk0oTzjz1skOiWjZ0zYV3N63Dhfa4PgxqjpxWTvogD4Y0pyxyxZg
   mCSa+31r9cgjPLFELvKvZJbtbb7+2A6wTPSIfONwvm1hJWx4PAiNsILjS
   cAgeVPxMdH6CRMVWMGopJ5y/m2UyJrsvv6hNiwnZof031jDp2CXkijNXP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="373923354"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="373923354"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 10:57:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="745548109"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="745548109"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 05 Oct 2023 10:57:34 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qoSbL-000LkK-2u;
        Thu, 05 Oct 2023 17:57:31 +0000
Date:   Fri, 6 Oct 2023 01:57:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     oe-kbuild-all@lists.linux.dev, shr@devkernel.io,
        akpm@linux-foundation.org, david@redhat.com, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 2/4] mm/ksm: add sysfs knobs for advisor
Message-ID: <202310060119.K002rbE5-lkp@intel.com>
References: <20231004190249.829015-3-shr@devkernel.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004190249.829015-3-shr@devkernel.io>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
config: i386-buildonly-randconfig-002-20231006 (https://download.01.org/0day-ci/archive/20231006/202310060119.K002rbE5-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231006/202310060119.K002rbE5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310060119.K002rbE5-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: mm/ksm.o: in function `scan_get_next_rmap_item':
>> ksm.c:(.text+0x3e45): undefined reference to `__divdi3'
>> ld: ksm.c:(.text+0x3e88): undefined reference to `__divdi3'
   ld: ksm.c:(.text+0x3ed9): undefined reference to `__divdi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
