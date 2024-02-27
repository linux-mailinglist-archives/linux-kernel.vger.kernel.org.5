Return-Path: <linux-kernel+bounces-82792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2BA8689C0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EFC9B2476F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704BB54BC7;
	Tue, 27 Feb 2024 07:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XAvCS9LG"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170145467A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709018448; cv=none; b=J/SYXdiiJB04KYw13n+vPmLQ/dt4wSHBtb0oA+yY5GDTT/X3lRSjk3bkKnBH4oOqwxuHMFC23izLcq7TLyp4vxceBfy3saZn4RB4uJLdFuXdrdQ2wkzbqjYVU3gs/DzyqT/jWWqbiUcluREDszFVqFkcsh33SsqexDHfKlenKOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709018448; c=relaxed/simple;
	bh=jFD+J/7osmXKpIC3TFgHsoSYx1D/6a4Vkb0pR6Tszwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBB+HbDdxJAPP4+APk4DnaCGpPD24kcPH35yzyVNIwpSkFfQjOO1no7Yf0xgwjeTvwI3bRB1WswFl8uC7z3XAuY0HkIRaOhrUQMb9c3GJsU6cLx8AH2weavt1v9La6L5QqtJYhJ4KHrpAHJhX8SxoI+yQ3GyQRo5LmFxswsTPIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XAvCS9LG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412aec2505dso737225e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 23:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709018445; x=1709623245; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FQ3ECuKh6c0xuGXZyTU0bxO9IeMYLwcYWqGnI4Uk05A=;
        b=XAvCS9LGhcW2MaquASW1wbA753N/w/TTJ3AYPFhinuL0pywxdvngxbRnRdxGwsAF4u
         XT3qzTR/gIEJqkbdeKbxxBtGzLvf2CNJKAlhq8PUHqZ/LF19gToKx9VXnxWLBSvitnGr
         15j+Wb16WDvUbpOHqAfIV+tvvRXCmG2j3y/iqwGb9XAM2M3J0ss7vq2+QGMDggsaF3vC
         puVdCDWcaVyNGC2TAuazFnuuqX+WWQp15M6XiaDsUJL3xqbADxzZxNX84A37JDVZsNnF
         Z7GEs/jgA4QG0mFm82kgbdo/1i3GeOESiboF280PJEFW1UVyymYn/QxVsqZQUXxab77R
         I3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709018445; x=1709623245;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FQ3ECuKh6c0xuGXZyTU0bxO9IeMYLwcYWqGnI4Uk05A=;
        b=j6FWSzSXogayvfgpAXl9X2dSLal3RGqnG+gCdLOJEgdRSiU5wJ3ZPKsgrRuLw5aVL5
         j6JWoXX5UBUcPYpKLCzobeTxg2J9OMNsFLwqrnW1BVlH57IuK59Ws7LnCQ8Qt4yFJ3dm
         LhyUanmiXzu4Dp8c+0CxZk0xvT4J4ZKfWOPlqugUaTDDHigdX79F+Kxt/LD/D+WkM5uh
         df6bNOapUdTfknBO4BxP3Hdds0vRbaBcvIliUOT0+LAiQ0sb0EJM+PoXCaBXObk5PfDO
         AACEd5X8vOfJR1+gshsQ9V5cmOOmOqlwOHVDoBMdJGbsdYNZ9iT26ePexeQWNjozaqZ0
         BBjA==
X-Forwarded-Encrypted: i=1; AJvYcCVV/IWHaF1dkCxt/HGYWfSErVnFS+NYGYspQSWU+EjAsPpmhncMsZ9HEAuh6rsD5yJfnkqEGLqzHU5XnJOW1pgzXGcFiCI71wyyBTRp
X-Gm-Message-State: AOJu0YxT3gRuaoMmqF5LeVMxIfj8qYjZqLw1d/2rxmfU+DDuWvn40y4m
	Qk6zxbA+/I9zG0gKtB3MWUVsb7RV34Kj8TnFkjs/hf7fMrLIKSVN/LkBt3QzU/4=
X-Google-Smtp-Source: AGHT+IHWVqCWPI3YRRb5LVqqw39FJgrixLKzi0fw2aCaLcXTvO6Rm/mEex9bYq+qCnKGaU8HCoOVdw==
X-Received: by 2002:a05:600c:3154:b0:410:8071:6931 with SMTP id h20-20020a05600c315400b0041080716931mr6781548wmo.20.1709018445251;
        Mon, 26 Feb 2024 23:20:45 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id g10-20020adfd1ea000000b0033d282c7537sm10772977wrd.23.2024.02.26.23.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 23:20:44 -0800 (PST)
Date: Tue, 27 Feb 2024 07:54:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: baolu.lu@linux.intel.com, bhelgaas@google.com, robin.murphy@arm.com,
	jgg@ziepe.ca, kevin.tian@intel.com, dwmw2@infradead.org,
	will@kernel.org, lukas@wunner.de, yi.l.liu@intel.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v13 3/3] iommu/vt-d: improve ITE fault handling if target
 device isn't valid
Message-ID: <8a220db4-a784-4dbf-9c6d-dcb4b47c0083@moroto.mountain>
References: <20240222090251.2849702-1-haifeng.zhao@linux.intel.com>
 <20240222090251.2849702-4-haifeng.zhao@linux.intel.com>
 <c655cd15-c883-483b-b698-b1b7ae360388@moroto.mountain>
 <2d1788da-521c-4531-a159-81d2fb801d6c@linux.intel.com>
 <039a19e5-d1ff-47ae-aa35-3347c08acc13@moroto.mountain>
 <31ee6660-ad4a-40b8-8503-ebc3ed06dd16@linux.intel.com>
 <f779be97-66c2-4520-91f2-a9a54e84017c@moroto.mountain>
 <623ce65f-da43-4493-8a21-4fd6dfe86dbb@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <623ce65f-da43-4493-8a21-4fd6dfe86dbb@linux.intel.com>

On Tue, Feb 27, 2024 at 04:00:33AM +0800, Ethan Zhao wrote:
> > +                       if (!dev || !dev_is_pci(dev))
> > +                               return -ETIMEDOUT;
> > +                       pdev = to_pci_dev(dev);
> > +                       if (!pci_device_is_present(pdev) &&
> > +                               ite_sid == pci_dev_id(pci_physfn(pdev)))
> >                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > Unless the device_rbtree_find() is returning garbage then these things
> > must be true.
> > 
> > +                               return -ETIMEDOUT;
> > 
> > I tried to double check how we were storing devices into the rbtree,
> > but then I discovered that the device_rbtree_find() doesn't exist in
> > linux-next and this patch breaks the build.
> > 
> > This is very frustrating thing.  But let's say a buggy BIOS could mess
> > up the rbtree.  In that situation, we would still want to change the &&
> > to an ||.  If the divice is not present and^W or the rbtree is corrupted
> 
> Maybe you meant
> +                       if (!pci_device_is_present(pdev) ||
> +                               ite_sid != pci_dev_id(pci_physfn(pdev)))

Yep, that's what I was asking.

> 
> Unfortunately, the ite_sid we got from the "Invalidation Queue Error Record Register" is the *PCI Requester-id* of faulty device, that could be different
> BDF as the sid in the ATS invalidation request for devices:
> 
> 1. behind the PCIe to PCI bridges.
> 2. behindConventional PCI Bridges  3.PCI Express* Devices Using Phantom
> Functions  4.Intel® Scalable I/O Virtualization Capable Devices  (e.g. ADI)
> 5. devices with ARI function.
> 6. behind root port without ACS enabled.
> ... ...

Fair enough...  Thanks.

regards,
dan carpenter


