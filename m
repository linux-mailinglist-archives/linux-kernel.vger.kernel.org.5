Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605517CF56A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjJSKcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjJSKcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:32:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E807B124
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697711568; x=1729247568;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WUYVtfhpHcqOb/ROewefpYGYuHxMLA4P77VPHllnjlU=;
  b=MjJ15nkdEOJw1PO3PX3vTPnnuKmpytD54NyQb9CRkXGy6caTsWtuC5+Q
   8SCEEFjliBGzSPYTjwMeglwFkOh+Rl678I1TpKXHHaJ/BK+9PlP8wovNG
   jaGAURK183/tRzRSY0zxj32v2+4PL149uwEo1e0gs6pSG52Z0mAgX4mNe
   QJ+42ptChJQGYAbcrXk46EvL1zpoP71kXwTEXbtA5guHGahISSOPu9nsS
   wnAnqXwnudVfBC+bzKBgHpv45cp7b424xfzZdh8p3YEaza/ylrNYZUKSZ
   JVikGH7ggOUZNo7Jcih40f5CKyl8iNB/ZygpjJu+ds5MhQyAk5oPI7z4Z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="365571815"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="365571815"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 03:32:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="791954514"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="791954514"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 19 Oct 2023 03:32:07 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtQJw-00021G-2Q;
        Thu, 19 Oct 2023 10:32:04 +0000
Date:   Thu, 19 Oct 2023 18:31:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Valentin Caron <valentin.caron@foss.st.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: drivers/spi/spi-stm32.c:1808:17: warning: array subscript 0 is
 outside array bounds of 'const bool[0]' {aka 'const _Bool[]'}
Message-ID: <202310191831.MLwx1c6x-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dd72f9c7e512da377074d47d990564959b772643
commit: fee681646fc831b154619ac0261afedcc7e671e7 spi: stm32: disable device mode with st,stm32f4-spi compatible
date:   3 months ago
config: parisc-randconfig-r013-20220830 (https://download.01.org/0day-ci/archive/20231019/202310191831.MLwx1c6x-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231019/202310191831.MLwx1c6x-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310191831.MLwx1c6x-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/spi/spi-stm32.c: In function 'stm32_spi_probe':
>> drivers/spi/spi-stm32.c:1808:17: warning: array subscript 0 is outside array bounds of 'const bool[0]' {aka 'const _Bool[]'} [-Warray-bounds=]
    1808 |         if (!cfg->has_device_mode && device_mode) {
         |              ~~~^~~~~~~~~~~~~~~~~
   cc1: note: source object is likely at address zero


vim +1808 drivers/spi/spi-stm32.c

  1795	
  1796	static int stm32_spi_probe(struct platform_device *pdev)
  1797	{
  1798		struct spi_controller *ctrl;
  1799		struct stm32_spi *spi;
  1800		struct resource *res;
  1801		struct reset_control *rst;
  1802		struct device_node *np = pdev->dev.of_node;
  1803		bool device_mode;
  1804		int ret;
  1805		const struct stm32_spi_cfg *cfg = of_device_get_match_data(&pdev->dev);
  1806	
  1807		device_mode = of_property_read_bool(np, "spi-slave");
> 1808		if (!cfg->has_device_mode && device_mode) {
  1809			dev_err(&pdev->dev, "spi-slave not supported\n");
  1810			return -EPERM;
  1811		}
  1812	
  1813		if (device_mode)
  1814			ctrl = devm_spi_alloc_slave(&pdev->dev, sizeof(struct stm32_spi));
  1815		else
  1816			ctrl = devm_spi_alloc_master(&pdev->dev, sizeof(struct stm32_spi));
  1817		if (!ctrl) {
  1818			dev_err(&pdev->dev, "spi controller allocation failed\n");
  1819			return -ENOMEM;
  1820		}
  1821		platform_set_drvdata(pdev, ctrl);
  1822	
  1823		spi = spi_controller_get_devdata(ctrl);
  1824		spi->dev = &pdev->dev;
  1825		spi->ctrl = ctrl;
  1826		spi->device_mode = device_mode;
  1827		spin_lock_init(&spi->lock);
  1828	
  1829		spi->cfg = cfg;
  1830	
  1831		spi->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
  1832		if (IS_ERR(spi->base))
  1833			return PTR_ERR(spi->base);
  1834	
  1835		spi->phys_addr = (dma_addr_t)res->start;
  1836	
  1837		spi->irq = platform_get_irq(pdev, 0);
  1838		if (spi->irq <= 0)
  1839			return dev_err_probe(&pdev->dev, spi->irq,
  1840					     "failed to get irq\n");
  1841	
  1842		ret = devm_request_threaded_irq(&pdev->dev, spi->irq,
  1843						spi->cfg->irq_handler_event,
  1844						spi->cfg->irq_handler_thread,
  1845						IRQF_ONESHOT, pdev->name, ctrl);
  1846		if (ret) {
  1847			dev_err(&pdev->dev, "irq%d request failed: %d\n", spi->irq,
  1848				ret);
  1849			return ret;
  1850		}
  1851	
  1852		spi->clk = devm_clk_get(&pdev->dev, NULL);
  1853		if (IS_ERR(spi->clk)) {
  1854			ret = PTR_ERR(spi->clk);
  1855			dev_err(&pdev->dev, "clk get failed: %d\n", ret);
  1856			return ret;
  1857		}
  1858	
  1859		ret = clk_prepare_enable(spi->clk);
  1860		if (ret) {
  1861			dev_err(&pdev->dev, "clk enable failed: %d\n", ret);
  1862			return ret;
  1863		}
  1864		spi->clk_rate = clk_get_rate(spi->clk);
  1865		if (!spi->clk_rate) {
  1866			dev_err(&pdev->dev, "clk rate = 0\n");
  1867			ret = -EINVAL;
  1868			goto err_clk_disable;
  1869		}
  1870	
  1871		rst = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
  1872		if (rst) {
  1873			if (IS_ERR(rst)) {
  1874				ret = dev_err_probe(&pdev->dev, PTR_ERR(rst),
  1875						    "failed to get reset\n");
  1876				goto err_clk_disable;
  1877			}
  1878	
  1879			reset_control_assert(rst);
  1880			udelay(2);
  1881			reset_control_deassert(rst);
  1882		}
  1883	
  1884		if (spi->cfg->has_fifo)
  1885			spi->fifo_size = spi->cfg->get_fifo_size(spi);
  1886	
  1887		ret = spi->cfg->config(spi);
  1888		if (ret) {
  1889			dev_err(&pdev->dev, "controller configuration failed: %d\n",
  1890				ret);
  1891			goto err_clk_disable;
  1892		}
  1893	
  1894		ctrl->dev.of_node = pdev->dev.of_node;
  1895		ctrl->auto_runtime_pm = true;
  1896		ctrl->bus_num = pdev->id;
  1897		ctrl->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LSB_FIRST |
  1898				  SPI_3WIRE;
  1899		ctrl->bits_per_word_mask = spi->cfg->get_bpw_mask(spi);
  1900		ctrl->max_speed_hz = spi->clk_rate / spi->cfg->baud_rate_div_min;
  1901		ctrl->min_speed_hz = spi->clk_rate / spi->cfg->baud_rate_div_max;
  1902		ctrl->use_gpio_descriptors = true;
  1903		ctrl->prepare_message = stm32_spi_prepare_msg;
  1904		ctrl->transfer_one = stm32_spi_transfer_one;
  1905		ctrl->unprepare_message = stm32_spi_unprepare_msg;
  1906		ctrl->flags = spi->cfg->flags;
  1907		if (STM32_SPI_DEVICE_MODE(spi))
  1908			ctrl->slave_abort = stm32h7_spi_device_abort;
  1909	
  1910		spi->dma_tx = dma_request_chan(spi->dev, "tx");
  1911		if (IS_ERR(spi->dma_tx)) {
  1912			ret = PTR_ERR(spi->dma_tx);
  1913			spi->dma_tx = NULL;
  1914			if (ret == -EPROBE_DEFER)
  1915				goto err_clk_disable;
  1916	
  1917			dev_warn(&pdev->dev, "failed to request tx dma channel\n");
  1918		} else {
  1919			ctrl->dma_tx = spi->dma_tx;
  1920		}
  1921	
  1922		spi->dma_rx = dma_request_chan(spi->dev, "rx");
  1923		if (IS_ERR(spi->dma_rx)) {
  1924			ret = PTR_ERR(spi->dma_rx);
  1925			spi->dma_rx = NULL;
  1926			if (ret == -EPROBE_DEFER)
  1927				goto err_dma_release;
  1928	
  1929			dev_warn(&pdev->dev, "failed to request rx dma channel\n");
  1930		} else {
  1931			ctrl->dma_rx = spi->dma_rx;
  1932		}
  1933	
  1934		if (spi->dma_tx || spi->dma_rx)
  1935			ctrl->can_dma = stm32_spi_can_dma;
  1936	
  1937		pm_runtime_set_autosuspend_delay(&pdev->dev,
  1938						 STM32_SPI_AUTOSUSPEND_DELAY);
  1939		pm_runtime_use_autosuspend(&pdev->dev);
  1940		pm_runtime_set_active(&pdev->dev);
  1941		pm_runtime_get_noresume(&pdev->dev);
  1942		pm_runtime_enable(&pdev->dev);
  1943	
  1944		ret = spi_register_controller(ctrl);
  1945		if (ret) {
  1946			dev_err(&pdev->dev, "spi controller registration failed: %d\n",
  1947				ret);
  1948			goto err_pm_disable;
  1949		}
  1950	
  1951		pm_runtime_mark_last_busy(&pdev->dev);
  1952		pm_runtime_put_autosuspend(&pdev->dev);
  1953	
  1954		dev_info(&pdev->dev, "driver initialized (%s mode)\n",
  1955			 STM32_SPI_MASTER_MODE(spi) ? "master" : "device");
  1956	
  1957		return 0;
  1958	
  1959	err_pm_disable:
  1960		pm_runtime_disable(&pdev->dev);
  1961		pm_runtime_put_noidle(&pdev->dev);
  1962		pm_runtime_set_suspended(&pdev->dev);
  1963		pm_runtime_dont_use_autosuspend(&pdev->dev);
  1964	err_dma_release:
  1965		if (spi->dma_tx)
  1966			dma_release_channel(spi->dma_tx);
  1967		if (spi->dma_rx)
  1968			dma_release_channel(spi->dma_rx);
  1969	err_clk_disable:
  1970		clk_disable_unprepare(spi->clk);
  1971	
  1972		return ret;
  1973	}
  1974	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
