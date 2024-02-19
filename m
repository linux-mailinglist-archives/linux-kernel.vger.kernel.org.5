Return-Path: <linux-kernel+bounces-71661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A630385A8A0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8C841C231A4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABFF3CF71;
	Mon, 19 Feb 2024 16:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRt2ZEVE"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4D13B1B2;
	Mon, 19 Feb 2024 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359530; cv=none; b=p66c90+yfzlRxfHZCTBlNctkRAqJnR3g9uD/8Z/g9M+8A9e6mYpjUHa7eIw8dgyhtKEEEB3JYERnxGIWN44F5ZWqbafjrgJnzwpi3sFFV5ciArDppYZr5bWH/KBu3mqMFJ9wx8qdtKVLexFrmfBlr/SQHXJPM9PDTajFdkKmsfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359530; c=relaxed/simple;
	bh=5LP7ITI8IxR8FihyrEfCPsDi/hGVUhuwAapc8ojBuww=;
	h=Content-Type:Mime-Version:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=evDUyZ+0fly5MFBsmFn9VaPoh7NALfvntcHu6ChdFOQM9dIBDU2jwWhErEKx6Fn/HdSE8E3eQs9ZVLpOUcDaRbP4bh7ccw4c7DXuG0QxnkcP9qMfrjNF1jENUMRBpAg84Z5f2VJDQru9qCap0Vqk1kXX75WKdfTGWYt+Se/zNnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRt2ZEVE; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3e82664d53so164766366b.3;
        Mon, 19 Feb 2024 08:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708359527; x=1708964327; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XnGkOpf2CVhPz/zljsYVnaZe/git0nem6as96fuozFY=;
        b=kRt2ZEVELTC8206hPrKBxwHd0K7EEonen9W+xLVkxzYcedVhxpaUXoP3FH5iD7wnoJ
         RVoBpnJfThUlUm+tv0ttDU2JI6zi/CwTfpNjabQuGg7sGr1Jb8ytOaIOaCqdk7RJk0KE
         M+6+MFipJMczJ0lID/MfgiXjovWjPO0W+yPn/zEP/ZqZ1w9uinzJmHEPYL01ds7BYUTn
         w5ky8UepE1f+9REx40hivXM2X316W/FjclBd66LFHdp9Mah2Pz/FjTORpuOIZ5OkWxnS
         zhyzogl/sr3sZpVKtD4qOehl7ghQjDjaZtpuq6lZR/QrrW/cmg3oAFVI5RUQBZQtWtiu
         pm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708359527; x=1708964327;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XnGkOpf2CVhPz/zljsYVnaZe/git0nem6as96fuozFY=;
        b=AL63P20PQMOaCq1qnhE7FsHjEMEeRzOED63Ur3I8AWWYpHyP8tAYYVjDNe7xVEhV4w
         I35Ox+KUYwtTNP93vpeKvNojtqlygThbbph2z42ZGKA3IexCYumxxWhzaBoUnyKlkDwe
         PXdMiWiXyKFdd5j3JBIGLBcUJHzAQWgbcPi/V6uN3bBWh+d7tcx1KMgJ349lEhZ+rjTS
         0FCCMIYK1nOAaWQ0SGBjf3uWkwvRyhTeoqJPiNhDOIApwnGhOzt2dhr3IAVilWKHyLo4
         /i/moI8Xf5vuRVEM0q19WK0OwrGx1ZWAIIlx7gEF30FvJrg1CK4JbRQe5YW77pBSrPnn
         J6iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVANScUt2sXLnupRb0x8aW6ITlNvIoSsMi+W+68EKeCE6rys5hIk5s32XusOWscyRFYhU0QKAzn5bKWKA/Uu+VpY9Lpl4YNea67tAvM5LmhB/kc5ctLEFWu5vleMElfDM/NrZ6eS407XWE=
X-Gm-Message-State: AOJu0YyzIXVWS5pjLjqPkGUtIDeQpmDftdqrY8YbKEYcKvEcE1gDyoLY
	PkfyeXoVYBf+rgs3Z+lbxAOfhYI4aG2AedTPUGmy5is9qzhwl8x1
X-Google-Smtp-Source: AGHT+IGUUJV/eeBIPCMl91Llf2j9jWuLG81QcvUsRhfs2AAcLV0xDw8mFgA+LpOP6YpcRwzhpcHTFg==
X-Received: by 2002:a17:906:1cc5:b0:a3e:98ee:765d with SMTP id i5-20020a1709061cc500b00a3e98ee765dmr1790223ejh.60.1708359527215;
        Mon, 19 Feb 2024 08:18:47 -0800 (PST)
Received: from localhost (p200300e41f2d4600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f2d:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id tj1-20020a170907c24100b00a3d35bccdf0sm3099051ejc.139.2024.02.19.08.18.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 08:18:46 -0800 (PST)
Content-Type: multipart/signed;
 boundary=5c88819ce2d668f2ae4936a9cee5d50b46dfdf026a77d46f159ba4c5cd91;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Mon, 19 Feb 2024 17:18:46 +0100
Message-Id: <CZ96WS1F2H67.CCTTAWAZX7PF@gmail.com>
Subject: Re: [PATCH v2 1/2] clocksource/drivers/timer-tegra186: add
 WDIOC_GETTIMELEFT support
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Pohsun Su" <pohsuns@nvidia.com>, <daniel.lezcano@linaro.org>,
 <tglx@linutronix.de>, <jonathanh@nvidia.com>
Cc: <sumitg@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <linux-tegra@vger.kernel.org>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240216210258.24855-1-pohsuns@nvidia.com>
 <20240216210258.24855-2-pohsuns@nvidia.com>
In-Reply-To: <20240216210258.24855-2-pohsuns@nvidia.com>

--5c88819ce2d668f2ae4936a9cee5d50b46dfdf026a77d46f159ba4c5cd91
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Feb 16, 2024 at 10:02 PM CET, Pohsun Su wrote:
[...]
> diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/t=
imer-tegra186.c
[...]
> @@ -234,12 +239,49 @@ static int tegra186_wdt_set_timeout(struct watchdog=
_device *wdd,
>  	return 0;
>  }
> =20
> +static unsigned int tegra186_wdt_get_timeleft(struct watchdog_device *wd=
d)
> +{
> +	struct tegra186_wdt *wdt =3D to_tegra186_wdt(wdd);
> +	u32 timeleft;
> +	u32 expiration;

One more thing I noticed: you could put both of these declarations on a
single line to make this a bit more compact.

Thierry

--5c88819ce2d668f2ae4936a9cee5d50b46dfdf026a77d46f159ba4c5cd91
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmXTf2YACgkQ3SOs138+
s6E30w//RlBSnLCPyQUCIOSqMYVuZUurdNauTPP7qqPY/IIOiqNIekmR+XRVjEDZ
A7pk4k1xqy8W9hfDYptB+F+3FpAgwT6Zk0kuIlD8lQgBhuHdfLXEmLyv+ZIBJJ1/
MNPXk89CIL3MDz5LDveTIVFG9jr8PO9WpPXjKFY+bN0tV/XAqAH7GKpW/ViUzE+w
dCIiN0GsH1/K8MxhOyl/juWZCAF7FpCxkWJ/CCJM5D6tQlP5qpw2bAwoFmlRD8PB
h92WRSlXCs2oiS58curADylcOvGFS8K26EJoP7vaAjGx//UiYBPrC0q1MfReROyx
Nd424Uv1jMPWbWpS4rRLwLsLTg3hlxGVHkkeXBvHtd5PF1JCvu9HXwzpIbP9X+nP
XWW0ksjeb+kQFoeXNTnYSHI8VsJXy3bnhM76U6TQZGXAOkQdF+uoP0VH1Nj9JGwo
SHSXfYWrXvVscWo1rQNDMZ6S2OmzRLpzLAr0cPQ6EEJ+cHZyFMShWMN5HwuaI4KA
Rvj24XY5z00kZFDPD7m590pqyWfbxakj9Q43oOSLMcs1B27REH1efAtiaQMIRe40
CxiFK7ayjesBpNz22hN4L9iCm0QtNcDZiiAW/f1+jq419fUkIQPox6S1h8v4C3iJ
IZ+NiKstX7lczpyFv2t3AuCfmQyHfrAt475aCitHZJGCWTvLMkA=
=ZlBV
-----END PGP SIGNATURE-----

--5c88819ce2d668f2ae4936a9cee5d50b46dfdf026a77d46f159ba4c5cd91--

