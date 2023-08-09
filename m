Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BD8776533
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjHIQgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjHIQgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:36:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0B11B2;
        Wed,  9 Aug 2023 09:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691599005; x=1723135005;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ydBCJtj9u/y8x/TfM7kTDDFzhiR7ELo5gtwHLbTMVBw=;
  b=Gq84e0QkX9CWz9V6tl4leGnwT3DOp9Df2xxt/sfJf+kjxccifgpWrrss
   XPuGHAQ0IlI/lq1qBoDJhm/4ZcABEVPiJOASfZXL1il66bxfCaEUWczOM
   nKjamZAxIfne8X0HRVUTiN5C8BW7HlC2SJAXUAGy2Oo46bTDtkuvjlap7
   Lb12ZknsBCcud13BSLejlWKO+Nm2LY8yzTRTs9cZEu79UhDqVNalfBHCk
   NTpELTdXn5AJb8as9MvvO8HU+Z4dgtX1MJvGbzmHzGEjsYDtr/698KEf2
   /cw8OmSg7ne1/DRJKBjpnLhvW3L8biHbXyryEAg/e1X4tXoY41G1WLNxa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="371160773"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="371160773"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 09:36:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="1062540094"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="1062540094"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 09 Aug 2023 09:36:39 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qTmAp-0006GG-0Q;
        Wed, 09 Aug 2023 16:36:39 +0000
Date:   Thu, 10 Aug 2023 00:36:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     oe-kbuild-all@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        Antonio Borneo <antonio.borneo@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Christophe Guibout <christophe.guibout@foss.st.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        linux-rtc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: stm32: remove incorrect #ifdef check
Message-ID: <202308100045.WeVD1ttk-lkp@intel.com>
References: <20230801105932.3738430-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801105932.3738430-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

kernel test robot noticed the following build warnings:

[auto build test WARNING on abelloni/rtc-next]
[also build test WARNING on atorgue-stm32/stm32-next soc/for-next linus/master v6.5-rc5 next-20230809]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Arnd-Bergmann/rtc-stm32-remove-incorrect-ifdef-check/20230801-190951
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
patch link:    https://lore.kernel.org/r/20230801105932.3738430-1-arnd%40kernel.org
patch subject: [PATCH] rtc: stm32: remove incorrect #ifdef check
config: x86_64-buildonly-randconfig-r003-20230809 (https://download.01.org/0day-ci/archive/20230810/202308100045.WeVD1ttk-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230810/202308100045.WeVD1ttk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308100045.WeVD1ttk-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/rtc/rtc-stm32.c:903:12: warning: 'stm32_rtc_resume' defined but not used [-Wunused-function]
     903 | static int stm32_rtc_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~
>> drivers/rtc/rtc-stm32.c:893:12: warning: 'stm32_rtc_suspend' defined but not used [-Wunused-function]
     893 | static int stm32_rtc_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~


vim +/stm32_rtc_resume +903 drivers/rtc/rtc-stm32.c

4e64350f42e2ce Amelie Delaunay 2017-01-11  892  
4e64350f42e2ce Amelie Delaunay 2017-01-11 @893  static int stm32_rtc_suspend(struct device *dev)
4e64350f42e2ce Amelie Delaunay 2017-01-11  894  {
4e64350f42e2ce Amelie Delaunay 2017-01-11  895  	struct stm32_rtc *rtc = dev_get_drvdata(dev);
4e64350f42e2ce Amelie Delaunay 2017-01-11  896  
9a6757eadc14f0 Amelie Delaunay 2017-07-06  897  	if (rtc->data->has_pclk)
9a6757eadc14f0 Amelie Delaunay 2017-07-06  898  		clk_disable_unprepare(rtc->pclk);
9a6757eadc14f0 Amelie Delaunay 2017-07-06  899  
4e64350f42e2ce Amelie Delaunay 2017-01-11  900  	return 0;
4e64350f42e2ce Amelie Delaunay 2017-01-11  901  }
4e64350f42e2ce Amelie Delaunay 2017-01-11  902  
4e64350f42e2ce Amelie Delaunay 2017-01-11 @903  static int stm32_rtc_resume(struct device *dev)
4e64350f42e2ce Amelie Delaunay 2017-01-11  904  {
4e64350f42e2ce Amelie Delaunay 2017-01-11  905  	struct stm32_rtc *rtc = dev_get_drvdata(dev);
4e64350f42e2ce Amelie Delaunay 2017-01-11  906  	int ret = 0;
4e64350f42e2ce Amelie Delaunay 2017-01-11  907  
9a6757eadc14f0 Amelie Delaunay 2017-07-06  908  	if (rtc->data->has_pclk) {
9a6757eadc14f0 Amelie Delaunay 2017-07-06  909  		ret = clk_prepare_enable(rtc->pclk);
9a6757eadc14f0 Amelie Delaunay 2017-07-06  910  		if (ret)
9a6757eadc14f0 Amelie Delaunay 2017-07-06  911  			return ret;
9a6757eadc14f0 Amelie Delaunay 2017-07-06  912  	}
9a6757eadc14f0 Amelie Delaunay 2017-07-06  913  
4e64350f42e2ce Amelie Delaunay 2017-01-11  914  	ret = stm32_rtc_wait_sync(rtc);
cf33e911f500f6 Chuhong Yuan    2019-12-06  915  	if (ret < 0) {
cf33e911f500f6 Chuhong Yuan    2019-12-06  916  		if (rtc->data->has_pclk)
cf33e911f500f6 Chuhong Yuan    2019-12-06  917  			clk_disable_unprepare(rtc->pclk);
4e64350f42e2ce Amelie Delaunay 2017-01-11  918  		return ret;
cf33e911f500f6 Chuhong Yuan    2019-12-06  919  	}
4e64350f42e2ce Amelie Delaunay 2017-01-11  920  
4e64350f42e2ce Amelie Delaunay 2017-01-11  921  	return ret;
4e64350f42e2ce Amelie Delaunay 2017-01-11  922  }
4e64350f42e2ce Amelie Delaunay 2017-01-11  923  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
