Return-Path: <linux-kernel+bounces-96770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71695876136
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 269BD282199
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B795B26296;
	Fri,  8 Mar 2024 09:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K1+FQYG1"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23907535BA
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709891182; cv=none; b=amJYOC45OFilG4azt29nLZEK1OAsvEfFuDgQtSw9/iUtT70u6VaxJIui4H8BIBXNCJ+tv6HW98VL1DkdWooDwA8RmYoKAF7c/3lCYe2ksk3nIPSMPz26jFAO2nMQtLYSmJ7cZ72b10EGVhk+x1sZNwf/tXHOLl+ASf4y9xS0xfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709891182; c=relaxed/simple;
	bh=Clqd8haJQgsPibeWAC6UKITH48izdvnBqHGXQt+95+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+O6PgfYvrHGrHsigNamBGHZ9gk9Jx+QEEIWutmfQ+j3rc8HHt+3rhVF68D31by6Xi7ram7BdGCp96h4QVPmm2bVr2vpORpIyc/gmU4+tcAQveDCyp6aW3dAR9nd3LjirvNFlUFJd75PaJlMWTMjF1gS9BqA+HdDk4PTsiJAivU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K1+FQYG1; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e649a2548cso594267b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 01:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709891180; x=1710495980; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kb10RNHzo2wWSlL+Eq4xCbaoA0z2rfpZzBo11/jnm6s=;
        b=K1+FQYG104NukSoFzZrIyWD9zmVz6yHjKl9boXxFMXquC1P8UJc1PpCuXVmeBAhJ1j
         jD4X8of89aJwqHpwM1+M4XrCMKfG3y95AvAr0ffctQQJpJPHtepfWLq7/55jZghMZdoX
         KeFmyCT4SThmdKGuZLhkNqqbzp7MCCwkcx4dg6R47D69yHBnmsZqnqnUtXWPl65/S0cK
         Y3wGOcH4k7mAIwCw7FozKJKwNIr9eznITx4McSR78HQtqsUey9kLfZoUnUt9MJzPIOs2
         vrwEBf8s6L9K9uCCgD7YwfB+JiYJNJoP17EGIKgwOIzM/w1dboc2bq1hChjlOgqIijHq
         EB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709891180; x=1710495980;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kb10RNHzo2wWSlL+Eq4xCbaoA0z2rfpZzBo11/jnm6s=;
        b=dwh0g/wzSXpi/WM1Bm7vuU9qKyDozAnAuaYNDHC7kb9e7AqNpT8N6dqrbVlpuTzGdM
         21t/1kARJj/cXTHSbVvNb0eY43jn65kHC8T2SgE7454neD1F8WUbw2cxmxRp37MyrIGq
         pj7r7yGEJTJ5TmKAaRasiaDG5wOySGEZ1sn+481kZQNpxy5VdNqU/ym7BTEJYdoZ8ldk
         1EfwGRxwcUbtbnivvKEXu3W5Hra2elmjV8BnOt8um2oskxVH9XJgEjuUW8KTtySamLTl
         P8pXG+wQL0sRrAxE/LJA8vdGKabusXgCaCDeAhorXx/YBRZnkhQfVwfFUpNEI/Nnm6P2
         wntw==
X-Forwarded-Encrypted: i=1; AJvYcCWcDfqJgSRzORH5eOR/+ZytZd5M4p69lcHiL5VN6rz4n13OhxU+SpdtVoGVuceG4TE7mQQoqm0AdXn67YrSLDdt/OMqUyq/LgaDGEIi
X-Gm-Message-State: AOJu0YyEV6ppntiztKszl8fFcaBh1ESUGCQRx1d7b0lCRIwUXFQAxPM4
	0Y00EQMkwvX3NwWAYJKdEQKba7xcadSt+KhvANDPtXPTvU7PNzF4qj/8Uv40Eg==
X-Google-Smtp-Source: AGHT+IGXPjNBSO3LeLRdTU/J0WCodruRNnBcnx9KyvKHRlBNLyysXxdMvyc+ZcZRv6FpAgOfc5/pVw==
X-Received: by 2002:a05:6a00:1301:b0:6e6:2dfd:602d with SMTP id j1-20020a056a00130100b006e62dfd602dmr15455121pfu.25.1709891180143;
        Fri, 08 Mar 2024 01:46:20 -0800 (PST)
Received: from thinkpad ([117.217.183.232])
        by smtp.gmail.com with ESMTPSA id x7-20020a056a00188700b006e64fdc6e69sm717499pfh.147.2024.03.08.01.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 01:46:19 -0800 (PST)
Date: Fri, 8 Mar 2024 15:16:06 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@axis.com
Subject: Re: [PATCH v9 08/10] PCI: dwc: ep: Add a generic
 dw_pcie_ep_linkdown() API to handle LINK_DOWN event
Message-ID: <20240308094606.GG3789@thinkpad>
References: <20240304-pci-dbi-rework-v9-0-29d433d99cda@linaro.org>
 <20240304-pci-dbi-rework-v9-8-29d433d99cda@linaro.org>
 <Zeo0996FscpDSnjL@ryzen>
 <20240308054152.GD3789@thinkpad>
 <ZerSwdxAnN2mUxf0@ryzen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZerSwdxAnN2mUxf0@ryzen>

On Fri, Mar 08, 2024 at 09:56:33AM +0100, Niklas Cassel wrote:
> On Fri, Mar 08, 2024 at 11:11:52AM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Mar 07, 2024 at 10:43:19PM +0100, Niklas Cassel wrote:
> > > On Mon, Mar 04, 2024 at 02:52:20PM +0530, Manivannan Sadhasivam wrote:
> > > > The PCIe link can go to LINK_DOWN state in one of the following scenarios:
> > > > 
> > > > 1. Fundamental (PERST#)/hot/warm reset
> > > > 2. Link transition from L2/L3 to L0
> > > > 
> > > > In those cases, LINK_DOWN causes some non-sticky DWC registers to loose the
> > > > state (like REBAR, PTM_CAP etc...). So the drivers need to reinitialize
> > > > them to function properly once the link comes back again.
> > > > 
> > > > This is not a problem for drivers supporting PERST# IRQ, since they can
> > > > reinitialize the registers in the PERST# IRQ callback. But for the drivers
> > > > not supporting PERST#, there is no way they can reinitialize the registers
> > > > other than relying on LINK_DOWN IRQ received when the link goes down. So
> > > > let's add a DWC generic API dw_pcie_ep_linkdown() that reinitializes the
> > > > non-sticky registers and also notifies the EPF drivers about link going
> > > > down.
> > > > 
> > > > This API can also be used by the drivers supporting PERST# to handle the
> > > > scenario (2) mentioned above.
> > > > 
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-designware-ep.c | 111 ++++++++++++++----------
> > > >  drivers/pci/controller/dwc/pcie-designware.h    |   5 ++
> > > >  2 files changed, 72 insertions(+), 44 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > index 278bdc9b2269..fed4c2936c78 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > @@ -14,14 +14,6 @@
> > > >  #include <linux/pci-epc.h>
> > > >  #include <linux/pci-epf.h>
> > > >  
> > > > -void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
> > > > -{
> > > > -	struct pci_epc *epc = ep->epc;
> > > > -
> > > > -	pci_epc_linkup(epc);
> > > > -}
> > > > -EXPORT_SYMBOL_GPL(dw_pcie_ep_linkup);
> > > > -
> > > >  void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
> > > >  {
> > > >  	struct pci_epc *epc = ep->epc;
> > > > @@ -603,19 +595,56 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
> > > >  	return 0;
> > > >  }
> > > >  
> > > > +static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
> > > > +{
> > > > +	unsigned int offset, ptm_cap_base;
> > > > +	unsigned int nbars;
> > > > +	u32 reg, i;
> > > > +
> > > > +	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
> > > > +	ptm_cap_base = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
> > > > +
> > > > +	dw_pcie_dbi_ro_wr_en(pci);
> > > > +
> > > > +	if (offset) {
> > > > +		reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
> > > > +		nbars = (reg & PCI_REBAR_CTRL_NBAR_MASK) >>
> > > > +			PCI_REBAR_CTRL_NBAR_SHIFT;
> > > > +
> > > > +		for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL)
> > > > +			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, 0x0);
> > > 
> > > If you look at PCI_REBAR_CAP, you will see that it is sticky,
> > > but you have to actually read the databook to see that:
> > > 
> > > "The RESBAR_CTRL_REG_BAR_SIZE field is automatically updated
> > > when you write to RESBAR_CAP_REG_0_REG through the DBI."
> > > 
> > > So the reason why we need to write this register, even though
> > > it is sticky, is to update the RESBAR_CTRL_REG_BAR_SIZE register,
> > > which is not sticky :)
> > > 
> > > (Perhaps we should add that as a comment?)
> > > 
> > 
> > Yeah, makes sense.
> 
> Note that I add a (unrelated) comment related to REBAR_CAP in this patch:
> https://lore.kernel.org/linux-pci/20240307111520.3303774-1-cassel@kernel.org/T/#u
> 
> But once we move/add code to dw_pcie_ep_init_non_sticky_registers(), I think
> that it might be a good "rule" to have a small comment for each write in
> dw_pcie_ep_init_non_sticky_registers() which explains why the code should be
> in dw_pcie_ep_init_non_sticky_registers() instead of dw_pcie_ep_init_registers(),
> even if it just a small:
> 
> /* Field PCI_XXX_YYY.ZZZ is non-sticky */
> writel_dbi(pci, offset + PCI_XXX_YYY, 0);
> 

Why? The function name itself suggests that we are reinitializing non-sticky
registers. So a comment for each write is overkill.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

