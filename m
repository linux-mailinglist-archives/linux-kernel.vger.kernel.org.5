Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED12878ED38
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 14:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245057AbjHaMfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 08:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbjHaMe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 08:34:58 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B501E53;
        Thu, 31 Aug 2023 05:34:52 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-56a8794b5adso615181a12.2;
        Thu, 31 Aug 2023 05:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693485291; x=1694090091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8qtfSYPASZsR2rv+sOsRKO0t16oVqa7LJBcF2xhXPs=;
        b=oII/cxjy/YLqXU3R5/zi4XqcTLWcSDIZK42tdwK/0bbjuse/+0chUFK2IuPlPB/yXn
         NpjNhujcGumO2EZ1ZwZjtq/FbIJmyDhASpiBsyigmcuXimcs/vglDJ8UPQMoVWjBv6Xq
         fbzSD9NpY/owdETtvAyTztGqB5Aj9JhixMFtvYlJg+MsLICUJ47EX4S4dmBfN56dR7JV
         whwiQdtHshlqLKHL/zbekw05ZFkeehTqmX0TCgDXi9ehcXWW5WkoiCZX6z3NrAg464JJ
         PUECt0RQxnYbu5SizlMKqOQk+I/y/vFfAHXneGbgqe+olZCJdpT4SWjlryJAG8KkwYqU
         at9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693485291; x=1694090091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T8qtfSYPASZsR2rv+sOsRKO0t16oVqa7LJBcF2xhXPs=;
        b=RrUeFk/0M2WG5APZzm429T/Mvjh95GXT1tiRTSvcKGKDggg0PVqQtb2WErUSjJDEbb
         pnhQZci7mG7OArQi6ZC4G/CI6Eewj1QFKNk+9a5aYGoW7cyqEHG+pkwHK5US3ICcSKK+
         K+vwX67846MsKaymjvpoGYUfHCX06YNC+JneEBLVIagJIxvj0HOBqrjWkvlH0pPGyh72
         DCW0+2+UvisyfJCcLFTWrHJ6GuBeROg9wIadrZcH067DkRD9XZ2iqK9uIMpRE2yKILJe
         wF3av3kx6efTkdbGHAPTWWzbIW9dFLYNDAGf3M/FDxs6wj5EHiv/d/8tGFAxEOZI3QfG
         TDgA==
X-Gm-Message-State: AOJu0YyGOaTFnG0/KqkAiGEwWEZ3iBFpOj7MR7n0INh8a5d+eTJbZEQa
        PDJNjF0dsakB68VjgxppX/MxIm8eMs8n8Y5ieAE=
X-Google-Smtp-Source: AGHT+IE9JEp2n1DYTHTgritm96XaJMShBw83vd2pIVn7QmnoMMXDocvWrdhklQkBFjK0CoIm9lrUxAcm3VTMQBtubHI=
X-Received: by 2002:a17:90a:4982:b0:26c:f9a5:4493 with SMTP id
 d2-20020a17090a498200b0026cf9a54493mr4896454pjh.5.1693485291299; Thu, 31 Aug
 2023 05:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230831115128.254226-1-aford173@gmail.com> <20230831115128.254226-4-aford173@gmail.com>
In-Reply-To: <20230831115128.254226-4-aford173@gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 31 Aug 2023 07:34:39 -0500
Message-ID: <CAHCN7xKDT-2GJMWwUtOQqHE4R24BOLWvsQy99gw0VP8zULtK+A@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: imx8mp-beacon: Add DMIC support
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 6:51=E2=80=AFAM Adam Ford <aford173@gmail.com> wrot=
e:
>
> The baseboard has a connector for a pulse density microphone.
> This is connected via the micfil interface and uses the DMIC
> audio codec with the simple-audio-card.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
>

Shawn,

I forgot to mention that this patch depends on a different patch that is fo=
und:

https://patchwork.kernel.org/project/linux-arm-kernel/patch/20230831044431.=
250338-2-aford173@gmail.com/

Sorry about that.

adam

> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts b/arch/a=
rm64/boot/dts/freescale/imx8mp-beacon-kit.dts
> index acd265d8b58e..ee64c6ffb551 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
> @@ -49,6 +49,12 @@ ss_ep: endpoint {
>                 };
>         };
>
> +       dmic_codec: dmic-codec {
> +               compatible =3D "dmic-codec";
> +               num-channels =3D <1>;
> +               #sound-dai-cells =3D <0>;
> +       };
> +
>         gpio-keys {
>                 compatible =3D "gpio-keys";
>                 autorepeat;
> @@ -147,6 +153,22 @@ reg_usb1_host_vbus: regulator-usb1-vbus {
>                 enable-active-high;
>         };
>
> +       sound-dmic {
> +               compatible =3D "simple-audio-card";
> +               simple-audio-card,name =3D "sound-pdm";
> +               simple-audio-card,format =3D "i2s";
> +               simple-audio-card,bitclock-master =3D <&dailink_master>;
> +               simple-audio-card,frame-master =3D <&dailink_master>;
> +
> +               dailink_master: simple-audio-card,cpu {
> +                       sound-dai =3D <&micfil>;
> +               };
> +
> +               simple-audio-card,codec {
> +                       sound-dai =3D <&dmic_codec>;
> +               };
> +       };
> +
>         sound-wm8962 {
>                 compatible =3D "simple-audio-card";
>                 simple-audio-card,name =3D "wm8962";
> @@ -174,6 +196,11 @@ simple-audio-card,codec {
>         };
>  };
>
> +&audio_blk_ctrl {
> +       assigned-clocks =3D <&clk IMX8MP_AUDIO_PLL1>, <&clk IMX8MP_AUDIO_=
PLL2>;
> +       assigned-clock-rates =3D <393216000>, <135475200>;
> +};
> +
>  &ecspi2 {
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&pinctrl_ecspi2>;
> @@ -364,6 +391,15 @@ hd3ss3220_out_ep: endpoint {
>         };
>  };
>
> +&micfil {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_pdm>;
> +       assigned-clocks =3D <&clk IMX8MP_CLK_PDM>;
> +       assigned-clock-parents =3D <&clk IMX8MP_AUDIO_PLL1_OUT>;
> +       assigned-clock-rates =3D <49152000>;
> +       status =3D "okay";
> +};
> +
>  &pcie {
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&pinctrl_pcie>;
> @@ -545,6 +581,13 @@ MX8MP_IOMUXC_SAI2_RXFS__GPIO4_IO21 0x10    /* PCIe_n=
RST */
>                 >;
>         };
>
> +       pinctrl_pdm: pdmgrp {
> +               fsl,pins =3D <
> +                       MX8MP_IOMUXC_SAI5_RXC__AUDIOMIX_PDM_CLK         0=
xd6
> +                       MX8MP_IOMUXC_SAI5_RXD0__AUDIOMIX_PDM_BIT_STREAM00=
       0xd6
> +               >;
> +       };
> +
>         pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
>                 fsl,pins =3D <
>                         MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19    0x40
> --
> 2.39.2
>
