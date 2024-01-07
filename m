Return-Path: <linux-kernel+bounces-18747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3574826280
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 01:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E349B21D28
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 00:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECA115A6;
	Sun,  7 Jan 2024 00:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T/MEG4Um"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AA3136F
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 00:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704587681; x=1736123681;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Jc1fr3TXXUiLWh/K84lcAKk/jX1fGwGlU8eyrDNE7+k=;
  b=T/MEG4UmcpWjHuQHnrOty4UVwygkst5Lkk6xDbwG2ADQkP6WWUniAer+
   PmfFlDjYKuZHxN+EKADu8AgqOmgto/DAReso6KLEAQoZINdYzFo1TUvdV
   LZQeXvaYZ+5D8axxkqBCSzOWuxhMTW2UNcla76Qz8Px90DsiFvcizZ2WY
   3bvPpSdD+1+kKr+DpeWAgW4vXie8JIB09sPJVj0Yx2fWwX+AuwKk558vH
   R4u5D+L1V4Tk2a+Y/98Mm67B/wW+m/vTy8vO3WRJXhc+H7AgoYrnWMGqX
   js3IVgD3Gny9IvmXn3x1D3J+dvCG2vsYikvh9t6fCz2GlV7h5ClnlL1k1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="4445188"
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="4445188"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 16:34:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="809877671"
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="809877671"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 06 Jan 2024 16:34:38 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMH7b-0003Cq-2g;
	Sun, 07 Jan 2024 00:34:35 +0000
Date: Sun, 7 Jan 2024 08:33:47 +0800
From: kernel test robot <lkp@intel.com>
To: Ang Tien Sung <tien.sung.ang@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dinh Nguyen <dinguyen@kernel.org>
Subject: drivers/firmware/stratix10-svc.c:58: warning: Function parameter or
 member 'intel_svc_fcs' not described in 'stratix10_svc'
Message-ID: <202401070808.wIHGhXPr-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ang,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   52b1853b080a082ec3749c3a9577f6c71b1d4a90
commit: e6281c26674e037798bf674f26a7593a324cdf39 firmware: stratix10-svc: Add support for FCS
date:   1 year, 6 months ago
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240107/202401070808.wIHGhXPr-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240107/202401070808.wIHGhXPr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401070808.wIHGhXPr-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/firmware/stratix10-svc.c:58: warning: Function parameter or member 'intel_svc_fcs' not described in 'stratix10_svc'


vim +58 drivers/firmware/stratix10-svc.c

7ca5ce896524f5 Richard Gong  2018-11-13  50  
b5dc75c915cdae Richard Gong  2019-09-03  51  /**
b5dc75c915cdae Richard Gong  2019-09-03  52   * struct stratix10_svc - svc private data
b5dc75c915cdae Richard Gong  2019-09-03  53   * @stratix10_svc_rsu: pointer to stratix10 RSU device
b5dc75c915cdae Richard Gong  2019-09-03  54   */
b5dc75c915cdae Richard Gong  2019-09-03  55  struct stratix10_svc {
b5dc75c915cdae Richard Gong  2019-09-03  56  	struct platform_device *stratix10_svc_rsu;
e6281c26674e03 Ang Tien Sung 2022-07-11  57  	struct platform_device *intel_svc_fcs;
b5dc75c915cdae Richard Gong  2019-09-03 @58  };
b5dc75c915cdae Richard Gong  2019-09-03  59  

:::::: The code at line 58 was first introduced by commit
:::::: b5dc75c915cdaebab9b9875022e45638d6b14a7e firmware: stratix10-svc: extend svc to support new RSU features

:::::: TO: Richard Gong <richard.gong@intel.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

