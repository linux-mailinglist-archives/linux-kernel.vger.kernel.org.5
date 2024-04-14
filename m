Return-Path: <linux-kernel+bounces-144148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C20628A4268
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AC63281831
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 13:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64D0381B9;
	Sun, 14 Apr 2024 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i29OXoiC"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C553A18AF4
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 13:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713099668; cv=none; b=OiBtJXs41h8UVI/0GdC+WrwOJ1IR4jQ/CAzg8zw50VMajxMuyLrIvNnaSV69VL15WgJdaU5LaSWhV1DhnpE4PzYOZrHDw1bUs2Fp7F1LfXAEtpysn7LRZvRpXNpMuSxLvNb5nuXqBcgDuZ06VlmgYXiBduRD7/pJJ5wYF0bYZEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713099668; c=relaxed/simple;
	bh=+JGinkGUgeetfZe7KdVXDzaihf5FNpwgQUbEfhGRNT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fofpXbjmXXolMeifnUNgE/M9yPcOgzCMPm0dkC+UcalDwtTxU9vuk0FSBGhqAujy4fZMqijHaw6GeFKOa/LCSPwe6GFfv32P4fyEc3jLhG0pFneOLbGT+PY5PNDJeZh4m2RjXgUSGaaweNgFc1ERNCJNAD+ZFh/rt1Dl2jK/El8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i29OXoiC; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2a52c544077so1586523a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 06:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713099665; x=1713704465; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jvVS8fZDPWZ6C8BGJgV7+o1D33foaDJkSVY8UEluGQI=;
        b=i29OXoiCjtgSjs2WBqyG62ltMF/8D8w132h2e+o9kphYy9ihfvaP5X0ibOC3K6AU65
         c19NIO7yAlI/SCOT/LAH4wUZPYbAhG+eOyhb9v3l0eaZ0V/1dIF8f2Jm12aBSSWQfBiJ
         +qhARDzTXliTEexQkXCq5tXgeXrAW8x0joKuj1H5aOXKp68kQc9IbDw7NU6QbMGvPPI2
         f+yQx5JapUMoeUzhGPWomwr5MioNdAFi+QjlMAjgOoigA/wFD/MeqzlcAtrbJl4dH5ZX
         EwyBn+TG/7jsv0vt6j/j/lF43WaE8hmLdjHw1KNrnLDIVatgg4fJ62xewf4KwTU48eoh
         +50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713099665; x=1713704465;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jvVS8fZDPWZ6C8BGJgV7+o1D33foaDJkSVY8UEluGQI=;
        b=fxYm1TzZWsRZMg0IYKAgxYiYIDmcBNACkUsBevgfu6t8LaJ+XankT08gfMAQxMi5FS
         kR54KUwMMBvyPEkwzVOV/TVX/3WB2Klgybhr7E++j454qm4TJwdO468JOlrWd1wT9+pc
         bIGwO67AP5FR5GeQbNvnGhS7Rqoo9020uajHD6acyxAjG6nJ6gL86xWcguxa+elSdwYx
         L5Z5tFmxbi7IXMINaisx89lbTz/CkX4khQexQoiztVYh/7djgZ/DAS4mvfSiWyzGpOTm
         EaE1FYVStwkC2UgR8/3EjQaJOB8fL/4I88DJbdSkp3/46qUCyAeaiBa4+Hx15KsGggxe
         Tq2g==
X-Forwarded-Encrypted: i=1; AJvYcCVRH78sSfdmsHTYbgAB3mG8/azd2PZ6uWoHwFz5wBoT7TJDT+d+yQHCbgGUNLGIQiCSHtuoh2VOiZQlHFPH+SFTtesj5NPJ/NFA1l+l
X-Gm-Message-State: AOJu0YxIFiaC77RbsGTDNE7yHPSef9E8Jz0N88avUe7VqyO4XFWJSL0X
	HarQRyoVdXnkSNp9Fs/OKBpJutHLt6dvFwDmL66U+esqZ3ttMMvt747G0JY+Qg==
X-Google-Smtp-Source: AGHT+IFGLYOEvtQ17A4IP+js2HGKJp/jc1XXKTbOcw6VnyVS54fNx/L51bEWNL/vMzMdch8Lr03TXg==
X-Received: by 2002:a17:90a:2f65:b0:2a0:2fb3:c1ff with SMTP id s92-20020a17090a2f6500b002a02fb3c1ffmr5676444pjd.15.1713099664882;
        Sun, 14 Apr 2024 06:01:04 -0700 (PDT)
Received: from thinkpad ([103.246.195.153])
        by smtp.gmail.com with ESMTPSA id x15-20020a17090a164f00b002a5cf58aae2sm5989216pje.11.2024.04.14.06.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 06:01:04 -0700 (PDT)
Date: Sun, 14 Apr 2024 18:30:58 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Kishon Vijay Abraham I <kvijayab@amd.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: Migrate to Genalloc framework for
 outbound window memory allocation
Message-ID: <20240414130058.GA2231@thinkpad>
References: <20240317-pci-ep-genalloc-v1-1-70fe52a3b9be@linaro.org>
 <37cfa724-f9ed-41ef-bad4-f00246a4ee8a@amd.com>
 <20240320112928.GB2525@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240320112928.GB2525@thinkpad>

On Wed, Mar 20, 2024 at 04:59:28PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Mar 20, 2024 at 03:26:41PM +0530, Kishon Vijay Abraham I wrote:
> > Hi Mani,
> > 
> > On 3/17/2024 11:39 AM, Manivannan Sadhasivam wrote:
> > > As proposed during the last year 'PCI Endpoint Subsystem Open Items
> > > Discussion' of Linux Plumbers conference [1], let's migrate to Genalloc
> > > framework for managing the endpoint outbound window memory allocation.
> > > 
> > > PCI Endpoint subsystem is using a custom memory allocator in pci-epc-mem
> > > driver from the start for managing the memory required to map the host
> > > address space (outbound) in endpoint. Even though it works well, it
> > > completely defeats the purpose of the 'Genalloc framework', a general
> > > purpose memory allocator framework created to avoid various custom memory
> > > allocators in the kernel.
> > > 
> > > The migration to Genalloc framework is done is such a way that the existing
> > > API semantics are preserved. So that the callers of the EPC mem APIs do not
> > > need any modification (apart from the pcie-designware-epc driver that
> > > queries page size).
> > > 
> > > Internally, the EPC mem driver now uses Genalloc framework's
> > > 'gen_pool_first_fit_order_align' algorithm that aligns the allocated memory
> > > based on the requested size as like the previous allocator. And the
> > > page size passed during pci_epc_mem_init() API is used as the minimum order
> > > for the memory allocations.
> > > 
> > > During the migration, 'struct pci_epc_mem' is removed as it is seems
> > > redundant and the existing 'struct pci_epc_mem_window' in 'struct pci_epc'
> > > is now used to hold the address windows of the endpoint controller.
> > > 
> > > [1] https://lpc.events/event/17/contributions/1419/
> > 
> > Thank you for working on this!
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >   drivers/pci/controller/dwc/pcie-designware-ep.c |  14 +-
> > >   drivers/pci/endpoint/pci-epc-mem.c              | 182 +++++++++---------------
> > >   include/linux/pci-epc.h                         |  25 +---
> > >   3 files changed, 81 insertions(+), 140 deletions(-)
> > > 
> > .
> > .
> > > diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
> > > index a9c028f58da1..f9e6e1a6aeaa 100644
> > > --- a/drivers/pci/endpoint/pci-epc-mem.c
> > > +++ b/drivers/pci/endpoint/pci-epc-mem.c
> > > @@ -4,37 +4,18 @@
> > >    *
> > >    * Copyright (C) 2017 Texas Instruments
> > >    * Author: Kishon Vijay Abraham I <kishon@ti.com>
> > > + *
> > > + * Copyright (C) 2024 Linaro Ltd.
> > > + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > >    */
> > > +#include <linux/genalloc.h>
> > >   #include <linux/io.h>
> > >   #include <linux/module.h>
> > >   #include <linux/slab.h>
> > >   #include <linux/pci-epc.h>
> > > -/**
> > > - * pci_epc_mem_get_order() - determine the allocation order of a memory size
> > > - * @mem: address space of the endpoint controller
> > > - * @size: the size for which to get the order
> > > - *
> > > - * Reimplement get_order() for mem->page_size since the generic get_order
> > > - * always gets order with a constant PAGE_SIZE.
> > > - */
> > > -static int pci_epc_mem_get_order(struct pci_epc_mem *mem, size_t size)
> > > -{
> > > -	int order;
> > > -	unsigned int page_shift = ilog2(mem->window.page_size);
> > > -
> > > -	size--;
> > > -	size >>= page_shift;
> > > -#if BITS_PER_LONG == 32
> > > -	order = fls(size);
> > > -#else
> > > -	order = fls64(size);
> > > -#endif
> > > -	return order;
> > > -}
> > > -
> > >   /**
> > >    * pci_epc_multi_mem_init() - initialize the pci_epc_mem structure
> > >    * @epc: the EPC device that invoked pci_epc_mem_init
> > > @@ -48,17 +29,11 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
> > >   			   struct pci_epc_mem_window *windows,
> > >   			   unsigned int num_windows)
> > >   {
> > > -	struct pci_epc_mem *mem = NULL;
> > > -	unsigned long *bitmap = NULL;
> > > -	unsigned int page_shift;
> > > +	struct pci_epc_mem_window *window = NULL;
> > >   	size_t page_size;
> > > -	int bitmap_size;
> > > -	int pages;
> > >   	int ret;
> > >   	int i;
> > > -	epc->num_windows = 0;
> > > -
> > >   	if (!windows || !num_windows)
> > >   		return -EINVAL;
> > > @@ -70,45 +45,51 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
> > >   		page_size = windows[i].page_size;
> > >   		if (page_size < PAGE_SIZE)
> > >   			page_size = PAGE_SIZE;
> > > -		page_shift = ilog2(page_size);
> > > -		pages = windows[i].size >> page_shift;
> > > -		bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
> > > -		mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> > > -		if (!mem) {
> > > +		windows[i].pool = gen_pool_create(ilog2(page_size), -1);
> > > +		if (!windows[i].pool) {
> > >   			ret = -ENOMEM;
> > > -			i--;
> > > -			goto err_mem;
> > > +			goto err_free_mem;
> > > +		}
> > > +
> > > +		gen_pool_set_algo(windows[i].pool, gen_pool_first_fit_order_align,
> > > +				  NULL);
> > > +
> > > +		windows[i].virt_base = ioremap(windows[i].phys_base, windows[i].size);
> > 
> > Do you have to ioremap upfront the entire window? This could be a problem in
> > 32-bit systems which has limited vmalloc space. I have faced issues before
> > when trying to map the entire memory window and had to manipulate vmalloc
> > boot parameter.
> > 
> > I'd prefer we find a way to do ioremap per allocation as before.
> > 
> 
> Hmm, thanks for pointing it out. Current genalloc implementation works on the
> virtual address as opposed to physical address (that might be due to majority of
> its users managing the virtual address only). That's the reason I did ioremap of
> the entire window upfront.
> 
> Let me see if we can somehow avoid this.
> 

Looks like we have to introduce some good amount of change to support dynamic
ioremap with genalloc. But IMO it doesn't worth the effort to introduce these
changes for some old systems which are supposed to go away soon.

So I think we can keep the old and genalloc based allocators and use the old one
only for 32bit systems and genalloc allocator for the rest.

What do you think?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

