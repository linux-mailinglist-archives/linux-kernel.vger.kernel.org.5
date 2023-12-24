Return-Path: <linux-kernel+bounces-10781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644B681DBBE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 19:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD722281D4D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 18:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC68CA7D;
	Sun, 24 Dec 2023 18:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VqWJHY89"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B067CA6F
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 18:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703441617; x=1734977617;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ocrrjhfwm2JP3wKLiTvIlbxxnn2b01d17w0X+yU6Pfc=;
  b=VqWJHY89sjt9DGv5cKBazPLH2zrDdr1XYA7XWrye9lOF3HW67/1Kv2Yh
   eCCJK0RC2fGk7J+ClU8pxLEBrUg0IRPRrKbleppV3V8n0keKkL3+82L2+
   8B/uUWlsfi9BOyA/c7RFDqzI+hhzAdLpwzyjwsHPSPUIRhRcek7tplkl1
   FtLt+CSzSRDmWnusbGf875g7XqHzak0C1PnTSRfwHxvbkcNgU8OkFHugu
   yMtdrs3U67PRU0BBbi3xant2elv8lcayRcNaERSUD7k2BYaq1Pimgo1tJ
   PXOSQ0WwxJBUWteHP2mAlUq5dvHU5rlKZbQEMCadEFIuaIrTjZdEU6BOf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="376384277"
X-IronPort-AV: E=Sophos;i="6.04,301,1695711600"; 
   d="scan'208";a="376384277"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 10:13:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="868212613"
X-IronPort-AV: E=Sophos;i="6.04,301,1695711600"; 
   d="scan'208";a="868212613"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Dec 2023 10:13:35 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHSyK-000CUu-0R;
	Sun, 24 Dec 2023 18:13:17 +0000
Date: Mon, 25 Dec 2023 02:12:16 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>
Subject: arch/x86/kernel/irq_64.c:26:1: sparse: sparse: symbol
 '__pcpu_scope_irq_stack_backing_store' was not declared. Should it be
 static?
Message-ID: <202312250248.UgnvTAFE-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   861deac3b092f37b2c5e6871732f3e11486f7082
commit: e6401c13093173aad709a5c6de00cf8d692ee786 x86/irq/64: Split the IRQ stack into its own pages
date:   4 years, 8 months ago
config: x86_64-randconfig-122-20231101 (https://download.01.org/0day-ci/archive/20231225/202312250248.UgnvTAFE-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231225/202312250248.UgnvTAFE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312250248.UgnvTAFE-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/x86/kernel/irq_64.c:26:1: sparse: sparse: symbol '__pcpu_scope_irq_stack_backing_store' was not declared. Should it be static?

vim +/__pcpu_scope_irq_stack_backing_store +26 arch/x86/kernel/irq_64.c

    25	
  > 26	DEFINE_PER_CPU_PAGE_ALIGNED(struct irq_stack, irq_stack_backing_store) __visible;
    27	DECLARE_INIT_PER_CPU(irq_stack_backing_store);
    28	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

