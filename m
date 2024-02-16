Return-Path: <linux-kernel+bounces-68478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49733857AD8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBFE5284901
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D3256757;
	Fri, 16 Feb 2024 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arv94Nrl"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFF615491;
	Fri, 16 Feb 2024 11:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708081223; cv=none; b=LyffUVQ5L3TFms3hj11sZobXDyrpXG6oRw1in6bfM2NOCkJ9+bhTz9fGkNsWPIhmhbrJY8Lr25/AUjVBzeYxQ8cqSOAC6XbNtd1/PP3HxPhFob1gG6DxgaL/zcquMg5TFc491UDG/F//HKfdPl4x3SQqfHp2dCmO8RpNDYaCVtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708081223; c=relaxed/simple;
	bh=CHIv7iKSTpiAvZmuBmb9/qlK73+FpJXa8Lg4JrGZpxg=;
	h=Content-Type:Mime-Version:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rF5UdxRv72oJX8xzbaiuV5fRIo9XfpqRXNwoz+tqNuHF8RdPZaN0TiNrYV3Q9zYCeEGf845falSwEfUSKkro+HiI8WxeaFrNPhW9Zwziyxil0ajXFoA368QqrRipmpRqP0gOVsGwOqvzp6XfkeM3Y8zl8Te4a0gooAHdTU+NaPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arv94Nrl; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-562178003a1so723437a12.1;
        Fri, 16 Feb 2024 03:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708081220; x=1708686020; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PLhCxXeXfTy0oKV1PZq76pGTpwbsrb7RXVp5Ag35IfA=;
        b=arv94NrlS/AWzQgV93s9+FKi68/sen4hBq65EDqOqyYkPrGwoP/obI4GmqVhP3fLHu
         KJJzOjvQmSwDwfiGDx0cn6dH7JU/vfVMOknIT+nitBHsf/H/O/PeX1LNvs3PkUTz7nGB
         t+7gWkqtQeztblDvFyJ/Y+0Bzb7giwZLaSPjHq6U1qC56QKy1jY60utyZEJqIqv/M9cQ
         cCTCywlLsTkr2ondSeZ31Wf9cHjuFzSA9oNGFir0j/QRFKAEVISGqlHrg4lM9NhSArXN
         jpwX3kQUxADZoNOB4W/lRZeJABaq96JA7oZ1GJ+ThN6T2rQs9IbaAmMnuQvQT2L9fgZT
         E2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708081220; x=1708686020;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PLhCxXeXfTy0oKV1PZq76pGTpwbsrb7RXVp5Ag35IfA=;
        b=GHR/sdTCbRD0k1yp/aRICgEOcJjnDfZgG07F6okhBypUTjhos2AW1/waYORvk5Ng4+
         JXjLki+1rJeDlZZwn18TJfK5J5EV741GLPx5XVj9U7kqo7EJ0r7aLIdE2SA7VMNbgHag
         RY66w8KUwnij7cBuZ+yw0fop7h8GH0WgMGbU198Dbq7LlX9N0UKTxsonhk5OJf5+Qz4E
         eF3k53uxwJeLAUHZmlUBjnixIX3CgILQD7KPfyte7cEkpzqIhElbMuAEcozOfkEA9Wt8
         kBEneCrRC14aMt7FOQHHKOIs1iPhSkBXvH/D2h7ivsJFb/KG5fpi4Ash3xR9rBhotkce
         DO7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8IzmXBTJOpsTSxqEI48feCvGJUFzb4pc+g0HjBg1PH0CI4ooZfb18gyMDzMwTFxS2pj6oiY1BIDCfEGY2X6SO7rpitlt5n3U/7875rI8q/S+IgukIW93s2jsclqLI3kqY9bNuDkskjVfsBf8wjtz7bizc+ArDIv8UNNRtG1+etOb1nWVs3eLx1sXqg1oC2g0lnJ922l0yWO+th1JyddbVR5oCteXGjrpnf1diCxXHnG2rwCquxK4QR3mwgHMjZIE+c7aNKPL5o/Oil1wLfZX4JFxok/fZUM25POIYyYudznnOa0//nWAIbppY4mMbsvu15h/XGpSAUcf+5VS7eOvNWA==
X-Gm-Message-State: AOJu0YzahorHPBWQ0Nd+HBilNx4JKtcbU1AJs89cjgIniWu7wuKfWdC2
	0g4xMMm92BEqNI35QI0TsEFuhhuEJRFbi4kvDHvcHyzex7xCFDdI
X-Google-Smtp-Source: AGHT+IGJg1U3l1s0cZ7SNrJJLULfB++IrJsj8RGS0gGWbyw09mvwxmMXattq7dTy3fEu4mQVbz3vaQ==
X-Received: by 2002:a17:906:46da:b0:a3c:f6dc:ea46 with SMTP id k26-20020a17090646da00b00a3cf6dcea46mr3038631ejs.49.1708081220098;
        Fri, 16 Feb 2024 03:00:20 -0800 (PST)
Received: from localhost (p200300e41f147f00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f14:7f00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ts4-20020a170907c5c400b00a3df003b6a9sm219235ejc.119.2024.02.16.03.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 03:00:19 -0800 (PST)
Content-Type: multipart/signed;
 boundary=3f4d0b1f359aea3b19397b20b790a1177690846d9dafd4c758ed6e868b5b;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 16 Feb 2024 12:00:18 +0100
Message-Id: <CZ6G9AYXMMHZ.3ABQKCJUHPSLU@gmail.com>
Cc: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
 <openbmc@lists.ozlabs.org>, <linux-tegra@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>, <linux-omap@vger.kernel.org>,
 <linux-mediatek@lists.infradead.org>, <linux-renesas-soc@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH 2/6] arm: dts: Fix dtc interrupt_provider warnings
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Rob Herring" <robh@kernel.org>, <soc@kernel.org>, "Shawn Guo"
 <shawnguo@kernel.org>, "Sascha Hauer" <s.hauer@pengutronix.de>,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>, "Fabio Estevam"
 <festevam@gmail.com>, "NXP Linux Team" <linux-imx@nxp.com>, "Rob Herring"
 <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Tsahee Zidenberg" <tsahee@annapurnalabs.com>, "Antoine Tenart"
 <atenart@kernel.org>, "Joel Stanley" <joel@jms.id.au>, "Andrew Jeffery"
 <andrew@codeconstruct.com.au>, "Ray Jui" <rjui@broadcom.com>, "Scott
 Branden" <sbranden@broadcom.com>, "Broadcom internal kernel review list"
 <bcm-kernel-feedback-list@broadcom.com>, "Andrew Lunn" <andrew@lunn.ch>,
 "Gregory Clement" <gregory.clement@bootlin.com>, "Sebastian Hesselbarth"
 <sebastian.hesselbarth@gmail.com>, =?utf-8?q?Jonathan_Neusch=C3=A4fer?=
 <j.neuschaefer@gmx.net>, "Jonathan Hunter" <jonathanh@nvidia.com>, "Stefan
 Agner" <stefan@agner.ch>, "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
 "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
 =?utf-8?q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, "Tony Lindgren"
 <tony@atomide.com>, "Chanho Min" <chanho.min@lge.com>, "Matthias Brugger"
 <matthias.bgg@gmail.com>, "AngeloGioacchino Del Regno"
 <angelogioacchino.delregno@collabora.com>, "Geert Uytterhoeven"
 <geert+renesas@glider.be>, "Magnus Damm" <magnus.damm@gmail.com>, "Linus
 Walleij" <linusw@kernel.org>, "Imre Kaloz" <kaloz@openwrt.org>, "Bjorn
 Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konrad.dybcio@linaro.org>, "Masahiro Yamada" <masahiroy@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>, "Nicolas Schier"
 <nicolas@fjasle.eu>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240213-arm-dt-cleanups-v1-0-f2dee1292525@kernel.org>
 <20240213-arm-dt-cleanups-v1-2-f2dee1292525@kernel.org>
In-Reply-To: <20240213-arm-dt-cleanups-v1-2-f2dee1292525@kernel.org>

--3f4d0b1f359aea3b19397b20b790a1177690846d9dafd4c758ed6e868b5b
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Feb 13, 2024 at 8:34 PM CET, Rob Herring wrote:
[...]
>  arch/arm/boot/dts/nvidia/tegra30-apalis-v1.1.dtsi      |  1 -
>  arch/arm/boot/dts/nvidia/tegra30-apalis.dtsi           |  1 -
>  arch/arm/boot/dts/nvidia/tegra30-colibri.dtsi          |  1 -
[...]

Acked-by: Thierry Reding <treding@nvidia.com>

--3f4d0b1f359aea3b19397b20b790a1177690846d9dafd4c758ed6e868b5b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmXPQEMACgkQ3SOs138+
s6F44g/+KPT4RF0vNadKSFIV9/iihK84gvvjHc/8S/+Ks+sJw7//4Zws8JtsGdab
UvvmQ8R5uIrvLpONlnmdl8cjWpnA3OV1VMJRgXeYIR/kKZxuoiZF03R8COiGQvfJ
Cf4mq2od1sc4OOIFxTV0KJfp6XbmI09stW6zm5wk1F5CjbnMD0TTgxQhEAsOLfum
aDJefFKp6T8QOlCQhCeYYnXwUIBdoYs7z+SRXBuJWJvgwdPMnyc4M7/5PtW57UXZ
Vn2Hri2+u9imbcIzSUkrPLev1Kg5sWTF7CSICzmA+jTvHQUAZFQQMyjrGFkFTeI/
g/J4ljpwRqBlhXRx5ioNbGqYmptZvuljjH6bT8hDzTRNPdfvZfKJSX2+wWb5+kM7
/CdKfwORAUgMMqqABa4mSxHys/mmyeLJ2idQj/buql4pC7EpgD7SZRadqnaAkD/S
3zxA6VBVq4Jt+6X3kjgGySa0tUyBMSWydLjH/TTkcZtwu8iEEggp7MxiYA2wJhne
Pf5VjnhX5nLnPJuJn/Av5GHF1jvsrt9lENJTmpLFZIzxhxWrPntynrvfbpAV50e3
eWqEDRu7eWFatZNZTrnRhmOHcGO197HIErp20X4PVISOY0uolzuiHFpjQBCUGQdV
1xaTRZPbjaTB4pcqWNxi+mI4M6jIyDJc6COrC2G9t5GYMcbE6W4=
=HY7z
-----END PGP SIGNATURE-----

--3f4d0b1f359aea3b19397b20b790a1177690846d9dafd4c758ed6e868b5b--

