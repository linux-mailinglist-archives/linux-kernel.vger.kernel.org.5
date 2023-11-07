Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D1D7E3299
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 02:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbjKGB2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 20:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjKGB2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 20:28:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10037D51;
        Mon,  6 Nov 2023 17:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699320514; x=1730856514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KGp1FTMlLvE0W7RuyMeG9Bl9f53olpKJMGfeLaVZB9c=;
  b=OFKtISmpMfGma0vNO745XiRn11LkB8K/pSSCBCrXJWuDr/1LniUTTQd8
   XO/sKpcqUMOYRG2EBhQOD/QSbxv9+Aa24GEBrmXLIhrZN/2KQxGeID7e4
   Mm8yx9htyRE6gLtPBroorlU/yJ7vY49xyAbLkQryeqQjlEloFd/K7wZlO
   hLiH7giEiFjY86s+DgG7lOinlQjahDnWDh3PvXsIqPAxqrHLk9uC49vsW
   4p12wmzJ1/vkHP/f9PP7xN/rX5rVeilxwRH2dHokcw1JFgYVgR3QCwZs5
   z4Z9ViVrhoT7IdCuOBNqyrLYZp9OLSRB4WR0xgUWNDaX6N9ZLoaXCO83U
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="386577560"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="386577560"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 17:28:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="756022146"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="756022146"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 06 Nov 2023 17:28:30 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r0AtH-0006sm-2W;
        Tue, 07 Nov 2023 01:28:27 +0000
Date:   Tue, 7 Nov 2023 09:28:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bryant Mairs <bryant@mai.rs>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 3/7] ARM: dts: qcom: Add support for Samsung Galaxy Tab 4
 8.0 Wi-Fi
Message-ID: <202311070844.zoUJwRlS-lkp@intel.com>
References: <20231105204759.37107-4-bryant@mai.rs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231105204759.37107-4-bryant@mai.rs>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bryant,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on dtor-input/next linus/master v6.6 next-20231106]
[cannot apply to dtor-input/for-linus]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bryant-Mairs/dt-bindings-input-melfas-mms114-add-MMS252-compatible/20231106-045021
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20231105204759.37107-4-bryant%40mai.rs
patch subject: [PATCH 3/7] ARM: dts: qcom: Add support for Samsung Galaxy Tab 4 8.0 Wi-Fi
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20231107/202311070844.zoUJwRlS-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231107/202311070844.zoUJwRlS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311070844.zoUJwRlS-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/qcom/qcom-apq8026-samsung-milletwifi.dts:14.15-26 Label or path mba_region not found
>> Error: arch/arm/boot/dts/qcom/qcom-apq8026-samsung-milletwifi.dts:15.15-27 Label or path mpss_region not found
>> Error: arch/arm/boot/dts/qcom/qcom-apq8026-samsung-milletwifi.dts:17.15-28 Label or path wcnss_region not found
   FATAL ERROR: Syntax error parsing input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
