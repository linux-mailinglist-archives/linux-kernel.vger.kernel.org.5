Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989547D2088
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 02:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjJVAQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 20:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVAQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 20:16:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3981BF4;
        Sat, 21 Oct 2023 17:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697933798; x=1729469798;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1PiMnn0i3KT3YYOJNg9IYf4n+r48HTbs7kDucILde3I=;
  b=boT5bfiFYK/vc+lYd3EFdQrp2D3lOA3l64gThX9cGSWJfbTSNNB7GwDV
   5N6xFoGpUyH+iXRzYaUGhnAikvZ7JvTG+M1rW/VORREEbXA5LfrPszlQu
   80HKU7FprD1M/vNr32drQDxVZO4lQ7figbeBfUuEdpl9LndlcznLpxswN
   Kwv9IHIDRpLzW4DfnrabdfWG8EtsXh5a4yWWIS9PuS2A8WbP2vKKe9KLf
   EQ0H75v1Wd3p4o+zswr8G21dN/x7+og4UujGLnc4rhj2dVQdukBh8+dOn
   Gj36U0e8jsywzN72Ultg57ZaR9VOEO6kp1poYgYEPkTyhBBwPmmRd31Pa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="385554727"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="385554727"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2023 17:16:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="761389573"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="761389573"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 21 Oct 2023 17:16:31 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1quM8s-0005Py-24;
        Sun, 22 Oct 2023 00:16:30 +0000
Date:   Sun, 22 Oct 2023 08:16:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, minyard@acm.org, joel@jms.id.au,
        andrew@aj.id.au, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, aladyshev22@gmail.com,
        jk@codeconstruct.com.au, matt@codeconstruct.com.au,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v5 1/3] ipmi: Move KCS headers to common include folder
Message-ID: <202310220806.BmOW2atE-lkp@intel.com>
References: <20231010122321.823-2-aladyshev22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010122321.823-2-aladyshev22@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konstantin,

kernel test robot noticed the following build errors:

[auto build test ERROR on cminyard-ipmi/for-next]
[also build test ERROR on linus/master v6.6-rc6 next-20231020]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Konstantin-Aladyshev/ipmi-Move-KCS-headers-to-common-include-folder/20231010-202425
base:   https://github.com/cminyard/linux-ipmi for-next
patch link:    https://lore.kernel.org/r/20231010122321.823-2-aladyshev22%40gmail.com
patch subject: [PATCH v5 1/3] ipmi: Move KCS headers to common include folder
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20231022/202310220806.BmOW2atE-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231022/202310220806.BmOW2atE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310220806.BmOW2atE-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/kcs_bmc_client.h:8,
                    from drivers/char/ipmi/kcs_bmc_cdev_ipmi.c:11:
>> include/linux/kcs_bmc.h:42:9: error: unknown type name 'spinlock_t'
      42 |         spinlock_t lock;
         |         ^~~~~~~~~~


vim +/spinlock_t +42 include/linux/kcs_bmc.h

faae6e391eda73 drivers/char/ipmi/kcs_bmc.h Andrew Jeffery 2021-06-08  31  
d4e7ac68f771ad drivers/char/ipmi/kcs_bmc.h Andrew Jeffery 2021-06-08  32  struct kcs_bmc_device {
d4e7ac68f771ad drivers/char/ipmi/kcs_bmc.h Andrew Jeffery 2021-06-08  33  	struct list_head entry;
20d60f61c58e8c drivers/char/ipmi/kcs_bmc.h Haiyue Wang    2018-02-02  34  
d4e7ac68f771ad drivers/char/ipmi/kcs_bmc.h Andrew Jeffery 2021-06-08  35  	struct device *dev;
20d60f61c58e8c drivers/char/ipmi/kcs_bmc.h Haiyue Wang    2018-02-02  36  	u32 channel;
20d60f61c58e8c drivers/char/ipmi/kcs_bmc.h Haiyue Wang    2018-02-02  37  
20d60f61c58e8c drivers/char/ipmi/kcs_bmc.h Haiyue Wang    2018-02-02  38  	struct kcs_ioreg ioreg;
20d60f61c58e8c drivers/char/ipmi/kcs_bmc.h Haiyue Wang    2018-02-02  39  
d4e7ac68f771ad drivers/char/ipmi/kcs_bmc.h Andrew Jeffery 2021-06-08  40  	const struct kcs_bmc_device_ops *ops;
20d60f61c58e8c drivers/char/ipmi/kcs_bmc.h Haiyue Wang    2018-02-02  41  
d4e7ac68f771ad drivers/char/ipmi/kcs_bmc.h Andrew Jeffery 2021-06-08 @42  	spinlock_t lock;
d4e7ac68f771ad drivers/char/ipmi/kcs_bmc.h Andrew Jeffery 2021-06-08  43  	struct kcs_bmc_client *client;
20d60f61c58e8c drivers/char/ipmi/kcs_bmc.h Haiyue Wang    2018-02-02  44  };
d4e7ac68f771ad drivers/char/ipmi/kcs_bmc.h Andrew Jeffery 2021-06-08  45  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
