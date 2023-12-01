Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE8D800D11
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 15:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379156AbjLAOWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 09:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379143AbjLAOWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 09:22:21 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8723310F0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 06:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701440547; x=1732976547;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BPLVm0NmvvEtXLrMNI/giTZDx3EOgxRyFpu+roO4UZI=;
  b=LjAkCl0QJ68QSF8jG2YkWGLuc61GtkEY4jDwtO3pKpLLcJsKTjBpnMqj
   qlMG1D+EPPOgQqTXYHojG4lfDUjZyGDqx6AlY2mrYTWSEm9OleHI+Z0Sc
   ZM+wvBf3HFaIDUwpJPR3BwwbZ6PDXGoT8P50leaUJY/AXHMXewg4w7p6c
   qGv3H7RAN+94i3rpQZ8Xov0QghdDs5PzwOW686TwiZFulgTNp1GlNhe3B
   Ki8zG+8SuCOPin2kBuux5THcdnXzZGK0HJFyA4LM1WM4vukcYpfbgIy0N
   bBIEJEvRLG8aZGn1BZuonx++jAooKzjqHXKyviAhTUvNP0S7wYjQjH9rh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="524876"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="524876"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 06:22:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="773453108"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="773453108"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 01 Dec 2023 06:22:25 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r94PQ-0003nM-00;
        Fri, 01 Dec 2023 14:22:24 +0000
Date:   Fri, 1 Dec 2023 22:21:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>
Subject: drivers/leds/leds-turris-omnia.c:438:15: sparse: sparse: cast to
 restricted __le16
Message-ID: <202312012213.wUNHTGnZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   994d5c58e50e91bb02c7be4a91d5186292a895c8
commit: 43e9082fbccc7df8b2028c1ba040c58cefda703f leds: turris-omnia: Add support for enabling/disabling HW gamma correction
date:   4 weeks ago
config: loongarch-randconfig-r034-20230511 (https://download.01.org/0day-ci/archive/20231201/202312012213.wUNHTGnZ-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20231201/202312012213.wUNHTGnZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312012213.wUNHTGnZ-lkp@intel.com/

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
