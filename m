Return-Path: <linux-kernel+bounces-10328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F9D81D2CF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 08:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1B78B22FE0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 07:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF7A63A0;
	Sat, 23 Dec 2023 07:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IrYroaZS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BD36FB0;
	Sat, 23 Dec 2023 07:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703315161; x=1734851161;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ua3gxrBq+A2K7dRFw6+hA5zFQS4btKUO72Ob8/lSyp0=;
  b=IrYroaZSNYjBOsJ71k/70dCRMTdUs1orKd0H6sFRdoTUODkcFuBC/YvV
   W6zQ08cQWCMQLtzU4/9w/25/0UmUXz7U+snSMpoZDmEe/WC3LWtQxKvMX
   dKbNFJOo7rwajjPusBYdaQRjkD2Hajm7vL0jcBPhGT943Pi02cvkf/as8
   vUz9fA8Agse3jZQMkRbbYU7Mge+ipmYu+wVfX7Nx56/XTC41oMdClXe+K
   hBTygMNqQa5AA4z4LDBYmd+mWYsCYLm94w7jeaKW9b82+R+de32GSd7OS
   l+CVjF3YtDktq+ICaXVOLL8MnwZ6GwJe/FxSb2E/Bs8U1EuiXD9n3h7gg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="460515996"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="460515996"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 23:06:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="18971455"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 22 Dec 2023 23:05:56 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rGw4x-000AOj-2Z;
	Sat, 23 Dec 2023 07:05:50 +0000
Date: Sat, 23 Dec 2023 15:04:54 +0800
From: kernel test robot <lkp@intel.com>
To: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>, olivia@selenic.com,
	herbert@gondor.apana.org.au, jiajie.ho@starfivetech.com,
	conor.dooley@microchip.com, martin@kaiser.cx, mmyangfl@gmail.com,
	jenny.zhang@starfivetech.com, robh@kernel.org,
	l.stelmach@samsung.com, ardb@kernel.org,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, CobeChen@zhaoxin.com,
	TonyWWang@zhaoxin.com, YunShen@zhaoxin.com, LeoLiu@zhaoxin.com,
	LeoLiuoc <LeoLiu-oc@zhaoxin.com>
Subject: Re: [PATCH v3] hwrng: add Zhaoxin rng driver base on rep_xstore
 instruction
Message-ID: <202312231428.55tEgXSQ-lkp@intel.com>
References: <20231221062602.799432-1-LeoLiu-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221062602.799432-1-LeoLiu-oc@zhaoxin.com>

Hi LeoLiu-oc,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus herbert-cryptodev-2.6/master linus/master v6.7-rc6 next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/LeoLiu-oc/hwrng-add-Zhaoxin-rng-driver-base-on-rep_xstore-instruction/20231222-174625
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20231221062602.799432-1-LeoLiu-oc%40zhaoxin.com
patch subject: [PATCH v3] hwrng: add Zhaoxin rng driver base on rep_xstore instruction
config: i386-defconfig (https://download.01.org/0day-ci/archive/20231223/202312231428.55tEgXSQ-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231223/202312231428.55tEgXSQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312231428.55tEgXSQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/char/hw_random/via-rng.o: in function `via_rng_mod_init':
>> via-rng.c:(.init.text+0x2): undefined reference to `via_rng_cpu_ids'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

