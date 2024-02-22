Return-Path: <linux-kernel+bounces-77453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 853FE86057B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B17F0289727
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E22A12D21F;
	Thu, 22 Feb 2024 22:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8WmRuVQ"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92F012D218;
	Thu, 22 Feb 2024 22:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708640067; cv=none; b=tR8ZK1WUodXQNUxSarLh1KWRHM8IA5GeMByZHf2PQOV1BdZj0j8HLnQjOkP/BEQ9pjYW/zcHtzYmqQOLKVx6T1ch5uSGHWbxr5mkM2FhiTPbdOD8RhTYUK6G/xodfEwJISe9esGCRP7d4+t2dBP2dCsljs6M/JPAen/QwoK9iYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708640067; c=relaxed/simple;
	bh=filPK0hW9sEluA5e/J32dWICU2fqEy2+asFrOlW3po4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cz/JJSuC0zlplT02mAKKpDTY2yj4238MdV+4itrBdx58taQmR7SsNJ4fiDBY9yzoJVshaMlXJIH7tY/Bfsmgq/2fyNIxXbtxphHJQ8K4vroN5alhClwNadbzfrLMlzCiQ/6y5B576peeDJWTQKTG9jFNJ76Jyx/MYHk+71PfjfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8WmRuVQ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5649c25369aso145752a12.2;
        Thu, 22 Feb 2024 14:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708640064; x=1709244864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bS8XuNs9Y5my5ivjgr100IJoKR3ZSqRXyi3h5KnP/KI=;
        b=N8WmRuVQKWKrI3KNBEbwNDINNdZSFVaLDbNmuhnfS0/THSUpSZ2II8W5MRbKo6d5WR
         QgS8rFBKiy3QDiyOUbDW/HAXlb2Ogy7DRsnrFUc4RFitg5M+PhPESrrwrewoYJY7DeqA
         jDNG00fjWnMnigONPHBWQ7hz1rwPAMXQ9S86uOzWId9wQvR+Fh81RByixldefhrCzdK4
         aNo7YmJjexfkXIj3mGFytbRrfb/BKPzCqp8iNQMH7ysSpMse4U+dP6FmU2NuOhJ138hG
         bTrVsND+VLlr+Siy/aGMAC70AcGsKGz2nCz2dPcW75DthaobqTYiaemp7hP2V5AXGMRD
         2zLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708640064; x=1709244864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bS8XuNs9Y5my5ivjgr100IJoKR3ZSqRXyi3h5KnP/KI=;
        b=RIBZCBaqJDSdeO8FIMCfEIsUCmK9OjAazhWecBNmOhrW8nBkqlf1anE8d3A70ZrUvd
         Vrly1lHocbPonUGpkzVC+RcDF8/cc6bhncZJa+HCFTf1bjURSGmZrzGvRvkacgRaa09u
         h96U1p7gL7ky+039kBRP7QKwoDBOy/rDiO38Yw05l4Dt/8CHcNxTIVlGs2AZpkog6pkF
         pYjf/nDvMMqmDec5nudxrB8IbRJbFiWPR5OnxLgS5BDDA0JkkXbFUJFwCqzdHHBW5+E3
         aFB/GPVsJTBJ5wELtnzmEbwMod6eZV4xwQZxBb+yBUie7sBRTonO3wdic/O6nLwI5TO1
         qfiA==
X-Forwarded-Encrypted: i=1; AJvYcCXLHKKyXgLCJ7ED2UhtP24Wb9w3dNtRVJ2Y2tAPU1nc5PlvHvQO5wCP+mDawFZ1fOgh0y66m4DfnvonhFnwKIb3Y4xxZWNixS0JRiPWLAlN5bHe/GJgQRNMPQEdMf9MkRyVkbJVWRT/SA==
X-Gm-Message-State: AOJu0YyQyQVdp2f+PtOyUxVykld4eS2QDcRTjqBB+WZyWyqAgP4UJTJU
	vMHhgm+Nt9WomnBWd/xn9dn+n7rwQ+NSL2lwQ67w6wmvchMOD3Fdh881z5prmBsM9BDUoQ+4bBW
	e+PUDVRZvU+qm4qxJkS8AwDD5+OI=
X-Google-Smtp-Source: AGHT+IEk72eRjdWU6OGClnZibRF8XqeL8yZeZipoHY4DOTpTBKjtMNck5AsaCjWZ1Q0ZHavd9KwBnr4+AKV0MREnQmk=
X-Received: by 2002:a17:906:e0c8:b0:a3c:f016:22a4 with SMTP id
 gl8-20020a170906e0c800b00a3cf01622a4mr75745ejb.37.1708640063865; Thu, 22 Feb
 2024 14:14:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1f598a72-dd9f-4c6c-af7f-29751f84bd23@alliedtelesis.co.nz>
 <Zde966nsJ76QOuzm@surfacebook.localdomain> <f5e74774-226a-4678-a6f9-b4f17250ad91@alliedtelesis.co.nz>
 <CAHp75Vfq3Pc+Eo3Z5mhORZwwuKF+Y7_47dTO8qARcfba4nmj2w@mail.gmail.com> <9d00e1b1-120b-4c2b-89c5-0ac736bf6441@alliedtelesis.co.nz>
In-Reply-To: <9d00e1b1-120b-4c2b-89c5-0ac736bf6441@alliedtelesis.co.nz>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 23 Feb 2024 00:13:47 +0200
Message-ID: <CAHp75VdnXtVwrLrcGjnYMfNx7roBvQm9DMr6_ndjZeAbRDbs_Q@mail.gmail.com>
Subject: Re: Linux support for a 7 segment LED display
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Pavel Machek <pavel@ucw.cz>, 
	"lee@kernel.org" <lee@kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 12:08=E2=80=AFAM Chris Packham
<Chris.Packham@alliedtelesis.co.nz> wrote:
> On 23/02/24 10:59, Andy Shevchenko wrote:
> > On Thu, Feb 22, 2024 at 11:53=E2=80=AFPM Chris Packham
> > <Chris.Packham@alliedtelesis.co.nz> wrote:
> >> On 23/02/24 10:34, andy.shevchenko@gmail.com wrote:
> >>> Sun, Feb 11, 2024 at 08:46:12PM +0000, Chris Packham kirjoitti:
> >>>> Hi Blinkenlight enthusiasts,
> >>>>
> >>>> I'm looking for something that I figured must exists but maybe it's =
so
> >>>> niche that no-one has bothered to upstream a driver for it.
> >>>>
> >>>> I have a requirement to support a 7-segment LED display[1] (one that=
 can
> >>>> display a single digit from 0-9). Hardware wise it's just a bunch of
> >>>> individual GPIOs connected to each segment (plus an extra one for a
> >>>> dot). I can't see anything obvious in drivers/leds but maybe I'm loo=
king
> >>>> in the wrong place. Or maybe it's the kind of thing on PC hardware t=
hat
> >>>> is just driven by the BIOS without the operating system knowing abou=
t it.
> >>>>
> >>>> Is there an existing in-kernel driver for such a thing?
> >>> No, and can't be. Here is just a mapping table and other drivers that=
 use
> >>> 7-segment LED displays to be connected to.
> >>>
> >>> What you need is something else, i.e. special case of leds-gpio (whic=
h should
> >>> be somewhere else) that does something like this. To me it sounds lik=
e a
> >>> mixture between line-display.h (from auxdisplay) and gpio-aggregator.
> >>>
> >>> How many digits do you want to connect? How are they going to be conn=
ected
> >>> (static display, or dynamic when you need to refresh in certain perio=
ds of
> >>> time)? Depending on the answer it might take one or another approach.
> >> It sounds like a auxdisplay driver might be the way to go. My hardware
> >> happens to have a single 7seg block but there's no reason the driver
> >> needs to be restricted to that. At some point it obviously becomes
> >> better to fit something like the ht16k33 to offload the character
> >> display but for one or 2 digits a PCA953x plus the LED block would do
> >> just fine.
> > I have hc595 (SPI GPIO) connected to a single digit 7-segment LED.
> > Since it can be also serialized, line display APIs seem plausible to
> > fit. What we need is a proxy between the two. And I think
> > gpio-aggregator is the best for that. It needs an additional
> > compatible string and the registration for line display (overall
> > something like 50 LoCs). We can even call that hardware compatible as
> > line-display-gpio (or so).
> >
> > Cc: Geert and Krzysztof (for the comments on the idea above).
>
> Would the gpio-aggregator be necessary?

Probably not. we just need to consume GPIOs, no need to provide...

> I was thinking something like
> this in the devicetree
>
> \{
>      led-7seg {
>          compatible =3D "kingbright,sa36";
>          seg-gpios =3D <&gpioN 0 GPIO_ACTIVE_HIGH>,
>              <&gpioN 1 GPIO_ACTIVE_HIGH>,
>              <&gpioN 2 GPIO_ACTIVE_HIGH>,
>              <&gpioN 3 GPIO_ACTIVE_HIGH>,
>              <&gpioN 4 GPIO_ACTIVE_HIGH>,
>              <&gpioN 5 GPIO_ACTIVE_HIGH>,
>              <&gpioN 6 GPIO_ACTIVE_HIGH>;
>      };
> };

Right, but also with some additional properties, like
- type of the indicator (7, 14, etc segments, for now we have only
these two supported)
- use-dot (+1 led per each digit)
- characters (how many digits we have, so we need respective amount of GPIO=
s)

With this it's indeed belongs directly to auxdisplay as we have almost
everything is done already there.

> >> The information we want to display is mostly static (basically a numer=
ic
> >> unit identifier) but there are cases where we may want to alternate
> >> between this and "F" to indicate some fault condition

--=20
With Best Regards,
Andy Shevchenko

