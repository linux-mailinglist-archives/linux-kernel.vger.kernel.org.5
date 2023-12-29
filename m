Return-Path: <linux-kernel+bounces-13154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C97820074
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 17:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4465E1C218ED
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 16:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E53B125CB;
	Fri, 29 Dec 2023 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emNh5KyN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5419C125B5;
	Fri, 29 Dec 2023 16:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-67ff310622eso31876286d6.2;
        Fri, 29 Dec 2023 08:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703865848; x=1704470648; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rBveRZ/3Tcv6FNoUttsLq22QmNg6t9sbKYbxX1//L4o=;
        b=emNh5KyNyIdDFB4xjdHxGcH2w/dNzHUbALhdzwWQCD+4vucp+eIy1IQ/VizyslRXne
         /O1bkz129byrDSAd5PvJQWcFSOAqJ5eWnKPhv4OKdWDvqLGyb4DvWX2SNA2WmwO5+AOR
         ff++zBHZUXYnqb3dTV7OmHD+ldOWy0AeCWt2Tm3CcXqWY9ocYFOUp+F1RSEc4fROHaya
         Wa5vM6I/hCHkhByh+SH5bC3MCL+/7e9WmxzzjyFUTE4TAUuXAP9XKtMrh59Wm6rHVNAa
         sARI12S7U/S0VvKSODroOR69DtlriWUEP1U8wVrl3+JnSgPkPOj9AZwlju6nqnCcXeb2
         eH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703865848; x=1704470648;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBveRZ/3Tcv6FNoUttsLq22QmNg6t9sbKYbxX1//L4o=;
        b=WQp/6FRxQK2jfnn8HCs1tWO3wpgglziCL2kju/J/xWKo3fvybJ4THvymnoORxuLdwK
         mojgJYifqUOXsokrNbW8fpyYhPh4vRuoyFb8Q2rBi+nyRTAN/l38zziRiP0osXZyJVxo
         aj4DobdgJhtnwewkoH8BYyqkl7Kf4gXDmi7JdzUJdOx8qDNQ17XSyxY1/4th8qv+KI8n
         rKFQGpVrtIaJhvI8sVsabku3VYBqXmEGQi1AooVC6jGHtFU0bYxEAudQTw58Bf57xZIs
         nJAUXRCAjnmRtwH9jEWpT5ojZJ0Xn+sapFJ2H9+I2b7tSmBfZ5G0Uah4wlpOO4Gkd5li
         PzCA==
X-Gm-Message-State: AOJu0YySRoseD4nppuMEPQui8e4r4x7pRguKoNLB4KVtN4bPFxTn/dCy
	BENcmZho3xo4YaXD04xnHwuWTRjZOCG1mB+vu6kCPlub
X-Google-Smtp-Source: AGHT+IFsmPXpWRntlcHD5aTn501AgexpjZ1aoCpxXhmZdPkKM+2b5xYsj5JUKespTJ2IT1jUhv7YavuNkRCE4IiBrrs=
X-Received: by 2002:a05:6214:20e5:b0:67e:f56c:b6c0 with SMTP id
 5-20020a05621420e500b0067ef56cb6c0mr22707379qvk.60.1703865847746; Fri, 29 Dec
 2023 08:04:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK2bqVKCdaD6-PZi6gXhf=9CiKGhxQM_UHyKV_onzDPnhbAmvw@mail.gmail.com>
 <ZY7omD5OBLUg6pyx@duo.ucw.cz>
In-Reply-To: <ZY7omD5OBLUg6pyx@duo.ucw.cz>
From: Chris Rankin <rankincj@gmail.com>
Date: Fri, 29 Dec 2023 16:03:56 +0000
Message-ID: <CAK2bqVLBZvU2fVfY4bkFrU=4X+W4O3f5pbTdeQjMW=W2sGWpeQ@mail.gmail.com>
Subject: Re: Does Linux still support UP?
To: Pavel Machek <pavel@ucw.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I have already attached as much information as I am *ever* likely to
be able to extract about this problem to the Bugzilla ticket.

Cheers,
Chris

On Fri, 29 Dec 2023 at 15:41, Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > I have an ancient i586 UP machine that happily runs vanilla Linux
> > 6.4.16, but which locks up shortly after booting vanilla 6.5.0. The
> > kernel *seems* to run into trouble as soon as the networking layer
> > becomes busy. However, its SysRq-S/U/B sequence still seems to work as
> > expected and so obviously *something* is still responding somewhere.
> >
> > This problem still exists in vanilla 6.6.8.
> >
> > FWIW I have raised this bug in bugzilla:
> > https://bugzilla.kernel.org/show_bug.cgi?id=218296
>
> Yes, UP should still work. I'm using such machine and intend to
> continue with that. But it seems more testing would be welcome.
>
> And yes, you'll likely need to bisect.
>
> Best regards,
>                                                                 Pavel
>
> --
> People of Russia, stop Putin before his war on Ukraine escalates.

