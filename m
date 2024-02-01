Return-Path: <linux-kernel+bounces-48308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FA0845A18
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE34028E778
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D366A5F481;
	Thu,  1 Feb 2024 14:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o1L1I5hC"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB6F5D46C
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797339; cv=none; b=Npr833HHaQQ180FcExJfi44uWT0V2gAkJ43pWZRi6iNLHDVlA/XeWu9VNjdLvPMDdUV54y5o5i659zijaegl1ojzFAaM+SdW1rIENQzWGGAW9j/XDuckhmcz1GTA+OztjYdXrEZbHverH2VQWTXsStVkssCvh+9ecysiQMeUtKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797339; c=relaxed/simple;
	bh=1O1AOTNGsQX+i0nDTY1kz81nsRaOmNyTqRoqQQPcBeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LqtEqjz9gXEKjpozRpYZ2HRBE20nIRLITAmbWb9mHOj3legsLG8l5okfiPr+yecU6eoOxZqLEQI4LWE3KVVZlx+Qtl0Z9eIabhONvUd+Lf9ByKt7+TPmDw4OUlnIfMh2R+egAk18Qw2PHsPNbnNwtlyq87Lhg9fGHShsQZgFyHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o1L1I5hC; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5d8bc1caf00so863249a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 06:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706797335; x=1707402135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6RqxSYIRPivOTJEnlw3gOkIIa+Ul1PRzCUBYhNeDdQ=;
        b=o1L1I5hChL71yecrcBoh/i5TxnGFN48SlTa6ffMxWpNnn/Vts3idVS64/7dP191Dea
         DiYTTjTBCDA76pnMxDDZ0DcmGrBC73q3aL8yIEgYqgooHk5jXEGB6cCxLVFPWtObxgaP
         v8UnQmGJQoH5A6CKa6dQ6Mhzyg4wYoghW3FRXDic/G56aAdwh5N0ErQ9mDSI45B7jy0P
         9po+smAMAzRODYtTQgAUK7mFb0TBaS8clJdiFmeMqkggELfeEeO+b5NeB7+Jv6z0w+QX
         DwFtB4b0WCl9/5GdJ/IcIP11HYHNVshU7DSU43QBVjQ0BK9Dru1nyux75FjOqsizqZ+c
         Ko3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706797335; x=1707402135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6RqxSYIRPivOTJEnlw3gOkIIa+Ul1PRzCUBYhNeDdQ=;
        b=tO/epxZ+viMqn8Kk45Ce82QTTQRSiIMQpPo7C/O11L77/j3C05+h5U6pfARGDNSWep
         kdG7DRTzrSpkNuKxR1hA5oRLAFA9iEGlvVCsMOY/PK+BV5p1Hd6G4qd3jeiQaV4qttCn
         q+1YHFsEHoHEP0pQV6IU/oiYn5R2qPCan1dwRpKlCvoOchuNza4HI5OEMHYYlUUCutja
         BsMc2BmRJ3dhy/ogF/e03bzKvbQ6X1HRpI29cbVf5D7DrvfHzOtQPQ7t/An70uzoMo73
         WshoJmdqYuYqKJKGZq4ZV19EIuw82v32AgsWKtcZBs4rxbTlbDLko8SrwbDP4tSh8Bz7
         6oMg==
X-Gm-Message-State: AOJu0YyHatK9zX5g3ZXMeu+KMAyY2ycMpZmZlgplBKWX9FirJun5g6Z6
	NLjC8E9jVlVfjZ9LHtM/v+fsFkddMrXLoPQGnkDxKpHUKtPgrrbn0iKxgC9FdEsu/cWoOaL8ilH
	fv/tGAZhL41oL1QDSJ3Gw/ViH98S7d9QlTpJusQ==
X-Google-Smtp-Source: AGHT+IErbFgMVG98pJg/oaehaHSpsB61MD2tROFlx7fdPd5hSbz2EsbFIOcbXTPEqNs8GfN7zqAzP9yPfu+IfMDWtSA=
X-Received: by 2002:a05:6a20:c526:b0:19c:74d1:b314 with SMTP id
 gm38-20020a056a20c52600b0019c74d1b314mr1891047pzb.17.1706797335445; Thu, 01
 Feb 2024 06:22:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125013858.3986-1-semen.protsenko@linaro.org>
 <20240125013858.3986-4-semen.protsenko@linaro.org> <cd9ca36f-84f6-4cc7-bc1e-a4c5781d2bf2@linaro.org>
In-Reply-To: <cd9ca36f-84f6-4cc7-bc1e-a4c5781d2bf2@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 1 Feb 2024 08:22:04 -0600
Message-ID: <CAPLW+4ke9AJ_7FkmqTsT7kQv3TWYW0_G2rc=RsSGVFuvX2qi-w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: exynos: Add SPI nodes for Exynos850
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 4:31=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 25/01/2024 02:38, Sam Protsenko wrote:
> > Some USI blocks can be configured as SPI controllers. Add corresponding
> > SPI nodes to Exynos850 SoC device tree.
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> > Changes in v2:
> >   - Sorted pinctrl properties properly
> >
> >  arch/arm64/boot/dts/exynos/exynos850.dtsi | 54 +++++++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/exynos/exynos850.dtsi b/arch/arm64/boo=
t/dts/exynos/exynos850.dtsi
> > index 618bc674896e..ca257da74b50 100644
> > --- a/arch/arm64/boot/dts/exynos/exynos850.dtsi
> > +++ b/arch/arm64/boot/dts/exynos/exynos850.dtsi
> > @@ -738,6 +738,24 @@ usi_spi_0: usi@139400c0 {
> >                                <&cmu_peri CLK_GOUT_SPI0_IPCLK>;
> >                       clock-names =3D "pclk", "ipclk";
> >                       status =3D "disabled";
> > +
> > +                     spi_0: spi@13940000 {
> > +                             compatible =3D "samsung,exynos850-spi";
> > +                             reg =3D <0x13940000 0x30>;
> > +                             interrupts =3D <GIC_SPI 221 IRQ_TYPE_LEVE=
L_HIGH>;
> > +                             pinctrl-0 =3D <&spi0_pins>;
> > +                             pinctrl-names =3D "default";
> > +                             clocks =3D <&cmu_peri CLK_GOUT_SPI0_IPCLK=
>,
> > +                                      <&cmu_peri CLK_GOUT_SPI0_PCLK>;
> > +                             clock-names =3D "spi_busclk0", "spi";
> > +                             samsung,spi-src-clk =3D <0>;
> > +                             dmas =3D <&pdma0 5>, <&pdma0 4>;
> > +                             dma-names =3D "tx", "rx";
> > +                             num-cs =3D <1>;
>
> For the future: please keep properties sorted by name, so clocks+name,
> dmas+name, interrupts, pinctrl+name, more-or-less matching DTS coding
> style. address/size cells can go to the end.
>

Noted, thanks! So IIUC, basically follow the order of properties
described at [1], but keep the standard/common properties block
sorted, and then keep vendor properties sorted, right?

[1] Documentation/devicetree/bindings/dts-coding-style.rst

> Best regards,
> Krzysztof
>

