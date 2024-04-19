Return-Path: <linux-kernel+bounces-151368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE0C8AADB0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5489B21C99
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA0F81AC9;
	Fri, 19 Apr 2024 11:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5brtCcG"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB4480029;
	Fri, 19 Apr 2024 11:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713526123; cv=none; b=oNxtvsPiLj8LZ+JQ7k+tloY52KsyHpIJl5CSHfubvOistEyOx4tJkVmMRNNo7DIFsnPYE0+3FG6J8zOJhIHBLVGBzJBXIHX1WXlCenz863DYl3p8sk9FaovGSnvVeWVFw+2kwH1HrU31gTYobrqQg8pgMUYlgC5f0IgRoXcmcYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713526123; c=relaxed/simple;
	bh=ePv7bJHuUzanw17+IrGOqLfUWC2Y6dNzrMMM+ekyZPo=;
	h=Content-Type:Mime-Version:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=JbGGc8D8lE0FxV0Mo0Hz1oSQmeepeBgfYaFGD/AUOMDsgJNFq0Jwv2YLVpWBCyGaNN8Mn03f8lS8iHdlYHD3FqISUlIwUimBExO3xzRCSOu4lzvQQA8oCBBgBcIGolYKNVLb9b9LGjSdOkAiaq4aukUKRX7gkxHdQD2rTxn99G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5brtCcG; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-571d6d1943fso464060a12.2;
        Fri, 19 Apr 2024 04:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713526120; x=1714130920; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3vJkoh0Y88E8xelvHUeCB5ZFGBjLcpHSC6lZET6ARl0=;
        b=g5brtCcGGvMPDiQqTuhSoa7bwm9ZxZ+ISQmmPhNa3d/328ddI8CmPgeKiy63qpuu54
         p1iIS4UBOfDkw20TqChHaiC1Ho+mxHDTV2kgnJOetYbLGhrhJotRgSgsdXworpIqFof4
         o38uA0repjSImpcC4RP/UW7uN57zPDiBaD0o3L+M9zJnLJjg+MkBcWFl3UK72+GYj706
         E+6d6u1NQmn92F150rtVPpumQHjODbc/1abA4hcKg6fmllKQ/ruTsOWwY+HauL+Inay3
         mc3kQ96WAiaRYu3X2oQSrXQtQlczLNm1EUqOTaP+bpwz8vzJAQRLt3sk+k1PQo2HneSx
         MY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526120; x=1714130920;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3vJkoh0Y88E8xelvHUeCB5ZFGBjLcpHSC6lZET6ARl0=;
        b=quUuxDlJbwvEwNOUkbBAou36qQMaUZuvFcxHMXdcpdzJftiiREpm1Bux2dzyYC+Peb
         7fZC8fsTmasjIgO9HiqL/Gpnd8QBhWEF/atXSUZiAt0T4NjaKCz9ZuW4WA4lfkjjrYYK
         gRjkuxjmNbOugRghCcUEb7Yz4lMZY5pIVQBvwSh7my7DJKD69+1oyIyHkfnyirRmaKOm
         4jb9k63swQ10syynd9yDfMP+/DZeINonhzMyuPXd1RGKzWGhJYhINQKoDiJg2hLAZeiu
         XoORigy+GmQSoSzq3lMgx+nua0SWkh9qg0jjhUCczI2YkSa7Yvv5yawu67BZENuKcnIs
         80sw==
X-Forwarded-Encrypted: i=1; AJvYcCX1To+zQNqEqYlXLkVkxR/zEs+uZhWdTsHfc0ee6fPX7NNN8ILR2Yuzdf5iEw41e07BLPNgMpzYpK+vQzPWM9cgCj88Q4p9aO88JXDxUlQhkjDuMnB83qjOMNXcNGJGt8NIHoHxgrjRt5M=
X-Gm-Message-State: AOJu0Yw1JA97c9XXSi3Jg3tLG2iA9HipOjzwLmyy0S89k5CFS2xuR81W
	FTGBdXg22R61IEIrWIkqNqtoNdW9xraVc6rqpifpFd/iXff1A2IW
X-Google-Smtp-Source: AGHT+IFKiwmp4FLKAWcTXgidfN19IfMXqqvkx3T/mYwog55rvnWpsnKvb8Yadb5rRXuT3dRv4qU4Xg==
X-Received: by 2002:a17:906:2a4b:b0:a52:1770:965 with SMTP id k11-20020a1709062a4b00b00a5217700965mr1248210eje.42.1713526119786;
        Fri, 19 Apr 2024 04:28:39 -0700 (PDT)
Received: from localhost (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id bi14-20020a170907368e00b00a5588ed8fa2sm552797ejc.113.2024.04.19.04.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 04:28:39 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=cd669ce6bdd8f9700a6a46cb06d3d090071a64c757641859cb60bdf1475c;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 19 Apr 2024 13:28:38 +0200
Message-Id: <D0O2BBOL89ME.QEWHYL0GV4MY@gmail.com>
From: "Thierry Reding" <thierry.reding@gmail.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 "David Airlie" <airlied@gmail.com>, "Daniel Vetter" <daniel@ffwll.ch>
Cc: "Frank Binns" <frank.binns@imgtec.com>, "Matt Coster"
 <matt.coster@imgtec.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "Chun-Kuang Hu" <chunkuang.hu@kernel.org>, "Philipp Zabel"
 <p.zabel@pengutronix.de>, "Matthias Brugger" <matthias.bgg@gmail.com>,
 "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 <linux-mediatek@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, "Mikko Perttunen"
 <mperttunen@nvidia.com>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 0/4] gpu: Convert to platform remove callback returning
 void
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <cover.1712681770.git.u.kleine-koenig@pengutronix.de>
 <xqwcrxfrg3ogplh35c5etl6nbzw6zueilm4h6euh7bnpszyir4@6dtn5qdvijv3>
In-Reply-To: <xqwcrxfrg3ogplh35c5etl6nbzw6zueilm4h6euh7bnpszyir4@6dtn5qdvijv3>

--cd669ce6bdd8f9700a6a46cb06d3d090071a64c757641859cb60bdf1475c
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Apr 19, 2024 at 9:20 AM CEST, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>
> On Tue, Apr 09, 2024 at 07:02:47PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > with some patches sent earlier[1], this series converts all platform
> > drivers below drivers/gpu to not use struct platform_device::remove()
> > any more.
> >=20
> > See commit 5c5a7680e67b ("platform: Provide a remove callback that
> > returns no value") for an extended explanation and the eventual goal.
> >=20
> > All conversations are trivial, because the driver's .remove() callbacks
> > returned zero unconditionally.
> >=20
> > There are no interdependencies between these patches. This is merge
> > window material.
>
> I wonder how this series will make it in. While I would prefer these
> patches to go in together (that I can consider this thread completed in
> one go), I think with how drm maintenace works, it's best if the patches
> are picked up by their individual maintainers. I guess that's:
>
>  - Frank Binns + Matt Coster for imagination
>
>  - Chun-Kuang Hu + Philipp Zabel for mediatek
>
>  - Thierry Reding + Mikko Perttunen for the host1x driver
>    (Note there is another patch for this driver set at
>     20240409165043.105137-2-u.kleine-koenig@pengutronix.de that is
>     relevant for the same quest.)
>
>  - Philipp Zabel for ipu-v3
>
> I plan to send a patch changing struct platform_driver::remove after the
> end of the merge window leading to 6.10-rc1 for inclusion in next via
> Greg's driver core. So please either care the patches land in 6.10-rc1
> or ack that I include them in the submission to Greg.

I think the latter would make more sense. I'll go ack those patches.

Thierry

--cd669ce6bdd8f9700a6a46cb06d3d090071a64c757641859cb60bdf1475c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYiVWcACgkQ3SOs138+
s6EMWxAAuBhTV9ovczgI1JfXW9dVlwEMXj4ZN4Wo303HNjKbzE/U9v17jp2EZP+t
s35e09Yav10cM7qTAnoTkHG/O7TbJ1j1eFN0dYuog+C28+u3a7FKYFzjxrDdohFD
nWXufe9EklSmTeDiA9LVY/hQgiebLT6zHLh4QxIPwhE2HpnZcT9JOq5Q95w9HYY+
wMSiJ0eQCGLCWgtDGZoWtCPNkp39ViRF59soniQuEHhm5pXc5eFfYbUOP940CJ44
8UWu69np3LlX7Gx0TMaqIuzlBWaG+MfU7vBI7hnyA5VgSjcuT0iEJwFW6lZAeBgm
I4h1xdDIMbrHoVIXqj81dZWFTCO6FILwyb7X1sEKAWqN/axoa6C/PPt4UrURzPfD
mMiWc006q+mYajFqk2S31q/WBfssrmC4F4boDphofmJHmsKT0z9Oj8jCpPM8+RHP
lpATu13Rq+zzNIGeqpodAvPEQrX8QGpE9xxncQwWPiXJ7PnG1UdZoiERW5hdE8zN
XcaZB7crWn1A0NbseWFFAb09WoPQmvR2JIO8gzsQ1a9CKs0UK4O8UNlfwnJp7suo
TkG+kqH5kUunGRVpvJbF9sS7raVtB0HRN28xWCY/jFpd0nmfi1tcfxcLBJhDBLRS
KtLx+oMwRhWxpalupIX1hLGY+QmcLxEi4tjYfCd/vHRoAShnV0Y=
=abck
-----END PGP SIGNATURE-----

--cd669ce6bdd8f9700a6a46cb06d3d090071a64c757641859cb60bdf1475c--

