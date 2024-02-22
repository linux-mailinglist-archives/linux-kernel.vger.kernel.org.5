Return-Path: <linux-kernel+bounces-75749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D4985EE6A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E55DB22BB6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB9C11721;
	Thu, 22 Feb 2024 01:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfikvTaB"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACAC362;
	Thu, 22 Feb 2024 01:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708563938; cv=none; b=gy7Yc4rR0mkwDrbcZm+XF3kBKCsYvq2YczcI9x7fpYteJKzNV8gYhk61ZFqbsR2GX6wCyEBZRnGWrU18oEt4qKsc5mGL9mfvePdJ1R2J/nddisUtGayjZiqCUyc151PaJ3cHXQq+m2zhbp6/Jp+Z+38WHphoIoB4ovA99R1cykI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708563938; c=relaxed/simple;
	bh=oVwvNABBYQwg8ch1Migh1pBvGqfufD05wV+UJaVQcMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQGtNJzRBZIv8mkWKmPZWja2S3qgXWSMqH4r4saA5l5QI/Mzhzowi+DWoz74UuA0IHoPgz9qE6vB8EIlXmzk2xh5mBrs5XvygH/Ip08aVKwVstjWi8xi7RrJ8mnS2pk+RTWJb4WrrYnCTV3qPrS6EzyPzdHKHSaO25/aaHOPM1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfikvTaB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d746856d85so48420595ad.0;
        Wed, 21 Feb 2024 17:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708563936; x=1709168736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l/kZGWidKQHDeiGOirXOw/MofqnSEIzxtMp9arYvsBI=;
        b=JfikvTaBbDdpORSJTkHHFg1J/YudbcHSas8bS/TzvXnBphgXkmiXzMwA8Z7v4w8ux3
         Z4f5C8GmYbZbEX/5FIR2vdEc9WmRkY1W2UWV53IqM2O9x7udAq/95WSiCWfklCAssXAr
         5x+9pFZIFfsd0ft1cjKGZi8dKZY4fFjAJPw4dHDxDq70OmwfOmkrNFEv5FdOv7h2G/hf
         pHu7UuzTdy/9s7OV5mSn9CxNEY4jP5P5rCrCToud/MRZt0gltGKg05X+h2lgONnD9hkc
         igUjFT1w7geFHMdDnn7U5IIfR+q0b2x143as3VCBCBPw2FuoRyDzMZel8aavNd4m1+eN
         7HbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708563936; x=1709168736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/kZGWidKQHDeiGOirXOw/MofqnSEIzxtMp9arYvsBI=;
        b=jRLKtByOOKDPqD2N583gtL6Iq9jcF+H7mQQBroGSZWBbLLx06bx0xcDqcgf8257spE
         a8bJDl6mZk/WfJ1efyxnplH535tJBJ24k+MYNMwGpMq1nGzO5b1hhw3aulpN7wYLi49K
         hhQsaZJiCzTAFjg1kvF+uaPadc4j9KP5Mc7vTCQVxRezq4BU6UWRBt+OBtGgu7Siby3R
         +a/o9OCtH5x364fpfMGBtAc6juM7TqGkDzuIrX32v42ESZvQxhHX8Rbbte0kjsj6NUsc
         xJaJRRzqUEY8YsDX7j1GkFXFnBptNNUQSJahGjTmFn0oh/3qFOpKmPZPWjnHSOY7n7mi
         V2JQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdLOfS7mS8S2YlYPRT/YaJF5KPNikCJR6F0mbTjH3XD14mWLhn9HLyzmRRAaoYqkcs3cGgpFZZq+eLbbISYzG5SjPEtLIpN3t7kAKByxBcGwAcUaUtyzT/2uS0FHRDCZBAwr4h3HGoqg==
X-Gm-Message-State: AOJu0YyAdQSFoyaJtPigpZiGbo11FE9FETz5IfT4IDqiXH6P4TJRp2RF
	br4dMKx906KTNMiJ4lt3QLIuu1VMZbhDWwNMzboA2q4Wz73h/B4fGeS23phN
X-Google-Smtp-Source: AGHT+IE6f+V0neO5f8BH6R4TDq0lyTu6zajB+MVmEOa+stdrRoMJ/qawhHeR7I+keI6fAMiDV6xA6g==
X-Received: by 2002:a17:902:b20a:b0:1d9:a647:5579 with SMTP id t10-20020a170902b20a00b001d9a6475579mr16599279plr.1.1708563936147;
        Wed, 21 Feb 2024 17:05:36 -0800 (PST)
Received: from rigel ([220.235.35.85])
        by smtp.gmail.com with ESMTPSA id k5-20020a170902e90500b001db7599aba0sm8749027pld.24.2024.02.21.17.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 17:05:35 -0800 (PST)
Date: Thu, 22 Feb 2024 09:05:30 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/2] gpiolib: cdev: release IRQs when the gpio chip
 device is removed
Message-ID: <20240222010530.GA11949@rigel>
References: <20240220111019.133697-1-herve.codina@bootlin.com>
 <20240220111019.133697-3-herve.codina@bootlin.com>
 <20240220142959.GA244726@rigel>
 <20240222005744.GA3603@rigel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222005744.GA3603@rigel>

On Thu, Feb 22, 2024 at 08:57:44AM +0800, Kent Gibson wrote:
> On Tue, Feb 20, 2024 at 10:29:59PM +0800, Kent Gibson wrote:
> > On Tue, Feb 20, 2024 at 12:10:18PM +0100, Herve Codina wrote:
>
> ...
>
> > >  }
> > >
> > > +static int linereq_unregistered_notify(struct notifier_block *nb,
> > > +				       unsigned long action, void *data)
> > > +{
> > > +	struct linereq *lr = container_of(nb, struct linereq,
> > > +					  device_unregistered_nb);
> > > +	int i;
> > > +
> > > +	for (i = 0; i < lr->num_lines; i++) {
> > > +		if (lr->lines[i].desc)
> > > +			edge_detector_stop(&lr->lines[i]);
> > > +	}
> > > +
> >
> > Firstly, the re-ordering in the previous patch creates a race,
> > as the NULLing of the gdev->chip serves to numb the cdev ioctls, so
> > there is now a window between the notifier being called and that numbing,
> > during which userspace may call linereq_set_config() and re-request
> > the irq.
> >
> > There is also a race here with linereq_set_config().  That can be prevented
> > by holding the lr->config_mutex - assuming the notifier is not being called
> > from atomic context.
> >
>
> It occurs to me that the fixed reordering in patch 1 would place
> the notifier call AFTER the NULLing of the ioctls, so there will no longer
> be any chance of a race with linereq_set_config() - so holding the
> config_mutex semaphore is not necessary.
>

NULLing -> numbing

The gdev->chip is NULLed, so the ioctls are numbed.
And I need to let the coffee soak in before sending.

> In which case this patch is fine - it is only patch 1 that requires
> updating.
>
> Cheers,
> Kent.

