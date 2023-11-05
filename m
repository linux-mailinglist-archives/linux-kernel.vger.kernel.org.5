Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1786F7E16B6
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 21:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjKEU7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 15:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEU7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 15:59:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18BF97
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 12:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699217961; x=1730753961;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bpggp+jfEBeZBE1fxRDYA37/V6b3KkZ7Tyn+qf8LJIY=;
  b=A2JmpBQtebgjUUiTsoFt4VXvyrjafYW6sqwCEmGI+25zdkcP5PRs6jfZ
   3PU8GG0oOO17BGGbW9d4rF0tWeNFO4F8MGK5MovHaGj2TDSS0KYkfTRPa
   JEsfEsCcmpYohqPGRhnszvowDAA4g3Z0BVFFFqZodaL9X2g/vVU946ZOj
   RkOW0PXjSK4Gm1NK/E+hj4Paw3EmersjMU5dILT82cNQZCuWV6deL8S7t
   yL2d/Cu5l4PSgsSTEbedHFgRksDjE9FRuLCKnAineNEE+4iXSc+qvY/XH
   Rd/po+5fLu6bpH4e8Bv1opYwVdEVOVOB1QktqzTcgph0yuOoSjTFMtix4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="10712392"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="10712392"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 12:59:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="1009340930"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="1009340930"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 05 Nov 2023 12:59:18 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzkDE-0005n6-0Z;
        Sun, 05 Nov 2023 20:59:16 +0000
Date:   Mon, 6 Nov 2023 04:58:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     kenechukwu maduechesi <maduechesik@gmail.com>,
        outreachy@lists.linux.dev, shreeya.patel23498@gmail.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: Replace delay function.
Message-ID: <202311060455.MQsyG6kq-lkp@intel.com>
References: <20231018004300.GA3189@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018004300.GA3189@ubuntu>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20231106/202311060455.MQsyG6kq-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231106/202311060455.MQsyG6kq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311060455.MQsyG6kq-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/staging/rts5208/sd.c:868:19: error: too few arguments to function call, expected 2, have 1
                           usleep_range(50);
                           ~~~~~~~~~~~~   ^
   include/linux/delay.h:66:20: note: 'usleep_range' declared here
   static inline void usleep_range(unsigned long min, unsigned long max)
                      ^
   drivers/staging/rts5208/sd.c:880:19: error: too few arguments to function call, expected 2, have 1
                           usleep_range(50);
                           ~~~~~~~~~~~~   ^
   include/linux/delay.h:66:20: note: 'usleep_range' declared here
   static inline void usleep_range(unsigned long min, unsigned long max)
                      ^
   drivers/staging/rts5208/sd.c:887:19: error: too few arguments to function call, expected 2, have 1
                   usleep_range(100);
                   ~~~~~~~~~~~~    ^
   include/linux/delay.h:66:20: note: 'usleep_range' declared here
   static inline void usleep_range(unsigned long min, unsigned long max)
                      ^
   drivers/staging/rts5208/sd.c:921:18: error: too few arguments to function call, expected 2, have 1
                   usleep_range(50);
                   ~~~~~~~~~~~~   ^
   include/linux/delay.h:66:20: note: 'usleep_range' declared here
   static inline void usleep_range(unsigned long min, unsigned long max)
                      ^
   drivers/staging/rts5208/sd.c:1419:19: error: too few arguments to function call, expected 2, have 1
                   usleep_range(100);
                   ~~~~~~~~~~~~    ^
   include/linux/delay.h:66:20: note: 'usleep_range' declared here
   static inline void usleep_range(unsigned long min, unsigned long max)
                      ^
   5 errors generated.


vim +868 drivers/staging/rts5208/sd.c

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
