Return-Path: <linux-kernel+bounces-151383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 117188AADE4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDD44281AFF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F0383A09;
	Fri, 19 Apr 2024 11:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J8NumG+q"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB777823D9
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713527202; cv=none; b=IJ3Zr1q8wOhu2lUnfLydGMDXc6XNwog6OcaqFFwG2qJUwZarLSOrh0ED9C8zmu1lnx5t4X7seRkrbBQbObGz2udbWJ+brDG6BkNjRz5QusmujKblRcextZcHTU12BsidsAABBX4be4ymTgN7pzWrreCGQIxyvbt98TX/5Hy9a0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713527202; c=relaxed/simple;
	bh=Z+5PnQstdz12unLr6o7KdhlMebiLBth/tiY2nW6b1g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtKrz9wsZIzpYTwvMCA7T0RTR0lNKi964wMcE6X+zKwkPi0Zi4nm8H0D62vYf0/zobwHR+XntmcfKEBzG7QzHsweVEeV1ff6RYZyU8XmSYNBjkcmU+AI3FcmH38SznCDVsY5EtWCwzf9QTdGRYW5VJNoWcgV1wSPbj9VOmCkBYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J8NumG+q; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ed627829e6so2086223b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 04:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713527200; x=1714132000; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GTMLAnugiBw3dWYCKfju/5rwkj08UNff4qYOo0W3/Mg=;
        b=J8NumG+qjgGvt4IGM8DwBZmMvoVY3++IGdNPdbFteAD+tOR+LxG1JPnUvdxCax0yfN
         A9Ve9yN/wxkpQOvXa+o/94kdkYStay/RtZ1gUT+L7K9GbEWAKfGMqynpXVT5u6uN0yQg
         KH8aRDqq2XPehnX3aW5jTucHnJHiuYrdRtiqIX012O9PPbGiW9BXIh1P0yImLut4ckZ9
         yXF3td/PTI0R2fEHDrErkI6mORrp4G7xX1wtM6xThtdwBRLembNJWtXz5tgoTgiI1Zbh
         P1+LFDQAcltOWj4pzBvzuN2XzUsugHd8dg5qOi0KM1kSAw+/oNO4YTS0NRDGCX8OLWtY
         wk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713527200; x=1714132000;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTMLAnugiBw3dWYCKfju/5rwkj08UNff4qYOo0W3/Mg=;
        b=CtL4lOr6x4HTGTOauF95lpoYi+GLYqmj6gEPZoCu+iLALvF1aUP5eLKbtRJleU0UT8
         JO3rTw8FCubq6j/HDPDba4yJg7iYHyJvolHw4pa675fPtz60SrEIPSKwzN8i9H/f1AWo
         UE3EoRk9GQDcmh6tcb5e3lG109FoM38YyNzQ4g+Y1PTt4fgdUZr6+1uLJLhy3SmIZqFV
         bpM0Rw+pule09ItL+ZQBpyH3VJpl5PfXaglYmEHk7aGwzEyFvoNI+rtN3M5/YPvRlZ2r
         9nGFZ7EePvq9DeGYDgZwu5/mgqSOl5JIHZ4BTiijUMlT1toigikpUPb9MCQkIWXjEZeh
         coXA==
X-Forwarded-Encrypted: i=1; AJvYcCVYL8R9RIECen3slOB4mVUCLqd752W9kqXb7gPOFlci2zmSmyjrYSYusF5Lnd5s66GjZWsitH+JvkSkxogZZQhR6JNbxB/4NHTcf5mV
X-Gm-Message-State: AOJu0YzpIGHZV/S5oBw3vTvlulu6AHatf9UDa2q8GxZaY3KVIzF1rf8g
	hp1kBFgKNJZ3dwuRVDBftvLZLjfMGbSftioJDEvn7kYdbOrVI1LxOwEi01UF4g==
X-Google-Smtp-Source: AGHT+IGoeU3eLSHGnW/Igh6/PaoVXNbmoJf+pid7O9XRyDCan+9n9T8XLGseBxtm5bNETZe2cgOMeA==
X-Received: by 2002:a05:6a20:9150:b0:1ac:34cc:b323 with SMTP id x16-20020a056a20915000b001ac34ccb323mr2469551pzc.33.1713527199827;
        Fri, 19 Apr 2024 04:46:39 -0700 (PDT)
Received: from thinkpad ([220.158.156.51])
        by smtp.gmail.com with ESMTPSA id fk12-20020a056a003a8c00b006e6a684a6ddsm3029904pfb.220.2024.04.19.04.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:46:39 -0700 (PDT)
Date: Fri, 19 Apr 2024 17:16:33 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v8 5/5] PCI: dwc: Add generic MSG TLP support for sending
 PME_Turn_Off when system suspend
Message-ID: <20240419114633.GB7195@thinkpad>
References: <20240418-pme_msg-v8-0-a54265c39742@nxp.com>
 <20240418-pme_msg-v8-5-a54265c39742@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240418-pme_msg-v8-5-a54265c39742@nxp.com>

On Thu, Apr 18, 2024 at 12:04:28PM -0400, Frank Li wrote:
> Instead of relying on the vendor specific implementations to send the
> PME_Turn_Off message, let's introduce a generic way of sending the message
> using the MSG TLP.
> 
> This is achieved by reserving a region for MSG TLP of size
> 'pci->region_align', at the end of the first IORESOURCE_MEM window of the
> host bridge. And then sending the PME_Turn_Off message during system
> suspend with the help of iATU.
> 
> The reason for reserving the MSG TLP region at the end of the
> IORESOURCE_MEM is to avoid generating holes in between. Because, when the
> region is allocated using allocate_resource(), memory will be allocated
> from the start of the window. Later, if memory gets allocated for an
> endpoint of size bigger than 'region_align', there will be a hole between
> MSG TLP region and endpoint memory.
> 
> It should be noted that this generic implementation is optional for the
> glue drivers and can be overridden by a custom 'pme_turn_off' callback.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 95 +++++++++++++++++++++--
>  drivers/pci/controller/dwc/pcie-designware.h      |  3 +
>  2 files changed, 93 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 3a9cb4be22ab2..a0822d5371bc5 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -398,6 +398,32 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>  	return 0;
>  }
>  
> +static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct resource_entry *win;
> +	struct resource *res;
> +
> +	win = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> +	if (win) {
> +		res = devm_kzalloc(pci->dev, sizeof(*res), GFP_KERNEL);
> +		if (!res)
> +			return;
> +
> +		/*
> +		 * Allocate MSG TLP region of size 'region_align' at the end of
> +		 * the host bridge window.
> +		 */
> +		res->start = win->res->end - pci->region_align + 1;
> +		res->end = win->res->end;
> +		res->name = "msg";
> +		res->flags = win->res->flags | IORESOURCE_BUSY;
> +
> +		if (!devm_request_resource(pci->dev, win->res, res))
> +			pp->msg_res = res;
> +	}
> +}
> +
>  int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -484,6 +510,18 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  
>  	dw_pcie_iatu_detect(pci);
>  
> +	/*
> +	 * Allocate the resource for MSG TLP before programming the iATU
> +	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
> +	 * on the value of 'region_align', this has to be done after
> +	 * dw_pcie_iatu_detect().
> +	 *
> +	 * Glue drivers need to set 'use_atu_msg' before dw_pcie_host_init() to
> +	 * make use of the generic MSG TLP implementation.
> +	 */
> +	if (pp->use_atu_msg)
> +		dw_pcie_host_request_msg_tlp_res(pp);
> +
>  	ret = dw_pcie_edma_detect(pci);
>  	if (ret)
>  		goto err_free_msi;
> @@ -700,7 +738,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  		atu.type = PCIE_ATU_TYPE_MEM;
>  		atu.cpu_addr = entry->res->start;
>  		atu.pci_addr = entry->res->start - entry->offset;
> -		atu.size = resource_size(entry->res);
> +
> +		/* Adjust iATU size if MSG TLP region was allocated before */
> +		if (pp->msg_res && pp->msg_res->parent == entry->res)
> +			atu.size = resource_size(entry->res) -
> +					resource_size(pp->msg_res);
> +		else
> +			atu.size = resource_size(entry->res);
>  
>  		ret = dw_pcie_prog_outbound_atu(pci, &atu);
>  		if (ret) {
> @@ -733,6 +777,8 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
>  			 pci->num_ob_windows);
>  
> +	pp->msg_atu_index = i;
> +
>  	i = 0;
>  	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
>  		if (resource_type(entry->res) != IORESOURCE_MEM)
> @@ -838,11 +884,47 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
>  
> +static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
> +{
> +	struct dw_pcie_ob_atu_cfg atu = { 0 };
> +	void __iomem *mem;
> +	int ret;
> +
> +	if (pci->num_ob_windows <= pci->pp.msg_atu_index)
> +		return -ENOSPC;
> +
> +	if (!pci->pp.msg_res)
> +		return -ENOSPC;
> +
> +	atu.code = PCIE_MSG_CODE_PME_TURN_OFF;
> +	atu.routing = PCIE_MSG_TYPE_R_BC;
> +	atu.type = PCIE_ATU_TYPE_MSG;
> +	atu.size = resource_size(pci->pp.msg_res);
> +	atu.index = pci->pp.msg_atu_index;
> +
> +	atu.cpu_addr = pci->pp.msg_res->start;
> +
> +	ret = dw_pcie_prog_outbound_atu(pci, &atu);
> +	if (ret)
> +		return ret;
> +
> +	mem = ioremap(atu.cpu_addr, pci->region_align);
> +	if (!mem)
> +		return -ENOMEM;
> +
> +	/* A dummy write is converted to a Msg TLP */
> +	writel(0, mem);
> +
> +	iounmap(mem);
> +
> +	return 0;
> +}
> +
>  int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  {
>  	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>  	u32 val;
> -	int ret;
> +	int ret = 0;
>  
>  	/*
>  	 * If L1SS is supported, then do not put the link into L2 as some
> @@ -854,10 +936,13 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  	if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_ACT)
>  		return 0;
>  
> -	if (!pci->pp.ops->pme_turn_off)
> -		return 0;
> +	if (pci->pp.ops->pme_turn_off)
> +		pci->pp.ops->pme_turn_off(&pci->pp);
> +	else
> +		ret = dw_pcie_pme_turn_off(pci);
>  
> -	pci->pp.ops->pme_turn_off(&pci->pp);
> +	if (ret)
> +		return ret;
>  
>  	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
>  				PCIE_PME_TO_L2_TIMEOUT_US/10,
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 703b50bc5e0f1..dca5de4c6e877 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -341,6 +341,9 @@ struct dw_pcie_rp {
>  	struct pci_host_bridge  *bridge;
>  	raw_spinlock_t		lock;
>  	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
> +	bool			use_atu_msg;
> +	int			msg_atu_index;
> +	struct resource		*msg_res;
>  };
>  
>  struct dw_pcie_ep_ops {
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

