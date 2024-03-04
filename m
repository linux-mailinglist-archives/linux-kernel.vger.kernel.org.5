Return-Path: <linux-kernel+bounces-90086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E9886FA0B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E35281699
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 06:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5334FD51E;
	Mon,  4 Mar 2024 06:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lQXfRR3v"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A16CA73
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 06:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709533604; cv=none; b=PotMxlZ8+x+lvieb1E0opTxCswrCVrlTOO0eTMsQEohRx+nZ02EuR74l0kNHxbos29qgGdEJ+tdSrZkzgSBp/4F+hE5Y8VfsSyMtTENsiQz3ltSUEDtSt5+vhigVPEdgJjNEN1wplv2qgDlktlyhAVtVPuHm1iW0ms8s8/d+L5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709533604; c=relaxed/simple;
	bh=xyQs9VtsBlLZ4Ylk//6q1rePA4Ild7tMp8ripotGz9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFsOab1UqrPcAhIDnzdfWUjcRxnkHRrmoZmm3Sm01LfGRWNQoTkSbcNqc3umQNFD198vDK9qMbekZgRxXpHUM96duxzvAiwg/U0TQFamdVJO5eF0A7TUZ/b9SdbushJvIi4TF4YEfTqUj0+kvF8ecSHu4oJ5OHQe50eiGveg25I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lQXfRR3v; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-68ee2c0a237so31297956d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 22:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709533601; x=1710138401; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f6SxR2LLsQ+g6a8hA+U1gdEFbl1WMiIH+9Qs8EKoBKQ=;
        b=lQXfRR3vwoCfhYH01W4GqhxsLu0h0/CC8JMTV7I0oR1PlbNngSfr/jbr7YiHy0MGhY
         P7fkBBwFxpgs5pm8PvL1WmnzSr2vEDpWmqZozS9LwoQYiB5DMcNmClldKb3KFzGIEYzX
         MZtFQ08YCyjift+H4yOZnP55S94WUJxgKcbTwgNlbmEZN7cEsOsAMcR3zWSRUhTp+6/+
         kAE4wWQL6Bdtm8SZ8KgnQXEhtcvT9D2nIcwRNGnx+OUZQh9YnbJoagR59jaDw/NINolG
         VGySz5htpOQp1U0ApMSQE4iKhi124Lt1iH2mj3M372fcY/mxv6mCoxLYlQ10lmbjRvy3
         85Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709533601; x=1710138401;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f6SxR2LLsQ+g6a8hA+U1gdEFbl1WMiIH+9Qs8EKoBKQ=;
        b=LRf+yhXIzELekMSNFMX3OHXx2POzg3rZQtbN+LNaAcbETlJz21b71tujHmrRoHUnEg
         DQy8hW9Ct1e+QJSySfrl1AEReLardy63ofT0HJIxiwHdTd9mb81dl+GyoR3lwApXr/Jn
         q7Xycdzj6OSAhvrBeRtKTnOZLA/DUiTAnCxuSTcjn3wT/EhRKY1X0rwTP097EKg8mL4h
         O96mhBwV7Pa2Uc0sdogtIHoMADKDdIjpkrrMWMjq9ISYL3LnewxEeZNFami2ahB2WqHi
         cB299nU4FCjErFEIknF5Fr2CqZ89RU5yfl5RLYJ6zetr7yZ9AZ4QQ6v6qoGGxWqAtjXO
         kHOg==
X-Forwarded-Encrypted: i=1; AJvYcCXp6iI59Tg8ft/w66x9ILM83RIBFcW/LDh953EMLke2yxw4B34++JFMaqgTKMAso32vrxQOZRt0w7cd7bYcDlbF1oDZoP3C0JL1Oej/
X-Gm-Message-State: AOJu0Yx3FvG1SSmBG+OQKDiTj9PBo+aBbddNvLFh6Pfv+z9Tju+/ULbq
	NActnHB8o471ROPeJkjAas4Qp6VQ+6GjROXIUgioO+tY7zswGLYsHripHuHG0w==
X-Google-Smtp-Source: AGHT+IGh16i8bKazRcKjIf+8mD1oHLxasc4gBXAtPUXGYbbq10g//g9iQu5psYwYR67+pyj7tPVbIg==
X-Received: by 2002:a05:6214:9aa:b0:690:6e8d:5f8f with SMTP id du10-20020a05621409aa00b006906e8d5f8fmr4779413qvb.7.1709533601528;
        Sun, 03 Mar 2024 22:26:41 -0800 (PST)
Received: from thinkpad ([117.207.30.163])
        by smtp.gmail.com with ESMTPSA id mm9-20020a0562145e8900b00690732feaadsm939670qvb.125.2024.03.03.22.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 22:26:41 -0800 (PST)
Date: Mon, 4 Mar 2024 11:56:25 +0530
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
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 07/10] PCI: dwc: ep: Remove "core_init_notifier" flag
Message-ID: <20240304062625.GG2647@thinkpad>
References: <20240224-pci-dbi-rework-v8-0-64c7fd0cfe64@linaro.org>
 <20240224-pci-dbi-rework-v8-7-64c7fd0cfe64@linaro.org>
 <ZeBpJL1K_vAdmr2M@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZeBpJL1K_vAdmr2M@fedora>

On Thu, Feb 29, 2024 at 12:23:16PM +0100, Niklas Cassel wrote:
> Hello Mani,
> 
> On Sat, Feb 24, 2024 at 12:24:13PM +0530, Manivannan Sadhasivam wrote:
> > "core_init_notifier" flag is set by the glue drivers requiring refclk from
> > the host to complete the DWC core initialization. Also, those drivers will
> > send a notification to the EPF drivers once the initialization is fully
> > completed using the pci_epc_init_notify() API. Only then, the EPF drivers
> > will start functioning.
> > 
> > For the rest of the drivers generating refclk locally, EPF drivers will
> > start functioning post binding with them. EPF drivers rely on the
> > 'core_init_notifier' flag to differentiate between the drivers.
> > Unfortunately, this creates two different flows for the EPF drivers.
> > 
> > So to avoid that, let's get rid of the "core_init_notifier" flag and follow
> > a single initialization flow for the EPF drivers. This is done by calling
> > the dw_pcie_ep_init_notify() from all glue drivers after the completion of
> > dw_pcie_ep_init_registers() API. This will allow all the glue drivers to
> > send the notification to the EPF drivers once the initialization is fully
> > completed.
> > 
> > Only difference here is that, the drivers requiring refclk from host will
> > send the notification once refclk is received, while others will send it
> > during probe time itself.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pci-dra7xx.c           |  2 ++
> >  drivers/pci/controller/dwc/pci-imx6.c             |  2 ++
> >  drivers/pci/controller/dwc/pci-keystone.c         |  2 ++
> >  drivers/pci/controller/dwc/pci-layerscape-ep.c    |  2 ++
> >  drivers/pci/controller/dwc/pcie-designware-plat.c |  2 ++
> >  drivers/pci/controller/dwc/pcie-qcom-ep.c         |  1 -
> >  drivers/pci/controller/dwc/pcie-rcar-gen4.c       |  2 ++
> >  drivers/pci/controller/dwc/pcie-tegra194.c        |  1 -
> >  drivers/pci/controller/dwc/pcie-uniphier-ep.c     |  2 ++
> >  drivers/pci/endpoint/functions/pci-epf-test.c     | 18 +++++-------------
> >  include/linux/pci-epc.h                           |  3 ---
> 
> pcie-artpec6.c:static const struct dw_pcie_ep_ops pcie_ep_ops = {
> pcie-keembay.c:static const struct dw_pcie_ep_ops keembay_pcie_ep_ops = {
> 
> Where is the love for these drivers? ;)
> 

Ah, my grep skills got exposed :(

Will fix them.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

