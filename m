Return-Path: <linux-kernel+bounces-75981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD5785F17E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE5DF283C19
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E638417988;
	Thu, 22 Feb 2024 06:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtyG5mHn"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4871426C;
	Thu, 22 Feb 2024 06:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708583171; cv=none; b=eJ8roPUgymve24WbbQNlgyGFbXnpxmCDZWZRXAN8mHbCJYyKkqwWjrppIcaJpwqfZkGHHm+S6EnO8+3edDy7k3DJmkHfxCnEkUTn0Vnt9OR8dlQZ2WNkPOSBPRabQ8XQ7ESWTlWSJqvQSJgjDeVt6Jdp021VXZq707HHq/UJUG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708583171; c=relaxed/simple;
	bh=bJ1twsr03OapjBwkQaHjmdwACj8NrQG6gyKvRlbVwqc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I8CVAzD1uki4vk+Qoa5L4b1tCqKI7ppxBL46jGWsU+lVvmCqWJDIgZQ/NpNejuLQIXVpki3qv0B4Y6Lf+zRXI8adokT8Ld8ZpOSCjnA8Az6IKH1HN8hAJPykPpbJ4ayFKfBoDYsDFap9LzVtVKJ0LMmcZmke6cPctnWSdQVF2y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtyG5mHn; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bbb4806f67so5012335b6e.3;
        Wed, 21 Feb 2024 22:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708583169; x=1709187969; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bJ1twsr03OapjBwkQaHjmdwACj8NrQG6gyKvRlbVwqc=;
        b=WtyG5mHnzE/zYeTKcoxFj79AnTkjKCmuC08gc5b0mfBia3OreIehxVomBFviUxSP9/
         psPhGeIrm0mVLdjNQKCmGRTpk/YxLO5c4LnIrhAxARsFvCw6kMgWcCZcfgB80/80ZI32
         CiAQT5WLMo6lq5CTn+KTsbTQSl7o0NrvM3EO8muiV2F5+fmkWOtB5QrFIEMVmmD8nAp8
         AXdDTy59WM1sNJlImd++qYwiUkphxQiuC6D/rAcc7S9psVy0J9GwFc7tq65YKDik81n4
         09xfBYD/swRQcNtABlIZIfr5OMy8HaVoE3ydMW8LHmjJZtBPx5A3f0EsidJdqkP0nB/u
         UtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708583169; x=1709187969;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bJ1twsr03OapjBwkQaHjmdwACj8NrQG6gyKvRlbVwqc=;
        b=jmqlmKSCilWktAiadMg9Ke2vefSnXwTnXKJ/YHXyrCchvNBPDleHmJFS+FkZhqRB6m
         lZS/mybIPaaV58q1L3QOHbKe16aSy2ASN2eHrnyUg9KmF5Mt9vB6AXMbNhzyGzOgKCdX
         nu9oxsgLsC3LH3R6RNZLoaZl2azE9Q49/Z0cJpmICoyTh9x1cLeAgx58z5dBF7zzFZkn
         L4HHsHQI9dVx4zUjoCdnTqRBqcRIhRwTsXgRtd5Kg8viZGeFCnutxWC1FLRUExnfZKQp
         JILHYkAXp99B+tbxQ2rzAYdcexV1zxhj7SaISIH36gK07rdHb57WiD9UT/k0cn3Cx6Qq
         9+9A==
X-Forwarded-Encrypted: i=1; AJvYcCXC6tdax7hB0+uwVFvG65I1nlzF5Tfzr97It3WBWyfGTMUtv8YooQNTrL2DS0CVN92R3NLlUA+c3GWNF9eDgxEjMr3PrGQIJL19glLXCFtU5M25YMq/4041qLRGvTBoGqvEPqBDydEoJA==
X-Gm-Message-State: AOJu0YwOCK0ul5BSX3CRdCLjrp01UhwQ06ecB+esiswXzPQyiDGgQ1Ty
	ly/pCmJywErxFkw1A2uOKXOIPqVbqhA4MxaFHOZ62FGU+sSXytn7
X-Google-Smtp-Source: AGHT+IHAomqPxKafdzM743TheVu1Mjl3kppCOPQ88mzZ84ChvxtOLQJl14XErPBzkVWfh6vIeg6c8g==
X-Received: by 2002:a05:6808:1314:b0:3c1:4979:888a with SMTP id y20-20020a056808131400b003c14979888amr18327038oiv.12.1708583168834;
        Wed, 21 Feb 2024 22:26:08 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id c25-20020aa78c19000000b006e45cffab54sm7776093pfd.49.2024.02.21.22.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 22:26:08 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 3D8E218628703; Thu, 22 Feb 2024 13:26:06 +0700 (WIB)
Date: Thu, 22 Feb 2024 13:26:05 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux ARM <linux-arm-msm@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Linux Devicetree <devicetree@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Aram M." <aram.minasyan@yahoo.com>
Subject: Qualcomm Snapdragon 8cx Gen 2 not supported yet?
Message-ID: <Zdbo_aXDZ8YLIiQh@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7HrsSCrKRc9ZB3FB"
Content-Disposition: inline


--7HrsSCrKRc9ZB3FB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Aram M. <aram.minasyan@yahoo.com> opened Bugzilla ticket requesting devicet=
ree
support for sc8180xp [1]. He wrote:

> The Linux kernel 6.7.5 only boots in ACPI mode on DELL Inspiron 14 3420
> with Qualcomm Snapdragon 8cx Gen 2 (sc8180xp).
> A lot of hardware is not functional, this maybe due to missing device tre=
e?
> Built in keyboard and PCIe devices not working, only runs on USB connecte=
d disk, keyboard & peripherals.
>=20
> Support for sc8180x & sc8280xp devices exist, but not for sc8180xp device=
s.
>=20
> Under arch/arm64/boot/dts/qcom in source tree the files
> sc8180x-pmics.dtsi, sc8180x.dtsi, sc8280xp-pmics.dtsi, sc8280xp.dtsi.
> exist, but none for sc8180xp, which would be used for specific hardware d=
ts=20
> files?
> Maybe the hardware is similar enough to sc8180x? But of course I have no =
idea.
>=20
> It would be nice for the keyboard to function without the device tree, se=
ems like module i2c_qcom_geni doesn't work without dtb?
>=20
>=20
> I have attached dmesg output.

Aram, can you submit devicetree patch supporting your device?

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D218512

--=20
An old man doll... just what I always wanted! - Clara

--7HrsSCrKRc9ZB3FB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZdbo+AAKCRD2uYlJVVFO
o0qdAQDDveJKpdEdrfwMMr3jYfzrABJO0ahSONN7cC7xANpSCwEAkwNYBx12CUlp
wer0WC+RRya8hs3Fmn975/62ViRyGgo=
=I7XZ
-----END PGP SIGNATURE-----

--7HrsSCrKRc9ZB3FB--

