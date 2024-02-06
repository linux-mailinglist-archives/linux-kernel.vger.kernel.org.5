Return-Path: <linux-kernel+bounces-55076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFE284B75C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD79D1C24E5A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1590113175E;
	Tue,  6 Feb 2024 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDlGHzHs"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4323131727;
	Tue,  6 Feb 2024 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707228435; cv=none; b=C6EBTnvRIBFPwWfpVQblpE2vgdNcuovFWGYgpwrSJe6m1JfWC9aDT63EG7jL43jx8XDtB69N6boB9OPJKjqdannx58B5wKs2CHC+HEVlkbSLm1GBzKJpLheP0wovFfD4Y9Vc9zb/OAoOTw9LPgqrF7zdV1n7bOORg1xbB76SUys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707228435; c=relaxed/simple;
	bh=q2wNq7y5zjR7zAn2na8XIo5UOuQ5bQiWtaEkyUGvvxM=;
	h=Content-Type:Mime-Version:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=A/WBYhnJxjBGAHCJTAws6puogHd3XXQnzyJ3v7BmMUCesf2DqSRbbe/Y75bEbrQuSSYzglJyUigkSqZZk8ZguDt8Y/cXOi3nEb9cl7dxxhY7+HZVd8Rh4bYht/R4OejGpXuWd4NejNPze0eGAf7ZlhgKj9YNhY2ND+YKSnWOJ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDlGHzHs; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a2f79e79f0cso126597166b.2;
        Tue, 06 Feb 2024 06:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707228432; x=1707833232; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KJpUKC6j6AC0vU6wV4VW+IEIUWwwFLgFCR86lJPnIQU=;
        b=dDlGHzHsd+iVBz4d8H8jU8iko/CCdhNNb1ieGY6x2/Od/h+K71P6NTR1XHfVfX+8k+
         p4vEstF8gwIQxVwk6aYxTGlzOLpXPyp8/odYoAe83wCAwI8ze6D46NHQZbyL2SFhT0NT
         77eGIPsGCW1LTcLuIZLexauxUnoErfXoefGabe6o4/EyoA+1qWbgpORAzUsJkYGj/rjY
         0swA/aF/KLMQ2ne8Vfx2LogdgatD3fwlBJ9zXbtj1/UDZRZze0wWmqCJsHZYe08DD+pr
         xU6ZvSmU38l7nNLIchiNKqvuLRVW1GdZtVIlkklg5QNxQNSKoL8eor7h91kwnkBBZiAG
         N+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707228432; x=1707833232;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KJpUKC6j6AC0vU6wV4VW+IEIUWwwFLgFCR86lJPnIQU=;
        b=iBxTNsl9CyG/zX1N9wmZOkKebNaLTDWZ/GDFdcflTbwfi9m0KN60QzWuOQL2AM2bVK
         EvWPB8FB6glaXEYoUnrtljxuJPShluJzHFdHzSn0Y46PvXALMt02PhkRbwCy4CCBBcAf
         fsTUDmGatoOzr/b3iLWn5PiIylDd+8WQvkwKQ99NtA3pRjgNLGD+zf2RHTGzsufNCRB3
         hoyF6UL3TiUqO/hElvwJaGUFyy6F98aG4KDpAKvzAtDwqGUl7+/g/6OiyZ0wCNwu9xWA
         dKGB3UMZPLT5q5lIrJyb0UVaYT/FB9n+hQZoVWdcKRcmfmjrtiSZWH6dr7LufXXA502V
         rKiA==
X-Gm-Message-State: AOJu0Yw6OX6u1H67s2kVFtzfp5lAz/qYdTkb6Alm+k4UEHAKAnbA0Bxa
	Yv2xQQfWarxzJMKid37wOby5sWOfTfN/zUpxlKDgHa8ypox0fVqq
X-Google-Smtp-Source: AGHT+IE/QybOw6uj6bLI+Ru49AYLlR1hq5HimT9v3C509yFpaajgpFQUQCfVIbDf2OhBKk6dV8GDPA==
X-Received: by 2002:a17:906:bc94:b0:a36:fb2c:8701 with SMTP id lv20-20020a170906bc9400b00a36fb2c8701mr2326547ejb.55.1707228431319;
        Tue, 06 Feb 2024 06:07:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXh0yc71LykZC9JSWb5oekCf0lhF0643l3OUVNsNNG2We6Bp8OZ/c5AHsz7OdNKaVwmMUJX55L0GbTkAah7WZC4byEf7H8rm3TUSzd1fKTkvNcprfXXXGHzjfbCcepOwOGzMnmwptHwpXRGFlWooQPdXx9z+bfILOFmT3MJFvnU07K6SpM596UdCVFCoHuGEjSALZc2jrZUSmK25M+YxtAphr7n/ggZkRNaP5RmOToxDti+w3lvKH1xV463jeXvdDK8HMveN1Hj5U5Lw+DXOG8gvmzdjRh7yXSGKHHapxEdlyAWMKvSkgDhsXu5xrmIsw==
Received: from localhost (p200300e41f147f00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f14:7f00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id vi11-20020a170907d40b00b00a3807aa93e1sm1165636ejc.222.2024.02.06.06.07.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 06:07:10 -0800 (PST)
Content-Type: multipart/signed;
 boundary=a57af45cc5955d68bdbf93fbe21e37380f2864359968660b19cc3d7e95c6;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 06 Feb 2024 15:07:10 +0100
Message-Id: <CYY1YXL0FWK2.1L5CRNMKUF22J@gmail.com>
Cc: "Sumit Gupta" <sumitg@nvidia.com>, <treding@nvidia.com>,
 <krzysztof.kozlowski@linaro.org>, <mark.rutland@arm.com>,
 <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
 <amhetre@nvidia.com>, <bbasu@nvidia.com>
Subject: Re: [Patch] memory: tegra: Skip SID override from Guest VM
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Marc Zyngier" <maz@kernel.org>, "Jon Hunter" <jonathanh@nvidia.com>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240206114852.8472-1-sumitg@nvidia.com>
 <86wmrh6b2n.wl-maz@kernel.org>
 <252d6094-b2d6-496d-b28f-93507a193ede@nvidia.com>
 <86v87169g2.wl-maz@kernel.org>
In-Reply-To: <86v87169g2.wl-maz@kernel.org>

--a57af45cc5955d68bdbf93fbe21e37380f2864359968660b19cc3d7e95c6
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Feb 6, 2024 at 1:53 PM CET, Marc Zyngier wrote:
> On Tue, 06 Feb 2024 12:28:27 +0000, Jon Hunter <jonathanh@nvidia.com> wro=
te:
> > On 06/02/2024 12:17, Marc Zyngier wrote:
[...]
> > > - My own tegra186 HW doesn't have VHE, since it is ARMv8.0, and this
> > >    helper will always return 'false'. How could this result in
> > >    something that still works? Can I get a free CPU upgrade?
> >=20
> > I thought this API just checks to see if we are in EL2?
>
> It does. And that's the problem. On ARMv8.0, we run the Linux kernel
> at EL1. Tegra186 is ARMv8.0 (Denver + A57). So as written, this change
> breaks the very platform it intends to support.

To clarify, the code that accesses these registers is shared across
Tegra186 and later chips. Tegra194 and later do support ARMv8.1 VHE.

Granted, if it always returns false on Tegra186 that's not what we
want.

> > > - If you assign this device to a VM and that the hypervisor doesn't
> > >    correctly virtualise it, then it is a different device and you
> > >    should simply advertise it something else. Or even better, fix you=
r
> > >    hypervisor.
> >=20
> > Sumit can add some more details on why we don't completely disable the
> > device for guest OSs.
>
> It's not about disabling it. It is about correctly supporting it
> (providing full emulation for it), or advertising it as something
> different so that SW can handle it differently.

It's really not a different device. It's exactly the same device except
that accessing some registers isn't permitted. We also can't easily
remove parts of the register region from device tree because these are
intermixed with other registers that we do want access to.

> Poking into the internals of how the kernel is booted for a driver
> that isn't tied to the core architecture (because it would need to
> access system registers, for example) is not an acceptable outcome.

So what would be the better option? Use a different compatible string to
make the driver handle the device differently? Or adding a custom
property to the device tree node to mark this as running in a
virtualized environment?

Perhaps we can reuse the top-level hypervisor node? That seems to only
ever have been used for Xen on 32-bit ARM, so not sure if that'd still
be appropriate.

Thierry

--a57af45cc5955d68bdbf93fbe21e37380f2864359968660b19cc3d7e95c6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmXCPQ4ACgkQ3SOs138+
s6FwlQ//VXIIRE1nFoDgCaZ79DgjEg3oOeQn6S/vAx4tfVMtsRrkpmxy4y56+/ft
lOjQ7mmXqYJiMVIoNVdxDEcZfwVsE740IDjsuJpMmI10BmZ4siqVc6Mj3ZmVwwKo
g46SrmLzXDMmhhT+YSdc0IoHhrDSU7XJTxig0cKaGRv44YQrsrKAjyRxtUVblHTg
wO7Ybxq1c+z2AKlhTEBUNgcaxUcQ9jBze6Gki3kuHOVpkxtRrZdxmHz41CtBkhim
cVVCufxKtrcBkGY0iYlF7I8eZhL1xaXQtdoIzPZ9A6Bla2LVx/fICkwHqH2aCzjg
9RrzH5tuHvv46vFC70BK2VK0fwdlxvvUMZJPZUqtFMTagz/JdyG3FredDhaPPp3Z
LN5xAoDiqOLucBlygGSOhBd4002KOowMtDN6fYDXVFN+nUJc0g5xUJPBUXoUwYDb
kr/Gh/RtaKdE4/4hcdHITNrPCUgv4TKkBMqMOynkTSEzwF24nHA6gHuLNd6E9ntB
2TpldvhxZaUfEeKGxtdGV0AVTIrxgZvBFUxINhbrJWW8W8pijh2iM/D4q9vBdT4R
mkE8ResmkedMQo8pYx4boSI9whZdt0bC8s/KSoTWuvEoM7BSsVZ1ibnLKOEQC6fu
PdYvbal6LrrRUlNAUlum8gCz7nXmPbKctnRHt2x6JKD0Tz/Cj/I=
=Ow9u
-----END PGP SIGNATURE-----

--a57af45cc5955d68bdbf93fbe21e37380f2864359968660b19cc3d7e95c6--

