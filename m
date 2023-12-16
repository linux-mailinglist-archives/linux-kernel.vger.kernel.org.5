Return-Path: <linux-kernel+bounces-2102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8708157DE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 06:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5B85B2477F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF01D12B6E;
	Sat, 16 Dec 2023 05:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZAM2T35J"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42D1125B4
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 05:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702705830; x=1734241830;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2r1RmthbL0AeCl5fdS9EMOhu196f9l/e8BDmOFR/C5o=;
  b=ZAM2T35JD5pEuSrpqJ/uk3efbPjR+aWhisc+mQS6XvGFoxLztTAgsrjB
   ll+AgjfzfENnxGw0xAMa5eeMFssndvqSKhJIDuHhtpAZlwmjicMCSqG09
   QHXpmzXtZNPNmr572Mfg+lFW27cIBlI2Uq3J4asnYaq0xpR9a+sDUpg3j
   cJQO4lv84YJZkRvoRyIqRDfayhsqjNR4xNO7RBuwMp5ycWo9xdMsULtLS
   peCx9d6rh8h0Fvzacytt4ZN8e51m950iZx22GcIbQwo1vSbBmUaWNp2Ua
   eJ5VwcmfyeZQ6nzMxrvbR7Uq+ku1kWNph/yxo07Pf+r+r2K/0dWqmT3cu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="481546806"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="481546806"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 21:50:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="948197866"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="948197866"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 15 Dec 2023 21:50:28 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rENYY-0001Cg-2E;
	Sat, 16 Dec 2023 05:50:10 +0000
Date: Sat, 16 Dec 2023 13:49:02 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: scripts/kernel-doc: drivers/block/drbd/drbd_actlog.c:1015: warning:
 Function parameter or struct member 'peer_device' not described in
 'drbd_try_rs_begin_io'
Message-ID: <202312161343.qr5ZeNZG-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c8e97fc6b4c057a350a9e9a1ad625e10cc9c39ee
commit: 0d11f3cf279c5ad20a41f29242f170ba3c02f2da drbd: Pass a peer device to the resync and online verify functions
date:   9 months ago
config: m68k-sun3x_defconfig (https://download.01.org/0day-ci/archive/20231216/202312161343.qr5ZeNZG-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231216/202312161343.qr5ZeNZG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312161343.qr5ZeNZG-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> scripts/kernel-doc: drivers/block/drbd/drbd_actlog.c:1015: warning: Function parameter or struct member 'peer_device' not described in 'drbd_try_rs_begin_io'
>> scripts/kernel-doc: drivers/block/drbd/drbd_actlog.c:1015: warning: Excess function parameter 'device' description in 'drbd_try_rs_begin_io'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

