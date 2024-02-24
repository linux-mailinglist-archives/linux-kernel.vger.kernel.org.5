Return-Path: <linux-kernel+bounces-79576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B958862464
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E596282928
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56692250FE;
	Sat, 24 Feb 2024 11:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEckkG1T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC0C210E8;
	Sat, 24 Feb 2024 11:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708772817; cv=none; b=HMx+hcoTPpaRVrym1ltl2HmP/KLmBI1pg+R557YiOFqnf162oeRZIH7XbqOEcBsirmvHKjmxg2oR8SFzQ5FIyMG/Tmw5n2+mPH0hJahyl/hYZ8z/nKGU7rFx1z4Jhu9ArPHm+MFAQqU5w/uFfdPlatN21sI51zRVsRo3D4DhMbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708772817; c=relaxed/simple;
	bh=cIB4znCddR1qjmuiBmTbiIoYuJDVKe+FBFWQftUxBM0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i62Kjd9i+XnKUmT+EISWqcwy6qVsQ/eZqgQ7Ka1qkxbVv1W85m43RZQS4VuxKypXf+LdfTdNAOphSrFvyvWR9kaqbd6jtLQZO8z+J87r+V2sRamRuMC/ayhLkuDmVIUJn1s+6F+wjUiQS/+h4MYwfcdbOITXMaPEmW/tbBNsHI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEckkG1T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49027C433C7;
	Sat, 24 Feb 2024 11:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708772816;
	bh=cIB4znCddR1qjmuiBmTbiIoYuJDVKe+FBFWQftUxBM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SEckkG1TSUc8e8L34eytMZdolSDt5McplEXt4l9EmI09MQzp+dNKaEMdKfUNKmblM
	 JP8EVMTn9k/6oQBVghZmzN6eEi1WQcZ3FZZAX4Kqf8LVa1v0+RvD8dfWiXQaxRXSr9
	 Dn4Nzq7vSu38JN0yYyaQXhi5sDVm70HpK68D2oBrJm5XT8/Y2WeAD185YmmECIE4gN
	 RDJLmQxkLgNkiD/y+oCEkNmCYdvQJtJlz7TCEcOtdaIrxG8U9zYBtdYRdSozQmgWXY
	 CD/MDh+WUHNRj26XJ6jZ7qvUPsTnQEfXWghSVGad18Diln1uhxc0p35mchq5JXo9Bw
	 OjiWCKsmdaxsw==
Date: Sat, 24 Feb 2024 11:06:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, linux-kernel@vger.kernel.org, Stefan Popa
 <stefan.popa@analog.com>, Julien Stephan <jstephan@baylibre.com>
Subject: Re: [PATCH v4 2/2] iio: adc: ad7380: new driver for AD7380 ADCs
Message-ID: <20240224110640.03f3b857@jic23-huawei>
In-Reply-To: <CAMknhBGkUP2Tdze5Fa_0qTcCP_OgcTxtczKYZiH1icfuTAEe+g@mail.gmail.com>
References: <20240110-ad7380-mainline-v4-0-93a1d96b50fa@baylibre.com>
	<20240110-ad7380-mainline-v4-2-93a1d96b50fa@baylibre.com>
	<CAMknhBGkUP2Tdze5Fa_0qTcCP_OgcTxtczKYZiH1icfuTAEe+g@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Feb 2024 13:47:03 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On Wed, Jan 10, 2024 at 2:29=E2=80=AFPM David Lechner <dlechner@baylibre.=
com> wrote:
>=20
> ...
>=20
> > +
> > +/* fully differential */
> > +DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(ad7380_channels, 16);
> > +DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(ad7381_channels, 14);
> > +/* pseudo differential */
> > +DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(ad7383_channels, 16);
> > +DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(ad7384_channels, 14);
> > + =20
>=20
> Similar question to [1] in light of [2]: Since AD7383 and AD7384 are
> pseudo-differential, should we handle them differently? I.e. add
> aina-supply and ainb-supply DT properties for the negative inputs
> (typically a V_REF / 2 supply) and remove the differential flag from
> the channel spec.
>=20
> [1]: https://lore.kernel.org/linux-iio/CAMknhBH2Pqa9xpPxnTCxJegVTbOG-QDeJ=
A4YrQUPfj+hfSs73A@mail.gmail.com/
> [2]: https://lore.kernel.org/linux-iio/CAMknhBF5mAsN1c-194Qwa5oKmqKzef2kh=
XnqA1cSdKpWHKWp0w@mail.gmail.com/

Yes. I think that gives a more intuitive interface for users.
I don't think we need to 'fix' any drivers already upstream as
presenting these as differential is not an ABI error as far as I
am concerned. It's just less than ideal choices given our views
now! (as a result of these discussions on what pseudo differential
means in practice)

Jonathan

