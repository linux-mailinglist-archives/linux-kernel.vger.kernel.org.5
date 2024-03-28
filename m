Return-Path: <linux-kernel+bounces-111323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DECF6886AA9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56453B23126
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714E13D38F;
	Fri, 22 Mar 2024 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tKuYgS6G"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B403D0D9
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711104391; cv=none; b=XtVMjyy2akid2iDvoijRJRSiu0DGHY9iMuuuf6a45sFeVVqytlp0Z6WTDkjgDNW3Ki9/X1BDi2ttclME8Ey+FCfwQBlSdSp/aH6OpQOUOzD7H6QH7ElVNHRK+XUN/nGMcDEROf1w5HhQvON1MlsEMS9PuJt/l32g3l/P+yOyf+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711104391; c=relaxed/simple;
	bh=QGR7xcLql5isKboVB8Rcqcg5AQuhvZfEMrcZLfakR7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NM2xcXNL/y1h8Bwqy5ZT7NcVgy5FQOqaTkkMfwDspo9WuOkY/8Lf04XYXA+LUvdK3IIE14b92UMDHKZfnBZ0mHxD+biT2vuluTAJy7ez/nMYdS3uKLQvEpIZGQ1JleTr0EDwFhqKRYHrKTEo4pGw7eazGg9Iz5miZnTr5Tv1fek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tKuYgS6G; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-60a0579a931so21101087b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 03:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711104388; x=1711709188; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=97wDgtdQd/tbYmjqEKsHUC2QXzy0inSI9dKHg+PWn5c=;
        b=tKuYgS6GuGgMeeOIuhcgKQU0ESAl2O9Jry9wWLkxXZo/TP/JNEnTxhAFWy6xq0Lsk7
         iNnAKDKb02qVSYJrhEXdBkKd9ZXUgNR3QdMtkll2Hk8kLAN/vCM1wYRKYzV6/gQkjklE
         jTN07p9cE5/k7msyy9R9KeHrohq4U9jpXNEh4TxSI01Tyoo2Hi9taiuyklgRkox6QMQE
         IrtLsl9iCVn5YXswbkQ/RZi7r5CdZiNhrAs1u0xmT2w9D4OevOJ6kEw6pj/nLSG+tnNy
         mK7GdPTwDABZYJWmkN6TD7JjXuNx3p3PSdyO2Y2ecDgOG5HMhHKg1MYENGDTNHrZBR5n
         RuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711104388; x=1711709188;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=97wDgtdQd/tbYmjqEKsHUC2QXzy0inSI9dKHg+PWn5c=;
        b=dEaRG2wQ0++7D53oC4qz0l3lBWtwRmjT6qC0j+raRQ8d1BRGZ+BNTzoXCtFhOzOs6J
         HGjtQR2c3rLMQEJOf/d7j0E8OQOYom2MCVHJ3lQ8QmioUdoDD2GIfkR+6RKFrh1ucM4/
         u93i+kwjZXg2g4oqSTV9X1V6A2t2qlO9pghGGPLt2P1svPtV0yXDHwiv0QnizqKt3tjD
         YCdaaQ+Iu26ZpGj7BcqWgZU0BS9fRlJlreXF/oc9D8L35HCCx7v5AfhybqY4+ljmUES6
         VUvMhA05kjyemvyrDjC+ojYF3eCluJokC3NjDnrs0N4q/Pb/u7PUolsl/G5HNVncwrQk
         QVVg==
X-Forwarded-Encrypted: i=1; AJvYcCUXthfTaRmmXIu4Qxh6gL4hQfJo0yIz+gSkBbAlXyaDdZwoCLYqNLDc/uFjPirJ0BtGHTnsXkhwTHIJcKY3ZMESglkPjUur9wGoaORL
X-Gm-Message-State: AOJu0YzDiMzd9EWLlYJDMYAdAKaDNEQPJQ6Tqm0u9JmpZP017mc0VauU
	+v653L3XajDtaQYITSGVeUfU3gnIJbOfHvgsCBPXXbT4bpO5dlkc2MaYQXjaOJU/1E38jLLMRI8
	=
X-Google-Smtp-Source: AGHT+IHCtSqnlRUT3IQHM6cO7aExK3dHje4/hrZRKFBm1rkVrshemniCoiZ/NZDXGu4R1cb/6z9avQ==
X-Received: by 2002:a05:6a20:d38c:b0:1a3:579f:2c5c with SMTP id iq12-20020a056a20d38c00b001a3579f2c5cmr2534308pzb.53.1711103998405;
        Fri, 22 Mar 2024 03:39:58 -0700 (PDT)
Received: from thinkpad ([2409:40f4:101a:4667:2dab:fb9d:47a0:28fe])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902ec8600b001ddb57a4dffsm1554671plg.132.2024.03.22.03.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 03:39:57 -0700 (PDT)
Date: Fri, 22 Mar 2024 16:09:35 +0530
From: 'Manivannan Sadhasivam' <manivannan.sadhasivam@linaro.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Shradha Todi <shradha.t@samsung.com>, bp@alien8.de, tony.luck@intel.com,
	james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com,
	gustavo.pimentel@synopsys.com, josh@joshtriplett.org,
	lukas.bulwahn@gmail.com, hongxing.zhu@nxp.com,
	pankaj.dubey@samsung.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, vidyas@nvidia.com, gost.dev@samsung.com,
	alim.akhtar@samsung.com, shiju.jose@huawei.com,
	Terry Bowman <Terry.Bowman@amd.com>
Subject: Re: [PATCH v2 0/3] Add support for RAS DES feature in PCIe DW
 controller
Message-ID: <20240322103935.GD3638@thinkpad>
References: <CGME20231130115055epcas5p4e29befa80877be45dbee308846edc0ba@epcas5p4.samsung.com>
 <20231130115044.53512-1-shradha.t@samsung.com>
 <20231130165514.GW3043@thinkpad>
 <000601da3e07$c39e5e00$4adb1a00$@samsung.com>
 <20240104055030.GA3031@thinkpad>
 <0df701da5ff0$df1165a0$9d3430e0$@samsung.com>
 <20240216134921.GH2559@thinkpad>
 <120d01da657e$66b9d3b0$342d7b10$@samsung.com>
 <20240319163315.GD3297@thinkpad>
 <20240320100144.0000056c@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240320100144.0000056c@Huawei.com>

On Wed, Mar 20, 2024 at 10:01:44AM +0000, Jonathan Cameron wrote:
> On Tue, 19 Mar 2024 22:03:15 +0530
> 'Manivannan Sadhasivam' <manivannan.sadhasivam@linaro.org> wrote:
> 
> > On Thu, Feb 22, 2024 at 04:30:47PM +0530, Shradha Todi wrote:
> > > + Borislav, Tony, James, Mauro, Robert
> > > 
> > > Hi All,
> > > 
> > > Synopsys DesignWare PCIe controllers have a vendor specific capability (which
> > > means that this set of registers are only present in DesignWare controllers)
> > > to perform debug operations called "RASDES".
> > > The functionalities provided by this extended capability are:
> > > 
> > > 1. Debug: This has some debug related diagnostic features like holding LTSSM
> > > in certain states, reading the status of lane detection, checking if any PCIe
> > > lanes are broken (RX Valid) and so on. It's a debug only feature used for diagnostic
> > > use-cases.
> > > 
> > > 2. Error Injection: This is a way to inject certain errors in PCIe like LCRC, ECRC,
> > > Bad TLPs and so on. Again, this is a debug feature and generally not used in
> > > functional use-case.
> > > 
> > > 3. Statistical counters: This has 3 parts
> > >  - Error counters
> > >  - Non error counters (covered as part of perf [1])
> > >  - Time based analysis counters (covered as part of perf [1])
> > > 
> > > Selective features of  the above functionality has been implemented
> > > by vendor specific PCIe controller drivers (pcie-tegra194.c) that use
> > > Synopsys DesignWare PCIe controllers.
> > > In order to make it useful to all vendors using DWC controller, we had
> > > proposed a common implementation in DWC PCIe controller directory
> > > (drivers/pci/controller/dwc/) and our original idea was based on debugfs
> > > filesystem. v1 and v2 are mentioned in [2] and [3].
> > > 
> > > We got a suggestion to implement this as part of EDAC framework [3] and
> > > we looked into the same. But as far as I understood, what I am trying to
> > > implement is a very specific feature (only valid for Synopsys DWC PCIe controllers).
> 
> For error part there are (at least superficially) similar features in the PCIe
> standard that we've started thinking about how to support.
> 
> See Flit Logging Extended capablity (7.7.8 in PCIe Base Spec rev6.
> That has the benefit that they are part of the standard so we can
> support them directly in portdrv / EP drivers using some library code in the
> PCI core.
> 

Sounds good. But v6 is a relatively new version and the DWC RAS predates that.
So we still need to support it somehow (either in EDAC or in
drivers/pci/controller/dwc).

> There are other interconnect and PCI PMU drivers that log retries etc which are also basically error
> counts. At least some of that is done through perf today. 
> 

IMO all the RAS support should be exposed through EDAC, otherwise it defeats the
purpose of the subsystem.

- Mani

> 
> > > This doesn't seem to fit in very well with the EDAC framework and we can 
> > > hardly use any of the EDAC framework APIs. We tried implementing a
> > > "pci_driver" but since a function driver will already be running on the EP and
> > > portdrv on the root-complex, we will not be able to bind 2 drivers to a single
> > > PCI device (root-complex or endpoint). Ultimately, what I will be doing is
> > > writing a platform driver with debugfs entries which will be present in EDAC
> > > directory instead of DWC directory.
> 
> The addition of this type of functionality to pordrv is a long running question.
> Everyone wants a solution, I believe some people are looking at it (+CC Terry)
> 
> Terry, another case for your long list.
> 
> For the EP end, this should be fired up by the EP driver, whilst it might be
> infrastructure used on a bunch of devices,  it is a feature of that particular
> EP - so you'd want to provide any functionality in a form that could be used
> by both the EP driver and a nice shiny new portdrv replacement.
> 
> > > 
> > > Can  you please help us out by going through this thread [3] and letting us
> > > know if our understanding is wrong at any point. If you think it is a better
> > > idea to integrate this in the EDAC framework, can you guide me as
> > > to how I can utilize the framework better?
> > > Please let me know if you need any other information to conclude.
> > > 
> > > [1] https://lore.kernel.org/linux-pci/20231121013400.18367-1-xueshuai@linux.alibaba.com/
> > > [2] https://lore.kernel.org/all/20210518174618.42089-1-shradha.t@samsung.com/T/
> > > [3] https://lore.kernel.org/all/20231130115044.53512-1-shradha.t@samsung.com/
> > >   
> > 
> > Gentle ping for the EDAC maintainers.
> > 
> > - Mani
> > 
> > > Thanks,
> > > Shradha
> > >   
> > > > -----Original Message-----
> > > > From: 'Manivannan Sadhasivam' <manivannan.sadhasivam@linaro.org>
> > > > Sent: 16 February 2024 19:19
> > > > To: Shradha Todi <shradha.t@samsung.com>
> > > > Cc: lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> > > > bhelgaas@google.com; jingoohan1@gmail.com;
> > > > gustavo.pimentel@synopsys.com; josh@joshtriplett.org;
> > > > lukas.bulwahn@gmail.com; hongxing.zhu@nxp.com;
> > > > pankaj.dubey@samsung.com; linux-kernel@vger.kernel.org; linux-
> > > > pci@vger.kernel.org; vidyas@nvidia.com; gost.dev@samsung.com
> > > > Subject: Re: [PATCH v2 0/3] Add support for RAS DES feature in PCIe DW
> > > > controller
> > > > 
> > > > On Thu, Feb 15, 2024 at 02:55:06PM +0530, Shradha Todi wrote:  
> > > > >
> > > > >  
> > > > 
> > > > [...]
> > > >   
> > > > > > For the error injection and counters, we already have the EDAC
> > > > > > framework. So adding them in the DWC driver doesn't make sense to me.
> > > > > >  
> > > > >
> > > > > Sorry for late response, was going through the EDAC framework to understand  
> > > > better how we can fit RAS DES support in it. Below are some technical challenges
> > > > found so far:  
> > > > > 1: This debugfs framework proposed [1] can run on both side of the link i.e. RC  
> > > > and EP as it will be a part of the link controller platform driver. Here for the EP
> > > > side the assumption is that it has Linux running, which is primarily a use case for
> > > > chip-to-chip communication.  After your suggestion to migrate to EDAC
> > > > framework we studied and here are the findings:  
> > > > > - If we move to EDAC framework, we need to have RAS DES as a
> > > > > pci_driver which will be binded based on vendor_id and device_id. Our
> > > > > observation is that on EP side system we are unable to bind two
> > > > > function driver (pci_driver), as pci_endpoint_test function driver or
> > > > > some other chip-to-chip function driver will already be bound. On the
> > > > > other hand, on RC side we observed that if we have portdrv enabled in
> > > > > Linux running on RC system, it gets bound to RC controller and then it
> > > > > does not allow EDAC pci_driver to bind. So basically we see a problem
> > > > > here, that we can't have two pci_driver binding to same PCI device
> > > > > 2: Another point is even though we use EDAC driver framework, we may not be  
> > > > able to use any of EDAC framework APIs as they are mostly suitable for memory
> > > > controller devices sitting on PCI BUS. We will end up using debugfs entries just via
> > > > a pci_driver placed inside EDAC framework.
> > > > 
> > > > Please wrap your replies to 80 characters.
> > > > 
> > > > There is no need to bind the edac driver to VID:PID of the device. The edac driver
> > > > can be a platform driver and you can instantiate the platform device from the
> > > > DWC driver. This way, the PCI device can be assocaited with whatever driver, but
> > > > still there can be a separate edac driver for handling errors.
> > > > 
> > > > Regarding API limitation, you should ask the maintainer about the possibility of
> > > > extending them.
> > > >   
> > > > >
> > > > > Please let me know if my understanding is wrong.
> > > > >  
> > > > > > But first check with the perf driver author if they have any plans
> > > > > > on adding the proposed functionality. If they do not have any plan
> > > > > > or not working on it, then look into EDAC.
> > > > > >
> > > > > > - Mani
> > > > > >  
> > > > >
> > > > > Since we already worked and posted patches [1], [2], we will continue to work  
> > > > on this and based on consent from community we will adopt to most suitable
> > > > framework.  
> > > > > We see many subsystems like ethernet, usb, gpu, cxl having debugfs files that  
> > > > give information about the current status of the running system and as of now
> > > > based on our findings, we still feel there is no harm in having debugfs entry based
> > > > support in DesignWare controller driver itself.
> > > > 
> > > > There is no issue in exposing the debug information through debugfs, that's the
> > > > sole purpose of the interface. But here, you are trying to add support for DWC
> > > > RAS feature for which a dedicated framework already exists.
> > > > 
> > > > And there will be more similar requests coming for vendor specific error protocols
> > > > as well. So your investigation could benefit everyone.
> > > > 
> > > > From your above investigation, looks like there are some shortcomings of the
> > > > EDAC framework. So let's get that clarified by writing to the EDAC maintainers
> > > > (keep us in CC). If the EDAC maintainer suggests you to add support for this
> > > > feature in DWC driver itself citing some reasons, then no issues with me.
> > > > 
> > > > - Mani
> > > > 
> > > > --
> > > > மணிவண்ணன் சதாசிவம்  
> > > 
> > >   
> > 
> 

-- 
மணிவண்ணன் சதாசிவம்

