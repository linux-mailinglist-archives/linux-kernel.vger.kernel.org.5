Return-Path: <linux-kernel+bounces-151379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82CF8AADD1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92841282F0A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1AC8287E;
	Fri, 19 Apr 2024 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxTc2htZ"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0453F8F6;
	Fri, 19 Apr 2024 11:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713526838; cv=none; b=Nx9Yk1CHn1iiOnbbm11vGVmJOk1zcYN6XZIZ16t/8sVwazlj9wx5ZcyjGhmxQunoWktclaMWziJYbOGNHU3CIeWlEFa5zDzpMZ9IrwnbFfI4lRiBCC9RY050Nvr1Dqt3CkAkuhyTZRqcigxD08A/0IyCk8d2GfNT4RBJfsc+vpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713526838; c=relaxed/simple;
	bh=67tAD9dPGFnocIYPgAQfazAvvpd43UU0V/pMhoUAdYo=;
	h=Content-Type:Mime-Version:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=pyQAY9msep0S5MyiCLDFlbrZ+znCl6GXY0w9waEeJ+TDfTuMK3HbGN6xI9KrmtyhfhWuXcseD+QZVzAlnzBCYC1jW3kohw3jaiD4P1ZToanUnZXMiIUEb9JAT48eYz0EcH5eHSggeJTRxSaoApvNMGp+4gMB/zghdKAeHvgQFPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxTc2htZ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51acb95b892so399542e87.2;
        Fri, 19 Apr 2024 04:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713526835; x=1714131635; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KCpSylsBBU0U0ink6MW+pyy6ZLptHlf0p+v10lZOwHU=;
        b=TxTc2htZ7OfSWDf22sQUBYZEtZI0nV4YPpi0dkJe+kSGBUZ7gXGe4vGD/dPY4oouvy
         8lQvv38MkQy6mzpN4t12Oi5VlrCJ383icUDgurtcI7SSg3GgPG0xSCDJ1nB8/pRJ78uE
         9GPN/c5rYzhCS52t4eJMD9/lV3vIx/XUfMgY5380UVYYiZw+4vf82eexncEK28yU4raZ
         L8Rx3Y/S5IWbigRuHiIrC046Ox1LLKU+IPvkGzEwaVsO300NttCTJkUzaf+1VHdXs/0S
         fSYUVD3iPZ/vXNAqHkq3qMY2W3Ynq65VZ4gOBnEYbk/qjlE49xA/g8t3UtnpCkrjK1t9
         tL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526835; x=1714131635;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KCpSylsBBU0U0ink6MW+pyy6ZLptHlf0p+v10lZOwHU=;
        b=LBK21c8MEXiM6oB4EFHlGx+bV2MA8Icyqi8JulmY1miU1Dd/ykV2l3uqF0d9BYBdcO
         //+ue9Y6bV1Tg48b/0PmpBmtNpLHS3Q1MqsH/naJUw3VKl2qztBOOdYwkNqKmAt6/kvt
         fNvUCPc1E0XlwiHxKJbq9MgZeDK4NDn5xjxzkK3KqpIXCj1b/TfReLe0DsoK69Fc3Z4J
         qt3VlrfjbqBKveQZ1MLJjQfe8uIR2knU+C+486wVbdxtfqlEj0iATE0GdnqItR8M8mIX
         EbCjAhTFRqNP0dKRNp9OSbCb2JZoZESnBhzyHNiVckU5pwNRMnuFgSKJ3SyUPl23kPWh
         3BZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBLFOKJGPfANrCouQdhWLVoFKI+sLvM5W5mG4MviLCi+/HyFAfC6Jt3jwGqsu+6YFcwPXmk4x2OWvj++DJkB1OV+nr8kfJqR0dIOhA8nKhTA3obNWLXKK2dEsJmknjJwb3Wh2Jv2aiWVZm95fR3MCNyRUUFOBXMeywMrIyPfUneEIXU40T
X-Gm-Message-State: AOJu0Yz9keriRx2JVkzGaCu8SoALqQRAdznx3CtdiH/7sACvi6fW0aRI
	bZrT1O7uP3/6ugms/lajtUgKfzojf6Oezv526DKvKBXCIUSwoQen
X-Google-Smtp-Source: AGHT+IGXx10cQyWuXmKeXjxTiJxMX6EMsrsI/7/4aIqi/FyvDkB5maihBkBnT5nDmKZVmAC6L4MjNw==
X-Received: by 2002:ac2:5618:0:b0:51a:ca2d:eeb7 with SMTP id v24-20020ac25618000000b0051aca2deeb7mr738796lfd.14.1713526834339;
        Fri, 19 Apr 2024 04:40:34 -0700 (PDT)
Received: from localhost (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id v22-20020a1709064e9600b00a55865b2760sm702466eju.30.2024.04.19.04.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 04:40:33 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=83f6e9dfc46da42c4afe7fb111a4258e10f079b07429dbcb59380d138491;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 19 Apr 2024 13:40:33 +0200
Message-Id: <D0O2KG09X87O.1UR0G6BXCEJ5E@gmail.com>
Cc: <mochs@nvidia.com>, <csoto@nvidia.com>, <jamien@nvidia.com>,
 <smangipudi@nvidia.com>
Subject: Re: [PATCH] gpio: tegra186: Fix tegra186_gpio_is_accessible() check
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Prathamesh Shete" <pshete@nvidia.com>, <linus.walleij@linaro.org>,
 <brgl@bgdev.pl>, <jonathanh@nvidia.com>, <treding@nvidia.com>,
 <linux-gpio@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240416123501.12916-1-pshete@nvidia.com>
In-Reply-To: <20240416123501.12916-1-pshete@nvidia.com>

--83f6e9dfc46da42c4afe7fb111a4258e10f079b07429dbcb59380d138491
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Apr 16, 2024 at 2:35 PM CEST, Prathamesh Shete wrote:
> The controller has several register bits describing access control
> information for a given GPIO pin. When SCR_SEC_[R|W]EN is unset, it
> means we have full read/write access to all the registers for given GPIO
> pin. When SCR_SEC[R|W]EN is set, it means we need to further check the
> accompanying SCR_SEC_G1[R|W] bit to determine read/write access to all
> the registers for given GPIO pin.
>
> This check was previously declaring that a GPIO pin was accessible
> only if either of the following conditions were met:
>
>   - SCR_SEC_REN + SCR_SEC_WEN both set
>
>     or
>
>   - SCR_SEC_REN + SCR_SEC_WEN both set and
>     SCR_SEC_G1R + SCR_SEC_G1W both set
>
> Update the check to properly handle cases where only one of
> SCR_SEC_REN or SCR_SEC_WEN is set.
>
> Fixes: b2b56a163230 ("gpio: tegra186: Check GPIO pin permission before ac=
cess.")
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> ---
>  drivers/gpio/gpio-tegra186.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--83f6e9dfc46da42c4afe7fb111a4258e10f079b07429dbcb59380d138491
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYiWDEACgkQ3SOs138+
s6FEphAAmS5L755Tb0YYFIl6RB74eVji3nmDr+ejsQxu0Oaj3NW+Ms1lzxjIuuCy
eVTsEAaoaIS6eZA1mX0MMqXJ7cEao3IqG5jGXPer8DxYD8JxW523Pu2N7lG1+FoH
Xr+jozaaTqR6pAJu0/E2eYa38xNkUDZmydTPTQJSz35wrBDBP+nGZ9llaCsYIf2B
yoF0DAd/ByUig48bnROxBKE6Wqay7oEJmUFY0/Vb/Ef20qqOnTc2TADVcsWkzIsQ
2e6f5hffAxQ+bMYVgfUZ77z8Tv2Ib0SQFIoB97w+IyLR//5o/c00d1Lii1L3lyBf
Cu0K0I3tyRa4lh2k7BIXaFyUreJE9Z/KJdRC+OQbeBWWn0B9AXgGAsuyAqMGblsj
OVg7K8jsjTW5EYEE/D8QxlU+U9QU7KKH/viXvAN4z8yiXV5Iq/EmygrMyy+xRyrR
o4TOpe8mCHaPHb7EJWDxG6+JaAF14MGyNlBkYG4cwolByaTH8neJixlUQqywwWAj
eHmymvJa+4r3Brrnnjj9340V+3OnB26GB1HFOohqO4gdUXciYfEhyBeRx9y0Y7pG
SSje8X/HymrXzJcOJOr/mfBzsnL7TGYbXH9qsU+pNWm4C03ZGK7o+ITYj0fwJxuZ
DlqqXG9jjTaiIdLYwpetbFTH3d5nEnQmCh5MOD/6C/Dchs+vtjw=
=XyTt
-----END PGP SIGNATURE-----

--83f6e9dfc46da42c4afe7fb111a4258e10f079b07429dbcb59380d138491--

