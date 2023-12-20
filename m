Return-Path: <linux-kernel+bounces-6956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E42D819FCE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C887B1F2311E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB6E2D63E;
	Wed, 20 Dec 2023 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGWs6Li/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6192D61A;
	Wed, 20 Dec 2023 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5cd8667c59eso3039897a12.2;
        Wed, 20 Dec 2023 05:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703078910; x=1703683710; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J42uhLZ5NQHa3c71aYKd5raLQ9LnD7iuSq74hysliPg=;
        b=LGWs6Li//ZmQRel0HFqaFeCFm7tj4QnCw01yI3kZitofcJvAHD/K/6S02L2lPYlwvv
         jlgN9H1Hgy9orbHDiZzgeKsla1yBc+rLdlpTkdH9B1VOEHtPpGN1drnrpwAapRgJTXqz
         EZ0xT53w9nGm5f9BPNA3YYNLSyWi5gkNV2FEQsj7h/VmFZ3ha+8javUxDj4WYX4jVHi3
         rldoIgomtHgN8zNWlK+XZ1L1nMSM4UxxwEfmHKLIUyQnf8T2LX7nj1yVQG4/wccXP5DT
         WN+iKmROMKmdkoOIPl4Y16of16B/2HW9cmiL+saE/g75QFLlNp3G6MAdIMEnhEDLvjQi
         fTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703078910; x=1703683710;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J42uhLZ5NQHa3c71aYKd5raLQ9LnD7iuSq74hysliPg=;
        b=L02Db+Loern8YM6WSAJB9s9qnN2CoOqFaAS4iDz01EmOpD87Rx5fbUT9KScgWVnr94
         RveLDbIxMz906utuY9bC9IfWeRY4bqdeGkHCe9VfAfxgO+hdrRKCRivoDBjsISl+kIsz
         gMpPXoPu86krDjkyUX6uSTUwjQozR0Gtvrjxpi577rNBXkz1+seb5OtCk/FV00bg+4bN
         wpjgaj46iQX9MXWnSSw3m82QxmiLnw96fiLVQbjrNmmzHnirn73pPMHu+U/IJFv2O0ZC
         Bw1USgyQ7hgSPMgKcLg09IzEYsbBCiL0KP9+cT0hfnKFLhu+343HGE6lMTHUn/S2HRf1
         77aQ==
X-Gm-Message-State: AOJu0Yw5xPalUoxzrl0YjGHwzG3vCfgkPJX0AqgpZ2iZW9k2Uag3WQ/9
	aCzwJDw1efJaIJ4rp0DY/kHKZRFfO5U=
X-Google-Smtp-Source: AGHT+IGHYzQEhTi2R8h7A57ens1/NZwAHZQ6fGv5YZYGCyuZODlZdkwq6MFrUDsHjR+WrhScG6nG8Q==
X-Received: by 2002:a17:903:246:b0:1d3:bc96:6c13 with SMTP id j6-20020a170903024600b001d3bc966c13mr6215334plh.35.1703078910118;
        Wed, 20 Dec 2023 05:28:30 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902d2c200b001cfd0ddc5b9sm22897145plc.262.2023.12.20.05.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 05:28:29 -0800 (PST)
Date: Wed, 20 Dec 2023 21:28:24 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, andy@kernel.org
Subject: Re: [PATCH 4/4] gpiolib: cdev: replace locking wrappers for
 gpio_device with guards
Message-ID: <ZYLr-LrZ_NurJXHi@rigel>
References: <20231220015106.16732-1-warthog618@gmail.com>
 <20231220015106.16732-5-warthog618@gmail.com>
 <CACRpkdZ5HzOxtbexQNE-A-bKhiUW1nHjvJQA_CCnmVXf+R6dbg@mail.gmail.com>
 <CAMRc=MfvKzOxPrmz1wmgWMwYUbNhWAjqoKOmcaggQntcDprLmQ@mail.gmail.com>
 <ZYLaayENrvL1Nh6H@rigel>
 <CAMRc=MfyCBpZ07SYfxMtug6FVYiKA0MRgvjMTOAzKiVLGdPM+w@mail.gmail.com>
 <ZYLczeiVDjd2cWQF@rigel>
 <CAMRc=MeXa5g6iQNYF4W+vGL+kgRTyVjFB-yXE_UBpuTnn2ZKng@mail.gmail.com>
 <ZYLjuqxXylKPYeYP@rigel>
 <CAMRc=McNMLmiUsGj8HmCqiwv-9K6EbMrmHpHMaMeFHx9BFX8gQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McNMLmiUsGj8HmCqiwv-9K6EbMrmHpHMaMeFHx9BFX8gQ@mail.gmail.com>

On Wed, Dec 20, 2023 at 02:19:37PM +0100, Bartosz Golaszewski wrote:
> On Wed, Dec 20, 2023 at 1:53 PM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > On Wed, Dec 20, 2023 at 01:30:57PM +0100, Bartosz Golaszewski wrote:
> > > On Wed, Dec 20, 2023 at 1:23 PM Kent Gibson <warthog618@gmail.com> wrote:
> > > >
> > > > >
> > > >
> > > > It would be read and write guards for the gpio_device.
> > > > cdev would only be using the read flavour.
> > > > And possibly named something other than read/write as the purpose is to
> > > > prevent (read) or allow (write) object removal.
> > > >
> > > > I though that would be clearer than having to reference gpiolib.h to see
> > > > what gdev->sem covers, and allow you to change the locking
> > > > mechanism later and not have to update cdev.
> > > >
> > >
> > > I still prefer open-coded guards here for clarity. I hope that with
> > > SRCU in gpiolib.c, we'll get rid of locking in cdev entirely anyway.
> > >
> >
> > Ok, it is your object so I should use it the way you want it used.
> >
> > Btw, before I go pushing out a v2, do you have an answer on whether
> > gpio_ioctl() requires a guard, as mentioned in the cover letter?
> > Is the fact there is an active ioctl on the chardev sufficient in
> > itself to keep the gpio_device alive?
> >
>
> AFAICT: no. I think it's a bug (good catch!).

The wrappers made that harder to pick up.
It kind of stood out as the exception after changing the other ioctls
over to guards - where was the guard for that one?

> Can you extend your
> series with a backportable bugfix that would come first?
>

Sure.  That would still use the guard(rwsem_read)?
I mean you don't to go adding a wrapper for the fix, just to
subsequently remove it, right?

Cheers,
Kent.

