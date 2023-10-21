Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5797D2052
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 00:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjJUWlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 18:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJUWle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 18:41:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD2B11B
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 15:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697928088; x=1729464088;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QTNy210PlMgi9Xz7qHUpyj2N+7s0EoG6ehIJFJZwxkY=;
  b=ah6O6yKyKU413bIgLJ9IJyhOWkTxfxnxAMeFhbcPS/io18YhQIUa4Uve
   8B9o9XQJHOIuAUmZBZvuNX/jIHZg7NltXMbk/LaEWEAE+3pl8TDKgfMVb
   4lldcr2aC4G+dVllnGVNefgznW6SKtZ3/aUV1fLUJLo27QfC26N7e0HmP
   aVNXojN/UFgHsQP+gq7xf/MxiyXIi9GYxs+MwKHYcHnLEdK6xOr0LQFWJ
   HowUnlS7diPfCNJQIz6AVcBua6bGGTkPu9KG+q8/weJOkv7h7sC2xqwSg
   v8jRzzq4OZnb+wg7htjCsWvagU+/lgZSSwWVewaZdn5rkuoHtfaywu/Q+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="383867172"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="383867172"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2023 15:41:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="1004922657"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="1004922657"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 21 Oct 2023 15:41:26 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1quKeq-0005Il-2e;
        Sat, 21 Oct 2023 22:41:24 +0000
Date:   Sun, 22 Oct 2023 06:41:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gary Rookard <garyrookard@fastmail.org>, gregkh@linuxfoundation.org
Cc:     oe-kbuild-all@lists.linux.dev, philipp.g.hortmann@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: Re: [PATCH v2] staging: rtl8192e: renamed variable TxCountToDataRate
Message-ID: <202310220613.ecHUnU2j-lkp@intel.com>
References: <20231021213202.6244-1-garyrookard@fastmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231021213202.6244-1-garyrookard@fastmail.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gary,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Gary-Rookard/staging-rtl8192e-renamed-variable-TxCountToDataRate/20231022-053516
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20231021213202.6244-1-garyrookard%40fastmail.org
patch subject: [PATCH v2] staging: rtl8192e: renamed variable TxCountToDataRate
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20231022/202310220613.ecHUnU2j-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231022/202310220613.ecHUnU2j-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310220613.ecHUnU2j-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/staging/rtl8192e/rtllib_softmac_wx.c: In function 'rtllib_wx_get_rate':
>> drivers/staging/rtl8192e/rtllib_softmac_wx.c:211:20: error: implicit declaration of function 'tx_count_to_data_rate'; did you mean 'tx_count_data_rate'? [-Werror=implicit-function-declaration]
     211 |         tmp_rate = tx_count_to_data_rate(ieee,
         |                    ^~~~~~~~~~~~~~~~~~~~~
         |                    tx_count_data_rate
   cc1: some warnings being treated as errors
--
>> drivers/staging/rtl8192e/rtl819x_HTProc.c:117:6: warning: no previous prototype for 'tx_count_to_data_rate' [-Wmissing-prototypes]
     117 | u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate)
         |      ^~~~~~~~~~~~~~~~~~~~~


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
