Return-Path: <linux-kernel+bounces-158490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 877BF8B20D9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B424BB2421A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DFC12B163;
	Thu, 25 Apr 2024 12:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bzEEEkKb"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A0A12AACA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 12:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714046580; cv=none; b=PtZXETF9swJhEiLloKWTXQ0zk/oxLO2WAtvPT6vPkfjSsQ6W8p5/nTjP0CDYtPleqo15l5i/DyOS4Szkk2Kdx3dGrhAYAzq3YAvSE/X9gV9x89vWBWKuAUGKKqNqc23eEXQ5xMIF3ahSBrjiulsxsCjlDbkwVMpcONjOwPnJZz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714046580; c=relaxed/simple;
	bh=jphqvKLIukinGvb9JMFC352rTpP7/8VXNF6oX6moPJg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rXDPa4H/LXxOZq1Lhx5OFP78JDBCPn0fFXRmAmxPaMe8Blf+X24bZmLuNumZU5GthQb5P/8ZfR5OoE6VlJXNX4w/inQq34syx2duCsQyMuHeh31mA1yWD5wG91ZWwDUJehqfvoh8hPlU54+jeQVb2oU/z57Sbmxfbg9NzQuNi8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bzEEEkKb; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-343d7ff2350so725591f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 05:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714046578; x=1714651378; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AZtgfXbbk2xQsw1Lmj4dmQHGao3EmNipVbMSfwpwCWw=;
        b=bzEEEkKbvW6eGqugSTDMMWOARDxCjrBsB73AuYu3mBKufCDyBoIybIf87+O8o/cYlo
         8dnUdZWz7hHWcsuR391z2Ojkb/pqqxZqlQCHdC9bYZibdNsvuloWttCqT6b+XqmLs4Uv
         48OkKDEBz208iJOfdVhxV5zKokj68aeJKRxLGZ6kpVaNuokK5jDs2vFgsAlG3QyMuBq5
         VwKvIsDJBDYPid3YjzSDE2MX8GJsE1DbbKcCmdBGjKYCi93pw9si3bzybCHJJSzcPQ9a
         WcWzOPre5zrY/q+I0opcdwYUupRIXZA/bVJR06FpAjSm/HHD48shBQnHYzjWRnbAbEMz
         2zFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714046578; x=1714651378;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AZtgfXbbk2xQsw1Lmj4dmQHGao3EmNipVbMSfwpwCWw=;
        b=l8wfFoeJL+SYo1vLk+1B5iGYhfEG0MCFVop9NNbu2hZiuGhO++Vshus2RxbyMj2nwK
         YQhfhNJssgnuiePHRV6StGBhndqhXAf+26vsQsGVEfxNwR0gFFv0MQ/IZ8zZ9dpiCfhr
         EQ7nsR+uhSRllV9lqL+tLDSXr6FSAR8Vy/7BUn0bsFzswr7bku/RCRiY887W/AKaTu/s
         I4iFbCRLfqqs/OV2JLBSzeKp23p9wMinlzjNG6UzsFcnFrM5IsEqzRYVHgp0fWEyKdXP
         +PzsKPdpQGbjJT1RYc+CVQlmyJn6hXk9N///DRSgIRr86GiV9/xbWV6fqBzRCM09tmIN
         swsw==
X-Forwarded-Encrypted: i=1; AJvYcCUuB9QaotRIICMcJV3hO6IYiytLV8qA87L74Dheus3U+f6nv4DFcfbNhGHSTDPLyoxe70URmkYHjzoP0MYR0tJN0fGgGd/jWZzt/35U
X-Gm-Message-State: AOJu0YznU4G5O6L9pi1GakwaEQrKV5JaZ1o9j5UCowKg8Jh/9wq4t6he
	POFdhF9+R+yC0uueW6wtpAg29JNmDn1ayuoB4x3cmQ8m1qGocMSZn98CG8oqgw4=
X-Google-Smtp-Source: AGHT+IEzZdSed4XOrE4rETuECmfdaxcVqf4C7+1LXgTcZDv2J71RTHhX+CpK/z2WbiePkXS0N6SWDw==
X-Received: by 2002:adf:eeca:0:b0:34b:147f:df67 with SMTP id a10-20020adfeeca000000b0034b147fdf67mr3840631wrp.53.1714046577733;
        Thu, 25 Apr 2024 05:02:57 -0700 (PDT)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id w20-20020adfe054000000b0034a366f26b0sm18062178wrh.87.2024.04.25.05.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 05:02:57 -0700 (PDT)
Message-ID: <52403f522a4f7513c5ee5dae48856988f7141825.camel@linaro.org>
Subject: Re: [PATCH v2 06/14] arm64: dts: exynos: gs101: Add ufs, ufs-phy
 and ufs regulator dt nodes
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, mturquette@baylibre.com, 
 sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
  vkoul@kernel.org, kishon@kernel.org, alim.akhtar@samsung.com,
 avri.altman@wdc.com,  bvanassche@acm.org, s.nawrocki@samsung.com,
 cw00.choi@samsung.com,  jejb@linux.ibm.com, martin.petersen@oracle.com, 
 James.Bottomley@HansenPartnership.com, ebiggers@kernel.org
Cc: linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, tudor.ambarus@linaro.org, 
	saravanak@google.com, willmcvicker@google.com
Date: Thu, 25 Apr 2024 13:02:55 +0100
In-Reply-To: <20240423205006.1785138-7-peter.griffin@linaro.org>
References: <20240423205006.1785138-1-peter.griffin@linaro.org>
	 <20240423205006.1785138-7-peter.griffin@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-04-23 at 21:49 +0100, Peter Griffin wrote:
> Enable the ufs controller, ufs phy and ufs regulator in device tree.
>=20
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
> =C2=A0.../boot/dts/exynos/google/gs101-oriole.dts=C2=A0=C2=A0 | 18 ++++++=
++++
> =C2=A0arch/arm64/boot/dts/exynos/google/gs101.dtsi=C2=A0 | 36 +++++++++++=
++++++++
> =C2=A02 files changed, 54 insertions(+)
>=20

[...]

> +
> +		ufs_0: ufs@14700000 {
> +			compatible =3D "google,gs101-ufs";
> +			reg =3D <0x14700000 0x200>,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <0x14701100 0x200>,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <0x14780000 0xa000>,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <0x14600000 0x100>;
> +			reg-names =3D "hci", "vs_hci", "unipro", "ufsp";
> +			interrupts =3D <GIC_SPI 532 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks =3D <&cmu_hsi2 CLK_GOUT_HSI2_UFS_EMBD_I_ACLK>,
> +				 <&cmu_hsi2 CLK_GOUT_HSI2_UFS_EMBD_I_CLK_UNIPRO>,
> +				 <&cmu_hsi2 CLK_GOUT_HSI2_UFS_EMBD_I_FMP_CLK>,
> +				 <&cmu_hsi2 CLK_GOUT_HSI2_QE_UFS_EMBD_HSI2_ACLK>,
> +				 <&cmu_hsi2 CLK_GOUT_HSI2_QE_UFS_EMBD_HSI2_PCLK>,
> +				 <&cmu_hsi2 CLK_GOUT_HSI2_SYSREG_HSI2_PCLK>;
> +			clock-names =3D "core_clk", "sclk_unipro_main", "fmp",
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ufs_aclk", "ufs_pclk", "sysreg";
> +			freq-table-hz =3D <0 0>, <0 0>, <0 0>, <0 0>, <0 0>, <0 0>;
> +			pinctrl-names =3D "default";
> +			pinctrl-0 =3D <&ufs_rst_n &ufs_refclk_out>;

The preferred order is pinctrl-0 before pinctrl-names (similar to clock-nam=
es and reg-names).

Other than that,

Acked-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>


