Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E74779E7C8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240384AbjIMMTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240320AbjIMMTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:19:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E6819A8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694607568; x=1726143568;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X1Pn9TpUNoyPdD3j0+oAS9diSSpPQYYq5l0i8RYiScQ=;
  b=VTsSMIPBw9BEQ45IWBzIc/d12pKSt9Skmkr6KXSqY04KUXADFQeB4m6t
   hHUQMEqhPABL7zsqtY2OyQ/yt0G6yXujC92oY5Hr/Zgo/JS41aPZLHZr3
   lcXjlj5/NSHrhAe8uKdSxMg6Q4CsqRa3e4eeqA6eEFbZGaOplhzpzuwtX
   RarUw17ZPX++dcFKUf8ec8j/ESgJNDBu9VWzgejxhzNH3L7fiBisO4Pg/
   sRLhbT6B+9vHb0qAF7sroW9DHGzxhQhdfIjq4V0Zlh5wzUQ2cWMBEXfIm
   XgphjwSOIXaaQRDAcwVBeMcw11NfMShie8sWTfzozGfDsSxgeBwjydtLQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="363673110"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="363673110"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 05:19:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="779169400"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="779169400"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 13 Sep 2023 05:19:25 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgOq3-00002J-0E;
        Wed, 13 Sep 2023 12:19:23 +0000
Date:   Wed, 13 Sep 2023 20:19:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ping Gan <jacky_gam_2001@163.com>, kbusch@kernel.org,
        axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, ping_gan@dell.com,
        jacky_gam_2001@163.com
Subject: Re: [PATCH 2/4] nvmet: Add polling queue task for nvme target
Message-ID: <202309131959.1zH6sjmk-lkp@intel.com>
References: <84d7f188e892b5b0ba251a4601455d7a137075f3.1694592708.git.jacky_gam_2001@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84d7f188e892b5b0ba251a4601455d7a137075f3.1694592708.git.jacky_gam_2001@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ping,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.6-rc1]
[also build test WARNING on linus/master next-20230913]
[cannot apply to hch-configfs/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ping-Gan/nvmet-Add-nvme-target-polling-queue-task-parameters/20230913-164112
base:   v6.6-rc1
patch link:    https://lore.kernel.org/r/84d7f188e892b5b0ba251a4601455d7a137075f3.1694592708.git.jacky_gam_2001%40163.com
patch subject: [PATCH 2/4] nvmet: Add polling queue task for nvme target
config: arc-randconfig-r004-20230913 (https://download.01.org/0day-ci/archive/20230913/202309131959.1zH6sjmk-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230913/202309131959.1zH6sjmk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309131959.1zH6sjmk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/nvme/target/polling-queue-thread.c: In function '__nvmet_pq_ring_do_enqueue':
>> drivers/nvme/target/polling-queue-thread.c:150:37: warning: this statement may fall through [-Wimplicit-fallthrough=]
     150 |                         ring[idx++] = obj_table[i++]; /* fallthrough */ \
         |                         ~~~~~~~~~~~~^~~~~~~~~~~~~~~~
   drivers/nvme/target/polling-queue-thread.c:278:9: note: in expansion of macro 'ENQUEUE_PTRS'
     278 |         ENQUEUE_PTRS(r, &r[1], prod_head, obj_table, n, void *);
         |         ^~~~~~~~~~~~
   drivers/nvme/target/polling-queue-thread.c:151:17: note: here
     151 |                 case 2: \
         |                 ^~~~
   drivers/nvme/target/polling-queue-thread.c:278:9: note: in expansion of macro 'ENQUEUE_PTRS'
     278 |         ENQUEUE_PTRS(r, &r[1], prod_head, obj_table, n, void *);
         |         ^~~~~~~~~~~~
   drivers/nvme/target/polling-queue-thread.c:152:37: warning: this statement may fall through [-Wimplicit-fallthrough=]
     152 |                         ring[idx++] = obj_table[i++]; /* fallthrough */ \
         |                         ~~~~~~~~~~~~^~~~~~~~~~~~~~~~
   drivers/nvme/target/polling-queue-thread.c:278:9: note: in expansion of macro 'ENQUEUE_PTRS'
     278 |         ENQUEUE_PTRS(r, &r[1], prod_head, obj_table, n, void *);
         |         ^~~~~~~~~~~~
   drivers/nvme/target/polling-queue-thread.c:153:17: note: here
     153 |                 case 1: \
         |                 ^~~~
   drivers/nvme/target/polling-queue-thread.c:278:9: note: in expansion of macro 'ENQUEUE_PTRS'
     278 |         ENQUEUE_PTRS(r, &r[1], prod_head, obj_table, n, void *);
         |         ^~~~~~~~~~~~
   drivers/nvme/target/polling-queue-thread.c: In function '__nvmet_pq_ring_do_dequeue':
   drivers/nvme/target/polling-queue-thread.c:181:40: warning: this statement may fall through [-Wimplicit-fallthrough=]
     181 |                         obj_table[i++] = ring[idx++]; /* fallthrough */ \
         |                                        ^
   drivers/nvme/target/polling-queue-thread.c:298:9: note: in expansion of macro 'DEQUEUE_PTRS'
     298 |         DEQUEUE_PTRS(r, &r[1], cons_head, obj_table, n, void *);
         |         ^~~~~~~~~~~~
   drivers/nvme/target/polling-queue-thread.c:182:17: note: here
     182 |                 case 2: \
         |                 ^~~~
   drivers/nvme/target/polling-queue-thread.c:298:9: note: in expansion of macro 'DEQUEUE_PTRS'
     298 |         DEQUEUE_PTRS(r, &r[1], cons_head, obj_table, n, void *);
         |         ^~~~~~~~~~~~
   drivers/nvme/target/polling-queue-thread.c:183:40: warning: this statement may fall through [-Wimplicit-fallthrough=]
     183 |                         obj_table[i++] = ring[idx++]; /* fallthrough */ \
         |                                        ^
   drivers/nvme/target/polling-queue-thread.c:298:9: note: in expansion of macro 'DEQUEUE_PTRS'
     298 |         DEQUEUE_PTRS(r, &r[1], cons_head, obj_table, n, void *);
         |         ^~~~~~~~~~~~
   drivers/nvme/target/polling-queue-thread.c:184:17: note: here
     184 |                 case 1: \
         |                 ^~~~
   drivers/nvme/target/polling-queue-thread.c:298:9: note: in expansion of macro 'DEQUEUE_PTRS'
     298 |         DEQUEUE_PTRS(r, &r[1], cons_head, obj_table, n, void *);
         |         ^~~~~~~~~~~~


vim +150 drivers/nvme/target/polling-queue-thread.c

   131	
   132	//below is derived from FreeBSD's bufring.h
   133	/* the actual enqueue of pointers on the ring.
   134	 * Placed here since identical code needed in both
   135	 * single and multi producer enqueue functions */
   136	#define ENQUEUE_PTRS(r, ring_start, prod_head, obj_table, n, obj_type) do { \
   137		unsigned int i; \
   138		const u32 size = (r)->size; \
   139		u32 idx = prod_head & (r)->mask; \
   140		obj_type *ring = (obj_type *)ring_start; \
   141		if (likely(idx + n < size)) { \
   142			for (i = 0; i < (n & ((~(unsigned)0x3))); i += 4, idx += 4) { \
   143				ring[idx] = obj_table[i]; \
   144				ring[idx+1] = obj_table[i+1]; \
   145				ring[idx+2] = obj_table[i+2]; \
   146				ring[idx+3] = obj_table[i+3]; \
   147			} \
   148			switch (n & 0x3) { \
   149			case 3: \
 > 150				ring[idx++] = obj_table[i++]; /* fallthrough */ \
   151			case 2: \
   152				ring[idx++] = obj_table[i++]; /* fallthrough */ \
   153			case 1: \
   154				ring[idx++] = obj_table[i++]; \
   155			} \
   156		} else { \
   157			for (i = 0; idx < size; i++, idx++)\
   158				ring[idx] = obj_table[i]; \
   159			for (idx = 0; i < n; i++, idx++) \
   160				ring[idx] = obj_table[i]; \
   161		} \
   162	} while (0)
   163	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
