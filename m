Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67ED7E7313
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345224AbjKIUuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjKIUuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:50:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA214239
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699563011; x=1731099011;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qEkTB2XDUI0FKh91zSZ010xzzkEFlr00Hv21Ko8WQh4=;
  b=Q9Dy2kfGxJEilXLL0LY0BEZoehXtuC6alQoTvJenhcNkSjdp5NVNHTlW
   kXkYEehXOhtNU1jewATBUegupWxye6obtsPqdmYZX7K4uFt0CB11Habn5
   1+p1Y2QLJKHiov7dtOrtOtSrZDG7k0AZSzQnDDAGmnwKjkYaDYMbmAQNt
   mDlVPMC6wrw9HIrq/UZkpoT23l1WQl4vt7jFxgUyznfGfetzC24awnHdr
   EHTPiyb1izoqDNmEmD94xvpk6YWRVGfcIgT4/oL9xxxdkr3QFhQSrP860
   FMUPcTT5Hkhp9XwMOpJkW4cgtzHeRGI6h174+vNmoX8Bus9cEW2OM3T4B
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="370279941"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="370279941"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 12:50:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="792668640"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="792668640"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 09 Nov 2023 12:50:09 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1ByZ-00098g-1c;
        Thu, 09 Nov 2023 20:50:07 +0000
Date:   Fri, 10 Nov 2023 04:49:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zach O'Keefe <zokeefe@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: mm/khugepaged.c:747:25: sparse: sparse: symbol
 'khugepaged_collapse_control' was not declared. Should it be static?
Message-ID: <202311100404.GhXGWRFN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6bc986ab839c844e78a2333a02e55f02c9e57935
commit: 34d6b470ab9cf3a038f9bcd0f8cf09016a2e6fbe mm/khugepaged: add struct collapse_control
date:   1 year, 2 months ago
config: i386-randconfig-062-20230909 (https://download.01.org/0day-ci/archive/20231110/202311100404.GhXGWRFN-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231110/202311100404.GhXGWRFN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311100404.GhXGWRFN-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> mm/khugepaged.c:747:25: sparse: sparse: symbol 'khugepaged_collapse_control' was not declared. Should it be static?

vim +/khugepaged_collapse_control +747 mm/khugepaged.c

   745	
   746	
 > 747	struct collapse_control khugepaged_collapse_control = {
   748		.last_target_node = NUMA_NO_NODE,
   749	};
   750	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
