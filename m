Return-Path: <linux-kernel+bounces-95672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CC887511E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54EB6B21B74
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F241F12D779;
	Thu,  7 Mar 2024 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XcxQMjmz"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43CE84FAF
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 14:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709820058; cv=none; b=XrCKIIDZap/RBXS/ga75w55l+SSm4J0uYjI2jGomB5ramKbRxR6BhCSuut5TmjN+Y2LmZHJEKG93v+nI/YRWPgt7pH0rRpqKFTy8mERMx+P5xB85F4WKgWEN0gMTbL2y1OD7jhv1Yo18ZTw0WiMpc3lv8vCu1WUrcJhKh4wGjVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709820058; c=relaxed/simple;
	bh=Rxopbb4SKL4jMO5ZljEMPIK89TPWRCZlHNnv5JnL/EU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZqHqWX+hYWN/pxsu7cjlPwGSr7AG1QCl86W5YZ6cknsBmIy52YOwQaUb6Zmwe14XdzS0u8BXHRL8Ln/Gl+pBIa//58aE3qJiO2AwynCG1gb65/qTeQKXvFF1S1SGhK94geTKdh9v52G/uHlh6+yWNRXITyDbCGA3TCSO+BFTIRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XcxQMjmz; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33e17fc5aceso1234197f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 06:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709820055; x=1710424855; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N+sfvI/pAcUuXIwddArkYjhI/1OGic5sgAQeOfKC660=;
        b=XcxQMjmzfSw8Frs6t3ULyPySjtLTU3nQdLQYh7fQa/uc+4bceEPUkRd5dw4fvvDM2R
         Hj5wPWP5485Xk91p93mHAIjsZFpJ+Xtb++d7mLgXhuKUV5CSgtRrcL4IvII7ASQaW8oA
         HLvo9TxaycevFH2tUQGAQvNb3+LsuKT7gH/nNtFW3IW/m47VTHg1TFUuzQEEl7YWcGtM
         bnrudsZ/uw80z9RX1xhUMWk3ofnAt+bLqMJ0X7d6KIS9vpqhgsCVXkntjTpI9cOQyxm4
         sWx4L5ALVNpxVywnx3LwzyKnlI/+GQnXE+C7f/7dEqsepH4zYexDfsbnuEMvg7cAffna
         +hIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709820055; x=1710424855;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N+sfvI/pAcUuXIwddArkYjhI/1OGic5sgAQeOfKC660=;
        b=i2E7tNfN2t0PcCnqDgPfri8UKKFVGJO/dVUqp/XKTpE7K1dE21dyQ8aPyXKmFUvM1A
         ZwowyGJ3MKTLlbjtB3iYrP9fYNmfl5u4ihErCWQOj+XE6tDG5+Dh/cvjNThu6rvqgBkN
         QtJAGdf2JxhypFjUVS9WQQOFl+9u9LAeV1fRdYILC0AJH3Epq9sLWbaT0NGrOzkigd4x
         AQzAQ9N/ClzBxkAyvHaIRelpQvxlQceGpZTBzOwmHcOx6DndSJBBe4cbwgIiSIn4TS4+
         taR7ineKVRU5i4eeCnbvYQka/an2/JpCF7NLJGPEFJgvfOe1eMbAR8u7mXpeTLNwWVdQ
         6Jpw==
X-Forwarded-Encrypted: i=1; AJvYcCXusAUoHKpcsd6TBkEt8rc8kJz+YVmALfndEENAklrFgtM7UMsXSipLD0Snox3ybmII0jIyLRHq4/8rS/j/or9q6d9PrAVssrh0bLWj
X-Gm-Message-State: AOJu0YyHRAxqr5NEstWzuOV6rM2A7cNclw5QuL+3lTpF/vQdPdswvBEC
	cwSJC2zjgcCnzC2+zJYybWP8pCjI5Zjqvp+kk8ZOtTa2B2C9y6+Ew1uKDUAJ284=
X-Google-Smtp-Source: AGHT+IFbMd/+zXt7hKs6MPmjNpo1tnBVbCHAEDFPGa6AXwQB/KfB3R2bSepofZI8S+6AVPVsYXaOVA==
X-Received: by 2002:adf:a3d4:0:b0:33e:6ce4:feb8 with SMTP id m20-20020adfa3d4000000b0033e6ce4feb8mr1042779wrb.12.1709820055073;
        Thu, 07 Mar 2024 06:00:55 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id hn37-20020a05600ca3a500b00412f478a90bsm2704587wmb.48.2024.03.07.06.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 06:00:53 -0800 (PST)
Message-ID: <3acffe042bde796dc47d4bdcb339f0081a05193c.camel@linaro.org>
Subject: Re: [PATCH] arm64: dts: exynos: gs101: move serial_0
 pinctrl-0/names to dtsi
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, peter.griffin@linaro.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: alim.akhtar@samsung.com, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, willmcvicker@google.com,
 kernel-team@android.com
Date: Thu, 07 Mar 2024 14:00:51 +0000
In-Reply-To: <20240307135248.162752-1-tudor.ambarus@linaro.org>
References: <20240307135248.162752-1-tudor.ambarus@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-03-07 at 13:52 +0000, Tudor Ambarus wrote:
> The pinctrl nodes are coming from the shared gs101-pinctrl.dtsi,
> thus the pinctrl-0/names shall stay in dtsi. Move them.
>=20
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
> =C2=A0arch/arm64/boot/dts/exynos/google/gs101-oriole.dts | 2 --
> =C2=A0arch/arm64/boot/dts/exynos/google/gs101.dtsi=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 2 ++
> =C2=A02 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts b/arch/ar=
m64/boot/dts/exynos/google/gs101-oriole.dts
> index 6ccade2c8cb4..9dc0f47ef646 100644
> --- a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
> +++ b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
> @@ -103,8 +103,6 @@ key_power: key-power-pins {
> =C2=A0};
> =C2=A0
> =C2=A0&serial_0 {
> -	pinctrl-names =3D "default";
> -	pinctrl-0 =3D <&uart0_bus>;
> =C2=A0	status =3D "okay";
> =C2=A0};
> =C2=A0
> diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/bo=
ot/dts/exynos/google/gs101.dtsi
> index 55e6bcb3689e..ee65ed9d2cfc 100644
> --- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> +++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> @@ -421,6 +421,8 @@ serial_0: serial@10a00000 {
> =C2=A0				reg =3D <0x10a00000 0xc0>;
> =C2=A0				interrupts =3D <GIC_SPI 634
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQ_TYPE_LEVEL_HIGH 0>;
> +				pinctrl-names =3D "default";
> +				pinctrl-0 =3D <&uart0_bus>;

The preferred order for these is pinctrl-0 pinctrl-names (and I thought
I had sent a patch for all such issues in gs101, but looks like I
didn't...)

Once addressed:

Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

Cheers,
Andre'


