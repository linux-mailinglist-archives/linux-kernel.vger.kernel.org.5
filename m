Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2248A77F108
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 09:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348416AbjHQHPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 03:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348480AbjHQHOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 03:14:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD05030F4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 00:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692256453; x=1723792453;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qzj47tgLoHuNMV18sy0M2D1+IBGU2vtgvBfe9bx6DLg=;
  b=iRCKUYUJmYf0ZCq/q17pWXPi4WHIZ2AKbBxhB1cD1tgkYYgOobbJf6+g
   GCpBQ+wxIu9t9BfUQzHv9Y1VVilBc7QimxEIpk+oin9Q1jDA8r9LD0aTm
   KRpbdc04vya0gjRyPkEkve34uPFYbdhcv5j+4bJoLlz9xfcsx+/LF4PyB
   z53wCkxJQooot9FmGNPw14zEhCi1TXKpji6WjaY0yVp+8FMqMFG/UdNaE
   SZxylZ47mpA+P6zMXNkH+eIjbpVMzmknwqT9QMngnPNYI6Uu3LL0XJNM/
   AdAANhpZ5sjoIr9e/K5RrH9CIF7Xl69cRhB3ZZR7cZZdOVnfdkXNYDnUC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357699448"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="357699448"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 00:14:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="799914638"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="799914638"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 17 Aug 2023 00:14:10 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWXCc-0000t5-2A;
        Thu, 17 Aug 2023 07:13:58 +0000
Date:   Thu, 17 Aug 2023 15:11:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Sebastian Wick <sebastian.wick@redhat.com>,
        Joshua Ashton <joshua@froggi.es>,
        Simon Ser <contact@emersion.fr>
Subject: drivers/gpu/drm/drm_connector.c:2215: warning: Function parameter or
 member 'supported_colorspaces' not described in
 'drm_mode_create_hdmi_colorspace_property'
Message-ID: <202308171526.DciyDwCK-lkp@intel.com>
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
head:   4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
commit: c265f340eaa87aa5f979adfb23d7463af67b7f27 drm/connector: Allow drivers to pass list of supported colorspaces
date:   10 weeks ago
config: sh-randconfig-r001-20230817 (https://download.01.org/0day-ci/archive/20230817/202308171526.DciyDwCK-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308171526.DciyDwCK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308171526.DciyDwCK-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/drm_connector.c:2215: warning: Function parameter or member 'supported_colorspaces' not described in 'drm_mode_create_hdmi_colorspace_property'
>> drivers/gpu/drm/drm_connector.c:2239: warning: Function parameter or member 'supported_colorspaces' not described in 'drm_mode_create_dp_colorspace_property'


vim +2215 drivers/gpu/drm/drm_connector.c

c627087cb164d1 Harry Wentland  2022-11-29  2202  
8806cd3aa025ad Gwan-gyeong Mun 2019-09-19  2203  /**
8806cd3aa025ad Gwan-gyeong Mun 2019-09-19  2204   * drm_mode_create_hdmi_colorspace_property - create hdmi colorspace property
8806cd3aa025ad Gwan-gyeong Mun 2019-09-19  2205   * @connector: connector to create the Colorspace property on.
8806cd3aa025ad Gwan-gyeong Mun 2019-09-19  2206   *
d2c6a405846c24 Uma Shankar     2019-02-19  2207   * Called by a driver the first time it's needed, must be attached to desired
8806cd3aa025ad Gwan-gyeong Mun 2019-09-19  2208   * HDMI connectors.
8806cd3aa025ad Gwan-gyeong Mun 2019-09-19  2209   *
8806cd3aa025ad Gwan-gyeong Mun 2019-09-19  2210   * Returns:
84e543bc9d1dc5 Antonio Borneo  2020-06-26  2211   * Zero on success, negative errno on failure.
d2c6a405846c24 Uma Shankar     2019-02-19  2212   */
c265f340eaa87a Harry Wentland  2022-11-29  2213  int drm_mode_create_hdmi_colorspace_property(struct drm_connector *connector,
c265f340eaa87a Harry Wentland  2022-11-29  2214  					     u32 supported_colorspaces)
d2c6a405846c24 Uma Shankar     2019-02-19 @2215  {
c265f340eaa87a Harry Wentland  2022-11-29  2216  	u32 colorspaces;
c265f340eaa87a Harry Wentland  2022-11-29  2217  
c265f340eaa87a Harry Wentland  2022-11-29  2218  	if (supported_colorspaces)
c265f340eaa87a Harry Wentland  2022-11-29  2219  		colorspaces = supported_colorspaces & hdmi_colorspaces;
c265f340eaa87a Harry Wentland  2022-11-29  2220  	else
c265f340eaa87a Harry Wentland  2022-11-29  2221  		colorspaces = hdmi_colorspaces;
c265f340eaa87a Harry Wentland  2022-11-29  2222  
c265f340eaa87a Harry Wentland  2022-11-29  2223  	return drm_mode_create_colorspace_property(connector, colorspaces);
d2c6a405846c24 Uma Shankar     2019-02-19  2224  }
8806cd3aa025ad Gwan-gyeong Mun 2019-09-19  2225  EXPORT_SYMBOL(drm_mode_create_hdmi_colorspace_property);
d2c6a405846c24 Uma Shankar     2019-02-19  2226  
45cf0e91df8c75 Gwan-gyeong Mun 2019-09-19  2227  /**
45cf0e91df8c75 Gwan-gyeong Mun 2019-09-19  2228   * drm_mode_create_dp_colorspace_property - create dp colorspace property
45cf0e91df8c75 Gwan-gyeong Mun 2019-09-19  2229   * @connector: connector to create the Colorspace property on.
45cf0e91df8c75 Gwan-gyeong Mun 2019-09-19  2230   *
45cf0e91df8c75 Gwan-gyeong Mun 2019-09-19  2231   * Called by a driver the first time it's needed, must be attached to desired
45cf0e91df8c75 Gwan-gyeong Mun 2019-09-19  2232   * DP connectors.
45cf0e91df8c75 Gwan-gyeong Mun 2019-09-19  2233   *
45cf0e91df8c75 Gwan-gyeong Mun 2019-09-19  2234   * Returns:
84e543bc9d1dc5 Antonio Borneo  2020-06-26  2235   * Zero on success, negative errno on failure.
45cf0e91df8c75 Gwan-gyeong Mun 2019-09-19  2236   */
c265f340eaa87a Harry Wentland  2022-11-29  2237  int drm_mode_create_dp_colorspace_property(struct drm_connector *connector,
c265f340eaa87a Harry Wentland  2022-11-29  2238  					   u32 supported_colorspaces)
45cf0e91df8c75 Gwan-gyeong Mun 2019-09-19 @2239  {
c265f340eaa87a Harry Wentland  2022-11-29  2240  	u32 colorspaces;
c265f340eaa87a Harry Wentland  2022-11-29  2241  
c265f340eaa87a Harry Wentland  2022-11-29  2242  	if (supported_colorspaces)
c265f340eaa87a Harry Wentland  2022-11-29  2243  		colorspaces = supported_colorspaces & dp_colorspaces;
c265f340eaa87a Harry Wentland  2022-11-29  2244  	else
c265f340eaa87a Harry Wentland  2022-11-29  2245  		colorspaces = dp_colorspaces;
c265f340eaa87a Harry Wentland  2022-11-29  2246  
c265f340eaa87a Harry Wentland  2022-11-29  2247  	return drm_mode_create_colorspace_property(connector, colorspaces);
d2c6a405846c24 Uma Shankar     2019-02-19  2248  }
45cf0e91df8c75 Gwan-gyeong Mun 2019-09-19  2249  EXPORT_SYMBOL(drm_mode_create_dp_colorspace_property);
d2c6a405846c24 Uma Shankar     2019-02-19  2250  

:::::: The code at line 2215 was first introduced by commit
:::::: d2c6a405846c24439f85c7a8da21545f12874638 drm: Add HDMI colorspace property

:::::: TO: Uma Shankar <uma.shankar@intel.com>
:::::: CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
