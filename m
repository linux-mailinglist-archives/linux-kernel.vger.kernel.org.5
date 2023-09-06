Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6A379338B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 04:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236883AbjIFCJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 22:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjIFCJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 22:09:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98174C3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 19:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693966151; x=1725502151;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=umut9XZvu2os+RYk7wYMyVsCLFdDZAkfVH+BHNVrPBM=;
  b=Koe818xyHTVi+OxGk+1YEqPtLJc7M7J12vj23ngNuuwfPmferpu7slL3
   9bMqfnxldC/1I4GZLQo4vDyfQ0uRSxO1MI0PGvzBe43o5wUvzvgI2OeBs
   Yv/Hdos4a/0s/Kh7yaZAeDG+Tt6mLtP4EcTj7RjEl5PRKtBhjD1TxJPxA
   kB9kjBm3fbe6EWw28PlPjEGojRElrNM6FoaK1mhxfDr8YqEqiUtZuV0dR
   PsXqxCsQFUrGv/Vq0LiyQiShgZLZrs2hNqtCfPwD/lkxH9JB+WCvhEmER
   eO8+CCyvURRVS8BGZU1Cn8/5pQSQqV/9xRRZ924Fa451Jcwv055rCpgV6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="440923576"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="440923576"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 19:09:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="776402101"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="776402101"
Received: from lkp-server02.sh.intel.com (HELO e0b2ea88afd5) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 05 Sep 2023 19:09:09 -0700
Received: from kbuild by e0b2ea88afd5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qdhyc-0002LL-2s;
        Wed, 06 Sep 2023 02:09:06 +0000
Date:   Wed, 6 Sep 2023 10:08:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: block/disk-events.c:302: warning: Excess function parameter 'events'
 description in 'disk_force_media_change'
Message-ID: <202309060957.vfl0mUur-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   65d6e954e37872fd9afb5ef3fc0481bb3c2f20f4
commit: ab6860f62bfe329e11e5b5b7295b673c9c3a62d0 block: simplify the disk_force_media_change interface
date:   2 weeks ago
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20230906/202309060957.vfl0mUur-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230906/202309060957.vfl0mUur-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309060957.vfl0mUur-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> block/disk-events.c:302: warning: Excess function parameter 'events' description in 'disk_force_media_change'


vim +302 block/disk-events.c

d5870edfa3afc46 Christoph Hellwig  2021-06-24  291  
e6138dc12de9df1 Matteo Croce       2021-07-13  292  /**
e6138dc12de9df1 Matteo Croce       2021-07-13  293   * disk_force_media_change - force a media change event
e6138dc12de9df1 Matteo Croce       2021-07-13  294   * @disk: the disk which will raise the event
e6138dc12de9df1 Matteo Croce       2021-07-13  295   * @events: the events to raise
e6138dc12de9df1 Matteo Croce       2021-07-13  296   *
ab6860f62bfe329 Christoph Hellwig  2023-08-11  297   * Should be called when the media changes for @disk.  Generates a uevent
ab6860f62bfe329 Christoph Hellwig  2023-08-11  298   * and attempts to free all dentries and inodes and invalidates all block
e6138dc12de9df1 Matteo Croce       2021-07-13  299   * device page cache entries in that case.
e6138dc12de9df1 Matteo Croce       2021-07-13  300   */
ab6860f62bfe329 Christoph Hellwig  2023-08-11  301  void disk_force_media_change(struct gendisk *disk)
e6138dc12de9df1 Matteo Croce       2021-07-13 @302  {
ab6860f62bfe329 Christoph Hellwig  2023-08-11  303  	disk_event_uevent(disk, DISK_EVENT_MEDIA_CHANGE);
b90ecc0379eb7bb Demi Marie Obenour 2023-06-07  304  	inc_diskseq(disk);
e6138dc12de9df1 Matteo Croce       2021-07-13  305  	if (__invalidate_device(disk->part0, true))
e6138dc12de9df1 Matteo Croce       2021-07-13  306  		pr_warn("VFS: busy inodes on changed media %s\n",
e6138dc12de9df1 Matteo Croce       2021-07-13  307  			disk->disk_name);
e6138dc12de9df1 Matteo Croce       2021-07-13  308  	set_bit(GD_NEED_PART_SCAN, &disk->state);
e6138dc12de9df1 Matteo Croce       2021-07-13  309  }
e6138dc12de9df1 Matteo Croce       2021-07-13  310  EXPORT_SYMBOL_GPL(disk_force_media_change);
e6138dc12de9df1 Matteo Croce       2021-07-13  311  

:::::: The code at line 302 was first introduced by commit
:::::: e6138dc12de9df17cbda9c40314d69592855ac5e block: add a helper to raise a media changed event

:::::: TO: Matteo Croce <mcroce@microsoft.com>
:::::: CC: Jens Axboe <axboe@kernel.dk>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
