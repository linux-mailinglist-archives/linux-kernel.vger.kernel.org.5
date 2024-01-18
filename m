Return-Path: <linux-kernel+bounces-30522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4C5831FCE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C18D12896BF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC972E410;
	Thu, 18 Jan 2024 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Yn3hlWOq"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E562E403
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 19:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705606592; cv=none; b=ht0Q4M1MjfkZgUsJfx4HpP5LvRsG74prx6U4nkzYcWfS9U9ZGXUBR1sYgz/a7z7b8K/YL6y1LNrc571O7ixsWwKBQbDic7BawggCW71/CRiSx+/Amqoe55HW1fn8qT+BLqn6ZU44jXUkmwDqd3gaygcjI382CyFHTKQ7qut1t44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705606592; c=relaxed/simple;
	bh=RhUutAdIJhj+56TWvVpkohH7higOxofuXmtZ8gXAS0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ir3Cm0CvEwr5Vwa/984BDuz8WQ0Q+ux+Vnx1uhh7B74886F3RTzvOrIKhgKssDRe9TUOeH7Ci5brzXKI4Ah6XqRMvpqx5mxVIiT/EEgbHqZbq9srdcOlEyi0HFpfF2Q2Z8l4g/0wSUA5OOgFlmB7lkPXUkQ2RoUe34eC20q0PBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Yn3hlWOq; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2108e106947so39698fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1705606589; x=1706211389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l2PskYN91C/N8uLAsb2pAS+pkc4njoKmH/O+Ga1GokQ=;
        b=Yn3hlWOqvTFpiOKycyrkMVg7msldVrhBAdPIQmbAozisbKiaMNZxhbW4CLrZgIeVO7
         RkPZuwQfbUJfOiICGAeXuPsn9dsypIXXg6P8mt057TZA8cOQl5gmk914DQFLwOWWtHk0
         NATSvInDrT9E/LNhSK4qHjIRaZ3HQNdm6BgmFRntZpuM9nz/pdvrajjLxU9Ckh/7h7Mt
         KGFzJlCfYqEXsBlXM7xpQmQO2F+AVEyQy7PVabBmvhE39mpYkR+Fm/iAiEDtlUjccYHo
         Z7K1am8FJ/qpAGAzXpWjM8cKXkszBtiWSAO4wThDSOrgUf+eD6Cctahyv7AibU5WH6W1
         /vbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705606589; x=1706211389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2PskYN91C/N8uLAsb2pAS+pkc4njoKmH/O+Ga1GokQ=;
        b=ZDZNb4WeVFBENUBOqfMuhYrnqztEe5pfCQHSCe8FS0oM2Yv9BqJ3LSl5bmQZTyoos1
         HuPa1L+giG++0Ydg09bEKbfriVgIcQWPCwODA5heLXqKbCIN47Fah+dg6fXU6WH11rcD
         DG+wG+GXgQV8laijA08FLJy7EMvpIMR+FqwI/nMEHKTJcSA6wGRFKNwkHR2vK6Hrw0KW
         sHeGZ4GTaNPAgHuAZt1lG8aElNjNShc2yo6xCvfFr4Zq1exIBSaFq6+eApdmIEtq78j7
         BkA9sshN5KqtmwiAv9wgfBE+23uONNu0gcMdGvhVTmguKtLo0l1nUeoB0bYVpTjYxKy5
         j0UQ==
X-Gm-Message-State: AOJu0YxtMd0EW6lFiFTOhmkoh6hX8XWPqjYWFhvrv2lTB9zFQU9gSd54
	GGQXpWrj2T4J6Zn5pstng/MVHHxlhW04odTQUGU+0tM7Z6AlQDo67TNKbGLTNE4uQ22jNHoCOgD
	z/2I=
X-Google-Smtp-Source: AGHT+IGcDCQed2oC90eSpiV4K0U2TE1f43Rh5brUKnoNn+8w5+ly9/pUcR1AINSn0E/WwPXGq3E0BA==
X-Received: by 2002:a05:6870:a923:b0:210:da44:c885 with SMTP id eq35-20020a056870a92300b00210da44c885mr98748oab.45.1705606589379;
        Thu, 18 Jan 2024 11:36:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id fs12-20020a056870f78c00b002044e1b74c5sm519705oab.52.2024.01.18.11.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 11:36:28 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rQYBf-0058a6-G1;
	Thu, 18 Jan 2024 15:36:27 -0400
Date: Thu, 18 Jan 2024 15:36:27 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommufd/selftest: Use right iommu_ops for mock device
Message-ID: <20240118193627.GJ50608@ziepe.ca>
References: <20240111073213.180020-1-baolu.lu@linux.intel.com>
 <20240111144840.GW50608@ziepe.ca>
 <016e052e-8a99-4d60-b864-87c9859953f2@arm.com>
 <20240111155648.GX50608@ziepe.ca>
 <e08cd3b3-7ce0-47c9-b2f3-28095987f46b@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e08cd3b3-7ce0-47c9-b2f3-28095987f46b@arm.com>

On Tue, Jan 16, 2024 at 06:19:00PM +0000, Robin Murphy wrote:

> > > As I've tried to explain before, this is in fact the correct use of fwspec
> > > as originally designed, i.e. being set up by *bus code* before device_add()
> > > (remember this is not the "IOMMU driver" part of selftest.c).
> > 
> > I understand it was the intention, but it doesn't relaly match how the
> > code works today..
> 
> The fact that some things aren't following the pattern, and are broken and
> problematic in several ways as a result, does not mean that other things
> that *can* follow the pattern correctly shouldn't.

What pattern? fwspec was never setup "by bus code" before
device_add(). I'm not even sure I see how that will be possible since
fwspec relies on the iommu driver being present to parse the FW tables
to create the fwspec in the first place.

The main tension is that the information the bus code needs to supply
to parse the FW has to go into the driver to accomplish the parse and
then be discarded once the parsing is done. Why would we attach
temporary data to the struct device prior to device_add and waste that
memory when we can generate it on the fly with a bus op callback?

> > > I'm working to get things back to that model (wherein the dev_iommu and
> > > fwspec lifecycles become trivial), just with the slight tweak that these
> > > days it's going to make more sense to have the initialisation factored into
> > > device_add() itself (via iommu_probe_device()), rather than beforehand.
> > 
> > I would prefer to simply remove fwspec as I've already shown patches
> > for. You should give some comment on them.
> 
> You mean the 1600 lines of churn which did nothing to address any real
> problem (but did at least acknowledge so in the cover letter)?

Sometimes it takes cleanup before you can solve the real problem. Just
constantly hacking around the edges often creates an architectural
mess.

Indeed is not quite nothing - it did solve alot of the wonky lifetime
issues throughout and replaces an incomplete abstraction with a
complete one.

Look, put aside your aesthetic distaste and point to something that is
actually fundamentally wrong and can't ever work with what I've
done. I showed everything, so if there is some issue it should be
visible.

Otherwise you should admit it is technically sound, even if you don't
like how it looks.

> I thought I had responded to that, but it must have been one of the
> many drafts which end up getting deleted out of utter
> exasperation. Needless to say, the response was a NAK.

Nope, no reply!

I think you should take a careful and thoughtful look. Given it is
right there ready to go we can be done with this probe mis-ordering
saga in a couple of months.

My plan is to break up the three parsing ways into smaller series and
go ahead with them in stages.

> For the last time, any fwspec lifetime issues are a *symptom* of a
> well-understood problem which exists, and not a problem in
> themselves.

There is more wrong than just the lifetime issues.

> some stuff being carried around in iommu_fwspec that really
> shouldn't need to be, but once probing is properly fixed it will get
> stripped back down to the useful shared abstraction of stored
> firmware data that has always been its true spirit. 

Which is what exactly? What can you put in the fwspec that is actually
shared by every, or even most, drivers? From my complete analysis the
answer is pretty much nothing.

> In the meantime, adding a load more complexity to unabstract it and
> support 2 or 3 different ways of drivers all individually
> open-coding storage of the same data is not helpful now, and even
> less helpful in future.

I think you should look at the series much more closely, because I
don't think that impression can really be justified.

Most drivers had a net LOC reduction and many had a significant
reduction in their probe-time complexity, like apple-dart. Many little
bugs and missing checks went away because the shared common code was
now actually doing what the drivers need.

Like it or not we actually have 4-5 different ways the drivers do
things! Explicitly supporting those ways and factoring common logic
into common code is *good design*. fwspec doesn't do that, it
 supports *one way* and everything else gets no good support.

We already had several different open coded ways for ID storage. That
isn't going away as far as I can see. The one common method, the u32
array of ids, is shorter, faster, and uses less memory. At no
significant complexity cost either.

The cleaner layering between FW parsing and IOMMU driver parsing, I
maintain, makes the whole thing easier to understand as the FW code
layer has a clear API boundary now instead of being messily co-mingled
with iommu code.

Jason

