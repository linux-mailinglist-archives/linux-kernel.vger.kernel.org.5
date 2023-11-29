Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391D57FD7D4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbjK2NVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjK2NV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:21:29 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA258A3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701264095; x=1732800095;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Uv+3/7Aknztxs5cU3L4/DlG3aMAvoCSv3yWSlEqW9f4=;
  b=LuopfG/k/DI946gqvYwQNbEawH2QxqBcerAOgqGhQUqEfJo1N6G42qyu
   N419YB/D+CmoyYroHZDD4j/fhH0YmUMmLhCX3cynVBQ8X9C/5tgSBhV4N
   30c7pT56vzYeKQn0bwv3y+08MkpTZjsvYnzInlXuUd8ekls39hyNh4hc5
   h8UGiw9DEu+ZZW+aI+QLCEzxUxgnNAHqPAJZZg9jfBtYsPHyn/tLhHoRP
   51VmPZ+iaWn8XyljQA/rGXioigZ2VfPkQy2ei3G6DTeY9qN+rPFayfvDV
   Og2S6WgsWhVwszX3QGcFfFnr2QzoRrApoVSBORLXYyfsbiClL2d4NzKJJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="424307193"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="424307193"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 05:21:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="859819811"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="859819811"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Nov 2023 05:21:25 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8KVG-0000H6-2y;
        Wed, 29 Nov 2023 13:21:22 +0000
Date:   Wed, 29 Nov 2023 21:20:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>
Subject: drivers/leds/leds-turris-omnia.c:438:15: sparse: sparse: cast to
 restricted __le16
Message-ID: <202311292057.IghAU74s-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   18d46e76d7c2eedd8577fae67e3f1d4db25018b0
commit: 43e9082fbccc7df8b2028c1ba040c58cefda703f leds: turris-omnia: Add support for enabling/disabling HW gamma correction
date:   4 weeks ago
config: sparc-randconfig-r004-20230225 (https://download.01.org/0day-ci/archive/20231129/202311292057.IghAU74s-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20231129/202311292057.IghAU74s-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311292057.IghAU74s-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/leds/leds-turris-omnia.c:438:15: sparse: sparse: cast to restricted __le16
>> drivers/leds/leds-turris-omnia.c:438:15: sparse: sparse: cast to restricted __le16
>> drivers/leds/leds-turris-omnia.c:438:15: sparse: sparse: cast to restricted __le16
>> drivers/leds/leds-turris-omnia.c:438:15: sparse: sparse: cast to restricted __le16
   drivers/leds/leds-turris-omnia.c:446:16: sparse: sparse: cast to restricted __le16
   drivers/leds/leds-turris-omnia.c:446:16: sparse: sparse: cast to restricted __le16
   drivers/leds/leds-turris-omnia.c:446:16: sparse: sparse: cast to restricted __le16
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
