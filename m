Return-Path: <linux-kernel+bounces-130513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8E6897923
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FCE31C260CF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE7D155394;
	Wed,  3 Apr 2024 19:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aFP1pcpT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D8D1401C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 19:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712173276; cv=none; b=cNHAwZnYjDvcoAh/K94gLTmNztzFXUmwMSAm+Zma2Zs1LVCRNsv1c9slNj2bThOnAFRD6NhNObpZGz9xog6V/yEiv8g3hd8kYsfhL9wAtzyAQGlVgvyWtV6eD09kNFRWJdiatccgtbP+LBQwhQRD9MijsR3mr2RFBrVvplFjhSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712173276; c=relaxed/simple;
	bh=wtgsOTWcDcU1QVgdYyI9WTvp94IoEhdztTk9LKgRQ5o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rKhEqWBTfVHL56sM93VPRJebcvLdT/DAFEG4NOJDRQ21Ujqgt9zNafnOMq41tDrxDnlaq/r2dS68YTT+Ee0eobnapl1k/H+I1YreJZlV4HsdXwDD383dwR0d2f7mBdYPZYtMskCKqv3wNqiRe2Lqbk/Ur8AuQeRkCZLE5yqHtIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aFP1pcpT; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712173274; x=1743709274;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wtgsOTWcDcU1QVgdYyI9WTvp94IoEhdztTk9LKgRQ5o=;
  b=aFP1pcpTnOUM0R8ml9pGp8Y+h6H1iY/uUAyvo1gnPKiS2DSvWUWMtIaJ
   Css8JfHjCw2b6cqqvO5K8r1qofWf/wtzAaUlaPOtRdG2a8tYKm3siJqVl
   L6AxpCfq2qVyoy8QEuq6FAzaF3RZZMfkV9JS8vhc2J85pCKm2vppFcygk
   PEOTn85IHxHW6hvPE9/YNAEVVeiax/uFaXdCTjtIdKvfTQSsdIhvwMOor
   B7CtQFWtE0xBXDpXrReSgrBXJ05lCt+559jS7uJpK6y1z2Besvahchx7B
   vScrgZNsdDUotoVhVbCDSaH+LLoxDdzWp9NmSyyURCzUyMIsbssqQi8zb
   w==;
X-CSE-ConnectionGUID: XoHyOXoAR2a5fxwOAU1SkQ==
X-CSE-MsgGUID: 5rEsUEr7SLaoMEPsA+yxDQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7618104"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7618104"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 12:41:13 -0700
X-CSE-ConnectionGUID: 5iv+8BkpSdqtG4B9arNTIQ==
X-CSE-MsgGUID: 6+8/0VDnRaO+EoncGVhshA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="19147943"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 03 Apr 2024 12:41:11 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rs6Ts-0000Ao-31;
	Wed, 03 Apr 2024 19:41:08 +0000
Date: Thu, 4 Apr 2024 03:40:24 +0800
From: kernel test robot <lkp@intel.com>
To: Liming Sun <limings@nvidia.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	David Thompson <davthompson@nvidia.com>
Subject: drivers/platform/mellanox/mlxbf-tmfifo.c:275:38: sparse: sparse:
 incorrect type in assignment (different base types)
Message-ID: <202404040339.S7CUIgf3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c85af715cac0a951eea97393378e84bb49384734
commit: 78034cbece79c2d730ad0770b3b7f23eedbbecf5 platform/mellanox: mlxbf-tmfifo: Drop the Rx packet if no more descriptors
date:   7 months ago
config: arm64-randconfig-r112-20240404 (https://download.01.org/0day-ci/archive/20240404/202404040339.S7CUIgf3-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 546dc2245ffc4cccd0b05b58b7a5955e355a3b27)
reproduce: (https://download.01.org/0day-ci/archive/20240404/202404040339.S7CUIgf3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404040339.S7CUIgf3-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/platform/mellanox/mlxbf-tmfifo.c:275:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __virtio32 [usertype] len @@     got unsigned long @@
   drivers/platform/mellanox/mlxbf-tmfifo.c:275:38: sparse:     expected restricted __virtio32 [usertype] len
   drivers/platform/mellanox/mlxbf-tmfifo.c:275:38: sparse:     got unsigned long

vim +275 drivers/platform/mellanox/mlxbf-tmfifo.c

   257	
   258	/* Allocate vrings for the FIFO. */
   259	static int mlxbf_tmfifo_alloc_vrings(struct mlxbf_tmfifo *fifo,
   260					     struct mlxbf_tmfifo_vdev *tm_vdev)
   261	{
   262		struct mlxbf_tmfifo_vring *vring;
   263		struct device *dev;
   264		dma_addr_t dma;
   265		int i, size;
   266		void *va;
   267	
   268		for (i = 0; i < ARRAY_SIZE(tm_vdev->vrings); i++) {
   269			vring = &tm_vdev->vrings[i];
   270			vring->fifo = fifo;
   271			vring->num = MLXBF_TMFIFO_VRING_SIZE;
   272			vring->align = SMP_CACHE_BYTES;
   273			vring->index = i;
   274			vring->vdev_id = tm_vdev->vdev.id.device;
 > 275			vring->drop_desc.len = VRING_DROP_DESC_MAX_LEN;
   276			dev = &tm_vdev->vdev.dev;
   277	
   278			size = vring_size(vring->num, vring->align);
   279			va = dma_alloc_coherent(dev->parent, size, &dma, GFP_KERNEL);
   280			if (!va) {
   281				mlxbf_tmfifo_free_vrings(fifo, tm_vdev);
   282				dev_err(dev->parent, "dma_alloc_coherent failed\n");
   283				return -ENOMEM;
   284			}
   285	
   286			vring->va = va;
   287			vring->dma = dma;
   288		}
   289	
   290		return 0;
   291	}
   292	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

