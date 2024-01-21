Return-Path: <linux-kernel+bounces-32068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E705A8355FA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 14:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BDD5B22DA9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 13:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EC4374D1;
	Sun, 21 Jan 2024 13:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILrkPXEz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0F937160;
	Sun, 21 Jan 2024 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705845088; cv=none; b=KahHLmlN4xZuMDTYNBcL9RIXoIJm+l9cIGdxXJZKw46lMLYg4Gyx8qy7TwGqvw3HIb2DBAoVQ1J2V+AOLhbATKfGWpDxwKGPblF5CikHFfaIgTD7EwDsf75Ni3UwjYODyyiBe4okGwHcrm53FW38eifT8zyEz+gji6RrEkPtR8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705845088; c=relaxed/simple;
	bh=RRuaQ9+UZxnjRq0EzIx5cXmNFrlQNvdxgFQYuMRugDs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZCZs0e09+kuuDNBYhik4pv3/R34zd1zgzS1H+zvb245GHV0GyQ/98EJ8VvBkCteZETw77cEIrLmUmcIfkYkflEmh6vbPnB3WrK48SNDa+Ka17MrwHCdxiA5FOzkEcKthwKnz6hU/6Q7IzU65pBAIafml3PfSRwY1zQE/dJXkEIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILrkPXEz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A399CC433C7;
	Sun, 21 Jan 2024 13:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705845087;
	bh=RRuaQ9+UZxnjRq0EzIx5cXmNFrlQNvdxgFQYuMRugDs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ILrkPXEzoDn/HWJ+Tq1WzkeGUP3ZFCNJMPxvH7UdJzBRLl22nalPQkgg96npJZo/z
	 BYt6Y5xPNg6EqQOUqzTU2fUDwOv3Anlhi5GX9xpHCh0Tx7yNsYIEjovBP6B90/Jlmb
	 mpx+Ymtxw0LgE2fzdb2lYmSUacHN0LoyEb8FzjtOF+hMn5BQKDnxXEzdGWq75WRMeR
	 3A+v5T+yOTKb1wT45ZTM0lBmzHiRF9OUQkauvoYssnjU8ZGP0wSbsG62eGwUjte1ft
	 N7D9ixepEe26qB0BjC7hQgA3CwQW6aWDMb5s1Q1Jn5GSSGGtLcBYb78pDtI6JH7ETI
	 zZAEkB9PTrvIg==
Date: Sun, 21 Jan 2024 13:51:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Li peiyu <579lpy@gmail.com>,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/4] iio: humidity: Add driver for ti HDC302x
 humidity sensors
Message-ID: <20240121135114.5f2aa0cf@jic23-huawei>
In-Reply-To: <b349fd4a-c7e3-44f8-9908-2abe24bbd69e@gmail.com>
References: <20231211122201.9598-1-579lpy@gmail.com>
	<20231211122940.9791-1-579lpy@gmail.com>
	<d9a84e5b-9e23-4aa9-8e58-0bb9f2b224d7@metafoo.de>
	<b349fd4a-c7e3-44f8-9908-2abe24bbd69e@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 20 Jan 2024 17:14:21 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> On 20.01.24 05:17, Lars-Peter Clausen wrote:
> > On 12/11/23 04:29, Li peiyu wrote: =20
> >> Add support for HDC302x integrated capacitive based relative
> >> humidity (RH) and temperature sensor.
> >> This driver supports reading values, reading the maximum and
> >> minimum of values and controlling the integrated heater of
> >> the sensor.
> >>
> >> Co-developed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> >> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> >> Signed-off-by: Li peiyu <579lpy@gmail.com>
> >> ---
> >> =C2=A0 MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 8 +
> >> =C2=A0 drivers/iio/humidity/Kconfig=C2=A0=C2=A0 |=C2=A0 12 +
> >> =C2=A0 drivers/iio/humidity/Makefile=C2=A0 |=C2=A0=C2=A0 1 +
> >> =C2=A0 drivers/iio/humidity/hdc3020.c | 473 ++++++++++++++++++++++++++=
+++++++ =20
> > I was just trying to use this driver. Somehow the Makefile and Kconfig
> > changes were lost when the patch was applied to the IIO tree.
> >=20
> >  =20
> Apparently only the driver code was added. The new entry in the
> MAINTAINERS file is also missing.
>=20
> Best regards,
> Javier Carrasco

Gah, I clearly messed up. My guess is a messy merge that went wrong..

Anyhow, I'll post a patch to put this back in a few mins and pick it direct=
ly
given it's just putting in the missing stuff from this patch.

That will be on the fixes-togreg branch of iio.git shortly.

Extra tags etc are fine, but I'm keen to get this into linux-next at least
quickly so we get some testing before I send a fixes pull request (probably
next weekend).

Sorry for the mess up!

Jonathan




