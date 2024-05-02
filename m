Return-Path: <linux-kernel+bounces-166749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 552F78B9EE4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12CE1F22FB6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727F316D4D4;
	Thu,  2 May 2024 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvSVvB61"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D71E1EA6F;
	Thu,  2 May 2024 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714668689; cv=none; b=f/HiCJyTBqCyr4hgeQOf//7WEINWKT67J1bPaOM5UUAMF/1AE3Od0fHJviDKAksBhRMR5ocwTFRZpWiHnpWIWLDOmqCODHkjmM0mq4yDy60HkB38+u46+XciLBelR1kfZqEyepsBbYInl9OT1ePtZJY0cFhGspbhOle0OTpWbT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714668689; c=relaxed/simple;
	bh=OHjeZeI4MZi130KNodmkNYdmSRbL11ZHV6UaEXjwIN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iThR1GoUDb6UFeoRrk9aE6IZz4A2NNp8gbmKvCB+92P4MEx7qhA3DIVr9EcB/PPUjwFMjbhOlfbeMRfQIpeV9TidGyGe6GywG+Cb2m6jq/kIZK/ysz2gqW4Fkpao4ttfbW66MOUCHS5Y9Sj4bT6ZaUG6X8cUCDDNcqrQj6j8eF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvSVvB61; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ed3cafd766so7383182b3a.0;
        Thu, 02 May 2024 09:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714668688; x=1715273488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zb2LQ7ZyHWxH6durNQbJmMpdtE7d3QFAS1SL6VR1M9c=;
        b=bvSVvB61EOUWdYeTkBK8APBf/LvXN5XpLhcU/eFVytEPXwoNTFdX9ZjK/+XeiNr/ir
         Cwv+KX1YLFTCDyf/s9OrdHErBMGM1UHsLk8PP1/HPuAFoOm4Ib8xxGsqhl3lY6+OOULD
         xh+KTCEhg3aWkNkLrrgueAYx7iKc5ZAjfVyS2tKrYnC7CvinCP4Er4ZV3A8M2YR9mwwJ
         Qzi86mPt+a9eM5S1GRo3NJprlSqBRmsaGUOC+5bdjwDpexIYxFkosBpIuNq7qXId2f7r
         gSx4IDcM+6ojWf22adj5gUmFpLD4g6aTMHXqx9/HWfvL3yYb/4LN0XKwFyqz1DzXr0i1
         zALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714668688; x=1715273488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zb2LQ7ZyHWxH6durNQbJmMpdtE7d3QFAS1SL6VR1M9c=;
        b=nD09c5FPO7Rj4lSmzaYKcY5fTxGPQJiVBdBscNQdna8Q/lqHJP7GOjm9DQx2XUB9nF
         gG/1f4iMyE7t6mVcqnUpUL0JNervitFNOO8GzV2olmRgQCWux5/oo5+0v6vHZYz0LT/V
         XEIn349cDJjywb7EPK6Ca010ca8NvNNvmTmFEgEj7TJqMN4M/sqR4yvpaoG3OGFWnb5N
         p7vE2T68WIUbnagefrEZ65GhsfjZ7pTLfoN63YhD+xxEl3yaaSYnc5MYuIVRerbB0n9m
         AYYyT+YnjQ0SeB+Ih17baie4PHDUIw1k7/Ja8Ji+VRQx5hCUaeVsmZ35JDY+Ruqcy1MN
         NoPA==
X-Forwarded-Encrypted: i=1; AJvYcCUY+dn6OmROsX4yLcp4pGnlgEd1NfrHbmEVv7AeRUgZ3BPueLj1rIPhjK/iySFXklmPNVZ2BsDeYS6fUVkGHAuWnPje6hHQCF/EnkutEWe0PwkPkKEV/eSm4p6dGklJ8C+6YaatPTZ4y1r8wylBxWBFWwtwV9XmqvuGzty4MmVcUOH+58VmBQ==
X-Gm-Message-State: AOJu0YzUCA9VUl1wSOHJoMEW7yUL2j6dy7sdxWOeJH8YalfHvyK7d6KH
	o9BUEnwBfKXb+Gl25Ta+1DA2VKSM4vWRt9O3CKhK+f7Z6q/Xp67orXKjqRSC/WeK3I9MBAU7Qdd
	6jiU5L/fvpMV2Ol3BZa1Y23B1OB4=
X-Google-Smtp-Source: AGHT+IE4L/gTAyjTdmR5GRd/iAA9g48rAosir3aWSZYrXAJKAi3C3OZ7Qth6wGGpGQJkCXAaUDlQOOcsmhbVVkiaJyE=
X-Received: by 2002:a05:6a21:3d94:b0:1a7:5334:fbf3 with SMTP id
 bj20-20020a056a213d9400b001a75334fbf3mr230314pzc.55.1714668687682; Thu, 02
 May 2024 09:51:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501084110.4165-2-shresthprasad7@gmail.com> <f1707254-ec32-4884-275a-c3c85b48d7d5@linux.intel.com>
In-Reply-To: <f1707254-ec32-4884-275a-c3c85b48d7d5@linux.intel.com>
From: Shresth Prasad <shresthprasad7@gmail.com>
Date: Thu, 2 May 2024 22:21:16 +0530
Message-ID: <CAE8VWiJy-2x6sKCAmN69Uq9Kf1cTRnaJezOoLDyZ0SbgPWuHAQ@mail.gmail.com>
Subject: Re: [PATCH v2][next] tty: sunsu: Simplify device_node cleanup by
 using __free
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: davem@davemloft.net, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, javier.carrasco.cruz@gmail.com, 
	skhan@linuxfoundation.org, Julia Lawall <julia.lawall@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 9:35=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Wed, 1 May 2024, Shresth Prasad wrote:
>
> > Add `__free` function attribute to `ap` and `match` pointer
> > initialisations which ensure that the pointers are freed as soon as the=
y
> > go out of scope, thus removing the need to manually free them using
> > `of_node_put`.
> >
> > This also removes the need for the `goto` statement and the `rc`
> > variable.
> >
> > Tested using a qemu x86_64 virtual machine.
>
> Eh, how can you test this with an x86_64 VM ???
>
> config SERIAL_SUNSU
>         tristate "Sun SU serial support"
>         depends on SPARC && PCI
>

By that, I mean that I compiled the kernel and ran the produced bzImage
on a x86_64 qemu machine.
I unfortunately don't have the hardware to test it on, but I don't
think the change is complex enough to require testing on real hardware
(unless I'm assuming incorrectly).

Regards,
Shresth

> > Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> > Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
> > ---
> > Changes in v2:
> >     - Specify how the patch was tested
> >
> >  drivers/tty/serial/sunsu.c | 37 +++++++++++--------------------------
> >  1 file changed, 11 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
> > index 67a5fc70bb4b..0f463da5e7ce 100644
> > --- a/drivers/tty/serial/sunsu.c
> > +++ b/drivers/tty/serial/sunsu.c
> > @@ -1382,44 +1382,29 @@ static inline struct console *SUNSU_CONSOLE(voi=
d)
> >
> >  static enum su_type su_get_type(struct device_node *dp)
> >  {
> > -     struct device_node *ap =3D of_find_node_by_path("/aliases");
> > -     enum su_type rc =3D SU_PORT_PORT;
> > +     struct device_node *ap __free(device_node) =3D
> > +                         of_find_node_by_path("/aliases");
> >
> >       if (ap) {
> >               const char *keyb =3D of_get_property(ap, "keyboard", NULL=
);
> >               const char *ms =3D of_get_property(ap, "mouse", NULL);
> > -             struct device_node *match;
> >
> >               if (keyb) {
> > -                     match =3D of_find_node_by_path(keyb);
> > +                     struct device_node *match __free(device_node) =3D
> > +                                         of_find_node_by_path(keyb);
> >
> > -                     /*
> > -                      * The pointer is used as an identifier not
> > -                      * as a pointer, we can drop the refcount on
> > -                      * the of__node immediately after getting it.
> > -                      */
> > -                     of_node_put(match);
> > -
> > -                     if (dp =3D=3D match) {
> > -                             rc =3D SU_PORT_KBD;
> > -                             goto out;
> > -                     }
> > +                     if (dp =3D=3D match)
> > +                             return SU_PORT_KBD;
> >               }
> >               if (ms) {
> > -                     match =3D of_find_node_by_path(ms);
> > +                     struct device_node *match __free(device_node) =3D
> > +                                         of_find_node_by_path(ms);
> >
> > -                     of_node_put(match);
> > -
> > -                     if (dp =3D=3D match) {
> > -                             rc =3D SU_PORT_MS;
> > -                             goto out;
> > -                     }
> > +                     if (dp =3D=3D match)
> > +                             return SU_PORT_MS;
> >               }
> >       }
> > -
> > -out:
> > -     of_node_put(ap);
> > -     return rc;
> > +     return SU_PORT_PORT;
> >  }
> >
> >  static int su_probe(struct platform_device *op)
> >

