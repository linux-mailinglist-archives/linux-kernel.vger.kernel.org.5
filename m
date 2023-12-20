Return-Path: <linux-kernel+bounces-6920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AC6819F56
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA3B1C2303C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BB025544;
	Wed, 20 Dec 2023 12:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmpEuSg1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C592D612;
	Wed, 20 Dec 2023 12:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d3eae5c1d7so4756445ad.2;
        Wed, 20 Dec 2023 04:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703076800; x=1703681600; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pu8CMU1xj5S1tt+nhGWIOxnMNYsHDR3R1vbW4Tx+XZQ=;
        b=LmpEuSg1s65xBah0P2p5jhGetQvOUSFRpyiKEKbAL2tetG9NWbwkxY11W6zc+A6vWU
         xax86P7aYUiwjyTlkcPnlXDhG44qSNRvkUPMyp8/LJrBKKFD+kohYn4HnmLZCsg0DNGz
         C//2nwjsvhSG+dv9h5PTbh+OqGy0S/DUZaZ7BYTdfJQlMmkFkxBxMS0KoQ71ovKFR8zr
         t4AKjHryjNeR1KX3Aw6Qpi9nNNEouf2XSq+r7W5h+17FjE7NHQg0HhYfkukOW9zW6bFj
         NE85p5emncSdrGDfiCb1Z6QryB3qf9y7PNRyYEmRPUI2RiXa4GLiAAJYKmwnEqRWZZod
         9eeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703076800; x=1703681600;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pu8CMU1xj5S1tt+nhGWIOxnMNYsHDR3R1vbW4Tx+XZQ=;
        b=b+F7BbWYpanqc5zqurK2yiP0wOErVJTKaPvwNP6MfGNMhBFyeR97IpK/Rd9RJ3tBj2
         ySs+pHjUGxIuMviniOnSj0UmZZmg5NrESs3UDD0jSgWPq5Pb8YcxME0BxUw860/766jS
         3/EJlvvve2zMMtk7EhP62WQNWhm9aCDmjTfZ7XJJjP0a7p8uKXzFz6Cliwa80+mKEIdL
         xdhLbmeoH6TL2ZIIWSCs/if5G4pdfgM95hVPVcJfz9SQ/ZKOm3PjYe3y4DwBAReQSrn/
         e6VWxQ6DfRvWNH0XSwS1ZNIsKxzn2iX4Uum2sQ+3hAafxZtjnxhoFlwWTAYeNGj+tLg5
         LOMQ==
X-Gm-Message-State: AOJu0YzscyOjzizwmnVoCUkQhqnnAGwywVhqO0oXrxfdHRwE/vZbijCy
	vI6A/WOvcz3lJWjVcpSKnxLwebHflhA=
X-Google-Smtp-Source: AGHT+IEEjj1N057u2J4nucBd3jEuKHMrIYJeW898KkxpkRIjtCy45r9TNBaRBJsNiwg2wgFg4iuKjA==
X-Received: by 2002:a17:902:e80b:b0:1d3:c21c:9400 with SMTP id u11-20020a170902e80b00b001d3c21c9400mr3354182plg.40.1703076800268;
        Wed, 20 Dec 2023 04:53:20 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id ju17-20020a170903429100b001d0cd48e08fsm1295481plb.179.2023.12.20.04.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 04:53:20 -0800 (PST)
Date: Wed, 20 Dec 2023 20:53:14 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, andy@kernel.org
Subject: Re: [PATCH 4/4] gpiolib: cdev: replace locking wrappers for
 gpio_device with guards
Message-ID: <ZYLjuqxXylKPYeYP@rigel>
References: <20231220015106.16732-1-warthog618@gmail.com>
 <20231220015106.16732-5-warthog618@gmail.com>
 <CACRpkdZ5HzOxtbexQNE-A-bKhiUW1nHjvJQA_CCnmVXf+R6dbg@mail.gmail.com>
 <CAMRc=MfvKzOxPrmz1wmgWMwYUbNhWAjqoKOmcaggQntcDprLmQ@mail.gmail.com>
 <ZYLaayENrvL1Nh6H@rigel>
 <CAMRc=MfyCBpZ07SYfxMtug6FVYiKA0MRgvjMTOAzKiVLGdPM+w@mail.gmail.com>
 <ZYLczeiVDjd2cWQF@rigel>
 <CAMRc=MeXa5g6iQNYF4W+vGL+kgRTyVjFB-yXE_UBpuTnn2ZKng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeXa5g6iQNYF4W+vGL+kgRTyVjFB-yXE_UBpuTnn2ZKng@mail.gmail.com>

On Wed, Dec 20, 2023 at 01:30:57PM +0100, Bartosz Golaszewski wrote:
> On Wed, Dec 20, 2023 at 1:23 PM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > >
> >
> > It would be read and write guards for the gpio_device.
> > cdev would only be using the read flavour.
> > And possibly named something other than read/write as the purpose is to
> > prevent (read) or allow (write) object removal.
> >
> > I though that would be clearer than having to reference gpiolib.h to see
> > what gdev->sem covers, and allow you to change the locking
> > mechanism later and not have to update cdev.
> >
>
> I still prefer open-coded guards here for clarity. I hope that with
> SRCU in gpiolib.c, we'll get rid of locking in cdev entirely anyway.
>

Ok, it is your object so I should use it the way you want it used.

Btw, before I go pushing out a v2, do you have an answer on whether
gpio_ioctl() requires a guard, as mentioned in the cover letter?
Is the fact there is an active ioctl on the chardev sufficient in
itself to keep the gpio_device alive?

Cheers,
Kent.

