Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65383803113
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjLDK7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLDK7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:59:37 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9383EB9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 02:59:42 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-4b2eccce4dcso88442e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 02:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701687581; x=1702292381; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7bEx0tCg0pBB2RGpWhKyVXvpL7LgHhHvq8+rdmdgSd4=;
        b=pB4Fd2hgdteuLGusn8XmUGe7Mv1AOC0nughdM5qz8ASXw8XDk//2AgNQIur/YFqM41
         y8oTocRPrWWRhaAZlxl/KN0Z4QEvW1vIzA2bAiJ3k5pyx5WvFZFdMowUgTUlz+a88HLV
         DDNou4sd17bPEF+YGcnH+RIlgjlq9BQtWbsxydDzYBR4YExsALmjyhm34cBfrW7GOFtu
         N2+ARgm6AXqD43QJKJAeasGQY3GyinNbPYoBnlZZt7rJh54CKZk/RRMKTSVyZLPN1BRc
         cvjE4V9zBMnBVUb9qGsRpKzZHTDMY+7rWkMTVllJYPURPqwW1rstTysT13IKqsmXz5Lu
         unDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701687581; x=1702292381;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7bEx0tCg0pBB2RGpWhKyVXvpL7LgHhHvq8+rdmdgSd4=;
        b=N1o7drX38dpm6yUaUMJVRH1Pl/++EqhhiAC4NA32KN+WMaxQzhNcessoPs1Km+4Foh
         tFTn19O5ZVyDR4+6vEpi5HI97tnEkW45BI83cbDWnmiPVFLU9R+66/DdRcNGYG9P61sK
         jwHZVofnjpQD1cfcWNkEdbnKV6GLdpVLxk7a9A4XeouNzYtAKUYOglHJJisCG6ZykRN1
         rwXVCYgkwDMQRWFZqLLoLzYlWUgx0GxvQ6c9rDGrv3wxoSRSNKDykWMApjc6WrOAkuMo
         z8C8JmoD6ynvGo9pXjS1wHMw4UrnYOY9bCznpDf00607y0LYKRPq/mR7CVlHySzT//BI
         vcdA==
X-Gm-Message-State: AOJu0YwiXtblpzVdoZVGWVO2NF55w/ed6GFM1Hy0j+aHmFDiui5ByRRH
        AzAEWAcqyt1wL9u1QnOpYnIi
X-Google-Smtp-Source: AGHT+IHaxXfyDhijP6/BJkFg6aoA3IV347qjEa/qt4rjuAXnbel85JEDfVEpxBpRpyh9yIkK0iQFMw==
X-Received: by 2002:ac5:cfed:0:b0:4b2:c554:eeff with SMTP id m45-20020ac5cfed000000b004b2c554eeffmr1436442vkf.17.1701687581647;
        Mon, 04 Dec 2023 02:59:41 -0800 (PST)
Received: from thinkpad ([117.213.101.240])
        by smtp.gmail.com with ESMTPSA id k13-20020a05620a07ed00b0077d61831eb2sm4137123qkk.40.2023.12.04.02.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 02:59:41 -0800 (PST)
Date:   Mon, 4 Dec 2023 16:29:31 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     bhelgaas@google.com, imx@lists.linux.dev, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        lpieralisi@kernel.org, minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
        robh@kernel.org, roy.zang@nxp.com
Subject: Re: [PATCH v5 2/4] PCI: layerscape: Add suspend/resume for ls1021a
Message-ID: <20231204105931.GB35383@thinkpad>
References: <20231201161712.1645987-1-Frank.Li@nxp.com>
 <20231201161712.1645987-3-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231201161712.1645987-3-Frank.Li@nxp.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 11:17:10AM -0500, Frank Li wrote:
> Add suspend/resume support for Layerscape LS1021a.
> 
> In the suspend path, PME_Turn_Off message is sent to the endpoint to
> transition the link to L2/L3_Ready state. In this SoC, there is no way to
> check if the controller has received the PME_To_Ack from the endpoint or
> not. So to be on the safer side, the driver just waits for
> PCIE_PME_TO_L2_TIMEOUT_US before asserting the SoC specific PMXMTTURNOFF
> bit to complete the PME_Turn_Off handshake. Then the link would enter L2/L3
> state depending on the VAUX supply.
> 
> In the resume path, the link is brought back from L2 to L0 by doing a
> software reset.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

One comment below. With that addressed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> ---
> 
> Notes:
>     Change from v4 to v5
>     - update comit message
>     - remove a empty line
>     - use comments
>     /* Reset the PEX wrapper to bring the link out of L2 */
>     - pci->pp.ops = pcie->drvdata->ops,
>     ls_pcie_host_ops to the "ops" member of layerscape_drvdata.
>     - don't set pcie->scfg = NULL at error path
>     
>     Change from v3 to v4
>     - update commit message.
>     - it is reset a glue logic part for PCI controller.
>     - use regmap_write_bits() to reduce code change.
>     
>     Change from v2 to v3
>     - update according to mani's feedback
>     change from v1 to v2
>     - change subject 'a' to 'A'
> 
>  drivers/pci/controller/dwc/pci-layerscape.c | 81 ++++++++++++++++++++-
>  1 file changed, 80 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> index aea89926bcc4f..8bdaae9be7d56 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> @@ -35,11 +35,19 @@
>  #define PF_MCR_PTOMR		BIT(0)
>  #define PF_MCR_EXL2S		BIT(1)
>  
> +/* LS1021A PEXn PM Write Control Register */
> +#define SCFG_PEXPMWRCR(idx)	(0x5c + (idx) * 0x64)
> +#define PMXMTTURNOFF		BIT(31)
> +#define SCFG_PEXSFTRSTCR	0x190
> +#define PEXSR(idx)		BIT(idx)
> +
>  #define PCIE_IATU_NUM		6
>  
>  struct ls_pcie_drvdata {
>  	const u32 pf_off;
> +	const struct dw_pcie_host_ops *ops;
>  	int (*exit_from_l2)(struct dw_pcie_rp *pp);
> +	bool scfg_support;
>  	bool pm_support;
>  };
>  
> @@ -47,6 +55,8 @@ struct ls_pcie {
>  	struct dw_pcie *pci;
>  	const struct ls_pcie_drvdata *drvdata;
>  	void __iomem *pf_base;
> +	struct regmap *scfg;
> +	int index;
>  	bool big_endian;
>  };
>  
> @@ -171,18 +181,70 @@ static int ls_pcie_host_init(struct dw_pcie_rp *pp)
>  	return 0;
>  }
>  
> +static void scfg_pcie_send_turnoff_msg(struct regmap *scfg, u32 reg, u32 mask)
> +{
> +	/* Send PME_Turn_Off message */
> +	regmap_write_bits(scfg, reg, mask, mask);
> +
> +	/*
> +	 * There is no specific register to check for PME_To_Ack from endpoint.
> +	 * So on the safe side, wait for PCIE_PME_TO_L2_TIMEOUT_US.
> +	 */
> +	mdelay(PCIE_PME_TO_L2_TIMEOUT_US/1000);
> +
> +	/*
> +	 * Layerscape hardware reference manual recommends clearing the PMXMTTURNOFF bit
> +	 * to complete the PME_Turn_Off handshake.
> +	 */
> +	regmap_write_bits(scfg, reg, mask, 0);
> +}
> +
> +static void ls1021a_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct ls_pcie *pcie = to_ls_pcie(pci);
> +
> +	scfg_pcie_send_turnoff_msg(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), PMXMTTURNOFF);
> +}
> +
> +static int scfg_pcie_exit_from_l2(struct regmap *scfg, u32 reg, u32 mask)
> +{
> +	/* Reset the PEX wrapper to bring the link out of L2 */
> +	regmap_write_bits(scfg, reg, mask, mask);
> +	regmap_write_bits(scfg, reg, mask, 0);
> +
> +	return 0;
> +}
> +
> +static int ls1021a_pcie_exit_from_l2(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct ls_pcie *pcie = to_ls_pcie(pci);
> +
> +	return scfg_pcie_exit_from_l2(pcie->scfg, SCFG_PEXSFTRSTCR, PEXSR(pcie->index));
> +}
> +
>  static const struct dw_pcie_host_ops ls_pcie_host_ops = {
>  	.host_init = ls_pcie_host_init,
>  	.pme_turn_off = ls_pcie_send_turnoff_msg,
>  };
>  
> +static const struct dw_pcie_host_ops ls1021a_pcie_host_ops = {
> +	.host_init = ls_pcie_host_init,
> +	.pme_turn_off = ls1021a_pcie_send_turnoff_msg,
> +};
> +
>  static const struct ls_pcie_drvdata ls1021a_drvdata = {
> -	.pm_support = false,
> +	.pm_support = true,
> +	.scfg_support = true,
> +	.ops = &ls1021a_pcie_host_ops,
> +	.exit_from_l2 = ls1021a_pcie_exit_from_l2,
>  };
>  
>  static const struct ls_pcie_drvdata layerscape_drvdata = {
>  	.pf_off = 0xc0000,
>  	.pm_support = true,
> +	.ops = &ls_pcie_host_ops;
>  	.exit_from_l2 = ls_pcie_exit_from_l2,
>  };
>  
> @@ -205,6 +267,8 @@ static int ls_pcie_probe(struct platform_device *pdev)
>  	struct dw_pcie *pci;
>  	struct ls_pcie *pcie;
>  	struct resource *dbi_base;
> +	u32 index[2];
> +	int ret;
>  
>  	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>  	if (!pcie)
> @@ -220,6 +284,7 @@ static int ls_pcie_probe(struct platform_device *pdev)
>  	pci->pp.ops = &ls_pcie_host_ops;

This should be removed now.

- Mani

>  
>  	pcie->pci = pci;
> +	pci->pp.ops = pcie->drvdata->ops;
>  
>  	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
>  	pci->dbi_base = devm_pci_remap_cfg_resource(dev, dbi_base);
> @@ -230,6 +295,20 @@ static int ls_pcie_probe(struct platform_device *pdev)
>  
>  	pcie->pf_base = pci->dbi_base + pcie->drvdata->pf_off;
>  
> +	if (pcie->drvdata->scfg_support) {
> +		pcie->scfg = syscon_regmap_lookup_by_phandle(dev->of_node, "fsl,pcie-scfg");
> +		if (IS_ERR(pcie->scfg)) {
> +			dev_err(dev, "No syscfg phandle specified\n");
> +			return PTR_ERR(pcie->scfg);
> +		}
> +
> +		ret = of_property_read_u32_array(dev->of_node, "fsl,pcie-scfg", index, 2);
> +		if (ret)
> +			return ret;
> +
> +		pcie->index = index[1];
> +	}
> +
>  	if (!ls_pcie_is_bridge(pcie))
>  		return -ENODEV;
>  
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
