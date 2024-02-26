Return-Path: <linux-kernel+bounces-81810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DFF867A51
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C00C32926C8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246E412CD87;
	Mon, 26 Feb 2024 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mu6GM4X1"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA27D12B16F
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961424; cv=none; b=Nh5D7GH74XNwgu4XHM5nxwrItF1OXj9CbCnQ9g19F+uKXgLGigDlmKnD0tSftex4uP/L/1zRH8aFQZwxPYL+JAFIMm/VjsYJ6HIBHs9+DmI3LTJoFjCL1zxmsB6DoldQqR3VDXwIxbv0Kb1l9sxhbsZJMS9nKE31w4zp5gvNCTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961424; c=relaxed/simple;
	bh=oFEMIGef+CE6PLlxuRtHfu5D8EheQ9NXKbB1G1jvTgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1HJI5jG+BVu9DVH6dcJ3WdRA7/4slkihLvMzlnN6obLZ9c/W/ox1nhYNSMR6Jq1hCNRaatHhQuFjhUtu8Rl+wp/vab5z8tpwkMapmgc8VyTPw158YMqZI/Ls7c5p7qPy0jop9PwVd6DyUcjFHh7D2/Kg7Syxrh1ZVuDhYyc4k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mu6GM4X1; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dc3b4b9b62so27351655ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 07:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708961421; x=1709566221; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nloYymieV56TsCLMArqRtZpx2dEpi1P4zJgPvO3bsZI=;
        b=mu6GM4X1ElC67/WHVxsbz5/5JIgj1REJVMMVrYfxfCKMfhVsNbJmxJHNExz+nXy1C7
         ipFGBGYe5bVP7wVd9BSpU9XnQYuxysGIo9laAUGCDtLHX66wPGlocI321U+U6dlX5now
         +jS1MbQBINv1hMoE/e2InsVKEvrYVq2yjbpGiul4qVIbSK2cA6XfMC7GQs0KZezhwGI+
         5GWIvQivVO/OYUY0Z/VIlcwUPxz09AxIgEhlP1eSuPFxcAHCqAK49aWh9wWppDf6hEpg
         QzspzcFkECpnbAx2TxANzWi28B/8u44xGYLcP3u2fCvP1sJn+hTtey8f+wvFnQbCfEEn
         X3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708961421; x=1709566221;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nloYymieV56TsCLMArqRtZpx2dEpi1P4zJgPvO3bsZI=;
        b=nl7tw9O7SySYcRnyu3eRU42QzoR/9ruK/sLJ1W5A5NdnQ+pPLvSOtDZaT94hJfKJos
         DJ3fc/9WDQ0/a73wwPXIUorG3T8o2AvoAy2TeWWZEPpsJfe9JInHhPhatis7Pk6GGfDw
         8psmJVxzvfhwt2egeB+aHFVQZZkpaOAzFq4E2H+kBktsuYhNTSU7wZ1HzZVeA4LnkUqj
         C5AchFrXSJMmBvxvle4IAQqPgWMVsBnKpkur2gEX5dUy/NnahSvR/fXewsjk0JAzD2kC
         ezCBifdJyUSwGxWXYnaOX7h+bW9eyoRe3sBnpeucvw8EPzr+qaPg9ii2j1bMQWI4V4fr
         N3uA==
X-Forwarded-Encrypted: i=1; AJvYcCVdwk1AbCI13PsEYgGtphJxQ4G8F1BvzvtJZ9C5Wdym3H8o3HTUG7ULeaGUt3ZRBOVW0+nH/uvkEOPPwm6/AG0FD8W2kuNj/yJwJsWl
X-Gm-Message-State: AOJu0YwfxDQCrfOIfLrk1LViE0AgHy08hSKNnKpzCVN6AkcT8JfTGS7f
	/rTk3xoBQEipD0xl3NX/VZWZA9TuwDUCpwO6LsH/2fTezuDrDQyJq8CCCn1NkQ==
X-Google-Smtp-Source: AGHT+IHBP2KQq2wlwcOVJTgkmJGQFKU/wQBEoc9dJwWSd4e5dH5JjnwXusBfF71v01BaIbPLTD8j5Q==
X-Received: by 2002:a17:902:ea0b:b0:1dc:7101:58c0 with SMTP id s11-20020a170902ea0b00b001dc710158c0mr10543808plg.22.1708961421157;
        Mon, 26 Feb 2024 07:30:21 -0800 (PST)
Received: from thinkpad ([117.202.184.81])
        by smtp.gmail.com with ESMTPSA id km6-20020a17090327c600b001dbae7b85b1sm4087272plb.237.2024.02.26.07.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 07:30:20 -0800 (PST)
Date: Mon, 26 Feb 2024 21:00:14 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	mhi@lists.linux.dev, Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH v3 2/5] PCI: dwc: Skip finding eDMA channels count if
 glue drivers have passed them
Message-ID: <20240226153014.GG8422@thinkpad>
References: <20240226-dw-hdma-v3-0-cfcb8171fc24@linaro.org>
 <20240226-dw-hdma-v3-2-cfcb8171fc24@linaro.org>
 <5gzkxdpx6u3jhw5twbncjhtozgekmlzxrpj3m6is3ijadm2svb@f6ng4owyakup>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5gzkxdpx6u3jhw5twbncjhtozgekmlzxrpj3m6is3ijadm2svb@f6ng4owyakup>

On Mon, Feb 26, 2024 at 03:53:20PM +0300, Serge Semin wrote:
> On Mon, Feb 26, 2024 at 05:07:27PM +0530, Manivannan Sadhasivam wrote:
> > In the case of Hyper DMA (HDMA) present in DWC controllers, there is no way
> > the drivers can auto detect the number of read/write channels as like its
> > predecessor embedded DMA (eDMA). So the glue drivers making use of HDMA
> > have to pass the channels count during probe.
> > 
> > To accommodate that, let's skip finding the channels if the channels count
> > were already passed by glue drivers. If the channels count passed were
> > wrong in any form, then the existing sanity check will catch it.
> > 
> > Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> > Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 193fcd86cf93..ce273c3c5421 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -927,13 +927,15 @@ static int dw_pcie_edma_find_channels(struct dw_pcie *pci)
> >  {
> >  	u32 val;
> >  
> > -	if (pci->edma.mf == EDMA_MF_EDMA_LEGACY)
> > -		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> > -	else
> > -		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
> > -
> > -	pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
> > -	pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
> 
> > +	if (!pci->edma.ll_wr_cnt || !pci->edma.ll_rd_cnt) {
> 
> Are you sure that the partly initialized case should be considered as
> a request for the auto-detection? IMO &&-ing here and letting the
> sanity check to fail further would be more correct since thus the
> developer would know about improper initialized data.
> 

We already have the check below. So the partly initialized case will fail
anyway.

- Mani

> -Serge(y)
> 
> > +		if (pci->edma.mf == EDMA_MF_EDMA_LEGACY)
> > +			val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> > +		else
> > +			val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
> > +
> > +		pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
> > +		pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
> > +	}
> >  
> >  	/* Sanity check the channels count if the mapping was incorrect */
> >  	if (!pci->edma.ll_wr_cnt || pci->edma.ll_wr_cnt > EDMA_MAX_WR_CH ||
> > 
> > -- 
> > 2.25.1
> > 

-- 
மணிவண்ணன் சதாசிவம்

