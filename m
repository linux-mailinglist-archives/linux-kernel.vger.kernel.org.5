Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF75E8019B3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 02:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjLBBpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 20:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLBBpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 20:45:05 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52094F1
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 17:45:09 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6d7fc4661faso812158a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 17:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701481508; x=1702086308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEhBHN8VbNTSZ80HrOax/U+nyc8vUjuAU0nMFJkgYg0=;
        b=ddWQY+K8z4Na3b3mDxDDDpEvCV/Hq3xR/VezTBCxlH+6oe7Qi0Vh2975oN4ioCr9yC
         d+g0iTbIPvjFIpVQz1bVYGc2eVPE1I7YJnLsqOzwSRWrM+FnJ+dLB1qI3zktgeZKpbnK
         0T7V2V25S4iofwIXRpFfEa/32rk2XRgbTFEiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701481508; x=1702086308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AEhBHN8VbNTSZ80HrOax/U+nyc8vUjuAU0nMFJkgYg0=;
        b=vunSuXA2glRLy0d1jRPM+uXqFyZLHhhp+BUt8kt8TObeGkbRHYAz3P1eOvj/bp+LyV
         rYQz2d7izsgAgU6Nte4dq9QD5izquDaoOKbm0KCtOYwe3YVbc4m2BbV1MfA8VEWqbyBb
         qfckTbIVLKPnh4s6RMB56xnNbML9+UtZgI3M8Q1f5HUGteVklZciRkaRq+mC9YXQA4cJ
         FR93gSoZQ+LjRwXipSZleUmeABjOGvsTw+EHqQyozPugOJwoJLc6a4P36+DhGXIcnyc5
         G4/i57QwiSllKflvVJ4WBC6FVb5td9i4rJwItFWDjgIyDog2MTe/OeZMjG6HJKsZ9kMt
         Z3Cw==
X-Gm-Message-State: AOJu0YyVmq7Z8xOOidUTq2enI+2kxbX8EQ6EyPmiwimfM13MBJ432HBQ
        QtxATW/ve2hRBz2DKKdXayUnr3GEYD5+V9Pb/Pw4xw==
X-Google-Smtp-Source: AGHT+IHm6JkQcChFtigJpby7DNcj+ghLGqdLy7xAZomgEUCmwUBtA96uNNJnkhGNGGUMwe4XdXtWmX53OPnA/nRo31I=
X-Received: by 2002:a05:6830:1696:b0:6d8:5534:61f9 with SMTP id
 k22-20020a056830169600b006d8553461f9mr541143otr.35.1701481508614; Fri, 01 Dec
 2023 17:45:08 -0800 (PST)
MIME-Version: 1.0
References: <20231201070719.1229447-1-wenst@chromium.org> <20231201070719.1229447-7-wenst@chromium.org>
In-Reply-To: <20231201070719.1229447-7-wenst@chromium.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 1 Dec 2023 17:44:42 -0800
Message-ID: <CAJMQK-iPT6p1izqQCHmJD2+E_RmnDKQfxsgMetnKtwNgLUmx1A@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] arm64: dts: mediatek: Add MT8186 Krabby platform
 based Tentacruel / Tentacool
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023 at 5:39=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> wr=
ote:
>
> Tentacruel and Tentacool are MT8186 based Chromebooks based on the
> Krabby design.
>
> Tentacruel, also known as the ASUS Chromebook CM14 Flip CM1402F, is a
> convertible device with touchscreen and stylus.
>
> Tentacool, also known as the ASUS Chromebook CM14 CM1402C, is a laptop
> device. It does not have a touchscreen or stylus.
>
> The two devices both have two variants. The difference is a second
> source touchpad controller that shares the same address as the original,
> but is incompatible.
>
> The extra SKU IDs for the Tentacruel devices map to different sensor
> components attached to the Embedded Controller. These are not visible
> to the main processor.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v1:
> - Reorder SKU numbers in descending order.
> - Fixed pinconfig node names
> - Moved pinctrl-* properties after interrupts-*
> - Switched to interrupts-extended for external components
> - Marked ADSP as explicitly disabled, with a comment explaining that it
>   stalls the system
> - Renamed "touchpad" to "trackpad"
> - Dropped bogus "no-laneswap" property from it6505 node
> - Moved "realtek,jd-src" property to after all the regulator supplies
> - Switched to macros for MT6366 regulator "regulator-allowed-modes"
> - Renamed "vgpu" regulator name to allow coupling, with a comment
>   containing the name used in the design
> - Renamed "cr50" node name to "tpm"
> - Moved trackpad_pins reference up to i2c2; workaround for second source
>   component resource sharing.
> - Fix copyright year
> - Fixed touchscreen supply name
>
>  arch/arm64/boot/dts/mediatek/Makefile         |    4 +
>  .../dts/mediatek/mt8186-corsola-krabby.dtsi   |  129 ++
>  .../mt8186-corsola-tentacool-sku327681.dts    |   57 +
>  .../mt8186-corsola-tentacool-sku327683.dts    |   26 +
>  .../mt8186-corsola-tentacruel-sku262144.dts   |   44 +
>  .../mt8186-corsola-tentacruel-sku262148.dts   |   28 +
>  .../boot/dts/mediatek/mt8186-corsola.dtsi     | 1719 +++++++++++++++++
>  7 files changed, 2007 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-krabby.dt=
si
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool=
-sku327681.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool=
-sku327683.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacrue=
l-sku262144.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacrue=
l-sku262148.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
>
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/=
mediatek/Makefile
> index e6e7592a3645..442af61b1305 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile

<snip>

> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327=
683.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327683.d=
ts
> new file mode 100644
> index 000000000000..2e4d8df978c1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327683.dts
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2023 Google LLC
> + */
> +
> +#include "mt8186-corsola-tentacool-sku327681.dts"
> +
> +/ {
> +       compatible =3D "google,tentacruel-sku327683", "google,tentacruel"=
, "mediatek,mt8186";
> +};
> +
> +/* This variant replaces only the touchpad controller. */
> +&i2c2 {
> +       /delete-node/ touchpad@15;

corsola.dtsi has this node named trackpad@15.

> +
> +       touchpad@15 {
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&trackpad_pin>;
> +               compatible =3D "hid-over-i2c";
> +               reg =3D <0x15>;
> +               interrupts-extended =3D <&pio 11 IRQ_TYPE_LEVEL_LOW>;
> +               hid-descr-addr =3D <0x0001>;
> +               vdd-supply =3D <&pp3300_s3>;
> +               wakeup-source;
> +       };
> +};

<snip>

> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku26=
2148.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262148=
.dts
> new file mode 100644
> index 000000000000..7841046084dc
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262148.dt=
s
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2023 Google LLC
> + */
> +
> +#include "mt8186-corsola-tentacruel-sku262144.dts"
> +
> +/ {
> +       compatible =3D "google,tentacruel-sku262151", "google,tentacruel-=
sku262150",
> +                    "google,tentacruel-sku262149", "google,tentacruel-sk=
u262148",
> +                    "google,tentacruel", "mediatek,mt8186";
> +};
> +
> +/* This variant replaces only the touchpad controller. */
> +&i2c2 {
> +       /delete-node/ touchpad@15;
> +

ditto.

> +       touchpad@15 {
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&trackpad_pin>;
> +               compatible =3D "hid-over-i2c";
> +               reg =3D <0x15>;
> +               interrupts-extended =3D <&pio 11 IRQ_TYPE_LEVEL_LOW>;
> +               hid-descr-addr =3D <0x0001>;
> +               vdd-supply =3D <&pp3300_s3>;
> +               wakeup-source;
> +       };
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/arm6=
4/boot/dts/mediatek/mt8186-corsola.dtsi
> new file mode 100644
> index 000000000000..c5446b18783d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
> @@ -0,0 +1,1719 @@

<snip>

> +
> +&i2c2 {
> +       pinctrl-names =3D "default";
> +       /*
> +        * Trackpad pin put here to work around second source components
> +        * sharing the pinmux
> +        */
> +       pinctrl-0 =3D <&i2c2_pins>, <&trackpad_pin>;
> +       clock-frequency =3D <400000>;
> +       i2c-scl-internal-delay-ns =3D <10000>;
> +       status =3D "okay";
> +
> +       trackpad@15 {
> +               compatible =3D "elan,ekth3000";
> +               reg =3D <0x15>;
> +               interrupts-extended =3D <&pio 11 IRQ_TYPE_LEVEL_LOW>;
> +               vcc-supply =3D <&pp3300_s3>;
> +               wakeup-source;
> +       };
> +};
> +

<snip>
