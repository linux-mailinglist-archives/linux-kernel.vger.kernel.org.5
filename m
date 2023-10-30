Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC03C7DB48C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 08:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjJ3Hom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 03:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjJ3Hok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 03:44:40 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7254DC2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 00:44:33 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5401bab7525so6929574a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 00:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698651871; x=1699256671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z8VaN6a4ya0DXMWsYW2kM9ryYhNEgaYXgGcUUpaZgDs=;
        b=wXqdv8y/NS/GEzbvuPfBGSRvi5JW/vtApLxHc3McAb1XlRF5W5x2fZE4aFZYgT/ZPa
         Af8xx6zyQs/ppcnjXnv4lQzqM10Pn4URH+Dsz8rBA7UNztTMu7LVvTLpXxtQz+r4QsEt
         gtFk70YAHZNkuOk1UXhD84L3fNhBR/ZAUSvuFHZWZgY6upHhvyubJ035y2f48MBhxXIt
         wwUD4YF+QoJldaKnZ38VH0hKK7uUIQz6NjYFrqpkPeOD1sirfCTpBsOpQk6Do++ehc4L
         ZftcRPP9WU3lGetfMouZ9RlUf+fY2/2xCrJEUs2kXes7y2HtApPJlVSwHe1vbiZwyteO
         ya3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698651871; x=1699256671;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8VaN6a4ya0DXMWsYW2kM9ryYhNEgaYXgGcUUpaZgDs=;
        b=qTQujdjOZPY7fx62HRFrJUbqQFeLoZwY4uVjqAtxPcOcCTUMlNDneMpTKywnA1ImpE
         3cTaN/9eEN7iJT3mCXygJPknC0mYjSHawnMtrSx8Bn2FgY5zed8usfqt7kE2XOzOfmaO
         bm6vqlbnIf09OHLPobQrAvJF99RN662NUEtP2hNcM+gPmuBsaPrKABTdWgk0dBKqRxnT
         dzfLanDvf3LCdAviHv+JCf5BHWHWjeatwPCZMlOMVAdjBM6fA1KkizobX7d7S8PpyTED
         /7JB1x4RwpgT++jpeo0bN9WiLo5Xmi7a47sjTx+RWIYSU5L5kRVVH8h1oA5fTsV/d6rV
         GHkQ==
X-Gm-Message-State: AOJu0YwaM+nBoxA/h/S+c1hx67EbBzmdzqQ6SE88eGddO+gOSjenVaxR
        gzYeUfaV/w/ZA6moAjI9VrE7lA==
X-Google-Smtp-Source: AGHT+IGmCG5g33B0DCnziedQFTBTigoiF1f7ySYkvgSgVXqPvNHy0HeHqM9KAxB8ql5ppreM1CyXZg==
X-Received: by 2002:a50:d593:0:b0:53e:3b8f:8ce1 with SMTP id v19-20020a50d593000000b0053e3b8f8ce1mr7854816edi.23.1698651871168;
        Mon, 30 Oct 2023 00:44:31 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id z22-20020a50cd16000000b005402a0c9784sm5760741edi.40.2023.10.30.00.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 00:44:30 -0700 (PDT)
Message-ID: <ebbbed14-ad93-4981-96f9-8cc344b63448@linaro.org>
Date:   Mon, 30 Oct 2023 08:44:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4][3/4] mmc: Add dw mobile mmc cmdq rtk driver
Content-Language: en-US
To:     Jyan Chou <jyanchou@realtek.com>, ulf.hansson@linaro.org,
        adrian.hunter@intel.com, jh80.chung@samsung.com,
        riteshh@codeaurora.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        asutoshd@codeaurora.org, p.zabel@pengutronix.de
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        briannorris@chromium.org, doug@schmorgal.com,
        tonyhuang.sunplus@gmail.com, abel.vesa@linaro.org,
        william.qiu@starfivetech.com
References: <20231030062749.2840-1-jyanchou@realtek.com>
 <20231030062749.2840-4-jyanchou@realtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231030062749.2840-4-jyanchou@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2023 07:27, Jyan Chou wrote:
> Add Realtek mmc driver to make good use Synopsys
> DesignWare mmc cmdq host driver.
> 
> Signed-off-by: Jyan Chou <jyanchou@realtek.com>
> 
> ---
> v3 -> v4:
> - Modify dma setting's code to fix linux coding style.

And coding style of all other parts were ignored. You must fix it
everywhere in your code.

...

> +
> +static void dw_mci_rtk_init_card(struct mmc_host *host, struct mmc_card *card)
> +{
> +	/* In Realtek Platform, we need to attach eMMC card onto mmc host
> +	 * during eMMC initialization because of the following reason:
> +	 * When system cannot run the hs400, we need to down speed to hs200
> +	 * and call mmc_hw_reset and modify the mmc card attribute through mmc host.
> +	 * At this moment, system will show errors if host->card = NULL.
> +	 */
> +	host->card = card;
> +}
> +
> +static int dw_mci_rtk_parse_dt(struct dw_mci *host)
> +{
> +	struct dw_mci_rtkemmc_host *priv;
> +	const u32 *prop;
> +	int size;
> +
> +	priv = devm_kzalloc(host->dev, sizeof(struct dw_mci_rtkemmc_host), GFP_KERNEL);

sizeof(*)

> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->pinctrl = devm_pinctrl_get(host->dev);
> +	if (IS_ERR(priv->pinctrl))
> +		dev_dbg(host->dev, "no pinctrl\n");
> +
> +	priv->pins_default = pinctrl_lookup_state(priv->pinctrl,
> +						  PINCTRL_STATE_DEFAULT);
> +	if (IS_ERR(priv->pins_default))
> +		dev_warn(host->dev, "could not get default state\n");
> +

So this is required by the driver but not by the bindings.

> +	priv->pins_sdr50 = pinctrl_lookup_state(priv->pinctrl,
> +						"sdr50");
> +	if (IS_ERR(priv->pins_sdr50))
> +		dev_warn(host->dev, "could not get sdr50 state\n");
> +
> +	priv->pins_hs200 = pinctrl_lookup_state(priv->pinctrl,
> +						"hs200");
> +	if (IS_ERR(priv->pins_hs200))
> +		dev_warn(host->dev, "could not get hs200 state\n");
> +
> +	priv->pins_hs400 = pinctrl_lookup_state(priv->pinctrl,
> +						"hs400");
> +	if (IS_ERR(priv->pins_hs400))
> +		dev_warn(host->dev, "could not get hs400 state\n");
> +
> +	priv->pins_tune0 = pinctrl_lookup_state(priv->pinctrl,
> +						"tune0");
> +	if (IS_ERR(priv->pins_tune0))
> +		dev_warn(host->dev, "could not get tune0 state\n");
> +
> +	priv->pins_tune1 = pinctrl_lookup_state(priv->pinctrl,
> +						"tune1");
> +	if (IS_ERR(priv->pins_tune1))
> +		dev_warn(host->dev, "could not get tune1 state\n");
> +
> +	priv->pins_tune2 = pinctrl_lookup_state(priv->pinctrl,
> +						"tune2");
> +	if (IS_ERR(priv->pins_tune2))
> +		dev_warn(host->dev, "could not get tune2 state\n");
> +
> +	priv->pins_tune3 = pinctrl_lookup_state(priv->pinctrl,
> +						"tune3");
> +	if (IS_ERR(priv->pins_tune3))
> +		dev_warn(host->dev, "could not get tune3 state\n");
> +
> +	priv->pins_tune4 = pinctrl_lookup_state(priv->pinctrl,
> +						"tune4");
> +
> +	if (IS_ERR(priv->pins_tune4))
> +		dev_warn(host->dev, "could not get tune4 state\n");
> +
> +	priv->vp0 = devm_clk_get(host->dev, "vp0");
> +	if (IS_ERR(priv->vp0))
> +		dev_err(host->dev, "could not get vp0 clk\n");
> +
> +	priv->vp1 = devm_clk_get(host->dev, "vp1");
> +	if (IS_ERR(priv->vp1))
> +		dev_err(host->dev, "could not get vp1 clk\n");

dev_err_probe. Everywhere where applicable.

> +
> +	priv->emmc_mode = 0;
> +	prop = of_get_property(host->dev->of_node, "speed-step", &size);
> +	if (prop) {
> +		priv->emmc_mode = of_read_number(prop, 1);
> +		dev_info(host->dev, "emmc mode : %d\n", priv->emmc_mode);

Drop

> +	} else {
> +		dev_info(host->dev, "use default emmc sdr50 mode !\n");

Drop, why is this a problem?

> +	}
> +
> +	priv->is_cqe = 0;
> +	prop = of_get_property(host->dev->of_node, "cqe", &size);
> +	if (prop) {
> +		priv->is_cqe = of_read_number(prop, 1);
> +		dev_info(host->dev, "cmdq mode : %d\n", priv->is_cqe);

Drop


> +	} else {
> +		dev_info(host->dev, "use default eMMC legacy mode !\n");

Drop


> +	}
> +
> +	prop = of_get_property(host->dev->of_node, "rdq-ctrl", &size);
> +	if (prop) {
> +		priv->rdq_ctrl = of_read_number(prop, 1);
> +		dev_info(host->dev, "get rdq-ctrl : %u\n", priv->rdq_ctrl);

Drop


> +	} else {
> +		priv->rdq_ctrl = 0;
> +		dev_info(host->dev, "no dqs_dly_tape switch node, use default 0x0 !!\n");

Drop

> +	}
> +
> +	priv->m2tmx = syscon_regmap_lookup_by_phandle(host->dev->of_node, "realtek,m2tmx");
> +	if (IS_ERR_OR_NULL(priv->m2tmx))
> +		dev_err(host->dev, "can not get m2mtx node.\n");
> +
> +	host->priv = priv;
> +
> +	return 0;
> +}
> +
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
> +	host->irq_flags = IRQF_SHARED;
> +
> +	mcq_writel(host, CP, 0x0);
> +
> +	/*Enable L4 gated*/

Read Linux coding style. Multiple times if needed.

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
> +	mcq_writel(host, AHB, 0);
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
> +	ret = dw_mci_cqe_runtime_resume(dev);
> +
> +	return ret;
> +}
> +#else
> +static int dw_mci_rtk_suspend(struct device *dev)
> +{
> +	dev_info(dev, "User should enable CONFIG_PM kernel config\n");

NAK, come on. I asked to drop it. Did you just ignore the feedback? Yep...

> +
> +	return 0;
> +}
> +
> +static int dw_mci_rtk_resume(struct device *dev)
> +{
> +	dev_info(dev, "User should enable CONFIG_PM kernel config\n");

NAK

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

NAK

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
> +	{ .compatible = "realtek,rtd1325-dw-cqe-emmc",
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

sizeof(*)

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

Use helper for this.

Open existing, recent drivers and use the them as template or some set
of patterns. Sorry, but upstreaming your vendor code will be painful,
because you started from some old, buggier version.

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


Best regards,
Krzysztof

