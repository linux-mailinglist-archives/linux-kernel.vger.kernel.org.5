Return-Path: <linux-kernel+bounces-52573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 261988499CF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D72B8280F4D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD3E1CF98;
	Mon,  5 Feb 2024 12:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="Dcohv9Zm"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1441CF90;
	Mon,  5 Feb 2024 12:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134969; cv=none; b=Leq3kpa1n4y3U104oj+8IK9UOg1xWlDU0ZYaU0qU0byRgUwX6NVWCzaiHwitrPk64QzIB6loy3o8zvgCfCNAJK3Tq1xoCKL0L1Ns+vXZGZi44RzZ9Y6E+2+m6FcLpSjF2o2Ky2DDpD6bWmg2fyRyxgzTLEnpjFzsg2V6/dVg5j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134969; c=relaxed/simple;
	bh=rIS3Kq1SWOO0Zhnbi5PnG6r7kDJfMeM311Gm53usdsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEqJGQxnskE4z3j3MPjMbXnpdRECMnCnky6nsidpX4vpoDKawFplcQ9WmL6MlPkgnbtMpx7t0/Kyk6sdoEUNzhAhO3MJK1VMECZaSC7O/MagKQC1HqQ40OEd0hrQeSZvn+4WpeFfB9sPdDEiNmfHj9QxLrKK8EF70AdRqxzlG0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=Dcohv9Zm reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d94323d547so34010485ad.3;
        Mon, 05 Feb 2024 04:09:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707134966; x=1707739766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DLefc7pK7RFw+slAQXx+5sxeMi8rLG7VIsDmWRBNNj4=;
        b=CIq+YDDMuidVL6k1eRx+s9l4JdKNEMe9YtKGo/ryW+A1YnCCgc6fUFU6yzYf2LPJvs
         vn+1JUJOPHgALl57FPMfeIG+HO0CRdFeEXQpHhkoqvfWzWw4AGC5TdZtdWOUy5/753Ub
         VEeEE7UvJd2gLb13o3EqKVAzD1T5oE859hNGj9huqmONMQRkZMLsrc3y0Fl8TQrJ8dEg
         OY7Xbr02xGsAVCAemveYoQZD/c76QWXpXc5INcmYINaht1E0sKOzdBggPnLtW7O6WS7d
         vfVRlge5FiDhB2GO+f6HVXrIwoMaUHH8uhDKxIkp3ucj2PHaBRCNIGMKL6Pjonp23hZG
         A8dQ==
X-Gm-Message-State: AOJu0YzxYvbNDWHZOhW3jUkhwKn3rIqJd1AitjOZhhCpyPrGqiEwCgLr
	hq8V08Tcz6ce+I+PZC2gmpJhurZ9oMPNEeFGt5yBKvy1NjeOaNq8
X-Google-Smtp-Source: AGHT+IFrYOIMiP3EBjQ3nn8jd9iPQ++Rmhlp00zJ2q9BETQ3jKHx72CnQjqjRJbiQ6SSobwcN+WNhA==
X-Received: by 2002:a17:903:22c4:b0:1d9:8cd8:acff with SMTP id y4-20020a17090322c400b001d98cd8acffmr7337201plg.62.1707134966532;
        Mon, 05 Feb 2024 04:09:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUP/czwzdKsfd/YxV57fPcqHupmEkuS0ucXZWYDNuIK2VLIR2MJQoI62z06hO+1lV1aJpuX7wfy41O3lX6ZXNvqZxBv+qVT348l5ETrgqIzrAuWmilV5xdZ0ZLs1CiqpOHUEHxPHTXY7cNZipCTq5PucPayGV9dck4EjojGJM4PYFP8BScerxKgdUFTgnOFXvJ2f9w=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902b78600b001d8a81e22cbsm6204351pls.14.2024.02.05.04.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:09:26 -0800 (PST)
Date: Mon, 5 Feb 2024 09:09:55 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707134964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DLefc7pK7RFw+slAQXx+5sxeMi8rLG7VIsDmWRBNNj4=;
	b=Dcohv9ZmrIkhJHT1VAYvE3tesaObT45lBMg4covJzOgHaqPIVv+acV70HlaZY2qT6De7U7
	agkhlwF42FTe2kfo4z6MnQeuyvJML4w9UZ57f/gepD1xCjRLmiXckd+rrtaO5JUY1TJIj2
	6hY2z7N10vSxUj9HHdKswJWXcZWWq41VMHQi135/NqzWschf5OW3g2bg9za15O0i6+ZBff
	lYGWnAqR3j6gH3cnGN61cgFaFcdHlCH9Y4YOEQPtc1dDUodcOoS0rwxTlMNdd/v2+dIfSj
	Zpa7NN5oDwwER+nZODQX4SBZhXm4A80XffkKy/3hhYcIhet8ji7ztmqGTA5PHA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] dma: dma-sysfs: make dma_subsys const
Message-ID: <paxhpsxe6w5r3urpwr5jvj36mlg5zxtmpdj2tzqhahl7qt66zi@4ppfluzcsaso>
References: <20240204-bus_cleanup-sh-v1-1-44ced951bb16@marliere.net>
 <26d729c173a2ba0b536de4b41dacd403793d94c7.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26d729c173a2ba0b536de4b41dacd403793d94c7.camel@physik.fu-berlin.de>

On  5 Feb 06:17, John Paul Adrian Glaubitz wrote:
> Hi Ricardo,
> 
> On Sun, 2024-02-04 at 12:15 -0300, Ricardo B. Marliere wrote:
> > Now that the driver core can properly handle constant struct bus_type,
> > move the dma_subsys variable to be a constant structure as well,
> > placing it into read-only memory which can not be modified at runtime.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> > ---
> >  arch/sh/drivers/dma/dma-sysfs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/sh/drivers/dma/dma-sysfs.c b/arch/sh/drivers/dma/dma-sysfs.c
> > index 431bc18f0a41..9f666280d80c 100644
> > --- a/arch/sh/drivers/dma/dma-sysfs.c
> > +++ b/arch/sh/drivers/dma/dma-sysfs.c
> > @@ -15,7 +15,7 @@
> >  #include <linux/string.h>
> >  #include <asm/dma.h>
> >  
> > -static struct bus_type dma_subsys = {
> > +static const struct bus_type dma_subsys = {
> >  	.name = "dma",
> >  	.dev_name = "dma",
> >  };
> > 
> > ---
> > base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> > change-id: 20240204-bus_cleanup-sh-6d3c136da6bb
> > 
> > Best regards,
> 
> Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> 
> Thanks for your patch. I will merge it into my linux-sh this weekend
> after returning from FOSDEM, either this evening or tomorrow.

Hi John,

thanks for reviewing. I was wondering if your tree should be listed
under SUPERH in the MAINTAINERS file? I didn't find it there and had to
do some searching.

All the best,
-	Ricardo.


> 
> Thanks,
> Adrian
> 
> -- 
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

