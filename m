Return-Path: <linux-kernel+bounces-77887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F72860B98
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC612281C82
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2F814F8C;
	Fri, 23 Feb 2024 07:52:05 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0572C14A93;
	Fri, 23 Feb 2024 07:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708674725; cv=none; b=AYalP0jzHbirQwv86CmNZe0jBJxmsUvXPlpFOEroNg71D/+bHyZe7JaH6mz1LX4jvaZ3Nxk9mEQj3SidHqqgDaR0OQvnTKhkmwJmKr+7C9eCWcCkIi3PfiRp1TM1VwkYB8lrJQb0lHSf39Ib+ag8NedL3YCcDUrxRcBbP+GUOuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708674725; c=relaxed/simple;
	bh=SulJxZRxNKoHXWIOjle6vK7l6oLwWgnMvc65TaihxoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fOPpW3yq8VRa9uu7XCk4XV/3iRvqfbC2+VRQQjYLrn9CW1f7sUaErWMtsgnR21QyF3Y2p25HEYs67XpMbtMFJ5xB+I2CyPhM+DVVBLnoyxUAsXx9QzTiUUAYmKCT3HLm7HJoeBvvLnCvkh4nn4VdmzWavyyx9hOQ6oJXoyRL+DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6087396e405so516677b3.0;
        Thu, 22 Feb 2024 23:52:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708674721; x=1709279521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehnKnXXrSdF/FxJDFVL5e2Nio1t6f04Uhg7zFnoYlkE=;
        b=Iv6V0qLOzn0czWQ3jjGNK3YBbkX+P9JnHyD2oDIoNMX9XlZRp5DhdlSdwRa4n1v4Oz
         q62OgkCVw0klKr31S2wPqssAfunbgxevH3wcG1ZdRswvKvBkbfJOoAsgb4ZR/OaYTr2f
         +oI38dZ/2BkRrRWm71Y0MwQkb8YRYEIbQLSQk4HO5vWDbYB3TtUEOxpI2aepo1efQ6RU
         MZXYLBZE+uRO1yIvAmraQj1ZcNkxq+wi0XZVHH41vXZHgHmdQNdWZ1gw+lFEwAVqpCy/
         LXQuu9pSdbEfYCoMRHCHSPBj9+UlyXoNVlsi9Q+uH16/JckVrGbYFiGeRQRiPQNwmHrH
         vN7w==
X-Forwarded-Encrypted: i=1; AJvYcCVmA0vQLFikpXRLYMBS+Z1Z/KwPuMqRgTPwJT88MQjvGgJghNU+HS89KlxKM4Bg9ztKK7DeZYOh8lRcKcgOVzvHUy+h6HviY98E9QhhEXtznAYpjWcC0YXRosCC3kWmTihrldnhfHQOEQ==
X-Gm-Message-State: AOJu0YxuQ8vZ3HZ5CAAv6s+oTVFOIdcRTVE6+DP1TTcKgqsZR9KbDdcN
	vMeDO5RVViYVHbMNsRqywfeucOc1n00CCINt06av7jkDbcCJ7v9lhKbgHxNVPOk=
X-Google-Smtp-Source: AGHT+IH//tH9n1DsPUfj63FKeqkdteEpx6pt0YkXRsoNt3LYdIunyDGJJKVVQ9PFURHlfbsxm9cWog==
X-Received: by 2002:a81:4f56:0:b0:608:b5a9:5e48 with SMTP id d83-20020a814f56000000b00608b5a95e48mr592410ywb.11.1708674721184;
        Thu, 22 Feb 2024 23:52:01 -0800 (PST)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id l123-20020a819481000000b00604ae9cb29bsm3480352ywg.127.2024.02.22.23.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 23:52:00 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so44017276.0;
        Thu, 22 Feb 2024 23:52:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVpU75cYV3PchflohykXe/nUzUcE27BldY/+YMg77GW+ctiuFp+/n0rR9KSsiTCUeHe/WG+iUYkiqJwOA2Anzd8p6ut3SfktULbLiOV1XqMj7AVcNLzb8xDAYntFuDEgnR6Kq7U7nJkUg==
X-Received: by 2002:a25:2107:0:b0:dcf:28b8:f04d with SMTP id
 h7-20020a252107000000b00dcf28b8f04dmr2869692ybh.0.1708674720437; Thu, 22 Feb
 2024 23:52:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1f598a72-dd9f-4c6c-af7f-29751f84bd23@alliedtelesis.co.nz>
 <Zde966nsJ76QOuzm@surfacebook.localdomain> <f5e74774-226a-4678-a6f9-b4f17250ad91@alliedtelesis.co.nz>
 <CAHp75Vfq3Pc+Eo3Z5mhORZwwuKF+Y7_47dTO8qARcfba4nmj2w@mail.gmail.com>
 <9d00e1b1-120b-4c2b-89c5-0ac736bf6441@alliedtelesis.co.nz>
 <CAHp75VdnXtVwrLrcGjnYMfNx7roBvQm9DMr6_ndjZeAbRDbs_Q@mail.gmail.com> <2a8d19ee-b18b-4b7c-869f-7d601cea30b6@alliedtelesis.co.nz>
In-Reply-To: <2a8d19ee-b18b-4b7c-869f-7d601cea30b6@alliedtelesis.co.nz>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 23 Feb 2024 08:51:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUFW7iTdhQtW4eDnU50zRqsdWsLnTD74UQo8tBU66-dCA@mail.gmail.com>
Message-ID: <CAMuHMdUFW7iTdhQtW4eDnU50zRqsdWsLnTD74UQo8tBU66-dCA@mail.gmail.com>
Subject: Re: Linux support for a 7 segment LED display
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Pavel Machek <pavel@ucw.cz>, 
	"lee@kernel.org" <lee@kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Fri, Feb 23, 2024 at 4:46=E2=80=AFAM Chris Packham
<Chris.Packham@alliedtelesis.co.nz> wrote:
> On 23/02/24 11:13, Andy Shevchenko wrote:
> > On Fri, Feb 23, 2024 at 12:08=E2=80=AFAM Chris Packham
> > <Chris.Packham@alliedtelesis.co.nz> wrote:
> >> On 23/02/24 10:59, Andy Shevchenko wrote:
> >>> On Thu, Feb 22, 2024 at 11:53=E2=80=AFPM Chris Packham
> >>> <Chris.Packham@alliedtelesis.co.nz> wrote:
> >>>> On 23/02/24 10:34, andy.shevchenko@gmail.com wrote:
> >>>>> Sun, Feb 11, 2024 at 08:46:12PM +0000, Chris Packham kirjoitti:
> >>>>>> I'm looking for something that I figured must exists but maybe it'=
s so
> >>>>>> niche that no-one has bothered to upstream a driver for it.
> >>>>>>
> >>>>>> I have a requirement to support a 7-segment LED display[1] (one th=
at can
> >>>>>> display a single digit from 0-9). Hardware wise it's just a bunch =
of
> >>>>>> individual GPIOs connected to each segment (plus an extra one for =
a
> >>>>>> dot). I can't see anything obvious in drivers/leds but maybe I'm l=
ooking
> >>>>>> in the wrong place. Or maybe it's the kind of thing on PC hardware=
 that
> >>>>>> is just driven by the BIOS without the operating system knowing ab=
out it.
> >>>>>>
> >>>>>> Is there an existing in-kernel driver for such a thing?
> >>>>> No, and can't be. Here is just a mapping table and other drivers th=
at use
> >>>>> 7-segment LED displays to be connected to.
> >>>>>
> >>>>> What you need is something else, i.e. special case of leds-gpio (wh=
ich should
> >>>>> be somewhere else) that does something like this. To me it sounds l=
ike a
> >>>>> mixture between line-display.h (from auxdisplay) and gpio-aggregato=
r.
> >>>>>
> >>>>> How many digits do you want to connect? How are they going to be co=
nnected
> >>>>> (static display, or dynamic when you need to refresh in certain per=
iods of
> >>>>> time)? Depending on the answer it might take one or another approac=
h.
> >>>> It sounds like a auxdisplay driver might be the way to go. My hardwa=
re
> >>>> happens to have a single 7seg block but there's no reason the driver
> >>>> needs to be restricted to that. At some point it obviously becomes
> >>>> better to fit something like the ht16k33 to offload the character
> >>>> display but for one or 2 digits a PCA953x plus the LED block would d=
o
> >>>> just fine.
> >>> I have hc595 (SPI GPIO) connected to a single digit 7-segment LED.
> >>> Since it can be also serialized, line display APIs seem plausible to
> >>> fit. What we need is a proxy between the two. And I think
> >>> gpio-aggregator is the best for that. It needs an additional
> >>> compatible string and the registration for line display (overall
> >>> something like 50 LoCs). We can even call that hardware compatible as
> >>> line-display-gpio (or so).
> >>>
> >>> Cc: Geert and Krzysztof (for the comments on the idea above).
> >> Would the gpio-aggregator be necessary?
> > Probably not. we just need to consume GPIOs, no need to provide...
> >
> >> I was thinking something like
> >> this in the devicetree
> >>
> >> \{
> >>       led-7seg {
> >>           compatible =3D "kingbright,sa36";
> >>           seg-gpios =3D <&gpioN 0 GPIO_ACTIVE_HIGH>,
> >>               <&gpioN 1 GPIO_ACTIVE_HIGH>,
> >>               <&gpioN 2 GPIO_ACTIVE_HIGH>,
> >>               <&gpioN 3 GPIO_ACTIVE_HIGH>,
> >>               <&gpioN 4 GPIO_ACTIVE_HIGH>,
> >>               <&gpioN 5 GPIO_ACTIVE_HIGH>,
> >>               <&gpioN 6 GPIO_ACTIVE_HIGH>;
> >>       };
> >> };
> > Right, but also with some additional properties, like
> > - type of the indicator (7, 14, etc segments, for now we have only
> > these two supported)
> > - use-dot (+1 led per each digit)
> > - characters (how many digits we have, so we need respective amount of =
GPIOs)
> >
> > With this it's indeed belongs directly to auxdisplay as we have almost
> > everything is done already there.
>
> I've been playing about with this. I've got an auxdisplay driver that's
> basically working (I won't bother spamming list with it yet). But I'm
> wondering how I'd represent multiple characters. I kind of feel the
> natural representation would be something like.
>
>          led-7seg {
>                  compatible =3D "generic,7-segment-on-gpio";

gpio-7seg?

>                  char-0 {
>                      segment-gpios =3D <&gpio 0 GPIO_ACTIVE_LOW
>                                       &gpio 1 GPIO_ACTIVE_LOW
>                                       &gpio 2 GPIO_ACTIVE_LOW
>                                       &gpio 3 GPIO_ACTIVE_LOW
>                                       &gpio 4 GPIO_ACTIVE_LOW
>                                       &gpio 5 GPIO_ACTIVE_LOW
>                                       &gpio 6 GPIO_ACTIVE_LOW>;
>                  };
>                  char-1 {
>                      segment-gpios =3D <&gpio 8 GPIO_ACTIVE_LOW
>                                       &gpio 9 GPIO_ACTIVE_LOW
>                                       &gpio 10 GPIO_ACTIVE_LOW
>                                       &gpio 11 GPIO_ACTIVE_LOW
>                                       &gpio 12 GPIO_ACTIVE_LOW
>                                       &gpio 13 GPIO_ACTIVE_LOW
>                                       &gpio 14 GPIO_ACTIVE_LOW>;
>                  };
>          };
>
> But having those sub-nodes means I can't just use devm_gpiod_get_array()
> instead I'd have to use device_for_each_child_node() and
> devm_fwnode_gpiod_get_index(). Am I missing something? I could do away
> with the sub-nodes and have properties like "segment-0-gpios",
> "segment-1-gpios" but that feels awkward.

Just use a single segment-gpios property?
The dot is optional, and can be zero.
The number of characters is (the number of elements + 1) / 8.
The "+ 1" serves to accommodate the optional dot for the last character,
but if people find that too complicated, you can enforce a multiple
of 8 instead.

The colon found on many 4-digit displays can be a separate gpios
property.

I do agree subnodes could be more appropriate for more complex
displays, but ideally you need some way to describe relative positions
for such displays, too.

Note that most larger displays are not individual LEDs, but matrices
of LEDs. Do we want to drive/scan them from software, using a
gpio-7seg-matrix driver?

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

