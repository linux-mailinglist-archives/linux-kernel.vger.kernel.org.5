Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181307BC2DE
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 01:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbjJFXTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 19:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbjJFXTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 19:19:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B1D93
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 16:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696634378; x=1728170378;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=h+t8v7+tfoSSmArQ2R2VuQiZ7kIi9aB2FdTQvbxH1lQ=;
  b=ApIFbaRk5Inn2hQziSdVbEpSn4JoZb5euO2usCE/7Y98iw4emj81Oy/Q
   Zm1p5HYXFq+rUY4QyVqDSJK++LAv3VMWRIH0zFFNuyrLk3FF01OeqCXp4
   UcZXcFyTg7oe8zspSH3gIiY+CNHgYQf/kZP2owy/YRwvzk68cluRwAtaE
   C5wnyAsZZRVpu+0iE+Y9jaqjGUz1asoWFMz5jumO/jwNQw5zWpAL7OPtO
   01IWkc+d2PAdx9nGJHJIqi5yF10qsZNYynmBIHl3jhQ9tP/JTpUrmBafR
   HIvcP5YlUDdbgPlazXAwZrfNFUT6+CBO6jQijFA51PgDrE5N6afni/NiX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="382719254"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="382719254"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 16:19:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="822676955"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="822676955"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 06 Oct 2023 16:19:36 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qou6X-0003jR-2B;
        Fri, 06 Oct 2023 23:19:33 +0000
Date:   Sat, 7 Oct 2023 07:18:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kate Hsuan <hpa@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Subject: drivers/platform/x86/intel/telemetry/core.c:116: warning: Function
 parameter or member 'ioss_evtconfig' not described in
 'telemetry_update_events'
Message-ID: <202310070743.WALmRGSY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kate,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   af95dc6fdc25e616051d0234aad638e15c02ec8f
commit: 2b6cb8f2e88b416393d2b34cad51bfe6e1aae8a7 platform/x86: intel_telemetry: Move to intel sub-directory
date:   2 years, 2 months ago
config: x86_64-randconfig-003-20230909 (https://download.01.org/0day-ci/archive/20231007/202310070743.WALmRGSY-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231007/202310070743.WALmRGSY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310070743.WALmRGSY-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/platform/x86/intel/telemetry/core.c:116: warning: Function parameter or member 'ioss_evtconfig' not described in 'telemetry_update_events'
>> drivers/platform/x86/intel/telemetry/core.c:188: warning: Function parameter or member 'ioss_evtconfig' not described in 'telemetry_get_eventconfig'


vim +116 drivers/platform/x86/intel/telemetry/core.c

378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  101  
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  102  /**
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  103   * telemetry_update_events() - Update telemetry Configuration
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  104   * @pss_evtconfig: PSS related config. No change if num_evts = 0.
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  105   * @pss_evtconfig: IOSS related config. No change if num_evts = 0.
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  106   *
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  107   * This API updates the IOSS & PSS Telemetry configuration. Old config
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  108   * is overwritten. Call telemetry_reset_events when logging is over
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  109   * All sample period values should be in the form of:
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  110   * bits[6:3] -> value; bits [0:2]-> Exponent; Period = (Value *16^Exponent)
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  111   *
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  112   * Return: 0 success, < 0 for failure
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  113   */
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  114  int telemetry_update_events(struct telemetry_evtconfig pss_evtconfig,
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  115  			    struct telemetry_evtconfig ioss_evtconfig)
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12 @116  {
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  117  	return telm_core_conf.telem_ops->update_events(pss_evtconfig,
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  118  						       ioss_evtconfig);
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  119  }
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  120  EXPORT_SYMBOL_GPL(telemetry_update_events);
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  121  
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  122  
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  123  /**
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  124   * telemetry_set_sampling_period() - Sets the IOSS & PSS sampling period
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  125   * @pss_period:  placeholder for PSS Period to be set.
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  126   *		 Set to 0 if not required to be updated
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  127   * @ioss_period: placeholder for IOSS Period to be set
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  128   *		 Set to 0 if not required to be updated
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  129   *
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  130   * All values should be in the form of:
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  131   * bits[6:3] -> value; bits [0:2]-> Exponent; Period = (Value *16^Exponent)
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  132   *
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  133   * Return: 0 success, < 0 for failure
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  134   */
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  135  int telemetry_set_sampling_period(u8 pss_period, u8 ioss_period)
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  136  {
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  137  	return telm_core_conf.telem_ops->set_sampling_period(pss_period,
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  138  							     ioss_period);
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  139  }
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  140  EXPORT_SYMBOL_GPL(telemetry_set_sampling_period);
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  141  
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  142  /**
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  143   * telemetry_get_sampling_period() - Get IOSS & PSS min & max sampling period
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  144   * @pss_min_period:  placeholder for PSS Min Period supported
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  145   * @pss_max_period:  placeholder for PSS Max Period supported
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  146   * @ioss_min_period: placeholder for IOSS Min Period supported
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  147   * @ioss_max_period: placeholder for IOSS Max Period supported
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  148   *
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  149   * All values should be in the form of:
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  150   * bits[6:3] -> value; bits [0:2]-> Exponent; Period = (Value *16^Exponent)
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  151   *
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  152   * Return: 0 success, < 0 for failure
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  153   */
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  154  int telemetry_get_sampling_period(u8 *pss_min_period, u8 *pss_max_period,
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  155  				  u8 *ioss_min_period, u8 *ioss_max_period)
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  156  {
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  157  	return telm_core_conf.telem_ops->get_sampling_period(pss_min_period,
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  158  							     pss_max_period,
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  159  							     ioss_min_period,
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  160  							     ioss_max_period);
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  161  }
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  162  EXPORT_SYMBOL_GPL(telemetry_get_sampling_period);
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  163  
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  164  
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  165  /**
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  166   * telemetry_reset_events() - Restore the IOSS & PSS configuration to default
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  167   *
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  168   * Return: 0 success, < 0 for failure
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  169   */
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  170  int telemetry_reset_events(void)
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  171  {
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  172  	return telm_core_conf.telem_ops->reset_events();
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  173  }
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  174  EXPORT_SYMBOL_GPL(telemetry_reset_events);
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  175  
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  176  /**
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  177   * telemetry_get_eventconfig() - Returns the pss and ioss events enabled
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  178   * @pss_evtconfig: Pointer to PSS related configuration.
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  179   * @pss_evtconfig: Pointer to IOSS related configuration.
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  180   * @pss_len:	   Number of u32 elements allocated for pss_evtconfig array
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  181   * @ioss_len:	   Number of u32 elements allocated for ioss_evtconfig array
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  182   *
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  183   * Return: 0 success, < 0 for failure
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  184   */
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  185  int telemetry_get_eventconfig(struct telemetry_evtconfig *pss_evtconfig,
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  186  			      struct telemetry_evtconfig *ioss_evtconfig,
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  187  			      int pss_len, int ioss_len)
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12 @188  {
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  189  	return telm_core_conf.telem_ops->get_eventconfig(pss_evtconfig,
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  190  							 ioss_evtconfig,
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  191  							 pss_len, ioss_len);
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  192  }
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  193  EXPORT_SYMBOL_GPL(telemetry_get_eventconfig);
378f956e3f93b7 drivers/platform/x86/intel_telemetry_core.c Souvik Kumar Chakravarty 2016-01-12  194  

:::::: The code at line 116 was first introduced by commit
:::::: 378f956e3f93b7862d89f93411953758491b42cc platform/x86: Add Intel Telemetry Core Driver

:::::: TO: Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>
:::::: CC: Darren Hart <dvhart@linux.intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
