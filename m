Return-Path: <linux-kernel+bounces-97970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7459877292
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 18:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FF6A1F21FEB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 17:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A101A2C6B4;
	Sat,  9 Mar 2024 17:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fg4QbmRn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82361F614;
	Sat,  9 Mar 2024 17:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710006858; cv=none; b=pGK9sbIgXsz16yi/Mofb5pWY8b3ZvsnIeNFgeKZSHX7s2f914MSasFLvcx386idUUMxIVexj5wjWl8tXN+H3yrC4Ca9aV1r7RFZ2VL+BEzOGCqe/ncykY5bPipZhE+C/+32HUAmlNH0k4L9ooXrfbHdEpy5u/mYBPBfHP1YOchc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710006858; c=relaxed/simple;
	bh=dJutrtW99BrcCsPyZ56zPa48zO/PCkDYMKsPiscIP+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qv4LlUrMwiznBF+B5X/GwXNVMueXAs14hYaIhm7ZY7t7pBFZKHi6AJfl69Z4Y6UOjdOx/dQvmWfoLUeIZmnvstKEtnspKN3jOjBbz76gJkup/8s+IfVI4UJJDiOlEnNNvSgCVNtBswVmJYomOLYInpL2NdZa5tpnkO76I6TpOK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fg4QbmRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB67DC433F1;
	Sat,  9 Mar 2024 17:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710006857;
	bh=dJutrtW99BrcCsPyZ56zPa48zO/PCkDYMKsPiscIP+Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fg4QbmRn9nIu4qW52splGHZJ/LGHQegLpnlvFh8yI/caYD4oXyfpB5rK+Mg2WrfZK
	 FFEa+/GXSh2xGBjRacWzDfkgI9Og07B7+tRq9lWeT9Ne14+T4LYqqA3LMDnJZ6cx4x
	 LLxrqWO3SnlMmfDvJ7uj7OViSjPaHb4C4BmY7DeceFs1TitdpWZGjcnk48+4v1f5LB
	 WG33NqdmkOvysyREBwLT4ABcDGoksAdoC9b+zivVqyX9kgqyLtNcSa/tH6VcPueZwG
	 SGFtJ9vWMroCcIhW3RlmyqVAYzCDr6P1NILjLEmZRVAjgtmEs2oCpNSJv/YZY2wU16
	 u7K6GZbNXYFCw==
Date: Sat, 9 Mar 2024 17:54:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Frank Rowand
 <frowand.list@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>, Jonathan
 Corbet <corbet@lwn.net>, linux-spi@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Jander <david@protonic.nl>
Subject: Re: [PATCH 01/13] spi: add core support for controllers with
 offload capabilities
Message-ID: <20240309175402.22de577d@jic23-huawei>
In-Reply-To: <CAMknhBHP+x4e0kTmNTn6JNKv=VCosZhBWce1MjjFW4MZ+K2Hcg@mail.gmail.com>
References: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
	<20240109-axi-spi-engine-series-3-v1-1-e42c6a986580@baylibre.com>
	<2c74aad9-3cb9-4222-8072-e72120c2658e@sirena.org.uk>
	<CAMknhBHP+x4e0kTmNTn6JNKv=VCosZhBWce1MjjFW4MZ+K2Hcg@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 4 Mar 2024 17:21:21 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On Wed, Jan 10, 2024 at 3:36=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:
> >
> > On Wed, Jan 10, 2024 at 01:49:42PM -0600, David Lechner wrote: =20
> > > This adds a feature for specialized SPI controllers that can record
> > > a series of SPI transfers, including tx data, cs assertions, delays,
> > > etc. and then play them back using a hardware trigger without CPU
> > > intervention. =20
> > =20
> > > The intended use case for this is with the AXI SPI Engine to capture
> > > data from ADCs at high rates (MSPS) with a stable sample period. =20
> > =20
> > > Most of the implementation is controller-specific and will be handled=
 by
> > > drivers that implement the offload_ops callbacks. The API follows a
> > > prepare/enable pattern that should be familiar to users of the clk
> > > subsystem. =20
> >
> > This is a lot to do in one go, and I think it's a bit too off on the
> > side and unintegrated with the core.  There's two very high level bits
> > here, there's the pre-cooking a message for offloading to be executed by
> > a hardware engine and there's the bit where that's triggered by some
> > hardwar event rather than by software.
> > =20
>=20
> ...
>=20
> >
> > The bit where messages are initiated by hardware is a step beyond that,
> > I think we need a bit more API for connecting up the triggers and we
> > also need to have something handling what happens with normal operation
> > of the device while these triggers are enabled.  I think it could be
> > useful to split this bit out since there's a lot more to work out there
> > in terms of interfaces. =20
>=20
> Now that we have addressed the pre-cooking messages bit [1] I'm coming
> back to the hardware trigger bit. Since the hardware trigger part
> hasn't been discussed in the past, it's not so clear to me what is
> being requested here (also see specific questions below).
>=20
> [1]: https://lore.kernel.org/linux-spi/20240219-mainline-spi-precook-mess=
age-v2-0-4a762c6701b9@baylibre.com/T/#t

Mark took the spi patches so we don't need to do anything complex next
cycle. Just need the IIO driver with these additions as by the time we hit
rc1 all the dependencies will be available.

Rest were questions for Mark I think.

