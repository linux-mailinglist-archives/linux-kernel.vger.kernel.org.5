Return-Path: <linux-kernel+bounces-22872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED3B82A4BA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 00:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84A1AB25ECB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 23:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080754F89F;
	Wed, 10 Jan 2024 23:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UtsmdAj0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E2B8F7A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 23:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704928114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p3Qug8q0VdY7pMyGvBvH86zD2vvdUwG2qbAIxxKPiWA=;
	b=UtsmdAj0N7TFSfUX95rfkk9JHuUm00VTu74drfjx3KWj4OW+KXMeFmHySvOj8v1BEnVh7W
	kG0T61eIsOzUBXTfeFZyj7LKtF640B9yZgtrP1FB9z+uiXILHjr8/993+QG3fGUm7lFC9Q
	68WBNj5A57icuNBQ1TG1oU2eAS1xgNk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-5-W6OkS7MGe8fNKVTH-7pw-1; Wed, 10 Jan 2024 18:08:27 -0500
X-MC-Unique: 5-W6OkS7MGe8fNKVTH-7pw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-78319f5d6edso607860385a.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 15:08:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704928106; x=1705532906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3Qug8q0VdY7pMyGvBvH86zD2vvdUwG2qbAIxxKPiWA=;
        b=RoyB6hY7paXlS8nmhogpY0j6s4stmC7lf49ckdlK1Ok+6h8CEewA5uUK1H4T1Qzq/a
         vjMuNtd30a7DdVvvzeqcA2yoi2Jhs4m+bWbGXnTU/d97UP5EFwBAFWL85GfFTBbZDLs3
         fEQF6dgwbCfBr7GnV8pg1Ww3SeqpTanwVL4yMVc4Z03ExUN0v+aklUrE8cIwxJR5eLMY
         PEPUbR+RzlB1MRI2fI40G4TbS6xFIjiWiwMI8nfl3IXeXowr+l2DG+WUTMRE4VliGwkx
         FZcRbFXK92QCQpEWdtuVtM1NvkVm9yXKik/F2HtRoiRzjMX96zEAjFyzrPREuFI2QR5O
         d/Kg==
X-Gm-Message-State: AOJu0YwW7pZ4E0g9xBO4bRZR078sNqgXSyP2ZR0kCrA5emwKTiwZoT8d
	iFaf+UQaqXsCqEkFM3870WxXYuf1FLwon3L+1Q+iIRkbCrge4Xq3VSDOMNDjrMYpHYvE4mHQD1/
	A9/na7BG8FTpWK7oTS1TtOGP8EoTbJids
X-Received: by 2002:a37:e115:0:b0:783:3063:14cf with SMTP id c21-20020a37e115000000b00783306314cfmr383104qkm.27.1704928106731;
        Wed, 10 Jan 2024 15:08:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuM5rPjkuVXFa7BTYo2SzUslbZHD0cP9S1YfZwwNkGMlaLA3tFb0mZaZybBtJdmhh7S0/60g==
X-Received: by 2002:a37:e115:0:b0:783:3063:14cf with SMTP id c21-20020a37e115000000b00783306314cfmr383092qkm.27.1704928106481;
        Wed, 10 Jan 2024 15:08:26 -0800 (PST)
Received: from optiplex-fbsd ([76.152.42.226])
        by smtp.gmail.com with ESMTPSA id w2-20020a05620a094200b0077dd463da60sm1940682qkw.126.2024.01.10.15.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 15:08:26 -0800 (PST)
Date: Wed, 10 Jan 2024 18:08:23 -0500
From: Rafael Aquini <aquini@redhat.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Audra Mitchell <audra@redhat.com>, linux-kernel@vger.kernel.org,
	tj@kernel.org, jiangshanlai@gmail.com,
	hirokazu.yamauchi.hk@hitachi.com, ddouwsma@redhat.com,
	loberman@redhat.com, raquini@redhat.com
Subject: Re: [PATCH v2] workqueue.c: Increase workqueue name length
Message-ID: <ZZ8jZ3J63jf4Ap3y@optiplex-fbsd>
References: <20231215193954.1785069-1-audra@redhat.com>
 <20240110202959.249296-1-audra@redhat.com>
 <2f0efed5-f9f3-4a5c-9fd4-a4837cada298@prevas.dk>
 <ZZ8RtfKCmOQqj5KC@optiplex-fbsd>
 <f5ded466-cbe1-4a46-b042-1c65839c9e02@prevas.dk>
 <ZZ8a1RvwpDZvwfg9@optiplex-fbsd>
 <ace8c8db-ff33-465f-9415-dfcb1c522f4f@prevas.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ace8c8db-ff33-465f-9415-dfcb1c522f4f@prevas.dk>

On Wed, Jan 10, 2024 at 11:52:38PM +0100, Rasmus Villemoes wrote:
> On 10/01/2024 23.31, Rafael Aquini wrote:
> > On Wed, Jan 10, 2024 at 11:06:22PM +0100, Rasmus Villemoes wrote:
> >> On 10/01/2024 22.52, Rafael Aquini wrote:
> 
> >>> The extra vsnprintf call is required because the return of the existing 
> >>> vsnprintf() is going to be already capped by sizeof(wq->name).
> >>
> >> No, it is not. vsnprintf() returns the length of the would-be-created
> >> string if the buffer was big enough. That is independent of whether one
> >> does a dummy NULL,0 call or just calls it with a real, but possibly too
> >> small, buffer.
> >>
> >> This is true for userspace (as required by posix) as well as the kernel
> >> implementation of vsnprintf(). What makes you think otherwise?
> >>
> > 
> > this snippet from PRINTF(3) man page
> > 
> > RETURN VALUE
> >        Upon successful return, these functions return the number of characters 
> >        printed (excluding the null byte used to end output to strings).
> > 
> 
> Assuming we have the same man pages installed, try reading the very next
> paragraph:
> 
>  The functions snprintf() and vsnprintf() do not write  more  than  size
>  bytes  (including the terminating null byte ('\0')).  If the output was
>  truncated due to this limit, then the return value  is  the  number  of
>  characters  (excluding the terminating null byte) which would have been
>  written to the final string if enough space had been available.   Thus,
>  a  return  value  of  size or more means that the output was truncated.
> 
> How else would you even expect the vsnprintf(NULL, 0, ...) thing to work?
>

OK, that's my bad! Sorry for the noise.
-- Rafael 


