Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1A878A522
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 07:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjH1FUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 01:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjH1FUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 01:20:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E8D10D
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 22:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693200014; x=1724736014;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ZIFzK/X1nhD6KUrdCwhykqKym1A1teP2AZ/Vewk+W1E=;
  b=NbHErfhkCm+irpXEaVcavedJHOAMH7S/gxZAFyDU9j0/UVm8kIW2ncOt
   xDRGqixuA/0Yg2O4yBuNyjPjJlz43DvhAU5LgT7QIqq2CW6fo9t0MS5o3
   DX6nw3Byv69QToaErOqTPOvZewQl0nZAns/emaLBz6C2iZeArY1+3sPpf
   x7QKogrD2/2WMUV/uVOaT5QRdfzmtiqsV8N3bhATPNURg6PIa+E9TBkte
   lRZrnmUSfVpLDHjOPCssLL9uqFCUczP2g7eD1epUjUj47A9+7b76NIS5V
   jEIZqJrVNHvNzF+r4u5ZrQePIoz9nXSqnr6WeVS75ZOzRYngWg4kiy3gB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="373903095"
X-IronPort-AV: E=Sophos;i="6.02,206,1688454000"; 
   d="scan'208";a="373903095"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 22:20:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="881790891"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 27 Aug 2023 22:20:17 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qaUfI-0007ab-10;
        Mon, 28 Aug 2023 05:19:53 +0000
Date:   Mon, 28 Aug 2023 13:19:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Li zeming <zeming@nfschina.com>, tj@kernel.org,
        jiangshanlai@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Li zeming <zeming@nfschina.com>
Subject: Re: [PATCH] kernel/workqueue: =?utf-8?Q?Re?=
 =?utf-8?B?bW92ZSB1bm5lY2Vzc2FyeSDigJgw4oCZ?= values from hash
Message-ID: <202308281313.YHarxg3i-lkp@intel.com>
References: <20230829181755.3204-1-zeming@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230829181755.3204-1-zeming@nfschina.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tj-wq/for-next]
[also build test WARNING on linus/master v6.5 next-20230825]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-zeming/kernel-workqueue-Remove-unnecessary-0-values-from-hash/20230828-095048
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-next
patch link:    https://lore.kernel.org/r/20230829181755.3204-1-zeming%40nfschina.com
patch subject: [PATCH] kernel/workqueue: Remove unnecessary ‘0’ values from hash
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20230828/202308281313.YHarxg3i-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce: (https://download.01.org/0day-ci/archive/20230828/202308281313.YHarxg3i-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308281313.YHarxg3i-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/workqueue.c: In function 'wqattrs_hash':
>> kernel/workqueue.c:3777:7: warning: 'hash' is used uninitialized in this function [-Wuninitialized]
     hash = jhash_1word(attrs->nice, hash);
     ~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/hash +3777 kernel/workqueue.c

5de7a03cac1476 Tejun Heo           2023-08-07  3771  
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  3772  /* hash value of the content of @attr */
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  3773  static u32 wqattrs_hash(const struct workqueue_attrs *attrs)
226223ab3c4118 Tejun Heo           2013-03-12  3774  {
dd46423224bbdf Li zeming           2023-08-30  3775  	u32 hash;
226223ab3c4118 Tejun Heo           2013-03-12  3776  
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02 @3777  	hash = jhash_1word(attrs->nice, hash);
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  3778  	hash = jhash(cpumask_bits(attrs->cpumask),
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  3779  		     BITS_TO_LONGS(nr_cpumask_bits) * sizeof(long), hash);
9546b29e4a6ad6 Tejun Heo           2023-08-07  3780  	hash = jhash(cpumask_bits(attrs->__pod_cpumask),
9546b29e4a6ad6 Tejun Heo           2023-08-07  3781  		     BITS_TO_LONGS(nr_cpumask_bits) * sizeof(long), hash);
8639ecebc9b179 Tejun Heo           2023-08-07  3782  	hash = jhash_1word(attrs->affn_strict, hash);
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  3783  	return hash;
d55262c4d16475 Tejun Heo           2013-04-01  3784  }
226223ab3c4118 Tejun Heo           2013-03-12  3785  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
