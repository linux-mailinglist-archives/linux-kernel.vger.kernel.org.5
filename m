Return-Path: <linux-kernel+bounces-1981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B30758156B0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37F7CB23D91
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 03:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3330B3FFB;
	Sat, 16 Dec 2023 03:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="im7EyT/Y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56251C32
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 03:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702696680; x=1734232680;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HabsVh6nLjBPNxyP+dgadBAqyokSuLh5oGVE4JhJ5L4=;
  b=im7EyT/YwGvntBgaAYO0vtkDpgQ2oKkvvD9IWY/nF34rh+oUbsNZeIRh
   gD7DrTLKjpRuGYs7zM8CIF8iEoGAHV+YcAZkuvBGiMBQpt74LVASZ7slG
   SnnP/U0Mn5MwaPC8FAQBYPn1VQRu9xjtNlqS9EOLMDiiODIUEuUnFRhhT
   jsxV7OAZkMDQwIqQvNmo9Zwf5jvp4liq44IPnjqs/SY6jdeCblW9QxRDQ
   HASNfNBTejjRbbcvFhuLgB0o57e1F6g/hPJpkk17RNofbtEQSI9WfRzk3
   ZqHNsxsshxVUCrEWMg5rOSXkUC35S1qn0fYV7tPITnZqpNBawJHgVOKox
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="461812245"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="461812245"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 19:18:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="724650668"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="724650668"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 15 Dec 2023 19:17:59 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rELBc-00015m-24;
	Sat, 16 Dec 2023 03:17:56 +0000
Date: Sat, 16 Dec 2023 11:17:15 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: scripts/kernel-doc: arch/arm/mach-sa1100/ssp.c:89: warning: Function
 parameter or struct member 'data' not described in 'ssp_read_word'
Message-ID: <202312161102.YBrHFedc-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3bd7d748816927202268cb335921f7f68b3ca723
commit: 8faf91c48ca20c714e0dd8cc5f510e3819852912 ARM: sa1100: un-deprecate jornada720
date:   11 months ago
config: arm-jornada720_defconfig (https://download.01.org/0day-ci/archive/20231216/202312161102.YBrHFedc-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231216/202312161102.YBrHFedc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312161102.YBrHFedc-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> scripts/kernel-doc: arch/arm/mach-sa1100/ssp.c:89: warning: Function parameter or struct member 'data' not described in 'ssp_read_word'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for SA1100_SSP
   Depends on [n]: ARCH_SA1100 [=y] && UNUSED_BOARD_FILES [=n]
   Selected by [y]:
   - SA1100_JORNADA720_SSP [=y] && ARCH_SA1100 [=y] && SA1100_JORNADA720 [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

