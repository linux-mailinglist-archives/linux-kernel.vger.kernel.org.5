Return-Path: <linux-kernel+bounces-2416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2DC815CCC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 01:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B09141C21793
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 00:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AAF7F4;
	Sun, 17 Dec 2023 00:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fzhd5MJe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4202B1FA4;
	Sun, 17 Dec 2023 00:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702772651; x=1734308651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LmAkoba8PlD6a6HIoR+TVVUwiqnKUrp8yzstST7TMSg=;
  b=Fzhd5MJeeOPDDFvdmx/1i9BUX3tC04n5TSQ0reOpyRZCZAXsTVQunjsr
   c3MXKRoSxqsbA2/i7F0vmNqIVI2v0901IiMfZbouzuNrj4efuFMK+EtKh
   uO4cwoRc4b44WdnWfc2Hkt4G+r6zU7bFGHlmOZVrVOkaGk0Kmgyrigm21
   ritARqDoLL5m8Z4lto5MOtW8fkG3QPuSdBl8SxkTiEfI+w1gl0O+vTwAE
   lVN83OdFkeLkmjAKq5nWj4zFzLBI2oc32hcmiyHRoq3uZbT3Pt1LxlkA+
   8hE9svzZzfPnPtyohT/TF2aX1JTiSnds7vZQifh9pd1z4IiOKUsZPicPI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="395129994"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="395129994"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2023 16:24:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="948366942"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="948366942"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 16 Dec 2023 16:24:06 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEewt-0002Ny-2k;
	Sun, 17 Dec 2023 00:24:03 +0000
Date: Sun, 17 Dec 2023 08:23:56 +0800
From: kernel test robot <lkp@intel.com>
To: Jia Jie Ho <jiajie.ho@starfivetech.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 5/5] crypto: starfive: Add sm4 support for JH8100
Message-ID: <202312170811.OzUPuAUd-lkp@intel.com>
References: <20231216141234.417498-6-jiajie.ho@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231216141234.417498-6-jiajie.ho@starfivetech.com>

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
patch link:    https://lore.kernel.org/r/20231216141234.417498-6-jiajie.ho%40starfivetech.com
patch subject: [PATCH 5/5] crypto: starfive: Add sm4 support for JH8100
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20231217/202312170811.OzUPuAUd-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231217/202312170811.OzUPuAUd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312170811.OzUPuAUd-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/crypto/starfive/jh8100-sm4.c:1088:5: warning: no previous prototype for function 'starfive_sm4_register_algs' [-Wmissing-prototypes]
    1088 | int starfive_sm4_register_algs(void)
         |     ^
   drivers/crypto/starfive/jh8100-sm4.c:1088:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1088 | int starfive_sm4_register_algs(void)
         | ^
         | static 
>> drivers/crypto/starfive/jh8100-sm4.c:1103:6: warning: no previous prototype for function 'starfive_sm4_unregister_algs' [-Wmissing-prototypes]
    1103 | void starfive_sm4_unregister_algs(void)
         |      ^
   drivers/crypto/starfive/jh8100-sm4.c:1103:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1103 | void starfive_sm4_unregister_algs(void)
         | ^
         | static 
   2 warnings generated.


vim +/starfive_sm4_register_algs +1088 drivers/crypto/starfive/jh8100-sm4.c

  1087	
> 1088	int starfive_sm4_register_algs(void)
  1089	{
  1090		int ret;
  1091	
  1092		ret = crypto_engine_register_skciphers(skcipher_sm4, ARRAY_SIZE(skcipher_sm4));
  1093		if (ret)
  1094			return ret;
  1095	
  1096		ret = crypto_engine_register_aeads(aead_sm4, ARRAY_SIZE(aead_sm4));
  1097		if (ret)
  1098			crypto_engine_unregister_skciphers(skcipher_sm4, ARRAY_SIZE(skcipher_sm4));
  1099	
  1100		return ret;
  1101	}
  1102	
> 1103	void starfive_sm4_unregister_algs(void)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

