Return-Path: <linux-kernel+bounces-120724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEC888DC05
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C1AF1C2819F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A14E47A7D;
	Wed, 27 Mar 2024 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/TXKLmF"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA9B1CA87;
	Wed, 27 Mar 2024 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711537585; cv=none; b=YIp9S30TKe9Yz8+bAZurZtyQPX2LLJu+PbAr4dAo0MPm8efwvneY+owAKG98ATTMWlT2fusuC4/xkSEb+7MhIKW4N5PirrW51SdKu2RFBovZyDBeKTXBanF1qNKO3H57paICvKO2rlDTaY3Nokgmypz2WYcKrSYTNTMnSLJBV5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711537585; c=relaxed/simple;
	bh=q3gcyXoKhRYf2fa69N6NdBZzbRfzKOTZ8xEHtHAX8IU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M5p+2X7MIDSIjm64B2fro56lSneYrfpMt3ZIzw480H9MF3rb+KRIy37+Afd2mSYOs4QHprGNOCkfHV2viZKqG6yYs0OgIHGqkIi1AxxPVI6Mbq3oxVXgyrI9EiqDf5q4FGnfazDRDwPqdVW8BwY0x84I35ubZHYqYz6cUME+04I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/TXKLmF; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-513da1c1f26so8189100e87.3;
        Wed, 27 Mar 2024 04:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711537582; x=1712142382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayI6BKXEd9WeONlek9wdLp9tj6kKhJtPOmCx1zPxi9Y=;
        b=k/TXKLmFi41IFRjM3qn5T1INI/8CgASOWtpdJjoZxrGL1omHZzd6DTgaD6jomsqWbv
         t8fciV7t8NO9c21jhna8pmkXLFetJLeRQi6OjvlIk6m6Y81eCupau+zP2IaDVZgnXlrk
         jg6hCPx5YzW6jNY5UKYTGWOyqcRGX+/7x93UZ5Qy/NhPgiMhP3hSkZGtoO86kjjHjEfj
         wYfMFzfQcx6VBBnWjXSTzznTDCMAF+1IwZk3Ovvw25Z1YWKD57OY5z0SQGh2KYnlfBqt
         mTrNaMphQaBUqunricz0UnXsHT7dClh2Iry2fvali3KJKnkCXnq78ziz1DHZebiKUHMh
         cb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711537582; x=1712142382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayI6BKXEd9WeONlek9wdLp9tj6kKhJtPOmCx1zPxi9Y=;
        b=YOhglBs3VBXAufvziOTopxYfiscEXO5SeNOmlVFSKRNX3d6sIzkKsr0oWbeQDN7jfC
         1kESEJe8sxi47RN5rKNuTkf+TrMDxZ1KMDk4LXfKtPrcVUTmcbXuS78U4l+J9kNtNfHA
         R7WykV7EhN50Shllwg6alTyjjiPUwFg9IkX26q8eg5emYXb9ioZHUqvxwuY9pmaFYZ7t
         pRfhk/jOaJS+r83KWkBArcU8g2XLisHGcBcZNY003aBTYLaKfc6LFGykbnV014I5MI8i
         r4JpN7h+nf6J8JY52tplpfDF7oNa+pDNTemqTcMjlN8EVsEDezNqjerzMUqtmZSS9OLY
         6wAA==
X-Forwarded-Encrypted: i=1; AJvYcCUOYxc40I3lsj5NmHjSBgRC536dqaWcFfPzHMZiQm8qbYXOCp+omr6Ie/H0WDWDdOuZ+MGE0pat/bWRvb7+J0xm1u9Kgmhd056ZZkzM4MgnWgAJxXRj59o2dioOzvGhnW8P+kT6gQe6x1wQ/99VYH+NkxOOZRVbZjB21kNZItxXHel9L2Qim8U5qI9v5XYZyU2bJ2oBBkNNEQRkjto9sEbg/J/ldAQ56A==
X-Gm-Message-State: AOJu0YwYxX5/iZFj9XtgFagu922FKtKW9eAsm2KEFObIJdypzEOEC3sI
	0JoHfBVCle0p2zvGm4sH6AQgW25xlOT4kh3mjIMUnUWS47CewhBelUH+5azcuSrlgxnXJWDyGzh
	xKQpo85X3JKHU9Z2Ew8ekSXcHGl/91MK+n7I=
X-Google-Smtp-Source: AGHT+IFnYy+AySgWrpXBEZGt4xGMs0W5jejiOVEiyuTICA6bnE05GDy9uSYbdCvYonGwLXIiFkEPLNwKn6JkxI2YreM=
X-Received: by 2002:ac2:5f91:0:b0:513:184a:ff5f with SMTP id
 r17-20020ac25f91000000b00513184aff5fmr2552363lfe.50.1711537582050; Wed, 27
 Mar 2024 04:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324150107.976025-1-hpa@redhat.com> <20240324150107.976025-2-hpa@redhat.com>
 <CAHp75Ve5201KNdjvDZYq_unHTKp9wZXPWZXDgStP8y+XjtnWWg@mail.gmail.com> <CAEth8oG7_qFuUrL+kX3ezNatWqKPqT-qiaO5NGY-N3F3ufQL9w@mail.gmail.com>
In-Reply-To: <CAEth8oG7_qFuUrL+kX3ezNatWqKPqT-qiaO5NGY-N3F3ufQL9w@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 27 Mar 2024 13:05:45 +0200
Message-ID: <CAHp75VdQtmT0G1dFhdY7TrcBj2W6GhOaVv90_T1e3MdEtiduQQ@mail.gmail.com>
Subject: Re: [PATCH v5 RESEND 1/6] platform: x86-android-tablets: other: Add
 swnode for Xiaomi pad2 indicator LED
To: Kate Hsuan <hpa@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	=?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 9:58=E2=80=AFAM Kate Hsuan <hpa@redhat.com> wrote:
> On Mon, Mar 25, 2024 at 3:30=E2=80=AFAM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sun, Mar 24, 2024 at 5:02=E2=80=AFPM Kate Hsuan <hpa@redhat.com> wro=
te:

..

> > > +/* main fwnode for ktd2026 */
> > > +static const struct software_node ktd2026_node =3D {
> > > +       .name =3D "ktd2026"
> >
> > Leave a comma, this is not a terminator.
> >
> > > +};
> >
> > When I asked about the name I relied on the fact that you have an idea
> > how it works. So, assuming my understanding is correct, this platform
> > may not have more than a single LED of this type. Dunno if we need a
> > comment about this.
>
> I'll make a comment to describe the configuration.
> This LED controller can be configured to an RGB LED like this. Also,
> it can be configured as three single-color (RGB) LEDs to show red,
> green, and blue only.
> I think the name can be "ktd2026-multi-color". Is it good for you?

My point here is that the name is static and if you have more than one
LED in the system, the second one won't be registered due to sysfs
name collisions. Question here is how many of these types of LEDs are
possible on the platform? If more than one, the name has to be
dropped. Writing this I think a comment would be good to have in any
case.

..

> > > +static int __init xiaomi_mipad2_init(void)
> > > +{
> > > +       return software_node_register_node_group(ktd2026_node_group);
> > > +}
> > > +
> > > +static void xiaomi_mipad2_exit(void)
> >
> > __exit ?
> No need.
> x86-andriod-tablet is based on platform_driver and platform_device so
> it doesn't need __exit.
>
> I put __exit and the compiler complained about the warning.
> =3D=3D=3D
> WARNING: modpost:
> drivers/platform/x86/x86-android-tablets/x86-android-tablets: section
> mismatch in reference: xiaomi_mipad2_info+0x50 (section: .init.rodata)
> -> xiaomi_mipad2_exit (section: .exit.text)
> =3D=3D=3D

This is interesting. Why then do we call them symmetrically?

Hans, do we need to have anything here been amended?

--=20
With Best Regards,
Andy Shevchenko

