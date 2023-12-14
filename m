Return-Path: <linux-kernel+bounces-180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B54813D1F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF5F3B21A3B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB33767206;
	Thu, 14 Dec 2023 22:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jy7I3aQd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAD0671FA
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 22:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702592428; x=1734128428;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2oxF91UwycN6W6BYGY4eiJniIvw65cXKbdqHisPMh74=;
  b=jy7I3aQdhbUviktJ5MMR0vZuGUJ1iqVlLL5iextvzKsUAlbtnvHCOFxR
   c2L4W3IJLwujpXt8AQw60mfE9ku3+q9cBY+zS2rBbyAIs3vQoWsi35YZ5
   Q/0HbzPeWUmN2khe2O1pWsx21ZPsU9Yawx/fj0XANJEC1PsWub7X0kxx6
   /3MFQFCMIIiOeo/9+mQa/cFra/dFKcvm2fQcFqk5wEld/oOCwuRsFKtqJ
   ilBqu/ZbV2NryRHzc6rJboPkRNuZjXKReU1TZObTHYZmzbohlWfAlkNOQ
   898LwS03NXcwarrJj4oTfVz+J5tyOafhurWD/lVPxqZPRl5YsOg+Fgbal
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="380187576"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="380187576"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 14:20:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="892648043"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="892648043"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 14 Dec 2023 14:20:26 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDu48-000Mef-2e;
	Thu, 14 Dec 2023 22:20:24 +0000
Date: Fri, 15 Dec 2023 06:19:56 +0800
From: kernel test robot <lkp@intel.com>
To: Kees Cook <keescook@chromium.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: drivers/reset/core.c:64: warning: Excess struct member 'rstc'
 description in 'reset_control_array'
Message-ID: <202312150614.kOx8xUkr-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c7402612e2e61b76177f22e6e7f705adcbecc6fe
commit: fed2ef7abaebe5e0207cd52ae52721ea3da3b5ba reset: Annotate struct reset_control_array with __counted_by
date:   7 weeks ago
config: arm-randconfig-r081-20231214 (https://download.01.org/0day-ci/archive/20231215/202312150614.kOx8xUkr-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231215/202312150614.kOx8xUkr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312150614.kOx8xUkr-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/reset/core.c:64: warning: Excess struct member 'rstc' description in 'reset_control_array'


vim +64 drivers/reset/core.c

61fc41317666be Philipp Zabel 2012-11-19  53  
17c82e206d2a3c Vivek Gautam  2017-05-22  54  /**
17c82e206d2a3c Vivek Gautam  2017-05-22  55   * struct reset_control_array - an array of reset controls
17c82e206d2a3c Vivek Gautam  2017-05-22  56   * @base: reset control for compatibility with reset control API functions
17c82e206d2a3c Vivek Gautam  2017-05-22  57   * @num_rstcs: number of reset controls
17c82e206d2a3c Vivek Gautam  2017-05-22  58   * @rstc: array of reset controls
17c82e206d2a3c Vivek Gautam  2017-05-22  59   */
17c82e206d2a3c Vivek Gautam  2017-05-22  60  struct reset_control_array {
17c82e206d2a3c Vivek Gautam  2017-05-22  61  	struct reset_control base;
17c82e206d2a3c Vivek Gautam  2017-05-22  62  	unsigned int num_rstcs;
fed2ef7abaebe5 Kees Cook     2023-09-22  63  	struct reset_control *rstc[] __counted_by(num_rstcs);
17c82e206d2a3c Vivek Gautam  2017-05-22 @64  };
17c82e206d2a3c Vivek Gautam  2017-05-22  65  

:::::: The code at line 64 was first introduced by commit
:::::: 17c82e206d2a3cd876b64921c59116f1ecdce6ad reset: Add APIs to manage array of resets

:::::: TO: Vivek Gautam <vivek.gautam@codeaurora.org>
:::::: CC: Philipp Zabel <p.zabel@pengutronix.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

