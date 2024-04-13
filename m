Return-Path: <linux-kernel+bounces-143826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284958A3DE5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 19:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDAF1281E3F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AEA4D59E;
	Sat, 13 Apr 2024 17:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCnOdxm2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF396282EE;
	Sat, 13 Apr 2024 17:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713028242; cv=none; b=CSOtYuxbo7MQyx4lQ8fbogxEujDkvVxZmrWH+pP7Rt5M/QillRPjqaZScWGTmPSE/W5m66GCWfTUB9kejdIH+2xr58daVmfbBrmJBOpQ7JMnBzUxg5Cv3pR1pHIw1KI70Xr7hQrbkJ8K6WuVl3zppsxEXEO78tmmhNei8M968S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713028242; c=relaxed/simple;
	bh=IzyicTygVPL8TrsSuC1OhkdvoCcDqBn35t5oGA/FRLc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a+pvYJWoKLYSa57QCKhsfKResB3suGN/lBRZpppDeWJIsAhCz9SgF/HNljhnXoA5y8c6xeDvLyoCKRsIl+gPYXwubBFSDTKuEQuXB4dp4fipDnC2Ejsl1lIhR17bK+91Fh0POR+0YurNDfwz9R7SMf6pUIi5FljwUSbljRQ58OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCnOdxm2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9416BC2BD11;
	Sat, 13 Apr 2024 17:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713028240;
	bh=IzyicTygVPL8TrsSuC1OhkdvoCcDqBn35t5oGA/FRLc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fCnOdxm2I9+CZXrSVMKRSEdUMHRjFqbU8/cE7Prl4xN/zlIH98/2By3Vpt4qyT7Xt
	 B4gqUcLHgfZIl7RCbdHuVgXN230Gp4yyOAVX791+SWqfKm0ISLdkoYjHaRCPuOjp/1
	 NhSpYyD0R1JOGDChM2PYks4Tn+zmIsUNc0wlegpZoQdf+yB8uvmOH6ZAkSdG4INVK/
	 Dwb8YrwuSrCiEpUNYl4+YGgeetiCMwGUEuB0KGouMqqMK/Q8UUCfXDjTYRzBlb25Ct
	 0PMomrlklTkM4X2HBz5M9jAa8SJ59mZbaxtUYMsoZzRcpx89bR1SNAyjcERCYcuK0C
	 XzWRyBhrrAsgg==
Date: Sat, 13 Apr 2024 18:10:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Kim Seer Paller <kimseer.paller@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 1/4] dt-bindings: iio: dac: Add adi,ltc2664.yaml
Message-ID: <20240413181025.39d1a62e@jic23-huawei>
In-Reply-To: <CAMknhBHMd2mK3yVoH_XjW7BapX5BTRZjUJpF=ZQrF8Mctf-NJQ@mail.gmail.com>
References: <20240412032102.136071-1-kimseer.paller@analog.com>
	<20240412032102.136071-2-kimseer.paller@analog.com>
	<CAMknhBHgKK_OEcPz-5ktxj+YEkB7jHpw5owdh9HVj_qfwuVXkQ@mail.gmail.com>
	<20240413160610.4cec010b@jic23-huawei>
	<CAMknhBHMd2mK3yVoH_XjW7BapX5BTRZjUJpF=ZQrF8Mctf-NJQ@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 13 Apr 2024 11:21:55 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On Sat, Apr 13, 2024 at 10:06=E2=80=AFAM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> >
> > On Fri, 12 Apr 2024 16:23:00 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> > =20
> > > On Thu, Apr 11, 2024 at 10:21=E2=80=AFPM Kim Seer Paller
> > > <kimseer.paller@analog.com> wrote: =20
> > > > =20
>=20
> ...
>=20
> > >
> > > And there is V~ on both which can be between -5.5V/-15.75V and GND, so
> > > optional v-neg-supply seems appropriate. =20
> >
> > Only make it optional in the binding if the settings of the device chan=
ge
> > depending on whether it is there or not.  Looks like there is an intern=
al
> > reference, so maybe it really is optional. =20
>=20
> I suggested optional with the thinking that if the pin is tied to GND,
> then the property would be omitted.

We could but given VND isn't really that special in this case I think
I'd prefer a fixed voltage reg of 0V if someone does wire it like that.
(I think that works, though not sure I've tried a 0V supply ;)
>=20
>=20
> ...
>=20
>=20
> > >
> > > * (both) The MUX/MUXOUT pins look like we have an embedded pin mux, so
> > > it could mean we need #pinctrl-cells. ltc2664 would also need
> > > muxin-gpios for this. =20
> > Not convinced that's the right approach - looks more like a channel
> > selector than a conventional mux or pin control. Sure that's a mux, but
> > we want a clean userspace control to let us choose a signal to measure
> > at runtime
> >
> > If you wanted to support this I'd have the binding describe optional
> > stuff to act as a consumer of an ADC channel on another device.
> > The IIO driver would then provide a bunch of input channels to allow
> > measurement of each of the signals.
> >
> > Look at io-channels etc in existing bindings for how to do that.
> > =20
>=20
> Right. I was thinking that this pin might be connected to something
> else external rather than the signal coming back to the SoC (or
> whatever has the SPI controller). But it makes more sense that we
> would want it as extra channels being read back by the SoC for
> diagnostics.

It might indeed.  But I think that's an exercise for the future if
it matters.  Might be a debugfs control only perhaps.

>=20
> ...
>=20
> > > =20
> > > > +
> > > > +      patternProperties:
> > > > +        "^channel@([0-3])$":
> > > > +          $ref: '#/$defs/toggle-operation'
> > > > +          unevaluatedProperties: false
> > > > +
> > > > +          description: Channel in toggle functionality.
> > > > +
> > > > +          properties:
> > > > +            adi,output-range-microvolt:
> > > > +              description: Specify the channel output full scale r=
ange. =20
> > >
> > > How would someone writing a .dts know what values to select for this
> > > property? Or is this something that should be configured at runtime
> > > instead of in the devicetree? Or should this info come from the
> > > missing voltage supplies I mentioned? =20
> >
> > Sometimes this one is a wiring related choice.  Sometimes to the extent
> > that picking the wrong one from any userspace control can cause damage
> > or is at least nonsense.
> >
> > You look to be right though that the possible values here aren' fine
> > if the internal reference is used, but not the external.
> >
> > However, it's keyed off MPS pins so you can't control it if they aren't
> > tied to all high.  So I'd imagine if the board can be damaged it will
> > be hard wired.  Hence these could be controlled form userspace.
> > It's a bit fiddly though as combines scale and offset controls and
> > you can end trying to set things to an invalid combination.
> > E.g. scale set to cover 20V range and offset set to 0V
> > To get around that you have to clamp one parameter to nearest
> > possible when the other is changed.
> > =20
>=20
> Thanks for the explanation. It sounds like I missed something in the
> datasheet that would be helpful to call out in the description for
> this property.
Agreed - it needs more detail.

Jonathan



