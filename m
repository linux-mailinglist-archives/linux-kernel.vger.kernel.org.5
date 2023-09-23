Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CAB7AC290
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 16:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjIWOFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 10:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjIWOFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 10:05:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7461A19E
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 07:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695477911; x=1727013911;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8OTmG9ZWIXQK0USIXRh00OJCENJCRHifURIhh2wi8gQ=;
  b=gakogLQynYcgIJbvRs2gdA7aVi28HO4AUWT7MVV/3qjco8/G8GEYlpXW
   C7Ro4VqYh9hF1/J/y1wAScIoaSyzJrI8+Dt1hVdy52kycOh1khyOg883Z
   YO/FdehdEDNB1w87Y/z3tUjlakYbq0yJQdRBcQb7uYt6WFNakucnFTZfk
   DKnJxegD1kXsg0//xOBx/XuJkzOqhWTPo3/gCzpaLxHzu6lnL3Z+zVEry
   G31GbfJl609HQTYvCBHUturqQTIGr1jMeE4rUj1QITM5rAuNhfv8uog0e
   HhpIdUjtNOUO6fy89Oc0UXdoNzKM45dqbgiJKYAfMWCzpR97v9tA+koAp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10842"; a="366078714"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="366078714"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2023 07:04:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10842"; a="863302477"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="863302477"
Received: from lkp-server02.sh.intel.com (HELO 493f6c7fed5d) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 23 Sep 2023 07:04:49 -0700
Received: from kbuild by 493f6c7fed5d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qk3FX-0002SD-1e;
        Sat, 23 Sep 2023 14:04:47 +0000
Date:   Sat, 23 Sep 2023 22:04:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sandor Yu <Sandor.yu@nxp.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c:332
 dw_hdmi_cec_suspend() warn: inconsistent indenting
Message-ID: <202309232133.OnycNeQQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d90b0276af8f25a0b8ae081a30d1b2a61263393b
commit: db1184e410744a680f92ca21e5acd5ae54510db8 drm: bridge: dw_hdmi: Add cec suspend/resume functions
date:   7 weeks ago
config: csky-randconfig-r071-20230917 (https://download.01.org/0day-ci/archive/20230923/202309232133.OnycNeQQ-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230923/202309232133.OnycNeQQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309232133.OnycNeQQ-lkp@intel.com/

smatch warnings:
drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c:332 dw_hdmi_cec_suspend() warn: inconsistent indenting

vim +332 drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c

   326	
   327	static int __maybe_unused dw_hdmi_cec_suspend(struct device *dev)
   328	{
   329		struct dw_hdmi_cec *cec = dev_get_drvdata(dev);
   330	
   331		/* store interrupt status/mask registers */
 > 332		 cec->regs_polarity = dw_hdmi_read(cec, HDMI_CEC_POLARITY);
   333		 cec->regs_mask = dw_hdmi_read(cec, HDMI_CEC_MASK);
   334		 cec->regs_mute_stat0 = dw_hdmi_read(cec, HDMI_IH_MUTE_CEC_STAT0);
   335	
   336		return 0;
   337	}
   338	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
