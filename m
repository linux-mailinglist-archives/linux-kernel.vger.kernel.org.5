Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A147F24B5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 04:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbjKUDsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 22:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKUDsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 22:48:18 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A55CF;
        Mon, 20 Nov 2023 19:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700538494; x=1732074494;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=857oIuq2ljv3IEo8BGH4JiHu1HpPQme7iJ2C6peyXC4=;
  b=ORHcT4p/kHEGEFpHZNmmVHl9wlPdOfH7qi+GmFo6HH9Arj6aUGnbVHWd
   69BjYJ9fAea3UpnP+QDTmzNrAM11ub415bT4sEsLn0wCnB9qiDASTSZKk
   DjD8yZy0F5L9ehMBEPIdDFGmTKpi/gD1Ci4ANFRlO4FgOJED+5aizEgyy
   C2CPv+mplilYP1m9rnXsEroHKPwpRO4eT1euaDv8CY4mdvk2Nx6fEyuQN
   hma1RB7ScNGgr9053XPyOJxQTZRG6Aln/AjIBjs3s7EeAj9W0qM8jV8yC
   /0lq+EWpOk+YR13Hd3ugixz9o1b8NRG7CT9lnOWNszIILurKqi1zWU+5e
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="10426058"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="10426058"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 19:48:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="857207899"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="857207899"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Nov 2023 19:48:10 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5Hk8-0007Fq-0p;
        Tue, 21 Nov 2023 03:48:08 +0000
Date:   Tue, 21 Nov 2023 11:47:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [rft, PATCH v1 1/1] pinctrl: qcom: lpass-lpi: Remove unused
 member in struct lpi_pingroup
Message-ID: <202311211148.TRaoiPGX-lkp@intel.com>
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
config: x86_64-buildonly-randconfig-001-20231121 (https://download.01.org/0day-ci/archive/20231121/202311211148.TRaoiPGX-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311211148.TRaoiPGX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311211148.TRaoiPGX-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:77:12: warning: 'gpio22_pins' defined but not used [-Wunused-variable]
      77 | static int gpio22_pins[] = { 22 };
         |            ^~~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:76:12: warning: 'gpio21_pins' defined but not used [-Wunused-variable]
      76 | static int gpio21_pins[] = { 21 };
         |            ^~~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:75:12: warning: 'gpio20_pins' defined but not used [-Wunused-variable]
      75 | static int gpio20_pins[] = { 20 };
         |            ^~~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:74:12: warning: 'gpio19_pins' defined but not used [-Wunused-variable]
      74 | static int gpio19_pins[] = { 19 };
         |            ^~~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:73:12: warning: 'gpio18_pins' defined but not used [-Wunused-variable]
      73 | static int gpio18_pins[] = { 18 };
         |            ^~~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:72:12: warning: 'gpio17_pins' defined but not used [-Wunused-variable]
      72 | static int gpio17_pins[] = { 17 };
         |            ^~~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:71:12: warning: 'gpio16_pins' defined but not used [-Wunused-variable]
      71 | static int gpio16_pins[] = { 16 };
         |            ^~~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:70:12: warning: 'gpio15_pins' defined but not used [-Wunused-variable]
      70 | static int gpio15_pins[] = { 15 };
         |            ^~~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:69:12: warning: 'gpio14_pins' defined but not used [-Wunused-variable]
      69 | static int gpio14_pins[] = { 14 };
         |            ^~~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:68:12: warning: 'gpio13_pins' defined but not used [-Wunused-variable]
      68 | static int gpio13_pins[] = { 13 };
         |            ^~~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:67:12: warning: 'gpio12_pins' defined but not used [-Wunused-variable]
      67 | static int gpio12_pins[] = { 12 };
         |            ^~~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:66:12: warning: 'gpio11_pins' defined but not used [-Wunused-variable]
      66 | static int gpio11_pins[] = { 11 };
         |            ^~~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:65:12: warning: 'gpio10_pins' defined but not used [-Wunused-variable]
      65 | static int gpio10_pins[] = { 10 };
         |            ^~~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:64:12: warning: 'gpio9_pins' defined but not used [-Wunused-variable]
      64 | static int gpio9_pins[] = { 9 };
         |            ^~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:63:12: warning: 'gpio8_pins' defined but not used [-Wunused-variable]
      63 | static int gpio8_pins[] = { 8 };
         |            ^~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:62:12: warning: 'gpio7_pins' defined but not used [-Wunused-variable]
      62 | static int gpio7_pins[] = { 7 };
         |            ^~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:61:12: warning: 'gpio6_pins' defined but not used [-Wunused-variable]
      61 | static int gpio6_pins[] = { 6 };
         |            ^~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:60:12: warning: 'gpio5_pins' defined but not used [-Wunused-variable]
      60 | static int gpio5_pins[] = { 5 };
         |            ^~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:59:12: warning: 'gpio4_pins' defined but not used [-Wunused-variable]
      59 | static int gpio4_pins[] = { 4 };
         |            ^~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:58:12: warning: 'gpio3_pins' defined but not used [-Wunused-variable]
      58 | static int gpio3_pins[] = { 3 };
         |            ^~~~~~~~~~
   drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:57:12: warning: 'gpio2_pins' defined but not used [-Wunused-variable]
      57 | static int gpio2_pins[] = { 2 };
         |            ^~~~~~~~~~
   drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:56:12: warning: 'gpio1_pins' defined but not used [-Wunused-variable]
      56 | static int gpio1_pins[] = { 1 };
         |            ^~~~~~~~~~
   drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c:55:12: warning: 'gpio0_pins' defined but not used [-Wunused-variable]
      55 | static int gpio0_pins[] = { 0 };
         |            ^~~~~~~~~~
--
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:79:12: warning: 'gpio22_pins' defined but not used [-Wunused-variable]
      79 | static int gpio22_pins[] = { 22 };
         |            ^~~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:78:12: warning: 'gpio21_pins' defined but not used [-Wunused-variable]
      78 | static int gpio21_pins[] = { 21 };
         |            ^~~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:77:12: warning: 'gpio20_pins' defined but not used [-Wunused-variable]
      77 | static int gpio20_pins[] = { 20 };
         |            ^~~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:76:12: warning: 'gpio19_pins' defined but not used [-Wunused-variable]
      76 | static int gpio19_pins[] = { 19 };
         |            ^~~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:75:12: warning: 'gpio18_pins' defined but not used [-Wunused-variable]
      75 | static int gpio18_pins[] = { 18 };
         |            ^~~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:74:12: warning: 'gpio17_pins' defined but not used [-Wunused-variable]
      74 | static int gpio17_pins[] = { 17 };
         |            ^~~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:73:12: warning: 'gpio16_pins' defined but not used [-Wunused-variable]
      73 | static int gpio16_pins[] = { 16 };
         |            ^~~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:72:12: warning: 'gpio15_pins' defined but not used [-Wunused-variable]
      72 | static int gpio15_pins[] = { 15 };
         |            ^~~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:71:12: warning: 'gpio14_pins' defined but not used [-Wunused-variable]
      71 | static int gpio14_pins[] = { 14 };
         |            ^~~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:70:12: warning: 'gpio13_pins' defined but not used [-Wunused-variable]
      70 | static int gpio13_pins[] = { 13 };
         |            ^~~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:69:12: warning: 'gpio12_pins' defined but not used [-Wunused-variable]
      69 | static int gpio12_pins[] = { 12 };
         |            ^~~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:68:12: warning: 'gpio11_pins' defined but not used [-Wunused-variable]
      68 | static int gpio11_pins[] = { 11 };
         |            ^~~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:67:12: warning: 'gpio10_pins' defined but not used [-Wunused-variable]
      67 | static int gpio10_pins[] = { 10 };
         |            ^~~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:66:12: warning: 'gpio9_pins' defined but not used [-Wunused-variable]
      66 | static int gpio9_pins[] = { 9 };
         |            ^~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:65:12: warning: 'gpio8_pins' defined but not used [-Wunused-variable]
      65 | static int gpio8_pins[] = { 8 };
         |            ^~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:64:12: warning: 'gpio7_pins' defined but not used [-Wunused-variable]
      64 | static int gpio7_pins[] = { 7 };
         |            ^~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:63:12: warning: 'gpio6_pins' defined but not used [-Wunused-variable]
      63 | static int gpio6_pins[] = { 6 };
         |            ^~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:62:12: warning: 'gpio5_pins' defined but not used [-Wunused-variable]
      62 | static int gpio5_pins[] = { 5 };
         |            ^~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:61:12: warning: 'gpio4_pins' defined but not used [-Wunused-variable]
      61 | static int gpio4_pins[] = { 4 };
         |            ^~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:60:12: warning: 'gpio3_pins' defined but not used [-Wunused-variable]
      60 | static int gpio3_pins[] = { 3 };
         |            ^~~~~~~~~~
   drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:59:12: warning: 'gpio2_pins' defined but not used [-Wunused-variable]
      59 | static int gpio2_pins[] = { 2 };
         |            ^~~~~~~~~~
   drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:58:12: warning: 'gpio1_pins' defined but not used [-Wunused-variable]
      58 | static int gpio1_pins[] = { 1 };
         |            ^~~~~~~~~~
   drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:57:12: warning: 'gpio0_pins' defined but not used [-Wunused-variable]
      57 | static int gpio0_pins[] = { 0 };
         |            ^~~~~~~~~~


vim +/gpio22_pins +77 drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c

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
