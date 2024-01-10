Return-Path: <linux-kernel+bounces-22662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A91882A112
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331ED1F23930
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248C24E1C7;
	Wed, 10 Jan 2024 19:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g2Snaozr"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13674CDEA
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 19:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a26f73732c5so531652566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 11:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704915325; x=1705520125; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+3BG0JIg7yk9nZ+DP+/QndM8kV/y23DKzFYLlCIV16M=;
        b=g2Snaozrwei/liTalFyeRJSV0ep9NbCasLsbys1Y0OrCEkxnX5CaHG6RruD8TOSh0k
         TbQva5FH8O19fUmRc9Ehr1flzr6knoxd5fwhD63YUfvOF55XVB/EfUZrtiuVlt2mWP//
         J/zJDt1Y+mEqKYD+gVLIyozqtGWgOwg2h0EjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704915325; x=1705520125;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+3BG0JIg7yk9nZ+DP+/QndM8kV/y23DKzFYLlCIV16M=;
        b=JBM+fstmGAlnqo3OdIB1cWEXSlEgn+LwllxBI6/JJ0nfCK3VLGcZPFOwWaAGkyPLtm
         jtOXaJNwD1mRNLj3vbLKK6McEZG7Zu1WkO2fdxfiIBtzu/TKL/YtEuKVeOdE1c17y9TG
         rLAnlmopcmoSiMjAHrjBJQffPifxk2dgF+p2IFCr5zX8p6tBT4+6RBzCqjoxE8hu4yOa
         iz2+VQiSEFuxy5iqMnhlrF+2QDXY8XhjXuctweJoYY4hvZba0MwFf6xd3yFtfWkqrW1J
         5yFrFr1Y6u235d+OChO/RRM5CMSIm0xGQxQHYskA47bR0B7R5bjFS7AX+FmoFxYBDrqV
         z9vg==
X-Gm-Message-State: AOJu0YzsBLDMBDmkybPN5ti/TLuB3uWR23DIo8aXi0uURw/SI68fij5p
	7tdtQFgdx/u/6t8fA1DPBSR2+1+1cX6zTHlo25KU5bixykcTmvtd
X-Google-Smtp-Source: AGHT+IHvmwgE11XYoDzX5EueRJ6tvMbU2AvhT7EwHHmQu4oY0cqV60I3Dpr5wc8PyM+D7jHfMyYM+Q==
X-Received: by 2002:a17:906:7f97:b0:a28:ce1f:6995 with SMTP id f23-20020a1709067f9700b00a28ce1f6995mr11659ejr.36.1704915324856;
        Wed, 10 Jan 2024 11:35:24 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id t11-20020a1709060c4b00b00a1df4387f16sm2402061ejf.95.2024.01.10.11.35.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 11:35:23 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a2c179aa5c4so62570766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 11:35:23 -0800 (PST)
X-Received: by 2002:a17:906:6989:b0:a28:b170:4863 with SMTP id
 i9-20020a170906698900b00a28b1704863mr13045ejr.55.1704915323262; Wed, 10 Jan
 2024 11:35:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com>
 <18c6df0d-45ed-450c-9eda-95160a2bbb8e@gmail.com> <CAHk-=wjvM5KiQFpbPMPXH-DcvheNcPGj+ThNEJVm+QL6n05A8A@mail.gmail.com>
 <CAHk-=wjE1eLMtkKqTt0XqNSnKAeDagV=WQU+vxHL_wsLuO8Gag@mail.gmail.com>
 <CAHk-=whkGHOmpM_1kNgzX1UDAs10+UuALcpeEWN29EE0m-my=w@mail.gmail.com> <20240110171739.2e2d9de0@canb.auug.org.au>
In-Reply-To: <20240110171739.2e2d9de0@canb.auug.org.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Jan 2024 11:35:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj1uqgU7hS=WqDSwEvc6=CwuWYBUmjSJAT6zx86CF=QBQ@mail.gmail.com>
Message-ID: <CAHk-=wj1uqgU7hS=WqDSwEvc6=CwuWYBUmjSJAT6zx86CF=QBQ@mail.gmail.com>
Subject: Re: [PATCH next v4 0/5] minmax: Relax type checks in min() and max().
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jiri Slaby <jirislaby@gmail.com>, David Laight <David.Laight@aculab.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Christoph Hellwig <hch@infradead.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jan 2024 at 22:17, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> > Can somebody else confirm similar time differences? Or is it just me?
>
> I was hopeful, but:

Yeah, my build times seem to be very unstable for some reason, and
seem to fluctuate fairly widely. I'm not sure what triggers it.

The min/max simplification helps, but I think my "big change" thing
was mostly due to other fluctuations.

It would be lovely to have some performance automation to find build
time regressions, although at least for me, one source of regressions
tends to be system updates with new compilers ;(

            Linus

