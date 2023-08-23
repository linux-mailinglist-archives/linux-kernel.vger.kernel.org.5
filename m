Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CAB7859D3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbjHWNwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236233AbjHWNwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:52:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FA619A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692798737; x=1724334737;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hhDbaxo+r59y9cxE+Cm53wih1htNCd2YXPEr7MQRr5Y=;
  b=G9p3F9y7oz5iseyNti8MRpI6CzRpsvzy9E0mxVaCnC8LrMmZUm4Dfmwv
   JPx5idxFdR7+RVHcgvxJCA2R9jUIEmph9qtz1Tm0xVSPCpfdJRrhm92nv
   8J73xPfHivZORwSySbZHvM+Wgv5RnjHWDzGNSwbDFBJez2E5SO1esDwbb
   0aQkrnTAofAidq2hHz6P7clplYi6HZvLbegrCeI059+syz8NW0ioJIjr0
   R4sSCf1KaifPtBRl59NqDtSISo7niP1Xx/bBZmWd+zXz7SXv9sxZNke0V
   m7NU5Dr8ksMeaYFl1LNltX9Wa6Qn/Ivbt9NtGpVbsI/o3JzIsdbO1lvMF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="405166153"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="405166153"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 06:52:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="826734546"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="826734546"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Aug 2023 06:52:15 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYoHO-0001Fb-30;
        Wed, 23 Aug 2023 13:52:14 +0000
Date:   Wed, 23 Aug 2023 21:51:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/base/regmap/regmap-raw-ram.c:24:24: sparse: sparse: cast to
 restricted __be16
Message-ID: <202308232120.uQEXvamQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   89bf6209cad66214d3774dac86b6bbf2aec6a30d
commit: 65dd2f671875b1d97b6fa9bcf7677f5e1c55f776 regmap: Provide a ram backed regmap with raw support
date:   2 months ago
config: i386-randconfig-061-20230823 (https://download.01.org/0day-ci/archive/20230823/202308232120.uQEXvamQ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230823/202308232120.uQEXvamQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308232120.uQEXvamQ-lkp@intel.com/

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
