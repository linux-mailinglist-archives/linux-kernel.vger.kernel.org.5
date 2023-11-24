Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA6A7F7684
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 15:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjKXOkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 09:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKXOkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 09:40:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F422919A2;
        Fri, 24 Nov 2023 06:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700836810; x=1732372810;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gXtrNk7qmb9HKWUJ2OdFj02KpJ3qMix92waD+ItrKSQ=;
  b=eu/d/HGMqZnB6FBn4o5A2WOGw1ivb29SyjRHOE+Vna1U9iVlKjSG1TKn
   TAzczBWqPEEfJYIKoiUqpvVNi/opWES2g/Laqp244AGug+KyfBfbO6Ex+
   YggyaxVRVzubPQxLu1/XzQzuyaJZENvBJVdbo4bny+NnBTSVeKrGVvgsf
   /y5UE8G7rEcaprk1LD6WTiAL4FzoB/cn+APAck7l5VzsE5GsDkxCyau3d
   LpHQ+3Epamz7Wy0UNuboR69wBrgCa/VaLsbTzCLWxfGJCY37BLYrkMa0n
   j/JiCYT1ewe9o6DMZrTtXcUFAEUSuv6mmlX8fRXRggjP1ev1UJLjOQvIN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="395248997"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="395248997"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 06:40:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="760975134"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="760975134"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 24 Nov 2023 06:40:07 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r6XLg-0002tX-0t;
        Fri, 24 Nov 2023 14:40:04 +0000
Date:   Fri, 24 Nov 2023 22:39:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Crt Mori <cmo@melexis.com>, Jonathan Cameron <jic23@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Crt Mori <cmo@melexis.com>
Subject: Re: [PATCH 1/2] iio: temperature: mlx90635 MLX90635 IR Temperature
 sensor
Message-ID: <202311241512.ZG52ib9O-lkp@intel.com>
References: <aa36393700ff783274894186366a152bb27e58ff.1700648165.git.cmo@melexis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa36393700ff783274894186366a152bb27e58ff.1700648165.git.cmo@melexis.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Crt,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.7-rc2 next-20231124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Crt-Mori/iio-temperature-mlx90635-MLX90635-IR-Temperature-sensor/20231122-202635
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/aa36393700ff783274894186366a152bb27e58ff.1700648165.git.cmo%40melexis.com
patch subject: [PATCH 1/2] iio: temperature: mlx90635 MLX90635 IR Temperature sensor
config: x86_64-randconfig-122-20231123 (https://download.01.org/0day-ci/archive/20231124/202311241512.ZG52ib9O-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231124/202311241512.ZG52ib9O-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311241512.ZG52ib9O-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/temperature/mlx90635.c:380:12: warning: logical not is only applied to the left hand side of this comparison [-Wlogical-not-parentheses]
                                          !(reg_status & MLX90635_STAT_END_CONV) == 0,
                                          ^                                      ~~
   include/linux/regmap.h:124:58: note: expanded from macro 'regmap_read_poll_timeout'
           __tmp = read_poll_timeout(regmap_read, __ret, __ret || (cond), \
                                                                   ^~~~
   include/linux/iopoll.h:47:7: note: expanded from macro 'read_poll_timeout'
                   if (cond) \
                       ^~~~
   drivers/iio/temperature/mlx90635.c:380:12: note: add parentheses after the '!' to evaluate the comparison first
   drivers/iio/temperature/mlx90635.c:380:12: note: add parentheses around left hand side expression to silence this warning
>> drivers/iio/temperature/mlx90635.c:380:12: warning: logical not is only applied to the left hand side of this comparison [-Wlogical-not-parentheses]
                                          !(reg_status & MLX90635_STAT_END_CONV) == 0,
                                          ^                                      ~~
   include/linux/regmap.h:124:58: note: expanded from macro 'regmap_read_poll_timeout'
           __tmp = read_poll_timeout(regmap_read, __ret, __ret || (cond), \
                                                                   ^~~~
   include/linux/iopoll.h:58:3: note: expanded from macro 'read_poll_timeout'
           (cond) ? 0 : -ETIMEDOUT; \
            ^~~~
   drivers/iio/temperature/mlx90635.c:380:12: note: add parentheses after the '!' to evaluate the comparison first
   drivers/iio/temperature/mlx90635.c:380:12: note: add parentheses around left hand side expression to silence this warning
   2 warnings generated.


vim +380 drivers/iio/temperature/mlx90635.c

   356	
   357	static int mlx90635_perform_measurement_burst(struct mlx90635_data *data)
   358	{
   359		unsigned int reg_status;
   360		int refresh_time;
   361		int ret;
   362	
   363		ret = regmap_write_bits(data->regmap, MLX90635_REG_STATUS,
   364					MLX90635_STAT_END_CONV, MLX90635_STAT_END_CONV);
   365		if (ret < 0)
   366			return ret;
   367	
   368		ret = mlx90635_calculate_dataset_ready_time(data, &refresh_time);
   369		if (ret < 0)
   370			return ret;
   371	
   372		ret = regmap_write_bits(data->regmap, MLX90635_REG_CTRL2,
   373					MLX90635_CTRL2_SOB(1), MLX90635_CTRL2_SOB(1));
   374		if (ret < 0)
   375			return ret;
   376	
   377		msleep(refresh_time); /* Wait minimum time for dataset to be ready */
   378	
   379		ret = regmap_read_poll_timeout(data->regmap, MLX90635_REG_STATUS, reg_status,
 > 380					       !(reg_status & MLX90635_STAT_END_CONV) == 0,
   381					       MLX90635_TIMING_POLLING, MLX90635_READ_RETRIES * 10000);
   382		if (ret < 0) {
   383			dev_err(&data->client->dev, "data not ready");
   384			return -ETIMEDOUT;
   385		}
   386	
   387		return ret;
   388	}
   389	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
