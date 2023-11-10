Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EB67E8510
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 22:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjKJV3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 16:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKJV3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 16:29:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0BC420B;
        Fri, 10 Nov 2023 13:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699651781; x=1731187781;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NA23B0Hz907EL3uQodBGpP4znG68sVHIJYpbYAN5Xys=;
  b=MoyDEIGyPVaHxhR2ucYoyf2O9JFpfE9xhTZHf+tlT9S7f9Rf3f+jP7AA
   bcMcXMqE30JIem5Hx7lBHJpoZiaoEpw8NbxFav1oWHJnYx6G0ZV1E3vUR
   tRAFf/m8IfBrVag5ayyQaY6LkQB9aaET1udqDFOj7ovS6hZ36dbr/0VaE
   sllcIny1Xt2i2pl/bG7sCNBJDSLICaETUr4z3KwHk3kAALn/LNOOjG+hq
   ZU3l05IpmnWwOskWUGDTihOL4Zpd1yRzhwHTuVuZzISCqzDkbseJISLeJ
   xio2+atwoPEkPzmR+YOV4Xo2VQHpo0TvUY/tCz7krvqtvoqApOLWhpJ3b
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="476460859"
X-IronPort-AV: E=Sophos;i="6.03,293,1694761200"; 
   d="scan'208";a="476460859"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 13:29:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="881059314"
X-IronPort-AV: E=Sophos;i="6.03,293,1694761200"; 
   d="scan'208";a="881059314"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 10 Nov 2023 13:29:38 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1Z4K-0009v0-1j;
        Fri, 10 Nov 2023 21:29:36 +0000
Date:   Sat, 11 Nov 2023 05:29:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v7 2/2] rtc: max31335: add driver support
Message-ID: <202311110508.MdqXcQsW-lkp@intel.com>
References: <20231109101449.8347-2-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109101449.8347-2-antoniu.miclaus@analog.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Antoniu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on abelloni/rtc-next]
[also build test WARNING on linus/master v6.6 next-20231110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Antoniu-Miclaus/rtc-max31335-add-driver-support/20231109-231755
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
patch link:    https://lore.kernel.org/r/20231109101449.8347-2-antoniu.miclaus%40analog.com
patch subject: [PATCH v7 2/2] rtc: max31335: add driver support
config: x86_64-randconfig-123-20231111 (https://download.01.org/0day-ci/archive/20231111/202311110508.MdqXcQsW-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231111/202311110508.MdqXcQsW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311110508.MdqXcQsW-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/rtc/rtc-max31335.c:504:22: sparse: sparse: symbol 'max31335_clk_init' was not declared. Should it be static?
>> drivers/rtc/rtc-max31335.c:527:21: sparse: sparse: symbol 'max31335_nvmem_cfg' was not declared. Should it be static?

vim +/max31335_clk_init +504 drivers/rtc/rtc-max31335.c

   503	
 > 504	struct clk_init_data max31335_clk_init = {
   505		.name = "max31335-clkout",
   506		.ops = &max31335_clkout_ops,
   507	};
   508	
   509	static int max31335_nvmem_reg_read(void *priv, unsigned int offset,
   510					   void *val, size_t bytes)
   511	{
   512		struct max31335_data *max31335 = priv;
   513		unsigned int reg = MAX31335_TS0_SEC_1_128 + offset;
   514	
   515		return regmap_bulk_read(max31335->regmap, reg, val, bytes);
   516	}
   517	
   518	static int max31335_nvmem_reg_write(void *priv, unsigned int offset,
   519					    void *val, size_t bytes)
   520	{
   521		struct max31335_data *max31335 = priv;
   522		unsigned int reg = MAX31335_TS0_SEC_1_128 + offset;
   523	
   524		return regmap_bulk_write(max31335->regmap, reg, val, bytes);
   525	}
   526	
 > 527	struct nvmem_config max31335_nvmem_cfg = {
   528		.reg_read = max31335_nvmem_reg_read,
   529		.reg_write = max31335_nvmem_reg_write,
   530		.word_size = 8,
   531		.size = MAX31335_RAM_SIZE,
   532	};
   533	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
