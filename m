Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F66175F5A5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 14:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjGXMFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 08:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjGXMEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 08:04:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25FD10D1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 05:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690200292; x=1721736292;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=58YmAVMNhM+69Uz4TSYJtTClde4BqyBdoWDlbcr2UFA=;
  b=FO31fJaquioOEDPAq/edPdyfcrXz99Q1zdxjfPiISNhPIson7oGFbwwW
   lYdj/kLLazbh2IaD97ND2L6otfCbJ527ZGxk19nPT11QE2/iI3rDOGU1q
   9rP0EVtNRkMlA0UFVjPGB9ILSG9g8IJLJeLYyNJB5acK2f6UI9wEUvaun
   VpXlpkko5KwTxGhOA9ba16P/Ii+vwmMHKMbnJSJsI9nx95mVdFE7ROjMi
   sBy8gsT+/T/9ZHwEbJ0MRkJVs6RDZ/Vlrfmhd7fMBvRPbCqeGENPHq3OG
   eWMkgcJ9C5BtE6WoXxHmeIUYWMvAX/3e+cCd7lAIIDu+qmyM7Rw1hRAnJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="371022843"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="371022843"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 05:04:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="795758415"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="795758415"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jul 2023 05:04:12 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qNuI7-0009iG-1a;
        Mon, 24 Jul 2023 12:04:01 +0000
Date:   Mon, 24 Jul 2023 20:03:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     sunran001@208suo.com, alexander.deucher@amd.com
Cc:     oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in sienna_cichlid_ppt.c
Message-ID: <202307241921.8W1KDtYK-lkp@intel.com>
References: <ea1cf43d5545fa917127694a294a57da@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea1cf43d5545fa917127694a294a57da@208suo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on drm/drm-next drm-exynos/exynos-drm-next drm-intel/for-linux-next drm-intel/for-linux-next-fixes drm-tip/drm-tip linus/master v6.5-rc3 next-20230724]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/sunran001-208suo-com/drm-amd-pm-Clean-up-errors-in-sienna_cichlid_ppt-c/20230724-153134
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/ea1cf43d5545fa917127694a294a57da%40208suo.com
patch subject: [PATCH] drm/amd/pm: Clean up errors in sienna_cichlid_ppt.c
config: i386-buildonly-randconfig-r004-20230724 (https://download.01.org/0day-ci/archive/20230724/202307241921.8W1KDtYK-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230724/202307241921.8W1KDtYK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307241921.8W1KDtYK-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/sienna_cichlid_ppt.c: In function 'sienna_cichlid_get_throttler_status_locked':
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/sienna_cichlid_ppt.c:595:42: error: 'smu_table' undeclared (first use in this function)
     595 |                 (SmuMetricsExternal_t *)(smu_table->metrics_table);
         |                                          ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/sienna_cichlid_ppt.c:595:42: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/sienna_cichlid_ppt.c:593:35: warning: unused variable 'smu_tabl' [-Wunused-variable]
     593 |         struct smu_table_context *smu_tabl = &smu->smu_table;
         |                                   ^~~~~~~~


vim +/smu_tabl +593 drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/sienna_cichlid_ppt.c

   590	
   591	static uint32_t sienna_cichlid_get_throttler_status_locked(struct smu_context *smu)
   592	{
 > 593		struct smu_table_context *smu_tabl = &smu->smu_table;
   594		SmuMetricsExternal_t *metrics_ext =
   595			(SmuMetricsExternal_t *)(smu_table->metrics_table);
   596		uint32_t throttler_status = 0;
   597		int i;
   598	
   599		if ((smu->adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 7)) &&
   600		     (smu->smc_fw_version >= 0x3A4900)) {
   601			for (i = 0; i < THROTTLER_COUNT; i++)
   602				throttler_status |=
   603					(metrics_ext->SmuMetrics_V3.ThrottlingPercentage[i] ? 1U << i : 0);
   604		} else if ((smu->adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 7)) &&
   605		     (smu->smc_fw_version >= 0x3A4300)) {
   606			for (i = 0; i < THROTTLER_COUNT; i++)
   607				throttler_status |=
   608					(metrics_ext->SmuMetrics_V2.ThrottlingPercentage[i] ? 1U << i : 0);
   609		} else {
   610			throttler_status = metrics_ext->SmuMetrics.ThrottlerStatus;
   611		}
   612	
   613		return throttler_status;
   614	}
   615	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
