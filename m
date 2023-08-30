Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3132978E278
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbjH3WmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjH3WmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:42:19 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E706BCEE;
        Wed, 30 Aug 2023 15:41:47 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a76d882052so98057b6e.0;
        Wed, 30 Aug 2023 15:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693435303; x=1694040103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMOv6qvYP7lBaNx84hgmzC8pacn6S2d4a2n9nMkFP+I=;
        b=YnwTPB0RD4pj0eFxq16Iu9jhWSz0QaRP+BI1by0qDZQFllLe6NRaTodNewf/DuESHN
         RfvHpvB3hWd9O4JyiyRroJwBhxxqbqYQtMBwMzA36hiZ6M4m9+aTAjJR7ghI54e3wh42
         8x0QN/3PHOpAVJWxnJ97wdSHK5WWM7Q4rXZU8dbFBQCC0Yfy6IwWcDPv4xvPa1ei4SKf
         nKAqwMztagKcyG7WetX9hTgRJSxLXwlL3c7dbBaV6eyBR1+fKFr26pXGwlLLjTqTITjq
         uwgTAfYj+gCohRsb5JOz3lLSYHnGSLLv7p/qI2HZBXMB5+W6M1CmZkk4nwEvg4MrwUGr
         Hlyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693435303; x=1694040103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMOv6qvYP7lBaNx84hgmzC8pacn6S2d4a2n9nMkFP+I=;
        b=UR//XrCaYqXVvYhDGTLrxv/iH3DUhniN9Jv6wbEqADtP/d/zc3yGFcL63G+qbXBoYI
         O2CUkej6k9pMjfHPCpesnlF1Ewfoee4HLUwg3Ms9VratsOAIi8GFltF7fT3ivDfg2LfJ
         PC+iseJ8vR9dqNgi18S4LBV0miWPNkeG28W2v16BsQ0auDhKkhjAajnp5tnG/nYz/cy5
         lGcXoEKtC3EZqqKpVoue9XSHxxXBaMwS/SdpDm9iFlx/gXUJxsqQT3scHK9gJcFSbUYX
         /DYO0XYNXVznQ4Z6329K82/9hJA+OD3j3Ef3IpX/WyGNibGPc0EuNeGzY9qIPvzazcnl
         nRGw==
X-Gm-Message-State: AOJu0YzX5mrXdza+fNPetVyChfQ4DJzaIiRa4HaUIhftfzftw7Dafute
        8MFWIJb0TUJUgFCrdFkGisWQS1BmlhOIzmory+KPapQiQBc=
X-Google-Smtp-Source: AGHT+IGC6113P61pMKmFK6kYqPE5Y00Uskr76w1E9mrq1hQd/Tb1Z/aUESY4i5L3LDKXGG16v8KuHO1GK9P5jaE0Xhs=
X-Received: by 2002:a05:6358:6383:b0:132:ce36:ee31 with SMTP id
 k3-20020a056358638300b00132ce36ee31mr3510119rwh.6.1693435303155; Wed, 30 Aug
 2023 15:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230827023155.467807-1-aford173@gmail.com> <20230827023155.467807-3-aford173@gmail.com>
In-Reply-To: <20230827023155.467807-3-aford173@gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 30 Aug 2023 17:41:31 -0500
Message-ID: <CAHCN7xK9TKuQshtdzY8-zFL-Ho5oGDjOQYo2gjsvTC3ooPvx9Q@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] arm64: dts: imx8mp: Add micfil node
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 9:32=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
>
> The i.MX8MP has a micfil controller which is used for interfacing
> with a pulse density microphone. Add the node and mark it as
> disabled by default.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---

Nak.  I guess I'll Nak myself.

> V2:  No Change
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/=
dts/freescale/imx8mp.dtsi
> index 79cdd4c066c8..b44851a2f579 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -1473,6 +1473,27 @@ easrc: easrc@30c90000 {
>                                         fsl,asrc-format =3D <2>;
>                                         status =3D "disabled";
>                                 };
> +
> +                               micfil: audio-controller@30ca0000 {
> +                                       compatible =3D "fsl,imx8mp-micfil=
";
> +                                       reg =3D <0x30ca0000 0x10000>;
> +                                       #sound-dai-cells =3D <0>;
> +                                       interrupts =3D <GIC_SPI 109 IRQ_T=
YPE_LEVEL_HIGH>,
> +                                                    <GIC_SPI 110 IRQ_TYP=
E_LEVEL_HIGH>,
> +                                                    <GIC_SPI 44 IRQ_TYPE=
_LEVEL_HIGH>,
> +                                                    <GIC_SPI 45 IRQ_TYPE=
_LEVEL_HIGH>;
> +                                       clocks =3D <&audio_blk_ctrl IMX8M=
P_CLK_AUDIOMIX_PDM_IPG>,
> +                                                <&audio_blk_ctrl IMX8MP_=
CLK_AUDIOMIX_PDM_ROOT>,

After a bunch of attempts to get this working on real hardware, it
turns out that IMX8MP_CLK_AUDIOMIX_PDM_ROOT doesn't really exist.  Its
real name is IMX8MP_CLK_AUDIOMIX_PDM_SEL.  I'll submit a patch to
remove this from imx8mp-clock.h and and a V3 of this series to update
the clock reference in this node.

> +                                                <&clk IMX8MP_AUDIO_PLL1_=
OUT>,
> +                                                <&clk IMX8MP_AUDIO_PLL2_=
OUT>,
> +                                                <&clk IMX8MP_CLK_EXT3>;
> +                                       clock-names =3D "ipg_clk", "ipg_c=
lk_app",
> +                                                     "pll8k", "pll11k", =
"clkext3";
> +                                       dmas =3D <&sdma2 24 25 0x80000000=
>;
> +                                       dma-names =3D "rx";
> +                                       status =3D "disabled";
> +                               };
> +
>                         };
>
>                         sdma3: dma-controller@30e00000 {
> --
> 2.39.2
>
