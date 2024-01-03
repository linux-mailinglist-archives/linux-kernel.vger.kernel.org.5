Return-Path: <linux-kernel+bounces-15652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B243D822F92
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 980081C23628
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF55E1A723;
	Wed,  3 Jan 2024 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="IVfZtuC2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8121A706
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3364c9ff8e1so306488f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 06:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1704292237; x=1704897037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwUN6t7HAGr2hlOOQMzSTbesbM08m3jhum8Tc06lG9g=;
        b=IVfZtuC2E6HmMZxMtEOo7kB43FFq/LCIEGbru+J9m34rM4ktdMlQ4f1B67A+I33YFQ
         zDx3DiUaKLOBqK94gEdsLYOdIDbDtfcsJnCicPcpFE9PSbr8cbFkGLaWV7xSaZZnCOZa
         7FBxCHceUGLUzLCtbuE3NNN/9FG9CC1ESkFrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704292237; x=1704897037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwUN6t7HAGr2hlOOQMzSTbesbM08m3jhum8Tc06lG9g=;
        b=sQGNpl3lX1oIlGQXB5fLvI4dTVTg/cG6nL2PPIwrgdG+e47G5fCSLYP4hJ8PYD9+jI
         JPD04VZXmJRRW5Nuz6pVNL99VR6znKWv5IlQogu1doohcNhEv9shiy/+KvgmlH5eUHkk
         HFos65rH/300HaqmEyjBHygFfOyI9VjRKkwf6M4mv82gSO3pHsfcac/lZvE/f/belOqw
         PuXfGlaERK1TLT+eawkYWEBHnEe7+vHXHYZxKD24dHsLD5r+WVB/+vfPxyy/G9hXKHpy
         quyr1J7m7VIlwSTfPWUsSPTZenMWir3HMotasbPtDIdo1L70nQR7WgSxTILPfXFVS7eK
         O/Sw==
X-Gm-Message-State: AOJu0YwTrUMtd0cnjYemiJXSsXtLgSulpgegMIMngZKrcWrOvG5nKB3o
	sABMMDyUor6p8mGn/aTuvhGaJZioDUH/69ilhMpZ4vctk812Vg==
X-Google-Smtp-Source: AGHT+IGwje3n2wj+C3cmRhuCtqab9yj971l+9oHM45uUPA3uLFszo+Jdtd2NfrOEa0Cb6+h7NYbTxhkPFZJoNjbW1as=
X-Received: by 2002:a1c:4b14:0:b0:40d:5cd1:7652 with SMTP id
 y20-20020a1c4b14000000b0040d5cd17652mr595182wma.15.1704292236772; Wed, 03 Jan
 2024 06:30:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM+7aWvGerEdUnsKboUg9+EoL=66k3nULHCnQgHyxsWQhUwmpw@mail.gmail.com>
 <ZZPbeUbMM3J4pH/K@kuha.fi.intel.com> <5458c2f4-b212-4e35-b870-f15fb724f41a@roeck-us.net>
In-Reply-To: <5458c2f4-b212-4e35-b870-f15fb724f41a@roeck-us.net>
From: Suniel Mahesh <sunil@amarulasolutions.com>
Date: Wed, 3 Jan 2024 20:00:25 +0530
Message-ID: <CAM+7aWvfB-TyYfwYiWiWc+RrGn9yyjr5SHagWeXqKwN44Z1H3Q@mail.gmail.com>
Subject: Re: USB PD TYPEC - FUSB302B port controller hard reset issue
To: Guenter Roeck <linux@roeck-us.net>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Kyle Tso <kyletso@google.com>, 
	Jagan Teki <jagan@amarulasolutions.com>, USB list <linux-usb@vger.kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Tue, Jan 2, 2024 at 10:39=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On Tue, Jan 02, 2024 at 11:46:34AM +0200, Heikki Krogerus wrote:
> > Hi Suniel,
> >
> > On Tue, Dec 26, 2023 at 04:14:48PM +0530, Suniel Mahesh wrote:
> > > Hi Guenter Roeck / Heikki Krogerus and all,
> > >
> > > 1.
> > > I am testing USB TYPEC PD on a Rockchip Rk3399 SOC based target which=
 has a
> > > FUSB302B TYPEC port controller.
> > >
> > > 2.
> > > My source is a wall charger which is based on Gallium Nitride (GaN II=
)
> > > technology and has four ports as follows:
> > >
> > > USB-C1: 100W PD3.0, 5V/3A, 9V/3A, 12V/3A, 15V/3A. 20V/5A. PPS: 3.3V-1=
1V/4A
> > > USB-C2: 100W PD3.0. 5V/3A. 9V/3A. 12V/3A, 15V/3A. 20V/5A PPS:3.3-11V/=
4A
> > > USB-C3: 20W PD3.0, 5V/3A, 9V/2.22A, 12V/1.67A
> > > USB-A: 18W QC3.0. 5V/3A, 9V/2A, 12V/1.5A
> > >
> > > 3.
> > > i am using latest linux-next and enabled all the relevant configs,
> > > especially:
> > > CONFIG_TYPEC=3Dy
> > > CONFIG_TYPEC_TCPM=3Dy
> > > CONFIG_TYPEC_FUSB302=3Dy
> >
> > Which kernel version?
> >
> > > 4.
> > > DT node is as follows when i use USB-C1 of wall charger:
> > >
> > >  connector {
> > >                         compatible =3D "usb-c-connector";
> > >                         label =3D "USB-C";
> > >                         data-role =3D "dual";
> > >                         power-role =3D "sink";
> > >                         try-power-role =3D "sink";
> > >                         op-sink-microwatt =3D <1000000>;
> > >                         sink-pdos =3D <PDO_FIXED(5000, 3000,
> > > PDO_FIXED_USB_COMM)
> > >                                     PDO_FIXED(12000, 3000,
> > > PDO_FIXED_USB_COMM)>;
> > >                 };
> >
> > What do you mean by "when i use USB-C1..."? Why is the above valid
> > only then and not with the other PD contracts?
> >
> > > Issue:
> > > The board power well most of the time, but may be in 1 out of 5 cold =
boots,
> > > FUSB302B is getting a hard reset, as
> > > FUSB302B INTERRUPTA register bit I_HARDRST is getting set.
> > >
> > > After some digging, found out that the above behaviour is accounted t=
o when
> > > something is wrong with the CRC of
> > > the received packet (SOP - Start of Packet)
> >
> > How did you determine that the problem is a bad CRC?
> >
> > > This behaviour is seen i.e. FUSB302B getting a hard reset more on the
> > > USB-C3 port.
> > >
> > > Any pointers on how to solve this issue.
> >
> > Guenter, do you have time to take a look at this?
> >
>
> As far as I can see, the bit means that a hard reset request has been
> received from the charger. What else can the code do but to execute
> that hard reset ? On a higher level, if there is a communication problem
> due to bad CRC (i.e., a bad communication link) between the wall charger
> and the development system, I am not sure if there is anything we can do
> in software to remedy the problem.
>
> Secondary question: Is this a regression ? The original e-mail states
> that it was seen with the "latest linux-next". If it is a regression, it
> should be possible to bisect it. However, the only recent commit which
> might affect reset behavior is a6fe37f428c1 ("usb: typec: tcpm: Skip hard
> reset when in error recovery"). If anything I would assume that this
> commit would improve the situation, not make it worse.

I have tested linux-next, linux-lts (v6.1) and linux-stable branches.

linux-next atleast reboots after it(FUSB302B) gets a hard reset
some branches in LTS, development board power is cutoff during
negotiation and board never boots.

>
> Thanks,
> Guenter

Thanks,
Suniel

