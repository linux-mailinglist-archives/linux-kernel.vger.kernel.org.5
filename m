Return-Path: <linux-kernel+bounces-2385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3C0815C15
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 23:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EED65B21127
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 22:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43135364DD;
	Sat, 16 Dec 2023 22:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ko4WYXcg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7277835880;
	Sat, 16 Dec 2023 22:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702764784; x=1734300784;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LrrLMVtF5thE9H16OS3pY7snAyvKHmli7OPtS5+MFRI=;
  b=Ko4WYXcgB/tuBNXaOWo12meBtGJKXFfHsLSU92X0HJwX8iVy5z/7L+Yr
   ssjcNX1G1t+PcdULQ6cAKD8mv1hYg7BW7mVWHcwj1rPAEDlfs61c1NROz
   isqCEaeF8GDQR4zW2RrjVKlWIgJAnh5YYgu+amuGhxiz6X/yd/Ho/16/g
   CHFrailQBZbAyHNjNT0MsozcdzmGMLWQVQVakwUp+dSxB90HaFyUEk8th
   /bT++eSfneUDHuRWBxahVIwhkRAh393hTkVO+YSjjwbVwxerxUxyyiwQg
   EWZkjYfCJtd8Y7HggCHq8eqOGPrFGNlklj76zfSlT4mVU/TKfebEVysEM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="8815304"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="8815304"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2023 14:13:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="845504176"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="845504176"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 16 Dec 2023 14:13:01 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEcu3-0002GY-0U;
	Sat, 16 Dec 2023 22:12:59 +0000
Date: Sun, 17 Dec 2023 06:12:43 +0800
From: kernel test robot <lkp@intel.com>
To: Jia Jie Ho <jiajie.ho@starfivetech.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 4/5] crypto: starfive: Add sm3 support for JH8100
Message-ID: <202312170614.24rtwf9x-lkp@intel.com>
References: <20231216141234.417498-5-jiajie.ho@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231216141234.417498-5-jiajie.ho@starfivetech.com>

Hi Jia,

kernel test robot noticed the following build warnings:

[auto build test WARNING on herbert-cryptodev-2.6/master]
[also build test WARNING on next-20231215]
[cannot apply to robh/for-next linus/master v6.7-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jia-Jie-Ho/dt-bindings-crypto-starfive-Add-jh8100-compatible-string/20231216-221614
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
patch link:    https://lore.kernel.org/r/20231216141234.417498-5-jiajie.ho%40starfivetech.com
patch subject: [PATCH 4/5] crypto: starfive: Add sm3 support for JH8100
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20231217/202312170614.24rtwf9x-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231217/202312170614.24rtwf9x-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312170614.24rtwf9x-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/crypto/starfive/jh8100-sm3.c:179:6: warning: no previous prototype for function 'starfive_sm3_done_task' [-Wmissing-prototypes]
     179 | void starfive_sm3_done_task(unsigned long param)
         |      ^
   drivers/crypto/starfive/jh8100-sm3.c:179:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     179 | void starfive_sm3_done_task(unsigned long param)
         | ^
         | static 
>> drivers/crypto/starfive/jh8100-sm3.c:524:5: warning: no previous prototype for function 'starfive_sm3_register_algs' [-Wmissing-prototypes]
     524 | int starfive_sm3_register_algs(void)
         |     ^
   drivers/crypto/starfive/jh8100-sm3.c:524:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     524 | int starfive_sm3_register_algs(void)
         | ^
         | static 
>> drivers/crypto/starfive/jh8100-sm3.c:529:6: warning: no previous prototype for function 'starfive_sm3_unregister_algs' [-Wmissing-prototypes]
     529 | void starfive_sm3_unregister_algs(void)
         |      ^
   drivers/crypto/starfive/jh8100-sm3.c:529:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     529 | void starfive_sm3_unregister_algs(void)
         | ^
         | static 
   3 warnings generated.


vim +/starfive_sm3_done_task +179 drivers/crypto/starfive/jh8100-sm3.c

   178	
 > 179	void starfive_sm3_done_task(unsigned long param)
   180	{
   181		struct starfive_cryp_dev *cryp = (struct starfive_cryp_dev *)param;
   182		int err;
   183	
   184		err = starfive_sm3_copy_hash(cryp->req.hreq);
   185	
   186		/* Reset to clear hash_done in irq register*/
   187		writel(STARFIVE_SM3_RESET, cryp->base + STARFIVE_SM3_CSR);
   188	
   189		crypto_finalize_hash_request(cryp->engine, cryp->req.hreq, err);
   190	}
   191	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

