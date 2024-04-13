Return-Path: <linux-kernel+bounces-143781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A8C8A3D6D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 691F328214A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B0F46421;
	Sat, 13 Apr 2024 15:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APPgoGnp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DD246430;
	Sat, 13 Apr 2024 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713021934; cv=none; b=k4YTk9wVWWDC+Wg70dq8HweDpUMn8wLtOD7byKM7kMcbEi554ITSVI0W2vzP5leUpCuNLL3DGhjcxReBWlhlvmOYv4ZPpavLbk2OAIip6PUjMRjgEuxP+d7N0Fq+Yj2uTwqpmiGC9KtNNCA9up3xu4YcltGsBsbAYSiBzzKqFxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713021934; c=relaxed/simple;
	bh=3Kn+y4YDBM2ctdCpS5YTUODlgq4383kifzR5wIs9IQo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JaT4X+NRF2bv5ieO++BsL80y0VvQ9roKVjHiWBo9U1cmmzQRawI4uZc+4UqAAaHW4caKMBEvMgHa8UoZ9JZjmPVtHbNLf5arIHwPex7V0+mzmuyK6dVLB81FOGrUZsnXR7y+sdi3Cvcla3lgvBHa89uEcwkFIwtW+G/IQn2B8zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APPgoGnp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579CAC113CD;
	Sat, 13 Apr 2024 15:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713021934;
	bh=3Kn+y4YDBM2ctdCpS5YTUODlgq4383kifzR5wIs9IQo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=APPgoGnp0cL3SqQyDBqwsrAH/OGfC5N1ZffOEvX/OtY8kcHnzW/PSQ76dSs6qNJb6
	 kCCUp5/vQPoLT9UTBb+Urpfgt/JSQCwlXwF2qnEeRxar6Fd8oLa+o2nXSC8EE8fDZn
	 +hCmR44mC6FmUIIQ4vFEof/sMZPlF6hql3+KjwGdzTYuf4bMySfml1XPmUZHaJAnfo
	 QJCddWkSnvo1NzWqs1lSIyg5an7aAh3ktEVyIX8AU1/hcaDYCjQvPnpThLjUDq8/dj
	 KB21GehKr3TDBCdgpPSTbRJ3k/nG7wE2KsG7Vx4/M4XTJ+y0ta2EcaJJa4MoagBkUS
	 UkNb+DkZMhDFg==
Date: Sat, 13 Apr 2024 16:25:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Kim Seer Paller <kimseer.paller@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 2/4] iio: ABI: add ABI file for the LTC2664 DAC
Message-ID: <20240413162517.4644b649@jic23-huawei>
In-Reply-To: <CAMknhBE9XihK27pRhyPwTNM3VQX=osYdDyCmjNspz1aqe_NVTw@mail.gmail.com>
References: <20240412032102.136071-1-kimseer.paller@analog.com>
	<20240412032102.136071-3-kimseer.paller@analog.com>
	<CAMknhBE9XihK27pRhyPwTNM3VQX=osYdDyCmjNspz1aqe_NVTw@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Apr 2024 16:26:17 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On Thu, Apr 11, 2024 at 10:21=E2=80=AFPM Kim Seer Paller
> <kimseer.paller@analog.com> wrote:
> >
> > Define the sysfs interface for toggle capable channels.
> >
> > Toggle enabled channels will have:
> >
> >  * out_voltageY_toggle_en =20
The big missing thing in this ABI is a reference to existing precedence.
You aren't actually defining anything new, it just hasn't yet been generali=
zed
beyond 1 device (unless you include PSK / FSK DDS drivers that are 'still' =
after
13+ years in staging!)

This patch needs to be generalizing that documentation from the ltc2688.

Probably in sysfs-bus-iio-dac

>=20
> It looks like there are 3 toggle modes.
>=20
> Two involve the notion of "enabled" outputs that I assume this attribute =
is for:
>=20
> 1. Toggling all enabled pins at the same time using a software trigger
> (global toggle bit)
> 2. Toggling all enabled pins at the same time using a hardware trigger
> (TGP pin) and toggling pins
>=20

This is presumably the tricky one as that hardware toggle may not be in
control of the host CPU.

> The third mode though looks like it uses the same toggle select
> register for selecting A or B for each channel instead of enabling or
> disabling each channel.
>=20
> 3. Toggling all pins to A or B based on the toggle select register. No
> notion of enabled pins here.
>=20
> I haven't looked at the driver implementation, but it sounds like
> out_voltageY_toggle_en and out_voltageY_symbol would be writing to the
> same register in conflicting ways. So maybe we need yet another custom
> attribute to select the currently active toggle mode?

This one feels like it could be handled as a software optimisation over
just changing the DAC value directly.

>=20
> In any case, it would be helpful if the documentation below explained
> a bit better the intention and conditions required to use each
> attribute (or add a .rst documentation file for these chips to explain
> how to use it in more detail since this is rather complex feature).
>=20
> >  * out_voltageY_raw0
> >  * out_voltageY_raw1 =20
>=20
> I guess there is no enum iio_modifier that fits this. It seems like we
> could still have out_voltageY_raw for register A so that users that
> don't need to do any toggling can use standard ABI. And maybe
> out_voltageY_raw_toggled for register B (question for Jonathan)?

There is precedence for doing it like this (ltc2688)
Note that we should only see these attribute for changes specifically
configured for 'hardware' triggered toggling.

Note that we cannot have duplicate documentation so we need to create
a common docs file covering this and existing ltc2688 ABI that overlaps.
That may need some generalising to cover both parts.

>=20
> Or just have 8 channels instead of 4 where even channels are register
> A and odd channels are register B?
>=20
> >  * out_voltageY_symbol =20
>=20
> "symbol" is a confusing name. It sounds like this just supports
> toggling one channel individually so _toggle_select would make more
> sense to me. Are there plans for supporting toggling multiple channels
> at the same time using a software trigger as well?

Again, precedence should have been called out.  It's not great ABI
but it corresponds to earlier work on Frequency Shift Keying DDS devices
(and I think Phase Shift Keying as well) in which this is call symbol.
Hence the name.

>=20
> >
> > The common interface present in all channels is:
> >
> >  * out_voltageY_raw (not present in toggle enabled channels) =20
>=20
> As mentioned above, I don't think we need to have to make a
> distinction between toggle enabled channels and not enabled channels.

Was a while back but I think that last time this turned up we concluded
we did need a different interface because the current 'toggle value'
is not in our control.  Hence you are programming one channel that
does different things - think of it as setting the Max and Min values
for a generated waveform - perhaps the toggle pin is connected to a PWM
for example.

>=20
> >  * out_voltageY_raw_available
> >  * out_voltageY_powerdown =20
>=20
> Is _powerdown a standard attribute? I don't see it documented
> anywhere. Perhaps you meant _en (via IIO_CHAN_INFO_ENABLE)?

It's there in Documentation/ABI/testing/sysfs-bus-iio
Different form simple enable (which came much later as ABI) because
it means entering a powerdown state in which a particular thing happens
on the output pin.  It is defined alongside powerdown_mode which=20
defines what happens. (often a choice between different impedance / High Z =
etc)


>=20
>=20
> >  * out_voltageY_scale
> >  * out_voltageY_offset
> >
> > Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> > ---
> >  .../ABI/testing/sysfs-bus-iio-dac-ltc2664     | 30 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  2 files changed, 31 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2664
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2664 b/Docu=
mentation/ABI/testing/sysfs-bus-iio-dac-ltc2664
> > new file mode 100644
> > index 000000000..4b656b7af
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2664
> > @@ -0,0 +1,30 @@
> > +What:          /sys/bus/iio/devices/iio:deviceX/out_voltageY_toggle_en
> > +KernelVersion: 5.18
> > +Contact:       linux-iio@vger.kernel.org
> > +Description:
> > +               Toggle enable. Write 1 to enable toggle or 0 to disable=
 it. This is
> > +               useful when one wants to change the DAC output codes. T=
he way it should
> > +               be done is:
> > +
> > +               - disable toggle operation;
> > +               - change out_voltageY_raw0 and out_voltageY_raw1;
> > +               - enable toggle operation.
> > +
> > +What:          /sys/bus/iio/devices/iio:deviceX/out_voltageY_raw0
> > +What:          /sys/bus/iio/devices/iio:deviceX/out_voltageY_raw1
> > +KernelVersion: 5.18
> > +Contact:       linux-iio@vger.kernel.org
> > +Description:
> > +               It has the same meaning as out_voltageY_raw. This attri=
bute is
> > +               specific to toggle enabled channels and refers to the D=
AC output
> > +               code in INPUT_A (_raw0) and INPUT_B (_raw1). The same s=
cale and offset
> > +               as in out_voltageY_raw applies.
> > +
> > +What:          /sys/bus/iio/devices/iio:deviceX/out_voltageY_symbol
> > +KernelVersion: 5.18
> > +Contact:       linux-iio@vger.kernel.org
> > +Description:
> > +               Performs a SW toggle. This attribute is specific to tog=
gle
> > +               enabled channels and allows to toggle between out_volta=
geY_raw0
> > +               and out_voltageY_raw1 through software. Writing 0 will =
select
> > +               out_voltageY_raw0 while 1 selects out_voltageY_raw1.
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index bd8645f6e..9ed00b364 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12842,6 +12842,7 @@ M:      Kim Seer Paller <kimseer.paller@analog.=
com>
> >  L:     linux-iio@vger.kernel.org
> >  S:     Supported
> >  W:     https://ez.analog.com/linux-software-drivers
> > +F:     Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2664
> >  F:     Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
> >
> >  LTC2688 IIO DAC DRIVER
> > --
> > 2.34.1
> > =20


