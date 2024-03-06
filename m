Return-Path: <linux-kernel+bounces-94306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C66873CCC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7BEF1C22253
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4917E13BACA;
	Wed,  6 Mar 2024 16:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="m/sf+qfo"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E346137900;
	Wed,  6 Mar 2024 16:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709744365; cv=none; b=Gwl98bbroKSCsuFeLAowm46C0DcekjgPVH5XGH0FS0xll3UfmQLxxgq/9AFrer+T94xYyCEyAuONzU/Va7P7zWcbA7XDzXEWQL46l/Q8ygvWK7932hawgCIitUg1zDArgPI/N+B4Go3f5Yl0/W3WJYefRpLahN7Dty4Ze4mJgnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709744365; c=relaxed/simple;
	bh=6efTsE/s//lWZT89K6OgZlxZVqIp94KG4aarsCx7d0A=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=tD6qP5do+zKPDbVb/bcjAdiqF68v6s1rzSDJ9/7OC2IFpqqteLfUf8ZLKxUABYNBuJHv/maRed0e0O9kaLwATp3WSiP4u/lj4+B2C7j7SqqQh6x8GuL+Na1aBCvkACedJBqOChQ0cM5WgI5gOz7f32ATqPScGeagoYh5pPTqrkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=m/sf+qfo; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DFF10BD1;
	Wed,  6 Mar 2024 17:59:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709744344;
	bh=6efTsE/s//lWZT89K6OgZlxZVqIp94KG4aarsCx7d0A=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=m/sf+qfoZeWnpt8ODHesHI9DNUOB1o3YkMqeKhYJoxHji+F6nk+EqOKlzYd56YAuX
	 O0WOa5dsH+bZ29Cox2IUxDVydwwqeXCFhGh7EkjdFmkbbFbJIxd4JV/iH8aiAnI5Ej
	 elUCBnXHRgRsXJrxLphY4pSuZo+GnjjR9mi13llU=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240306081038.212412-6-umang.jain@ideasonboard.com>
References: <20240306081038.212412-1-umang.jain@ideasonboard.com> <20240306081038.212412-6-umang.jain@ideasonboard.com>
Subject: Re: [PATCH 5/5] media: imx335: Limit analogue gain value
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, Umang Jain <umang.jain@ideasonboard.com>
To: Umang Jain <umang.jain@ideasonboard.com>, linux-media@vger.kernel.org
Date: Wed, 06 Mar 2024 16:59:19 +0000
Message-ID: <170974435963.362031.17853243017273896294@ping.linuxembedded.co.uk>
User-Agent: alot/0.10

Quoting Umang Jain (2024-03-06 08:10:38)
> The sensor gain (both analog and digital) are controlled by a
> single gain value where:
> - 0dB to 30dB correspond to analog gain
> - 30.3dB to 72dB correspond to digital gain
> (with 0.3dB step)
>=20
> Hence, limit the analogue gain value to 100.
> For digital gain, support can be added later if needed.
>=20
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>

I think this makes the behaviour more consistent with expectations from
userspace for the ANALOGUE_GAIN.

Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>


> ---
>  drivers/media/i2c/imx335.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
> index c00e0c2be3f3..701bd5318b45 100644
> --- a/drivers/media/i2c/imx335.c
> +++ b/drivers/media/i2c/imx335.c
> @@ -45,7 +45,7 @@
>  /* Analog gain control */
>  #define IMX335_REG_AGAIN       CCI_REG8(0x30e8)
>  #define IMX335_AGAIN_MIN       0
> -#define IMX335_AGAIN_MAX       240
> +#define IMX335_AGAIN_MAX       100
>  #define IMX335_AGAIN_STEP      1
>  #define IMX335_AGAIN_DEFAULT   0
> =20
> @@ -1169,6 +1169,14 @@ static int imx335_init_controls(struct imx335 *imx=
335)
>                                              IMX335_EXPOSURE_STEP,
>                                              IMX335_EXPOSURE_DEFAULT);
> =20
> +       /*
> +        * The sensor has an analog gain and a digital gain, both control=
led
> +        * through a single gain value, expressed in 0.3dB increments. Va=
lues
> +        * from 0.0dB (0) to 30.0dB (100) apply analog gain only, higher =
values
> +        * up to 72.0dB (240) add further digital gain. Limit the range to
> +        * analog gain only, support for digital gain can be added separa=
tely
> +        * if needed.
> +        */
>         imx335->again_ctrl =3D v4l2_ctrl_new_std(ctrl_hdlr,
>                                                &imx335_ctrl_ops,
>                                                V4L2_CID_ANALOGUE_GAIN,
> --=20
> 2.43.0
>

