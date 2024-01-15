Return-Path: <linux-kernel+bounces-25599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B2D82D332
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 03:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBD93B20D31
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 02:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F6E1874;
	Mon, 15 Jan 2024 02:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G4uob0gd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB81F17CB
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 02:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705287291; x=1736823291;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=srwuYYGom2ZS4W5k3lZVCuKq6F8VJrRPXChD69St4WQ=;
  b=G4uob0gd7Npr7+n9f7bQy21xpww3LQKEKDKicLgQDTv+ZwwhnTiTgM0u
   sCA9t2NGmIxPfYQKiVKn5xjtvwxGzYKk6/a/VXp1eAOehZ7qpi3JsCYmH
   iDhLKtI0Fsq0ItM7LwMgcGUGtxpxCsXs//VXGgNguZXnm2milh5RUAj4e
   /5eD6TgRLwVr0ZfzApDqIm5HGSB6wYFvPLymNKbin1Z0iWK/uxBja3l+Y
   Ofk/d6FoIau3W2TsxioECjUxqlW3sQYCqIQjIDzKaNoJRwStALmEPZIAt
   xMc59o3K9rxmUJZe5lRO1M2VoWeH0KjnlU52osXzLHGZ3X9zeXHNJnjs3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="6616597"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; 
   d="scan'208";a="6616597"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 18:54:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="733176597"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; 
   d="scan'208";a="733176597"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 14 Jan 2024 18:54:47 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rPD7a-000C2O-0M;
	Mon, 15 Jan 2024 02:54:42 +0000
Date: Mon, 15 Jan 2024 10:53:48 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Brian Norris <briannorris@chromium.org>,
	Julius Werner <jwerner@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] firmware: google: cbmem: Add to module device table
Message-ID: <202401151013.Xioj5wZo-lkp@intel.com>
References: <20240111151226.842603-4-nfraprado@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240111151226.842603-4-nfraprado@collabora.com>

Hi Nícolas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20240111]
[also build test WARNING on v6.7]
[cannot apply to chrome-platform/for-next chrome-platform/for-firmware-next masahiroy-kbuild/for-next masahiroy-kbuild/fixes arm64/for-next/core linus/master v6.7 v6.7-rc8 v6.7-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/N-colas-F-R-A-Prado/firmware-coreboot-Generate-modalias-uevent-for-devices/20240111-231841
base:   next-20240111
patch link:    https://lore.kernel.org/r/20240111151226.842603-4-nfraprado%40collabora.com
patch subject: [PATCH 3/4] firmware: google: cbmem: Add to module device table
config: i386-randconfig-013-20240115 (https://download.01.org/0day-ci/archive/20240115/202401151013.Xioj5wZo-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240115/202401151013.Xioj5wZo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401151013.Xioj5wZo-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/firmware/google/cbmem.c:118:40: warning: unused variable 'cbmem_ids' [-Wunused-const-variable]
     118 | static const struct coreboot_device_id cbmem_ids[] = {
         |                                        ^~~~~~~~~
   1 warning generated.


vim +/cbmem_ids +118 drivers/firmware/google/cbmem.c

   117	
 > 118	static const struct coreboot_device_id cbmem_ids[] = {
   119		{ .tag = LB_TAG_CBMEM_ENTRY },
   120		{ /* sentinel */ }
   121	};
   122	MODULE_DEVICE_TABLE(coreboot, cbmem_ids);
   123	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

