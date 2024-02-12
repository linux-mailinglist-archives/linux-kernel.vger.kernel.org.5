Return-Path: <linux-kernel+bounces-61268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86494851022
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93BA1C21E24
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B72E17BC7;
	Mon, 12 Feb 2024 09:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M48HCUmx"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A3A18032;
	Mon, 12 Feb 2024 09:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707731850; cv=none; b=r8kFkkv6eNUqJe1p4W8AvcBzLJmpRK0Tkii7RdI8VRh54rBHtDjLJSQIzSQs9STM3NnMIFi375osVpbXcS4+hRu9KAcumMito+f6d/s0+/eYehCu7umeY2ejcFLqOSuEbG8k68MaAS6JFDK2Kv2luh0QtaJKddar7TQ1UNXdOiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707731850; c=relaxed/simple;
	bh=eCqmbyMfVAA3HHq0HEwZ9UD08bLCGHfxEbdDbk7eRwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQe4Xg/DQ6jNbP/8xJNKJaxWOexw49nr5JTduUsiXzXG8Row+SReWPqz29tGxQ0ezx016YAEZk1vuuwSyrdcH0g0o+1e5dwX1OEhBv5rjZ+SNY6ma8UI5IkQ4qNCF5jbdJvjzUMJmB2rEk9vfcdGkwlivr7+kEIzSkCtYoINR/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M48HCUmx; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-29041136f73so1651018a91.0;
        Mon, 12 Feb 2024 01:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707731848; x=1708336648; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oyhOHugUVAx4B66zNESjQuh6m2gkAlYGfoBW+8fBdik=;
        b=M48HCUmx4jH7JA8oEdMpCBUqJIHCTXYR/jRL2yRq5IQ+oClIuCSyiASL94YNSKyHjW
         kZAkMqtslKkdmRWtd2v9P6VEMhqdS/RjnYu5o9cxHqYK5Ji0GbclyV7p25++NHbitBJY
         kDbR7NvvguQId6v1niCHa0/hgH16wFSUYFNzK9rkpsb08FNq17ovqaR7PTl82+qglR0k
         3h80o6W5uPe0aAGC1g8q8Ivwo6Mc0u3Ss2lIdAfzqq1eHEYI9Ij0kxWOpcwwSLE0YpwF
         rIjeYy3dVRVJysHOlioFaWaNKPsZ2U1rejJoDDdNBy/b5JRZbmyl9QJ4Vqm0phMwls48
         G9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707731848; x=1708336648;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oyhOHugUVAx4B66zNESjQuh6m2gkAlYGfoBW+8fBdik=;
        b=WHhetCrayu75wQOd3KavARSUNnJnITCyisF/v8HzZ2Q6sVvwdthx4RRFTJaqRl9ycq
         j093i3NRoOIl19Um2j7IQgIZZUEgFOQVKDjH9yL3yKV+I3vTnVDTCZH6f7g2dyxYgkrU
         GMToUxEiV+EoHNu3nHgyySlVTXbkjsYOxb+Emyb2n6V0Wybc9DU5ibxHHQTniIzI2FJi
         /an+eAX8p7v24hz/1Kc3ukVW5+CIwOWZXaYZbtqa3XmQsfVGbi6iNuUqOqS2agAQNjlE
         +WisPolaXt4IG5rXCNxktVGu6CpRiIrFLoC+PsIQ/hl3GFU1Xmg0eDJUns+DNiAkAG/1
         rj+g==
X-Gm-Message-State: AOJu0YyADs6hiFLXBpESd8VlEUSk42lC/0onZwIaCDASC9Lohqc4020X
	FmaEqeZFqVUocWEnKjqWzwa2LU7SS8zA2sMzvPKW1PELhMFgD58r
X-Google-Smtp-Source: AGHT+IEgnRvYJL1OfbeRML3L344/GxTTB1Q8Pkgg6QOkelFQtjr8RKhStioejs5S2m67u5dtr6o6JA==
X-Received: by 2002:a17:90b:4009:b0:295:ade7:cdf2 with SMTP id ie9-20020a17090b400900b00295ade7cdf2mr3070418pjb.13.1707731848509;
        Mon, 12 Feb 2024 01:57:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1SmWRDClNQ9LXUj4w/Ehvs7aJrWFeaQRiJab+GrNE0rr0sdisXVFN2DPl5LG4KL0d6QFUSyPxVpuc2emQCo1Y6L6XXwxHfjxJHsU3vuxLPjOeW1u7B/DsYvUBgIRGlZ1elRUrkFohETMrhKASYwL0sRPUMZv5i3lUaLRjl1ZNsbiDOYakeD4k9mkKmaiA7hk3IyJ1WcqcR0n9Ode7Nn1zLZwT0/zIJl+njiZgjYnnFjI2cuQoJjVVujHt0qxfxB/ufvjia+gwSJFurl0ANtmNFBUfRQRDr6xaMcKqIbAquxSMnSEzeLWpX+2gi31rCg++m4b+oZc8rJNve05L
Received: from rigel ([220.235.35.85])
        by smtp.gmail.com with ESMTPSA id d5-20020a17090ac24500b002971390d19csm97492pjx.1.2024.02.12.01.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 01:57:28 -0800 (PST)
Date: Mon, 12 Feb 2024 17:57:22 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alex Elder <elder@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 23/24] gpio: remove the RW semaphore from the GPIO
 device
Message-ID: <20240212095722.GB388487@rigel>
References: <20240208095920.8035-1-brgl@bgdev.pl>
 <20240208095920.8035-24-brgl@bgdev.pl>
 <20240210053730.GA187163@rigel>
 <CAMRc=Mcq2Obf58=iLHpm5B2_KkHCqRevFWupbBuKmNs_BV6i2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mcq2Obf58=iLHpm5B2_KkHCqRevFWupbBuKmNs_BV6i2g@mail.gmail.com>

On Mon, Feb 12, 2024 at 10:53:07AM +0100, Bartosz Golaszewski wrote:
> On Sat, Feb 10, 2024 at 6:37 AM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > On Thu, Feb 08, 2024 at 10:59:19AM +0100, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > With all accesses to gdev->chip being protected with SRCU, we can now
> > > remove the RW-semaphore specific to the character device which
> > > fullfilled the same role up to this point.
> > >
> >
> > fulfilled
> >
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > > ---
> > >  drivers/gpio/gpiolib-cdev.c | 1 -
> > >  drivers/gpio/gpiolib.c      | 4 ----
> > >  drivers/gpio/gpiolib.h      | 5 -----
> > >  3 files changed, 10 deletions(-)
> > >
> > > diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> > > index ccdeed013f6b..9323b357df43 100644
> > > --- a/drivers/gpio/gpiolib-cdev.c
> > > +++ b/drivers/gpio/gpiolib-cdev.c
> > > @@ -24,7 +24,6 @@
> > >  #include <linux/pinctrl/consumer.h>
> > >  #include <linux/poll.h>
> > >  #include <linux/rbtree.h>
> > > -#include <linux/rwsem.h>
> > >  #include <linux/seq_file.h>
> > >  #include <linux/spinlock.h>
> > >  #include <linux/timekeeping.h>
> >
> > Shouldn't this be part of the rwsem -> srcu switch in the previous
> > patch?
> >
>
> That other patch was already huge. I figured this should be separate.
>

To be clear, I mean just this header removal, not the whole patch.

Cheers,
Kent.

