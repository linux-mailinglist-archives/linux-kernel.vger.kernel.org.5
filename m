Return-Path: <linux-kernel+bounces-71650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1B885A860
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45655286E99
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911EE3C697;
	Mon, 19 Feb 2024 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E4NIl2/4"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75E23B79D
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359139; cv=none; b=isXbm3d64Hj/4iDmUwUJ/cHty3FxsuTc+VGuX+AyDA6BookiVgUWPpL8G13bgmALGo80FU/EIwVwJ8fbYQiJ7fqLIhNYorZH86xjFPGuQBsj4bRcz/ZR4me8gCae5pmn8VSFN940tvvrLlnZ4r+r7D4ka5aGqdbHjqOcX8Z8mzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359139; c=relaxed/simple;
	bh=sHaZ1fkkziKisQCFum7OdMUZZlYeSLfKSujPIsT4gnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTwAgXFpDwzLBmBL55O/rmbbjNMQJWgf5PLeihF7TGwe0OoYFV5M7tJDTTjr78z3xXX+OhfCvbHJ1m2El9KKbWh//NjHb4NpC3JJc+irYTY8kTcd1Ao1YJh0MuNMqELxLqNM1fR9PtytdXysG01a/yEAMwgHBR3lYUIB4J/wYIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E4NIl2/4; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e4751b97eeso258380b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708359137; x=1708963937; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VjM5BP6IafIzFETSaEBSJHdOU4rhZ/NqSlKuCbN1tEA=;
        b=E4NIl2/46Rabk8cJCRssM4QtVI9OrhkpyAW0Zxk8Vq0N3w+aY2EggmAuzGqrXqGRbh
         ajnrk7UEMtItxhNZlv6pfOej3OvWHMw/6gy7C3qSgXnUR17105ZRftdnNlnxof+La4yj
         bCe5CaPc8zPAbxzpWjndjykuRqCdGNbAtDDkSmc53poZnQZD+Znz5MRCbTqzqbws6KmV
         oKwz/KgqOekZD3jArhNNWYWYUzGJRJBYeeAfIlOrv0nODTXjhf2j1wDIp2rmHq3QyJlm
         a3DgTz9lUy4a8TFFHW2b8unNdMdve8BHpTWW+mSSgOHlWGGt3LrhjFeD3mOJpTPCTyxn
         Wwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708359137; x=1708963937;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VjM5BP6IafIzFETSaEBSJHdOU4rhZ/NqSlKuCbN1tEA=;
        b=dh5IPOKa+87ypuEQkHCGNbTQCTtBmUvwqi7V/vCzuzAjSl9qaaMqNnVLm08YbNpES1
         e+eOtMP7zfPkhRCgqh+FLVv0LrP6JXyZn0YhV3FWfTCeDMUsdOIxxdvKXH2wnw7KXAWg
         riYeM91wQd2YP6WJIcq752e2mTnALOuB6fYuFhlc/UILNtVOnBilShd0Y0YuXXuUduKV
         +WJZjLh424S+kiwJHwtLFD7A6ki2RS1CgvZQ+Xioo7iAMokvMOhqOaUDvW2rEptzg/8S
         XLk1tQ6DhXglmGYyR/byYRWcnjOFxTOWS+7AAmE3lAKmzkIrAOHaOOmG35kDW0F3bgix
         SrGA==
X-Forwarded-Encrypted: i=1; AJvYcCWWZljhsq/NCOYX2mcde99BtWP8c9L8v4D4gyunvgTN7mQq1JGrcYT6EzeKumJEbLGyzA8OAPrISN256fg79h+dTLRzeC83UyFe6ex9
X-Gm-Message-State: AOJu0YyAdITiRBbVzFebROeENXTcwwZiaXskNhldoHn5s1HQANBQuPAt
	OvDeKU0TAPApyG29h74fPaoAp2gkJuYF2OKpr3RRa1FWT5M9IBRLjnc5Z/aqBQ==
X-Google-Smtp-Source: AGHT+IEe2VfOrNLtUn52OWpBafmo/JTiMuopuECfKir8MlzvUnPKjJ7qwLaSaZAMlkN+p9OgG7LaGw==
X-Received: by 2002:aa7:8b8f:0:b0:6e3:ad06:8153 with SMTP id r15-20020aa78b8f000000b006e3ad068153mr4161626pfd.28.1708359137153;
        Mon, 19 Feb 2024 08:12:17 -0800 (PST)
Received: from thinkpad ([117.248.7.166])
        by smtp.gmail.com with ESMTPSA id c7-20020a62f847000000b006e0e35c1e55sm4930061pfm.79.2024.02.19.08.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 08:12:16 -0800 (PST)
Date: Mon, 19 Feb 2024 21:42:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, festevam@gmail.com, helgaas@kernel.org,
	hongxing.zhu@nxp.com, imx@lists.linux.dev, kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	robh@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v10 00/14] PCI: imx6: Clean up and add imx95 pci support
Message-ID: <20240219161208.GE3281@thinkpad>
References: <20240205173335.1120469-1-Frank.Li@nxp.com>
 <ZdNvsdao8jbB/52L@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZdNvsdao8jbB/52L@lizhi-Precision-Tower-5810>

On Mon, Feb 19, 2024 at 10:11:45AM -0500, Frank Li wrote:
> On Mon, Feb 05, 2024 at 12:33:21PM -0500, Frank Li wrote:
> > first 6 patches use drvdata: flags to simplify some switch-case code.
> > Improve maintaince and easy to read code.
> > 
> 
> @Lorenzo Pieralisi:
> 
> 	Do you have chance to look other patches?
> 	Mani's apply EP side change. 

Even though the controller is for the endpoint, it is still a controller
driver. So all the patches should go through Lorenzo.

I only merge patches under drivers/pci/endpoint. Hope this clarifies.

- Mani

> 	'PCI: imx6: Add iMX95 Endpoint (EP) support' need be rebased. 
> 
> Frank
> 
> > Then add imx95 basic pci host function.
> > 
> > follow two patch do endpoint code clean up.
> > Then add imx95 basic endpont function.
> > 
> > Compared with v2, added EP function support and some fixes,  please change
> > notes at each patches.
> > 
> > Change from v9 to v10
> > - remove two patches:
> > >   dt-bindings: imx6q-pcie: Add linux,pci-domain as required for iMX8MQ
> > >   PCI: imx6: Using "linux,pci-domain" as slot ID
> > it is not good solution to fixed hardcode check to get controller id.
> > Will see better solution later.
> > 
> > dt-binding pass pcie node:
> > 
> > pcie0: pcie@4c300000 {
> >                         compatible = "fsl,imx95-pcie";
> >                         reg = <0 0x4c300000 0 0x40000>,
> >                                 <0 0x4c360000 0 0x10000>,
> >                                 <0 0x4c340000 0 0x20000>,
> >                                 <0 0x60100000 0 0xfe00000>;
> >                         reg-names = "dbi", "atu", "app", "config";
> >                         #address-cells = <3>;
> >                         #size-cells = <2>;
> >                         device_type = "pci";
> >                         linux,pci-domain = <0>;
> >                         bus-range = <0x00 0xff>;
> >                         ranges = <0x81000000 0x0 0x00000000 0x0 0x6ff00000 0 0x00100000>,
> >                                  <0x82000000 0x0 0x10000000 0x9 0x10000000 0 0x10000000>;
> >                         num-lanes = <1>;
> >                         num-viewport = <8>;
> >                         interrupts = <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>;
> >                         interrupt-names = "msi";
> >                         #interrupt-cells = <1>;
> >                         interrupt-map-mask = <0 0 0 0x7>;
> >                         interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
> >                                         <0 0 0 2 &gic 0 0 GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
> >                                         <0 0 0 3 &gic 0 0 GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
> >                                         <0 0 0 4 &gic 0 0 GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
> >                         fsl,max-link-speed = <3>;
> >                         clocks = <&scmi_clk IMX95_CLK_HSIO>,
> >                                  <&scmi_clk IMX95_CLK_HSIOPLL>,
> >                                  <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
> >                                  <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> >                         clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
> >                         assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
> >                                          <&scmi_clk IMX95_CLK_HSIOPLL>,
> >                                          <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> >                         assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
> >                         assigned-clock-parents = <0>, <0>,
> >                                                  <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
> >                         power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
> >                         /* 0x30~0x37 stream id for pci0 */
> >                         /*
> >                          * iommu-map = <0x000 &apps_smmu 0x30 0x1>,
> >                          * <0x100 &apps_smmu 0x31 0x1>;
> >                          */
> >                         status = "disabled";
> >                 };
> > 
> > pcie1: pcie-ep@4c380000 {
> >                         compatible = "fsl,imx95-pcie-ep";
> >                         reg = <0 0x4c380000 0 0x20000>,
> >                               <0 0x4c3e0000 0 0x1000>,
> >                               <0 0x4c3a0000 0 0x1000>,
> >                               <0 0x4c3c0000 0 0x10000>,
> >                               <0 0x4c3f0000 0 0x10000>,
> >                               <0xa 0 1 0>;
> >                         reg-names = "dbi", "atu", "dbi2", "app", "dma", "addr_space";
> >                         interrupts = <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>;
> >                         interrupt-names = "dma";
> >                         fsl,max-link-speed = <3>;
> >                         clocks = <&scmi_clk IMX95_CLK_HSIO>,
> >                                  <&scmi_clk IMX95_CLK_HSIOPLL>,
> >                                  <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
> >                                  <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> >                         clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
> >                         assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
> >                                          <&scmi_clk IMX95_CLK_HSIOPLL>,
> >                                          <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> >                         assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
> >                         assigned-clock-parents = <0>, <0>,
> >                                                  <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
> >                         power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
> >                         status = "disabled";
> >                 };
> > 
> > Frank Li (13):
> >   PCI: imx6: Simplify clock handling by using clk_bulk*() function
> >   PCI: imx6: Simplify phy handling by using IMX6_PCIE_FLAG_HAS_PHYDRV
> >   PCI: imx6: Simplify reset handling by using by using
> >     *_FLAG_HAS_*_RESET
> >   PCI: imx6: Simplify ltssm_enable() by using ltssm_off and ltssm_mask
> >   PCI: imx6: Simplify configure_type() by using mode_off and mode_mask
> >   PCI: imx6: Simplify switch-case logic by involve init_phy callback
> >   dt-bindings: imx6q-pcie: Clean up irrationality clocks check
> >   dt-bindings: imx6q-pcie: Restruct reg and reg-name
> >   PCI: imx6: Add iMX95 PCIe Root Complex support
> >   PCI: imx6: Clean up get addr_space code
> >   PCI: imx6: Add epc_features in imx6_pcie_drvdata
> >   dt-bindings: imx6q-pcie: Add iMX95 pcie endpoint compatible string
> >   PCI: imx6: Add iMX95 Endpoint (EP) support
> > 
> > Richard Zhu (1):
> >   dt-bindings: imx6q-pcie: Add imx95 pcie compatible string
> > 
> >  .../bindings/pci/fsl,imx6q-pcie-common.yaml   |  17 +-
> >  .../bindings/pci/fsl,imx6q-pcie-ep.yaml       |  46 +-
> >  .../bindings/pci/fsl,imx6q-pcie.yaml          |  49 +-
> >  drivers/pci/controller/dwc/pci-imx6.c         | 634 ++++++++++--------
> >  4 files changed, 436 insertions(+), 310 deletions(-)
> > 
> > -- 
> > 2.34.1
> > 

-- 
மணிவண்ணன் சதாசிவம்

