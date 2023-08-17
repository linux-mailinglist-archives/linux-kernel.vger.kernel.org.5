Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86FD77F54E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350259AbjHQLcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350364AbjHQLcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:32:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D91BE4F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 04:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692271918; x=1723807918;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=iDi416exc+zRn2LxZA9/Yqx76xEWKY7ALPHcrARbaRM=;
  b=S7ICn+/10yW5DD2jrkR0LhDzlM7Nb5T6NisAsHRD6O+UIOU4LRD3GFz5
   TDEp94w8xfzaOScSB0Nk/329jZEQjorHzcHyuIRXpY6HMwM3MRbtI5Vwx
   sPr5W/oXLVks8LNjki75WHN1fqup+2/uRHFxJoPF0izZDTa8CLMJcpwDB
   yIHqzXTesNL83WdSi9jPAfn7WxeoPX/gj4DoNA4zGpblpC9+9K1Sca42y
   1N4R+fcxT8HNyf2BNZHWV4ApBLl4wBL+45vYh7Kp8C+Y/52zquzExwEsl
   itjacPeWalbOk6re1xS0O57R+LpQNW7nMkYoR8plVL75nTwGhD8xvj4Qz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="459140012"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="459140012"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 04:31:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="908374592"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="908374592"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 17 Aug 2023 04:31:46 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWbE9-00015a-1x;
        Thu, 17 Aug 2023 11:31:45 +0000
Date:   Thu, 17 Aug 2023 19:30:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph =?iso-8859-1?Q?B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: drivers/block/drbd/drbd_actlog.c:1015: warning: Function parameter
 or member 'peer_device' not described in 'drbd_try_rs_begin_io'
Message-ID: <202308171900.BavnPGx1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
commit: 0d11f3cf279c5ad20a41f29242f170ba3c02f2da drbd: Pass a peer device to the resync and online verify functions
date:   5 months ago
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230817/202308171900.BavnPGx1-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308171900.BavnPGx1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308171900.BavnPGx1-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/block/drbd/drbd_actlog.c:1015: warning: Function parameter or member 'peer_device' not described in 'drbd_try_rs_begin_io'
>> drivers/block/drbd/drbd_actlog.c:1015: warning: Excess function parameter 'device' description in 'drbd_try_rs_begin_io'


vim +1015 drivers/block/drbd/drbd_actlog.c

b411b3637fa71f Philipp Reisner      2009-09-25  1004  
b411b3637fa71f Philipp Reisner      2009-09-25  1005  /**
b411b3637fa71f Philipp Reisner      2009-09-25  1006   * drbd_try_rs_begin_io() - Gets an extent in the resync LRU cache, does not sleep
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  1007   * @device:	DRBD device.
b411b3637fa71f Philipp Reisner      2009-09-25  1008   * @sector:	The sector number.
b411b3637fa71f Philipp Reisner      2009-09-25  1009   *
b411b3637fa71f Philipp Reisner      2009-09-25  1010   * Gets an extent in the resync LRU cache, sets it to BME_NO_WRITES, then
b411b3637fa71f Philipp Reisner      2009-09-25  1011   * tries to set it to BME_LOCKED. Returns 0 upon success, and -EAGAIN
b411b3637fa71f Philipp Reisner      2009-09-25  1012   * if there is still application IO going on in this area.
b411b3637fa71f Philipp Reisner      2009-09-25  1013   */
0d11f3cf279c5a Christoph Böhmwalder 2023-03-30  1014  int drbd_try_rs_begin_io(struct drbd_peer_device *peer_device, sector_t sector)
b411b3637fa71f Philipp Reisner      2009-09-25 @1015  {
0d11f3cf279c5a Christoph Böhmwalder 2023-03-30  1016  	struct drbd_device *device = peer_device->device;
b411b3637fa71f Philipp Reisner      2009-09-25  1017  	unsigned int enr = BM_SECT_TO_EXT(sector);
b411b3637fa71f Philipp Reisner      2009-09-25  1018  	const unsigned int al_enr = enr*AL_EXT_PER_BM_SECT;
b411b3637fa71f Philipp Reisner      2009-09-25  1019  	struct lc_element *e;
b411b3637fa71f Philipp Reisner      2009-09-25  1020  	struct bm_extent *bm_ext;
b411b3637fa71f Philipp Reisner      2009-09-25  1021  	int i;
0d11f3cf279c5a Christoph Böhmwalder 2023-03-30  1022  	bool throttle = drbd_rs_should_slow_down(peer_device, sector, true);
ad3fee790088d3 Lars Ellenberg       2013-12-20  1023  
ad3fee790088d3 Lars Ellenberg       2013-12-20  1024  	/* If we need to throttle, a half-locked (only marked BME_NO_WRITES,
ad3fee790088d3 Lars Ellenberg       2013-12-20  1025  	 * not yet BME_LOCKED) extent needs to be kicked out explicitly if we
ad3fee790088d3 Lars Ellenberg       2013-12-20  1026  	 * need to throttle. There is at most one such half-locked extent,
ad3fee790088d3 Lars Ellenberg       2013-12-20  1027  	 * which is remembered in resync_wenr. */
ad3fee790088d3 Lars Ellenberg       2013-12-20  1028  
ad3fee790088d3 Lars Ellenberg       2013-12-20  1029  	if (throttle && device->resync_wenr != enr)
ad3fee790088d3 Lars Ellenberg       2013-12-20  1030  		return -EAGAIN;
b411b3637fa71f Philipp Reisner      2009-09-25  1031  
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  1032  	spin_lock_irq(&device->al_lock);
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  1033  	if (device->resync_wenr != LC_FREE && device->resync_wenr != enr) {
b411b3637fa71f Philipp Reisner      2009-09-25  1034  		/* in case you have very heavy scattered io, it may
b411b3637fa71f Philipp Reisner      2009-09-25  1035  		 * stall the syncer undefined if we give up the ref count
b411b3637fa71f Philipp Reisner      2009-09-25  1036  		 * when we try again and requeue.
b411b3637fa71f Philipp Reisner      2009-09-25  1037  		 *
b411b3637fa71f Philipp Reisner      2009-09-25  1038  		 * if we don't give up the refcount, but the next time
b411b3637fa71f Philipp Reisner      2009-09-25  1039  		 * we are scheduled this extent has been "synced" by new
b411b3637fa71f Philipp Reisner      2009-09-25  1040  		 * application writes, we'd miss the lc_put on the
b411b3637fa71f Philipp Reisner      2009-09-25  1041  		 * extent we keep the refcount on.
b411b3637fa71f Philipp Reisner      2009-09-25  1042  		 * so we remembered which extent we had to try again, and
b411b3637fa71f Philipp Reisner      2009-09-25  1043  		 * if the next requested one is something else, we do
b411b3637fa71f Philipp Reisner      2009-09-25  1044  		 * the lc_put here...
b411b3637fa71f Philipp Reisner      2009-09-25  1045  		 * we also have to wake_up
b411b3637fa71f Philipp Reisner      2009-09-25  1046  		 */
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  1047  		e = lc_find(device->resync, device->resync_wenr);
b411b3637fa71f Philipp Reisner      2009-09-25  1048  		bm_ext = e ? lc_entry(e, struct bm_extent, lce) : NULL;
b411b3637fa71f Philipp Reisner      2009-09-25  1049  		if (bm_ext) {
0b0ba1efc7b887 Andreas Gruenbacher  2011-06-27  1050  			D_ASSERT(device, !test_bit(BME_LOCKED, &bm_ext->flags));
0b0ba1efc7b887 Andreas Gruenbacher  2011-06-27  1051  			D_ASSERT(device, test_bit(BME_NO_WRITES, &bm_ext->flags));
b411b3637fa71f Philipp Reisner      2009-09-25  1052  			clear_bit(BME_NO_WRITES, &bm_ext->flags);
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  1053  			device->resync_wenr = LC_FREE;
ad3fee790088d3 Lars Ellenberg       2013-12-20  1054  			if (lc_put(device->resync, &bm_ext->lce) == 0) {
ad3fee790088d3 Lars Ellenberg       2013-12-20  1055  				bm_ext->flags = 0;
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  1056  				device->resync_locked--;
ad3fee790088d3 Lars Ellenberg       2013-12-20  1057  			}
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  1058  			wake_up(&device->al_wait);
b411b3637fa71f Philipp Reisner      2009-09-25  1059  		} else {
d01801710265cf Andreas Gruenbacher  2011-07-03  1060  			drbd_alert(device, "LOGIC BUG\n");
b411b3637fa71f Philipp Reisner      2009-09-25  1061  		}
b411b3637fa71f Philipp Reisner      2009-09-25  1062  	}
b411b3637fa71f Philipp Reisner      2009-09-25  1063  	/* TRY. */
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  1064  	e = lc_try_get(device->resync, enr);
b411b3637fa71f Philipp Reisner      2009-09-25  1065  	bm_ext = e ? lc_entry(e, struct bm_extent, lce) : NULL;
b411b3637fa71f Philipp Reisner      2009-09-25  1066  	if (bm_ext) {
b411b3637fa71f Philipp Reisner      2009-09-25  1067  		if (test_bit(BME_LOCKED, &bm_ext->flags))
b411b3637fa71f Philipp Reisner      2009-09-25  1068  			goto proceed;
b411b3637fa71f Philipp Reisner      2009-09-25  1069  		if (!test_and_set_bit(BME_NO_WRITES, &bm_ext->flags)) {
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  1070  			device->resync_locked++;
b411b3637fa71f Philipp Reisner      2009-09-25  1071  		} else {
b411b3637fa71f Philipp Reisner      2009-09-25  1072  			/* we did set the BME_NO_WRITES,
b411b3637fa71f Philipp Reisner      2009-09-25  1073  			 * but then could not set BME_LOCKED,
b411b3637fa71f Philipp Reisner      2009-09-25  1074  			 * so we tried again.
b411b3637fa71f Philipp Reisner      2009-09-25  1075  			 * drop the extra reference. */
b411b3637fa71f Philipp Reisner      2009-09-25  1076  			bm_ext->lce.refcnt--;
0b0ba1efc7b887 Andreas Gruenbacher  2011-06-27  1077  			D_ASSERT(device, bm_ext->lce.refcnt > 0);
b411b3637fa71f Philipp Reisner      2009-09-25  1078  		}
b411b3637fa71f Philipp Reisner      2009-09-25  1079  		goto check_al;
b411b3637fa71f Philipp Reisner      2009-09-25  1080  	} else {
b411b3637fa71f Philipp Reisner      2009-09-25  1081  		/* do we rather want to try later? */
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  1082  		if (device->resync_locked > device->resync->nr_elements-3)
b411b3637fa71f Philipp Reisner      2009-09-25  1083  			goto try_again;
b411b3637fa71f Philipp Reisner      2009-09-25  1084  		/* Do or do not. There is no try. -- Yoda */
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  1085  		e = lc_get(device->resync, enr);
b411b3637fa71f Philipp Reisner      2009-09-25  1086  		bm_ext = e ? lc_entry(e, struct bm_extent, lce) : NULL;
b411b3637fa71f Philipp Reisner      2009-09-25  1087  		if (!bm_ext) {
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  1088  			const unsigned long rs_flags = device->resync->flags;
b411b3637fa71f Philipp Reisner      2009-09-25  1089  			if (rs_flags & LC_STARVING)
d01801710265cf Andreas Gruenbacher  2011-07-03  1090  				drbd_warn(device, "Have to wait for element"
b411b3637fa71f Philipp Reisner      2009-09-25  1091  				     " (resync LRU too small?)\n");
46a15bc3ec425b Lars Ellenberg       2011-02-21  1092  			BUG_ON(rs_flags & LC_LOCKED);
b411b3637fa71f Philipp Reisner      2009-09-25  1093  			goto try_again;
b411b3637fa71f Philipp Reisner      2009-09-25  1094  		}
b411b3637fa71f Philipp Reisner      2009-09-25  1095  		if (bm_ext->lce.lc_number != enr) {
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  1096  			bm_ext->rs_left = drbd_bm_e_weight(device, enr);
b411b3637fa71f Philipp Reisner      2009-09-25  1097  			bm_ext->rs_failed = 0;
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  1098  			lc_committed(device->resync);
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  1099  			wake_up(&device->al_wait);
0b0ba1efc7b887 Andreas Gruenbacher  2011-06-27  1100  			D_ASSERT(device, test_bit(BME_LOCKED, &bm_ext->flags) == 0);
b411b3637fa71f Philipp Reisner      2009-09-25  1101  		}
b411b3637fa71f Philipp Reisner      2009-09-25  1102  		set_bit(BME_NO_WRITES, &bm_ext->flags);
0b0ba1efc7b887 Andreas Gruenbacher  2011-06-27  1103  		D_ASSERT(device, bm_ext->lce.refcnt == 1);
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  1104  		device->resync_locked++;
b411b3637fa71f Philipp Reisner      2009-09-25  1105  		goto check_al;
b411b3637fa71f Philipp Reisner      2009-09-25  1106  	}
b411b3637fa71f Philipp Reisner      2009-09-25  1107  check_al:
b411b3637fa71f Philipp Reisner      2009-09-25  1108  	for (i = 0; i < AL_EXT_PER_BM_SECT; i++) {
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  1109  		if (lc_is_used(device->act_log, al_enr+i))
b411b3637fa71f Philipp Reisner      2009-09-25  1110  			goto try_again;
b411b3637fa71f Philipp Reisner      2009-09-25  1111  	}
b411b3637fa71f Philipp Reisner      2009-09-25  1112  	set_bit(BME_LOCKED, &bm_ext->flags);
b411b3637fa71f Philipp Reisner      2009-09-25  1113  proceed:
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  1114  	device->resync_wenr = LC_FREE;
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  1115  	spin_unlock_irq(&device->al_lock);
b411b3637fa71f Philipp Reisner      2009-09-25  1116  	return 0;
b411b3637fa71f Philipp Reisner      2009-09-25  1117  
b411b3637fa71f Philipp Reisner      2009-09-25  1118  try_again:
ad3fee790088d3 Lars Ellenberg       2013-12-20  1119  	if (bm_ext) {
ad3fee790088d3 Lars Ellenberg       2013-12-20  1120  		if (throttle) {
ad3fee790088d3 Lars Ellenberg       2013-12-20  1121  			D_ASSERT(device, !test_bit(BME_LOCKED, &bm_ext->flags));
ad3fee790088d3 Lars Ellenberg       2013-12-20  1122  			D_ASSERT(device, test_bit(BME_NO_WRITES, &bm_ext->flags));
ad3fee790088d3 Lars Ellenberg       2013-12-20  1123  			clear_bit(BME_NO_WRITES, &bm_ext->flags);
ad3fee790088d3 Lars Ellenberg       2013-12-20  1124  			device->resync_wenr = LC_FREE;
ad3fee790088d3 Lars Ellenberg       2013-12-20  1125  			if (lc_put(device->resync, &bm_ext->lce) == 0) {
ad3fee790088d3 Lars Ellenberg       2013-12-20  1126  				bm_ext->flags = 0;
ad3fee790088d3 Lars Ellenberg       2013-12-20  1127  				device->resync_locked--;
ad3fee790088d3 Lars Ellenberg       2013-12-20  1128  			}
ad3fee790088d3 Lars Ellenberg       2013-12-20  1129  			wake_up(&device->al_wait);
ad3fee790088d3 Lars Ellenberg       2013-12-20  1130  		} else
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  1131  			device->resync_wenr = enr;
ad3fee790088d3 Lars Ellenberg       2013-12-20  1132  	}
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  1133  	spin_unlock_irq(&device->al_lock);
b411b3637fa71f Philipp Reisner      2009-09-25  1134  	return -EAGAIN;
b411b3637fa71f Philipp Reisner      2009-09-25  1135  }
b411b3637fa71f Philipp Reisner      2009-09-25  1136  

:::::: The code at line 1015 was first introduced by commit
:::::: b411b3637fa71fce9cf2acf0639009500f5892fe The DRBD driver

:::::: TO: Philipp Reisner <philipp.reisner@linbit.com>
:::::: CC: Jens Axboe <jens.axboe@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
