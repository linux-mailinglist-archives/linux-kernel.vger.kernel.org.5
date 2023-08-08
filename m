Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA47C774D61
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjHHVxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjHHVxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:53:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3258D32980;
        Tue,  8 Aug 2023 09:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691512269; x=1723048269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n+5QGUNq96Zzb5hprHduqLPIugcCxfucZViugpqDUbY=;
  b=HmMki0I+vEeV2uLP0eQS9xi9POwWcqvC4egoHTgLnLIoQM84oJyNk0sj
   5ZKw8JB31wRBIi5eg47KS7HlmLZB4HhslJYG6qG2ltaqKa+epwyDh+W0s
   Ss6HUpiubl3A+1iNmDLT7rMFcTd5WGjbN/aAzWhRNZRgfg0aQZWc36mXp
   OwEBOG63LTUqwajmKmOuV2hAtxeG1K5xYFH8VuyEZbCxyLedVK3UwSmOB
   GQvZH1g/yFay/tj+fOWHTAn9SL4GiJutwdXRsBtLJY9xMYUSYE061/AT+
   RvVzxYoal5xL8fbj2vA01iAO2BPoq0JqLOM39+kvLmUrUoVwQam/APdLq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="401755388"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="401755388"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 04:30:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="905192031"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="905192031"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 Aug 2023 04:30:56 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qTKvQ-0005JY-0G;
        Tue, 08 Aug 2023 11:30:56 +0000
Date:   Tue, 8 Aug 2023 19:30:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 2/2] usb: typec: qcom-pmic-typec: register drm_bridge
Message-ID: <202308081918.CVuUdaXs-lkp@intel.com>
References: <20230728110942.485358-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728110942.485358-3-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-linus]
[also build test ERROR on linus/master v6.5-rc5 next-20230808]
[cannot apply to usb/usb-testing usb/usb-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Baryshkov/usb-typec-altmodes-displayport-add-support-for-embedded-DP-cases/20230728-191207
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-linus
patch link:    https://lore.kernel.org/r/20230728110942.485358-3-dmitry.baryshkov%40linaro.org
patch subject: [PATCH v4 2/2] usb: typec: qcom-pmic-typec: register drm_bridge
config: i386-buildonly-randconfig-r006-20230808 (https://download.01.org/0day-ci/archive/20230808/202308081918.CVuUdaXs-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230808/202308081918.CVuUdaXs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308081918.CVuUdaXs-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c:167:15: error: no member named 'of_node' in 'struct drm_bridge'
           tcpm->bridge.of_node = of_get_child_by_name(tcpm->dev->of_node, "connector");
           ~~~~~~~~~~~~ ^
   1 error generated.


vim +167 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c

   163	
   164	static int qcom_pmic_typec_init_drm(struct pmic_typec *tcpm)
   165	{
   166		tcpm->bridge.funcs = &qcom_pmic_typec_bridge_funcs;
 > 167		tcpm->bridge.of_node = of_get_child_by_name(tcpm->dev->of_node, "connector");
   168		tcpm->bridge.ops = DRM_BRIDGE_OP_HPD;
   169		tcpm->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
   170	
   171		return devm_drm_bridge_add(tcpm->dev, &tcpm->bridge);
   172	}
   173	#else
   174	static int qcom_pmic_typec_init_drm(struct pmic_typec *tcpm)
   175	{
   176		return 0;
   177	}
   178	#endif
   179	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
