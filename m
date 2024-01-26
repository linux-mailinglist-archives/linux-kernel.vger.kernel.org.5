Return-Path: <linux-kernel+bounces-40287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0107583DDA2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 336661C211ED
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB4F1CFAD;
	Fri, 26 Jan 2024 15:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RtiHZfi+"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B011B970
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283490; cv=none; b=V3LTaDgaGAMRvhfXYWQQETDr723EApkMeQyvvmnSKLF1uEYtsMco+U084TKEKkI/Qn2hvVlR7AsAyuN4F4g7AwkYAP89SKho2t89BtidD5xqZR69kk7a2va9YNmNLTpYF5WKvueMIAXKmkDH1CZZezc+u7/Qe9YQTLFHy3F0aVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283490; c=relaxed/simple;
	bh=NE4Sjf8Dg7SqoLejQ6feujTkrFV2RmwRB6VtZjUDVtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeSfS8s6oFi1TlPB2NLg9faaMYNybADGS1RNssJ567ZJdW0VK35NVmw28MN3AdYL4UtNAvv/m0ikzPUvI8h0xMTPCC95Qi8iL1/4Blk6kzgbtxeZB2uSZfwsyq13JpJNWR7VLA1oieammp//YDcGoi9lup/9H8lF5IDn2mFOIj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RtiHZfi+; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3be05826fa1so103430b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 07:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706283488; x=1706888288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DHXnx8afQv16BuE8CvDhlcpu6wVrXL3+T1JQxNtzp2I=;
        b=RtiHZfi+MnZhtJb4A+iFXt4WCYU7CQnU8pya9kGhjFjymnJ8WC0ciIlzaNfnk773iR
         ck2NLh9oDVd4dSPGpH5gsuBrjAOqD1L4GWmGjxbMgzhrUEsoTfuQ6dDuclFnHoTMbbnW
         9w3LW8QJ/JW58At6kPEDS61LfUEd6VHmXMK4aFUDg58702hTDJ1twa3Oy2aKJqTGCTlc
         okfz690smTGBnh7Ygfb2DSgtciYw5nCTUzZv7wBrhGz395lrVx1vdberPnY9xVZdCFDn
         K83FP2uVKLEuZatzE9/19bYinRlCPLlby6SnSj4QJ2VCoo3MG/Fclbeky89wMbwWpFaI
         Rd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706283488; x=1706888288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHXnx8afQv16BuE8CvDhlcpu6wVrXL3+T1JQxNtzp2I=;
        b=oS0ngPhCGS0dvu45G1C3BtVyHXUKfqQGlhzRFwmQV6c6LoXeMGKc4+dNNPRDa/x2QH
         c0iOG+rgI3/IGreWeDxgZt9Hof+WczOtMpWBpS9xnUNrm7is+7mWk5q6CYyqD5sZTden
         01AFgDn9KinaYI9dgJwH0McbJWJeX18a8+L8d3127Ls7VZalCJA3KwUJBmf1+py78/sP
         zv9Yj7x70vQqx3DBvD2CMY8meBvvJvcjdrBQLRgMxB39pWTIzSurRcKPaVWfpQOj5cf4
         cTT6i/8UpqrN+coNyrQRlNqIyJkERKvY4L0YHV52UhPOVvts95gwyFkMiMbNjKZCH/Sh
         uybQ==
X-Gm-Message-State: AOJu0YxPanieDL4I6oVifPoGres5lLICwDNXxJdG6fK2c4/qfAgXRTGa
	ZP3Do/NN8fpxhqStKHiwm88reEWmyPxAiQwEQrwvwsZT1Uk+XD3kVgd0QVsPtXs=
X-Google-Smtp-Source: AGHT+IEVGCeD2tM9LcGFGHmBJ+r7/F8U5I6RxMP8MFLTO92PxPlyG1PzNUzs0fbA+dDD2wknC9vMZg==
X-Received: by 2002:a05:6808:169f:b0:3bd:727f:9624 with SMTP id bb31-20020a056808169f00b003bd727f9624mr1825667oib.2.1706283487883;
        Fri, 26 Jan 2024 07:38:07 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id u19-20020a056808151300b003be012c9e19sm71884oiw.17.2024.01.26.07.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 07:38:07 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rTOHO-009S9B-F8;
	Fri, 26 Jan 2024 11:38:06 -0400
Date: Fri, 26 Jan 2024 11:38:06 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: Shivaprasad G Bhat <sbhat@linux.ibm.com>, iommu@lists.linux.dev,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>, npiggin <npiggin@gmail.com>,
	christophe leroy <christophe.leroy@csgroup.eu>,
	aneesh kumar <aneesh.kumar@kernel.org>,
	naveen n rao <naveen.n.rao@linux.ibm.com>, jroedel@suse.de,
	aik@amd.com, bgray@linux.ibm.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	gbatra@linux.vnet.ibm.com, vaibhav@linux.ibm.com
Subject: Re: [PATCH 1/2] powerpc: iommu: Bring back table group
 release_ownership() call
Message-ID: <20240126153806.GA50608@ziepe.ca>
References: <170618450592.3805.8216395093813382208.stgit@ltcd48-lp2.aus.stglab.ibm.com>
 <170618451433.3805.9015493852395837391.stgit@ltcd48-lp2.aus.stglab.ibm.com>
 <20240125155017.GW50608@ziepe.ca>
 <b825dd04-3d32-4fbd-91e3-523ddf96fc7a@linux.ibm.com>
 <20240126151701.GZ50608@ziepe.ca>
 <392247278.10124607.1706282995795.JavaMail.zimbra@raptorengineeringinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <392247278.10124607.1706282995795.JavaMail.zimbra@raptorengineeringinc.com>

On Fri, Jan 26, 2024 at 09:29:55AM -0600, Timothy Pearson wrote:
> > On Fri, Jan 26, 2024 at 08:43:12PM +0530, Shivaprasad G Bhat wrote:
> >> > Also, is there any chance someone can work on actually fixing this to
> >> > be a proper iommu driver? I think that will become important for power
> >> > to use the common dma_iommu code in the next year...
> >> We are looking into it.
> > 
> > Okay, let me know, I can possibly help make parts of this happen
> > 
> > power is the last still-current architecture to be outside the modern
> > IOMMU and DMA API design and I'm going to start proposing things that
> > will not be efficient on power because of this.
> 
> I can get development resources on this fairly rapidly, including
> testing.  We should figure out the best way forward and how to deal
> with the VFIO side of things, even if that's a rewrite at the end of
> the day the machine-specific codebase isn't *that* large for our two
> target flavors (64-bit PowerNV and 64-bit pSeries).

I have a feeling the way forward is to just start a power driver under
drivers/iommu/ and use kconfig to make the user exclusively select
either the legacy arch or the modern iommu.

Get that working to a level where dma_iommu is happy.

Get iommufd support in the new driver good enough to run your
application.

Just forget about the weird KVM and SPAPR stuff, leave it under the
kconfig of the old code and nobody will run it. Almost nobody already
runs it, apparently.

Remove it in a few years

From what I remember the code under the arch directory is already very
nearly almost an iommu driver. I think someone could fairly quickly
get to something working and using dma_iommu.c. If s390 is any
experience there is some benchmarking and tweaking to get performance
equal to the arch's tweaked dma_iommu copy.

Jason

