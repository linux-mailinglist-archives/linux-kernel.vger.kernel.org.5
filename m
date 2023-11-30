Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA597FE87B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 06:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344421AbjK3FEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 00:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjK3FEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 00:04:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C5010D9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 21:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701320691; x=1732856691;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Y7nVp7ml6LGkNf1O9ozqBUqWWJfCOgrXgHof4PRyFuQ=;
  b=Iq6ANsBE370vQZdQ/4STZtzNEtGj6k9hDwLEMzyg/7CraluHtTFEUhdu
   ZO6VhgDY16gooCm5/GLCUrXBWgg9W4NPsnFvJc66HeNEPcqAQPQIDXfPc
   GL5QiqrRTGjdPBJP0Zxy0CSOzk5XsU57loQbi+/1ZFX4G1Pqie+J2mTwb
   DUkGUD2RddcwgRRxlAHNurNoAAGMgseB0C2XdEsz5svR9lvWXT+wrwI2w
   GYiSzo2vcGsnpf+2wRhtZlUtPEqSevAa5c8sTvmQmsrmk78uIDB7yuKb7
   C3x0jpmV2x3GiHp5D25owIMwzSWHDdixFc50aZjra47FvbNX4fNM90H0b
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="396078915"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="396078915"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 21:04:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="745503685"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="745503685"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 29 Nov 2023 21:04:48 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8ZED-0001OM-2Q;
        Thu, 30 Nov 2023 05:04:45 +0000
Date:   Thu, 30 Nov 2023 13:03:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: sound/soc/qcom/lpass-sc7280.c:419:34: warning:
 'sc7280_lpass_cpu_device_id' defined but not used
Message-ID: <202311301257.ImTyBnyl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivasa,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3b47bc037bd44f142ac09848e8d3ecccc726be99
commit: b62c4e5fba2f910bc9f23ae152d11627e4c2f00f ASoC: qcom: lpass-sc7280: Add platform driver for lpass audio
date:   1 year, 9 months ago
config: x86_64-buildonly-randconfig-001-20231105 (https://download.01.org/0day-ci/archive/20231130/202311301257.ImTyBnyl-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231130/202311301257.ImTyBnyl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311301257.ImTyBnyl-lkp@intel.com/

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
