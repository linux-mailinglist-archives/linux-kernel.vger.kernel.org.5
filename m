Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACDC78A4F5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 06:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjH1Egj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 00:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjH1EgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 00:36:15 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD2C124
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 21:36:12 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-48d2c072030so2383251e0c.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 21:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693197371; x=1693802171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nh8L7SPw4RViz9VA1sF9ySvJTG7C06Vhgexpn6PD42w=;
        b=L/uZO4Gd3rjoW8dAVPF8qpTF14OjQc/iyfqEvuSjsN+vpmLaz2qz9kgrH/gJgSaHcx
         a7qqgKWxqUd2UNVJ8CajAhS3p1JFPLDBSD1t+c//3GJXE+W9iXqUWGwES4VRDvAVl1Pk
         oW81fzl2yq9uKzE2pqV22LqM6coCNGimOnZ7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693197371; x=1693802171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nh8L7SPw4RViz9VA1sF9ySvJTG7C06Vhgexpn6PD42w=;
        b=Qaxlz97ia98E+Z7stwB/um2LlMPD469NX7tRXbzHhm54FUM1Se0ngBchWKOV8pyeig
         pCIW0z7OBIjnCYvGQJDVzApIot0bUBqFnU7DjIDfsYJ+IExq0Blj1ex/64dfee6hNtMn
         3mhAnM9a2E2/k0zM4f2d7zpuuRQus2afxmAr9/RwlVsI9fyeVG5vJUZRQvwfGEuPslsL
         Viwza0UJfY8/wQ7PeXZShSY0gk+BmXd29BohbxFW3job3tGcZ5S5nzH4XMl8vvBbrf+1
         CXcmEIEE9M9XGS1VrDbUgad7OhvV5y7UScpdK0emRqgvtYRN0IvLIEm/Iw/wMXPCy5yO
         wL0w==
X-Gm-Message-State: AOJu0YwlrUqECf10t/AnuWYs0f07+mkdwMa+NUP8Zr1tG9SyVQLyKjSB
        AsHAzdfUCmIZdQ9T6eiXWW1KGzgWSQMe9Zscjm110w==
X-Google-Smtp-Source: AGHT+IHLoDWbp+A1vm+E06DTMTE8I9Noq3kCRigkWJtma4Wg5EkCXXdSuBcCU5DRQCse7QXtHEqJ0euy3T5dp2nQ+sA=
X-Received: by 2002:a1f:c886:0:b0:490:1723:a491 with SMTP id
 y128-20020a1fc886000000b004901723a491mr1909681vkf.5.1693197371386; Sun, 27
 Aug 2023 21:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230825114623.16884-1-macpaul.lin@mediatek.com> <20230825114623.16884-3-macpaul.lin@mediatek.com>
In-Reply-To: <20230825114623.16884-3-macpaul.lin@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 28 Aug 2023 12:36:00 +0800
Message-ID: <CAGXv+5FTuY=ZHB3-2Woit5amRZ=RxByGMq=LQp-es8tWEhAQUA@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: mediatek: mt6360: add PMIC MT6360 related nodes
To:     Macpaul Lin <macpaul.lin@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 7:46=E2=80=AFPM Macpaul Lin <macpaul.lin@mediatek.c=
om> wrote:
>
> MT6360 is the secondary PMIC for MT8195.
> It supports USB Type-C and PD functions.
> Add MT6360 related common nodes which is used for MT8195 platform, includ=
es
>  - charger
>  - ADC
>  - LED
>  - regulators
>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt6360.dtsi | 112 +++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6360.dtsi
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt6360.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt6360.dtsi
> new file mode 100644
> index 000000000000..e841f4e5a54b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt6360.dtsi
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2023 MediaTek Inc.
> + */
> +
> +#include <dt-bindings/regulator/mediatek,mt6360-regulator.h>
> +
> +&mt6360 {
> +       interrupt-controller;
> +       interrupt-parent =3D <&pio>;
> +       interrupt-names =3D "IRQB";
> +
> +       charger {
> +               compatible =3D "mediatek,mt6360-chg";
> +               richtek,vinovp-microvolt =3D <14500000>;
> +
> +               otg_vbus_regulator: usb-otg-vbus-regulator {
> +                       regulator-compatible =3D "usb-otg-vbus";
> +                       regulator-name =3D "usb-otg-vbus";
> +                       regulator-min-microvolt =3D <4425000>;
> +                       regulator-max-microvolt =3D <5825000>;
> +               };
> +       };
> +
> +       adc {
> +               compatible =3D "mediatek,mt6360-adc";
> +               #io-channel-cells =3D <1>;
> +       };
> +
> +       led {
> +               compatible =3D "mediatek,mt6360-led";
> +       };
> +
> +       regulator {
> +               compatible =3D "mediatek,mt6360-regulator";
> +               LDO_VIN3-supply =3D <&mt6360_buck2>;
> +
> +               mt6360_buck1: buck1 {
> +                       regulator-compatible =3D "BUCK1";
> +                       regulator-name =3D "mt6360,buck1";

Normally there's no need to provide a default name. Any used regulator
should have been named to match the power rail name from the board's
schematics.

> +                       regulator-min-microvolt =3D <300000>;
> +                       regulator-max-microvolt =3D <1300000>;

These values correspond to the regulator's range. They make no sense as
regulator constraints. The min/max values are supposed to be the most
restrictive set of voltages of the regulator consumers. If what is fed
by this regulator can only take 0.7V ~ 1.1V, then it should save 0.7V
and 1.1V here. If the regulator is unused, then there are no constraints,
and these can be left out.

Just leave them out of the file.

Both comments apply to all the regulators.

ChenYu

> +                       regulator-allowed-modes =3D <MT6360_OPMODE_NORMAL
> +                                                  MT6360_OPMODE_LP
> +                                                  MT6360_OPMODE_ULP>;
> +               };
> +
> +               mt6360_buck2: buck2 {
> +                       regulator-compatible =3D "BUCK2";
> +                       regulator-name =3D "mt6360,buck2";
> +                       regulator-min-microvolt =3D <300000>;
> +                       regulator-max-microvolt =3D <1300000>;
> +                       regulator-allowed-modes =3D <MT6360_OPMODE_NORMAL
> +                                                  MT6360_OPMODE_LP
> +                                                  MT6360_OPMODE_ULP>;
> +               };
> +
> +               mt6360_ldo1: ldo1 {
> +                       regulator-compatible =3D "LDO1";
> +                       regulator-name =3D "mt6360,ldo1";
> +                       regulator-min-microvolt =3D <1200000>;
> +                       regulator-max-microvolt =3D <3600000>;
> +                       regulator-allowed-modes =3D <MT6360_OPMODE_NORMAL
> +                                                  MT6360_OPMODE_LP>;
> +               };
> +
> +               mt6360_ldo2: ldo2 {
> +                       regulator-compatible =3D "LDO2";
> +                       regulator-name =3D "mt6360,ldo2";
> +                       regulator-min-microvolt =3D <1200000>;
> +                       regulator-max-microvolt =3D <3600000>;
> +                       regulator-allowed-modes =3D <MT6360_OPMODE_NORMAL
> +                                                  MT6360_OPMODE_LP>;
> +               };
> +
> +               mt6360_ldo3: ldo3 {
> +                       regulator-compatible =3D "LDO3";
> +                       regulator-name =3D "mt6360,ldo3";
> +                       regulator-min-microvolt =3D <1200000>;
> +                       regulator-max-microvolt =3D <3600000>;
> +                       regulator-allowed-modes =3D <MT6360_OPMODE_NORMAL
> +                                                  MT6360_OPMODE_LP>;
> +               };
> +
> +               mt6360_ldo5: ldo5 {
> +                       regulator-compatible =3D "LDO5";
> +                       regulator-name =3D "mt6360,ldo5";
> +                       regulator-min-microvolt =3D <2700000>;
> +                       regulator-max-microvolt =3D <3600000>;
> +                       regulator-allowed-modes =3D <MT6360_OPMODE_NORMAL
> +                                                  MT6360_OPMODE_LP>;
> +               };
> +
> +               mt6360_ldo6: ldo6 {
> +                       regulator-compatible =3D "LDO6";
> +                       regulator-name =3D "mt6360,ldo6";
> +                       regulator-min-microvolt =3D <500000>;
> +                       regulator-max-microvolt =3D <2100000>;
> +                       regulator-allowed-modes =3D <MT6360_OPMODE_NORMAL
> +                                                  MT6360_OPMODE_LP>;
> +               };
> +
> +               mt6360_ldo7: ldo7 {
> +                       regulator-compatible =3D "LDO7";
> +                       regulator-name =3D "mt6360,ldo7";
> +                       regulator-min-microvolt =3D <500000>;
> +                       regulator-max-microvolt =3D <2100000>;
> +                       regulator-allowed-modes =3D <MT6360_OPMODE_NORMAL
> +                                                  MT6360_OPMODE_LP>;
> +               };
> +       };
> +};
> --
> 2.18.0
>
>
