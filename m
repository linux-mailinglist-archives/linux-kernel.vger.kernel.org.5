Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC05379A384
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 08:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbjIKGa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 02:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjIKGay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 02:30:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A314BEA
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 23:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694413846; x=1725949846;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mHGDktIdHZ2sp4tCCtKrCx+DSVNhi68TUsVKEiZ/UPw=;
  b=afuKqsUimIe3dwb/fpErP4ELYa3lEwhkNtiQV7JznPT1HiM6quXjhP2d
   RFH1ciHSLyG1WmzjBrIFjqDVcW4mq0YYY8CsYxIe5tWjluM1KHgcc2YTi
   msLr6XYPPnhyp+DMEgHbl7lpD4GST8nUCojGcQg7W6IxZa3U+ltFvVChC
   ZX3gzIvcrM0zKsuuO23bW+mwb8WDoVuY5GD95saWOHwhcz8bjeAYwi1nI
   WK/kpJAMKJIE62fjbtHa/Ag8AIGiR1TfyjoOpNS6EZRr/Ez9gam1/aBWm
   ewUg8QKs/zFtcmXK+iqkhcMwUe5es6LIP8wtX7ap+mVWH15XV80hgSMsh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="368245282"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="368245282"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2023 23:30:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="858198114"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="858198114"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 10 Sep 2023 23:30:37 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qfaRP-0005tb-1E;
        Mon, 11 Sep 2023 06:30:35 +0000
Date:   Mon, 11 Sep 2023 14:30:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Marco Elver <elver@google.com>
Subject: drivers/firmware/efi/test/efi_test.c:187:13: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202309111412.xYn3gZWr-lkp@intel.com>
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
head:   0bb80ecc33a8fb5a682236443c1e740d5c917d1d
commit: 75cf0290271bf6dae9dee982aef15242dadf97e4 instrumented.h: add KMSAN support
date:   11 months ago
config: i386-randconfig-061-20230911 (https://download.01.org/0day-ci/archive/20230911/202309111412.xYn3gZWr-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230911/202309111412.xYn3gZWr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309111412.xYn3gZWr-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/firmware/efi/test/efi_test.c:157:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *[addressable] data_size @@
   drivers/firmware/efi/test/efi_test.c:157:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:157:13: sparse:     got unsigned long *[addressable] data_size
   drivers/firmware/efi/test/efi_test.c:160:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct guid_t [usertype] *[addressable] vendor_guid @@
   drivers/firmware/efi/test/efi_test.c:160:61: sparse:     expected void const [noderef] __user *from
   drivers/firmware/efi/test/efi_test.c:160:61: sparse:     got struct guid_t [usertype] *[addressable] vendor_guid
   drivers/firmware/efi/test/efi_test.c:167:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected unsigned short [noderef] [usertype] __user *src @@     got unsigned short [usertype] *[addressable] variable_name @@
   drivers/firmware/efi/test/efi_test.c:167:60: sparse:     expected unsigned short [noderef] [usertype] __user *src
   drivers/firmware/efi/test/efi_test.c:167:60: sparse:     got unsigned short [usertype] *[addressable] variable_name
   drivers/firmware/efi/test/efi_test.c:187:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:187:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:187:13: sparse:     got unsigned long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:187:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:187:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/firmware/efi/test/efi_test.c:187:13: sparse:     got unsigned long [usertype] *__ptr
>> drivers/firmware/efi/test/efi_test.c:187:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:187:13: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:187:13: sparse:     got unsigned long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:194:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr @@
   drivers/firmware/efi/test/efi_test.c:194:35: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:194:35: sparse:     got unsigned long *__ptr
   drivers/firmware/efi/test/efi_test.c:194:35: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr @@
   drivers/firmware/efi/test/efi_test.c:194:35: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/firmware/efi/test/efi_test.c:194:35: sparse:     got unsigned long *__ptr
>> drivers/firmware/efi/test/efi_test.c:194:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned long *__ptr @@
   drivers/firmware/efi/test/efi_test.c:194:35: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:194:35: sparse:     got unsigned long *__ptr
   drivers/firmware/efi/test/efi_test.c:209:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got void *[addressable] data @@
   drivers/firmware/efi/test/efi_test.c:209:45: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:209:45: sparse:     got void *[addressable] data
   drivers/firmware/efi/test/efi_test.c:215:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:215:19: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:215:19: sparse:     got unsigned int [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:215:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:215:19: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/firmware/efi/test/efi_test.c:215:19: sparse:     got unsigned int [usertype] *__ptr
>> drivers/firmware/efi/test/efi_test.c:215:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned int [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:215:19: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:215:19: sparse:     got unsigned int [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:220:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr @@
   drivers/firmware/efi/test/efi_test.c:220:19: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:220:19: sparse:     got unsigned long *__ptr
   drivers/firmware/efi/test/efi_test.c:220:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr @@
   drivers/firmware/efi/test/efi_test.c:220:19: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/firmware/efi/test/efi_test.c:220:19: sparse:     got unsigned long *__ptr
   drivers/firmware/efi/test/efi_test.c:220:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned long *__ptr @@
   drivers/firmware/efi/test/efi_test.c:220:19: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:220:19: sparse:     got unsigned long *__ptr
   drivers/firmware/efi/test/efi_test.c:243:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct guid_t [usertype] *[addressable] vendor_guid @@
   drivers/firmware/efi/test/efi_test.c:243:53: sparse:     expected void const [noderef] __user *from
   drivers/firmware/efi/test/efi_test.c:243:53: sparse:     got struct guid_t [usertype] *[addressable] vendor_guid
   drivers/firmware/efi/test/efi_test.c:248:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected unsigned short [noderef] [usertype] __user *src @@     got unsigned short [usertype] *[addressable] variable_name @@
   drivers/firmware/efi/test/efi_test.c:248:60: sparse:     expected unsigned short [noderef] [usertype] __user *src
   drivers/firmware/efi/test/efi_test.c:248:60: sparse:     got unsigned short [usertype] *[addressable] variable_name
   drivers/firmware/efi/test/efi_test.c:253:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __user * @@     got void *[addressable] data @@
   drivers/firmware/efi/test/efi_test.c:253:39: sparse:     expected void const [noderef] __user *
   drivers/firmware/efi/test/efi_test.c:253:39: sparse:     got void *[addressable] data
   drivers/firmware/efi/test/efi_test.c:263:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:263:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:263:13: sparse:     got unsigned long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:263:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:263:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/firmware/efi/test/efi_test.c:263:13: sparse:     got unsigned long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:263:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:263:13: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:263:13: sparse:     got unsigned long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:292:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:292:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:292:13: sparse:     got unsigned long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:292:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:292:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/firmware/efi/test/efi_test.c:292:13: sparse:     got unsigned long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:292:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:292:13: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:292:13: sparse:     got unsigned long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:301:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct efi_time_cap_t [noderef] [usertype] __user *cap_local @@     got struct efi_time_cap_t [usertype] * @@
   drivers/firmware/efi/test/efi_test.c:301:27: sparse:     expected struct efi_time_cap_t [noderef] [usertype] __user *cap_local
   drivers/firmware/efi/test/efi_test.c:301:27: sparse:     got struct efi_time_cap_t [usertype] *
   drivers/firmware/efi/test/efi_test.c:308:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got struct efi_time_t [usertype] *[addressable] time @@
   drivers/firmware/efi/test/efi_test.c:308:41: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:308:41: sparse:     got struct efi_time_t [usertype] *[addressable] time
   drivers/firmware/efi/test/efi_test.c:325:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct efi_time_t [usertype] *[addressable] time @@
   drivers/firmware/efi/test/efi_test.c:325:46: sparse:     expected void const [noderef] __user *from
   drivers/firmware/efi/test/efi_test.c:325:46: sparse:     got struct efi_time_t [usertype] *[addressable] time
   drivers/firmware/efi/test/efi_test.c:330:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:330:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:330:13: sparse:     got unsigned long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:330:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:330:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/firmware/efi/test/efi_test.c:330:13: sparse:     got unsigned long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:330:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:330:13: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:330:13: sparse:     got unsigned long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:354:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:354:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:354:13: sparse:     got unsigned long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:354:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:354:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/firmware/efi/test/efi_test.c:354:13: sparse:     got unsigned long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:354:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:354:13: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:354:13: sparse:     got unsigned long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:360:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:360:38: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:360:38: sparse:     got unsigned char [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:360:38: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned char [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:360:38: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/firmware/efi/test/efi_test.c:360:38: sparse:     got unsigned char [usertype] *__ptr
>> drivers/firmware/efi/test/efi_test.c:360:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned char [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:360:38: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:360:38: sparse:     got unsigned char [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:365:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got struct efi_time_t [usertype] *[addressable] time @@
   drivers/firmware/efi/test/efi_test.c:365:47: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:365:47: sparse:     got struct efi_time_t [usertype] *[addressable] time
   drivers/firmware/efi/test/efi_test.c:389:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct efi_time_t [usertype] *[addressable] time @@
   drivers/firmware/efi/test/efi_test.c:389:60: sparse:     expected void const [noderef] __user *from
   drivers/firmware/efi/test/efi_test.c:389:60: sparse:     got struct efi_time_t [usertype] *[addressable] time
   drivers/firmware/efi/test/efi_test.c:397:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:397:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:397:13: sparse:     got unsigned long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:397:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:397:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/firmware/efi/test/efi_test.c:397:13: sparse:     got unsigned long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:397:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:397:13: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:397:13: sparse:     got unsigned long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:421:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *[addressable] variable_name_size @@
   drivers/firmware/efi/test/efi_test.c:421:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:421:21: sparse:     got unsigned long *[addressable] variable_name_size
   drivers/firmware/efi/test/efi_test.c:429:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct guid_t [usertype] *[addressable] vendor_guid @@
   drivers/firmware/efi/test/efi_test.c:429:52: sparse:     expected void const [noderef] __user *from
   drivers/firmware/efi/test/efi_test.c:429:52: sparse:     got struct guid_t [usertype] *[addressable] vendor_guid
   drivers/firmware/efi/test/efi_test.c:439:52: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short [noderef] [usertype] __user *src @@     got unsigned short [usertype] *[addressable] variable_name @@
   drivers/firmware/efi/test/efi_test.c:439:52: sparse:     expected unsigned short [noderef] [usertype] __user *src
   drivers/firmware/efi/test/efi_test.c:439:52: sparse:     got unsigned short [usertype] *[addressable] variable_name
   drivers/firmware/efi/test/efi_test.c:452:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected unsigned short [noderef] [usertype] __user *src @@     got unsigned short [usertype] *[addressable] variable_name @@
   drivers/firmware/efi/test/efi_test.c:452:52: sparse:     expected unsigned short [noderef] [usertype] __user *src
   drivers/firmware/efi/test/efi_test.c:452:52: sparse:     got unsigned short [usertype] *[addressable] variable_name
   drivers/firmware/efi/test/efi_test.c:461:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:461:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:461:13: sparse:     got unsigned long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:461:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:461:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/firmware/efi/test/efi_test.c:461:13: sparse:     got unsigned long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:461:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:461:13: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:461:13: sparse:     got unsigned long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:468:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr @@
   drivers/firmware/efi/test/efi_test.c:468:35: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:468:35: sparse:     got unsigned long *__ptr
   drivers/firmware/efi/test/efi_test.c:468:35: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr @@
   drivers/firmware/efi/test/efi_test.c:468:35: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/firmware/efi/test/efi_test.c:468:35: sparse:     got unsigned long *__ptr
   drivers/firmware/efi/test/efi_test.c:468:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned long *__ptr @@
   drivers/firmware/efi/test/efi_test.c:468:35: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:468:35: sparse:     got unsigned long *__ptr
   drivers/firmware/efi/test/efi_test.c:479:62: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short [noderef] [usertype] __user *dst @@     got unsigned short [usertype] *[addressable] variable_name @@
   drivers/firmware/efi/test/efi_test.c:479:62: sparse:     expected unsigned short [noderef] [usertype] __user *dst
   drivers/firmware/efi/test/efi_test.c:479:62: sparse:     got unsigned short [usertype] *[addressable] variable_name
   drivers/firmware/efi/test/efi_test.c:487:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr @@
   drivers/firmware/efi/test/efi_test.c:487:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:487:21: sparse:     got unsigned long *__ptr
   drivers/firmware/efi/test/efi_test.c:487:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr @@
   drivers/firmware/efi/test/efi_test.c:487:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/firmware/efi/test/efi_test.c:487:21: sparse:     got unsigned long *__ptr
   drivers/firmware/efi/test/efi_test.c:487:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned long *__ptr @@
   drivers/firmware/efi/test/efi_test.c:487:21: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:487:21: sparse:     got unsigned long *__ptr
   drivers/firmware/efi/test/efi_test.c:494:53: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got struct guid_t [usertype] *[addressable] vendor_guid @@
   drivers/firmware/efi/test/efi_test.c:494:53: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:494:53: sparse:     got struct guid_t [usertype] *[addressable] vendor_guid
   drivers/firmware/efi/test/efi_test.c:522:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:522:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:522:13: sparse:     got unsigned long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:522:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:522:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/firmware/efi/test/efi_test.c:522:13: sparse:     got unsigned long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:522:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:522:13: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:522:13: sparse:     got unsigned long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:529:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:529:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:529:13: sparse:     got unsigned int [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:529:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:529:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/firmware/efi/test/efi_test.c:529:13: sparse:     got unsigned int [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:529:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned int [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:529:13: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:529:13: sparse:     got unsigned int [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:546:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __user * @@     got void * @@
   drivers/firmware/efi/test/efi_test.c:546:37: sparse:     expected void const [noderef] __user *
   drivers/firmware/efi/test/efi_test.c:546:37: sparse:     got void *
   drivers/firmware/efi/test/efi_test.c:575:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:575:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:575:13: sparse:     got unsigned long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:575:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:575:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/firmware/efi/test/efi_test.c:575:13: sparse:     got unsigned long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:575:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:575:13: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:575:13: sparse:     got unsigned long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:581:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:581:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:581:13: sparse:     got unsigned long long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:581:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:581:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/firmware/efi/test/efi_test.c:581:13: sparse:     got unsigned long long [usertype] *__ptr
>> drivers/firmware/efi/test/efi_test.c:581:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned long long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:581:13: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:581:13: sparse:     got unsigned long long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:585:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:585:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:585:13: sparse:     got unsigned long long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:585:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:585:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/firmware/efi/test/efi_test.c:585:13: sparse:     got unsigned long long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:585:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned long long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:585:13: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:585:13: sparse:     got unsigned long long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:589:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:589:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:589:13: sparse:     got unsigned long long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:589:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:589:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/firmware/efi/test/efi_test.c:589:13: sparse:     got unsigned long long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:589:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned long long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:589:13: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:589:13: sparse:     got unsigned long long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:625:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got struct efi_capsule_header_t [usertype] ** @@
   drivers/firmware/efi/test/efi_test.c:625:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:625:21: sparse:     got struct efi_capsule_header_t [usertype] **
   drivers/firmware/efi/test/efi_test.c:629:50: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct efi_capsule_header_t [usertype] *[assigned] c @@
   drivers/firmware/efi/test/efi_test.c:629:50: sparse:     expected void const [noderef] __user *from
   drivers/firmware/efi/test/efi_test.c:629:50: sparse:     got struct efi_capsule_header_t [usertype] *[assigned] c
   drivers/firmware/efi/test/efi_test.c:643:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:643:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:643:13: sparse:     got unsigned long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:643:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:643:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/firmware/efi/test/efi_test.c:643:13: sparse:     got unsigned long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:643:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:643:13: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:643:13: sparse:     got unsigned long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:653:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:653:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:653:13: sparse:     got unsigned long long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:653:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:653:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/firmware/efi/test/efi_test.c:653:13: sparse:     got unsigned long long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:653:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned long long [usertype] *__ptr @@
   drivers/firmware/efi/test/efi_test.c:653:13: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:653:13: sparse:     got unsigned long long [usertype] *__ptr
   drivers/firmware/efi/test/efi_test.c:658:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr @@
   drivers/firmware/efi/test/efi_test.c:658:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:658:13: sparse:     got int *__ptr
   drivers/firmware/efi/test/efi_test.c:658:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr @@
   drivers/firmware/efi/test/efi_test.c:658:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/firmware/efi/test/efi_test.c:658:13: sparse:     got int *__ptr
>> drivers/firmware/efi/test/efi_test.c:658:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got int *__ptr @@
   drivers/firmware/efi/test/efi_test.c:658:13: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:658:13: sparse:     got int *__ptr
   drivers/firmware/efi/test/efi_test.c:671:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *supported_mask @@     got unsigned int * @@
   drivers/firmware/efi/test/efi_test.c:671:24: sparse:     expected unsigned int [noderef] __user *supported_mask
   drivers/firmware/efi/test/efi_test.c:671:24: sparse:     got unsigned int *
   drivers/firmware/efi/test/efi_test.c:35:27: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [usertype] *s @@     got unsigned short [noderef] [usertype] __user *str @@
   drivers/firmware/efi/test/efi_test.c:35:27: sparse:     expected unsigned short [usertype] *s
   drivers/firmware/efi/test/efi_test.c:35:27: sparse:     got unsigned short [noderef] [usertype] __user *str
   drivers/firmware/efi/test/efi_test.c:44:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short [usertype] * @@
   drivers/firmware/efi/test/efi_test.c:44:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:44:13: sparse:     got unsigned short [usertype] *
   drivers/firmware/efi/test/efi_test.c:50:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short [usertype] * @@
   drivers/firmware/efi/test/efi_test.c:50:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:50:21: sparse:     got unsigned short [usertype] *
   drivers/firmware/efi/test/efi_test.c:35:27: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [usertype] *[assigned] s @@     got unsigned short [noderef] [usertype] __user *str @@
   drivers/firmware/efi/test/efi_test.c:35:27: sparse:     expected unsigned short [usertype] *[assigned] s
   drivers/firmware/efi/test/efi_test.c:35:27: sparse:     got unsigned short [noderef] [usertype] __user *str
   drivers/firmware/efi/test/efi_test.c:44:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short [usertype] * @@
   drivers/firmware/efi/test/efi_test.c:44:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:44:13: sparse:     got unsigned short [usertype] *
   drivers/firmware/efi/test/efi_test.c:50:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short [usertype] * @@
   drivers/firmware/efi/test/efi_test.c:50:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:50:21: sparse:     got unsigned short [usertype] *
   drivers/firmware/efi/test/efi_test.c:35:27: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [usertype] *[assigned] s @@     got unsigned short [noderef] [usertype] __user *str @@
   drivers/firmware/efi/test/efi_test.c:35:27: sparse:     expected unsigned short [usertype] *[assigned] s
   drivers/firmware/efi/test/efi_test.c:35:27: sparse:     got unsigned short [noderef] [usertype] __user *str
   drivers/firmware/efi/test/efi_test.c:44:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short [usertype] * @@
   drivers/firmware/efi/test/efi_test.c:44:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:44:13: sparse:     got unsigned short [usertype] *
   drivers/firmware/efi/test/efi_test.c:50:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short [usertype] * @@
   drivers/firmware/efi/test/efi_test.c:50:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:50:21: sparse:     got unsigned short [usertype] *

vim +187 drivers/firmware/efi/test/efi_test.c

ff6301dabc3ca2 Ivan Hu 2016-08-25  138  
ff6301dabc3ca2 Ivan Hu 2016-08-25  139  static long efi_runtime_get_variable(unsigned long arg)
ff6301dabc3ca2 Ivan Hu 2016-08-25  140  {
ff6301dabc3ca2 Ivan Hu 2016-08-25  141  	struct efi_getvariable __user *getvariable_user;
ff6301dabc3ca2 Ivan Hu 2016-08-25  142  	struct efi_getvariable getvariable;
46b9b7135332d1 Ivan Hu 2016-10-18  143  	unsigned long datasize = 0, prev_datasize, *dz;
ff6301dabc3ca2 Ivan Hu 2016-08-25  144  	efi_guid_t vendor_guid, *vd = NULL;
ff6301dabc3ca2 Ivan Hu 2016-08-25  145  	efi_status_t status;
ff6301dabc3ca2 Ivan Hu 2016-08-25  146  	efi_char16_t *name = NULL;
ff6301dabc3ca2 Ivan Hu 2016-08-25  147  	u32 attr, *at;
ff6301dabc3ca2 Ivan Hu 2016-08-25  148  	void *data = NULL;
ff6301dabc3ca2 Ivan Hu 2016-08-25  149  	int rv = 0;
ff6301dabc3ca2 Ivan Hu 2016-08-25  150  
ff6301dabc3ca2 Ivan Hu 2016-08-25  151  	getvariable_user = (struct efi_getvariable __user *)arg;
ff6301dabc3ca2 Ivan Hu 2016-08-25  152  
ff6301dabc3ca2 Ivan Hu 2016-08-25  153  	if (copy_from_user(&getvariable, getvariable_user,
ff6301dabc3ca2 Ivan Hu 2016-08-25  154  			   sizeof(getvariable)))
ff6301dabc3ca2 Ivan Hu 2016-08-25  155  		return -EFAULT;
ff6301dabc3ca2 Ivan Hu 2016-08-25  156  	if (getvariable.data_size &&
ff6301dabc3ca2 Ivan Hu 2016-08-25  157  	    get_user(datasize, getvariable.data_size))
ff6301dabc3ca2 Ivan Hu 2016-08-25  158  		return -EFAULT;
ff6301dabc3ca2 Ivan Hu 2016-08-25  159  	if (getvariable.vendor_guid) {
ff6301dabc3ca2 Ivan Hu 2016-08-25  160  		if (copy_from_user(&vendor_guid, getvariable.vendor_guid,
ff6301dabc3ca2 Ivan Hu 2016-08-25  161  					sizeof(vendor_guid)))
ff6301dabc3ca2 Ivan Hu 2016-08-25  162  			return -EFAULT;
ff6301dabc3ca2 Ivan Hu 2016-08-25  163  		vd = &vendor_guid;
ff6301dabc3ca2 Ivan Hu 2016-08-25  164  	}
ff6301dabc3ca2 Ivan Hu 2016-08-25  165  
ff6301dabc3ca2 Ivan Hu 2016-08-25  166  	if (getvariable.variable_name) {
ff6301dabc3ca2 Ivan Hu 2016-08-25  167  		rv = copy_ucs2_from_user(&name, getvariable.variable_name);
ff6301dabc3ca2 Ivan Hu 2016-08-25  168  		if (rv)
ff6301dabc3ca2 Ivan Hu 2016-08-25  169  			return rv;
ff6301dabc3ca2 Ivan Hu 2016-08-25  170  	}
ff6301dabc3ca2 Ivan Hu 2016-08-25  171  
ff6301dabc3ca2 Ivan Hu 2016-08-25  172  	at = getvariable.attributes ? &attr : NULL;
ff6301dabc3ca2 Ivan Hu 2016-08-25  173  	dz = getvariable.data_size ? &datasize : NULL;
ff6301dabc3ca2 Ivan Hu 2016-08-25  174  
ff6301dabc3ca2 Ivan Hu 2016-08-25  175  	if (getvariable.data_size && getvariable.data) {
ff6301dabc3ca2 Ivan Hu 2016-08-25  176  		data = kmalloc(datasize, GFP_KERNEL);
ff6301dabc3ca2 Ivan Hu 2016-08-25  177  		if (!data) {
ff6301dabc3ca2 Ivan Hu 2016-08-25  178  			kfree(name);
ff6301dabc3ca2 Ivan Hu 2016-08-25  179  			return -ENOMEM;
ff6301dabc3ca2 Ivan Hu 2016-08-25  180  		}
ff6301dabc3ca2 Ivan Hu 2016-08-25  181  	}
ff6301dabc3ca2 Ivan Hu 2016-08-25  182  
ff6301dabc3ca2 Ivan Hu 2016-08-25  183  	prev_datasize = datasize;
ff6301dabc3ca2 Ivan Hu 2016-08-25  184  	status = efi.get_variable(name, vd, at, dz, data);
ff6301dabc3ca2 Ivan Hu 2016-08-25  185  	kfree(name);
ff6301dabc3ca2 Ivan Hu 2016-08-25  186  
ff6301dabc3ca2 Ivan Hu 2016-08-25 @187  	if (put_user(status, getvariable.status)) {
ff6301dabc3ca2 Ivan Hu 2016-08-25  188  		rv = -EFAULT;
ff6301dabc3ca2 Ivan Hu 2016-08-25  189  		goto out;
ff6301dabc3ca2 Ivan Hu 2016-08-25  190  	}
ff6301dabc3ca2 Ivan Hu 2016-08-25  191  
ff6301dabc3ca2 Ivan Hu 2016-08-25  192  	if (status != EFI_SUCCESS) {
ff6301dabc3ca2 Ivan Hu 2016-08-25  193  		if (status == EFI_BUFFER_TOO_SMALL) {
ff6301dabc3ca2 Ivan Hu 2016-08-25 @194  			if (dz && put_user(datasize, getvariable.data_size)) {
ff6301dabc3ca2 Ivan Hu 2016-08-25  195  				rv = -EFAULT;
ff6301dabc3ca2 Ivan Hu 2016-08-25  196  				goto out;
ff6301dabc3ca2 Ivan Hu 2016-08-25  197  			}
ff6301dabc3ca2 Ivan Hu 2016-08-25  198  		}
ff6301dabc3ca2 Ivan Hu 2016-08-25  199  		rv = -EINVAL;
ff6301dabc3ca2 Ivan Hu 2016-08-25  200  		goto out;
ff6301dabc3ca2 Ivan Hu 2016-08-25  201  	}
ff6301dabc3ca2 Ivan Hu 2016-08-25  202  
ff6301dabc3ca2 Ivan Hu 2016-08-25  203  	if (prev_datasize < datasize) {
ff6301dabc3ca2 Ivan Hu 2016-08-25  204  		rv = -EINVAL;
ff6301dabc3ca2 Ivan Hu 2016-08-25  205  		goto out;
ff6301dabc3ca2 Ivan Hu 2016-08-25  206  	}
ff6301dabc3ca2 Ivan Hu 2016-08-25  207  
ff6301dabc3ca2 Ivan Hu 2016-08-25  208  	if (data) {
ff6301dabc3ca2 Ivan Hu 2016-08-25  209  		if (copy_to_user(getvariable.data, data, datasize)) {
ff6301dabc3ca2 Ivan Hu 2016-08-25  210  			rv = -EFAULT;
ff6301dabc3ca2 Ivan Hu 2016-08-25  211  			goto out;
ff6301dabc3ca2 Ivan Hu 2016-08-25  212  		}
ff6301dabc3ca2 Ivan Hu 2016-08-25  213  	}
ff6301dabc3ca2 Ivan Hu 2016-08-25  214  
ff6301dabc3ca2 Ivan Hu 2016-08-25 @215  	if (at && put_user(attr, getvariable.attributes)) {
ff6301dabc3ca2 Ivan Hu 2016-08-25  216  		rv = -EFAULT;
ff6301dabc3ca2 Ivan Hu 2016-08-25  217  		goto out;
ff6301dabc3ca2 Ivan Hu 2016-08-25  218  	}
ff6301dabc3ca2 Ivan Hu 2016-08-25  219  
ff6301dabc3ca2 Ivan Hu 2016-08-25  220  	if (dz && put_user(datasize, getvariable.data_size))
ff6301dabc3ca2 Ivan Hu 2016-08-25  221  		rv = -EFAULT;
ff6301dabc3ca2 Ivan Hu 2016-08-25  222  
ff6301dabc3ca2 Ivan Hu 2016-08-25  223  out:
ff6301dabc3ca2 Ivan Hu 2016-08-25  224  	kfree(data);
ff6301dabc3ca2 Ivan Hu 2016-08-25  225  	return rv;
ff6301dabc3ca2 Ivan Hu 2016-08-25  226  
ff6301dabc3ca2 Ivan Hu 2016-08-25  227  }
ff6301dabc3ca2 Ivan Hu 2016-08-25  228  
ff6301dabc3ca2 Ivan Hu 2016-08-25  229  static long efi_runtime_set_variable(unsigned long arg)
ff6301dabc3ca2 Ivan Hu 2016-08-25  230  {
ff6301dabc3ca2 Ivan Hu 2016-08-25  231  	struct efi_setvariable __user *setvariable_user;
ff6301dabc3ca2 Ivan Hu 2016-08-25  232  	struct efi_setvariable setvariable;
ff6301dabc3ca2 Ivan Hu 2016-08-25  233  	efi_guid_t vendor_guid;
ff6301dabc3ca2 Ivan Hu 2016-08-25  234  	efi_status_t status;
ff6301dabc3ca2 Ivan Hu 2016-08-25  235  	efi_char16_t *name = NULL;
ff6301dabc3ca2 Ivan Hu 2016-08-25  236  	void *data;
ff6301dabc3ca2 Ivan Hu 2016-08-25  237  	int rv = 0;
ff6301dabc3ca2 Ivan Hu 2016-08-25  238  
ff6301dabc3ca2 Ivan Hu 2016-08-25  239  	setvariable_user = (struct efi_setvariable __user *)arg;
ff6301dabc3ca2 Ivan Hu 2016-08-25  240  
ff6301dabc3ca2 Ivan Hu 2016-08-25  241  	if (copy_from_user(&setvariable, setvariable_user, sizeof(setvariable)))
ff6301dabc3ca2 Ivan Hu 2016-08-25  242  		return -EFAULT;
ff6301dabc3ca2 Ivan Hu 2016-08-25  243  	if (copy_from_user(&vendor_guid, setvariable.vendor_guid,
ff6301dabc3ca2 Ivan Hu 2016-08-25  244  				sizeof(vendor_guid)))
ff6301dabc3ca2 Ivan Hu 2016-08-25  245  		return -EFAULT;
ff6301dabc3ca2 Ivan Hu 2016-08-25  246  
ff6301dabc3ca2 Ivan Hu 2016-08-25  247  	if (setvariable.variable_name) {
ff6301dabc3ca2 Ivan Hu 2016-08-25  248  		rv = copy_ucs2_from_user(&name, setvariable.variable_name);
ff6301dabc3ca2 Ivan Hu 2016-08-25  249  		if (rv)
ff6301dabc3ca2 Ivan Hu 2016-08-25  250  			return rv;
ff6301dabc3ca2 Ivan Hu 2016-08-25  251  	}
ff6301dabc3ca2 Ivan Hu 2016-08-25  252  
c208ed916e5870 Ivan Hu 2016-10-18  253  	data = memdup_user(setvariable.data, setvariable.data_size);
c208ed916e5870 Ivan Hu 2016-10-18  254  	if (IS_ERR(data)) {
ff6301dabc3ca2 Ivan Hu 2016-08-25  255  		kfree(name);
c208ed916e5870 Ivan Hu 2016-10-18  256  		return PTR_ERR(data);
ff6301dabc3ca2 Ivan Hu 2016-08-25  257  	}
ff6301dabc3ca2 Ivan Hu 2016-08-25  258  
ff6301dabc3ca2 Ivan Hu 2016-08-25  259  	status = efi.set_variable(name, &vendor_guid,
ff6301dabc3ca2 Ivan Hu 2016-08-25  260  				setvariable.attributes,
ff6301dabc3ca2 Ivan Hu 2016-08-25  261  				setvariable.data_size, data);
ff6301dabc3ca2 Ivan Hu 2016-08-25  262  
ff6301dabc3ca2 Ivan Hu 2016-08-25  263  	if (put_user(status, setvariable.status)) {
ff6301dabc3ca2 Ivan Hu 2016-08-25  264  		rv = -EFAULT;
ff6301dabc3ca2 Ivan Hu 2016-08-25  265  		goto out;
ff6301dabc3ca2 Ivan Hu 2016-08-25  266  	}
ff6301dabc3ca2 Ivan Hu 2016-08-25  267  
ff6301dabc3ca2 Ivan Hu 2016-08-25  268  	rv = status == EFI_SUCCESS ? 0 : -EINVAL;
ff6301dabc3ca2 Ivan Hu 2016-08-25  269  
ff6301dabc3ca2 Ivan Hu 2016-08-25  270  out:
ff6301dabc3ca2 Ivan Hu 2016-08-25  271  	kfree(data);
ff6301dabc3ca2 Ivan Hu 2016-08-25  272  	kfree(name);
ff6301dabc3ca2 Ivan Hu 2016-08-25  273  
ff6301dabc3ca2 Ivan Hu 2016-08-25  274  	return rv;
ff6301dabc3ca2 Ivan Hu 2016-08-25  275  }
ff6301dabc3ca2 Ivan Hu 2016-08-25  276  
ff6301dabc3ca2 Ivan Hu 2016-08-25  277  static long efi_runtime_get_time(unsigned long arg)
ff6301dabc3ca2 Ivan Hu 2016-08-25  278  {
ff6301dabc3ca2 Ivan Hu 2016-08-25  279  	struct efi_gettime __user *gettime_user;
ff6301dabc3ca2 Ivan Hu 2016-08-25  280  	struct efi_gettime  gettime;
ff6301dabc3ca2 Ivan Hu 2016-08-25  281  	efi_status_t status;
ff6301dabc3ca2 Ivan Hu 2016-08-25  282  	efi_time_cap_t cap;
ff6301dabc3ca2 Ivan Hu 2016-08-25  283  	efi_time_t efi_time;
ff6301dabc3ca2 Ivan Hu 2016-08-25  284  
ff6301dabc3ca2 Ivan Hu 2016-08-25  285  	gettime_user = (struct efi_gettime __user *)arg;
ff6301dabc3ca2 Ivan Hu 2016-08-25  286  	if (copy_from_user(&gettime, gettime_user, sizeof(gettime)))
ff6301dabc3ca2 Ivan Hu 2016-08-25  287  		return -EFAULT;
ff6301dabc3ca2 Ivan Hu 2016-08-25  288  
ff6301dabc3ca2 Ivan Hu 2016-08-25  289  	status = efi.get_time(gettime.time ? &efi_time : NULL,
ff6301dabc3ca2 Ivan Hu 2016-08-25  290  			      gettime.capabilities ? &cap : NULL);
ff6301dabc3ca2 Ivan Hu 2016-08-25  291  
ff6301dabc3ca2 Ivan Hu 2016-08-25  292  	if (put_user(status, gettime.status))
ff6301dabc3ca2 Ivan Hu 2016-08-25  293  		return -EFAULT;
ff6301dabc3ca2 Ivan Hu 2016-08-25  294  
ff6301dabc3ca2 Ivan Hu 2016-08-25  295  	if (status != EFI_SUCCESS)
ff6301dabc3ca2 Ivan Hu 2016-08-25  296  		return -EINVAL;
ff6301dabc3ca2 Ivan Hu 2016-08-25  297  
ff6301dabc3ca2 Ivan Hu 2016-08-25  298  	if (gettime.capabilities) {
ff6301dabc3ca2 Ivan Hu 2016-08-25  299  		efi_time_cap_t __user *cap_local;
ff6301dabc3ca2 Ivan Hu 2016-08-25  300  
ff6301dabc3ca2 Ivan Hu 2016-08-25  301  		cap_local = (efi_time_cap_t *)gettime.capabilities;
ff6301dabc3ca2 Ivan Hu 2016-08-25  302  		if (put_user(cap.resolution, &(cap_local->resolution)) ||
ff6301dabc3ca2 Ivan Hu 2016-08-25  303  			put_user(cap.accuracy, &(cap_local->accuracy)) ||
ff6301dabc3ca2 Ivan Hu 2016-08-25  304  			put_user(cap.sets_to_zero, &(cap_local->sets_to_zero)))
ff6301dabc3ca2 Ivan Hu 2016-08-25  305  			return -EFAULT;
ff6301dabc3ca2 Ivan Hu 2016-08-25  306  	}
ff6301dabc3ca2 Ivan Hu 2016-08-25  307  	if (gettime.time) {
ff6301dabc3ca2 Ivan Hu 2016-08-25  308  		if (copy_to_user(gettime.time, &efi_time, sizeof(efi_time_t)))
ff6301dabc3ca2 Ivan Hu 2016-08-25  309  			return -EFAULT;
ff6301dabc3ca2 Ivan Hu 2016-08-25  310  	}
ff6301dabc3ca2 Ivan Hu 2016-08-25  311  
ff6301dabc3ca2 Ivan Hu 2016-08-25  312  	return 0;
ff6301dabc3ca2 Ivan Hu 2016-08-25  313  }
ff6301dabc3ca2 Ivan Hu 2016-08-25  314  
ff6301dabc3ca2 Ivan Hu 2016-08-25  315  static long efi_runtime_set_time(unsigned long arg)
ff6301dabc3ca2 Ivan Hu 2016-08-25  316  {
ff6301dabc3ca2 Ivan Hu 2016-08-25  317  	struct efi_settime __user *settime_user;
ff6301dabc3ca2 Ivan Hu 2016-08-25  318  	struct efi_settime settime;
ff6301dabc3ca2 Ivan Hu 2016-08-25  319  	efi_status_t status;
ff6301dabc3ca2 Ivan Hu 2016-08-25  320  	efi_time_t efi_time;
ff6301dabc3ca2 Ivan Hu 2016-08-25  321  
ff6301dabc3ca2 Ivan Hu 2016-08-25  322  	settime_user = (struct efi_settime __user *)arg;
ff6301dabc3ca2 Ivan Hu 2016-08-25  323  	if (copy_from_user(&settime, settime_user, sizeof(settime)))
ff6301dabc3ca2 Ivan Hu 2016-08-25  324  		return -EFAULT;
ff6301dabc3ca2 Ivan Hu 2016-08-25  325  	if (copy_from_user(&efi_time, settime.time,
ff6301dabc3ca2 Ivan Hu 2016-08-25  326  					sizeof(efi_time_t)))
ff6301dabc3ca2 Ivan Hu 2016-08-25  327  		return -EFAULT;
ff6301dabc3ca2 Ivan Hu 2016-08-25  328  	status = efi.set_time(&efi_time);
ff6301dabc3ca2 Ivan Hu 2016-08-25  329  
ff6301dabc3ca2 Ivan Hu 2016-08-25  330  	if (put_user(status, settime.status))
ff6301dabc3ca2 Ivan Hu 2016-08-25  331  		return -EFAULT;
ff6301dabc3ca2 Ivan Hu 2016-08-25  332  
ff6301dabc3ca2 Ivan Hu 2016-08-25  333  	return status == EFI_SUCCESS ? 0 : -EINVAL;
ff6301dabc3ca2 Ivan Hu 2016-08-25  334  }
ff6301dabc3ca2 Ivan Hu 2016-08-25  335  
ff6301dabc3ca2 Ivan Hu 2016-08-25  336  static long efi_runtime_get_waketime(unsigned long arg)
ff6301dabc3ca2 Ivan Hu 2016-08-25  337  {
ff6301dabc3ca2 Ivan Hu 2016-08-25  338  	struct efi_getwakeuptime __user *getwakeuptime_user;
ff6301dabc3ca2 Ivan Hu 2016-08-25  339  	struct efi_getwakeuptime getwakeuptime;
ff6301dabc3ca2 Ivan Hu 2016-08-25  340  	efi_bool_t enabled, pending;
ff6301dabc3ca2 Ivan Hu 2016-08-25  341  	efi_status_t status;
ff6301dabc3ca2 Ivan Hu 2016-08-25  342  	efi_time_t efi_time;
ff6301dabc3ca2 Ivan Hu 2016-08-25  343  
ff6301dabc3ca2 Ivan Hu 2016-08-25  344  	getwakeuptime_user = (struct efi_getwakeuptime __user *)arg;
ff6301dabc3ca2 Ivan Hu 2016-08-25  345  	if (copy_from_user(&getwakeuptime, getwakeuptime_user,
ff6301dabc3ca2 Ivan Hu 2016-08-25  346  				sizeof(getwakeuptime)))
ff6301dabc3ca2 Ivan Hu 2016-08-25  347  		return -EFAULT;
ff6301dabc3ca2 Ivan Hu 2016-08-25  348  
ff6301dabc3ca2 Ivan Hu 2016-08-25  349  	status = efi.get_wakeup_time(
ff6301dabc3ca2 Ivan Hu 2016-08-25  350  		getwakeuptime.enabled ? (efi_bool_t *)&enabled : NULL,
ff6301dabc3ca2 Ivan Hu 2016-08-25  351  		getwakeuptime.pending ? (efi_bool_t *)&pending : NULL,
ff6301dabc3ca2 Ivan Hu 2016-08-25  352  		getwakeuptime.time ? &efi_time : NULL);
ff6301dabc3ca2 Ivan Hu 2016-08-25  353  
ff6301dabc3ca2 Ivan Hu 2016-08-25  354  	if (put_user(status, getwakeuptime.status))
ff6301dabc3ca2 Ivan Hu 2016-08-25  355  		return -EFAULT;
ff6301dabc3ca2 Ivan Hu 2016-08-25  356  
ff6301dabc3ca2 Ivan Hu 2016-08-25  357  	if (status != EFI_SUCCESS)
ff6301dabc3ca2 Ivan Hu 2016-08-25  358  		return -EINVAL;
ff6301dabc3ca2 Ivan Hu 2016-08-25  359  
ff6301dabc3ca2 Ivan Hu 2016-08-25 @360  	if (getwakeuptime.enabled && put_user(enabled,
ff6301dabc3ca2 Ivan Hu 2016-08-25  361  						getwakeuptime.enabled))
ff6301dabc3ca2 Ivan Hu 2016-08-25  362  		return -EFAULT;
ff6301dabc3ca2 Ivan Hu 2016-08-25  363  
ff6301dabc3ca2 Ivan Hu 2016-08-25  364  	if (getwakeuptime.time) {
ff6301dabc3ca2 Ivan Hu 2016-08-25  365  		if (copy_to_user(getwakeuptime.time, &efi_time,
ff6301dabc3ca2 Ivan Hu 2016-08-25  366  				sizeof(efi_time_t)))
ff6301dabc3ca2 Ivan Hu 2016-08-25  367  			return -EFAULT;
ff6301dabc3ca2 Ivan Hu 2016-08-25  368  	}
ff6301dabc3ca2 Ivan Hu 2016-08-25  369  
ff6301dabc3ca2 Ivan Hu 2016-08-25  370  	return 0;
ff6301dabc3ca2 Ivan Hu 2016-08-25  371  }
ff6301dabc3ca2 Ivan Hu 2016-08-25  372  

:::::: The code at line 187 was first introduced by commit
:::::: ff6301dabc3ca20ab8f50f8d0252ac05da610d89 efi: Add efi_test driver for exporting UEFI runtime service interfaces

:::::: TO: Ivan Hu <ivan.hu@canonical.com>
:::::: CC: Matt Fleming <matt@codeblueprint.co.uk>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
