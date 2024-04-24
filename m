Return-Path: <linux-kernel+bounces-156920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6817C8B0A5F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3F01C22C8F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD84D15B546;
	Wed, 24 Apr 2024 13:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bnPc2LbP"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A4015B14E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963902; cv=none; b=XzM7yJLfXv6znPTMNuwaygEt5CZjoHoL8F/libhKBh5/R6hnuO/O59WEFMHO4cHAU4FuLqLQIWZRwHNJhuCgCFR8JKJU3np8bmMWwWE1J7+BN9rOCoBxTBTZfMYy8P/X6gfm0m6NAZiv/L2CfxrjeVTDSqGbeuJvgAuUtR7/7h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963902; c=relaxed/simple;
	bh=FSxpfw5X3JKannFz6aCnhtqS7DvpDujOvyv9amJS5LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I638wajEIzresleorEpVqVEoyN4YplGoqMhdwq+YlP6PfFJ6FuRlzstif0ZE+Yr5hD3sDlF3QUuxIbJVAfcSwAYn4okeyALGHZqpZWzghS9d5SN153Y8Lc1DQ4kaw3JLzRNdxnMUfdsnu1ocwvMwGAn/y9kNZp4pbidj8hjB5CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bnPc2LbP; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5ac8e8ce2a7so376577eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1713963900; x=1714568700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nbc/ZlhMzbLo/3ax7yL4ZIM4VQzRDrjohLJqBNOiRFQ=;
        b=bnPc2LbPqNQp1VKFkc674np82S0LkIZEUxbZmCP6n+wOUhAlr8M6StlJdsP7A3cavB
         6f/sV1EpBrUPCiaju6wGMnFT1IxukCXxXNScPnUeeH9MIvyqW/5Y/8s1/1qNe5sF+zbK
         TPPKiLnT4udg9d7OS+GGtfYveBsnxeE4d+aB7n0nE14fWXTUBhzZkVg6oR56+4Q9yUAl
         UVw+Bs5YUONDwghELCzMTtreNHhZnyCAH0rk+vChqfvTos0lfQ66dKN/rdfsIAsosO17
         WlahfHIokLI2OsD1n4B3823Mpnj961LXc2UwEpZCp35ll0qiHc3ba/qT3N/lKKzNYXc7
         wNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713963900; x=1714568700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nbc/ZlhMzbLo/3ax7yL4ZIM4VQzRDrjohLJqBNOiRFQ=;
        b=gP+EYM+eZ6Cpka1My+AEQ1v2d6m6m3BotMziuu/LDwkX7bwyI7AdjqwRJIljB+8qL4
         p9SuhMlSNMtcmdTwXIk1H0Tm7Xk9dXy9tbY0oL3qJcWEMJzuJQaX5VDMeTelg7J60fR3
         xkwFRm0UDue4dmd4ieQHGXUYKnFK7I0YpDAQ4s3NzBYHapsPjbB+Ww42AYMHoeWKlinD
         43VFwWG18l7JmVJu93FIjMxwIyZTIxEp/QogwI06ZjvP5D+r35tpxcjt0rbjUN8FyRhv
         IaP7JdQ4oyX+K4xNF+jn/qp3euCd0iGGU1Rf4sSDNcjwUnDdgKALaBB0aBGIy9eAE1tt
         4sTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/Dx2+TvvkB+QHc44i2IyE/z01cBt8iJ44sAU4S7ho6zGs0Hl7PjSFukoifiNuny8YFqzzmEsJgRgBnTiqgSk//vclLBae+/ymR5eM
X-Gm-Message-State: AOJu0Yzv2Gom5DhinM19Yh4d3JunUx05XglYXMu3WHTAv7Ga6Lmzd2Sd
	n0tpyd20N4ppYUT8FTiYn3Z3SpyGBmpHr5WFE1tVZe7Krn5Rz+LGuJekp8iXWj43FGB+Uz2aReO
	G9X4=
X-Google-Smtp-Source: AGHT+IEHA0RheIKXaYWq3t0fLCW1LE7ebG1Op9pYKAXc/ZhXqWzTYKFvXAfIMS7+yw3mUPAtrNk4bw==
X-Received: by 2002:a05:6870:71c9:b0:232:fbb7:c633 with SMTP id p9-20020a05687071c900b00232fbb7c633mr1051735oag.11.1713963899893;
        Wed, 24 Apr 2024 06:04:59 -0700 (PDT)
Received: from ziepe.ca ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id mk9-20020a0568700d0900b0022f939a3e2dsm2834331oab.55.2024.04.24.06.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 06:04:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rzcIz-007uTp-Kk;
	Wed, 24 Apr 2024 10:04:57 -0300
Date: Wed, 24 Apr 2024 10:04:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, ewagner12@gmail.com,
	suravee.suthikulpanit@amd.com, vashegde@amd.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH] iommu: Fix def_domain_type interaction with untrusted
 devices
Message-ID: <20240424130457.GF231144@ziepe.ca>
References: <fa14583e94cbf540b60a6be94b41bb24d0037e75.1713272443.git.robin.murphy@arm.com>
 <20240416152943.GU223006@ziepe.ca>
 <3cf97e3c-c8d9-4282-a8ca-e4c1ea383dbd@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cf97e3c-c8d9-4282-a8ca-e4c1ea383dbd@arm.com>

On Tue, Apr 23, 2024 at 12:26:41PM +0100, Robin Murphy wrote:
> On 16/04/2024 4:29 pm, Jason Gunthorpe wrote:
> > On Tue, Apr 16, 2024 at 02:00:43PM +0100, Robin Murphy wrote:
> > > Previously, an untrusted device forcing IOMMU_DOMAIN_DMA always took
> > > precedence over whatever a driver's def_domain_type may have wanted to
> > > say. This was intentionally handled in core code since 3 years prior,
> > > to avoid drivers poking at the details of what is essentially a policy
> > > between the PCI core and the IOMMU core. Now, though, we go to the
> > > length of evaluating both constraints to check for any conflict, and if
> > > so throw our toys out of the pram and refuse to handle the device at
> > > all. Regardless of any intent, in practice this leaves the device, and
> > > potentially the rest of its group or even the whole IOMMU, in a largely
> > > undetermined state, which at worst may render the whole system
> > > unusable.
> > 
> > For systems supporting untrusted device security the translation must
> > be BLOCKED at this point.
> 
> So why is that not enforced then? 

I'm not sure what you mean? At this point the core code has no idea
what translation the iommu driver setup when it booted the HW..

I mean if a iommu driver is going to support untrusted then at no
point can it be doing IDENTITY while the untrusted link is up.

> Simply hoping that calling ops->release_device() or returning an
> error from iommu_device_register() might do the right thing is no
> guarantee.

The systems that support untrusted must put things back to BLOCKED in
their release_device() to be ready for the next hotplug of an
untrusted device.

> Furthermore I'm pretty sure we're still letting an
> untrusted device be hotplugged into an existing group without any
> checks at all.

Yes, combining trusted and untrusted in the same group, regardless of
domain type, is fundamentally wrong and we don't check it.

> > > Unfortunately it turns out that this is a realistic situation to run
> > > into by connecting a PASID-capable device (e.g. a GPU) to an AMD-based
> > > laptop via a Thunderbolt expansion box, since the AMD IOMMU driver needs
> > > an identity default domain for PASIDs to be usable, and thus sets a
> > > def_domain_type override based on PASID capability.
> > 
> > The majority of places implementing def_domain_type are using it as a
> > statement of HW capability that should not be ignored by the core code:
> > 
> >   - DART
> >     * system page size is too small, can't map IOPTEs, force identity
> 
> Not a hardware limitation at all, it supports paging just fine, and
> iommu-dma *could* in principle work with larger pages with a bit of effort
> (some proof-of-concept patches were posted some time ago). 

I was not clear, I mean a HW/SW/Driver/system issue. The net result is
that PAGING or IDENTITY does not work in the Linux kernel for a whole
bunch of good and bad reasons.

> >     * iommu does not support IDENTITY at all, force paging

Like this one is a good reason. No HW support. It is checked during
attach domain and fails it.

> >   - tegra: Device quirks mean paging and DMA API doesn't work
> 
> Hmm, I don't recall any specific device concerns. 

Thierry told me once, it is another ugly GPU driver hack IIRC. It is a
bad reason, some hacky GPU driver issue and is overkill since it
should of_match like qcom.

> >   - amd: The driver can't support PAGING when in SNP mode
> >   - SMMU: The driver can't support paging when in legacy binding mode and
> >           paging domain allocation fails as well
> 
> Quite obviously nothing to do with hardware.

But attach_domain still fails. From a core perspective PAGING doesn't
work.

> OK, so after all that you do in fact agree? In that case, why are we still
> mucking about proposing hacks on top of hacks in the AMD driver rather than
> just fixing the regression sensibly?

It is because your proposal is regressing the meaning of
def_domain_type back to a policy knob when I've spent a bunch of work
emptying out def_domain type implementations to get it into a
capability report.

def_domain_type is now about *capability*. Does the
HW/SW/Driver/system support PAGING/IDENTITY or not.

Meaning if def_domain_type says it is not supported then the core code
should not use it. This is how everything was working until AMD
changed their driver to lie about what their attach_domain would
accept.

I do not want to see def_domain_type regress back to being confused
where some drivers are policy advice and some drivers are capability!

AMD should hack their driver for the rc fix and then go and fix it
properly to remove the PASID logic entirely from def_domain_type. I
will also point again out that in v6.9-rc AMD doesn't even support
PASID yet so this abuse of def_domain_type isn't even needed. :(

The core code should contiue to treat def_domain_type as capability.

This has obviously become confusing. I think we should rename
def_domain_type to have a clearer name and clearer purpose. Call it
supported_domain_types() returning an enum of:

 SUPPORTS_ALL
 SUPPORTS_IDENTITY
 SUPPORTS_PAGING
 SUPPORTS_IDENTITY_PASID

Which is much more clearly about some full system support, not a way
for drivers to inject arbitrary policy.

Jason

