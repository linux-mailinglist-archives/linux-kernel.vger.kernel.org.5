Return-Path: <linux-kernel+bounces-74068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADACC85CF84
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A4BE284DD6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302D839AFF;
	Wed, 21 Feb 2024 05:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sNyUboI7"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935DFA35
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 05:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708492810; cv=none; b=oMjJ2VdVL87+uUd9XV9PnOdZaJ+8qHtolfGb59RhC2iIvri/1SVzrFaJpqvMTjX5DFj7nbTg3eKx+c7C1lvKVzSWiSOw0my9XfHObQcgwACjV7VCslrSkKWH+7TEmwdaRIgY6xMLVJDzbaEqO7lOQiJIJ3cqIz24MpD4h3hJfoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708492810; c=relaxed/simple;
	bh=tU5D19gbAMGh1onifR5Xg6u/MCOTn3Br+s4+IWELJxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+Um0b5ijU16ABHFikPOK1ZEjH7plS04iQ6Y35Q8TXg08iFKg3meXDRR7ZlFurABtyIq6eblcBFIpz312Xi1x3O/snLxpJD80Ykp5Cv0tnNn2yYc11pOzkL7uOQ0WnMmWcemKL2eL2SZDnZ0ZDR56G3X/yi7FWS3gVJ6SWhPsYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sNyUboI7; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c0485fc8b8so5033769b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 21:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708492806; x=1709097606; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pHwFms0+JDvWd5qBV1E84IHlDR/CGNV6i5IheOsfMC8=;
        b=sNyUboI7JjcrA9gmxW+cZnonG5IJJRXd10GdZyjGTTIYKVHW8MHbW8ETRDml2z9+Ti
         SzsDMLrRfHlH0627RFSqY7hH01k8rVXJLVgOk3bWDhMdKABu1ZSEFHls1wAZioO27iBF
         WOIseyq/vtl01juCKYwSdRlb+45owNAbZ+dRb+Fv2WB61wszdpIgCset5yNXgCicMCZj
         DS3qDVuuOmAWnq1BmLFcA4gs9X2lgAgh5HNmbeuWCDTqu6aY6h9PzrnoRF1Y0+iu0lIh
         0FCrV8nhF1HhYBFMK3NuRaTtYMv2MihiIP9heEeTSN2KG22vfzGfXLpixeLvvDa5LQKI
         Xq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708492806; x=1709097606;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pHwFms0+JDvWd5qBV1E84IHlDR/CGNV6i5IheOsfMC8=;
        b=u9cl3yv9jjr0M/JgDXC1ZgkNRmyBx9YuLUkjaJV2K/btHePUbGaF5Afj8oQZ50V77K
         ESjTUW+ZcqytS7CYpzaH1G4yOqT7LvnRAJVkAwow+9q7ncGZVTB/5+qlbtuZfr1RcZXM
         WEPm5IJNcgftLICOL2YXSbn4f+qxZUHYPQpunp2aXOMkK4W5oVyzKD9sjdNfcU8q/WC2
         zTLgqDTYN4iiqdaTZX9F6aa6E6mf/ytpW5PJretaeMnXRN21lomLFve/57LDx+mB1NMB
         +gWTo3xLMxqqkaK5FKZ8Ycn1ccsFx4UZ2BxtaPORGcxl3HDruE56xE6JhjWseIA20ew9
         XTXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjA//hpR0KQVmzDClg5t1GykSSAoXq7putKXmKPO4TYCDjcZQoyzxcab/bjlCRxzQ+ILuQ+Mi4wFRV6BAiuJ/OGAOIIOEaVS8QJR0L
X-Gm-Message-State: AOJu0Yy92fHWK3rEVmSFVrIyJkg7WiSidKXanlHSxpWtmwqEMixgO66i
	P0ZLx236KCcaDbBiPnlEUFrpYCIDMh8IlmlggM/8oX5+jZ3tX0aqlm6nx4ygTA==
X-Google-Smtp-Source: AGHT+IEuT54lpfKbdVp6OsXqUZsETdQ9m2YjGGonqtDb7VAI7upsBNLaAOWSALT/SFOMkvsd/jhc6g==
X-Received: by 2002:a54:470c:0:b0:3c0:3044:dfbc with SMTP id k12-20020a54470c000000b003c03044dfbcmr16658295oik.18.1708492806631;
        Tue, 20 Feb 2024 21:20:06 -0800 (PST)
Received: from thinkpad ([117.207.28.224])
        by smtp.gmail.com with ESMTPSA id w24-20020aa78598000000b006e4695e519csm4360375pfn.194.2024.02.20.21.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 21:20:06 -0800 (PST)
Date: Wed, 21 Feb 2024 10:49:58 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	quic_krichai@quicinc.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Add D3 support for PCI bridges in DT based
 platforms
Message-ID: <20240221051958.GA11693@thinkpad>
References: <20240214-pcie-qcom-bridge-v3-1-3a713bbc1fd7@linaro.org>
 <20240220220240.GA1507934@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240220220240.GA1507934@bhelgaas>

On Tue, Feb 20, 2024 at 04:02:40PM -0600, Bjorn Helgaas wrote:
> On Wed, Feb 14, 2024 at 05:16:09PM +0530, Manivannan Sadhasivam wrote:
> > Currently, PCI core will enable D3 support for PCI bridges only when the
> > following conditions are met:
> 
> Whenever I read "D3", I first have to figure out whether we're talking
> about D3hot or D3cold.  Please save me the effort :)
> 

Both actually, that's why I used "D3" as in the spec. I should've explicitly
mentioned that in the commit message.

> > 1. Platform is ACPI based
> > 2. Thunderbolt controller is used
> > 3. pcie_port_pm=force passed in cmdline
> 
> Are these joined by "AND" or "OR"?  I guess probably "OR"?
> 
> "... all the following conditions are met" or "... one of the
> following conditions is met" would clarify this.
> 

Will use "one of the..."

> > While options 1 and 2 do not apply to most of the DT based platforms,
> > option 3 will make the life harder for distro maintainers. Due to this,
> > runtime PM is also not getting enabled for the bridges.
> > 
> > To fix this, let's make use of the "supports-d3" property [1] in the bridge
> > DT nodes to enable D3 support for the capable bridges. This will also allow
> > the capable bridges to support runtime PM, thereby conserving power.
> 
> Looks like "supports-d3" was added by
> https://github.com/devicetree-org/dt-schema/commit/4548397d7522.
> The commit log mentions "platform specific ways", which suggests maybe
> this is D3cold, since D3hot should be supported via PMCSR without any
> help from the platform.
> 
> So I *guess* this really means "platform provides some non-architected
> way to put devices in D3cold and bring them back to D0"?
> 

By reading the comments and git log of the pci_bridge_d3_possible() function in
drivers/pci/pci.c, we can understand that some of the old bridges do not support
both D3hot and D3cold. And to differentiate such bridges, platforms have to
notify the OS using some ways.

ACPI has its own implementation [1] and DT uses "supports-d3" property.

And yes, in an ideal world PMCSR should be sufficient for D3hot, but you know
the PCI vendors more than me ;)

> > Ideally, D3 support should be enabled by default for the more recent PCI
> > bridges, but we do not have a sane way to detect them.
> > 
> > [1] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pci/pci-pci-bridge.yaml#L31
> 
> This link won't remain accurate as lines are added/removed.  The
> kernel.org cgit allows specific commits
> (https://git.kernel.org/linus/0dd3ee311255) or line references at
> specific commits or tags
> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v6.0#n94)
> 

I'm not aware of such references in github. So I'll reference the commit
instead.

- Mani

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pci-acpi.c#n976

> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> > This patch is tested on Qcom SM8450 based development board with an out-of-tree
> > DT patch.
> > 
> > NOTE: I will submit the DT patches adding this property for applicable bridges
> > in Qcom SoCs separately.
> > 
> > Changes in v3:
> > - Fixed kdoc, used of_property_present() and dev_of_node() (Lukas)
> > - Link to v2: https://lore.kernel.org/r/20240214-pcie-qcom-bridge-v2-1-9dd6dbb1b817@linaro.org
> > 
> > Changes in v2:
> > - Switched to DT based approach as suggested by Lukas.
> > - Link to v1: https://lore.kernel.org/r/20240202-pcie-qcom-bridge-v1-0-46d7789836c0@linaro.org
> > ---
> >  drivers/pci/of.c  | 12 ++++++++++++
> >  drivers/pci/pci.c |  3 +++
> >  drivers/pci/pci.h |  6 ++++++
> >  3 files changed, 21 insertions(+)
> > 
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index 51e3dd0ea5ab..24b0107802af 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -786,3 +786,15 @@ u32 of_pci_get_slot_power_limit(struct device_node *node,
> >  	return slot_power_limit_mw;
> >  }
> >  EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
> > +
> > +/**
> > + * of_pci_bridge_d3 - Check if the bridge is supporting D3 states or not
> > + *
> > + * @node: device tree node of the bridge
> > + *
> > + * Return: %true if the bridge is supporting D3 states, %false otherwise.
> > + */
> > +bool of_pci_bridge_d3(struct device_node *node)
> > +{
> > +	return of_property_present(node, "supports-d3");
> > +}
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index d8f11a078924..8678fba092bb 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -1142,6 +1142,9 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
> >  	if (pci_use_mid_pm())
> >  		return false;
> >  
> > +	if (dev_of_node(&dev->dev))
> > +		return of_pci_bridge_d3(dev->dev.of_node);
> > +
> >  	return acpi_pci_bridge_d3(dev);
> >  }
> >  
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 2336a8d1edab..10387461b1fe 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -635,6 +635,7 @@ int of_pci_get_max_link_speed(struct device_node *node);
> >  u32 of_pci_get_slot_power_limit(struct device_node *node,
> >  				u8 *slot_power_limit_value,
> >  				u8 *slot_power_limit_scale);
> > +bool of_pci_bridge_d3(struct device_node *node);
> >  int pci_set_of_node(struct pci_dev *dev);
> >  void pci_release_of_node(struct pci_dev *dev);
> >  void pci_set_bus_of_node(struct pci_bus *bus);
> > @@ -673,6 +674,11 @@ of_pci_get_slot_power_limit(struct device_node *node,
> >  	return 0;
> >  }
> >  
> > +static inline bool of_pci_bridge_d3(struct device_node *node)
> > +{
> > +	return false;
> > +}
> > +
> >  static inline int pci_set_of_node(struct pci_dev *dev) { return 0; }
> >  static inline void pci_release_of_node(struct pci_dev *dev) { }
> >  static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
> > 
> > ---
> > base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> > change-id: 20240131-pcie-qcom-bridge-b6802a9770a3
> > 
> > Best regards,
> > -- 
> > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 

-- 
மணிவண்ணன் சதாசிவம்

