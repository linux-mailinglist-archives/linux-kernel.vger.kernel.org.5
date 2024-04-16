Return-Path: <linux-kernel+bounces-146725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C50F08A69EC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E832A1C211C7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6510A129E64;
	Tue, 16 Apr 2024 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="U4Lrr7X4"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C4384E0A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 11:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713268198; cv=none; b=V/YR2Se+4TMlYoFlqlm3blZsdbl2iN3V39k+UKDTIV9PDy8tcevcTCFhKhE52JWyNM+KDWYxNoHC1EuV27PooA0sB3ZXmH6hcLzlVMttayNVwYLAXUoYqbPHTjB4gLlNPEg4JIwaI1guByp762shBPZSauPx9VJCLEARi+vNLFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713268198; c=relaxed/simple;
	bh=rmvpFPUTIYgHV2p8/6H+ARfWisXS/Az8htu2TVN/PtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSvDThqckoeX7mN78C+G1eiRwhHWE2bdUWVO0FhhddO3V6a4k0/cJbGxPNxVOsRd4YxhJESNE4w9Q+ZwBP1UBxngtyNdnUvdtYaVxy2BDIKPAo1IsEAkg/Q0MH2TmT5q5hk2aDkpUcjGhi4XtP7gyXokaCh0KciFFYGPCK4bJWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=U4Lrr7X4; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-69b3d05e945so26765416d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 04:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1713268196; x=1713872996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QCTi/88RzK0ECiO7fDP6JKGXgjJySXc+KTjtiX7cVN8=;
        b=U4Lrr7X4VFI0pd/Ny7N11t4/jnUQMrFGxsq5QcV2H08YfQkoOzmnlmsbMwgLTLgzVU
         3Zfa3nUHoBGyzcKmXVzPc7vSI44qjP4fhdNAj2WwLvBxlOiDxYc+fIm2BeC2U5tdhSd7
         2rAaypOLCBpWZc/s2O6Z6dRNXxN48IBUorCTwr2j0pUn/wfxh68ksgO0U5XQXPTuMEP/
         TyvqqYbp5s9b05BkXT28xVAoxuvVlUpETJ3GN8lRdHdyz9FrkMeUoZuDchGG/NpbPw7K
         MVGHyompLwGTP1cZAGX7zs+Wa78MJRKMaxY08awEEKrRKnK/bjlLv2vENMpdUlk+fH59
         RnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713268196; x=1713872996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCTi/88RzK0ECiO7fDP6JKGXgjJySXc+KTjtiX7cVN8=;
        b=D5toocMaXn/RRKRkSl7Y+a3DpubvM5Gh05Or/g3nlFGy1pkkhmN3brK2+yLfuP5XyF
         c7nBvunRPhdOpmcEFPwbuh1n/FFrTbCHgaqwtpgmqQMExFnpRpL+44P9PMlkkkhnBQmo
         A1D8c7hoUFV4tpffsGT01TCZQ8Q5wbtzcbMQ5PWs4BIpntGResWvYpR88EgKPODXcaWX
         ZPlzjA3jd4NCUHMR5ir1qagg6M0osMGWxJAca2ZU9z4OnV1i4UZyV6yC3xlcXTqhT1mt
         C/+bc5GxKIVroQJNqha170hUYUe7+km55uVLvMZEeGV1/Vsza1yQlVrWwI3Dnp8aJPyt
         TaJg==
X-Forwarded-Encrypted: i=1; AJvYcCWDDc0Tq97DrEo7O0ksgIJJNHipmRw5JYg7kmdI8rBinTUg9u1fShv48Hvh84+qHHL9HGt53ZZlCR9hN0hou8kPGViuJI73eb9T/oYF
X-Gm-Message-State: AOJu0YzZDkKljDtuUBFG8B144ANLZHhpQFbalSVVYhYS+HtMVZgpxInk
	zxPzVTLI5Bk+twx50YEju1JSiOAbtk2dNQOYfu7+i6b99YH5dByExbZqOgUC8uE=
X-Google-Smtp-Source: AGHT+IESqldpjft/eXho3+hgJTTcbX6pmRWAM7oqr10WigziCiL0y4fcBwniEWrqOwd0oNhEvyEagw==
X-Received: by 2002:a0c:efc6:0:b0:69e:b96d:26a0 with SMTP id a6-20020a0cefc6000000b0069eb96d26a0mr1003878qvt.27.1713268196162;
        Tue, 16 Apr 2024 04:49:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id r18-20020ad44052000000b00698e65cdfefsm7335858qvp.87.2024.04.16.04.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 04:49:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rwhJz-008b7B-5T;
	Tue, 16 Apr 2024 08:49:55 -0300
Date: Tue, 16 Apr 2024 08:49:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, Eric Wagner <ewagner12@gmail.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: Kernel 6.7 regression doesn't boot if using AMD eGPU
Message-ID: <20240416114955.GT223006@ziepe.ca>
References: <CAHudX3zLH6CsRmLE-yb+gRjhh-v4bU5_1jW_xCcxOo_oUUZKYg@mail.gmail.com>
 <20240415163056.GP223006@ziepe.ca>
 <CAHudX3zhagFWBv4isZzAtC8dA7EAAtY6Yk7fkJ31hf0D9zrNqw@mail.gmail.com>
 <65d4d7e0-4d90-48d7-8e4a-d16800df148a@arm.com>
 <20240416003903.GR223006@ziepe.ca>
 <47d4bfd6-1d76-4bb8-a33c-c9c99b86656b@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47d4bfd6-1d76-4bb8-a33c-c9c99b86656b@arm.com>

On Tue, Apr 16, 2024 at 12:25:52PM +0100, Robin Murphy wrote:
> On 2024-04-16 1:39 am, Jason Gunthorpe wrote:
> > On Mon, Apr 15, 2024 at 10:44:34PM +0100, Robin Murphy wrote:
> > > On 2024-04-15 7:57 pm, Eric Wagner wrote:
> > > > Apologies if I made a mistake in the first bisect, I'm new to kernel
> > > > debugging.
> > > > 
> > > > I tested cedc811c76778bdef91d405717acee0de54d8db5 (x86/amd) and
> > > > 3613047280ec42a4e1350fdc1a6dd161ff4008cc (core) directly and both were good.
> > > > Then I ran git bisect again with e8cca466a84a75f8ff2a7a31173c99ee6d1c59d2
> > > > as the bad and 6e6c6d6bc6c96c2477ddfea24a121eb5ee12b7a3 as the good and the
> > > > bisect log is attached. It ended up at the same commit as before.
> > > > 
> > > > I've also attached a picture of the boot screen that occurs when it hangs.
> > > > 0000:05:00.0 is the PCIe bus address of the RX 580 eGPU that's causing the
> > > > problem.
> > > 
> > > Looks like 59ddce4418da483 probably broke things most - prior to that, the
> > > fact that it's behind a Thunderbolt port would have always taken precedence
> > > and forced IOMMU_DOMAIN_DMA regardless of what the driver may have wanted to
> > > saywhereas now we ask the driver first, then complain that it conflicts
> > > with the untrusted status and ultimately don't configure the IOMMU
> > > at all.
> > 
> > Yes, if the driver wants to force a domain type it should be
> > forced. Driver knows best. Eg AMD forces IDENTITY when the HW/driver
> > is incapable of supporting otherwise.
> 
> No, in the case of AMD it only forces identity if it thinks the device might
> want to use PASIDs (because of the architectural limitation that the RID
> always operates in GPA space so can't have its own independent translation).

AMD forces this because it doesn't yet have a way to automatically
choose it's v1/v2 page table format during alloc domain. It is just a
SW bug.

The CC/SNP limitation is also a SW bug but is more fatal as it can't
even attach a v1 page table in this mode.

> Either way, though, there's really little sense to that argument - if
> enforcing strict translation *might* compromise the device's functionality,
> we should instead go out of our way to ensure it's definitely as broken as
> possible? I fail to see how that can be justified as useful or desirable
> behaviour.

For SNP cases the attach of a DMA domain will fail, so yes, moving the
failure earlier and giving a clear message is desirable.

> "Failing" iommu_probe_device is merely how we tell ourselves that we're not
> interested in a device, and consequently tell the rest of the kernel it
> doesn't have an IOMMU (via device_iommu_mapped() returning false). 

Probing failing with ENODEV means the device has no iommu and the rest
of the code should assume DMA direct will work.

Probing failing with any other error code means the device has an
iommu and it couldn't be setup. DMA direct probably won't work today.

If you want all failure codes to mean the device is safe for DMA
direct then we need to try and attach the IDENTITY domain on various
probe failure paths too.

> I think I've now satisfied myself that a simple fix for the core code is
> appropriate and will write that up now; one other thing I couldn't
> quite

It really doesn't match the design here.

Jason

