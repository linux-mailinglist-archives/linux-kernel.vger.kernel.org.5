Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679C9813543
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573927AbjLNPvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573889AbjLNPvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:51:36 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFF712C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:51:41 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-28b0c586c51so255673a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702569100; x=1703173900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4shbPEqVxkGN9H1B1A5vAGpPP6O8/awx28j2SHUPR0=;
        b=Zp9XedpY8de2Q6nzf08cJFKD8lVysD4gbtzSuUyzRBBi1oew3netCqW2f/Ebry/7gv
         9LmB1uhd3JKlAMbPQ/7EFAE1SqOdO2/SDV1ICL7q9KXh0KKNcSoqJnKASNxsqTkC/JRp
         NgAuvJGw2UOtMDGDVzxl6dzu3PsRiDVJ7v9aCukx3j4Enx0HpikUaNkU3LGE7egNgEFX
         5udDHJOAk0W4xdkLFSoSdRxDLOSFXsR0hraMnb6e1Ul744nnh8wooAKnaJ9ODjZbR7uE
         zey7WBMAR4Ey8SmQUy/FlRLu5vivsDaPBQxS6DLg7aluRecEjPWgZQQImSDm5/KPAJy8
         FaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702569100; x=1703173900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4shbPEqVxkGN9H1B1A5vAGpPP6O8/awx28j2SHUPR0=;
        b=neGux/+KzS8msGi5GquvCcUeIh9rjfRY8bDxo+k79Bd9SDngr75qNUW6pnSgjkw604
         S8nhpXVl78EddCFSoXB1COMHGINemNkyqMXZve74Mq0Juu7DI5+UHqG43xgQ1iA6gvsL
         HhqMz1WOiv2rWAPWCX4eSL/y5dElFmkhBlohyeGst+ZrXEewVfb/V8Ieeyn5sqJhJYnM
         p50udCNf2apOqdhBo97XDZMYQz3gWAgiV/t2f8wi/Ei4PksSQzEmAOk7u08QyOhmaR7G
         HM5vo/1EaN3TF8XbhrUDCcKKgfZvYiK1LxGo6hYPSpkouzRynoqfiG8CS9rWhR2haP8f
         v9lA==
X-Gm-Message-State: AOJu0YwW+wgCjPl6waLxjovOUk/qSgczq52qKf0ydhSJ9EBWCULEfofH
        y/u4u6FknH9vDM7mk0g6qmOXdcHgir52a9ClIce0nQ==
X-Google-Smtp-Source: AGHT+IEcLyIBjCeACmNKHeqZ9hHHJ2Q7TjC4blb+sKMEqy3oaRC2aQn0Nv8MggtFAhmMpCa9dnIxmORX9rGbyNPaNqU=
X-Received: by 2002:a17:90a:1b8b:b0:286:6cc1:268 with SMTP id
 w11-20020a17090a1b8b00b002866cc10268mr4586020pjc.51.1702569100651; Thu, 14
 Dec 2023 07:51:40 -0800 (PST)
MIME-Version: 1.0
References: <20231214105243.3707730-1-tudor.ambarus@linaro.org> <20231214105243.3707730-11-tudor.ambarus@linaro.org>
In-Reply-To: <20231214105243.3707730-11-tudor.ambarus@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 14 Dec 2023 09:51:29 -0600
Message-ID: <CAPLW+4nKgAN2_dE1-28KbAobR55pr2RzKD1fjA2WN2A-tQ4MpA@mail.gmail.com>
Subject: Re: [PATCH 10/13] arm64: dts: exynos: gs101: define USI8 with I2C configuration
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     peter.griffin@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org, andi.shyti@kernel.org,
        alim.akhtar@samsung.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        s.nawrocki@samsung.com, tomasz.figa@gmail.com,
        cw00.choi@samsung.com, arnd@arndb.de, andre.draszik@linaro.org,
        saravanak@google.com, willmcvicker@google.com,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 4:53=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
> USI8 I2C is used to communicate with an eeprom found on the battery
> connector. Define USI8 in I2C configuration.
>
> USI8 CONFIG register comes with a 0x0 reset value, meaning that USI8
> doesn't have a default protocol (I2C, SPI, UART) at reset. Thus the
> selection of the protocol is intentionally left for the board dtsi file.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  arch/arm64/boot/dts/exynos/google/gs101.dtsi | 26 ++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/bo=
ot/dts/exynos/google/gs101.dtsi
> index ffb7b4d89a8c..4ea1b180cd0a 100644
> --- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> +++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> @@ -354,6 +354,32 @@ pinctrl_peric0: pinctrl@10840000 {
>                         interrupts =3D <GIC_SPI 625 IRQ_TYPE_LEVEL_HIGH 0=
>;
>                 };
>
> +               usi8: usi@109700c0 {
> +                       compatible =3D "google,gs101-usi",
> +                                    "samsung,exynos850-usi";
> +                       reg =3D <0x109700c0 0x20>;
> +                       ranges;
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <1>;
> +                       clocks =3D <&cmu_peric0 CLK_DOUT_PERIC0_USI8_USI>=
,

Are you sure this is a leaf clock? Usually it's a GATE clock, not a DIV one=
.

> +                                <&cmu_peric0 CLK_GOUT_PERIC0_CLK_PERIC0_=
USI8_USI_CLK>;

Because of following letter-for-letter the crazy TRM clock namings,
now it's not possible to keep 80 characters length in a sane way :(

> +                       clock-names =3D "pclk", "ipclk";
> +                       samsung,sysreg =3D <&sysreg_peric0 0x101c>;

samsung,mode is not needed in this case?

> +                       status =3D "disabled";
> +
> +                       hsi2c_8: i2c@10970000 {
> +                               compatible =3D "google,gs101-hsi2c",
> +                                            "samsung,exynosautov9-hsi2c"=
;
> +                               reg =3D <0x10970000 0xc0>;
> +                               interrupts =3D <GIC_SPI 642
> +                                             IRQ_TYPE_LEVEL_HIGH 0>;

IRQ type constant can fit the previous line.

> +                               clocks =3D <&cmu_peric0 CLK_DOUT_PERIC0_U=
SI8_USI>,
> +                                        <&cmu_peric0 CLK_GOUT_PERIC0_CLK=
_PERIC0_USI8_USI_CLK>;
> +                               clock-names =3D "hsi2c", "hsi2c_pclk";
> +                               status =3D "disabled";

Pinctrl properties are not needed for this node?

> +                       };
> +               };
> +
>                 usi_uart: usi@10a000c0 {
>                         compatible =3D "google,gs101-usi",
>                                      "samsung,exynos850-usi";
> --
> 2.43.0.472.g3155946c3a-goog
>
