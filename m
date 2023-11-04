Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845BA7E0EC3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 11:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjKDKWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 06:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjKDKWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 06:22:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79267D44;
        Sat,  4 Nov 2023 03:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699093318; x=1730629318;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=emg2xa7Wz0DXz6//3gwEvIkyuahnQ3WpkSUAQpBFaek=;
  b=NksP0BoEKywQwrllKARUu08NIMZYCiZ2IKGOA6JMY+fMKKrSaSvI0/dD
   pto9mjLedrZZA1WxJGWvMJl/Y12hXzz+fQ8jQQpyL+6YXJtfwWINeE31v
   0eZxKcItv8gFMxyJKA1dcHgHkSvS7teDkwY8867YsCXeWfCubXRMeslcQ
   Tnm5FFqDwnpUX7UF1ZQeAQzDCBLaO3Voq7SGqzlgq+UtD5IpzxVSnWRCT
   Fxwm4FSiG4Y68g5m1VG+Lu9DmsTXp3TAj6h18BBiiiCpiqiyjh4yqbgb3
   mfAIB6p9prhXfZ5JkQx9+fglkcb/+lI5IC0lTLthokWMRX2xg2yyxSfe5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="386250286"
X-IronPort-AV: E=Sophos;i="6.03,276,1694761200"; 
   d="scan'208";a="386250286"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2023 03:21:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="711759849"
X-IronPort-AV: E=Sophos;i="6.03,276,1694761200"; 
   d="scan'208";a="711759849"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 04 Nov 2023 03:21:50 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzDml-0003lw-2R;
        Sat, 04 Nov 2023 10:21:47 +0000
Date:   Sat, 4 Nov 2023 18:21:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Henry Shi <henryshi2018@gmail.com>, hbshi69@hotmail.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        hdegoede@redhat.com, markgross@kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, hb_shi2003@yahoo.com,
        henrys@silicom-usa.com, wenw@silicom-usa.com
Subject: Re: [PATCH v10] platform/x86: Add Silicom Platform Driver
Message-ID: <202311041804.4fQDRw0E-lkp@intel.com>
References: <20231027203836.25936-1-henryshi2018@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027203836.25936-1-henryshi2018@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Henry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/master]
[also build test WARNING on linus/master tip/auto-latest v6.6 next-20231103]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Henry-Shi/platform-x86-Add-Silicom-Platform-Driver/20231028-043932
base:   tip/master
patch link:    https://lore.kernel.org/r/20231027203836.25936-1-henryshi2018%40gmail.com
patch subject: [PATCH v10] platform/x86: Add Silicom Platform Driver
reproduce: (https://download.01.org/0day-ci/archive/20231104/202311041804.4fQDRw0E-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311041804.4fQDRw0E-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: file ./Documentation/ABI/testing/sysfs-platform-silicom#18:
>> Warning: /sys/devices/platform/silicom-platform/hwmon/hwmon1/ is defined 4 times:  ./Documentation/ABI/testing/sysfs-platform-silicom:28  ./Documentation/ABI/testing/sysfs-platform-silicom:37  ./Documentation/ABI/testing/sysfs-platform-silicom:46  ./Documentation/ABI/testing/sysfs-platform-silicom:55

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
