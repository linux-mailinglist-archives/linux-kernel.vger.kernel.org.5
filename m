Return-Path: <linux-kernel+bounces-157850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F3E8B174A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACDB6282648
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E6416F0F9;
	Wed, 24 Apr 2024 23:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mTSeKG3O"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D98416EBEF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 23:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714001994; cv=none; b=YdxxHpM3AdfUICDwllluX0+13SA2WvFTJvmommxEaYtU79/bfXeXHwC4x1u/Vq6cvUpFHy1wPHTnirWcebjOAy3nDWfDwMp4xS56FUSjF+UfaI8SF5yMNog4k8UP3nk4dk+zRYC4Q8RIOvBTFSjFWDBFEafoOxUrY9eUQ9Py+Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714001994; c=relaxed/simple;
	bh=2O0o98ggkAQaDI7rP6itKxJY1fyhiAPS6wTogNwU5hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msOW+A/podwaPgKG1O8LWu7w5PNTUl+KW0GTAKsoqCIVWAvjl4U6uWWkVuOhI8jyRTWFpmyLB959Atis1olUgNQdDX75Uw7aLMaygw9rfCjb3w9wwu2zH+2SyUPN+WLd8hA4+erYRtPrcN88ysiscaHfNuvc3Tx6xEgMYG3jVkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mTSeKG3O; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-23333dddd8aso319179fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1714001992; x=1714606792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pu6etYv5ocPJpDTio+T7Fs2/aD2ssrnDfuoC/AGwC3E=;
        b=mTSeKG3OB6ztab6ECA7dehoBN5pZIBhzN4mW8PzumBU+iO+9fA5LcuTqcSNryCkEK9
         JZhGzJXb2QOZ2f8IUMjSxOaNDT+XhUIdVUcORKhViXkw3/QSpvk8WTSjNdgosV4r0Nbt
         MUJCYaTM/IbpI+NfqUVCvCpZ7TuXewAPvjG4RfcB768UPa9FOjuLAxnvopEGFZCJEvu0
         Cxk4s/PxiZqBd0C/ZfoJD7p0jkgNr5gDtrsS/wmoEJX5hgnt7oFUCk6QT96k/CqBsdg2
         e8p34X+AwDDLoUkQo0bkoIQAkL9+P3rZf7uiGtyG3En0zPV9apxUNl4nq2gMD/Y7rR3g
         6acA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714001992; x=1714606792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pu6etYv5ocPJpDTio+T7Fs2/aD2ssrnDfuoC/AGwC3E=;
        b=SugHLbVc36gyKmzL4vhmJmTbaTM2EaD9lIknx9mW5cUW7nJS9Byevtsoymz0JiOeF7
         1le225Ohvg7Ax9zp0H5MDlnVLbb+FZIVeYevxZ6jdDJDBHKryzAgrE2C3dzH8WUbHVCr
         ODN1u2Qvtvxpbjvw/JbRzjM1znrNkCbjnMPfib3g4RaIWwPg7JkzW4nsib9sKLrX2r1R
         MSDGovqk31ttSS9t/OEhBm7qNz238bUcnzc24fhgyrzzwXbCm/Mq/m6wIBvh8h+J6XEb
         frerGs+/smx9Y5zI2EuRdS6MDLSF+WfXELIcUxOFPprJy+/eMDmtYjduLa/RnaRVdaVA
         /xsg==
X-Forwarded-Encrypted: i=1; AJvYcCX/QFkCqAane2F/EPtq28xEGgXwCxMdlw1QTTypfuY55NtdC0FzI8Tuh+IWl+St/AEeYqJbn9AqGiPcsHYIXYeddEUVG2/nfgP7uzI1
X-Gm-Message-State: AOJu0Ywu62+mdKtbDwiIV2odEi5G9yIZTI4eMWFNum7RYOIBCiwt/xXH
	2lu7yb+FMDjt+w2vLkRHleM0GR7GFtSqjXMS12MNWuA+BxNegdXIRu2PYonds8Q=
X-Google-Smtp-Source: AGHT+IFHSoQmOFvkIt4UdS9vVvm/+9LOICy267nTOZxeYgmuzEs2JusAIDrqy2AljxZbMWh+yyg/Lg==
X-Received: by 2002:a05:6870:9602:b0:22e:bc50:3492 with SMTP id d2-20020a056870960200b0022ebc503492mr4335970oaq.47.1714001992183;
        Wed, 24 Apr 2024 16:39:52 -0700 (PDT)
Received: from ziepe.ca ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id pv10-20020a0568709d8a00b0023b50a85913sm78072oab.38.2024.04.24.16.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 16:39:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rzmDO-00A1fN-HT;
	Wed, 24 Apr 2024 20:39:50 -0300
Date: Wed, 24 Apr 2024 20:39:50 -0300
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
Subject: Re: [PATCH v2 7/7] iommu/riscv: Paging domain support
Message-ID: <20240424233950.GJ231144@ziepe.ca>
References: <cover.1713456597.git.tjeznach@rivosinc.com>
 <301244bc3ff5da484b46d3fecc931cdad7d2806f.1713456598.git.tjeznach@rivosinc.com>
 <20240419125627.GD223006@ziepe.ca>
 <CAH2o1u5+XD9YN=gdMVtfkyhKoKha0UpwKgOVbCAwOQa+saPfRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2o1u5+XD9YN=gdMVtfkyhKoKha0UpwKgOVbCAwOQa+saPfRw@mail.gmail.com>

On Wed, Apr 24, 2024 at 04:30:45PM -0700, Tomasz Jeznach wrote:
> > > @@ -46,6 +46,10 @@ MODULE_LICENSE("GPL");
> > >  #define dev_to_iommu(dev) \
> > >       container_of((dev)->iommu->iommu_dev, struct riscv_iommu_device, iommu)
> > >
> > > +/* IOMMU PSCID allocation namespace. */
> > > +static DEFINE_IDA(riscv_iommu_pscids);
> > > +#define RISCV_IOMMU_MAX_PSCID                BIT(20)
> > > +
> >
> > You may consider putting this IDA in the riscv_iommu_device() and move
> > the pscid from the domain to the bond?
> >
> 
> I've been considering containing IDA inside riscv_iommu_device at some
> point,  but it made PCSID management more complicated.  In the follow
> up patches it is desired for PSCID to be unique across all IOMMUs in
> the system (within guest's GSCID), as the protection domains might
> (and will) be shared between more than single IOMMU device.

The PCSID isn't scoped under the GSCID? That doesn't sound very good,
it means VM's can't direct issue invalidation with their local view of
the PCSID space?

> > This seems suboptimal, you probably want to copy the new design that
> > Intel is doing where you allocate "bonds" that are already
> > de-duplicated. Ie if I have 10 devices on the same iommu sharing the
> > domain the above will invalidate the PSCID 10 times. It should only be
> > done once.
> >
> > ie add a "bond" for the (iommu,pscid) and refcount that based on how
> > many devices are used. Then another "bond" for the ATS stuff eventually.
> >
> 
> Agree, not perfect to send duplicate invalidations.
> This should improve with follow up patchsets introducing of SVA
> (reusing the same, extended bond structure) and update to send IOTLB
> range invalidations.
> 
> For this change I've decided to go with as simple as possible
> implementation and over-invalidate for domains with multiple devices
> attached. Hope this makes sense.

It is fine as long as you do fix it..

Jason

