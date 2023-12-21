Return-Path: <linux-kernel+bounces-8336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C2B81B5DF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A0421F23609
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2379C73460;
	Thu, 21 Dec 2023 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="sEPmDJlC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA6D7319C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 12:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5B6A73F73D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 12:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1703161730;
	bh=utwwjd3w/GTj0TOYQ7r9hzEA4xysvpOk2/pKVIn6Dd8=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=sEPmDJlCtPhMZGGX4hMs+N+3/syHVA/APg4UwTnQJVaHFmr+wbOUuahWGaDViWudv
	 EvCw6KkxFIKDjITVYFtqk7U75uHyK8E2sTLMiERZNEq1RKRdnQ5hwGj2/63pQCTX8U
	 wENGR2PXLhpUx5PLtOr/egjp2fx9QryJHWJxapjSQGUarnf4FF/So3maUtWc4+9O9N
	 f+iYUaYIHJsaczpv/O4ELBBaec8LWv5KDcV6z5i6DIXqZwsTE/h7Q4ZPkmWPWK7T1H
	 ql2XLUDnG/9+9IJzLf7fqgQCzGiPN4XazpgAYpXO6sNEb32LmzuMIsfsefI8+Lyq+u
	 +soPLWhoh0r8w==
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-781029a475bso122172785a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 04:28:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703161727; x=1703766527;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=utwwjd3w/GTj0TOYQ7r9hzEA4xysvpOk2/pKVIn6Dd8=;
        b=O9Spzm/ctZrimpIvs7ipm2TJvXX4F6ZO78qTgHm9ksWtgs2m3BXm/QlfE55kDYvIwq
         pAOA+J/shmBhECOuyiQFvpxzIS1ikqJpGG6G07ynMFQR5jnmAw3dVWl04QBssO6h1N9g
         w9zg+vJMvSVl1xdZPh4KZsMuliZDu6tFETwNRkxShA9JcEuQQ7AP2YAiwGJf3Zfjl0nG
         JnA1ES22MqOtgFeRvIHXWxdOZ6ES8bRPYCTSTyuGx9RYU/HCkFCJKHIE8mqj5oYtBaAZ
         4HiYgPc0vwh00ngVkd4kCi4nYRFQRb9vFdtxqDdxXW0XFb9LOkrzHqtn6I8Hw1sOVvHs
         b2gA==
X-Gm-Message-State: AOJu0YxhMo7IlT0JQGifcdJeffaGRObcPedXQIpZzSXxO07B42LX6cL6
	v/eHsu12gIuyEDQhkuuDc4D87Qla7q9D38LZocAi/n2ml2I0c80ckhFHMlnF2T4q5vFUEf5eE3c
	qfCwJOC1nUT3leqV8WKOslFRtYUhDq3WLGd+fbt89nbTCwT3doMwiesL8YSz3ZK8I
X-Received: by 2002:a05:620a:3dc:b0:77e:ffcd:2728 with SMTP id r28-20020a05620a03dc00b0077effcd2728mr897514qkm.53.1703161727419;
        Thu, 21 Dec 2023 04:28:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHB2Dun85XQ6cgWOoZpoJaB/RapIEzw1KjVwm/JtqPitqqKxcRJWcJjtxi1b+wBY8zYrCiPA/YZeVrH74MD5jI=
X-Received: by 2002:a05:620a:3dc:b0:77e:ffcd:2728 with SMTP id
 r28-20020a05620a03dc00b0077effcd2728mr897496qkm.53.1703161727167; Thu, 21 Dec
 2023 04:28:47 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 Dec 2023 04:28:46 -0800
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <CACRpkdYT+jf4=dk3Y9cwa_=aYCihVq93N-iT0RUbtT2-+PX69w@mail.gmail.com>
References: <20231215143906.3651122-1-emil.renner.berthing@canonical.com>
 <20231215143906.3651122-2-emil.renner.berthing@canonical.com>
 <20231215202137.GA317624-robh@kernel.org> <CAJM55Z9pBpYfwpxPH7bUumuosVDn9DHLSBngW6CtG7aK_z+_bQ@mail.gmail.com>
 <CACRpkdYT+jf4=dk3Y9cwa_=aYCihVq93N-iT0RUbtT2-+PX69w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Thu, 21 Dec 2023 04:28:46 -0800
Message-ID: <CAJM55Z8osSFxKi_7=aRkEr+U3vAq0TS93OggnRzyPpssNuuJ3Q@mail.gmail.com>
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
> On Sat, Dec 16, 2023 at 2:57=E2=80=AFPM Emil Renner Berthing
> <emil.renner.berthing@canonical.com> wrote:
>
> > > > +          thead,strong-pull-up:
> > > > +            oneOf:
> > > > +              - type: boolean
> > > > +              - $ref: /schemas/types.yaml#/definitions/uint32
> > > > +                enum: [ 0, 2100 ]
> > > > +            description: Enable or disable strong 2.1kOhm pull-up.
> > >
> > > bias-pull-up can already specify the strength in Ohms.
> >
> > The strong pull up is a separate bit that can be enabled independently =
from the
> > regular pull-up/down, so in theory you could enable both the regular pu=
ll-up
> > and the strong pull-up at the same time, or even the regular poll-down =
and the
> > strong pull-up which is probably not advised.
>
> bias-pull-up; <- Just regular pulling up the ordinary
> bias-pull-up =3D <100>; <- Same thing if the ordinary is 100 Ohm (figure =
out what
>   resistance it actually is....)
> bias-pull-up =3D <21000000>; <- strong pull up
> bias-pull-up =3D <21000100>; <- both at the same time

Hmm.. the two pull-ups combined would be a stronger pull-up, eg. lower
resistance, right? So you'd need to calculate it using
https://en.wikipedia.org/wiki/Series_and_parallel_circuits#Resistance_units=
_2

The problem is that the documentation doesn't actually mention what will ha=
ppen
if you combine the strong pull-up with the regular bias. My best guess for =
what
happens if you enable the strong pull-up and the regular pull-down is that =
you
create a sort of voltage divider. But how do you represent that as an Ohm v=
alue?

We would kind of have to, otherwise the pinconf_get callbacks have states t=
hat
it can't represent.

> > So the idea here was just to make sure that you can do eg.
> >
> >         thead,strong-pull-up =3D <0>;
> >
> > to make sure the bit is cleared.
>
> No use bias-disable; for this.
>
> Yours,
> Linus Walleij
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

