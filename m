Return-Path: <linux-kernel+bounces-130991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 834218981A2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B26328AC00
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 06:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247D659B7E;
	Thu,  4 Apr 2024 06:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/imHRy6"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B215812B;
	Thu,  4 Apr 2024 06:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712213316; cv=none; b=RZjvqkp+ZtVZQ1y0b4m+1yh9zAsR8ddMN8HbSseYARG9+uURPocMN2PxdrZ2F7xCFT9zVy5GRxjywKVfI81aGoTQAcWFKrTfHL1n5FsdHYcHtU4sqUDzZZT4SYsWVPGdfoNXEy3lOi+fV/Elq/2IEgNWB+cmP3KkBim6LsmQTOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712213316; c=relaxed/simple;
	bh=4PqKQuyI4AvifN12LECL2ppqNFOTJqQn6NM0HK1VYE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SALveenf7X7+dia3aGk7e7W2kVZdExtJtXa/mfPJ4WwmUNQcpflZnnWiyfG96LXcK9egQ0PibsKu79ZUWEM2Mcn5rn1LkQxQ3M6nM4lqQdE9A2dYr7x81DYZIHtxVy1tn2q9qzlwUELF5iHOjwKkCQYg9vpITh1Ob/UvqO/7VYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/imHRy6; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78bc322a55cso41051385a.1;
        Wed, 03 Apr 2024 23:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712213313; x=1712818113; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U+z2WHjVYiy4PLghxmgu4ncf+R1tkh3udKbxNTVqC4c=;
        b=J/imHRy6HqFyQWFJMTRdSBPEXIYybFUdcEK39KCo2cN83GKcWXTCuVS5k03vOENyKt
         SQ/09xK5QEF2vWHg5MxrI5I+VM+nKNY67dkgCTK3k2c2+zYcda+5ieqH67PVRNR0cMvi
         4SubYyzWQmsaQBnBTPdLWeMdDFAYU2jm796qK34oi1+P50HbflU81SWtzUYtgqIMP4lH
         bntJ7wEjMuQG+82isFMLoti47FhTBKZvzlLrSXp1X5QkIMtCdqUI9NGJa5Oh7T+tSQ5x
         J74lRr6VVEV6hC72ejLixqeGngQjMZoz/1qKXePzb/NfjOfYQEE51HpUSfx5E7lMPiXw
         g6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712213313; x=1712818113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+z2WHjVYiy4PLghxmgu4ncf+R1tkh3udKbxNTVqC4c=;
        b=ZZW9woC1jIl/Ohzq3A4P2Zhbw2ZSTMbxpG2pGgbXs8H0xAi6AaHQqX53su7MePWr5d
         vw+5PsVSax3HF1bV6Y2dnFaidRxCMtJbbvh/FPFugq6LVgiRMy/y1wzLk5TPLgjHBcn1
         lxSfmw0cAwdZbUoJNiCxOqKAGx3OY5hlDyPZRhwJMTuzHlXf+ayhjtedBTYYD6xZygnU
         f7dGP5ws5FPloCzFBBHh7NQlYKnAiPTeB4XPK/g6bnjAqhxw09n4Z9fcvNHsEHy5iixD
         kYKnjMGHO8S/iVzWIA/sFEcOIQbi/eI4GMryrIyr16h2KdaoARgOQE43aE3EgylMMtgB
         SoFw==
X-Forwarded-Encrypted: i=1; AJvYcCWHC697o5mSqfu9Fx1ZvBbiCkAZbBYZurAT9REkPwU05Tf00xBUYgYRvH3aGfztfUYfkBCzRGuJSIdB4xejUvrYEH83yHBAuLEIl/eLzJSrfckit1ejYfGW9iG1a2Kk/Ya0biZEmCxp
X-Gm-Message-State: AOJu0Yy9IRZ3WnaDxbRJ2tvPWTja+LLXwcPfd2D+wLCOuu4x8ItrqcEt
	1thdS7z7sz1IraIJZwH3bZJNVzY2/BgF631pTAJA4uc5/GvdsIG4KcwhyZlsJYokMHd7YLyyGtP
	6xgiOIwG9iuv/Qd06Hk/WGcfcl5U=
X-Google-Smtp-Source: AGHT+IFdc9GRYka/KG2na+kn0smWY+f1f3/MLok4TQ9SbhKrgAGuR1dLd5UY+QGJ7Qm1Vh0yxnS/2bfWAaJ1PDj2cyw=
X-Received: by 2002:a05:6214:19cd:b0:696:8bc4:6cb4 with SMTP id
 j13-20020a05621419cd00b006968bc46cb4mr1961276qvc.47.1712213313495; Wed, 03
 Apr 2024 23:48:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403050824.166787-1-kaiwan.billimoria@gmail.com> <8734s2twjq.fsf@meer.lwn.net>
In-Reply-To: <8734s2twjq.fsf@meer.lwn.net>
From: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Date: Thu, 4 Apr 2024 12:18:15 +0530
Message-ID: <CAPDLWs8vNvew=uddn76k57b+o+yvQuE9PrUGTLaP8iW0spsPBQ@mail.gmail.com>
Subject: Re: [PATCH] docs: Add relevant kernel publications to list of books;
 LKP 2E
To: Jonathan Corbet <corbet@lwn.net>
Cc: Carlos Bilbao <carlos.bilbao@amd.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Happy to add the book
Thanks..
> but ... surely the author of said book wants to
> set a good example by sending a properly written patch?
Apologies! Wilco.. will send a v2 shortly.

> - Stick to the 80-character limit (we still really try to do that for
>   text)
Sure. It's just that checkpatch.pl didn't report it..
Still, as you correctly say, I shall stick to the 80-char limit!
Without any malice whatsoever :-) , I'd also like to point out that this limit
doesn't always seem to be adhered to in the current ver of this doc..

Thanks,
Kaiwan.
>
> Thanks,
>
> jon
>
> > Signed-off-by: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
> > ---
> >  Documentation/process/kernel-docs.rst | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
> > index 8660493b91d0..f73671b65a71 100644
> > --- a/Documentation/process/kernel-docs.rst
> > +++ b/Documentation/process/kernel-docs.rst
> > @@ -75,6 +75,15 @@ On-line docs
> >  Published books
> >  ---------------
> >
> > +    * Title: **Linux Kernel Programming: A Comprehensive and practical guide to Kernel Internals, Writing Modules, and Kernel Synchronization**
> > +
> > +      :Author: Kaiwan N Billimoria
> > +      :Publisher: Packt Publishing Ltd
> > +      :Date: February, 2024
> > +      :Pages: 826
> > +      :ISBN: 978-1803232225
> > +      :Notes: 2nd Edition
> > +
> >      * Title: **Linux Kernel Debugging: Leverage proven tools and advanced techniques to effectively debug Linux kernels and kernel modules**
> >
> >        :Author: Kaiwan N Billimoria
> > @@ -91,6 +100,7 @@ Published books
> >        :Date: March, 2021
> >        :Pages: 754
> >        :ISBN: 978-1789953435
> > +      :Notes: 1st Edition
> >
> >      * Title: **Linux Kernel Programming Part 2 - Char Device Drivers and Kernel Synchronization: Create user-kernel interfaces, work with peripheral I/O, and handle hardware interrupts**
> >
> > --
> > 2.40.1

