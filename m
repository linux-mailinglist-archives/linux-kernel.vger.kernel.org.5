Return-Path: <linux-kernel+bounces-21438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD356828F20
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 138AAB2476C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303AE3DB98;
	Tue,  9 Jan 2024 21:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gcaKChwW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A943DB89
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 21:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704836638; x=1736372638;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tj+0C4n/drvfg0qVu2elx57BhD5hX6wUCR9fvyug+XQ=;
  b=gcaKChwWarIlMCIqY8OjVQL9GQGEHdobemlkbvo2g/Fp84VngOYAZlek
   dxF8hDufhcsiJ7eA/rBau2hv2yoPg15JBchQL4oStZ58qK6q3k2/vNxSz
   x8ZSaFjcoA8l5Tm3YLt4b/gYGPSmSQNLlaJXMYG9eGFkzFuUfLY999O/5
   +uaKEkPqerN1iZ0hUO/4HvWNRBW4Iubz0DeeL9e+L5k364+eJUUPZT8XJ
   +Skd+s3jDoRHpvmxjCfWI4Hn3OGudUU/R3tCEx+F/ssVZKdZf4xG1OdjK
   NUCgIv0iRT5hjq4N5LbYnM2/qhdozfZnQF6xQCFseSR751il7z5Xvf1BY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="11676500"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="11676500"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 13:43:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="731618178"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="731618178"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 09 Jan 2024 13:43:55 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNJt2-0006Hi-2z;
	Tue, 09 Jan 2024 21:43:52 +0000
Date: Wed, 10 Jan 2024 05:43:33 +0800
From: kernel test robot <lkp@intel.com>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: drivers/nvme/target/trace.h:56:9: warning: 'strncpy' specified bound
 depends on the length of the source argument
Message-ID: <202401100527.L7RokChn-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Chaitanya,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9f8413c4a66f2fb776d3dc3c9ed20bf435eb305e
commit: d86481e924a7d6e8a40477ffa98077c6c0d77ed5 nvmet: use min of device_path and disk len
date:   2 years, 11 months ago
config: arm64-randconfig-002-20240106 (https://download.01.org/0day-ci/archive/20240110/202401100527.L7RokChn-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240110/202401100527.L7RokChn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401100527.L7RokChn-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/nvme/target/core.c:14:
   In function '__assign_req_name',
       inlined from 'trace_event_raw_event_nvmet_req_init' at drivers/nvme/target/./trace.h:61:1:
>> drivers/nvme/target/trace.h:56:9: warning: 'strncpy' specified bound depends on the length of the source argument [-Wstringop-truncation]
      56 |         strncpy(name, req->ns->device_path,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      57 |                 min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path)));
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:14,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from drivers/nvme/target/core.c:7:
   drivers/nvme/target/trace.h:57:46: note: length computed here
      57 |                 min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path)));
   include/linux/minmax.h:38:39: note: in definition of macro '__cmp_once'
      38 |                 typeof(y) unique_y = (y);               \
         |                                       ^
   include/linux/minmax.h:110:33: note: in expansion of macro '__careful_cmp'
     110 | #define min_t(type, x, y)       __careful_cmp((type)(x), (type)(y), <)
         |                                 ^~~~~~~~~~~~~
   drivers/nvme/target/trace.h:57:17: note: in expansion of macro 'min_t'
      57 |                 min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path)));
         |                 ^~~~~
   In function '__assign_req_name',
       inlined from 'trace_event_raw_event_nvmet_req_complete' at drivers/nvme/target/./trace.h:103:1:
>> drivers/nvme/target/trace.h:56:9: warning: 'strncpy' specified bound depends on the length of the source argument [-Wstringop-truncation]
      56 |         strncpy(name, req->ns->device_path,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      57 |                 min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path)));
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/target/trace.h:57:46: note: length computed here
      57 |                 min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path)));
   include/linux/minmax.h:38:39: note: in definition of macro '__cmp_once'
      38 |                 typeof(y) unique_y = (y);               \
         |                                       ^
   include/linux/minmax.h:110:33: note: in expansion of macro '__careful_cmp'
     110 | #define min_t(type, x, y)       __careful_cmp((type)(x), (type)(y), <)
         |                                 ^~~~~~~~~~~~~
   drivers/nvme/target/trace.h:57:17: note: in expansion of macro 'min_t'
      57 |                 min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path)));
         |                 ^~~~~
   In function '__assign_req_name',
       inlined from 'perf_trace_nvmet_req_complete' at drivers/nvme/target/./trace.h:103:1:
>> drivers/nvme/target/trace.h:56:9: warning: 'strncpy' specified bound depends on the length of the source argument [-Wstringop-truncation]
      56 |         strncpy(name, req->ns->device_path,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      57 |                 min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path)));
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/target/trace.h:57:46: note: length computed here
      57 |                 min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path)));
   include/linux/minmax.h:38:39: note: in definition of macro '__cmp_once'
      38 |                 typeof(y) unique_y = (y);               \
         |                                       ^
   include/linux/minmax.h:110:33: note: in expansion of macro '__careful_cmp'
     110 | #define min_t(type, x, y)       __careful_cmp((type)(x), (type)(y), <)
         |                                 ^~~~~~~~~~~~~
   drivers/nvme/target/trace.h:57:17: note: in expansion of macro 'min_t'
      57 |                 min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path)));
         |                 ^~~~~
   In function '__assign_req_name',
       inlined from 'perf_trace_nvmet_req_init' at drivers/nvme/target/./trace.h:61:1:
>> drivers/nvme/target/trace.h:56:9: warning: 'strncpy' specified bound depends on the length of the source argument [-Wstringop-truncation]
      56 |         strncpy(name, req->ns->device_path,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      57 |                 min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path)));
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/target/trace.h:57:46: note: length computed here
      57 |                 min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path)));
   include/linux/minmax.h:38:39: note: in definition of macro '__cmp_once'
      38 |                 typeof(y) unique_y = (y);               \
         |                                       ^
   include/linux/minmax.h:110:33: note: in expansion of macro '__careful_cmp'
     110 | #define min_t(type, x, y)       __careful_cmp((type)(x), (type)(y), <)
         |                                 ^~~~~~~~~~~~~
   drivers/nvme/target/trace.h:57:17: note: in expansion of macro 'min_t'
      57 |                 min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path)));
         |                 ^~~~~


vim +/strncpy +56 drivers/nvme/target/trace.h

    48	
    49	static inline void __assign_req_name(char *name, struct nvmet_req *req)
    50	{
    51		if (!req->ns) {
    52			memset(name, 0, DISK_NAME_LEN);
    53			return;
    54		}
    55	
  > 56		strncpy(name, req->ns->device_path,
    57			min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path)));
    58	}
    59	#endif
    60	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

