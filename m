Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A896A7D2F4E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjJWJ7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbjJWJ6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:58:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753FC1991
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698055068; x=1729591068;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UPjDoU0ockPvp0hf/8FOxYtAdwZsw6RIVLnw5bNdlzk=;
  b=eqwT+ltOlkbhL9FQipLwJrlCn+aWygHs2hcArEB7z6eA/dWxasXQwaMY
   SaERKO7PwsX8bXYQSCDjxag12eImU7M6PqelN19MzZauyVnN/scL02jeX
   oq6D5lyayUctOXV/bP/JKD0URR9nC3RcMSi27IjvJX16TBTrapRaRMTzU
   KSYb0eoYHoH8nOSG9snzKPWNMo/f7MXjqfeU68YuV1pJoLVl0y6dGyMtk
   r9PcQFqK92hHKrX5RD+5zNzlsDpz6wyPGSU+4niIJ3538LOVjCCYOoyDa
   3J9zaxpqpTYYVpU3uwWXh2Jn+tzEK+3L+fEqbMCtCfMQkRoFXp4W4b87d
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="386622080"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="386622080"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 02:57:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="901759584"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="901759584"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 23 Oct 2023 02:55:28 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qurgt-0006nN-2S;
        Mon, 23 Oct 2023 09:57:43 +0000
Date:   Mon, 23 Oct 2023 17:56:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wei-Ning Huang <wnhuang@google.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, james.clark@arm.com, leo.yan@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@google.com>
Subject: Re: [PATCH] coresight: etm4x: Allow configuring cycle count threshold
Message-ID: <202310231753.SaIFtaWg-lkp@intel.com>
References: <20231019082357.1505047-1-wnhuang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019082357.1505047-1-wnhuang@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei-Ning,

kernel test robot noticed the following build errors:

[auto build test ERROR on soc/for-next]
[also build test ERROR on linus/master v6.6-rc7]
[cannot apply to next-20231023]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Ning-Huang/coresight-etm4x-Allow-configuring-cycle-count-threshold/20231019-162600
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20231019082357.1505047-1-wnhuang%40google.com
patch subject: [PATCH] coresight: etm4x: Allow configuring cycle count threshold
config: arm64-randconfig-001-20231023 (https://download.01.org/0day-ci/archive/20231023/202310231753.SaIFtaWg-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231023/202310231753.SaIFtaWg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310231753.SaIFtaWg-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/hwtracing/coresight/coresight-etm4x-core.c: In function 'etm4_parse_event_config':
>> drivers/hwtracing/coresight/coresight-etm4x-core.c:671:17: error: 'cyc_threshold' undeclared (first use in this function); did you mean 'cyc_threadhold'?
     671 |                 cyc_threshold = ((attr->config >> ETM_OPT_CYC_THRESHOLD_SHIFT) &
         |                 ^~~~~~~~~~~~~
         |                 cyc_threadhold
   drivers/hwtracing/coresight/coresight-etm4x-core.c:671:17: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/hwtracing/coresight/coresight-etm4x-core.c:672:60: error: expected ')' before ';' token
     672 |                                  ETM_OPT_CYC_THRESHOLD_MASK;
         |                                                            ^
   drivers/hwtracing/coresight/coresight-etm4x-core.c:671:33: note: to match this '('
     671 |                 cyc_threshold = ((attr->config >> ETM_OPT_CYC_THRESHOLD_SHIFT) &
         |                                 ^
>> drivers/hwtracing/coresight/coresight-etm4x-core.c:674:60: error: expected ';' before '}' token
     674 |                                  ETM_CYC_THRESHOLD_DEFAULT;
         |                                                            ^
         |                                                            ;
     675 |         }
         |         ~                                                   
>> drivers/hwtracing/coresight/coresight-etm4x-core.c:648:13: warning: unused variable 'cyc_threadhold' [-Wunused-variable]
     648 |         u64 cyc_threadhold;
         |             ^~~~~~~~~~~~~~


vim +671 drivers/hwtracing/coresight/coresight-etm4x-core.c

   638	
   639	static int etm4_parse_event_config(struct coresight_device *csdev,
   640					   struct perf_event *event)
   641	{
   642		int ret = 0;
   643		struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
   644		struct etmv4_config *config = &drvdata->config;
   645		struct perf_event_attr *attr = &event->attr;
   646		unsigned long cfg_hash;
   647		int preset;
 > 648		u64 cyc_threadhold;
   649	
   650		/* Clear configuration from previous run */
   651		memset(config, 0, sizeof(struct etmv4_config));
   652	
   653		if (attr->exclude_kernel)
   654			config->mode = ETM_MODE_EXCL_KERN;
   655	
   656		if (attr->exclude_user)
   657			config->mode = ETM_MODE_EXCL_USER;
   658	
   659		/* Always start from the default config */
   660		etm4_set_default_config(config);
   661	
   662		/* Configure filters specified on the perf cmd line, if any. */
   663		ret = etm4_set_event_filters(drvdata, event);
   664		if (ret)
   665			goto out;
   666	
   667		/* Go from generic option to ETMv4 specifics */
   668		if (attr->config & BIT(ETM_OPT_CYCACC)) {
   669			config->cfg |= TRCCONFIGR_CCI;
   670			/* TRM: Must program this for cycacc to work */
 > 671			cyc_threshold = ((attr->config >> ETM_OPT_CYC_THRESHOLD_SHIFT) &
 > 672					 ETM_OPT_CYC_THRESHOLD_MASK;
   673			config->ccctlr = cyc_threshold ? cyc_threshold :
 > 674					 ETM_CYC_THRESHOLD_DEFAULT;
   675		}
   676		if (attr->config & BIT(ETM_OPT_TS)) {
   677			/*
   678			 * Configure timestamps to be emitted at regular intervals in
   679			 * order to correlate instructions executed on different CPUs
   680			 * (CPU-wide trace scenarios).
   681			 */
   682			ret = etm4_config_timestamp_event(drvdata);
   683	
   684			/*
   685			 * No need to go further if timestamp intervals can't
   686			 * be configured.
   687			 */
   688			if (ret)
   689				goto out;
   690	
   691			/* bit[11], Global timestamp tracing bit */
   692			config->cfg |= TRCCONFIGR_TS;
   693		}
   694	
   695		/* Only trace contextID when runs in root PID namespace */
   696		if ((attr->config & BIT(ETM_OPT_CTXTID)) &&
   697		    task_is_in_init_pid_ns(current))
   698			/* bit[6], Context ID tracing bit */
   699			config->cfg |= TRCCONFIGR_CID;
   700	
   701		/*
   702		 * If set bit ETM_OPT_CTXTID2 in perf config, this asks to trace VMID
   703		 * for recording CONTEXTIDR_EL2.  Do not enable VMID tracing if the
   704		 * kernel is not running in EL2.
   705		 */
   706		if (attr->config & BIT(ETM_OPT_CTXTID2)) {
   707			if (!is_kernel_in_hyp_mode()) {
   708				ret = -EINVAL;
   709				goto out;
   710			}
   711			/* Only trace virtual contextID when runs in root PID namespace */
   712			if (task_is_in_init_pid_ns(current))
   713				config->cfg |= TRCCONFIGR_VMID | TRCCONFIGR_VMIDOPT;
   714		}
   715	
   716		/* return stack - enable if selected and supported */
   717		if ((attr->config & BIT(ETM_OPT_RETSTK)) && drvdata->retstack)
   718			/* bit[12], Return stack enable bit */
   719			config->cfg |= TRCCONFIGR_RS;
   720	
   721		/*
   722		 * Set any selected configuration and preset.
   723		 *
   724		 * This extracts the values of PMU_FORMAT_ATTR(configid) and PMU_FORMAT_ATTR(preset)
   725		 * in the perf attributes defined in coresight-etm-perf.c.
   726		 * configid uses bits 63:32 of attr->config2, preset uses bits 3:0 of attr->config.
   727		 * A zero configid means no configuration active, preset = 0 means no preset selected.
   728		 */
   729		if (attr->config2 & GENMASK_ULL(63, 32)) {
   730			cfg_hash = (u32)(attr->config2 >> 32);
   731			preset = attr->config & 0xF;
   732			ret = cscfg_csdev_enable_active_config(csdev, cfg_hash, preset);
   733		}
   734	
   735		/* branch broadcast - enable if selected and supported */
   736		if (attr->config & BIT(ETM_OPT_BRANCH_BROADCAST)) {
   737			if (!drvdata->trcbb) {
   738				/*
   739				 * Missing BB support could cause silent decode errors
   740				 * so fail to open if it's not supported.
   741				 */
   742				ret = -EINVAL;
   743				goto out;
   744			} else {
   745				config->cfg |= BIT(ETM4_CFG_BIT_BB);
   746			}
   747		}
   748	
   749	out:
   750		return ret;
   751	}
   752	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
