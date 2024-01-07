Return-Path: <linux-kernel+bounces-18792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 511EA826318
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 06:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9E0D1F21C5A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 05:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF54125B7;
	Sun,  7 Jan 2024 05:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AOzVSo3X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AB2125B1
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 05:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-28bcc273833so778935a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jan 2024 21:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704606920; x=1705211720; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=npkPTWZbSrPT/J2qTivWUqWZDlbUUJa861d4n1crd6s=;
        b=AOzVSo3XuBr//L8//JwBoD9vygIZwyOMjsRiMaAzqaAPi1+Y+thjiOYBNEiXpUeGSh
         S2ar7i8r5IEpK7ENCra3pCU/IMWRpwMbnACdGXkB81OfR7YXoZA4YVfafllDFhmQlLRO
         QS+I1XSupkAscskSOJLVsOFmc77n8sGuhL5KFQBwKw/zlmuvhYYomS1ohZHLRAnsKrXM
         kXVSs/pIm36f6gcxRmMasPLl8V83skDO6gUJR3GylJoroqPzZuPxv2x1YSvtEmgSh1u1
         tAMxwrZnWYDEl/J/vJx7x8NXPzPw0usn+D+j784jwWusupsZPve3ufiwGlg/bYMAXJEq
         QuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704606920; x=1705211720;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=npkPTWZbSrPT/J2qTivWUqWZDlbUUJa861d4n1crd6s=;
        b=te7w92ZY/7l5RhTWJKJx9nUgFIAcHqx/KB4TnQBrd7YnbtpFQFSKsX0v0c6BqjOpSt
         HzpG3seGkUZ+YLE/cBZYK6LNjqNVuHsozIlbtXVqW4gOygmpcN66qsWol8azQcJgTH4W
         gN5uJ/xkzkCizOjbPVxR/sHbH2BXoyoEJ7KVL83tBsYYXaEzd0W700Q6RF7EkgjvPKra
         MsFsYWy0pwqajtZZXvWTjZF89sYvIOs4yuTfPDR7ZBXAyrGPTUgWa1+F4wizr+uRDzXj
         d4hB36WGEFxucil299vqmpSla0sWNHPalvRziXNJabJRkIhdjZ1HNkSrjEOjewI0e4CP
         jcEg==
X-Gm-Message-State: AOJu0YzOZZymOYYyWaJ9Yjj78I5HxZgKqgMIjGpnAFxBDidNxwqqYDM2
	RwHCN+/YL5HvJCYkdvUD+FggZxaxmuQ9
X-Google-Smtp-Source: AGHT+IGyYHLcrSwSasOKfyMhzH4xhR/SbgU0ri+aHf3n40oDj/JY/IkyQis8SJwfZ2Us7GRm5TN95g==
X-Received: by 2002:a05:6a20:7a82:b0:199:8953:6e0c with SMTP id u2-20020a056a207a8200b0019989536e0cmr1255512pzh.52.1704606920277;
        Sat, 06 Jan 2024 21:55:20 -0800 (PST)
Received: from thinkpad ([103.197.115.97])
        by smtp.gmail.com with ESMTPSA id 9-20020a17090a018900b0028a4c85a55csm4287287pjc.27.2024.01.06.21.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 21:55:19 -0800 (PST)
Date: Sun, 7 Jan 2024 11:25:10 +0530
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
Subject: Re: [PATCH v7 13/16] PCI: imx6: Clean up get addr_space code
Message-ID: <20240107055510.GM3416@thinkpad>
References: <20231227182727.1747435-1-Frank.Li@nxp.com>
 <20231227182727.1747435-14-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231227182727.1747435-14-Frank.Li@nxp.com>

On Wed, Dec 27, 2023 at 01:27:24PM -0500, Frank Li wrote:

Subject: PCI: imx6: Rely on DWC core to fetch 'addr_space' region 

> The common dw_pcie_ep_init() already do the same thing. Needn't platform
> driver do it again.
> 

'Since the dw_pcie_ep_init() function is already fetching the 'addr_space'
region, no need to do the same in this driver.'

> Signed-off-by: Frank Li <Frank.Li@nxp.com>

With above changes,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> 
> Notes:
>     Change from v1 to v3
>     - new patches
> 
>  drivers/pci/controller/dwc/pci-imx6.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 9e60ab6f1885a..4b2b9aafad1b4 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1080,7 +1080,6 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
>  	int ret;
>  	unsigned int pcie_dbi2_offset;
>  	struct dw_pcie_ep *ep;
> -	struct resource *res;
>  	struct dw_pcie *pci = imx6_pcie->pci;
>  	struct dw_pcie_rp *pp = &pci->pp;
>  	struct device *dev = pci->dev;
> @@ -1099,14 +1098,8 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
>  		pcie_dbi2_offset = SZ_4K;
>  		break;
>  	}
> -	pci->dbi_base2 = pci->dbi_base + pcie_dbi2_offset;
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
> -	if (!res)
> -		return -EINVAL;
>  
> -	ep->phys_base = res->start;
> -	ep->addr_size = resource_size(res);
> -	ep->page_size = SZ_64K;
> +	pci->dbi_base2 = pci->dbi_base + pcie_dbi2_offset;
>  
>  	ret = dw_pcie_ep_init(ep);
>  	if (ret) {
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

