Return-Path: <linux-kernel+bounces-97412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF96876A22
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C7BD281BD0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E512F381D4;
	Fri,  8 Mar 2024 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="htSfjLDA"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5281117745
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709919970; cv=none; b=IJMiDuzvOfsLIa9lNZDAN/D7USam/JROcYktPZYZd0VMBAVThu5hix6cdUJcDSbwm0kJL6OZta6YZ6vg9qMq+i6Bf++fOsy1AJIavfGTqqxxPyegO45g957xE3fErwNz+HSU4mVqGZ/TzrfGhZZiJ/uN7HB9a9Z3+QJg1nlWcyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709919970; c=relaxed/simple;
	bh=rK08lC8h70tM+jBp3b7B85bfPjBarpj/C+Yd2hRo22M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6pcaDLD46i6x1Cuc973xkFB2VuVZkkH/AVaAjdWioNyJ0HE1f2sXBAmK1DPP8dW8jeIrmGQfR4GAGykI7dOSE8YOm2fPiMVdEIjjhW4EIR7iHsvLqdKac5lhGE8hjH4PVQX5aE1/dvr2cGgmEFq0HBxDGn5ZCR9U1ZItzujOkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=htSfjLDA; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c1ea425a0fso1094295b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 09:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709919967; x=1710524767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ZYf0KQeywWJjZBtMXb+CC74/7IAx0iyjAYpGhr4CHk=;
        b=htSfjLDASqt0bGgEQbKqJtVgXpOyZLr7VZ0ir+PL+LgIAIJCB4DRYLB4IFrpKMuoDx
         TxkZgpHimJOgNw6PlSXa27I+ECeDlWcMRfHIWdeFfYojCIXnvO1CiRp2zvSv803lKM7x
         +qZEli5XHbsC0wTc2cFK9/QzsPVJyES7/ye2tVA5oeUML8km26kKEcDKoGmcigPWEJu3
         Z2VS0AtuKz5NoKjqGXPpQhg9RQ85lU+BpZ7Fg//vXJRbZphHblaCxYrBpAfU3kfHF2qy
         x5bVCYJViNHJnOYgjd84zLWwrd0IvsJO2EK3/dC5Jv3mEp0Bd/+yJsdTaAfxtkZY1g3B
         Gbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709919967; x=1710524767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ZYf0KQeywWJjZBtMXb+CC74/7IAx0iyjAYpGhr4CHk=;
        b=QZsvp8i0zNFzrBjw3KnA5HirU/Sm4y67ayBiCsATDfVitb92gn40V0ERyOp3n4Oig3
         k7KMQUoPLo+2i4mKRgCZ9beT1OIP5SvmwS5Q887sNMMHe04wGeEbhr6RLuIxfkzQ0riJ
         HGnTYrfqwVVfv8YGcC3R7KmsdHHm39McjRPMLxiWLa6JZvDRZj1EjOQu/zNgqAPhPuxc
         3+FJLDh6ziWI7647IbAXyo+NfzbjLGsXqlBsHiUq6HmyggJFrbtGnji+CageZp+NlnRs
         eGIlnA1BTXag3KXVJjAvuYhmq7a7ntmUD/1cQf7USzM9e1+vPRPKsE2AVwx3iz9FLyKd
         9P9g==
X-Forwarded-Encrypted: i=1; AJvYcCUFnVp7KqJaC4veWJrDWVziYi9zmsGfdfSXQubAMptUcQjqqYy0SBGltNXUe8+Lg5i1R8PAJvxugzEn0wLgAbEBKjK8KhuM4ChGEJOW
X-Gm-Message-State: AOJu0YyXtE/cv6KyhJ40YHac4jR+7CqFHdupQoTC+aXhV/8upxSyyrz+
	s4gkKBtxlMaebnYqJie48RtR2nILkL26DU/L/RyIo2cprOD3VJb3cBXSvlbDlj0=
X-Google-Smtp-Source: AGHT+IG/7S0/bhrT9Ch0XEq+I93hxTOeDTQg4sBqPyBXTbTrJFkEN75WabLyNMNzEVIsrKpv74Bpcg==
X-Received: by 2002:a05:6808:23d4:b0:3c2:34b4:2b05 with SMTP id bq20-20020a05680823d400b003c234b42b05mr1861100oib.25.1709919967381;
        Fri, 08 Mar 2024 09:46:07 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id bk1-20020a0568081a0100b003c1e577140asm1940100oib.25.2024.03.08.09.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 09:46:06 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rieIH-007YP8-Qj;
	Fri, 08 Mar 2024 13:46:05 -0400
Date: Fri, 8 Mar 2024 13:46:05 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/8] iommu/sva: Use iopf domain attach/detach interface
Message-ID: <20240308174605.GV9225@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122073903.24406-3-baolu.lu@linux.intel.com>

On Mon, Jan 22, 2024 at 03:38:57PM +0800, Lu Baolu wrote:
> @@ -215,7 +202,23 @@ static struct iopf_group *iopf_group_alloc(struct iommu_fault_param *iopf_param,
>  		group = abort_group;
>  	}
>  
> +	cookie = iopf_pasid_cookie_get(iopf_param->dev, pasid);
> +	if (!cookie && pasid != IOMMU_NO_PASID)
> +		cookie = iopf_pasid_cookie_get(iopf_param->dev, IOMMU_NO_PASID);
> +	if (IS_ERR(cookie) || !cookie) {
> +		/*
> +		 * The PASID of this device was not attached by an I/O-capable
> +		 * domain. Ask the caller to abort handling of this fault.
> +		 * Otherwise, the reference count will be switched to the new
> +		 * iopf group and will be released in iopf_free_group().
> +		 */
> +		kfree(group);
> +		group = abort_group;
> +		cookie = NULL;
> +	}

If this is the main point of the cookie mechansim - why not just have
a refcount inside the domain itself?

I'm really having a hard time making sense of this cookie thing, we
have a lifetime issue on the domain pointer, why is adding another
structure the answer?

I see we also need to stick a pointer in the domain for iommufd to get
back to the hwpt, but that doesn't seem to need such a big system to
accomplish - just add a void *. It would make sense for the domain to
have some optional pointer to a struct for all the fault related data
that becomes allocated when a PRI domain is created..

Also, I thought we'd basically said that domain detatch is supposed to
flush any open PRIs before returning, what happened to that as a
solution to the lifetime problem?

Regardless I think we should split this into two series - improve the PRI
lifetime model for domains and then put iommufd on top of it..

Jason

