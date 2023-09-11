Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C30779AFB3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344299AbjIKVNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237250AbjIKMVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:21:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72E3CDC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 05:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694434871; x=1725970871;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1nwifj3QZPTBhAtia8klKFNb88Tbo5yFt/Vfp+yPm1I=;
  b=CTXcSl4aVpRdTxxa2O5JR1j3QnPvzv9qJSscBl4+nphmR5rxeUF0yub1
   KX78VoqN2rdwd0/gpJdBGSWiUL2r1MlsZ+re7wdqVeyOD+13JeUx3jNqj
   +UFHyfLIQcvB/itr/cR3Fss6SalLiHZ/9NX16bAQx8DKOCuwcG9/MAY5Z
   qa6nh9hGA/HGKn3CtSA50SgryFqF5afContgHmCRTO7WXdokG+yPoQtur
   zUQ4FvJQ4kQOwWhuaNenX13Qx2uPFEqXo34BGDV0devz6hc9mhxm7qqrC
   5PopR8SI4TzgTpRCHGN+5VX6X8TNOcesnEgo9E4yDG2N/mAFVJkeGiupR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="363087620"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="363087620"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 05:21:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="833485284"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="833485284"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Sep 2023 05:21:09 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qffud-0006Ck-2K;
        Mon, 11 Sep 2023 12:21:07 +0000
Date:   Mon, 11 Sep 2023 20:20:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
Subject: kernel/power/swap.c:1570: warning: Function parameter or member
 'snapshot_test' not described in 'swsusp_close'
Message-ID: <202309112011.MJzjBMxT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0bb80ecc33a8fb5a682236443c1e740d5c917d1d
commit: 2736e8eeb0ccdc71d1f4256c9c9a28f58cc43307 block: use the holder as indication for exclusive opens
date:   3 months ago
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20230911/202309112011.MJzjBMxT-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230911/202309112011.MJzjBMxT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309112011.MJzjBMxT-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/power/swap.c:543: warning: Function parameter or member 'handle' not described in 'save_image'
   kernel/power/swap.c:543: warning: Function parameter or member 'snapshot' not described in 'save_image'
   kernel/power/swap.c:543: warning: Function parameter or member 'nr_to_write' not described in 'save_image'
   kernel/power/swap.c:890: warning: Function parameter or member 'nr_pages' not described in 'enough_swap'
   kernel/power/swap.c:1061: warning: Function parameter or member 'handle' not described in 'load_image'
   kernel/power/swap.c:1061: warning: Function parameter or member 'snapshot' not described in 'load_image'
   kernel/power/swap.c:1061: warning: Function parameter or member 'nr_to_read' not described in 'load_image'
   kernel/power/swap.c:1520: warning: Function parameter or member 'snapshot_test' not described in 'swsusp_check'
>> kernel/power/swap.c:1570: warning: Function parameter or member 'snapshot_test' not described in 'swsusp_close'


vim +1570 kernel/power/swap.c

61159a314bca64 Rafael J. Wysocki 2006-03-23  1564  
61159a314bca64 Rafael J. Wysocki 2006-03-23  1565  /**
61159a314bca64 Rafael J. Wysocki 2006-03-23  1566   *	swsusp_close - close swap device.
61159a314bca64 Rafael J. Wysocki 2006-03-23  1567   */
61159a314bca64 Rafael J. Wysocki 2006-03-23  1568  
2736e8eeb0ccdc Christoph Hellwig 2023-06-08  1569  void swsusp_close(bool snapshot_test)
61159a314bca64 Rafael J. Wysocki 2006-03-23 @1570  {
8a0d613fa12e1b Jiri Slaby        2010-05-01  1571  	if (IS_ERR(hib_resume_bdev)) {
64ec72a1ece37d Joe Perches       2017-09-27  1572  		pr_debug("Image device not initialised\n");
61159a314bca64 Rafael J. Wysocki 2006-03-23  1573  		return;
61159a314bca64 Rafael J. Wysocki 2006-03-23  1574  	}
61159a314bca64 Rafael J. Wysocki 2006-03-23  1575  
2736e8eeb0ccdc Christoph Hellwig 2023-06-08  1576  	blkdev_put(hib_resume_bdev, snapshot_test ? &swsusp_holder : NULL);
61159a314bca64 Rafael J. Wysocki 2006-03-23  1577  }
1b29c1643c0d82 Vivek Goyal       2007-05-02  1578  

:::::: The code at line 1570 was first introduced by commit
:::::: 61159a314bca6408320c3173c1282c64f5cdaa76 [PATCH] swsusp: separate swap-writing/reading code

:::::: TO: Rafael J. Wysocki <rjw@sisk.pl>
:::::: CC: Linus Torvalds <torvalds@g5.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
