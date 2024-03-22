Return-Path: <linux-kernel+bounces-111386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5025886BA5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0441F24AD2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA0A3F8F7;
	Fri, 22 Mar 2024 11:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6EiJl7m"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DA23FB07;
	Fri, 22 Mar 2024 11:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711108467; cv=none; b=LgqTqq0Xd9Isdn4i93Dh8ph4Pv8/VTh/kMJiDTvC8ewF2uriUdTTJhuf2sTGtXOY4nJ8MERAY+pVVkishwiDgTyz1yqz1uTps+A11Rcg2SDPtre/TRI6lI16NF49kLRDJfZOVSW6a1jzfd2yDQ0FTp6UlhyGD1w2Tfvw+9tCEtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711108467; c=relaxed/simple;
	bh=cl4xjErbVI23OC6w9YYx1Y9I9UVaJ3wKtPzhlKhvlaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oexyyT2SBsKwfSvwAn/ELFjAEJ9vyAfxoGlq1T2iIzF2oI1M8t42selBr0mhCj1zrG0ccs83EttUMJWru4HXnUsObugwSfHsDDf75dsEwStqBHK0aPyNqRnlA+dPqf7RA4xaQY/ABEGmLq99K0MlH7Z4m6puqYhdeJhROM0gtYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6EiJl7m; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dca3951ad9so12803295ad.3;
        Fri, 22 Mar 2024 04:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711108465; x=1711713265; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sugrI04a69D7TsptgUFH0TrJAHa5oTy/e7UovPooNCg=;
        b=c6EiJl7mU+JkDh6n3wQSIJxcydAMhQ6+uHiYZjR2iUsyXYFSIjemFxd0awfuGmNgKn
         XHwpDdwmrY2hshxMqvnbNrfoyDHBvzD26Ss2qmIsPcmMCBD2210pb2JE4SZHwG7Xjhdw
         nyLFwUe+m3PCz9RCm0ad1FBCi/MF2UOgx2lMtCaIMoMW9pQmIa31//V+/aRQQzKPFhyJ
         bwYDIvvkQYB8o//7AHGkq02NZd52zeHs4NF6DbyzmcyJ4BRv1F2G1xvMZDr1wBbPIHhQ
         3Nl+T8rAILy9OSG5C+0COGpuPSuwnYnXqtW9YuK0x5I/bekKNTYiGzxR0ejqBZoTvIHD
         sVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711108465; x=1711713265;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sugrI04a69D7TsptgUFH0TrJAHa5oTy/e7UovPooNCg=;
        b=nkbEjUhstLZHwgut3ZIA0gy5mbtCO4rMB+1KKh9WyMxXBvWHDT5rJWs6FC8yueGWzj
         1xCq/nsfzFAKzVdBKZwJaP+nB/KWUL3nP1l7f3Y3qT4q1UYmLEvsz+TunJZHKdDygbp3
         TqdduwMJonIqjfg5T6cQSqMk7XwKHShMFBNTJh7z5vZ3d3Nfc03JhMYgNnpSTh24np0r
         OrEARFmUenmiqRbKPasXytN0ZzOL+IWvV/slqqSBJSNLT9th/q23gXkhTK6YKQ4o1ScK
         6rfxm9N9uLKOzT6jvAMJ8k24zjFgW4sk2vfXgegOBXWeUy38TRczuPx29+ECzxe0ugpZ
         xKgw==
X-Forwarded-Encrypted: i=1; AJvYcCWYhAt66ZNSHq4uZGwH02Y546mIS5D74Yul6cRGraiuWe0dthhTN7rNrXNSbM44DKSMRucbrtLerE/mHf8+oJwCDfMO+gTkJVQXYq8xWr6CsQ7s96Z+nqITpPMQbRGZvHRn1NKwOP+F1sRjKpUCBg+qLufd8h44tOa9l6gsjpi7Eg==
X-Gm-Message-State: AOJu0YzbsrRkZdez14Cxnh9qWWL3inyYZUNnxMqeaiEePfH5cXB6u04P
	mN2dChIU/5PmuZHam0+NsqkNh4zDR8xdLpa91vdKBJK1v2U2aIQF
X-Google-Smtp-Source: AGHT+IHblRTDxClg0hncaI3YdLPYlc0ctt2Ultcay3fROynXSndppinQVCFztH0kEfmSc0kK5dykdA==
X-Received: by 2002:a17:902:f7d1:b0:1e0:18b1:d0a2 with SMTP id h17-20020a170902f7d100b001e018b1d0a2mr2184720plw.40.1711108464936;
        Fri, 22 Mar 2024 04:54:24 -0700 (PDT)
Received: from rigel (110-175-159-48.tpgi.com.au. [110.175.159.48])
        by smtp.gmail.com with ESMTPSA id l15-20020a170903244f00b001dd98195371sm1686451pls.181.2024.03.22.04.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 04:54:24 -0700 (PDT)
Date: Fri, 22 Mar 2024 19:54:19 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	stable@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH] gpio: cdev: sanitize the label before requesting the
 interrupt
Message-ID: <20240322115419.GA31273@rigel>
References: <20240320125945.16985-1-brgl@bgdev.pl>
 <20240322013034.GA4572@rigel>
 <CAMRc=MfQnZQU_t9-uDPp18vFikz_9eP6LtnWJYG0+KFgWjBcEg@mail.gmail.com>
 <f529d746-f8c5-466b-860b-e2bfaeb2cc27@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f529d746-f8c5-466b-860b-e2bfaeb2cc27@moroto.mountain>

On Fri, Mar 22, 2024 at 12:31:36PM +0300, Dan Carpenter wrote:
> On Fri, Mar 22, 2024 at 08:46:50AM +0100, Bartosz Golaszewski wrote:
> > On Fri, Mar 22, 2024 at 2:30 AM Kent Gibson <warthog618@gmail.com> wrote:
> > >
> > > On Wed, Mar 20, 2024 at 01:59:44PM +0100, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > Let's replace all "/" with "-".
> > > >
> > >
> > > I actually prefer the ":" you originally suggested, as it more clearly
> > > indicates a tier separation, whereas a hyphen is commonly used for
> > > multi-word names. And as the hyphen is more commonly used the sanitized
> > > name is more likely to conflict.
> > >
> >
> > Sounds good, will do.
> > > >
> > > > +     label = make_irq_label(le->label);
> > > > +     if (!label)
> > > > +             goto out_free_le;
> > > > +
> > >
> > > Need to set ret = -ENOMEM before the goto, else you will return 0.
> > >
> >
> > Eek, right, thanks.
>
> Smatch has a warning about this, btw.
> drivers/gpio/gpiolib-cdev.c:2221 lineevent_create() warn: missing error code 'ret'
>

And that triggered a "what the hell does that mean" warning in my
wetware error parser ;-).

That could be better worded - it isn't "missing", it hasn't been
appropriately set. So maybe "unset error code"?

> The other warning here is:
> drivers/gpio/gpiolib-cdev.c:2269 lineevent_create() warn: 'irq' from request_threaded_irq() not released on lines: 2258.
>

Looks like a false positive to me - as per the comment in the code, that path
(2258) results in lineevent_release() being called and that releases the irq.

Cheers,
Kent.

