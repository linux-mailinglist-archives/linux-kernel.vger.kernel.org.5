Return-Path: <linux-kernel+bounces-105192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C6F87DA5A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 15:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8A6281F47
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 14:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8249618EA2;
	Sat, 16 Mar 2024 14:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwxaQ75s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B8F18AED;
	Sat, 16 Mar 2024 14:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710597642; cv=none; b=LzXjh0AHnfzJ0PgpAypu5vSOWmZ6c7NUjQJS34FUf36Vnf0U3nR1AW1DdbZe5y23EbSFxQ46kCAiNUSU9LpD1UklQsSr865bHGYqcX+dfv0NBO3cRdDaymHLy4NEUBwE9reYn/VdogzkNwAySx3kZlGpbIq3AJs5OXNzOI0GDZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710597642; c=relaxed/simple;
	bh=OsANXNq+J2cqDLKb0p8kEa9kLFEZDomwY/SqKXI9w5k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UugaHSBbHjxn4w6KKarS9Z5rjDAtajVBXxMUn6IIYcYQufiYvjIHTsFtT29QfMLzyVXIbVXSP5xsWPprSUd1NSNyVtvxm8XIMf7+T3bQNoCyc6wO4tMfMNY9JStWaUDOBzF5dEtJ2onViqblwZfj6JDbyHGZI2E9C2UP5xQ4pBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwxaQ75s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2323C433F1;
	Sat, 16 Mar 2024 14:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710597642;
	bh=OsANXNq+J2cqDLKb0p8kEa9kLFEZDomwY/SqKXI9w5k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CwxaQ75sL/MY2rDZYUgNRX8An/nNeL45UcRhFGqDo2TPjK4TfTs6E0HqaTDyEpXFg
	 4j5JyiOKfnuQDjm1YFEC5CnY4W73JX27Nrvpw4mpsm/Ug2dAgvi5EnGlxcGyqJWwlY
	 /8LM7egri4URcmDyAz9aeI/BaVxMdEKH78ghp+v2xsaD+sQuQwRrvW1LwQdG1pwTfZ
	 zsXRtGzztVSO0MHXQSJNDzQFvtrz8D0edy92hRg8QPbz6T07ofdMOIyoJNVcK8PWy9
	 HhaJfIho7xRuORWiU4HUrQ8JvRjla+x9jPHaQUB572CjwS4QV1COLmU0FA13p8jPPY
	 UNk2QTxlyGneg==
Date: Sat, 16 Mar 2024 14:00:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Angel Iglesias <ang.iglesiasg@gmail.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
 andriy.shevchenko@linux.intel.com, mazziesaccount@gmail.com,
 ak@it-klinger.de, petre.rodan@subdimension.ro, linus.walleij@linaro.org,
 phil@raspberrypi.com, 579lpy@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] iio: pressure: Simplify and make more clear
 temperature readings
Message-ID: <20240316140026.4daa2480@jic23-huawei>
In-Reply-To: <63d6a4b0cb2155d5c194b3b65fa60c985a6338ca.camel@gmail.com>
References: <20240313174007.1934983-1-vassilisamir@gmail.com>
	<20240313174007.1934983-5-vassilisamir@gmail.com>
	<20240314150959.585367b5@jic23-huawei>
	<20240314201718.GD1964894@vamoiridPC>
	<46389801aeb20f18affed86d979aff7a62cf36d5.camel@gmail.com>
	<ZfQPVlqv7A3zxExl@vamoirid-EDL-PC>
	<63d6a4b0cb2155d5c194b3b65fa60c985a6338ca.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Mar 2024 14:28:30 +0100
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> On Fri, 2024-03-15 at 10:05 +0100, Vasileios Amoiridis wrote:
> > On Fri, Mar 15, 2024 at 12:22:50AM +0100, Angel Iglesias wrote: =20
> > > On Thu, 2024-03-14 at 21:17 +0100, Vasileios Amoiridis wrote: =20
> > > > On Thu, Mar 14, 2024 at 03:09:59PM +0000, Jonathan Cameron wrote: =
=20
> > > > > On Wed, 13 Mar 2024 18:40:05 +0100
> > > > > Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> > > > >  =20
> > > > > > The read_press/read_humid functions need the updated t_fine val=
ue
> > > > > > in order to calculate the current pressure/humidity. Temperature
> > > > > > reads should be removed from the read_press/read_humid functions
> > > > > > and should be placed in the oneshot captures before the pressure
> > > > > > and humidity reads. This makes the code more intuitive.
> > > > > >=20
> > > > > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com> =20
> > > > >=20
> > > > > To me this makes the use of these calls less obvious than they we=
re
> > > > > previously.=C2=A0 The calls are made close to where t_fine is use=
d and
> > > > > don't have to go via the indirection of chip_info.
> > > > >=20
> > > > > So I disagree. I think this change makes the code a lot less
> > > > > clear.
> > > > >  =20
> > > >=20
> > > > This was mainly driven by the fact that I wanted to avoid reading
> > > > the temperature 3 times in case temp, press and humid are enabled
> > > > and there are consecutive buffer readings. But thank you for the
> > > > proposal I really appreciate it!
> > > >  =20
> > >=20
> > > Hi, just a side note reflecting on this. Depending on your sampling
> > > frequency
> > > and registers data shadowing, to avoid compensating with different sa=
mples
> > > between readings, we should be doing burst readings to get a bundle o=
f the
> > > temperature+pressure and/or humidity.
> > > On the bmp/bme280 and bmp380 this can be done as registers are contig=
uous on
> > > the
> > > memory. On the bmp580 this is not a problem as the values are already
> > > compensated, you`ll get always the latest reading.
> > >=20
> > > Kind regard,
> > > Angel =20
> >=20
> > Hi Angel,
> >=20
> > Thank you for pointing this out! Indeed that's true but I noticed that =
this is
> > not
> > the case for the BMP{085/180} devices. I just feel that some changes mi=
ght
> > make
> > data acquisition/processing faster for a device (like the one you propo=
sed)
> > but
> > it might make the code much more unreadable and unmaintanable. I will t=
ry and
> > see if something could be done in that sense but I feel that keeping it=
 simple
> > will
> > be good for everyone!
> >=20
> > Cheers,
> > Vasilis =20
>=20
> Yeah, data adquisition on bmp085/180 is already different as they don't s=
upport
> continuous mode as the newer models and you have to warm-up the sensor an=
d do
> one-shot readings. There's already a different code path in place for that
> models. I guess that is the price to pay to support that wide range of
> sensors...
> Anyway, this patches are already big and you're doing quite a lot of heav=
y-
> lifting right now, so don't pay much attention to my ramblings! Regardles=
s,
> happy to help with tasks polishing and updating this driver :)

If burst readings do make sense: We can reasonably assume anyone who is usi=
ng
this sensor and is using buffered mode probably wants to 'mostly' grab all =
the
channels, then a specific function that always grabs them all, plus use of
available_scan_masks =3D { ALL BITS, 0 }; will let the IIO core deal with a=
ny
cases where only some channels are requested.  This is something we
do in drivers where there is some interaction between the channels (like he=
re)
or where burst reads are much more efficient than single channels (possibly
also true here) and complexity is significant for switching between burst
and single channels reads.

That covers a lot of devices and is part of why we have the core code
do channel de-multiplexing rather than leaving it for the drivers. The other
reason that drove that complexity was unrelated to this driver (SoC ADCs wi=
th
some channels used for touchscreens, and others for unrelated purposes).

You may just want to reduce how much code you are reusing from
the oneshot single channel sysfs reads so that you can just do a single set
of readings and use them as needed for compensation etc.

Jonathan

=20
>=20
> Kind regards,
> Angel
>=20


