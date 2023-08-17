Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFBE77F0D2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 09:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348360AbjHQHBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 03:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348400AbjHQHBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 03:01:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615CF2102
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 00:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692255675; x=1723791675;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GxVSz0+K70n2RiSX2HbYvGXiUp70U70qqszn/+NTkWI=;
  b=jzeNwYDsrlt36MaOkvEgCobiXdlTJNPW0UPwkb36dwsZGZK9FrAclO3L
   9tMi6Om0Y0LUyHO2UFU3VR5YcsCyYNJgPpJiVKUO9suKH7lOL4VUp7w68
   B9pA6vGuv5DrqESxW3xLbnHy3HuaVAGQ38KSkBJGH9rEr5GZub4zsP3SR
   q3s5pwTkUDOp2VkY0pD8/morNcu9i8JDbl8TF0fFe9rZxL0XWzZ+nrqzQ
   8FAHOUSPxchFNOHW4lSFfkAfDP0VY7VleL+TE14wo4m6pUrxMF8DFE1CV
   c0pxC5NnjPwxJ2HfrNQkLOareQyDqz8I65C3rCscDhH0H0L/cY3athsHF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="403711273"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="403711273"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 00:01:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="711421262"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="711421262"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 17 Aug 2023 00:01:11 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWX0H-0000sF-21;
        Thu, 17 Aug 2023 07:01:09 +0000
Date:   Thu, 17 Aug 2023 15:00:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: kernel/power/swap.c:1518: warning: Function parameter or member
 'snapshot_test' not described in 'swsusp_check'
Message-ID: <202308171425.aprr6uan-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
commit: d6545e687271ab27472eebff770f2de6a5f1a464 PM: hibernate: remove the global snapshot_test variable
date:   2 months ago
config: powerpc-randconfig-r023-20230817 (https://download.01.org/0day-ci/archive/20230817/202308171425.aprr6uan-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308171425.aprr6uan-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308171425.aprr6uan-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/power/swap.c:543: warning: Function parameter or member 'handle' not described in 'save_image'
   kernel/power/swap.c:543: warning: Function parameter or member 'snapshot' not described in 'save_image'
   kernel/power/swap.c:543: warning: Function parameter or member 'nr_to_write' not described in 'save_image'
   kernel/power/swap.c:890: warning: Function parameter or member 'nr_pages' not described in 'enough_swap'
   kernel/power/swap.c:1061: warning: Function parameter or member 'handle' not described in 'load_image'
   kernel/power/swap.c:1061: warning: Function parameter or member 'snapshot' not described in 'load_image'
   kernel/power/swap.c:1061: warning: Function parameter or member 'nr_to_read' not described in 'load_image'
>> kernel/power/swap.c:1518: warning: Function parameter or member 'snapshot_test' not described in 'swsusp_check'
   kernel/power/swap.c:1572: warning: Function parameter or member 'mode' not described in 'swsusp_close'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for HOTPLUG_CPU
   Depends on [n]: SMP [=y] && (PPC_PSERIES [=n] || PPC_PMAC [=n] || PPC_POWERNV [=n] || FSL_SOC_BOOKE [=n])
   Selected by [y]:
   - PM_SLEEP_SMP [=y] && SMP [=y] && (ARCH_SUSPEND_POSSIBLE [=y] || ARCH_HIBERNATION_POSSIBLE [=y]) && PM_SLEEP [=y]


vim +1518 kernel/power/swap.c

61159a314bca64 Rafael J. Wysocki 2006-03-23  1512  
61159a314bca64 Rafael J. Wysocki 2006-03-23  1513  /**
61159a314bca64 Rafael J. Wysocki 2006-03-23  1514   *      swsusp_check - Check for swsusp signature in the resume device
61159a314bca64 Rafael J. Wysocki 2006-03-23  1515   */
61159a314bca64 Rafael J. Wysocki 2006-03-23  1516  
d6545e687271ab Christoph Hellwig 2023-05-31  1517  int swsusp_check(bool snapshot_test)
61159a314bca64 Rafael J. Wysocki 2006-03-23 @1518  {
61159a314bca64 Rafael J. Wysocki 2006-03-23  1519  	int error;
39fbef4b0f77f9 Ye Bin            2021-10-13  1520  	void *holder;
5904de0d735bbb Chen Yu           2023-04-14  1521  	fmode_t mode = FMODE_READ;
5904de0d735bbb Chen Yu           2023-04-14  1522  
5904de0d735bbb Chen Yu           2023-04-14  1523  	if (snapshot_test)
5904de0d735bbb Chen Yu           2023-04-14  1524  		mode |= FMODE_EXCL;
61159a314bca64 Rafael J. Wysocki 2006-03-23  1525  
d4d77629953eab Tejun Heo         2010-11-13  1526  	hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device,
0718afd47f70cf Christoph Hellwig 2023-06-01  1527  					    mode, &holder, NULL);
8a0d613fa12e1b Jiri Slaby        2010-05-01  1528  	if (!IS_ERR(hib_resume_bdev)) {
8a0d613fa12e1b Jiri Slaby        2010-05-01  1529  		set_blocksize(hib_resume_bdev, PAGE_SIZE);
3ecb01df3261d3 Jan Beulich       2010-10-26  1530  		clear_page(swsusp_header);
568e34ed7339e3 Bart Van Assche   2022-07-14  1531  		error = hib_submit_io(REQ_OP_READ, swsusp_resume_block,
1b29c1643c0d82 Vivek Goyal       2007-05-02  1532  					swsusp_header, NULL);
9a154d9d95b7b9 Rafael J. Wysocki 2006-12-06  1533  		if (error)
76b57e613f6006 Jiri Slaby        2009-10-07  1534  			goto put;
9a154d9d95b7b9 Rafael J. Wysocki 2006-12-06  1535  
3624eb04c24861 Rafael J. Wysocki 2010-10-04  1536  		if (!memcmp(HIBERNATE_SIG, swsusp_header->sig, 10)) {
1b29c1643c0d82 Vivek Goyal       2007-05-02  1537  			memcpy(swsusp_header->sig, swsusp_header->orig_sig, 10);
61159a314bca64 Rafael J. Wysocki 2006-03-23  1538  			/* Reset swap signature now */
568e34ed7339e3 Bart Van Assche   2022-07-14  1539  			error = hib_submit_io(REQ_OP_WRITE | REQ_SYNC,
162b99e3119767 Mike Christie     2016-06-05  1540  						swsusp_resume_block,
1b29c1643c0d82 Vivek Goyal       2007-05-02  1541  						swsusp_header, NULL);
61159a314bca64 Rafael J. Wysocki 2006-03-23  1542  		} else {
76b57e613f6006 Jiri Slaby        2009-10-07  1543  			error = -EINVAL;
61159a314bca64 Rafael J. Wysocki 2006-03-23  1544  		}
74d9555580c48a David Woodhouse   2021-11-08  1545  		if (!error && swsusp_header->flags & SF_HW_SIG &&
74d9555580c48a David Woodhouse   2021-11-08  1546  		    swsusp_header->hw_sig != swsusp_hardware_signature) {
74d9555580c48a David Woodhouse   2021-11-08  1547  			pr_info("Suspend image hardware signature mismatch (%08x now %08x); aborting resume.\n",
74d9555580c48a David Woodhouse   2021-11-08  1548  				swsusp_header->hw_sig, swsusp_hardware_signature);
74d9555580c48a David Woodhouse   2021-11-08  1549  			error = -EINVAL;
74d9555580c48a David Woodhouse   2021-11-08  1550  		}
76b57e613f6006 Jiri Slaby        2009-10-07  1551  
76b57e613f6006 Jiri Slaby        2009-10-07  1552  put:
61159a314bca64 Rafael J. Wysocki 2006-03-23  1553  		if (error)
5904de0d735bbb Chen Yu           2023-04-14  1554  			blkdev_put(hib_resume_bdev, mode);
61159a314bca64 Rafael J. Wysocki 2006-03-23  1555  		else
64ec72a1ece37d Joe Perches       2017-09-27  1556  			pr_debug("Image signature found, resuming\n");
61159a314bca64 Rafael J. Wysocki 2006-03-23  1557  	} else {
8a0d613fa12e1b Jiri Slaby        2010-05-01  1558  		error = PTR_ERR(hib_resume_bdev);
61159a314bca64 Rafael J. Wysocki 2006-03-23  1559  	}
61159a314bca64 Rafael J. Wysocki 2006-03-23  1560  
61159a314bca64 Rafael J. Wysocki 2006-03-23  1561  	if (error)
64ec72a1ece37d Joe Perches       2017-09-27  1562  		pr_debug("Image not found (code %d)\n", error);
61159a314bca64 Rafael J. Wysocki 2006-03-23  1563  
61159a314bca64 Rafael J. Wysocki 2006-03-23  1564  	return error;
61159a314bca64 Rafael J. Wysocki 2006-03-23  1565  }
61159a314bca64 Rafael J. Wysocki 2006-03-23  1566  

:::::: The code at line 1518 was first introduced by commit
:::::: 61159a314bca6408320c3173c1282c64f5cdaa76 [PATCH] swsusp: separate swap-writing/reading code

:::::: TO: Rafael J. Wysocki <rjw@sisk.pl>
:::::: CC: Linus Torvalds <torvalds@g5.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
