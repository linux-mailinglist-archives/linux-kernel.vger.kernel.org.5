Return-Path: <linux-kernel+bounces-107841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE6F880263
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A687281DB2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58368BE2;
	Tue, 19 Mar 2024 16:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P1INXCQ6"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191FF20DC8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866008; cv=none; b=RU3Nb4EHmmrREr7QjFDCI+Y1UXnxQakKMuU43Gr/sJieJBbi//X1TV2BmFYVSKNSKPLaqHaMiQiqhXq1lE6vKrgivUrciEq3A2DnjgMmRdOyg6kDAZkDD3vHk2ogAYdUk0ad+vD1yEL1vWaHWkCo8Kr1BdZz2gyd3Nm69l4X+sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866008; c=relaxed/simple;
	bh=PeIAsruLzkLKeE08ndyRTXfNaTUHjpsUFBRVrP/igeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gqm2tRbUqaBvrLr5zHBIZMTvN0Y0Ge+Ny4g8pEofYDRtHXlefuHsnSmmhuGkRHiw0oREtZwM24g624j1ZVjg/nTCL5YkG79u9kb4b7YHPCsL+Uah2tOAjsuCeLNXkrNNIrE979DOfLjmxGvAB1o5nlhOzievBkdyny5ErRTNzGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P1INXCQ6; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e6f6d782e4so3687249b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710866006; x=1711470806; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=21zEQnfxcYpMdB2q3MtSkNSfUlYefH4UFBDqIUczato=;
        b=P1INXCQ6Sj05vE1MDcr1mcdBElgam/U8b5vHWQuP4n1qRQi19d9KKAO7R8znZBLgnc
         Fr72Shr6MmTXNZJFaMA3ddDfunj/q+6AJ+p/lpLdm+P5TX3UMBTMZd2nAO2W53dUuYCD
         OJMEsWCYhj/sifr6jjJtZZK+IJOxWcgT+3HEffxzfMXE4BZfvMbKuBwN/FfWBQpVibjX
         qEcAAKyR88g2rIOb1MtzjZ1WU2dAuNrTZpyr3rDMkIftgFyPXme86DlxJ4/90lg0IOKb
         iUflrYDbv+ijBAAQ4w+vsR5Q2+IKiybz7ytx9ctS/9o00S1QlJ8xgM+CrXa7jx4UXLRS
         UC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710866006; x=1711470806;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=21zEQnfxcYpMdB2q3MtSkNSfUlYefH4UFBDqIUczato=;
        b=kYAVaHh63ATHyXoNAaSeJy73+JVaaDNDtiO4w+cmvrj1seJm5eailDHmlSWkHfJ6Hv
         KUMprMxLjDs/x1Hlz0pZvdJDMlAKbcX1kxljdnxWerqgvaymSgq6thW5IgV73AvUj0Bf
         TfS5esaocyt16zRkyrv+c6FXZavPR1CTrW74ePJbq4H2GXZYsvBu++BWqsaNvEJoAtkH
         rYsfHQ40hyw9xzJHfPrxo2IecdT8Ea8VnCG/38WS9zhc7jDIBGdDV9rOV7yPNwA/5imd
         rLVuJ0C7kBCxJ82RZLF0mF47R9/oP2Q5//4WDNLHqpaxupe+l08x08nlnLOe2lbV7arb
         aj4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWyIZi8bPd+6Bwwq4M0UsdEQO5NNrdgm9hIF1B9onjg2H/T5JYGeFA5JjJj5aAumfq1PPVfGMbReSD+srgtWcQ8Okn4XuvNAHw8NLK4
X-Gm-Message-State: AOJu0Yw0Arm1asX7/SvppaH6VkzsNwRGn/DmilRqISUveVMsVL20FXKJ
	NNINDXz5ri1g0RcGCVCkpHHqQpNOIjEfLos82/FA+AFRdSZDPPL+wnj46Ro6HQ==
X-Google-Smtp-Source: AGHT+IGdOZw8YS4SHpor1EHU9P51zW05feF5360p5IkyjhPjT10QsmUSI91PX9X2UnQj0tJ6FnFOuQ==
X-Received: by 2002:aa7:8883:0:b0:6e6:b32c:501d with SMTP id z3-20020aa78883000000b006e6b32c501dmr17160677pfe.19.1710866005021;
        Tue, 19 Mar 2024 09:33:25 -0700 (PDT)
Received: from thinkpad ([120.56.201.52])
        by smtp.gmail.com with ESMTPSA id lb3-20020a056a004f0300b006e664031f10sm10042675pfb.51.2024.03.19.09.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:33:24 -0700 (PDT)
Date: Tue, 19 Mar 2024 22:03:15 +0530
From: 'Manivannan Sadhasivam' <manivannan.sadhasivam@linaro.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
	mchehab@kernel.org, rric@kernel.org, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
	josh@joshtriplett.org, lukas.bulwahn@gmail.com,
	hongxing.zhu@nxp.com, pankaj.dubey@samsung.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	vidyas@nvidia.com, gost.dev@samsung.com, alim.akhtar@samsung.com
Subject: Re: [PATCH v2 0/3] Add support for RAS DES feature in PCIe DW
 controller
Message-ID: <20240319163315.GD3297@thinkpad>
References: <CGME20231130115055epcas5p4e29befa80877be45dbee308846edc0ba@epcas5p4.samsung.com>
 <20231130115044.53512-1-shradha.t@samsung.com>
 <20231130165514.GW3043@thinkpad>
 <000601da3e07$c39e5e00$4adb1a00$@samsung.com>
 <20240104055030.GA3031@thinkpad>
 <0df701da5ff0$df1165a0$9d3430e0$@samsung.com>
 <20240216134921.GH2559@thinkpad>
 <120d01da657e$66b9d3b0$342d7b10$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <120d01da657e$66b9d3b0$342d7b10$@samsung.com>

On Thu, Feb 22, 2024 at 04:30:47PM +0530, Shradha Todi wrote:
> + Borislav, Tony, James, Mauro, Robert
> 
> Hi All,
> 
> Synopsys DesignWare PCIe controllers have a vendor specific capability (which
> means that this set of registers are only present in DesignWare controllers)
> to perform debug operations called "RASDES".
> The functionalities provided by this extended capability are:
> 
> 1. Debug: This has some debug related diagnostic features like holding LTSSM
> in certain states, reading the status of lane detection, checking if any PCIe
> lanes are broken (RX Valid) and so on. It's a debug only feature used for diagnostic
> use-cases.
> 
> 2. Error Injection: This is a way to inject certain errors in PCIe like LCRC, ECRC,
> Bad TLPs and so on. Again, this is a debug feature and generally not used in
> functional use-case.
> 
> 3. Statistical counters: This has 3 parts
>  - Error counters
>  - Non error counters (covered as part of perf [1])
>  - Time based analysis counters (covered as part of perf [1])
> 
> Selective features of  the above functionality has been implemented
> by vendor specific PCIe controller drivers (pcie-tegra194.c) that use
> Synopsys DesignWare PCIe controllers.
> In order to make it useful to all vendors using DWC controller, we had
> proposed a common implementation in DWC PCIe controller directory
> (drivers/pci/controller/dwc/) and our original idea was based on debugfs
> filesystem. v1 and v2 are mentioned in [2] and [3].
> 
> We got a suggestion to implement this as part of EDAC framework [3] and
> we looked into the same. But as far as I understood, what I am trying to
> implement is a very specific feature (only valid for Synopsys DWC PCIe controllers).
> This doesn't seem to fit in very well with the EDAC framework and we can 
> hardly use any of the EDAC framework APIs. We tried implementing a
> "pci_driver" but since a function driver will already be running on the EP and
> portdrv on the root-complex, we will not be able to bind 2 drivers to a single
> PCI device (root-complex or endpoint). Ultimately, what I will be doing is
> writing a platform driver with debugfs entries which will be present in EDAC
> directory instead of DWC directory.
> 
> Can  you please help us out by going through this thread [3] and letting us
> know if our understanding is wrong at any point. If you think it is a better
> idea to integrate this in the EDAC framework, can you guide me as
> to how I can utilize the framework better?
> Please let me know if you need any other information to conclude.
> 
> [1] https://lore.kernel.org/linux-pci/20231121013400.18367-1-xueshuai@linux.alibaba.com/
> [2] https://lore.kernel.org/all/20210518174618.42089-1-shradha.t@samsung.com/T/
> [3] https://lore.kernel.org/all/20231130115044.53512-1-shradha.t@samsung.com/
> 

Gentle ping for the EDAC maintainers.

- Mani

> Thanks,
> Shradha
> 
> > -----Original Message-----
> > From: 'Manivannan Sadhasivam' <manivannan.sadhasivam@linaro.org>
> > Sent: 16 February 2024 19:19
> > To: Shradha Todi <shradha.t@samsung.com>
> > Cc: lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> > bhelgaas@google.com; jingoohan1@gmail.com;
> > gustavo.pimentel@synopsys.com; josh@joshtriplett.org;
> > lukas.bulwahn@gmail.com; hongxing.zhu@nxp.com;
> > pankaj.dubey@samsung.com; linux-kernel@vger.kernel.org; linux-
> > pci@vger.kernel.org; vidyas@nvidia.com; gost.dev@samsung.com
> > Subject: Re: [PATCH v2 0/3] Add support for RAS DES feature in PCIe DW
> > controller
> > 
> > On Thu, Feb 15, 2024 at 02:55:06PM +0530, Shradha Todi wrote:
> > >
> > >
> > 
> > [...]
> > 
> > > > For the error injection and counters, we already have the EDAC
> > > > framework. So adding them in the DWC driver doesn't make sense to me.
> > > >
> > >
> > > Sorry for late response, was going through the EDAC framework to understand
> > better how we can fit RAS DES support in it. Below are some technical challenges
> > found so far:
> > > 1: This debugfs framework proposed [1] can run on both side of the link i.e. RC
> > and EP as it will be a part of the link controller platform driver. Here for the EP
> > side the assumption is that it has Linux running, which is primarily a use case for
> > chip-to-chip communication.  After your suggestion to migrate to EDAC
> > framework we studied and here are the findings:
> > > - If we move to EDAC framework, we need to have RAS DES as a
> > > pci_driver which will be binded based on vendor_id and device_id. Our
> > > observation is that on EP side system we are unable to bind two
> > > function driver (pci_driver), as pci_endpoint_test function driver or
> > > some other chip-to-chip function driver will already be bound. On the
> > > other hand, on RC side we observed that if we have portdrv enabled in
> > > Linux running on RC system, it gets bound to RC controller and then it
> > > does not allow EDAC pci_driver to bind. So basically we see a problem
> > > here, that we can't have two pci_driver binding to same PCI device
> > > 2: Another point is even though we use EDAC driver framework, we may not be
> > able to use any of EDAC framework APIs as they are mostly suitable for memory
> > controller devices sitting on PCI BUS. We will end up using debugfs entries just via
> > a pci_driver placed inside EDAC framework.
> > 
> > Please wrap your replies to 80 characters.
> > 
> > There is no need to bind the edac driver to VID:PID of the device. The edac driver
> > can be a platform driver and you can instantiate the platform device from the
> > DWC driver. This way, the PCI device can be assocaited with whatever driver, but
> > still there can be a separate edac driver for handling errors.
> > 
> > Regarding API limitation, you should ask the maintainer about the possibility of
> > extending them.
> > 
> > >
> > > Please let me know if my understanding is wrong.
> > >
> > > > But first check with the perf driver author if they have any plans
> > > > on adding the proposed functionality. If they do not have any plan
> > > > or not working on it, then look into EDAC.
> > > >
> > > > - Mani
> > > >
> > >
> > > Since we already worked and posted patches [1], [2], we will continue to work
> > on this and based on consent from community we will adopt to most suitable
> > framework.
> > > We see many subsystems like ethernet, usb, gpu, cxl having debugfs files that
> > give information about the current status of the running system and as of now
> > based on our findings, we still feel there is no harm in having debugfs entry based
> > support in DesignWare controller driver itself.
> > 
> > There is no issue in exposing the debug information through debugfs, that's the
> > sole purpose of the interface. But here, you are trying to add support for DWC
> > RAS feature for which a dedicated framework already exists.
> > 
> > And there will be more similar requests coming for vendor specific error protocols
> > as well. So your investigation could benefit everyone.
> > 
> > From your above investigation, looks like there are some shortcomings of the
> > EDAC framework. So let's get that clarified by writing to the EDAC maintainers
> > (keep us in CC). If the EDAC maintainer suggests you to add support for this
> > feature in DWC driver itself citing some reasons, then no issues with me.
> > 
> > - Mani
> > 
> > --
> > மணிவண்ணன் சதாசிவம்
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

