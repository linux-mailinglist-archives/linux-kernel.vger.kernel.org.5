Return-Path: <linux-kernel+bounces-83215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FF586905B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5B40B213DB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AC51419B1;
	Tue, 27 Feb 2024 12:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GewXukva"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB7213F006
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036517; cv=none; b=JqJdfXbbSKYBbHJz9irfOkbQV34oIGkd6qg6z+8BqPCGVkr8j8QMI3yEow0/0g4mZSikXi0kRKbCPkMsQE8WZAfh+mipsyc555EapIqBpXJ8KRQHmZnV04FpHPWoWZRa4M9to+mF8RtOK9R1umkRM4wBg/oNmjVhTcAdUL7jeq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036517; c=relaxed/simple;
	bh=OS7E+/QQezCuwcjLO9iExKTfqPQ2LbBPhoHoghWs9UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfyXT0ts7rISe59D+W2MQKgimRHBrLGEwQX6YjHTk9aJxrNs+2dDD9i9cOeJZJKjvlVFCGOBNBQ2dGu5barPlgyIuqE3vNRICcVaD6io7QoQMJP0YT/IB0nw3RMJ8cCTkCF6i8+eHh5rILb8c8or93F1YrXo4vnFzyITOuhtNw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GewXukva; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dcad814986so13795195ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709036515; x=1709641315; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fox2FOTrnn7H7ARtUpilsDQjBFro1sbb1UtQfPOSFHk=;
        b=GewXukvadPyjq8mmPdVrgdexPxxyZVm5taQLw4UE8uzO1qUZywn25e1hJOamHZRCwn
         yY+fYRQ8cx2oj0K3Cn0m0LlooL1bgs+2XFfZJwLd2QmFcpgqANpbYHXxKYXJRTtr/IY5
         54ykV2o0Lwwn2FjqEAhg5xUQj9vmNHZ24yruwhr6w7w6Nw/fz8WwRIg/HvWqz6JmzNTK
         NGvIyAFIELJm2LZ539C/VM+BNa1k9PKPHXKVhOxVPtyXRJBTFys9lI3XaxtMM3MXeo/N
         as6NuVHKMzRAOzFJ9NXZBZFLeLvQptX86wJ0CeHmULxbgBk9ACo8WuXLMj05/Bnsad29
         hBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709036515; x=1709641315;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fox2FOTrnn7H7ARtUpilsDQjBFro1sbb1UtQfPOSFHk=;
        b=q2mmM6069SIbN48E4i6wmpMJ3lRQWXC1s8cRCzg4cM3vCmClxdp9A0QV9BfevS2zk9
         VPGgp4acWrS2HDW83ySofkOwtJlJ2URcSB83yVsJu9w/3gkLDFlKHu17HSl7VcvLRHuU
         2Rety1HhqikBOkAxHM66zUZruPwrF/U9T/UTrj5ph1l+ZJRWN2tphqV1Mxr7oRJfE8Mh
         eKxR6mykEGvdTgYHcc8Y7GCjIiWghI2cH5mh77mg6SJ4DAAixdo5IXUPy1pXvhGIhSTT
         o5F25BVGKNOemEU4SHjzI5fBnFrSQpCsEoVgVf/HfTtpvDC50vDwvHoUZusyZcO1E1Rw
         xWgw==
X-Forwarded-Encrypted: i=1; AJvYcCUa/NC7m636+ySRGkC31iXiarZ9u/Ni0m1SH4zv4yxbSpjxwriqJE4SrVA5f3n5f7Q0uPleD5CqWB0vbqEQ4qO/xMWMJP8bJhlrPR41
X-Gm-Message-State: AOJu0YzWbaKBzw8OoyOITsSjro1LcISODuEfl8OmCLc0J677uHNzJxRF
	zqN8CBNu3NB4UKpx86Eb71m9ex0cIwV7LalfeUBdhGiCMvdC2WcHXovIxzidew==
X-Google-Smtp-Source: AGHT+IHOZyIvtu9udPjddxeRBkjckef05G60ZrgUBTNS/Hn/UgLmDOmQzD5ShaYiOTnnINlgtxpJEw==
X-Received: by 2002:a17:903:181:b0:1dc:b173:f27b with SMTP id z1-20020a170903018100b001dcb173f27bmr4528891plg.32.1709036515334;
        Tue, 27 Feb 2024 04:21:55 -0800 (PST)
Received: from thinkpad ([117.213.97.177])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902b94800b001dba356b96esm1406270pls.306.2024.02.27.04.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 04:21:54 -0800 (PST)
Date: Tue, 27 Feb 2024 17:51:41 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
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
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v8 06/10] PCI: dwc: ep: Call dw_pcie_ep_init_registers()
 API directly from all glue drivers
Message-ID: <20240227122141.GN2587@thinkpad>
References: <20240224-pci-dbi-rework-v8-0-64c7fd0cfe64@linaro.org>
 <20240224-pci-dbi-rework-v8-6-64c7fd0cfe64@linaro.org>
 <ZdzEoXwU42rFCF/W@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZdzEoXwU42rFCF/W@lizhi-Precision-Tower-5810>

On Mon, Feb 26, 2024 at 12:04:33PM -0500, Frank Li wrote:
> On Sat, Feb 24, 2024 at 12:24:12PM +0530, Manivannan Sadhasivam wrote:
> > Currently, dw_pcie_ep_init_registers() API is directly called by the glue
> > drivers requiring active refclk from host. But for the other drivers, it is
> > getting called implicitly by dw_pcie_ep_init(). This is due to the fact
> > that this API initializes DWC EP specific registers and that requires an
> > active refclk (either from host or generated locally by endpoint itsef).
> > 
> > But, this causes a discrepancy among the glue drivers. So to avoid this
> > confusion, let's call this API directly from all glue drivers irrespective
> > of refclk dependency. Only difference here is that the drivers requiring
> > refclk from host will call this API only after the refclk is received and
> > other drivers without refclk dependency will call this API right after
> > dw_pcie_ep_init().
> > 
> > This change will also allow us to remove the "core_init_notifier" flag in
> > the later commits.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pci-dra7xx.c           |  7 +++++++
> >  drivers/pci/controller/dwc/pci-imx6.c             |  8 ++++++++
> >  drivers/pci/controller/dwc/pci-keystone.c         |  9 +++++++++
> >  drivers/pci/controller/dwc/pci-layerscape-ep.c    |  7 +++++++
> >  drivers/pci/controller/dwc/pcie-designware-ep.c   | 22 ----------------------
> >  drivers/pci/controller/dwc/pcie-designware-plat.c |  9 +++++++++
> >  drivers/pci/controller/dwc/pcie-rcar-gen4.c       | 12 +++++++++++-
> >  drivers/pci/controller/dwc/pcie-uniphier-ep.c     | 13 ++++++++++++-
> >  8 files changed, 63 insertions(+), 24 deletions(-)

[...]

> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index ed1f2afd830a..278bdc9b2269 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -729,7 +729,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  	struct device *dev = pci->dev;
> >  	struct platform_device *pdev = to_platform_device(dev);
> >  	struct device_node *np = dev->of_node;
> > -	const struct pci_epc_features *epc_features;
> >  
> >  	INIT_LIST_HEAD(&ep->func_list);
> >  
> > @@ -775,29 +774,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  		goto err_exit_epc_mem;
> >  	}
> >  
> > -	if (ep->ops->get_features) {
> > -		epc_features = ep->ops->get_features(ep);
> > -		if (epc_features->core_init_notifier)
> > -			return 0;
> > -	}
> 
> why remove this check?
> 

There is no point in keeping this check since we are removing the call to
dw_pcie_ep_init_registers() below. But I should've described this change in the
commit message.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

