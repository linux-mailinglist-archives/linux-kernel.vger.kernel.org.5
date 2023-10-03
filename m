Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AB77B6B4E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239068AbjJCOW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239479AbjJCOWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:22:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA52AB;
        Tue,  3 Oct 2023 07:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696342943; x=1727878943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cjks6CkF+4bewzoomLbEOwdv2hYLwa0cZHBRPyA2qlk=;
  b=Cn6+tXrhcr4Rh01hVJM3p6mPXtIiFhDRNG1+0xoHVAqEURBIseoVbjVW
   E1Iljanns4mz/9S0D9NuZ48FeuVkNBb2ctZXqGRySw5Qpt+mjAc2p60wa
   U1xRv4m0f06uhjn2czfjl7EeQjdCfgU4STg5ty8AcbTuEIMegDRudpRSN
   Zs6TYUd8DJJqEerz6UN5gU33a4ttb3FzfIHLJhSW1VXzVxcujdNxB/yIV
   t5Yx53tBg5tfb1IRE2AtMjK5frcN08h6O/iSW4aC9h+qviWMDIiKoDcHT
   dIGXsmbl8MhTrspumbdA5Nf4wi1JECV+ka7V3B/OZNgEmavEkIz33fzTz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="382794208"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="382794208"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 07:22:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="816701888"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="816701888"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 03 Oct 2023 07:22:18 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qngHu-0007B6-1v;
        Tue, 03 Oct 2023 14:22:15 +0000
Date:   Tue, 3 Oct 2023 22:21:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     oe-kbuild-all@lists.linux.dev,
        David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 22/27] staging: iio: resolver: ad2s1210: convert LOS
 threshold to event attr
Message-ID: <202310032242.jYDq0057-lkp@intel.com>
References: <20230929-ad2s1210-mainline-v3-22-fa4364281745@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929-ad2s1210-mainline-v3-22-fa4364281745@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 5e99f692d4e32e3250ab18d511894ca797407aec]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/dt-bindings-iio-resolver-add-devicetree-bindings-for-ad2s1210/20230930-014031
base:   5e99f692d4e32e3250ab18d511894ca797407aec
patch link:    https://lore.kernel.org/r/20230929-ad2s1210-mainline-v3-22-fa4364281745%40baylibre.com
patch subject: [PATCH v3 22/27] staging: iio: resolver: ad2s1210: convert LOS threshold to event attr
config: i386-randconfig-062-20231003 (https://download.01.org/0day-ci/archive/20231003/202310032242.jYDq0057-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231003/202310032242.jYDq0057-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310032242.jYDq0057-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/staging/iio/resolver/ad2s1210.c:896:1: sparse: sparse: symbol 'iio_const_attr_in_phase0_mag_value_available' was not declared. Should it be static?
>> drivers/staging/iio/resolver/ad2s1210.c:901:1: sparse: sparse: symbol 'iio_const_attr_in_altvoltage0_thresh_falling_value_available' was not declared. Should it be static?
   drivers/staging/iio/resolver/ad2s1210.c:902:1: sparse: sparse: symbol 'iio_dev_attr_in_angl1_thresh_rising_value_available' was not declared. Should it be static?
   drivers/staging/iio/resolver/ad2s1210.c:903:1: sparse: sparse: symbol 'iio_dev_attr_in_angl1_thresh_rising_hysteresis_available' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
