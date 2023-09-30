Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DF27B405B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 14:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbjI3M53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 08:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjI3M50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 08:57:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5DCE6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 05:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
 s=s31663417; t=1696078630; x=1696683430; i=frank-w@public-files.de;
 bh=1cQ3HuKXIF1mPThFuYOTsPaNKR1Gk3qp55at/3uFCBc=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=EEoUSAh14u3J5l5foG6CeiigJBfxBKsr4oZ4oE9NfEzWUGpQnOEjVDivg6pyKrWx6nX2Cpfzm6j
 brqBoptdJjeUsaJK9nSjoPkbCpv2Qd2LOcIQJUH6ZEvCfiKn5JFuxBBonzpuSa+VcPrjvNzZe+Dbs
 8mwOE1PeZPiZEtZnZz02N44X7LAZdNygfIwC240YoL5vXgXbguVnfAGo/Ispt28QMFdSz9BiVqyNm
 ZGqlzxNfc6Nyz4oDE3PCLIr46K1YZSCREWMRvgk7UUKlVoWQwXvc8EY6ymYDGU9bSsvA0YLC7rDZF
 z6CXM7vdi6oM0U+7YNdHxAQRlfNvGdSpQKwQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.152.33] ([217.61.152.33]) by web-mail.gmx.net
 (3c-app-gmx-bs36.server.lan [172.19.170.88]) (via HTTP); Sat, 30 Sep 2023
 14:57:09 +0200
MIME-Version: 1.0
Message-ID: <trinity-3fe161a2-70f1-4619-be28-199ea6201668-1696078629921@3c-app-gmx-bs36>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Frank Wunderlich <linux@fw-web.de>
Subject: Aw: [RFC v1] arm64: dts: mediatek: add dtbs with applied overlays
 for bpi-r3
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 30 Sep 2023 14:57:09 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20230916083214.7059-1-linux@fw-web.de>
References: <20230916083214.7059-1-linux@fw-web.de>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:xgVUp3hQ4hSWgQi6tyM4GTOL7nnTaeGiONOEAMNzVr2x3MXSwA99wM2JIyElwhlptAxSU
 PcVlSycFEy138pXjcEUXubl/pKh79GpplV2t3SUbXwuBxOE9Zg9FoMqu7vAf1xQfKW7xY0g18aH9
 YCVJjEYvgap3NV2sJk/tlMy2tWmFks5dplS5Sd63W8Q6ykY8VoJHBy2MMhwIQouVbrVEKX0gu70k
 7edc2VdoC1khbHlxR8BTG0shUzp2eljfa2hZfOS/sLApETTOMH33rm8/a6nb7SI+g1zWjIj9iRkI
 dg=
UI-OutboundReport: notjunk:1;M01:P0:CDsWDlRXma4=;LEkD/j2srMmq1++2T1jhrjSf2gn
 xkcr3IsPqJi00BwGAkNQWWRlvG6HeQ0Z1L44RqAxgM8chUkCsyAwNy7lLUvtOyrLAYTJjSGqM
 J2i0f1lIw5TCUlCv4lWg7bfV3opi2vpSlF7tXOoLF3tYmjvMimiYIsSQHfHinqGy6RjN93o3w
 ULtq9XJlL0XekO84MPCz9zL4UdE3LBvzdwJaee/5mNNo0LflhSZy51FenkLdrSrzqvNQnZS61
 31ysYxnyvFhO87i2+w/j+81u0sZNc3Ihd9rd8rGWJPOAWdm+gF9QcTmI7dCUxb1nMR0fgEg2C
 JImM3A/2DWcdeAhI0bdbNiDkjKCaqB2vQj0uO6+SSdYf1IxOh28QJWM1Mnaa0SvvVMppzoYO/
 WmixOHvzJ4KdiZEDUAf0HWXrTifMPIto61HrNhHMx6Z08TlEfgs0Yu5T2Eb2ztt98HUa0BAL2
 L58ejJFT2eZZuZm3Iw4q+f0/XxnqaIf+WrrYiYJUN7XGMXO0l5anYajZ51zZ0FHP0Y1Eg3Ido
 ZAL6A8PAeOnuGS5qxkbwffF9BKE8ovg8ffpDlcDrJQ9lEBDy1AyHoaI4bMAJmjRVlMV9mafN2
 F+fmBrcY8zlfKGj/a67IGNw9PJcFsdwKxWwaStG6X9FgVibZ0ERk4okRtaffxoFQ8OrmJZ4jV
 ivLAsnUvheHox04gQVjbtiKo9rYxUuMrb3s7+ffcLk9Phj5NYbOOd2z7OQW2yPbxYJt7MmfiC
 VFMsKrRWq0KypWlSRF2uN4JbBHq3jiQiW2m0MmS/ySTKYPmsyfF6TT1/VbHEYMhG5s/1u1djf
 h6RINiOAp9DXQkp5AwdQiTSxp7rWv5aa1YJOEa9c2QTD4=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

just a friendly reminder...is this the right way to go?

regards Frank


> Gesendet: Samstag, 16. September 2023 um 10:32 Uhr
> Von: "Frank Wunderlich" <linux@fw-web.de>
> An: linux-mediatek@lists.infradead.org
> Cc: "Frank Wunderlich" <frank-w@public-files.de>, "Matthias Brugger" <ma=
tthias.bgg@gmail.com>, "AngeloGioacchino Del Regno" <angelogioacchino.delr=
egno@collabora.com>, "Rob Herring" <robh+dt@kernel.org>, "Krzysztof Kozlow=
ski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.=
org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
> Betreff: [RFC v1] arm64: dts: mediatek: add dtbs with applied overlays f=
or bpi-r3
>
> From: Frank Wunderlich <frank-w@public-files.de>
>
> Build devicetree binaries for testing overlays and providing users
> full dtb without using overlays.
>
> Suggested-by: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> based on discussion here:
> https://lore.kernel.org/all/CAL_JsqK_3xxD0DFwipXO85P=3Dq=3DEYjUdjE1_8g1M=
Ktvw3vVzx5A@mail.gmail.com/
> https://lore.kernel.org/all/CAL_JsqJSi=3DkJSix=3Df3787ULZnaCy_Y26Phdhy5y=
9fat_vkDuUw@mail.gmail.com/
> ---
>  arch/arm64/boot/dts/mediatek/Makefile | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts=
/mediatek/Makefile
> index c99c3372a4b5..18be027bf6b4 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -13,6 +13,14 @@ dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi=
-r3-emmc.dtbo
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-nand.dtbo
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-nor.dtbo
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-sd.dtbo
> +mt7986a-bananapi-bpi-r3-emmc-nand-dtbs :=3D mt7986a-bananapi-bpi-r3.dtb=
 mt7986a-bananapi-bpi-r3-emmc.dtbo mt7986a-bananapi-bpi-r3-nand.dtbo
> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-emmc-nand.dtb
> +mt7986a-bananapi-bpi-r3-emmc-nor-dtbs :=3D mt7986a-bananapi-bpi-r3.dtb =
mt7986a-bananapi-bpi-r3-emmc.dtbo mt7986a-bananapi-bpi-r3-nor.dtbo
> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-emmc-nor.dtb
> +mt7986a-bananapi-bpi-r3-sd-nand-dtbs :=3D mt7986a-bananapi-bpi-r3.dtb m=
t7986a-bananapi-bpi-r3-sd.dtbo mt7986a-bananapi-bpi-r3-nand.dtbo
> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-sd-nand.dtb
> +mt7986a-bananapi-bpi-r3-sd-nor-dtbs :=3D mt7986a-bananapi-bpi-r3.dtb mt=
7986a-bananapi-bpi-r3-sd.dtbo mt7986a-bananapi-bpi-r3-nor.dtbo
> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-sd-nor.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-rfb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986b-rfb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8167-pumpkin.dtb
> --
> 2.34.1
>
>
