Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A953578A502
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 06:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjH1Er7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 00:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjH1Er5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 00:47:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35F2125
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 21:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693198074; x=1724734074;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=AML3Z8z7qdGvxJYdKNtfiMw06abAIFsPRuYSYCZd6zI=;
  b=D4Yp6Cx14o+h1s9YtOSQsN2gPdPrQ39b89rm7bjHXY4c66odTF4uoywV
   EtaO+6ZcdlTAhAxlMktriUkP+KJYJXFXLt84bPZZqtDHj3YSsLQN7m8dk
   U3J308JNREQ/TdlKETmNu+2M/dB/XmqPR3n1EJJexh9yJkoZtrg/vDw0U
   BJRgTGSpzLTOt5PE6SzwrLCWP/3kuOGwl1sHbQ8/+MAEvV9KqpOHakh4k
   F9c8U+cWiwwI0wGazES9V6AXcjMx1ytrAIJyabWpbWXU6nsiA+OXKyquI
   7B+25wQ1KP8w9M+Go1h47tuZ8LMZ931bmz3fP24Rxqt/P6beKD6SczJS6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="377746048"
X-IronPort-AV: E=Sophos;i="6.02,206,1688454000"; 
   d="scan'208";a="377746048"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 21:47:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="984740233"
X-IronPort-AV: E=Sophos;i="6.02,206,1688454000"; 
   d="scan'208";a="984740233"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 27 Aug 2023 21:47:52 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qaUAB-0007YV-1x;
        Mon, 28 Aug 2023 04:47:45 +0000
Date:   Mon, 28 Aug 2023 12:47:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Li zeming <zeming@nfschina.com>, tj@kernel.org,
        jiangshanlai@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Li zeming <zeming@nfschina.com>
Subject: Re: [PATCH] kernel/workqueue: =?utf-8?Q?Re?=
 =?utf-8?B?bW92ZSB1bm5lY2Vzc2FyeSDigJgw4oCZ?= values from hash
Message-ID: <202308281239.bDfhnlkw-lkp@intel.com>
References: <20230829181755.3204-1-zeming@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230829181755.3204-1-zeming@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
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
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20230828/202308281239.bDfhnlkw-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230828/202308281239.bDfhnlkw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308281239.bDfhnlkw-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/workqueue.c: In function 'wqattrs_hash':
>> kernel/workqueue.c:3777:16: warning: 'hash' is used uninitialized [-Wuninitialized]
    3777 |         hash = jhash_1word(attrs->nice, hash);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/workqueue.c:3775:13: note: 'hash' was declared here
    3775 |         u32 hash;
         |             ^~~~


vim +/hash +3777 kernel/workqueue.c

5de7a03cac14765 Tejun Heo           2023-08-07  3771  
6ba94429c8e7b87 Frederic Weisbecker 2015-04-02  3772  /* hash value of the content of @attr */
6ba94429c8e7b87 Frederic Weisbecker 2015-04-02  3773  static u32 wqattrs_hash(const struct workqueue_attrs *attrs)
226223ab3c4118d Tejun Heo           2013-03-12  3774  {
dd46423224bbdfa Li zeming           2023-08-30  3775  	u32 hash;
226223ab3c4118d Tejun Heo           2013-03-12  3776  
6ba94429c8e7b87 Frederic Weisbecker 2015-04-02 @3777  	hash = jhash_1word(attrs->nice, hash);
6ba94429c8e7b87 Frederic Weisbecker 2015-04-02  3778  	hash = jhash(cpumask_bits(attrs->cpumask),
6ba94429c8e7b87 Frederic Weisbecker 2015-04-02  3779  		     BITS_TO_LONGS(nr_cpumask_bits) * sizeof(long), hash);
9546b29e4a6ad6e Tejun Heo           2023-08-07  3780  	hash = jhash(cpumask_bits(attrs->__pod_cpumask),
9546b29e4a6ad6e Tejun Heo           2023-08-07  3781  		     BITS_TO_LONGS(nr_cpumask_bits) * sizeof(long), hash);
8639ecebc9b1796 Tejun Heo           2023-08-07  3782  	hash = jhash_1word(attrs->affn_strict, hash);
6ba94429c8e7b87 Frederic Weisbecker 2015-04-02  3783  	return hash;
d55262c4d164759 Tejun Heo           2013-04-01  3784  }
226223ab3c4118d Tejun Heo           2013-03-12  3785  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
