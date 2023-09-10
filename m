Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D007D799CCA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 08:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344691AbjIJGJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 02:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjIJGJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 02:09:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642171B5
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 23:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694326174; x=1725862174;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=srBVjL1ys+MFs56VMXsXYEQpruTuyJ5tQYX53T0UB24=;
  b=WMa395fPm8DJSoPMZwS5bVzdEM8fEM/ebRiuV2RQHODEAkTI+uqIFmYR
   y414FGB39JWd6vLf1De5hn8z2tyVodsEYKSLkqFoDkKkR8fwQ2lUg4sBw
   7g5jV8Gl2kEbJUyZpJanpu3pKZPKcOtfH0PYAC3pCeWigR14rt8gUxCow
   Sy23ryiSWT+t/ME3zBOlYTqq7Q6n+VPnl19foqrUb/vs946JQkqC6NTCz
   yWesD/3rvQijgcgTkurJ1iiJVv+m2Ddv0RaGtQEQyyQ4n3e/OV919Yf6L
   KLoG6Y7XjY2Uf1e0CN+VO8upQFA1EZjiwJzqRrbYkjIxr0gaeul5R4uZp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="380591854"
X-IronPort-AV: E=Sophos;i="6.02,241,1688454000"; 
   d="scan'208";a="380591854"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2023 23:09:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="989704268"
X-IronPort-AV: E=Sophos;i="6.02,241,1688454000"; 
   d="scan'208";a="989704268"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 09 Sep 2023 23:09:27 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qfDdN-0004V4-0F;
        Sun, 10 Sep 2023 06:09:25 +0000
Date:   Sun, 10 Sep 2023 14:08:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: drivers/opp/core.c:2092: warning: Function parameter or member
 'config_clks' not described in '_opp_set_clknames'
Message-ID: <202309101424.6IVOgtMf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   535a265d7f0dd50d8c3a4f8b4f3a452d56bd160f
commit: 2083da24eb56ce622332946800a67a7449d85fe5 OPP: Allow multiple clocks for a device
date:   1 year, 2 months ago
config: csky-defconfig (https://download.01.org/0day-ci/archive/20230910/202309101424.6IVOgtMf-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230910/202309101424.6IVOgtMf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309101424.6IVOgtMf-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/opp/core.c:1904: warning: Function parameter or member 'opp_table' not described in '_opp_set_supported_hw'
   drivers/opp/core.c:1904: warning: Excess function parameter 'dev' description in '_opp_set_supported_hw'
   drivers/opp/core.c:1947: warning: Function parameter or member 'opp_table' not described in '_opp_set_prop_name'
   drivers/opp/core.c:1947: warning: Excess function parameter 'dev' description in '_opp_set_prop_name'
   drivers/opp/core.c:1988: warning: Function parameter or member 'opp_table' not described in '_opp_set_regulators'
   drivers/opp/core.c:1988: warning: Excess function parameter 'count' description in '_opp_set_regulators'
   drivers/opp/core.c:2092: warning: Function parameter or member 'opp_table' not described in '_opp_set_clknames'
>> drivers/opp/core.c:2092: warning: Function parameter or member 'config_clks' not described in '_opp_set_clknames'
   drivers/opp/core.c:2190: warning: Function parameter or member 'opp_table' not described in '_opp_set_config_regulators_helper'
   drivers/opp/core.c:2254: warning: Function parameter or member 'opp_table' not described in '_opp_attach_genpd'
   drivers/opp/core.c:2481: warning: Function parameter or member 'token' not described in 'dev_pm_opp_clear_config'
   drivers/opp/core.c:2481: warning: Excess function parameter 'opp_table' description in 'dev_pm_opp_clear_config'


vim +2092 drivers/opp/core.c

38393409da345c drivers/base/power/opp.c      Viresh Kumar        2014-11-25  1890  
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1891  /**
89f03984fa2abf drivers/opp/core.c            Viresh Kumar        2022-05-26  1892   * _opp_set_supported_hw() - Set supported platforms
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1893   * @dev: Device for which supported-hw has to be set.
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1894   * @versions: Array of hierarchy of versions to match.
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1895   * @count: Number of elements in the array.
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1896   *
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1897   * This is required only for the V2 bindings, and it enables a platform to
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1898   * specify the hierarchy of versions it supports. OPP layer will then enable
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1899   * OPPs, which are available for those versions, based on its 'opp-supported-hw'
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1900   * property.
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1901   */
89f03984fa2abf drivers/opp/core.c            Viresh Kumar        2022-05-26  1902  static int _opp_set_supported_hw(struct opp_table *opp_table,
fa30184d192ec7 drivers/base/power/opp/core.c Viresh Kumar        2017-01-23  1903  				 const u32 *versions, unsigned int count)
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar        2015-12-09 @1904  {
25419de1b8dda2 drivers/opp/core.c            Viresh Kumar        2018-05-22  1905  	/* Another CPU that shares the OPP table has set the property ? */
25419de1b8dda2 drivers/opp/core.c            Viresh Kumar        2018-05-22  1906  	if (opp_table->supported_hw)
89f03984fa2abf drivers/opp/core.c            Viresh Kumar        2022-05-26  1907  		return 0;
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1908  
2c2709dc6921c5 drivers/base/power/opp/core.c Viresh Kumar        2016-02-16  1909  	opp_table->supported_hw = kmemdup(versions, count * sizeof(*versions),
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1910  					GFP_KERNEL);
89f03984fa2abf drivers/opp/core.c            Viresh Kumar        2022-05-26  1911  	if (!opp_table->supported_hw)
89f03984fa2abf drivers/opp/core.c            Viresh Kumar        2022-05-26  1912  		return -ENOMEM;
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1913  
2c2709dc6921c5 drivers/base/power/opp/core.c Viresh Kumar        2016-02-16  1914  	opp_table->supported_hw_count = count;
fa30184d192ec7 drivers/base/power/opp/core.c Viresh Kumar        2017-01-23  1915  
89f03984fa2abf drivers/opp/core.c            Viresh Kumar        2022-05-26  1916  	return 0;
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1917  }
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1918  
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1919  /**
89f03984fa2abf drivers/opp/core.c            Viresh Kumar        2022-05-26  1920   * _opp_put_supported_hw() - Releases resources blocked for supported hw
89f03984fa2abf drivers/opp/core.c            Viresh Kumar        2022-05-26  1921   * @opp_table: OPP table returned by _opp_set_supported_hw().
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1922   *
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1923   * This is required only for the V2 bindings, and is called for a matching
89f03984fa2abf drivers/opp/core.c            Viresh Kumar        2022-05-26  1924   * _opp_set_supported_hw(). Until this is called, the opp_table structure
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1925   * will not be freed.
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1926   */
89f03984fa2abf drivers/opp/core.c            Viresh Kumar        2022-05-26  1927  static void _opp_put_supported_hw(struct opp_table *opp_table)
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1928  {
89f03984fa2abf drivers/opp/core.c            Viresh Kumar        2022-05-26  1929  	if (opp_table->supported_hw) {
2c2709dc6921c5 drivers/base/power/opp/core.c Viresh Kumar        2016-02-16  1930  		kfree(opp_table->supported_hw);
2c2709dc6921c5 drivers/base/power/opp/core.c Viresh Kumar        2016-02-16  1931  		opp_table->supported_hw = NULL;
2c2709dc6921c5 drivers/base/power/opp/core.c Viresh Kumar        2016-02-16  1932  		opp_table->supported_hw_count = 0;
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1933  	}
9c4f220f3dc260 drivers/opp/core.c            Yangtao Li          2021-03-14  1934  }
9c4f220f3dc260 drivers/opp/core.c            Yangtao Li          2021-03-14  1935  
01fb4d3c39d35b drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1936  /**
298098e55a6fcc drivers/opp/core.c            Viresh Kumar        2022-05-26  1937   * _opp_set_prop_name() - Set prop-extn name
a5da64477ee79e drivers/base/power/opp/core.c Viresh Kumar        2016-02-16  1938   * @dev: Device for which the prop-name has to be set.
01fb4d3c39d35b drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1939   * @name: name to postfix to properties.
01fb4d3c39d35b drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1940   *
01fb4d3c39d35b drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1941   * This is required only for the V2 bindings, and it enables a platform to
01fb4d3c39d35b drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1942   * specify the extn to be used for certain property names. The properties to
01fb4d3c39d35b drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1943   * which the extension will apply are opp-microvolt and opp-microamp. OPP core
01fb4d3c39d35b drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1944   * should postfix the property name with -<name> while looking for them.
01fb4d3c39d35b drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1945   */
298098e55a6fcc drivers/opp/core.c            Viresh Kumar        2022-05-26  1946  static int _opp_set_prop_name(struct opp_table *opp_table, const char *name)
01fb4d3c39d35b drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1947  {
878ec1a9f0e5a6 drivers/opp/core.c            Viresh Kumar        2018-05-22  1948  	/* Another CPU that shares the OPP table has set the property ? */
2c2709dc6921c5 drivers/base/power/opp/core.c Viresh Kumar        2016-02-16  1949  	if (!opp_table->prop_name) {
298098e55a6fcc drivers/opp/core.c            Viresh Kumar        2022-05-26  1950  		opp_table->prop_name = kstrdup(name, GFP_KERNEL);
298098e55a6fcc drivers/opp/core.c            Viresh Kumar        2022-05-26  1951  		if (!opp_table->prop_name)
298098e55a6fcc drivers/opp/core.c            Viresh Kumar        2022-05-26  1952  			return -ENOMEM;
01fb4d3c39d35b drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1953  	}
01fb4d3c39d35b drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1954  
298098e55a6fcc drivers/opp/core.c            Viresh Kumar        2022-05-26  1955  	return 0;
01fb4d3c39d35b drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1956  }
01fb4d3c39d35b drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1957  
01fb4d3c39d35b drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1958  /**
298098e55a6fcc drivers/opp/core.c            Viresh Kumar        2022-05-26  1959   * _opp_put_prop_name() - Releases resources blocked for prop-name
298098e55a6fcc drivers/opp/core.c            Viresh Kumar        2022-05-26  1960   * @opp_table: OPP table returned by _opp_set_prop_name().
01fb4d3c39d35b drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1961   *
01fb4d3c39d35b drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1962   * This is required only for the V2 bindings, and is called for a matching
298098e55a6fcc drivers/opp/core.c            Viresh Kumar        2022-05-26  1963   * _opp_set_prop_name(). Until this is called, the opp_table structure
01fb4d3c39d35b drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1964   * will not be freed.
01fb4d3c39d35b drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1965   */
298098e55a6fcc drivers/opp/core.c            Viresh Kumar        2022-05-26  1966  static void _opp_put_prop_name(struct opp_table *opp_table)
01fb4d3c39d35b drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1967  {
298098e55a6fcc drivers/opp/core.c            Viresh Kumar        2022-05-26  1968  	if (opp_table->prop_name) {
2c2709dc6921c5 drivers/base/power/opp/core.c Viresh Kumar        2016-02-16  1969  		kfree(opp_table->prop_name);
2c2709dc6921c5 drivers/base/power/opp/core.c Viresh Kumar        2016-02-16  1970  		opp_table->prop_name = NULL;
01fb4d3c39d35b drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1971  	}
298098e55a6fcc drivers/opp/core.c            Viresh Kumar        2022-05-26  1972  }
01fb4d3c39d35b drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1973  
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  1974  /**
b0ec09428621da drivers/opp/core.c            Viresh Kumar        2022-07-04  1975   * _opp_set_regulators() - Set regulator names for the device
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  1976   * @dev: Device for which regulator name is being set.
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  1977   * @names: Array of pointers to the names of the regulator.
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  1978   * @count: Number of regulators.
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  1979   *
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  1980   * In order to support OPP switching, OPP layer needs to know the name of the
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  1981   * device's regulators, as the core would be required to switch voltages as
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  1982   * well.
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  1983   *
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  1984   * This must be called before any OPPs are initialized for the device.
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  1985   */
b0ec09428621da drivers/opp/core.c            Viresh Kumar        2022-07-04  1986  static int _opp_set_regulators(struct opp_table *opp_table, struct device *dev,
87686cc845c3be drivers/opp/core.c            Viresh Kumar        2022-07-04  1987  			       const char * const names[])
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  1988  {
87686cc845c3be drivers/opp/core.c            Viresh Kumar        2022-07-04  1989  	const char * const *temp = names;
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  1990  	struct regulator *reg;
87686cc845c3be drivers/opp/core.c            Viresh Kumar        2022-07-04  1991  	int count = 0, ret, i;
87686cc845c3be drivers/opp/core.c            Viresh Kumar        2022-07-04  1992  
87686cc845c3be drivers/opp/core.c            Viresh Kumar        2022-07-04  1993  	/* Count number of regulators */
87686cc845c3be drivers/opp/core.c            Viresh Kumar        2022-07-04  1994  	while (*temp++)
87686cc845c3be drivers/opp/core.c            Viresh Kumar        2022-07-04  1995  		count++;
87686cc845c3be drivers/opp/core.c            Viresh Kumar        2022-07-04  1996  
87686cc845c3be drivers/opp/core.c            Viresh Kumar        2022-07-04  1997  	if (!count)
b0ec09428621da drivers/opp/core.c            Viresh Kumar        2022-07-04  1998  		return -EINVAL;
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  1999  
779b783cfaa726 drivers/opp/core.c            Viresh Kumar        2018-05-22  2000  	/* Another CPU that shares the OPP table has set the regulators ? */
779b783cfaa726 drivers/opp/core.c            Viresh Kumar        2018-05-22  2001  	if (opp_table->regulators)
b0ec09428621da drivers/opp/core.c            Viresh Kumar        2022-07-04  2002  		return 0;
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2003  
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2004  	opp_table->regulators = kmalloc_array(count,
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2005  					      sizeof(*opp_table->regulators),
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2006  					      GFP_KERNEL);
b0ec09428621da drivers/opp/core.c            Viresh Kumar        2022-07-04  2007  	if (!opp_table->regulators)
b0ec09428621da drivers/opp/core.c            Viresh Kumar        2022-07-04  2008  		return -ENOMEM;
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2009  
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2010  	for (i = 0; i < count; i++) {
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2011  		reg = regulator_get_optional(dev, names[i]);
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2012  		if (IS_ERR(reg)) {
543256d239b415 drivers/opp/core.c            Krzysztof Kozlowski 2022-04-08  2013  			ret = dev_err_probe(dev, PTR_ERR(reg),
543256d239b415 drivers/opp/core.c            Krzysztof Kozlowski 2022-04-08  2014  					    "%s: no regulator (%s) found\n",
543256d239b415 drivers/opp/core.c            Krzysztof Kozlowski 2022-04-08  2015  					    __func__, names[i]);
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2016  			goto free_regulators;
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2017  		}
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2018  
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2019  		opp_table->regulators[i] = reg;
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2020  	}
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2021  
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2022  	opp_table->regulator_count = count;
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2023  
c522ce8a08066b drivers/opp/core.c            Viresh Kumar        2022-05-31  2024  	/* Set generic config_regulators() for single regulators here */
c522ce8a08066b drivers/opp/core.c            Viresh Kumar        2022-05-31  2025  	if (count == 1)
c522ce8a08066b drivers/opp/core.c            Viresh Kumar        2022-05-31  2026  		opp_table->config_regulators = _opp_config_regulator_single;
c522ce8a08066b drivers/opp/core.c            Viresh Kumar        2022-05-31  2027  
b0ec09428621da drivers/opp/core.c            Viresh Kumar        2022-07-04  2028  	return 0;
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2029  
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2030  free_regulators:
24957db1004353 drivers/opp/core.c            Marek Szyprowski    2019-10-17  2031  	while (i != 0)
24957db1004353 drivers/opp/core.c            Marek Szyprowski    2019-10-17  2032  		regulator_put(opp_table->regulators[--i]);
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2033  
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2034  	kfree(opp_table->regulators);
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2035  	opp_table->regulators = NULL;
46f48aca2e5aef drivers/opp/core.c            Viresh Kumar        2018-12-11  2036  	opp_table->regulator_count = -1;
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2037  
b0ec09428621da drivers/opp/core.c            Viresh Kumar        2022-07-04  2038  	return ret;
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2039  }
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2040  
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2041  /**
b0ec09428621da drivers/opp/core.c            Viresh Kumar        2022-07-04  2042   * _opp_put_regulators() - Releases resources blocked for regulator
b0ec09428621da drivers/opp/core.c            Viresh Kumar        2022-07-04  2043   * @opp_table: OPP table returned from _opp_set_regulators().
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2044   */
b0ec09428621da drivers/opp/core.c            Viresh Kumar        2022-07-04  2045  static void _opp_put_regulators(struct opp_table *opp_table)
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2046  {
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2047  	int i;
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2048  
779b783cfaa726 drivers/opp/core.c            Viresh Kumar        2018-05-22  2049  	if (!opp_table->regulators)
b0ec09428621da drivers/opp/core.c            Viresh Kumar        2022-07-04  2050  		return;
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2051  
72f80ce4ef9b75 drivers/opp/core.c            Viresh Kumar        2020-08-13  2052  	if (opp_table->enabled) {
8d45719caaf56c drivers/opp/core.c            Kamil Konieczny     2019-07-19  2053  		for (i = opp_table->regulator_count - 1; i >= 0; i--)
8d45719caaf56c drivers/opp/core.c            Kamil Konieczny     2019-07-19  2054  			regulator_disable(opp_table->regulators[i]);
8d45719caaf56c drivers/opp/core.c            Kamil Konieczny     2019-07-19  2055  	}
8d45719caaf56c drivers/opp/core.c            Kamil Konieczny     2019-07-19  2056  
24957db1004353 drivers/opp/core.c            Marek Szyprowski    2019-10-17  2057  	for (i = opp_table->regulator_count - 1; i >= 0; i--)
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2058  		regulator_put(opp_table->regulators[i]);
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2059  
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2060  	kfree(opp_table->regulators);
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2061  	opp_table->regulators = NULL;
46f48aca2e5aef drivers/opp/core.c            Viresh Kumar        2018-12-11  2062  	opp_table->regulator_count = -1;
32aee78bc5184c drivers/opp/core.c            Yangtao Li          2021-03-14  2063  }
32aee78bc5184c drivers/opp/core.c            Yangtao Li          2021-03-14  2064  
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2065  static void _put_clks(struct opp_table *opp_table, int count)
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2066  {
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2067  	int i;
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2068  
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2069  	for (i = count - 1; i >= 0; i--)
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2070  		clk_put(opp_table->clks[i]);
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2071  
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2072  	kfree(opp_table->clks);
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2073  	opp_table->clks = NULL;
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2074  }
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2075  
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar        2017-06-21  2076  /**
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2077   * _opp_set_clknames() - Set clk names for the device
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2078   * @dev: Device for which clk names is being set.
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2079   * @names: Clk names.
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2080   *
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2081   * In order to support OPP switching, OPP layer needs to get pointers to the
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2082   * clocks for the device. Simple cases work fine without using this routine
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2083   * (i.e. by passing connection-id as NULL), but for a device with multiple
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2084   * clocks available, the OPP core needs to know the exact names of the clks to
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2085   * use.
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar        2017-06-21  2086   *
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar        2017-06-21  2087   * This must be called before any OPPs are initialized for the device.
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar        2017-06-21  2088   */
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2089  static int _opp_set_clknames(struct opp_table *opp_table, struct device *dev,
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2090  			     const char * const names[],
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2091  			     config_clks_t config_clks)
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar        2017-06-21 @2092  {
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2093  	const char * const *temp = names;
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2094  	int count = 0, ret, i;
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2095  	struct clk *clk;
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar        2017-06-21  2096  
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2097  	/* Count number of clks */
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2098  	while (*temp++)
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2099  		count++;
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar        2017-06-21  2100  
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2101  	/*
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2102  	 * This is a special case where we have a single clock, whose connection
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2103  	 * id name is NULL, i.e. first two entries are NULL in the array.
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2104  	 */
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2105  	if (!count && !names[1])
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2106  		count = 1;
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2107  
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2108  	/* Fail early for invalid configurations */
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2109  	if (!count || (config_clks && count == 1) || (!config_clks && count > 1))
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2110  		return -EINVAL;
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar        2017-06-21  2111  
0a43452bb6b1f4 drivers/opp/core.c            Viresh Kumar        2022-05-25  2112  	/* Another CPU that shares the OPP table has set the clkname ? */
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2113  	if (opp_table->clks)
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2114  		return 0;
0a43452bb6b1f4 drivers/opp/core.c            Viresh Kumar        2022-05-25  2115  
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2116  	opp_table->clks = kmalloc_array(count, sizeof(*opp_table->clks),
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2117  					GFP_KERNEL);
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2118  	if (!opp_table->clks)
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2119  		return -ENOMEM;
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar        2017-06-21  2120  
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2121  	/* Find clks for the device */
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2122  	for (i = 0; i < count; i++) {
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2123  		clk = clk_get(dev, names[i]);
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2124  		if (IS_ERR(clk)) {
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2125  			ret = dev_err_probe(dev, PTR_ERR(clk),
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2126  					    "%s: Couldn't find clock with name: %s\n",
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2127  					    __func__, names[i]);
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2128  			goto free_clks;
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2129  		}
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2130  
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2131  		opp_table->clks[i] = clk;
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar        2017-06-21  2132  	}
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar        2017-06-21  2133  
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2134  	opp_table->clk_count = count;
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2135  
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2136  	/* Set generic single clk set here */
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2137  	if (count == 1) {
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2138  		opp_table->config_clks = _opp_config_clk_single;
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2139  
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2140  		/*
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2141  		 * We could have just dropped the "clk" field and used "clks"
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2142  		 * everywhere. Instead we kept the "clk" field around for
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2143  		 * following reasons:
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2144  		 *
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2145  		 * - avoiding clks[0] everywhere else.
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2146  		 * - not running single clk helpers for multiple clk usecase by
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2147  		 *   mistake.
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2148  		 *
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2149  		 * Since this is single-clk case, just update the clk pointer
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2150  		 * too.
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2151  		 */
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2152  		opp_table->clk = opp_table->clks[0];
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2153  	} else {
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2154  		opp_table->config_clks = config_clks;
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2155  	}
0a43452bb6b1f4 drivers/opp/core.c            Viresh Kumar        2022-05-25  2156  
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2157  	return 0;
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2158  
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2159  free_clks:
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2160  	_put_clks(opp_table, i);
2083da24eb56ce drivers/opp/core.c            Viresh Kumar        2022-06-10  2161  	return ret;
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar        2017-06-21  2162  }
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar        2017-06-21  2163  

:::::: The code at line 2092 was first introduced by commit
:::::: 829a4e8c0e9aab17bcfe2ddb070388b8ada26292 PM / OPP: Add dev_pm_opp_{set|put}_clkname()

:::::: TO: Viresh Kumar <viresh.kumar@linaro.org>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
