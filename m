Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25641761853
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjGYM2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjGYM2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:28:12 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99978A7;
        Tue, 25 Jul 2023 05:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690288088; x=1721824088;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zu6o05zhMgF/5xWegXDEuIottLQva+nlIKEi6LdQR3k=;
  b=jkzHyNi+1l6CH5wsrJVwhM1qYEqlxVUqtUYdbFoBr5UmS5aDPaGezCez
   /YbKSW60tnRaXy62ssOBREYzV2iX1o7m+D583dJIx5jTFT3ETMTOUht9X
   2cG4ZjU5z0HTenmhCgYWBqsFmEt1X+o695UBJD5GPGpAxu0XHLRO+mxcX
   FgLB1YStff3oZPVU/1L5DWJSvhrI5AezALoy2/k92JhzUQA+CDpd6EKBQ
   7OfWDWHZ7/3ZgSSoLwqgl7h/bqW96C7ZWgChoiAYt7VDV7e9uQyOQ9g9i
   MYETJPq35TyMcyVjtbT8gG9EaOXtxVUZKzK/wqzTyiD+Jr/YXokCf4HTE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="347312521"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="347312521"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 05:28:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="676221438"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="676221438"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 25 Jul 2023 05:28:02 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOH8z-000Abc-29;
        Tue, 25 Jul 2023 12:28:01 +0000
Date:   Tue, 25 Jul 2023 20:27:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tao Zhang <quic_taozha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, Tao Zhang <quic_taozha@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org
Subject: Re: [PATCH v7 09/13] coresight-tpdm: Add nodes for dsb edge control
Message-ID: <202307252010.fbqRILwZ-lkp@intel.com>
References: <1690269353-10829-10-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690269353-10829-10-git-send-email-quic_taozha@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.5-rc3 next-20230725]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tao-Zhang/coresight-tpdm-Remove-the-unnecessary-lock/20230725-152235
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/1690269353-10829-10-git-send-email-quic_taozha%40quicinc.com
patch subject: [PATCH v7 09/13] coresight-tpdm: Add nodes for dsb edge control
config: arm-randconfig-r003-20230725 (https://download.01.org/0day-ci/archive/20230725/202307252010.fbqRILwZ-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230725/202307252010.fbqRILwZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307252010.fbqRILwZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/hwtracing/coresight/coresight-tpdm.c: In function 'dsb_edge_ctrl_val_store':
>> drivers/hwtracing/coresight/coresight-tpdm.c:383:28: warning: variable 'mask' set but not used [-Wunused-but-set-variable]
     383 |         unsigned long val, mask, edge_ctrl;
         |                            ^~~~
   drivers/hwtracing/coresight/coresight-tpdm.c: In function 'dsb_edge_ctrl_mask_store':
>> drivers/hwtracing/coresight/coresight-tpdm.c:449:9: warning: this 'else' clause does not guard... [-Wmisleading-indentation]
     449 |         else
         |         ^~~~
   drivers/hwtracing/coresight/coresight-tpdm.c:451:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'else'
     451 |                 drvdata->dsb->edge_ctrl_mask[reg] = set;
         |                 ^~~~~~~


vim +/mask +383 drivers/hwtracing/coresight/coresight-tpdm.c

   368	
   369	/*
   370	 * This function is used to control the edge detection according
   371	 * to the index number that has been set.
   372	 * "edge_ctrl" should be one of the following values.
   373	 * 0 - Rising edge detection
   374	 * 1 - Falling edge detection
   375	 * 2 - Rising and falling edge detection (toggle detection)
   376	 */
   377	static ssize_t dsb_edge_ctrl_val_store(struct device *dev,
   378						struct device_attribute *attr,
   379						const char *buf,
   380						size_t size)
   381	{
   382		struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 > 383		unsigned long val, mask, edge_ctrl;
   384		int reg;
   385	
   386		if ((kstrtoul(buf, 0, &edge_ctrl)) || (edge_ctrl > 0x2))
   387			return -EINVAL;
   388	
   389		spin_lock(&drvdata->spinlock);
   390		/*
   391		 * There are 2 bit per DSB Edge Control line.
   392		 * Thus we have 16 lines in a 32bit word.
   393		 */
   394		reg = EDCR_TO_WORD_IDX(drvdata->dsb->edge_ctrl_idx);
   395		mask = EDCR_TO_WORD_MASK(drvdata->dsb->edge_ctrl_idx);
   396		val = drvdata->dsb->edge_ctrl[reg];
   397		val &= ~EDCR_TO_WORD_MASK(drvdata->dsb->edge_ctrl_idx);
   398		val |= EDCR_TO_WORD_VAL(edge_ctrl, drvdata->dsb->edge_ctrl_idx);
   399		drvdata->dsb->edge_ctrl[reg] = val;
   400		spin_unlock(&drvdata->spinlock);
   401	
   402		return size;
   403	}
   404	static DEVICE_ATTR_RW(dsb_edge_ctrl_val);
   405	
   406	static ssize_t dsb_edge_ctrl_mask_show(struct device *dev,
   407						    struct device_attribute *attr,
   408						    char *buf)
   409	{
   410		struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
   411		ssize_t size = 0;
   412		unsigned long bytes;
   413		int i;
   414	
   415		spin_lock(&drvdata->spinlock);
   416		for (i = 0; i < TPDM_DSB_MAX_EDCMR; i++) {
   417			bytes = sysfs_emit_at(buf, size,
   418					  "Val:0x%x\n", drvdata->dsb->edge_ctrl_mask[i]);
   419			if (bytes <= 0)
   420				break;
   421			size += bytes;
   422		}
   423		spin_unlock(&drvdata->spinlock);
   424		return size;
   425	}
   426	
   427	static ssize_t dsb_edge_ctrl_mask_store(struct device *dev,
   428						     struct device_attribute *attr,
   429						     const char *buf,
   430						     size_t size)
   431	{
   432		struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
   433		unsigned long val;
   434		u32 set;
   435		int reg;
   436	
   437		if ((kstrtoul(buf, 0, &val)) || (val & ~1UL))
   438			return -EINVAL;
   439	
   440		spin_lock(&drvdata->spinlock);
   441		/*
   442		 * There is 1 bit per DSB Edge Control Mark line.
   443		 * Thus we have 32 lines in a 32bit word.
   444		 */
   445		reg = EDCMR_TO_WORD_IDX(drvdata->dsb->edge_ctrl_idx);
   446		set = drvdata->dsb->edge_ctrl_mask[reg];
   447		if (val)
   448			set |= BIT(EDCMR_TO_WORD_SHIFT(drvdata->dsb->edge_ctrl_idx));
 > 449		else
   450			set &= ~BIT(EDCMR_TO_WORD_SHIFT(drvdata->dsb->edge_ctrl_idx));
   451			drvdata->dsb->edge_ctrl_mask[reg] = set;
   452		spin_unlock(&drvdata->spinlock);
   453	
   454		return size;
   455	}
   456	static DEVICE_ATTR_RW(dsb_edge_ctrl_mask);
   457	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
