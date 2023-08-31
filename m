Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDF878F604
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 01:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347786AbjHaXOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 19:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjHaXOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 19:14:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAE4CD6;
        Thu, 31 Aug 2023 16:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693523655; x=1725059655;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=unbP9RrrhlZwjUSeD1H+zVYGdrIWlAPK6CY8x3hEpGM=;
  b=gj0D75LldzkXl3vu1FaSHxDfPhak0ySB8emNakrZz0Q+s7RRPE7BFNGw
   mpqP/hnZI/WRXCMzdF4RmFZZLJtJgl3Mgo+57lTRmLvuKbmA0mO8ba/FO
   rd6JjXIfvf6gszIYDciIHnMUjigqI3fjifsRbxSECDHjixrnBjBb6r0q0
   RP7O1mxbjJzQHaMbMfljEnnTq0NQNNpXXBZGZTxYGalkr+vj/f4Cv8Su4
   fSBFz8aJKLlnWYN+mkXZTZMp49zx8f+pQm8jGC9KZNEKt+Q9lTMi15FaN
   qhOpG0Si9wrrNscBSzQvZWV+hEI8vgxAUp2F1wP6Pq+lmSc0wyQUEWPUx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="361112758"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="361112758"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 16:14:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="809837768"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="809837768"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 31 Aug 2023 16:14:12 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qbqrZ-0000db-2r;
        Thu, 31 Aug 2023 23:14:09 +0000
Date:   Fri, 1 Sep 2023 07:13:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Adam Ford <aford173@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: dts: imx8mp-beacon: Add DMIC support
Message-ID: <202309010735.D668npQl-lkp@intel.com>
References: <20230831115128.254226-4-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831115128.254226-4-aford173@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on arm/for-next arm64/for-next/core kvmarm/next rockchip/for-next shawnguo/for-next soc/for-next linus/master v6.5 next-20230831]
[cannot apply to arm/fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Adam-Ford/arm64-dts-imx8mm-beacon-Add-DMIC-support/20230831-195442
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230831115128.254226-4-aford173%40gmail.com
patch subject: [PATCH 4/4] arm64: dts: imx8mp-beacon: Add DMIC support
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20230901/202309010735.D668npQl-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230901/202309010735.D668npQl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309010735.D668npQl-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts:394.1-8 Label or path micfil not found
>> FATAL ERROR: Syntax error parsing input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
