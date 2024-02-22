Return-Path: <linux-kernel+bounces-77204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F258601F8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AB7928C385
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B424F12D21E;
	Thu, 22 Feb 2024 18:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhoyhb2W"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DB11EB3D;
	Thu, 22 Feb 2024 18:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627924; cv=none; b=XjRGj7KIjl86gVrvN/ANwiA0LWyy/U05cebQRpbhTnKsKz7ryVtlfxjQiaRRoo02+1UD2F0O2TB1LYyB3Xf+bxftA4I8wDO0L7h22D5ClJsZXJ/MPhj5yUev/LJRQbof9qAZI+jesGLx/p0TmAlxiFCg/eVY63HDJKDVukoszgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627924; c=relaxed/simple;
	bh=Rqlhl8scJWK1KFRqpMadZ1k19G5+0GHAMj4w2ohm/zY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgY2HlxO6t/YQL1NjjNysBUdk3ePrbH+JqrV9tkeJyFHhWwK0sbNMn90Tkh8iAGlmoTBoi77h3vAu6/RKeXqmAmAF4dwihN8oAa9VsOb2Fj6PV40+WLp/WTNTZQfIMg9+bTbQjZZ0Eq7S3sSVcZVILndEAnczvywePKQPFoYCjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhoyhb2W; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dc09556599so917605ad.1;
        Thu, 22 Feb 2024 10:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708627922; x=1709232722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CX+buwoA+SqSG7r/CEcjs5/GgQYEZL4oqoCzZ/o1bnQ=;
        b=dhoyhb2WM2xHU8UYV/bu557UmKK5fTA57zIUepJs3xoaogtKo68dh185NAt0azrd9C
         o58m3rcwZ8KKzagRZNcAByGNqHJtJk6vhfnw23CBl8o8BrCHlvnOrKL1VflUjgAIecWO
         tt1M7tQHFt4DBCfhfarYWIETCECUeNfggXPPnK3LT+9cMZmihpQ9hevuSdvCa7qFM9Qf
         3mhgkfobB9ZgSQl8UQ/JR6Gw6ZTuwqJFBSp892bJUelyzB9KVh6/z78I04vEZd1cL852
         NiYux7wC+XDgj4j2bPqIDlmc8JYjSEJ3oqujkbqbdRNvu2K0tisiuteurk04p8scNusa
         Bmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708627922; x=1709232722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CX+buwoA+SqSG7r/CEcjs5/GgQYEZL4oqoCzZ/o1bnQ=;
        b=iEL5HFHJPTeKl3hNEB1yMZ85vbcgs4z6OQPXcYw+NNXPWX6GuoZriKbFDjGkBR8J5H
         iLtqOKR2gvJj0ZBGYEE4lHWB0H/ZHotI0DebN56eI7HCzQux2/P9HOaLvlNSVzZoMYB4
         9TShXrsz7floV8TefG5Hxkdq66dNIzepQZC9DpSMT2vJkA8aRxLpqRGtn3TysYwXT/Gk
         31YwJGikXEwcjDdgY+eBGITx/DPMc/UPW0v8x93ii9b8+hl/qQ6fJwHOGhqoHPuZAS+t
         vWxIjKfon2sn/Jpx6Yqdd15ZWS77WZ7dGDXbkCKPz/m0OeguOFkHAjxRFlLdhJPtWzSO
         53LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpgrDVCrIIR4+nj2Rrx5a/hzYphmqCj1NOg0MAuvFWOZPzID1+gHvnO2NvORHNW188McOEDSdEAfpp7gzi4a0Ro2jCXna/elXasTuQBKbBciz4Kz0Qgw/m5tEWwvggMxR5YQ0rMIW1aubdDgqqSki7MP48OvczX/B/PBf7M4iqJd+DwM4GwKC7
X-Gm-Message-State: AOJu0Yw0G+P4R23tgmuyLOVk98kD+aqq+LV1i8M7qLfHGMz0CCx5Ygtf
	jo/rwDh25TINf4dnjMw/+6SzIM1HqFoXIpUZCftu7a/Me0NGXiWF
X-Google-Smtp-Source: AGHT+IF11qcXZe+TAthoK9MJjpLgyxNCAn9qgPH8lHdKb4SzYXPbd+d0D2xNb+iqjUlMyv4QiBwmcQ==
X-Received: by 2002:a17:903:1212:b0:1d9:14fb:d142 with SMTP id l18-20020a170903121200b001d914fbd142mr26128212plh.32.1708627921888;
        Thu, 22 Feb 2024 10:52:01 -0800 (PST)
Received: from debian ([2601:641:300:14de:f32d:6b5:d03a:44f])
        by smtp.gmail.com with ESMTPSA id mp14-20020a17090b190e00b002993f72ed02sm12374377pjb.34.2024.02.22.10.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 10:52:01 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Thu, 22 Feb 2024 10:51:41 -0800
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Robert Richter <rrichter@amd.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] cxl/hdm: Clean up a debug printk
Message-ID: <ZdeXvYEs_fMks3rU@debian>
References: <3d3d969d-651d-4e9d-a892-900876a60ab5@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d3d969d-651d-4e9d-a892-900876a60ab5@moroto.mountain>

On Thu, Feb 22, 2024 at 09:14:02AM +0300, Dan Carpenter wrote:
> Smatch complains that %pa is for phys_addr_t types and "size" is a u64.
> 
>     drivers/cxl/core/hdm.c:521 cxl_dpa_alloc() error: '%pa' expects
>     argument of type 'phys_addr_t*', argument 4 has type 'ullong*
> 
> Looking at this, to me it seems more useful to print the sizes as
> decimal instead of hex.  Let's do that.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  drivers/cxl/core/hdm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 7d97790b893d..0b1843631b26 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -518,9 +518,9 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>  	}
>  
>  	if (size > avail) {
> -		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
> +		dev_dbg(dev, "%llu exceeds available %s capacity: %llu\n", size,
>  			cxled->mode == CXL_DECODER_RAM ? "ram" : "pmem",
> -			&avail);
> +			(u64)avail);
>  		rc = -ENOSPC;
>  		goto out;
>  	}
> -- 
> 2.43.0
> 

