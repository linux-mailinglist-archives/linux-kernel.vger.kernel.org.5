Return-Path: <linux-kernel+bounces-21374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D25828E52
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65A6A1F24A53
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C80C3D57B;
	Tue,  9 Jan 2024 20:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hw51Pz6r"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BC63D551;
	Tue,  9 Jan 2024 20:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-67f95d69115so25189636d6.1;
        Tue, 09 Jan 2024 12:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704830463; x=1705435263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXac4/81ga5dfpeZFySVL6do3EP7yaaUkmtReOLudXU=;
        b=hw51Pz6rh0nYoJPLm4oAtPs2+w19h8L1LzNRvtrUS0UJ09HlI8FTIb+aakM4JxP1lu
         UqQNN1uQanHSDns+XjN2AOaouA5RyRxW2FLlw5c+Hg3S7vynq7ZhVYzGMkpXl8i0slYb
         oCzLhJreaC4PQ4vpopom9wiBU1XPRmxo7nCPoNUaxZ6ra18fRHt6P2R/TZUhH1/qYxTV
         dsYHEJq1lr0l972+YYnFgBWMVMPOFbRqHngE0UzABHtT5OIyxqEUPypRpXZ+dPv7QJO0
         l0gN2arzTW01CvDkpMGmMSFr9CJ03UR2e0f7T/toRUfCO0O1h0V80LD75eTKeg8UoJN3
         gB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704830463; x=1705435263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kXac4/81ga5dfpeZFySVL6do3EP7yaaUkmtReOLudXU=;
        b=hF7nqGa9VgdXgWY09sy3YUXj1uEwx0UGyb6xWokLtxSAEYwRtjw5eRz0TV2wekxG2c
         6WhfU7BvFLK36RcXd3Dz2EdgOtHC5RropxPlmKdtsficRdZqMHNh31cCULfr17qy8IDk
         6F5P8tfH4f14oEJ/t1oGNHDCxgTGU7cCDL0ePYQYuior6bRjOquWAugiG8XlUyHsWwtv
         ijeM5GJzRRJTEKcdnSTskHEUC0RCuFb8BJzNQds5Gt2yfhoFqS55xti+qUqeAWqNvxbN
         NvcPbLCUpae6m/CC17JR1VnZE5sHUFvkYK+hDo4USCgvuw24oEI5bV9Uq22satsg68nv
         qfDA==
X-Gm-Message-State: AOJu0YzW05KMZdQXgzD9a9St/TEkkdJxd7hTIsbRWlcL3n80xXyGSe7o
	FaEDmR3Sg5iyDuvGojAN2YJj+1U/paLXZwrVgmE=
X-Google-Smtp-Source: AGHT+IEzXITr4/CoEu3IVJU+4WJtAV85gLT2EYcXcWdHlmubwIf3EZDf/6e6aVBfKpGtOvNjNtEQdDpPhlKUkECWt1s=
X-Received: by 2002:a05:6214:1304:b0:67f:4926:60c0 with SMTP id
 pn4-20020a056214130400b0067f492660c0mr39853qvb.1.1704830462923; Tue, 09 Jan
 2024 12:01:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109135952.77458-1-warthog618@gmail.com>
In-Reply-To: <20240109135952.77458-1-warthog618@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 9 Jan 2024 22:00:26 +0200
Message-ID: <CAHp75Ve05bAK-ehZZ7XSci5VqR18cCb=hgnbFKXwy2QPkxo=pw@mail.gmail.com>
Subject: Re: [PATCH 0/7] Documentation: gpio: add character device userspace
 API documentation
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-doc@vger.kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org, 
	andy@kernel.org, corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 4:00=E2=80=AFPM Kent Gibson <warthog618@gmail.com> w=
rote:
>
> My new year's resolution was to improve the documentation of the
> character device API and gpio in general, so here we are.
>
> Wrt the formatting and file breakdown, I've taken inspiration from
> the userspace-api/media documentation.
>
> Patch 1 adds documentation for the current chardev uAPI. I've added
> it to the userspace-api book, as that is the most obvious place a
> reader would look for it, but have also provided links from the
> admin-guide book where the gpio docs currently reside.
>
> I realise MAINTAINERS should be updated with
> Documentation/userspace-api/gpio/, but the split out of GPIO UAPI
> hasn't made it into gpio/for-next yet, so I was unsure of how to
> handle that.
>
> Patch 2 relocates the sysfs API doc to stress its deprecation by
> moving it to a new deprecated section, again in userspace-api but
> with a similar section in the admin-guide. The deprecated section
> also provides a placeholder for subsequent changes.
>
> Patch 3 updates the sysfs API doc to reference the chardev
> documentation rather than gpio.h.
>
> Patch 4 adds documentation for the deprecated v1 version of the
> chardev uAPI.  It is deprecated, but still useful to have, if
> nothing else to help identify the differences between v1 and v2.
>
> Patch 5 capitalizes the title of the admin-guide/gpio to match
> the other subsystems and the userspace-api book.
>
> Patch 6 adds a deprecation note to the gpio-mockup, as it is
> obsoleted by the gpio-sim.
>
> Patch 7 moves the gpio-mockup doc into the deprecated section.
>
> I've got some minor updates for the kernel doc in gpio.h as well,
> but they make sense on their own so I'll send those separately
> keep the cross-posting to a minimum.
>
> I realise the only thing less exciting than writing documentation
> is reviewing it, so my apologies and thanks in advance if you
> have the fortitude to attempt such a scintillating endeavour.

Thanks a lot for doing this!

..

>  Documentation/userspace-api/gpio/chardev.rst  | 114 ++++++++++++++++
>  .../userspace-api/gpio/chardev_v1.rst         | 129 ++++++++++++++++++

Shouldn't it be better to have chardev_v2.rst along with chardev.rst
to be a link to it?

..

May we actually state in the documentation that sysfs is subject to
remove at some point?

--=20
With Best Regards,
Andy Shevchenko

