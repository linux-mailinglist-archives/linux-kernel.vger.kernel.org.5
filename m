Return-Path: <linux-kernel+bounces-6996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 587EF81A053
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D086284625
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862063716B;
	Wed, 20 Dec 2023 13:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNAclo50"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9912538DD5;
	Wed, 20 Dec 2023 13:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d04c097e34so6018415ad.0;
        Wed, 20 Dec 2023 05:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703080429; x=1703685229; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+oQKwjeNrmhY06Pfwv0+C1DNUwlrrB0GDKSfgdTxLZY=;
        b=CNAclo50ZAU12VYHzq4XUUsli/TzLbyMmZ5vLufofmz/VNEQi6GWV2FVA84mmLr41b
         jhNsPsaGEn6x8wz5Szj458imti8z9YUuGLZq7GodjKWjVgDkBwMdHod9duUouu2DAVmt
         Tn1OutDAFD8OteUlm6/oN8qRFEJBIMDwx58jXnoSp1A46huXx5iIv+Wh4vwqHe+UKCdM
         w8dprvYj9wAoJqcS9hcILIPxAnPyEB3uw29zMCBCB2t44IBYSg9doj+VSh0qFzHzYd77
         JJ+9TPmI3rLYmDADt+UwebDhNbfvQPVwXP6gbtOFnnTIpFyedF298IOKxGiLJCllpNMH
         2ynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703080429; x=1703685229;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+oQKwjeNrmhY06Pfwv0+C1DNUwlrrB0GDKSfgdTxLZY=;
        b=wZfnlU3rRdztmuJUMrjHHLADRtYZ83VdhqymK9hxQ5Ivnk5R1+O/Wg3lsvKvVeME8F
         ca6KMlFa+EapNCCt7X4n1Qdmtt9X+n7CDF94XNOlIrgTfDckuaQkd5bSMSAT8sQV2aA5
         hONNI5wSVKhVtaTRBTyp+vRC7l/Vzu/lBE4F4U7++oBiGvU50+OX5VJbDcchEQasPcHy
         5iBeLJZ4yF2nT4fQPhFQG4yuRkW0ezQUTbKOqJ0RHIpz0rCTiB0HGFLWLBJmlhj2HVhT
         9PrLzvqMMiN6FHcNTlWPLB/BZG65IHMLTnsQWvvd78bE3ptbx5EDD75b8QhMcyVZEh7S
         RTWQ==
X-Gm-Message-State: AOJu0Yx7C770pq7XqDQo+AjNApxtQado7WOH1JIo81DJN9aPx1fNHae2
	e3udYLsM+QFIY6GqfyeaA8M=
X-Google-Smtp-Source: AGHT+IEGVW1i9VIgTb6R5XPpLS0sggrLzXmDh87Bm/LkdSDZnFCLliNG5vKZpehLlH7xjv7xs23pgg==
X-Received: by 2002:a17:902:8c85:b0:1d0:6ffd:6112 with SMTP id t5-20020a1709028c8500b001d06ffd6112mr2927869plo.52.1703080428720;
        Wed, 20 Dec 2023 05:53:48 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id s16-20020a170902989000b001bb750189desm23092235plp.255.2023.12.20.05.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 05:53:48 -0800 (PST)
Date: Wed, 20 Dec 2023 21:53:43 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, andy@kernel.org
Subject: Re: [PATCH 4/4] gpiolib: cdev: replace locking wrappers for
 gpio_device with guards
Message-ID: <ZYLx5-k-dIqlCQ3A@rigel>
References: <CACRpkdZ5HzOxtbexQNE-A-bKhiUW1nHjvJQA_CCnmVXf+R6dbg@mail.gmail.com>
 <CAMRc=MfvKzOxPrmz1wmgWMwYUbNhWAjqoKOmcaggQntcDprLmQ@mail.gmail.com>
 <ZYLaayENrvL1Nh6H@rigel>
 <CAMRc=MfyCBpZ07SYfxMtug6FVYiKA0MRgvjMTOAzKiVLGdPM+w@mail.gmail.com>
 <ZYLczeiVDjd2cWQF@rigel>
 <CAMRc=MeXa5g6iQNYF4W+vGL+kgRTyVjFB-yXE_UBpuTnn2ZKng@mail.gmail.com>
 <ZYLjuqxXylKPYeYP@rigel>
 <CAMRc=McNMLmiUsGj8HmCqiwv-9K6EbMrmHpHMaMeFHx9BFX8gQ@mail.gmail.com>
 <ZYLr-LrZ_NurJXHi@rigel>
 <CAMRc=MdvPA7Km-029-AF36Vh7sWs-j3ft+equiGVMg4_Na3LgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdvPA7Km-029-AF36Vh7sWs-j3ft+equiGVMg4_Na3LgA@mail.gmail.com>

On Wed, Dec 20, 2023 at 02:47:45PM +0100, Bartosz Golaszewski wrote:
> On Wed, Dec 20, 2023 at 2:28 PM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > On Wed, Dec 20, 2023 at 02:19:37PM +0100, Bartosz Golaszewski wrote:
> > > On Wed, Dec 20, 2023 at 1:53 PM Kent Gibson <warthog618@gmail.com> wrote:
> > > >
> > > > On Wed, Dec 20, 2023 at 01:30:57PM +0100, Bartosz Golaszewski wrote:
> > > > > On Wed, Dec 20, 2023 at 1:23 PM Kent Gibson <warthog618@gmail.com> wrote:
> > > > > >
> > > > > > >
> > > > > >
> > > > > > It would be read and write guards for the gpio_device.
> > > > > > cdev would only be using the read flavour.
> > > > > > And possibly named something other than read/write as the purpose is to
> > > > > > prevent (read) or allow (write) object removal.
> > > > > >
> > > > > > I though that would be clearer than having to reference gpiolib.h to see
> > > > > > what gdev->sem covers, and allow you to change the locking
> > > > > > mechanism later and not have to update cdev.
> > > > > >
> > > > >
> > > > > I still prefer open-coded guards here for clarity. I hope that with
> > > > > SRCU in gpiolib.c, we'll get rid of locking in cdev entirely anyway.
> > > > >
> > > >
> > > > Ok, it is your object so I should use it the way you want it used.
> > > >
> > > > Btw, before I go pushing out a v2, do you have an answer on whether
> > > > gpio_ioctl() requires a guard, as mentioned in the cover letter?
> > > > Is the fact there is an active ioctl on the chardev sufficient in
> > > > itself to keep the gpio_device alive?
> > > >
> > >
> > > AFAICT: no. I think it's a bug (good catch!).
> >
> > The wrappers made that harder to pick up.
> > It kind of stood out as the exception after changing the other ioctls
> > over to guards - where was the guard for that one?
> >
>
> Yeah, it makes sense. This is precisely why guards are so much better
> than hand-coding locks.
>
> > > Can you extend your
> > > series with a backportable bugfix that would come first?
> > >
> >
> > Sure.  That would still use the guard(rwsem_read)?
> > I mean you don't to go adding a wrapper for the fix, just to
> > subsequently remove it, right?
> >
>
> In master - sure. But we definitely do want to backport that to stable
> branches and for that we need to use the old wrapper.
>

Ok, so cleanup.h is too recent for backporting.
Adding and then removing a wrapper it is then.

Cheers,
Kent.

