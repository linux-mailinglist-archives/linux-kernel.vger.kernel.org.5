Return-Path: <linux-kernel+bounces-600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B416814367
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410D21F24154
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE2D11723;
	Fri, 15 Dec 2023 08:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FljYaz6q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D0116426;
	Fri, 15 Dec 2023 08:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5cd68a0de49so126684a12.2;
        Fri, 15 Dec 2023 00:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702628108; x=1703232908; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JcxN+Wuh89KaOginueUIn7+/Z6eQmxDiVvsbQXwd9Y4=;
        b=FljYaz6q2DKIK7p/tVNtPi0xWS18+wZEAa7lhY7UIV7dySqbYsd48MZobrB+5BPYRa
         aq+zWST/yXqj11Z5huKrMdtpdBnldOLZxBLpD4tQ3cB3cX0PAQdfF4Rw9iPcyOVtqrCy
         8PG3UbEfIpOm1baVoJJOblybvRwFpJdJQbdoGUfwOelc2MV1pXi7AqmzV2B6Wz+CYvWl
         95t2qhAUx4oTP0k1mXN3wvhxXbPmyGMGB959v2x139A7nEtEpvwBcGyHcY1glHcd+wjT
         kGoooBEY6j9HO5BIkX0457rEqPSzyneOgqm9i4H/sR4ncOSjSTttnnL/7Tf7I/ickfvy
         HFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702628108; x=1703232908;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JcxN+Wuh89KaOginueUIn7+/Z6eQmxDiVvsbQXwd9Y4=;
        b=kP9cnn1qcTR+2q21jZ/9U6DjsuApjEOUQF/gcen0jmjDgVMTNAUYxf/lBNVVd/8eQs
         KWEJyyXCZkbRiVnNmUFjW05RJyk14uPmIdeq+L2JiaaBjzmohNEKHLmbqOM4Vauac87d
         omDb/yFzAheW0SyUs7hk5jvLKTWN6nr9QCFlGDVNjjgDI0gigdPh+hlHLGSnMsCV0qwq
         /ugNebMEiD+kpnaH5CtSaNC5u/+R6PLDR/vr0heeK48qUQ1R+o+uuCYAWxnBmuczHQVa
         dVW1FOvt+a3OQWrTE0A+n9OKaEraw1uUmYr8NZk2aIw5tWL2vdAgs275WAe1yb1YCxcO
         Vc8w==
X-Gm-Message-State: AOJu0YwuMicQeHdvFjpEMB8s+eSL2lpCJuVrZf38YIpoFORGPeG+ErD5
	5cXTsTu1g2oxua+G1J/5lcs=
X-Google-Smtp-Source: AGHT+IFPbo03p11R9HSwkGlgrEsUnaQ260L8Ce74R2enlMWQnm7k194d77ePo5sCV50PL0+r/qoBcQ==
X-Received: by 2002:a05:6a20:9693:b0:18f:bf91:2938 with SMTP id hp19-20020a056a20969300b0018fbf912938mr10399039pzc.125.1702628107669;
        Fri, 15 Dec 2023 00:15:07 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id g13-20020aa79dcd000000b006d26eed29a8sm1307579pfq.95.2023.12.15.00.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 00:15:07 -0800 (PST)
Date: Fri, 15 Dec 2023 16:15:03 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linus.walleij@linaro.org
Subject: Re: [PATCH v2 2/5] gpiolib: cdev: relocate debounce_period_us from
 struct gpio_desc
Message-ID: <ZXwLB2BW4gtZjlQ5@rigel>
References: <20231214095814.132400-1-warthog618@gmail.com>
 <20231214095814.132400-3-warthog618@gmail.com>
 <ZXsZJ9z7iln8uMf8@smile.fi.intel.com>
 <ZXsajZoQRw7HgHl1@smile.fi.intel.com>
 <ZXsp8QjxsUMPlZIR@rigel>
 <ZXswRCsT0OYwHe3N@smile.fi.intel.com>
 <CAMRc=Md55pSWwbKqxO-eHJyn1+vtLMuWmD0d1_iqFT4h7dJ4Yg@mail.gmail.com>
 <ZXumIX39JRpbYrbw@rigel>
 <CAMRc=MfRs79kkXLV5KiH7ehDYq4BRR=eTNh+WNcCvsu8mg_J+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfRs79kkXLV5KiH7ehDYq4BRR=eTNh+WNcCvsu8mg_J+Q@mail.gmail.com>

On Fri, Dec 15, 2023 at 09:07:48AM +0100, Bartosz Golaszewski wrote:
> On Fri, Dec 15, 2023 at 2:04 AM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > On Thu, Dec 14, 2023 at 10:06:14PM +0100, Bartosz Golaszewski wrote:
> > > On Thu, Dec 14, 2023 at 5:41 PM Andy Shevchenko <andy@kernel.org> wrote:
> > > >
> > > > On Fri, Dec 15, 2023 at 12:14:41AM +0800, Kent Gibson wrote:
> > > > > On Thu, Dec 14, 2023 at 05:09:01PM +0200, Andy Shevchenko wrote:
> > > > > > On Thu, Dec 14, 2023 at 05:03:03PM +0200, Andy Shevchenko wrote:
> > > > > > > On Thu, Dec 14, 2023 at 05:58:11PM +0800, Kent Gibson wrote:
> > > >
> > > > ...
> > > >
> > > > > > > > +static void supinfo_init(void)
> > > > > > > > +{
> > > > > > > > +       supinfo.tree = RB_ROOT;
> > > > > > > > +       spin_lock_init(&supinfo.lock);
> > > > > > > > +}
> > > > > > >
> > > > > > > Can it be done statically?
> > > > > > >
> > > > > > > supinfo = {
> > > > > > >   .tree = RB_ROOT,
> > > > > > >   .lock = __SPIN_LOCK_UNLOCKED(supinfo.lock),
> > >
> > > Double underscore typically means it's private and shouldn't be used.
> > >
> >
> > You mean like __assign_bit(), __set_bit(), __clear_bit() and __free() -
> > all used in gpiolib.c?
> >
>
> Touché. But this is just lack of strict naming conventions. :( Another
> common use of leading underscores are "unlocked" (or in this case:
> non-atomic) variants of functions.
>

Sorry, should've added a ;-) to the end of that one - not giving you a
hard time, just found it amusing.

> > > > > >
> > > > > > I even checked the current tree, we have 32 users of this pattern in drivers/.
> > > > >
>
> As opposed to ~1200 uses of DEFINE_SPINLOCK if you really want to go there. :)
>

To be clear, that is Andy's quote you are replying to :-).

> > > > > Ah, that is what you meant.  Yeah sure can - the supinfo_init() is
> > > > > another hangover from when I was trying to create the supinfo per chip,
> > > > > but now it is a global a static initialiser makes sense.
> > > >
> > > > Yep, the DEFINE_MUTEX() / DEFINE_SPINLOCK() / etc looks better naturally
> > > > than above.
> > >
> > > Yeah, so maybe we should use non-struct, global variables after all.
> > >
> >
> > Despite the 32 cases cited that already use that pattern?
> > 9 of which use __SPIN_LOCK_UNLOCKED().
> > Sounds like a pretty convincing argument to use the struct ;-).
> >
> > But lets keep it as kosher as possible and split out the struct :-(.
> >
>
> I'll leave it for you to decide, I don't have a strong opinion and the
> entire file is your code so you should pick.
>

I've split it out in v3.

Cheers,
Kent.

