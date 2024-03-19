Return-Path: <linux-kernel+bounces-106990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC64D87F662
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B5A8B2239E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 04:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547247C094;
	Tue, 19 Mar 2024 04:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YXFZAbBP"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAB67C08D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 04:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710822329; cv=none; b=CQpDLdpTHKQ6xGMBezRlmKmChmJZkcoHjGoqLROp5upBmnqQIj0p924o7Rf6I8K2TQOnFUCkCwLVwQLk3kRQKyp6z/iGSU4kPB3UKNtgkl0ovP7y7RWk67G3P6+Bz8pWedi/TcE4i+LnwuYA2Hr/duu1Y4DZOQefECHO1Mkzztc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710822329; c=relaxed/simple;
	bh=VN66wk4pd+pbC7x5g7MDH8Bc+xnl/oVvzoDN1k4m+1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsAhvPshrKVKAWI6zHJLqQoY58LRKSZ4UBwdy9mY83MJVB35cC4wkxa71itcxYsBVt11OkwHteNrMZcT78PbzLqNNASgL17DKmKJkvgsQwfVxYmjS2x+N90G+xYcoTkFP41xhhkSShD2OZNVISc8rBJCRNch8idgZO69grM8m7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YXFZAbBP; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5a47abe2ff7so1977807eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 21:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710822325; x=1711427125; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DYSxwXFW2D08mopaFSybkujbNsqvikyUbk9X8WRnuB0=;
        b=YXFZAbBP/ClYcy6nVgT+QRFwD35JJFg08WKy+/rOSoisBqYWdOPez1cQ0thz6Z7wDC
         P64AQOvJfzC6bFnnGod99e0nRDtxhRRlH+v5viiZuxSUDw5ihL9TJKnoUOBp1VF2tIck
         0CbcZJW71XaiznUGs8zTXN1KF9CqBcSoMbIP1/XV5ZwWGc1m5rXe9lmOTcNmWc9e473O
         yvL9hye+CF72amnbbopmoBEe4gSNtsmIM17a+G20TViwP/CDpZSBG8L7iBIwdZZ+Spqu
         lOAMub5WitfEZFrhAyEUf+9FqfmRWrRdaetxS7ROS6IHIPDicMCjtUHPbYPp7etGjGst
         vJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710822325; x=1711427125;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DYSxwXFW2D08mopaFSybkujbNsqvikyUbk9X8WRnuB0=;
        b=B2ZGzP8R9BGY2Pka9r3zXldjnVXT8VW4amR+KiqqffiLB7rGKqQLsPUfbWju0JKuLO
         YDNfPIWgDUQJdU11qRGP7n0+0GR8n7bgU3NSlEGFpEund8yKffx/uOdWzOPoye6YI6Uh
         605SXH7ZSt4k05briBoJZWezgH/+mlPN44Up4wiO8gmXMT6ux9p83AftYfUAFpqcnTfT
         dG9pRtAHKC7PydicsZ5/c2F2MNvQ10idZ3KoI4ZtCM0F6k/+DSQHqkQdnsXp1YwSF+/T
         cOo+2kmiWqmN2CapwNcvLLCZ04+xI3HVOoGPobGIGknDnMGdiRnl5bFWrrMAE1PnWiy4
         QESQ==
X-Forwarded-Encrypted: i=1; AJvYcCV40UN21uTkm4O4SJ/0fXb+wqUVi8zBuzs2mL4i53+4ys/f+nsmq/GTNXvRl5qoOWUOwrTKAA8h2QubHC9Ex2Gb14N3NWjWfGzYdic5
X-Gm-Message-State: AOJu0YwMfYVmpatkqMwtXCR0GC7XsharAoaVMz1eWGMYMMqYPHsDvwZk
	Ol6ov+BC9ASWPDAjQW6cz2cR06fuzsXpRHDfVsaeF6PH0G4HueUf8bourEIDJg==
X-Google-Smtp-Source: AGHT+IH/pO37rgSPaTlNhZttxco3gB1vIzcYxEvQOMB+Zx/OQop+kfGcfEZfksBnuYl+SkTSpUmqqQ==
X-Received: by 2002:a05:6359:4c85:b0:17c:23c2:98e4 with SMTP id kk5-20020a0563594c8500b0017c23c298e4mr10136124rwc.3.1710822325286;
        Mon, 18 Mar 2024 21:25:25 -0700 (PDT)
Received: from thinkpad ([120.138.12.142])
        by smtp.gmail.com with ESMTPSA id r68-20020a632b47000000b005e43cce33f8sm8062781pgr.88.2024.03.18.21.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 21:25:24 -0700 (PDT)
Date: Tue, 19 Mar 2024 09:55:19 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 5/5] PCI: dwc: Add common send PME_Turn_Off message
 method
Message-ID: <20240319042519.GA52500@thinkpad>
References: <20240213-pme_msg-v4-0-e2acd4d7a292@nxp.com>
 <20240213-pme_msg-v4-5-e2acd4d7a292@nxp.com>
 <erja6zkhstoaverqtadnqj3nsyluh3sealibpujqmea4pndiuv@icihj7cby2l7>
 <Zd0UERil+A2LgSot@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zd0UERil+A2LgSot@lizhi-Precision-Tower-5810>

On Mon, Feb 26, 2024 at 05:43:29PM -0500, Frank Li wrote:
> On Tue, Feb 27, 2024 at 12:52:45AM +0300, Serge Semin wrote:
> > On Tue, Feb 13, 2024 at 04:50:26PM -0500, Frank Li wrote:
> > > Reserve space at end of first IORESOURCE_MEM window as message TLP MMIO
> > > window. This space's size is 'region_align'.
> > > 
> > > Set outbound ATU map memory write to send PCI message. So one MMIO write
> > > can trigger a PCI message, such as PME_Turn_Off.
> > > 
> > > Add common dwc_pme_turn_off() function.
> > > 
> > > Call dwc_pme_turn_off() to send out PME_Turn_Off message in general
> > > dw_pcie_suspend_noirq() if there are not platform callback pme_turn_off()
> > > exist.
> > > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware-host.c | 93 ++++++++++++++++++++++-
> > >  drivers/pci/controller/dwc/pcie-designware.h      |  2 +
> > >  2 files changed, 91 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > index 267687ab33cbc..5e83756492462 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -393,6 +393,31 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> > >  	return 0;
> > >  }
> > >  
> > > +static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
> > > +{
> > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > +	struct resource_entry *win;
> > > +	struct resource *res;
> > > +
> > > +	win = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> > > +	if (win) {
> > > +		res = devm_kzalloc(pci->dev, sizeof(*res), GFP_KERNEL);
> > > +		if (!res)
> > > +			return;
> > > +
> > > +		/* Reserve last region_align block as message TLP space */
> > > +		res->start = win->res->end - pci->region_align + 1;
> > > +		res->end = win->res->end;
> > > +		res->name = "msg";
> > > +		res->flags = win->res->flags | IORESOURCE_BUSY;
> > > +
> > > +		if (!request_resource(win->res, res))
> > > +			pp->msg_res = res;
> > > +		else
> > > +			devm_kfree(pci->dev, res);
> > > +	}
> > > +}
> > > +
> > >  int dw_pcie_host_init(struct dw_pcie_rp *pp)
> > >  {
> > >  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > @@ -479,6 +504,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> > >  
> > >  	dw_pcie_iatu_detect(pci);
> > >  
> > 
> > > +	/* Need call after dw_pcie_iatu_detect() before dw_pcie_setup_rc() */
> > > +	dw_pcie_host_request_msg_tlp_res(pp);
> > 
> > This may cause regressions for instance if the outbound memory window
> > is small and is fully dedicated for some device like VGA/GPU/etc.
> 
> There are host memory map windows, which are quite big. It will be too
> small if only because one page size windows less.
> 
> Look like it is impossible to dedicated to one device, all pcie devices
> (VGA/GPU) should go through standard pcie probe flow, the bar will be
> allocated from bridge windows space.
> 

No, Sergey's concern is still valid. You are allocating the memory for TLPs at
the end of the existing MEM range. But there is a chance that it could cause
memory hungry devices like GPU to run out of memory in an existing setup.

That being said, I also do not want to hold off merging this series. So let's
make this region opt-in for drivers making use of this feature. This way, if we
migrate to a dedicated 'ranges' region in the future, we can remove the
conditional check and base the check on the existence of the new region.

- Mani

> > 
> > Why not to use a new ranges-based mapping as we discussed earlier:
> > https://lore.kernel.org/linux-pci/20240214061412.GB4618@thinkpad/
> > ?
> 
> If driver can auto alloc from known range, why need static defined in dts
> files.
> 
> static alloc can't resolve small outbound memory windows problem. It may
> disable this feature. 
> 
> > 
> > I know it might be troublesome but still it would be much better
> > and more portable across various platforms.
> > 
> > Bjorn, Lorenzo, Krzysztofm Rob could you please follow the link above
> > and give your opinion about the solution suggested there?
> > 
> > -Serge(y)
> > 
> > > +
> > >  	ret = dw_pcie_edma_detect(pci);
> > >  	if (ret)
> > >  		goto err_free_msi;
> > > @@ -536,6 +564,11 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
> > >  
> > >  	dw_pcie_edma_remove(pci);
> > >  
> > > +	if (pp->msg_res) {
> > > +		release_resource(pp->msg_res);
> > > +		devm_kfree(pci->dev, pp->msg_res);
> > > +	}
> > > +
> > >  	if (pp->has_msi_ctrl)
> > >  		dw_pcie_free_msi(pp);
> > >  
> > > @@ -697,6 +730,10 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> > >  		atu.pci_addr = entry->res->start - entry->offset;
> > >  		atu.size = resource_size(entry->res);
> > >  
> > > +		/* MSG TLB window resource reserve at one of end of IORESOURCE_MEM resource */
> > > +		if (pp->msg_res && pp->msg_res->parent == entry->res)
> > > +			atu.size -= resource_size(pp->msg_res);
> > > +
> > >  		ret = dw_pcie_prog_outbound_atu(pci, &atu);
> > >  		if (ret) {
> > >  			dev_err(pci->dev, "Failed to set MEM range %pr\n",
> > > @@ -728,6 +765,8 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> > >  		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
> > >  			 pci->num_ob_windows);
> > >  
> > > +	pp->msg_atu_index = i;
> > > +
> > >  	i = 0;
> > >  	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
> > >  		if (resource_type(entry->res) != IORESOURCE_MEM)
> > > @@ -833,11 +872,54 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
> > >  }
> > >  EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
> > >  
> > > +/* Using message outbound ATU to send out PME_Turn_Off message for dwc PCIe controller */
> > > +static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
> > > +{
> > > +	struct dw_pcie_ob_atu_cfg atu = { 0 };
> > > +	void __iomem *m;
> > > +	int ret;
> > > +
> > > +	if (pci->num_ob_windows <= pci->pp.msg_atu_index)
> > > +		return -EINVAL;
> > > +
> > > +	if (!pci->pp.msg_res)
> > > +		return -EINVAL;
> > > +
> > > +	atu.code = PCIE_MSG_CODE_PME_TURN_OFF;
> > > +	atu.routing = PCIE_MSG_TYPE_R_BC;
> > > +	atu.type = PCIE_ATU_TYPE_MSG;
> > > +	atu.size = resource_size(pci->pp.msg_res);
> > > +	atu.index = pci->pp.msg_atu_index;
> > > +
> > > +	if (!atu.size) {
> > > +		dev_dbg(pci->dev,
> > > +			"atu memory map windows is zero, please check 'msg' reg in dts\n");
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	atu.cpu_addr = pci->pp.msg_res->start;
> > > +
> > > +	ret = dw_pcie_prog_outbound_atu(pci, &atu);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	m = ioremap(atu.cpu_addr, pci->region_align);
> > > +	if (!m)
> > > +		return -ENOMEM;
> > > +
> > > +	/* A dummy write is converted to a Msg TLP */
> > > +	writel(0, m);
> > > +
> > > +	iounmap(m);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  int dw_pcie_suspend_noirq(struct dw_pcie *pci)
> > >  {
> > >  	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > >  	u32 val;
> > > -	int ret;
> > > +	int ret = 0;
> > >  
> > >  	/*
> > >  	 * If L1SS is supported, then do not put the link into L2 as some
> > > @@ -849,10 +931,13 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
> > >  	if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_ACT)
> > >  		return 0;
> > >  
> > > -	if (!pci->pp.ops->pme_turn_off)
> > > -		return 0;
> > > +	if (pci->pp.ops->pme_turn_off)
> > > +		pci->pp.ops->pme_turn_off(&pci->pp);
> > > +	else
> > > +		ret = dw_pcie_pme_turn_off(pci);
> > >  
> > > -	pci->pp.ops->pme_turn_off(&pci->pp);
> > > +	if (ret)
> > > +		return ret;
> > >  
> > >  	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
> > >  				PCIE_PME_TO_L2_TIMEOUT_US/10,
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > index 703b50bc5e0f1..9e6076aa4c850 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > @@ -341,6 +341,8 @@ struct dw_pcie_rp {
> > >  	struct pci_host_bridge  *bridge;
> > >  	raw_spinlock_t		lock;
> > >  	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
> > > +	int			msg_atu_index;
> > > +	struct resource		*msg_res;
> > >  };
> > >  
> > >  struct dw_pcie_ep_ops {
> > > 
> > > -- 
> > > 2.34.1
> > > 
> > > 

-- 
மணிவண்ணன் சதாசிவம்

