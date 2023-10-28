Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F7D7DA550
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 08:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjJ1G3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 02:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJ1G3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 02:29:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51B711B;
        Fri, 27 Oct 2023 23:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698474558; x=1730010558;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZmPZf8J+GCs5OUrhdqek1E0Y1P76n/e4mnKOXv6ZLjM=;
  b=ePirB8Uu75ZOnNNTsup760nCJuELLn5bMlJ0xlc1pXyQLNRllJ5eXqGE
   FzcFij1ZVWml0QPdf/z4txiWFa8GUKjOTJN9gCpzqE2g+iU0aA1EMBidF
   FgiDusMBcw7BvR1NB0vza3VBYgm6ucyjNHFVEgxl0aG4tGXo1rwm/0oZ3
   jr+PEXErcsaQPWeMc8JMH8h86HF4cvcXJpIGLgHv1o39+12HVpXhHO7s5
   jDSnargNi8Y5f916Lr3ykRT1rkSMfqd9G49kBVubjLpIzoBxQkNHL7FU7
   hmgJaRD11FiE7moDVfsZAanYAeBjdcgYKx/RFKD7kQhavACYB8eB9bDOZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="719988"
X-IronPort-AV: E=Sophos;i="6.03,258,1694761200"; 
   d="scan'208";a="719988"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 23:29:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="825578486"
X-IronPort-AV: E=Sophos;i="6.03,258,1694761200"; 
   d="scan'208";a="825578486"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 27 Oct 2023 23:29:13 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qwcoo-000BXT-3C;
        Sat, 28 Oct 2023 06:29:11 +0000
Date:   Sat, 28 Oct 2023 14:29:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        Matt Ranostay <matt@ranostay.sg>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: light: Add support for APDS9306 Light Sensor
Message-ID: <202310281420.see2fNLh-lkp@intel.com>
References: <20231027074545.6055-3-subhajit.ghosh@tweaklogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027074545.6055-3-subhajit.ghosh@tweaklogic.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Subhajit,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 611da07b89fdd53f140d7b33013f255bf0ed8f34]

url:    https://github.com/intel-lab-lkp/linux/commits/Subhajit-Ghosh/dt-bindings-iio-light-Avago-APDS9306/20231027-154954
base:   611da07b89fdd53f140d7b33013f255bf0ed8f34
patch link:    https://lore.kernel.org/r/20231027074545.6055-3-subhajit.ghosh%40tweaklogic.com
patch subject: [PATCH v2 2/2] iio: light: Add support for APDS9306 Light Sensor
config: alpha-allmodconfig (https://download.01.org/0day-ci/archive/20231028/202310281420.see2fNLh-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231028/202310281420.see2fNLh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310281420.see2fNLh-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/light/apds9306.c:110: warning: cannot understand function prototype: 'const int apds9306_repeat_rate_freq[][2] = '
>> drivers/iio/light/apds9306.c:123: warning: cannot understand function prototype: 'const int apds9306_repeat_rate_period[] = '


vim +110 drivers/iio/light/apds9306.c

   106	
   107	/**
   108	 * apds9306_repeat_rate_freq - Sampling Frequency in uHz
   109	 */
 > 110	static const int apds9306_repeat_rate_freq[][2] = {
   111		{40, 0},
   112		{20, 0},
   113		{10, 0},
   114		{5,  0},
   115		{2,  0},
   116		{1,  0},
   117		{0, 500000},
   118	};
   119	
   120	/**
   121	 * apds9306_repeat_rate_period - Sampling period in uSec
   122	 */
 > 123	static const int apds9306_repeat_rate_period[] = {
   124		25000, 50000, 100000, 200000, 500000, 1000000, 2000000
   125	};
   126	static_assert(ARRAY_SIZE(apds9306_repeat_rate_freq) ==
   127		      ARRAY_SIZE(apds9306_repeat_rate_period));
   128	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
