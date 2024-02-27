Return-Path: <linux-kernel+bounces-83152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0C3868F90
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96DEEB21665
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8E613A254;
	Tue, 27 Feb 2024 11:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fb73xaMR"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E7855E63;
	Tue, 27 Feb 2024 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709035100; cv=none; b=cHTNReN+BRM7CXmdPaXBjUK3LLncRgvCKb6AtCb16GQr8Q+LXg702GPl0k79ZdJ4/R7l0F8mnqijKIhD1Jzm0L2aN4vDgtmC0S8H3/zOknP9cC4ne9gdY3OVShR7/0+sNuZbGjdxVZHrWRxkQQPYQbSHMo21WZVyDWl8i/J1Fxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709035100; c=relaxed/simple;
	bh=xxZhRagdqpYdE/yRV4Xi7zuH3R59yc8vsZ//HgmIGwQ=;
	h=Content-Type:Mime-Version:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=P+POIhNxPg/DAPb7vYVLnuH7NCQAXOIDbzoGWtlvMsMlOyvA6vIw0Ru4gYmwJRYlqi+HY6ygHl9u13hTg6Co3/vem5UO2LtmENdLjKEXqZDs6sorHoluClWV7kIL9Hl6IYJ5X5hjeblkbnHlWVcV4H7sB3yF6oxA3Ltnsigraw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fb73xaMR; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a293f2280c7so622978766b.1;
        Tue, 27 Feb 2024 03:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709035097; x=1709639897; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iD5yEQo/k0yP9hJDkvshK/ceYjlmawpvxOVwpMDKXyw=;
        b=fb73xaMRkVybWz9l8k/6j6NgAvCtgdlbLDncNQav7N9teKrN2bKugkIcZul6RC57Ii
         9XWdF3+eee5jxGZfnXKLDjhuKMr7QYoxE9mDo7IuWHWYHNFKeUlxyFc/pTxacrtFZ79g
         Fxod7xuTO866g6LMCke33R05d83rg4O5WZ2TCD1c9Z0knP5hQtXpAJweUiiORybQks6+
         wCTd8algPxApGshuLan7rNx7GB157sUdwyx5fDjUnYC/10L2lZaAVz/OZwuNvg/n4IRJ
         smieXh6mcmonD0KAXJx+EZ9LrYoDVabBCeDAlUhyKa950KLb84w+2xnRnuHD7jTYUJhh
         xzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709035097; x=1709639897;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iD5yEQo/k0yP9hJDkvshK/ceYjlmawpvxOVwpMDKXyw=;
        b=rjKton5MMVHofpQZDaLHulqmzBcwws9q0E32kyO3jgwLafjJ/g/FYm6J60bsacFHFx
         0owKo+8V4mnJr4IsPTlrJiHiG9Vuot+rDJjFADtjntCy79bDVbVho1+hzUUhoIy+Ekzq
         PZ0DjfILQaoUwRVCqUOPU4wdKuF7qNdRCfXGHuqezPSQ8XZ6OR95ItbJowbjpNwUD4RW
         JqjFXVKPNEjp+etZ8PnfwCCJYuSlEEbTGNhrPfv39BN3kDoTKYAWZXmqPyEyfCZbLjyv
         u+lzkuEL7gg1X/J4ZKNzgu7no4TVBKvErHUjsQ1BHFTm0DsnbQ8ZK88J2tjfCg6rak1r
         hkDA==
X-Forwarded-Encrypted: i=1; AJvYcCX8M3cISEPOTHG94R3KwcKSUpkSsAR1avn8SDEcYsuO9AdSBgtY2KHgR6PhINrFrMxxcaR+w8wTVBbOlOEKbZZYt4U0Z2Yv7p/Il98=
X-Gm-Message-State: AOJu0YxG6qbNyQr9GOsCors2czGYjAHlrba9+NVkWiZ+U7pa1bEICzOH
	VFlb6Q6rnOF+Dg4pkTbZk+kyp8uMRuh9SaV+SIpFIMUoIIcV2GO5
X-Google-Smtp-Source: AGHT+IG/8hrkAmo6firC3P6TvxZ11thXM16Y0Y8yJs4jxFxuCNQ+wTIMavaQOihRto6GArH6Vl7kEQ==
X-Received: by 2002:aa7:db5a:0:b0:566:2be1:5276 with SMTP id n26-20020aa7db5a000000b005662be15276mr1839910edt.23.1709035096555;
        Tue, 27 Feb 2024 03:58:16 -0800 (PST)
Received: from localhost (p200300e41f222300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f22:2300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id z95-20020a509e68000000b00565671fd23asm722478ede.22.2024.02.27.03.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 03:58:16 -0800 (PST)
Content-Type: multipart/signed;
 boundary=0b310bada9a22be6bb3934105c69e6dfccfb4490b3887f73dfc6b62fff06;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 27 Feb 2024 12:58:15 +0100
Message-Id: <CZFUDO8U8WAE.1YDN70AI3JWNQ@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
 <sumitg@nvidia.com>
Subject: Re: [PATCH v2 1/2] clocksource/drivers/timer-tegra186: add
 WDIOC_GETTIMELEFT support
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Pohsun Su" <pohsuns@nvidia.com>, <daniel.lezcano@linaro.org>,
 <tglx@linutronix.de>, <jonathanh@nvidia.com>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <CZ96NM6U8O59.3TXG2WKAL7L8F@gmail.com>
 <20240223235126.31004-1-pohsuns@nvidia.com>
In-Reply-To: <20240223235126.31004-1-pohsuns@nvidia.com>

--0b310bada9a22be6bb3934105c69e6dfccfb4490b3887f73dfc6b62fff06
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Sat Feb 24, 2024 at 12:51 AM CET, Pohsun Su wrote:
> Hi Thierry,
>
> >> +static unsigned int tegra186_wdt_get_timeleft(struct watchdog_device =
*wdd)
> >> +{
> >> +     struct tegra186_wdt *wdt =3D to_tegra186_wdt(wdd);
> >> +     u32 timeleft;
> >> +     u32 expiration;
> >> +
> >> +     if (!watchdog_active(&wdt->base)) {
> >> +             /* return zero if the watchdog timer is not activated. *=
/
> >> +             return 0;
> >> +     }
> >> +
> >> +     /*
> >> +      * System power-on reset occurs on the fifth expiration of the w=
atchdog timer and so
> >
> >Is "system power-on reset" really what this is called? Power-on reset
> >sounds like something that only happens after you power the device on,
> >not something that can be triggered by the watchdog.
>
> I will change it from "system power-on reset" to "System POR(Power On Res=
et)" in next patch.
> AFAIK Power On Reset is used for decribing resetting circuits and initial=
ing whatever it needs
> when received a POR signal after powered up. This term should also be app=
licable for
> hardware watchdog reset since the system is already powered up at that mo=
ment and=20

"System POR" isn't an improvement over "system power-on reset". I'm
mainly concerned that somebody might mistake this to somehow mean that
there's an actual power cycle, which, as I understand, there isn't. So
maybe just explain that this type of reset will put the system into the
same state that it would be after a power cycle?

Thierry

--0b310bada9a22be6bb3934105c69e6dfccfb4490b3887f73dfc6b62fff06
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmXdzlgACgkQ3SOs138+
s6FV3A/9E2xaa7fY4Podpe3Oql8JIzZCPAtCtKzCaCy4/GnYEDfspkT44/i1X31D
hbrbmTFeeZi44771obeHv/0A/ookODruAV2ylduv5T1gYdMpjWRvaCsfnasmL0ZU
wunFkLvilQI20ncq/COM30KfLZA6eljfvD9laAS2AHS8GZj2HwRFVvxSsBH/7v1L
GUd3R2TIoChY1pBDVEZPF0ZYl9Dq0O8NoPNfw/g8yhsZOEt8eRQ4IrxC+EKWk/4r
Ju9gLAAXxlnkdpH3P4AhkTzN/fgbJykiSrbxH5rdcpUHheTu373L6V1eaSbe6ZyG
51ngM7OXqBAnXI6d6mXCPfP37InT0xZ9BBjwsboFZ7eYtHA6I7fGpzgTA1+zdjOa
0F4ede8RYEEf3Em46eOAPH3XMv9F1HrsGcaS0vnZRO9LcY5MTGOCpAqTiio92sP0
CQ7QKL0mUeeXi3kjZSHfvbv7M0ZdggNvi3mjgA94aHHauVve793d2xRCwoulbIb5
QZwzVHtBgMAPXwkyj7wWmbzTCAsevPEuu0HWkA7GfW0yKqwhygKInJED/Ql3RXKo
45t8jMGOCdv2yjbu9jNP/zOfl+VN6yGr8XOXQteVaeZvjvC2rCsQ3NE6EWJkVN16
B2BoXjZ1SThXPmInfwO1+KEkkuf7+ZG5vxaJ9j5s2f4vnAdG7Lk=
=Ed17
-----END PGP SIGNATURE-----

--0b310bada9a22be6bb3934105c69e6dfccfb4490b3887f73dfc6b62fff06--

