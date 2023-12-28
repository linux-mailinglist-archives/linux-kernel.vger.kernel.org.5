Return-Path: <linux-kernel+bounces-12701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC5381F918
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403C31F23463
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA1BCA67;
	Thu, 28 Dec 2023 14:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pqc9NNBE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D0AC8D2
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703773884; x=1735309884;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4YoiP5cx+oOE35Y5TkJFbWoAf3NNxqHps5Ad7oCP678=;
  b=Pqc9NNBEcnN+OlinCW5FtxesjCnmiWIW2PyvFU+okRyULeuYoFWocDKZ
   xYkGiZP62j0s6O/rs9U7fzvy95l9jmZ0A7lmN5MKhU7El/nNB4inmQXJi
   K632pJwt2Lk+zL6XJVqXPVzwxn2c8pQiTocPKdlRFqHh7WipR4hRrvGXY
   +gIg/ZS7Ps7OuGofFiGVR94JD9/QcUniLT1o3qeqceXKwghuvwPkdlVqd
   4YQ0Lrp2Hc1MweHX4bIg6iRE+cXFJwwTvJWeis9E28vJvb3LazIuRYCHZ
   a9A7P3JiJfMDS8BnItPbJ6MeNu56n96qJPzEKQKG8bYXXb1Nu2Q0/ijxm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="427722222"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="427722222"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 06:31:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="728328070"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="728328070"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 28 Dec 2023 06:31:22 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rIrPs-000GXB-0A;
	Thu, 28 Dec 2023 14:31:20 +0000
Date: Thu, 28 Dec 2023 22:30:51 +0800
From: kernel test robot <lkp@intel.com>
To: Aswath Govindraju <a-govindraju@ti.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>
Subject: drivers/mux/adg792a.c:134:34: warning: 'adg792a_of_match' defined
 but not used
Message-ID: <202312282250.c3GseJPc-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Aswath,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f5837722ffecbbedf1b1dbab072a063565f0dad1
commit: e4d4371253029528c02bfb43a46c252e1c3d035f phy: phy-can-transceiver: Add support for setting mux
date:   1 year, 9 months ago
config: x86_64-randconfig-c022-20230306 (https://download.01.org/0day-ci/archive/20231228/202312282250.c3GseJPc-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231228/202312282250.c3GseJPc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312282250.c3GseJPc-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mux/adg792a.c:134:34: warning: 'adg792a_of_match' defined but not used [-Wunused-const-variable=]
     134 | static const struct of_device_id adg792a_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~


vim +/adg792a_of_match +134 drivers/mux/adg792a.c

afda08c4caa948 drivers/mux/mux-adg792a.c Peter Rosin 2017-05-14  133  
afda08c4caa948 drivers/mux/mux-adg792a.c Peter Rosin 2017-05-14 @134  static const struct of_device_id adg792a_of_match[] = {
afda08c4caa948 drivers/mux/mux-adg792a.c Peter Rosin 2017-05-14  135  	{ .compatible = "adi,adg792a", },
afda08c4caa948 drivers/mux/mux-adg792a.c Peter Rosin 2017-05-14  136  	{ .compatible = "adi,adg792g", },
afda08c4caa948 drivers/mux/mux-adg792a.c Peter Rosin 2017-05-14  137  	{ }
afda08c4caa948 drivers/mux/mux-adg792a.c Peter Rosin 2017-05-14  138  };
afda08c4caa948 drivers/mux/mux-adg792a.c Peter Rosin 2017-05-14  139  MODULE_DEVICE_TABLE(of, adg792a_of_match);
afda08c4caa948 drivers/mux/mux-adg792a.c Peter Rosin 2017-05-14  140  

:::::: The code at line 134 was first introduced by commit
:::::: afda08c4caa9489511557def51e322a5f2142a2f mux: adg792a: add mux controller driver for ADG792A/G

:::::: TO: Peter Rosin <peda@axentia.se>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

