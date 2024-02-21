Return-Path: <linux-kernel+bounces-75013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3C785E182
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE001C20E51
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C048063E;
	Wed, 21 Feb 2024 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZDXkzcEA"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18398063C
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530015; cv=none; b=r+anrPcCUOLpaaFlMnrxeCtBMSu5GoPjBSOfbyFbs0lFWO6IIAsTqVqGQ0eQMj+UXMQBNA8FE9iviimQxRTABOHNAg0P2ZWn0pZjsZXu2JfJKKEkcCwRX3aJLKr28V2JXU2UbbUrfk4Mh+EdVEdCWrq675eEs6MXy9QPPo6dVrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530015; c=relaxed/simple;
	bh=96xfu/ouzriUH60bX/QlTKilA8Z4OsLCUCAiI5+vuOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ci/qBJBoaA5dV/z8mNBlncODpvaxHlnNKsRhT32WXgQVYWytEyCCERIt9fj73yNy/5ZuPGTCkX/Wxs38wN8MH12/3+eFdPTvVlwB8TlI86qKF1Luuf1tTktFOGCBZr9K3DsVevxCKPrSuWbOrw95gPKA/8C+/en739ABKsAovas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ZDXkzcEA; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c13410a319so356243b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1708530013; x=1709134813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c/EcdnXy5zHBejejLatJVqAEruFgiaEfzzpOoPh/aDs=;
        b=ZDXkzcEApIJ78BGtrTP0xEIbTeh251xU3FKQkwYqjeqAzhMwMjK6f6z/h/SZZ33fva
         WEujAxiH6VhCZK7hb3qONPInPw49/hOqMQ7C4Qe3FdbMaoZLd0loz525+8nCiFKnR7+2
         DeDJqZfBvbuBqlW3vFd1IcMJz1cjhqch/yE8xfIQmlw6QJyx2ZEN6NCEZA/NBbKPOfcy
         sUjfhqAJGDIuNkXWLH3cnZiGrOarqzKsdjaR+p6W3gxXsZbAT//qNCoW4PWw4UYYGvOv
         JOW+kR0ViwiVm4RtIkT0TPuDfuD5XhewSI9Q2p1I37zVCX5WK6nxRNWb1sG5w0MCGd+R
         y6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708530013; x=1709134813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/EcdnXy5zHBejejLatJVqAEruFgiaEfzzpOoPh/aDs=;
        b=SHivDv9xrZ8kYImUSOYDD+X+2WS20ZrWn3WrA28DZZRp0J72tzmYJn0H1yJYiqHD9V
         1AteS9y5ZQ8TaJX/rCQGw+lsBOy3UjyS6NweDGvWhiUxP7EenK1lUSgJ36x0b3P4WU4O
         MjBmSBqJzTLs96Hf86RypCSl4lqaFTQMWzaLPnA4srK8ykwuV8Vyr5WDtlKXULAwBWJ7
         T9phxUitBtcTYwzDqb1jyu99UE6I5cUuCd/V95Zg3Nky6/AFhK8tRgwjRlcfoSeWK6f5
         ejZyNoACyuYYYx3fHiHoT1Tn31hNGSgzmRg3fNNYpuWsRPjWSbwMUXQc5vlyrL1zObCk
         L9eA==
X-Forwarded-Encrypted: i=1; AJvYcCXuT9pvdoCWVlNPrZe2ZjkzcSgTSa8FHm82MigtGU7Hiroetw6J/+4KA1tnyjqkmd+SqRa273/gfZbYtmzGs1etKwoenT45SPBoZrKu
X-Gm-Message-State: AOJu0YzfqlEYr0brYN1J6DI1PY/9yZpZ5G3tI9ByUdHOIK+2eDHripvV
	VFKZ6r9MvoDL8zTuKbQyBJH1yR+soF16m86Owp1zEQJ9Kdncx+kUeLIvbmjMnhwBTlt6jQIEp1D
	g
X-Google-Smtp-Source: AGHT+IG+kmpMRxxp0YFDSSIfQrxkjBFHwU6q1DujwecqtkB+lPQDTRXsUaS3XIU79BX+gWBVZ/rNog==
X-Received: by 2002:a05:6808:13cd:b0:3c1:7019:ae9b with SMTP id d13-20020a05680813cd00b003c17019ae9bmr2199970oiw.43.1708530013104;
        Wed, 21 Feb 2024 07:40:13 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id e5-20020a056214162500b0068f0923ff12sm5578477qvw.30.2024.02.21.07.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 07:40:12 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rcohg-00BQrQ-0b;
	Wed, 21 Feb 2024 11:40:12 -0400
Date: Wed, 21 Feb 2024 11:40:12 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Eric Badger <ebadger@purestorage.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"open list:INTEL IOMMU (VT-d)" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/vt-d: Check for non-NULL domain on device release
Message-ID: <20240221154012.GC13491@ziepe.ca>
References: <20240113181713.1817855-1-ebadger@purestorage.com>
 <20240116152215.GE50608@ziepe.ca>
 <7455b538-e934-4377-9ab5-004ee991b3d2@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7455b538-e934-4377-9ab5-004ee991b3d2@linux.intel.com>

On Wed, Jan 31, 2024 at 03:10:53PM +0800, Baolu Lu wrote:
> I like this suggestion.
> 
> Currently, the device_release callback for an iommu driver does the
> following:
> 
> a) Silent IOMMU DMA translation. This is done by detaching the existing
>    domain from the IOMMU and bringing the IOMMU into a blocking state
>    (some drivers might be in identity state);
> b) Releases the resources allocated in the probe callback and restores
>    the device to its previous state before the probe.
> 
> From my understanding of your suggestion, we should move a) out of the
> release callback and make it a special domain, which could be a blocking
> domain or identity domain, depending on the iommu hardware.
> 
> In the end, the release_device callback of an iommu driver should focus
> on the opposite operation of device_probe. This makes the concept
> clearer.

Right

Can someone make some patches to fix Eric's bug? We don't really need
to do the release_domain stuff if the driver just self-attaches one of
its known static domain types (blocking/identity)

Jason

