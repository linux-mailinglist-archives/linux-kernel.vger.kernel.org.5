Return-Path: <linux-kernel+bounces-140173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ED38A0C60
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815D91C2160C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6133D144D31;
	Thu, 11 Apr 2024 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="avKDZ3JH"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFE714263A;
	Thu, 11 Apr 2024 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712827668; cv=none; b=G79OsV3CROOkT5ZHVa6SYr2fBYUQetC1fxIP7JHEXb//7KQ2aRbjQKrHk1QITyF7IgdxddXILi+QlcVyGeDnbxez6CSp9zbh8lAkz4tlXKBoMyr8uE6zyZTM+c1CYfvdhsccx9zD0E4CJojyknYRhRNzXFQaADpObaCOpN/xyoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712827668; c=relaxed/simple;
	bh=BUX3q6uB8fMbKKJnsl2nqHWR9WoGSzMH9fjDG70Smv8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=OC6jndfH765zqQ7fMlt11HbKbCe3hHID3o+bNS+EMX4r5QIM6FApPZRRIkOwJdT7Gd1f9p9fdSxhM7uLj2Eb86liK+px91Gdi6PbpqVpr/L66OALiQp6TaPpZFzDQzP6ww3rw645EPgoHfxbSJfO/Tq4cagjL7winsKvSP7LiJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=avKDZ3JH; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 99C1540006;
	Thu, 11 Apr 2024 09:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712827664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zSgBA8xW2dbaQwRIZ3MOom2jnWkBfYRk1zCKM74gmQ=;
	b=avKDZ3JHvpH9EEjrmu7G3yzibfjjR8gjjEQTw5w/RtaNfV6OUc+EkUCt+4KPlgE0vCsBni
	MLI3cWixxeI7NhmZOKyHWqmKyqEVjmlvO4Fibu6JJJBZ/XH4amnqKzOI55nGGvZ1aMyhcR
	NQhkKRvpLsBYTjgc0Ay8uCHR2/o8C7zqM84aS6jORZ05ay0S+ZwbDNacIsxydj+gREpmj3
	u8rzkHqSCw8AB4LNylgLMsYgwzH7K8GKGZmGxof1k8ClTIlr9SIBoGeD4VwGKzrFQS/pZW
	fSARUFWQgsnsDRv56FQTUMhtMJWMvQi5QgoYvl0TiCA4jIHScK8s/ub0jj3Feg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 11:27:43 +0200
Message-Id: <D0H6QDTNE0FO.27IGZ1AWYO11S@bootlin.com>
To: "Mark Brown" <broonie@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v3 4/9] spi: cadence-qspi: allow FIFO depth detection
Cc: "Rob Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Vaishnav Achath" <vaishnav.a@ti.com>, "Thomas Bogendoerfer"
 <tsbogend@alpha.franken.de>, "Rob Herring" <robh@kernel.org>,
 <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mips@vger.kernel.org>, "Vladimir
 Kondratiev" <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
X-Mailer: aerc 0.15.2
References: <20240410-cdns-qspi-mbly-v3-0-7b7053449cf7@bootlin.com>
 <20240410-cdns-qspi-mbly-v3-4-7b7053449cf7@bootlin.com>
 <161eebc1-9417-4ab0-ad8c-c1b17be119b4@sirena.org.uk>
In-Reply-To: <161eebc1-9417-4ab0-ad8c-c1b17be119b4@sirena.org.uk>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Wed Apr 10, 2024 at 10:03 PM CEST, Mark Brown wrote:
> On Wed, Apr 10, 2024 at 11:29:07AM +0200, Th=C3=A9o Lebrun wrote:
>
> > If FIFO depth DT property is provided, check it matches what hardware
> > reports and warn otherwise. Else, use hardware provided value.
> >=20
> > Hardware exposes FIFO depth indirectly because
> > CQSPI_REG_SRAMPARTITION is partially read-only.
>
> This breaks an allmodconfig build:
>
> /build/stage/linux/drivers/spi/spi-cadence-quadspi.c: In function =E2=80=
=98cqspi_of_get_
> pdata=E2=80=99:
> /build/stage/linux/drivers/spi/spi-cadence-quadspi.c:1506:45: error: unus=
ed vari
> able =E2=80=98ddata=E2=80=99 [-Werror=3Dunused-variable]
>  1506 |         const struct cqspi_driver_platdata *ddata =3D cqspi->ddat=
a;
>       |                                             ^~~~~
> /build/stage/linux/drivers/spi/spi-cadence-quadspi.c: In function =E2=80=
=98cqspi_control
> ler_detect_fifo_depth=E2=80=99:
> /build/stage/linux/drivers/spi/spi-cadence-quadspi.c:1582:45: error: unus=
ed vari
> able =E2=80=98ddata=E2=80=99 [-Werror=3Dunused-variable]
>  1582 |         const struct cqspi_driver_platdata *ddata =3D cqspi->ddat=
a;
>       |                                             ^~~~~
> cc1: all warnings being treated as errors

I really should fix my kernel compiler warnings. Sorry about that.
Will fix next revision.

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


