Return-Path: <linux-kernel+bounces-18772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1F18262D1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 04:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568391C21280
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 03:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EA5111A9;
	Sun,  7 Jan 2024 03:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QL7ccs8L"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583C81119A
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 03:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-59641a03f31so631322eaf.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jan 2024 19:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704597904; x=1705202704; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JT8PzdZBJLSbhtU2oJSCK4IIB9jqkagcV3B13A1Ehp4=;
        b=QL7ccs8LZfTJUu2iPhPihFPI/anIk08E6iSd+PNsX9xSYQ/VJFRIDjTYt3Cpj1hsPP
         ZvutDgCuKbQWcUB1mkredk3DgtXhVbuVHOvCxP1w4qLSJ1phxE1GC5aarTd08Z3h0Fax
         LjZLeo0+P3H2Xu59fZIhetQBK07wuTbeTfV6ST0QF/rto1qwXq1DVoFO9LcE4cCsz62e
         zy0NaTlG/eh4q3mTKhlqrVkF+wR46GScSO9C8rZhJqPjd0IFIxp3zC+PeEm1H4uUPdPx
         HmQod8PS/IEIsyP+HdB7/a5/6NtwYJCvqPCNH0YshXQluJIG7mzjvKj0opFdfmjeDHnf
         K09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704597904; x=1705202704;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JT8PzdZBJLSbhtU2oJSCK4IIB9jqkagcV3B13A1Ehp4=;
        b=jze2h/78V75DeMERpwcCLQA9YoNAvutleTACCBzJBdphzIQNvS/v62/1Tp5VMgA6ii
         l3YaTioKIWlT2N0p/k2L0wy89qfICE/CB30lEj8q1c7qfO3WFfYC50bktSqf2FRq2w8O
         5CDxy3Klf6VR0l6z8EtWj+ppItTqOGKRS8wB5yILIYTHZxmMFLXdND1n9y87FpL1ayQf
         nrwwkjfOHeLaZ/istk6TBnsoZfBbyKbAsJHN7yn4abFCaLWYmIIEEANMNwngolGMsQEl
         0xWEUVlZAOxxS3vK+MBGUdrOv5fEyaOADbLmsOtO4lFZtjAejv/via1EIhzttEfGGF+B
         WbIA==
X-Gm-Message-State: AOJu0YxHgYHxaZckx/VogqWMXRJH2qz2ePuTv8ctbDivFHEymYyEdp2j
	aJc3Rdtn5PzE3MeOGroLG0rF5dMHrMrU
X-Google-Smtp-Source: AGHT+IHff8Egcia+tCBq4/ujZo7qI22JNBSI2y6azf6TA1QKj7wiLnydPvISo8qBHWU0i/bPamewsQ==
X-Received: by 2002:a05:6870:9a1d:b0:204:521a:505f with SMTP id fo29-20020a0568709a1d00b00204521a505fmr2577606oab.57.1704597904376;
        Sat, 06 Jan 2024 19:25:04 -0800 (PST)
Received: from thinkpad ([103.197.115.97])
        by smtp.gmail.com with ESMTPSA id t6-20020a63dd06000000b005b9083b81f0sm3608131pgg.36.2024.01.06.19.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 19:25:03 -0800 (PST)
Date: Sun, 7 Jan 2024 08:54:56 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: krzysztof.kozlowski@linaro.org, bhelgaas@google.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
	helgaas@kernel.org, hongxing.zhu@nxp.com, imx@lists.linux.dev,
	kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, robh@kernel.org, s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: Re: [PATCH v7 06/16] PCI: imx6: Simplify ltssm_enable() by using
 ltssm_off and ltssm_mask
Message-ID: <20240107032456.GE3416@thinkpad>
References: <20231227182727.1747435-1-Frank.Li@nxp.com>
 <20231227182727.1747435-7-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231227182727.1747435-7-Frank.Li@nxp.com>

On Wed, Dec 27, 2023 at 01:27:17PM -0500, Frank Li wrote:
> Add drvdata::ltssm_off and drvdata::ltssm_mask to simple
> imx6_pcie_ltssm_enable(disable)() logic.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> 
> Notes:
>     Change from v1 to v3
>     - none
> 
>  drivers/pci/controller/dwc/pci-imx6.c | 37 ++++++++++++---------------
>  1 file changed, 16 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 332c392f8e5bc..588bfb616260e 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -75,6 +75,8 @@ struct imx6_pcie_drvdata {
>  	int dbi_length;
>  	const char *gpr;
>  	const char *clk_names[IMX6_PCIE_MAX_CLKS];
> +	const u32 ltssm_off;
> +	const u32 ltssm_mask;
>  };
>  
>  struct imx6_pcie {
> @@ -775,18 +777,11 @@ static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
>  static void imx6_pcie_ltssm_enable(struct device *dev)
>  {
>  	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> +	const struct imx6_pcie_drvdata *drvdata = imx6_pcie->drvdata;
>  
> -	switch (imx6_pcie->drvdata->variant) {
> -	case IMX6Q:
> -	case IMX6SX:
> -	case IMX6QP:
> -		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				   IMX6Q_GPR12_PCIE_CTL_2,
> -				   IMX6Q_GPR12_PCIE_CTL_2);
> -		break;
> -	default:
> -		break;
> -	}
> +	if (drvdata->ltssm_mask)
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, drvdata->ltssm_off, drvdata->ltssm_mask,
> +				   drvdata->ltssm_mask);
>  
>  	reset_control_deassert(imx6_pcie->apps_reset);
>  }
> @@ -794,17 +789,11 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
>  static void imx6_pcie_ltssm_disable(struct device *dev)
>  {
>  	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> +	const struct imx6_pcie_drvdata *drvdata = imx6_pcie->drvdata;
>  
> -	switch (imx6_pcie->drvdata->variant) {
> -	case IMX6Q:
> -	case IMX6SX:
> -	case IMX6QP:
> -		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				   IMX6Q_GPR12_PCIE_CTL_2, 0);
> -		break;
> -	default:
> -		break;
> -	}
> +	if (drvdata->ltssm_mask)
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, drvdata->ltssm_off,
> +				   drvdata->ltssm_mask, 0);
>  
>  	reset_control_assert(imx6_pcie->apps_reset);
>  }
> @@ -1385,6 +1374,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  		.dbi_length = 0x200,
>  		.gpr = "fsl,imx6q-iomuxc-gpr",
>  		.clk_names = {"pcie_bus", "pcie", "pcie_phy"},
> +		.ltssm_off = IOMUXC_GPR12,
> +		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
>  	},
>  	[IMX6SX] = {
>  		.variant = IMX6SX,
> @@ -1393,6 +1384,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.gpr = "fsl,imx6q-iomuxc-gpr",
>  		.clk_names = {"pcie_bus", "pcie", "pcie_phy", "pcie_inbound_axi"},
> +		.ltssm_off = IOMUXC_GPR12,
> +		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
>  	},
>  	[IMX6QP] = {
>  		.variant = IMX6QP,
> @@ -1402,6 +1395,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  		.dbi_length = 0x200,
>  		.gpr = "fsl,imx6q-iomuxc-gpr",
>  		.clk_names = {"pcie_bus", "pcie", "pcie_phy"},
> +		.ltssm_off = IOMUXC_GPR12,
> +		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
>  	},
>  	[IMX7D] = {
>  		.variant = IMX7D,
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

