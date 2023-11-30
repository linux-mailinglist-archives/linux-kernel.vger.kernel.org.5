Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFBD7FF6B7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbjK3QqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235186AbjK3QqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:46:18 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393F910E4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:46:24 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-67a3f1374bdso6531466d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701362783; x=1701967583; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kjHz7y8FdABfzePSYWvG3C7LR0AsyMP0bJ41uTORMXU=;
        b=q4CuJY2cIM/u1JfDIjIKi03c4r3KcjRzIjZ8Zgnkf6wPkHSciSG4iludWQAjzmB7Lc
         ggeZaVPPNJ0Lse0yjBMqv/oMn59kUc7wcS3kZ80kS0+aclPP6lA7ivkY21KAtub87HzZ
         wTrUhaJPx+XI1Ip0+9SWjMsiITUmMCfCAVKRmizHq6ANLyafDFl/SYUDMK7KasdHXhuw
         wybWDc8W22CQ7PFqeaoKMDRNetF7W46uFTX8hyBjQoxtfXlb0hA2oieiknW9OVwH62mk
         Ts2LfQZPk/IYH0fplV23MTXxRx3hTTLMRbG3NGIE+FA0KbVWyQsQs1al0jm4zPNkih8G
         2p2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701362783; x=1701967583;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kjHz7y8FdABfzePSYWvG3C7LR0AsyMP0bJ41uTORMXU=;
        b=aV4Xs8SoOa05QBrANMtKSbsEN4QXf8lTm1O3NH4qifmZx+vQEyXVyjWdIsF/R5E58y
         Ylv9GNGbIgCkfiRDz8pQhY+xu4Fgli/ND8FrC0lp4I8runhivZmqPMYImJrdAmWcJ1Qp
         TkAcY5pjh10NIYS4ycQFhIPa3DAQKXS2mswn56tY1667baVRBRo417WQDPpgJj2Q9xQt
         wNzwnTAh3wybmAkZIWL7SVciPZh0IigVVomosSx/Tn7ylVpXbmhiSi/ZPyHREC6qDXuA
         AKBIU6Sss0hdA6ZN9Gs+DKrQGJ5KXe2qMqmMVWM4H37pQloYadRMooxnC4UW0NgL+xkU
         /pGw==
X-Gm-Message-State: AOJu0YyZCrda3FbUdcaRUopBzZBSuWOjn/3MRMfy4e59UW6b4tAYVoiC
        Q1yTbaqrjfF4Ee6VJ+LqHwyx
X-Google-Smtp-Source: AGHT+IGr+FYWyq9x/hJmkOaCYSyPqI1d2GXxR9QhDtHyNIh5/ut2psmnppxw1XpPHzUoptuB8eT7og==
X-Received: by 2002:a05:6214:cce:b0:67a:1580:d7c3 with SMTP id 14-20020a0562140cce00b0067a1580d7c3mr35231818qvx.58.1701362783244;
        Thu, 30 Nov 2023 08:46:23 -0800 (PST)
Received: from thinkpad ([117.213.102.92])
        by smtp.gmail.com with ESMTPSA id h29-20020a0cab1d000000b0067a2a0b44ddsm650581qvb.44.2023.11.30.08.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 08:46:22 -0800 (PST)
Date:   Thu, 30 Nov 2023 22:16:12 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     bhelgaas@google.com, imx@lists.linux.dev, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        lpieralisi@kernel.org, minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
        robh@kernel.org, roy.zang@nxp.com
Subject: Re: [PATCH v4 3/4] PCI: layerscape: Rename pf_* as pf_lut_*
Message-ID: <20231130164612.GU3043@thinkpad>
References: <20231129214412.327633-1-Frank.Li@nxp.com>
 <20231129214412.327633-4-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231129214412.327633-4-Frank.Li@nxp.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 04:44:11PM -0500, Frank Li wrote:
> 'pf' and 'lut' is just difference name in difference chips, but basic it is
> a MMIO base address plus an offset.
> 
> Rename it to avoid duplicate pf_* and lut_* in driver.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Can you fix the name in pci-layerscape-ep.c also?

- Mani

> ---
> 
> Notes:
>     pf_lut is better than pf_* or lut* because some chip use 'pf', some chip
>     use 'lut'.
>     
>     change from v1 to v4
>     - new patch at v3
> 
>  drivers/pci/controller/dwc/pci-layerscape.c | 34 ++++++++++-----------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> index 42bca2c3b5c3e..590e07bb27002 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> @@ -44,7 +44,7 @@
>  #define PCIE_IATU_NUM		6
>  
>  struct ls_pcie_drvdata {
> -	const u32 pf_off;
> +	const u32 pf_lut_off;
>  	const struct dw_pcie_host_ops *ops;
>  	int (*exit_from_l2)(struct dw_pcie_rp *pp);
>  	bool scfg_support;
> @@ -54,13 +54,13 @@ struct ls_pcie_drvdata {
>  struct ls_pcie {
>  	struct dw_pcie *pci;
>  	const struct ls_pcie_drvdata *drvdata;
> -	void __iomem *pf_base;
> +	void __iomem *pf_lut_base;
>  	struct regmap *scfg;
>  	int index;
>  	bool big_endian;
>  };
>  
> -#define ls_pcie_pf_readl_addr(addr)	ls_pcie_pf_readl(pcie, addr)
> +#define ls_pcie_pf_lut_readl_addr(addr)	ls_pcie_pf_lut_readl(pcie, addr)
>  #define to_ls_pcie(x)	dev_get_drvdata((x)->dev)
>  
>  static bool ls_pcie_is_bridge(struct ls_pcie *pcie)
> @@ -101,20 +101,20 @@ static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
>  	iowrite32(PCIE_ABSERR_SETTING, pci->dbi_base + PCIE_ABSERR);
>  }
>  
> -static u32 ls_pcie_pf_readl(struct ls_pcie *pcie, u32 off)
> +static u32 ls_pcie_pf_lut_readl(struct ls_pcie *pcie, u32 off)
>  {
>  	if (pcie->big_endian)
> -		return ioread32be(pcie->pf_base + off);
> +		return ioread32be(pcie->pf_lut_base + off);
>  
> -	return ioread32(pcie->pf_base + off);
> +	return ioread32(pcie->pf_lut_base + off);
>  }
>  
> -static void ls_pcie_pf_writel(struct ls_pcie *pcie, u32 off, u32 val)
> +static void ls_pcie_pf_lut_writel(struct ls_pcie *pcie, u32 off, u32 val)
>  {
>  	if (pcie->big_endian)
> -		iowrite32be(val, pcie->pf_base + off);
> +		iowrite32be(val, pcie->pf_lut_base + off);
>  	else
> -		iowrite32(val, pcie->pf_base + off);
> +		iowrite32(val, pcie->pf_lut_base + off);
>  }
>  
>  static void ls_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
> @@ -124,11 +124,11 @@ static void ls_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
>  	u32 val;
>  	int ret;
>  
> -	val = ls_pcie_pf_readl(pcie, LS_PCIE_PF_MCR);
> +	val = ls_pcie_pf_lut_readl(pcie, LS_PCIE_PF_MCR);
>  	val |= PF_MCR_PTOMR;
> -	ls_pcie_pf_writel(pcie, LS_PCIE_PF_MCR, val);
> +	ls_pcie_pf_lut_writel(pcie, LS_PCIE_PF_MCR, val);
>  
> -	ret = readx_poll_timeout(ls_pcie_pf_readl_addr, LS_PCIE_PF_MCR,
> +	ret = readx_poll_timeout(ls_pcie_pf_lut_readl_addr, LS_PCIE_PF_MCR,
>  				 val, !(val & PF_MCR_PTOMR),
>  				 PCIE_PME_TO_L2_TIMEOUT_US/10,
>  				 PCIE_PME_TO_L2_TIMEOUT_US);
> @@ -147,15 +147,15 @@ static int ls_pcie_exit_from_l2(struct dw_pcie_rp *pp)
>  	 * Set PF_MCR_EXL2S bit in LS_PCIE_PF_MCR register for the link
>  	 * to exit L2 state.
>  	 */
> -	val = ls_pcie_pf_readl(pcie, LS_PCIE_PF_MCR);
> +	val = ls_pcie_pf_lut_readl(pcie, LS_PCIE_PF_MCR);
>  	val |= PF_MCR_EXL2S;
> -	ls_pcie_pf_writel(pcie, LS_PCIE_PF_MCR, val);
> +	ls_pcie_pf_lut_writel(pcie, LS_PCIE_PF_MCR, val);
>  
>  	/*
>  	 * L2 exit timeout of 10ms is not defined in the specifications,
>  	 * it was chosen based on empirical observations.
>  	 */
> -	ret = readx_poll_timeout(ls_pcie_pf_readl_addr, LS_PCIE_PF_MCR,
> +	ret = readx_poll_timeout(ls_pcie_pf_lut_readl_addr, LS_PCIE_PF_MCR,
>  				 val, !(val & PF_MCR_EXL2S),
>  				 1000,
>  				 10000);
> @@ -243,7 +243,7 @@ static const struct ls_pcie_drvdata ls1021a_drvdata = {
>  };
>  
>  static const struct ls_pcie_drvdata layerscape_drvdata = {
> -	.pf_off = 0xc0000,
> +	.pf_lut_off = 0xc0000,
>  	.pm_support = true,
>  	.exit_from_l2 = ls_pcie_exit_from_l2,
>  };
> @@ -293,7 +293,7 @@ static int ls_pcie_probe(struct platform_device *pdev)
>  
>  	pcie->big_endian = of_property_read_bool(dev->of_node, "big-endian");
>  
> -	pcie->pf_base = pci->dbi_base + pcie->drvdata->pf_off;
> +	pcie->pf_lut_base = pci->dbi_base + pcie->drvdata->pf_lut_off;
>  
>  	if (pcie->drvdata->scfg_support) {
>  		pcie->scfg = syscon_regmap_lookup_by_phandle(dev->of_node, "fsl,pcie-scfg");
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
