Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D679A7D05D8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 02:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346795AbjJTAhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 20:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346790AbjJTAhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 20:37:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA16A3;
        Thu, 19 Oct 2023 17:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697762260; x=1729298260;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8iubCs15//k2GBeV+ULutuA4rmgbIK1gDzdV1fVOCXc=;
  b=haVNhneX5dbgu2R7We3tgnc/6hWPnXlQ+Oxg8QLC+3167pzESgCOIOfY
   LNM0KJRJcN2fMMUyhGbvIhxY0Ky27srnVl6kTUUQQcA+g03yyLR6A45LA
   BHz9dGWRVRv+iwn8L9i/KPmkrlmCgJHOdpkhqCOKd/TS0PIeoBBbF5u5Y
   0GqXt0QIbWnC/6aD/YP9PLwsH3lqdovbrOvvVE75GlmwI4T6kuH7eF9FJ
   2cBmPoO+nnwIXNqWLhjlC4B/vmKnODtUzCMWECfjHR87odFaW+8pUSyF3
   diMHEo5t9We0TF9v1CV2P/Zpm78tMmOTaI6MFXwT6I7kFcctGvHA+iAA9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="385279697"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="385279697"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 17:37:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="733784145"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="733784145"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 19 Oct 2023 17:37:37 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtdWB-0002mW-0U;
        Fri, 20 Oct 2023 00:37:35 +0000
Date:   Fri, 20 Oct 2023 08:37:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Herring <robh@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
        Tom Rix <trix@redhat.com>, Michal Simek <monstr@monstr.eu>
Cc:     oe-kbuild-all@lists.linux.dev, kernel test robot <lkp@intel.com>,
        linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: xilinx-pr-decoupler: Fix unused
 xlnx_pr_decoupler_of_match warning for !CONFIG_OF
Message-ID: <202310200826.9spStghB-lkp@intel.com>
References: <20231012192149.1546368-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012192149.1546368-1-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

kernel test robot noticed the following build errors:

[auto build test ERROR on xilinx-xlnx/master]
[also build test ERROR on linus/master v6.6-rc6]
[cannot apply to next-20231019]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rob-Herring/fpga-xilinx-pr-decoupler-Fix-unused-xlnx_pr_decoupler_of_match-warning-for-CONFIG_OF/20231017-112523
base:   https://github.com/Xilinx/linux-xlnx master
patch link:    https://lore.kernel.org/r/20231012192149.1546368-1-robh%40kernel.org
patch subject: [PATCH] fpga: xilinx-pr-decoupler: Fix unused xlnx_pr_decoupler_of_match warning for !CONFIG_OF
config: parisc-randconfig-002-20231019 (https://download.01.org/0day-ci/archive/20231020/202310200826.9spStghB-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231020/202310200826.9spStghB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310200826.9spStghB-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/fpga/xilinx-pr-decoupler.c:179:35: error: 'xlnx_pr_decoupler_of_match' undeclared here (not in a function); did you mean 'xlnx_pr_decoupler_data'?
     179 |                 .of_match_table = xlnx_pr_decoupler_of_match,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                   xlnx_pr_decoupler_data


vim +179 drivers/fpga/xilinx-pr-decoupler.c

   173	
   174	static struct platform_driver xlnx_pr_decoupler_driver = {
   175		.probe = xlnx_pr_decoupler_probe,
   176		.remove = xlnx_pr_decoupler_remove,
   177		.driver = {
   178			.name = "xlnx_pr_decoupler",
 > 179			.of_match_table = xlnx_pr_decoupler_of_match,
   180		},
   181	};
   182	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
