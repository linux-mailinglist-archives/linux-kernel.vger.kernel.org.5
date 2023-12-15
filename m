Return-Path: <linux-kernel+bounces-267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A2B813E76
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 01:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC8F4B21C3C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AD2182B3;
	Fri, 15 Dec 2023 00:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W3HYZXg/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9410B1FBC
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 00:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702598443; x=1734134443;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tcpcAlMdKKK06C/33apeXcQu5usHl/ntthMI7bkHjxY=;
  b=W3HYZXg/FJnpSEeWflOfl6K6Fp+IGR/PI9d9I7eg31u74Z+fBBLc8zdV
   1Rb4YJFSsKSO5Q60nEcuAzoGk+i4T0XlYLQqSWKsRttCJ8BnTDJfrax1N
   fpsbkYMSdFxFD3C2c/OyMdOA/MSIEIWzvvG1nWgwS3VrSgWHldIDiBfHX
   bspkec1FaOUYvBcvMlOfUoSzSE2Q7gJI2CYKr9hy5DDEpZsMeV0YX1ryO
   sYUPOffrujjKKS2TkIEcGURV4DUtRwes1QoB21ZjIvXFWAJuSlleXf7Hx
   MIT7EsSot25qVo/m/uuJ7hPgfMSHPls8QZinm+6kURVgBL0tfHMAeat5o
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="380200328"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="380200328"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 16:00:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="892676037"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="892676037"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 14 Dec 2023 16:00:41 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDvd9-000Mm6-2z;
	Fri, 15 Dec 2023 00:00:39 +0000
Date: Fri, 15 Dec 2023 08:00:12 +0800
From: kernel test robot <lkp@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts
Message-ID: <202312150734.dBgwSGBp-lkp@intel.com>
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
commit: 833e622459432ed5bc7cc58ffadb91b59c863a3a genksyms: generate lexer and parser during build instead of shipping
date:   6 years ago
config: x86_64-buildonly-randconfig-006-20230830 (https://download.01.org/0day-ci/archive/20231215/202312150734.dBgwSGBp-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231215/202312150734.dBgwSGBp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312150734.dBgwSGBp-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
>> scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
--
>> scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
>> scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
>> scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
>> scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

