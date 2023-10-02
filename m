Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53CB7B4FDC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 12:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbjJBKE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 06:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjJBKEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 06:04:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773599F;
        Mon,  2 Oct 2023 03:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696241090; x=1727777090;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5D4U+LA+ZgnEx7OwERb3YlJnlwrY5TKHb6buSPufX1M=;
  b=JY7WR9JxRzqWzhS5ZAW3pKjqDJWwQP57BmjJGr9WqWSOQ6DLUqclBLy0
   jm102MTGhiGUeQKLntxh72w13jp65MA7qMf3W1euZVPG3hdyZK8lPPbUR
   k1hfvWNumurpmFPv9QpaOSB1VvAwj871GFRF7fvm0mKzCuw2wctxwdA8H
   PDF1c1GITvISGX9CB/5sRPz47DDh9VT9Gqm7AQLfmJYJUitE9FOmFZNe/
   SjvpiwxHCccHYInDYOyb8fwmtPWF+4Xkj2O+ZXR19v9EYeJ606c3w24PA
   WceTSP73vUtGZCViOKcEAMujz24cwqlmSQ0QA2uiYCvp+e34vuK9eHS1n
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="381497171"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="381497171"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 03:04:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="820843587"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="820843587"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 02 Oct 2023 03:04:45 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qnFnA-0005w5-2B;
        Mon, 02 Oct 2023 10:04:44 +0000
Date:   Mon, 2 Oct 2023 18:04:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v7 3/4] Input: goodix-berlin - add I2C support for Goodix
 Berlin Touchscreen IC
Message-ID: <202310021730.epucKAC1-lkp@intel.com>
References: <20231002-topic-goodix-berlin-upstream-initial-v7-3-792fb91f5e88@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002-topic-goodix-berlin-upstream-initial-v7-3-792fb91f5e88@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

kernel test robot noticed the following build errors:

[auto build test ERROR on 6465e260f48790807eef06b583b38ca9789b6072]

url:    https://github.com/intel-lab-lkp/linux/commits/Neil-Armstrong/dt-bindings-input-document-Goodix-Berlin-Touchscreen-IC/20231002-145648
base:   6465e260f48790807eef06b583b38ca9789b6072
patch link:    https://lore.kernel.org/r/20231002-topic-goodix-berlin-upstream-initial-v7-3-792fb91f5e88%40linaro.org
patch subject: [PATCH v7 3/4] Input: goodix-berlin - add I2C support for Goodix Berlin Touchscreen IC
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20231002/202310021730.epucKAC1-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231002/202310021730.epucKAC1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310021730.epucKAC1-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/input/touchscreen/goodix_berlin_core.c: In function 'goodix_berlin_checksum_valid':
>> drivers/input/touchscreen/goodix_berlin_core.c:50:16: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
      50 |         return FIELD_GET(GOODIX_BERLIN_COOR_DATA_CHECKSUM_MASK, cal_checksum) == r_checksum;
         |                ^~~~~~~~~
   drivers/input/touchscreen/goodix_berlin_core.c: In function 'goodix_berlin_get_ic_info':
>> drivers/input/touchscreen/goodix_berlin_core.c:284:1: warning: the frame size of 1140 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     284 | }
         | ^
   cc1: some warnings being treated as errors


vim +/FIELD_GET +50 drivers/input/touchscreen/goodix_berlin_core.c

3fd649a6bbd95d Neil Armstrong 2023-10-02  15  
3fd649a6bbd95d Neil Armstrong 2023-10-02  16  /*
3fd649a6bbd95d Neil Armstrong 2023-10-02  17   * Goodix "Berlin" Touchscreen ID driver
3fd649a6bbd95d Neil Armstrong 2023-10-02  18   *
3fd649a6bbd95d Neil Armstrong 2023-10-02  19   * This driver is distinct from goodix.c since hardware interface
3fd649a6bbd95d Neil Armstrong 2023-10-02  20   * is different enough to require a new driver.
3fd649a6bbd95d Neil Armstrong 2023-10-02  21   * None of the register address or data structure are close enough
3fd649a6bbd95d Neil Armstrong 2023-10-02  22   * to the previous generations.
3fd649a6bbd95d Neil Armstrong 2023-10-02  23   *
3fd649a6bbd95d Neil Armstrong 2023-10-02  24   * Currently only handles Multitouch events with already
3fd649a6bbd95d Neil Armstrong 2023-10-02  25   * programmed firmware and "config" for "Revision D" Berlin IC.
3fd649a6bbd95d Neil Armstrong 2023-10-02  26   *
3fd649a6bbd95d Neil Armstrong 2023-10-02  27   * Support is missing for:
3fd649a6bbd95d Neil Armstrong 2023-10-02  28   * - ESD Management
3fd649a6bbd95d Neil Armstrong 2023-10-02  29   * - Firmware update/flashing
3fd649a6bbd95d Neil Armstrong 2023-10-02  30   * - "Config" update/flashing
3fd649a6bbd95d Neil Armstrong 2023-10-02  31   * - Stylus Events
3fd649a6bbd95d Neil Armstrong 2023-10-02  32   * - Gesture Events
3fd649a6bbd95d Neil Armstrong 2023-10-02  33   * - Support for older revisions (A & B)
3fd649a6bbd95d Neil Armstrong 2023-10-02  34   */
3fd649a6bbd95d Neil Armstrong 2023-10-02  35  
3fd649a6bbd95d Neil Armstrong 2023-10-02  36  static bool goodix_berlin_checksum_valid(const u8 *data, int size)
3fd649a6bbd95d Neil Armstrong 2023-10-02  37  {
3fd649a6bbd95d Neil Armstrong 2023-10-02  38  	u32 cal_checksum = 0;
3fd649a6bbd95d Neil Armstrong 2023-10-02  39  	u16 r_checksum;
3fd649a6bbd95d Neil Armstrong 2023-10-02  40  	u32 i;
3fd649a6bbd95d Neil Armstrong 2023-10-02  41  
3fd649a6bbd95d Neil Armstrong 2023-10-02  42  	if (size < GOODIX_BERLIN_COOR_DATA_CHECKSUM_SIZE)
3fd649a6bbd95d Neil Armstrong 2023-10-02  43  		return false;
3fd649a6bbd95d Neil Armstrong 2023-10-02  44  
3fd649a6bbd95d Neil Armstrong 2023-10-02  45  	for (i = 0; i < size - GOODIX_BERLIN_COOR_DATA_CHECKSUM_SIZE; i++)
3fd649a6bbd95d Neil Armstrong 2023-10-02  46  		cal_checksum += data[i];
3fd649a6bbd95d Neil Armstrong 2023-10-02  47  
3fd649a6bbd95d Neil Armstrong 2023-10-02  48  	r_checksum = get_unaligned_le16(&data[i]);
3fd649a6bbd95d Neil Armstrong 2023-10-02  49  
3fd649a6bbd95d Neil Armstrong 2023-10-02 @50  	return FIELD_GET(GOODIX_BERLIN_COOR_DATA_CHECKSUM_MASK, cal_checksum) == r_checksum;
3fd649a6bbd95d Neil Armstrong 2023-10-02  51  }
3fd649a6bbd95d Neil Armstrong 2023-10-02  52  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
