Return-Path: <linux-kernel+bounces-28458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535E382FEBD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65E821C23C88
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1950867C72;
	Wed, 17 Jan 2024 02:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="n3+HvqFW"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EA35CBD
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 02:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705458025; cv=none; b=TldjZ2EPL+h5/lrAiH+QRJauxqV4uWKvGV4++5t5ldG9w6AzjYD7jaD+8Qk+NAKMDyetMKCVs18K611fKOInhFrVNfDpy8MadJoDWoMNGwqAgTO2eIlrEttmKRVzo/2+nIvrge2Pgn4TZSJGS2HMJsXSLb2m3fDpkfjKd+jh5h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705458025; c=relaxed/simple;
	bh=7CVCiHmkWEtjZaOJE+H1yk91VAqzvFxUdjW7LQYfSRc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=Q58r2Xw9QBw5zOQAb5/UafCpxeEopgDR16LiHnK5khndtC2Uai38R7/H3I0SR37XretV/84Toy11xPeX66WORBW4LKcbBTk9z9UvKaDFitzJMGygu90KqDGnLfjKsN899jUzIoXZ4aNXr/mHasESZJ9wBsKMQUaK4jcmvYJvbK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=n3+HvqFW; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78329cb6742so520565485a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1705458021; x=1706062821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pYVZPcyXo7q2SktZ2+i1Gh7El+Ql5ZT8EyFJ+5OtVjg=;
        b=n3+HvqFWQrMBUuylBVwt3ABK/gekkt2vCCFrQpILSDGnPprm4KmIx7xN8uPJRW3Rcb
         zxpjFgxehAI02cDFVrb8GKcjysr9Wxbsz58PxnTX3Z+9zQp57g5Tc3xEz+Y40HCKqZzB
         aWNlBjL3k/MAUt84DeIl6zEF5Memal1tiRlfSvVQOL5Nlbunvj0pPjLPzMwEYp/ml/DF
         5SIuprZxl1MxC3psmlSUyklaKPcU42MZS2vACLz2gsCcOIMScSZ69RPr4kI5y6zTjrf0
         mbcRziPs2AdU8N7VthB8R0n8UV7PUZg7mLHHVUsHVbExMKGl//EdnyX4Z0hvvNRW4Td3
         bJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705458021; x=1706062821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYVZPcyXo7q2SktZ2+i1Gh7El+Ql5ZT8EyFJ+5OtVjg=;
        b=h9RpN4vnvL1hEL+Re79teDtk/yPAFzM8SVLN7pL5YIVkdyzhBWpvYHv2J72ytJDSFw
         6N2dV7XtpxfNbY2YX0xrZ1vOfBgGUITgYYgHpjCKNwXnc/bqUeHM/j7Uw+tQGWTIXgCp
         aRVgCAJmC6DrIGcgNY/ePc87KAsLmtDja8HntkU/t6PQjT7+MElqVqanTCWoAPtdXkFu
         jqHeJn5unmGEDNkh/ehCos27F4s5yX4ob4l/qL7c8fK2yDbRhacuITbccFxXj/4DMq8O
         Dqp67mDQoIKwqK121c0qZVcrQOGBi8s7gdz67leuaCXrfGO5Q2iaO7vUaCFHu46rbPe5
         nY3g==
X-Gm-Message-State: AOJu0YwLz/Hxg/+9CfS8GaL/bI3Kfz767/oWOQ3VlaJ49SplwbdyGujn
	hgXCuVZXqiy1VOLRBZqrjOB9ilZRvIsThg==
X-Google-Smtp-Source: AGHT+IFaky36LUNJ0WdGHSeGcJ+zHWWfUOIMulY4AsqbXvuDUu75qz5IBEXI5urAHMTEk+MnU6c9iQ==
X-Received: by 2002:a05:620a:4554:b0:783:539a:f319 with SMTP id u20-20020a05620a455400b00783539af319mr7292948qkp.13.1705458021691;
        Tue, 16 Jan 2024 18:20:21 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id wa12-20020a05620a4d0c00b0078321f3e7c7sm4172575qkn.114.2024.01.16.18.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 18:20:21 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rPvXQ-004Zr6-Fb;
	Tue, 16 Jan 2024 22:20:20 -0400
Date: Tue, 16 Jan 2024 22:20:20 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Eric Badger <ebadger@purestorage.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	"open list:INTEL IOMMU (VT-d)" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/vt-d: Check for non-NULL domain on device release
Message-ID: <20240117022020.GH50608@ziepe.ca>
References: <20240113181713.1817855-1-ebadger@purestorage.com>
 <20240116152215.GE50608@ziepe.ca>
 <46a61123-dd22-46cb-8b2a-15431fcc03f1@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46a61123-dd22-46cb-8b2a-15431fcc03f1@arm.com>

On Wed, Jan 17, 2024 at 01:57:34AM +0000, Robin Murphy wrote:
> > > ---
> > >   drivers/iommu/intel/iommu.c | 10 ++++++----
> > >   1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > Unfortunately this issue is likely systemic in all the drivers.
> 
> All two of the drivers which support deferred attach, that is.

We could call release_device on an unlikely error unwind path with a
NULL domain for all drivers.

> > Something I've been thinking about for a while now is to have the
> > option for the core code release to set the driver to a specific
> > releasing domain (probably a blocking or identity global static)
> > 
> > A lot of drivers are open coding this internally in their release
> > functions, like Intel. But it really doesn't deserve to be special.
> 
> Either way it shouldn't apply in this case, though. Crash kernels *are*
> special. The whole point of deferred attach is that we don't disturb
> anything unless we've got as far as definitely using a given default domain
> (from which we can infer the relevant client device should have been reset
> and quiesced). 

If only it were so simple.. It assumes drivers are structured to reset
their devices using only MMIO before doing anything to setup DMA and
trigger an iommu attach. A lot of drivers aren't and this whole scheme
turns a bit sketchy.

Some devices can't even do it at all. eg mlx5 has the crashing kernel
quiet the device before passing over to the crash kernel because there
is no way beyond FLR to regain control of a mlx5 device.

> Thus regardless of why release might get called, if a
> deferred attach never happened then the release should still avoid touching
> any hardware configuration either.

Interesting point.. Makes sense to me

> I'd suggest using dev->iommu->attach_deferred as the condition rather than a
> NULL domain, to be clear that it's the *only* valid reason to not have a
> domain at this point.

So if we take this release_domain approach and we have the core code
not call it for the defered attach case then the driver's
release_device should just free memory allocated by probe and not
touch the data structures?

Then the idea is that drivers would only manipulate their STE/DTE/etc
under attach and never in probe/release.

Jason

