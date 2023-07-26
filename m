Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719E6762828
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 03:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjGZB3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 21:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGZB3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 21:29:21 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14882699
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 18:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690334960; x=1721870960;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rLrwN231gbRNZwlVTiskoIa513bQnsdAEsRYgBtr61k=;
  b=cDDVTmc7z660qbyCcLnRHkecQXVvv1NRKyRROG6u3aUTIe/BE/yYcauh
   Qrvo7444CSQgqc4knJ6wDUBND4sgcHvAVlSHq3bFr5/mTvBSGAgIQE2dx
   2GsAAAHNdc6us5blwiJZ0lO2m1Z36cTuVXFSBSOEzk97IetJDgXtdu0Be
   hPpkbpH1cYdHof9VYZcuXDXB0lgXG6dGwryY7yvCIkL5sDX47Wrb2K6Zd
   eKUBc9N1yc2RyRpPEKXWftta5w3C4YXb6jsFx38l4CwFETdZg1ukkIBQm
   cuuiP23bisQAR0raMVfyZEeXBi4GFOcOm7OHiZnTbn3LHtikAgrgQ1zLM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="352788251"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="352788251"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 18:29:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="755980612"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="755980612"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 25 Jul 2023 18:29:19 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOTL4-0000WJ-14;
        Wed, 26 Jul 2023 01:29:18 +0000
Date:   Wed, 26 Jul 2023 09:29:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: drivers/pinctrl/qcom/pinctrl-ipq5018.c:244:27: warning: '_groups'
 defined but not used
Message-ID: <202307260914.AMUMoZ8S-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   18b44bc5a67275641fb26f2c54ba7eef80ac5950
commit: 405ac045ec730d10e5901d653088b9d67bfaaa80 pinctrl: qcom: allow true compile testing
date:   7 weeks ago
config: i386-buildonly-randconfig-r004-20230726 (https://download.01.org/0day-ci/archive/20230726/202307260914.AMUMoZ8S-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230726/202307260914.AMUMoZ8S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307260914.AMUMoZ8S-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pinctrl/qcom/pinctrl-ipq5018.c:244:27: warning: '_groups' defined but not used [-Wunused-const-variable=]
     244 | static const char * const _groups[] = {
         |                           ^~~~~~~


vim +/_groups +244 drivers/pinctrl/qcom/pinctrl-ipq5018.c

725d1c8916583f Sricharan Ramabadhran 2023-06-08  243  
725d1c8916583f Sricharan Ramabadhran 2023-06-08 @244  static const char * const _groups[] = {
725d1c8916583f Sricharan Ramabadhran 2023-06-08  245  	"gpio0", "gpio1", "gpio2", "gpio3", "gpio4", "gpio5", "gpio6", "gpio7",
725d1c8916583f Sricharan Ramabadhran 2023-06-08  246  	"gpio8", "gpio9", "gpio10", "gpio11", "gpio12", "gpio13", "gpio14",
725d1c8916583f Sricharan Ramabadhran 2023-06-08  247  	"gpio15", "gpio16", "gpio17", "gpio18", "gpio19", "gpio20", "gpio21",
725d1c8916583f Sricharan Ramabadhran 2023-06-08  248  	"gpio22", "gpio23", "gpio24", "gpio25", "gpio26", "gpio27", "gpio28",
725d1c8916583f Sricharan Ramabadhran 2023-06-08  249  	"gpio29", "gpio30", "gpio31", "gpio32", "gpio33", "gpio34", "gpio35",
725d1c8916583f Sricharan Ramabadhran 2023-06-08  250  	"gpio36", "gpio37", "gpio38", "gpio39", "gpio40", "gpio41", "gpio42",
725d1c8916583f Sricharan Ramabadhran 2023-06-08  251  	"gpio43", "gpio44", "gpio45", "gpio46",
725d1c8916583f Sricharan Ramabadhran 2023-06-08  252  };
725d1c8916583f Sricharan Ramabadhran 2023-06-08  253  

:::::: The code at line 244 was first introduced by commit
:::::: 725d1c8916583f9c09e5f05e5a55dd47fdca61c1 pinctrl: qcom: Add IPQ5018 pinctrl driver

:::::: TO: Sricharan Ramabadhran <quic_srichara@quicinc.com>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
