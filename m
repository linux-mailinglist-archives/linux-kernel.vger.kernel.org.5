Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974C9767C55
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 07:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbjG2F3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 01:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjG2F3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 01:29:14 -0400
Received: from mgamail.intel.com (unknown [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EC149CA;
        Fri, 28 Jul 2023 22:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690608552; x=1722144552;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p5OlNuOBiNRpIEoTzzV9BfAcI6Rj48c+yaAUgRH2CiY=;
  b=jSmjbp4SdBu5aW+UFPchpawfqgjO9SqfYQlNdQbXrD1xYrlwNscA+b0K
   qSxYhI49UX5PNoL00POwRuGuM/KtkxfhYqsE+QfjxQbJGAe48B4r/HeJm
   IQyQBU8KJU8RNiTlVYHPKqtJ9s7wviKdAqAMeH48mz4r3hh8MAq02cAFk
   bZK/WmVaHBaSGLWW2FQjULs610or3Tyl/B/SGMjmQkxlQxo9cfuilmRI9
   5yKo1QaqjjxPBUv+LhcWdxLIGJ7rykcCVekvkC4W5u1RyLv8uox5F8ZWp
   TYmgaSHRJHWrq+EuAw9GB9jxMvnRkwH6JgEhCHhPGAFAWXy5XCzBKxD2u
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="348338525"
X-IronPort-AV: E=Sophos;i="6.01,239,1684825200"; 
   d="scan'208";a="348338525"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 22:29:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="793131840"
X-IronPort-AV: E=Sophos;i="6.01,239,1684825200"; 
   d="scan'208";a="793131840"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jul 2023 22:29:09 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPcVo-0003r5-1j;
        Sat, 29 Jul 2023 05:29:08 +0000
Date:   Sat, 29 Jul 2023 13:28:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nikita Travkin <nikita@trvn.ru>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
Subject: Re: [PATCH 4/4] power: supply: Add driver for pm8916 lbc
Message-ID: <202307291336.Zxmj8R1g-lkp@intel.com>
References: <20230728-pm8916-bms-lbc-v1-4-56da32467487@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728-pm8916-bms-lbc-v1-4-56da32467487@trvn.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

kernel test robot noticed the following build warnings:

[auto build test WARNING on d7b3af5a77e8d8da28f435f313e069aea5bcf172]

url:    https://github.com/intel-lab-lkp/linux/commits/Nikita-Travkin/dt-bindings-power-supply-Add-pm8916-VM-BMS/20230729-013044
base:   d7b3af5a77e8d8da28f435f313e069aea5bcf172
patch link:    https://lore.kernel.org/r/20230728-pm8916-bms-lbc-v1-4-56da32467487%40trvn.ru
patch subject: [PATCH 4/4] power: supply: Add driver for pm8916 lbc
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20230729/202307291336.Zxmj8R1g-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230729/202307291336.Zxmj8R1g-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307291336.Zxmj8R1g-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/power/supply/pm8916_lbc.c: In function 'pm8916_lbc_charger_get_property':
>> drivers/power/supply/pm8916_lbc.c:130:22: warning: unused variable 'tmp' [-Wunused-variable]
     130 |         unsigned int tmp;
         |                      ^~~
>> drivers/power/supply/pm8916_lbc.c:129:13: warning: unused variable 'ret' [-Wunused-variable]
     129 |         int ret = 0;
         |             ^~~


vim +/tmp +130 drivers/power/supply/pm8916_lbc.c

   123	
   124	static int pm8916_lbc_charger_get_property(struct power_supply *psy,
   125						   enum power_supply_property psp,
   126						   union power_supply_propval *val)
   127	{
   128		struct pm8916_lbc_charger *chg = power_supply_get_drvdata(psy);
 > 129		int ret = 0;
 > 130		unsigned int tmp;
   131	
   132		switch (psp) {
   133		case POWER_SUPPLY_PROP_ONLINE:
   134			val->intval = chg->online;
   135			return 0;
   136	
   137		case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
   138			val->intval = chg->charge_voltage_max;
   139			return 0;
   140	
   141		case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
   142			val->intval = chg->charge_current_max;
   143			return 0;
   144	
   145		default:
   146			return -EINVAL;
   147		};
   148	}
   149	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
