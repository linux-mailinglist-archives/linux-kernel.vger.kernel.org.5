Return-Path: <linux-kernel+bounces-22851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E09582A3F9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 23:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CB4928550A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B584F888;
	Wed, 10 Jan 2024 22:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1xw9GZr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE4A4F886
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 22:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704925915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DP7v475vF9i2mjWODzqqIUAcLzw1NqFNzyO2KHguQ4g=;
	b=d1xw9GZrjTupg3qOT9YzX3S82ocFA/KZv5AB3lwjsf3FHcyvN2jpMK9jtcNhtR0QE/t63P
	WxExikz38GK+oYmbVkpGqvbIMWIVW0ldECqKsdJV1iUEJ9VKzCj09bwp1xEPP235esNGxy
	gDklpevNYmQ0nXe9JfwCoOLRIIcP13I=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-kg93waf1Ns2RLQh_MlVePQ-1; Wed, 10 Jan 2024 17:31:53 -0500
X-MC-Unique: kg93waf1Ns2RLQh_MlVePQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-78335ae3fa8so119234285a.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 14:31:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704925912; x=1705530712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DP7v475vF9i2mjWODzqqIUAcLzw1NqFNzyO2KHguQ4g=;
        b=M9OVDRqSyYpq6CRy09Bh9Rr3bO0Q4ZuVZwiYDh14MWzLPppz9o5Zc2eGF7/h4ptIZA
         0ut11fDBUpLsiMQ0Z7hoyjPYBT/9b+cX8bKCZXQGwlUBT9GSuh4q3i/rGyz/XxwZoW3q
         s6i50df+Dh6m3tva/ZVHxuZGv8oaeKMuZzv4Wc99cf96k3iA+umMkLgwfH+HFl8aTWx1
         XPD6n2wSdd3A976iKLLN9Od691tx/phzDfoucP7yX9XALoWdZclrwa3QKr8oeBQJ2fsU
         OxIUtNBhpPxFfs6Yh0VW+lOL7iJ/ow5O1lqZMVgptqfM/qp7UwSGhl7pUJRniupweD9s
         S1EA==
X-Gm-Message-State: AOJu0Yy6cpwbaTma/xFnwORtwr6y/6s3vxv6st6vYzELmhyXmd0yxFmk
	lp3JecuO45gqi8KEwqrI8fyRZdU2oAXCjjyKre0mzUDnDkAsoZE5vkGdLlmcRxObW91QhfLnFyt
	uoMTNT0aVvpt6jikLRDiKWDddMKjK2N+L
X-Received: by 2002:a37:f508:0:b0:783:29f9:9a86 with SMTP id l8-20020a37f508000000b0078329f99a86mr298122qkk.79.1704925912492;
        Wed, 10 Jan 2024 14:31:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1sg08TM9beGsOJp2Z1CR+XLiC4N+BpnpEy2fGGvxB9ZUF4DjpI0TMmSOS3C+FVRC/m7sCoQ==
X-Received: by 2002:a37:f508:0:b0:783:29f9:9a86 with SMTP id l8-20020a37f508000000b0078329f99a86mr298112qkk.79.1704925912241;
        Wed, 10 Jan 2024 14:31:52 -0800 (PST)
Received: from optiplex-fbsd ([76.152.42.226])
        by smtp.gmail.com with ESMTPSA id x3-20020ae9f803000000b007815c8ab309sm1918969qkh.34.2024.01.10.14.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 14:31:51 -0800 (PST)
Date: Wed, 10 Jan 2024 17:31:49 -0500
From: Rafael Aquini <aquini@redhat.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Audra Mitchell <audra@redhat.com>, linux-kernel@vger.kernel.org,
	tj@kernel.org, jiangshanlai@gmail.com,
	hirokazu.yamauchi.hk@hitachi.com, ddouwsma@redhat.com,
	loberman@redhat.com, raquini@redhat.com
Subject: Re: [PATCH v2] workqueue.c: Increase workqueue name length
Message-ID: <ZZ8a1RvwpDZvwfg9@optiplex-fbsd>
References: <20231215193954.1785069-1-audra@redhat.com>
 <20240110202959.249296-1-audra@redhat.com>
 <2f0efed5-f9f3-4a5c-9fd4-a4837cada298@prevas.dk>
 <ZZ8RtfKCmOQqj5KC@optiplex-fbsd>
 <f5ded466-cbe1-4a46-b042-1c65839c9e02@prevas.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5ded466-cbe1-4a46-b042-1c65839c9e02@prevas.dk>

On Wed, Jan 10, 2024 at 11:06:22PM +0100, Rasmus Villemoes wrote:
> On 10/01/2024 22.52, Rafael Aquini wrote:
> > On Wed, Jan 10, 2024 at 09:47:56PM +0100, Rasmus Villemoes wrote:
> >> On 10/01/2024 21.29, Audra Mitchell wrote:
> >>
> >>> @@ -4663,9 +4663,10 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
> >>>  					 unsigned int flags,
> >>>  					 int max_active, ...)
> >>>  {
> >>> -	va_list args;
> >>> +	va_list args, args_copy;
> >>>  	struct workqueue_struct *wq;
> >>>  	struct pool_workqueue *pwq;
> >>> +	int len;
> >>>  
> >>>  	/*
> >>>  	 * Unbound && max_active == 1 used to imply ordered, which is no longer
> >>> @@ -4692,6 +4693,13 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
> >>>  	}
> >>>  
> >>>  	va_start(args, max_active);
> >>> +	va_copy(args_copy, args);
> >>> +	len = vsnprintf(NULL, 0, fmt, args_copy);
> >>> +	WARN(len > WQ_NAME_LEN,
> >>> +		"workqueue: wq->name too long (%d). Truncated to WQ_NAME_LEN (%d)\n",
> >>> +		len, WQ_NAME_LEN);
> >>> +
> >>> +	va_end(args_copy);
> >>>  	vsnprintf(wq->name, sizeof(wq->name), fmt, args);
> >>
> >> Eh, why not just _not_ throw away the return value from the existing
> >> vsnprintf() and do "len >= sizeof(wq->name)" to know if truncation
> >> happened? There's really no need need to do vsnprintf() twice. (And yes,
> >> you want >=, not >).
> >>
> > 
> > The extra vsnprintf call is required because the return of the existing 
> > vsnprintf() is going to be already capped by sizeof(wq->name).
> 
> No, it is not. vsnprintf() returns the length of the would-be-created
> string if the buffer was big enough. That is independent of whether one
> does a dummy NULL,0 call or just calls it with a real, but possibly too
> small, buffer.
> 
> This is true for userspace (as required by posix) as well as the kernel
> implementation of vsnprintf(). What makes you think otherwise?
>

this snippet from PRINTF(3) man page

RETURN VALUE
       Upon successful return, these functions return the number of characters 
       printed (excluding the null byte used to end output to strings).




 
> The kernel _also_ happens to have a non-standardized function called
> vscnprintf (note the c) which returns the possibly-truncated result. But
> that's irrelevant here.
> 
> >> Oh, and definitely not WARN,  pr_warn() or pr_warn_once() please.
> >>
> > 
> > Then you lose the ability to figure out what was trying to create the
> > wq with the inflated name. Also, the _once variants don't seem to do
> > good here, because alloc_workqueue() can be called by different 
> > drivers.
> 
> I assume that whatever creates the wq will do so on every boot, and the
> name is most likely some fixed thing. So you're essentially setting up
> some configurations to do a WARN on every single boot, not to mention
> that for some machines that implies a panic... It really is not
> something that warrants a WARN.
> 
> As for figuring out what caused that too-long name, well, I'd hope that
> the 31 meaningful bytes that did get produced would provide a
> sufficiently good hint.
> 
> Rasmus
> 


