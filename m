Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE83793031
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240833AbjIEUom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjIEUol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:44:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD3E132;
        Tue,  5 Sep 2023 13:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693946677; x=1725482677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ldRgTQqmEua8N5cJhViF6FB4LOCXO1IC3Kf5Kk1RTeM=;
  b=N3eNrQ2Do9uMHdXBpsdMncRwfeBx26jiwR2LhKwTyJtywF9Yi9AKYUOp
   pdFbMnPbeeWRWALxt9Ex6DpnLFuvCpCE58z766Ruvy7L2A0T6X7SqvOTQ
   LrByfTenykFIwGH9PJQ7FPfVPzEVQttE2dywx63eu5Fw0WeXJQye/qZ+Q
   HYJkSx8BUX5/3hceoW1ZD/s53hqsJrmEqTUaRMd6YoO6U0frDrwx4mNSo
   YB1sTK8VhCK6BLFHl0MwXFfSWLPEq0gtFag1KU0CoDmuG9J2g9qWok4W3
   8YN/QBT1YCFl5XsJbyl+JonZ/Tmkq5GWoJDZR5DogJWakfMiVlNlQXs4v
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="361928011"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="361928011"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 13:44:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="864886953"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="864886953"
Received: from lkp-server02.sh.intel.com (HELO e0b2ea88afd5) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 05 Sep 2023 13:44:33 -0700
Received: from kbuild by e0b2ea88afd5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qdcuV-00023o-1b;
        Tue, 05 Sep 2023 20:44:31 +0000
Date:   Wed, 6 Sep 2023 04:44:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liam Beguin <liambeguin@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Liam Beguin <liambeguin@gmail.com>
Subject: Re: [PATCH 2/3] iio: adc: ltc2309: switch to new .probe()
Message-ID: <202309060456.UYGqTIBd-lkp@intel.com>
References: <20230824-ltc2309-v1-2-b87b4eb8030c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824-ltc2309-v1-2-b87b4eb8030c@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

kernel test robot noticed the following build warnings:

[auto build test WARNING on a5e505a99ca748583dbe558b691be1b26f05d678]

url:    https://github.com/intel-lab-lkp/linux/commits/Liam-Beguin/iio-adc-add-ltc2309-support/20230825-005720
base:   a5e505a99ca748583dbe558b691be1b26f05d678
patch link:    https://lore.kernel.org/r/20230824-ltc2309-v1-2-b87b4eb8030c%40gmail.com
patch subject: [PATCH 2/3] iio: adc: ltc2309: switch to new .probe()
config: i386-randconfig-061-20230906 (https://download.01.org/0day-ci/archive/20230906/202309060456.UYGqTIBd-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230906/202309060456.UYGqTIBd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309060456.UYGqTIBd-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/adc/ltc2309.c:138:24: sparse: sparse: cast to restricted __be16

vim +138 drivers/iio/adc/ltc2309.c

a967828958b014 Liam Beguin 2023-08-24  106  
a967828958b014 Liam Beguin 2023-08-24  107  static int ltc2309_read_raw(struct iio_dev *indio_dev,
a967828958b014 Liam Beguin 2023-08-24  108  			    struct iio_chan_spec const *chan, int *val,
a967828958b014 Liam Beguin 2023-08-24  109  			    int *val2, long mask)
a967828958b014 Liam Beguin 2023-08-24  110  {
a967828958b014 Liam Beguin 2023-08-24  111  	struct ltc2309 *ltc2309 = iio_priv(indio_dev);
a967828958b014 Liam Beguin 2023-08-24  112  	u16 buf;
a967828958b014 Liam Beguin 2023-08-24  113  	int ret;
a967828958b014 Liam Beguin 2023-08-24  114  	u8 din;
a967828958b014 Liam Beguin 2023-08-24  115  
a967828958b014 Liam Beguin 2023-08-24  116  	mutex_lock(&ltc2309->lock);
a967828958b014 Liam Beguin 2023-08-24  117  
a967828958b014 Liam Beguin 2023-08-24  118  	switch (mask) {
a967828958b014 Liam Beguin 2023-08-24  119  	case IIO_CHAN_INFO_RAW:
a967828958b014 Liam Beguin 2023-08-24  120  		din = FIELD_PREP(LTC2309_DIN_CH_MASK, chan->address & 0x0f) |
a967828958b014 Liam Beguin 2023-08-24  121  			FIELD_PREP(LTC2309_DIN_UNI, 1) |
a967828958b014 Liam Beguin 2023-08-24  122  			FIELD_PREP(LTC2309_DIN_SLEEP, 0);
a967828958b014 Liam Beguin 2023-08-24  123  
a967828958b014 Liam Beguin 2023-08-24  124  		ret = i2c_smbus_write_byte(ltc2309->client, din);
a967828958b014 Liam Beguin 2023-08-24  125  		if (ret < 0) {
a967828958b014 Liam Beguin 2023-08-24  126  			dev_err(ltc2309->dev, "i2c command failed: %pe\n",
a967828958b014 Liam Beguin 2023-08-24  127  				ERR_PTR(ret));
a967828958b014 Liam Beguin 2023-08-24  128  			goto out;
a967828958b014 Liam Beguin 2023-08-24  129  		}
a967828958b014 Liam Beguin 2023-08-24  130  
a967828958b014 Liam Beguin 2023-08-24  131  		ret = i2c_master_recv(ltc2309->client, (char *)&buf, 2);
a967828958b014 Liam Beguin 2023-08-24  132  		if (ret < 0) {
a967828958b014 Liam Beguin 2023-08-24  133  			dev_err(ltc2309->dev, "i2c read failed: %pe\n",
a967828958b014 Liam Beguin 2023-08-24  134  				ERR_PTR(ret));
a967828958b014 Liam Beguin 2023-08-24  135  			goto out;
a967828958b014 Liam Beguin 2023-08-24  136  		}
a967828958b014 Liam Beguin 2023-08-24  137  
a967828958b014 Liam Beguin 2023-08-24 @138  		*val = be16_to_cpu(buf) >> 4;
a967828958b014 Liam Beguin 2023-08-24  139  
a967828958b014 Liam Beguin 2023-08-24  140  		ret = IIO_VAL_INT;
a967828958b014 Liam Beguin 2023-08-24  141  		break;
a967828958b014 Liam Beguin 2023-08-24  142  	case IIO_CHAN_INFO_SCALE:
a967828958b014 Liam Beguin 2023-08-24  143  		*val = ltc2309->vref_mv;
a967828958b014 Liam Beguin 2023-08-24  144  		*val2 = LTC2309_ADC_RESOLUTION;
a967828958b014 Liam Beguin 2023-08-24  145  		ret = IIO_VAL_FRACTIONAL_LOG2;
a967828958b014 Liam Beguin 2023-08-24  146  		break;
a967828958b014 Liam Beguin 2023-08-24  147  	default:
a967828958b014 Liam Beguin 2023-08-24  148  		ret = -EINVAL;
a967828958b014 Liam Beguin 2023-08-24  149  		break;
a967828958b014 Liam Beguin 2023-08-24  150  	}
a967828958b014 Liam Beguin 2023-08-24  151  
a967828958b014 Liam Beguin 2023-08-24  152  out:
a967828958b014 Liam Beguin 2023-08-24  153  	mutex_unlock(&ltc2309->lock);
a967828958b014 Liam Beguin 2023-08-24  154  	return ret;
a967828958b014 Liam Beguin 2023-08-24  155  }
a967828958b014 Liam Beguin 2023-08-24  156  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
