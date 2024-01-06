Return-Path: <linux-kernel+bounces-18442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8674825D9B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 02:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0051F24232
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 01:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3DA15A8;
	Sat,  6 Jan 2024 01:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="deRUyUk6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B555E1374
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 01:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704504184; x=1736040184;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oUD5nPwpRpz4iuTXPl6a9Ihv7rV6n2mrRMaWybo8RzI=;
  b=deRUyUk6ypYM9SI4WZMiMv0vu9HVE8z31XjJ5E555TixReP3yKJLBEnd
   Tlc3YklUlOnn8SK7QcxK5jCKBeYBUqhN4iYOP+J4OP6ZPVVk7mwTGmV5Y
   Zibz2XjgEfiYG9/XGRsAx7ZbysIkF1isLl3CGVANY/yKSJ8o7s+M9hgJl
   kH3YtnNFzTzZQpXbkgKp9MmH7pBeUlhygIphJh0RCWhwj0OudTaZ7nDz/
   duYZNRyUr75fj277bHrg2iKF0sOBSyDwfj+qR+Jndv6nVIEseBHur7C5h
   u3chhSuhaabUo77pPPl9XQUEfFmqkuoVue5balRVku21D1v2WrigTkQSa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="4390651"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="4390651"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 17:23:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="22653409"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 05 Jan 2024 17:23:02 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rLvOt-0001sT-2g;
	Sat, 06 Jan 2024 01:22:59 +0000
Date: Sat, 6 Jan 2024 09:22:50 +0800
From: kernel test robot <lkp@intel.com>
To: Robert Marko <robimarko@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Kalle Valo <quic_kvalo@quicinc.com>
Subject: drivers/net/wireless/ath/ath10k/core.c:893:50: warning: '%s'
 directive output may be truncated writing up to 99 bytes into a region of
 size between 98 and 99
Message-ID: <202401060901.bCLLpa8q-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a4ab2706bb1280693e7dff1c5c42a8cb9d70c177
commit: f2a7064a78b22f2b68b9fcbc8a6f4c5e61c5ba64 ath10k: support bus and device specific API 1 BDF selection
date:   1 year, 8 months ago
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240106/202401060901.bCLLpa8q-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240106/202401060901.bCLLpa8q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401060901.bCLLpa8q-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/wireless/ath/ath10k/core.c: In function 'ath10k_core_fetch_board_file':
>> drivers/net/wireless/ath/ath10k/core.c:893:50: warning: '%s' directive output may be truncated writing up to 99 bytes into a region of size between 98 and 99 [-Wformat-truncation=]
     893 |         snprintf(filename, sizeof(filename), "%s/%s", dir, file);
         |                                                  ^~
   ......
    1247 |                 ar->normal_mode_fw.board = ath10k_fetch_fw_file(ar,
         |                                            ~~~~~~~~~~~~~~~~~~~~~~~~
    1248 |                                                                 ar->hw_params.fw.dir,
         |                                                                 ~~~~~~~~~~~~~~~~~~~~~
    1249 |                                                                 boardname);
         |                                                                 ~~~~~~~~~~
   In function 'ath10k_fetch_fw_file',
       inlined from 'ath10k_core_fetch_board_data_api_1' at drivers/net/wireless/ath/ath10k/core.c:1247:30,
       inlined from 'ath10k_core_fetch_board_file' at drivers/net/wireless/ath/ath10k/core.c:1620:8:
   drivers/net/wireless/ath/ath10k/core.c:893:9: note: 'snprintf' output 2 or more bytes (assuming 102) into a destination of size 100
     893 |         snprintf(filename, sizeof(filename), "%s/%s", dir, file);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +893 drivers/net/wireless/ath/ath10k/core.c

5e3dd157d7e70f Kalle Valo       2013-06-12  878  
5e3dd157d7e70f Kalle Valo       2013-06-12  879  static const struct firmware *ath10k_fetch_fw_file(struct ath10k *ar,
5e3dd157d7e70f Kalle Valo       2013-06-12  880  						   const char *dir,
5e3dd157d7e70f Kalle Valo       2013-06-12  881  						   const char *file)
5e3dd157d7e70f Kalle Valo       2013-06-12  882  {
5e3dd157d7e70f Kalle Valo       2013-06-12  883  	char filename[100];
5e3dd157d7e70f Kalle Valo       2013-06-12  884  	const struct firmware *fw;
5e3dd157d7e70f Kalle Valo       2013-06-12  885  	int ret;
5e3dd157d7e70f Kalle Valo       2013-06-12  886  
5e3dd157d7e70f Kalle Valo       2013-06-12  887  	if (file == NULL)
5e3dd157d7e70f Kalle Valo       2013-06-12  888  		return ERR_PTR(-ENOENT);
5e3dd157d7e70f Kalle Valo       2013-06-12  889  
5e3dd157d7e70f Kalle Valo       2013-06-12  890  	if (dir == NULL)
5e3dd157d7e70f Kalle Valo       2013-06-12  891  		dir = ".";
5e3dd157d7e70f Kalle Valo       2013-06-12  892  
5e3dd157d7e70f Kalle Valo       2013-06-12 @893  	snprintf(filename, sizeof(filename), "%s/%s", dir, file);
c8e028026387ea Andres Rodriguez 2018-05-10  894  	ret = firmware_request_nowarn(&fw, filename, ar->dev);
9f5bcfe93315d7 Michal Kazior    2017-02-13  895  	ath10k_dbg(ar, ATH10K_DBG_BOOT, "boot fw request '%s': %d\n",
9f5bcfe93315d7 Michal Kazior    2017-02-13  896  		   filename, ret);
9f5bcfe93315d7 Michal Kazior    2017-02-13  897  
5e3dd157d7e70f Kalle Valo       2013-06-12  898  	if (ret)
5e3dd157d7e70f Kalle Valo       2013-06-12  899  		return ERR_PTR(ret);
5e3dd157d7e70f Kalle Valo       2013-06-12  900  
5e3dd157d7e70f Kalle Valo       2013-06-12  901  	return fw;
5e3dd157d7e70f Kalle Valo       2013-06-12  902  }
5e3dd157d7e70f Kalle Valo       2013-06-12  903  

:::::: The code at line 893 was first introduced by commit
:::::: 5e3dd157d7e70f0e3cea3f2573ed69fb156a19d5 ath10k: mac80211 driver for Qualcomm Atheros 802.11ac CQA98xx devices

:::::: TO: Kalle Valo <kvalo@qca.qualcomm.com>
:::::: CC: Kalle Valo <kvalo@qca.qualcomm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

