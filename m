Return-Path: <linux-kernel+bounces-126339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B62893553
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 20:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CD911F23C0B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1944F1EA8D;
	Sun, 31 Mar 2024 18:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZAPq6mX"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95BF145333;
	Sun, 31 Mar 2024 18:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711908519; cv=none; b=NL1VYNeESk4x7/4ae4tNREdFkaSYpcDvo1RXxYW1XyXh6BAfgB39ETYZxcA/jlMT/p7iVCNLmAsYhrx9T89Vhi/9BL445lrz7HR5UfClAEFaZdhCh6Lw0UeXMfPpG8riJHC5YPpy2Xnb6ffRvG7gvt8LJgt9okr4kQal+KmA7uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711908519; c=relaxed/simple;
	bh=ihSPv/bZ5sM/c7Y+V2q4SohkVL5V2lyMiRXiQ6Rkf2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aI1+tgukaeKcdCD1OyTgUJrDC3V9WbaaCAerNypDUeTGI1LuxkzfS1ePQK4pDksfyoe7/ZfGajcttglNxe3dn/+fcMs7Q/bT1WDNkkJkYd3ET3z4Kvymi2yGZtW8a5gq1UJdt/Hf7l1zTu7Q6ug6nh+qMed03PUJ0VVvCOVaiuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZAPq6mX; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e034607879so27505255ad.0;
        Sun, 31 Mar 2024 11:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711908517; x=1712513317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ywW9FTrztw/GYYLfTIt316+aO2c7ZNlNlgGATNzPyRQ=;
        b=eZAPq6mX5F8b2bPnsNR/4NO3lmkyTNtyIdfnihD7qze8TathwoAR2iN9O6qu4UB9z/
         aRqZQM/28wFQ2Rx0aWwGa70R4lWKzF8jKNEHBV/GSTNF1Euw0ePuQnBoJxBBNet68hjq
         TI3OJ3I1qOrG5sC5TRB+dXr4YS5yB3Vf3+8iPpU38TrqyjycyzBwoQr06KFf7UBAji9k
         eeCE59aeXBCbd9QMCEpl/Fk056xFJwmsMioTa5CoYa5R8WA77EfVBVZLz+hDy9NFoh/s
         nQgxnwILsI78dmzGwqSkQcRsAt4qoD8pQdo2bz01yf1sQhJFStD6h7j6PvLqwURbdqas
         qUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711908517; x=1712513317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywW9FTrztw/GYYLfTIt316+aO2c7ZNlNlgGATNzPyRQ=;
        b=mJ/iv0B39W/F0QODoInyD5xgS1903QhgJpyudmdrtJlmxH5IR/6Mho5X8d1ZeO+nOW
         gD4vF+/wkQMJmE7syUYmGxxlEku9KnKJUf8lKbhFSqyoTjNTYyZ5umefzIcPB84JO6sx
         SiWmMDO6CaEF/5rOQVuL9jDNKWwWVEJ+78P7vQ9pqSpsApSSnzkNtnpFvzZOvlqb0Wav
         TSRcRA/+Lzwaf4alVV4qC1sFdAluONT1YBBl/iS7G8TtZDAQT7DJDh+gqB1hShG+veUr
         oFiMnJnh4l8Pn45E94eA1rpRctbvFdyRwCWwRa4PkBvMZFN0Qlt+0wAoj8Luli8mXH6w
         YZRg==
X-Forwarded-Encrypted: i=1; AJvYcCXekhgyhVrsbsMZzpp+c/lNnpMF4TNdrKZ/D/05pcFSVW1oMSFoYyCVpZo+R+jZ9bqt0LlPFDHoygPfh7uQYp/djJhUzZbI8uspYJkGn3giq+AyDHiEbAsHmqjI8sfbha+4tQ2oKa+/JfGlBtQ+ClNJanc3
X-Gm-Message-State: AOJu0YyHyj5r0OVD/BC/1zmaQBYsIJwWA4/acQ4+Yr8HYZTAQll3XJrH
	vBWu4s1RYOde/w7aVjaDkcv+u3QwCiuRvhbKqYUJ/y0Z47mCWi3o
X-Google-Smtp-Source: AGHT+IG4HHJOnoY0AX8Z2Ya0xCmP7GPs6kEBHr7Vo0I7bNns7ryU/Kx/k+nAX7wqZdTIyu2uc9SojA==
X-Received: by 2002:a17:902:ca8a:b0:1e0:c91d:4487 with SMTP id v10-20020a170902ca8a00b001e0c91d4487mr6398283pld.43.1711908516993;
        Sun, 31 Mar 2024 11:08:36 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([2409:40e3:1005:4847:2e21:db9c:20bb:4a48])
        by smtp.gmail.com with ESMTPSA id j7-20020a170903024700b001e22860c32asm5652309plh.143.2024.03.31.11.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 11:08:36 -0700 (PDT)
Date: Sun, 31 Mar 2024 23:38:28 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: alison.schofield@intel.com, paul@paul-moore.com, mic@digikod.net,
	fabio.maria.de.francesco@linux.intel.com,
	linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2] landlock: Use kmem for landlock_object
Message-ID: <ZgmmnLIal3gz55Q+@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
References: <ZggZi/EFICvb4xTU@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
 <2024033030-tutu-dynamite-47c9@gregkh>
 <ZgmETqQr7+W9XtWN@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
 <2024033111-squeezing-linoleum-52a7@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024033111-squeezing-linoleum-52a7@gregkh>

On Sun, Mar 31, 2024 at 06:54:39PM +0200, Greg KH wrote:
> On Sun, Mar 31, 2024 at 09:12:06PM +0530, Ayush Tiwari wrote:
> > Hello Greg. Thanks for the feedback.
> > On Sat, Mar 30, 2024 at 05:12:18PM +0100, Greg KH wrote:
> > > On Sat, Mar 30, 2024 at 07:24:19PM +0530, Ayush Tiwari wrote:
> > > > Use kmem_cache replace kzalloc() calls with kmem_cache_zalloc() for
> > > > struct landlock_object and update the related dependencies to improve
> > > > memory allocation and deallocation performance.
> > > 
> > > So it's faster?  Great, what are the measurements?
> > > 
> > Thank you for the feedback. Regarding the performance improvements, I
> > realized I should have provided concrete measurements to support the
> > claim. The intention behind switching to kmem_cache_zalloc() was to
> > optimize memory management efficiency based on general principles.
> > Could you suggest some way to get some measurements if possible?
> 
> If you can not measure the difference, why make the change at all?

Kindly refer to this issue: https://github.com/landlock-lsm/linux/issues/19
I have been assigned this issue hence I am focussing on making the
changes that have been listed.
> 
> Again, you need to prove the need for this change, so far I fail to see
> a reason why.
> 
> > > > +static struct kmem_cache *landlock_object_cache;
> > > > +
> > > > +void __init landlock_object_cache_init(void)
> > > > +{
> > > > +	landlock_object_cache = kmem_cache_create(
> > > > +		"landlock_object_cache", sizeof(struct landlock_object), 0,
> > > > +		SLAB_PANIC, NULL);
> > > 
> > > You really want SLAB_PANIC?  Why?
> > >
> > The SLAB_PANIC flag used in kmem_cache_create indicates that if the
> > kernel is unable to create the cache, it should panic. The use of
> > SLAB_PANIC in the creation of the landlock_object_cache is due to the
> > critical nature of this cache for the Landlock LSM's operation. I
> > found it to be a good choice to be used. Should I use some other
> > altrnative?
> 
> Is panicing really a good idea?  Why can't you properly recover from
> allocation failures?

I am relying on SLAB_PANIC because of the reason I mentioned earlier,
and also because it was used in lsm_file_cache that I was asked to look
into as reference. I could try to recover from allocation failures but
currently my focus is on working on the changes that are listed. I will
definitely try to look into it once I am done with all changes.

> > > > +
> > > >  struct landlock_object *
> > > >  landlock_create_object(const struct landlock_object_underops *const underops,
> > > >  		       void *const underobj)
> > > > @@ -25,7 +34,8 @@ landlock_create_object(const struct landlock_object_underops *const underops,
> > > >  
> > > >  	if (WARN_ON_ONCE(!underops || !underobj))
> > > >  		return ERR_PTR(-ENOENT);
> > > > -	new_object = kzalloc(sizeof(*new_object), GFP_KERNEL_ACCOUNT);
> > > > +	new_object =
> > > > +		kmem_cache_zalloc(landlock_object_cache, GFP_KERNEL_ACCOUNT);
> > > 
> > > Odd indentation, why?
> > > 
> > This indentation is due to formatting introduced by running
> > clang-format.
> 
> Why not keep it all on one line?
> 
I kept it all in one line in v1, but Paul and Mickael asked me to use
clang-format, hence it is this way.
> thanks,
> 
> greg k-h

