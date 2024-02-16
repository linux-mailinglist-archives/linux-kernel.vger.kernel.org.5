Return-Path: <linux-kernel+bounces-68651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56178857DD8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC551F279CA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB33312B155;
	Fri, 16 Feb 2024 13:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VL9m6VwJ"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9ED12A15F;
	Fri, 16 Feb 2024 13:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708090773; cv=none; b=hZsK/2BBlMOv6bo3ZFIkKyPMjdN0z8pp6N04F9d5uhX2ZcphQ+peEDRg3RKbgccTYXOrEXKcowV7JXmvLzMB6kJIHx0G/76DjoU94s8Iz/y2lKLqbTo1hsUEFxXuIfIivz15uoW/JyPxq4MhFNoX00+wuRPzp63cSaLf7UXOgD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708090773; c=relaxed/simple;
	bh=FDu00HfUQqbq8LOUT3Fr67reUqKl66h6XTNuu8HMX0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bUjGTc6YBqG8zkbagUqpEwEMV6BLr4AiwPyG+Zwl+qKP3rrVhypodkkJkBgTfBH9JNvq4ksEJOH1AzUILwklS3cLwN6zsNAAIkXGDNc/sGED9H3/uHG1+hXlX4uL1G5WukQN+voS5/qZc9HzeZyjeaz7D76KYSzB2eKog1N6ZjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VL9m6VwJ; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso1630163a12.0;
        Fri, 16 Feb 2024 05:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708090771; x=1708695571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOqL2waxPXgBWJKgEVSZwCFl44Mn/Oy806uHCqDxXrQ=;
        b=VL9m6VwJjgQk6QXeKSYyG39oCkq21z8UgNOIXliiv2JneAl/HMh52WS02yipGv1ViN
         R55HkbctbZXBsxFE77B7WeJTO43l9ULnDqaqIvaTOkhffKHvsUW4CubVgsxjaBWz2qLv
         imtvAnyAo/tNECDIyAKMNe31xiKR04ZnbqQhOPtHFwa3QGWdTflBw3QyPmBytJKzhVCa
         OK9bI3+InLl4+gLGOgGSY+8HASRQxFZHdPm2ZBHx8tFFrwYHQUtDy39WBe1rmgkr489S
         EPVqTyVxvrDSJHAUe0E6Mvho0VxP6hznX0RJmgtOiz0zH8gtIhaQ0L/QF4q/x923uwsx
         fvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708090771; x=1708695571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOqL2waxPXgBWJKgEVSZwCFl44Mn/Oy806uHCqDxXrQ=;
        b=E6j7DwKhj9mk1Tk1FHLDsB9oMoMmmZPjEIh816xIiNNBAtQ+VHoI427Q/itFVMPvvX
         ISUMtedeTORtB9UdWrVmdiNeTMEMPo4pDDei/ZfXEX0GxNgQBbP5nvHj2D9o+hUrkSwU
         k6yjymWG0CEE+J1sVuYcyGpcUvbO6/0I0NW6OQ6kVmC0QMBEH9e50s7L85KisSTVYm0X
         jUop7HnU1J9KJJy2ivyorxRDiPrGXpikHS5wM06X+8hadUcUMed+KU5N19v3YNi43QFU
         G9Dxk8nDGb07Lbnw3REYwyJKIrACWfwzQyQG2o7Of8q9aRW0K0MDqeGgCRPXj4lmzla9
         x66A==
X-Forwarded-Encrypted: i=1; AJvYcCXTvKSy4FhTg9g3BPIH5VgPm1d8mtMaV8/np8cs9kUvw5t99QjjhHgJwW89wlhE1bE8k5bzVDJOWoYx906MG+dHQ5DlQ9MihDlOHwrYCHZSQ8YlaqfKCVj8ok/K6Oz5N0Z6g3yfHPZ2nIbd9F5lLTDj74Xq6YDJGDjStNax+TkSycC/cA==
X-Gm-Message-State: AOJu0Yyh1pR49zMDw/xhvkbYfEtJZ3U/rnQGW+YZY3pU1+ODBdcezsOE
	KUjBxHPtYjPbcvI+uPZRE3nvCd8RHhjhLc7gmDd94MMK1BmJm9V4tTawjBx1I2yaEOlQ7aS2NbT
	0P74q85HAC0EtLnqTCA4618uWNQ==
X-Google-Smtp-Source: AGHT+IGfehBtqkqqjqbZ9qLvhnFe77HVWNt2MibfH86q4iGYZZFvpZ/g9U4+dnBA39NBUnC7mvckcuyiNa8mRg3PcN4=
X-Received: by 2002:a17:90a:c706:b0:296:f874:6844 with SMTP id
 o6-20020a17090ac70600b00296f8746844mr4509458pjt.15.1708090770798; Fri, 16 Feb
 2024 05:39:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZcH9u7Vo2sFERIHJ@finisterre.sirena.org.uk> <20240207224546.44030-1-frut3k7@gmail.com>
 <20240207224546.44030-2-frut3k7@gmail.com> <cd8c2f79-2307-4ad8-90c7-747d40f14ede@linaro.org>
 <CAKEyCaAy9U_qQ=pXPYaGetEuuuVuoejxjKPrG92fBFauy1wwuw@mail.gmail.com> <263bb77f-b91d-4139-91a5-0ddeda0ece17@linaro.org>
In-Reply-To: <263bb77f-b91d-4139-91a5-0ddeda0ece17@linaro.org>
From: =?UTF-8?Q?Pawe=C5=82_Owoc?= <frut3k7@gmail.com>
Date: Fri, 16 Feb 2024 14:39:19 +0100
Message-ID: <CAKEyCaD=2Md8f=K0pfAFmSCQjL0PkBvAzG_g5Me-wpd5iv2rVw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: trivial-devices: Add qca,qca4024
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Robert Marko <robimarko@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
	Peter Yin <peteryin.openbmc@gmail.com>, 
	Patrick Rudolph <patrick.rudolph@9elements.com>, Michal Simek <michal.simek@amd.com>, 
	Marek Vasut <marex@denx.de>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, Fabio Estevam <festevam@denx.de>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

To be clear, I don't want to add support for the QCA4024, I just want
to use this SoC with its own firmware connected to another SoC
(IPQ8072A) via spi.

On Fri, Feb 16, 2024 at 8:19=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 15/02/2024 23:01, frut3k7 wrote:
> > The device I use has the QCA4024 chip connected via the spi controller:
> >         blsp1_spi4: spi@78b8000 {
> >             compatible =3D "qcom,spi-qup-v2.2.1";
> >             #address-cells =3D <1>;
> >             #size-cells =3D <0>;
> >             reg =3D <0x78b8000 0x600>;
> >             interrupts =3D <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> >             clocks =3D <&gcc GCC_BLSP1_QUP4_SPI_APPS_CLK>,
> >                  <&gcc GCC_BLSP1_AHB_CLK>;
> >             clock-names =3D "core", "iface";
> >             dmas =3D <&blsp_dma 18>, <&blsp_dma 19>;
> >             dma-names =3D "tx", "rx";
> >             status =3D "disabled";
> >         };
> >
> > and apart from setting the frequency and gpio there is nothing else:
> >         &blsp1_spi4 {
> >             status =3D "okay";
> >
> >             pinctrl-0 =3D <&spi_3_pins &quartz_pins>;
> >             pinctrl-names =3D "default";
> >
> >             /* Qualcomm QCA4024 IoT */
> >             iot@3 {
> >                 compatible =3D "qca,qca4024";
> >                 reg =3D <0>;
> >                 spi-max-frequency =3D <24000000>;
>
> That's your downstream or fork DTS, not hardware description. You could
> have several regulators not listed here, because your downstream has
> always-on, or clocks which are not taken and works due to
> assigned-clocks in other places... Sorry, that's not an argument. Never
> use downstream DTS as proof how hardware looks. It is usually dis-proof,
> that things are certainly missing.
>
> Best regards,
> Krzysztof
>

