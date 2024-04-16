Return-Path: <linux-kernel+bounces-147127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F678A6FD0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9AD1F22152
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A794130ACC;
	Tue, 16 Apr 2024 15:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fNTrCVgf"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01F31304A2
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 15:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713281387; cv=none; b=eSXDVpam2D2QT6WfBbRk39SuVU2swhEQfJ3mcBTxwKGFkInr+Jgs6HBiADZW6ssJrYWKnBHC35NXfixHMM/V5s37vqDdClF67cIk3Je1GUPTOWX3fbX4B46lsQUeb9hr4gq9NvUgRkMHTNvrQt8LOTnpTLDfXQd44Ip1N6gH4Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713281387; c=relaxed/simple;
	bh=N5prF0FaWdPob3YwO19P3byW98fbFcSX6G2WX/kGCXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfLXgntQ0PS0ulVPnAwxLt04UkGBLeacY5jhlLuEnwoIBQebapyXOd6/vsvgwif4CnRo30/YJZSgPL8BukhEMaTQVdL/DAd+X11Na2ZlxiJtuBgq5b0q+A9Rrkv5l4HbEV08AJ1Qk/lOHq8AL9LGIMMYtNoBPxfs70KHPCcyX/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fNTrCVgf; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-434925427c6so16506651cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1713281385; x=1713886185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7s25aMASpVRUeKUKXzKd+zK4MQIEa6+60XfUEWUrr9g=;
        b=fNTrCVgfVRxE84QBRf1v8ZTaFhCvc1iFzRaLNmL77YKgEcsd3VgeG0ylIPHP4bEUyQ
         ewbVRH3eI9vPR8NSknglUfy5Mw6zjPwOPv26R7qZoKCnMETPyav3QAoA5cflw6NG95Nd
         jOj7yiiciearjYWBqgs+sIgRrNBL4X04GytUCkQk3hoXmufWah0OUXTmbgZdl/64yP+f
         agfnqf9IKQlAvkLeEYZiXJCS1wH6H7MWVoxwwT8wt1BXMPivitdpG3Q/z4UuTdRel385
         /I9qW+8+g5iSVZSY4EPj93p4mBR+bpuc3X4AQQKFomea+TSLIPpeVwQs2U4LoRmpz6oT
         XSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713281385; x=1713886185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7s25aMASpVRUeKUKXzKd+zK4MQIEa6+60XfUEWUrr9g=;
        b=EZ/DHn27E+tCU7aklHlPgwSLgcDKUf2WqPy/4ZDLJGT4w+GrvrtaDZ4OKqF2/gLfHs
         6pjVVbTm2vSPLJM9F3WrZKTVkAGvMm7vzb0bmX/Z3L1RSjiwoLGxfb4ujEBhHD185Fbm
         HLXV3IB6gcs4OBglpQJseIcji3m9+tEgfpDldwdtf7HiIFSxWJs/61zFgXwkir+fHLc5
         R4LQMV/RSO+pkX8KLvqLhYqEwbBcclRYNK0NC2vmmjy0kvEaYB3ufik007/6LvmJiaE7
         DJRWtjCiBQc4RCHdpxO68/y5+zxKzTJKtsj+kOR5ve7OZuaKZdCmZ0yKwRuM2Z3DelT6
         tHZg==
X-Forwarded-Encrypted: i=1; AJvYcCXTTKQxSf7a4ud1XjdSHhmBAIkY2lTKAroMSFeTWYcD5ZoyKQWcKb2TzL+HbtcC/uI3OMGhg+/c6qSdplF77DO5j27fhoPy/74cv1+H
X-Gm-Message-State: AOJu0YzbpZEmlcxp2lhaFmKi/BiogEmLYc/XqhkAs7yilCXEfpFgcQiX
	4u8z7dEJVu+LTuyCigLCeLcTyQkP5u/qbEAZwm6xzT+zuaIVj60Mll1cBVIXxcA=
X-Google-Smtp-Source: AGHT+IF/3k1/teQJA1GB8J3pMCstLtjiobAISw7ClEQWRiHFNDW7XzfII5GKKYoGzBoTUGYQ5TEi/Q==
X-Received: by 2002:a05:622a:1313:b0:437:5ecf:5ef8 with SMTP id v19-20020a05622a131300b004375ecf5ef8mr313548qtk.21.1713281384704;
        Tue, 16 Apr 2024 08:29:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id ol9-20020ac84149000000b0043721c4654csm1820605qtb.30.2024.04.16.08.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:29:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rwkkh-0094DA-GG;
	Tue, 16 Apr 2024 12:29:43 -0300
Date: Tue, 16 Apr 2024 12:29:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, ewagner12@gmail.com,
	suravee.suthikulpanit@amd.com, vashegde@amd.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH] iommu: Fix def_domain_type interaction with untrusted
 devices
Message-ID: <20240416152943.GU223006@ziepe.ca>
References: <fa14583e94cbf540b60a6be94b41bb24d0037e75.1713272443.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa14583e94cbf540b60a6be94b41bb24d0037e75.1713272443.git.robin.murphy@arm.com>

On Tue, Apr 16, 2024 at 02:00:43PM +0100, Robin Murphy wrote:
> Previously, an untrusted device forcing IOMMU_DOMAIN_DMA always took
> precedence over whatever a driver's def_domain_type may have wanted to
> say. This was intentionally handled in core code since 3 years prior,
> to avoid drivers poking at the details of what is essentially a policy
> between the PCI core and the IOMMU core. Now, though, we go to the
> length of evaluating both constraints to check for any conflict, and if
> so throw our toys out of the pram and refuse to handle the device at
> all. Regardless of any intent, in practice this leaves the device, and
> potentially the rest of its group or even the whole IOMMU, in a largely
> undetermined state, which at worst may render the whole system
> unusable.

For systems supporting untrusted device security the translation must
be BLOCKED at this point.

> Unfortunately it turns out that this is a realistic situation to run
> into by connecting a PASID-capable device (e.g. a GPU) to an AMD-based
> laptop via a Thunderbolt expansion box, since the AMD IOMMU driver needs
> an identity default domain for PASIDs to be usable, and thus sets a
> def_domain_type override based on PASID capability.

The majority of places implementing def_domain_type are using it as a
statement of HW capability that should not be ignored by the core code:

 - DART
   * system page size is too small, can't map IOPTEs, force identity
   * iommu does not support IDENTITY at all, force paging
 - tegra: Device quirks mean paging and DMA API doesn't work
 - amd: The driver can't support PAGING when in SNP mode
 - SMMU: The driver can't support paging when in legacy binding mode and
         paging domain allocation fails as well
 - qcom: Looks like these devices have some iommu bypass bus in their
         HW and paging doesn't work
 - SMMUv3: The comment says HISI devices cannot support paging due to a HW quirk

For these force overriding the driver knowledge will either result in
domain allocate/attach failure or a broken DMA environment anyhow.

The AMD PASID thing is actually unique because the driver can still
fully support PAGING, despite it wrongly telling the core code that it
can't.

This is happening because it is all just a hack to work around the
incomplete SW implementation in the AMD driver. When the AMD driver is
completed its def_domain_type should be removed entirely.

Since actual PASID AMD attach isn't implemented yet we could just
remove that check from def_domain_type as an RC fix. Vasant can sort
it out properly by disabling pasid support on untrusted devices until
the DTE logic is fully completed.

> In general, restoring the old behaviour of forcing translation will not
> make that device's operation any more broken than leaving it potentially
> blocked or subject to the rest of a group's translations would, nor will
> it be any less safe than leaving it potentially bypassed or subject to
> the rest of a group's translations would, so do that, and let eGPUs work
> again.

Well, this is true, since we can't handle the probe error it doesn't
matter what we do.

Jason

