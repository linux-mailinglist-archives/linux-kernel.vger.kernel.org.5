Return-Path: <linux-kernel+bounces-148731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1138A86B9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFB401C21A13
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298EC1428F9;
	Wed, 17 Apr 2024 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WSMym2Cj"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7692140E3D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365549; cv=none; b=NowZye8IwQj4LMXdlaDPEofudhKPvZpXfq7Jfe4XiBuy64I9doXlBZfW5qXuAR6204pCoClKzZ8C+QdeeaEk71ubGkg8vz6W/VZTOPKb5qKro9Owbv8WSKmw8jL/ICv+vrctWk+YfhGoe3hKNNj3pFzp6WmirBZct5Qo7YEl4DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365549; c=relaxed/simple;
	bh=6CbU8oZoZvfJQ4l7BQ0E7R8sd/rp6YJ97qBSOjVt0SY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYPcURtd3JgAwkaiTq0b5UZDg38+nMSNyZVmfNFD2NtmCMiicH9sZJAShM4NjMHvRQ+kb1RkPCse9KyoeSvVIP1n2FOZemwX3AJRIpkVb7xLGo5jBLKILU9W+dNhk2JiKrkIgcD3MICVUJFsfLZnBGJJRxZrmQMH9wn7Y2paVtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WSMym2Cj; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5e152c757a5so3274703a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 07:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713365546; x=1713970346; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RRcH7cubL16QjSGiD5EC34kxfaFUJ1HeGUtZLh460rs=;
        b=WSMym2CjTC9fso4XghQj6jYLfkG/j2ZLRDMnKSYWvcsWuWfkoGCKhDibsJkkhj2aGr
         Fn87/ZelIhCFxcw7BLJk8q0sk4+Lkqjb7ZYkpGr0kkTLYc+R3DFHauHnGhaXx8iOVDlO
         2O4KEkxyH9glPYBEbdNbjk4wzf5/Kv7+c0cTPBYDQTdTrTcaksYPhH0HAFCAwovl0u2v
         LfQjhdTn9Be4gJwlToiRrSXiHfcCPfVF9buDenW8UuG6UXIeOV/ap/WHHDfOOTxsUdot
         YkGewR9vn0Z7iiCjkPG4zs2fquzZqoVuEKKj2ozERfAOAyaaxQNqfCahY83LvSRakdpR
         FiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713365546; x=1713970346;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RRcH7cubL16QjSGiD5EC34kxfaFUJ1HeGUtZLh460rs=;
        b=HlYgq6L5dC0JtiKU4m6hqbD9R4tnZR5x/hjPQ7X/F9+rM5fTloY8CgOL52Bo//0pZI
         A9i15ucl6//i2TmxKO7tCytT3imwaNqgzOcP1/qB1Cy8i4n5IB1jDjlvX4mbNZxqTA4e
         /aRWNnQ/w46SItpI+tIngu88JDZR/HtGLFmXzxVEbS1Xdsr+COF3NIT56l9TaN3yVtTh
         Z4ibP50LZZWpnYryaJ5XhuH0ePjf5tpSNBomPpFUKhLRdFrN53p+ntAyfsHzlVOQrHKa
         CliGwQCJfeevOZ2/qLFpR7l/PAANdFmd9ra1c+bdu+WYo0UVFletUPMH4vmmQeY7GwqN
         25Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVlVYnR7w5peHgF0D3P3z7EJxz+5QkIxE3weOgwkEAjKsROsE1xQLSZLgVeEDUFaAg529g0daqhuplu8IVk0LRtQmTMIWgtxiulSU9X
X-Gm-Message-State: AOJu0Yw/Tf2WspGTSAX7MZWrFt4nIp2/wMK9du/iTmrC4WYlk7yu61Tb
	jEVN7wf71O4hLLifj5B24jPlspTu3PvzfezOf59JMqWP2hDUzVGPTUjVNrN+3A==
X-Google-Smtp-Source: AGHT+IH4uiQblvN6+qvQcX3FzKjb/+STr6YBJm0netobGBM54Ggr0hc4wAhnknVts4R8UHLZsZKLEQ==
X-Received: by 2002:a17:90a:68c5:b0:2a5:d0cf:3ef with SMTP id q5-20020a17090a68c500b002a5d0cf03efmr14076350pjj.37.1713365545879;
        Wed, 17 Apr 2024 07:52:25 -0700 (PDT)
Received: from thinkpad ([120.60.54.9])
        by smtp.gmail.com with ESMTPSA id l9-20020a17090a070900b002a528a1f907sm1571527pjl.56.2024.04.17.07.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 07:52:25 -0700 (PDT)
Date: Wed, 17 Apr 2024 20:22:04 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 5/5] PCI: dwc: Add generic MSG TLP support for sending
 PME_Turn_Off when system suspend
Message-ID: <20240417145204.GA15187@thinkpad>
References: <20240415-pme_msg-v6-0-56dad968ad3a@nxp.com>
 <20240415-pme_msg-v6-5-56dad968ad3a@nxp.com>
 <20240417101944.GG3894@thinkpad>
 <Zh/ezLdct9sisvhc@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zh/ezLdct9sisvhc@lizhi-Precision-Tower-5810>

On Wed, Apr 17, 2024 at 10:38:04AM -0400, Frank Li wrote:
> On Wed, Apr 17, 2024 at 03:49:44PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Apr 15, 2024 at 03:33:29PM -0400, Frank Li wrote:
> > > Instead of relying on the vendor specific implementations to send the
> > > PME_Turn_Off message, let's introduce a generic way of sending the message
> > > using the MSG TLP.
> > > 
> > > This is achieved by reserving a region for MSG TLP of size
> > > 'pci->region_align', at the end of the first IORESOURCE_MEM window of the
> > > host bridge. And then sending the PME_Turn_Off message during system
> > > suspend with the help of iATU.
> > > 
> > > The reserve space at end is a little bit better than alloc_resource()
> > > because the below reasons.
> > > - alloc_resource() will allocate space at begin of IORESOURCE_MEM window.
> > > There will be a hole when first Endpoint Device (EP) try to alloc a bigger
> > > space then 'region_align' size.
> > > - Keep EP device's IORESOURCE_MEM space unchange with/without this patch.
> > > 
> > 
> > I'd rewrite the above sentence as:
> > 
> > 'The reason for reserving the MSG TLP region at the end of the
> > IORESOURCE_MEM is to avoid generating holes in between. Because, when the region
> > is allocated using allocate_resource(), memory will be allocated from the start
> > of the window. Later, if memory gets allocated for an endpoint of size bigger
> > than 'region_align', there will be a hole between MSG TLP region and endpoint
> > memory.'
> > 
> > > It should be noted that this generic implementation is optional for the
> > > glue drivers and can be overridden by a custom 'pme_turn_off' callback.
> > > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware-host.c | 94 ++++++++++++++++++++++-
> > >  drivers/pci/controller/dwc/pcie-designware.h      |  3 +
> > >  2 files changed, 93 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > index 3a9cb4be22ab2..5001cdf220123 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -398,6 +398,31 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
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
> > 
> > 		/*
> > 		 * Allocate MSG TLP region of size 'region_align' at the end of
> > 		 * the host bridge window.
> > 		 */
> > 
> > > +		res->start = win->res->end - pci->region_align + 1;
> > > +		res->end = win->res->end;
> > > +		res->name = "msg";
> > > +		res->flags = win->res->flags | IORESOURCE_BUSY;
> > > +
> > > +		if (!devm_request_resource(pci->dev, win->res, res))
> > > +			pp->msg_res = res;
> > > +		else
> > > +			devm_kfree(pci->dev, res);
> > 
> > You are explicitly freeing 'msg_res' everywhere. So either drop devm_ or rely
> > on devm to free the memory.
> > 
> > > +	}
> > > +}
> > > +
> > >  int dw_pcie_host_init(struct dw_pcie_rp *pp)
> > >  {
> > >  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > @@ -484,6 +509,16 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> > >  
> > >  	dw_pcie_iatu_detect(pci);
> > >  
> > > +	/*
> > > +	 * Allocate the resource for MSG TLP before programming the iATU outbound window in
> > > +	 * dw_pcie_setup_rc(). Since the allocation depends on the value of 'region_align', this has
> > > +	 * to be done after dw_pcie_iatu_detect().
> > 
> > Please wrap the comments to 80 columns.
> 
> New code style is 100 columns. does comments still stick to 80 columns?
> 

That's only applicable for code and not comments. I also learned that some time
back.

- Mani

> > 
> > > +	 *
> > > +	 * Glue driver need set use_atu_msg before dw_pcie_host_init() if want MSG TLP feature.
> > 
> > How about,
> > 
> > 	 * Glue drivers need to set 'use_atu_msg' before dw_pcie_host_init() to
> > 	 * make use of the generic MSG TLP implementation.
> > 
> > > +	 */
> > > +	if (pp->use_atu_msg)
> > > +		dw_pcie_host_request_msg_tlp_res(pp);
> > > +
> > >  	ret = dw_pcie_edma_detect(pci);
> > >  	if (ret)
> > >  		goto err_free_msi;
> > > @@ -541,6 +576,11 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
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
> > > @@ -702,6 +742,10 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> > >  		atu.pci_addr = entry->res->start - entry->offset;
> > >  		atu.size = resource_size(entry->res);
> > >  
> > > +		/* MSG TLB window resource reserve at one of end of IORESOURCE_MEM resource */
> > 
> > How about,
> > 
> > 		/* Adjust iATU size if MSG TLP region was allocated before */
> > 		if (pp->msg_res && pp->msg_res->parent == entry->res)
> > 			atu.size = resource_size(entry->res) -
> > 					resource_size(pp->msg_res);
> > 		else
> > 			atu.size = resource_size(entry->res);
> > 
> > > +		if (pp->msg_res && pp->msg_res->parent == entry->res)
> > > +			atu.size -= resource_size(pp->msg_res);
> > > +
> > >  		ret = dw_pcie_prog_outbound_atu(pci, &atu);
> > >  		if (ret) {
> > >  			dev_err(pci->dev, "Failed to set MEM range %pr\n",
> > > @@ -733,6 +777,8 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> > >  		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
> > >  			 pci->num_ob_windows);
> > >  
> > > +	pp->msg_atu_index = i;
> > > +
> > >  	i = 0;
> > >  	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
> > >  		if (resource_type(entry->res) != IORESOURCE_MEM)
> > > @@ -838,11 +884,48 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
> > >  }
> > >  EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
> > >  
> > > +/* Using message outbound ATU to send out PME_Turn_Off message for dwc PCIe controller */
> > 
> > No need of this comment.
> > 
> > > +static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
> > > +{
> > > +	struct dw_pcie_ob_atu_cfg atu = { 0 };
> > > +	void __iomem *mem;
> > > +	int ret;
> > > +
> > > +	if (pci->num_ob_windows <= pci->pp.msg_atu_index)
> > > +		return -EINVAL;
> > 
> > 		return -ENOSPC;
> > 
> > > +
> > > +	if (!pci->pp.msg_res)
> > > +		return -EINVAL;
> > 
> > 		return -ENOSPC;
> > - Mani
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

