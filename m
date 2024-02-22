Return-Path: <linux-kernel+bounces-76968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A9E85FF2E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBE081C25180
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A43D19478;
	Thu, 22 Feb 2024 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InY9sYoE"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9036A154BE3;
	Thu, 22 Feb 2024 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622393; cv=none; b=o0vfJyOu9tHFjPWXkye0peXK3pdz+XTSYHSv/3l/8APHbkc0J15uj1HGjwVaVY+9a4NyQC5jjDO7LcyoKipBvexSJIAN0UY4QNfieumR2+AS/lKg9x/H45mHOdLHfWfbPJpX0ECKQSe6FtmajnUq1irDldatdDWs3OFpcS1ibs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622393; c=relaxed/simple;
	bh=8CEg/RKdoDPInzI7juj6Pe6d6f/MCz9OOa+Abxcwaq0=;
	h=Content-Type:Mime-Version:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=P9G7ZbXVSuMG37vKx4ZUhpVhJa900VAIdq/pEzeaa9Ad1WmBe0AQNzkwWX6/NQMZ52n4iQCANTH1PWtXae67kVXlyPtOmhnVjCgo4yw6LCH+axC78OyO/zyILSw+KME+0Bok3z4ZvpEo/6+anzFLJGRAmV3+2CLGJgAEp+iGXiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InY9sYoE; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3f5808b0dfso265033266b.1;
        Thu, 22 Feb 2024 09:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708622390; x=1709227190; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CQMhMz89ycmZ70Ia4sIX+P56KQVZUaP0RVmqAd/9EXs=;
        b=InY9sYoEUxm9LCJTB9VHQXmzpqr5KVHNSohIL7LDhjDCgy4oYsys0xKoO6rNfqgHZ2
         ExIpdnhnc7WFSb1GpicPRmq3YB1Sf/ROfutzuNj0/ozgpkwtVHbyOv3/AdjLAwyPZ9O6
         MzxDDDQTiVKFXfAElVQdQkN9kXG5qvDp3KPwnFg6hSv7DT5Lk3Bs7rR9lJ6x4DSbxkr6
         98q9Yu/AliKUWwp6C3HecFLzvVY4Gsh1xGeljUuWzlbMAIuwW8OuZBKg+7eHrQeWzchA
         QRRdMNC5j6qa++mmwuu2YQlSZU1TMDipmcSDHlliU25n0riXl54pw5S1miOFBOfwhXxH
         TFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708622390; x=1709227190;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CQMhMz89ycmZ70Ia4sIX+P56KQVZUaP0RVmqAd/9EXs=;
        b=uIalnx8i3uf9yhMxTLMyGm9jDdW0SgsrTMqse6D4GJHXrQBX5SrDAK1/lNvUGO4tTJ
         bFEsYVXetDf/6Cc5wBDoMDVSvuAIx1ULJlXd5/j+Be70ib9sSzzQ18b+oonFw4TUn6+2
         /qjoQn2UB96XlzagiZ7ggTc/w4vKBUDxQZnF2WX/dvsMgBGPAwx6RzBlxcm+k5vs6esf
         MvGpsHIdRAD62EacJdg+gqnuKcmw3N5NbHGMdy9GKzURS1fpwCAy5KARtviFk7EDEMZd
         2fBfm97YReOYemo7jEkWNtcVIp1qcbxjhOD/cx9sMtWu0jS1X++q0NQcqkUSor+oJSDj
         /H2g==
X-Forwarded-Encrypted: i=1; AJvYcCW9DyWEhdzBEwBFC0qqJdM/odKO5D24einiQ0KbV7ek2jB9ePGqz9RON5yl2xwgvhrplQkoI8wuU3BoeG8DndXwRDlA4ZeOSOgbx4ZROh26Fx8ykfLClmi3rwY0dzPv7kxpwWOvfrCB7EMuhPryMY7pL7FGEbnwwCnuQu3W63/KVUq+s3W0TFum5WQ=
X-Gm-Message-State: AOJu0Yzo4xPpbisiQunqMwF1WG7/CIudEF39MDp5WGvb3avuKj1wVH7r
	WGEa8PfuE0I45jyxvnDprD/MfC1B2GH6dp6qpErIOk8uvSRcuX7ibtg8nndN
X-Google-Smtp-Source: AGHT+IG/A2Zz+TNmcwZ83Ix3GENVBoY4VDLiLrmD1Q4+RDnMLOBCPfXOIHB3Cs54Y2XtVODY2oQdSA==
X-Received: by 2002:a17:906:5fd7:b0:a3e:4f8b:bcc5 with SMTP id k23-20020a1709065fd700b00a3e4f8bbcc5mr9505053ejv.34.1708622389841;
        Thu, 22 Feb 2024 09:19:49 -0800 (PST)
Received: from localhost (p200300e41f2d4600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f2d:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id vw3-20020a170907a70300b00a3fb4d11809sm25842ejc.204.2024.02.22.09.19.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 09:19:49 -0800 (PST)
Content-Type: multipart/signed;
 boundary=0688b8b99b58602d6dc6058d279e832db2b7d6c583f7afba1028c2f475c1;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Thu, 22 Feb 2024 18:19:48 +0100
Message-Id: <CZBS35EFPNLY.3UV6B9TKIU1@gmail.com>
Cc: <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] Tegra30: add support for LG tegra based phones
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Svyatoslav Ryhel" <clamor95@gmail.com>, "Rob Herring"
 <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Jonathan Hunter" <jonathanh@nvidia.com>, "Kees Cook"
 <keescook@chromium.org>, "Maxim Schwalm" <maxim.schwalm@gmail.com>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240214091201.17636-1-clamor95@gmail.com>
In-Reply-To: <20240214091201.17636-1-clamor95@gmail.com>

--0688b8b99b58602d6dc6058d279e832db2b7d6c583f7afba1028c2f475c1
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Feb 14, 2024 at 10:11 AM CET, Svyatoslav Ryhel wrote:
> Bring up Tegra 3 based LG phones Optimus 4X HD and Optimus Vu based
> on LG X3 board.
>
> ---
> Changes from v3:
> - set max77663 ldo0 to be always on since it is required by the SOC
> - adjusted bluetooth module comment
> - added enable gpio to dw9714 focuser
>
> Changes from v2:
> - switched from _ to - in node names
>
> Changes from v1:
> - switched from prefix lge to lg
> ---
>
> Maxim Schwalm (1):
>   dt-bindings: arm: tegra: Add LG Optimus Vu P895 and Optimus 4X P880
>
> Svyatoslav Ryhel (2):
>   ARM: tegra: Add device-tree for LG Optimus Vu (P895)
>   ARM: tegra: Add device-tree for LG Optimus 4X HD (P880)
>
>  .../devicetree/bindings/arm/tegra.yaml        |    8 +
>  arch/arm/boot/dts/nvidia/Makefile             |    2 +
>  arch/arm/boot/dts/nvidia/tegra30-lg-p880.dts  |  489 +++++
>  arch/arm/boot/dts/nvidia/tegra30-lg-p895.dts  |  496 +++++
>  arch/arm/boot/dts/nvidia/tegra30-lg-x3.dtsi   | 1812 +++++++++++++++++
>  5 files changed, 2807 insertions(+)
>  create mode 100644 arch/arm/boot/dts/nvidia/tegra30-lg-p880.dts
>  create mode 100644 arch/arm/boot/dts/nvidia/tegra30-lg-p895.dts
>  create mode 100644 arch/arm/boot/dts/nvidia/tegra30-lg-x3.dtsi

Applied, thanks.

Thierry

--0688b8b99b58602d6dc6058d279e832db2b7d6c583f7afba1028c2f475c1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmXXgjUACgkQ3SOs138+
s6EQnw//T3TGiscSn6UwTQWA/k7/K4loL3jUeWw3q5tn04EP5N6dqJBuKEg3WF48
DYu1z6Z5P6lUS/axfxPnszFqEJu99g+O8OgJgqlcv7dOaoL3RXLBCiWHzqCV6fsP
i7gfak36LTv8fTY88JG3xl1T27VL7rNjQ8qMFh1iqXQrRvKFtEEpkIFGAF/liMQT
EmqTBSIO7HJE+ER1nscITCU3rUuZ4I17ZMQo+MZVYp1otdHnqI8qzWNL/cGb9k6a
SchIHrOXO/jCXjh4j1tWh0pVrPQtN89c66MM8qllGw+0ef1dl9tqzSsPUDT9OvkK
R7SWbYrYAwBGhTSMwrKmtMSl2fI5VHRyr1RSewvmflfpup6P+wgfDJENT1/9B/pl
FkX3UzZiLY4tKc8SQ38rXL6MoYYaHTpaL6Nz210tPm96lJvPrx/dM2Ge+MCt3Bv0
47hUWslfhPe9UhggaTDz3Nrm81PCCMH9s7ucV9BQSbwwHYRNzJLI0aHmuABzLFu6
vJ0IXW+9N9wG6usjbzujq/LHCEDhm6eNHI4yXIASoz6BzuH9nfQHv91oHg5WhkNM
8356TcPyz+Q6vsRI6QPsnKGcEIaDxen9GW6/VjxqkbPUfRO1274lCczrHsWpJP73
8yYfQ25yz4OyfTkBUiKwfC38JDXbEFwPElTUDQcWzJ9NbBqs0E0=
=tZ71
-----END PGP SIGNATURE-----

--0688b8b99b58602d6dc6058d279e832db2b7d6c583f7afba1028c2f475c1--

