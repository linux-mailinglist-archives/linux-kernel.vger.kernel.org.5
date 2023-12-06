Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3788C8066A1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 06:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376690AbjLFFfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 00:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjLFFfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 00:35:51 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054D918F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 21:35:57 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c0fc1cf3dso20895905e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 21:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701840955; x=1702445755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qzthnNL0UkewQ0fO1K+PfqxIntdCT/Ts1fLBxjOArOk=;
        b=XcVQX36TMvPD/G2D+hD5VCKJVoAA7budWGdvmim5wokrfSrrhd3M/hb1+sUDfCJbu/
         E71IPpuerQE9GSt+k73wdoCV34B0oTMqV0akrmvzPUS5pH5SBB3tX0dT873ZP83qh7LC
         F794xw3ckH4bMHfB0ezw3SK4u8QyCOTGHfBMnHaJj9gTrEElpGXELk0L3bbrZYC23zfF
         xygUkJiY4RNOX7Uu/0wcH/d8wmYGmucJUMheyOxfEGRDVmBlTIT0llMg9VraXxvVUQAo
         VAfuRnlo7JXLGA/Ppaz9pPNnxMWIYVZ4IZAxVMRTy9/p8LrZuZmDqXlq8DWj/AGK3G3j
         iIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701840955; x=1702445755;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qzthnNL0UkewQ0fO1K+PfqxIntdCT/Ts1fLBxjOArOk=;
        b=SWPAGV8KGTvh9SsbsV5jvCA36R6FldlSlHqQd0JCNUnxoWbm9R3GA8lCd0mY9aklHn
         Q+swrM6YxLNNZ0mys89R7qGra+iY4kYXjV+ghDBZKgeCP/fOCXNhVBNQ76JJl3Ec68Q5
         yt6gE93lOINpy9uomQlWZ8Nro8ovAOumStrbR9sWYFIFSBjZeqFe3AIqgLxj2GD0Xbqc
         q5iY89UERhngkCHf9LG0L2x9pY6cFEiAQ+9+QkBf+Oljv/i5w1Q0PXpJVOYsidbUb6b2
         exh+Q856xd8odmz/NrAf8D+KyGLE5T9tHqQL566M2JALHDPGRXNRY2+ap2o2BPQ93Nz5
         9dbg==
X-Gm-Message-State: AOJu0YyJR58+OKWku0MBJwrKrLqAUMVIdOC11sL05ExlViw9KlPs0ohG
        8CDa75GIoix0A3Qvtq/UL5e5xw==
X-Google-Smtp-Source: AGHT+IENKmGGzONbrvIGkyY6v9ZdmSl19kkWnDTVDK4IiWorUXZqx8FY4JZ07ZgvvdYSt4VRR9L23w==
X-Received: by 2002:a05:600c:21c9:b0:40b:5e59:c555 with SMTP id x9-20020a05600c21c900b0040b5e59c555mr214951wmj.127.1701840955265;
        Tue, 05 Dec 2023 21:35:55 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x16-20020adfec10000000b003333beb564asm10410153wrn.5.2023.12.05.21.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 21:35:54 -0800 (PST)
Date:   Wed, 6 Dec 2023 08:35:52 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Haoran Liu <liuhaoran14@163.com>,
        davem@davemloft.net
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev, edumazet@google.com,
        pabeni@redhat.com, heiko@sntech.de, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Haoran Liu <liuhaoran14@163.com>
Subject: Re: [PATCH] [net/ethernet] arc_emac: Add error handling in
 emac_rockchip_probe
Message-ID: <08f04975-2abb-4c1a-8bf6-34e6653568af@suswa.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130031318.35850-1-liuhaoran14@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Haoran,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Haoran-Liu/arc_emac-Add-error-handling-in-emac_rockchip_probe/20231130-112325
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
patch link:    https://lore.kernel.org/r/20231130031318.35850-1-liuhaoran14%40163.com
patch subject: [PATCH] [net/ethernet] arc_emac: Add error handling in emac_rockchip_probe
config: csky-randconfig-r071-20231203 (https://download.01.org/0day-ci/archive/20231206/202312060119.eRpB9j4s-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231206/202312060119.eRpB9j4s-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202312060119.eRpB9j4s-lkp@intel.com/

smatch warnings:
drivers/net/ethernet/arc/emac_rockchip.c:139 emac_rockchip_probe() warn: missing unwind goto?
drivers/net/ethernet/arc/emac_rockchip.c:249 emac_rockchip_probe() warn: 'ndev' from alloc_etherdev_mqs() not released on lines: 139.

vim +139 drivers/net/ethernet/arc/emac_rockchip.c

6eacf31139bf96 Romain Perier      2014-09-08   93  static int emac_rockchip_probe(struct platform_device *pdev)
6eacf31139bf96 Romain Perier      2014-09-08   94  {
6eacf31139bf96 Romain Perier      2014-09-08   95  	struct device *dev = &pdev->dev;
6eacf31139bf96 Romain Perier      2014-09-08   96  	struct net_device *ndev;
6eacf31139bf96 Romain Perier      2014-09-08   97  	struct rockchip_priv_data *priv;
6eacf31139bf96 Romain Perier      2014-09-08   98  	const struct of_device_id *match;
0c65b2b90d13c1 Andrew Lunn        2019-11-04   99  	phy_interface_t interface;
6eacf31139bf96 Romain Perier      2014-09-08  100  	u32 data;
0c65b2b90d13c1 Andrew Lunn        2019-11-04  101  	int err;
6eacf31139bf96 Romain Perier      2014-09-08  102  
6eacf31139bf96 Romain Perier      2014-09-08  103  	if (!pdev->dev.of_node)
6eacf31139bf96 Romain Perier      2014-09-08  104  		return -ENODEV;
6eacf31139bf96 Romain Perier      2014-09-08  105  
6eacf31139bf96 Romain Perier      2014-09-08  106  	ndev = alloc_etherdev(sizeof(struct rockchip_priv_data));
6eacf31139bf96 Romain Perier      2014-09-08  107  	if (!ndev)
6eacf31139bf96 Romain Perier      2014-09-08  108  		return -ENOMEM;
6eacf31139bf96 Romain Perier      2014-09-08  109  	platform_set_drvdata(pdev, ndev);
6eacf31139bf96 Romain Perier      2014-09-08  110  	SET_NETDEV_DEV(ndev, dev);
6eacf31139bf96 Romain Perier      2014-09-08  111  
6eacf31139bf96 Romain Perier      2014-09-08  112  	priv = netdev_priv(ndev);
6eacf31139bf96 Romain Perier      2014-09-08  113  	priv->emac.drv_name = DRV_NAME;
6eacf31139bf96 Romain Perier      2014-09-08  114  	priv->emac.set_mac_speed = emac_rockchip_set_mac_speed;
6eacf31139bf96 Romain Perier      2014-09-08  115  
0c65b2b90d13c1 Andrew Lunn        2019-11-04  116  	err = of_get_phy_mode(dev->of_node, &interface);
0c65b2b90d13c1 Andrew Lunn        2019-11-04  117  	if (err)
0c65b2b90d13c1 Andrew Lunn        2019-11-04  118  		goto out_netdev;
6eacf31139bf96 Romain Perier      2014-09-08  119  
af72261f33ee49 Xing Zheng         2016-01-08  120  	/* RK3036/RK3066/RK3188 SoCs only support RMII */
6eacf31139bf96 Romain Perier      2014-09-08  121  	if (interface != PHY_INTERFACE_MODE_RMII) {
6eacf31139bf96 Romain Perier      2014-09-08  122  		dev_err(dev, "unsupported phy interface mode %d\n", interface);
6eacf31139bf96 Romain Perier      2014-09-08  123  		err = -ENOTSUPP;
6eacf31139bf96 Romain Perier      2014-09-08  124  		goto out_netdev;
6eacf31139bf96 Romain Perier      2014-09-08  125  	}
6eacf31139bf96 Romain Perier      2014-09-08  126  
663713eb477b9b Caesar Wang        2016-03-14  127  	priv->grf = syscon_regmap_lookup_by_phandle(dev->of_node,
663713eb477b9b Caesar Wang        2016-03-14  128  						    "rockchip,grf");
6eacf31139bf96 Romain Perier      2014-09-08  129  	if (IS_ERR(priv->grf)) {
663713eb477b9b Caesar Wang        2016-03-14  130  		dev_err(dev, "failed to retrieve global register file (%ld)\n",
663713eb477b9b Caesar Wang        2016-03-14  131  			PTR_ERR(priv->grf));
6eacf31139bf96 Romain Perier      2014-09-08  132  		err = PTR_ERR(priv->grf);
6eacf31139bf96 Romain Perier      2014-09-08  133  		goto out_netdev;
6eacf31139bf96 Romain Perier      2014-09-08  134  	}
6eacf31139bf96 Romain Perier      2014-09-08  135  
6eacf31139bf96 Romain Perier      2014-09-08  136  	match = of_match_node(emac_rockchip_dt_ids, dev->of_node);
8cb4cdab4b4030 Haoran Liu         2023-11-29  137  	if (!match) {
8cb4cdab4b4030 Haoran Liu         2023-11-29  138  		dev_err(dev, "No matching device found\n");
8cb4cdab4b4030 Haoran Liu         2023-11-29 @139  		return -ENODEV;

goto out_netdev;

8cb4cdab4b4030 Haoran Liu         2023-11-29  140  	}
8cb4cdab4b4030 Haoran Liu         2023-11-29  141  
6eacf31139bf96 Romain Perier      2014-09-08  142  	priv->soc_data = match->data;
6eacf31139bf96 Romain Perier      2014-09-08  143  
6eacf31139bf96 Romain Perier      2014-09-08  144  	priv->emac.clk = devm_clk_get(dev, "hclk");
6eacf31139bf96 Romain Perier      2014-09-08  145  	if (IS_ERR(priv->emac.clk)) {
663713eb477b9b Caesar Wang        2016-03-14  146  		dev_err(dev, "failed to retrieve host clock (%ld)\n",
663713eb477b9b Caesar Wang        2016-03-14  147  			PTR_ERR(priv->emac.clk));
6eacf31139bf96 Romain Perier      2014-09-08  148  		err = PTR_ERR(priv->emac.clk);
6eacf31139bf96 Romain Perier      2014-09-08  149  		goto out_netdev;
6eacf31139bf96 Romain Perier      2014-09-08  150  	}
6eacf31139bf96 Romain Perier      2014-09-08  151  
6eacf31139bf96 Romain Perier      2014-09-08  152  	priv->refclk = devm_clk_get(dev, "macref");
6eacf31139bf96 Romain Perier      2014-09-08  153  	if (IS_ERR(priv->refclk)) {
663713eb477b9b Caesar Wang        2016-03-14  154  		dev_err(dev, "failed to retrieve reference clock (%ld)\n",
663713eb477b9b Caesar Wang        2016-03-14  155  			PTR_ERR(priv->refclk));
6eacf31139bf96 Romain Perier      2014-09-08  156  		err = PTR_ERR(priv->refclk);
6eacf31139bf96 Romain Perier      2014-09-08  157  		goto out_netdev;
6eacf31139bf96 Romain Perier      2014-09-08  158  	}
6eacf31139bf96 Romain Perier      2014-09-08  159  
6eacf31139bf96 Romain Perier      2014-09-08  160  	err = clk_prepare_enable(priv->refclk);
6eacf31139bf96 Romain Perier      2014-09-08  161  	if (err) {
6eacf31139bf96 Romain Perier      2014-09-08  162  		dev_err(dev, "failed to enable reference clock (%d)\n", err);
6eacf31139bf96 Romain Perier      2014-09-08  163  		goto out_netdev;
6eacf31139bf96 Romain Perier      2014-09-08  164  	}
6eacf31139bf96 Romain Perier      2014-09-08  165  
6eacf31139bf96 Romain Perier      2014-09-08  166  	/* Optional regulator for PHY */
6eacf31139bf96 Romain Perier      2014-09-08  167  	priv->regulator = devm_regulator_get_optional(dev, "phy");
6eacf31139bf96 Romain Perier      2014-09-08  168  	if (IS_ERR(priv->regulator)) {
00777fac28ba3e Christophe JAILLET 2018-03-18  169  		if (PTR_ERR(priv->regulator) == -EPROBE_DEFER) {
00777fac28ba3e Christophe JAILLET 2018-03-18  170  			err = -EPROBE_DEFER;
00777fac28ba3e Christophe JAILLET 2018-03-18  171  			goto out_clk_disable;
00777fac28ba3e Christophe JAILLET 2018-03-18  172  		}
6eacf31139bf96 Romain Perier      2014-09-08  173  		dev_err(dev, "no regulator found\n");
6eacf31139bf96 Romain Perier      2014-09-08  174  		priv->regulator = NULL;
6eacf31139bf96 Romain Perier      2014-09-08  175  	}
6eacf31139bf96 Romain Perier      2014-09-08  176  
6eacf31139bf96 Romain Perier      2014-09-08  177  	if (priv->regulator) {
6eacf31139bf96 Romain Perier      2014-09-08  178  		err = regulator_enable(priv->regulator);
6eacf31139bf96 Romain Perier      2014-09-08  179  		if (err) {
6eacf31139bf96 Romain Perier      2014-09-08  180  			dev_err(dev, "failed to enable phy-supply (%d)\n", err);
6eacf31139bf96 Romain Perier      2014-09-08  181  			goto out_clk_disable;
6eacf31139bf96 Romain Perier      2014-09-08  182  		}
6eacf31139bf96 Romain Perier      2014-09-08  183  	}
6eacf31139bf96 Romain Perier      2014-09-08  184  
f4c9d3ee0334fd Xing Zheng         2016-01-08  185  	/* Set speed 100M */
f4c9d3ee0334fd Xing Zheng         2016-01-08  186  	data = (1 << (priv->soc_data->grf_speed_offset + 16)) |
f4c9d3ee0334fd Xing Zheng         2016-01-08  187  	       (1 << priv->soc_data->grf_speed_offset);
f4c9d3ee0334fd Xing Zheng         2016-01-08  188  	/* Set RMII mode */
f4c9d3ee0334fd Xing Zheng         2016-01-08  189  	data |= (1 << (priv->soc_data->grf_mode_offset + 16)) |
f4c9d3ee0334fd Xing Zheng         2016-01-08  190  		(0 << priv->soc_data->grf_mode_offset);
6eacf31139bf96 Romain Perier      2014-09-08  191  
6eacf31139bf96 Romain Perier      2014-09-08  192  	err = regmap_write(priv->grf, priv->soc_data->grf_offset, data);
6eacf31139bf96 Romain Perier      2014-09-08  193  	if (err) {
663713eb477b9b Caesar Wang        2016-03-14  194  		dev_err(dev, "unable to apply initial settings to grf (%d)\n",
663713eb477b9b Caesar Wang        2016-03-14  195  			err);
6eacf31139bf96 Romain Perier      2014-09-08  196  		goto out_regulator_disable;
6eacf31139bf96 Romain Perier      2014-09-08  197  	}
6eacf31139bf96 Romain Perier      2014-09-08  198  
6eacf31139bf96 Romain Perier      2014-09-08  199  	/* RMII interface needs always a rate of 50MHz */
6eacf31139bf96 Romain Perier      2014-09-08  200  	err = clk_set_rate(priv->refclk, 50000000);
2a9ee696c72a24 Branislav Radocaj  2017-12-12  201  	if (err) {
663713eb477b9b Caesar Wang        2016-03-14  202  		dev_err(dev,
663713eb477b9b Caesar Wang        2016-03-14  203  			"failed to change reference clock rate (%d)\n", err);
2a9ee696c72a24 Branislav Radocaj  2017-12-12  204  		goto out_regulator_disable;
2a9ee696c72a24 Branislav Radocaj  2017-12-12  205  	}
c9bca2fe3ca6d6 Xing Zheng         2016-01-08  206  
f4c9d3ee0334fd Xing Zheng         2016-01-08  207  	if (priv->soc_data->need_div_macclk) {
f4c9d3ee0334fd Xing Zheng         2016-01-08  208  		priv->macclk = devm_clk_get(dev, "macclk");
f4c9d3ee0334fd Xing Zheng         2016-01-08  209  		if (IS_ERR(priv->macclk)) {
663713eb477b9b Caesar Wang        2016-03-14  210  			dev_err(dev, "failed to retrieve mac clock (%ld)\n",
663713eb477b9b Caesar Wang        2016-03-14  211  				PTR_ERR(priv->macclk));
f4c9d3ee0334fd Xing Zheng         2016-01-08  212  			err = PTR_ERR(priv->macclk);
f4c9d3ee0334fd Xing Zheng         2016-01-08  213  			goto out_regulator_disable;
f4c9d3ee0334fd Xing Zheng         2016-01-08  214  		}
f4c9d3ee0334fd Xing Zheng         2016-01-08  215  
f4c9d3ee0334fd Xing Zheng         2016-01-08  216  		err = clk_prepare_enable(priv->macclk);
f4c9d3ee0334fd Xing Zheng         2016-01-08  217  		if (err) {
f4c9d3ee0334fd Xing Zheng         2016-01-08  218  			dev_err(dev, "failed to enable mac clock (%d)\n", err);
f4c9d3ee0334fd Xing Zheng         2016-01-08  219  			goto out_regulator_disable;
f4c9d3ee0334fd Xing Zheng         2016-01-08  220  		}
f4c9d3ee0334fd Xing Zheng         2016-01-08  221  
f4c9d3ee0334fd Xing Zheng         2016-01-08  222  		/* RMII TX/RX needs always a rate of 25MHz */
f4c9d3ee0334fd Xing Zheng         2016-01-08  223  		err = clk_set_rate(priv->macclk, 25000000);
e46772a6946a7d Branislav Radocaj  2017-12-07  224  		if (err) {
663713eb477b9b Caesar Wang        2016-03-14  225  			dev_err(dev,
663713eb477b9b Caesar Wang        2016-03-14  226  				"failed to change mac clock rate (%d)\n", err);
e46772a6946a7d Branislav Radocaj  2017-12-07  227  			goto out_clk_disable_macclk;
e46772a6946a7d Branislav Radocaj  2017-12-07  228  		}
f4c9d3ee0334fd Xing Zheng         2016-01-08  229  	}
f4c9d3ee0334fd Xing Zheng         2016-01-08  230  
c9bca2fe3ca6d6 Xing Zheng         2016-01-08  231  	err = arc_emac_probe(ndev, interface);
c9bca2fe3ca6d6 Xing Zheng         2016-01-08  232  	if (err) {
c9bca2fe3ca6d6 Xing Zheng         2016-01-08  233  		dev_err(dev, "failed to probe arc emac (%d)\n", err);
2a9ee696c72a24 Branislav Radocaj  2017-12-12  234  		goto out_clk_disable_macclk;
c9bca2fe3ca6d6 Xing Zheng         2016-01-08  235  	}
c9bca2fe3ca6d6 Xing Zheng         2016-01-08  236  
6eacf31139bf96 Romain Perier      2014-09-08  237  	return 0;
2a9ee696c72a24 Branislav Radocaj  2017-12-12  238  
e46772a6946a7d Branislav Radocaj  2017-12-07  239  out_clk_disable_macclk:
2a9ee696c72a24 Branislav Radocaj  2017-12-12  240  	if (priv->soc_data->need_div_macclk)
e46772a6946a7d Branislav Radocaj  2017-12-07  241  		clk_disable_unprepare(priv->macclk);
6eacf31139bf96 Romain Perier      2014-09-08  242  out_regulator_disable:
6eacf31139bf96 Romain Perier      2014-09-08  243  	if (priv->regulator)
6eacf31139bf96 Romain Perier      2014-09-08  244  		regulator_disable(priv->regulator);
6eacf31139bf96 Romain Perier      2014-09-08  245  out_clk_disable:
6eacf31139bf96 Romain Perier      2014-09-08  246  	clk_disable_unprepare(priv->refclk);
6eacf31139bf96 Romain Perier      2014-09-08  247  out_netdev:
6eacf31139bf96 Romain Perier      2014-09-08  248  	free_netdev(ndev);
6eacf31139bf96 Romain Perier      2014-09-08 @249  	return err;
6eacf31139bf96 Romain Perier      2014-09-08  250  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

