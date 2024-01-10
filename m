Return-Path: <linux-kernel+bounces-22861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C098482A41A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 23:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AFADB23958
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A264F892;
	Wed, 10 Jan 2024 22:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DuRQG6zY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C494F886
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 22:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704926721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4dxvjz/LguywFF+dMC+eIAohdJIL/n8s2jYF9k2gVi0=;
	b=DuRQG6zYVhdzdYCSYF44MQE4JMP3nm4Jm3FLfSLKkD43u6ziHRuHzOOPg51rOmeS6Nd/2t
	zHhIdhfYDDAKnIc9ZI8WN1HfCCRIaF9DoouMGhB6tTHH9jHu9MyZCSd+07iIkJZT3VPh1q
	6KDODrwBo514XnaSgKoxlH0Z5DkMz6g=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-X1ov8-cEOqa-mTUR4Wqc0g-1; Wed, 10 Jan 2024 17:45:19 -0500
X-MC-Unique: X1ov8-cEOqa-mTUR4Wqc0g-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-429a8494838so21212911cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 14:45:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704926719; x=1705531519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dxvjz/LguywFF+dMC+eIAohdJIL/n8s2jYF9k2gVi0=;
        b=kcFFJfbURdm+CJKqfgTkpOj7SJ3nXJnisCwVtOfCtjuibIZJ9YPHXncifMlQfew/Iw
         k5Xw6iPXoEq54gl5nxN+PP6rY9obwgYQ9pe6lAcUKWwIkJRy6qWwQtJtQLsxuOR6xTEX
         VvMdoj+bEUElc5p2X0sGRInZzzziq5FY2ones7a1n0BLLUtLOlsOC6m5uro7KXYYVEmA
         BO/AxpWKymq4WO/tPtGY1GcHKEP47P9Ewdpt6acv38ne2zpQyLj5tx3QBbOV/n8RsdCE
         Rz5GjoVTtSbDFfMn4YMa8F3rr+G26HtIUoUqhqko9v3vrREYalIyU6Y8L7pxPNiOEKFE
         jc2Q==
X-Gm-Message-State: AOJu0Yz1b18BWDHAqjmTMu/ngZuOyt147udSh7xLvc4qaJvDKQS7cntF
	u95kRUJjByx32X0c9WihASc2r11PvoSBxouxM7R9C73y/D8VMzZguhO49xHuiS0stc+W88SKXLy
	1md95TlHCgf1U2nMoQiDDXHkeqpB13ZuE
X-Received: by 2002:ac8:4e55:0:b0:425:a5ef:a70d with SMTP id e21-20020ac84e55000000b00425a5efa70dmr223966qtw.51.1704926718967;
        Wed, 10 Jan 2024 14:45:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtvnUrslBpQt+z+LcK44YZj5fdJ5ZcnfMS7Ju8WpEV4JGtgvpyt4JXHgtEvn5J1KJzfUj6Tg==
X-Received: by 2002:ac8:4e55:0:b0:425:a5ef:a70d with SMTP id e21-20020ac84e55000000b00425a5efa70dmr223959qtw.51.1704926718715;
        Wed, 10 Jan 2024 14:45:18 -0800 (PST)
Received: from optiplex-fbsd ([76.152.42.226])
        by smtp.gmail.com with ESMTPSA id f5-20020a05622a114500b00429a8751bf2sm1679965qty.36.2024.01.10.14.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 14:45:18 -0800 (PST)
Date: Wed, 10 Jan 2024 17:45:15 -0500
From: Rafael Aquini <aquini@redhat.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Audra Mitchell <audra@redhat.com>, linux-kernel@vger.kernel.org,
	tj@kernel.org, jiangshanlai@gmail.com,
	hirokazu.yamauchi.hk@hitachi.com, ddouwsma@redhat.com,
	loberman@redhat.com, raquini@redhat.com
Subject: Re: [PATCH v2] workqueue.c: Increase workqueue name length
Message-ID: <ZZ8d-7TUJ5F9GvRV@optiplex-fbsd>
References: <20231215193954.1785069-1-audra@redhat.com>
 <20240110202959.249296-1-audra@redhat.com>
 <2f0efed5-f9f3-4a5c-9fd4-a4837cada298@prevas.dk>
 <ZZ8RtfKCmOQqj5KC@optiplex-fbsd>
 <f5ded466-cbe1-4a46-b042-1c65839c9e02@prevas.dk>
 <ZZ8a1RvwpDZvwfg9@optiplex-fbsd>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ8a1RvwpDZvwfg9@optiplex-fbsd>

On Wed, Jan 10, 2024 at 05:31:49PM -0500, Rafael Aquini wrote:
> On Wed, Jan 10, 2024 at 11:06:22PM +0100, Rasmus Villemoes wrote:
> > On 10/01/2024 22.52, Rafael Aquini wrote:
> > > On Wed, Jan 10, 2024 at 09:47:56PM +0100, Rasmus Villemoes wrote:
> > >> On 10/01/2024 21.29, Audra Mitchell wrote:
> > >>
> > >>> @@ -4663,9 +4663,10 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
> > >>>  					 unsigned int flags,
> > >>>  					 int max_active, ...)
> > >>>  {
> > >>> -	va_list args;
> > >>> +	va_list args, args_copy;
> > >>>  	struct workqueue_struct *wq;
> > >>>  	struct pool_workqueue *pwq;
> > >>> +	int len;
> > >>>  
> > >>>  	/*
> > >>>  	 * Unbound && max_active == 1 used to imply ordered, which is no longer
> > >>> @@ -4692,6 +4693,13 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
> > >>>  	}
> > >>>  
> > >>>  	va_start(args, max_active);
> > >>> +	va_copy(args_copy, args);
> > >>> +	len = vsnprintf(NULL, 0, fmt, args_copy);
> > >>> +	WARN(len > WQ_NAME_LEN,
> > >>> +		"workqueue: wq->name too long (%d). Truncated to WQ_NAME_LEN (%d)\n",
> > >>> +		len, WQ_NAME_LEN);
> > >>> +
> > >>> +	va_end(args_copy);
> > >>>  	vsnprintf(wq->name, sizeof(wq->name), fmt, args);
> > >>
> > >> Eh, why not just _not_ throw away the return value from the existing
> > >> vsnprintf() and do "len >= sizeof(wq->name)" to know if truncation
> > >> happened? There's really no need need to do vsnprintf() twice. (And yes,
> > >> you want >=, not >).
> > >>
> > > 
> > > The extra vsnprintf call is required because the return of the existing 
> > > vsnprintf() is going to be already capped by sizeof(wq->name).
> > 
> > No, it is not. vsnprintf() returns the length of the would-be-created
> > string if the buffer was big enough. That is independent of whether one
> > does a dummy NULL,0 call or just calls it with a real, but possibly too
> > small, buffer.
> > 
> > This is true for userspace (as required by posix) as well as the kernel
> > implementation of vsnprintf(). What makes you think otherwise?
> >
> 
> this snippet from PRINTF(3) man page
> 
> RETURN VALUE
>        Upon successful return, these functions return the number of characters 
>        printed (excluding the null byte used to end output to strings).
>

Perhaps the man page should be amended to indicate vsnprintf returns the
number of characters that would have been printed if the buffer size 
were unlimited.

We based the assumption of kernel's vsnprintf behavior out of the 
documented POSIX behavior as stated on the man page.


