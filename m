Return-Path: <linux-kernel+bounces-18936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0110E826564
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 18:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575241F216B2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 17:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B9513FE4;
	Sun,  7 Jan 2024 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CpX6D/yd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAB713FE0
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 17:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704649536; x=1736185536;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=RPNJWRwOSNG+92W5g8P3LAsgtaNmWZFvCKObb1Jp08I=;
  b=CpX6D/ydEROisvK0gWesmI3TNzaSTbV55pCM+l7jh+fCDL5kUyV5Ik/d
   UosANWrYdmyteTlka8MsO2RVcTjVmPLw2LyJaQOX/mMwpGWWSJ/B8qw15
   qdVjXn8o2QJJV6DPFiw64BktWThN4MR39ODj8RMImWd0xVKG6E9zApaCr
   uO6IcVDgvvNPD3fnfjm+Cnso8wJVQq0VZt8SjsddFdkSYNN14Uj23M9ja
   5g45Qwf3YVgU4GvPM0VZBZ8A1LtbmQAsnpEFapzS6FHgHdsMPnFjNTBSP
   2LnmuWSx18C0BC6Uz3p8qp9sqIj29Sxew0RC6iCZtkuuCj+qye63hYotc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="4835143"
X-IronPort-AV: E=Sophos;i="6.04,339,1695711600"; 
   d="scan'208";a="4835143"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 09:45:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,339,1695711600"; 
   d="scan'208";a="22950749"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 07 Jan 2024 09:45:34 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMXDH-0003z1-0W;
	Sun, 07 Jan 2024 17:45:31 +0000
Date: Mon, 8 Jan 2024 01:45:12 +0800
From: kernel test robot <lkp@intel.com>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: drivers/nvmem/meson-efuse.c:78:12: warning: cast from 'void
 (*)(struct clk *)' to 'void (*)(void *)' converts to incompatible function
 type
Message-ID: <202401080110.6j92FbQa-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Rafał,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   52b1853b080a082ec3749c3a9577f6c71b1d4a90
commit: 28fc7c986f01fdcfd28af648be2597624cac0e27 nvmem: prefix all symbols with NVMEM_
date:   1 year, 3 months ago
config: arm64-randconfig-001-20240107 (https://download.01.org/0day-ci/archive/20240108/202401080110.6j92FbQa-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 7e186d366d6c7def0543acc255931f617e76dff0)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240108/202401080110.6j92FbQa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401080110.6j92FbQa-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/nvmem/meson-efuse.c:78:12: warning: cast from 'void (*)(struct clk *)' to 'void (*)(void *)' converts to incompatible function type [-Wcast-function-type-strict]
      78 |                                        (void(*)(void *))clk_disable_unprepare,
         |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +78 drivers/nvmem/meson-efuse.c

ad855eae6caf0d Carlo Caione   2016-08-27   40  
ad855eae6caf0d Carlo Caione   2016-08-27   41  static int meson_efuse_probe(struct platform_device *pdev)
ad855eae6caf0d Carlo Caione   2016-08-27   42  {
401488d121a4ec Jerome Brunet  2018-05-11   43  	struct device *dev = &pdev->dev;
8cde3c2153e8f5 Carlo Caione   2019-07-31   44  	struct meson_sm_firmware *fw;
8cde3c2153e8f5 Carlo Caione   2019-07-31   45  	struct device_node *sm_np;
ad855eae6caf0d Carlo Caione   2016-08-27   46  	struct nvmem_device *nvmem;
401488d121a4ec Jerome Brunet  2018-05-11   47  	struct nvmem_config *econfig;
611fbca1c86197 Jerome Brunet  2018-11-30   48  	struct clk *clk;
ad855eae6caf0d Carlo Caione   2016-08-27   49  	unsigned int size;
611fbca1c86197 Jerome Brunet  2018-11-30   50  	int ret;
611fbca1c86197 Jerome Brunet  2018-11-30   51  
8cde3c2153e8f5 Carlo Caione   2019-07-31   52  	sm_np = of_parse_phandle(pdev->dev.of_node, "secure-monitor", 0);
8cde3c2153e8f5 Carlo Caione   2019-07-31   53  	if (!sm_np) {
8cde3c2153e8f5 Carlo Caione   2019-07-31   54  		dev_err(&pdev->dev, "no secure-monitor node\n");
8cde3c2153e8f5 Carlo Caione   2019-07-31   55  		return -ENODEV;
8cde3c2153e8f5 Carlo Caione   2019-07-31   56  	}
8cde3c2153e8f5 Carlo Caione   2019-07-31   57  
8cde3c2153e8f5 Carlo Caione   2019-07-31   58  	fw = meson_sm_get(sm_np);
8cde3c2153e8f5 Carlo Caione   2019-07-31   59  	of_node_put(sm_np);
8cde3c2153e8f5 Carlo Caione   2019-07-31   60  	if (!fw)
8cde3c2153e8f5 Carlo Caione   2019-07-31   61  		return -EPROBE_DEFER;
8cde3c2153e8f5 Carlo Caione   2019-07-31   62  
611fbca1c86197 Jerome Brunet  2018-11-30   63  	clk = devm_clk_get(dev, NULL);
611fbca1c86197 Jerome Brunet  2018-11-30   64  	if (IS_ERR(clk)) {
611fbca1c86197 Jerome Brunet  2018-11-30   65  		ret = PTR_ERR(clk);
611fbca1c86197 Jerome Brunet  2018-11-30   66  		if (ret != -EPROBE_DEFER)
611fbca1c86197 Jerome Brunet  2018-11-30   67  			dev_err(dev, "failed to get efuse gate");
611fbca1c86197 Jerome Brunet  2018-11-30   68  		return ret;
611fbca1c86197 Jerome Brunet  2018-11-30   69  	}
611fbca1c86197 Jerome Brunet  2018-11-30   70  
611fbca1c86197 Jerome Brunet  2018-11-30   71  	ret = clk_prepare_enable(clk);
611fbca1c86197 Jerome Brunet  2018-11-30   72  	if (ret) {
611fbca1c86197 Jerome Brunet  2018-11-30   73  		dev_err(dev, "failed to enable gate");
611fbca1c86197 Jerome Brunet  2018-11-30   74  		return ret;
611fbca1c86197 Jerome Brunet  2018-11-30   75  	}
611fbca1c86197 Jerome Brunet  2018-11-30   76  
611fbca1c86197 Jerome Brunet  2018-11-30   77  	ret = devm_add_action_or_reset(dev,
611fbca1c86197 Jerome Brunet  2018-11-30  @78  				       (void(*)(void *))clk_disable_unprepare,
611fbca1c86197 Jerome Brunet  2018-11-30   79  				       clk);
611fbca1c86197 Jerome Brunet  2018-11-30   80  	if (ret) {
611fbca1c86197 Jerome Brunet  2018-11-30   81  		dev_err(dev, "failed to add disable callback");
611fbca1c86197 Jerome Brunet  2018-11-30   82  		return ret;
611fbca1c86197 Jerome Brunet  2018-11-30   83  	}
ad855eae6caf0d Carlo Caione   2016-08-27   84  
8cde3c2153e8f5 Carlo Caione   2019-07-31   85  	if (meson_sm_call(fw, SM_EFUSE_USER_MAX, &size, 0, 0, 0, 0, 0) < 0) {
8649dbe58d359c Jerome Brunet  2018-11-30   86  		dev_err(dev, "failed to get max user");
ad855eae6caf0d Carlo Caione   2016-08-27   87  		return -EINVAL;
8649dbe58d359c Jerome Brunet  2018-11-30   88  	}
ad855eae6caf0d Carlo Caione   2016-08-27   89  
401488d121a4ec Jerome Brunet  2018-05-11   90  	econfig = devm_kzalloc(dev, sizeof(*econfig), GFP_KERNEL);
401488d121a4ec Jerome Brunet  2018-05-11   91  	if (!econfig)
401488d121a4ec Jerome Brunet  2018-05-11   92  		return -ENOMEM;
401488d121a4ec Jerome Brunet  2018-05-11   93  
401488d121a4ec Jerome Brunet  2018-05-11   94  	econfig->dev = dev;
401488d121a4ec Jerome Brunet  2018-05-11   95  	econfig->name = dev_name(dev);
401488d121a4ec Jerome Brunet  2018-05-11   96  	econfig->stride = 1;
401488d121a4ec Jerome Brunet  2018-05-11   97  	econfig->word_size = 1;
401488d121a4ec Jerome Brunet  2018-05-11   98  	econfig->reg_read = meson_efuse_read;
e55077307d6f7c Jerome Brunet  2018-05-11   99  	econfig->reg_write = meson_efuse_write;
401488d121a4ec Jerome Brunet  2018-05-11  100  	econfig->size = size;
8cde3c2153e8f5 Carlo Caione   2019-07-31  101  	econfig->priv = fw;
ad855eae6caf0d Carlo Caione   2016-08-27  102  
401488d121a4ec Jerome Brunet  2018-05-11  103  	nvmem = devm_nvmem_register(&pdev->dev, econfig);
ad855eae6caf0d Carlo Caione   2016-08-27  104  
90696a4097e35f Andrey Smirnov 2018-03-09  105  	return PTR_ERR_OR_ZERO(nvmem);
ad855eae6caf0d Carlo Caione   2016-08-27  106  }
ad855eae6caf0d Carlo Caione   2016-08-27  107  

:::::: The code at line 78 was first introduced by commit
:::::: 611fbca1c861976e95a5244acf9f40bb0981977c nvmem: meson-efuse: add peripheral clock

:::::: TO: Jerome Brunet <jbrunet@baylibre.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

