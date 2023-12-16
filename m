Return-Path: <linux-kernel+bounces-2378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F7B815BE7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 22:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746E41C215B9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 21:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8863529F;
	Sat, 16 Dec 2023 21:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D6XlCPgC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930D03527E;
	Sat, 16 Dec 2023 21:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702762805; x=1734298805;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B5+1khIzYC84y6QeFySsT9tQ2/gDS/cYymgmLyh/A28=;
  b=D6XlCPgCLOPqkoeFJSTIilgLLtE+UNi1o4V4uPayLDn+b8usoexdmeph
   n3GvebnpCeDFlYVTp/hZJTmVYuYx1JIpwUqHjK8iFzFrRq3hqv2OKUBTy
   gVaGWlXXvsU3zU3jdSqnxX9PmpNgCc3TMwXQQIE6erz4Mac83dpXKwqre
   UKo8jW/NdvL14JK9FgZtnYtccvfHhGzcBvp27FIaNy1xr35m8BqNh4lxT
   NV4qzlGOlVUzfu9T8w4d3+lhxwy5PwwEzOQH+M+r4h0fB6YII+9WO4PWb
   1tgw0+OR8GYNHqiSF0fl7BiM4qG6ZgE0Mx5GhV2QfVZbTEHZgxcVy/16t
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="8748610"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="8748610"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2023 13:40:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="751325541"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="751325541"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Dec 2023 13:40:00 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEcO6-0002Ew-06;
	Sat, 16 Dec 2023 21:39:58 +0000
Date: Sun, 17 Dec 2023 05:39:07 +0800
From: kernel test robot <lkp@intel.com>
To: Jia Jie Ho <jiajie.ho@starfivetech.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 4/5] crypto: starfive: Add sm3 support for JH8100
Message-ID: <202312170505.afaYFFS6-lkp@intel.com>
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
config: csky-randconfig-r081-20231217 (https://download.01.org/0day-ci/archive/20231217/202312170505.afaYFFS6-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231217/202312170505.afaYFFS6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312170505.afaYFFS6-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/crypto/starfive/jh8100-sm3.c:179:6: warning: no previous prototype for 'starfive_sm3_done_task' [-Wmissing-prototypes]
     179 | void starfive_sm3_done_task(unsigned long param)
         |      ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/crypto/starfive/jh8100-sm3.c:524:5: warning: no previous prototype for 'starfive_sm3_register_algs' [-Wmissing-prototypes]
     524 | int starfive_sm3_register_algs(void)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/crypto/starfive/jh8100-sm3.c:529:6: warning: no previous prototype for 'starfive_sm3_unregister_algs' [-Wmissing-prototypes]
     529 | void starfive_sm3_unregister_algs(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


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

