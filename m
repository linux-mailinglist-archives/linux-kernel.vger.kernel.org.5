Return-Path: <linux-kernel+bounces-152225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1055B8ABAF8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 12:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D4E5B21569
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 10:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523361803A;
	Sat, 20 Apr 2024 10:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpycxb1j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2D9EAE5;
	Sat, 20 Apr 2024 10:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713608563; cv=none; b=Gy2u9iWiatA4JXuWt9ekMDYDb2fVhuxxFvdhHWKiuYp15Pjq1hsw/K6Nski/TVsERHM+wvUgOXCgx4Juxz3SZQAU4KY66oIJEzswvbxxuaWXDKmIUIqS3iPDTGzhNi3v5I4bWxl3Dle3zWF1dfhBDYd2n/UIoEM+kFx8JXlu3wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713608563; c=relaxed/simple;
	bh=KRtH72COXg4XKcrIj0lhwKQkoqKmJzEaOOAWH2FjFQk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VbJ2Z+l8Tf3rP1lpBVKt8o4GKosL0p7dU1SA2h/0cj9g2piIs1fI16MFnn0ynWyG+8dURcaRkBLt9SlmbRt0CQpXIqfLSWpSebopVLusf7kou7OVQDQL+MnyHYAochmgpLU5frjYSpN+3PIAa/hxNYogsCwwA7JOehKgqJqZf8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpycxb1j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B33EC072AA;
	Sat, 20 Apr 2024 10:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713608563;
	bh=KRtH72COXg4XKcrIj0lhwKQkoqKmJzEaOOAWH2FjFQk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bpycxb1j1WgaWm62gv8gWE8Dnz0r7rYgTJSE8LHqlRvPNp8kJ5wAP9Qb+1CtFtkAz
	 ODoY/c2HrPIg6z9fwrqtBTrv+4LV4xrfj4LvYz/1olRC1WHGFFLsfwJkjTnGYBTuIv
	 wheBxPgi6UtmNeL6zkuwYDSGpqZ1qhQJOLXLz8uv9pIReEHWGbY9HwvYg77xEkUAp8
	 nozbx89XxKU3lkudnk6IJYL9Rz/5eRHG8h1rxxDJjfXUZFEmwsmUADxufVVdNWjgLu
	 FHrOs+oJryXceLjidSeArlk5p+iQETS8YBw03LEkmpC9gGjrOrmSrfs4yqOxQW0Tn+
	 uamdLgJzepI3g==
Date: Sat, 20 Apr 2024 11:22:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Kim Seer Paller
 <kimseer.paller@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 2/4] iio: ABI: add ABI file for the LTC2664 DAC
Message-ID: <20240420112227.68577ac0@jic23-huawei>
In-Reply-To: <79734a9f54e320cd09aab83015f1c0e6d93e700c.camel@gmail.com>
References: <20240412032102.136071-1-kimseer.paller@analog.com>
	<20240412032102.136071-3-kimseer.paller@analog.com>
	<CAMknhBE9XihK27pRhyPwTNM3VQX=osYdDyCmjNspz1aqe_NVTw@mail.gmail.com>
	<20240413162517.4644b649@jic23-huawei>
	<79734a9f54e320cd09aab83015f1c0e6d93e700c.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Apr 2024 14:45:52 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Sat, 2024-04-13 at 16:25 +0100, Jonathan Cameron wrote:
> > On Fri, 12 Apr 2024 16:26:17 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >  =20
> > > On Thu, Apr 11, 2024 at 10:21=E2=80=AFPM Kim Seer Paller
> > > <kimseer.paller@analog.com> wrote: =20
> > > >=20
> > > > Define the sysfs interface for toggle capable channels.
> > > >=20
> > > > Toggle enabled channels will have:
> > > >=20
> > > > =C2=A0* out_voltageY_toggle_en=C2=A0  =20
> > The big missing thing in this ABI is a reference to existing precedence.
> > You aren't actually defining anything new, it just hasn't yet been gene=
ralized
> > beyond 1 device (unless you include PSK / FSK DDS drivers that are 'sti=
ll'
> > after
> > 13+ years in staging!)
> >=20
> > This patch needs to be generalizing that documentation from the ltc2688.
> >=20
> > Probably in sysfs-bus-iio-dac
> >  =20
> > >=20
> > > It looks like there are 3 toggle modes.
> > >=20
> > > Two involve the notion of "enabled" outputs that I assume this attrib=
ute is
> > > for:
> > >=20
> > > 1. Toggling all enabled pins at the same time using a software trigger
> > > (global toggle bit)
> > > 2. Toggling all enabled pins at the same time using a hardware trigger
> > > (TGP pin) and toggling pins
> > >  =20
> >=20
> > This is presumably the tricky one as that hardware toggle may not be in
> > control of the host CPU.
> >  =20
> > > The third mode though looks like it uses the same toggle select
> > > register for selecting A or B for each channel instead of enabling or
> > > disabling each channel.
> > >=20
> > > 3. Toggling all pins to A or B based on the toggle select register. No
> > > notion of enabled pins here.
> > >=20
> > > I haven't looked at the driver implementation, but it sounds like
> > > out_voltageY_toggle_en and out_voltageY_symbol would be writing to the
> > > same register in conflicting ways. So maybe we need yet another custom
> > > attribute to select the currently active toggle mode? =20
> >=20
> > This one feels like it could be handled as a software optimisation over
> > just changing the DAC value directly. =20
>=20
> Things may be slightly different in these devices. But for ltc2688 and AF=
AIR,
> the symbol attribute is about toggling between A and B through SW (not re=
ally
> enabling the mode). That interface will only pop up if there's no HW (PWM=
 for
> example) toggle present.

I can't remember if we discussed it at the time of that driver,
but from a userspace interface point of view, for a single channel there wo=
uld
be little point in this. I guess the key is it simultaneously switches
a bunch of channels.  Perhaps we can make that clearer in the ABI docs
(if it isn't already clear enough!)

So a software interface does seem appropriate.

There is a fun question of whether the toggle select is useful to software.
That is picking which of A or B each output uses for next toggle.
At first glance I don't think so, but I'm open to people suggesting why
that might need a userspace interface.
Superficially feels like anything that can be done with that interface can
also be done keeping all channels toggling to A or all to B at one time and
potentially a few more register writes.

Jonathan

