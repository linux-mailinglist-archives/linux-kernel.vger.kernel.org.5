Return-Path: <linux-kernel+bounces-18795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BC382631F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 07:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2593E28294E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 06:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20D7125C8;
	Sun,  7 Jan 2024 06:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mp4nMo+8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C54125BB
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 06:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3608cfa5ce6so511355ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jan 2024 22:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704608216; x=1705213016; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tjkLk9BGknFoHjmI/p9bsyEkzetnF4kncdD8DemYfk8=;
        b=mp4nMo+8oUzgiyAYO3mucOKU/DnbmnmrLiWzjIHWlo99gmScfcpxckZj3UMDQEuIw9
         eDnKO3F3yQ5SpsXH0oBJa1PtiEA4EHc9dvJlJ42XR2UmaLjw/tc1AWVkCmIKcEYAbHf7
         ASzB9qAdsyc1Bh+RI/hYc6Cw2/6JTCZrj2oT3fKUoaRhHQPeedccywJbu3hnBW6XDXXl
         +Stho0pDyLE3nFjVA+rYTMtuxR+7UBSZ3J//NVzUZkxfPzu/znVVv6seKlxcuMpeGPTr
         UOjWwfH7uNQc5d74Lb9goj8JZ+Vd4ombPfhAlBIHqCvFl6pi5NJYiMzCeU7iZ6Yxow0N
         NJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704608216; x=1705213016;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tjkLk9BGknFoHjmI/p9bsyEkzetnF4kncdD8DemYfk8=;
        b=skzDdKM+eZe7QZzFLAjdX2wbWT4sJtdwKwJpmfoITBer54oFEmrMqfPaQrJavkwczU
         sx7MjhI0MTtFeDla2n7wLo/0bQZEogDIZbvdn1fM3QB3PhXAEVmteDHcBdqwDEEBVQeN
         XWBQA2V0cvbGwNSNhci7zhLQ2My5LJvrJNDIY4JtlDjpHhkYcom5rVbwWGfgUUN67FQw
         s7hztxAdVc8NjheEe2yj4lLpIxyzc6toMXIpvhDpVvwReZvi3p/cTnBdPZPsOUASVUHq
         anHjNGiNS4hDAAUzxc3y7NStoVf28fn/GjGK6r5LN+R/QappCsyvjKIxeh4McDZTky0i
         g/YA==
X-Gm-Message-State: AOJu0YxxU5X5F1l+UWGEEnHrz4UMpRG2v3RN6huiqYbyQQd810BoTiM8
	hlarlPzViURGTGjRspnS3duNrKB0yE6x
X-Google-Smtp-Source: AGHT+IGkIZ9NUGm1g1hagpBGTj6dUH9zK41yf3/7mRT3F5hk9YWbobujTiV37E3hfHnBnFtEWKlang==
X-Received: by 2002:a05:6e02:1d17:b0:360:655e:df6b with SMTP id i23-20020a056e021d1700b00360655edf6bmr3772923ila.12.1704608215966;
        Sat, 06 Jan 2024 22:16:55 -0800 (PST)
Received: from thinkpad ([103.197.115.97])
        by smtp.gmail.com with ESMTPSA id v5-20020a170902b7c500b001bbb8d5166bsm3888225plz.123.2024.01.06.22.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 22:16:55 -0800 (PST)
Date: Sun, 7 Jan 2024 11:46:49 +0530
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
Subject: Re: [PATCH v7 14/16] PCI: imx6: Add epc_features in imx6_pcie_drvdata
Message-ID: <20240107061649.GN3416@thinkpad>
References: <20231227182727.1747435-1-Frank.Li@nxp.com>
 <20231227182727.1747435-15-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231227182727.1747435-15-Frank.Li@nxp.com>

On Wed, Dec 27, 2023 at 01:27:25PM -0500, Frank Li wrote:
> The i.MX EP exhibits variations in epc_features among different EP
> configurations. This introduces the addition of epc_features in
> imx6_pcie_drvdata to accommodate these differences. It's important to note
> that there are no functional changes in this commit; instead, it lays the
> groundwork for supporting i.MX95 EP functions.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> 
> Notes:
>     Change from v5 to v6
>     - add missed maxitems.
>     - add comments about reuse linux,pci-domain as controller id.
>     linux,pci-domain have not defined at PCI endpoint side.
>     
>     Change from v1 to v3
>     - new patch at v3
> 
>  drivers/pci/controller/dwc/pci-imx6.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 4b2b9aafad1b4..6a58fd63a9dd2 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -104,6 +104,7 @@ struct imx6_pcie_drvdata {
>  	const u32 ltssm_mask;
>  	const u32 mode_off[IMX6_PCIE_MAX_INSTANCES];
>  	const u32 mode_mask[IMX6_PCIE_MAX_INSTANCES];
> +	const struct pci_epc_features *epc_features;
>  	int (*init_phy)(struct imx6_pcie *pcie);
>  };
>  
> @@ -1065,7 +1066,10 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
>  static const struct pci_epc_features*
>  imx6_pcie_ep_get_features(struct dw_pcie_ep *ep)
>  {
> -	return &imx8m_pcie_epc_features;
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
> +
> +	return imx6_pcie->drvdata->epc_features;
>  }
>  
>  static const struct dw_pcie_ep_ops pcie_ep_ops = {
> @@ -1530,6 +1534,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.mode_off[1] = IOMUXC_GPR12,
>  		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
> +		.epc_features = &imx8m_pcie_epc_features,
>  		.init_phy = imx8mq_pcie_init_phy,
>  	},
>  	[IMX8MM_EP] = {
> @@ -1540,6 +1545,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> +		.epc_features = &imx8m_pcie_epc_features,
>  	},
>  	[IMX8MP_EP] = {
>  		.variant = IMX8MP_EP,
> @@ -1549,6 +1555,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> +		.epc_features = &imx8m_pcie_epc_features,
>  	},
>  };
>  
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

