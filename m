Return-Path: <linux-kernel+bounces-2694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B24B8160A8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B982128173B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B10B4642B;
	Sun, 17 Dec 2023 17:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bb29152h"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DE545BF2
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d3ab37d0d1so283195ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 09:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702832827; x=1703437627; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/K03hCZQCPV3Olg5sBkXZ+1FaJknZTPPokPGS7pirfk=;
        b=bb29152hWtc48LdPz4HZM8D1CtyuJ/6ne23dxAFZaM/54eCfzm3043kyGTOiJy3cFv
         RhexgBvV3g96hJQGy0yaSFK1An0VDDHoCpCgUDnoQ6Oj5ZDXg6ywWqEUeZf1n+4GFCbc
         RiVE9yMcxxpn1U4k5W1TAfXrj3wCT9uEJosraMOFq6Gztwq1mk6ClpqgfjkGlGekFNtr
         oWqco0FGxwlvaIT7H0e+TPTnc7RjWbFe5moslWEGMFLIc8kxqHQ2DmmO+CYKbp3DxzuQ
         btdXBmjgGwdAn7fFtaL2PUqj7O3tk3LXyOzFQGUtvE0I/nvjUc/MKjXH3UyvgYTivb+s
         bC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702832827; x=1703437627;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/K03hCZQCPV3Olg5sBkXZ+1FaJknZTPPokPGS7pirfk=;
        b=h5HWO2PIfvEYmcsZLcFgaZbUUNu1SQrM1vqFkPD74+mOP0powJRBpsDkbeE63FVHH9
         ACMR20v/+NvKnRgojGJURSmQI2ehIrX1f2wJXr10x4H9miNn0UQec+xNV4J4aVofvYI4
         1wyxYvAPG0bBzRB6qeO0KwrIK+3u5nh4x/Y8Q0B56F8S2w8pqOvSRScSdDReUK4feSJO
         lUxwDho4KWtmuQpy3HTE8sgi4yD1K68toHXAx53zlDDBejxu56fBgJygOGaZiaxTODFB
         R1IuJlT9UwIcct2bSGwZuJR4tb0btbpHJ8CB+JcVmzoizJgMovyvhCrf/4NZZuf2DrSz
         mzqw==
X-Gm-Message-State: AOJu0YxG+sTZknxAhXJhHr9tahSVqoNQb6qZsniBFlpFTOtRdJ2Qs+uQ
	0S7OIlSIlZ+Ip2/EmaCGy7FJ
X-Google-Smtp-Source: AGHT+IF87cHE/NtQnAKvY7hzR4Yb1+nieura/Ja8Di49a65zvK6JCuAZ11jhxfgrEwKDGnHgmwq5ug==
X-Received: by 2002:a17:903:11c7:b0:1d3:4783:cfc with SMTP id q7-20020a17090311c700b001d347830cfcmr5578132plh.93.1702832827014;
        Sun, 17 Dec 2023 09:07:07 -0800 (PST)
Received: from thinkpad ([103.28.246.178])
        by smtp.gmail.com with ESMTPSA id i11-20020a170902c94b00b001d359db2370sm7463049pla.152.2023.12.17.09.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 09:07:06 -0800 (PST)
Date: Sun, 17 Dec 2023 22:36:55 +0530
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
Subject: Re: [PATCH v4 01/15] PCI: imx6: Simplify clock handling by using
 bulk_clk_*() function
Message-ID: <20231217170655.GC6748@thinkpad>
References: <20231217051210.754832-1-Frank.Li@nxp.com>
 <20231217051210.754832-2-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231217051210.754832-2-Frank.Li@nxp.com>

On Sun, Dec 17, 2023 at 12:11:56AM -0500, Frank Li wrote:
> Refactors the clock handling logic in the imx6 PCI driver by adding
> clk_names[] define in drvdata . Simplifies the code and makes it more
> maintainable, as future additions of SOC support will only require
> straightforward changes.
> 

Commit description should be in imperative mood as per
Documentation/process/submitting-patches.rst:

"Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
to do frotz", as if you are giving orders to the codebase to change
its behaviour."

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Change from v3 to v4
>     - using clk_bulk_*() API
>     Change from v1 to v3
>     - none
> 
>  drivers/pci/controller/dwc/pci-imx6.c | 128 ++++++++------------------
>  1 file changed, 38 insertions(+), 90 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 74703362aeec7..2086214345e9a 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c

[...]

>  static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
> @@ -1305,32 +1265,19 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  		return imx6_pcie->reset_gpio;
>  	}
>  
> -	/* Fetch clocks */
> -	imx6_pcie->pcie_bus = devm_clk_get(dev, "pcie_bus");
> -	if (IS_ERR(imx6_pcie->pcie_bus))
> -		return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_bus),
> -				     "pcie_bus clock source missing or invalid\n");
> +	while (imx6_pcie->drvdata->clk_names[imx6_pcie->clks_cnt]) {
> +		int i = imx6_pcie->clks_cnt;
>  
> -	imx6_pcie->pcie = devm_clk_get(dev, "pcie");
> -	if (IS_ERR(imx6_pcie->pcie))
> -		return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie),
> -				     "pcie clock source missing or invalid\n");
> +		imx6_pcie->clks[i].id = imx6_pcie->drvdata->clk_names[i];
> +		imx6_pcie->clks_cnt++;

You can just initialize clks_cnt in drv_data with sizeof() of clk_names.

> +	}
> +
> +	/* Fetch clocks */
> +	ret = devm_clk_bulk_get(dev, imx6_pcie->clks_cnt, imx6_pcie->clks);
> +	if (ret)
> +		return ret;
>  
>  	switch (imx6_pcie->drvdata->variant) {
> -	case IMX6SX:
> -		imx6_pcie->pcie_inbound_axi = devm_clk_get(dev,
> -							   "pcie_inbound_axi");
> -		if (IS_ERR(imx6_pcie->pcie_inbound_axi))
> -			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_inbound_axi),
> -					     "pcie_inbound_axi clock missing or invalid\n");
> -		break;
> -	case IMX8MQ:
> -	case IMX8MQ_EP:
> -		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
> -		if (IS_ERR(imx6_pcie->pcie_aux))
> -			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
> -					     "pcie_aux clock source missing or invalid\n");
> -		fallthrough;
>  	case IMX7D:
>  		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
>  			imx6_pcie->controller_id = 1;
> @@ -1353,10 +1300,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
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
> @@ -1372,14 +1315,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  	default:
>  		break;
>  	}
> -	/* Don't fetch the pcie_phy clock, if it has abstract PHY driver */
> -	if (imx6_pcie->phy == NULL) {
> -		imx6_pcie->pcie_phy = devm_clk_get(dev, "pcie_phy");
> -		if (IS_ERR(imx6_pcie->pcie_phy))
> -			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_phy),
> -					     "pcie_phy clock source missing or invalid\n");
> -	}
> -
>  
>  	/* Grab turnoff reset */
>  	imx6_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
> @@ -1470,6 +1405,9 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
>  	imx6_pcie_assert_core_reset(imx6_pcie);
>  }
>  
> +#define IMX6_CLKS_COMMON "pcie_bus", "pcie"
> +#define IMX6_CLKS_NO_PHYDRV IMX6_CLKS_COMMON, "pcie_phy"
> +

Just use the clock names directly instead of definitions. It makes the code more
readable.

Rest LGTM!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

