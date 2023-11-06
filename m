Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01C57E1C35
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjKFI3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjKFI3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:29:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCAE184
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 00:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699259374; x=1730795374;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ATPx4wg4Mc/OgprcqkZHNz5UzvVPgD1AGF0I5shyCvc=;
  b=lpYqxMUdq8lCIP/1FoO1YXX6hVk19oN24wFHbrBh9LpbBeb/aMhHyPA8
   pSKgmgGeMnZS9ataL4zMD4DaowyWGZnyy7rM3v1t/FLqMzSE/3dsqgxVU
   36PYzl0G5/A/t2fTXE7ARPRkcfdoAQ4qXEKXTSa9JAvN1A+nNMU+wvk3f
   QMDXayw2eiJFTxIBzGBItxeYSAfEpfRwvvaBGbxY0Y5LRmnMnvN1QLd7r
   Dm/l0hZ4Zz4kijqW+ti6M9N0rqwhkawtWAiXRFCEQjKuREA6d80ffWgeB
   wJ/f7oJOn27z0y/L4PvzYQm/q4FAeOeG57LyNr6NY3ogs+4dk3lKihMqs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="379621117"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="379621117"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 00:29:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="935738238"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="935738238"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 06 Nov 2023 00:29:32 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzuzB-0006GY-2E;
        Mon, 06 Nov 2023 08:29:29 +0000
Date:   Mon, 6 Nov 2023 16:23:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shanker Donthineni <sdonthineni@nvidia.com>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, Vikram Sethi <vsethi@nvidia.com>
Subject: kismet: WARNING: unmet direct dependencies detected for
 HAVE_ARM_SMCCC_DISCOVERY when selected by ARM_GIC_V3
Message-ID: <202311061613.NN3iGNAf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d2f51b3516dade79269ff45eae2a7668ae711b25
commit: 35727af2b15d98a2dd2811d631d3a3886111312e irqchip/gicv3: Workaround for NVIDIA erratum T241-FABRIC-4
date:   7 months ago
config: arm-kismet-CONFIG_HAVE_ARM_SMCCC_DISCOVERY-CONFIG_ARM_GIC_V3-0-0 (https://download.01.org/0day-ci/archive/20231106/202311061613.NN3iGNAf-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20231106/202311061613.NN3iGNAf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311061613.NN3iGNAf-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for HAVE_ARM_SMCCC_DISCOVERY when selected by ARM_GIC_V3
   
   WARNING: unmet direct dependencies detected for HAVE_ARM_SMCCC_DISCOVERY
     Depends on [n]: ARM_PSCI_FW [=n]
     Selected by [y]:
     - ARM_GIC_V3 [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
