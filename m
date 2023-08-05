Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A536770D7F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 05:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjHEDTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 23:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjHEDTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 23:19:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238984ED6;
        Fri,  4 Aug 2023 20:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691205553; x=1722741553;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6BUZMrgcIdifnOs6mbPytqxS1JGu/yhvfT9qNZo3fPA=;
  b=fIHnkg1GvT4R1H1lkdXfrNYPxk5GX8aKjec2DkB7Ug27iYeKuDM5dcsM
   nwgfHzPOhIcY3roB3qio12yfx87zmUOMl0hBQai3GiIR60aGymTKNU8C8
   tXuMOfVbVt88DxTXmzmKGc8a1MDbTydRDs17eSDcRFxYm1+MAKKqU3a68
   3MvmlkVKZG1vakp4EXoK5TqwjUBniusqfJjGjA0IY3uhO3T/fnrpSSO/e
   OQgL3jb7xlmqNdKu76LYW19qRpDMjDJWNyd/PiuLxQ+eAOqW6QrrmjY3P
   /5j6bGVMlZheRnkvFntJ8vNH2P+ejaOR7quSV+bmgXrty1HABQ8FKzsRX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="456666384"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="456666384"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 20:19:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="733492416"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="733492416"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 04 Aug 2023 20:19:09 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qS7oq-0003HP-1u;
        Sat, 05 Aug 2023 03:19:08 +0000
Date:   Sat, 5 Aug 2023 11:18:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coresight: etm: Make cycle count threshold user
 configurable
Message-ID: <202308051014.Uzl7XY32-lkp@intel.com>
References: <20230804044720.1478900-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804044720.1478900-1-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

kernel test robot noticed the following build errors:

[auto build test ERROR on soc/for-next]
[also build test ERROR on linus/master v6.5-rc4 next-20230804]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/coresight-etm-Make-cycle-count-threshold-user-configurable/20230804-124850
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20230804044720.1478900-1-anshuman.khandual%40arm.com
patch subject: [PATCH] coresight: etm: Make cycle count threshold user configurable
config: arm64-randconfig-r004-20230731 (https://download.01.org/0day-ci/archive/20230805/202308051014.Uzl7XY32-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230805/202308051014.Uzl7XY32-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308051014.Uzl7XY32-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/hwtracing/coresight/coresight-etm4x-core.c: In function 'etm4_parse_event_config':
>> drivers/hwtracing/coresight/coresight-etm4x-core.c:661:17: error: 'cc_treshold' undeclared (first use in this function); did you mean 'cc_threshold'?
     661 |                 cc_treshold = attr->config3 & ETM_CYC_THRESHOLD_MASK;
         |                 ^~~~~~~~~~~
         |                 cc_threshold
   drivers/hwtracing/coresight/coresight-etm4x-core.c:661:17: note: each undeclared identifier is reported only once for each function it appears in


vim +661 drivers/hwtracing/coresight/coresight-etm4x-core.c

   629	
   630	static int etm4_parse_event_config(struct coresight_device *csdev,
   631					   struct perf_event *event)
   632	{
   633		int ret = 0;
   634		struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
   635		struct etmv4_config *config = &drvdata->config;
   636		struct perf_event_attr *attr = &event->attr;
   637		unsigned long cfg_hash;
   638		int preset, cc_threshold;
   639	
   640		/* Clear configuration from previous run */
   641		memset(config, 0, sizeof(struct etmv4_config));
   642	
   643		if (attr->exclude_kernel)
   644			config->mode = ETM_MODE_EXCL_KERN;
   645	
   646		if (attr->exclude_user)
   647			config->mode = ETM_MODE_EXCL_USER;
   648	
   649		/* Always start from the default config */
   650		etm4_set_default_config(config);
   651	
   652		/* Configure filters specified on the perf cmd line, if any. */
   653		ret = etm4_set_event_filters(drvdata, event);
   654		if (ret)
   655			goto out;
   656	
   657		/* Go from generic option to ETMv4 specifics */
   658		if (attr->config & BIT(ETM_OPT_CYCACC)) {
   659			config->cfg |= TRCCONFIGR_CCI;
   660			/* TRM: Must program this for cycacc to work */
 > 661			cc_treshold = attr->config3 & ETM_CYC_THRESHOLD_MASK;
   662			if (cc_treshold) {
   663				if (cc_treshold < drvdata->ccitmin)
   664					config->ccctlr = drvdata->ccitmin;
   665				else
   666					config->ccctlr = cc_threshold;
   667			} else {
   668				config->ccctlr = ETM_CYC_THRESHOLD_DEFAULT;
   669			}
   670		}
   671		if (attr->config & BIT(ETM_OPT_TS)) {
   672			/*
   673			 * Configure timestamps to be emitted at regular intervals in
   674			 * order to correlate instructions executed on different CPUs
   675			 * (CPU-wide trace scenarios).
   676			 */
   677			ret = etm4_config_timestamp_event(drvdata);
   678	
   679			/*
   680			 * No need to go further if timestamp intervals can't
   681			 * be configured.
   682			 */
   683			if (ret)
   684				goto out;
   685	
   686			/* bit[11], Global timestamp tracing bit */
   687			config->cfg |= TRCCONFIGR_TS;
   688		}
   689	
   690		/* Only trace contextID when runs in root PID namespace */
   691		if ((attr->config & BIT(ETM_OPT_CTXTID)) &&
   692		    task_is_in_init_pid_ns(current))
   693			/* bit[6], Context ID tracing bit */
   694			config->cfg |= TRCCONFIGR_CID;
   695	
   696		/*
   697		 * If set bit ETM_OPT_CTXTID2 in perf config, this asks to trace VMID
   698		 * for recording CONTEXTIDR_EL2.  Do not enable VMID tracing if the
   699		 * kernel is not running in EL2.
   700		 */
   701		if (attr->config & BIT(ETM_OPT_CTXTID2)) {
   702			if (!is_kernel_in_hyp_mode()) {
   703				ret = -EINVAL;
   704				goto out;
   705			}
   706			/* Only trace virtual contextID when runs in root PID namespace */
   707			if (task_is_in_init_pid_ns(current))
   708				config->cfg |= TRCCONFIGR_VMID | TRCCONFIGR_VMIDOPT;
   709		}
   710	
   711		/* return stack - enable if selected and supported */
   712		if ((attr->config & BIT(ETM_OPT_RETSTK)) && drvdata->retstack)
   713			/* bit[12], Return stack enable bit */
   714			config->cfg |= TRCCONFIGR_RS;
   715	
   716		/*
   717		 * Set any selected configuration and preset.
   718		 *
   719		 * This extracts the values of PMU_FORMAT_ATTR(configid) and PMU_FORMAT_ATTR(preset)
   720		 * in the perf attributes defined in coresight-etm-perf.c.
   721		 * configid uses bits 63:32 of attr->config2, preset uses bits 3:0 of attr->config.
   722		 * A zero configid means no configuration active, preset = 0 means no preset selected.
   723		 */
   724		if (attr->config2 & GENMASK_ULL(63, 32)) {
   725			cfg_hash = (u32)(attr->config2 >> 32);
   726			preset = attr->config & 0xF;
   727			ret = cscfg_csdev_enable_active_config(csdev, cfg_hash, preset);
   728		}
   729	
   730		/* branch broadcast - enable if selected and supported */
   731		if (attr->config & BIT(ETM_OPT_BRANCH_BROADCAST)) {
   732			if (!drvdata->trcbb) {
   733				/*
   734				 * Missing BB support could cause silent decode errors
   735				 * so fail to open if it's not supported.
   736				 */
   737				ret = -EINVAL;
   738				goto out;
   739			} else {
   740				config->cfg |= BIT(ETM4_CFG_BIT_BB);
   741			}
   742		}
   743	
   744	out:
   745		return ret;
   746	}
   747	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
