Return-Path: <linux-kernel+bounces-72814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CA085B8F2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 596E4283CBF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAD5612CA;
	Tue, 20 Feb 2024 10:23:33 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303CA60ED2;
	Tue, 20 Feb 2024 10:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708424613; cv=none; b=a62xCIvRqBPOPacboigiNac9Q3Auw76qHL/Y3pp2cwuJviZgtCkc155M0TjFbEgvI7tVn8ckMXOeKR8rwghlDzH1B4u/yK0FXZmHeM+0bMAVx4YS5KM4XzGLcP6utUQeMxn4OI/LOq8DW0obe2IPwVeJsSuXiO1BkTZEdx93j9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708424613; c=relaxed/simple;
	bh=mLt4xmejzlrsSSdRTa1yS9wn+ZVm8cOBAXhmP0gRgxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nKcRq9dN+pwtx+i1/jDVn97FUNEggL/+ZMrv0tAqgxeghgdq+2QyOryo400NW0SNd5TJZwdQUbY18360ZnmwU+hTzyrOtBgZ4AlLGFwKLZy3R7MzAd4DvJGpKmmApkzesRuhKZVcvl2os4IL697seMZQS7N9SaZ9B6cuXgAhU/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-603fd31f5c2so52743127b3.0;
        Tue, 20 Feb 2024 02:23:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708424609; x=1709029409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12Kyp8aB3rpgIdqlByHzUCQrNKWenvMCDuD+CWYwf7E=;
        b=ErrwAcfSwPedBNUHJVGu3hzP3G6tpDriLPnHaM+cfoUJPJG6u90d6vy/GJxNw00S2+
         +v3UojF/1PBzdsLoT1z1FNufj9UOsB3/qKt5YPOM+z8fEEOMwPxEQ3KpvkIk7cPvGWFV
         R+MsdpJ1vQwebP2VJEeWLBIfI0wvmnOMyIdFTZmlN0nImFDNVzDGmza35Pl/pvu6idf2
         iroPLopv1i780m2GCSF52TIPzmR3uzdOnj/c4WOGMe3fxujjWP+Oyz6Os8Ao5TUjS090
         v8wEQqjfOTQLiUegM+YdCteeUy1DPvaIFzphZ4fPKMZhRxEA9bieAW2vZcXSkqY8eELw
         w7Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWmg4cxqEYlrx0U15sJ7+9abb4BcJSQjxWW+IvkMGAUfjA46X1uE8L17TjoZGTon2toH+jliQzJixeR37ounzV3MvWhM72BUpBa8nP28YGui+dosG9tWeI4HrBkXZXaKhdOzrIyOSU19Yre
X-Gm-Message-State: AOJu0YyzpJEbbBpexvdpW0mPnaUgKa968EmUHi0RFEfp9HYqPXwqbG8R
	EXq6o+rtGnfkANF0aqeMIbP/4YIbi4IUQEhluEbQrdW242owlphPPUuYDUoGckQ=
X-Google-Smtp-Source: AGHT+IG/bCk4kIW9NyrCSQ6KIPPrgxsc/22TJV8EHDe4dT1Ty8hdJebdL39GxuNsH4o+UyZWeccXhw==
X-Received: by 2002:a05:690c:d1a:b0:607:7bce:fe28 with SMTP id cn26-20020a05690c0d1a00b006077bcefe28mr10471026ywb.13.1708424608744;
        Tue, 20 Feb 2024 02:23:28 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id j126-20020a819284000000b005ff98d9a7b8sm2045385ywg.19.2024.02.20.02.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 02:23:28 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-607eefeea90so38019587b3.1;
        Tue, 20 Feb 2024 02:23:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXlmEqZNdZ9RzyaYKredLH0J3NmRXlJAgQF9l7zRUYxCf6+cnTTPvZAL29NsiW83HQhY5UsP3x3I4PXI5rsFSbDI6fSlQYReNN9TWaMHWQxkmTEgc4JwK46wNsC4i05U8yBgEjzU/BvqS2m
X-Received: by 2002:a81:4f84:0:b0:607:df5f:5e0c with SMTP id
 d126-20020a814f84000000b00607df5f5e0cmr9142339ywb.3.1708424607929; Tue, 20
 Feb 2024 02:23:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219164002.520342-1-thuth@redhat.com> <c44bfc7f-7b06-4985-953d-185f8b576a5b@kernel.org>
In-Reply-To: <c44bfc7f-7b06-4985-953d-185f8b576a5b@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Feb 2024 11:23:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXc=rR9udEmMsCJof+sCxdoJryF49-Gy9j=DJqiHyUsvQ@mail.gmail.com>
Message-ID: <CAMuHMdXc=rR9udEmMsCJof+sCxdoJryF49-Gy9j=DJqiHyUsvQ@mail.gmail.com>
Subject: Re: [PATCH] drivers/tty/serial: Remove unused function early_mcf_setup
To: Jiri Slaby <jirislaby@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>
Cc: Thomas Huth <thuth@redhat.com>, linux-m68k@lists.linux-m68k.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 6:11=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> w=
rote:
> On 19. 02. 24, 17:40, Thomas Huth wrote:
> > Compiling a kernel for the ColdFire causes a compiler warning:
> >
> > drivers/tty/serial/mcf.c:473:12: warning: no previous prototype for
> >   =E2=80=98early_mcf_setup=E2=80=99 [-Wmissing-prototypes]
> >    473 | int __init early_mcf_setup(struct mcf_platform_uart *platp)
> >        |            ^~~~~~~~~~~~~~~
> >
> > This function seems to be completely unused, so let's remove it
> > to silence the warning.
>
> And it seems so since the driver addition in 2007 by:
> commit 49aa49bfd40d718095669c1c70c9d167b814e29b
> Author: Greg Ungerer <gerg@snapgear.com>
> Date:   Tue Oct 23 14:37:54 2007 +1000
>
>      m68knommu: new style ColdFire UART driver

Indeed.

Looks like the "changes to the ColdFire based m68knommu systems
to use a platform model at init, and this is used there" from [1]
never materialized on any public mailing list?

Greg: does it still make sense to add them? If not:
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

[1] https://lore.kernel.org/all/47254BEB.2040609@snapgear.com/

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

