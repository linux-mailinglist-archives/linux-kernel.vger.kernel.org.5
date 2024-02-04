Return-Path: <linux-kernel+bounces-51927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C0884911B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 23:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C96ABB21E10
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 22:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F423A1DE;
	Sun,  4 Feb 2024 22:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="UmALxAir"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550D43A1A6
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 22:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707085653; cv=none; b=EVbNDWiok5fKbcCnTV5s9sNORzKl80HMetag4TOZ7yPArZ4nOOubMfuTyzN8Eo1GQetKJrHgrAWKEnWqM8+GaMrwrOv1vNa8HQy11Z46CNyJZCPeudEzZNqyhc+et23CHa59DyUJ6ZePg7Ec6akSUySQ+1r8zZgi6CUnNtk/RLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707085653; c=relaxed/simple;
	bh=TOF+iGQdBp9TBaaMC6ebC6/70csILrWjlbBU1KhhBKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfMUkGtzvx0gE7Ac4tPrdTf+5pDnJDHKyBaXdv8joPCgzhieY1v7TmCU7gCbkCbhqBZ+8kAgUJQPm3yb9ZZxO0zfMKcTK2zLYTtSVJrXa8Y0GnoGmk5NLSTABOUPfJBtMCnsRupQeEfGiyDfWa3+pHDZNPcKBZPzVq3xtTc0gU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=UmALxAir reason="key not found in DNS"; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5dc11fdddd6so862648a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 14:27:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707085650; x=1707690450;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from
         :dkim-signature:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHAGM085fsoYV4EjUCOOIJGL1Cm2y/rOptN80w9wOqA=;
        b=Rb+KLzlR5Vd/UL1DVrxyGKxMCS+9rO46JvsE39D57ePiS+5ix7GeXxx7lUe4kV6oJB
         8PxZi04lRSCV2fKzMbFbqLEcaHb62fw/QIkH2gMkJjQUFMQMrwZ+RtBddpEBynHfVH0u
         hYqBU0Vo74Z/N5j7Y201tfjzrfvNEAKFC5h7v9LeVsjS/ajrEJ8S6zrz9qLk67/iWhN9
         RwE4sDnJwDqdnDUy6ezH5qyj7JtJRXpd8/7AOLJ54rm/67E9EKlr+ZI+woNrzzeEJpZN
         0RLT2E9fL1qLoGtycBs9rfgw3ZaW705xOjBEt6Cv0gX4hBzpRkoHWix7x3IwqARY/jV+
         HvlQ==
X-Gm-Message-State: AOJu0YxC1NwozsI/MONzCGLFVpmNuzsIh2DAN4z+R+LM3L/ZEsADTqMR
	ZF3PUVs6dQrnU/2bOrCNgM2zJhbsqyLmLXp0uOyhqwld4rW9B99j
X-Google-Smtp-Source: AGHT+IE7xsQtuqPLovGJXbhGUtA6z2KPh9IQ9DBp3DumhjNuKm4Op9nzCm0bxABlhKKRTissyyCajw==
X-Received: by 2002:a05:6a20:d80a:b0:19e:5e6c:9d61 with SMTP id iv10-20020a056a20d80a00b0019e5e6c9d61mr4523378pzb.28.1707085649956;
        Sun, 04 Feb 2024 14:27:29 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUqltxojW8XM7QUJEUR5FTuoK3Lt5oguTDd8RXHmL+WzzfPQOm5orxnU9OY7ZLLJjKxLLTevCxDVpj59zni+hHJ6fSQvPLTwOiDfQx788CfxegsSC67KbRwFFIvTO7amrEvzv0vqA4Nu7OE0eCNf5yNDZ/MNy8rWaedP4Q9CBnh
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id r23-20020aa78457000000b006dfdb672a93sm5252977pfn.20.2024.02.04.14.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 14:27:29 -0800 (PST)
Date: Sun, 4 Feb 2024 19:27:59 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707085648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IHAGM085fsoYV4EjUCOOIJGL1Cm2y/rOptN80w9wOqA=;
	b=UmALxAirH1wqqpHTl/9t94icZ0BkhUgkWlxJcrWJn1a/367v6UKaB01ZkLH24AWKQguV9o
	rwCfxGLC7npaSWmAMYeYPWCYu4OLHiB60zYu4zZfESF4RcnRIRw1kg+ivb4gnThj8jvMkp
	JfZ2p6FRe5fwLkWJ75Iv+u0z0wGyfa8GmMf2cB1eW4LbFQNr3FpIhlThuN/u1VEN/LZjVm
	LJdLdYoAb/an8PoQQ8peWzTLrEm/I30nAIehg9rLBGGa3GROuY4ZRVL6vRIksVAQnVE/oI
	CFt00EbzJ90q1Ez7wsHhqRyJU3B+EnupJoatgeUnbM8MKsZbI9ExEdKMr/Wr0g==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thorsten Scherer <t.scherer@eckelmann.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] siox: make siox_bus_type const
Message-ID: <lyib5lnxawbuvwhxsarldijmlo2uqauohw3ala3erdsrrfpchj@lj4ksyg4xzq5>
References: <20240204-bus_cleanup-siox-v1-1-2d12583d3a6c@marliere.net>
 <oixce2fflwe6rodxsv625ogbymqlblw7qvvbxmtp7tpgarqpju@ufnqi7j364md>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <oixce2fflwe6rodxsv625ogbymqlblw7qvvbxmtp7tpgarqpju@ufnqi7j364md>

On  4 Feb 22:29, Uwe Kleine-KÃ¶nig wrote:
> Hello Ricardo,
> 
> On Sun, Feb 04, 2024 at 05:36:03PM -0300, Ricardo B. Marliere wrote:
> > Now that the driver core can properly handle constant struct bus_type,
> > move the siox_bus_type variable to be a constant structure as well,
> > placing it into read-only memory which can not be modified at runtime.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> > ---
> >  drivers/siox/siox-core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/siox/siox-core.c b/drivers/siox/siox-core.c
> > index 561408583b2b..a1eda7bd76ed 100644
> > --- a/drivers/siox/siox-core.c
> > +++ b/drivers/siox/siox-core.c
> > @@ -543,7 +543,7 @@ static void siox_shutdown(struct device *dev)
> >  		sdriver->shutdown(sdevice);
> >  }
> >  
> > -static struct bus_type siox_bus_type = {
> > +static const struct bus_type siox_bus_type = {
> >  	.name = "siox",
> >  	.match = siox_match,
> >  	.probe = siox_probe,
> 
> while I like this change, I wonder about the "Now" in the commit log.
> Doing the homework, this is about commit d492cc2573a0 ("driver core:
> device.h: make struct bus_type a const *") which is in 6.4-rc1. Would
> you please care to mention that commit as the one that makes this siox
> change possible?

Hi Uwe!

Sounds reasonable, I just sent a v2. The original log is being used
across the tree, took from a template first used by Greg.

Thanks for reviewing,
-	Ricardo.


> 
> Thanks
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |



