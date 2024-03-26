Return-Path: <linux-kernel+bounces-118481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D778F88BB90
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2618B2195B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A234130AEC;
	Tue, 26 Mar 2024 07:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K44Vpity"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A5A130A48
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 07:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711439079; cv=none; b=sSyPGrsKMoVvPgJrwaysxqE8FIgTi3uIU9MYsxdNP+2wObxeQ/WivUJiNin0D4U7wGKwBreJEL8P/qrJ35wDI6hZYUT/1rWV+fTKGD+DaSYZWEXd2PiWDvDLJAe4nu++o0lO6zZe84mG7FPE0sNh8im7vj4Hi6Nvf6vgzXg3tyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711439079; c=relaxed/simple;
	bh=MsrkW69p8rySCRtLMEt7t+ExHfkgy2bgx4K2VLJtRIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSqPDdbX1xbQuqnYbLltLTVkN5BvxEMIV08pXF0Uym5kKOqK3s0OfHIeUYgeUOPk39kYg60Dw3SeADQ6r0AOCXTrqs2Ycwss7czDxn+QmhvHP/eIBaISO7jyPD/yUAK0CgaQWQEmWlzlyigACLpgaPMRoxgAHkAbzVsApZY/Nv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K44Vpity; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2a0782f0da5so967248a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 00:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711439077; x=1712043877; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ltBMUKgzn3zhp60fMyljAq7QO/sGMekj2XSf0AJieWY=;
        b=K44Vpityl70wxDk+ib6CnDpqrxYFhnGK9av1CsMF9Ys4/iwNWdrVIi+FEhyxvce0CB
         gU9hm41RFiiUA963wzug+ypG3N2Ze6bOC1Raaxul8rWiyjM1J2EeaG/beRff2Lh8fMFH
         pmn6GVf8JKeX8kdB8Q8AEL7lKz3Ouv63hzVoKHz+7dTaH24WI13qMZCwb+3NEfN221+1
         JblUd0Gt4ZWQUIK0y1Trvniu5goKH17Up88VAPGiIaodMO3IJLVWc6zWyf2Zwj58PdXN
         DRHDOioCrIR0i6tMhz2P/tUnusQ+BUuVf4Y7zf2iV8wppt84ptibSximcUl1xjBzj8FD
         Q5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711439077; x=1712043877;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ltBMUKgzn3zhp60fMyljAq7QO/sGMekj2XSf0AJieWY=;
        b=IR/f/GDaBlj9eVYXYzY28IkCyGmGv0+mMifhh+vcH8hXHL4CPWmsc3mrzoKF4W4OVJ
         1VC5r6xTNxlDoTIo/Iw3ScsWmhxS58E/jn7L5MXCLjSIrptLyRxC1YNXDkfQBl+si8fP
         REgdmE4LKx1KN9Mi2/gd5uSNiU6sw8R52cpMpTP+MP1dhxn+jJkNgdhvC266H/Xy09xP
         Emg4IM9vLvSpxXKIh7XKV0fqWtK4sxYRSCbEf/8kWfQrcKuFXdfM9IdOGVqOim+DCnKS
         SukUIS4lHdpR2oSxyEBMBCfm5g4qOG6SHPydgoMBg7gvuEobFiHv/wWP5/1/EeN8KZEG
         8hRw==
X-Forwarded-Encrypted: i=1; AJvYcCWBZsgYkoUnc8SIGl7tWCbbvjPYrXMzst+iArK6HQBq6Kj0+Y/lB0CEG/7MuVqLz9CdDrtWoKwoVSc1XbQAT7bjMTov5TTDZ0gAEaDe
X-Gm-Message-State: AOJu0YyMzqDjwcnIwtHjQS5N2ENgb+wRAL+0RMdUP8SEpfy8djz6mbb6
	/HXF78cTHJdLiMS+B5wHOoGpcJeGDHDRflKULjcWH562OfWT8KMc/EySAeRbSQ==
X-Google-Smtp-Source: AGHT+IFpNW25eFjP8EzgblCKW0udVOJeCu+1W8FIYLgYCGlpAIzgTkcJLGCCZzYcvI56FkcxZcDtgA==
X-Received: by 2002:a17:90a:ec0d:b0:2a0:61ca:8d8a with SMTP id l13-20020a17090aec0d00b002a061ca8d8amr1054642pjy.6.1711439077214;
        Tue, 26 Mar 2024 00:44:37 -0700 (PDT)
Received: from thinkpad ([117.207.28.168])
        by smtp.gmail.com with ESMTPSA id q67-20020a17090a17c900b0029c5ee381dfsm8460725pja.26.2024.03.26.00.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 00:44:36 -0700 (PDT)
Date: Tue, 26 Mar 2024 13:14:29 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 01/11] PCI: qcom-ep: Disable resources unconditionally
 during PERST# assert
Message-ID: <20240326074429.GC9565@thinkpad>
References: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
 <20240314-pci-epf-rework-v1-1-6134e6c1d491@linaro.org>
 <Zf2s9kTMlZncldWx@ryzen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zf2s9kTMlZncldWx@ryzen>

On Fri, Mar 22, 2024 at 05:08:22PM +0100, Niklas Cassel wrote:
> On Thu, Mar 14, 2024 at 08:53:40PM +0530, Manivannan Sadhasivam wrote:
> > All EP specific resources are enabled during PERST# deassert. As a counter
> > operation, all resources should be disabled during PERST# assert. There is
> > no point in skipping that if the link was not enabled.
> > 
> > This will also result in enablement of the resources twice if PERST# got
> > deasserted again. So remove the check from qcom_pcie_perst_assert() and
> > disable all the resources unconditionally.
> > 
> > Fixes: f55fee56a631 ("PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver")
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom-ep.c | 6 ------
> >  1 file changed, 6 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > index 2fb8c15e7a91..50b1635e3cbb 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > @@ -500,12 +500,6 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
> >  static void qcom_pcie_perst_assert(struct dw_pcie *pci)
> >  {
> >  	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
> > -	struct device *dev = pci->dev;
> > -
> > -	if (pcie_ep->link_status == QCOM_PCIE_EP_LINK_DISABLED) {
> > -		dev_dbg(dev, "Link is already disabled\n");
> > -		return;
> > -	}
> >  
> >  	dw_pcie_ep_cleanup(&pci->ep);
> >  	qcom_pcie_disable_resources(pcie_ep);
> 
> Are you really sure that this is safe?
> 
> I think I remember seeing some splat in dmesg if some clks, or maybe it
> was regulators, got disabled while already being disabled.
> 
> Perhaps you could test it by simply calling:
> qcom_pcie_disable_resources();
> twice here, and see if you see and splat in dmesg.
> 

Calling the disable_resources() function twice will definitely result in the
splat. But here PERST# is level triggered, so I don't see how the EP can see
assert twice.

Am I missing something?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

