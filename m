Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501E47F0575
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 11:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjKSKhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 05:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjKSKhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 05:37:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6578FBC
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 02:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700390268; x=1731926268;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/+JN/zoMx/os+TZ5Z/lVCp+Ia1JUjOmqu4RwK/EqZyc=;
  b=YBOpOQek9NQgXQ2phkSTGv0TE4Mp/xwVWeE11cqB3MN/S1o31RI00O6f
   LJX3fWyvMO9dOh3bVHJeFTfNJKGeYdBCSPYze6kB61iHhs+9kbvsq/g4N
   bwrChSclL/XWGj+ILWJt0Z+YZoY5HzUJUie/OEx07wSkapY59hwbWANLa
   SQ03WsHSDy8fGoGzQJhtcLjeQTTTh9sN2W03XlA8jBCpO0bARrYfyYpFB
   r/l692lv/n4OBUKDhufXyv9vkOHeJNdDz81EiveyQbozkBXPeVkC1Irf6
   CP+TZm+GdH4v929EJqRZcU7nOImDfsN54v+mB+ybT3XatyUSqJaWpg4lP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="477695109"
X-IronPort-AV: E=Sophos;i="6.04,210,1695711600"; 
   d="scan'208";a="477695109"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 02:37:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,210,1695711600"; 
   d="scan'208";a="13899646"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 19 Nov 2023 02:37:47 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4fBP-0004zB-2L;
        Sun, 19 Nov 2023 10:37:43 +0000
Date:   Sun, 19 Nov 2023 18:37:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shaohua Li <shli@fb.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: block/blk-throttle.c:1498:43: warning: '%lu' directive output may be
 truncated writing between 1 and 20 bytes into a region of size 17
Message-ID: <202311191805.T3V1HGnn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   037266a5f7239ead1530266f7d7af153d2a867fa
commit: ec80991d6fc2cb17abfc5427ac1512d2ccd40589 blk-throttle: add interface for per-cgroup target latency
date:   7 years ago
config: x86_64-randconfig-r031-20230816 (https://download.01.org/0day-ci/archive/20231119/202311191805.T3V1HGnn-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231119/202311191805.T3V1HGnn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311191805.T3V1HGnn-lkp@intel.com/

All warnings (new ones prefixed by >>):

   block/blk-throttle.c: In function 'tg_prfill_limit':
   block/blk-throttle.c:1491:74: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
    1491 |                         snprintf(idle_time, sizeof(idle_time), " idle=%lu",
         |                                                                          ^
   block/blk-throttle.c:1491:25: note: 'snprintf' output between 8 and 27 bytes into a destination of size 26
    1491 |                         snprintf(idle_time, sizeof(idle_time), " idle=%lu",
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1492 |                                 tg->idletime_threshold);
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~
>> block/blk-throttle.c:1498:43: warning: '%lu' directive output may be truncated writing between 1 and 20 bytes into a region of size 17 [-Wformat-truncation=]
    1498 |                                 " latency=%lu", tg->latency_target);
         |                                           ^~~
   block/blk-throttle.c:1498:33: note: directive argument in the range [0, 18446744073709551614]
    1498 |                                 " latency=%lu", tg->latency_target);
         |                                 ^~~~~~~~~~~~~~
   block/blk-throttle.c:1497:25: note: 'snprintf' output between 11 and 30 bytes into a destination of size 26
    1497 |                         snprintf(latency_time, sizeof(latency_time),
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1498 |                                 " latency=%lu", tg->latency_target);
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +1498 block/blk-throttle.c

  1443	
  1444	static u64 tg_prfill_limit(struct seq_file *sf, struct blkg_policy_data *pd,
  1445				 int off)
  1446	{
  1447		struct throtl_grp *tg = pd_to_tg(pd);
  1448		const char *dname = blkg_dev_name(pd->blkg);
  1449		char bufs[4][21] = { "max", "max", "max", "max" };
  1450		u64 bps_dft;
  1451		unsigned int iops_dft;
  1452		char idle_time[26] = "";
  1453		char latency_time[26] = "";
  1454	
  1455		if (!dname)
  1456			return 0;
  1457	
  1458		if (off == LIMIT_LOW) {
  1459			bps_dft = 0;
  1460			iops_dft = 0;
  1461		} else {
  1462			bps_dft = U64_MAX;
  1463			iops_dft = UINT_MAX;
  1464		}
  1465	
  1466		if (tg->bps_conf[READ][off] == bps_dft &&
  1467		    tg->bps_conf[WRITE][off] == bps_dft &&
  1468		    tg->iops_conf[READ][off] == iops_dft &&
  1469		    tg->iops_conf[WRITE][off] == iops_dft &&
  1470		    (off != LIMIT_LOW ||
  1471		     (tg->idletime_threshold == tg->td->dft_idletime_threshold &&
  1472		      tg->latency_target == DFL_LATENCY_TARGET)))
  1473			return 0;
  1474	
  1475		if (tg->bps_conf[READ][off] != bps_dft)
  1476			snprintf(bufs[0], sizeof(bufs[0]), "%llu",
  1477				tg->bps_conf[READ][off]);
  1478		if (tg->bps_conf[WRITE][off] != bps_dft)
  1479			snprintf(bufs[1], sizeof(bufs[1]), "%llu",
  1480				tg->bps_conf[WRITE][off]);
  1481		if (tg->iops_conf[READ][off] != iops_dft)
  1482			snprintf(bufs[2], sizeof(bufs[2]), "%u",
  1483				tg->iops_conf[READ][off]);
  1484		if (tg->iops_conf[WRITE][off] != iops_dft)
  1485			snprintf(bufs[3], sizeof(bufs[3]), "%u",
  1486				tg->iops_conf[WRITE][off]);
  1487		if (off == LIMIT_LOW) {
  1488			if (tg->idletime_threshold == ULONG_MAX)
  1489				strcpy(idle_time, " idle=max");
  1490			else
  1491				snprintf(idle_time, sizeof(idle_time), " idle=%lu",
  1492					tg->idletime_threshold);
  1493	
  1494			if (tg->latency_target == ULONG_MAX)
  1495				strcpy(latency_time, " latency=max");
  1496			else
  1497				snprintf(latency_time, sizeof(latency_time),
> 1498					" latency=%lu", tg->latency_target);
  1499		}
  1500	
  1501		seq_printf(sf, "%s rbps=%s wbps=%s riops=%s wiops=%s%s%s\n",
  1502			   dname, bufs[0], bufs[1], bufs[2], bufs[3], idle_time,
  1503			   latency_time);
  1504		return 0;
  1505	}
  1506	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
