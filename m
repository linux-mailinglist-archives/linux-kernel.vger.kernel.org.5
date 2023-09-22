Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588ED7AB676
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 18:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjIVQuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 12:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjIVQuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 12:50:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90EDA3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 09:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695401396; x=1726937396;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wNC1cB/3vJ6kJjJHlSep3kPnIouUcZ1zH58ykMrKA48=;
  b=HV6lxhldMwF9KElBjtTvBzsdVkMIGAtoQE5Vn90PErYvsNsSiHeJp63K
   mERcZFMSK5a7oO1j5MjgOXaCDyOtyJ61pz6uQcP9HmVPLzSG6MB1tlxro
   2DEu0qdLvQT72/Nq4x5FQFT5c72xHpszvHQ7ZZp3gIfa4IoRPY0zBhpXU
   7eFHEu3uIunu562WTxAoyHcOWO+H3SHMXuz39ToF1SEQ6LPHU3n+y6Brd
   u8EcNgpjtao10MyQlgNvvSUaex+7b6uukx91u2bbYXTCp4qg0pp9rfm/U
   WwZdIQYZMfAV6iHBIA7fERPIgdwK8DjFfiN2qmx4+4uE9DwzOpEhYge9i
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="380783568"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="380783568"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 09:49:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="890879811"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="890879811"
Received: from lkp-server02.sh.intel.com (HELO 493f6c7fed5d) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 22 Sep 2023 09:49:00 -0700
Received: from kbuild by 493f6c7fed5d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qjjLk-000113-36;
        Fri, 22 Sep 2023 16:49:52 +0000
Date:   Sat, 23 Sep 2023 00:49:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/opp/core.c:2010: warning: Function parameter or member
 'opp_table' not described in '_opp_set_prop_name'
Message-ID: <202309230000.tczsdKvz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   27bbf45eae9ca98877a2d52a92a188147cd61b07
commit: 298098e55a6fcc176a5af52cd689f33577ead5ca OPP: Migrate set-prop-name helper API to use set-config helpers
date:   1 year, 2 months ago
config: csky-defconfig (https://download.01.org/0day-ci/archive/20230923/202309230000.tczsdKvz-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230923/202309230000.tczsdKvz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309230000.tczsdKvz-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/opp/core.c:1967: warning: Function parameter or member 'opp_table' not described in '_opp_set_supported_hw'
   drivers/opp/core.c:1967: warning: Excess function parameter 'dev' description in '_opp_set_supported_hw'
>> drivers/opp/core.c:2010: warning: Function parameter or member 'opp_table' not described in '_opp_set_prop_name'
>> drivers/opp/core.c:2010: warning: Excess function parameter 'dev' description in '_opp_set_prop_name'
   drivers/opp/core.c:2051: warning: Function parameter or member 'opp_table' not described in '_opp_set_regulators'
   drivers/opp/core.c:2051: warning: Excess function parameter 'count' description in '_opp_set_regulators'
   drivers/opp/core.c:2164: warning: Function parameter or member 'opp_table' not described in '_opp_set_clknames'
   drivers/opp/core.c:2228: warning: Function parameter or member 'opp_table' not described in '_opp_register_set_opp_helper'
   drivers/opp/core.c:2314: warning: Function parameter or member 'opp_table' not described in '_opp_attach_genpd'
   drivers/opp/core.c:2536: warning: Function parameter or member 'token' not described in 'dev_pm_opp_clear_config'
   drivers/opp/core.c:2536: warning: Excess function parameter 'opp_table' description in 'dev_pm_opp_clear_config'


vim +2010 drivers/opp/core.c

38393409da345c drivers/base/power/opp.c      Viresh Kumar 2014-11-25  1953  
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1954  /**
89f03984fa2abf drivers/opp/core.c            Viresh Kumar 2022-05-26  1955   * _opp_set_supported_hw() - Set supported platforms
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1956   * @dev: Device for which supported-hw has to be set.
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1957   * @versions: Array of hierarchy of versions to match.
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1958   * @count: Number of elements in the array.
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1959   *
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1960   * This is required only for the V2 bindings, and it enables a platform to
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1961   * specify the hierarchy of versions it supports. OPP layer will then enable
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1962   * OPPs, which are available for those versions, based on its 'opp-supported-hw'
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1963   * property.
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1964   */
89f03984fa2abf drivers/opp/core.c            Viresh Kumar 2022-05-26  1965  static int _opp_set_supported_hw(struct opp_table *opp_table,
fa30184d192ec7 drivers/base/power/opp/core.c Viresh Kumar 2017-01-23  1966  				 const u32 *versions, unsigned int count)
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09 @1967  {
25419de1b8dda2 drivers/opp/core.c            Viresh Kumar 2018-05-22  1968  	/* Another CPU that shares the OPP table has set the property ? */
25419de1b8dda2 drivers/opp/core.c            Viresh Kumar 2018-05-22  1969  	if (opp_table->supported_hw)
89f03984fa2abf drivers/opp/core.c            Viresh Kumar 2022-05-26  1970  		return 0;
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1971  
2c2709dc6921c5 drivers/base/power/opp/core.c Viresh Kumar 2016-02-16  1972  	opp_table->supported_hw = kmemdup(versions, count * sizeof(*versions),
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1973  					GFP_KERNEL);
89f03984fa2abf drivers/opp/core.c            Viresh Kumar 2022-05-26  1974  	if (!opp_table->supported_hw)
89f03984fa2abf drivers/opp/core.c            Viresh Kumar 2022-05-26  1975  		return -ENOMEM;
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1976  
2c2709dc6921c5 drivers/base/power/opp/core.c Viresh Kumar 2016-02-16  1977  	opp_table->supported_hw_count = count;
fa30184d192ec7 drivers/base/power/opp/core.c Viresh Kumar 2017-01-23  1978  
89f03984fa2abf drivers/opp/core.c            Viresh Kumar 2022-05-26  1979  	return 0;
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1980  }
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1981  
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1982  /**
89f03984fa2abf drivers/opp/core.c            Viresh Kumar 2022-05-26  1983   * _opp_put_supported_hw() - Releases resources blocked for supported hw
89f03984fa2abf drivers/opp/core.c            Viresh Kumar 2022-05-26  1984   * @opp_table: OPP table returned by _opp_set_supported_hw().
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1985   *
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1986   * This is required only for the V2 bindings, and is called for a matching
89f03984fa2abf drivers/opp/core.c            Viresh Kumar 2022-05-26  1987   * _opp_set_supported_hw(). Until this is called, the opp_table structure
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1988   * will not be freed.
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1989   */
89f03984fa2abf drivers/opp/core.c            Viresh Kumar 2022-05-26  1990  static void _opp_put_supported_hw(struct opp_table *opp_table)
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1991  {
89f03984fa2abf drivers/opp/core.c            Viresh Kumar 2022-05-26  1992  	if (opp_table->supported_hw) {
2c2709dc6921c5 drivers/base/power/opp/core.c Viresh Kumar 2016-02-16  1993  		kfree(opp_table->supported_hw);
2c2709dc6921c5 drivers/base/power/opp/core.c Viresh Kumar 2016-02-16  1994  		opp_table->supported_hw = NULL;
2c2709dc6921c5 drivers/base/power/opp/core.c Viresh Kumar 2016-02-16  1995  		opp_table->supported_hw_count = 0;
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1996  	}
9c4f220f3dc260 drivers/opp/core.c            Yangtao Li   2021-03-14  1997  }
9c4f220f3dc260 drivers/opp/core.c            Yangtao Li   2021-03-14  1998  
01fb4d3c39d35b drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1999  /**
298098e55a6fcc drivers/opp/core.c            Viresh Kumar 2022-05-26  2000   * _opp_set_prop_name() - Set prop-extn name
a5da64477ee79e drivers/base/power/opp/core.c Viresh Kumar 2016-02-16  2001   * @dev: Device for which the prop-name has to be set.
01fb4d3c39d35b drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  2002   * @name: name to postfix to properties.
01fb4d3c39d35b drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  2003   *
01fb4d3c39d35b drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  2004   * This is required only for the V2 bindings, and it enables a platform to
01fb4d3c39d35b drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  2005   * specify the extn to be used for certain property names. The properties to
01fb4d3c39d35b drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  2006   * which the extension will apply are opp-microvolt and opp-microamp. OPP core
01fb4d3c39d35b drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  2007   * should postfix the property name with -<name> while looking for them.
01fb4d3c39d35b drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  2008   */
298098e55a6fcc drivers/opp/core.c            Viresh Kumar 2022-05-26  2009  static int _opp_set_prop_name(struct opp_table *opp_table, const char *name)
01fb4d3c39d35b drivers/base/power/opp/core.c Viresh Kumar 2015-12-09 @2010  {
878ec1a9f0e5a6 drivers/opp/core.c            Viresh Kumar 2018-05-22  2011  	/* Another CPU that shares the OPP table has set the property ? */
2c2709dc6921c5 drivers/base/power/opp/core.c Viresh Kumar 2016-02-16  2012  	if (!opp_table->prop_name) {
298098e55a6fcc drivers/opp/core.c            Viresh Kumar 2022-05-26  2013  		opp_table->prop_name = kstrdup(name, GFP_KERNEL);
298098e55a6fcc drivers/opp/core.c            Viresh Kumar 2022-05-26  2014  		if (!opp_table->prop_name)
298098e55a6fcc drivers/opp/core.c            Viresh Kumar 2022-05-26  2015  			return -ENOMEM;
01fb4d3c39d35b drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  2016  	}
01fb4d3c39d35b drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  2017  
298098e55a6fcc drivers/opp/core.c            Viresh Kumar 2022-05-26  2018  	return 0;
01fb4d3c39d35b drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  2019  }
01fb4d3c39d35b drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  2020  

:::::: The code at line 2010 was first introduced by commit
:::::: 01fb4d3c39d35b725441e8a9a26b3f3ad67793ed PM / OPP: Parse 'opp-<prop>-<name>' bindings

:::::: TO: Viresh Kumar <viresh.kumar@linaro.org>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
