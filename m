Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BB47EDB67
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 07:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjKPGEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 01:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjKPGEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 01:04:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70B11A3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 22:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700114679; x=1731650679;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qzx0Uwl/XWwSseR1iZmncAHgqTTMi/MLGZmLBKaBFz8=;
  b=ATZnp4x0GxUrrsNVfFJ//G+j2cAMeFjiw6zeoqeKtJ1V23KJyuF3eLDq
   Si3j/yyfUb83dJohXPcDyQIuZ9Ew6EyQS+py0h2Vunl0YWVK/OSU8Rfkd
   VbZqx+8Ci7HNe0I+jcvX9Y8N6HRjCrXKzvRrGG9jcS+E9ycFLabGWVLFU
   V2ZvcpCzg5cbbx/N0HZiyZXf8/zF7j50ljD7bsaoDCMnJMM/q3X9L/fx3
   ms5z4exO7F/CUUlUR8aAoW1dLWku72nuxEQSh6BaXfwGGyiR0kVXmjcdk
   uDbVoqOebgSFIXv0Jl4fAjH8GE29ivRDxD0W4JXt4/pO/4VVRxNo6aFX4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="389879855"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="389879855"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 22:04:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="909011145"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="909011145"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 15 Nov 2023 22:04:38 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3VUS-0001Mx-0g;
        Thu, 16 Nov 2023 06:04:36 +0000
Date:   Thu, 16 Nov 2023 14:03:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: drivers/mux/adg792a.c:134:34: warning: 'adg792a_of_match' defined
 but not used
Message-ID: <202311161306.opyfcoCY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aswath,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c
commit: e4d4371253029528c02bfb43a46c252e1c3d035f phy: phy-can-transceiver: Add support for setting mux
date:   1 year, 7 months ago
config: x86_64-randconfig-x012-20230629 (https://download.01.org/0day-ci/archive/20231116/202311161306.opyfcoCY-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311161306.opyfcoCY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311161306.opyfcoCY-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mux/adg792a.c:134:34: warning: 'adg792a_of_match' defined but not used [-Wunused-const-variable=]
     134 | static const struct of_device_id adg792a_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~


vim +/adg792a_of_match +134 drivers/mux/adg792a.c

afda08c4caa94895 drivers/mux/mux-adg792a.c Peter Rosin 2017-05-14  133  
afda08c4caa94895 drivers/mux/mux-adg792a.c Peter Rosin 2017-05-14 @134  static const struct of_device_id adg792a_of_match[] = {
afda08c4caa94895 drivers/mux/mux-adg792a.c Peter Rosin 2017-05-14  135  	{ .compatible = "adi,adg792a", },
afda08c4caa94895 drivers/mux/mux-adg792a.c Peter Rosin 2017-05-14  136  	{ .compatible = "adi,adg792g", },
afda08c4caa94895 drivers/mux/mux-adg792a.c Peter Rosin 2017-05-14  137  	{ }
afda08c4caa94895 drivers/mux/mux-adg792a.c Peter Rosin 2017-05-14  138  };
afda08c4caa94895 drivers/mux/mux-adg792a.c Peter Rosin 2017-05-14  139  MODULE_DEVICE_TABLE(of, adg792a_of_match);
afda08c4caa94895 drivers/mux/mux-adg792a.c Peter Rosin 2017-05-14  140  

:::::: The code at line 134 was first introduced by commit
:::::: afda08c4caa9489511557def51e322a5f2142a2f mux: adg792a: add mux controller driver for ADG792A/G

:::::: TO: Peter Rosin <peda@axentia.se>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
