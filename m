Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B70813557
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573931AbjLNPzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573902AbjLNPzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:55:09 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AF5115
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:55:15 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-28b05a2490bso961189a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702569314; x=1703174114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3dEU5MDIKfW+qCgC0PdqFKd7O+g3bLPZxWTXEaaam8=;
        b=LUyqbVXObIzpamKp0fyTc+Rjv3sguhqfdpED9TmePWCZv+DQG/dqABjbEk0V9Q+uRg
         nD0pZis1uUfhbvMV5ZpUNXnIWzvwEmssJkxnzs5vknuwPWCN1CQFOmtEBppmxh4xVxS6
         KcrEUnjnK8ll51DompifLrq+hhtrACZorfqCrAFgGokXqwzz/3AkrYjEhKgdJLf8TKHD
         WNqSuGRt/DTZNcxdV6vGL5bfJKU6P5WWvmwqoz12BOSNydE17EfFC/y6fSisGB7bCKks
         uDImIVJsm27r8qyePzoYzOkSF4SS9POTHWtJC1EWaCCwdjeQhG+t67dnl1Ft3Bi+gBue
         fr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702569314; x=1703174114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3dEU5MDIKfW+qCgC0PdqFKd7O+g3bLPZxWTXEaaam8=;
        b=O0cTqTTfsjOcOVLtYXlD1j/sXkbI+LExjhMntFcTubgd3Nfu8UdPWHc8hdvb0YpjdS
         QPeeoFbzlVyeOAcZYL5yVr4f5QwFlbhudMcd4hDWgaVJu+81S9dW6/EtccUiAkqT5n7E
         X0jYG7PQQUgilUmo9X2ev02md7237imcNz8XE5c13tHl5e/zhBGtkg/ghJk2aY4nn/KQ
         WZeZPYga9tTTjXqTZyBLnFMIl+t3R7I5gwUr41pzWVpkmFPYmMA2jn2feN5oOEiFe8W1
         zU7dXXO4CZ18c9C/jfzPKJZbjZwAkSAC//jqc3TH14jg+9QFAjbzr934UZrPzCqCrjfj
         JwNQ==
X-Gm-Message-State: AOJu0YyEyXZ+w8FCvIaGz/P0dSkNxUG50TJdfFHOzNxpgVbYbS9QvBFu
        ot8Z+GbxEh7Fdt++kaclYl2unTfefNPcqF1si1j46Q==
X-Google-Smtp-Source: AGHT+IGkTnLdOtrqyXltKJs1dUID0ysgTZE7BI1PV4SJTjovnObU8OGLzeMvBOaKswBq0xLjC9rksw67hcvGeMcAL24=
X-Received: by 2002:a17:90b:948:b0:28a:e356:459b with SMTP id
 dw8-20020a17090b094800b0028ae356459bmr2009364pjb.34.1702569314569; Thu, 14
 Dec 2023 07:55:14 -0800 (PST)
MIME-Version: 1.0
References: <20231214105243.3707730-1-tudor.ambarus@linaro.org> <20231214105243.3707730-12-tudor.ambarus@linaro.org>
In-Reply-To: <20231214105243.3707730-12-tudor.ambarus@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 14 Dec 2023 09:55:03 -0600
Message-ID: <CAPLW+4nTgam4jZ+s5m5E05jWO_kfSy=fMS0Ywp3yQEEn-UESbg@mail.gmail.com>
Subject: Re: [PATCH 11/13] arm64: dts: exynos: gs101: enable eeprom on gs101-oriole
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     peter.griffin@linaro.org, robh+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org,
        andi.shyti@kernel.org, alim.akhtar@samsung.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, s.nawrocki@samsung.com,
        tomasz.figa@gmail.com, cw00.choi@samsung.com, arnd@arndb.de,
        andre.draszik@linaro.org, saravanak@google.com,
        willmcvicker@google.com, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 4:53=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
> Enable the eeprom found on the battery connector.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  .../boot/dts/exynos/google/gs101-oriole.dts    | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts b/arch/ar=
m64/boot/dts/exynos/google/gs101-oriole.dts
> index 4a71f752200d..11b299d21c5d 100644
> --- a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
> +++ b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
> @@ -63,6 +63,19 @@ &ext_200m {
>         clock-frequency =3D <200000000>;
>  };
>
> +&hsi2c_8 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&hsi2c8_bus>;
> +       #address-cells =3D <1>;
> +       #size-cells =3D <0>;

Not sure if those 4 above properties belong in board's dts or in SoC's
dtsi. Krzysztof, what do you think?

Other than that:

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

> +       status =3D "okay";
> +
> +       eeprom: eeprom@50 {
> +               compatible =3D "atmel,24c08";
> +               reg =3D <0x50>;
> +       };
> +};
> +
>  &pinctrl_far_alive {
>         key_voldown: key-voldown-pins {
>                 samsung,pins =3D "gpa7-3";
> @@ -99,6 +112,11 @@ &usi_uart {
>         status =3D "okay";
>  };
>
> +&usi8 {
> +       samsung,mode =3D <USI_V2_I2C>;
> +       status =3D "okay";
> +};
> +
>  &watchdog_cl0 {
>         timeout-sec =3D <30>;
>         status =3D "okay";
> --
> 2.43.0.472.g3155946c3a-goog
>
