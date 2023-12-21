Return-Path: <linux-kernel+bounces-8553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 310D481B94F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9DFB1F291E8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957EE6D6DA;
	Thu, 21 Dec 2023 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="VwVRVV2U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF856D6C8
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AECC73F16B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 14:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1703167658;
	bh=YSFGFVOxlECeWrb1201TBHQMqNul2EH+RYRBpW3Owdk=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=VwVRVV2UVwXjf8JlJDzV3fN24W/UzOytMCEbJrXi7MlRdL8UvxWG8XKQCNiRX2IEu
	 LXuDXj4OhJql4WQkiytPmQ+ZYvYYBIxnB7cYN6aB13g9cHm5yHZL0bNiU9vobyeWlD
	 RXtbFcpaEEbrt9gJOvYAaTGiYpFwyn+m1wyagzV/vQy5usCyIa2S3QLLJ+pifiAlDw
	 yQeyPdjUDeoJvFWrSHFWC9FOHgZ11pPWDUVKyXkwMp9H+A5+Hgu2JAqB/KVPbZn2+d
	 qxlm8NiaSF/J+KKi6/nG8cZ8m9WPjY3/KNZnxG/F2jF2Iw84lp8pnZ090oI9pCzo5+
	 w5hAHPGJJA/Ug==
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50e4dfdb01dso717960e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 06:07:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703167658; x=1703772458;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YSFGFVOxlECeWrb1201TBHQMqNul2EH+RYRBpW3Owdk=;
        b=Mku8UmN4aCYIz6qzvcKKDQbXNvjRCuQKUZNjPzplbCmcc99JlZ44AJt3IQrGJ56lHv
         yDyeWeZV7tNRUymY7ShHGFLVLyx9LydR2/w9Xd6Yv2D46feTZWZRhzLFsIeyok21PLov
         STn1M9w0E7I9Q0itKpECcftwLGJfY0fJlxg5vV1uCVsoSrI4D6uiq6j9f5IA5RuzULO4
         u2HXvSmcgRPNIsMvzHmrVeQEqM/zmmd4CIrvwf7kDXB5aNcBwysJJi+eXbm/lDwkrykp
         6wMJqps+NNG+pO4e/1kTqIwMMMgqMfgT0+srQesdoqtkanEvOHNyLT/TYdkScs8o/ozo
         XouQ==
X-Gm-Message-State: AOJu0YzKkEx6Ftoj1LcW8FOkQ4pir4ix3EWtLUogdrSwoUHnfzkK699W
	WLPJuVR4k7zmJWYLrm6bVfKaj60BU3y+X0O3n97hp9vRrfb5LMbz2ONxtLg3cMSEWXs+wdKlTmo
	ZQeiMtSKe1rL+pdTEHfcp+UtUMSEiMKz7+LqRih6vU61kkPY02GZpT/0U9g==
X-Received: by 2002:ac2:5617:0:b0:50e:29c1:f829 with SMTP id v23-20020ac25617000000b0050e29c1f829mr3635667lfd.74.1703167658224;
        Thu, 21 Dec 2023 06:07:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGplfpPbW0FT9ATmbiZqm1++et4V4L718raZzPodJBABIbwHrAdrNT6mNWONQxZ+jsDmjLpy/oSnYqjsp61ks4=
X-Received: by 2002:ac2:5617:0:b0:50e:29c1:f829 with SMTP id
 v23-20020ac25617000000b0050e29c1f829mr3635656lfd.74.1703167657892; Thu, 21
 Dec 2023 06:07:37 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 Dec 2023 09:07:36 -0500
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <CACRpkdbx7BOoHzbGd6n5p=Ho3GhMcujwUzQam0jLe6Ysg+xsNg@mail.gmail.com>
References: <20231215143906.3651122-1-emil.renner.berthing@canonical.com>
 <20231215143906.3651122-2-emil.renner.berthing@canonical.com>
 <20231215202137.GA317624-robh@kernel.org> <CAJM55Z9pBpYfwpxPH7bUumuosVDn9DHLSBngW6CtG7aK_z+_bQ@mail.gmail.com>
 <CACRpkdYT+jf4=dk3Y9cwa_=aYCihVq93N-iT0RUbtT2-+PX69w@mail.gmail.com>
 <CAJM55Z8osSFxKi_7=aRkEr+U3vAq0TS93OggnRzyPpssNuuJ3Q@mail.gmail.com> <CACRpkdbx7BOoHzbGd6n5p=Ho3GhMcujwUzQam0jLe6Ysg+xsNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Thu, 21 Dec 2023 09:07:36 -0500
Message-ID: <CAJM55Z8SwyNEqw4HWRd7G8Y9rdtOGtKy-KbzDorqohdK3nZg0A@mail.gmail.com>
Subject: Re: [PATCH v1 1/8] dt-bindings: pinctrl: Add thead,th1520-pinctrl bindings
To: Linus Walleij <linus.walleij@linaro.org>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Rob Herring <robh@kernel.org>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Hoan Tran <hoan@os.amperecomputing.com>, Serge Semin <fancer.lancer@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Linus Walleij wrote:
> On Thu, Dec 21, 2023 at 1:28=E2=80=AFPM Emil Renner Berthing
> <emil.renner.berthing@canonical.com> wrote:
> > Linus Walleij wrote:
> > > On Sat, Dec 16, 2023 at 2:57=E2=80=AFPM Emil Renner Berthing
> > > <emil.renner.berthing@canonical.com> wrote:
> > >
> > > > > > +          thead,strong-pull-up:
> > > > > > +            oneOf:
> > > > > > +              - type: boolean
> > > > > > +              - $ref: /schemas/types.yaml#/definitions/uint32
> > > > > > +                enum: [ 0, 2100 ]
> > > > > > +            description: Enable or disable strong 2.1kOhm pull=
-up.
> > > > >
> > > > > bias-pull-up can already specify the strength in Ohms.
> > > >
> > > > The strong pull up is a separate bit that can be enabled independen=
tly from the
> > > > regular pull-up/down, so in theory you could enable both the regula=
r pull-up
> > > > and the strong pull-up at the same time, or even the regular poll-d=
own and the
> > > > strong pull-up which is probably not advised.
> > >
> > > bias-pull-up; <- Just regular pulling up the ordinary
> > > bias-pull-up =3D <100>; <- Same thing if the ordinary is 100 Ohm (fig=
ure out what
> > >   resistance it actually is....)
> > > bias-pull-up =3D <21000000>; <- strong pull up
> > > bias-pull-up =3D <21000100>; <- both at the same time
> >
> > Hmm.. the two pull-ups combined would be a stronger pull-up, eg. lower
> > resistance, right? So you'd need to calculate it using
> > https://en.wikipedia.org/wiki/Series_and_parallel_circuits#Resistance_u=
nits_2
>
> Yeah hehe elementary electronics beats me, of course it is in parallel.
>
> > The problem is that the documentation doesn't actually mention what wil=
l happen
> > if you combine the strong pull-up with the regular bias.
>
> So why even allow it then?
>
> Do the people designing boards using this have better documentation than =
what
> you have? Then either get that documentation or just don't give them
> too much rope.

We can certainly prevent Linux from ever combining the strong pull-up with =
the
regular bias, but that doesn't mean that the vendor u-boot can't find a use=
 for
it and might hand over pins in such states Linux then wouldn't know how to
handle.

If you think its better we could just postpone that problem to when/if it e=
ver
happens.

