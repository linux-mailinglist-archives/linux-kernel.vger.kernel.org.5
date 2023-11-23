Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDFB7F56D8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 04:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344389AbjKWDMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 22:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjKWDMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 22:12:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FA319D;
        Wed, 22 Nov 2023 19:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700709133; x=1732245133;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mSKD3BunRLxqAt/sN5FuFA7OLE8wOF1ps3cvzngk/nc=;
  b=ToxWiljGHdBONZD/z6zLyFQXHweCtATIU81iXTdr3f5xRsWAI4aoByeL
   sXxW40NigVuuniuVNcYQA9ocR7UoP0PG+d35vEz5V8iVao/LkvIbihnpf
   Utc1Z2gk6dYeBDIzxNQEIfCPTxLjoNPfXdqrVQ82mHhKNzX+6no4/1cMV
   VHjSvO8O+9SfcZ7tzSOgAx62GOOJbPg6PsomOQT8tgbEpAumiCMH9j3O2
   bxEyAT+E9hxIaW+IEQLMjmYfHs2vilcrd5IAXPp5XiGgvhURdB9IarXW2
   wMB5zYZoOzA1Wgq+LDPGHNvhYtNjkxmSkIXK94FBET+AyUsys+s3KQpe3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="13744876"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="13744876"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 19:12:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="8712747"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 22 Nov 2023 19:12:10 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r608O-00019o-0t;
        Thu, 23 Nov 2023 03:12:08 +0000
Date:   Thu, 23 Nov 2023 11:11:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     SungHwan Jung <onenowy@gmail.com>, "Lee, Chun-Yi" <jlee@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     oe-kbuild-all@lists.linux.dev, SungHwan Jung <onenowy@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2 2/2] platform/x86: acer-wmi: add fan speed monitoring
 for Predator PHN16-71
Message-ID: <202311230750.psygl1ot-lkp@intel.com>
References: <20231122065534.3668-3-onenowy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122065534.3668-3-onenowy@gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi SungHwan,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.7-rc2 next-20231122]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/SungHwan-Jung/platform-x86-acer-wmi-Add-platform-profile-and-mode-key-support-for-Predator-PHN16-71/20231122-151512
base:   linus/master
patch link:    https://lore.kernel.org/r/20231122065534.3668-3-onenowy%40gmail.com
patch subject: [PATCH v2 2/2] platform/x86: acer-wmi: add fan speed monitoring for Predator PHN16-71
config: x86_64-buildonly-randconfig-004-20231123 (https://download.01.org/0day-ci/archive/20231123/202311230750.psygl1ot-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231123/202311230750.psygl1ot-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311230750.psygl1ot-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/platform/x86/acer-wmi.o: in function `acer_platform_probe':
>> acer-wmi.c:(.text+0x27f5): undefined reference to `devm_hwmon_device_register_with_info'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
