Return-Path: <linux-kernel+bounces-18804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CC6826330
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 07:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0ED0B21687
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 06:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B646112B66;
	Sun,  7 Jan 2024 06:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hJKKjD6K"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8A1125CD
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 06:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704609606; x=1736145606;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f/RZLPT6p0ebDjCoyzION04uQw5odX9ZXvphidLuD5Y=;
  b=hJKKjD6KY+QDLwY4UbsRECMFsxLX1/n3CfQ0E6lgX25o6BPsgUhVIo7b
   yHzx+QR6S1j8t0y4+m5Q7Tg4OgHit+tcO2eIfg9stFtkvgAMxB0iQFwb9
   TGMn5SXqbb/DclkxLABwXmGuzhApnGtdfzzDoXt5mJ2AkHu21H7iCGmGr
   bRUFfRVNfpF4eX6JpCa4gicdp9xQvdaP8H/EC7/IbRR7VTFnSXPzieL0T
   wYJFI7AzQywLEROAtoKcv+GFuKiwM2Nl0OifdDFKcWWn/FWDvtalURSNG
   Q3M/x9lACHi/7fsnMa/fqWO5jvCXuE+m+ot+oINr2G3HLSaH+rSPiFaae
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="388160480"
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="388160480"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 22:40:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="22855899"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 06 Jan 2024 22:40:05 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMMpF-0003UW-27;
	Sun, 07 Jan 2024 06:40:01 +0000
Date: Sun, 7 Jan 2024 14:39:05 +0800
From: kernel test robot <lkp@intel.com>
To: Kah Jing Lee <kah.jing.lee@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Radu Bacrau <radu.bacrau@intel.com>,
	Ang Tien Sung <tien.sung.ang@intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>
Subject: drivers/firmware/stratix10-rsu.c:93: warning: Function parameter or
 member 'dcmf_status' not described in 'stratix10_rsu_priv'
Message-ID: <202401071443.x9tmUlhW-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Kah,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   52b1853b080a082ec3749c3a9577f6c71b1d4a90
commit: 1b4394c5d731593063f53df9d72467335c3b0367 firmware: stratix10-svc: extend svc to support RSU feature
date:   1 year, 6 months ago
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240107/202401071443.x9tmUlhW-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240107/202401071443.x9tmUlhW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401071443.x9tmUlhW-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/firmware/stratix10-rsu.c:93: warning: Function parameter or member 'status' not described in 'stratix10_rsu_priv'
   drivers/firmware/stratix10-rsu.c:93: warning: Function parameter or member 'dcmf_version' not described in 'stratix10_rsu_priv'
>> drivers/firmware/stratix10-rsu.c:93: warning: Function parameter or member 'dcmf_status' not described in 'stratix10_rsu_priv'


vim +93 drivers/firmware/stratix10-rsu.c

4526ebbc77732b Richard Gong 2019-09-03  37  
4526ebbc77732b Richard Gong 2019-09-03  38  typedef void (*rsu_callback)(struct stratix10_svc_client *client,
4526ebbc77732b Richard Gong 2019-09-03  39  			     struct stratix10_svc_cb_data *data);
4526ebbc77732b Richard Gong 2019-09-03  40  /**
4526ebbc77732b Richard Gong 2019-09-03  41   * struct stratix10_rsu_priv - rsu data structure
4526ebbc77732b Richard Gong 2019-09-03  42   * @chan: pointer to the allocated service channel
4526ebbc77732b Richard Gong 2019-09-03  43   * @client: active service client
4526ebbc77732b Richard Gong 2019-09-03  44   * @completion: state for callback completion
4526ebbc77732b Richard Gong 2019-09-03  45   * @lock: a mutex to protect callback completion state
4526ebbc77732b Richard Gong 2019-09-03  46   * @status.current_image: address of image currently running in flash
4526ebbc77732b Richard Gong 2019-09-03  47   * @status.fail_image: address of failed image in flash
75bc73fc0188ef Richard Gong 2020-06-15  48   * @status.version: the interface version number of RSU firmware
4526ebbc77732b Richard Gong 2019-09-03  49   * @status.state: the state of RSU system
4526ebbc77732b Richard Gong 2019-09-03  50   * @status.error_details: error code
4526ebbc77732b Richard Gong 2019-09-03  51   * @status.error_location: the error offset inside the image that failed
75bc73fc0188ef Richard Gong 2020-06-15  52   * @dcmf_version.dcmf0: Quartus dcmf0 version
75bc73fc0188ef Richard Gong 2020-06-15  53   * @dcmf_version.dcmf1: Quartus dcmf1 version
75bc73fc0188ef Richard Gong 2020-06-15  54   * @dcmf_version.dcmf2: Quartus dcmf2 version
75bc73fc0188ef Richard Gong 2020-06-15  55   * @dcmf_version.dcmf3: Quartus dcmf3 version
4a6c8c565db1d0 Kah Jing Lee 2022-07-11  56   * @dcmf_status.dcmf0: dcmf0 status
4a6c8c565db1d0 Kah Jing Lee 2022-07-11  57   * @dcmf_status.dcmf1: dcmf1 status
4a6c8c565db1d0 Kah Jing Lee 2022-07-11  58   * @dcmf_status.dcmf2: dcmf2 status
4a6c8c565db1d0 Kah Jing Lee 2022-07-11  59   * @dcmf_status.dcmf3: dcmf3 status
4526ebbc77732b Richard Gong 2019-09-03  60   * @retry_counter: the current image's retry counter
75bc73fc0188ef Richard Gong 2020-06-15  61   * @max_retry: the preset max retry value
4526ebbc77732b Richard Gong 2019-09-03  62   */
4526ebbc77732b Richard Gong 2019-09-03  63  struct stratix10_rsu_priv {
4526ebbc77732b Richard Gong 2019-09-03  64  	struct stratix10_svc_chan *chan;
4526ebbc77732b Richard Gong 2019-09-03  65  	struct stratix10_svc_client client;
4526ebbc77732b Richard Gong 2019-09-03  66  	struct completion completion;
4526ebbc77732b Richard Gong 2019-09-03  67  	struct mutex lock;
4526ebbc77732b Richard Gong 2019-09-03  68  	struct {
4526ebbc77732b Richard Gong 2019-09-03  69  		unsigned long current_image;
4526ebbc77732b Richard Gong 2019-09-03  70  		unsigned long fail_image;
4526ebbc77732b Richard Gong 2019-09-03  71  		unsigned int version;
4526ebbc77732b Richard Gong 2019-09-03  72  		unsigned int state;
4526ebbc77732b Richard Gong 2019-09-03  73  		unsigned int error_details;
4526ebbc77732b Richard Gong 2019-09-03  74  		unsigned int error_location;
4526ebbc77732b Richard Gong 2019-09-03  75  	} status;
75bc73fc0188ef Richard Gong 2020-06-15  76  
75bc73fc0188ef Richard Gong 2020-06-15  77  	struct {
75bc73fc0188ef Richard Gong 2020-06-15  78  		unsigned int dcmf0;
75bc73fc0188ef Richard Gong 2020-06-15  79  		unsigned int dcmf1;
75bc73fc0188ef Richard Gong 2020-06-15  80  		unsigned int dcmf2;
75bc73fc0188ef Richard Gong 2020-06-15  81  		unsigned int dcmf3;
75bc73fc0188ef Richard Gong 2020-06-15  82  	} dcmf_version;
75bc73fc0188ef Richard Gong 2020-06-15  83  
4a6c8c565db1d0 Kah Jing Lee 2022-07-11  84  	struct {
4a6c8c565db1d0 Kah Jing Lee 2022-07-11  85  		unsigned int dcmf0;
4a6c8c565db1d0 Kah Jing Lee 2022-07-11  86  		unsigned int dcmf1;
4a6c8c565db1d0 Kah Jing Lee 2022-07-11  87  		unsigned int dcmf2;
4a6c8c565db1d0 Kah Jing Lee 2022-07-11  88  		unsigned int dcmf3;
4a6c8c565db1d0 Kah Jing Lee 2022-07-11  89  	} dcmf_status;
4a6c8c565db1d0 Kah Jing Lee 2022-07-11  90  
4526ebbc77732b Richard Gong 2019-09-03  91  	unsigned int retry_counter;
75bc73fc0188ef Richard Gong 2020-06-15  92  	unsigned int max_retry;
4526ebbc77732b Richard Gong 2019-09-03 @93  };
4526ebbc77732b Richard Gong 2019-09-03  94  

:::::: The code at line 93 was first introduced by commit
:::::: 4526ebbc77732bcae965ee374cf3e8d86436b2ad firmware: add Intel Stratix10 remote system update driver

:::::: TO: Richard Gong <richard.gong@intel.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

