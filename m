Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47AB7DC30E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 00:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjJ3XU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 19:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjJ3XUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 19:20:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABE8E4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 16:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698708052; x=1730244052;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LynUxohCCjaRiA0g/AavoK34cqlxiIsfBx03A+JRPgs=;
  b=dMJFXA37QCKCMKksXdfNH2wpkaFXb1LdRbM2BYAclUEgYZdiADCaOU9g
   eSnp/TEgr3nxVTQ+Jpm8YI9inHAiXuCVuBYEd5hNG+sXafyrBkb0rzvff
   GES5BG4Ohx9xzQqRfgv7Ii078dDFIw/JyYrZfRuXN3BFV5Z/zE8FTd5OC
   6xyL9hB9zi5jEpIxW4yrY2f4CiQEnVyRzxPpIuB+vQbrEj4FEqGVDhV01
   GqNKEFqeUtwdsQKnxBkqHmHLUTOh6pv5Xy3RxdnOIR3rVjF0nlCv72+7r
   XLBPit7qNy4aapL47W/Yf8PTh0xP+v5RoDhfJpUFYVgVniLm8U8A2mYlD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="387999073"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="387999073"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 16:20:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="736893754"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="736893754"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 30 Oct 2023 16:20:50 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qxbYt-000DeF-2S;
        Mon, 30 Oct 2023 23:20:47 +0000
Date:   Tue, 31 Oct 2023 07:20:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gary Rookard <garyrookard@fastmail.org>, gregkh@linuxfoundation.org
Cc:     oe-kbuild-all@lists.linux.dev, philipp.g.hortmann@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: Re: [PATCH v3] staging: rtl8192e: renamed variable TxCountToDataRate
Message-ID: <202310310745.6B9DzSi5-lkp@intel.com>
References: <20231021215440.6584-1-garyrookard@fastmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231021215440.6584-1-garyrookard@fastmail.org>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gary,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Gary-Rookard/staging-rtl8192e-renamed-variable-TxCountToDataRate/20231022-061649
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20231021215440.6584-1-garyrookard%40fastmail.org
patch subject: [PATCH v3] staging: rtl8192e: renamed variable TxCountToDataRate
config: openrisc-allyesconfig (https://download.01.org/0day-ci/archive/20231031/202310310745.6B9DzSi5-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231031/202310310745.6B9DzSi5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310310745.6B9DzSi5-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/staging/rtl8192e/rtllib_softmac_wx.c: In function 'rtllib_wx_get_rate':
>> drivers/staging/rtl8192e/rtllib_softmac_wx.c:211:20: error: implicit declaration of function 'tx_count_to_data_rate'; did you mean 'tx_count_data_rate'? [-Werror=implicit-function-declaration]
     211 |         tmp_rate = tx_count_to_data_rate(ieee,
         |                    ^~~~~~~~~~~~~~~~~~~~~
         |                    tx_count_data_rate
   cc1: some warnings being treated as errors


vim +211 drivers/staging/rtl8192e/rtllib_softmac_wx.c

   204	
   205	int rtllib_wx_get_rate(struct rtllib_device *ieee,
   206				     struct iw_request_info *info,
   207				     union iwreq_data *wrqu, char *extra)
   208	{
   209		u32 tmp_rate;
   210	
 > 211		tmp_rate = tx_count_to_data_rate(ieee,
   212					     ieee->softmac_stats.CurrentShowTxate);
   213		wrqu->bitrate.value = tmp_rate * 500000;
   214	
   215		return 0;
   216	}
   217	EXPORT_SYMBOL(rtllib_wx_get_rate);
   218	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
