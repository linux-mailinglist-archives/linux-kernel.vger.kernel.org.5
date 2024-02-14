Return-Path: <linux-kernel+bounces-65416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6D4854CAB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2AF71C212E9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A665C91F;
	Wed, 14 Feb 2024 15:27:09 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D12E5C8F5;
	Wed, 14 Feb 2024 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924428; cv=none; b=Gyqg784I7P2n1NXmuEtYxsHSGiTMSHfi6rgKgJatEu/5lqcKk+bwf2fu0VQhyn97RrPuj5E78vOrx/o4jpJHkTF4CWzFBkfUtWnv6jJ15nE50BjO2oqc4P5AAGIt4LuBLVv2TRWdRxiBQiHnUwXB7dGUSyiA7WRPeM0JRrrMgdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924428; c=relaxed/simple;
	bh=Y1By5kaxlBOqyM0fj5WuN+yTKrFl/qbAdgT0wfnOtNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d58p/XuJZamxKlcrjkpgW0mrEJRQ0PiQSxWHr3y1ZbgXytghKSsRqTFUTtH3QOdNGQgswQ70fsB3PaQZP9ej2kHv6kgH3dFOFYK3as3TNd+PfszlHJ690laWJj5E3Mm/paLtafpG8WwRGRHn1xzwbhFIzgOgtrhiohYWoqMoMO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-607aafb2cb4so6051837b3.0;
        Wed, 14 Feb 2024 07:27:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707924425; x=1708529225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGSQkrT6rlJ6JwZQYVWtpuSKpi5dZxL5B9G4nRDynJk=;
        b=YsMrguLHzG0z5gGquYdAMZWjx9tyvcfJ4bD0kl9IgxY7+3lF3wwqEZoUdwqYu50U/c
         2AuwuBemd7yQCxvXqk1T/2vRcBy14H2BY43NsKHW6G9vTekYKfycaU8BvfUkz6yq4VNK
         WEjw979Weyv5pCns48sWiKQJT3sThO5oHyW0pCE8vlOI2o6Il766nhP8DTMBw9EjUN8d
         otizo1fni+ivN0nIf72yf0fS6LjBC+p4t1TaQ4oHPRwoeN32BsPmiyLfLgzB2wWVPSA3
         U/XPq+kdVsmPc2v9R/e3o10P6WIHZ8VwV9t8e4nWQ3jyG+W2PlBXNp1Rya1fLcxbxQqF
         aQLg==
X-Forwarded-Encrypted: i=1; AJvYcCXt70U/VanNt5iAEfEOYrcTZ/1KU6tvhAhTLh4Sq/nMdSOtkEgUaNJBeDMb8w1dcA9RWqBNN1xKByTgD03A/QE94WMtQIX+n7QalQBniVeldbJNJqlEscg9t+5rhhvxyYlyTwENl4s1a9jczYhP2kolJ2YXAqpSX2YTM0o2ItTkNErMHWzhQyNBaSBbD4cXBqrcJzi1r5ZrplxisRc6yyclPEka7Kft77qzEvI=
X-Gm-Message-State: AOJu0YzpLO8TGizzRytax1AMSeZp2jGV8a2FyOWNbEiJqM8xMPdKMMWc
	QEmJTaUDBxNmCCz+QPmX8sC/UdaIfCnJTEq4K7qIeGYtWfyEFA9sX80L8tVBSJE=
X-Google-Smtp-Source: AGHT+IGPrRgk8wKM8zsUxqqF7k9vsjL1Z7+9O20BdKdCByyA8F0mUO1cMv/F0ejfFJ0mYdMhp3fxKQ==
X-Received: by 2002:a05:690c:350f:b0:607:b0d3:ebc0 with SMTP id fq15-20020a05690c350f00b00607b0d3ebc0mr1760652ywb.21.1707924424687;
        Wed, 14 Feb 2024 07:27:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUm7rFgwJt00HwIP/38k+jjV/FLhJVVY1DoR5A+LtKoqrWbRnro7rMB6xJvcrIr5zRu8Z3Lg4d36JuR91b9zwt9W4neiUQ8y/HsH3UVJ8MHNqpcsS9RdiVMU4IYc3nlKHuhNToIpeIbNa4k03MUFF8w8+q1yr8sV0fQQdmUi1lqKiXUETE/3UFYtjVj6syQPbZAhhWwx5QWE22L3pBailV9aAuC2z9tv/pNaQk=
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id x187-20020a0dd5c4000000b006049f599ca8sm85874ywd.119.2024.02.14.07.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 07:27:04 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcbc00f6c04so2656194276.3;
        Wed, 14 Feb 2024 07:27:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWrsK2Lvf18z57Svdhf06kVYhaNxxkYOaCk+Emie1LEm8kb8/Q+LblNpC0tymSdgNR3WTwkSuAWiClM67WbGvvRpIgo5t4oixwNHFCP7/6Gz0bdJsnKQFVYvqcWWNM28vPgEFR+LCxdOKSBxSEhPwm5MFIPSmVsYGNdBaS/gE6FdYxlhU6t3KgO5HGn5FPGPDQ2uRNx3oxrKXGqw8skpUMeIhN2+PScclT2oeM=
X-Received: by 2002:a25:df07:0:b0:dcb:e0dc:67ee with SMTP id
 w7-20020a25df07000000b00dcbe0dc67eemr2902678ybg.45.1707924424392; Wed, 14 Feb
 2024 07:27:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208105817.2619703-1-claudiu.beznea.uj@bp.renesas.com>
 <20240208105817.2619703-3-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdV+CryvbFkcFGthk2VM0j7m13rQJ_0GtumPg2f-hpuMvA@mail.gmail.com> <fea4f538-b3c2-4299-9af1-5e2b61d06ce4@tuxon.dev>
In-Reply-To: <fea4f538-b3c2-4299-9af1-5e2b61d06ce4@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Feb 2024 16:26:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU8iJhXWFTrVqr8W-ov2D=oSUbsyDP1kfs6mC3rBcLxzQ@mail.gmail.com>
Message-ID: <CAMuHMdU8iJhXWFTrVqr8W-ov2D=oSUbsyDP1kfs6mC3rBcLxzQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/9] watchdog: rzg2l_wdt: Make the driver depend on PM
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: wim@linux-watchdog.org, linux@roeck-us.net, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	p.zabel@pengutronix.de, geert+renesas@glider.be, magnus.damm@gmail.com, 
	biju.das.jz@bp.renesas.com, linux-watchdog@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Fri, Feb 9, 2024 at 1:25=E2=80=AFPM claudiu beznea <claudiu.beznea@tuxon=
dev> wrote:
> On 08.02.2024 14:53, Geert Uytterhoeven wrote:
> > On Thu, Feb 8, 2024 at 1:26=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.de=
v> wrote:
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> The rzg2l_wdt watchdog driver cannot work w/o CONFIG_PM=3Dy (e.g. the
> >> clocks are enabled though pm_runtime_* specific APIs). To avoid buildi=
ng
> >> a driver that doesn't work make explicit the dependency on CONFIG_PM.
> >>
> >> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >> ---
> >>
> >> Changes in v6:
> >> - update patch description
> >> - fixed the dependency on COMPILE_TEST previously introduced
> >
> > Thanks for the update!
> >
> >> --- a/drivers/watchdog/Kconfig
> >> +++ b/drivers/watchdog/Kconfig
> >> @@ -911,6 +911,7 @@ config RENESAS_RZN1WDT
> >>  config RENESAS_RZG2LWDT
> >>         tristate "Renesas RZ/G2L WDT Watchdog"
> >>         depends on ARCH_RZG2L || ARCH_R9A09G011 || COMPILE_TEST
> >> +       depends on PM
> >
> > depends on PM || COMPILE_TEST
>
> Isn't "depends on PM" enough? As of [1] ("If multiple dependencies are
> defined, they are connected with '&&'") the above:
>
> depends on ARCH_RZG2L || ARCH_R9A09G011 || COMPILE_TEST
> depends on PM
>
> are translated into:
> depends on (ARCH_RZG2L || ARCH_R9A09G011 || COMPILE_TEST) && PM
>
> Please let me know if I'm wrong.

That is correct.  But you still can compile-test this driver when
compiling for a different platform, and CONFIG_PM is disabled.

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

