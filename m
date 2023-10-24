Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82747D4C94
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbjJXJhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbjJXJhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:37:09 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1589412B
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:37:06 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507a62d4788so6735416e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698140224; x=1698745024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHRbBWy4owH0wLPGHWwFMskchN1xwqqo7kAge+EOJ5o=;
        b=hFzL87eLIeL2Y4QOJXssaDj6lxe/966/331cv5wr+YFLHwJiP4s5Lu0oODyjx5NMxd
         XC7WEQpg77DwqOfob5R5rLzc5Gb9OehNUMu/OXMPl/gUIpCNda3PbcEahI+0jj6mY5tT
         /3mP4n1+VglKRolK5FE+lu77yGzreNrnP6IJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698140224; x=1698745024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHRbBWy4owH0wLPGHWwFMskchN1xwqqo7kAge+EOJ5o=;
        b=JUTeoXxS4Apr4dvy8Kzcd0012PH6JMBsZTde44QZnTBK/4TkqjtwZjKwEyvYrCJg75
         h4ivHdIB+2z/julWFc1QeLt9eUL8crlw5kiNXt+C53mZ+0xjVLWC0ejVBQdH2KMG/5ai
         +/Hq4RaBgBT4az6L+tfV1XtzTLdfov6DnI6wkRPZ7o7b8t2orgGwEYDBILIBJ1Lqpecw
         1FH+NgNWb8RTL93IGGTl//7VAvPOB2JBHPTjt0vuZG/WLarBOJ0lbBcRyhFv70gU664N
         +NeO0Swb4eEVfX615ploU+Ht4l/xyV6AChbVew771SoDOsH9Ex9O1MlcG5FfMorR575e
         LhUQ==
X-Gm-Message-State: AOJu0Yx/UBo4fBNpN3euil9EJFCDuFC3M+wmkhxVhT3jAkUWHru8x9mp
        t0PfxWs0KYSQbjf21dDRg2CWfksLnDjw9ANb80/LXA==
X-Google-Smtp-Source: AGHT+IHGVQptyGMQXoofkQqC+IzPV7oxdJqffR5O4goH3KPMBttmhBy2IKngQcwmJqNk00UNW3VT28I49cockoDF/xo=
X-Received: by 2002:a19:3846:0:b0:503:364d:b93d with SMTP id
 d6-20020a193846000000b00503364db93dmr8614267lfj.20.1698140224327; Tue, 24 Oct
 2023 02:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231023083839.24453-1-jason-ch.chen@mediatek.com>
 <20231023083839.24453-5-jason-ch.chen@mediatek.com> <a1846955-e6d9-4217-8c9f-1f20be166f4b@baylibre.com>
In-Reply-To: <a1846955-e6d9-4217-8c9f-1f20be166f4b@baylibre.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 24 Oct 2023 17:36:53 +0800
Message-ID: <CAGXv+5Gdr4DuiGAZFdVdqjj8Rv2Onq78k+=Mmu0MOe=rxQkr3A@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] arm64: dts: Add MediaTek MT8188 dts and evaluation
 board and Makefile
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 23, 2023 at 6:55=E2=80=AFPM Alexandre Mergnat <amergnat@baylibr=
e.com> wrote:
>
>
>
> On 23/10/2023 10:38, Jason-ch Chen wrote:
> > From: jason-ch chen <Jason-ch.Chen@mediatek.com>
> >
> > MT8188 is a SoC based on 64bit ARMv8 architecture. It contains 6 CA55
> > and 2 CA78 cores. MT8188 share many HW IP with MT65xx series.
> >
> > We add basic chip support for MediaTek MT8188 on evaluation board.
> >
> > Signed-off-by: jason-ch chen <Jason-ch.Chen@mediatek.com>
> > ---
> >   arch/arm64/boot/dts/mediatek/Makefile       |   1 +
> >   arch/arm64/boot/dts/mediatek/mt8188-evb.dts | 387 ++++++++
> >   arch/arm64/boot/dts/mediatek/mt8188.dtsi    | 956 +++++++++++++++++++=
+
> >   3 files changed, 1344 insertions(+)
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-evb.dts
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8188.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dt=
s/mediatek/Makefile
> > index e6e7592a3645..8900b939ed52 100644
> > --- a/arch/arm64/boot/dts/mediatek/Makefile
> > +++ b/arch/arm64/boot/dts/mediatek/Makefile
> > @@ -44,6 +44,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-krane-s=
ku0.dtb
> >   dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-krane-sku176.dtb
> >   dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-pumpkin.dtb
> >   dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8186-evb.dtb
> > +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8188-evb.dtb
> >   dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8192-asurada-hayato-r1.dtb
> >   dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8192-asurada-hayato-r5-sku2.dtb
> >   dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8192-asurada-spherion-r0.dtb
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8188-evb.dts b/arch/arm64/b=
oot/dts/mediatek/mt8188-evb.dts
> > new file mode 100644
> > index 000000000000..68a82b49f7a3
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt8188-evb.dts
> > @@ -0,0 +1,387 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +/*
> > + * Copyright (C) 2023 MediaTek Inc.
> > + */
> > +/dts-v1/;
> > +#include "mt8188.dtsi"
> > +#include "mt6359.dtsi"
> > +
> > +/ {
> > +     model =3D "MediaTek MT8188 evaluation board";
> > +     compatible =3D "mediatek,mt8188-evb", "mediatek,mt8188";
> > +
> > +     aliases {
> > +             serial0 =3D &uart0;
> > +             i2c0 =3D &i2c0;
> > +             i2c1 =3D &i2c1;
> > +             i2c2 =3D &i2c2;
> > +             i2c3 =3D &i2c3;
> > +             i2c4 =3D &i2c4;
> > +             i2c5 =3D &i2c5;
> > +             i2c6 =3D &i2c6;
> > +             mmc0 =3D &mmc0;
> > +     };
> > +
> > +     chosen: chosen {
> > +             stdout-path =3D "serial0:115200n8";
> > +     };
> > +
> > +     memory@40000000 {
> > +             device_type =3D "memory";
> > +             reg =3D <0 0x40000000 0 0x80000000>;
> > +     };
> > +
> > +     reserved_memory: reserved-memory {
> > +             #address-cells =3D <2>;
> > +             #size-cells =3D <2>;
> > +             ranges;
> > +
> > +             scp_mem_reserved: memory@50000000 {
> > +                     compatible =3D "shared-dma-pool";
> > +                     reg =3D <0 0x50000000 0 0x2900000>;
> > +                     no-map;
> > +             };
> > +     };
> > +};
> > +
> > +&auxadc {
> > +     status =3D "okay";
> > +};
> > +
> > +&i2c0 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&i2c0_pins>;
> > +     clock-frequency =3D <400000>;
> > +     status =3D "okay";
>
> IMO, the order should be
>
> clock-frequency =3D <400000>;
> pinctrl-0 =3D <&i2c0_pins>;
> pinctrl-names =3D "default";
> status =3D "okay";
>
> Please apply this to other nodes

Within the MediaTek platform device trees, this ordering seems to be all
over. The one here seems to be the ordering MediaTek likes. The device
trees upstreamed by Collabora folks have:

{
    status =3D "okay";

    clock-frequency =3D <400000>;
    pinctrl-names =3D "default";
    pinctrl-0 =3D <&i2c3_pins>;
}

As long as the ordering sort of makes sense (external bus properties come
after internal properties), I probably wouldn't argue either way.

> > +};
> > +
> > +&i2c1 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&i2c1_pins>;
> > +     clock-frequency =3D <400000>;
> > +     status =3D "okay";
> > +};
> > +
> > +&i2c2 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&i2c2_pins>;
> > +     clock-frequency =3D <400000>;
> > +     status =3D "okay";
> > +};
> > +
> > +&i2c3 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&i2c3_pins>;
> > +     clock-frequency =3D <400000>;
> > +     status =3D "okay";
> > +};
> > +
> > +&i2c4 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&i2c4_pins>;
> > +     clock-frequency =3D <400000>;
> > +     status =3D "okay";
> > +};
> > +
> > +&i2c5 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&i2c5_pins>;
> > +     clock-frequency =3D <400000>;
> > +     status =3D "okay";
> > +};
> > +
> > +&i2c6 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&i2c6_pins>;
> > +     clock-frequency =3D <400000>;
> > +     status =3D "okay";
> > +};
> > +
> > +&mmc0 {
> > +     bus-width =3D <8>;
> > +     hs400-ds-delay =3D <0x1481b>;
> > +     max-frequency =3D <200000000>;
> > +
> > +     cap-mmc-highspeed;
> > +     mmc-hs200-1_8v;
> > +     mmc-hs400-1_8v;
> > +     supports-cqe;
> > +     cap-mmc-hw-reset;
> > +     no-sdio;
> > +     no-sd;
> > +     non-removable;
> > +
> > +     vmmc-supply =3D <&mt6359_vemc_1_ldo_reg>;
> > +     vqmmc-supply =3D <&mt6359_vufs_ldo_reg>;
> > +
> > +     pinctrl-names =3D "default", "state_uhs";
> > +     pinctrl-0 =3D <&mmc0_default_pins>;
> > +     pinctrl-1 =3D <&mmc0_uhs_pins>;
> > +
> > +     status =3D "okay";
> > +};
> > +
> > +&mt6359_vcore_buck_reg {
> > +     regulator-always-on;
> > +};
> > +
> > +&mt6359_vgpu11_buck_reg {
> > +     regulator-always-on;
> > +};
> > +
> > +&mt6359_vpu_buck_reg {
> > +     regulator-always-on;
> > +};
> > +
> > +&mt6359_vrf12_ldo_reg {
> > +     regulator-always-on;
> > +};
> > +
> > +&nor_flash {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&nor_pins_default>;
> > +     #address-cells =3D <1>;
> > +     #size-cells =3D <0>;
> > +     status =3D "okay";
>
> Order:
>
>
> #address-cells =3D <1>;
> #size-cells =3D <0>;
>
> pinctrl-0 =3D <&nor_pins_default>;
> pinctrl-names =3D "default";

I think pinctrl-names before pinctrl-* makes more sense. We declare the
names and by extension how many pinctrl-N entries are needed first. The
vast majority of the arm64 device tree files have pinctrl-names before
pinctrl-N. The only platform that exclusively has pinctrl-N before
pinctrl-names is amlogic.

If there's a preference for a particular order platform-wide or tree-wide
then it should probably be documented somewhere?

> status =3D "okay";

I think #address-cells and #size-cells belong at the end of the list,
even after "status", just before any child nodes. They describe
properties or requirements for the child nodes, not for the node they
sit in.

> > +
> > +     flash@0 {
> > +             compatible =3D "jedec,spi-nor";
> > +             reg =3D <0>;
> > +             spi-max-frequency =3D <52000000>;
> > +     };
> > +};
> > +
>
> ..snip..
>
> > +
> > +&pmic {
> > +     interrupts-extended =3D <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
> > +};
> > +
> > +&scp {
> > +     memory-region =3D <&scp_mem_reserved>;
> > +     status =3D "okay";
> > +};
> > +
> > +&spi0 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&spi0_pins>;
>
> Order:
>
> pinctrl-0 =3D <&spi0_pins>;
> pinctrl-names =3D "default";
>
> Please apply this to other nodes

See above.

ChenYu

> > +     status =3D "okay";
> > +};
> > +
> > +&spi1 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&spi1_pins>;
> > +     status =3D "okay";
> > +};
> > +
> > +&spi2 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&spi2_pins>;
> > +     status =3D "okay";
> > +};
> > +
> > +&u3phy0 {
> > +     status =3D "okay";
> > +};
> > +
> > +&u3phy1 {
> > +     status =3D "okay";
> > +};
> > +
> > +&u3phy2 {
> > +     status =3D "okay";
> > +};
> > +
> > +&uart0 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&uart0_pins>;
> > +     status =3D "okay";
> > +};
> > +
>
> ..snip..
>
> > +             };
> > +     };
> > +};
>
> After that:
> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
>
> --
> Regards,
> Alexandre
