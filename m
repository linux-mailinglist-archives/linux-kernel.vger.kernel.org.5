Return-Path: <linux-kernel+bounces-97352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACF287694D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 451B2286F13
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F0020B10;
	Fri,  8 Mar 2024 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DDurbmA3"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6398A200BE
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 17:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709917551; cv=none; b=HJXvugESxKbGy7JERxlv9Lz5/xk57/NYj5M6DEHF8SXs8e8imJ36Dg2/cMiVd6XrGC6UEcLqTyLDclJkQmfMqJ3X1n+n2RuhVDt+Z+u9SliptXjiqZu+P14WRAJpS5POjGuDbzWfy3UiAmWQpMNWHnciAEkdq7exOJr+K5ShHgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709917551; c=relaxed/simple;
	bh=V6KJTShdwT+mkrh0tNjho/v1spFJQp+mhN1u9pDoGUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcZaSf5intdtuxddXteUjq0vSgXMFS7aIIuzMQ7wN3CTmBC8anJiaD4zgDsqfou101LJQBqNOVAn68Ca+T3+l/u/Mz9U6sbUyDWZgrqzRHGRomZFdGOVvOsV3im/25P0JTYWuOTokPQW2hgwA1g3Jprbqf+D0diZdBDsJNIo7oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DDurbmA3; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c21a3120feso436343b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 09:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709917548; x=1710522348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M1AjcWBSkItGUiNsU5CP48uMxnVb158nfN7iDwmiCRM=;
        b=DDurbmA3S6btZn2V8KtaQVOAeU8XJtj2r2bxnzLWx/bXgBtqnKFzitf+UKd3O+C8Sf
         GzSEE5xJX6ZJwq+cgIT9I+GoVPReBCKzUqa3diO4WI2esw9hE4l4Ybc+d1u+FQmA+2ru
         /t6/zSUaORfxu+qRugu+U6q6pVMItxiwHgC6N5VdfO8aP01mvm0otMqzG0VW9GPaKvym
         w9RnhV2zf+ykqTh/UWxYdF4koZZy375vi2K90ej2Dpn9zybrsvP6NTGj3BBH2Ougo0Yh
         YrKZkb53J0xmtuSnehL9IeWufuOOeF20AX4aowrlITKI1CoGUICBc2F16BYKP+z5pCAV
         gfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709917548; x=1710522348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1AjcWBSkItGUiNsU5CP48uMxnVb158nfN7iDwmiCRM=;
        b=IhmpdKCbBQoskrr7j/xLH0N9ubNE/XK/ZZHHGdgnUh8SqP7eHTpeeRO/QWOWVALEHv
         HSYLemttRv+8d+2GIVPYvmz1MEupwQlWm3DH9lVCN4TGskc9j+wiZtraPPo/vv55ESE1
         0M4CWCeKLzI/p8dLDvUkbw+r32O5Mz4oV3Vj5zNaI0gUxuj2p3VfihdSnXGCUmwjvGjS
         cYl7tR11/Nm3uKhnUg3Plk2PCmys6JqZ5wnR7JPFfWq03ffFUdjDap+1TjYzKDc9MKMm
         eg0JfT/rJdDmCeQmsaMBVCOCaeavhzfQuSrh8rQOZRUQnaYf46Ftx7+uT1fnGCaiiSau
         k41A==
X-Forwarded-Encrypted: i=1; AJvYcCU56DcQFZxctgucDygiMe+8jHqmINeqMDVqTImyrfiqFLLLMBtr2k3/e7bScrt+04HVH7+Xss/3hHHVKD70+4ZIxY2jBqLPJ5AxXofM
X-Gm-Message-State: AOJu0YxmZjRo6XxZ6vb/ve1vVsdNH3mCP8QF7YscM8fcBHHB4CbxHeww
	rcjC+M3XIeg+MAbiKdP3qfRofqnqRbcAU0uD51GeJipmBTXv0GddkCMSc1t6weo=
X-Google-Smtp-Source: AGHT+IFmpdDM8Yw9rLFEeWGGVYCMO+qikKXQROcwg2THfy528Bht9EXOGogx2z63mdDKX9uCapRecg==
X-Received: by 2002:a05:6808:1393:b0:3c2:3a02:2731 with SMTP id c19-20020a056808139300b003c23a022731mr106904oiw.5.1709917548441;
        Fri, 08 Mar 2024 09:05:48 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id v2-20020a544482000000b003c1ec2c3fa5sm1655913oiv.42.2024.03.08.09.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 09:05:47 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ridfG-007SKN-Rm;
	Fri, 08 Mar 2024 13:05:46 -0400
Date: Fri, 8 Mar 2024 13:05:46 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"clg@redhat.com" <clg@redhat.com>,
	"Chatre, Reinette" <reinette.chatre@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] vfio/pci: Disable auto-enable of exclusive INTx IRQ
Message-ID: <20240308170546.GS9225@ziepe.ca>
References: <20240306211445.1856768-1-alex.williamson@redhat.com>
 <20240306211445.1856768-2-alex.williamson@redhat.com>
 <BL1PR11MB527189373E8756AA8697E8D78C202@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20240307132348.5dbc57dc.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307132348.5dbc57dc.alex.williamson@redhat.com>

On Thu, Mar 07, 2024 at 01:23:48PM -0700, Alex Williamson wrote:
> On Thu, 7 Mar 2024 08:39:16 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> 
> > > From: Alex Williamson <alex.williamson@redhat.com>
> > > Sent: Thursday, March 7, 2024 5:15 AM
> > > 
> > > Currently for devices requiring masking at the irqchip for INTx, ie.
> > > devices without DisINTx support, the IRQ is enabled in request_irq()
> > > and subsequently disabled as necessary to align with the masked status
> > > flag.  This presents a window where the interrupt could fire between
> > > these events, resulting in the IRQ incrementing the disable depth twice.
> > > This would be unrecoverable for a user since the masked flag prevents
> > > nested enables through vfio.
> > > 
> > > Instead, invert the logic using IRQF_NO_AUTOEN such that exclusive INTx
> > > is never auto-enabled, then unmask as required.
> > > 
> > > Fixes: 89e1f7d4c66d ("vfio: Add PCI device driver")
> > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>  
> > 
> > CC stable?
> 
> I've always found that having a Fixes: tag is sufficient to get picked
> up for stable, so I typically don't do both.  If it helps out someone's
> process I'd be happy to though.  Thanks,

It helps other distros in the ecosystem to flag patches that really
should be backported. Not everyone runs their backport trees as
agressively as a stable does.

Jason

