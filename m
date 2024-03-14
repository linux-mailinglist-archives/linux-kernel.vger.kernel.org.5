Return-Path: <linux-kernel+bounces-102929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9241187B88A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DFEA1F21292
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7325D731;
	Thu, 14 Mar 2024 07:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MaCuFtT1"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9B75C61C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710400943; cv=none; b=riMvyoLyBBu8NypGIXT7Qb11Be33bYV/3ag6nBBW44uBdDZvFooxwP2+x/v+EfZEp1dbgf/YYk+LKM+prNUldSrk9xrgc6cmA4ksRQ5DOUc7WkwXvG0Vp698ODMxae1YXGhkBeetCGv0txQvnAwOiGzF91rrL4+OzpoKaWDFMek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710400943; c=relaxed/simple;
	bh=n+DhiitdzCy6PlCjUMm0H6SMuSpk93mlHftoxOwzpbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=peZr9DO2xnzOu+pU47+0RHEsOdqA9378xfNodFPYKPtujZKABuwrTuiXzM2MIcanWfB9jWXs1UXvhsqXMKFdFYNoQ6S4Kq0Q/ZBG82Xf81hY6DvOlZ1S222bdncW8C3L2LYxELYPB9LlEoeejJJpQS92XiR6u1Y8GAvtms4fOkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MaCuFtT1; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5e4613f2b56so526049a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 00:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710400940; x=1711005740; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Hg0QBhHNwXtR+/hf03RzKTokT9XhPWy1qXzqNjgPKw=;
        b=MaCuFtT1txVGTv/VHGoD12w6G1l1lilNPoJLxc9Mk27j4Jp4utucTNyi1EL6HOWA6j
         MSkMPEw4ssLdo7mU9dzwbWTuxa8hmpPh1hxPQCs4tgCv/X00ByHGlkrQKfwQ7j8x/WWg
         tLFGtQl9FnGQ7yJapj4cA5ye1BTBUBUex34N/xMBspTE29YTDLZxveNwisQ7DUdBtjI7
         jbS5QvJQollqjBeM3P0l8GF1A6BJlbyoML1JQKzZm/FG8PgrcVIB5Y3n07ZbDMWmO+vw
         /EBarJNjanR9EVg0u3psNGmouCfyv3Gaq0T4y70IiXbR4XH8jjZGl3oeGNVf5LfEFw/P
         mdlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710400940; x=1711005740;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Hg0QBhHNwXtR+/hf03RzKTokT9XhPWy1qXzqNjgPKw=;
        b=N4y32igagFbfy82rS3QYkhMj/UVRWphuhyqtCy1/IFHY9atrWMZ6cc/jCIkxVU2tUs
         5Ke0VBJNQY5G6jDrqcntXk7T4ld6h6i6SgGK9yFEmzzWGVmcetQ5rvuWFEYRHhckM2dJ
         pJmXThi0N2WmL2yZ7m9Pu0YmsTDrnxZDmIc+SZz5LA/lPP8kNstVdGobCsKnj52L4AP/
         LbTI40nJceh1xZDPlmbDU9yps9nv7gxddDpK3eal65DUIvUmhFnuzIJ/M0j+Kf6iJa+E
         Dxr0ZOLwMQVeEIfn70Nj78Rc5CL6EfPggBpzpLeMQnLmPhV2Zxq0Cw6Y6zq+b1Tr7yTT
         cejQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5AeZmKentxvFAWbTIFtG0SV75HmbLOZqNQWy6eBtB6gKxO051e/GUTnqxl5bByPIuhyU5Nm5q5EMVTqC7hy47E9M46Co463IOzID5
X-Gm-Message-State: AOJu0YwiuWOAx7UrY1GPi8fVXXIKimhnvPlUyg0CS4ySXqN6uVE0kZgs
	/+OQfq7DhEoVCKtr9N4DQwC5y5FIfWOyIRHWCWJxxZ/A/YKWI+Kk5vHRqGYHuw==
X-Google-Smtp-Source: AGHT+IF/X3aYAW3IYlU6wCv/eec5+n3yuANXgesmj7Xvw84faSW1oJcJKTyrIR8e5yfg2eATFcw1LQ==
X-Received: by 2002:a17:902:7594:b0:1dc:cc77:5668 with SMTP id j20-20020a170902759400b001dccc775668mr937645pll.51.1710400939560;
        Thu, 14 Mar 2024 00:22:19 -0700 (PDT)
Received: from thinkpad ([117.207.30.211])
        by smtp.gmail.com with ESMTPSA id c7-20020a170902d48700b001dddeb10d83sm881090plg.223.2024.03.14.00.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 00:22:19 -0700 (PDT)
Date: Thu, 14 Mar 2024 12:52:07 +0530
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
Subject: Re: [PATCH v9 06/10] PCI: dwc: ep: Call dw_pcie_ep_init_registers()
 API directly from all glue drivers
Message-ID: <20240314072207.GC4831@thinkpad>
References: <20240304-pci-dbi-rework-v9-0-29d433d99cda@linaro.org>
 <20240304-pci-dbi-rework-v9-6-29d433d99cda@linaro.org>
 <ZeolaEIRYmKZjnvT@ryzen>
 <20240308053624.GB3789@thinkpad>
 <ZerUx9Vw_W997LZk@ryzen>
 <20240308094947.GH3789@thinkpad>
 <Zerm_LukciAYCZxD@ryzen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zerm_LukciAYCZxD@ryzen>

On Fri, Mar 08, 2024 at 11:22:52AM +0100, Niklas Cassel wrote:
> On Fri, Mar 08, 2024 at 03:19:47PM +0530, Manivannan Sadhasivam wrote:
> > > > > > @@ -467,6 +467,13 @@ static int dra7xx_add_pcie_ep(struct dra7xx_pcie *dra7xx,
> > > > > >  		return ret;
> > > > > >  	}
> > > > > >  
> > > > > > +	ret = dw_pcie_ep_init_registers(ep);
> > > > > > +	if (ret) {
> > > > > 
> > > > > Here you are using if (ret) to error check the return from
> > > > > dw_pcie_ep_init_registers().
> > > > > 
> > > > > 
> > > > > > index c0c62533a3f1..8392894ed286 100644
> > > > > > --- a/drivers/pci/controller/dwc/pci-keystone.c
> > > > > > +++ b/drivers/pci/controller/dwc/pci-keystone.c
> > > > > > @@ -1286,6 +1286,13 @@ static int ks_pcie_probe(struct platform_device *pdev)
> > > > > >  		ret = dw_pcie_ep_init(&pci->ep);
> > > > > >  		if (ret < 0)
> > > > > >  			goto err_get_sync;
> > > > > > +
> > > > > > +		ret = dw_pcie_ep_init_registers(&pci->ep);
> > > > > > +		if (ret < 0) {
> > > > > 
> > > > > Here you are using if (ret < 0) to error check the return from
> > > > > dw_pcie_ep_init_registers(). Please be consistent.
> > > > > 
> > > > 
> > > > I maintained the consistency w.r.t individual drivers. Please check them
> > > > individually.
> > > > 
> > > > If I maintain consistency w.r.t this patch, then the style will change within
> > > > the drivers.
> > > 
> > > Personally, I disagree with that.
> > > 
> > > All glue drivers should use the same way of checking dw_pcie_ep_init(),
> > > depending on the kdoc of dw_pcie_ep_init().
> > > 
> > > If the kdoc for dw_pcie_ep_init() says returns 0 on success,
> > > then I think that it is strictly more correct to do:
> > > 
> > > ret = dw_pcie_ep_init()
> > > if (ret) {
> > > 	<error handling>
> > > }
> > > 
> > > And if a glue driver doesn't look like that, then I think we should change
> > > them. (Same reasoning for dw_pcie_ep_init_registers().)
> > > 
> > > 
> > > If you read code that looks like:
> > > ret = dw_pcie_ep_init()
> > > if (ret < 0) {
> > > 	<error handling>
> > > }
> > > 
> > > then you assume that is is a function with a kdoc that says it can return 0
> > > or a positive value on success, e.g. a function that returns an index in an
> > > array.
> > > 
> > 
> > But if you read the same function from the individual drivers, it could present
> > a different opinion because the samantics is different than others.
> 
> Is there any glue driver where a positive result from dw_pcie_ep_init() is
> considered valid?
> 
> 
> > 
> > I'm not opposed to keeping the API semantics consistent, but we have to take
> > account of the drivers style as well.
> 
> kdoc > "driver style"
> IMO, but you are the maintainer, I just offered my 50 cents :)
> 

Those valuable 50 cents :) Looking at it again, I think you are right. We
should honor the API over driver's own style.

I've changed the semantics in next version, thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

