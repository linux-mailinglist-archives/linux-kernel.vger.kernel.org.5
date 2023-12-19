Return-Path: <linux-kernel+bounces-4728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E75818146
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26681286140
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 06:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3990746A;
	Tue, 19 Dec 2023 06:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P5dBtOsB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2EEC132;
	Tue, 19 Dec 2023 06:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702965627; x=1734501627;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BsACiejB7wz3shwOgu/STyqJwCYDRHhOdCqujC1vkq4=;
  b=P5dBtOsBxKKpD5sP70/AbL36WKqew59C18thhjAQn/M3wgfq8MJT2txB
   SvXov1qyku8+gsltYTluY4J/xFqsv8bJ5hrWF8Uwdf8/PcpdKE5RV78br
   UFWEwCmKXYLziVmL+9AMaza7KiR+95c00/PkKDmfF1uGJ0aOp9ZsQy+th
   2gHsMnlvAbHfSJQfvnJPirU9nRHq3n0/qYiG9bnVupQHuYXGeFmgn6QvQ
   Wfr6NImw4vfEqscddOMR7PPWLKgaUzkVnX0MIEVczqlzLcV/R3zGtmn2n
   gZxRXSNYv+rYxm17h7NMdZexBXzh5qLsLcRTndqu+EHxSUkUsgywo6hx6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="392785553"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="392785553"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 22:00:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="769108678"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="769108678"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 18 Dec 2023 22:00:24 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFT9R-0004ux-2P;
	Tue, 19 Dec 2023 06:00:21 +0000
Date: Tue, 19 Dec 2023 14:00:13 +0800
From: kernel test robot <lkp@intel.com>
To: Jun Yan <jerrysteve1101@gmail.com>, Jonathan.Cameron@huawei.com
Cc: oe-kbuild-all@lists.linux.dev, lars@metafoo.de,
	Qing-wu.Li@leica-geosystems.com.cn, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jun Yan <jerrysteve1101@gmail.com>
Subject: Re: [PATCH] iio: accel: bmi088: add i2c support for bmi088 accel
 driver
Message-ID: <202312191325.jfiyeL5F-lkp@intel.com>
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
config: x86_64-randconfig-161-20231219 (https://download.01.org/0day-ci/archive/20231219/202312191325.jfiyeL5F-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231219/202312191325.jfiyeL5F-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312191325.jfiyeL5F-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/accel/bmi088-accel-i2c.c:14:10: fatal error: 'linux/i2c/i2c.h' file not found
   #include <linux/i2c/i2c.h>
            ^~~~~~~~~~~~~~~~~
   1 error generated.


vim +14 drivers/iio/accel/bmi088-accel-i2c.c

  > 14	#include <linux/i2c/i2c.h>
    15	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

