Return-Path: <linux-kernel+bounces-111400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6455C886BD2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E1B8286907
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563CC3FBBD;
	Fri, 22 Mar 2024 12:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBNRKgCx"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242663FB3B;
	Fri, 22 Mar 2024 12:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711109079; cv=none; b=VbjWFUQKtIJThV6Yqmn3xXQ/KQ6lzs6Opf7fePt57VrCiUM6pXr3jp7FWTMvChYzM9I1pCXm1dGAGIPDziZM8Nr87lmvtdVj2mOGChVYSqpvDLtNMpt8sUmeh/Szn7ChdbFERkniHAZQEh65R7u0BdZiQDwTyRzeZyMzCfVxoEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711109079; c=relaxed/simple;
	bh=1TCuJ3w/BDoNx9LM4VjC1x6y9/x9YsRVN+lNH7V+/4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImodAIx/LwW7QVVHXSdEhvmzw9MqAKkM753XWreDZetdwjJaaygrr8mSggD6SqTbJJKrQ8IHb+8EWOlbmLXYFnLqQT0Joa78gIm2rxBWG4/z+4hMkzFMtf9LYlNNtNk1I1wqWFJed+cbbj4r8ncFQWbTq1aa+W8P4w4k2Vnj5SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBNRKgCx; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78a16114b69so189897285a.0;
        Fri, 22 Mar 2024 05:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711109077; x=1711713877; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ln7qEJHKHqLJtKwDgDsUNcpQ9J+dt/V2pERnhD5tvGE=;
        b=HBNRKgCx4sI0FDpZa6DDhHuonrpM4TshSWAQzyqKTaGUyaalfoYDIg04G3XQK1adIH
         LivBg9xcRzbVHAR2axHAnW0rQGr+qdwnJlu+byLtABvbxvZjY3d3VFpmBke9dj31Ytwv
         XEtMYz9yKevlJjRKPGzJrBePZv8DBeUUV/by27h3USBvSqmHz5hkgwl0UZTqlrFTYzNz
         6S6wK8qJbkxkvpUvKkzFbTo3XuK0OW5j9rxm3LV5L4FVUxBhG9HR3tJPQnrhRuXSqq1f
         5DjWm89TUi7CVLcCEq+Kf+rhfXV1kTYP0/t9aAn2qLvvZElhECFhu8rM2KSFSfbBiE7p
         ADCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711109077; x=1711713877;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ln7qEJHKHqLJtKwDgDsUNcpQ9J+dt/V2pERnhD5tvGE=;
        b=TnKissL0GNxpuEnPECTjVWDgHk6sSHC4KCmSBTYZ7Yh1w6nS0JWNHF8aGbwoOXkvqI
         /dkDMZ/Ni9ufYJUD0c+IdHNC/rbhhqDqAkIN41/33DX90aK0Sfg5TNWCPdWltSSeCT33
         YWKCHnYYMRD3Rbte8kW2ooDMTWxwrNY+zST79R7EeDx0t8kaLThG5uGF6PFjHa7Wa/Yj
         8cU4s8Sihsz77ooUBOOaPXnZlvjy++ZXw0bGOnFQTgcYYjC6OALDjEvFfIEc3x/cRzw8
         WQfdIWCC7O/SqiukzhKrJmQVt2bU9NXt74dodnASSrRbun7oQnxrWnYQe+XLhOp2gaGB
         4Beg==
X-Forwarded-Encrypted: i=1; AJvYcCU95zy8quaPItBTx2zyPolzXYcA2Is4t5gA+M7qvX0qygIG/StHKewp84Kpd6AdNvJlLlxV5fFJgWKjOou2EWsK8GmJyilVzDKPD3s7UzRNV888vexIMpmDEIc1Pq6SMF2Q3kBNblSvLJ7eintNZ16WY7mcJV33J+n4x58BeVCVlQ==
X-Gm-Message-State: AOJu0Yy6mmpVLik1cOR+X2g6P8m7dG5Dfnbtmsh+bwcNQb5Wm0RkDSxX
	bW3ofRTrqGvsnEByHHIDGc4S7FypZBK1tQQztIuzi42dV3lB2jn1xa9PKsDF
X-Google-Smtp-Source: AGHT+IHPq9y1yWNwFckZtC2dMim5x0Ex/mkhoSW8lHHUcQGNGa9lvNioyg2f6h3Uo27AvTL0k0LFLA==
X-Received: by 2002:a05:6a20:728f:b0:1a3:ae18:f5f2 with SMTP id o15-20020a056a20728f00b001a3ae18f5f2mr159722pzk.15.1711108680244;
        Fri, 22 Mar 2024 04:58:00 -0700 (PDT)
Received: from rigel (110-175-159-48.tpgi.com.au. [110.175.159.48])
        by smtp.gmail.com with ESMTPSA id t68-20020a625f47000000b006e592a2d073sm1525393pfb.161.2024.03.22.04.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 04:57:59 -0700 (PDT)
Date: Fri, 22 Mar 2024 19:57:54 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
	stable@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2] gpio: cdev: sanitize the label before requesting the
 interrupt
Message-ID: <20240322115754.GA45839@rigel>
References: <20240322090209.13384-1-brgl@bgdev.pl>
 <20240322111835.GA24228@rigel>
 <CAMRc=Md87eGmjehSEegdFCdv6D3H1p2On153JowY5cDnW9iw8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Md87eGmjehSEegdFCdv6D3H1p2On153JowY5cDnW9iw8Q@mail.gmail.com>

On Fri, Mar 22, 2024 at 12:52:29PM +0100, Bartosz Golaszewski wrote:
> On Fri, Mar 22, 2024 at 12:18 PM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > On Fri, Mar 22, 2024 at 10:02:08AM +0100, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > @@ -2198,12 +2216,18 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
> > >       if (ret)
> > >               goto out_free_le;
> > >
> > > +     label = make_irq_label(le->label);
> > > +     if (!label) {
> > > +             ret = -ENOMEM;
> > > +             goto out_free_le;
> > > +     }
> > > +
> > >       /* Request a thread to read the events */
> > >       ret = request_threaded_irq(irq,
> > >                                  lineevent_irq_handler,
> > >                                  lineevent_irq_thread,
> > >                                  irqflags,
> > > -                                le->label,
> > > +                                label,
> > >                                  le);
> > >       if (ret)
> > >               goto out_free_le;
> >
> > Leaks label if the request_threaded_irq() fails.
> >
>
> Ah, dammit, I didn't catch the fact that irq_free() will not return
> the label address if the request failed.
>

You caught it in edge_detector_setup() - you call free_irq_label() if
request_threaded_irq() fails there.

> Nice catch.

The give away here is that the goto targets are the same.
Bit irritated that I didn't catch it earlier - got distracted by the
return code problem.

Anyway, third time lucky.

Cheers,
Kent.

