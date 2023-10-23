Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DED7D2905
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 05:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjJWDYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 23:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjJWDYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 23:24:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508D9188;
        Sun, 22 Oct 2023 20:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698031471; x=1729567471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WG7qKWGw/AVDVBViDrvNqZrBZW+aiYkM5T/NGemPMbg=;
  b=QoV+b182rC+OmkkAKAojHH+iXNdfZXsKyVQPGhsB7FLo8O7Arpz8M0r0
   zlReltiMGvowFVpvPwJ3aoerNXf5oE9CR9nb/k3Esl/Ieuj4nQgemDVow
   vOj1n23AmUEWn7m35EICeIVN5yxp4I04WeFl/nwoCQw9Gj4p3lOd2DiM2
   /ibj65z3OSCvcAhL5lHFuuG/mbawk9yP5eTC9NnQFVGgZ3Su+gGRovnmG
   Ym9dNfK2IUBF4VVvz66+zTHqgkYbKiOJgLbazWvfjWK49/tx/ORZkMzUb
   S7rcoooLPrxZux+Tln23/B1xZHTll/RVkAzzFAdiHELvfLBzy+2Yaymw6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="472971052"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="472971052"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 20:24:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="1005169869"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="1005169869"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 22 Oct 2023 20:24:27 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qulYH-0006WL-0R;
        Mon, 23 Oct 2023 03:24:25 +0000
Date:   Mon, 23 Oct 2023 11:24:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Jeff LaBundy <jeff@labundy.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v9 3/4] Input: goodix-berlin - add I2C support for Goodix
 Berlin Touchscreen IC
Message-ID: <202310231123.eHyxswnW-lkp@intel.com>
References: <20231021-topic-goodix-berlin-upstream-initial-v9-3-13fb4e887156@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231021-topic-goodix-berlin-upstream-initial-v9-3-13fb4e887156@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 2030579113a1b1b5bfd7ff24c0852847836d8fd1]

url:    https://github.com/intel-lab-lkp/linux/commits/Neil-Armstrong/dt-bindings-input-document-Goodix-Berlin-Touchscreen-IC/20231021-191942
base:   2030579113a1b1b5bfd7ff24c0852847836d8fd1
patch link:    https://lore.kernel.org/r/20231021-topic-goodix-berlin-upstream-initial-v9-3-13fb4e887156%40linaro.org
patch subject: [PATCH v9 3/4] Input: goodix-berlin - add I2C support for Goodix Berlin Touchscreen IC
config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20231023/202310231123.eHyxswnW-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231023/202310231123.eHyxswnW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310231123.eHyxswnW-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/input/touchscreen/goodix_berlin_core.c: In function 'goodix_berlin_get_ic_info':
>> drivers/input/touchscreen/goodix_berlin_core.c:285:1: warning: the frame size of 1148 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     285 | }
         | ^


vim +285 drivers/input/touchscreen/goodix_berlin_core.c

7aae63b22cf7e9 Neil Armstrong 2023-10-21  235  
7aae63b22cf7e9 Neil Armstrong 2023-10-21  236  static int goodix_berlin_get_ic_info(struct goodix_berlin_core *cd)
7aae63b22cf7e9 Neil Armstrong 2023-10-21  237  {
7aae63b22cf7e9 Neil Armstrong 2023-10-21  238  	u8 afe_data[GOODIX_BERLIN_IC_INFO_MAX_LEN];
7aae63b22cf7e9 Neil Armstrong 2023-10-21  239  	__le16 length_raw;
7aae63b22cf7e9 Neil Armstrong 2023-10-21  240  	u16 length;
7aae63b22cf7e9 Neil Armstrong 2023-10-21  241  	int error;
7aae63b22cf7e9 Neil Armstrong 2023-10-21  242  
7aae63b22cf7e9 Neil Armstrong 2023-10-21  243  	error = regmap_raw_read(cd->regmap, GOODIX_BERLIN_IC_INFO_ADDR,
7aae63b22cf7e9 Neil Armstrong 2023-10-21  244  				&length_raw, sizeof(length_raw));
7aae63b22cf7e9 Neil Armstrong 2023-10-21  245  	if (error) {
7aae63b22cf7e9 Neil Armstrong 2023-10-21  246  		dev_info(cd->dev, "failed get ic info length, %d\n", error);
7aae63b22cf7e9 Neil Armstrong 2023-10-21  247  		return error;
7aae63b22cf7e9 Neil Armstrong 2023-10-21  248  	}
7aae63b22cf7e9 Neil Armstrong 2023-10-21  249  
7aae63b22cf7e9 Neil Armstrong 2023-10-21  250  	length = le16_to_cpu(length_raw);
7aae63b22cf7e9 Neil Armstrong 2023-10-21  251  	if (length >= GOODIX_BERLIN_IC_INFO_MAX_LEN) {
7aae63b22cf7e9 Neil Armstrong 2023-10-21  252  		dev_info(cd->dev, "invalid ic info length %d\n", length);
7aae63b22cf7e9 Neil Armstrong 2023-10-21  253  		return -EINVAL;
7aae63b22cf7e9 Neil Armstrong 2023-10-21  254  	}
7aae63b22cf7e9 Neil Armstrong 2023-10-21  255  
7aae63b22cf7e9 Neil Armstrong 2023-10-21  256  	error = regmap_raw_read(cd->regmap, GOODIX_BERLIN_IC_INFO_ADDR,
7aae63b22cf7e9 Neil Armstrong 2023-10-21  257  				afe_data, length);
7aae63b22cf7e9 Neil Armstrong 2023-10-21  258  	if (error) {
7aae63b22cf7e9 Neil Armstrong 2023-10-21  259  		dev_info(cd->dev, "failed get ic info data, %d\n", error);
7aae63b22cf7e9 Neil Armstrong 2023-10-21  260  		return error;
7aae63b22cf7e9 Neil Armstrong 2023-10-21  261  	}
7aae63b22cf7e9 Neil Armstrong 2023-10-21  262  
7aae63b22cf7e9 Neil Armstrong 2023-10-21  263  	/* check whether the data is valid (ex. bus default values) */
7aae63b22cf7e9 Neil Armstrong 2023-10-21  264  	if (goodix_berlin_is_dummy_data(cd, (const uint8_t *)afe_data, length)) {
7aae63b22cf7e9 Neil Armstrong 2023-10-21  265  		dev_err(cd->dev, "fw info data invalid\n");
7aae63b22cf7e9 Neil Armstrong 2023-10-21  266  		return -EINVAL;
7aae63b22cf7e9 Neil Armstrong 2023-10-21  267  	}
7aae63b22cf7e9 Neil Armstrong 2023-10-21  268  
7aae63b22cf7e9 Neil Armstrong 2023-10-21  269  	if (!goodix_berlin_checksum_valid((const uint8_t *)afe_data, length)) {
7aae63b22cf7e9 Neil Armstrong 2023-10-21  270  		dev_info(cd->dev, "fw info checksum error\n");
7aae63b22cf7e9 Neil Armstrong 2023-10-21  271  		return -EINVAL;
7aae63b22cf7e9 Neil Armstrong 2023-10-21  272  	}
7aae63b22cf7e9 Neil Armstrong 2023-10-21  273  
7aae63b22cf7e9 Neil Armstrong 2023-10-21  274  	error = goodix_berlin_convert_ic_info(cd, afe_data, length);
7aae63b22cf7e9 Neil Armstrong 2023-10-21  275  	if (error)
7aae63b22cf7e9 Neil Armstrong 2023-10-21  276  		return error;
7aae63b22cf7e9 Neil Armstrong 2023-10-21  277  
7aae63b22cf7e9 Neil Armstrong 2023-10-21  278  	/* check some key info */
7aae63b22cf7e9 Neil Armstrong 2023-10-21  279  	if (!cd->touch_data_addr) {
7aae63b22cf7e9 Neil Armstrong 2023-10-21  280  		dev_err(cd->dev, "touch_data_addr is null\n");
7aae63b22cf7e9 Neil Armstrong 2023-10-21  281  		return -EINVAL;
7aae63b22cf7e9 Neil Armstrong 2023-10-21  282  	}
7aae63b22cf7e9 Neil Armstrong 2023-10-21  283  
7aae63b22cf7e9 Neil Armstrong 2023-10-21  284  	return 0;
7aae63b22cf7e9 Neil Armstrong 2023-10-21 @285  }
7aae63b22cf7e9 Neil Armstrong 2023-10-21  286  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
