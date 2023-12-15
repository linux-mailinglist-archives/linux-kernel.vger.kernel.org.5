Return-Path: <linux-kernel+bounces-1801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7DF815455
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BD992878D1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4158C18ECA;
	Fri, 15 Dec 2023 23:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JpafZeO4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F15B18EBB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 23:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702681710; x=1734217710;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IxpgahQuvfS3Jhc/9Rqhsx6HsLl+Y8PHsuXXdQ+0hrg=;
  b=JpafZeO4ZUtnzhLYhbdNJakx5ci3b2eloISM7lKJTMmV7XAoGPMN2dOH
   PAgmGQPC8pw01dq/OrPxsTPtyChImuoZV13vlCm2/IZ7DHKgocTkk/H8A
   naXwVBmbblvCFLW7jm7h4/YhCheOaKTQVrF/sOSV5dfgZZWWXLjxFxLEo
   1sVc1Soask02rj1JH9k7w8e8OJCFgZ2Trc9+gFNflZD+KEhyUgBC2OhOf
   72FhN+iF7IqvhnZJl/QLcb496cM7XefkaznLQQod+Pnc84kBttE6lmO6A
   qq8K+qpbEjeJr3RQoCUWJ7kBE4xmGbSckbWbOkIpDGLe2WDuIaDu55mrn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="394213588"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="394213588"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 15:08:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="768151309"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="768151309"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 15 Dec 2023 15:08:27 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEHI9-0000sq-13;
	Fri, 15 Dec 2023 23:08:25 +0000
Date: Sat, 16 Dec 2023 07:07:40 +0800
From: kernel test robot <lkp@intel.com>
To: Andreas Gruenbacher <agruen@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: scripts/kernel-doc: drivers/block/drbd/drbd_bitmap.c:1222: warning:
 Function parameter or struct member 'peer_device' not described in
 'drbd_bm_read'
Message-ID: <202312160637.pp8kGHZ5-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3bd7d748816927202268cb335921f7f68b3ca723
commit: 8164dd6c8ae158ec0740bf37f0f14645a1fb5355 drbd: Add peer device parameter to whole-bitmap I/O handlers
date:   9 months ago
config: m68k-sun3x_defconfig (https://download.01.org/0day-ci/archive/20231216/202312160637.pp8kGHZ5-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231216/202312160637.pp8kGHZ5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312160637.pp8kGHZ5-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> scripts/kernel-doc: drivers/block/drbd/drbd_bitmap.c:1222: warning: Function parameter or struct member 'peer_device' not described in 'drbd_bm_read'
>> scripts/kernel-doc: drivers/block/drbd/drbd_bitmap.c:1234: warning: Function parameter or struct member 'peer_device' not described in 'drbd_bm_write'
>> scripts/kernel-doc: drivers/block/drbd/drbd_bitmap.c:1246: warning: Function parameter or struct member 'peer_device' not described in 'drbd_bm_write_all'
>> scripts/kernel-doc: drivers/block/drbd/drbd_bitmap.c:1273: warning: Function parameter or struct member 'peer_device' not described in 'drbd_bm_write_copy_pages'
--
>> scripts/kernel-doc: drivers/block/drbd/drbd_main.c:3415: warning: Function parameter or struct member 'peer_device' not described in 'drbd_bmio_set_n_write'
>> scripts/kernel-doc: drivers/block/drbd/drbd_main.c:3441: warning: Function parameter or struct member 'peer_device' not described in 'drbd_bmio_clear_n_write'
>> scripts/kernel-doc: drivers/block/drbd/drbd_main.c:3502: warning: Function parameter or struct member 'peer_device' not described in 'drbd_queue_bitmap_io'
>> scripts/kernel-doc: drivers/block/drbd/drbd_main.c:3544: warning: Function parameter or struct member 'peer_device' not described in 'drbd_bitmap_io'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

