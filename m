Return-Path: <linux-kernel+bounces-10205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0755681D12D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D915B25E24
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A29A5A;
	Sat, 23 Dec 2023 02:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7Pct699"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB81A7EE;
	Sat, 23 Dec 2023 02:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3ba52d0f9feso1833441b6e.0;
        Fri, 22 Dec 2023 18:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703297300; x=1703902100; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tSEYNsw40lOGpE/LYtf6GTFnHQe8PBqBKGpVOYnVyS4=;
        b=B7Pct699pdAr7WlFpqCDCbE1OOHVIkhxP2dJvtvz6EEAH4WZ1ChUFhrZVIjSNIZUYj
         3N1F18EYApDINpEsJ/BnamoqQHecW023vi3hnRuVCs4bcc4BRVqWTCDqqUhYSHZmDO9j
         mYQd1O/ViAnh83QoU23l44takbWnMbidUTmFZlJyHsQ7vO7gK3nru0jzulfqzBr5hqje
         wO9TZluZoWOQR7DjuaAJacIfMMtCsYweyVSXXjq0EV3OL1sUeVpz3X8HQpjwcylvI0Wr
         e2Y/80/M6OPqugFP887hREuk3dbBdbR2zrRSG/ocdAFTlMxLfMzrtmGnRR83rhDNEiO7
         LPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703297300; x=1703902100;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tSEYNsw40lOGpE/LYtf6GTFnHQe8PBqBKGpVOYnVyS4=;
        b=wurdV6CIJt45UzyM503pRSg/jP6Z7MczDzhVG4CGKi8dwArLs52dxD0TNWDaBq2zGt
         dvy1ip8/7IIz91G7CqgKmy9X1iqPUEdEMtbIaQoynxCkAPyMuA6/aJ1UgLA0O75dIU3o
         6IFmT9K/cVZhL2CmDux7kuWnkjO3EMR+cPDGfYcL56nOEC536QfNPZIkOyBGDt121Ows
         aWfWU3jNCeHaSq5cbR2vFkBC9F/9DAECyEs7x/gXA3tKDQk5WF5C9e8yWRW7ZYscwqi0
         msNF66IyxeAJd9O5XlHOK/0bo7Mc0GnWXbNGpDmuhHZy/0edROyqEfGuCyaDrWpRCR+7
         X6UA==
X-Gm-Message-State: AOJu0Yxyo2O2aVe5NvoOHaDpL/Ax9wmeUf1zKeDr9uPiR7UzY/f2lSRJ
	uVb2Lc1BhHVdlJkMcTEf4Ms=
X-Google-Smtp-Source: AGHT+IFcdLvURlqt+oAULebiS4ad/zZFRyZVDbtfx7RaCF3nPaS3U35twxlL4qbs+pR5gO4ujSi4gg==
X-Received: by 2002:a05:6808:2f09:b0:3bb:9815:7cb2 with SMTP id gu9-20020a0568082f0900b003bb98157cb2mr246303oib.114.1703297299897;
        Fri, 22 Dec 2023 18:08:19 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id hy3-20020a056a006a0300b006d5405e62basm4036860pfb.134.2023.12.22.18.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 18:08:19 -0800 (PST)
Date: Sat, 23 Dec 2023 10:08:14 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] gpiolib: cdev: Split line_get_debounce_period()
 and use
Message-ID: <ZYZBDu1HjtU23fnB@rigel>
References: <20231221175527.2814506-1-andriy.shevchenko@linux.intel.com>
 <ZYTihbWMcHMHSkC_@rigel>
 <ZYWDij-J1YruTIM7@smile.fi.intel.com>
 <ZYWHjq_7PnwO27ro@rigel>
 <CAMRc=McPzQyR1J5Mhn7_cBrWEcqz2JKg7t8CpjHx6jgVEnYBvA@mail.gmail.com>
 <ZYWYZ6Ys3hSb4IOe@rigel>
 <CACMJSeu-bS+MpP8HCcD74w0j6vFt821bpgth5LHpqq-fHnEe1w@mail.gmail.com>
 <ZYWZ4yhqzTF8rShe@rigel>
 <CACRpkdZrnOJ-Sjj4VpuVU0Gvzca_uGN9Um5Zj=bRMH2df4kRZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZrnOJ-Sjj4VpuVU0Gvzca_uGN9Um5Zj=bRMH2df4kRZw@mail.gmail.com>

On Fri, Dec 22, 2023 at 06:49:03PM +0100, Linus Walleij wrote:
> On Fri, Dec 22, 2023 at 3:15 PM Kent Gibson <warthog618@gmail.com> wrote:
> > On Fri, Dec 22, 2023 at 03:09:54PM +0100, Bartosz Golaszewski wrote:
>
> > > I can still split the uAPI files into their own section, make Linus
> > > and myself maintainers and make you a reviewer, how about that?
> >
> > That is closer to the reality, so that would work for me.
>
> Hmm I think of Kent as one of the main architects for UAPI v2
> so I would like you as maintainer, and me to be dropped, I already
> responded to that patch though.
>

There is no escaping that my fingerprints are all over that so it does
make sense to list me over you. Given that patch and git-tree management
will be deferred to the GPIO subsystem/Bart, there isn't much distinction
between a reviewer and a maintainer, so I'm ok with being listed as a
maintainer - I'll just have to pay a bit more attention to the list mails
than I have been.

Cheers,
Kent.

