Return-Path: <linux-kernel+bounces-6487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ACF819982
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D132D1F257A6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B116C1C6B7;
	Wed, 20 Dec 2023 07:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TozwqxXQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A578A1C695
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703057400; x=1734593400;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BLjDO7r5mLL+cu5RRPPq2ChE9x4K9wfxRNFUHoEs1iw=;
  b=TozwqxXQg/xmvD3JMeqiL6dPpb5i4duvESg//k0RU+z2vbi2lKOmjbG2
   zVCPQBVgLlOV4y+SnyBCJyqSV88XNdlx5z2s0o2ySQlEbBsTVUkJ5aKQE
   9JlSEhvEAo3tKKeNHxE1kTZfh2SMcxExXY6Tt5flttNqTh1/YAjtlLH+h
   bxMS4y9C7HWI/De6dC+aue3iiy4/sEtJ1sIpklFgXnmLTCwohHL+mhgrb
   qUKnFhTK2EyvEfZeBNPJo+wBaOyCujNDtOJqBtM+oQ/+7aYyxlRrUMJDu
   wPbAMPGyVoOECc7LdtAWf1NpoOpp8DWoUHvoDmRsCsFVB99HUs387zRsX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="395502692"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="395502692"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 23:30:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="899636416"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="899636416"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 19 Dec 2023 23:29:58 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFr1g-0006Z7-0q;
	Wed, 20 Dec 2023 07:29:56 +0000
Date: Wed, 20 Dec 2023 15:29:05 +0800
From: kernel test robot <lkp@intel.com>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>, Fuad Tabba <tabba@google.com>
Subject: arch/arm64/kvm/hyp/nvhe/stacktrace.c:10:1: sparse: sparse: symbol
 '__pcpu_scope_overflow_stack' was not declared. Should it be static?
Message-ID: <202312201507.DlDhct9c-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   55cb5f43689d7a9ea5bf35ef050f12334f197347
commit: 548ec3336f323db56260b312c232ab37285f0284 KVM: arm64: On stack overflow switch to hyp overflow_stack
date:   1 year, 5 months ago
config: arm64-randconfig-r112-20231117 (https://download.01.org/0day-ci/archive/20231220/202312201507.DlDhct9c-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231220/202312201507.DlDhct9c-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312201507.DlDhct9c-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/arm64/kvm/hyp/nvhe/stacktrace.c:10:1: sparse: sparse: symbol '__pcpu_scope_overflow_stack' was not declared. Should it be static?

vim +/__pcpu_scope_overflow_stack +10 arch/arm64/kvm/hyp/nvhe/stacktrace.c

     9	
  > 10	DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

