Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D02F7781AE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbjHJTh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbjHJTh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:37:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5A2213B;
        Thu, 10 Aug 2023 12:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691696245; x=1723232245;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xx83EKLu+vN9CXT+mV65pORzjTdIyb9PiTLDHfY8Y3Y=;
  b=fPNZTXEjZNZbw66LIy8UFogYcWw7wEU6TNArkvYvhMUxcKaWZ3OEIUHP
   PtWN3ABVXLUomUblgeRpi9ln4ps6TEJSIAkhuxdQBP6FCgxCal9foGoYT
   vgGWOZJkP6HBsTI+EWv0H7ANBWsUb8E/nxDXKpvJ//cHyEU//O2ikmuF0
   lKYP98rmEJvO5qsO4KA8RYTa5tKJdjHGkYrZRf+9HC4xa2xr0NUlABqyH
   ZdF+9P18OaOsi1X2fqC22dqejYqTGOdzECqsmu/Vd3Wz4bMMKzll8owG8
   yNgWN3Zh+RYJcAQ1w9ug79kU1pQNOF7S8RV7oT/1XAflzHgPpp+x1nQ0w
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="351825314"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="351825314"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 12:37:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="906175689"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="906175689"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 10 Aug 2023 12:37:18 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUBTB-0007DA-2s;
        Thu, 10 Aug 2023 19:37:17 +0000
Date:   Fri, 11 Aug 2023 03:36:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Okan Sahin <okan.sahin@analog.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Lee Jones <lee@kernel.org>, Haibo Chen <haibo.chen@nxp.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ad717x: add AD717X driver
Message-ID: <202308110347.LseABMWN-lkp@intel.com>
References: <20230810093322.593259-2-mitrutzceclan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810093322.593259-2-mitrutzceclan@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dumitru,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v6.5-rc5 next-20230809]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dumitru-Ceclan/iio-adc-ad717x-add-AD717X-driver/20230810-173526
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20230810093322.593259-2-mitrutzceclan%40gmail.com
patch subject: [PATCH 2/2] iio: adc: ad717x: add AD717X driver
config: xtensa-randconfig-m041-20230811 (https://download.01.org/0day-ci/archive/20230811/202308110347.LseABMWN-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230811/202308110347.LseABMWN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308110347.LseABMWN-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from drivers/iio/adc/ad717x.c:9:
>> include/linux/module.h:244:1: error: expected ',' or ';' before 'extern'
     244 | extern typeof(name) __mod_##type##__##name##_device_table               \
         | ^~~~~~
   drivers/iio/adc/ad717x.c:974:1: note: in expansion of macro 'MODULE_DEVICE_TABLE'
     974 | MODULE_DEVICE_TABLE(of, ad717x_of_match);
         | ^~~~~~~~~~~~~~~~~~~


vim +244 include/linux/module.h

^1da177e4c3f41 Linus Torvalds    2005-04-16  240  
cff26a51da5d20 Rusty Russell     2014-02-03  241  #ifdef MODULE
cff26a51da5d20 Rusty Russell     2014-02-03  242  /* Creates an alias so file2alias.c can find device table. */
^1da177e4c3f41 Linus Torvalds    2005-04-16  243  #define MODULE_DEVICE_TABLE(type, name)					\
0bf8bf50eddc75 Matthias Kaehlcke 2017-07-24 @244  extern typeof(name) __mod_##type##__##name##_device_table		\
cff26a51da5d20 Rusty Russell     2014-02-03  245    __attribute__ ((unused, alias(__stringify(name))))
cff26a51da5d20 Rusty Russell     2014-02-03  246  #else  /* !MODULE */
cff26a51da5d20 Rusty Russell     2014-02-03  247  #define MODULE_DEVICE_TABLE(type, name)
cff26a51da5d20 Rusty Russell     2014-02-03  248  #endif
^1da177e4c3f41 Linus Torvalds    2005-04-16  249  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
