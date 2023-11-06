Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90437E191D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 04:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjKFDON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 22:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjKFDOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 22:14:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FBABB
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 19:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699240448; x=1730776448;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dbajzVtIpOq/cz2pmSW4X4RYySJcGXG6w+HpiWbMlPw=;
  b=bdOcF9bJxYz105NHA4sao6fxXaQjBpTdYZcBQwjXNet9YutXJgQdwvom
   deiYsEP/SZFugGIg/L4KBzDgjM+ZEGI7d2mGe3JlJSFowG7rIN2PE7cPo
   dytC7/Fs8CCaFf259P2j6Oy7PPMCUAzy4UsCQRoMwwBuqEfp8VGL6QIcb
   zwB5ABQ9RV8mC0UIGrzBI5wGg713quAZM2nkNqWmKMvG08jev5VJRw1nM
   3cbuVcWiIYAZf6zJUUz5+/L6/0TqwS2F2KwEmIBoCcVazV+lYoEjolMTH
   4HrwIBd9phr0CtcOilvx34ONktedDqUBuUBZ+02B3JN1FRhYk54xjuyuz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="374231528"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="374231528"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 19:14:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="762189122"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="762189122"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 05 Nov 2023 19:14:06 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzq3v-00063c-2K;
        Mon, 06 Nov 2023 03:14:03 +0000
Date:   Mon, 6 Nov 2023 11:13:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: sound/soc/amd/acp3x-rt5682-max9836.c:315:36: warning:
 'acp3x_audio_acpi_match' defined but not used
Message-ID: <202311061037.NzRrAjdy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   77fa2fbe87fc605c4bfa87dff87be9bfded0e9a3
commit: 6b8e4e7db3cd236a2cbb720360fb135087a2ac1d ASoC: amd: Add machine driver for Raven based platform
date:   3 years, 8 months ago
config: x86_64-buildonly-randconfig-r001-20220516 (https://download.01.org/0day-ci/archive/20231106/202311061037.NzRrAjdy-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231106/202311061037.NzRrAjdy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311061037.NzRrAjdy-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> sound/soc/amd/acp3x-rt5682-max9836.c:315:36: warning: 'acp3x_audio_acpi_match' defined but not used [-Wunused-const-variable=]
     315 | static const struct acpi_device_id acp3x_audio_acpi_match[] = {
         |                                    ^~~~~~~~~~~~~~~~~~~~~~


vim +/acp3x_audio_acpi_match +315 sound/soc/amd/acp3x-rt5682-max9836.c

   314	
 > 315	static const struct acpi_device_id acp3x_audio_acpi_match[] = {
   316		{ "AMDI5682", 0 },
   317		{},
   318	};
   319	MODULE_DEVICE_TABLE(acpi, acp3x_audio_acpi_match);
   320	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
