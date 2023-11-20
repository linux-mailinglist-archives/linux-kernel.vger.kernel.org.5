Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F607F0AFB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 04:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjKTD32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 22:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjKTD31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 22:29:27 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7145DF2;
        Sun, 19 Nov 2023 19:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700450964; x=1731986964;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=79nx+jYDbS/YIn8ND8Ww6p1B32P9iaQpRFvr5tSfCWY=;
  b=RfxUWsGU83BkRYGr8AHGQyM6DAbglNW5bd1PoOd1KRQk2yaPaFHijite
   KppcPv6KQdJWSemACmMONFtZsP6QmoXYiCjtcwbBANJUw4dQiab5l3qtR
   cMrdOVVP8Qlo39Z2JDrV4FSpJb/J2YAuolXjfc3y6sX4qAHrF0Uk1GvHx
   fuMkL3zUbV5s1Fbesi7U7ReYObWACHAVPdz2C0y0kWXfE4KhfeyiSf0x0
   5To2BaijfDq73SCQv5HHpvMo4RJaPfhyiJxMsbzCuKT+V5tldF/rLYHUb
   FO98Dte39iCOjW7vQ853pyaoc4KxxxTD/TpZgiX7rfULwqLWdJ+xmuRj6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="370886751"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="370886751"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 19:29:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="7426029"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 19 Nov 2023 19:29:22 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4uyN-0005tj-2K;
        Mon, 20 Nov 2023 03:29:19 +0000
Date:   Mon, 20 Nov 2023 11:28:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-doc@vger.kernel.org
Subject: drivers/mmc/host/sdhci-omap.c:2: warning: This comment starts with
 '/**', but isn't a kernel-doc comment. Refer
 Documentation/doc-guide/kernel-doc.rst
Message-ID: <202311201117.lFxgJTK6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   98b1cc82c4affc16f5598d4fa14b1858671b2263
commit: 7d326930d3522a1183b8d54126c524fcbccd3343 mmc: sdhci-omap: Add OMAP SDHCI driver
date:   6 years ago
config: x86_64-buildonly-randconfig-001-20231012 (https://download.01.org/0day-ci/archive/20231120/202311201117.lFxgJTK6-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231120/202311201117.lFxgJTK6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311201117.lFxgJTK6-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/mmc/host/sdhci-omap.c:265:6: warning: no previous prototype for 'sdhci_omap_set_ios' [-Wmissing-prototypes]
     265 | void sdhci_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
         |      ^~~~~~~~~~~~~~~~~~
   drivers/mmc/host/sdhci-omap.c:326:6: warning: no previous prototype for 'sdhci_omap_set_power' [-Wmissing-prototypes]
     326 | void sdhci_omap_set_power(struct sdhci_host *host, unsigned char mode,
         |      ^~~~~~~~~~~~~~~~~~~~
   drivers/mmc/host/sdhci-omap.c:347:14: warning: no previous prototype for 'sdhci_omap_get_min_clock' [-Wmissing-prototypes]
     347 | unsigned int sdhci_omap_get_min_clock(struct sdhci_host *host)
         |              ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/mmc/host/sdhci-omap.c:2: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * SDHCI Controller driver for TI's OMAP SoCs


vim +2 drivers/mmc/host/sdhci-omap.c

   > 2	 * SDHCI Controller driver for TI's OMAP SoCs
     3	 *
     4	 * Copyright (C) 2017 Texas Instruments
     5	 * Author: Kishon Vijay Abraham I <kishon@ti.com>
     6	 *
     7	 * This program is free software: you can redistribute it and/or modify
     8	 * it under the terms of the GNU General Public License version 2 of
     9	 * the License as published by the Free Software Foundation.
    10	 *
    11	 * This program is distributed in the hope that it will be useful,
    12	 * but WITHOUT ANY WARRANTY; without even the implied warranty of
    13	 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    14	 * GNU General Public License for more details.
    15	 *
    16	 * You should have received a copy of the GNU General Public License
    17	 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
    18	 */
    19	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
