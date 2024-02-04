Return-Path: <linux-kernel+bounces-51676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F4F848E2A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D03E22845F0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E2D224F0;
	Sun,  4 Feb 2024 13:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dd4dy9di"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3617624A0D;
	Sun,  4 Feb 2024 13:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707054071; cv=none; b=o+vZ7Z2lcNQEMJ3asKye/pcuGnjJY4+5bQ+SG403u3/Kmb6vE9yYLpnS2XbfLXEmqS8V1akL2/L0xvdcoRRxhb8eSWQ62vU7mT2oztmbOJsfdr08zokQrPyegZqck9ue1GQx2n5190UH4e5+J/OS93I6H1hMZQ9QTJXgK2MHTiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707054071; c=relaxed/simple;
	bh=QQi+L54IHlqVrO+b4uCPKhTLx6aVmrEehR+ugW8qGDg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SN2oRF/wwlFkHQfajDAFYFKsxvC5IRPg+MUUNmdfgAY+daK/Icp1NyvG/F2Lgk/9DP7ERQYYEi/D0IEqeJVf45ygdzHAlLQ5N6XLBcN5WWeGmfgUUBcu80XjQoCS8HmFhXdqH6jjWstqnoLRL9XIbjx35KnnDtJQDKul+VW3VXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dd4dy9di; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70F6C433F1;
	Sun,  4 Feb 2024 13:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707054070;
	bh=QQi+L54IHlqVrO+b4uCPKhTLx6aVmrEehR+ugW8qGDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dd4dy9diFtUypiMGrjx6IBME6EqrSvcgT+HcV2VE5xyN8S+ZMWziwfFbrP9DBaiJ4
	 krvwPlFIPg11U/hrxH9BGzFpDVy9O+fmuzvpVNChWCw/43ye+zh9Quqq5n1/d3fXm2
	 0ORaKQvD44PziYuccW0YWQjIUA1iutQ3brgh/txSLIa/KZlt5ew8LyUrgSowvs/5gZ
	 2x+LBTmhRtAm2H76m5cq5sOVhKW/zuivwTQnN+4yibhXN3SeAA5irOmEVLXneQohN6
	 HJLorwkertRv+gKLvmh/mSjCM4AhIOgPA6nMEw8iprQwoerazg+C8VZQeYTHnmv0Oe
	 q2ZCkdmQ1OwRQ==
Date: Sun, 4 Feb 2024 13:40:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Marek Vasut
 <marex@denx.de>, Anshul Dalal <anshulusr@gmail.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Matt Ranostay <matt@ranostay.sg>, Stefan
 Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] iio: light: Add support for APDS9306 Light
 Sensor
Message-ID: <20240204134056.5dc64e8b@jic23-huawei>
In-Reply-To: <fd404067-bc24-449c-94b4-f59a54c3f532@tweaklogic.com>
References: <20240121051735.32246-1-subhajit.ghosh@tweaklogic.com>
	<20240121051735.32246-4-subhajit.ghosh@tweaklogic.com>
	<20240121152332.6b15666a@jic23-huawei>
	<757a18b7-94f4-4d72-9917-5d8b1cd677f6@tweaklogic.com>
	<fd404067-bc24-449c-94b4-f59a54c3f532@tweaklogic.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 4 Feb 2024 21:53:55 +1030
Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:

> Hi Jonathan,
> >> =20
> >>> +
> >>> +static struct iio_event_spec apds9306_event_spec_als[] =3D {
> >>> +=C2=A0=C2=A0=C2=A0 {
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .type =3D IIO_EV_TYPE_THR=
ESH,
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .dir =3D IIO_EV_DIR_RISIN=
G,
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mask_shared_by_all =3D B=
IT(IIO_EV_INFO_VALUE),
> >>> +=C2=A0=C2=A0=C2=A0 }, {
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .type =3D IIO_EV_TYPE_THR=
ESH,
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .dir =3D IIO_EV_DIR_FALLI=
NG,
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mask_shared_by_all =3D B=
IT(IIO_EV_INFO_VALUE),
> >>> +=C2=A0=C2=A0=C2=A0 }, {
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .type =3D IIO_EV_TYPE_THR=
ESH,
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mask_shared_by_all =3D B=
IT(IIO_EV_INFO_PERIOD),
> >>> +=C2=A0=C2=A0=C2=A0 }, {
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .type =3D IIO_EV_TYPE_THR=
ESH_ADAPTIVE,
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mask_shared_by_all =3D B=
IT(IIO_EV_INFO_VALUE) |
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 B=
IT(IIO_EV_INFO_ENABLE),
> >>> +=C2=A0=C2=A0=C2=A0 }, {
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mask_separate =3D BIT(II=
O_EV_INFO_ENABLE), =20
> >>
> >> What's the intent of this final entry?
> >> The type will default to IIO_EV_TYPE_THRESH anyway but if that
> >> the intent you should specify it.=C2=A0=C2=A0 There isn't an 'obvious'
> >> default for type in the same way there sort of is for dir
> >> (as it's either direction). =20
> > Understood, let me experiment and see the ABI difference, if any and ge=
t back to you.
> >  =20
> This device has two channels - ALS and CLEAR. One interrupt enable option=
 and
> one Channel selection option (Clear or ALS). According to our previous di=
scussions:
> https://lore.kernel.org/all/20230415183543.6d5e3392@jic23-huawei/
> the event_spec was updated to have two interrupt enable attributes - one =
for CLEAR and
> one for ALS. (Intensity channel and Illuminance channel)
>=20
> If I remove the final entry I am getting only one enable option (intensit=
y channel):
> /sys/bus/iio/devices/iio:device0/
> |-- events
> |   |-- in_intensity_clear_thresh_either_en
> |   |-- thresh_adaptive_either_en
> |   |-- thresh_adaptive_either_value
> |   |-- thresh_adaptive_either_values_available
> |   |-- thresh_either_period
> |   |-- thresh_either_period_available
> |   |-- thresh_falling_value
> |   `-- thresh_rising_value
>=20
> The last entry gives be the following event attributes, enable attributes=
 for both
> intensity and illuminance channels:
> /sys/bus/iio/devices/iio:device0/
> |-- events
> |   |-- in_illuminance_thresh_either_en
> |   |-- in_intensity_clear_thresh_either_en
> |   |-- thresh_adaptive_either_en
> |   |-- thresh_adaptive_either_value
> |   |-- thresh_adaptive_either_values_available
> |   |-- thresh_either_period
> |   |-- thresh_either_period_available
> |   |-- thresh_falling_value
> |   `-- thresh_rising_value
>=20
> Please let me know if this sounds ok to you.
Looks like coincidence of enum values being 0.
It's really
{
	.type =3D IIO_EV_TYPE_THRESH, /* Value 0 */
	.dir =3D IIO_EV_DIR_EITHER, /* value 0 */
	.mask_separate =3D BIT(IIO_EV_INFO_ENABLE),

Dropping 'defaults' for these things is fine if they are the obvious default
or other parameters mean they aren't used, but that isn't the case here so
please be explicit for all the values that are used.

You can put this final mask a few lines earlier as the other fields match
anyway.
	{
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 	.type =3D IIO_EV_TYPE_THRESH,
		.dir =3D IIO_EV_DIR_EITHER,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 	.mask_shared_by_all =3D BIT(IIO=
_EV_INFO_PERIOD),
		.mask_separate =3D BIT(IIO_EV_INFO_ENABLE),
	},..

>=20
> Regards,
> Subhajit Ghosh


