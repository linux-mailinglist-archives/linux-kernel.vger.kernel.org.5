Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B6B7F35BC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbjKUSMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKUSMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:12:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2403097;
        Tue, 21 Nov 2023 10:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700590369; x=1732126369;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9PouWqQLxKRZD/js5Fh0MQNGfH4qTSbUBOOPCcqp9nc=;
  b=bo5jMta8Pr6m1sr1u/me0cydyNh8Fozx8DWh+2JFQyemjwikZ3cElbDx
   MAQIvrbPPCn+lAjaInE3YSaP1xGByrxyAr/xQdxiGZdvBS/GYADBhFm9/
   6IADqFh9Mm3wEBan0Yq/NWCLE8cz/2Hf+ZjaFr/1c3zeEUsGMD5Bbisze
   hBn3gtZQlpizKa8/xk+Z/QrcsNsE43pMJ/gUxdCX6GjkdATfa0A95HjHC
   a2rID9E/E0fsPFgKPkXJRFrScx4eHddwarqkyf/0wrKpbEdoumIiwvvcR
   vd1U8OQ03qIxK9DYKbDvpq/sLN/iq5z1N+GWh5CLBvyWMCUKTd/+VDvOw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="456235119"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="456235119"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 10:12:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="770344823"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="770344823"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 21 Nov 2023 10:12:19 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5VDl-00086q-0n;
        Tue, 21 Nov 2023 18:11:53 +0000
Date:   Wed, 22 Nov 2023 02:08:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hermes Zhang <Hermes.Zhang@axis.com>, sre@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@axis.com, Hermes Zhang <chenhuiz@axis.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/2] power: supply: bq24190_charger: Add support for
  BQ24296
Message-ID: <202311220126.8UPRiJN0-lkp@intel.com>
References: <20231121070505.3061304-3-Hermes.Zhang@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121070505.3061304-3-Hermes.Zhang@axis.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hermes,

kernel test robot noticed the following build errors:

[auto build test ERROR on sre-power-supply/for-next]
[also build test ERROR on linus/master v6.7-rc2 next-20231121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hermes-Zhang/dt-bindings-power-supply-bq24190-Add-BQ24296-compatible/20231121-151103
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20231121070505.3061304-3-Hermes.Zhang%40axis.com
patch subject: [PATCH v3 2/2] power: supply: bq24190_charger: Add support for  BQ24296
config: x86_64-buildonly-randconfig-004-20231121 (https://download.01.org/0day-ci/archive/20231122/202311220126.8UPRiJN0-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231122/202311220126.8UPRiJN0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311220126.8UPRiJN0-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/power/supply/bq24190_charger.c:1975:16: error: initializer element is not constant
      .vbus_desc = bq24190_vbus_desc,
                   ^~~~~~~~~~~~~~~~~
   drivers/power/supply/bq24190_charger.c:1975:16: note: (near initialization for 'bq24190_chip_info_tbl[0].vbus_desc')
   drivers/power/supply/bq24190_charger.c:1984:16: error: initializer element is not constant
      .vbus_desc = bq24190_vbus_desc,
                   ^~~~~~~~~~~~~~~~~
   drivers/power/supply/bq24190_charger.c:1984:16: note: (near initialization for 'bq24190_chip_info_tbl[1].vbus_desc')
   drivers/power/supply/bq24190_charger.c:1993:16: error: initializer element is not constant
      .vbus_desc = bq24190_vbus_desc,
                   ^~~~~~~~~~~~~~~~~
   drivers/power/supply/bq24190_charger.c:1993:16: note: (near initialization for 'bq24190_chip_info_tbl[2].vbus_desc')
   drivers/power/supply/bq24190_charger.c:2002:16: error: initializer element is not constant
      .vbus_desc = bq24190_vbus_desc,
                   ^~~~~~~~~~~~~~~~~
   drivers/power/supply/bq24190_charger.c:2002:16: note: (near initialization for 'bq24190_chip_info_tbl[3].vbus_desc')
   drivers/power/supply/bq24190_charger.c:2011:16: error: initializer element is not constant
      .vbus_desc = bq24296_vbus_desc,
                   ^~~~~~~~~~~~~~~~~
   drivers/power/supply/bq24190_charger.c:2011:16: note: (near initialization for 'bq24190_chip_info_tbl[4].vbus_desc')


vim +1975 drivers/power/supply/bq24190_charger.c

  1971	
  1972	static const struct bq24190_chip_info bq24190_chip_info_tbl[] = {
  1973		[BQ24190] = {
  1974			.ichg_array_size = ARRAY_SIZE(bq24190_ccc_ichg_values),
> 1975			.vbus_desc = bq24190_vbus_desc,
  1976			.check_chip = bq24190_check_chip,
  1977			.set_chg_config = bq24190_battery_set_chg_config,
  1978			.ntc_fault_mask = BQ24190_REG_F_NTC_FAULT_MASK,
  1979			.get_ntc_status = bq24190_charger_get_ntc_status,
  1980			.set_otg_vbus = bq24190_set_otg_vbus,
  1981		},
  1982		[BQ24192] = {
  1983			.ichg_array_size = ARRAY_SIZE(bq24190_ccc_ichg_values),
  1984			.vbus_desc = bq24190_vbus_desc,
  1985			.check_chip = bq24190_check_chip,
  1986			.set_chg_config = bq24190_battery_set_chg_config,
  1987			.ntc_fault_mask = BQ24190_REG_F_NTC_FAULT_MASK,
  1988			.get_ntc_status = bq24190_charger_get_ntc_status,
  1989			.set_otg_vbus = bq24190_set_otg_vbus,
  1990		},
  1991		[BQ24192i] = {
  1992			.ichg_array_size = ARRAY_SIZE(bq24190_ccc_ichg_values),
  1993			.vbus_desc = bq24190_vbus_desc,
  1994			.check_chip = bq24190_check_chip,
  1995			.set_chg_config = bq24190_battery_set_chg_config,
  1996			.ntc_fault_mask = BQ24190_REG_F_NTC_FAULT_MASK,
  1997			.get_ntc_status = bq24190_charger_get_ntc_status,
  1998			.set_otg_vbus = bq24190_set_otg_vbus,
  1999		},
  2000		[BQ24196] = {
  2001			.ichg_array_size = ARRAY_SIZE(bq24190_ccc_ichg_values),
  2002			.vbus_desc = bq24190_vbus_desc,
  2003			.check_chip = bq24190_check_chip,
  2004			.set_chg_config = bq24190_battery_set_chg_config,
  2005			.ntc_fault_mask = BQ24190_REG_F_NTC_FAULT_MASK,
  2006			.get_ntc_status = bq24190_charger_get_ntc_status,
  2007			.set_otg_vbus = bq24190_set_otg_vbus,
  2008		},
  2009		[BQ24296] = {
  2010			.ichg_array_size = BQ24296_CCC_ICHG_VALUES_LEN,
  2011			.vbus_desc = bq24296_vbus_desc,
  2012			.check_chip = bq24296_check_chip,
  2013			.set_chg_config = bq24296_battery_set_chg_config,
  2014			.ntc_fault_mask = BQ24296_REG_F_NTC_FAULT_MASK,
  2015			.get_ntc_status = bq24296_charger_get_ntc_status,
  2016			.set_otg_vbus = bq24296_set_otg_vbus,
  2017		},
  2018	};
  2019	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
