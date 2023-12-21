Return-Path: <linux-kernel+bounces-8513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4506E81B8DE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC16528A7CD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87004360AC;
	Thu, 21 Dec 2023 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="veaMOXg1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801A436088
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 13:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so566288276.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 05:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703166296; x=1703771096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CeP4kNdvACJ5LqYxE4fXGpJZwNtLXE/FAa7f+Vu66/c=;
        b=veaMOXg1t2IuV/XaIDb8r3wyV0rs0XvtLwWDMDY182Dn0iqyJYdeoXIZcuwxEt7aDj
         IIyvvLTw9QLlmifV8lOEa6Y+fnXtzKoozuaf0IM1wg4eMHExK/q8cMWIGjas1PXC5crm
         ryTMUneQk96pkyK+CwFtk0MOug4xRkAczoun+woFtaSkWIQV/FxUzE14HCpNO4bLUese
         n5PlVflEN+qsAbPRQHrOPr6vn7BZT1BwvZdlgni7SS89nOgwth0pyrxFpm5veWrO0lct
         iui76nznXtkLFzMgq7ahYb/8uibippjOtp2l9vo0FdKKpeTXvOKgBWqn+FQttOpSm3no
         Ukyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703166296; x=1703771096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CeP4kNdvACJ5LqYxE4fXGpJZwNtLXE/FAa7f+Vu66/c=;
        b=Avx4ha7ooFo/0Zb3HaZTuuGehwFqvb+hJ4AWnLIuJ6K1vsnHZyppXU0RR9JpGoCi4H
         gcw3hXa/i3r2GUuyyDkhmxlE2Dxdde27t+5S5kDEwvA6K2q+mHUIcUddo4sXnUqUvgCP
         FjSimi/iLTTBb1RvoVIQQ6zVfqkKkufZbV0BDwxXwnJs/AwdEMpnpVIobSZ8XYAoWMh1
         amkbodXhfHj5mJfQYai4tThVEj9jm+WRbeJQvoZXVf23m96z2ZpwToxTxxHOFlhyRxC5
         y2IP81Bke8KlrqXCfOF/71LAnR0m8nTHEzUVcb9mJYjNy4t5WLJWi2EhAj05ICGfRvZV
         /BwA==
X-Gm-Message-State: AOJu0YxKZhLKjXdhsakr6HTfItL0nB4dJqA8dRSHAsHaM1LiRnaH+zFa
	z78Fq9oWqcPaCwDlhvYwdKk5UxQYuIqbwp3hZfC3XA==
X-Google-Smtp-Source: AGHT+IFxNXE+jS35HnUO8ZrCIK4+Br5wJL3Ray/yXu7HV4UVOSnWmkmQQIZtfNhSkhxjGhC4KfG1Asd4QPb2AdIfEKs=
X-Received: by 2002:a25:b08f:0:b0:dbd:5253:c3af with SMTP id
 f15-20020a25b08f000000b00dbd5253c3afmr812295ybj.1.1703166296433; Thu, 21 Dec
 2023 05:44:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215143906.3651122-1-emil.renner.berthing@canonical.com>
 <20231215143906.3651122-2-emil.renner.berthing@canonical.com>
 <20231215202137.GA317624-robh@kernel.org> <CAJM55Z9pBpYfwpxPH7bUumuosVDn9DHLSBngW6CtG7aK_z+_bQ@mail.gmail.com>
 <CACRpkdYT+jf4=dk3Y9cwa_=aYCihVq93N-iT0RUbtT2-+PX69w@mail.gmail.com> <CAJM55Z8osSFxKi_7=aRkEr+U3vAq0TS93OggnRzyPpssNuuJ3Q@mail.gmail.com>
In-Reply-To: <CAJM55Z8osSFxKi_7=aRkEr+U3vAq0TS93OggnRzyPpssNuuJ3Q@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 21 Dec 2023 14:44:44 +0100
Message-ID: <CACRpkdbx7BOoHzbGd6n5p=Ho3GhMcujwUzQam0jLe6Ysg+xsNg@mail.gmail.com>
Subject: Re: [PATCH v1 1/8] dt-bindings: pinctrl: Add thead,th1520-pinctrl bindings
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Rob Herring <robh@kernel.org>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Hoan Tran <hoan@os.amperecomputing.com>, Serge Semin <fancer.lancer@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 1:28=E2=80=AFPM Emil Renner Berthing
<emil.renner.berthing@canonical.com> wrote:
> Linus Walleij wrote:
> > On Sat, Dec 16, 2023 at 2:57=E2=80=AFPM Emil Renner Berthing
> > <emil.renner.berthing@canonical.com> wrote:
> >
> > > > > +          thead,strong-pull-up:
> > > > > +            oneOf:
> > > > > +              - type: boolean
> > > > > +              - $ref: /schemas/types.yaml#/definitions/uint32
> > > > > +                enum: [ 0, 2100 ]
> > > > > +            description: Enable or disable strong 2.1kOhm pull-u=
p.
> > > >
> > > > bias-pull-up can already specify the strength in Ohms.
> > >
> > > The strong pull up is a separate bit that can be enabled independentl=
y from the
> > > regular pull-up/down, so in theory you could enable both the regular =
pull-up
> > > and the strong pull-up at the same time, or even the regular poll-dow=
n and the
> > > strong pull-up which is probably not advised.
> >
> > bias-pull-up; <- Just regular pulling up the ordinary
> > bias-pull-up =3D <100>; <- Same thing if the ordinary is 100 Ohm (figur=
e out what
> >   resistance it actually is....)
> > bias-pull-up =3D <21000000>; <- strong pull up
> > bias-pull-up =3D <21000100>; <- both at the same time
>
> Hmm.. the two pull-ups combined would be a stronger pull-up, eg. lower
> resistance, right? So you'd need to calculate it using
> https://en.wikipedia.org/wiki/Series_and_parallel_circuits#Resistance_uni=
ts_2

Yeah hehe elementary electronics beats me, of course it is in parallel.

> The problem is that the documentation doesn't actually mention what will =
happen
> if you combine the strong pull-up with the regular bias.

So why even allow it then?

Do the people designing boards using this have better documentation than wh=
at
you have? Then either get that documentation or just don't give them
too much rope.

Yours,
Linus Walleij

