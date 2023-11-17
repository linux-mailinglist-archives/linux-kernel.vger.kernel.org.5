Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394A17EF462
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjKQOY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjKQOYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:24:55 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B719211D;
        Fri, 17 Nov 2023 06:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700231092; x=1731767092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KkQB0JC1sh9iALs/FsLxS+o9qCBJEgLAxvhigYsmDTs=;
  b=e16YPxUlr/CWppKe4X6YaPGH/YZo5/Zqi1x+j9GoRsG6kS/K4X4Zg23a
   dK1v3qWhmGDVIkNIAquQf/+sOfCDhk1QzpAYClyrF2N8m2kAuqjpDZ9+1
   3uMpp+hzn7xPKGOVTMER0kzyaypVjNMY8ffeizFx14ntrSlnbd+ep6IU/
   hiqNCp87/+N40rwzxcLak3euD96ELQBD2rlFCd6a75HQ0CYrnyZQp+yO+
   I34b6C962Qdv8qwVx56x/TNvk2meU7TSyiOpGlu1OojjTbCr9jfXjOUqK
   w7FlDSLdR8reWXnEbEv+U6FFWFR+1beT9PrY2esnK36008u8FclsRtq7A
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="390163905"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="390163905"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 06:24:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="889255853"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="889255853"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 17 Nov 2023 06:24:48 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3zlz-0002qh-1u;
        Fri, 17 Nov 2023 14:24:43 +0000
Date:   Fri, 17 Nov 2023 22:23:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anshul Dalal <anshulusr@gmail.com>, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Anshul Dalal <anshulusr@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Jonathan Cameron <jic23@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2 2/2] iio: light: driver for Lite-On ltr390
Message-ID: <202311172224.S2IXNUii-lkp@intel.com>
References: <20231117074554.700970-2-anshulusr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117074554.700970-2-anshulusr@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshul,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on robh/for-next linus/master v6.7-rc1 next-20231117]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anshul-Dalal/iio-light-driver-for-Lite-On-ltr390/20231117-154922
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20231117074554.700970-2-anshulusr%40gmail.com
patch subject: [PATCH v2 2/2] iio: light: driver for Lite-On ltr390
config: xtensa-randconfig-r081-20231117 (https://download.01.org/0day-ci/archive/20231117/202311172224.S2IXNUii-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231117/202311172224.S2IXNUii-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311172224.S2IXNUii-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/acpi.h:14,
                    from include/linux/i2c.h:13,
                    from drivers/iio/light/ltr390.c:23:
>> drivers/iio/light/ltr390.c:217:25: error: 'ltr390_id_table' undeclared here (not in a function); did you mean 'ltr390_of_table'?
     217 | MODULE_DEVICE_TABLE(of, ltr390_id_table);
         |                         ^~~~~~~~~~~~~~~
   include/linux/module.h:244:15: note: in definition of macro 'MODULE_DEVICE_TABLE'
     244 | extern typeof(name) __mod_##type##__##name##_device_table               \
         |               ^~~~
>> include/linux/module.h:244:21: error: '__mod_of__ltr390_id_table_device_table' aliased to undefined symbol 'ltr390_id_table'
     244 | extern typeof(name) __mod_##type##__##name##_device_table               \
         |                     ^~~~~~
   drivers/iio/light/ltr390.c:217:1: note: in expansion of macro 'MODULE_DEVICE_TABLE'
     217 | MODULE_DEVICE_TABLE(of, ltr390_id_table);
         | ^~~~~~~~~~~~~~~~~~~


vim +217 drivers/iio/light/ltr390.c

   212	
   213	static const struct of_device_id ltr390_of_table[] = {
   214		{ .compatible = "liteon,ltr390"},
   215		{ /* Sentinel */ }
   216	};
 > 217	MODULE_DEVICE_TABLE(of, ltr390_id_table);
   218	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
