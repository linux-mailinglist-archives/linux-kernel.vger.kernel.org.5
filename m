Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FC17E13DE
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 15:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjKEOWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 09:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKEOWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 09:22:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D92D6;
        Sun,  5 Nov 2023 06:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699194142; x=1730730142;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=toY6pyEYbBKJg/bhP6bai1KvDXetaJWeInK0Nmn3nX0=;
  b=GNIy0GTu2qw+xMzamgTBc70OM3d90qwQgKs56oOxjWyIh9CCLgqrbhkF
   wA6sSS30Nw8f73vBBoQ+hxfB1CSdmimGheodYMjfVuF4gknffRf9krMHQ
   XbP2JRIZKnGBGgXOmvnXyMes1tTfHFL0/7H9eZOulM8wQXy+DbbWgqkUy
   JTTwz1kw7bKpKI89v3GWyYXsAMo67ilrOP9QITDMPCkK9beB4gkc2tCBu
   JR5i72Go1QQMPokV0RQR3qGMca6jabtgk4rb1ADlsJ94cPku3AGJb02Z2
   JG9Svn5MDucRzPWIZKfCt7yw47FWR/DNyN/XnxMHD48gHH+mzyr88d5V8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="2059769"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="2059769"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 06:22:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="935568580"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="935568580"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 05 Nov 2023 06:22:16 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qze10-0005W3-25;
        Sun, 05 Nov 2023 14:22:14 +0000
Date:   Sun, 5 Nov 2023 22:22:07 +0800
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
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        Matt Ranostay <matt@ranostay.sg>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: light: Add support for APDS9306 Light Sensor
Message-ID: <202311052102.1GrBH0gk-lkp@intel.com>
References: <20231027074545.6055-3-subhajit.ghosh@tweaklogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027074545.6055-3-subhajit.ghosh@tweaklogic.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
config: powerpc64-allyesconfig (https://download.01.org/0day-ci/archive/20231105/202311052102.1GrBH0gk-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231105/202311052102.1GrBH0gk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311052102.1GrBH0gk-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/light/apds9306.c:598:10: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
     598 |                 return ret;
         |                        ^~~
   drivers/iio/light/apds9306.c:593:9: note: initialize the variable 'ret' to silence this warning
     593 |         int ret, intg_old, gain_old, gain_new, gain_new_closest;
         |                ^
         |                 = 0
   1 warning generated.


vim +/ret +598 drivers/iio/light/apds9306.c

   589	
   590	static int apds9306_intg_time_set(struct apds9306_data *data, int val2)
   591	{
   592		struct device *dev = data->dev;
   593		int ret, intg_old, gain_old, gain_new, gain_new_closest;
   594		bool ok;
   595	
   596		if (!iio_gts_valid_time(&data->gts, val2)) {
   597			dev_err(dev, "Unsupported integration time %u\n", val2);
 > 598			return ret;
   599		}
   600	
   601		intg_old = iio_gts_find_int_time_by_sel(&data->gts,
   602							data->intg_time_idx);
   603		if (ret < 0)
   604			return ret;
   605	
   606		if (intg_old == val2)
   607			return 0;
   608	
   609		gain_old = iio_gts_find_gain_by_sel(&data->gts, data->gain_idx);
   610		if (gain_old < 0)
   611			return gain_old;
   612	
   613		ret = iio_gts_find_new_gain_by_old_gain_time(&data->gts, gain_old,
   614							     intg_old, val2, &gain_new);
   615		if (gain_new < 0) {
   616			dev_err(dev, "Unsupported gain with time\n");
   617			return gain_new;
   618		}
   619	
   620		gain_new_closest = iio_find_closest_gain_low(&data->gts, gain_new, &ok);
   621		if (gain_new_closest < 0) {
   622			gain_new_closest = iio_gts_get_min_gain(&data->gts);
   623			if (gain_new_closest < 0)
   624				return gain_new_closest < 0;
   625		}
   626		if (!ok)
   627			dev_dbg(dev, "Unable to find optimum gain, setting minimum");
   628	
   629		ret = iio_gts_find_sel_by_int_time(&data->gts, val2);
   630		if (ret < 0)
   631			return ret;
   632	
   633		ret = apds9306_intg_time_set_hw(data, ret);
   634		if (ret)
   635			return ret;
   636	
   637		ret = iio_gts_find_sel_by_gain(&data->gts, gain_new_closest);
   638		if (ret < 0)
   639			return ret;
   640	
   641		return apds9306_gain_set_hw(data, ret);
   642	}
   643	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
