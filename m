Return-Path: <linux-kernel+bounces-56675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA7784CD74
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816711F213EB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA997F7C8;
	Wed,  7 Feb 2024 14:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TuqdcN5g"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9743B7E77F
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317821; cv=none; b=RuJdtP2k5sQN66udnSB+V4R+rmjl7OwYNFWne9PQgwHGGaWz3f03qLRx9ZwL0AF3mKA9SFAyQP8wVsn4hh8HU40PrOMTzBRYbipGHlcftd3eawBlMbsbQQR3+zENb0FngEeMHMphveEvMG8qF6E11pWwhPKrF/RYTwRUM5e/OqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317821; c=relaxed/simple;
	bh=/qjE+nqSpEqB34LHfo7cPWwv+pZ6RnEWm3Y5iE2Thd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t00F0GTehCcPkvTZv6yXkmtjP2J8t0g6DXM8PBKFTJPIi+XqXs6d1Xm5KlI/icjbvuQYqGyudnfPzBLL9tpgid7Ua/rB9V2vXAkNg9NUInDItn3KEdC4nKQ/v2r7ov2B4QuARFfGpxGLHxFVgsI7cQsEZqRaBcZzGDlQKwtqdxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TuqdcN5g; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bfdb84c0ebso404832b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 06:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707317818; x=1707922618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W0M3TTROdnQ99LEOVazWVIVuG+en6VXt1COOl14WDc8=;
        b=TuqdcN5gvVjifQyToKKHIrb62FsRQfdArYZ8Wk6zzRqDa6PeACYWWs5V87c9irJ169
         mtSBMBe0Afsar8dTeATIAtSxI4tnijzUWuYdygcMGx5G0hDvk4t79IqH2CGCF4ku+EyM
         u+cOk2DjPcA2tHIPygW1mVgjiodc36jclGo26XNtO6YVoWO6pjAppDPpE26cPzojyMit
         ZTgvJBH7Zp7H3yRkIjrKNIRSX6++llI+uTLis+8of/QzjDIu8Ekgue+HqWK55CytceEA
         qGcXsKF5wvBjqz8g9dWCGvlYZuenqFccHFmsxG0PD9l/v8/VJi5f5/e/CXZJbqEU7pg8
         Ta9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707317818; x=1707922618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0M3TTROdnQ99LEOVazWVIVuG+en6VXt1COOl14WDc8=;
        b=rjrIgH7ke+4gLwf6XgaEt1OprGAtb2Egr+QhosDC7u8ix+Le93nhNeX8QjomWHt/5+
         S7S1vUfHguqx9GouYhgj46k8LPLp3Uj+IwGqegvNq15JHSGs0HsxnEtOxAFnKWgUsfN1
         Uz4DjRxKGp5UFxQxZJUg+cGtbY1jwbh+iUcPCxzVql0NMOC9wK2+JxH2HiNBwmqz0eFn
         81PQ8gplgpYWBWIP19kiy9FaKzqR3kAfpOX6QE4qsrBaXnfy6uYUof5DZditqumFts2/
         3XeD7Lbkgzs4TDpMzxEDTuGK5/8caoqyvpZeuSBeH5ekrLsYnUI9gpWUHVq6KR0eVHdN
         /E5A==
X-Gm-Message-State: AOJu0YzR+Cw862zqMZ5d1lnbCINmNpymlLWjho3SKsiYrnMON3evRykS
	V9BfVi1gbmRL9lduuftegdOvzFRDJ2m1Pq3vOIrfh/lQRGAc+z8n14awbQtzN/s=
X-Google-Smtp-Source: AGHT+IH0cGhGSUUEHRfNJyx46hgtKE8MP2Q4bijQoKH/+hSAOGqsrBm8bmc4wOyxrlNBdW++URiPlw==
X-Received: by 2002:a05:6808:228d:b0:3bf:e427:d11e with SMTP id bo13-20020a056808228d00b003bfe427d11emr6918880oib.27.1707317818498;
        Wed, 07 Feb 2024 06:56:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW8Vl0sHpxqYNmb3IO1yaxSDS8Kwsbp3SFMBoVHT0KITNM8mecYYn7vRx6DgxJfxVsz+8az+e0iU511lusFO7VEXsStZrpyPCtahqJFSKIGp8qCQyhZ0VBPq9iFSzT5sLyGS4mfU/JS0TPw+n5X0EUOaI1UuaMhwyQbc2p60pV8YqEJk9NQa9hCOGfMvMJCYaBBPATZLFVDBMKCOu06L4Izdao9SVg=
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id es11-20020a056808278b00b003bfe85d3a62sm205325oib.38.2024.02.07.06.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 06:56:58 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rXjM8-008VpY-Vw;
	Wed, 07 Feb 2024 10:56:56 -0400
Date: Wed, 7 Feb 2024 10:56:56 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nikhil V <quic_nprakash@quicinc.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Charan Teja Kalla <quic_charante@quicinc.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu: Avoid races around default domain allocations
Message-ID: <20240207145656.GJ31743@ziepe.ca>
References: <e605b38a2d40b1e7589e10110c6d3ece35f6af4e.1705571894.git.quic_nprakash@quicinc.com>
 <139a9abe-75d8-3bda-3ec9-a14a493eb2a9@quicinc.com>
 <20240201162317.GI50608@ziepe.ca>
 <9ba9c4fa-3fa9-c6c4-ce77-0c6cd5e23680@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ba9c4fa-3fa9-c6c4-ce77-0c6cd5e23680@quicinc.com>

On Wed, Feb 07, 2024 at 07:56:25PM +0530, Nikhil V wrote:
> 
> 
> On 2/1/2024 9:53 PM, Jason Gunthorpe wrote:
> > On Mon, Jan 29, 2024 at 01:29:12PM +0530, Nikhil V wrote:
> > 
> > > Gentle ping to have your valuable feedback. This fix is helping us
> > > downstream without which we see a bunch of kernel crashes.
> > 
> > What are you expecting here? This was fixed in Linus's tree some time
> > ago now
> > 
> > Are you asking for the stable team to put something weird in 6.1? I
> > don't think they generally do that?
> > 
> > Jason
> 
> 
> Hi @Jason,
> 
> Considering that the issue is reported on 6.1, which is an __LTS kernel__,
> any suggestion to fix this issue cleanly would help us a lot. Right thing
> here would have been propagating the changes from 6.6 (like for any
> stability issue), but considering the intrusiveness of them, is it even
> possible?
> 
> Just to be open about reproducibility of the issue, a bunch of them are
> reported, both internally and by customers.

I think you need to talk to the stable maintainers not the iommu
upstream folks. I don't well know their policy.

Frankly, I'd suggest just proposing the necessary (and tested)
upstream patches to 6.1, however large they are, and see what Greg and
Sasha say. This is the usual working model they have, as I understand
it.

Jason

