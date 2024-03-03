Return-Path: <linux-kernel+bounces-89678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8133986F414
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 09:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1689B1F20FDC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 08:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533B5AD2C;
	Sun,  3 Mar 2024 08:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Y/YxnJ0y"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F21B65D;
	Sun,  3 Mar 2024 08:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709455003; cv=none; b=m3Q7kRydxUpEHM28UiCjOpWJoB2vx45lrruRW/lgN76MturDQiONlhVQMJiZrxSLSDzvC93L4m+OcM2DUR6VgL29+MWZzM4aiD0/5IKA+PMDtMZx6sPa6NaOpzvHPFrVTvZH3CnB+Hq/pItGALwhvF6iXWk+LJLDtlXd7bY61t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709455003; c=relaxed/simple;
	bh=TjzaCrSVjQxb6zp0lUZIs8SzQu513pmNezGydfAD2t0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tDapewOaPMxGyzvlHaVVzBNgOKTPicWqM9+uuA+bTnkp+3F599WxCByAbharwDe68nAGH0aYSuK7DNNYfh/o6N23/l2qRl2cF+ye4NJOHdeUDmQm1TiE/ZE1JzZlxnPfGst3zeEfjZonPqeF0J/7Zw9SiOvr+wNzRpqYGbrFFJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Y/YxnJ0y; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709454979; x=1710059779; i=markus.elfring@web.de;
	bh=TjzaCrSVjQxb6zp0lUZIs8SzQu513pmNezGydfAD2t0=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Y/YxnJ0y8y/6w3ppw9VoRWnIF118s/SyLTe1D5EHwo4hyjTS8jPgxDatLsXyKI20
	 EnuDm0wGCJq9a4ETcycyUQ7rTLgbPxGaXeMGOsXtNBdICgDQ/8ZE4KVdahpgSkogx
	 UVqwWAwAzaOBTUafB6dT3ncNSpfB5UkMAW0n4VRPM9MSDE1V9fuf1XcEd769QzLus
	 nFqCaboZfIDaTHrnWLF+mPBOXmLoAqk8pX53IM75xLuZWVFWlyUxC08Iye86ekfnf
	 ZBhB3Pd3Ov8fBXyoFkM5unrEiZMWENw5qv9It6x3DknpW4OPkk2WOljXWnZ+gbR0w
	 XTXYDAO4GXpE80PPuw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MYLmq-1rLGTZ0z6A-00VnT6; Sun, 03
 Mar 2024 09:36:19 +0100
Message-ID: <af4995cf-6ea5-4214-a133-af260e2c517f@web.de>
Date: Sun, 3 Mar 2024 09:36:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: rcar-csi2: Use common error handling code in
 rcsi2_parse_dt()
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <8b4203dc-bc0a-4c00-8862-e2d0ed6e346b@web.de>
 <CAMuHMdWwegdks3eEviEsBJE3AvUVKbZqHduYdhuwz=8xTMDs5g@mail.gmail.com>
 <260d82b6-e7fc-40c3-b414-50a883709fd7@moroto.mountain>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <260d82b6-e7fc-40c3-b414-50a883709fd7@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FtJYFEbxNxvq/gj5STpjZsWeQd2N5C5UaMlhKG3LGGyeWAZcWuB
 LZXN9x+O3r5yv5I7Z1CAC+OGBoWsL3XDLRn5owyenNleoZsr7l/5a+CZqdFbWwXi34sofhT
 QLb9KczD9mm0dyS5jCZaKp1BMp3xIz864gmSXPtVYJiL+cBpVjxxnQRT0N2NKzK+wSMxWGl
 Ur4V139e4XcrnufdvGpFA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:u2BtA3GksbE=;A7YNyS2ZssbGa0brxc5GH/Icea8
 rBMD/0398Bq8/Qj3vkiIdqsYltFv5RqlOsDHSOndxudHas2PQVNA7f6UhpI52LiqHJIbLo0qO
 wa163nB0gn72JT/dr+u50YAW+U+qnq+6P0A4aFpUXPeIsPp9ZmpVxSYBAddJQ/2ikrAj75vYn
 6/Ndui8HYZHMEDuVBBh9oX3ua+5iLXEPHNtO3ULTGZGePB5soHOUAcISPP/gr/PnMai1gOd4e
 FTmvaPVgMJaSYu8w+BFgH455GJsC6mEIBL4WItTjeJT4HW2GUSGmLJGL2Sk8DnNC1+65O+HbQ
 YoEIZDgKkAtwBbgYduPcS5+55lHG26vrOmxiYCYKtPJ6IcQxZf1YrvwLWw0VCXlsJEl7Mxv4d
 wloF0Gu7zbVB4FxBV+YOSJpir7BRxFqZuqKuK5M5bal3kiWroPxdNwsGyEOBaC36mUhAvTe1I
 y2D6mzRrNpvoZt945LCI4P+vLcZZtRZJNP/XBwW+2pRxlvWHeYwZktKgsdnZQwwNByPDSEzPp
 DALlz71fPT5x9Cevy67WOq32b12CvjepwgNiR6/99FWhDFiuo8viNV7xTAyrySWjm12z1jD8j
 9vxpxQ/XxXPWXiFMma/8bBIv2UTz8siQhCe1rgvvaAyEbRpmhhKB5lKxtOId13XrwXFdDFfm7
 uJZtdmGLoNTLSQY8i5c9+8JK80oVb90dt3bioCXg7fO48RhbH391SgLjbTQU0R+tXdtd5MTyy
 uFF4eU1JQoz9wDVQo5tlT9RARDfbPJJD+62kPnC1783U1yseHfY0WLN3gyplsa54YSj5CehA6
 EPtlOhIh8PuMrpuDJEGDIJ1/W3LjwGZojjfmb8HW1fK6w=

> Sakari Ailus pointed out in another thread that we could use __free() in=
stead.

See also:
Contributions by Jonathan Cameron from 2024-02-17

* device property: Move fwnode_handle_put() into property.h
  https://lore.kernel.org/r/20240217164249.921878-2-jic23@kernel.org

* device property: Add cleanup.h based fwnode_handle_put() scope based cle=
anup.
  https://lore.kernel.org/r/20240217164249.921878-3-jic23@kernel.org


> Something like this:
>
> diff --git a/drivers/media/platform/renesas/rcar-csi2.c b/drivers/media/=
platform/renesas/rcar-csi2.c
> index 582d5e35db0e..c569df6057b7 100644
> --- a/drivers/media/platform/renesas/rcar-csi2.c
> +++ b/drivers/media/platform/renesas/rcar-csi2.c
> @@ -1372,8 +1372,8 @@ static int rcsi2_parse_v4l2(struct rcar_csi2 *priv=
,
>  static int rcsi2_parse_dt(struct rcar_csi2 *priv)
>  {
>  	struct v4l2_async_connection *asc;
> -	struct fwnode_handle *fwnode;
> -	struct fwnode_handle *ep;
> +	struct fwnode_handle *fwnode __free(fwnode_handle) =3D NULL;
> +	struct fwnode_handle *ep __free(fwnode_handle);
>  	struct v4l2_fwnode_endpoint v4l2_ep =3D {
>  		.bus_type =3D V4L2_MBUS_UNKNOWN,
>  	};

I suggest to reconsider the position for the adjusted variable declaration=
s
a bit more.


> @@ -1388,18 +1388,14 @@ static int rcsi2_parse_dt(struct rcar_csi2 *priv=
)
>  	ret =3D v4l2_fwnode_endpoint_parse(ep, &v4l2_ep);
>  	if (ret) {
>  		dev_err(priv->dev, "Could not parse v4l2 endpoint\n");
> -		fwnode_handle_put(ep);
>  		return -EINVAL;
>  	}
>
>  	ret =3D rcsi2_parse_v4l2(priv, &v4l2_ep);
> -	if (ret) {
> -		fwnode_handle_put(ep);
> +	if (ret)
>  		return ret;
> -	}
>
>  	fwnode =3D fwnode_graph_get_remote_endpoint(ep);
> -	fwnode_handle_put(ep);
>
>  	dev_dbg(priv->dev, "Found '%pOF'\n", to_of_node(fwnode));
>
> @@ -1408,7 +1404,6 @@ static int rcsi2_parse_dt(struct rcar_csi2 *priv)
>
>  	asc =3D v4l2_async_nf_add_fwnode(&priv->notifier, fwnode,
>  				       struct v4l2_async_connection);
> -	fwnode_handle_put(fwnode);
>  	if (IS_ERR(asc))
>  		return PTR_ERR(asc);
>

I find that two function calls marked the end of scopes here
which obviously are not at the end of the discussed function implementatio=
n.
Thus I imagine that the known source code transformation =E2=80=9CReduce s=
cope for variables=E2=80=9D
will become relevant.
https://refactoring.com/catalog/reduceScopeOfVariable.html

Regards,
Markus

