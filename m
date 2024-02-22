Return-Path: <linux-kernel+bounces-75888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB23C85F058
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ACA5B239C4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E213B17994;
	Thu, 22 Feb 2024 04:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h5u1EeSn"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3842B1773E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 04:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708574799; cv=none; b=HbS+EvkeZzL92whg4XFIQ3NbL8Y8CZf0wCkptrdGHONeIi5eK1rnYbowHAHB6W+sDEEz8VfyNzpClVRSpV2DP3pg+zMIdiDXUDCvxW6OCVImWdZO/xpyhDAaeub5dkMlHbWw6mPX4sMBkFngUFFi61JTJJf9lBfrpfJTTrXB7Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708574799; c=relaxed/simple;
	bh=Oll19zsaxLp+ZZqDdVlR3wuJZCzW4xzyBuSKxDQ0WU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4AiHR0+dvZjL1F1UkvA4qmHN6DuICLlaHpO+sd1LvyN3walWzbIIG+epqIthrZ6/4bIOf82UJrjbOeoVCFCfZJdQbQY4P0G4BHXNOzSKzrGxGz0S2HgyHJw75DNERxSu3KcpFNmlV23d0yoQdwkMK4JDR8Rle+F+jyOi3hwjC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h5u1EeSn; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso4419979a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 20:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708574797; x=1709179597; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TpJrdqhFrvQ0edeTwSKLJEayZ6GvBYYXFZmjWChyYsw=;
        b=h5u1EeSnh/gglgtUl1AeyBL6uuAnU8yTQ8N5+gCF8/gKTUR3jb89TlJTiLwjcQQk8n
         kx/fY7KhDNS+0FU0mdCCPWgH5tQwiZsIsAITZP7VsZKbKeQEZ0Z4uSN+MPBi/sHzYcP5
         +pX+AYJf/gSEndxEbXpO8oHwr+yBlghmRFSwLTjxNl8WrfICRVRgcKqz2kvY28DU0IQe
         hLp/pC4mslMsewsFmbkyrZS/8/tmV3eHdoLB4tykiI+t5AW7EmezLe50BzI9WyPfkRnz
         eF7QwJZESFw8P4hSdHqkYxMnoQ+GUkle5n15q8GgZvdgkjgEuAuNTsknkASUBTjlgV9f
         YMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708574797; x=1709179597;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TpJrdqhFrvQ0edeTwSKLJEayZ6GvBYYXFZmjWChyYsw=;
        b=DWzjkP9UWlgGGBVBGGFoMQirsJFnXW0cLlT/vf/drBCtgfzLhXtrtUJGbjxWTa5Nsy
         GAVXtlZt03EVOjV9DA4Lz1ULl87BF+r4tolvJ05qGq+ayE8grfOp4a7wbpOU3oq1LQG2
         rL1+7PjwejGH7DgBo1ky7A6Wq4zHrNT9GzNYOhDvVU23OYTG46pUiPtp2SChjcawQZXX
         dUnj0tkiwxBZFpm0E6of78ZZTFV7B4mk1gF66WZffrxel3kBIVO77Z/X52dKlu+pNIpE
         PyJZfcOUFEwYSEr1ME/ff/1QpOKX2WEqdjRcgA1UzsmuUV7l9YkRIkDr3KTHb+m3JjhK
         tS3A==
X-Forwarded-Encrypted: i=1; AJvYcCW7R+Q+1WrZrg8RRD+pQvZ38dbgKnfhERZAnyTDJSYN3Pd2tG3yn1ZLkD6gF6nXWiM4jy7ipPLMNnaww7gKaxh69d4qry0uxlg+59vJ
X-Gm-Message-State: AOJu0YyMvyw7V6ll2crBWB3moxDOA9sPQ9rZLOkhPgRnQ8yaTsracqMT
	BrBLFJ4ruYMTWihtNSHKPuQJfsGAj2BLsdHTKn9iNaMQyyXByLAudYqitILKdw==
X-Google-Smtp-Source: AGHT+IGB0ygkFw7v1Et17l2Q1xivnY3Th2mwC9DGiv4KRj9nV6Y2WYuziamel6IQCMgxOtG3fJToHQ==
X-Received: by 2002:a17:90b:2347:b0:29a:4e7c:c139 with SMTP id ms7-20020a17090b234700b0029a4e7cc139mr207696pjb.28.1708574797366;
        Wed, 21 Feb 2024 20:06:37 -0800 (PST)
Received: from thinkpad ([117.193.212.166])
        by smtp.gmail.com with ESMTPSA id nd12-20020a17090b4ccc00b00297317e5e04sm2729947pjb.52.2024.02.21.20.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 20:06:37 -0800 (PST)
Date: Thu, 22 Feb 2024 09:36:29 +0530
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
Message-ID: <20240222040629.GB3374@thinkpad>
References: <20240221051958.GA11693@thinkpad>
 <20240221182000.GA1533634@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240221182000.GA1533634@bhelgaas>

On Wed, Feb 21, 2024 at 12:20:00PM -0600, Bjorn Helgaas wrote:
> On Wed, Feb 21, 2024 at 10:49:58AM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Feb 20, 2024 at 04:02:40PM -0600, Bjorn Helgaas wrote:
> > > On Wed, Feb 14, 2024 at 05:16:09PM +0530, Manivannan Sadhasivam wrote:
> > > > Currently, PCI core will enable D3 support for PCI bridges only when the
> > > > following conditions are met:
> > > 
> > > Whenever I read "D3", I first have to figure out whether we're talking
> > > about D3hot or D3cold.  Please save me the effort :)
> > 
> > Both actually, that's why I used "D3" as in the spec. I should've explicitly
> > mentioned that in the commit message.
> > 
> > > > 1. Platform is ACPI based
> > > > 2. Thunderbolt controller is used
> > > > 3. pcie_port_pm=force passed in cmdline
> > > 
> > > Are these joined by "AND" or "OR"?  I guess probably "OR"?
> > > 
> > > "... all the following conditions are met" or "... one of the
> > > following conditions is met" would clarify this.
> > 
> > Will use "one of the..."
> > 
> > > > While options 1 and 2 do not apply to most of the DT based
> > > > platforms, option 3 will make the life harder for distro
> > > > maintainers. Due to this, runtime PM is also not getting enabled
> > > > for the bridges.
> > > > 
> > > > To fix this, let's make use of the "supports-d3" property [1] in
> > > > the bridge DT nodes to enable D3 support for the capable
> > > > bridges. This will also allow the capable bridges to support
> > > > runtime PM, thereby conserving power.
> > > 
> > > Looks like "supports-d3" was added by
> > > https://github.com/devicetree-org/dt-schema/commit/4548397d7522.
> > > The commit log mentions "platform specific ways", which suggests maybe
> > > this is D3cold, since D3hot should be supported via PMCSR without any
> > > help from the platform.
> > > 
> > > So I *guess* this really means "platform provides some non-architected
> > > way to put devices in D3cold and bring them back to D0"?
> > 
> > By reading the comments and git log of the pci_bridge_d3_possible()
> > function in drivers/pci/pci.c, we can understand that some of the
> > old bridges do not support both D3hot and D3cold. And to
> > differentiate such bridges, platforms have to notify the OS using
> > some ways.
> > 
> > ACPI has its own implementation [1] and DT uses "supports-d3"
> > property.
> > 
> > And yes, in an ideal world PMCSR should be sufficient for D3hot, but
> > you know the PCI vendors more than me ;)
> 
> So it sounds like this is supposed to cover two cases:
> 
>   1) D3hot doesn't work per spec.  This sounds like a hardware
>      defect in the device that should be a quirk based on
>      Vendor/Device ID, not something in DT.  I don't actually know if
>      this is common, although there are several existing quirks that
>      mention issues with D3.
> 

I'd love to use quirks if we started from that. But right now, quirks are not
used and there are multiple checks based on various factors [1], including
relying on ACPI. So that's the reason I went with DT based approach.

If quirks has to be used now, then it has to be used for both ACPI and DT based
platforms. For DT it won't be an issue since nobody bothered until now, but for
ACPI, we need to add quirks for all the bridges in the wild which is not
feasible.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pci.c#n3116

>   2) The platform doesn't support putting the bridge in D3cold and
>      back to D0.  I don't understand this either because I assumed DT
>      would describe *hardware*, and "supports-d3" might imply the
>      presence of hardware power control, but doesn't tell us how to
>      operate it, and it must be up to a native driver to know how to
>      do it.
> 

"supports-d3" implies that both D3hot and D3cold works as in the spec and the OS
can handle it appropriately. If this is absent, then OS should not transition
the bridge to any of the D3 states. I don't understand what is the confusion
here. This is similar to what we already have for ACPI (whether or not it is
correct is another topic).

> These are two vastly different scenarios, and I would really like to
> untangle them so they aren't conflated.  I see that you're extending
> platform_pci_bridge_d3(), which apparently has that conflation baked
> into it already, but my personal experience is that this is really
> hard to maintain.
> 

I do agree that it is not in a good shape, but there is no better solution other
than making use of the DT property. If you have any better idea, please suggest.

- Mani

> > > > Ideally, D3 support should be enabled by default for the more recent PCI
> > > > bridges, but we do not have a sane way to detect them.
> > > > 
> > > > [1] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pci/pci-pci-bridge.yaml#L31
> 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pci-acpi.c#n976
> > 
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > > This patch is tested on Qcom SM8450 based development board with an out-of-tree
> > > > DT patch.
> > > > 
> > > > NOTE: I will submit the DT patches adding this property for applicable bridges
> > > > in Qcom SoCs separately.
> > > > 
> > > > Changes in v3:
> > > > - Fixed kdoc, used of_property_present() and dev_of_node() (Lukas)
> > > > - Link to v2: https://lore.kernel.org/r/20240214-pcie-qcom-bridge-v2-1-9dd6dbb1b817@linaro.org
> > > > 
> > > > Changes in v2:
> > > > - Switched to DT based approach as suggested by Lukas.
> > > > - Link to v1: https://lore.kernel.org/r/20240202-pcie-qcom-bridge-v1-0-46d7789836c0@linaro.org
> > > > ---
> > > >  drivers/pci/of.c  | 12 ++++++++++++
> > > >  drivers/pci/pci.c |  3 +++
> > > >  drivers/pci/pci.h |  6 ++++++
> > > >  3 files changed, 21 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > > > index 51e3dd0ea5ab..24b0107802af 100644
> > > > --- a/drivers/pci/of.c
> > > > +++ b/drivers/pci/of.c
> > > > @@ -786,3 +786,15 @@ u32 of_pci_get_slot_power_limit(struct device_node *node,
> > > >  	return slot_power_limit_mw;
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
> > > > +
> > > > +/**
> > > > + * of_pci_bridge_d3 - Check if the bridge is supporting D3 states or not
> > > > + *
> > > > + * @node: device tree node of the bridge
> > > > + *
> > > > + * Return: %true if the bridge is supporting D3 states, %false otherwise.
> > > > + */
> > > > +bool of_pci_bridge_d3(struct device_node *node)
> > > > +{
> > > > +	return of_property_present(node, "supports-d3");
> > > > +}
> > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > index d8f11a078924..8678fba092bb 100644
> > > > --- a/drivers/pci/pci.c
> > > > +++ b/drivers/pci/pci.c
> > > > @@ -1142,6 +1142,9 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
> > > >  	if (pci_use_mid_pm())
> > > >  		return false;
> > > >  
> > > > +	if (dev_of_node(&dev->dev))
> > > > +		return of_pci_bridge_d3(dev->dev.of_node);
> > > > +
> > > >  	return acpi_pci_bridge_d3(dev);
> > > >  }
> > > >  
> > > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > > index 2336a8d1edab..10387461b1fe 100644
> > > > --- a/drivers/pci/pci.h
> > > > +++ b/drivers/pci/pci.h
> > > > @@ -635,6 +635,7 @@ int of_pci_get_max_link_speed(struct device_node *node);
> > > >  u32 of_pci_get_slot_power_limit(struct device_node *node,
> > > >  				u8 *slot_power_limit_value,
> > > >  				u8 *slot_power_limit_scale);
> > > > +bool of_pci_bridge_d3(struct device_node *node);
> > > >  int pci_set_of_node(struct pci_dev *dev);
> > > >  void pci_release_of_node(struct pci_dev *dev);
> > > >  void pci_set_bus_of_node(struct pci_bus *bus);
> > > > @@ -673,6 +674,11 @@ of_pci_get_slot_power_limit(struct device_node *node,
> > > >  	return 0;
> > > >  }
> > > >  
> > > > +static inline bool of_pci_bridge_d3(struct device_node *node)
> > > > +{
> > > > +	return false;
> > > > +}
> > > > +
> > > >  static inline int pci_set_of_node(struct pci_dev *dev) { return 0; }
> > > >  static inline void pci_release_of_node(struct pci_dev *dev) { }
> > > >  static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
> > > > 
> > > > ---
> > > > base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> > > > change-id: 20240131-pcie-qcom-bridge-b6802a9770a3
> > > > 
> > > > Best regards,
> > > > -- 
> > > > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

