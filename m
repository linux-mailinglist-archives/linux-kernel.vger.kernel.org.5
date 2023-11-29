Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672A27FDBC2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343874AbjK2Poe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343525AbjK2Poc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:44:32 -0500
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Nov 2023 07:44:39 PST
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87236D48
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701272679; x=1732808679;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=63xF9uOg8OVtnAgYBg5OwqCiqI0g2+7pktQhnVsh81A=;
  b=KgntEGmP4/pi3qq6YeEdYn3yV0rN4UamQ0IFCRT2HaM+4HG3+hSNTQOV
   9vZ5o39QxlhUr/HM34Sr6D2oMCZfKbKySB05mM9FHq9/4fOwNBfjHPBVm
   xEw4fWRqRbiQPDcUhxWrMP0KyaLr+CQJl4kReiJd4iZ8IpQGq/mYHzBfC
   GpoOGqJEdDZv9H53afgQ1iMfpFpqHkFgve//oXfK67YkKuCp1T7Ju0iXp
   pkzJV4mu3WaEpMkt23YW+6hBhgpKnRuDtwztTnBxSg3Q9F6AuEpB5jbap
   uljrjHd6frdZgC2Y5CyfpOYcYRdwrqbSSnkM3FUqkrblD9+FTBYy17kB8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="83286"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="83286"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 07:43:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="839470240"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="839470240"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 29 Nov 2023 07:43:37 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8Mit-0000Os-0U;
        Wed, 29 Nov 2023 15:43:35 +0000
Date:   Wed, 29 Nov 2023 23:43:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>
Subject: drivers/leds/leds-turris-omnia.c:438:15: sparse: sparse: cast to
 restricted __le16
Message-ID: <202311292308.oZ97PtBs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   18d46e76d7c2eedd8577fae67e3f1d4db25018b0
commit: 43e9082fbccc7df8b2028c1ba040c58cefda703f leds: turris-omnia: Add support for enabling/disabling HW gamma correction
date:   4 weeks ago
config: powerpc-randconfig-c042-20230517 (https://download.01.org/0day-ci/archive/20231129/202311292308.oZ97PtBs-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20231129/202311292308.oZ97PtBs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311292308.oZ97PtBs-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/leds/leds-turris-omnia.c:438:15: sparse: sparse: cast to restricted __le16
   drivers/leds/leds-turris-omnia.c:446:16: sparse: sparse: cast to restricted __le16

vim +438 drivers/leds/leds-turris-omnia.c

   426	
   427	static int omnia_mcu_get_features(const struct i2c_client *client)
   428	{
   429		u16 reply;
   430		int err;
   431	
   432		err = omnia_cmd_read_raw(client->adapter, OMNIA_MCU_I2C_ADDR,
   433					 CMD_GET_STATUS_WORD, &reply, sizeof(reply));
   434		if (err < 0)
   435			return err;
   436	
   437		/* Check whether MCU firmware supports the CMD_GET_FEAUTRES command */
 > 438		if (!(le16_to_cpu(reply) & STS_FEATURES_SUPPORTED))
   439			return 0;
   440	
   441		err = omnia_cmd_read_raw(client->adapter, OMNIA_MCU_I2C_ADDR,
   442					 CMD_GET_FEATURES, &reply, sizeof(reply));
   443		if (err < 0)
   444			return err;
   445	
   446		return le16_to_cpu(reply);
   447	}
   448	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
