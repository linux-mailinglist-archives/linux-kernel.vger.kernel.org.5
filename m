Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22557BC386
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 03:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbjJGBI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 21:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbjJGBIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 21:08:55 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E305FB6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 18:08:52 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5892832f8daso3012035a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 18:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696640932; x=1697245732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gKkumzJlB1AJAaEBL/3zAyHlpON0qICZEOpcp7SbAQ=;
        b=dTeice77ZUOpWM83KL/phho7/lS06ON9lmG7UvUGAhSGH7E8IRf792QnhnTPvDPrSc
         jJbZYPx3J7TekUHPIVbH/UYPkyLs72r2Ug3qevMBiLKQRuuXi9UUhoqERWpSBI1EcpK0
         eWzVcA2HFxvJI1otgL6Plk4Wo3lcZ752NmVUee74FkhYy9kd/ACZh7P0+Qy+OTdP5W0k
         nz/Fbk/7JkuVxS5cMuZr5n7XI9R3Di1k0KLbWF9wRfIWgi8hwxnQ+vLmJO1tZubyLb/l
         LcrEYAo/sJVGfqydIbjqhnO7tukcF6Pk65LxhZN5j2t60eb8A817kaD22hJoBtzLc+VA
         4qnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696640932; x=1697245732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0gKkumzJlB1AJAaEBL/3zAyHlpON0qICZEOpcp7SbAQ=;
        b=Hqz9zm5VfG0waOJ3GCYnv9dbXqw4SvnA9hVBfKuirvvXhMHx91NzTJ3iPccaqvxxWV
         uAF3pF0hGp2lElJpH+JZW+OEF2LKgirlpEVmh2eXEqDLOdzysxyVpWXIyRPFBPwR/k1w
         92z3WuSQgPkgvYYNJ5SP0egT3itANn/raCylKWWlJta1AUrqlTLa08DFVhb5VGPVSW/N
         W/fkJfILnza2wW2/QfK6OrLksy7erc6YcGdxb3WUUk1h7lKjD1eZs2Lt3Syt+J8N760d
         nxgDzV6EzZUmixIg8jl1laNWeiVWP6jSEw8x+IKEHHFv/8m+WsNf/3sy/VQYIxG5LnwB
         kEow==
X-Gm-Message-State: AOJu0Yxrzgxnc4TA1bgNs30KqPIYNh2JnN2BbCjsMTGD9WgEkDCNUg+q
        3D2969MSOLdS/sARsm4Cs8c1r9t4QY+wCUQ51E4G4w81z7A99cdHJ+ycjQ==
X-Google-Smtp-Source: AGHT+IHMlzOByq27nliJcaGOpNfGMHtU3ypBHuuHm9Bu+ikfNLw+CbrbDZi7WzhODMicpvBhiWJhKVG9lv0MQBORogA=
X-Received: by 2002:a17:90a:1c0f:b0:263:f521:da3e with SMTP id
 s15-20020a17090a1c0f00b00263f521da3emr10764154pjs.2.1696640932299; Fri, 06
 Oct 2023 18:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231006090258.278369-1-tudor.ambarus@linaro.org>
In-Reply-To: <20231006090258.278369-1-tudor.ambarus@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Fri, 6 Oct 2023 20:08:40 -0500
Message-ID: <CAPLW+4m2a=joAo5vQUXruy1f2tVwMyf6dP0S+Z+W4Y2B7u3muA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: exynos: set USI mode in board dts
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski@linaro.org,
        conor+dt@kernel.org, alim.akhtar@samsung.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter.griffin@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 6, 2023 at 4:03=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro.=
org> wrote:
>
> The Universal Serial Interface (USI) provides selectable serial protocol
> (UART, SPI, I2C). Only one function can be used at a time. The SoC
> provides flexibility for boards to choose the protocol desired. Instead
> of selecting the USI protocol mode in the SoC dtsi file, select the mode
> in the board dts file as the USI IP can work in either of the 3 modes,
> but the board uses just one. Where the USI node was not enabled in the
> board dts file, just remove the samsung,mode specified in dtsi.
>

I can comment only on Exynos850 changes, as I don't have the TRM for
ExynosAutoV9.

All USIs found in PERI block have actual default values, which are
reset values of corresponding sysreg SW_CONF registers. Exactly those
values are specified in 'samsung,mode' properties in exynos850.dtsi.
Corresponding regmap_update_bits() driver call would skip writing
those values (as it reads the same reset values from the registers
first), which is also kinda nice consequence of having those defaults.
I still think it's important to stress (in exynos850.dtsi) that PERI
USIs have actual HW defaults, by specifying their values. If some
particular Exynos850-based board wants to actually override that mode,
it can be done in that board's dts file. So yeah, it was designed that
way, and I'd say it's better to leave 'samsung,mode' in dtsi for PERI
USIs as is.

Now CMGP USIs are a different story. They don't have any sensible
reset values in their sysreg SW_CONF registers (i.e. all I2C/SPI/UART
SW_CONF reg fields have '0' reset value). So maybe removing
'samsung,mode' for CMGP USIs in exynos850.dtsi is a reasonable thing
to do. It won't make any functional change at the moment, but it can
be valuable, as a way to emphasize those CMGP USIs don't have any HW
defaults and their mode must be chosen for each particular board.

> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  .../boot/dts/exynos/exynos850-e850-96.dts     |  2 ++
>  arch/arm64/boot/dts/exynos/exynos850.dtsi     |  8 ------
>  .../boot/dts/exynos/exynosautov9-sadk.dts     |  2 ++
>  arch/arm64/boot/dts/exynos/exynosautov9.dtsi  | 25 -------------------
>  4 files changed, 4 insertions(+), 33 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts b/arch/arm6=
4/boot/dts/exynos/exynos850-e850-96.dts
> index 6ed38912507f..615c1d6647ea 100644
> --- a/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
> @@ -15,6 +15,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/leds/common.h>
> +#include <dt-bindings/soc/samsung,exynos-usi.h>
>
>  / {
>         model =3D "WinLink E850-96 board";
> @@ -187,6 +188,7 @@ &serial_0 {
>  };
>
>  &usi_uart {
> +       samsung,mode =3D <USI_V2_UART>;
>         samsung,clkreq-on; /* needed for UART mode */
>         status =3D "okay";
>  };
> diff --git a/arch/arm64/boot/dts/exynos/exynos850.dtsi b/arch/arm64/boot/=
dts/exynos/exynos850.dtsi
> index aa077008b3be..db35ee742a27 100644
> --- a/arch/arm64/boot/dts/exynos/exynos850.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos850.dtsi
> @@ -12,7 +12,6 @@
>
>  #include <dt-bindings/clock/exynos850.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> -#include <dt-bindings/soc/samsung,exynos-usi.h>
>
>  / {
>         /* Also known under engineering name Exynos3830 */
> @@ -574,7 +573,6 @@ usi_uart: usi@138200c0 {
>                         compatible =3D "samsung,exynos850-usi";
>                         reg =3D <0x138200c0 0x20>;
>                         samsung,sysreg =3D <&sysreg_peri 0x1010>;
> -                       samsung,mode =3D <USI_V2_UART>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
>                         ranges;
> @@ -600,7 +598,6 @@ usi_hsi2c_0: usi@138a00c0 {
>                         compatible =3D "samsung,exynos850-usi";
>                         reg =3D <0x138a00c0 0x20>;
>                         samsung,sysreg =3D <&sysreg_peri 0x1020>;
> -                       samsung,mode =3D <USI_V2_I2C>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
>                         ranges;
> @@ -628,7 +625,6 @@ usi_hsi2c_1: usi@138b00c0 {
>                         compatible =3D "samsung,exynos850-usi";
>                         reg =3D <0x138b00c0 0x20>;
>                         samsung,sysreg =3D <&sysreg_peri 0x1030>;
> -                       samsung,mode =3D <USI_V2_I2C>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
>                         ranges;
> @@ -656,7 +652,6 @@ usi_hsi2c_2: usi@138c00c0 {
>                         compatible =3D "samsung,exynos850-usi";
>                         reg =3D <0x138c00c0 0x20>;
>                         samsung,sysreg =3D <&sysreg_peri 0x1040>;
> -                       samsung,mode =3D <USI_V2_I2C>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
>                         ranges;
> @@ -684,7 +679,6 @@ usi_spi_0: usi@139400c0 {
>                         compatible =3D "samsung,exynos850-usi";
>                         reg =3D <0x139400c0 0x20>;
>                         samsung,sysreg =3D <&sysreg_peri 0x1050>;
> -                       samsung,mode =3D <USI_V2_SPI>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
>                         ranges;
> @@ -698,7 +692,6 @@ usi_cmgp0: usi@11d000c0 {
>                         compatible =3D "samsung,exynos850-usi";
>                         reg =3D <0x11d000c0 0x20>;
>                         samsung,sysreg =3D <&sysreg_cmgp 0x2000>;
> -                       samsung,mode =3D <USI_V2_I2C>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
>                         ranges;
> @@ -738,7 +731,6 @@ usi_cmgp1: usi@11d200c0 {
>                         compatible =3D "samsung,exynos850-usi";
>                         reg =3D <0x11d200c0 0x20>;
>                         samsung,sysreg =3D <&sysreg_cmgp 0x2010>;
> -                       samsung,mode =3D <USI_V2_I2C>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
>                         ranges;
> diff --git a/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts b/arch/arm6=
4/boot/dts/exynos/exynosautov9-sadk.dts
> index bc1815f6ada2..91d302703366 100644
> --- a/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
> +++ b/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
> @@ -9,6 +9,7 @@
>  /dts-v1/;
>  #include "exynosautov9.dtsi"
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/soc/samsung,exynos-usi.h>
>
>  / {
>         model =3D "Samsung ExynosAuto v9 SADK board";
> @@ -79,6 +80,7 @@ &ufs_1 {
>  };
>
>  &usi_0 {
> +       samsung,mode =3D <USI_V2_UART>;
>         samsung,clkreq-on; /* needed for UART mode */
>         status =3D "okay";
>  };
> diff --git a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi b/arch/arm64/bo=
ot/dts/exynos/exynosautov9.dtsi
> index b228cd7e351e..92f4b738834a 100644
> --- a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
> @@ -9,7 +9,6 @@
>  #include <dt-bindings/clock/samsung,exynosautov9.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/soc/samsung,boot-mode.h>
> -#include <dt-bindings/soc/samsung,exynos-usi.h>
>
>  / {
>         compatible =3D "samsung,exynosautov9";
> @@ -392,7 +391,6 @@ usi_0: usi@103000c0 {
>                                      "samsung,exynos850-usi";
>                         reg =3D <0x103000c0 0x20>;
>                         samsung,sysreg =3D <&syscon_peric0 0x1000>;
> -                       samsung,mode =3D <USI_V2_UART>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
>                         ranges;
> @@ -454,7 +452,6 @@ usi_i2c_0: usi@103100c0 {
>                                      "samsung,exynos850-usi";
>                         reg =3D <0x103100c0 0x20>;
>                         samsung,sysreg =3D <&syscon_peric0 0x1004>;
> -                       samsung,mode =3D <USI_V2_I2C>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
>                         ranges;
> @@ -483,7 +480,6 @@ usi_1: usi@103200c0 {
>                                      "samsung,exynos850-usi";
>                         reg =3D <0x103200c0 0x20>;
>                         samsung,sysreg =3D <&syscon_peric0 0x1008>;
> -                       samsung,mode =3D <USI_V2_UART>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
>                         ranges;
> @@ -545,7 +541,6 @@ usi_i2c_1: usi@103300c0 {
>                                      "samsung,exynos850-usi";
>                         reg =3D <0x103300c0 0x20>;
>                         samsung,sysreg =3D <&syscon_peric0 0x100c>;
> -                       samsung,mode =3D <USI_V2_I2C>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
>                         ranges;
> @@ -574,7 +569,6 @@ usi_2: usi@103400c0 {
>                                      "samsung,exynos850-usi";
>                         reg =3D <0x103400c0 0x20>;
>                         samsung,sysreg =3D <&syscon_peric0 0x1010>;
> -                       samsung,mode =3D <USI_V2_UART>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
>                         ranges;
> @@ -636,7 +630,6 @@ usi_i2c_2: usi@103500c0 {
>                                      "samsung,exynos850-usi";
>                         reg =3D <0x103500c0 0x20>;
>                         samsung,sysreg =3D <&syscon_peric0 0x1014>;
> -                       samsung,mode =3D <USI_V2_I2C>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
>                         ranges;
> @@ -665,7 +658,6 @@ usi_3: usi@103600c0 {
>                                      "samsung,exynos850-usi";
>                         reg =3D <0x103600c0 0x20>;
>                         samsung,sysreg =3D <&syscon_peric0 0x1018>;
> -                       samsung,mode =3D <USI_V2_UART>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
>                         ranges;
> @@ -727,7 +719,6 @@ usi_i2c_3: usi@103700c0 {
>                                      "samsung,exynos850-usi";
>                         reg =3D <0x103700c0 0x20>;
>                         samsung,sysreg =3D <&syscon_peric0 0x101c>;
> -                       samsung,mode =3D <USI_V2_I2C>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
>                         ranges;
> @@ -756,7 +747,6 @@ usi_4: usi@103800c0 {
>                                      "samsung,exynos850-usi";
>                         reg =3D <0x103800c0 0x20>;
>                         samsung,sysreg =3D <&syscon_peric0 0x1020>;
> -                       samsung,mode =3D <USI_V2_UART>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
>                         ranges;
> @@ -818,7 +808,6 @@ usi_i2c_4: usi@103900c0 {
>                                      "samsung,exynos850-usi";
>                         reg =3D <0x103900c0 0x20>;
>                         samsung,sysreg =3D <&syscon_peric0 0x1024>;
> -                       samsung,mode =3D <USI_V2_I2C>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
>                         ranges;
> @@ -847,7 +836,6 @@ usi_5: usi@103a00c0 {
>                                      "samsung,exynos850-usi";
>                         reg =3D <0x103a00c0 0x20>;
>                         samsung,sysreg =3D <&syscon_peric0 0x1028>;
> -                       samsung,mode =3D <USI_V2_UART>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
>                         ranges;
> @@ -909,7 +897,6 @@ usi_i2c_5: usi@103b00c0 {
>                                      "samsung,exynos850-usi";
>                         reg =3D <0x103b00c0 0x20>;
>                         samsung,sysreg =3D <&syscon_peric0 0x102c>;
> -                       samsung,mode =3D <USI_V2_I2C>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
>                         ranges;
> @@ -938,7 +925,6 @@ usi_6: usi@109000c0 {
>                                      "samsung,exynos850-usi";
>                         reg =3D <0x109000c0 0x20>;
>                         samsung,sysreg =3D <&syscon_peric1 0x1000>;
> -                       samsung,mode =3D <USI_V2_UART>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
>                         ranges;
> @@ -1000,7 +986,6 @@ usi_i2c_6: usi@109100c0 {
>                                      "samsung,exynos850-usi";
>                         reg =3D <0x109100c0 0x20>;
>                         samsung,sysreg =3D <&syscon_peric1 0x1004>;
> -                       samsung,mode =3D <USI_V2_I2C>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
>                         ranges;
> @@ -1029,7 +1014,6 @@ usi_7: usi@109200c0 {
>                                      "samsung,exynos850-usi";
>                         reg =3D <0x109200c0 0x20>;
>                         samsung,sysreg =3D <&syscon_peric1 0x1008>;
> -                       samsung,mode =3D <USI_V2_UART>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
>                         ranges;
> @@ -1091,7 +1075,6 @@ usi_i2c_7: usi@109300c0 {
>                                      "samsung,exynos850-usi";
>                         reg =3D <0x109300c0 0x20>;
>                         samsung,sysreg =3D <&syscon_peric1 0x100c>;
> -                       samsung,mode =3D <USI_V2_I2C>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
>                         ranges;
> @@ -1120,7 +1103,6 @@ usi_8: usi@109400c0 {
>                                      "samsung,exynos850-usi";
>                         reg =3D <0x109400c0 0x20>;
>                         samsung,sysreg =3D <&syscon_peric1 0x1010>;
> -                       samsung,mode =3D <USI_V2_UART>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
>                         ranges;
> @@ -1182,7 +1164,6 @@ usi_i2c_8: usi@109500c0 {
>                                      "samsung,exynos850-usi";
>                         reg =3D <0x109500c0 0x20>;
>                         samsung,sysreg =3D <&syscon_peric1 0x1014>;
> -                       samsung,mode =3D <USI_V2_I2C>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
>                         ranges;
> @@ -1211,7 +1192,6 @@ usi_9: usi@109600c0 {
>                                      "samsung,exynos850-usi";
>                         reg =3D <0x109600c0 0x20>;
>                         samsung,sysreg =3D <&syscon_peric1 0x1018>;
> -                       samsung,mode =3D <USI_V2_UART>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
>                         ranges;
> @@ -1273,7 +1253,6 @@ usi_i2c_9: usi@109700c0 {
>                                      "samsung,exynos850-usi";
>                         reg =3D <0x109700c0 0x20>;
>                         samsung,sysreg =3D <&syscon_peric1 0x101c>;
> -                       samsung,mode =3D <USI_V2_I2C>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
>                         ranges;
> @@ -1302,7 +1281,6 @@ usi_10: usi@109800c0 {
>                                      "samsung,exynos850-usi";
>                         reg =3D <0x109800c0 0x20>;
>                         samsung,sysreg =3D <&syscon_peric1 0x1020>;
> -                       samsung,mode =3D <USI_V2_UART>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
>                         ranges;
> @@ -1364,7 +1342,6 @@ usi_i2c_10: usi@109900c0 {
>                                      "samsung,exynos850-usi";
>                         reg =3D <0x109900c0 0x20>;
>                         samsung,sysreg =3D <&syscon_peric1 0x1024>;
> -                       samsung,mode =3D <USI_V2_I2C>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
>                         ranges;
> @@ -1393,7 +1370,6 @@ usi_11: usi@109a00c0 {
>                                      "samsung,exynos850-usi";
>                         reg =3D <0x109a00c0 0x20>;
>                         samsung,sysreg =3D <&syscon_peric1 0x1028>;
> -                       samsung,mode =3D <USI_V2_UART>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
>                         ranges;
> @@ -1453,7 +1429,6 @@ usi_i2c_11: usi@109b00c0 {
>                                      "samsung,exynos850-usi";
>                         reg =3D <0x109b00c0 0x20>;
>                         samsung,sysreg =3D <&syscon_peric1 0x102c>;
> -                       samsung,mode =3D <USI_V2_I2C>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
>                         ranges;
> --
> 2.42.0.609.gbb76f46606-goog
>
