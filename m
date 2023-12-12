Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8B680F386
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376274AbjLLQtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbjLLQtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:49:19 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CCFDB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:49:24 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6d0985c70ffso1330824b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702399764; x=1703004564; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O3Qb4Pmctf3QLFWZxDCGFwLHLw9E0QvAVnQNcESZf+I=;
        b=NMCuFxIs6oxdzM3LbvRHK5frKK+Sy0i8Vh1Elp3NgeFdkWcsW4ZpzIfft5uoe6m8Kt
         j2+TLP3jPVKizeJwy9ix3HmdsJ25cOz7e1JrkaVmHst6kuIrsEc0FlAzcLZWv+tRl8EA
         FRM9lAq9LZ23FLMpkop9CABpft4AIH2yCpIcBPhFQTft5Q/Y3odnLeUDbnKxOLnfgtz2
         PrmUesTtr64kKQFL+MgG2ZCyKNwihTWsLJR3K4wC1LSoDIzknD1Msz8dErMjzeTqUEYl
         nsGFIbCD6Z2p9t7q9Fexn9SfhaaT3WQTtUjxzGpy4V6wSAc8Vn3YHQ66b4IWxcg0BuV1
         E99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702399764; x=1703004564;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O3Qb4Pmctf3QLFWZxDCGFwLHLw9E0QvAVnQNcESZf+I=;
        b=QZDOdPOt64C8erWZSCgfCY+vKv23EU93+E0oQgKnL7kFXt2Dx5wNlF1ycI5b4KMPxv
         CimyQGAhwFaX3ykz0viR/k4aqDlo5SSip1QlWheieL5D4qkMPvsgnBQt7oRNMvBVuLpw
         aKZDLg+lL1l6D5FGAPtaxZUK8SMHWtDTMTKdMdZp2oMlG0RX3WvU9fFP7T+4q4hd/y6s
         h7JsYTsa2hQ+RWkJN4DG5RV+QGCM0VL1WcG0tMA7jJg28u6vqT9SqpwqLIUG7681A21q
         dZeo6wbTTkJvoG6TBlay2AyOv9bqUbC6KX+2nDAVTr+l78LlJ6qPKKVzEYs+KtI+AFMX
         ocug==
X-Gm-Message-State: AOJu0Yx5Ocsa8g3saRNdPJPPvc87l3UrsM2NMmR2sT9+wHQzC1Wij9wB
        hsgNKaBT/lMSOSi1zI2trUMQ
X-Google-Smtp-Source: AGHT+IEdRCICFtznyHHkBUNYDtZL2BWvbWNge5n8xa4XWLlDEc4bBXuXkjMOrYe3szp98CDGiy/H6w==
X-Received: by 2002:a05:6a21:3281:b0:18b:985e:8035 with SMTP id yt1-20020a056a21328100b0018b985e8035mr3756929pzb.12.1702399763615;
        Tue, 12 Dec 2023 08:49:23 -0800 (PST)
Received: from thinkpad ([117.202.189.222])
        by smtp.gmail.com with ESMTPSA id v29-20020a63481d000000b005c19c586cb7sm8368570pga.33.2023.12.12.08.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 08:49:22 -0800 (PST)
Date:   Tue, 12 Dec 2023 22:19:13 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     bhelgaas@google.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, festevam@gmail.com, helgaas@kernel.org,
        hongxing.zhu@nxp.com, imx@lists.linux.dev, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
        l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v3 01/13] PCI: imx6: Simplify clock handling by using
 HAS_CLK_* bitmask
Message-ID: <20231212164913.GA21240@thinkpad>
References: <20231211215842.134823-1-Frank.Li@nxp.com>
 <20231211215842.134823-2-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231211215842.134823-2-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 04:58:30PM -0500, Frank Li wrote:
> Refactors the clock handling logic in the imx6 PCI driver by adding
> HAS_CLK_* bitmask define for drvdata::flags . Simplifies the code and makes
> it more maintainable, as future additions of SOC support will only require
> straightforward changes. The drvdata::flags and a bitmask ensures a cleaner
> and more scalable switch-case structure for handling clocks.
> 

Is there any necessity to validate each clock in the driver? I mean, can't you
just rely on devicetree to provide enough clocks for the functioning of the PCIe
controller?

If you can rely on devicetree (everyone should in an ideal world), then you can
just use devm_clk_bulk_get_all() to get all available clocks for the SoC and
just enable/disable whatever is available.

This will greatly simplify the code.

Only downside of this approach is, if the devicetree is not supplying enough
clocks, then it will be difficult to find why PCIe is not working. But this also
means that the devicetree is screwed.

- Mani

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Change from v1 to v3
>     - none
> 
>  drivers/pci/controller/dwc/pci-imx6.c | 84 +++++++++++++--------------
>  1 file changed, 42 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 74703362aeec7..8a9b527934f80 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -60,6 +60,10 @@ enum imx6_pcie_variants {
>  #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
>  #define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
>  #define IMX6_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
> +#define IMX6_PCIE_FLAG_HAS_CLK_INBOUND_AXI	BIT(3)
> +#define IMX6_PCIE_FLAG_HAS_CLK_AUX		BIT(4)
> +
> +#define imx6_check_flag(pci, val)	(pci->drvdata->flags & val)
>  
>  struct imx6_pcie_drvdata {
>  	enum imx6_pcie_variants variant;
> @@ -550,19 +554,23 @@ static int imx6_pcie_attach_pd(struct device *dev)
>  
>  static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>  {
> -	struct dw_pcie *pci = imx6_pcie->pci;
> -	struct device *dev = pci->dev;
>  	unsigned int offset;
>  	int ret = 0;
>  
> -	switch (imx6_pcie->drvdata->variant) {
> -	case IMX6SX:
> +	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_CLK_INBOUND_AXI)) {
>  		ret = clk_prepare_enable(imx6_pcie->pcie_inbound_axi);
> -		if (ret) {
> -			dev_err(dev, "unable to enable pcie_axi clock\n");
> -			break;
> -		}
> +		if (ret)
> +			return ret;
> +	}
>  
> +	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_CLK_AUX)) {
> +		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	switch (imx6_pcie->drvdata->variant) {
> +	case IMX6SX:
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>  				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
>  		break;
> @@ -589,12 +597,6 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>  	case IMX8MQ_EP:
>  	case IMX8MP:
>  	case IMX8MP_EP:
> -		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
> -		if (ret) {
> -			dev_err(dev, "unable to enable pcie_aux clock\n");
> -			break;
> -		}
> -
>  		offset = imx6_pcie_grp_offset(imx6_pcie);
>  		/*
>  		 * Set the over ride low and enabled
> @@ -614,10 +616,13 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>  
>  static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
>  {
> -	switch (imx6_pcie->drvdata->variant) {
> -	case IMX6SX:
> +	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_CLK_INBOUND_AXI))
>  		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
> -		break;
> +
> +	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_CLK_AUX))
> +		clk_disable_unprepare(imx6_pcie->pcie_aux);
> +
> +	switch (imx6_pcie->drvdata->variant) {
>  	case IMX6QP:
>  	case IMX6Q:
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> @@ -631,14 +636,6 @@ static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
>  				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
>  				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
>  		break;
> -	case IMX8MM:
> -	case IMX8MM_EP:
> -	case IMX8MQ:
> -	case IMX8MQ_EP:
> -	case IMX8MP:
> -	case IMX8MP_EP:
> -		clk_disable_unprepare(imx6_pcie->pcie_aux);
> -		break;
>  	default:
>  		break;
>  	}
> @@ -1316,21 +1313,21 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie),
>  				     "pcie clock source missing or invalid\n");
>  
> -	switch (imx6_pcie->drvdata->variant) {
> -	case IMX6SX:
> -		imx6_pcie->pcie_inbound_axi = devm_clk_get(dev,
> -							   "pcie_inbound_axi");
> +	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_CLK_INBOUND_AXI)) {
> +		imx6_pcie->pcie_inbound_axi = devm_clk_get(dev, "pcie_inbound_axi");
>  		if (IS_ERR(imx6_pcie->pcie_inbound_axi))
> -			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_inbound_axi),
> -					     "pcie_inbound_axi clock missing or invalid\n");
> -		break;
> -	case IMX8MQ:
> -	case IMX8MQ_EP:
> +			dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_inbound_axi),
> +				      "pcie_inbound_axi clock missing or invalid\n");
> +	}
> +
> +	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_CLK_AUX)) {
>  		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
>  		if (IS_ERR(imx6_pcie->pcie_aux))
>  			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
>  					     "pcie_aux clock source missing or invalid\n");
> -		fallthrough;
> +	}
> +
> +	switch (imx6_pcie->drvdata->variant) {
>  	case IMX7D:
>  		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
>  			imx6_pcie->controller_id = 1;
> @@ -1353,10 +1350,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  	case IMX8MM_EP:
>  	case IMX8MP:
>  	case IMX8MP_EP:
> -		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
> -		if (IS_ERR(imx6_pcie->pcie_aux))
> -			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
> -					     "pcie_aux clock source missing or invalid\n");
>  		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev,
>  									 "apps");
>  		if (IS_ERR(imx6_pcie->apps_reset))
> @@ -1482,7 +1475,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  		.variant = IMX6SX,
>  		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
>  			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE |
> -			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> +			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
> +			 IMX6_PCIE_FLAG_HAS_CLK_INBOUND_AXI,
>  		.gpr = "fsl,imx6q-iomuxc-gpr",
>  	},
>  	[IMX6QP] = {
> @@ -1500,30 +1494,36 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  	},
>  	[IMX8MQ] = {
>  		.variant = IMX8MQ,
> +		.flags = IMX6_PCIE_FLAG_HAS_CLK_AUX,
>  		.gpr = "fsl,imx8mq-iomuxc-gpr",
>  	},
>  	[IMX8MM] = {
>  		.variant = IMX8MM,
> -		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> +		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
> +			 IMX6_PCIE_FLAG_HAS_CLK_AUX,
>  		.gpr = "fsl,imx8mm-iomuxc-gpr",
>  	},
>  	[IMX8MP] = {
>  		.variant = IMX8MP,
> -		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> +		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
> +			 IMX6_PCIE_FLAG_HAS_CLK_AUX,
>  		.gpr = "fsl,imx8mp-iomuxc-gpr",
>  	},
>  	[IMX8MQ_EP] = {
>  		.variant = IMX8MQ_EP,
> +		.flags = IMX6_PCIE_FLAG_HAS_CLK_AUX,
>  		.mode = DW_PCIE_EP_TYPE,
>  		.gpr = "fsl,imx8mq-iomuxc-gpr",
>  	},
>  	[IMX8MM_EP] = {
>  		.variant = IMX8MM_EP,
> +		.flags = IMX6_PCIE_FLAG_HAS_CLK_AUX,
>  		.mode = DW_PCIE_EP_TYPE,
>  		.gpr = "fsl,imx8mm-iomuxc-gpr",
>  	},
>  	[IMX8MP_EP] = {
>  		.variant = IMX8MP_EP,
> +		.flags = IMX6_PCIE_FLAG_HAS_CLK_AUX,
>  		.mode = DW_PCIE_EP_TYPE,
>  		.gpr = "fsl,imx8mp-iomuxc-gpr",
>  	},
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
