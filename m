Return-Path: <linux-kernel+bounces-166461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6508B9AF8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D9521F23465
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F2962171;
	Thu,  2 May 2024 12:36:37 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608851CAB8;
	Thu,  2 May 2024 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714653397; cv=none; b=D6ZORrPioDufrOrPN1CXlYUcimFACB9YWvAmcXgRnN3r0wc8yr9INpM0r3RIdW1tXF8riQ6uwXQZzHfzjFSVT2v9yvWlsEFPaWySzNj0E7pB5uC+wktMpQVsXf7UhLoAvweARwkU70ndKT3+LZg0tsAsQW/SS20tAX/BwA13Yqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714653397; c=relaxed/simple;
	bh=g8yoyySYQucAfTxisyM9kmbm4UKX0YvUAmEQNAgg6zM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EyRBFkL4jktSz/ZO/imKMja0A+ixDCVSUifvwn6XfnBd5q3LHOMBY1QKVRkcpB2u2wKgb1b8f81/H94EnRPcUm0cyAx4ei5J0CNFoehIzsebBcQ9Mu7RxcRBRzaTWlCa1x/BAvm7ooGwJqt6Tg0I1Dzq96+eBOZoTcXwRuxYSdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VVYJQ3DXXz6GD3H;
	Thu,  2 May 2024 20:33:42 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F6DE1408F9;
	Thu,  2 May 2024 20:36:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 2 May
 2024 13:36:24 +0100
Date: Thu, 2 May 2024 13:36:23 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: =?ISO-8859-1?Q?Jo=E3o?= Paulo =?ISO-8859-1?Q?Gon=E7alves?=
	<jpaulo.silvagoncalves@gmail.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<joao.goncalves@toradex.com>, Peter Rosin <peda@axentia.se>
Subject: Re: Supporting a Device with Switchable Current/Voltage Measurement
Message-ID: <20240502133623.0000463e@Huawei.com>
In-Reply-To: <20240501233853.32y4ev7jvas5ahdz@joaog-nb>
References: <20240501233853.32y4ev7jvas5ahdz@joaog-nb>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 1 May 2024 20:38:53 -0300
Jo=E3o Paulo Gon=E7alves <jpaulo.silvagoncalves@gmail.com> wrote:

> Hello all,
>=20
> We need to support a hardware that can measure current and voltage on
> the same differential analog input, similar to a multimeter. The mode
> of measurement is controlled by a GPIO switch and goes to different
> ADC inputs depending on the mode. If the switch is enabled, a current
> loop with a shunt is enabled for current measurement; otherwise, voltage
> is measured. From the software point of view, we are considering using
> the iio-rescale driver as a consumer of an ADC IIO parent device. One
> of the problems is that we need to change the mode of measurement at
> runtime, but we are trying to avoid using some userspace "hack". The
> other is that for a minimal solution to enable the mode from boot, we
> can use a gpio-hog and control it with overlays. However,
> still would be better that this was done by the kernel. Do you know
> or have some guidance on how to properly support this in the kernel?
>=20
> For the in kernel gpio solution, this is a draft of DT we are thinking:
>=20
> current-sense {
>       compatible =3D "current-sense-shunt";
>       io-channels =3D <&adc 0>;
>       gpio =3D <&main_gpio0 29 GPIO_ACTIVE_HIGH>;
>       shunt-resistor-micro-ohms =3D <3300000>;     =20
> };
>=20
> voltage-sense {
>         compatible =3D "voltage-divider";
>         io-channels =3D <&adc 1>;
>         gpio =3D <&main_gpio0 29 GPIO_ACTIVE_LOW>;
>         output-ohms =3D <22>;
>         full-ohms =3D <222>;
> };
>=20
> Regards,
> Jo=E3o Paulo Gon=E7alves
>=20
+CC Peter Rosin who wrote all the relevant parts you need I think.
>=20

Superficially sounds like you want a mixture of appropriate analog front en=
ds
and a Mux.  I haven't tried the combination but it should be possible to do
something like this with=20

An IIO mux via this binding
https://elixir.bootlin.com/linux/v6.9-rc6/source/Documentation/devicetree/b=
indings/iio/multiplexer/io-channel-mux.yaml
(that includes a gpio-mux example).

Consumed in turn by a pair of AFE devices.

Then you should be able to just read from which ever of the AFE device you =
want.
A sysfs read from
/sys/bus/iio/devices/iio\:deviceA/in_voltage_raw
will switch the mux to appropriate place then request the
voltage from the iio-mux, which in turn requests it from the ADC IIO driver.

/sys/bus/iio/devices/iio\:deviceB/in_current_raw
switches the mux the other way and otherwise the flow as above.

Jonathan


