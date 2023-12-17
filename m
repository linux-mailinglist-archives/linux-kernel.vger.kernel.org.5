Return-Path: <linux-kernel+bounces-2758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AB781616A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E6852827E6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBE046451;
	Sun, 17 Dec 2023 17:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bNLF3MiA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3343046549
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-58d06bfadf8so1895418eaf.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 09:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702835527; x=1703440327; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lc/zLJNzSAqGznoN5w3Ph2TFTZf9i/K/7UT0KNG4Hrw=;
        b=bNLF3MiAT17b9nnOyqEYVJeUcpirvOV7yui3etuUZ+9XChA9QnmmKIuXqTlD8+QSEI
         mnZ2fi+LkXrkj0WALk1gAKojfqO0/9WK1DxkPieb3i5iT1VLTOzar8TuVoOKw2sU7QpV
         NOs7EvbE2vmub+CtTlvwTW57g9bTz93yHSGlqF0OD1rkNNUlV2tL7D9kz2CytcY8DYM6
         l0RoO+aSOx9JSyfD0fLRaDKlZ+O1q7GPAowcMlk1dbURL/RrmGzM7qoy9Li20p1sTUOn
         am1AEP4qpETN8gE14r3DysMG76d4fVfX6Qmdb7mL9/8CeRtzNqpMyeVEiKKUMc/azg3n
         FY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702835527; x=1703440327;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lc/zLJNzSAqGznoN5w3Ph2TFTZf9i/K/7UT0KNG4Hrw=;
        b=uU/nKP5t0T4R9sB3J/IAV5EMseAFkIYXRuWNKx0JPiwXZNhhpJZdMkI3kN6vv61tcD
         fRWLRf8YQPw/ldZjgvCyMfTy69f8BQVAhsL1cDFRiQYr6hjy8OAc//JeowysBu+XD363
         OkjJCfxiaKL/YscMR609uFAutLPWDtBhTY/pnB6aUxwGJ0CUj4LXmA3BhxdEXLYmgZe8
         BW+JVdqW3hOI9GlvKXJYBXzJyMRL9dJRC7tLV/7SaJDRSzt1VZ9us88WNYMm5qlMtGd1
         hCxWl5/T2a3scntZ6zg/6GOtV4lCoNRPkNi3FYT9y+iClli6o+oVnNl4RemSqzGdyHZ1
         QKkg==
X-Gm-Message-State: AOJu0YyDOJzDS1Z72jytF/piZXmUoSkW2b7k47NI6h2oqnhN2DJNaQu5
	SDpfCesgc6aUeIF1SVcHvbgr
X-Google-Smtp-Source: AGHT+IGDdM44nBRNmiHZRWfECxq8krpGAL/3ufVgbPBZ2jHJKGq4ThK6sdpIIvOmdYfBXkl52GKZNQ==
X-Received: by 2002:a05:6358:910d:b0:172:9d70:3441 with SMTP id q13-20020a056358910d00b001729d703441mr6500872rwq.54.1702835527104;
        Sun, 17 Dec 2023 09:52:07 -0800 (PST)
Received: from thinkpad ([103.28.246.178])
        by smtp.gmail.com with ESMTPSA id ch23-20020a17090af41700b0028ae287e869sm8746648pjb.26.2023.12.17.09.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 09:52:06 -0800 (PST)
Date: Sun, 17 Dec 2023 23:21:58 +0530
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
Subject: Re: [PATCH v4 04/15] PCI: imx6: Using "linux,pci-domain" as slot ID
Message-ID: <20231217175158.GF6748@thinkpad>
References: <20231217051210.754832-1-Frank.Li@nxp.com>
 <20231217051210.754832-5-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231217051210.754832-5-Frank.Li@nxp.com>

On Sun, Dec 17, 2023 at 12:11:59AM -0500, Frank Li wrote:
> Avoid use get slot id by compared with register physical address. If there
> are more than 2 slots, compared logic will become complex.
> 
> "linux,pci-domain" already exist at dts since first commit:
> 	commit (9e65987b9584d arm64: dts: imx8mp: Add iMX8MP PCIe support).
> 
> So it is safe to remove compare basic address code:

You should mark this property as "required" in the binding. Otherwise, drivers
cannot make assumptions.

> 	...
> 	if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> 		imx6_pcie->controller_id = 1;
> 	...
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Change from v3 to v4
>     - remove compare basic address logic
>     Change from v2 to v3
>     - none
>     Change from v1 to v2
>     - fix of_get_pci_domain_nr return value check logic
> 
>  drivers/pci/controller/dwc/pci-imx6.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index c1fb38a2ebeb6..7145947e21d92 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -33,6 +33,7 @@
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  
> +#include "../../pci.h"
>  #include "pcie-designware.h"
>  
>  #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
> @@ -40,7 +41,6 @@
>  #define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE	BIT(11)
>  #define IMX8MQ_GPR_PCIE_VREG_BYPASS		BIT(12)
>  #define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE	GENMASK(11, 8)
> -#define IMX8MQ_PCIE2_BASE_ADDR			0x33c00000
>  
>  #define to_imx6_pcie(x)	dev_get_drvdata((x)->dev)
>  
> @@ -1279,13 +1279,11 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  					     "Failed to get PCIEPHY reset control\n");
>  	}
>  
> -	switch (imx6_pcie->drvdata->variant) {
> -	case IMX7D:
> -		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> -			imx6_pcie->controller_id = 1;
> -	default:
> -		break;
> -	}
> +	/* Using linux,pci-domain as PCI slot id */
> +	imx6_pcie->controller_id = of_get_pci_domain_nr(node);
> +	/* If there are not "linux,pci-domain" in dts file, means only 1 controller */

Only -EINVAL means the property is not present, other error codes means property
is present, but is not in good shape.

- Mani

> +	if (imx6_pcie->controller_id < 0)
> +		imx6_pcie->controller_id = 0;
>  
>  	/* Grab turnoff reset */
>  	imx6_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

