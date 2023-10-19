Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3927CF05D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 08:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjJSGsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 02:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjJSGsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 02:48:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14442B0;
        Wed, 18 Oct 2023 23:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697698082; x=1729234082;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z+EclUDtcGVM7gLY01jKF5MJX5Gbyzk5nQ7IfqgLxdY=;
  b=AkROOZQmoIYryfJfoUuL83j+CtaApOTS7Pa9IrsgozcrNPsS4kiVDDKb
   v13/W+xNu9YCKg3/K03S0tLlqqgxl9T76fiWlzB+lzCPbd34jeJ1jmaMr
   3aZPYp12aFw5MrEks4AkXqfTiqbc/iub3AVwjzegT7i0zaXk6VTl3oSwC
   ao8yGeqsNYo7SpBSs5bJGkX7+0PKUdKaM9ZN8zFxd70SHYcYxxtmGgppB
   G5uTENFSpBp5Fjp60T3wVzrmugOc9LBdZM4WkBDg0w6vtrSuBFIrNl6dm
   rOAY3jnztRODZ4KCbQbcmqGRGR/kGqzV3gGcO0aP4VX6F7sFPV9PQFSNX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="366426327"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="366426327"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 23:48:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="847571625"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="847571625"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Oct 2023 23:47:57 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtMoz-0001la-1Z;
        Thu, 19 Oct 2023 06:47:53 +0000
Date:   Thu, 19 Oct 2023 14:47:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tylor Yang <tylor_yang@himax.corp-partner.google.com>,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        poyuan_chang@himax.corp-partner.google.com,
        jingyliang@chromium.org, hbarnor@chromium.org, wuxy23@lenovo.com,
        luolm1@lenovo.com, poyu_hung@himax.corp-partner.google.com,
        Tylor Yang <tylor_yang@himax.corp-partner.google.com>
Subject: Re: [PATCH v3 4/4] HID: touchscreen: Add initial support for Himax
 HID-over-SPI
Message-ID: <202310191454.v9qp5FPx-lkp@intel.com>
References: <20231017091900.801989-5-tylor_yang@himax.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017091900.801989-5-tylor_yang@himax.corp-partner.google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tylor,

kernel test robot noticed the following build errors:

[auto build test ERROR on hid/for-next]
[also build test ERROR on dtor-input/next dtor-input/for-linus robh/for-next linus/master v6.6-rc6 next-20231018]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tylor-Yang/dt-bindings-input-Introduce-Himax-HID-over-SPI-device/20231017-172156
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/20231017091900.801989-5-tylor_yang%40himax.corp-partner.google.com
patch subject: [PATCH v3 4/4] HID: touchscreen: Add initial support for Himax HID-over-SPI
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20231019/202310191454.v9qp5FPx-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231019/202310191454.v9qp5FPx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310191454.v9qp5FPx-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/hid/hx-hid/hx_core.c: In function 'himax_boot_upgrade':
   drivers/hid/hx-hid/hx_core.c:701:14: warning: variable 'fw_load_status' set but not used [-Wunused-but-set-variable]
     701 |         bool fw_load_status = false;
         |              ^~~~~~~~~~~~~~
   drivers/hid/hx-hid/hx_core.c: At top level:
   drivers/hid/hx-hid/hx_core.c:831:6: warning: no previous prototype for 'hx_hid_update' [-Wmissing-prototypes]
     831 | void hx_hid_update(struct work_struct *work)
         |      ^~~~~~~~~~~~~
   drivers/hid/hx-hid/hx_core.c:890:6: warning: no previous prototype for 'himax_report_data_deinit' [-Wmissing-prototypes]
     890 | void himax_report_data_deinit(struct himax_ts_data *ts)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hx-hid/hx_core.c:940:5: warning: no previous prototype for 'himax_chip_suspend' [-Wmissing-prototypes]
     940 | int himax_chip_suspend(struct himax_ts_data *ts)
         |     ^~~~~~~~~~~~~~~~~~
   drivers/hid/hx-hid/hx_core.c: In function 'himax_chip_suspend':
   drivers/hid/hx-hid/hx_core.c:942:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     942 |         int ret = 0;
         |             ^~~
   drivers/hid/hx-hid/hx_core.c: At top level:
   drivers/hid/hx-hid/hx_core.c:983:5: warning: no previous prototype for 'himax_chip_resume' [-Wmissing-prototypes]
     983 | int himax_chip_resume(struct himax_ts_data *ts)
         |     ^~~~~~~~~~~~~~~~~
   drivers/hid/hx-hid/hx_core.c: In function 'himax_resume':
>> drivers/hid/hx-hid/hx_core.c:1047:21: error: too few arguments to function 'himax_chip_init'
    1047 |                 if (himax_chip_init())
         |                     ^~~~~~~~~~~~~~~
   In file included from drivers/hid/hx-hid/hx_ic_core.h:6,
                    from drivers/hid/hx-hid/hx_core.c:16:
   drivers/hid/hx-hid/hx_core.h:485:5: note: declared here
     485 | int himax_chip_init(struct himax_ts_data *ts);
         |     ^~~~~~~~~~~~~~~
   drivers/hid/hx-hid/hx_core.c: At top level:
   drivers/hid/hx-hid/hx_core.c:1212:6: warning: no previous prototype for 'himax_chip_deinit' [-Wmissing-prototypes]
    1212 | void himax_chip_deinit(struct himax_ts_data *ts)
         |      ^~~~~~~~~~~~~~~~~
   drivers/hid/hx-hid/hx_core.c: In function 'himax_platform_init':
   drivers/hid/hx-hid/hx_core.c:1271:13: warning: variable 'err' set but not used [-Wunused-but-set-variable]
    1271 |         int err = PROBE_FAIL;
         |             ^~~
   drivers/hid/hx-hid/hx_core.c: At top level:
   drivers/hid/hx-hid/hx_core.c:1353:5: warning: no previous prototype for 'himax_spi_drv_probe' [-Wmissing-prototypes]
    1353 | int himax_spi_drv_probe(struct spi_device *spi)
         |     ^~~~~~~~~~~~~~~~~~~


vim +/himax_chip_init +1047 drivers/hid/hx-hid/hx_core.c

66a3d0692ad03f Tylor Yang 2023-10-17  1034  
66a3d0692ad03f Tylor Yang 2023-10-17  1035  int himax_resume(struct device *dev)
66a3d0692ad03f Tylor Yang 2023-10-17  1036  {
66a3d0692ad03f Tylor Yang 2023-10-17  1037  	int ret = 0;
66a3d0692ad03f Tylor Yang 2023-10-17  1038  	struct himax_ts_data *ts = dev_get_drvdata(dev);
66a3d0692ad03f Tylor Yang 2023-10-17  1039  
66a3d0692ad03f Tylor Yang 2023-10-17  1040  	I("enter");
66a3d0692ad03f Tylor Yang 2023-10-17  1041  	/*
66a3d0692ad03f Tylor Yang 2023-10-17  1042  	 *	wait until device resume for TDDI
66a3d0692ad03f Tylor Yang 2023-10-17  1043  	 *	TDDI: Touch and display Driver IC
66a3d0692ad03f Tylor Yang 2023-10-17  1044  	 */
66a3d0692ad03f Tylor Yang 2023-10-17  1045  	if (!ts->initialized) {
66a3d0692ad03f Tylor Yang 2023-10-17  1046  #if !defined(CONFIG_FB)
66a3d0692ad03f Tylor Yang 2023-10-17 @1047  		if (himax_chip_init())
66a3d0692ad03f Tylor Yang 2023-10-17  1048  			return -ECANCELED;
66a3d0692ad03f Tylor Yang 2023-10-17  1049  #else
66a3d0692ad03f Tylor Yang 2023-10-17  1050  		E("init not ready, skip!");
66a3d0692ad03f Tylor Yang 2023-10-17  1051  		return -ECANCELED;
66a3d0692ad03f Tylor Yang 2023-10-17  1052  #endif
66a3d0692ad03f Tylor Yang 2023-10-17  1053  	}
66a3d0692ad03f Tylor Yang 2023-10-17  1054  	ret = himax_chip_resume(ts);
66a3d0692ad03f Tylor Yang 2023-10-17  1055  	if (ret < 0) {
66a3d0692ad03f Tylor Yang 2023-10-17  1056  		E("resume failed!");
66a3d0692ad03f Tylor Yang 2023-10-17  1057  		I("retry resume");
66a3d0692ad03f Tylor Yang 2023-10-17  1058  		schedule_delayed_work(&ts->work_resume_delayed_work,
66a3d0692ad03f Tylor Yang 2023-10-17  1059  				      msecs_to_jiffies(ts->pdata->ic_resume_delay));
66a3d0692ad03f Tylor Yang 2023-10-17  1060  		// I("try int rescue");
66a3d0692ad03f Tylor Yang 2023-10-17  1061  		// himax_int_enable(ts, 1);
66a3d0692ad03f Tylor Yang 2023-10-17  1062  	}
66a3d0692ad03f Tylor Yang 2023-10-17  1063  
66a3d0692ad03f Tylor Yang 2023-10-17  1064  	return ret;
66a3d0692ad03f Tylor Yang 2023-10-17  1065  }
66a3d0692ad03f Tylor Yang 2023-10-17  1066  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
