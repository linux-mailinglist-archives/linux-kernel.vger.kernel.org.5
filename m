Return-Path: <linux-kernel+bounces-19870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2755D8275EB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C3C71C221BD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F36254725;
	Mon,  8 Jan 2024 16:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JMJRxRTQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5158F54677
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7ce3e5bc2afso167250241.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 08:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704733148; x=1705337948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9K38x+VLezLj6/jNgYnVJ1nMGYFk9RbvwFtSlmgAh8I=;
        b=JMJRxRTQrXt6dYOVHTcRkB66Vus3vPceaCR89pobZ45yNCLesysITZBsd8NaWFEi2y
         a9MyVIT/zZPBjZ9qhRYndyN2QkZqF/6JDNLS0vUApYRXVurnwkcpA0UvAeCVjle2NzEb
         zAAWt0g7YOv5r/FtN5ZJtDpFeAWqdN4HDJ9J/LAB9tFfuUcI+55mr2YH9RTNKPaqZ9ex
         BG4qGKLEEi2QygmpBZ3IuZDGbVxyYF9C5I+SKS3lUf9/Zx5RtZAeR7mpuOWUYLvW0pHp
         3ku2RgoigxpD1yf0FoxL5ZVMaB5SJWh2DBVMljs8D4leVMnVS2t43qi3bgfBcBjHeQ1z
         /bXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704733148; x=1705337948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9K38x+VLezLj6/jNgYnVJ1nMGYFk9RbvwFtSlmgAh8I=;
        b=oqNv4CkEQeJSmGi/fmicVkmRUKnv6YefUCyHteQT2GSmkrQz0+FYO8U4nF7WPHIkUZ
         ElK3eitPGPOqStVzhWYcAF0KzAuWG/CBfze1MRW5yBEBXDzPLWPmEZv1RFcZ/ClDwXPp
         86aqrCuCoJGakJNqsTy3iul/uOMbXEPOsg+A+L0PJsMHbpeTy8LsF4fTtoSaGnPNXVTM
         ULKgq6ciS24Hnf3HeOtYEjPsdFLkZnUMIcpV10GbHVWBfUk0pUsvJCvrWG2M7HkW+UFf
         419yCG1wmEljNCODPSyPSBhsDOytPSGEKmmEIIOjPZZyapOS/w4DLbsXUpHNgCVLXwdX
         ajkg==
X-Gm-Message-State: AOJu0YwplBJOzX86yoMGeJHuzPRGaKHHUxU+opF2fxd8JuVE9AWqbY6Q
	Au+5PxcDsV5gJHQ769axOL9b9EQF+8f4HNuuZ6BKCq4oliE=
X-Google-Smtp-Source: AGHT+IE/Qv668Ztj0QeHPWgPiCUb8oh1aEW8N4ltPdUoThdREI08DKfFatV4tJeLg/DwRn8524cBIg==
X-Received: by 2002:a05:6102:3e90:b0:467:cd80:2608 with SMTP id m16-20020a0561023e9000b00467cd802608mr1476669vsv.11.1704733148039;
        Mon, 08 Jan 2024 08:59:08 -0800 (PST)
Received: from ubuntu-server-vm-macos (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id hv14-20020a67e68e000000b004662865945asm30618vsb.7.2024.01.08.08.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 08:59:07 -0800 (PST)
Date: Mon, 8 Jan 2024 16:59:05 +0000
From: William Breathitt Gray <william.gray@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: lee@kernel.org, alexandre.torgue@foss.st.com, linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/10] counter: stm32-timer-cnt: add checks on
 quadrature encoder capability
Message-ID: <ZZwp2Tq23FtRsHhq@ubuntu-server-vm-macos>
References: <20231220145726.640627-1-fabrice.gasnier@foss.st.com>
 <20231220145726.640627-7-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wjNWh2SLmyHjR/FO"
Content-Disposition: inline
In-Reply-To: <20231220145726.640627-7-fabrice.gasnier@foss.st.com>


--wjNWh2SLmyHjR/FO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 03:57:22PM +0100, Fabrice Gasnier wrote:
> This is a precursor patch to support capture channels on all possible
> channels and stm32 timer types. Original driver was intended to be used
> only as quadrature encoder and simple counter on internal clock.
>=20
> So, add a check on encoder capability, so the driver may be probed for
> timer instances without encoder feature. This way, all timers may be used
> as simple counter on internal clock, starting from here.
>=20
> Encoder capability is retrieved by using the timer index (originally in
> stm32-timer-trigger driver and dt-bindings). The need to keep backward
> compatibility with existing device tree lead to parse aside trigger node.
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
> Changes in v3:
> - New patch split from:
>   "counter: stm32-timer-cnt: populate capture channels and check encoder"
> - return -EOPNOTSUPP when encoder function isn't supported by the timer
>   instance.
> ---
>  drivers/counter/stm32-timer-cnt.c | 55 +++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>=20
> diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-ti=
mer-cnt.c
> index bf2726dd7f12..6933d42b16bf 100644
> --- a/drivers/counter/stm32-timer-cnt.c
> +++ b/drivers/counter/stm32-timer-cnt.c
> @@ -11,6 +11,7 @@
>  #include <linux/mfd/stm32-timers.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/types.h>
> @@ -38,6 +39,8 @@ struct stm32_timer_cnt {
>  	u32 max_arr;
>  	bool enabled;
>  	struct stm32_timer_regs bak;
> +	bool has_encoder;
> +	u32 idx;

This idx value is only used temporarily to determine whether the device has
support for encoder mode. Do we really need to store it indefinitely
here?

> +static int stm32_timer_cnt_probe_encoder(struct platform_device *pdev,

This function uses 'pdev' only to access 'dev'. It'll be better to pass
a reference to 'dev' directly instead.

William Breathitt Gray

--wjNWh2SLmyHjR/FO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZZwp2QAKCRC1SFbKvhIj
K7S+AQCQM0asZnc8G7bJKzKJwkk/Jggj2YNluI1xFmJNzzWqQgD+I9Gx0gcX1sk5
8Cm4QXQFUMIu5YPYOyZsy0Yj0qaIKw4=
=FdQj
-----END PGP SIGNATURE-----

--wjNWh2SLmyHjR/FO--

