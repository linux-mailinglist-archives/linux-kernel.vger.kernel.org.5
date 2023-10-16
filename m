Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DE67C9D6A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 04:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjJPCeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 22:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjJPCem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 22:34:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8264FAB
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 19:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697423681; x=1728959681;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/r47gQmJh4ILT5TdjtJ8Po44vb4rux8n6laLq5vp7uY=;
  b=k2lRw8nfDUPjMciZfetAvh6/QTGlzmdy0mtEawMr1E7DsbYjU+jMFl7G
   NKRmk1sAsfV1hsXZqXr8gDjMzc45fkeclFifAK1VdA8iFD8GL2nQVht+l
   3YaEpNFi9Ss+yf3UYm9AnSyg2fqm6qiMLXAO6ato0WKKA5fxbQqzF0cI1
   yG5psSqTH8C9aryesE0KmfTS4nnD2c0qEfL5iMBnPwydStvCZljuCIU+S
   EW44yhPAOPcCsh0DG1Q4hfVCJrmOQ/u78e0nNGaU3ZSwPhaWXa+6e1wJV
   pXPoPciHgYP//2GqgIiptk8FYIJyrb4fnxqVU3t0BauWXMm2yIcCGD4aT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="389294279"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="389294279"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 19:34:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="825832757"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="825832757"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 15 Oct 2023 19:34:39 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsDRF-00081h-0C;
        Mon, 16 Oct 2023 02:34:37 +0000
Date:   Mon, 16 Oct 2023 10:34:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: sound/soc/qcom/lpass-sc7280.c:419:34: warning:
 'sc7280_lpass_cpu_device_id' defined but not used
Message-ID: <202310161030.CHFngnbd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivasa,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   58720809f52779dc0f08e53e54b014209d13eebb
commit: b62c4e5fba2f910bc9f23ae152d11627e4c2f00f ASoC: qcom: lpass-sc7280: Add platform driver for lpass audio
date:   1 year, 8 months ago
config: i386-buildonly-randconfig-002-20231016 (https://download.01.org/0day-ci/archive/20231016/202310161030.CHFngnbd-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231016/202310161030.CHFngnbd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310161030.CHFngnbd-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> sound/soc/qcom/lpass-sc7280.c:419:34: warning: 'sc7280_lpass_cpu_device_id' defined but not used [-Wunused-const-variable=]
     419 | static const struct of_device_id sc7280_lpass_cpu_device_id[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/sc7280_lpass_cpu_device_id +419 sound/soc/qcom/lpass-sc7280.c

   418	
 > 419	static const struct of_device_id sc7280_lpass_cpu_device_id[] = {
   420		{.compatible = "qcom,sc7280-lpass-cpu", .data = &sc7280_data},
   421		{}
   422	};
   423	MODULE_DEVICE_TABLE(of, sc7280_lpass_cpu_device_id);
   424	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
