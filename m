Return-Path: <linux-kernel+bounces-104183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D861887CA5B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3361F222DC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7826A175B6;
	Fri, 15 Mar 2024 09:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A16aS3m7"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1379B1755A;
	Fri, 15 Mar 2024 09:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710493532; cv=none; b=u6M5uZTBGDwqoQQu9eAL5mckdL7dhvNSMdEueRzUoDpNVXVbvSh6ypNvj/uxuJ4bBjGG97mfmLv3qNCWbuNEYPeYzGdclbQ6Ih2e4fDE0J4YixljSty/gJMrg9oe53zLxT5Me5O7hjsoVNm8feEM8OFPCIK96iR9doWmyQYiq1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710493532; c=relaxed/simple;
	bh=9Wr/WHl5jjd+r6BC9zDAQHL3m+G4K5aBLL3K0PtAJ/o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vf8eKw7xUu1kSeg0sOCoNN8AMfwfnqV5FvCyAmW8M+WIhPkNoNJvQGBe7Vw3yrzci21inOhuQPT3tAWEYB25qqnHrSEsYFFBZ34pisJ5Eh6lkmRUWHsomq6YuQXj+RqI+ISPafiI5+2oulXzT+8q3OUmrizPTUrqR48qh1JIxSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A16aS3m7; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a45f257b81fso230892466b.0;
        Fri, 15 Mar 2024 02:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710493529; x=1711098329; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TxeRvHu/Cn5xVdouc/KQm2ZkL4m6+rAgdA+KuVZtW9A=;
        b=A16aS3m77cz0owKtcZeMkgX9IgM7lQ7hzebQO2HHFTUr+OHCnupJkPPh2/XOsafodO
         lWtaxPbgL1cOnXgNCHIDTf6ShRmhwp+PO3pUGhFByIBNn7c3hOmHwQGGAsHBrPz/vzqF
         +w7fE+UPDGk3CY9aPtVuMgyhRibynP54Rg5blntNsv8DCwmmJFUhU6q3FL8CXiFnkbHE
         6gbTa2wDP/HU1+WF8XamGLR0+1MZcgJUlAHDPWYwDnyjIcIpHQi58Zn7yIu6gjYgi1kQ
         61ONPfdzrJ4a7wV9KisVEDHNkuFgCT7op4VTnxqqEckzPgtvI1f1+CqyhQz+IGUT1GTj
         apjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710493529; x=1711098329;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TxeRvHu/Cn5xVdouc/KQm2ZkL4m6+rAgdA+KuVZtW9A=;
        b=VrujilUKcRd1N3Zw3rsDG7ZhDN7XgYjG/kIYaQISvG6lTReQpmoEjyT8L/Vfks/ACr
         +cvwL4UafM/sk1OBVJvjbm2oLmcKNZWlZTtOVyaoogxFGxAAL09g8nDGCHluM56emdp6
         aZv1weF4I4465Is1paETWZSTiAlcKd+JIYhqp5J8QmvCBLvV+lyD3onhmniNZpBKXhzi
         vZ+nKQP+0yyeXpxi4/vQAAv6WPgw5sZ/ZIuyVWmHoh+x65jdWbD5vAM1GSL7swNb2+zZ
         RTUxJKGPzBy655yqTTN2BY/E9bc+OPy1nQMe1fixFv1gM6qNbXl1bnOwAUFFWFOVBk1p
         0asg==
X-Forwarded-Encrypted: i=1; AJvYcCUEgKDJfs8yC/dOVP3uyQxDuSPv2W5/sAx3kMTofU7kgDl6tsZPJ9tjJxNcDyrVnArqlFRLR6UxbVQjjNtnAiW9v/JKevkkBK3C/ONvH3l91j1NkQmSTeLQLliMRtIncjqtkTwOfDGQ
X-Gm-Message-State: AOJu0Yw98Mgo7yd9xBkBYVC8ypmPr+xI0GnnDK6H90bZL+a2Si+CvTP8
	4FJk49SrYQZMWCMd1fpg1Nqf137K9fEgAEJVWIreemBIjsZS76Ye
X-Google-Smtp-Source: AGHT+IGB2COdTYW4uDyufoSziJPEzTPjjGdlCx1qqcqrkvp10SASXDI5BR5O4vj6BoDuUeBr6psKQg==
X-Received: by 2002:a17:906:8406:b0:a46:7384:3233 with SMTP id n6-20020a170906840600b00a4673843233mr2416679ejx.57.1710493529117;
        Fri, 15 Mar 2024 02:05:29 -0700 (PDT)
Received: from vamoirid-EDL-PC ([2001:1458:202:121::101:4e8c])
        by smtp.gmail.com with ESMTPSA id jz8-20020a17090775e800b00a461d2a3374sm1495608ejc.47.2024.03.15.02.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 02:05:28 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoirid-edl-pc>
Date: Fri, 15 Mar 2024 10:05:26 +0100
To: Angel Iglesias <ang.iglesiasg@gmail.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>, lars@metafoo.de,
	andriy.shevchenko@linux.intel.com, mazziesaccount@gmail.com,
	ak@it-klinger.de, petre.rodan@subdimension.ro,
	linus.walleij@linaro.org, phil@raspberrypi.com, 579lpy@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] iio: pressure: Simplify and make more clear
 temperature readings
Message-ID: <ZfQPVlqv7A3zxExl@vamoirid-EDL-PC>
References: <20240313174007.1934983-1-vassilisamir@gmail.com>
 <20240313174007.1934983-5-vassilisamir@gmail.com>
 <20240314150959.585367b5@jic23-huawei>
 <20240314201718.GD1964894@vamoiridPC>
 <46389801aeb20f18affed86d979aff7a62cf36d5.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46389801aeb20f18affed86d979aff7a62cf36d5.camel@gmail.com>

On Fri, Mar 15, 2024 at 12:22:50AM +0100, Angel Iglesias wrote:
> On Thu, 2024-03-14 at 21:17 +0100, Vasileios Amoiridis wrote:
> > On Thu, Mar 14, 2024 at 03:09:59PM +0000, Jonathan Cameron wrote:
> > > On Wed, 13 Mar 2024 18:40:05 +0100
> > > Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> > > 
> > > > The read_press/read_humid functions need the updated t_fine value
> > > > in order to calculate the current pressure/humidity. Temperature
> > > > reads should be removed from the read_press/read_humid functions
> > > > and should be placed in the oneshot captures before the pressure
> > > > and humidity reads. This makes the code more intuitive.
> > > > 
> > > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > > 
> > > To me this makes the use of these calls less obvious than they were
> > > previously.  The calls are made close to where t_fine is used and
> > > don't have to go via the indirection of chip_info.
> > > 
> > > So I disagree. I think this change makes the code a lot less
> > > clear.
> > > 
> > 
> > This was mainly driven by the fact that I wanted to avoid reading
> > the temperature 3 times in case temp, press and humid are enabled
> > and there are consecutive buffer readings. But thank you for the
> > proposal I really appreciate it!
> > 
> 
> Hi, just a side note reflecting on this. Depending on your sampling frequency
> and registers data shadowing, to avoid compensating with different samples
> between readings, we should be doing burst readings to get a bundle of the
> temperature+pressure and/or humidity.
> On the bmp/bme280 and bmp380 this can be done as registers are contiguous on the
> memory. On the bmp580 this is not a problem as the values are already
> compensated, you`ll get always the latest reading.
> 
> Kind regard,
> Angel

Hi Angel,

Thank you for pointing this out! Indeed that's true but I noticed that this is not
the case for the BMP{085/180} devices. I just feel that some changes might make
data acquisition/processing faster for a device (like the one you proposed) but
it might make the code much more unreadable and unmaintanable. I will try and
see if something could be done in that sense but I feel that keeping it simple will
be good for everyone!

Cheers,
Vasilis

