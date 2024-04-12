Return-Path: <linux-kernel+bounces-142042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 390548A26AB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7C7F1F248A1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A564653C;
	Fri, 12 Apr 2024 06:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="umEAK5SR"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D3540BE3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 06:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712903573; cv=none; b=tZjHUw9cIzHnU/WqCH9DqxwPiYHw6t6WZhNZyVY3IYAqcBcnw880TuwKj4gqjiTLY/ud7olnfleF6th+TEAz1KgdTpVj3y4ExW+gHYGEqOph1mXzm8igmXYSP62ztSPmPx4oQoUewrDiUrm4Oths9h9AaLbbSiwltAAHTzSnqzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712903573; c=relaxed/simple;
	bh=bwU006iDRHmLpYECYxI0IIeu6Yfiw/jYFKnkfTxSxBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPfriigioYFfNiRyXtyB3JgXiCHNPo690jatRy5vadhTA1jAuxUhRIhx0dAT3idSoN1njhj7mf7S0sp5mFAWdoftbCxdj/IHd1HDecp71V01X1Hxve6o9DVwCZhsdoFpjgkV8msb8/Y9Ner1B4NMI5oLzocCj/nuhBW+4mmzKAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=umEAK5SR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e3c9300c65so5860465ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 23:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712903572; x=1713508372; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OZ1TSm7GFHa2Ucou+5Iv5f1vxmDGk25rrnqUZSXXWQw=;
        b=umEAK5SR7rvEjnN4/z50FpxC8TdW/Pf6APRnLK49BddjBpnjZCno0PAVDYA1fCcO2F
         k6IXDlgFey5CIYP66FoJABZIyXK1MwAMC0R3LU76KGAlA05OMhS12NmfA0idJS14fk1u
         CWZneYuDBYM10I36PrRjU41en5cZtfxmzDD9PKuKICgScMl7hbPbWlIDQXvNF1Hdu/m9
         2bMbyS3nDP/ZQ3kZHcNSa/h3bDWcCaDLBy7oYb3rBMnTqRv8JAHoyS/vSz4rUQpgI1m0
         f7en9r8gy9JSrk/DF4bnjTK3jTrmKsm3NlbFotiIREcDh+7ZKPZbulkqgfpeCNwfk4c1
         683g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712903572; x=1713508372;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OZ1TSm7GFHa2Ucou+5Iv5f1vxmDGk25rrnqUZSXXWQw=;
        b=tcpLFANQ0lMepXY5KdYY0dXvqfwWcVPdVMCQif0m4IaQvMBI4z+hI2lYMNhjKNMrny
         LWoaCY30BAAaLHji5P/8swXuwLfwz48VQ2b4EFVawXkZ91vFHfOfRNIsSMYmvtzVulrJ
         cPnJZvPGRrlVUEWb4tuF1YdJkmB2LfcsU9tw74YxwE65BCFN7quNQpTLbFKqC0aCqVe+
         1OqzAJOni59CVBGDi61z8kutrWPce9DrNyPMJV0mt4wQ+hqj/XrwUiwaKtxUyHGTUBNZ
         Fehxolfbx6afIYOANQk8h4L40V5mNf+sIR0hgaRphI/4Xr3ityWUNukTFe5YfeKzmwbr
         INEA==
X-Forwarded-Encrypted: i=1; AJvYcCW+Oa0oOUznE4+ZgV7AA/A6lH4SS0f8XRuUF8NfXT6TVTQORFsDZTELB3AF+5L5+rU7mw1jKpAv6/AbxhlOJhRwM6Qq442g/ztHQr7F
X-Gm-Message-State: AOJu0YzKOWn9PFLJGbhn72tEicEYI29IhLGo27c8Ll0vPe3703jsqDln
	ux5vuzfupsd5vlIIyCCcUy1Ld/Q792P4BZ6GEyLqpC3ESSfLdw2Gs7bFA5bV/rCOexQ4AchnfuE
	=
X-Google-Smtp-Source: AGHT+IFtWVDd1JybnaegLu2KjmDMDdAP9N33LYJF44OL052ORmXPnpbkzGfYpmuz2tVoN9tuYOItQg==
X-Received: by 2002:a17:902:ccce:b0:1e5:4fde:15f with SMTP id z14-20020a170902ccce00b001e54fde015fmr2031560ple.7.1712903571591;
        Thu, 11 Apr 2024 23:32:51 -0700 (PDT)
Received: from thinkpad ([120.56.204.201])
        by smtp.gmail.com with ESMTPSA id w2-20020a1709026f0200b001e43df03096sm472645plk.30.2024.04.11.23.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 23:32:51 -0700 (PDT)
Date: Fri, 12 Apr 2024 12:02:42 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 10/10] PCI: qcom: Implement shutdown() callback to
 properly reset the endpoint devices
Message-ID: <20240412063242.GA2712@thinkpad>
References: <20240401-pci-epf-rework-v2-0-970dbe90b99d@linaro.org>
 <20240401-pci-epf-rework-v2-10-970dbe90b99d@linaro.org>
 <ZgvpnqdjQ39JMRiV@ryzen>
 <20240403133217.GK25309@thinkpad>
 <Zg22Dhi2c7U5oqoz@ryzen>
 <20240410105410.GC2903@thinkpad>
 <Zhanol2xi_E2Ypv3@ryzen>
 <ZhcAKSJCQag6AX09@ryzen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZhcAKSJCQag6AX09@ryzen>

On Wed, Apr 10, 2024 at 11:10:01PM +0200, Niklas Cassel wrote:
> On Wed, Apr 10, 2024 at 04:52:18PM +0200, Niklas Cassel wrote:
> > On Wed, Apr 10, 2024 at 04:24:10PM +0530, Manivannan Sadhasivam wrote:
> > > 
> > > Well, we could prevent the register access during PERST# assert time in the
> > > endpoint, but my worry is that we will end up with 2 version of the cleanup
> > > APIs. Lets take an example of dw_pcie_edma_remove() API which gets called
> > > during deinit and it touches some eDMA registers.
> > > 
> > > So should we introduce another API which just clears the sw data structure and
> > > not touching the registers? And this may be needed for other generic APIs as
> > > well.
> > 
> > I agree that it will be hard to come up with an elegant solution to this
> > problem.
> > 
> > These endpoint controllers that cannot do register accesses to their own
> > controllers' DBI/register space without the RC providing a refclock are
> > really becoming a pain... and the design and complexity of the PCI endpoint
> > APIs is what suffers as a result.
> > 
> > PERST could be asserted at any time.
> > So for your system to not crash/hang by accessing registers in the controller,
> > an EPF driver must be designed with great care to never do any register access
> > when it is not safe...
> > 
> > Perhaps the the EPF core should set the state (i.e. init_complete = false,
> > even before calling the deinit callback in EPF driver, and perhaps even add
> > safe-guards against init_complete in some APIs, so that e.g. a set_bar() call
> > cannot trigger a crash because PERST# is asserted.. but even then, it could
> > still be asserted in the middle of set_bar()'s execution.)
> > 
> > 
> > Looking at the databook, it looks like core_clk is derived from pipe_clk
> > output of the PHY. The PHY will either use external clock or internal clock.
> > 
> > 4.6.2 DBI Protocol Transactions
> > it looks like core_clk must be active to read/write the DBI.
> > 
> > I really wish those controllers could e.g. change the clock temporarily
> > using a mux, so that it could still perform DBI read/writes when there is
> > not external refclk... Something like pm_sel_aux_clk selecting to use the
> > aux clk instead of core_clk when in low power states.
> > But I don't know the hardware well enough to know if that is possible for
> > the DBI, so that might just be wishful thinking...
> 
> 
> Looking at the rock5b SBC (rockchip rk3588), the PHY refclk can either
> be taken from
> -a PLL internally from the SoC.
> or
> -an external clock on the SBC.
> 
> There does not seem to be an option to get the refclk as an input from
> the PCIe slot. (The refclk can only be output to the PCIe slot.)
> 
> So when running two rock5b SBC, you cannot use a common clock for the RC
> and the EP side, you have to use a separate reference clock scheme,
> either SRNS or SRIS.
> 
> Since I assume that you use two qcom platforms of the same model
> (I remember that you wrote that you usually test with
> qcom,sdx55-pcie-ep somewhere.)
> Surely this board must be able to supply a reference clock?
> (How else does it send this clock to the EP side?)
> 

It is not the same model. It is the same SoC but with different base boards.
FWIW, I'm testing with both SDX55 and SM8450 SoC based boards.

So the Qcom EP has no way to generate refclk internally (I double checked this)
and it has to rely on refclk from either host or a separate clock source.

But in most of the board designs they connect to host refclk by default.

> So... why can't you run in SRNS or SRIS mode, where the EP provides
> it's own clock?
> 

As per the discussion I had with Qcom PCIe team, they that said SRIS is only
available at the host side to supply independent clock to the EP. But that
requires changes to the PHY sequence and could also result in preformance drop.
Also this mode is available only on new SoCs but not on older ones like SDX55.

So I don't think this is a viable option.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

