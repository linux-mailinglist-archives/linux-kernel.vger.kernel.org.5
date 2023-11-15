Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315DA7EBF3B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 10:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbjKOJPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbjKOJPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:15:22 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB398FC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 01:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700039718; x=1731575718;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UV3NuFFzI6aW/rGifueyBnWfJNTeeqEssuxS6rbinXQ=;
  b=S3C2vMnOcb2HKNwZ8v1Lu0xMIdIZauTPbSOnac1iQFBJWPPzR2GQPy7f
   mf9xdb4pxe81sjaw3+N92z90iM+LYjtEeX/Q9eO2XmInxGq561UnC1r+E
   d8Oh49CbnjIFpPb8b9fo3e/nWFwVp4bPD6PoRKuicNTjvhe9sb1k6HEIE
   9K0n/2di35AA+ZUvavCVqEzIF0cnm88cqqecovzLAU0PnNU4wPj6WIzsv
   VMabzTKfNJ544BwLeTb+kTEFr25PIpVayF7HmoAjdspWb2ftSkS+sKklW
   ZoLgzCKesUqwb5ltor46TqYXZE1v20BsAj9VIiAmER8WhhJy5Y9wWEXXt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="394756651"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="394756651"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 01:15:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="741382716"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="741382716"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Nov 2023 01:15:16 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3Byq-0000DP-35;
        Wed, 15 Nov 2023 09:15:03 +0000
Date:   Wed, 15 Nov 2023 17:12:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Robert Foss <rfoss@kernel.org>
Subject: drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c:230:26: warning:
 'best_m' is used uninitialized
Message-ID: <202311151746.f7u7dzbZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c
commit: ce62f8ea7e3f8a8e788c3b5ea0195f1224575b66 drm/bridge: imx: Add i.MX93 MIPI DSI support
date:   4 weeks ago
config: arc-randconfig-001-20231115 (https://download.01.org/0day-ci/archive/20231115/202311151746.f7u7dzbZ-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231115/202311151746.f7u7dzbZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311151746.f7u7dzbZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c: In function 'dphy_pll_get_configure_from_opts.isra':
>> drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c:230:26: warning: 'best_m' is used uninitialized [-Wuninitialized]
     230 |         unsigned long m, best_m;
         |                          ^~~~~~
>> drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c:229:39: warning: 'best_n' is used uninitialized [-Wuninitialized]
     229 |         unsigned int min_n, max_n, n, best_n;
         |                                       ^~~~~~


vim +/best_m +230 drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c

   218	
   219	static int
   220	dphy_pll_get_configure_from_opts(struct imx93_dsi *dsi,
   221					 struct phy_configure_opts_mipi_dphy *dphy_opts,
   222					 struct dphy_pll_cfg *cfg)
   223	{
   224		struct device *dev = dsi->dev;
   225		unsigned long fin = dsi->ref_clk_rate;
   226		unsigned long fout;
   227		unsigned long best_fout = 0;
   228		unsigned int fvco_div;
 > 229		unsigned int min_n, max_n, n, best_n;
 > 230		unsigned long m, best_m;
   231		unsigned long min_delta = ULONG_MAX;
   232		unsigned long delta;
   233		u64 tmp;
   234	
   235		if (dphy_opts->hs_clk_rate < DATA_RATE_MIN_SPEED ||
   236		    dphy_opts->hs_clk_rate > DATA_RATE_MAX_SPEED) {
   237			dev_dbg(dev, "invalid data rate per lane: %lu\n",
   238				dphy_opts->hs_clk_rate);
   239			return -EINVAL;
   240		}
   241	
   242		fout = data_rate_to_fout(dphy_opts->hs_clk_rate);
   243	
   244		/* DPHY Databook 3.3.6.1 Output Frequency */
   245		/* Fout = Fvco / Fvco_div = (Fin * M) / (Fvco_div * N) */
   246		/* Fvco_div could be 1/2/4/8 according to Fout range. */
   247		fvco_div = 8UL / min(DIV_ROUND_UP(fout, FVCO_DIV_FACTOR), 8UL);
   248	
   249		/* limitation: 2MHz <= Fin / N <= 8MHz */
   250		min_n = DIV_ROUND_UP_ULL((u64)fin, MHZ(8));
   251		max_n = DIV_ROUND_DOWN_ULL((u64)fin, MHZ(2));
   252	
   253		/* clamp possible N(s) */
   254		min_n = clamp(min_n, N_MIN, N_MAX);
   255		max_n = clamp(max_n, N_MIN, N_MAX);
   256	
   257		dev_dbg(dev, "Fout = %lu, Fvco_div = %u, n_range = [%u, %u]\n",
   258			fout, fvco_div, min_n, max_n);
   259	
   260		for (n = min_n; n <= max_n; n++) {
   261			/* M = (Fout * N * Fvco_div) / Fin */
   262			m = DIV_ROUND_CLOSEST(fout * n * fvco_div, fin);
   263	
   264			/* check M range */
   265			if (m < M_MIN || m > M_MAX)
   266				continue;
   267	
   268			/* calculate temporary Fout */
   269			tmp = m * fin;
   270			do_div(tmp, n * fvco_div);
   271			if (tmp < FOUT_MIN || tmp > FOUT_MAX)
   272				continue;
   273	
   274			delta = abs(fout - tmp);
   275			if (delta < min_delta) {
   276				best_n = n;
   277				best_m = m;
   278				min_delta = delta;
   279				best_fout = tmp;
   280			}
   281		}
   282	
   283		if (best_fout) {
   284			cfg->m = best_m;
   285			cfg->n = best_n;
   286			dev_dbg(dev, "best Fout = %lu, m = %u, n = %u\n",
   287				best_fout, cfg->m, cfg->n);
   288		} else {
   289			dev_dbg(dev, "failed to find best Fout\n");
   290			return -EINVAL;
   291		}
   292	
   293		return 0;
   294	}
   295	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
