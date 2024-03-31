Return-Path: <linux-kernel+bounces-126094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DF9893216
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F17DC281EBE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 15:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301771EB31;
	Sun, 31 Mar 2024 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fatXrpMA"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A82144D3E;
	Sun, 31 Mar 2024 15:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711899734; cv=none; b=OSZrusnBHDSd6qxJo/WNlLEVEF9J5zrROC/NGBVvh7ImBHVc6oQxBEdAgwZ7MwnxSfg6yEo394hRhjeubZeaaNrSo2mS5BVSvdX5Hf48H8Xu3i/CzmseaR82CKkos8G3SB9bTxvsf49dR5zwEcYiyv+rFWoGkXmnzAIkKVLqeh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711899734; c=relaxed/simple;
	bh=YG4fm0DOjyKHoMPqV6nwk2JT5UpmidEryxHIcOk5MWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifCEQVobFx8ss4nBzTVZXonpPSQEdAqVoNsD+njmwBxrepSHNevcPspwwSbZ4808pMJ8uEZOk+bAPPRaTrmeuWOoiyDC8aKc6KuHo6skJoqbFtzbn5iLXs5X52gnbdNgufzBXBWOHUw4hFGUt9Z3Ab9EkKZxiGr7167/K29uNX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fatXrpMA; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e8f765146fso2789428b3a.0;
        Sun, 31 Mar 2024 08:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711899732; x=1712504532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7Lj8kkoEYEQzC1PpONnBxC+yNCe4TSIQMnVonB2rGI=;
        b=fatXrpMAhnG1wKt82Orxpr2hWfWEpTHdTefRSHMIvHti0KbwwPaQej96vfyy5MIhHz
         Rj35/qhfG2JqhLY+44b/ul7AWpE3r9R4m/7CujTT3y2XadTLUHuh0g0GYW/8rAPdzp7y
         IvCIdYRyval3jbl1UWZC4xMF2KJqe8tyzHWpJRHrpYM9MB6K/MX6NOMGwfA2q02m89jb
         D1Vf3k4QmUh019ss8yNgXC9khHfXVP97DbjOY+AJu91rX8fm4rbInVg/RkV201Y6Fun6
         y3jWZDi9DbwF1S9RWL8cQOXMorYQAI/+xaVmwLn76bQDFqWku+A/7A7JnbYUOaeiRRlB
         /SCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711899732; x=1712504532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7Lj8kkoEYEQzC1PpONnBxC+yNCe4TSIQMnVonB2rGI=;
        b=nF7DXzTYVTzXk2We3A+ssdq8S+IEKz/B3PuZd5nBVzv07BlwLeKRpghTJys+qRDDUO
         Vv0bHjwiP5tjXW0zwuPnQkkomDhnv/dmWYcq70HQdtksamCbF3RoEo/3e6LR9/Q5G6OL
         gOndfZqjcmXbxNeb0hpFjf5TO6MOc1Dm0pSnlSOGTtuJzidmFBCB6dOiPS4G80lRmLWp
         PgNvWUTQZH/jlrxCIRalslosEj5Qg9sOC3BP4SVjeE4gPrhXBJk8BDxl5M7DigSib9/Z
         ooKncyHpeKbWc4r9/P5c2ZpDda2vuePcaqAycQ6euACsX08bP4Tbo+MtICV1bBk7LoGy
         T7PA==
X-Forwarded-Encrypted: i=1; AJvYcCVI8hEqrcPUaNIGKdjKfLS0s3d/jGAJRj+KbxVzwFnZqJyYg/3wVp1TalWMf1hgjm6nd0MPQDaBe9YRX4l3GuD1GHE2/LO/udYB+TBrVMNDWdJx8WDkpIgBBEX0Kgx2vKU8NRnUbgnWAY+LNiLb6Gjbm4y9
X-Gm-Message-State: AOJu0Yy7LmlmvzXu0HZ0l89ddpYaZx8TvKGauMl96GuGuveloOWlvwSw
	FgRNtvktTs6gARhNYRlQc+0LcVDysuJ15K0KVDqs8u3wd1WqS22k
X-Google-Smtp-Source: AGHT+IGoAD2XFSgANX6jcnvF/J8GDaKNLNbkcChU83aH25OT4EyE4kjSWIjG7NW8WdulbmpcfJC9FA==
X-Received: by 2002:a05:6a21:33a2:b0:1a3:c515:202c with SMTP id yy34-20020a056a2133a200b001a3c515202cmr6093425pzb.62.1711899732128;
        Sun, 31 Mar 2024 08:42:12 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([2409:40e3:1005:4847:df97:da84:df14:fe41])
        by smtp.gmail.com with ESMTPSA id f6-20020a170902860600b001defa2d8e22sm6970881plo.233.2024.03.31.08.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 08:42:11 -0700 (PDT)
Date: Sun, 31 Mar 2024 21:12:06 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: alison.schofield@intel.com, paul@paul-moore.com, mic@digikod.net,
	fabio.maria.de.francesco@linux.intel.com,
	linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2] landlock: Use kmem for landlock_object
Message-ID: <ZgmETqQr7+W9XtWN@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
References: <ZggZi/EFICvb4xTU@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
 <2024033030-tutu-dynamite-47c9@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024033030-tutu-dynamite-47c9@gregkh>

Hello Greg. Thanks for the feedback.
On Sat, Mar 30, 2024 at 05:12:18PM +0100, Greg KH wrote:
> On Sat, Mar 30, 2024 at 07:24:19PM +0530, Ayush Tiwari wrote:
> > Use kmem_cache replace kzalloc() calls with kmem_cache_zalloc() for
> > struct landlock_object and update the related dependencies to improve
> > memory allocation and deallocation performance.
> 
> So it's faster?  Great, what are the measurements?
> 
Thank you for the feedback. Regarding the performance improvements, I
realized I should have provided concrete measurements to support the
claim. The intention behind switching to kmem_cache_zalloc() was to
optimize memory management efficiency based on general principles.
Could you suggest some way to get some measurements if possible?
> > This patch does not
> > change kfree() and kfree_rcu() calls because according to kernel commit
> > ae65a5211d90("mm/slab: document kfree() as allowed for
> > kmem_cache_alloc() objects"), starting from kernel 6.4 with
> > CONFIG_SLOB, kfree() is safe to use for such objects.
> 
> There is no CONFIG_SLOB anymore so why mention it?
> 
About the mention of CONFIG_SLOB and commit ae65a5211d90, my aim was
to highlight the kernel's documentation of using kfree() for objects
allocated with kmem_cache_alloc(), ensuring this practice's safety
across kernel versions post-6.4. I acknowledge that referencing
CONFIG_SLOB was misleading due to its removal from the kernel
configuration options. The focus should be on the broader acceptance
and documentation of kfree() usage with kmem_cache allocated objects,
independent of the specific allocator configuration. I will revise the
patch description to clarify this point and remove any irrelevant
references to CONFIG_SLOB.
> 
> 
>   
> > +static struct kmem_cache *landlock_object_cache;
> > +
> > +void __init landlock_object_cache_init(void)
> > +{
> > +	landlock_object_cache = kmem_cache_create(
> > +		"landlock_object_cache", sizeof(struct landlock_object), 0,
> > +		SLAB_PANIC, NULL);
> 
> You really want SLAB_PANIC?  Why?
>
The SLAB_PANIC flag used in kmem_cache_create indicates that if the
kernel is unable to create the cache, it should panic. The use of
SLAB_PANIC in the creation of the landlock_object_cache is due to the
critical nature of this cache for the Landlock LSM's operation. I
found it to be a good choice to be used. Should I use some other
altrnative?
> > +
> >  struct landlock_object *
> >  landlock_create_object(const struct landlock_object_underops *const underops,
> >  		       void *const underobj)
> > @@ -25,7 +34,8 @@ landlock_create_object(const struct landlock_object_underops *const underops,
> >  
> >  	if (WARN_ON_ONCE(!underops || !underobj))
> >  		return ERR_PTR(-ENOENT);
> > -	new_object = kzalloc(sizeof(*new_object), GFP_KERNEL_ACCOUNT);
> > +	new_object =
> > +		kmem_cache_zalloc(landlock_object_cache, GFP_KERNEL_ACCOUNT);
> 
> Odd indentation, why?
> 
This indentation is due to formatting introduced by running
clang-format.
> thanks,
> 
> greg k-h

