Return-Path: <linux-kernel+bounces-18679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 035488260EA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 18:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FD8C282484
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 17:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD44C2CE;
	Sat,  6 Jan 2024 17:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bSY9MPxn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F3DC15F
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704562251; x=1736098251;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=yDdiujozwQBkl6LUfD1mgQJdMsZM4n6TnVP5IS61zUU=;
  b=bSY9MPxn9eg2dgkmLn9n4RHy4GtCNEkE63HVwtou2hAmbQFDKg6g0NJS
   UV6FDRTbgRMCNLuF4vQEtlYIfGxMJy2zR8YKqok+sdycF98y7jrCLKHZ9
   60Tjc4f4psyPykbR35FlvWrmHtQR5QsWEVhczKxeazzbllUumP+bptkkG
   x9e59Hups+HH4aL/lOnHNDqXSl5a7wKvjNCemUC5mbMI7Ygbq7Rs6vVLL
   ATJtEmlQNbM1fg9aWfwbBD7DuvOHYOJrVyaDRw+v8k7jU55k8aXK/8c70
   kTPvNYSB5VKo3eidsUGWb4lnjDqrGgjGULmLpc8kapGNl+bbYfcHD0zcq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="4763441"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="4763441"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 09:30:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="954249142"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="954249142"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 06 Jan 2024 09:30:48 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMAVS-0002o4-1Y;
	Sat, 06 Jan 2024 17:30:46 +0000
Date: Sun, 7 Jan 2024 01:30:35 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: drivers/infiniband/core/cm.c:1272:20: sparse: sparse: cast from
 restricted __be32
Message-ID: <202401070142.Q4XXLJwy-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   95c8a35f1c017327eab3b6a2ff5c04255737c856
commit: 34bd6d227ffc99d8ce1ced20bbfceacb14651869 arm64: dts: qcom: sc8280xp-pmics: Add support for PMK8280 RESIN input
date:   1 year, 2 months ago
config: i386-randconfig-062-20240106 (https://download.01.org/0day-ci/archive/20240107/202401070142.Q4XXLJwy-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240107/202401070142.Q4XXLJwy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401070142.Q4XXLJwy-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/infiniband/core/cm.c:1272:20: sparse: sparse: cast from restricted __be32

vim +1272 drivers/infiniband/core/cm.c

067b171b8679f9 Haggai Eran    2015-07-30  1265  
87a37ce9e400e4 Håkon Bugge    2018-07-04  1266  static __be64 cm_form_tid(struct cm_id_private *cm_id_priv)
a977049dacdef6 Hal Rosenstock 2005-07-27  1267  {
76039ac9095f5e Mark Zhang     2021-06-02  1268  	u64 hi_tid = 0, low_tid;
76039ac9095f5e Mark Zhang     2021-06-02  1269  
76039ac9095f5e Mark Zhang     2021-06-02  1270  	lockdep_assert_held(&cm_id_priv->lock);
a977049dacdef6 Hal Rosenstock 2005-07-27  1271  
87a37ce9e400e4 Håkon Bugge    2018-07-04 @1272  	low_tid = (u64)cm_id_priv->id.local_id;
76039ac9095f5e Mark Zhang     2021-06-02  1273  	if (!cm_id_priv->av.port)
76039ac9095f5e Mark Zhang     2021-06-02  1274  		return cpu_to_be64(low_tid);
76039ac9095f5e Mark Zhang     2021-06-02  1275  
76039ac9095f5e Mark Zhang     2021-06-02  1276  	spin_lock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
76039ac9095f5e Mark Zhang     2021-06-02  1277  	if (cm_id_priv->av.port->mad_agent)
76039ac9095f5e Mark Zhang     2021-06-02  1278  		hi_tid = ((u64)cm_id_priv->av.port->mad_agent->hi_tid) << 32;
76039ac9095f5e Mark Zhang     2021-06-02  1279  	spin_unlock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
a977049dacdef6 Hal Rosenstock 2005-07-27  1280  	return cpu_to_be64(hi_tid | low_tid);
a977049dacdef6 Hal Rosenstock 2005-07-27  1281  }
a977049dacdef6 Hal Rosenstock 2005-07-27  1282  

:::::: The code at line 1272 was first introduced by commit
:::::: 87a37ce9e400e40daee537ff95343e3c94743c6d IB/cm: Remove unused and erroneous msg sequence encoding

:::::: TO: Håkon Bugge <haakon.bugge@oracle.com>
:::::: CC: Jason Gunthorpe <jgg@mellanox.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

