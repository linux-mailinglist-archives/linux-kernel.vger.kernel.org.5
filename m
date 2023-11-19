Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A890D7F0423
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 04:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjKSCwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 21:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjKSCwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 21:52:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E4EC5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 18:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700362323; x=1731898323;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QGTI8e5HrwBVqtHTXqt0DhdvG+n+xpW4HPnMOsNBkOk=;
  b=YD3f2LaEyjaBtHS4nXV+DToNEdPl6eEG5q2Bq5W4w4J4xzDXA4pc8qom
   UC3dvCFYNFDmtuCdRI5VM0znqoG7g0wKFu9Y3SR8yuEv1t1kRNI6HNOtv
   /GQoeQpPiFcx7xhhnJh4qw/Tf5t4DhRfb17RgvXiLDYXaCgNKoDTAM/fD
   pW3EWmgBzfUBKgNIv6cfkwhr4tWOuqR5Im5SgqBMNtTdJNdRls1klYtB4
   zwtgIjpV406pu3xUC0VMNeUvASuDz6e2S5Kv+Vbuc0TGKmApciBQlGUC+
   ul1PCD/4cusYA609H+VNRi12ScVs/Bi/R2f1TLrNL0AsRB0I0GXPfl1ue
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="10129674"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="10129674"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2023 18:52:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="836426935"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="836426935"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 18 Nov 2023 18:52:00 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4Xug-0004Zn-1P;
        Sun, 19 Nov 2023 02:51:58 +0000
Date:   Sun, 19 Nov 2023 10:51:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shaohua Li <shli@fb.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: block/blk-throttle.c:1488:74: warning: 'snprintf' output may be
 truncated before the last format character
Message-ID: <202311191030.CRFJc6T4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b8f1fa2419c19c81bc386a6b350879ba54a573e1
commit: ada75b6e5b2a939401d4919dfaf2f2fc9484f68a blk-throttle: add interface to configure idle time threshold
date:   7 years ago
config: x86_64-randconfig-r031-20230816 (https://download.01.org/0day-ci/archive/20231119/202311191030.CRFJc6T4-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231119/202311191030.CRFJc6T4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311191030.CRFJc6T4-lkp@intel.com/

All warnings (new ones prefixed by >>):

   block/blk-throttle.c:1675:13: warning: 'throtl_tg_is_idle' defined but not used [-Wunused-function]
    1675 | static bool throtl_tg_is_idle(struct throtl_grp *tg)
         |             ^~~~~~~~~~~~~~~~~
   block/blk-throttle.c: In function 'tg_prfill_limit':
>> block/blk-throttle.c:1488:74: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
    1488 |                         snprintf(idle_time, sizeof(idle_time), " idle=%lu",
         |                                                                          ^
   block/blk-throttle.c:1488:25: note: 'snprintf' output between 8 and 27 bytes into a destination of size 26
    1488 |                         snprintf(idle_time, sizeof(idle_time), " idle=%lu",
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1489 |                                 tg->idletime_threshold);
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~


vim +/snprintf +1488 block/blk-throttle.c

  1442	
  1443	static u64 tg_prfill_limit(struct seq_file *sf, struct blkg_policy_data *pd,
  1444				 int off)
  1445	{
  1446		struct throtl_grp *tg = pd_to_tg(pd);
  1447		const char *dname = blkg_dev_name(pd->blkg);
  1448		char bufs[4][21] = { "max", "max", "max", "max" };
  1449		u64 bps_dft;
  1450		unsigned int iops_dft;
  1451		char idle_time[26] = "";
  1452	
  1453		if (!dname)
  1454			return 0;
  1455	
  1456		if (off == LIMIT_LOW) {
  1457			bps_dft = 0;
  1458			iops_dft = 0;
  1459		} else {
  1460			bps_dft = U64_MAX;
  1461			iops_dft = UINT_MAX;
  1462		}
  1463	
  1464		if (tg->bps_conf[READ][off] == bps_dft &&
  1465		    tg->bps_conf[WRITE][off] == bps_dft &&
  1466		    tg->iops_conf[READ][off] == iops_dft &&
  1467		    tg->iops_conf[WRITE][off] == iops_dft &&
  1468		    (off != LIMIT_LOW || tg->idletime_threshold ==
  1469					  tg->td->dft_idletime_threshold))
  1470			return 0;
  1471	
  1472		if (tg->bps_conf[READ][off] != bps_dft)
  1473			snprintf(bufs[0], sizeof(bufs[0]), "%llu",
  1474				tg->bps_conf[READ][off]);
  1475		if (tg->bps_conf[WRITE][off] != bps_dft)
  1476			snprintf(bufs[1], sizeof(bufs[1]), "%llu",
  1477				tg->bps_conf[WRITE][off]);
  1478		if (tg->iops_conf[READ][off] != iops_dft)
  1479			snprintf(bufs[2], sizeof(bufs[2]), "%u",
  1480				tg->iops_conf[READ][off]);
  1481		if (tg->iops_conf[WRITE][off] != iops_dft)
  1482			snprintf(bufs[3], sizeof(bufs[3]), "%u",
  1483				tg->iops_conf[WRITE][off]);
  1484		if (off == LIMIT_LOW) {
  1485			if (tg->idletime_threshold == ULONG_MAX)
  1486				strcpy(idle_time, " idle=max");
  1487			else
> 1488				snprintf(idle_time, sizeof(idle_time), " idle=%lu",
  1489					tg->idletime_threshold);
  1490		}
  1491	
  1492		seq_printf(sf, "%s rbps=%s wbps=%s riops=%s wiops=%s%s\n",
  1493			   dname, bufs[0], bufs[1], bufs[2], bufs[3], idle_time);
  1494		return 0;
  1495	}
  1496	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
