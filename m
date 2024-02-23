Return-Path: <linux-kernel+bounces-77888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CDC860B9D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB3311F22DE8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873A4171A3;
	Fri, 23 Feb 2024 07:53:17 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFF7168CC;
	Fri, 23 Feb 2024 07:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708674797; cv=none; b=absWoLEaprOLT0i7bpl/1qqx0jMKwYuLvfFga9KEcyeuN5/RBThhkNbGpfM8E0xLgFCFJYSFv4R1n73bC5vlmZ6vwHA19hMvOjOR395qVZ8NYGYEchUYADj3KzD+0n3mnpg6WimyqhtPOuAdG+uvqksNDPTVV/V3TT8BijVH72Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708674797; c=relaxed/simple;
	bh=qHslgBc+dxBtygE57lTc0uObtKxoKK7ZdkGay0b7jHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hh+XQGWkldGMHB4mZqW6oNHivws+X2l5NKHoDwbOSU87+Esy4xnn7wmy5/dW2ic1GtPWNCMyVhL64TddytFsPp1tUtnvSY4+uIfU/7D3MmLj+1a6Ppl6XAgcu5uv7PT0gL8rFnj9rUAiUK59V3xtyWgtX9Wt/xwSSizdInTVc8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-607c5679842so5990167b3.2;
        Thu, 22 Feb 2024 23:53:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708674793; x=1709279593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2q0tElHBwB+IEKfpHAd0JdG/IiytCMbGJOSpofd++Pk=;
        b=Dl6bV+/Guvfj92jVgBAUeR/4WcIL2xQofT6r3T7QLCXWp5XXTtCukdXz3JoqG8lKT+
         qkh6S/J3Zk240jlnUdhC9WX/uosUK0qGmR0LRDIAyFoQ5LVXRsalbQQR/GgBWTlJ7skf
         JPFxmYcgY4V2EEpSejtHIUaeuqw9KkOIlh5VNm+tieyUnSoMLa3iCUNLgw74PYx1HYhG
         qc1/b8+Ath/uYaHz5mekoEy2q02HjnBvviKyD6lXlWDEAq7GJemf6uacJCY4godV2jzr
         40GBdJ5s29FYwmNWw2eIqYM3r8yhnscbLEr7iDZQSZkOOJTA1K/BBVnMs1iFu5tPz+57
         8DEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqm0zK8hzUST5ZDWWpbJn2arJ0X0WzoCZLwioMRbkhQ5XSiuuR8jVjWigGou0xOMO/EShfhy9itBSSFJIpbKLP4yc6ieOZnygmEFVgqyzIMGV0wzQodJk6wP11F8gk8kCMQqbMNuN2sA==
X-Gm-Message-State: AOJu0YyeEfBiDM1/pxnugBRbBZzQkCEleuCdoeBU+Bb9Kzp1yH8H+XyL
	9O/OvePmcswo7iluSbQUn6IOxDQOE8g4NDy9i2w71HvIue3rVQ2btziaQYBbd6c=
X-Google-Smtp-Source: AGHT+IGtZ8wF/m6RncSFbUuu5O6YZlJwetlW8fne7hX7vLkwSzpO9iXDp9MvHwjQoXuszLnE5F0k8Q==
X-Received: by 2002:a81:a115:0:b0:608:bbc5:df4 with SMTP id y21-20020a81a115000000b00608bbc50df4mr639094ywg.35.1708674793547;
        Thu, 22 Feb 2024 23:53:13 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id j206-20020a816ed7000000b00607af248292sm3478285ywc.49.2024.02.22.23.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 23:53:13 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6087192b092so6732577b3.0;
        Thu, 22 Feb 2024 23:53:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXM3Aq0dobQ7KB9wgBVZNjIBg0Xyeyy9rLCnpD8kmGvMv7daRDv7TL5SqT1D2paqxbzRb+IsG+Ok2fKm2q06C0H/xv5Nw/SIC1G5dPe55wl9XD1BgFZLI67SdHEID9JLRa8wLZZpDah3w==
X-Received: by 2002:a81:4311:0:b0:608:a8cd:b7de with SMTP id
 q17-20020a814311000000b00608a8cdb7demr1438877ywa.46.1708674792940; Thu, 22
 Feb 2024 23:53:12 -0800 (PST)
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
 <CAHp75VdnXtVwrLrcGjnYMfNx7roBvQm9DMr6_ndjZeAbRDbs_Q@mail.gmail.com>
 <2a8d19ee-b18b-4b7c-869f-7d601cea30b6@alliedtelesis.co.nz> <ZdhNlUotGJCklJTs@duo.ucw.cz>
In-Reply-To: <ZdhNlUotGJCklJTs@duo.ucw.cz>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 23 Feb 2024 08:53:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVPcty_O5uwTv6eBNwt_PNviKwjpjmfiOF05tqNW_CA4g@mail.gmail.com>
Message-ID: <CAMuHMdVPcty_O5uwTv6eBNwt_PNviKwjpjmfiOF05tqNW_CA4g@mail.gmail.com>
Subject: Re: Linux support for a 7 segment LED display
To: Pavel Machek <pavel@ucw.cz>
Cc: Chris Packham <Chris.Packham@alliedtelesis.co.nz>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, "lee@kernel.org" <lee@kernel.org>, 
	"linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On Fri, Feb 23, 2024 at 8:47=E2=80=AFAM Pavel Machek <pavel@ucw.cz> wrote:
> > > Right, but also with some additional properties, like
> > > - type of the indicator (7, 14, etc segments, for now we have only
> > > these two supported)
> > > - use-dot (+1 led per each digit)
> > > - characters (how many digits we have, so we need respective amount o=
f GPIOs)
> > >
> > > With this it's indeed belongs directly to auxdisplay as we have almos=
t
> > > everything is done already there.
> >
> > I've been playing about with this. I've got an auxdisplay driver that's
> > basically working (I won't bother spamming list with it yet). But I'm
> > wondering how I'd represent multiple characters. I kind of feel the
> > natural representation would be something like.
> >
> >          led-7seg {
> >                  compatible =3D "generic,7-segment-on-gpio";
> >                  char-0 {
> >                      segment-gpios =3D <&gpio 0 GPIO_ACTIVE_LOW
> >                                       &gpio 1 GPIO_ACTIVE_LOW
> >                                       &gpio 2 GPIO_ACTIVE_LOW
> >                                       &gpio 3 GPIO_ACTIVE_LOW
> >                                       &gpio 4 GPIO_ACTIVE_LOW
> >                                       &gpio 5 GPIO_ACTIVE_LOW
> >                                       &gpio 6 GPIO_ACTIVE_LOW>;
> >                  };
> >                  char-1 {
> >                      segment-gpios =3D <&gpio 8 GPIO_ACTIVE_LOW
> >                                       &gpio 9 GPIO_ACTIVE_LOW
> >                                       &gpio 10 GPIO_ACTIVE_LOW
> >                                       &gpio 11 GPIO_ACTIVE_LOW
> >                                       &gpio 12 GPIO_ACTIVE_LOW
> >                                       &gpio 13 GPIO_ACTIVE_LOW
> >                                       &gpio 14 GPIO_ACTIVE_LOW>;
> >                  };
> >          };
> >
> > But having those sub-nodes means I can't just use devm_gpiod_get_array(=
)
> > instead I'd have to use device_for_each_child_node() and
> > devm_fwnode_gpiod_get_index(). Am I missing something? I could do away
> > with the sub-nodes and have properties like "segment-0-gpios",
> > "segment-1-gpios" but that feels awkward.
>
> One solution would be to treat separate digits as separata devices
> :-).

That's definitely an option, but would prevent you from having a
single display using auxdisplay/line-display.

> Other would be saying you don't have hardware for that, and make it
> someone else's future problem.

;-)

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

