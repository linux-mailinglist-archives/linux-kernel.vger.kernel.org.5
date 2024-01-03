Return-Path: <linux-kernel+bounces-15644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BCC822F65
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C1EC1C23585
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B92D1A599;
	Wed,  3 Jan 2024 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LTtjvLXS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24FE1A596
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 14:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3368d1c7b23so9132558f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 06:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1704291972; x=1704896772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e722oByqgpHNvGYkLGBGT1QkBNwB8tcOkyv0srHUQbY=;
        b=LTtjvLXSHjXGme2Z0Zm3AG858vleSC9FMMP8JMmjAlLS8lOhBRhG+Hu6FuiqH6j+D1
         emCUZuebIZT5QM4zxe0HBC/zHnoPthGUm2+3BFA8GuZVYOHXWSs80yucJ4aRIEv2eyC4
         3ueYO73X+iog6Rv54InqswgmATMZ3NNl+NZuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704291972; x=1704896772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e722oByqgpHNvGYkLGBGT1QkBNwB8tcOkyv0srHUQbY=;
        b=U8Yos5JZRZAuxuHz0Hn79WofXY5h7aQ0Yd7KWrJfwSGcULn4G6Y8DabJcpZLt4fYBs
         M6CJtfGRmCStzZvlUA1oVHx9ku4+HmtpaHOz/FzG73qu1DU4ChMxwvCEgj8Y+DZVMA3h
         ZioacaCvL8U0SGS6haLaSmSVDvgIzOCr0oKR4MjexD+hmxOF2ta3WzyvyIklNJ3Ye71f
         /s1yzGmJZ93CwF+zvZtDm8ata08SXZ/viG8vhGH8QslC1EQMxGuuMH8IV4YuMwUGy1wW
         fBrScWE0CUB+A1sROs+1VhMwOVhuMFIp2Aun13MsgHPciwcU+jm4jultHLY85Y7WhfFZ
         hsvw==
X-Gm-Message-State: AOJu0YxCOdXMX32DTgUHUfdApIL5xT1edGnj4leK1jGVHVlu66XtqQSR
	8LycH1xjzUGG7z/5c5zBdTq9Jycd6y3+dFjsMPTGlGwq601Ovg==
X-Google-Smtp-Source: AGHT+IGuI2r//nXGoqQe8hb1yYyJOPkhJr8O+DQHx/jGjD3K0TDwb5rtlHLKE2nNFAih/hisSmIbht2maih2yoSyIc0=
X-Received: by 2002:a05:600c:3849:b0:40d:589d:cbe1 with SMTP id
 s9-20020a05600c384900b0040d589dcbe1mr7046124wmr.43.1704291972067; Wed, 03 Jan
 2024 06:26:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM+7aWvGerEdUnsKboUg9+EoL=66k3nULHCnQgHyxsWQhUwmpw@mail.gmail.com>
 <ZZPbeUbMM3J4pH/K@kuha.fi.intel.com>
In-Reply-To: <ZZPbeUbMM3J4pH/K@kuha.fi.intel.com>
From: Suniel Mahesh <sunil@amarulasolutions.com>
Date: Wed, 3 Jan 2024 19:56:00 +0530
Message-ID: <CAM+7aWu9iEZYtge489eihZUc-5KDH9xfaDfwrBA6Bzj5OPXjwA@mail.gmail.com>
Subject: Re: USB PD TYPEC - FUSB302B port controller hard reset issue
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Kyle Tso <kyletso@google.com>, 
	Jagan Teki <jagan@amarulasolutions.com>, USB list <linux-usb@vger.kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Heikki,

On Tue, Jan 2, 2024 at 3:16=E2=80=AFPM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi Suniel,
>
> On Tue, Dec 26, 2023 at 04:14:48PM +0530, Suniel Mahesh wrote:
> > Hi Guenter Roeck / Heikki Krogerus and all,
> >
> > 1.
> > I am testing USB TYPEC PD on a Rockchip Rk3399 SOC based target which h=
as a
> > FUSB302B TYPEC port controller.
> >
> > 2.
> > My source is a wall charger which is based on Gallium Nitride (GaN II)
> > technology and has four ports as follows:
> >
> > USB-C1: 100W PD3.0, 5V/3A, 9V/3A, 12V/3A, 15V/3A. 20V/5A. PPS: 3.3V-11V=
/4A
> > USB-C2: 100W PD3.0. 5V/3A. 9V/3A. 12V/3A, 15V/3A. 20V/5A PPS:3.3-11V/4A
> > USB-C3: 20W PD3.0, 5V/3A, 9V/2.22A, 12V/1.67A
> > USB-A: 18W QC3.0. 5V/3A, 9V/2A, 12V/1.5A
> >
> > 3.
> > i am using latest linux-next and enabled all the relevant configs,
> > especially:
> > CONFIG_TYPEC=3Dy
> > CONFIG_TYPEC_TCPM=3Dy
> > CONFIG_TYPEC_FUSB302=3Dy
>
> Which kernel version?

The kernel version is linux-next which is 6.7.0-rc8

>
> > 4.
> > DT node is as follows when i use USB-C1 of wall charger:
> >
> >  connector {
> >                         compatible =3D "usb-c-connector";
> >                         label =3D "USB-C";
> >                         data-role =3D "dual";
> >                         power-role =3D "sink";
> >                         try-power-role =3D "sink";
> >                         op-sink-microwatt =3D <1000000>;
> >                         sink-pdos =3D <PDO_FIXED(5000, 3000,
> > PDO_FIXED_USB_COMM)
> >                                     PDO_FIXED(12000, 3000,
> > PDO_FIXED_USB_COMM)>;
> >                 };
>
> What do you mean by "when i use USB-C1..."? Why is the above valid
> only then and not with the other PD contracts?

USB-C1, USB-C2 and USB-C3 are the receptacles/connectors on the PD Wall cha=
rger
USB-C1 and USB-C2 are idenical rated as: 100W PD3.0, 5V/3A, 9V/3A,
12V/3A, 15V/3A. 20V/5A. PPS: 3.3V-11V/4A
USB-C3 is rated as: 20W PD3.0, 5V/3A, 9V/2.22A, 12V/1.67A

now when i say "when i use USB-C1", i mean that I am using receptacle
USB-C1 on the wall charger to power
my target/development system which has a FUSB302B receptacle/connector.

irrespective of the PDO's requested, like:
PDO_FIXED(9000, 3000, PDO_FIXED_USB_COMM);
or
PDO_FIXED(12000, 3000, PDO_FIXED_USB_COMM);
or
PDO_FIXED(15000, 3000, PDO_FIXED_USB_COMM);
or
PDO_FIXED(20000, 5000, PDO_FIXED_USB_COMM);

the target/development board FUSB302B is getting a hard reset like i
mentioned in
1 out of 5 cold boots.

>
> > Issue:
> > The board power well most of the time, but may be in 1 out of 5 cold bo=
ots,
> > FUSB302B is getting a hard reset, as
> > FUSB302B INTERRUPTA register bit I_HARDRST is getting set.
> >
> > After some digging, found out that the above behaviour is accounted to =
when
> > something is wrong with the CRC of
> > the received packet (SOP - Start of Packet)
>
> How did you determine that the problem is a bad CRC?

The power contract negotiation as per my understanding is:
cable detect =3D> source sends Accept =3D> Sink responds with good CRC =3D>
source sends capabilities =3D>
=3D> sink replied with goodCRC and sink requests for a particular PDO =3D>
=3D> source sends accept =3D> sink replied with goodCRC =3D>
=3D> source sends PS_RDY to sink =3D> sink replied with goodCRC and gets
bound to desired contract from source.

However in some scenarios, based on below log, i guessed it as bad
CRC: (RX, header is 0x0)
[    1.599074] FUSB302: IRQ: 0x80, a: 0x00, b: 0x00, status0: 0x83
[    1.602877] FUSB302: IRQ: 0x00, a: 0x40, b: 0x00, status0: 0x83
[    1.605978] TCPM: tcpm_pd_event_handler:
[    1.606575] TCPM: tcpm_pd_event_handler: in TCPM_CC_EVENT
[    1.967732] FUSB302: IRQ: 0x80, a: 0x00, b: 0x00, status0: 0x83
[    2.132493] FUSB302: IRQ: 0x41, a: 0x04, b: 0x00, status0: 0x93
[    2.133057] FUSB302: IRQ: PD tx success
[    2.135446] TCPM: PD TX complete, status: 0
[    2.138529] FUSB302: IRQ: 0x51, a: 0x00, b: 0x00, status0: 0xd1
[    2.141351] FUSB302: IRQ: 0x51, a: 0x00, b: 0x01, status0: 0x93
[    2.141968] FUSB302: IRQ: PD sent good CRC
[    2.144321] FUSB302: fusb302_pd_read_message: to tcpm_pd_receive
[    2.144912] TCPM: PD RX, header: 0x1a3 [1]
[    2.145479] TCPM: tcpm_pd_ctrl_request: type:0x3
[    2.145873] TCPM: tcpm_pd_ctrl_request: case PD_CTRL_ACCEPT
[    2.146309] TCPM: tcpm_pd_ctrl_request: case SOFT_RESET_SEND
[    2.146706] TCPM: tcpm_pd_rx_handler: done
[    2.154971] FUSB302: IRQ: 0x51, a: 0x00, b: 0x01, status0: 0x93
[    2.155374] FUSB302: IRQ: PD sent good CRC
[    2.158067] FUSB302: fusb302_pd_read_message: to tcpm_pd_receive
[    2.158496] TCPM: PD RX, header: 0x0 [1]
[    2.159030] TCPM: tcpm_pd_rx_handler: done
[    2.176842] FUSB302: IRQ: 0x41, a: 0x01, b: 0x00, status0: 0x83
[    2.177298] FUSB302: IRQ: PD received hardreset: interrupta: 1
[    2.177850] FUSB302: fusb302_pd_reset:
[    2.179471] TCPM: tcpm_pd_event_handler:
[    2.179919] TCPM: tcpm_pd_event_handler: TCPM_RESET_EVENT
[    2.180449] TCPM: _tcpm_pd_hard_reset: Received hard reset
[    2.181099] TCPM4: _tcpm_pd_hard_reset:

board(FUSB302B hard reset) reboots

when i use a USB-C3 receptacle on wall charger with rating: 20W PD3.0,
5V/3A, 9V/2.22A, 12V/1.67A
and device tree node as:
connector {
                        compatible =3D "usb-c-connector";
                        label =3D "USB-C";
                        data-role =3D "dual";
                        power-role =3D "sink";
                        try-power-role =3D "sink";
                        op-sink-microwatt =3D <1000000>;
                        sink-pdos =3D <PDO_FIXED(5000, 3000, PDO_FIXED_USB_=
COMM)
                                    PDO_FIXED(12000, 1670, PDO_FIXED_USB_CO=
MM)>;
                };
log when FUSB302B gets a hard reset: (here it might or might not be a bad C=
RC ?)

[   1.602441] FUSB302: IRQ: 0x80, a: 0x00, b: 0x00, status0: 0x83
[    1.606642] FUSB302: IRQ: 0x00, a: 0x40, b: 0x00, status0: 0x83
[    1.609672] TCPM: tcpm_pd_event_handler:
[    1.610240] TCPM: tcpm_pd_event_handler: in TCPM_CC_EVENT
[    1.976170] FUSB302: IRQ: 0x80, a: 0x00, b: 0x00, status0: 0x83
[    2.136304] FUSB302: IRQ: 0x41, a: 0x04, b: 0x00, status0: 0x93
[    2.136916] FUSB302: IRQ: PD tx success
[    2.139148] TCPM: PD TX complete, status: 0
[    2.141867] FUSB302: IRQ: 0x51, a: 0x00, b: 0x01, status0: 0x93
[    2.142325] FUSB302: IRQ: PD sent good CRC
[    2.144775] FUSB302: fusb302_pd_read_message: to tcpm_pd_receive
[    2.145313] TCPM: PD RX, header: 0x1a3 [1]
[    2.145886] TCPM: tcpm_pd_ctrl_request: type:0x3
[    2.146281] TCPM: tcpm_pd_ctrl_request: case PD_CTRL_ACCEPT
[    2.146716] TCPM:tcpm_pd_ctrl_request: case SOFT_RESET_SEND
[    2.147113] TCPM: tcpm_pd_rx_handler: done
[    2.167042] FUSB302: IRQ: 0x41, a: 0x01, b: 0x00, status0: 0x83
[    2.167495] FUSB302: IRQ: PD received hardreset: interrupta: 1
[    2.168047] FUSB302: fusb302_pd_reset:
[    2.169988] TCPM: tcpm_pd_event_handler:
[    2.170395] TCPM: tcpm_pd_event_handler: TCPM_RESET_EVENT
[    2.170785] TCPM: _tcpm_pd_hard_reset: Received hard reset
[    2.171290] TCPM4: _tcpm_pd_hard_reset:

 when FUSB302B negotiates for a contract on USB-C3 receptacle, the
FUSB302B gets hard reset more
 number of times compared to USB-C1/C2.

>
> > This behaviour is seen i.e. FUSB302B getting a hard reset more on the
> > USB-C3 port.
> >
> > Any pointers on how to solve this issue.
>
> Guenter, do you have time to take a look at this?
>
> thanks,
>
> --
> heikki

Thanks,
Suniel

