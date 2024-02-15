Return-Path: <linux-kernel+bounces-67729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D25C856FBB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2401B21752
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC791420B8;
	Thu, 15 Feb 2024 22:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GW94aQAm"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7719013DB92;
	Thu, 15 Feb 2024 22:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708034473; cv=none; b=Q6AwkAsu8wmZ1ionzg8C2dnZbssV0C05f/CBU7lxTEuI4GiZcb+jR0lFLeTcd1H9cdNw7lceDkQ/8s3wZOGCYeh8hL8ure6HVNALVVmIaDyUZmpdVAA0qRzPmO9J2JDMwUHpTuRlV3UJs03hOUCVseAD1W3LDUMvvYlIjbzKQnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708034473; c=relaxed/simple;
	bh=r+fF7hspTcauMVJ6ENMToSqRGVf6qDI5uFjl4h27hAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZlNVU/QdeSJRCul54X1ZyO6xtCUfMrqfkKv2TGq9QAAufeTIu8gwUoGdlzquzhJfwcj/ipb0XTEsV2bZ0DPDskMbohzYrhx4Lm6kWaML3OOhFdZwdgvmjehQjcClAyjbEIXdQPmMcMZ08bzy/2w4QiIVsizsHmk2W09Kz1d6Gdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GW94aQAm; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-296cca9169bso1173304a91.3;
        Thu, 15 Feb 2024 14:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708034472; x=1708639272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMw8ym7Hes5nA0a7OJqANqfyz//pYIxa/w4OlCDzeSo=;
        b=GW94aQAmzsoSd5vlP3RBwLdJgdtzvLK2Vca4Du4/QJ7+MOxbPM+DhVSrGHuL1spbdt
         MjqSR8651mH4zaZIRdQ1OA7cdpRWKab3aX21Hz4gm9UmOiQIGxj7TPD785h575Zgzd2k
         LfpXKKaVEkzDb2PjIj8qOQW2Chz4VutITKUPXr+u1sGXpsQB/6uRimYKgiH7VnT4En+8
         7+AKEBfQKYLX5OFnz0i9iJtQsKPAbun25DOzKTE/7HVBKqh1OMA/xYJ1HaUh7DIknE0g
         5658XqlMSNcaQH3pTKZFSvelbLsqspthoBObMIv4skuOOSslWoYc294AwLdRok4CqtIw
         8zoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708034472; x=1708639272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMw8ym7Hes5nA0a7OJqANqfyz//pYIxa/w4OlCDzeSo=;
        b=a9pArIS5WsnjXDdgGzTPSSzsKGYDKExRBIQeKt7pwLZDI1CmSjCahdg3TjrpjbIf8p
         KYnJSQANmAlt00fKpJOBK3KaW1iBb7OChmg/diKVTfeV21lLEWdXAwbdkCxRJy+9nUZF
         R2JNDikOqTHBSz0rLErvm9wXJtHF5yxdh4J0GsmL9ETxysOhEd0gjBFZ7WuEdtEkTP5y
         ySWZKdVPCV8mOEymb5SAIXeHSB5UGAlbavv15dHjBpifJ2rc9XUk43Vi7ehBKtaqh4+Z
         +FY65Rz1gE0ARyvp7vnbReGiNa1zU2Y76qhOE7xDSYfEou15WDfj7jhJFxALmWvCTdrz
         7s1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWuDpdoS/mNA1/457CpH8QJK/m3YVluaZ3m2MjyLR74M3eX/jnUDPmpnwSnOtwniMvztxf8J0qYYO5aJUk2/0Xh9NV5HwwEkyTP1hOrVuRXHoTfQykoToX7DWU4hp4zs11o66s9KmeE+TlMurX00zJzBRnz8fVpXwkFnoAytkLVt/xhQg==
X-Gm-Message-State: AOJu0Yz7Q3HMYChJHh76XwuSfYZYlpsivoiHlIwlu/c8R4vJ/6QV0HMJ
	ppu6y6QVs2aI8/ZWdWoM6HlWCb6MHkoYzymTxd8RMm0o7KTbdiZ05TIJyKGr/lQL1+7AF1bnlRz
	ew/PHgpdJi1rKi48guNtfAbGM2w==
X-Google-Smtp-Source: AGHT+IEi646NKnhmT37pZ1NAnDETQM7w7aM9iIytbbEJKQ+CWwALKbge6VymBHYk2T5dOZHHUtCJikXQx1ipCutpDHw=
X-Received: by 2002:a17:90a:c08f:b0:299:21ef:6b5a with SMTP id
 o15-20020a17090ac08f00b0029921ef6b5amr1710226pjs.24.1708034471706; Thu, 15
 Feb 2024 14:01:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZcH9u7Vo2sFERIHJ@finisterre.sirena.org.uk> <20240207224546.44030-1-frut3k7@gmail.com>
 <20240207224546.44030-2-frut3k7@gmail.com> <cd8c2f79-2307-4ad8-90c7-747d40f14ede@linaro.org>
In-Reply-To: <cd8c2f79-2307-4ad8-90c7-747d40f14ede@linaro.org>
From: frut3k7 <frut3k7@gmail.com>
Date: Thu, 15 Feb 2024 23:01:00 +0100
Message-ID: <CAKEyCaAy9U_qQ=pXPYaGetEuuuVuoejxjKPrG92fBFauy1wwuw@mail.gmail.com>
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

The device I use has the QCA4024 chip connected via the spi controller:
        blsp1_spi4: spi@78b8000 {
            compatible =3D "qcom,spi-qup-v2.2.1";
            #address-cells =3D <1>;
            #size-cells =3D <0>;
            reg =3D <0x78b8000 0x600>;
            interrupts =3D <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
            clocks =3D <&gcc GCC_BLSP1_QUP4_SPI_APPS_CLK>,
                 <&gcc GCC_BLSP1_AHB_CLK>;
            clock-names =3D "core", "iface";
            dmas =3D <&blsp_dma 18>, <&blsp_dma 19>;
            dma-names =3D "tx", "rx";
            status =3D "disabled";
        };

and apart from setting the frequency and gpio there is nothing else:
        &blsp1_spi4 {
            status =3D "okay";

            pinctrl-0 =3D <&spi_3_pins &quartz_pins>;
            pinctrl-names =3D "default";

            /* Qualcomm QCA4024 IoT */
            iot@3 {
                compatible =3D "qca,qca4024";
                reg =3D <0>;
                spi-max-frequency =3D <24000000>;
            };
        };

        &tlmm {
            spi_3_pins: spi-3-state {
                spi-pins {
                    pins =3D "gpio50", "gpio52", "gpio53";
                    function =3D "blsp3_spi";
                    drive-strength =3D <8>;
                    bias-disable;
                };

                cs-pins {
                    pins =3D "gpio22";
                    function =3D "blsp3_spi2";
                    drive-strength =3D <8>;
                    bias-disable;
                };
            };

            quartz_pins: quartz-state {
                interrupt-pins {
                    pins =3D "gpio48";
                    function =3D "gpio";
                    bias-disable;
                    input;
                };

                reset-pins {
                    pins =3D "gpio21";
                    function =3D "gpio";
                    bias-disable;
                    output-high;
                };
            };
        };

On Thu, Feb 8, 2024 at 8:32=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 07/02/2024 23:45, Pawe=C5=82 Owoc wrote:
> > Add Qualcomm QCA4024 to trivial devices.
> >
> > Signed-off-by: Pawe=C5=82 Owoc <frut3k7@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/D=
ocumentation/devicetree/bindings/trivial-devices.yaml
> > index 79dcd92c4a43..c6362e981920 100644
> > --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> > +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> > @@ -309,6 +309,8 @@ properties:
> >            - plx,pex8648
> >              # Pulsedlight LIDAR range-finding sensor
> >            - pulsedlight,lidar-lite-v2
> > +            # Qualcomm QCA4024 Multi-mode Bluetooth and 802.15.4 SoC
> > +          - qca,qca4024
>
>
> As I wrote, Bluetooth chip is not a trivial device. This one
> particular exposes several interfaces to the host, needs a clock and
> power supply.
>
> Best regards,
> Krzysztof
>

