Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F2C7A5EF7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjISKAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjISKAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:00:05 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC1F9E;
        Tue, 19 Sep 2023 03:00:00 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso4499003a12.3;
        Tue, 19 Sep 2023 03:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695117600; x=1695722400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjWijmchQBLdKzLnayUJX/ewjoWaI+9Ghlb5Rr9/x3k=;
        b=jUgjDy2muSdTysszr0Gj4QuqINvOReZhK7xmamLiTFE5wG2ZxexFJEXIx+GHqqtDrX
         G0j/m8ypDt1MBYNDMgYX23u9O8Mi24g64hKuNtyojcgCAT1UD6/NKRwHeHuM8kGKts1r
         Z0OtSR0FegVtcQM0wvb9kYZouyqs5sfhKmiJVHwpIMP3S08LOXypr0ezUApdSkUPqPl1
         Qa62URSnxZFpAMnQ78ob4IQvywH5Xm92HsfoaWO0SjWyxEVoXEU2Gkvd7UjhNW7R/tNM
         sLM4y1yLYw1N2defTWvgBBHzyrnb7sFOlkD6lnFd/zbpA9QZDiGDhTONHO47EVkxqUwK
         Swxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695117600; x=1695722400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjWijmchQBLdKzLnayUJX/ewjoWaI+9Ghlb5Rr9/x3k=;
        b=hgmLVXSLMTNJfAv1lTEXN51wzG3XFUYx2pO1+QTfnoPmHusEMwaTGh5mZpnV777ZVI
         16JlxcDv5Ic3WX82UOGXxERBMjjTqOF2vjQTdTQTp1Mwol8zIjybrq3kpyr99zhKWhdn
         43FZ+wpSHfbrfRPg2Q37ylM4Pd2o5a9yicixpL/HGy/4Ts4nzcnMsSwg8O2d+qzxU75f
         WAaojcXbdMuqaf3ED7FapQswJWy63sbCJQgmS1Vs+FppWD8MCUhnkhrXxL6kIFxtRD9p
         luesGoBpX74lrLkmou/jpCVVGsElLIROiB1OiGSfldNRASlDc40nZHSK+atx8caoG04o
         iGag==
X-Gm-Message-State: AOJu0Yy07wKnwNKyvjrDvaoEG2vLgxSUy8LwkImszwqgyhDSWqg50FAq
        AZ5Pi+2Stw3xl80/rc6UtKnZV5noExXW+KhFlAY=
X-Google-Smtp-Source: AGHT+IEnsQg8X0JeKZ6zrmk09NlOSOsSeqkPbKFpD2GuDgbkgyhb8u0Bpatqn01FSWHg8wXKMxGD+C2KU7fVdqGStvE=
X-Received: by 2002:a05:6a20:2594:b0:151:b96f:88b4 with SMTP id
 k20-20020a056a20259400b00151b96f88b4mr12768707pzd.23.1695117599552; Tue, 19
 Sep 2023 02:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <1695108775-22924-1-git-send-email-shengjiu.wang@nxp.com> <8ce3f7e172a747100366ebd14d3bd74fe549ae10.camel@pengutronix.de>
In-Reply-To: <8ce3f7e172a747100366ebd14d3bd74fe549ae10.camel@pengutronix.de>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Tue, 19 Sep 2023 17:59:48 +0800
Message-ID: <CAA+D8AM5Lp_vRBVgWXBQ2DFxf1AUG5702rrYrSgvn994GAaFAw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mp: assign parent clock and rate for
 audio clocks
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, marex@denx.de,
        peng.fan@nxp.com, alexander.stein@ew.tq-group.com,
        laurent.pinchart@ideasonboard.com, aford173@gmail.com,
        Frank.Li@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 4:20=E2=80=AFPM Lucas Stach <l.stach@pengutronix.de=
> wrote:
>
> Hi Shengjiu,
>
> Am Dienstag, dem 19.09.2023 um 15:32 +0800 schrieb Shengjiu Wang:
> > Assign parent clock for audio AHB and AXI clocks, and assign
> > clock rate for audio PLL1 and PLL2.
> >
> Please don't do this. Configuring all those clocks in the clock
> controller is a pain to override if the board uses the PLLs in any
> other way than the reference design.
>
> The audio AXI and AHB clocks are already properly configured with Adams
> patch [1], so there is no need for the changes in this patch.
>
> Please set up the audio PLLs in the board DT in peripheral nodes that
> are actually using those clocks.
>
> Regards,
> Lucas
>
> [1] https://lore.kernel.org/all/20230819105002.132750-1-aford173@gmail.co=
m/

For this patch, it changes the AXI clock to 600M.  But the parent clock
is 800M,  so the result AXI clock is 400M actually, the 800M can't be divid=
ed
to 600MHz.

Best regards
Wang shengjiu



>
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boo=
t/dts/freescale/imx8mp.dtsi
> > index 6f2f50e1639c..8a8a2c4aff9f 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > @@ -734,16 +734,26 @@ clk: clock-controller@30380000 {
> >                                                 <&clk IMX8MP_CLK_A53_CO=
RE>,
> >                                                 <&clk IMX8MP_CLK_NOC>,
> >                                                 <&clk IMX8MP_CLK_NOC_IO=
>,
> > -                                               <&clk IMX8MP_CLK_GIC>;
> > +                                               <&clk IMX8MP_CLK_GIC>,
> > +                                               <&clk IMX8MP_CLK_AUDIO_=
AHB>,
> > +                                               <&clk IMX8MP_CLK_AUDIO_=
AXI_SRC>,
> > +                                               <&clk IMX8MP_AUDIO_PLL1=
>,
> > +                                               <&clk IMX8MP_AUDIO_PLL2=
>;
> >                               assigned-clock-parents =3D <&clk IMX8MP_S=
YS_PLL1_800M>,
> >                                                        <&clk IMX8MP_ARM=
_PLL_OUT>,
> >                                                        <&clk IMX8MP_SYS=
_PLL2_1000M>,
> >                                                        <&clk IMX8MP_SYS=
_PLL1_800M>,
> > -                                                      <&clk IMX8MP_SYS=
_PLL2_500M>;
> > +                                                      <&clk IMX8MP_SYS=
_PLL2_500M>,
> > +                                                      <&clk IMX8MP_SYS=
_PLL1_800M>,
> > +                                                      <&clk IMX8MP_SYS=
_PLL1_800M>;
> >                               assigned-clock-rates =3D <0>, <0>,
> >                                                      <1000000000>,
> >                                                      <800000000>,
> > -                                                    <500000000>;
> > +                                                    <500000000>,
> > +                                                    <400000000>,
> > +                                                    <800000000>,
> > +                                                    <393216000>,
> > +                                                    <361267200>;
> >                       };
> >
> >                       src: reset-controller@30390000 {
>
