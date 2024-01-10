Return-Path: <linux-kernel+bounces-21880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BD48295E9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21DB5B25C0B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0BF3EA70;
	Wed, 10 Jan 2024 09:09:48 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12303BB29;
	Wed, 10 Jan 2024 09:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T924T5xbbz6D8tD;
	Wed, 10 Jan 2024 17:07:21 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E421B140C72;
	Wed, 10 Jan 2024 17:09:40 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Jan
 2024 09:09:40 +0000
Date: Wed, 10 Jan 2024 09:09:40 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Liam Girdwood
	<lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: spi: add spi-rx-bus-channels
 peripheral property
Message-ID: <20240110090940.00002f31@Huawei.com>
In-Reply-To: <CAMknhBGNDV7+C4wE8ced5jhe-0eydo7g8SZMJwLnFi+y_qon_w@mail.gmail.com>
References: <20231215-ad7380-mainline-v3-0-7a11ebf642b9@baylibre.com>
	<20231215-ad7380-mainline-v3-1-7a11ebf642b9@baylibre.com>
	<20240107164356.3e8df266@jic23-huawei>
	<f431e418-0b7c-4362-be26-9d2f03e0de07@sirena.org.uk>
	<CAMknhBE7eUMzcD0bdymrhL2Lw3FubB3aHDWmJFD7YnaGNYmQ9w@mail.gmail.com>
	<0a774bc6-3bf9-4b5f-92e0-8bd673e71a33@sirena.org.uk>
	<CAMknhBGNDV7+C4wE8ced5jhe-0eydo7g8SZMJwLnFi+y_qon_w@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 8 Jan 2024 11:15:31 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On Mon, Jan 8, 2024 at 10:39=E2=80=AFAM Mark Brown <broonie@kernel.org> w=
rote:
> >
> > On Sun, Jan 07, 2024 at 05:02:56PM -0600, David Lechner wrote: =20
> > > On Sun, Jan 7, 2024 at 3:27=E2=80=AFPM Mark Brown <broonie@kernel.org=
> wrote: =20
> > =20
> > > > This makes no sense to me without a corresponding change in the SPI=
 core
> > > > and possibly controller support, though I guess you could do data
> > > > manging to rewrite from a normal parallel SPI to this for a pure
> > > > software implementation.  I also see nothing in the driver that even
> > > > attempts to parse this so I can't see how it could possibly work. =
=20
> > =20
> > > We currently don't have a controller that supports this. This is just
> > > an attempt to make a complete binding for a peripheral according to
> > > [2] which says: =20
> >
> > ...
> > =20
> > > So, will DT maintainers accept an incomplete binding for the
> > > peripheral? Or will you reconsider this without SPI core support if I
> > > can explain it better? It doesn't seem like a reasonable request to
> > > expect us to spend time developing software that we don't need at this
> > > time just to get a complete DT binding accepted for a feature that
> > > isn't being used. =20
> >
> > I don't think it's sensible to try to make a binding for this without
> > having actually tried to put a system together that uses it and made
> > sure that everything is joined up properly, the thing about complete
> > bindings is more for things that are handle turning than for things that
> > are substantial new features in subsystems. =20
>=20
> We do have plans to eventually implement such a feature in an
> FPGA-based SPI controller, so if we need to wait until then for the
> binding, then we can do that. But it would be really nice if we could
> find a way forward for the IIO driver in this series without having to
> wait for the resolution of new SPI controller feature for the complete
> DT bindings.
>=20
> DT/IIO maintainers, if I resubmit this series with the
> `spi-rx-bus-channels` parts removed from the iio/adc/adi,ad7380.yaml
> bindings, would that be acceptable? (Also resubmitting without this
> patch of course.)
>=20
=46rom IIO side of things that's fine with me.

Jonathan

