Return-Path: <linux-kernel+bounces-11170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8646881E26E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 22:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D5201C20F81
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 21:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FF353E18;
	Mon, 25 Dec 2023 21:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HC9jJlMF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3048253E04
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 21:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703539146; x=1735075146;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=huB9MMZ7tYRhi5UyF5AYs+8duVR45cwboZWmObxXF1Q=;
  b=HC9jJlMFWxGXpzONa53obKI3jXq5o+ZcsABhR7/wFH9znugmr0jCghFG
   U2IDkpw4lqwcwrXifM569jrHuHA6s6WHMC0QlOGfTnaQPBadkxAwSMt+d
   ME8/zw+8ID4bsbkCwLt+k3HBj6+yRqPjNTUZzdKfWk+iscpxlBZOEcmf4
   xyzSeqYQR3/9sN0bhYqI3Bt8dmYD35BeDIFutxATrKqew8CMl/a8++j1o
   6yAnxxrRjwJmGQloScWNPL6GENoY/Cdb1ZUrcPB9zjZDTdI3YMRSLSFVm
   zSVGzNOaDLS1EiULQPXw0A7FsQfbUcrrrnqLjWlXOocUyopaHCIISCrO8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="17868701"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="17868701"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 13:19:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="12276679"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 25 Dec 2023 13:19:04 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHsLl-000DgV-26;
	Mon, 25 Dec 2023 21:19:01 +0000
Date: Tue, 26 Dec 2023 05:18:23 +0800
From: kernel test robot <lkp@intel.com>
To: Eddie James <eajames@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: drivers/hwmon/pmbus/ibm-cffps.c:184:60: warning: '%04X' directive
 output may be truncated writing between 4 and 8 bytes into a region of size
 5
Message-ID: <202312260533.FU092oo9-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   861deac3b092f37b2c5e6871732f3e11486f7082
commit: 2f8a855efe8a6faf962c53af406e5ea4791b3877 pmbus: (ibm-cffps) Add support for version 2 of the PSU
date:   4 years, 4 months ago
config: x86_64-randconfig-x063-20230716 (https://download.01.org/0day-ci/archive/20231226/202312260533.FU092oo9-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231226/202312260533.FU092oo9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312260533.FU092oo9-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/hwmon/pmbus/ibm-cffps.c: In function 'ibm_cffps_debugfs_op':
   drivers/hwmon/pmbus/ibm-cffps.c:171:60: warning: '%02X' directive output may be truncated writing between 2 and 8 bytes into a region of size 3 [-Wformat-truncation=]
     171 |                                 snprintf(&data[i * 2], 3, "%02X", rc);
         |                                                            ^~~~
   drivers/hwmon/pmbus/ibm-cffps.c:171:59: note: directive argument in the range [0, 2147483647]
     171 |                                 snprintf(&data[i * 2], 3, "%02X", rc);
         |                                                           ^~~~~~
   drivers/hwmon/pmbus/ibm-cffps.c:171:33: note: 'snprintf' output between 3 and 9 bytes into a destination of size 3
     171 |                                 snprintf(&data[i * 2], 3, "%02X", rc);
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hwmon/pmbus/ibm-cffps.c:184:60: warning: '%04X' directive output may be truncated writing between 4 and 8 bytes into a region of size 5 [-Wformat-truncation=]
     184 |                                 snprintf(&data[i * 4], 5, "%04X", rc);
         |                                                            ^~~~
   drivers/hwmon/pmbus/ibm-cffps.c:184:59: note: directive argument in the range [0, 2147483647]
     184 |                                 snprintf(&data[i * 4], 5, "%04X", rc);
         |                                                           ^~~~~~
   drivers/hwmon/pmbus/ibm-cffps.c:184:33: note: 'snprintf' output between 5 and 9 bytes into a destination of size 5
     184 |                                 snprintf(&data[i * 4], 5, "%04X", rc);
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +184 drivers/hwmon/pmbus/ibm-cffps.c

   129	
   130	static ssize_t ibm_cffps_debugfs_op(struct file *file, char __user *buf,
   131					    size_t count, loff_t *ppos)
   132	{
   133		u8 cmd;
   134		int i, rc;
   135		int *idxp = file->private_data;
   136		int idx = *idxp;
   137		struct ibm_cffps *psu = to_psu(idxp, idx);
   138		char data[I2C_SMBUS_BLOCK_MAX] = { 0 };
   139	
   140		pmbus_set_page(psu->client, 0);
   141	
   142		switch (idx) {
   143		case CFFPS_DEBUGFS_INPUT_HISTORY:
   144			return ibm_cffps_read_input_history(psu, buf, count, ppos);
   145		case CFFPS_DEBUGFS_FRU:
   146			cmd = CFFPS_FRU_CMD;
   147			break;
   148		case CFFPS_DEBUGFS_PN:
   149			cmd = CFFPS_PN_CMD;
   150			break;
   151		case CFFPS_DEBUGFS_SN:
   152			cmd = CFFPS_SN_CMD;
   153			break;
   154		case CFFPS_DEBUGFS_CCIN:
   155			rc = i2c_smbus_read_word_swapped(psu->client, CFFPS_CCIN_CMD);
   156			if (rc < 0)
   157				return rc;
   158	
   159			rc = snprintf(data, 5, "%04X", rc);
   160			goto done;
   161		case CFFPS_DEBUGFS_FW:
   162			switch (psu->version) {
   163			case cffps1:
   164				for (i = 0; i < CFFPS1_FW_NUM_BYTES; ++i) {
   165					rc = i2c_smbus_read_byte_data(psu->client,
   166								      CFFPS_FW_CMD +
   167									i);
   168					if (rc < 0)
   169						return rc;
   170	
   171					snprintf(&data[i * 2], 3, "%02X", rc);
   172				}
   173	
   174				rc = i * 2;
   175				break;
   176			case cffps2:
   177				for (i = 0; i < CFFPS2_FW_NUM_WORDS; ++i) {
   178					rc = i2c_smbus_read_word_data(psu->client,
   179								      CFFPS_FW_CMD +
   180									i);
   181					if (rc < 0)
   182						return rc;
   183	
 > 184					snprintf(&data[i * 4], 5, "%04X", rc);
   185				}
   186	
   187				rc = i * 4;
   188				break;
   189			default:
   190				return -EOPNOTSUPP;
   191			}
   192			goto done;
   193		default:
   194			return -EINVAL;
   195		}
   196	
   197		rc = i2c_smbus_read_block_data(psu->client, cmd, data);
   198		if (rc < 0)
   199			return rc;
   200	
   201	done:
   202		data[rc] = '\n';
   203		rc += 2;
   204	
   205		return simple_read_from_buffer(buf, count, ppos, data, rc);
   206	}
   207	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

