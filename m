Return-Path: <linux-kernel+bounces-157823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 321128B16D6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566721C24EE5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A9816F0C2;
	Wed, 24 Apr 2024 23:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RGOpKw+s"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5BA16EBF3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 23:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714000039; cv=none; b=Ds3vBsQA9UK1Uiw3CpNZazY33sG9t4J2u1Nh3CsAMf7WmeE57uDGvu5EifqlIaE3XxUaLqSP1AI/fOeBXNusMSwLpFezkiUo6bljiwjvMhLEs91H+ZyJDte87uCfntzy5oHc747O/sBXMPbH3VvLHRjh9GLUL34KXxQj+G9YjAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714000039; c=relaxed/simple;
	bh=YkqsC0nF/H/k4Oytm2ewDWntFmRtzUD1STC8KXiQ41g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCK4wtSoThRup0Eh5RwxYgHg8bUSAImoZnVkDA/nnGctU6ch7BVZE5bB3X1nJkRyFYSaf+ugnr0sa0YlFajui4meRpG0GHPllFahwI3YXq929eKMzC7roxqOFJcU6o/Rg2o9XThmp7w23TaSmuALXYgt5OjmP79HhJMkXwexIzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RGOpKw+s; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6ebc92079b5so271879a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1714000037; x=1714604837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5EOPLUxSGdh2673E9UnVgdv/f9WeKREWyE41T1+ComY=;
        b=RGOpKw+sLSLcuvF8vdrD+kMElj4DLvMy8Jr8r7isGFxpW2e2r/ZdfJIhN1I80MOOve
         /pQVO+3L45Ffch4h3HqtnQXLJ3akJPWQbWPuOd/Oq6nsXwEtReAPomhWWIex9MRXTfp/
         bVR40bWS8gLIPLkE8eiOCRk94b4Pw3HBMg1Il8y/Gi+fwzcITKqwGBOgC3GcuohSW3Tc
         WLr3YlCQEo1IeNv/2d8yTzyyH/zv6rvIufADTJN+pum/WaI8oEvQKimCYC1JGZ3Ew3tS
         2avS8BFoY8IiZ+BaWk1Fb1k0EUG7M6CkJVRuY0FT1q1eNPieQSWfWLb+F2fbKruK2PNJ
         6GEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714000037; x=1714604837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5EOPLUxSGdh2673E9UnVgdv/f9WeKREWyE41T1+ComY=;
        b=hOBBBsFzqlYzt9AgG4fqkx/VsVXmUotNDGXkNIs+PcCDbJOOhY8AN9PoTqvVCuiFF/
         f4j75RXlPXQseoB2LNL9TI8HYXmW/UJwZWJw20CJ1NimyZEeF36+Aree0Z79e8SjPiAx
         w6oxf7ME3FJOPKyUc9n+VDJlR/EmlBW2hAV8hSRDyCwqgZm7ODLgH8a+j92PRtFNMEDN
         eOm72xYYrMyTVe3NP23DEUGBabGTM/jV09WdEIfgJ/nvR6NQSz/cSCRxZPUrkOuEOjAT
         5/xNwGdgXxIph6Xxn7d+nQl9hcWZbqpWY5f8pxyUwNilz2KMwHrB/3cUwpDyjPR9Jg+4
         srWw==
X-Forwarded-Encrypted: i=1; AJvYcCWcweJwFt9wRuIEKoW5yKg2CL7J1q05d2aI32os4sxH+FPuZborPzuBkbF0uaYjwqOWZYjeA01O8aQgPF/FIJfpGCMRx8Jk/+DuvBqk
X-Gm-Message-State: AOJu0YxhDEfHrVZlPQmCkIRU0mQzUAMAxsLdvpqgo1zVKoZXRpa9msIn
	RSTOAZiWa0NLWT3SwTZeXLw19PPkgirAfnwmEMmwidSEDWbxcXys6g6n+7A3X0Y=
X-Google-Smtp-Source: AGHT+IEK1yF/pF3Jt1MaMAE7gbVSzzN/c9vmeIlr7aFyXy4aHkiw6cz3OYQ6jtkyalR6CHilLOVggw==
X-Received: by 2002:a05:6870:c0c7:b0:235:3d0:3096 with SMTP id e7-20020a056870c0c700b0023503d03096mr4168277oad.24.1714000037198;
        Wed, 24 Apr 2024 16:07:17 -0700 (PDT)
Received: from ziepe.ca ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id oh23-20020a0568702c9700b00239379f06cdsm2596004oab.9.2024.04.24.16.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 16:07:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rzlhr-009uvX-JB;
	Wed, 24 Apr 2024 20:07:15 -0300
Date: Wed, 24 Apr 2024 20:07:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux@rivosinc.com
Subject: Re: [PATCH v2 5/7] iommu/riscv: Device directory management.
Message-ID: <20240424230715.GI231144@ziepe.ca>
References: <cover.1713456597.git.tjeznach@rivosinc.com>
 <232b2824d5dfd9b8dcb3553bfd506444273c3305.1713456598.git.tjeznach@rivosinc.com>
 <20240419124017.GC223006@ziepe.ca>
 <CAH2o1u7_YBtS6m1-T56tmxud1mda2gb6tLGVpbBSs15FPcjaGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2o1u7_YBtS6m1-T56tmxud1mda2gb6tLGVpbBSs15FPcjaGQ@mail.gmail.com>

On Wed, Apr 24, 2024 at 04:01:04PM -0700, Tomasz Jeznach wrote:
> > > +     /* Update existing or allocate new entries in device directory */
> > > +     for (i = 0; i < fwspec->num_ids; i++) {
> > > +             dc = riscv_iommu_get_dc(iommu, fwspec->ids[i], !iommu_domain);
> > > +             if (!dc && !iommu_domain)
> > > +                     continue;
> > > +             if (!dc)
> > > +                     return -ENODEV;
> >
> > But if this fails some of the fwspecs were left in a weird state ?
> >
> > Drivers should try hard to have attach functions that fail and make no
> > change at all or fully succeed.
> >
> > Meaning ideally preallocate any required memory before doing any
> > change to the HW visable structures.
> 
> Good point. Done.
> Looking at the fwspec->ids[] I'm assuming nobody will add/modify the
> IDs after iommu_probe_device() completes.

Yes

> > > +             /* Swap device context, update TC valid bit as the last operation */
> > > +             xchg64(&dc->fsc, fsc);
> > > +             xchg64(&dc->ta, ta);
> > > +             xchg64(&dc->tc, tc);
> >
> > This doesn't loook right? When you get to adding PAGING suport fsc has
> > the page table pfn and ta has the cache tag, so this will end up
> > tearing the data for sure, eg when asked to replace a PAGING domain
> > with another PAGING domain? That will create a functional/security
> > problem, right?
> >
> > I would encourage you to re-use the ARM sequencing code, ideally moved
> > to some generic helper library. Every iommu driver dealing with
> > multi-quanta descriptors seems to have this same fundamental
> > sequencing problem.
> >
> 
> Good point. Reworked.

I suppose by force clearing the v bit before starting the sequence?

That is OK but won't support some non-embedded focused features in the
long run. It is a good approach to get the driver landed though.
 
> > The release_domain has landed too now. Please don't invent weird NULL
> > domain types that have special meaning. I assume clearing the V bit is
> > a blocking behavior? So please implement a proper blocking domain and
> > set release_domain = &riscv_iommu_blocking and just omit this release
> > function.
> >
> 
> Updated to use release_domain, should be cleaner now.
> Clearing TC.V is a blocking (but noisy) behavior, should be fine for
> release domain where devices should be quiesced already.

blocking is fine to be noisy.

Jason

