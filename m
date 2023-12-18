Return-Path: <linux-kernel+bounces-2954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A3D816527
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 03:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 908DF281BB3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 02:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB7429AF;
	Mon, 18 Dec 2023 02:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VmVapPzn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2BF3C16
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 02:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702868359; x=1734404359;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ix+RIqgS9O5+g+wip7SZp6Oy9GhVKpNKHDFmWD+npWA=;
  b=VmVapPznY4d0uzOtlZP0YRhIIAfqLy31ytMBLzil4X5C8o5QmAJf9sH6
   3YlZP5AczSc5FtJRD+Fz9SFBHIrht02gS1EXxXg76uIKnDbcdiHBb8Yd+
   jaB3JFfHPH16VSist+lsu+bEw7CpwslCsdITfEg/SoVCG28yo5iGJINqq
   jqNCWe3odMP35tolVZ3kUGXUeFFb0y7gtnkPIj9syp50qffrROveDe0oD
   k1p/N8rGsZI4/IKyJBKocgE7s+t1PeEHQ2OsJMmZB/+IMkUIdJhf8xa7/
   QirzKskbCg/v607EkDY6GVllJsZXCjL0HivjnSKU2leduH+bHCdThwSF2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="461903714"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="461903714"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 18:59:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="751597377"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="751597377"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 17 Dec 2023 18:59:16 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rF3qd-0003hB-0K;
	Mon, 18 Dec 2023 02:59:15 +0000
Date: Mon, 18 Dec 2023 10:58:56 +0800
From: kernel test robot <lkp@intel.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Miroslav Benes <mbenes@suse.cz>
Subject: drivers/video/fbdev/omap2/omapfb/dss/omapdss.o: warning: objtool:
 hdmi_power_on_full.isra.0+0xcd: hdmi_pll_compute() is missing a __noreturn
 annotation
Message-ID: <202312181048.k6iQRj1R-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Josh,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ceb6a6f023fd3e8b07761ed900352ef574010bcb
commit: fedb724c3db5490234ddde0103811c28c2fedae0 objtool: Detect missing __noreturn annotations
date:   7 months ago
config: x86_64-buildonly-randconfig-r003-20211101 (https://download.01.org/0day-ci/archive/20231218/202312181048.k6iQRj1R-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231218/202312181048.k6iQRj1R-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312181048.k6iQRj1R-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/video/fbdev/omap2/omapfb/dss/omapdss.o: warning: objtool: hdmi_power_on_full.isra.0+0xcd: hdmi_pll_compute() is missing a __noreturn annotation


objdump-func vmlinux.o hdmi_power_on_full.isra.0:

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

