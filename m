Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BADE7F3986
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 23:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbjKUWwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 17:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbjKUWwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 17:52:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9208AF4;
        Tue, 21 Nov 2023 14:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700607145; x=1732143145;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4El9C1OtR2c7yuMuhHbcy9uKYS1ErYxb0i53zPctChc=;
  b=FdMXFFYnvb3Ew7o/6oxGEcuehoh82ZXvG2FqVDj70u/Zss0kwLxuRi2E
   btYrU9V6gE+qFmAMzCexgUhRVpl4bt3eWuKrZjgewnKODe1GQxiZHMtlP
   YnAAp8SJjD1+h9BiBEJ/9BvlAvNzAV/9rIrd3EjRSl4NrTWY1tJ9cfqdO
   dkpaeYXWCPwl8oiYibdaQz4kkN+HwH5+FfzpWse2fhwbNYMhWggFmkxBn
   WywrVBnE/pcdcnAl7YiMoni39iam0Wxmd39+TldAero9aROXnuZhqr1q2
   1tP9955ghxNb1/T+1k5se+hiTMZUb8RYcsaponn2AdhHx3Z/WdFYi4LVe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="395860403"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="395860403"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 14:52:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="15045295"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 21 Nov 2023 14:52:20 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5ZbO-0008Mk-0R;
        Tue, 21 Nov 2023 22:52:18 +0000
Date:   Wed, 22 Nov 2023 06:52:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jingbao Qiu <qiujingbao.dlmu@gmail.com>, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, krzysztof.kozlowski+dt@linaro.org,
        chao.wei@sophgo.com, unicorn_wang@outlook.com, conor+dt@kernel.org,
        robh+dt@kernel.org, conor@kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     oe-kbuild-all@lists.linux.dev, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Subject: Re: [PATCH 2/3] rtc: add rtc controller support for Sophgo CV1800B
 SoC
Message-ID: <202311220645.2hOquYn6-lkp@intel.com>
References: <20231121094642.2973795-3-qiujingbao.dlmu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121094642.2973795-3-qiujingbao.dlmu@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jingbao,

kernel test robot noticed the following build errors:

[auto build test ERROR on abelloni/rtc-next]
[also build test ERROR on linus/master v6.7-rc2 next-20231121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jingbao-Qiu/dt-bindings-rtc-add-binding-for-Sophgo-CV1800B-rtc-controller/20231121-174927
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
patch link:    https://lore.kernel.org/r/20231121094642.2973795-3-qiujingbao.dlmu%40gmail.com
patch subject: [PATCH 2/3] rtc: add rtc controller support for Sophgo CV1800B SoC
config: sparc-allmodconfig (https://download.01.org/0day-ci/archive/20231122/202311220645.2hOquYn6-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231122/202311220645.2hOquYn6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311220645.2hOquYn6-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/rtc/rtc-cv1800b.c: In function 'cv1800b_rtc_alarm_irq_enable':
>> drivers/rtc/rtc-cv1800b.c:90:17: error: implicit declaration of function 'writel_relaxed' [-Werror=implicit-function-declaration]
      90 |                 writel_relaxed(REG_ENABLE_FUN, data->core_map + RTC_ALARM_ENABLE);
         |                 ^~~~~~~~~~~~~~
   drivers/rtc/rtc-cv1800b.c: In function 'cv1800b_rtc_read_alarm':
>> drivers/rtc/rtc-cv1800b.c:115:21: error: implicit declaration of function 'readl' [-Werror=implicit-function-declaration]
     115 |         alrm_time = readl(data->core_map + RTC_ALARM_TIME);
         |                     ^~~~~
   drivers/rtc/rtc-cv1800b.c: In function 'cv1800b_rtc_softinit':
>> drivers/rtc/rtc-cv1800b.c:128:9: error: implicit declaration of function 'writel' [-Werror=implicit-function-declaration]
     128 |         writel(ACTIVATE_RTC_POR_DB_MAGIC_KEY,
         |         ^~~~~~
   drivers/rtc/rtc-cv1800b.c: In function 'cv1800b_rtc_read_time':
>> drivers/rtc/rtc-cv1800b.c:150:16: error: implicit declaration of function 'readl_relaxed' [-Werror=implicit-function-declaration]
     150 |         time = readl_relaxed(data->core_map + RTC_SEC_CNTR_VALUE);
         |                ^~~~~~~~~~~~~
   drivers/rtc/rtc-cv1800b.c: In function 'cv1800b_rtc_probe':
   drivers/rtc/rtc-cv1800b.c:246:16: error: implicit declaration of function 'rtc_register_device'; did you mean 'devm_rtc_register_device'? [-Werror=implicit-function-declaration]
     246 |         return rtc_register_device(rtc->rtc_dev);
         |                ^~~~~~~~~~~~~~~~~~~
         |                devm_rtc_register_device
   cc1: some warnings being treated as errors


vim +/writel_relaxed +90 drivers/rtc/rtc-cv1800b.c

    83	
    84	static int cv1800b_rtc_alarm_irq_enable(struct device *dev,
    85						unsigned int enabled)
    86	{
    87		struct cv1800b_rtc_priv *data = dev_get_drvdata(dev);
    88	
    89		if (enabled)
  > 90			writel_relaxed(REG_ENABLE_FUN, data->core_map + RTC_ALARM_ENABLE);
    91		else
    92			writel_relaxed(REG_DISABLE_FUN,
    93				       data->core_map + RTC_ALARM_ENABLE);
    94	
    95		return 0;
    96	}
    97	
    98	static int cv1800b_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
    99	{
   100		struct cv1800b_rtc_priv *data = dev_get_drvdata(dev);
   101		unsigned long time = rtc_tm_to_time64(&alrm->time);
   102	
   103		writel_relaxed(time, data->core_map + RTC_ALARM_TIME);
   104	
   105		cv1800b_rtc_alarm_irq_enable(dev, 1);
   106	
   107		return 0;
   108	}
   109	
   110	static int cv1800b_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
   111	{
   112		u32 alrm_time, now_time;
   113		struct cv1800b_rtc_priv *data = dev_get_drvdata(dev);
   114	
 > 115		alrm_time = readl(data->core_map + RTC_ALARM_TIME);
   116		now_time = readl(data->core_map + RTC_SEC_CNTR_VALUE);
   117		rtc_time64_to_tm(alrm_time, &alrm->time);
   118		alrm->pending = now_time > alrm_time ? 1 : 0;
   119		alrm->enabled = readl(data->core_map + RTC_ALARM_ENABLE);
   120	
   121		return 0;
   122	}
   123	
   124	static int cv1800b_rtc_softinit(struct cv1800b_rtc_priv *dev)
   125	{
   126		u32 timeout = 20;
   127	
 > 128		writel(ACTIVATE_RTC_POR_DB_MAGIC_KEY,
   129		       dev->core_map + RTC_POR_DB_MAGIC_KEY);
   130		writel(INIT_LOAD_TIME, dev->core_map + RTC_SET_SEC_CNTR_VALUE);
   131		writel(REG_DISABLE_FUN, dev->core_map + RTC_SET_SEC_CNTR_TRIG);
   132	
   133		while (readl(dev->core_map + RTC_SEC_CNTR_VALUE) == INIT_LOAD_TIME
   134		       && timeout--)
   135			udelay(5);
   136	
   137		if (!timeout)
   138			return -1;
   139		return 0;
   140	}
   141	
   142	static int cv1800b_rtc_read_time(struct device *dev, struct rtc_time *tm)
   143	{
   144		struct cv1800b_rtc_priv *data = dev_get_drvdata(dev);
   145		u32 time = 0;
   146	
   147		if (!data)
   148			return -1;
   149	
 > 150		time = readl_relaxed(data->core_map + RTC_SEC_CNTR_VALUE);
   151		rtc_time64_to_tm(time, tm);
   152	
   153		return 0;
   154	}
   155	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
