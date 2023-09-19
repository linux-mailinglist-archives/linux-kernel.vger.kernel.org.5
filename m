Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBBB7A62B0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjISMVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjISMVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:21:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AE4F2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695126075; x=1726662075;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jkJ9CGlFDqa68i7QfPQiQmGvrbGaAcZ7REHBG/MX8Tc=;
  b=LEOXwc7JrgWTMbx/HoMRH9yBEgdHI+1snhbOvgLwJu9nHFPzCXieCGsI
   TeaOD9/4mLopAWDK611zdtSnkve8fdSRTrR9TG8EIaLX3AemziiSjAW+O
   Fm+g+LDKuqdOqlpRjvUZfWshwlIzmm3gC7MKr/sYRxAI/6XRTRVsAjGQC
   /DHTTqkDGrwO++NTCVJP9zmvAHQSfTBlmkhbAoSDngpGn8I78VB7We/8q
   hk51/GZsxjQFIIm3ppCz5F4nH4P/iBK/dJNt4o2/+6oD/w8sTRi2lJuxk
   hhnWX0fX2CTqXxZrEwc8NJalxl5Q+xN5Pp1EqNtRmz4nXE7vXNTPg8FU9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="383750987"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="383750987"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 05:21:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="739681722"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="739681722"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 19 Sep 2023 05:21:13 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qiZj5-0007Lo-0R;
        Tue, 19 Sep 2023 12:21:11 +0000
Date:   Tue, 19 Sep 2023 20:21:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>
Subject: drivers/leds/trigger/ledtrig-netdev.c:120:34: warning: array
 subscript 17 is above array bounds of 'char[16]'
Message-ID: <202309192035.GTJEEbem-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2cf0f715623872823a72e451243bbf555d10d032
commit: 28a6a2ef18ad840a390d519840c303b03040961c leds: trigger: netdev: refactor code setting device name
date:   4 months ago
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20230919/202309192035.GTJEEbem-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230919/202309192035.GTJEEbem-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309192035.GTJEEbem-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/leds/trigger/ledtrig-netdev.c: In function 'set_device_name':
>> drivers/leds/trigger/ledtrig-netdev.c:120:34: warning: array subscript 17 is above array bounds of 'char[16]' [-Warray-bounds=]
     120 |         trigger_data->device_name[size] = 0;
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
   drivers/leds/trigger/ledtrig-netdev.c:48:14: note: while referencing 'device_name'
      48 |         char device_name[IFNAMSIZ];
         |              ^~~~~~~~~~~
>> drivers/leds/trigger/ledtrig-netdev.c:120:34: warning: array subscript 17 is above array bounds of 'char[16]' [-Warray-bounds=]
     120 |         trigger_data->device_name[size] = 0;
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
   drivers/leds/trigger/ledtrig-netdev.c:48:14: note: while referencing 'device_name'
      48 |         char device_name[IFNAMSIZ];
         |              ^~~~~~~~~~~


vim +120 drivers/leds/trigger/ledtrig-netdev.c

06f502f57d0d77 Ben Whitten       2017-12-10  106  
28a6a2ef18ad84 Andrew Lunn       2023-05-29  107  static int set_device_name(struct led_netdev_data *trigger_data,
28a6a2ef18ad84 Andrew Lunn       2023-05-29  108  			   const char *name, size_t size)
06f502f57d0d77 Ben Whitten       2017-12-10  109  {
06f502f57d0d77 Ben Whitten       2017-12-10  110  	cancel_delayed_work_sync(&trigger_data->work);
06f502f57d0d77 Ben Whitten       2017-12-10  111  
d1b9e1391ab2dc Christian Marangi 2023-04-19  112  	mutex_lock(&trigger_data->lock);
06f502f57d0d77 Ben Whitten       2017-12-10  113  
06f502f57d0d77 Ben Whitten       2017-12-10  114  	if (trigger_data->net_dev) {
06f502f57d0d77 Ben Whitten       2017-12-10  115  		dev_put(trigger_data->net_dev);
06f502f57d0d77 Ben Whitten       2017-12-10  116  		trigger_data->net_dev = NULL;
06f502f57d0d77 Ben Whitten       2017-12-10  117  	}
06f502f57d0d77 Ben Whitten       2017-12-10  118  
28a6a2ef18ad84 Andrew Lunn       2023-05-29  119  	memcpy(trigger_data->device_name, name, size);
909346433064b8 Rasmus Villemoes  2019-03-14 @120  	trigger_data->device_name[size] = 0;
06f502f57d0d77 Ben Whitten       2017-12-10  121  	if (size > 0 && trigger_data->device_name[size - 1] == '\n')
06f502f57d0d77 Ben Whitten       2017-12-10  122  		trigger_data->device_name[size - 1] = 0;
06f502f57d0d77 Ben Whitten       2017-12-10  123  
06f502f57d0d77 Ben Whitten       2017-12-10  124  	if (trigger_data->device_name[0] != 0)
06f502f57d0d77 Ben Whitten       2017-12-10  125  		trigger_data->net_dev =
06f502f57d0d77 Ben Whitten       2017-12-10  126  		    dev_get_by_name(&init_net, trigger_data->device_name);
06f502f57d0d77 Ben Whitten       2017-12-10  127  
e2f24cb1b5daf9 Christian Marangi 2023-04-19  128  	trigger_data->carrier_link_up = false;
06f502f57d0d77 Ben Whitten       2017-12-10  129  	if (trigger_data->net_dev != NULL)
e2f24cb1b5daf9 Christian Marangi 2023-04-19  130  		trigger_data->carrier_link_up = netif_carrier_ok(trigger_data->net_dev);
06f502f57d0d77 Ben Whitten       2017-12-10  131  
06f502f57d0d77 Ben Whitten       2017-12-10  132  	trigger_data->last_activity = 0;
06f502f57d0d77 Ben Whitten       2017-12-10  133  
06f502f57d0d77 Ben Whitten       2017-12-10  134  	set_baseline_state(trigger_data);
d1b9e1391ab2dc Christian Marangi 2023-04-19  135  	mutex_unlock(&trigger_data->lock);
06f502f57d0d77 Ben Whitten       2017-12-10  136  
28a6a2ef18ad84 Andrew Lunn       2023-05-29  137  	return 0;
28a6a2ef18ad84 Andrew Lunn       2023-05-29  138  }
28a6a2ef18ad84 Andrew Lunn       2023-05-29  139  

:::::: The code at line 120 was first introduced by commit
:::::: 909346433064b8d840dc82af26161926b8d37558 leds: trigger: netdev: use memcpy in device_name_store

:::::: TO: Rasmus Villemoes <linux@rasmusvillemoes.dk>
:::::: CC: Jacek Anaszewski <jacek.anaszewski@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
