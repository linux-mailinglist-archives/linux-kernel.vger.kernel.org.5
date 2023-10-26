Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F867D7BFD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 07:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbjJZFJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 01:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJZFJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 01:09:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE417C0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698296945; x=1729832945;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xB8r1iCDvaAf81vie1lsCwaJjJd1upJo9dCecMfNqvI=;
  b=Ov1kaq+wkKMPZNSRHMtTG1KlcRUG2QDeuc2sAbW5UiP/JU6oCzbRv7or
   8OcYvQ4+Q3MtC1DuDmHW42ub0KKzw9VeGcDSy5h1YZYDyKVYF3GmuSSOx
   Lk3DJZzbB+mAItVHzqoqtWaxHUXSqwZJUWbvBkHhegKJDHLhn5jQiE3W5
   Y6LnaA5q0F8ZL8Xd6Zqi65ElIKAcSTK+RR94i96J50brOkUAhefXjvMO0
   v6kWWwnhzJj/7C0XK8yR5vFZQ6vbGITRIQvBsyvD20n4JX+daiAoERfc6
   F0lD0srEg5XmY7+3QoLNMwmlRfu9mI+0T57lMQ6/IiAkM2qEIARBxIW6c
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="265624"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="265624"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 22:09:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="829487672"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="829487672"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 25 Oct 2023 22:09:01 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qvsc6-0009U5-0R;
        Thu, 26 Oct 2023 05:08:58 +0000
Date:   Thu, 26 Oct 2023 13:08:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gary Rookard <garyrookard@fastmail.org>, gregkh@linuxfoundation.org
Cc:     oe-kbuild-all@lists.linux.dev, philipp.g.hortmann@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: Re: [PATCH v3] staging: rtl8192e: renamed variable TxCountToDataRate
Message-ID: <202310261254.JYIf89K5-lkp@intel.com>
References: <20231021215440.6584-1-garyrookard@fastmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231021215440.6584-1-garyrookard@fastmail.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gary,

kernel test robot noticed the following build warnings:

[auto build test WARNING on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Gary-Rookard/staging-rtl8192e-renamed-variable-TxCountToDataRate/20231022-061649
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20231021215440.6584-1-garyrookard%40fastmail.org
patch subject: [PATCH v3] staging: rtl8192e: renamed variable TxCountToDataRate
config: i386-buildonly-randconfig-002-20231026 (https://download.01.org/0day-ci/archive/20231026/202310261254.JYIf89K5-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231026/202310261254.JYIf89K5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310261254.JYIf89K5-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/staging/rtl8192e/rtl819x_HTProc.c:117:6: warning: no previous declaration for 'tx_count_to_data_rate' [-Wmissing-declarations]
    u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate)
         ^~~~~~~~~~~~~~~~~~~~~


vim +/tx_count_to_data_rate +117 drivers/staging/rtl8192e/rtl819x_HTProc.c

   116	
 > 117	u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate)
   118	{
   119		u16	CCKOFDMRate[12] = {0x02, 0x04, 0x0b, 0x16, 0x0c, 0x12, 0x18,
   120					   0x24, 0x30, 0x48, 0x60, 0x6c};
   121		u8	is40MHz = 0;
   122		u8	isShortGI = 0;
   123	
   124		if (nDataRate < 12)
   125			return CCKOFDMRate[nDataRate];
   126		if (nDataRate >= 0x10 && nDataRate <= 0x1f) {
   127			is40MHz = 0;
   128			isShortGI = 0;
   129		} else if (nDataRate >= 0x20  && nDataRate <= 0x2f) {
   130			is40MHz = 1;
   131			isShortGI = 0;
   132		} else if (nDataRate >= 0x30  && nDataRate <= 0x3f) {
   133			is40MHz = 0;
   134			isShortGI = 1;
   135		} else if (nDataRate >= 0x40  && nDataRate <= 0x4f) {
   136			is40MHz = 1;
   137			isShortGI = 1;
   138		}
   139		return MCS_DATA_RATE[is40MHz][isShortGI][nDataRate & 0xf];
   140	}
   141	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
