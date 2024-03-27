Return-Path: <linux-kernel+bounces-120363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0E988D64A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29D141C24112
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F68F1CAAF;
	Wed, 27 Mar 2024 06:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BpAs1eki"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEA71CA9C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 06:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711520314; cv=none; b=ZOOEwHxWdeqFzgFuusXUOqgO9IcqX90xr37b1Sei64sQ36LxbNDRP1PpEkZVCWHQKvD5u1yc6T23emN47EMO3IxW8uuVMQ0KMn4BgFiKf0/vrD2Vz+i71s9FbNN0BlEQEjzkyIgJkMAYnf8kQgcibHj8k+4pW4gEBFIWe7OCq4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711520314; c=relaxed/simple;
	bh=QSWOd5QSD/Mwb0i+vtxbpmvy9IlXp1/N645iLIzqlgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwB+xf9EOSdnzKZ8bFUmYKlsnqa7hnEVYw5wwjHOPh5+eYtGg0GzcBl7Q++CjMZmktgSsi87TpYBE7Vhg6XVmt+diLhmllQchApRvI9gfxYwS8AWyAkc89LAZJ+g4RVEwe7ZUOXjYE8yfwEb6p7Bl+0jPJB/gcnZN+3hR0aJXKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BpAs1eki; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e0511a4383so47392285ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 23:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711520312; x=1712125112; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o0gjg83GHJ5iMw1grXSKgZDAg4bzhxIcgbatUtZtL1w=;
        b=BpAs1eki9UcYrHbYskq6BTJRGnVazUjcNoYWEcquZ4go4y217O2heUBhTAbAlfzi63
         hcoyCJ3Oby3LR2S9jIX3VYjp5dAS678VcM5fHkGB+lnQkCjXBAA4eXyMvNcXfxq7LuXc
         NnfTzf31USr8FlizdgP65bvOVRkRpAgZinQHTC245Q3qTKcrikksDiSPvK045vWwjxK4
         92JGmLIRGiN+D0dmWpeJe/hiBereYxVFb2Yu3Y3Xt+uETckXSMGCpGxeLRdjX9K1tuKY
         jx8Fn6wx9TckYgbZJN3GtHIh+siE8ohRialiOjTJCSZuvdXDKMvuRKWEJz/vsVmHqAUu
         0oPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711520312; x=1712125112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0gjg83GHJ5iMw1grXSKgZDAg4bzhxIcgbatUtZtL1w=;
        b=nILBpeKfLzu87ekkFVkn1U1hvAcVcYgLEAjZ52ddMLe4QKjjioAv07OBbySpEXGBBe
         zMia+5qE9h0riafRROrccj+VhRi3SqIrLltimFcVBeOTwUwR+yv2HvRWWVfPNQcEUfvc
         ft4hT2C282+eKUz87jka59lsE32ss2TrG1zrsMjBqI7wV1Uv1CusNeO0alJyfIvuMuTN
         QuLDxC5BFOO+lKaZoHh9aOjbCTVUWrzU1G81EmZOkQVeMhjEbmvGjtlC8dXp7ygKRIIl
         nHhE2h6zAHiqHSrovrqXvMNZQzKbam+F76EgjS+SwGoGOcgJSXnIbYgOSrmPgCk0rXCD
         SCXA==
X-Forwarded-Encrypted: i=1; AJvYcCWOhZ9cH9z+A5QFzmfqoXoySh1AplY/aNAcAahdBON1TdzPVV0QiLPg3pc3SXvOqH1ciQ8bZJrHuwTjdlABa2wasx6IOCqhTuPBH9ql
X-Gm-Message-State: AOJu0YyU53E5sYMfjW00z3sQoZQSLXQNsDe2xSuaIkJYI9vYlGdWLjbo
	eG7I2+YS3MfVNcsuRP6mxv8PAyvhXFgtbXhVp3DhoUVC2jBsWoaFyj7+GaUqYQ==
X-Google-Smtp-Source: AGHT+IHji7g8cihtAriwVgPqznOHJahJLJB2a+jqLM2ts6GNSuhe4SxcmmyVioUmpWFcQTqU1N0vyg==
X-Received: by 2002:a17:902:ecc5:b0:1e0:342b:af6f with SMTP id a5-20020a170902ecc500b001e0342baf6fmr3668522plh.16.1711520311993;
        Tue, 26 Mar 2024 23:18:31 -0700 (PDT)
Received: from thinkpad ([117.207.28.168])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902f54a00b001e02875930asm8003160plf.25.2024.03.26.23.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 23:18:31 -0700 (PDT)
Date: Wed, 27 Mar 2024 11:48:19 +0530
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
Subject: Re: [PATCH 05/11] PCI: epf-{mhi/test}: Move DMA initialization to
 EPC init callback
Message-ID: <20240327055457.GA2742@thinkpad>
References: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
 <20240314-pci-epf-rework-v1-5-6134e6c1d491@linaro.org>
 <Zf2tXgKo-gc3qy1D@ryzen>
 <20240326082636.GG9565@thinkpad>
 <ZgKsBoTvPWWhPO9e@ryzen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZgKsBoTvPWWhPO9e@ryzen>

On Tue, Mar 26, 2024 at 12:05:42PM +0100, Niklas Cassel wrote:
> On Tue, Mar 26, 2024 at 01:56:36PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Mar 22, 2024 at 05:10:06PM +0100, Niklas Cassel wrote:
> > > On Thu, Mar 14, 2024 at 08:53:44PM +0530, Manivannan Sadhasivam wrote:
> > > > To maintain uniformity across EPF drivers, let's move the DMA
> > > > initialization to EPC init callback. This will also allow us to deinit DMA
> > > > during PERST# assert in the further commits.
> > > > 
> > > > For EPC drivers without PERST#, DMA deinit will only happen during driver
> > > > unbind.
> > > > 
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > 
> > > Reviewed-by: Niklas Cassel <cassel@kernel.org>
> > > 
> > > 
> > > For the record, I was debugging a problem related to EPF DMA recently
> > > and was dumping the DMA mask for the struct device of the epf driver.
> > > I was a bit confused to see it as 32-bits, even though the EPC driver
> > > has it set to 64-bits.
> > > 
> > > The current code works, because e.g., pci_epf_test_write(), etc,
> > > does:
> > > struct device *dma_dev = epf->epc->dev.parent;
> > > dma_map_single(dma_dev, ...);
> > > 
> > > but it also means that all EPF drivers will do this uglyness.
> > > 
> > 
> > This ugliness is required as long as the dmaengine is associated only with the
> > EPC.
> > 
> > > 
> > > 
> > > However, if a EPF driver does e.g.
> > > dma_alloc_coherent(), and sends in the struct *device for the EPF,
> > > which is the most logical thing to do IMO, it will use the wrong DMA
> > > mask.
> > > 
> > > Perhaps EPF or EPC code should make sure that the struct *device
> > > for the EPF will get the same DMA mask as epf->epc->dev.parent,
> > > so that EPF driver developer can use the struct *epf when calling
> > > e.g. dma_alloc_coherent().
> > > 
> > 
> > Makes sense. I think it can be done during bind() in the EPC core. Feel free to
> > submit a patch if you like, otherwise I'll keep it in my todo list.
> 
> So we still want to test:
> -DMA API using the eDMA
> -DMA API using the "dummy" memcpy dma-channel.
> 

IMO, the test driver should just test one form of data transfer. Either CPU
memcpy (using iATU or something similar) or DMA. But I think the motive behind
using DMA memcpy is that to support platforms that do not pass DMA slave
channels in devicetree.

It is applicable to test driver but not to MHI driver since all DMA supported
MHI platforms will pass the DMA slave channels in devicetree.

> However, it seems like both pci-epf-mhi.c and pci-epf-test.c
> do either:
> -Use DMA API
> or
> -Use memcpy_fromio()/memcpy_toio() instead of DMA API
> 
> 
> To me, it seems like we should always be able to use
> DMA API (using either a eDMA or "dummy" memcpy).
> 

No, there are platforms that don't support DMA at all. Like Qcom SDX55, so we
still need to do CPU memcpy.

> I don't really see the need to have the path that does:
> memcpy_fromio()/memcpy_toio().
> 
> I know that for DWC, when using memcpy (and this also
> memcpy via DMA API), we need to map the address using
> iATU first.
> 
> But that could probably be done using another flag,
> perhaps rename that flag FLAG_USE_DMA to NEEDS_MAP or
> something.
> (Such that we can change these drivers to only have a
> code path that uses DMA API.)
> (...and making sure that inheriting the DMA mask does
> not affect the DMA mask for DMA_MEMCPY.)
> 
> But perhaps I am missing something... and DMA_MEMCPY is
> not always available?
> 

Yes.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

