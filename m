Return-Path: <linux-kernel+bounces-22831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1975A82A392
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33E6B1C23FF5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097B84F881;
	Wed, 10 Jan 2024 21:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HVKTugiB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6FD4F613
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 21:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704923578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+5vhDyCsQlUSJz1HuivnP8fa7a2xOoYAxYuj0ub3clg=;
	b=HVKTugiBmglhY5Kl2NAi33yIsKkaa03hFgFJ/zH6qib79xiovq0/Rm6xhYM1akxwFag7Wd
	65FFm1J1YTtE2wo/5RpkP6hbSuYwsMSPtWYp3tgUBdol4JfM60RVlDqJQdTBQbPjtCQBMk
	SQFwaaqEwyRFGu/rrTyK99Yu0da4j6w=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-L9NRbFz_MvCdwXzaLh48TA-1; Wed, 10 Jan 2024 16:52:57 -0500
X-MC-Unique: L9NRbFz_MvCdwXzaLh48TA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4297db4eba1so46628621cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 13:52:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704923577; x=1705528377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5vhDyCsQlUSJz1HuivnP8fa7a2xOoYAxYuj0ub3clg=;
        b=m+btAZxlDSBXNgikFRs+HVRsGvUGeWwbxI/Pkgje/Vv8f+K4gCoba9qmwy+fVXlkpm
         PllxIkowG9A9STVCyE3Yj9UhiT2AcMUS+7KcvjeeFgX1fTJIxmgmV1C31a7M3SbBawfG
         fUIr+84LxKf49pH7R6OMZG1i+c8etu0xeq0pj5Sr9rP3pIOLTd0mQe1Xe/KZWicqSeNo
         rjt34hU3N6KI5UZ61e1imUiE0Ztsh/7d8RkeA69tZC+si6/O1hg2Xu7xjxuTmec939Rc
         6nH8mGu8NfWpnXx7+aF+/dwU4TKRnzSnuut6kau0/eAJHCoo5u0tjzuGV7OuO5eh0Gst
         yG3w==
X-Gm-Message-State: AOJu0YycQf9l4Bx9Bsd1TsJ6Ko/nIpYWQf1Q9npVkBIFUKr/A/QMHO0a
	6PsVAUHcsCedVnBgyqVsiJjkSuIEkICU9/AzuUS32eaP2oiwcDQag5xuazuCo1reM6MuCdSJOW/
	mC8mriuf0ELdVN3F1Nm6FIXprijHckaJq
X-Received: by 2002:ac8:7d81:0:b0:429:ab35:6402 with SMTP id c1-20020ac87d81000000b00429ab356402mr205294qtd.2.1704923576795;
        Wed, 10 Jan 2024 13:52:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdf4mVuJM2l1/x9f0hdoVpUH9XJsnmJfIw2R9shu3lJq9KbhQxG/mIIyJNKvKZPoAMB8tv2g==
X-Received: by 2002:ac8:7d81:0:b0:429:ab35:6402 with SMTP id c1-20020ac87d81000000b00429ab356402mr205285qtd.2.1704923576542;
        Wed, 10 Jan 2024 13:52:56 -0800 (PST)
Received: from optiplex-fbsd ([76.152.42.226])
        by smtp.gmail.com with ESMTPSA id jv23-20020a05622aa09700b00427fabefe3bsm2094691qtb.52.2024.01.10.13.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 13:52:56 -0800 (PST)
Date: Wed, 10 Jan 2024 16:52:53 -0500
From: Rafael Aquini <aquini@redhat.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Audra Mitchell <audra@redhat.com>, linux-kernel@vger.kernel.org,
	tj@kernel.org, jiangshanlai@gmail.com,
	hirokazu.yamauchi.hk@hitachi.com, ddouwsma@redhat.com,
	loberman@redhat.com, raquini@redhat.com
Subject: Re: [PATCH v2] workqueue.c: Increase workqueue name length
Message-ID: <ZZ8RtfKCmOQqj5KC@optiplex-fbsd>
References: <20231215193954.1785069-1-audra@redhat.com>
 <20240110202959.249296-1-audra@redhat.com>
 <2f0efed5-f9f3-4a5c-9fd4-a4837cada298@prevas.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f0efed5-f9f3-4a5c-9fd4-a4837cada298@prevas.dk>

On Wed, Jan 10, 2024 at 09:47:56PM +0100, Rasmus Villemoes wrote:
> On 10/01/2024 21.29, Audra Mitchell wrote:
> 
> > @@ -4663,9 +4663,10 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
> >  					 unsigned int flags,
> >  					 int max_active, ...)
> >  {
> > -	va_list args;
> > +	va_list args, args_copy;
> >  	struct workqueue_struct *wq;
> >  	struct pool_workqueue *pwq;
> > +	int len;
> >  
> >  	/*
> >  	 * Unbound && max_active == 1 used to imply ordered, which is no longer
> > @@ -4692,6 +4693,13 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
> >  	}
> >  
> >  	va_start(args, max_active);
> > +	va_copy(args_copy, args);
> > +	len = vsnprintf(NULL, 0, fmt, args_copy);
> > +	WARN(len > WQ_NAME_LEN,
> > +		"workqueue: wq->name too long (%d). Truncated to WQ_NAME_LEN (%d)\n",
> > +		len, WQ_NAME_LEN);
> > +
> > +	va_end(args_copy);
> >  	vsnprintf(wq->name, sizeof(wq->name), fmt, args);
> 
> Eh, why not just _not_ throw away the return value from the existing
> vsnprintf() and do "len >= sizeof(wq->name)" to know if truncation
> happened? There's really no need need to do vsnprintf() twice. (And yes,
> you want >=, not >).
>

The extra vsnprintf call is required because the return of the existing 
vsnprintf() is going to be already capped by sizeof(wq->name).
 
> Oh, and definitely not WARN,  pr_warn() or pr_warn_once() please.
> 

Then you lose the ability to figure out what was trying to create the
wq with the inflated name. Also, the _once variants don't seem to do
good here, because alloc_workqueue() can be called by different 
drivers.

-- Rafael


