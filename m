Return-Path: <linux-kernel+bounces-154834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4A08AE1B1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD902848D8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA88660263;
	Tue, 23 Apr 2024 10:03:13 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA545FB9C;
	Tue, 23 Apr 2024 10:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713866593; cv=none; b=UGbNDNJTZhaNas+wFxA1ENxtNko9Scvw3a8YyXzVbZHMPxIjUrkuD655WcbKI4ApHtN+xdZLMK6iF0SVewmbV/HtSDlwT2fL8lFICF4SqkCzcxveiBY/toLdQQew8mtvbpWnx1VPidNAqWo60VjNMzkWGdocOnCTL+40bXi0EKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713866593; c=relaxed/simple;
	bh=ubi5lY9jdoMRFD0hpTrFY3X8qGf9sZbmLl66vsqVJ2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HG++dDLfXblX37bh7naJQ9NYDVyB0SE45iIL8esfK3IqzmN6AXa91Okn6oms5Q68pK0tJRU2izEoy0pXZvOdbPONB6RLxshkRr3kIe+uQx+0u46BiA4lslKNxzGXd9+MEJGO0nCBfCEbfnBzzFLyRE2jR84WQDAAXUvXg0ZarNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-617f8a59a24so45192997b3.1;
        Tue, 23 Apr 2024 03:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713866584; x=1714471384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8iCIO75E6eRSEMI68ISqOBTKwQen37nd2kUoY+O+raQ=;
        b=SmXnQ+7R0E6SJqYGh02/BDkRhaX9wySaPWbJh67BdeF+/2oJHboEz9IfW3OF7uQ4bK
         uCwO6JOies1+wrOFsGpht0oX1rbozJt3KJo2qWYX9DB7xV4r3bueLmCwP4oPfrLdH8oy
         kxiuAFawxWl5U57ElSviepGISFbusM5hoLiq17cssDeNLZA1lTKm0zI0tBlH6obTT+Q/
         v+7Hg6uc7nspxP+v25Ysj4ZdV1jbCc86xE1TOVj595mHdaYEcTip59SKDX6OKwIfdsqd
         Hr5uCOGep7XwJImDbEerA293S+1VrxX7jiB3/+bvIJcYXn+3iIq6f8jpRf5uakwEeNdv
         0J8A==
X-Forwarded-Encrypted: i=1; AJvYcCV1egPGwd2js98JmicK1kS/PlumAFzAyBfr+lCm7Hy0FR2Ws5RQ9smusbI9SQdhbz3B+TgN0c+DKGrs3Ba9rtn64vGOi0sM74vw1YInhatek/Rl79a/zbHlwMIzOaZtC0E1cfugEujsFbHv
X-Gm-Message-State: AOJu0YxnccOoHTV3ftfJjlBnVU38dXAOPX1nqGOPF8Sy+ONTF1flwHQp
	HIVhDmMA8MLtKHs/17ZYdceJvyauD0gJ4cHYSBUVPgxwkNjcftGXlyJOXErb
X-Google-Smtp-Source: AGHT+IHnWmbdRZTfwVxFQXITiziChvLPzY3uzO1kBrFNurUQsQWW3Hwr1lt9uTg4fWBtUlTTup7aiQ==
X-Received: by 2002:a05:690c:630c:b0:61a:c439:9b36 with SMTP id ho12-20020a05690c630c00b0061ac4399b36mr15658777ywb.4.1713866584489;
        Tue, 23 Apr 2024 03:03:04 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id t192-20020a0deac9000000b0061accf6a37esm2422375ywe.131.2024.04.23.03.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 03:03:04 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-de46da8ced2so5311154276.0;
        Tue, 23 Apr 2024 03:02:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVUIqlDj2pGlKC/vRBOOOfQSQMaaseSzYevPRdGxUSjVO+0FZyz3e/c3S+WCvftZOUJHuFgVgFE39WtTfzA7ufzFMwYjlJiZkl51NkgUVbyimfPSgGfTnyvHZW4i+xp4A9385wU6CYE0LHb
X-Received: by 2002:a25:fc17:0:b0:dcc:d694:b4a6 with SMTP id
 v23-20020a25fc17000000b00dccd694b4a6mr12051653ybd.15.1713866568604; Tue, 23
 Apr 2024 03:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409154253.3043822-1-hugo@hugovil.com> <20240409154253.3043822-4-hugo@hugovil.com>
 <CAMuHMdVq=rf-6o485KiA+zcwJPHMe5STKUtSWtFPs2nmvshu-A@mail.gmail.com>
In-Reply-To: <CAMuHMdVq=rf-6o485KiA+zcwJPHMe5STKUtSWtFPs2nmvshu-A@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Apr 2024 12:02:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWBYnhVvDMditnf9bh17TeBhrZmuz--7x9QEejivCCyJg@mail.gmail.com>
Message-ID: <CAMuHMdWBYnhVvDMditnf9bh17TeBhrZmuz--7x9QEejivCCyJg@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] serial: sc16is7xx: split into core and I2C/SPI
 parts (core)
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, peterz@infradead.org, 
	mingo@kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	andy.shevchenko@gmail.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 12:01=E2=80=AFPM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Tue, Apr 9, 2024 at 5:48=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com>=
 wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >
> > Split the common code from sc16is7xx driver and move the I2C and SPI bu=
s
> > parts into interface-specific source files.
> >
> > sc16is7xx becomes the core functions which can support multiple bus
> > interfaces like I2C and SPI.
> >
> > No functional changes intended.
> >
> > Also simplify and improve Kconfig entries.
> >   - Capitalize SPI keyword for consistency
> >   - Display list of supported ICs each on a separate line (and aligned)=
 to
> >     facilitate locating a specific IC model
> >   - Add Manufacturer name at start of description string
> >   - Add UART keyword to description string
> >
> > Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> Thanks for your patch, which is now commit d49216438139bca0
> ("serial: sc16is7xx: split into core and I2C/SPI parts (core)")
> in tty-next (next-20240415 and later).
>
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -1021,41 +1021,30 @@ config SERIAL_SCCNXP_CONSOLE
> >           Support for console on SCCNXP serial ports.
> >
> >  config SERIAL_SC16IS7XX_CORE
> > -       tristate
> > -
> > -config SERIAL_SC16IS7XX
> > -       tristate "SC16IS7xx serial support"
> > +       tristate "NXP SC16IS7xx UART support"
>
> Hence this replaces SERIAL_SC16IS7XX_CORE by SERIAL_SC16IS7XX,
> so arch/mips/configs/cu1??0-neo_defconfig needs to updated.

Or just rename SERIAL_SC16IS7XX_CORE back to SERIAL_SC16IS7XX.

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

