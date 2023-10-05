Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CCD7B99D7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 04:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbjJECEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 22:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjJECEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 22:04:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B429AB;
        Wed,  4 Oct 2023 19:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696471481; x=1728007481;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7f2TlIXBIJjbSNeuOq7FE3Xuyd7JTillqKjxVDak1fY=;
  b=hJLJSK0csq69DUU4LIHCOSiKCkhZrlAodmog5YQEj7rGChJ0ufoTSXNe
   cwLUgM6eFn1XVxRZaKPfvB+/FPxV6e6W5sJTusef5bcWH4NL78QYbJFE/
   9w3M69zAYfVODnWKynGXL+6SbD5qWXqy1UkKsl1PA+rkZ2NrZxAtyr0dJ
   AWmMdAZ/dR2OezPNWvjojgqvatskEY9dDI9IL1CongYOOzvahGCoSKsut
   xvc48S5n+TZV13Ajowio5H7OxJgr1h9k1F/W4uMyU3pb3SalP2wenUBtB
   mV2PHzToSQoLdKT+eqVswhucOwNbUYUDEt5YnLF2Rk2jLt5PI3Z/dRFrY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="449865051"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="449865051"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 19:04:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="875366247"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="875366247"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 04 Oct 2023 19:04:37 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qoDj9-000Krs-0E;
        Thu, 05 Oct 2023 02:04:35 +0000
Date:   Thu, 5 Oct 2023 10:04:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     werneazc@gmail.com, jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        lars@metafoo.de
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>
Subject: Re: [PATCH 2/2] iio: adc: ads7038: Add driver support for 12bit ADC
Message-ID: <202310050917.qrpQA2nb-lkp@intel.com>
References: <20231004102330.3713-2-andre.werner@systec-electronic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004102330.3713-2-andre.werner@systec-electronic.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on robh/for-next linus/master v6.6-rc4 next-20231004]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/werneazc-gmail-com/iio-adc-ads7038-Add-driver-support-for-12bit-ADC/20231004-182531
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20231004102330.3713-2-andre.werner%40systec-electronic.com
patch subject: [PATCH 2/2] iio: adc: ads7038: Add driver support for 12bit ADC
config: powerpc64-allyesconfig (https://download.01.org/0day-ci/archive/20231005/202310050917.qrpQA2nb-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231005/202310050917.qrpQA2nb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310050917.qrpQA2nb-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/adc/ti-ads7038-core.c:46:5: warning: no previous prototype for function 'ads7038_read_raw' [-Wmissing-prototypes]
      46 | int ads7038_read_raw(struct iio_dev *indio_dev,
         |     ^
   drivers/iio/adc/ti-ads7038-core.c:46:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      46 | int ads7038_read_raw(struct iio_dev *indio_dev,
         | ^
         | static 
   1 warning generated.


vim +/ads7038_read_raw +46 drivers/iio/adc/ti-ads7038-core.c

    45	
  > 46	int ads7038_read_raw(struct iio_dev *indio_dev,
    47			     struct iio_chan_spec const *chan,
    48			     int *val, int *val2,
    49			     long mask)
    50	{
    51		unsigned int ret;
    52		struct ads7038_ch_meas_result tmp_val;
    53		struct ads7038_data *const data = (struct ads7038_data *)iio_priv(indio_dev);
    54		struct ads7038_info *const info = (struct ads7038_info *)data->info;
    55	
    56		ret = info->read_channel(indio_dev, chan->channel, &tmp_val);
    57	
    58		if (ret < 0) {
    59			dev_err(&indio_dev->dev, "Read channel returned with error %d", ret);
    60			return ret;
    61		}
    62	
    63		switch (mask) {
    64		case IIO_CHAN_INFO_RAW:
    65			*val = tmp_val.raw;
    66	
    67			ret = IIO_VAL_INT;
    68			break;
    69		case IIO_CHAN_INFO_SCALE:
    70			ret = regulator_get_voltage(data->reg);
    71			if (ret < 0)
    72				break;
    73	
    74			*val = ret / 1000;	/* uV -> mV */
    75			*val2 = (1 << chan->scan_type.realbits) - 1;
    76	
    77			ret = IIO_VAL_FRACTIONAL;
    78			break;
    79		default:
    80			ret = -EINVAL;
    81			break;
    82		}
    83	
    84		return ret;
    85	}
    86	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
