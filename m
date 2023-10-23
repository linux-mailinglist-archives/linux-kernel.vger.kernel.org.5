Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77CB7D431A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 01:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjJWXKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 19:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJWXK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 19:10:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450C4D68
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 16:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698102626; x=1729638626;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2DTHrKNA7mweT0JgMxWkZFN/aHE3omR2fa0y4eM3/gs=;
  b=lw1QlTkCUwKDa21+U4ujx24+xiFiUjn8/vEXJzoXaeY2JYRHTnpRpyCP
   sypkODoPZtdbW2sRABeGqejOgUcm53j6GNewHWTYbXkDVTHkPL/mLcS2V
   APBKpMCUImPVDR3fNaeCrPrWyTntcfqFJMH9hLC/Fw7zD9Ye7JQ/yrmXG
   AIveI2OmYaLw1H51pH7l3UBWHmY9u3sxAqJfVeS3PHdN/2jpHPfnwUowr
   N1YxsdAMxpdlbecqZ4sEqlC4LVaiSn4NNC6vsqYfm0ATfHVgAWLyC5dFr
   HNQN9lK1h+aQ0dui3OJvV8IZlRcOa9VNvjqeWYHFUEiEzYgrrB3gYc1Sz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="385841765"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="385841765"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 16:10:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="881924053"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="881924053"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 23 Oct 2023 16:10:23 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qv43x-0007MH-0m;
        Mon, 23 Oct 2023 23:10:21 +0000
Date:   Tue, 24 Oct 2023 07:09:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     kenechukwu maduechesi <maduechesik@gmail.com>,
        outreachy@lists.linux.dev, shreeya.patel23498@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: Replace delay function.
Message-ID: <202310240604.OZnfTcMT-lkp@intel.com>
References: <20231018004300.GA3189@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018004300.GA3189@ubuntu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi kenechukwu,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/kenechukwu-maduechesi/staging-rts5208-Replace-delay-function/20231018-090457
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20231018004300.GA3189%40ubuntu
patch subject: [PATCH] staging: rts5208: Replace delay function.
config: microblaze-allyesconfig (https://download.01.org/0day-ci/archive/20231024/202310240604.OZnfTcMT-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231024/202310240604.OZnfTcMT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310240604.OZnfTcMT-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/staging/rts5208/sd.c: In function 'sd_change_phase':
>> drivers/staging/rts5208/sd.c:868:25: error: too few arguments to function 'usleep_range'
     868 |                         usleep_range(50);
         |                         ^~~~~~~~~~~~
   In file included from drivers/staging/rts5208/rtsx.h:17,
                    from drivers/staging/rts5208/sd.c:16:
   include/linux/delay.h:66:20: note: declared here
      66 | static inline void usleep_range(unsigned long min, unsigned long max)
         |                    ^~~~~~~~~~~~
   drivers/staging/rts5208/sd.c:880:25: error: too few arguments to function 'usleep_range'
     880 |                         usleep_range(50);
         |                         ^~~~~~~~~~~~
   include/linux/delay.h:66:20: note: declared here
      66 | static inline void usleep_range(unsigned long min, unsigned long max)
         |                    ^~~~~~~~~~~~
   drivers/staging/rts5208/sd.c:887:17: error: too few arguments to function 'usleep_range'
     887 |                 usleep_range(100);
         |                 ^~~~~~~~~~~~
   include/linux/delay.h:66:20: note: declared here
      66 | static inline void usleep_range(unsigned long min, unsigned long max)
         |                    ^~~~~~~~~~~~
   drivers/staging/rts5208/sd.c:921:17: error: too few arguments to function 'usleep_range'
     921 |                 usleep_range(50);
         |                 ^~~~~~~~~~~~
   include/linux/delay.h:66:20: note: declared here
      66 | static inline void usleep_range(unsigned long min, unsigned long max)
         |                    ^~~~~~~~~~~~
   drivers/staging/rts5208/sd.c: In function 'sd_wait_data_idle':
   drivers/staging/rts5208/sd.c:1419:17: error: too few arguments to function 'usleep_range'
    1419 |                 usleep_range(100);
         |                 ^~~~~~~~~~~~
   include/linux/delay.h:66:20: note: declared here
      66 | static inline void usleep_range(unsigned long min, unsigned long max)
         |                    ^~~~~~~~~~~~


vim +/usleep_range +868 drivers/staging/rts5208/sd.c

   814	
   815	static int sd_change_phase(struct rtsx_chip *chip, u8 sample_point, u8 tune_dir)
   816	{
   817		struct sd_info *sd_card = &chip->sd_card;
   818		u16 SD_VP_CTL, SD_DCMPS_CTL;
   819		u8 val;
   820		int retval;
   821		bool ddr_rx = false;
   822	
   823		dev_dbg(rtsx_dev(chip), "%s (sample_point = %d, tune_dir = %d)\n",
   824			__func__, sample_point, tune_dir);
   825	
   826		if (tune_dir == TUNE_RX) {
   827			SD_VP_CTL = SD_VPRX_CTL;
   828			SD_DCMPS_CTL = SD_DCMPS_RX_CTL;
   829			if (CHK_SD_DDR50(sd_card))
   830				ddr_rx = true;
   831		} else {
   832			SD_VP_CTL = SD_VPTX_CTL;
   833			SD_DCMPS_CTL = SD_DCMPS_TX_CTL;
   834		}
   835	
   836		if (chip->asic_code) {
   837			retval = rtsx_write_register(chip, CLK_CTL, CHANGE_CLK,
   838						     CHANGE_CLK);
   839			if (retval)
   840				return retval;
   841			retval = rtsx_write_register(chip, SD_VP_CTL, 0x1F,
   842						     sample_point);
   843			if (retval)
   844				return retval;
   845			retval = rtsx_write_register(chip, SD_VPCLK0_CTL,
   846						     PHASE_NOT_RESET, 0);
   847			if (retval)
   848				return retval;
   849			retval = rtsx_write_register(chip, SD_VPCLK0_CTL,
   850						     PHASE_NOT_RESET, PHASE_NOT_RESET);
   851			if (retval)
   852				return retval;
   853			retval = rtsx_write_register(chip, CLK_CTL, CHANGE_CLK, 0);
   854			if (retval)
   855				return retval;
   856		} else {
   857			rtsx_read_register(chip, SD_VP_CTL, &val);
   858			dev_dbg(rtsx_dev(chip), "SD_VP_CTL: 0x%x\n", val);
   859			rtsx_read_register(chip, SD_DCMPS_CTL, &val);
   860			dev_dbg(rtsx_dev(chip), "SD_DCMPS_CTL: 0x%x\n", val);
   861	
   862			if (ddr_rx) {
   863				retval = rtsx_write_register(chip, SD_VP_CTL,
   864							     PHASE_CHANGE,
   865							     PHASE_CHANGE);
   866				if (retval)
   867					return retval;
 > 868				usleep_range(50);
   869				retval = rtsx_write_register(chip, SD_VP_CTL, 0xFF,
   870							     PHASE_CHANGE |
   871							     PHASE_NOT_RESET |
   872							     sample_point);
   873				if (retval)
   874					return retval;
   875			} else {
   876				retval = rtsx_write_register(chip, CLK_CTL,
   877							     CHANGE_CLK, CHANGE_CLK);
   878				if (retval)
   879					return retval;
   880				usleep_range(50);
   881				retval = rtsx_write_register(chip, SD_VP_CTL, 0xFF,
   882							     PHASE_NOT_RESET |
   883							     sample_point);
   884				if (retval)
   885					return retval;
   886			}
   887			usleep_range(100);
   888	
   889			rtsx_init_cmd(chip);
   890			rtsx_add_cmd(chip, WRITE_REG_CMD, SD_DCMPS_CTL, DCMPS_CHANGE,
   891				     DCMPS_CHANGE);
   892			rtsx_add_cmd(chip, CHECK_REG_CMD, SD_DCMPS_CTL,
   893				     DCMPS_CHANGE_DONE, DCMPS_CHANGE_DONE);
   894			retval = rtsx_send_cmd(chip, SD_CARD, 100);
   895			if (retval != STATUS_SUCCESS)
   896				goto fail;
   897	
   898			val = *rtsx_get_cmd_data(chip);
   899			if (val & DCMPS_ERROR)
   900				goto fail;
   901	
   902			if ((val & DCMPS_CURRENT_PHASE) != sample_point)
   903				goto fail;
   904	
   905			retval = rtsx_write_register(chip, SD_DCMPS_CTL,
   906						     DCMPS_CHANGE, 0);
   907			if (retval)
   908				return retval;
   909			if (ddr_rx) {
   910				retval = rtsx_write_register(chip, SD_VP_CTL,
   911							     PHASE_CHANGE, 0);
   912				if (retval)
   913					return retval;
   914			} else {
   915				retval = rtsx_write_register(chip, CLK_CTL,
   916							     CHANGE_CLK, 0);
   917				if (retval)
   918					return retval;
   919			}
   920	
   921			usleep_range(50);
   922		}
   923	
   924		retval = rtsx_write_register(chip, SD_CFG1, SD_ASYNC_FIFO_NOT_RST, 0);
   925		if (retval)
   926			return retval;
   927	
   928		return STATUS_SUCCESS;
   929	
   930	fail:
   931		rtsx_read_register(chip, SD_VP_CTL, &val);
   932		dev_dbg(rtsx_dev(chip), "SD_VP_CTL: 0x%x\n", val);
   933		rtsx_read_register(chip, SD_DCMPS_CTL, &val);
   934		dev_dbg(rtsx_dev(chip), "SD_DCMPS_CTL: 0x%x\n", val);
   935	
   936		rtsx_write_register(chip, SD_DCMPS_CTL, DCMPS_CHANGE, 0);
   937		rtsx_write_register(chip, SD_VP_CTL, PHASE_CHANGE, 0);
   938		mdelay(10);
   939		sd_reset_dcm(chip, tune_dir);
   940		return STATUS_FAIL;
   941	}
   942	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
