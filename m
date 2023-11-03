Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6A37E011F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346957AbjKCJXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 05:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346978AbjKCJXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 05:23:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EDDD46
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 02:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699003403; x=1730539403;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UKF4yHvLsTDHBFzDY/OehueONcmx1m7S/EbTJbzOH/Y=;
  b=MPWqThBMdafwPsOmUjHfgAbpmFsCeH177xdpAc+n7NWr3ET5BSuCK4zu
   q5QsPDh4U9owEYT+Y6TYGUCEJ1PsDpOlR2S9y8IgHU+zWjsLeeZwCT4jk
   qNxg50N4bAIQG+lDaOjA/NeGmV1lNApyGfSwJJDItWxCO3kz2toF1Z2y+
   oHI7d2BSfCqYEhhmfkuZGwHn4eLhVNPbZUhKHloZJae0jHDfcSMUqIU6N
   WZYmFTjD+m4+eKFSra9D449mrXXhlJcIVN07L9z2FSVRD5U7ggb1ZCcKG
   27wb5gEIhUx8NzMjjOkVwCytYS5XGGZ80Breqn86ONKNwK5G0LSTphuN1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="369117562"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="369117562"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 02:23:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="9671046"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 03 Nov 2023 02:23:21 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyqOd-0002PQ-0b;
        Fri, 03 Nov 2023 09:23:19 +0000
Date:   Fri, 3 Nov 2023 17:22:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shanker Donthineni <sdonthineni@nvidia.com>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, Vikram Sethi <vsethi@nvidia.com>
Subject: kismet: WARNING: unmet direct dependencies detected for
 HAVE_ARM_SMCCC_DISCOVERY when selected by ARM_GIC_V3
Message-ID: <202311031706.irbBcT0N-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8f6f76a6a29f36d2f3e4510d0bde5046672f6924
commit: 35727af2b15d98a2dd2811d631d3a3886111312e irqchip/gicv3: Workaround for NVIDIA erratum T241-FABRIC-4
date:   7 months ago
config: arm-kismet-CONFIG_HAVE_ARM_SMCCC_DISCOVERY-CONFIG_ARM_GIC_V3-0-0 (https://download.01.org/0day-ci/archive/20231103/202311031706.irbBcT0N-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20231103/202311031706.irbBcT0N-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311031706.irbBcT0N-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for HAVE_ARM_SMCCC_DISCOVERY when selected by ARM_GIC_V3
   .config:7014:warning: symbol value 'ONFIG_ARCH_MMAP_RND_BITS_MI' invalid for ARCH_MMAP_RND_BITS
   
   WARNING: unmet direct dependencies detected for HAVE_ARM_SMCCC_DISCOVERY
     Depends on [n]: ARM_PSCI_FW [=n]
     Selected by [y]:
     - ARM_GIC_V3 [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
