Return-Path: <linux-kernel+bounces-12699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE46981F90D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1362858C3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F333DD517;
	Thu, 28 Dec 2023 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sSaYratf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60A0883A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40d5a41143fso21507775e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 06:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703773344; x=1704378144; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ycTyKuCg6AYWdYK86Pju7Unfy3xZlo2FyoLEvMCq1QE=;
        b=sSaYratfK3H+gPyaUwhoz4Sxrvw8NFmdUnnAVEHDr/LQkt4Sb2QEjzsiAWyGaTLW/9
         uEaXn3FU27QpaWKsd6DKM77pGGimB33Kbq449FQL83mA/HKGylBoFKw8kQAQinmANygQ
         pp8gf+3rOZlEVPL+3Ntpns34cR7iKxBQ61+tkXxIAxrt1S6db0fUaVUIKIK/PWj3iFuz
         SaW+SEpA9YzTOUOPAehQlbtKy97y4RteTwY+MAxaiWLALkPWZb7VtlFyEyJvaQzxE919
         EXUjA2UAGhe9p8Zq2chXrmn91ZCSJma4ar8w5p9YD9VmmBpMtUYxG7QGz4Dqce/G9W7Z
         VRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703773344; x=1704378144;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ycTyKuCg6AYWdYK86Pju7Unfy3xZlo2FyoLEvMCq1QE=;
        b=N+IxYUO8ff3ptnc5kuG9+FIIWKDyjuiSio+1nUgWwlEvN/oDDOVsPP5GeMAUUd9XtK
         6NJRBOHCbj2B62dT1JwaYX/45LXsXNZIO6VIx+rZ138jT4Hjo1wf2q8QSqlTDWeS0er/
         RyF82TPtCuV5sS0Nx3rDHTSM/Dz8r6TzUFXpvXXp3NCF+oKhMZIHzRKTuavWZimAI5nG
         qQ831FHW6VNCn7qpq+luGm9OZBYyQC1kQ6xhlBZf9GeSrJUE/iPuXOARZSl2cB5f/hbV
         u3p6ERR3+7xMFuzgT+1xfFQB4c3wmYKPzZrXpcaiyQ1N+OPArXZ/MylTWr/CiYS59Sua
         UOUQ==
X-Gm-Message-State: AOJu0Yw5e9FTqn6w5JyVtMpIkWHq46cQ4+MC+iAj7QilkciC44KUSGvS
	ENQT17/ckrqwD4rzskLVO+2/jfCkhsBkPw==
X-Google-Smtp-Source: AGHT+IF7Y+vb4J0pHbvv95oe1mN5Y8Zu/nZlOrbGCyTdcvIPgWbzLoCwmU0azPl/MDHggoogLpoBVw==
X-Received: by 2002:a05:600c:4594:b0:40d:5ca1:80bc with SMTP id r20-20020a05600c459400b0040d5ca180bcmr1792499wmo.107.1703773344106;
        Thu, 28 Dec 2023 06:22:24 -0800 (PST)
Received: from salami.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c471100b0040d5fcaefcesm5028325wmo.19.2023.12.28.06.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 06:22:23 -0800 (PST)
Message-ID: <5a961a6992d7661e6c7589496438cad7b68d4f5a.camel@linaro.org>
Subject: Re: [PATCH v2 10/12] arm64: dts: exynos: gs101: update USI UART to
 use peric0 clocks
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, peter.griffin@linaro.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 mturquette@baylibre.com,  sboyd@kernel.org, conor+dt@kernel.org,
 andi.shyti@kernel.org,  alim.akhtar@samsung.com,
 gregkh@linuxfoundation.org, jirislaby@kernel.org,  s.nawrocki@samsung.com,
 tomasz.figa@gmail.com, cw00.choi@samsung.com,  arnd@arndb.de,
 semen.protsenko@linaro.org
Cc: saravanak@google.com, willmcvicker@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-serial@vger.kernel.org, kernel-team@android.com
Date: Thu, 28 Dec 2023 14:22:22 +0000
In-Reply-To: <20231228125805.661725-11-tudor.ambarus@linaro.org>
References: <20231228125805.661725-1-tudor.ambarus@linaro.org>
	 <20231228125805.661725-11-tudor.ambarus@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Tudor,

On Thu, 2023-12-28 at 12:58 +0000, Tudor Ambarus wrote:
>=20
> diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/bo=
ot/dts/exynos/google/gs101.dtsi
> [...]
> @@ -380,7 +373,8 @@ serial_0: serial@10a00000 {
> =C2=A0				reg =3D <0x10a00000 0xc0>;
> =C2=A0				interrupts =3D <GIC_SPI 634
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQ_TYPE_LEVEL_HIGH 0>;
> -				clocks =3D <&dummy_clk 0>, <&dummy_clk 0>;
> +				clocks =3D <&cmu_peric0 CLK_GOUT_PERIC0_CLK_PERIC0_USI0_UART_CLK>,
> +					 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP1_IPCLK_0>;

I suspect these two should be the other way around, given the clock-names b=
elow?

> =C2=A0				clock-names =3D "uart", "clk_uart_baud0";
> =C2=A0				samsung,uart-fifosize =3D <256>;
> =C2=A0				status =3D "disabled";

Cheers,
A.

