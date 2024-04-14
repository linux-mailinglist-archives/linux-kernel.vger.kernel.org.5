Return-Path: <linux-kernel+bounces-143968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 259BF8A402D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 06:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43CF41C210EF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 04:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C3F56B81;
	Sun, 14 Apr 2024 04:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcxGiSaZ"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A6D17BBA;
	Sun, 14 Apr 2024 04:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713067428; cv=none; b=XlGtPEAxD2oIA3GZELIAfdBa2eJjdXDLk1Iy2jXAqr6Fbb/yhPlY7ISbi8MF5+zVdKi2QYL5euAHj+//NRDYX/F50DiDOzBS4B9c29nMD6hIhEWTX+CmjfM8fAkb3WsI1p7Kql5K6jzn6FO+HGiqFqVwq4bpPkQxToXvqBygDq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713067428; c=relaxed/simple;
	bh=UvulKxToBJa2V9rLoni4ZsRrzy6iwvrW6I6kTAFYC60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQZZj2Vxb0sOzkGgvXNrjTAbe6KY67d556OvGqlJmVeQUBzVcbRiXPgJDELalKJ6S06Q4MWY57RuIVONFii90LB+AQ9RzWqfBSeXojLKGOXSwOkBUYL0N9GYnWbqR+icEodXzeqcJhloXor5vRMkdw9wEvJuCfguFl6BkgENaFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcxGiSaZ; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso1682214a12.3;
        Sat, 13 Apr 2024 21:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713067426; x=1713672226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Ok46bha88LZu6vC4j3blq4Xh4fTHbIZSTY67Ht00pM=;
        b=kcxGiSaZ8l1I2M35DvGV3vRaOPfr4vKsG7tiWczt4z1cKo14cAyqBMSD517AJyK0hz
         dB8yN9BqohJhN7AU61jF3hpaIIGJvuddtpminMs/khauKgXHVt3JJjceLaMNz1j1ZgjJ
         7GJ6N/Q733UPvKVEj3lcZDIesG8DSisFsB0MIdWhKH55N5YF7juRvkFe0J3mOYvNeawL
         cH9WhwJkYkZ3VE+xQMO2/2LGt/cihza0pDzQWbuEUBaOqtv+/590Rn8L14x5fhbODnFh
         GetGc5ClPpsDy2//FEtA9sjBBAyS7ZZO7WBfnuOflAS+BRcXXgukF7GjAAn2OLGmBLKm
         Bp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713067426; x=1713672226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Ok46bha88LZu6vC4j3blq4Xh4fTHbIZSTY67Ht00pM=;
        b=DpqsaCX+otfvM0f2qPG+OyUhlaNCqTUxF8KAsDhtz+kM9ExDpesu2rr/RjOgy4qRAu
         WyezCr4VVg5zaT3QzSQCx8c5j9pllPhZhYGNVo+yd1sNedAUydbI2tOA3rjtJh5PqVQU
         rvO+nErEy3lul12+PNsRmbM5sTGdXHe+dKxqwO6Rrd59B4bliGgABFj6Bg6zZJpYo+Vn
         J7cxFbhf1iC7NQgdTlTK4zZ0F5yOApT2DTwUWQqh7Sc0FnspzzxtcngwFlFJo2ParE3B
         2C7kM3qUp+xE6HYLbqdchWVweiDNq3rqyxBJJhR4i/heYc5/y8lmnR/QEeobUAGgqke6
         HsYg==
X-Forwarded-Encrypted: i=1; AJvYcCWfzYukagZnr64zteqO9avO9rvIGtvsBUZ/0vh7/GBdqZ+gIdEWsFn6dm5uqPGtjUqGdrI2WdwcbSY+iS6oVVgJUF5z0m8g2coIJDitjRAhqs/OuhoC06N1b14lGKlR+Al/IUQmJFq6XkYbSJzPnV9V31u7WslZUuHJCkkYYVFv
X-Gm-Message-State: AOJu0YzPHblvBOZZL39iMO8xFzv8ACZMANzPaGS4JBGEnLuiXVau9sLm
	FSVsmch7beMrbaFQ6lfsikDaZX7xoxm9KKvRSkEpaPcK/oH0yOA8j371jmmfE2S5Lw12x9j/YGX
	nYuDZsTHxVRGF4E8YCFB5c4xhqYs=
X-Google-Smtp-Source: AGHT+IH55Q23XnVFIU8fCCTgNFdhxIb2sTv8GcSNR8PiT4QhIlVXSIFnlABTcyVir/hvhYJ8Tqm/4KPNAdafRa3qyyg=
X-Received: by 2002:a05:6a20:9794:b0:1a7:a6f3:1827 with SMTP id
 hx20-20020a056a20979400b001a7a6f31827mr8038484pzc.46.1713067425778; Sat, 13
 Apr 2024 21:03:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329133458.323041-2-valla.francesco@gmail.com>
 <20240329133458.323041-3-valla.francesco@gmail.com> <CAMZ6RqKLaYb+8EaeoFMHofcaBT5G2-qdqSb4do73xrgMvWMZaA@mail.gmail.com>
 <9f5ad308-f2a0-47be-85f3-d152bc98099a@hartkopp.net>
In-Reply-To: <9f5ad308-f2a0-47be-85f3-d152bc98099a@hartkopp.net>
From: Vincent Mailhol <vincent.mailhol@gmail.com>
Date: Sun, 14 Apr 2024 13:03:33 +0900
Message-ID: <CAMZ6RqKGKcYd4hAM8AVV72t78H-Kt92NXowx6Q+YCw=AuSxKuw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Documentation: networking: document ISO 15765-2:2016
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Francesco Valla <valla.francesco@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, fabio@redaril.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun. 14 Apr. 2024 at 02:29, Oliver Hartkopp <socketcan@hartkopp.net> wro=
te:
> Hi Vincent,
>
> On 13.04.24 15:11, Vincent Mailhol wrote:
> > Hi Francesco,
> >
> > Thank you for the ISO-TP documentation.
> >
> > I left a few comments, but overall, good work. Also, I did not double
> > check each individual option one by one.
> >
> > On Sat. 30 Mar 2024 at 00:06, Francesco Valla <valla.francesco@gmail.co=
m> wrote:
> >> Document basic concepts, APIs and behaviour of the ISO 15675-2:2016
> >> (ISO-TP) CAN stack.
> >>
> >> Signed-off-by: Francesco Valla <valla.francesco@gmail.com>
> >> ---
> >>   Documentation/networking/index.rst      |   1 +
> >>   Documentation/networking/iso15765-2.rst | 356 ++++++++++++++++++++++=
++
> >>   MAINTAINERS                             |   1 +
> >>   3 files changed, 358 insertions(+)
> >>   create mode 100644 Documentation/networking/iso15765-2.rst
> >>
> >> diff --git a/Documentation/networking/index.rst b/Documentation/networ=
king/index.rst
> >> index 473d72c36d61..bbd9bf537793 100644
> >> --- a/Documentation/networking/index.rst
> >> +++ b/Documentation/networking/index.rst
> >> @@ -19,6 +19,7 @@ Contents:
> >>      caif/index
> >>      ethtool-netlink
> >>      ieee802154
> >> +   iso15765-2
> >>      j1939
> >>      kapi
> >>      msg_zerocopy
> >> diff --git a/Documentation/networking/iso15765-2.rst b/Documentation/n=
etworking/iso15765-2.rst
> >> new file mode 100644
> >> index 000000000000..bbed4d2ef1a8
> >> --- /dev/null
> >> +++ b/Documentation/networking/iso15765-2.rst
> >> @@ -0,0 +1,356 @@
> >> +.. SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> >> +
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >> +ISO 15765-2:2016 (ISO-TP)
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >> +
> >> +Overview
> >> +=3D=3D=3D=3D=3D=3D=3D=3D
> >> +
> >> +ISO 15765-2:2016, also known as ISO-TP, is a transport protocol speci=
fically
> >> +defined for diagnostic communication on CAN. It is widely used in the=
 automotive
> >> +industry, for example as the transport protocol for UDSonCAN (ISO 142=
29-3) or
> >> +emission-related diagnostic services (ISO 15031-5).
> >> +
> >> +ISO-TP can be used both on CAN CC (aka Classical CAN, CAN 2.0B) and C=
AN FD (CAN
> >
> > CC is already the abbreviation of *C*lassical *C*AN. Saying CAN CC, is
> > like saying CAN Classical CAN, c.f. the RAS syndrome:
> >
> >    https://en.wikipedia.org/wiki/RAS_syndrome
> >
> > Then, considering the CAN2.0B, as far as I know, ISO-TP can also be
> > used on CAN2.0A (as long as you only use 11 bits CAN ids).
>
> The suggestion "be used both on CAN CC (aka Classical CAN, CAN 2.0B) and
> CAN FD" was from my side.
>
> And this follows the new CAN in Automation (can-cia.org) naming scheme.
> E.g. https://www.can-cia.org/can-knowledge/can/cybersecurity-for-can/
> "=E2=80=9CSafety and security=E2=80=9D specifies generic security options=
 for CAN CC and
> CAN FD protocols."
>
> So your hint to the RAS syndrome is right but in this case the this is
> intentional to be able to reference CAN CC/FD/XL content.
>
> For that reason I wanted to introduce the new CAN CC naming scheme which
> is pretty handy IMO.

I double checked. ISO 11898-1:2015 and ISO 15765-2:2016 never use the
"CC" abbreviation a single time, thus my confusion. *BUT* ISO
15765-2:2024 actually uses that naming, in the exact same way that CAN
in Automation does.

This doesn't remove the fact that I think that this naming convention
is stupid because of the RAS syndrome, but I acknowledge that CAN CC
is now the official denomination and thus, that we should adopt it in
our documentation as well.

> > So, I would rather just say:
> >
> >    ISO-TP can be used both on Classical CAN and CAN FD...
> >

(...)

> >> +    NOTE: this is not covered by the ISO15765-2:2016 standard.
> >                                          ^^^^^^^^
> > Add a space between ISO and the number. Also, update the year:
> >
> >    ISO 15765-2:2024
> >
>
> Interesting! Didn't know there's already a new version.
>
> Will check this out whether we really support ISO 15765-2:2024 ...
>
> Do you have the standard at hand right now or should we leave this as
> ISO15765-2:2016 until we know?

I have access to the newer revisions. But I never really invested time
into reading that standard (neither the 2016 nor the 2024 versions).

Regardless, here is a verbatim extract from the Foreworld section of
ISO 15765-2:2024

  This fourth edition cancels and replaces the third edition (ISO
  15765-2:2016), which has been technically revised.

  The main changes are as follows:

    - restructured the document to achieve compatibility with OSI
      7-layers model;

    - introduced T_Data abstract service primitive interface to
      achieve compatibility with ISO 14229-2;

    - moved all transport layer protocol-related information to Clause 9;

    - clarification and editorial corrections

> >> +  - ``CAN_ISOTP_DYN_FC_PARMS``: enable dynamic update of flow control
> >> +    parameters.

(...)

> >
> > Here, I would suggest the C99 designated field initialization:
> >
> >    struct sockaddr_can addr =3D {
> >            .can_family =3D AF_CAN;
> >            .can_ifindex =3D if_nametoindex("can0");
> >            .tp.tx_id =3D 0x18DA42F1 | CAN_EFF_FLAG;
> >            .tp.rx_id =3D 0x18DAF142 | CAN_EFF_FLAG;
> >    };

Typo in my previous message: the designated initializers are not
separated by colon ";" but by comma ",". So it should have been:

  struct sockaddr_can addr =3D {
        .can_family =3D AF_CAN,
        .can_ifindex =3D if_nametoindex("can0"),
        .tp.tx_id =3D 0x18DA42F1 | CAN_EFF_FLAG,
        .tp.rx_id =3D 0x18DAF142 | CAN_EFF_FLAG,
  };

> > Well, this is just a suggestion, feel free to reject it if you do not l=
ike it.
>
> At least I don't like it.
>
> These values are usually interactively given on the command line:
>
>  >            .can_ifindex =3D if_nametoindex("can0");
>  >            .tp.tx_id =3D 0x18DA42F1 | CAN_EFF_FLAG;
>  >            .tp.rx_id =3D 0x18DAF142 | CAN_EFF_FLAG;
>
> So have it in a static field initialization leads to a wrong path IMO.

There is no such limitation that C99 designated initializers should
only work with variables which have static storage duration. In my
suggested example, nothing is static.

I see this as the same thing as below example:

  int foo(void);

  int bar()
  {
          int i =3D foo();
  }

  int baz()
  {
          int i;

          i =3D foo();
  }

In bar(), the fact that the variable i is initialized at declaration
does not mean that it is static. In both examples, the variable i uses
automatic storage duration.

Here, my preference goes to bar(), but I recognize that baz() is also
perfectly fine. Replace the int type by the struct sockaddr_can type
and the scalar initialization by designated initializers and you
should see the connection.


** Different topic **

While replying on this, I encountered something which made me worry a bit:

The type of sockaddr_can.can_ifindex is a signed int:

  https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/can.h#L=
243

But if_nametoindex() returns an unsigned int:

   https://man7.org/linux/man-pages/man3/if_nametoindex.3.html

Shouldn't sockaddr_can.can_ifindex also be declared as an unsigned int?

> >
> >> +  int ret;
> >> +
> >> +  s =3D socket(PF_CAN, SOCK_DGRAM, CAN_ISOTP);
> >> +  if (s < 0)
> >> +      exit(1);
> >> +
> >> +  addr.can_family =3D AF_CAN;
> >> +  addr.can_ifindex =3D if_nametoindex("can0");
> >
> > if_nametoindex() may fail. Because you are doing error handling in
> > this example, do it also here:
> >
> >    if (!addr.can_ifindex)
> >            err("if_nametoindex()");
> >
>
> This is not really needed for an example like this.
>
> When we have a problem here the bind() syscall with fail with -ENODEV

Ack.

> >> +  addr.tp.tx_id =3D (0x18DA42F1 | CAN_EFF_FLAG);
> >> +  addr.tp.rx_id =3D (0x18DAF142 | CAN_EFF_FLAG);
> >
> > Nitpick: the bracket are not needed here:
> >
> >    addr.tp.tx_id =3D 0x18DA42F1 | CAN_EFF_FLAG;
> >    addr.tp.rx_id =3D 0x18DAF142 | CAN_EFF_FLAG;
> >
> >> +
> >> +  ret =3D bind(s, (struct sockaddr *)&addr, sizeof(addr));
> >> +  if (ret < 0)
> >> +      exit(1);
> >> +
> >> +  // Data can now be received using read(s, ...) and sent using write=
(s, ...)
> >
> > Kernel style prefers C style comments over C++. I think that should
> > also apply to the documentation:
> >
> >    /* Data can now be received using read(s, ...) and sent using write(=
s, ...) */
> >
>
> ACK
>
> >> +
> >> +Additional examples
> >> +-------------------
> >> +
> >> +More complete (and complex) examples can be found inside the ``isotp*=
`` userland
> >> +tools, distributed as part of the ``can-utils`` utilities at:
> >> +https://github.com/linux-can/can-utils
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 6a233e1a3cf2..e0190b90d1a8 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -4695,6 +4695,7 @@ W:        https://github.com/linux-can
> >>   T:     git git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-c=
an.git
> >>   T:     git git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-c=
an-next.git
> >>   F:     Documentation/networking/can.rst
> >> +F:     Documentation/networking/iso15765-2.rst
> >>   F:     include/linux/can/can-ml.h
> >>   F:     include/linux/can/core.h
> >>   F:     include/linux/can/skb.h
> >> --
> >> 2.44.0
> >>
> >>
> >
>
> Thanks for the review, Vincent!

You are welcome!

Yours sincerely,
Vincent Mailhol

