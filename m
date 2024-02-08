Return-Path: <linux-kernel+bounces-57359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 821EA84D776
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1965B22381
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68261D6AA;
	Thu,  8 Feb 2024 01:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DuoQhmuG"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDBA1DFD9
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 01:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707354790; cv=none; b=elXCyFrS+ieWCBcl2uoRFUeE9Xue1njj6ixkhZECeAZPWFTYviGXH0Hfut3totx2Xuei/ZeNzX9pVCRb+nxRXi8/g3u/zXsZ2zJtFxv7tY3eNaKzooaWknAKCafjVaj7B0c/j3SIvgCb0mDaAcqJnH/ba+fFvrnDc3aeELix1Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707354790; c=relaxed/simple;
	bh=yScPOF8WrSenAGTUkyEQRqEcunLC5CJdwIIrDEnpy+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Em63SlnIsrXDPlvOzf69MEzn/1OI+itl5KtoIgF22h/3C+/I7g/8BhxJT8uXy1hpNQXKrFlC3G9S3la0sMpsyqk56+evWSZZVVDuqauITruO4yQHku/2AL4KmDtH44WIZPTU2JAd8jQDhwjEUpT2Zrnbw8mK1XVt93XGcDqoWTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DuoQhmuG; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6ddca59e336so230172a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 17:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707354787; x=1707959587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3MLv8CAUfSagrlhodaWKNWgVzAaOQjo0pM5UtQzgUUQ=;
        b=DuoQhmuG0sctyhoitdUlfCmDOLv4TbKoQ7PXawTCocXJqmRCUGZFKMauGoJGv93p4v
         6ZwLOkIuSb8LB1prnSs/cjGOjOIz2z4q42pntebH9TYzmuCbhwst6WHPKXGNVhbhc2PY
         opT8LHJ3EVXkSimciroBIxcgW4+hplRbJN3MKLpeLYJPpBtrbxCcDHXfVLYiLSuOjXXu
         qzHD4jJeRdi7KpQVfhjVIwS+Ydwn9qtUqcoGtualI1dADCo0tl5g3LRfljaPyffDgPMG
         1XWYBclwzNvhsYPczww0v8UBtMjUPXTUn2lZCm8/LphK6oAvCFnrbAzg8qlv8G65xrn3
         nCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707354787; x=1707959587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3MLv8CAUfSagrlhodaWKNWgVzAaOQjo0pM5UtQzgUUQ=;
        b=qMn3M0lXFhWgb2mvwihHywKQn7MYKONMqLQL9M45xaqivAjJ35ml9nfoYeBbY7rK9a
         SukPIEWI/cpW9wfMviSC0Pt9ZNZ4WPUSMvPeL3AgMyb1hgHOlumUp6E3rmolcfqyFUFg
         X4UgTOuPrhzwZRcSpX6E6TuHnkITa9RUT9i//Q2Xu0KvkCFQdm0d9cDbTMNlOdv475O6
         XmVnXy74mmhx2cFVjyP1ARib4J0rui+MXunt2lVGTDQy7jexnjiCN5XP2yt+1LoKhdJ/
         H84QXY2cdKUGstLaXJF6y6plqLyLVTXAc5qGZhI6giUMSsd2fO1XQbtM33xvUCB2ButH
         FPvQ==
X-Gm-Message-State: AOJu0YzVRubfSOju/9QS8YNSVAVRswmS2Qh44raxwQAUw6dRptuv3Fk9
	deT+mereEd8si/4rOzEhCBMjcT2lTvLoAa8FghKeLB87tRTEfchhdC84vuoOvqhFr8xhaB8xpTM
	R
X-Google-Smtp-Source: AGHT+IHmcvbcyMlsNym9pH4+Y3ZNvq/GkFWDijh2Czdvifds6S6RPwX3FfVNGCZYcZuAG0BmRv+ebg==
X-Received: by 2002:a05:6830:4107:b0:6e2:b00c:8d78 with SMTP id w7-20020a056830410700b006e2b00c8d78mr675168ott.1.1707354787569;
        Wed, 07 Feb 2024 17:13:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX5oA7olDzl/Cnv75qmNczwOe9W3QaJ/QKpsDbETKMj7yZ2DK+dXE3LSHpxq2XUcGA4+SAeSGPVU43vzi/aoll+xULrfmtTvE+X0u0WaZV7+GtnUUhJ43vqiwaiFKNCyhqXau+vPyIHT8ArVQJ3/swiv/bb+ooC/S+XfJc22Dd8qE3YJfukMsYb5smlctLZ7omLPHIHZt2MN+qlK/4K38Yg
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d8-20020a9d51c8000000b006e2c026aa59sm99665oth.72.2024.02.07.17.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 17:13:06 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rXsyP-00BpUM-Hs;
	Wed, 07 Feb 2024 21:13:05 -0400
Date: Wed, 7 Feb 2024 21:13:05 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Nikhil V <quic_nprakash@quicinc.com>, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Charan Teja Kalla <quic_charante@quicinc.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu: Avoid races around default domain allocations
Message-ID: <20240208011305.GM31743@ziepe.ca>
References: <e605b38a2d40b1e7589e10110c6d3ece35f6af4e.1705571894.git.quic_nprakash@quicinc.com>
 <139a9abe-75d8-3bda-3ec9-a14a493eb2a9@quicinc.com>
 <20240201162317.GI50608@ziepe.ca>
 <9ba9c4fa-3fa9-c6c4-ce77-0c6cd5e23680@quicinc.com>
 <20240207145656.GJ31743@ziepe.ca>
 <37ab8689-5e0d-4166-bad6-84d3c51446ca@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37ab8689-5e0d-4166-bad6-84d3c51446ca@arm.com>

On Thu, Feb 08, 2024 at 12:04:44AM +0000, Robin Murphy wrote:
> > Frankly, I'd suggest just proposing the necessary (and tested)
> > upstream patches to 6.1, however large they are, and see what Greg and
> > Sasha say. This is the usual working model they have, as I understand
> > it.
> 
> To be blunt, hell no. Stable is far enough from its namesake already; the
> ongoing bordering-on-ridiculous brokenness of your mainline changes where

What on earth are you even talking about? POWER?

> That said, I also don't think there would be any harm in applying this to
> mainline as a belt-and-braces thing either,

Really?

Now that you've made me look, this patch breaks the
iommu_group_store_type() flow both on latest and on v6.1 from what I
can see.

On v6.1:

iommu_change_dev_def_domain():
  
        prev_dom = group->default_domain;
        if (!prev_dom) {
                ret = -EINVAL;
                goto out;
        }
[..]
        /* Sets group->default_domain to the newly allocated domain */
        ret = iommu_group_alloc_default_domain(dev->bus, group, type);
        if (ret)
                goto out;

But this patch changes iommu_group_alloc_default_domain() to succeed
always without doing anythiing.

So this patch needs some fixing.

There is a very good reason the stable people don't like boutique patches..

Jason

