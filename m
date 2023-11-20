Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007737F2182
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 00:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjKTXkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 18:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjKTXkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 18:40:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E4792;
        Mon, 20 Nov 2023 15:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700523603; x=1732059603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gp1wbrJ6oJSN+w/KtUYVHSAUTDc/TxqBc/emsqqKEac=;
  b=fGFMBUKzr6ec7LpqylyDOZten3trAofUqIM2jYmI5Hy1NPYYNX2Hr1ZY
   NEuifPCY3xbAXZQBnFDZ28NihKuYPG6/RgxaDPYhB2r2AxsAzjjVnnZSm
   qhIxZoy9chHpdweLxjpzi3ccOeUoRV5DSI0jnNrf3MHNayPy0ACoCo8Kx
   iQJ3+gVi0FVPCNNYurGDWLft9FLUrKPY90KMH3LiVG9vJ5Ub088SWiPeC
   c1bsbFFpvJu5tEYkyNcw1jx/FgaaLjFmojpZr+x3kVa8Wr75tTYSL573g
   320AX7/j5RSJ1v16b/0/jYIrHrjaI64UhZNJrHYw8/liFg60JYOOmwVB6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="371067854"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="371067854"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 15:40:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="910279769"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="910279769"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 20 Nov 2023 15:40:00 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5Drx-00074E-16;
        Mon, 20 Nov 2023 23:39:57 +0000
Date:   Tue, 21 Nov 2023 07:39:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [rft, PATCH v1 1/1] pinctrl: qcom: lpass-lpi: Remove unused
 member in struct lpi_pingroup
Message-ID: <202311210748.H9kflJ6K-lkp@intel.com>
References: <20231120193353.1670732-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120193353.1670732-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linusw-pinctrl/devel]
[also build test WARNING on linusw-pinctrl/for-next linus/master v6.7-rc2 next-20231120]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/pinctrl-qcom-lpass-lpi-Remove-unused-member-in-struct-lpi_pingroup/20231121-034448
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
patch link:    https://lore.kernel.org/r/20231120193353.1670732-1-andriy.shevchenko%40linux.intel.com
patch subject: [rft, PATCH v1 1/1] pinctrl: qcom: lpass-lpi: Remove unused member in struct lpi_pingroup
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20231121/202311210748.H9kflJ6K-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311210748.H9kflJ6K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311210748.H9kflJ6K-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:55:12: warning: unused variable 'gpio0_pins' [-Wunused-variable]
   static int gpio0_pins[] = { 0 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:56:12: warning: unused variable 'gpio1_pins' [-Wunused-variable]
   static int gpio1_pins[] = { 1 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:57:12: warning: unused variable 'gpio2_pins' [-Wunused-variable]
   static int gpio2_pins[] = { 2 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:58:12: warning: unused variable 'gpio3_pins' [-Wunused-variable]
   static int gpio3_pins[] = { 3 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:59:12: warning: unused variable 'gpio4_pins' [-Wunused-variable]
   static int gpio4_pins[] = { 4 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:60:12: warning: unused variable 'gpio5_pins' [-Wunused-variable]
   static int gpio5_pins[] = { 5 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:61:12: warning: unused variable 'gpio6_pins' [-Wunused-variable]
   static int gpio6_pins[] = { 6 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:62:12: warning: unused variable 'gpio7_pins' [-Wunused-variable]
   static int gpio7_pins[] = { 7 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:63:12: warning: unused variable 'gpio8_pins' [-Wunused-variable]
   static int gpio8_pins[] = { 8 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:64:12: warning: unused variable 'gpio9_pins' [-Wunused-variable]
   static int gpio9_pins[] = { 9 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:65:12: warning: unused variable 'gpio10_pins' [-Wunused-variable]
   static int gpio10_pins[] = { 10 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:66:12: warning: unused variable 'gpio11_pins' [-Wunused-variable]
   static int gpio11_pins[] = { 11 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:67:12: warning: unused variable 'gpio12_pins' [-Wunused-variable]
   static int gpio12_pins[] = { 12 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:68:12: warning: unused variable 'gpio13_pins' [-Wunused-variable]
   static int gpio13_pins[] = { 13 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:69:12: warning: unused variable 'gpio14_pins' [-Wunused-variable]
   static int gpio14_pins[] = { 14 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:70:12: warning: unused variable 'gpio15_pins' [-Wunused-variable]
   static int gpio15_pins[] = { 15 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:71:12: warning: unused variable 'gpio16_pins' [-Wunused-variable]
   static int gpio16_pins[] = { 16 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:72:12: warning: unused variable 'gpio17_pins' [-Wunused-variable]
   static int gpio17_pins[] = { 17 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:73:12: warning: unused variable 'gpio18_pins' [-Wunused-variable]
   static int gpio18_pins[] = { 18 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:74:12: warning: unused variable 'gpio19_pins' [-Wunused-variable]
   static int gpio19_pins[] = { 19 };
              ^
   drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:75:12: warning: unused variable 'gpio20_pins' [-Wunused-variable]
   static int gpio20_pins[] = { 20 };
              ^
   drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:76:12: warning: unused variable 'gpio21_pins' [-Wunused-variable]
   static int gpio21_pins[] = { 21 };
              ^
   drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:77:12: warning: unused variable 'gpio22_pins' [-Wunused-variable]
   static int gpio22_pins[] = { 22 };
              ^
   23 warnings generated.
--
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:57:12: warning: unused variable 'gpio0_pins' [-Wunused-variable]
   static int gpio0_pins[] = { 0 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:58:12: warning: unused variable 'gpio1_pins' [-Wunused-variable]
   static int gpio1_pins[] = { 1 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:59:12: warning: unused variable 'gpio2_pins' [-Wunused-variable]
   static int gpio2_pins[] = { 2 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:60:12: warning: unused variable 'gpio3_pins' [-Wunused-variable]
   static int gpio3_pins[] = { 3 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:61:12: warning: unused variable 'gpio4_pins' [-Wunused-variable]
   static int gpio4_pins[] = { 4 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:62:12: warning: unused variable 'gpio5_pins' [-Wunused-variable]
   static int gpio5_pins[] = { 5 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:63:12: warning: unused variable 'gpio6_pins' [-Wunused-variable]
   static int gpio6_pins[] = { 6 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:64:12: warning: unused variable 'gpio7_pins' [-Wunused-variable]
   static int gpio7_pins[] = { 7 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:65:12: warning: unused variable 'gpio8_pins' [-Wunused-variable]
   static int gpio8_pins[] = { 8 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:66:12: warning: unused variable 'gpio9_pins' [-Wunused-variable]
   static int gpio9_pins[] = { 9 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:67:12: warning: unused variable 'gpio10_pins' [-Wunused-variable]
   static int gpio10_pins[] = { 10 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:68:12: warning: unused variable 'gpio11_pins' [-Wunused-variable]
   static int gpio11_pins[] = { 11 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:69:12: warning: unused variable 'gpio12_pins' [-Wunused-variable]
   static int gpio12_pins[] = { 12 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:70:12: warning: unused variable 'gpio13_pins' [-Wunused-variable]
   static int gpio13_pins[] = { 13 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:71:12: warning: unused variable 'gpio14_pins' [-Wunused-variable]
   static int gpio14_pins[] = { 14 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:72:12: warning: unused variable 'gpio15_pins' [-Wunused-variable]
   static int gpio15_pins[] = { 15 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:73:12: warning: unused variable 'gpio16_pins' [-Wunused-variable]
   static int gpio16_pins[] = { 16 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:74:12: warning: unused variable 'gpio17_pins' [-Wunused-variable]
   static int gpio17_pins[] = { 17 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:75:12: warning: unused variable 'gpio18_pins' [-Wunused-variable]
   static int gpio18_pins[] = { 18 };
              ^
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:76:12: warning: unused variable 'gpio19_pins' [-Wunused-variable]
   static int gpio19_pins[] = { 19 };
              ^
   drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:77:12: warning: unused variable 'gpio20_pins' [-Wunused-variable]
   static int gpio20_pins[] = { 20 };
              ^
   drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:78:12: warning: unused variable 'gpio21_pins' [-Wunused-variable]
   static int gpio21_pins[] = { 21 };
              ^
   drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:79:12: warning: unused variable 'gpio22_pins' [-Wunused-variable]
   static int gpio22_pins[] = { 22 };
              ^
   23 warnings generated.


vim +/gpio0_pins +55 drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c

5a6ca1f240d6a2 Krzysztof Kozlowski 2023-02-03  54  
5a6ca1f240d6a2 Krzysztof Kozlowski 2023-02-03 @55  static int gpio0_pins[] = { 0 };
5a6ca1f240d6a2 Krzysztof Kozlowski 2023-02-03 @56  static int gpio1_pins[] = { 1 };
5a6ca1f240d6a2 Krzysztof Kozlowski 2023-02-03 @57  static int gpio2_pins[] = { 2 };
5a6ca1f240d6a2 Krzysztof Kozlowski 2023-02-03 @58  static int gpio3_pins[] = { 3 };
5a6ca1f240d6a2 Krzysztof Kozlowski 2023-02-03 @59  static int gpio4_pins[] = { 4 };
5a6ca1f240d6a2 Krzysztof Kozlowski 2023-02-03 @60  static int gpio5_pins[] = { 5 };
5a6ca1f240d6a2 Krzysztof Kozlowski 2023-02-03 @61  static int gpio6_pins[] = { 6 };
5a6ca1f240d6a2 Krzysztof Kozlowski 2023-02-03 @62  static int gpio7_pins[] = { 7 };
5a6ca1f240d6a2 Krzysztof Kozlowski 2023-02-03 @63  static int gpio8_pins[] = { 8 };
5a6ca1f240d6a2 Krzysztof Kozlowski 2023-02-03 @64  static int gpio9_pins[] = { 9 };
5a6ca1f240d6a2 Krzysztof Kozlowski 2023-02-03 @65  static int gpio10_pins[] = { 10 };
5a6ca1f240d6a2 Krzysztof Kozlowski 2023-02-03 @66  static int gpio11_pins[] = { 11 };
5a6ca1f240d6a2 Krzysztof Kozlowski 2023-02-03 @67  static int gpio12_pins[] = { 12 };
5a6ca1f240d6a2 Krzysztof Kozlowski 2023-02-03 @68  static int gpio13_pins[] = { 13 };
5a6ca1f240d6a2 Krzysztof Kozlowski 2023-02-03 @69  static int gpio14_pins[] = { 14 };
5a6ca1f240d6a2 Krzysztof Kozlowski 2023-02-03 @70  static int gpio15_pins[] = { 15 };
5a6ca1f240d6a2 Krzysztof Kozlowski 2023-02-03 @71  static int gpio16_pins[] = { 16 };
5a6ca1f240d6a2 Krzysztof Kozlowski 2023-02-03 @72  static int gpio17_pins[] = { 17 };
5a6ca1f240d6a2 Krzysztof Kozlowski 2023-02-03 @73  static int gpio18_pins[] = { 18 };
5a6ca1f240d6a2 Krzysztof Kozlowski 2023-02-03 @74  static int gpio19_pins[] = { 19 };
5a6ca1f240d6a2 Krzysztof Kozlowski 2023-02-03 @75  static int gpio20_pins[] = { 20 };
5a6ca1f240d6a2 Krzysztof Kozlowski 2023-02-03 @76  static int gpio21_pins[] = { 21 };
5a6ca1f240d6a2 Krzysztof Kozlowski 2023-02-03 @77  static int gpio22_pins[] = { 22 };
5a6ca1f240d6a2 Krzysztof Kozlowski 2023-02-03  78  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
