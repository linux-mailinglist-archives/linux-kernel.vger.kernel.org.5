Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194C67E132D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 12:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjKELlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 06:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjKELlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 06:41:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D6FDE
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 03:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699184457; x=1730720457;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TAlvNa+RwHK+WF8lY0qoCEACoQqGeWE3BsCvtL7u4ws=;
  b=DEV8lE9DGtiIKhUC+z1IzOLajlH3blL8bdjCi0nuJX3wZY07NnnuCaqu
   Tu5Ly6uJP1s+R76IZZ2hxWJP/7k1YbpuAmr+xi2V9APEw6xTDhlZ4uFt1
   qo3iY4/+nLopdQSNAmhE8/L96vQkGEUwHtEgtiXhlv918AizQ+CbsJlNY
   tzVAxsrVu8VHrMcayTAbAl8ivcADBdDV8tPO3NXfpgYCibbQ6VnYmaWxh
   Md4Z9uIqRYv0OE2OlA+0FI+eZzA69MIY32lCCc2sbvyaja1Am37kwHmSt
   yiVVE5HlnzDubi2PZuaMaavABvo8tYZA0P0XKh5FeDc9YaxBegbnPZU+T
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="2118895"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="2118895"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 03:40:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="755599248"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="755599248"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 05 Nov 2023 03:40:55 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzbUr-0005ND-01;
        Sun, 05 Nov 2023 11:40:53 +0000
Date:   Sun, 5 Nov 2023 19:40:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Romain Perier <romain.perier@free-electrons.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: drivers/spi/spi-armada-3700.c:788:34: warning: 'a3700_spi_dt_ids'
 defined but not used
Message-ID: <202311051927.Yvv2LqvE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Romain,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1c41041124bd14dd6610da256a3da4e5b74ce6b1
commit: 5762ab71eb24a8393a167361510d7ca5e18c99f9 spi: Add support for Armada 3700 SPI Controller
date:   7 years ago
config: i386-buildonly-randconfig-005-20231101 (https://download.01.org/0day-ci/archive/20231105/202311051927.Yvv2LqvE-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231105/202311051927.Yvv2LqvE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311051927.Yvv2LqvE-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/spi/spi-armada-3700.c: In function 'a3700_spi_probe':
   drivers/spi/spi-armada-3700.c:850:22: warning: comparison of unsigned expression in '< 0' is always false [-Wtype-limits]
     850 |         if (spi->irq < 0) {
         |                      ^
   drivers/spi/spi-armada-3700.c: At top level:
>> drivers/spi/spi-armada-3700.c:788:34: warning: 'a3700_spi_dt_ids' defined but not used [-Wunused-const-variable=]
     788 | static const struct of_device_id a3700_spi_dt_ids[] = {
         |                                  ^~~~~~~~~~~~~~~~


vim +/a3700_spi_dt_ids +788 drivers/spi/spi-armada-3700.c

   787	
 > 788	static const struct of_device_id a3700_spi_dt_ids[] = {
   789		{ .compatible = "marvell,armada-3700-spi", .data = NULL },
   790		{},
   791	};
   792	
   793	MODULE_DEVICE_TABLE(of, a3700_spi_dt_ids);
   794	
   795	static int a3700_spi_probe(struct platform_device *pdev)
   796	{
   797		struct device *dev = &pdev->dev;
   798		struct device_node *of_node = dev->of_node;
   799		struct resource *res;
   800		struct spi_master *master;
   801		struct a3700_spi *spi;
   802		u32 num_cs = 0;
   803		int ret = 0;
   804	
   805		master = spi_alloc_master(dev, sizeof(*spi));
   806		if (!master) {
   807			dev_err(dev, "master allocation failed\n");
   808			ret = -ENOMEM;
   809			goto out;
   810		}
   811	
   812		if (of_property_read_u32(of_node, "num-cs", &num_cs)) {
   813			dev_err(dev, "could not find num-cs\n");
   814			ret = -ENXIO;
   815			goto error;
   816		}
   817	
   818		master->bus_num = pdev->id;
   819		master->dev.of_node = of_node;
   820		master->mode_bits = SPI_MODE_3;
   821		master->num_chipselect = num_cs;
   822		master->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(32);
   823		master->prepare_message =  a3700_spi_prepare_message;
   824		master->transfer_one = a3700_spi_transfer_one;
   825		master->unprepare_message = a3700_spi_unprepare_message;
   826		master->set_cs = a3700_spi_set_cs;
   827		master->flags = SPI_MASTER_HALF_DUPLEX;
   828		master->mode_bits |= (SPI_RX_DUAL | SPI_RX_DUAL |
   829				      SPI_RX_QUAD | SPI_TX_QUAD);
   830	
   831		platform_set_drvdata(pdev, master);
   832	
   833		spi = spi_master_get_devdata(master);
   834		memset(spi, 0, sizeof(struct a3700_spi));
   835	
   836		spi->master = master;
   837		spi->instr_cnt = A3700_INSTR_CNT;
   838		spi->addr_cnt = A3700_ADDR_CNT;
   839		spi->hdr_cnt = A3700_INSTR_CNT + A3700_ADDR_CNT +
   840			       A3700_DUMMY_CNT;
   841	
   842		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   843		spi->base = devm_ioremap_resource(dev, res);
   844		if (IS_ERR(spi->base)) {
   845			ret = PTR_ERR(spi->base);
   846			goto error;
   847		}
   848	
   849		spi->irq = platform_get_irq(pdev, 0);
 > 850		if (spi->irq < 0) {
   851			dev_err(dev, "could not get irq: %d\n", spi->irq);
   852			ret = -ENXIO;
   853			goto error;
   854		}
   855	
   856		init_completion(&spi->done);
   857	
   858		spi->clk = devm_clk_get(dev, NULL);
   859		if (IS_ERR(spi->clk)) {
   860			dev_err(dev, "could not find clk: %ld\n", PTR_ERR(spi->clk));
   861			goto error;
   862		}
   863	
   864		ret = clk_prepare(spi->clk);
   865		if (ret) {
   866			dev_err(dev, "could not prepare clk: %d\n", ret);
   867			goto error;
   868		}
   869	
   870		ret = a3700_spi_init(spi);
   871		if (ret)
   872			goto error_clk;
   873	
   874		ret = devm_request_irq(dev, spi->irq, a3700_spi_interrupt, 0,
   875				       dev_name(dev), master);
   876		if (ret) {
   877			dev_err(dev, "could not request IRQ: %d\n", ret);
   878			goto error_clk;
   879		}
   880	
   881		ret = devm_spi_register_master(dev, master);
   882		if (ret) {
   883			dev_err(dev, "Failed to register master\n");
   884			goto error_clk;
   885		}
   886	
   887		return 0;
   888	
   889	error_clk:
   890		clk_disable_unprepare(spi->clk);
   891	error:
   892		spi_master_put(master);
   893	out:
   894		return ret;
   895	}
   896	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
