Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9DD799F59
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 20:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjIJSjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 14:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjIJSjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 14:39:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED9818F
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 11:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694371157; x=1725907157;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sRPslDq8xAm7OtXPQftbOPWJWMMlpbPjvA2mX/1IcBk=;
  b=igyiLj+vENc1zy+h4mrl1ZE1xN2JELVZNOsDS6jz6QPdWtZZR2iDhMtx
   vbdStLSMHVq0WOig8hPooqCj0RZbvdcJWSNarQUZF+F8ZTgQvSG0u+Ta7
   8IHbgMwD20r8AuLCXcWc4UKyTLx/FHXq/lNS1ifXriJVx5jKURPmryec4
   0D4iCT8FRXcycVrIzpFnvubC4AuDj9V/lScRmcfxTnvd5xqMpdhGtqPnC
   LN3cYSsvwAdRSqK2ulPU9YbKN4sH5+oNYf01qQgjIOAlNeGiohCnlDRis
   01ID61OLGZjGxrhGjtoHyVT2CbbXOxbfMErxVRVWxG3Q+azRSJO2dvbtN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="380635537"
X-IronPort-AV: E=Sophos;i="6.02,242,1688454000"; 
   d="scan'208";a="380635537"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2023 11:39:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="1073872122"
X-IronPort-AV: E=Sophos;i="6.02,242,1688454000"; 
   d="scan'208";a="1073872122"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 10 Sep 2023 11:39:15 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qfPKz-0005Gq-1r;
        Sun, 10 Sep 2023 18:39:13 +0000
Date:   Mon, 11 Sep 2023 02:38:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/base/regmap/regmap-raw-ram.c:24:24: sparse: sparse: cast to
 restricted __be16
Message-ID: <202309110201.bRLC5gww-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   535a265d7f0dd50d8c3a4f8b4f3a452d56bd160f
commit: 65dd2f671875b1d97b6fa9bcf7677f5e1c55f776 regmap: Provide a ram backed regmap with raw support
date:   3 months ago
config: i386-randconfig-063-20230910 (https://download.01.org/0day-ci/archive/20230911/202309110201.bRLC5gww-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230911/202309110201.bRLC5gww-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309110201.bRLC5gww-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/base/regmap/regmap-raw-ram.c:24:24: sparse: sparse: cast to restricted __be16
>> drivers/base/regmap/regmap-raw-ram.c:26:24: sparse: sparse: cast to restricted __le16

vim +24 drivers/base/regmap/regmap-raw-ram.c

    18	
    19	static unsigned int decode_reg(enum regmap_endian endian, const void *reg)
    20	{
    21		const u16 *r = reg;
    22	
    23		if (endian == REGMAP_ENDIAN_BIG)
  > 24			return be16_to_cpu(*r);
    25		else
  > 26			return le16_to_cpu(*r);
    27	}
    28	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
