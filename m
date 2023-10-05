Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347527BAF1A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 01:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjJEXIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 19:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjJEXFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 19:05:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21A3D51
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 16:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696546839; x=1728082839;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZVYVYHZ9ftRJUO4Gv7vtAO9m7gGtzYYlUB4SqGQdJMA=;
  b=jMN+a7IkXzvLQ4cLtFLaOqWuYO6mFg5HNaCrCgs9XgAFMLoY4cIJmQvD
   uLJuLwdp7808k5qQqjwQMGAkfoloXWMPSb5YImKjVTfcZIuHVdilSNHSw
   WjNHSogeCfLyWoQk1q4hm/3RWojs7cEeRls+jM0IQikiULq1eFnbFJJGk
   Az6YdL/cnOmQ3DRpDLKROpjINiuDJyYtajYOPj0PfWs6IQSewOyNWvr2A
   EShxeZsFOml4UTl5lH9OaWJs0MQJDzA1fBKMk5JBrkX9IIQSQlduNNIzK
   k8TmtZdUG+4rq8Zi06ucxzMEGwg/ZXTs8X/0B58Ib+QCTwI6sm4JCn9tO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="368719612"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="368719612"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 16:00:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="787175719"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="787175719"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 05 Oct 2023 16:00:35 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qoXKa-000M06-1l;
        Thu, 05 Oct 2023 23:00:32 +0000
Date:   Fri, 6 Oct 2023 07:00:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andreas Gruenbacher <agruen@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph =?iso-8859-1?Q?B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: drivers/block/drbd/drbd_bitmap.c:1222: warning: Function parameter
 or member 'peer_device' not described in 'drbd_bm_read'
Message-ID: <202310060638.1byWPNxY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f291209eca5eba0b4704fa0832af57b12dbc1a02
commit: 8164dd6c8ae158ec0740bf37f0f14645a1fb5355 drbd: Add peer device parameter to whole-bitmap I/O handlers
date:   6 months ago
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231006/202310060638.1byWPNxY-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231006/202310060638.1byWPNxY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310060638.1byWPNxY-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/block/drbd/drbd_bitmap.c:1222: warning: Function parameter or member 'peer_device' not described in 'drbd_bm_read'
>> drivers/block/drbd/drbd_bitmap.c:1234: warning: Function parameter or member 'peer_device' not described in 'drbd_bm_write'
>> drivers/block/drbd/drbd_bitmap.c:1246: warning: Function parameter or member 'peer_device' not described in 'drbd_bm_write_all'
>> drivers/block/drbd/drbd_bitmap.c:1273: warning: Function parameter or member 'peer_device' not described in 'drbd_bm_write_copy_pages'
--
>> drivers/block/drbd/drbd_main.c:3415: warning: Function parameter or member 'peer_device' not described in 'drbd_bmio_set_n_write'
>> drivers/block/drbd/drbd_main.c:3441: warning: Function parameter or member 'peer_device' not described in 'drbd_bmio_clear_n_write'
>> drivers/block/drbd/drbd_main.c:3502: warning: Function parameter or member 'peer_device' not described in 'drbd_queue_bitmap_io'
>> drivers/block/drbd/drbd_main.c:3544: warning: Function parameter or member 'peer_device' not described in 'drbd_bitmap_io'


vim +1222 drivers/block/drbd/drbd_bitmap.c

b411b3637fa71f Philipp Reisner     2009-09-25  1214  
b411b3637fa71f Philipp Reisner     2009-09-25  1215  /**
b411b3637fa71f Philipp Reisner     2009-09-25  1216   * drbd_bm_read() - Read the whole bitmap from its on disk location.
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  1217   * @device:	DRBD device.
b411b3637fa71f Philipp Reisner     2009-09-25  1218   */
8164dd6c8ae158 Andreas Gruenbacher 2023-03-30  1219  int drbd_bm_read(struct drbd_device *device,
8164dd6c8ae158 Andreas Gruenbacher 2023-03-30  1220  		 struct drbd_peer_device *peer_device) __must_hold(local)
8164dd6c8ae158 Andreas Gruenbacher 2023-03-30  1221  
b411b3637fa71f Philipp Reisner     2009-09-25 @1222  {
4ce4926683b820 Lars Ellenberg      2014-05-06  1223  	return bm_rw(device, BM_AIO_READ, 0);
b411b3637fa71f Philipp Reisner     2009-09-25  1224  }
b411b3637fa71f Philipp Reisner     2009-09-25  1225  
b411b3637fa71f Philipp Reisner     2009-09-25  1226  /**
b411b3637fa71f Philipp Reisner     2009-09-25  1227   * drbd_bm_write() - Write the whole bitmap to its on disk location.
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  1228   * @device:	DRBD device.
19f843aa08e2d8 Lars Ellenberg      2010-12-15  1229   *
19f843aa08e2d8 Lars Ellenberg      2010-12-15  1230   * Will only write pages that have changed since last IO.
b411b3637fa71f Philipp Reisner     2009-09-25  1231   */
8164dd6c8ae158 Andreas Gruenbacher 2023-03-30  1232  int drbd_bm_write(struct drbd_device *device,
8164dd6c8ae158 Andreas Gruenbacher 2023-03-30  1233  		 struct drbd_peer_device *peer_device) __must_hold(local)
b411b3637fa71f Philipp Reisner     2009-09-25 @1234  {
4ce4926683b820 Lars Ellenberg      2014-05-06  1235  	return bm_rw(device, 0, 0);
b411b3637fa71f Philipp Reisner     2009-09-25  1236  }
b411b3637fa71f Philipp Reisner     2009-09-25  1237  
d1aa4d04da8de5 Philipp Reisner     2012-08-08  1238  /**
d1aa4d04da8de5 Philipp Reisner     2012-08-08  1239   * drbd_bm_write_all() - Write the whole bitmap to its on disk location.
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  1240   * @device:	DRBD device.
d1aa4d04da8de5 Philipp Reisner     2012-08-08  1241   *
d1aa4d04da8de5 Philipp Reisner     2012-08-08  1242   * Will write all pages.
d1aa4d04da8de5 Philipp Reisner     2012-08-08  1243   */
8164dd6c8ae158 Andreas Gruenbacher 2023-03-30  1244  int drbd_bm_write_all(struct drbd_device *device,
8164dd6c8ae158 Andreas Gruenbacher 2023-03-30  1245  		struct drbd_peer_device *peer_device) __must_hold(local)
d1aa4d04da8de5 Philipp Reisner     2012-08-08 @1246  {
4ce4926683b820 Lars Ellenberg      2014-05-06  1247  	return bm_rw(device, BM_AIO_WRITE_ALL_PAGES, 0);
d1aa4d04da8de5 Philipp Reisner     2012-08-08  1248  }
d1aa4d04da8de5 Philipp Reisner     2012-08-08  1249  
c7a58db4e9dc52 Lars Ellenberg      2013-12-20  1250  /**
c7a58db4e9dc52 Lars Ellenberg      2013-12-20  1251   * drbd_bm_write_lazy() - Write bitmap pages 0 to @upper_idx-1, if they have changed.
c7a58db4e9dc52 Lars Ellenberg      2013-12-20  1252   * @device:	DRBD device.
c7a58db4e9dc52 Lars Ellenberg      2013-12-20  1253   * @upper_idx:	0: write all changed pages; +ve: page index to stop scanning for changed pages
c7a58db4e9dc52 Lars Ellenberg      2013-12-20  1254   */
c7a58db4e9dc52 Lars Ellenberg      2013-12-20  1255  int drbd_bm_write_lazy(struct drbd_device *device, unsigned upper_idx) __must_hold(local)
c7a58db4e9dc52 Lars Ellenberg      2013-12-20  1256  {
c7a58db4e9dc52 Lars Ellenberg      2013-12-20  1257  	return bm_rw(device, BM_AIO_COPY_PAGES, upper_idx);
c7a58db4e9dc52 Lars Ellenberg      2013-12-20  1258  }
c7a58db4e9dc52 Lars Ellenberg      2013-12-20  1259  
0e8488ade26b4b Lars Ellenberg      2012-04-25  1260  /**
0e8488ade26b4b Lars Ellenberg      2012-04-25  1261   * drbd_bm_write_copy_pages() - Write the whole bitmap to its on disk location.
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  1262   * @device:	DRBD device.
0e8488ade26b4b Lars Ellenberg      2012-04-25  1263   *
0e8488ade26b4b Lars Ellenberg      2012-04-25  1264   * Will only write pages that have changed since last IO.
0e8488ade26b4b Lars Ellenberg      2012-04-25  1265   * In contrast to drbd_bm_write(), this will copy the bitmap pages
0e8488ade26b4b Lars Ellenberg      2012-04-25  1266   * to temporary writeout pages. It is intended to trigger a full write-out
0e8488ade26b4b Lars Ellenberg      2012-04-25  1267   * while still allowing the bitmap to change, for example if a resync or online
0e8488ade26b4b Lars Ellenberg      2012-04-25  1268   * verify is aborted due to a failed peer disk, while local IO continues, or
0e8488ade26b4b Lars Ellenberg      2012-04-25  1269   * pending resync acks are still being processed.
0e8488ade26b4b Lars Ellenberg      2012-04-25  1270   */
8164dd6c8ae158 Andreas Gruenbacher 2023-03-30  1271  int drbd_bm_write_copy_pages(struct drbd_device *device,
8164dd6c8ae158 Andreas Gruenbacher 2023-03-30  1272  		struct drbd_peer_device *peer_device) __must_hold(local)
0e8488ade26b4b Lars Ellenberg      2012-04-25 @1273  {
4ce4926683b820 Lars Ellenberg      2014-05-06  1274  	return bm_rw(device, BM_AIO_COPY_PAGES, 0);
19f843aa08e2d8 Lars Ellenberg      2010-12-15  1275  }
19f843aa08e2d8 Lars Ellenberg      2010-12-15  1276  

:::::: The code at line 1222 was first introduced by commit
:::::: b411b3637fa71fce9cf2acf0639009500f5892fe The DRBD driver

:::::: TO: Philipp Reisner <philipp.reisner@linbit.com>
:::::: CC: Jens Axboe <jens.axboe@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
