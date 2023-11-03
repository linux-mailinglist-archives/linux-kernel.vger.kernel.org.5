Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E337F7E0750
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 18:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377294AbjKCRU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 13:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjKCRU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 13:20:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C0CBD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 10:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699032020; x=1730568020;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=92ACeWf6IBFRlHh//J8Lv0FzVZ8+Ndk1Z7JTGFgY9Hw=;
  b=jc5KDeTUEpj7AtMq+13n3FfMwsgFu8P8m43nw7VVp8YPpditZOrb4Twg
   y+T6OA9F+MfJWpzizgktoP7sXVG3bAsyg32JH3Xx/s9IdSw5rcQQ8mqsc
   ZKES0+hkXpb57bNccbWOAkbCLE2kgyprk6pTDh3z/cVMjTRWq+RSRTytR
   xoiwrYaUsL9b/wSozYyWH2gPj0lnv5B4JA3XeF6oUohJNhmn2uPu0b9AS
   U1+tAoOons1w1a9CMm/V0ct87fEWx/ylo1QfScu+SLm/AG0yPhWaB0lM0
   MDrGX5uzr5K7d5yE8D4xPFxk9gKDu2dMKnCilWQ5wdybeIKUuLwK1T+A7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="374024617"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="374024617"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 10:20:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="796682361"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="796682361"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 03 Nov 2023 10:20:18 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyxqC-0002kc-05;
        Fri, 03 Nov 2023 17:20:16 +0000
Date:   Sat, 4 Nov 2023 01:19:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: drivers/gpu/drm/imx/ipuv3/imx-ldb.c:659:39: warning: '_sel'
 directive writing 4 bytes into a region of size between 3 and 13
Message-ID: <202311040118.DpgJp95C-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8f6f76a6a29f36d2f3e4510d0bde5046672f6924
commit: 4b6cb2b67da883bc5095ee6d77f951f1cd7a1c24 drm/imx: move IPUv3 driver into separate subdirectory
date:   11 months ago
config: sparc-allmodconfig (https://download.01.org/0day-ci/archive/20231104/202311040118.DpgJp95C-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311040118.DpgJp95C-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311040118.DpgJp95C-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/imx/ipuv3/imx-ldb.c: In function 'imx_ldb_probe':
>> drivers/gpu/drm/imx/ipuv3/imx-ldb.c:659:39: warning: '_sel' directive writing 4 bytes into a region of size between 3 and 13 [-Wformat-overflow=]
     659 |                 sprintf(clkname, "di%d_sel", i);
         |                                       ^~~~
   drivers/gpu/drm/imx/ipuv3/imx-ldb.c:659:17: note: 'sprintf' output between 8 and 18 bytes into a destination of size 16
     659 |                 sprintf(clkname, "di%d_sel", i);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/_sel +659 drivers/gpu/drm/imx/ipuv3/imx-ldb.c

8767f4711b2b74 drivers/gpu/drm/imx/imx-ldb.c     Philipp Zabel        2020-12-10  615  
8767f4711b2b74 drivers/gpu/drm/imx/imx-ldb.c     Philipp Zabel        2020-12-10  616  static int imx_ldb_probe(struct platform_device *pdev)
8767f4711b2b74 drivers/gpu/drm/imx/imx-ldb.c     Philipp Zabel        2020-12-10  617  {
8767f4711b2b74 drivers/gpu/drm/imx/imx-ldb.c     Philipp Zabel        2020-12-10  618  	struct device *dev = &pdev->dev;
17b5001b5143e3 drivers/staging/imx-drm/imx-ldb.c Russell King         2013-11-03  619  	struct device_node *np = dev->of_node;
8767f4711b2b74 drivers/gpu/drm/imx/imx-ldb.c     Philipp Zabel        2020-12-10  620  	const struct of_device_id *of_id = of_match_device(imx_ldb_dt_ids, dev);
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  621  	struct device_node *child;
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  622  	struct imx_ldb *imx_ldb;
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  623  	int dual;
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  624  	int ret;
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  625  	int i;
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  626  
8767f4711b2b74 drivers/gpu/drm/imx/imx-ldb.c     Philipp Zabel        2020-12-10  627  	imx_ldb = devm_kzalloc(dev, sizeof(*imx_ldb), GFP_KERNEL);
8767f4711b2b74 drivers/gpu/drm/imx/imx-ldb.c     Philipp Zabel        2020-12-10  628  	if (!imx_ldb)
8767f4711b2b74 drivers/gpu/drm/imx/imx-ldb.c     Philipp Zabel        2020-12-10  629  		return -ENOMEM;
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  630  
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  631  	imx_ldb->regmap = syscon_regmap_lookup_by_phandle(np, "gpr");
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  632  	if (IS_ERR(imx_ldb->regmap)) {
17b5001b5143e3 drivers/staging/imx-drm/imx-ldb.c Russell King         2013-11-03  633  		dev_err(dev, "failed to get parent regmap\n");
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  634  		return PTR_ERR(imx_ldb->regmap);
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  635  	}
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  636  
b58262396fabd4 drivers/gpu/drm/imx/imx-ldb.c     Lucas Stach          2018-04-11  637  	/* disable LDB by resetting the control register to POR default */
b58262396fabd4 drivers/gpu/drm/imx/imx-ldb.c     Lucas Stach          2018-04-11  638  	regmap_write(imx_ldb->regmap, IOMUXC_GPR2, 0);
b58262396fabd4 drivers/gpu/drm/imx/imx-ldb.c     Lucas Stach          2018-04-11  639  
17b5001b5143e3 drivers/staging/imx-drm/imx-ldb.c Russell King         2013-11-03  640  	imx_ldb->dev = dev;
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  641  
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  642  	if (of_id)
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  643  		imx_ldb->lvds_mux = of_id->data;
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  644  
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  645  	dual = of_property_read_bool(np, "fsl,dual-channel");
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  646  	if (dual)
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  647  		imx_ldb->ldb_ctrl |= LDB_SPLIT_MODE_EN;
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  648  
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  649  	/*
4599934de2cd1c drivers/staging/imx-drm/imx-ldb.c Masanari Iida        2013-07-24  650  	 * There are three different possible clock mux configurations:
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  651  	 * i.MX53:  ipu1_di0_sel, ipu1_di1_sel
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  652  	 * i.MX6q:  ipu1_di0_sel, ipu1_di1_sel, ipu2_di0_sel, ipu2_di1_sel
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  653  	 * i.MX6dl: ipu1_di0_sel, ipu1_di1_sel, lcdif_sel
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  654  	 * Map them all to di0_sel...di3_sel.
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  655  	 */
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  656  	for (i = 0; i < 4; i++) {
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  657  		char clkname[16];
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  658  
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18 @659  		sprintf(clkname, "di%d_sel", i);
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  660  		imx_ldb->clk_sel[i] = devm_clk_get(imx_ldb->dev, clkname);
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  661  		if (IS_ERR(imx_ldb->clk_sel[i])) {
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  662  			ret = PTR_ERR(imx_ldb->clk_sel[i]);
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  663  			imx_ldb->clk_sel[i] = NULL;
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  664  			break;
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  665  		}
3973aff0658530 drivers/gpu/drm/imx/imx-ldb.c     Philipp Zabel        2014-11-26  666  
3973aff0658530 drivers/gpu/drm/imx/imx-ldb.c     Philipp Zabel        2014-11-26  667  		imx_ldb->clk_parent[i] = clk_get_parent(imx_ldb->clk_sel[i]);
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  668  	}
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  669  	if (i == 0)
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  670  		return ret;
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  671  
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  672  	for_each_child_of_node(np, child) {
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  673  		struct imx_ldb_channel *channel;
032003c5cd744e drivers/gpu/drm/imx/imx-ldb.c     Liu Ying             2016-07-08  674  		int bus_format;
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  675  
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  676  		ret = of_property_read_u32(child, "reg", &i);
aa3312012f103f drivers/gpu/drm/imx/imx-ldb.c     Julia Lawall         2019-01-13  677  		if (ret || i < 0 || i > 1) {
aa3312012f103f drivers/gpu/drm/imx/imx-ldb.c     Julia Lawall         2019-01-13  678  			ret = -EINVAL;
aa3312012f103f drivers/gpu/drm/imx/imx-ldb.c     Julia Lawall         2019-01-13  679  			goto free_child;
aa3312012f103f drivers/gpu/drm/imx/imx-ldb.c     Julia Lawall         2019-01-13  680  		}
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  681  
c80d673b91a6c8 drivers/gpu/drm/imx/imx-ldb.c     Lucas Stach          2018-04-11  682  		if (!of_device_is_available(child))
c80d673b91a6c8 drivers/gpu/drm/imx/imx-ldb.c     Lucas Stach          2018-04-11  683  			continue;
c80d673b91a6c8 drivers/gpu/drm/imx/imx-ldb.c     Lucas Stach          2018-04-11  684  
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  685  		if (dual && i > 0) {
17b5001b5143e3 drivers/staging/imx-drm/imx-ldb.c Russell King         2013-11-03  686  			dev_warn(dev, "dual-channel mode, ignoring second output\n");
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  687  			continue;
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  688  		}
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  689  
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  690  		channel = &imx_ldb->channel[i];
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  691  		channel->ldb = imx_ldb;
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  692  		channel->chno = i;
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  693  
751e2676ee9272 drivers/gpu/drm/imx/imx-ldb.c     Philipp Zabel        2014-03-06  694  		/*
751e2676ee9272 drivers/gpu/drm/imx/imx-ldb.c     Philipp Zabel        2014-03-06  695  		 * The output port is port@4 with an external 4-port mux or
751e2676ee9272 drivers/gpu/drm/imx/imx-ldb.c     Philipp Zabel        2014-03-06  696  		 * port@2 with the internal 2-port mux.
751e2676ee9272 drivers/gpu/drm/imx/imx-ldb.c     Philipp Zabel        2014-03-06  697  		 */
ebc9446135671b drivers/gpu/drm/imx/imx-ldb.c     Rob Herring          2017-03-29  698  		ret = drm_of_find_panel_or_bridge(child,
ebc9446135671b drivers/gpu/drm/imx/imx-ldb.c     Rob Herring          2017-03-29  699  						  imx_ldb->lvds_mux ? 4 : 2, 0,
ebc9446135671b drivers/gpu/drm/imx/imx-ldb.c     Rob Herring          2017-03-29  700  						  &channel->panel, &channel->bridge);
e36aecba54bf24 drivers/gpu/drm/imx/imx-ldb.c     Leonard Crestez      2017-05-10  701  		if (ret && ret != -ENODEV)
aa3312012f103f drivers/gpu/drm/imx/imx-ldb.c     Julia Lawall         2019-01-13  702  			goto free_child;
a6d206e28abe46 drivers/gpu/drm/imx/imx-ldb.c     Steve Longerbeam     2016-04-27  703  
dc80d7038883fe drivers/gpu/drm/imx/imx-ldb.c     Peter Senna Tschudin 2016-08-05  704  		/* panel ddc only if there is no bridge */
dc80d7038883fe drivers/gpu/drm/imx/imx-ldb.c     Peter Senna Tschudin 2016-08-05  705  		if (!channel->bridge) {
dc80d7038883fe drivers/gpu/drm/imx/imx-ldb.c     Peter Senna Tschudin 2016-08-05  706  			ret = imx_ldb_panel_ddc(dev, channel, child);
dc80d7038883fe drivers/gpu/drm/imx/imx-ldb.c     Peter Senna Tschudin 2016-08-05  707  			if (ret)
aa3312012f103f drivers/gpu/drm/imx/imx-ldb.c     Julia Lawall         2019-01-13  708  				goto free_child;
a6d206e28abe46 drivers/gpu/drm/imx/imx-ldb.c     Steve Longerbeam     2016-04-27  709  		}
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  710  
032003c5cd744e drivers/gpu/drm/imx/imx-ldb.c     Liu Ying             2016-07-08  711  		bus_format = of_get_bus_format(dev, child);
032003c5cd744e drivers/gpu/drm/imx/imx-ldb.c     Liu Ying             2016-07-08  712  		if (bus_format == -EINVAL) {
5e501ed7253b36 drivers/gpu/drm/imx/imx-ldb.c     Philipp Zabel        2014-12-02  713  			/*
5e501ed7253b36 drivers/gpu/drm/imx/imx-ldb.c     Philipp Zabel        2014-12-02  714  			 * If no bus format was specified in the device tree,
5e501ed7253b36 drivers/gpu/drm/imx/imx-ldb.c     Philipp Zabel        2014-12-02  715  			 * we can still get it from the connected panel later.
5e501ed7253b36 drivers/gpu/drm/imx/imx-ldb.c     Philipp Zabel        2014-12-02  716  			 */
5e501ed7253b36 drivers/gpu/drm/imx/imx-ldb.c     Philipp Zabel        2014-12-02  717  			if (channel->panel && channel->panel->funcs &&
5e501ed7253b36 drivers/gpu/drm/imx/imx-ldb.c     Philipp Zabel        2014-12-02  718  			    channel->panel->funcs->get_modes)
032003c5cd744e drivers/gpu/drm/imx/imx-ldb.c     Liu Ying             2016-07-08  719  				bus_format = 0;
5e501ed7253b36 drivers/gpu/drm/imx/imx-ldb.c     Philipp Zabel        2014-12-02  720  		}
032003c5cd744e drivers/gpu/drm/imx/imx-ldb.c     Liu Ying             2016-07-08  721  		if (bus_format < 0) {
5e501ed7253b36 drivers/gpu/drm/imx/imx-ldb.c     Philipp Zabel        2014-12-02  722  			dev_err(dev, "could not determine data mapping: %d\n",
032003c5cd744e drivers/gpu/drm/imx/imx-ldb.c     Liu Ying             2016-07-08  723  				bus_format);
aa3312012f103f drivers/gpu/drm/imx/imx-ldb.c     Julia Lawall         2019-01-13  724  			ret = bus_format;
aa3312012f103f drivers/gpu/drm/imx/imx-ldb.c     Julia Lawall         2019-01-13  725  			goto free_child;
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  726  		}
49f98bc4d44a4e drivers/gpu/drm/imx/imx-ldb.c     Philipp Zabel        2016-07-06  727  		channel->bus_format = bus_format;
aa3312012f103f drivers/gpu/drm/imx/imx-ldb.c     Julia Lawall         2019-01-13  728  		channel->child = child;
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  729  	}
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  730  
8767f4711b2b74 drivers/gpu/drm/imx/imx-ldb.c     Philipp Zabel        2020-12-10  731  	platform_set_drvdata(pdev, imx_ldb);
8767f4711b2b74 drivers/gpu/drm/imx/imx-ldb.c     Philipp Zabel        2020-12-10  732  
8767f4711b2b74 drivers/gpu/drm/imx/imx-ldb.c     Philipp Zabel        2020-12-10  733  	return component_add(&pdev->dev, &imx_ldb_ops);
aa3312012f103f drivers/gpu/drm/imx/imx-ldb.c     Julia Lawall         2019-01-13  734  
aa3312012f103f drivers/gpu/drm/imx/imx-ldb.c     Julia Lawall         2019-01-13  735  free_child:
aa3312012f103f drivers/gpu/drm/imx/imx-ldb.c     Julia Lawall         2019-01-13  736  	of_node_put(child);
aa3312012f103f drivers/gpu/drm/imx/imx-ldb.c     Julia Lawall         2019-01-13  737  	return ret;
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  738  }
ac4c1a9b330059 drivers/staging/imx-drm/imx-ldb.c Sascha Hauer         2013-06-18  739  

:::::: The code at line 659 was first introduced by commit
:::::: ac4c1a9b33005969b05de0f13ec90ec426a76769 staging: drm/imx: Add LDB support

:::::: TO: Sascha Hauer <s.hauer@pengutronix.de>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
