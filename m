Return-Path: <linux-kernel+bounces-4696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5058180B5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1DC1C21683
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044CF6AA2;
	Tue, 19 Dec 2023 04:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZKSA+UdZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC63C134;
	Tue, 19 Dec 2023 04:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702961384; x=1734497384;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u1PrKXJ5wdf/6ii9goqAcOzxorRlFg0fLsA9scgSD3s=;
  b=ZKSA+UdZyUv5u7V0bnS2sY8sKSTHVj+mXnbwmYCit730WLtA6JcDg/kw
   gjJl9mIhNzBDAca7WWAQbOBH2ON0GyuyC7Ix22ZOdnYMr5gR0UruzOB6S
   iOqeMoHfVhYXI7Ej1hk2zvCY5ZkGDScCdfES0Z5zYEkmWcv6fIh4JhYKw
   Bv6LETB1EByT9FFiMfyK0y50WCJvzA2u1O1+RnzHZeK0cVai5d3A5I9nf
   Hyqxzzva84Ep/YE/uLwecX8oxXcsE+sxEDPjWL9b3V0M5TnGz3/FCNiUe
   QP7gmSOcyFKKJjvGmLswuH/k+57BUq3JT8kWoqpXeb3w6VBaLiVyZvrXA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="2832774"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="2832774"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 20:49:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="899224556"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="899224556"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 18 Dec 2023 20:49:42 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFS2m-0004sH-0T;
	Tue, 19 Dec 2023 04:49:39 +0000
Date: Tue, 19 Dec 2023 12:48:39 +0800
From: kernel test robot <lkp@intel.com>
To: Jun Yan <jerrysteve1101@gmail.com>, Jonathan.Cameron@huawei.com
Cc: oe-kbuild-all@lists.linux.dev, lars@metafoo.de,
	Qing-wu.Li@leica-geosystems.com.cn, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jun Yan <jerrysteve1101@gmail.com>
Subject: Re: [PATCH] iio: accel: bmi088: add i2c support for bmi088 accel
 driver
Message-ID: <202312191202.IFnDRQVb-lkp@intel.com>
References: <20231218154045.219317-1-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218154045.219317-1-jerrysteve1101@gmail.com>

Hi Jun,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v6.7-rc6 next-20231218]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jun-Yan/iio-accel-bmi088-add-i2c-support-for-bmi088-accel-driver/20231218-235104
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20231218154045.219317-1-jerrysteve1101%40gmail.com
patch subject: [PATCH] iio: accel: bmi088: add i2c support for bmi088 accel driver
config: powerpc64-randconfig-r081-20231219 (https://download.01.org/0day-ci/archive/20231219/202312191202.IFnDRQVb-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231219/202312191202.IFnDRQVb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312191202.IFnDRQVb-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/accel/bmi088-accel-i2c.c:14:10: fatal error: linux/i2c/i2c.h: No such file or directory
      14 | #include <linux/i2c/i2c.h>
         |          ^~~~~~~~~~~~~~~~~
   compilation terminated.


vim +14 drivers/iio/accel/bmi088-accel-i2c.c

  > 14	#include <linux/i2c/i2c.h>
    15	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

