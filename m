Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C40C784C5A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 23:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjHVVzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 17:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjHVVzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:55:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E89BCE;
        Tue, 22 Aug 2023 14:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692741335; x=1724277335;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1XiNWfJBN+3ai0b4J4rL8ll+FV9nSOq+DRqCAx2HFFo=;
  b=QQJpgq1g1XueYbMFtUNMoQY0471MsF3+A+s49hRrhHnz8NQw8zzTzOoA
   tLbxxZbsavAp2LvmjFjq98T5h5rBjEIAUkMp5gud9040rBDtvlCdDCeD3
   z3JzQY/Eg/38nSY5XSIPub/rXH5bbT7okvwrUAK1/H8LkOTntZYsv8FV7
   3YMTGCaMttAc6KoGye29NjkKq+UZ/5eHSk2CQnKOTlptZzvoljFic+AjX
   4oY5R07gnG87L8Kh+l+/WVnHdYbXaiNK8joK7h2oN6y82VgTh/wcg62OF
   S6k+I3NnxHiwwFEAWGL32eiODMJw6K9fV4zqOXblGBnXuq0uALdAClqI6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="354337074"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="354337074"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 14:55:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="713328564"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="713328564"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 22 Aug 2023 14:55:18 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYZLJ-0000Ye-0W;
        Tue, 22 Aug 2023 21:55:17 +0000
Date:   Wed, 23 Aug 2023 05:54:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiansheng Wu <jiansheng.wu@unisoc.com>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yongzhi.chen@unisoc.com,
        xiaoqing.wu@unisoc.com, jinfeng.lin1@unisoc.com,
        jianshengwu16@gmail.com
Subject: Re: [PATCH 2/2] mfd: sprd-sc27xx-spi: Add PMICs support for UMS9621
 SoC
Message-ID: <202308230504.UYqC6CLk-lkp@intel.com>
References: <20230822075113.25506-3-jiansheng.wu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822075113.25506-3-jiansheng.wu@unisoc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiansheng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lee-mfd/for-mfd-next]
[also build test WARNING on robh/for-next lee-leds/for-leds-next lee-mfd/for-mfd-fixes linus/master v6.5-rc7 next-20230822]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiansheng-Wu/dt-bindings-spi-Convert-sprd-spi-bindings-to-yaml/20230822-155400
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
patch link:    https://lore.kernel.org/r/20230822075113.25506-3-jiansheng.wu%40unisoc.com
patch subject: [PATCH 2/2] mfd: sprd-sc27xx-spi: Add PMICs support for UMS9621 SoC
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20230823/202308230504.UYqC6CLk-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230823/202308230504.UYqC6CLk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308230504.UYqC6CLk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/mfd/sprd-sc27xx-spi.c: In function 'sprd_pmic_spi_write':
>> drivers/mfd/sprd-sc27xx-spi.c:133:19: warning: 'pdata' is used uninitialized [-Wuninitialized]
     133 |         if (!pdata->slave_id) {
         |              ~~~~~^~~~~~~~~~
   drivers/mfd/sprd-sc27xx-spi.c:129:38: note: 'pdata' was declared here
     129 |         const struct sprd_pmic_data *pdata;
         |                                      ^~~~~


vim +/pdata +133 drivers/mfd/sprd-sc27xx-spi.c

   124	
   125	static int sprd_pmic_spi_write(void *context, const void *data, size_t count)
   126	{
   127		struct device *dev = context;
   128		struct spi_device *spi = to_spi_device(dev);
   129		const struct sprd_pmic_data *pdata;
   130		int ret;
   131		u32 *pmdata;
   132	
 > 133		if (!pdata->slave_id) {
   134			ret = spi_write(spi, data, count);
   135		} else {
   136			pdata = ((struct sprd_pmic *)spi_get_drvdata(spi))->pdata;
   137	
   138			pmdata = kzalloc(count, GFP_KERNEL);
   139			if (!pmdata)
   140				return -ENOMEM;
   141			memcpy(pmdata, data, count);
   142			*pmdata += pdata->slave_id;
   143			ret = spi_write(spi, (const void *)pmdata, count);
   144			kfree(pmdata);
   145		}
   146		if (ret)
   147			pr_err("pmic mfd write failed!\n");
   148	
   149		return ret;
   150	}
   151	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
