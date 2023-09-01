Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4AD78FC12
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349089AbjIALHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 07:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242330AbjIALHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:07:13 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B59410D2;
        Fri,  1 Sep 2023 04:07:11 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-26d1a17ce06so1306968a91.0;
        Fri, 01 Sep 2023 04:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693566430; x=1694171230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPUOMfLU4we4CjltUjwN44sx+Ez5EK03Lr9xq9NQohw=;
        b=f8IA9xzGM7p+Fpyaa7UW7rwFtzfe7CvPyo+NlWXf2ChGZ2osL4bLeN/FHpbp0vqfns
         d7jHgDg5SjCmWOkNGl8E6Dtaf3jW9tm6t66SXPq6UgG99hVv4PAzDZhklMCWUcYYnnrB
         xvMQzKHTCt2Myy+s/SCEScrl3ggUU0OoHDp2xhPhUzX85fPYp1E4BbaHmf1N/OznhR58
         ObN7rCTtMOEwCHdLlC8lM3ZjmCSwasMFWFS27WgLIf/NGkIqaIEdHDzTERovCMKViiwu
         mVA05ydNMcNhuAv4AWzWsar0Bi51NfVR07aa5H2xeJ3zF5aYK2aBu/qXxlQrfaPugzdQ
         DGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693566430; x=1694171230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPUOMfLU4we4CjltUjwN44sx+Ez5EK03Lr9xq9NQohw=;
        b=Dp4qzuhDxTLhWDz95vnoZPsoHGVSVMUr7ERGhrZeGq10KjXVRJwHT2j+a9Uqv+1Zll
         /7534I+/TyWxFtWZkKYQv5rMV2yNPi35hKjI+N+NvmmXaYr3S2qsLpI5yAqlhC1YUWML
         njiJYpq7610cVmEIoHql0I9RhZjesZqhlYONOQA8eVlwmIEbaf+FGgzPd8nl57GlosVm
         Ac+hPGeCFgu2sdnhH98Oyq8qsdtTWF0febUmpneUR5TDCNOobQTJKopmhsNS/SSOZVHQ
         qHbZjHpiVX7l4OXIyyNV+MCOnHzenO9rbybtJQhzgKnkVW7XO2eQ6CUvozWYI4tFxCSP
         Ic0w==
X-Gm-Message-State: AOJu0Yw0MrKirbnx8Jene1DzmiGo9S7zSFO6jV4gKzg/xmvr476P2c6B
        zOcXO1Ujilh+t7/+o1kqdCDXSdqV96OOj3QfZsQ=
X-Google-Smtp-Source: AGHT+IE2MCHN/JLIV3aZGEUAAMU6YT0YmbzRuP8i8CYwfT9g4LLvQK1VGtWvr2duPwboM58vGfo3BnTX2uUxdgkgWd0=
X-Received: by 2002:a17:90a:5aa3:b0:26d:355a:47e3 with SMTP id
 n32-20020a17090a5aa300b0026d355a47e3mr1944668pji.38.1693566429840; Fri, 01
 Sep 2023 04:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230831044431.250338-1-aford173@gmail.com> <20230831044431.250338-2-aford173@gmail.com>
 <4d700304-3e10-a19b-d3f0-d0a1aec11580@denx.de>
In-Reply-To: <4d700304-3e10-a19b-d3f0-d0a1aec11580@denx.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 1 Sep 2023 06:06:56 -0500
Message-ID: <CAHCN7xJpug+ap4koX_3w_YTvHF9NC8-2S0f69SsDNY_6T+rcPQ@mail.gmail.com>
Subject: Re: [PATCH V3 2/3] arm64: dts: imx8mp: Add micfil node
To:     Marek Vasut <marex@denx.de>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
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

On Thu, Aug 31, 2023 at 4:53=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 8/31/23 06:44, Adam Ford wrote:
> > The i.MX8MP has a micfil controller which is used for interfacing
> > with a pulse density microphone. Add the node and mark it as
> > disabled by default.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> > V3:  The AUDIOMIX_PDM_ROOT doesn't exist and the real clock is
> >       called IMX8MP_CLK_AUDIOMIX_PDM_SEL, so swap it out.
> >
> > V2:  No change
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boo=
t/dts/freescale/imx8mp.dtsi
> > index 3167706d81e1..341fd0369ce9 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > @@ -1479,6 +1479,27 @@ easrc: easrc@30c90000 {
> >                                       fsl,asrc-format =3D <2>;
> >                                       status =3D "disabled";
> >                               };
> > +
> > +                             micfil: audio-controller@30ca0000 {
> > +                                     compatible =3D "fsl,imx8mp-micfil=
";
> > +                                     reg =3D <0x30ca0000 0x10000>;
> > +                                     #sound-dai-cells =3D <0>;
> > +                                     interrupts =3D <GIC_SPI 109 IRQ_T=
YPE_LEVEL_HIGH>,
> > +                                                  <GIC_SPI 110 IRQ_TYP=
E_LEVEL_HIGH>,
> > +                                                  <GIC_SPI 44 IRQ_TYPE=
_LEVEL_HIGH>,
> > +                                                  <GIC_SPI 45 IRQ_TYPE=
_LEVEL_HIGH>;
> > +                                     clocks =3D <&audio_blk_ctrl IMX8M=
P_CLK_AUDIOMIX_PDM_IPG>,
> > +                                              <&audio_blk_ctrl IMX8MP_=
CLK_AUDIOMIX_PDM_SEL>,
> > +                                              <&clk IMX8MP_AUDIO_PLL1_=
OUT>,
> > +                                              <&clk IMX8MP_AUDIO_PLL2_=
OUT>,
> > +                                              <&clk IMX8MP_CLK_EXT3>;
> > +                                     clock-names =3D "ipg_clk", "ipg_c=
lk_app",
> > +                                                   "pll8k", "pll11k", =
"clkext3";
> > +                                     dmas =3D <&sdma2 24 25 0x80000000=
>;
> > +                                     dma-names =3D "rx";
>
> Is dma-names really required if there is only a single DMA channel in DT =
?

I would normally agree with you, the DT binding file shows it's
required, and the driver looks like it's searching for a channel name
called 'rx'

adam
