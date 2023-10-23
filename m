Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFFD7D2C2A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjJWIEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjJWIEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:04:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37102C4;
        Mon, 23 Oct 2023 01:04:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B721C433C9;
        Mon, 23 Oct 2023 08:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698048258;
        bh=e6WSVmogUY5zf8QKqZKYodzoMfi32E6WUjWErOJssmM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tpONxKJ0R7eq92BoM0DlL9yCH7sJfHqrHCurIplekJlgAbOwotJjtRcJMKS/eXeOF
         KjGZE2YA1eO3hBuIAIHHiyLba14upJI2YrHum+WPPbsv9LMdTU8Khfu39HLlkhpRWd
         N5QJWPs2gomZPNbxRky8m+/sVTV2OUTACmK1xTgbnXHAduMds8GeEaU44U5yeFD8GU
         qMhYv/QkDD1to+9+hJGBKsMA8NaxbhlpiZdHhsZygINgjtFmd9Slb+tQGP5aD7/x8w
         bygb9picdSGCuIhu8pQYXAmFJbLN8QAh3oqF14WswOgmXz+etrOFzJgoriKr7++PAd
         4yWYDGjsTzsSw==
Message-ID: <5bc8fd15-9ae7-449d-9625-6e8c87876b06@kernel.org>
Date:   Mon, 23 Oct 2023 10:04:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3][3/4] mmc: Add dw mobile mmc cmdq rtk driver
Content-Language: en-US
To:     Jyan Chou <jyanchou@realtek.com>, adrian.hunter@intel.com,
        jh80.chung@samsung.com, ulf.hansson@linaro.org
Cc:     riteshh@codeaurora.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        asutoshd@codeaurora.org, p.zabel@pengutronix.de,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        briannorris@chromium.org, doug@schmorgal.com,
        tonyhuang.sunplus@gmail.com, abel.vesa@linaro.org,
        william.qiu@starfivetech.com
References: <20231020034921.1179-1-jyanchou@realtek.com>
 <20231020034921.1179-4-jyanchou@realtek.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20231020034921.1179-4-jyanchou@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/2023 05:49, Jyan Chou wrote:
> Add Realtek mmc driver to make good use Synopsys
> DesignWare mmc cmdq host driver.
> 
> Signed-off-by: Jyan Chou <jyanchou@realtek.com>
> 
> ---

> +static int dw_mci_rtk_init(struct dw_mci *host)
> +{
> +	struct dw_mci_rtkemmc_host *priv = host->priv;
> +
> +	host->pdata->caps2 = MMC_CAP2_NO_SDIO | MMC_CAP2_NO_SD;
> +
> +	if (priv->emmc_mode >= 2)
> +		host->pdata->caps2 |= MMC_CAP2_HS200_1_8V_SDR;
> +	if (priv->emmc_mode >= 3) {
> +		host->pdata->caps |= MMC_CAP_1_8V_DDR;
> +		host->pdata->caps2 |= MMC_CAP2_HS400_1_8V;
> +	}
> +
> +	if (priv->is_cqe > 0)
> +		host->pdata->caps2 |= (MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD);
> +
> +	/*In Realtek Platform, only using 32bit DMA*/

Use Linux coding style. This driver looks like one for staging, not
ready for submission. :/

> +	host->dma_64bit_address = 0;
> +
> +	/*In Realtek Platform, do not use PIO mode by default*/
> +	host->use_dma = TRANS_MODE_DMA;
> +
> +	host->irq_flags = IRQF_SHARED;
> +
> +	mcq_writel(host, CP, 0x0);
> +
> +	/*Enable L4 gated*/
> +	mcq_writel(host, OTHER1, mcq_readl(host, OTHER1) &
> +		~(SDMMC_L4_GATED_DIS | SDMMC_L4_GATED_DIS1));
> +
> +	mcq_writel(host, OTHER1, mcq_readl(host, OTHER1) &
> +		   (~(SDMMC_DQS_CTRL_GATE_DIS | SDMMC_DBUS_MAS_GATING_DIS)));
> +
> +	/*Set the eMMC wrapper little Endian*/
> +	mcq_writel(host, AHB, mcq_readl(host, AHB) | SDMMC_AHB_BIG);
> +
> +	mcq_writel(host, OTHER1,
> +		   mcq_readl(host, OTHER1) | SDMMC_STARK_CARD_STOP_ENABLE);
> +
> +	/*set eMMC instead of nand*/
> +	regmap_update_bits_base(priv->m2tmx, SDMMC_NAND_DMA_SEL,
> +				SDMMC_SRAM_DMA_SEL, SDMMC_SRAM_DMA_SEL, NULL, false, true);
> +
> +	/*Set the clk initial phase*/
> +	dw_mci_rtk_phase_tuning(host, 0, 0);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int dw_mci_rtk_suspend(struct device *dev)
> +{
> +	struct dw_mci *host = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	ret = dw_mci_cqe_runtime_suspend(dev);
> +
> +	mcq_writel(host, AHB, 0);
> +	dev_info(dev, "AHB=0x%x, dw_mci_cqe_suspend ret=%d\n",
> +		 mcq_readl(host, AHB), ret);

Drop useless success/function entry/exit messages..

> +
> +	return ret;
> +}
> +
> +static int dw_mci_rtk_resume(struct device *dev)
> +{
> +	struct dw_mci *host = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	mcq_writel(host, AHB, mcq_readl(host, AHB) | SDMMC_AHB_BIG);
> +
> +	ret = dw_mci_cqe_runtime_resume(dev);
> +
> +	dev_info(dev, "AHB=0x%x, dw_mci_cqe_resume ret=%d\n",
> +		 mcq_readl(host, AHB), ret);

Drop useless success/function entry/exit messages..

> +
> +	return ret;
> +}
> +#else
> +static int dw_mci_rtk_suspend(struct device *dev)
> +{
> +	dev_err(dev, "User should enable CONFIG_PM kernel config\n");

Why? This is not an error. If it were, then it should be build stage error.

> +
> +	return 0;
> +}
> +
> +static int dw_mci_rtk_resume(struct device *dev)
> +{
> +	dev_err(dev, "User should enable CONFIG_PM kernel config\n");
> +
> +	return 0;
> +}
> +#endif /*CONFIG_PM*/
> +static const struct dev_pm_ops rtk_dev_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(dw_mci_rtk_suspend,
> +				dw_mci_rtk_resume)
> +	SET_RUNTIME_PM_OPS(dw_mci_cqe_runtime_suspend,
> +			   dw_mci_cqe_runtime_resume,
> +			   NULL)
> +};
> +
> +static void dw_mci_rtk_shutdown(struct platform_device *pdev)
> +{
> +	dev_info(&pdev->dev, "[eMMC] Shutdown\n");
> +	dw_mci_cqe_runtime_resume(&pdev->dev);
> +}
> +
> +static unsigned long dw_mci_rtk_dwmmc_caps[1] = {
> +	MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA |
> +	MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED |
> +	MMC_CAP_NONREMOVABLE | MMC_CAP_CMD23,
> +};
> +
> +static const struct dw_mci_drv_data rtk_drv_data = {
> +	.caps                   = dw_mci_rtk_dwmmc_caps,
> +	.num_caps               = ARRAY_SIZE(dw_mci_rtk_dwmmc_caps),
> +	.set_ios                = dw_mci_rtk_set_ios,
> +	.execute_tuning         = dw_mci_rtk_execute_tuning,
> +	.parse_dt               = dw_mci_rtk_parse_dt,
> +	.init                   = dw_mci_rtk_init,
> +	.prepare_hs400_tuning	= dw_mci_rtk_prepare_hs400_tuning,
> +	.hs400_complete         = dw_mci_rtk_hs400_complete,
> +	.init_card		= dw_mci_rtk_init_card,
> +};
> +
> +static const struct of_device_id dw_mci_rtk_match[] = {
> +	{ .compatible = "realtek,rtd-dw-cqe-emmc",
> +		.data = &rtk_drv_data },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, dw_mci_rtk_match);
> +
> +int dw_mci_cqe_pltfm_register(struct platform_device *pdev,
> +			      const struct dw_mci_drv_data *drv_data)
> +{
> +	struct dw_mci *host;
> +	struct resource	*regs;
> +
> +	host = devm_kzalloc(&pdev->dev, sizeof(struct dw_mci), GFP_KERNEL);
> +	if (!host)
> +		return -ENOMEM;
> +
> +	host->irq = platform_get_irq(pdev, 0);
> +	if (host->irq < 0)
> +		return host->irq;
> +
> +	host->drv_data = drv_data;
> +	host->pdev = pdev;
> +	host->dev = &pdev->dev;
> +	host->irq_flags = 0;
> +	host->pdata = pdev->dev.platform_data;
> +
> +	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	host->regs = devm_ioremap_resource(&pdev->dev, regs);
> +	if (IS_ERR(host->regs))
> +		return PTR_ERR(host->regs);
> +
> +	/* Get registers' physical base address */
> +	host->phy_regs = regs->start;
> +
> +	platform_set_drvdata(pdev, host);
> +
> +	return dw_mci_cqe_probe(host);
> +}
> +
> +static int dw_mci_rtk_probe(struct platform_device *pdev)
> +{
> +	const struct dw_mci_drv_data *drv_data;
> +	const struct of_device_id *match;
> +
> +	if (!pdev->dev.of_node)
> +		return -ENODEV;
> +
> +	match = of_match_node(dw_mci_rtk_match, pdev->dev.of_node);
> +	drv_data = match->data;
> +
> +	return dw_mci_cqe_pltfm_register(pdev, drv_data);
> +}
> +
> +int dw_mci_rtk_remove(struct platform_device *pdev)
> +{
> +	struct dw_mci *host = platform_get_drvdata(pdev);
> +
> +	dw_mci_cqe_remove(host);
> +	return 0;
> +}
> +
> +static struct platform_driver dw_mci_rtk_pltfm_driver = {
> +	.probe          = dw_mci_rtk_probe,
> +	.remove         = dw_mci_rtk_remove,
> +	.driver         = {
> +		.name           = "dwmmc_cqe_rtk",
> +		.of_match_table = dw_mci_rtk_match,
> +		.pm             = &rtk_dev_pm_ops,
> +	},
> +	.shutdown   = dw_mci_rtk_shutdown,
> +};
> +
> +module_platform_driver(dw_mci_rtk_pltfm_driver);
> +
> +MODULE_AUTHOR("<jyanchou@realtek.com>");
> +MODULE_DESCRIPTION(" Specific Driver Extension");
> +MODULE_ALIAS("platform:dwmmc_cqe_rtk");

You should not need MODULE_ALIAS() in normal cases. If you need it,
usually it means your device ID table is wrong.


Best regards,
Krzysztof

