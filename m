Return-Path: <linux-kernel+bounces-76973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1E185FF43
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D16392841D0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B603155307;
	Thu, 22 Feb 2024 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5T27oL3"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25ED1552E9;
	Thu, 22 Feb 2024 17:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622668; cv=none; b=UKWVVuwWxNO+ZA/9uT5M2TcMmgUqqRGORX+DY7KCDjVIyOdP+bLQARSxaGycLE8yvZYzamQLYG1MKsTgyxFlyypImrfkE/lv2eJ/+N9XKQWbpE1U0kndT48GD5Rgp+G70wPr6niM+1f24rFyX4T3EHZz2qyrbj8Ba7/kRcznU6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622668; c=relaxed/simple;
	bh=mB5HR1t4CGsfz9a1IloGkIBehJL9LhPECgUcPMzntPA=;
	h=Content-Type:Mime-Version:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=fGoXGndhACzrq1xw3/vICtwI6s3ZzSssk9frHaL65PntU2XrWa67I/PlsdY8g5dzo4lMiP6cHEwDBFyvs6XbMRh/0As/DKh4e4ubMhnG1VgmWcNXN6B56zE3BT4rEV+ZSogHn3/hmu6bDjtaK1wjE4ZO0+AA2HkBAezNDm7IsTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5T27oL3; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512c2e8c6cfso17130e87.1;
        Thu, 22 Feb 2024 09:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708622665; x=1709227465; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UGSSSHzcuD2w3h77m+4FErM+O8zZreX4G+SB+HfFeNU=;
        b=T5T27oL34Gp0buDBbybB4a2MIU+a8ymZBT5XBMyyD0ET+s0htUXn7AZ/ZlC3p2GmGe
         fBKv7tLzQ6uW36NnHBgfGhTUD8oslX+QISGDGu2FN2UKTaG6uCa55If92l6bQvIPLVsr
         5ytsBvC3zgJ00m4Vpo9oghfMyhdwXDiwWTHF3329HNWGvPYk39b38fpwkpR2nTrrTRjI
         eMCJlW0u2A1r1lxqws76DexIdFYYJpCw/dAnno47vqdOYP+RwG+0mXiQUCZkftkngIPO
         fHuksO5tLAGiylvyKQuVY1YIvE/O3Q3SXaVNBwOiqOtycORLpZn5RTGaU2r3qKDpEouS
         vF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708622665; x=1709227465;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UGSSSHzcuD2w3h77m+4FErM+O8zZreX4G+SB+HfFeNU=;
        b=k6R555RlojNGVp1xUdsLC5IjMBRLXpcVVdJ6hH0FLeBGM/V1kYD8H3+sbHWxY65ulO
         Eu+UPzUammmVQCZKTWghchvAAmNlLPGB3cHPxUlNQERK4KqdOexbELmiuG5l0PoXIkwi
         GMg+6KI6O5nwqwcUzO0Y5j4gJVSsI9RdhkmagakecexvPOVa/suROluL3Tt9yDnkKo63
         ICkiSj442xFlKlUKyK/NGXwx1zV2vAiA3mjqIS/2CxeYEoZX2GpLjCre4aTBYTzTHdVS
         OyYrV2YSHZcysst2NnHMi8vTwT44kH+E/TdYfikX3PgmNF9cYTlLJQgyrSU6+GM145D2
         hACA==
X-Forwarded-Encrypted: i=1; AJvYcCVN3zL8yUkPwGpSOEzI/crtcetSlWHH+rhOQL7zij/YD3OFoOFvVq/+yHArAbI8pwoTU34fRCdXaT4nhumFy+uymBFMIvFGD/PBr5xo+J2V4qStg7TyonOvJejryau+w4czDNCdrqtHRw==
X-Gm-Message-State: AOJu0YxAWToZn/tXWxvuVM7SOQBH8sFrVFicbkOx2mfvC6pt+sTCUNu0
	SdvgWqm1OC4sP6tK6VGWAEdFejDpfGgWlxuakjIUTGaoSiYaHmqS
X-Google-Smtp-Source: AGHT+IHEx1yQZNxT66iUU709fp+1Swa2uVvbnPwCNC8o0jN87XPdqODh6XUDx8mtyDk9PlDUEyIj9w==
X-Received: by 2002:a05:6512:3487:b0:512:be87:9348 with SMTP id v7-20020a056512348700b00512be879348mr5349109lfr.36.1708622664875;
        Thu, 22 Feb 2024 09:24:24 -0800 (PST)
Received: from localhost (p200300e41f2d4600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f2d:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id a7-20020adfeec7000000b0033b483d1abcsm20777394wrp.53.2024.02.22.09.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 09:24:24 -0800 (PST)
Content-Type: multipart/signed;
 boundary=94ba30e1270fd17fe8994149d6c9ed1fc8edc1bf8a49979d11e9a4d7ff5f;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Thu, 22 Feb 2024 18:24:23 +0100
Message-Id: <CZBS6NOQ26HE.2SNQBM5FIB9GG@gmail.com>
Cc: <linux-tegra@vger.kernel.org>, <spujar@nvidia.com>,
 <jonathanh@nvidia.com>, <mkumard@nvidia.com>
Subject: Re: [PATCH 0/4] Add audio support for Jetson Orin NX and Jetson
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Sheetal ." <sheetal@nvidia.com>, <robh+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240207120518.697926-1-sheetal@nvidia.com>
In-Reply-To: <20240207120518.697926-1-sheetal@nvidia.com>

--94ba30e1270fd17fe8994149d6c9ed1fc8edc1bf8a49979d11e9a4d7ff5f
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Feb 7, 2024 at 1:05 PM CET, Sheetal . wrote:
> From: sheetal <sheetal@nvidia.com>
>
> - Move ports from platform DTS to SoC DTSI.
> - Define missing IO ports in SoC DTSI.
> - Add audio support for Jetson Orin NX (p3767 SKU0) module and Jetson
>   Orin Nano (p3767 SKU5) module with p3768 carrier board.
> - Remove the module specific DTSI files as it is already taken
>   care in base DTS file.
>
> sheetal (4):
>   arm64: tegra: Move AHUB ports to SoC DTSI
>   arm64: tegra: Define missing IO ports
>   arm64: tegra: Add audio support for Jetson Orin NX and Jetson Orin
>     Nano
>   arm64: tegra: Remove Jetson Orin NX and Jetson Orin Nano DTSI
>
>  .../arm64/boot/dts/nvidia/tegra234-p3701.dtsi | 1948 ---------------
>  .../boot/dts/nvidia/tegra234-p3767-0000.dtsi  |   14 -
>  .../boot/dts/nvidia/tegra234-p3767-0005.dtsi  |   14 -
>  .../arm64/boot/dts/nvidia/tegra234-p3767.dtsi |   82 +
>  .../nvidia/tegra234-p3768-0000+p3767-0000.dts |    7 +-
>  .../nvidia/tegra234-p3768-0000+p3767-0005.dts |   12 +-
>  arch/arm64/boot/dts/nvidia/tegra234.dtsi      | 2122 ++++++++++++++++-
>  7 files changed, 2198 insertions(+), 2001 deletions(-)
>  delete mode 100644 arch/arm64/boot/dts/nvidia/tegra234-p3767-0000.dtsi
>  delete mode 100644 arch/arm64/boot/dts/nvidia/tegra234-p3767-0005.dtsi

Applied, thanks.

Thierry

--94ba30e1270fd17fe8994149d6c9ed1fc8edc1bf8a49979d11e9a4d7ff5f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmXXg0gACgkQ3SOs138+
s6EwJBAAne4sHozpEIYhpT9nY+aLU9qDvfoHXsSxEmvwyPfDfFGOmwWuua970it/
gIhakKDq2tvKjJuRU9CDFsE1mAlPFOV0UzAdXJD+uzAXQUI3UzUtkfphMraKwTci
MfkvP1TCaJX/yX6pVGNwCYCDN23rbkcX1EpcVVjoOzQo97ITS64sa97q7Sc1lhBT
DcMZUdvAxekT3vVTMXI928POgaff5Y80rE2L2sXX79E9EUsdLaHpkqQnCMFfEcel
vHZgc3jhQGAHVpiSbMQCrRtIbtQPqe+oMyZkw2katy88nG3bEXkJ1wsTHgpAVWHl
AdvDLXBnwOVIyYpESNyoTgt04BsDnFrkw8305qvvysvgelQpBKhxwJis7DmlUPeN
JurmN/tLZpvuUSBhxcqp3nkf2h8or7V4p+tPzRIoRO7s0Ch+rLVoVLHHLA1heKJB
bJXdfF5QUUxmiWIG5o86jUwSZ7/z8+xPNm+XJe5AfHTrnr1VbTFrGHuMcJKyhZcz
BLQXoccg13+Oq+VvTwR/JyfbBuYu8SvcUKNCWQ9Nzg4KxN9E2l28uwYz02M/1cC3
rb+Kts1uqyoEPFBWCVfoS76N/jhMDEysTOenu22VKX6vBc6lVYhDbD9FxF3haAiz
Wm7/QjGsGG8i+rA7AtO488lxNT8S2KMovGj7qkO+z9Tr6cwjCIs=
=QBRH
-----END PGP SIGNATURE-----

--94ba30e1270fd17fe8994149d6c9ed1fc8edc1bf8a49979d11e9a4d7ff5f--

