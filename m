Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15C77B7A34
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241737AbjJDIhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241730AbjJDIhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:37:00 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6121E83;
        Wed,  4 Oct 2023 01:36:56 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4060b623e64so3761945e9.0;
        Wed, 04 Oct 2023 01:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696408615; x=1697013415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkfAdr3F5jJkOyznGJa/M5SZW3t5nD9ld59JmHneym0=;
        b=YDjDZJfAJCH3BcaPs570WA9qoZ5XKQP9ubMdbJX5athTtjPVLYyhx3NQ/Msau6EVRy
         GeORU3vvrAJ61K1qaSxTvlWX14BJQNUY9JOTZ02Rf7zs/OIKN+JG4PsQKzfLTEkDuvhd
         s0p+z8XHryXWtjMSaO+mqtp2zZG+mKuM5owcgBbBcTTtT48kE97Fco/ltVtHjkI8hJoI
         a+Gt+8C/zqJCPeY3V8x+1HMhm1dc6GbazWW+R38VQuzGaJXVOXxrR46TL7mj4aD6NC7A
         U48VEZ0QoQiCt7Dfq++/UjpKCR7i5J3gqRMTid0rG0Wr/v6bX/Yt+goix25kvbLL73pD
         vZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696408615; x=1697013415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkfAdr3F5jJkOyznGJa/M5SZW3t5nD9ld59JmHneym0=;
        b=BrCMTfDE4UwrGng17rBWYsx9aYdWXrTlZw3gt/A6Qe43uirNRChY5FrygchaWJ+awO
         anEqQfCrNQsVRMhKiWdRnU0AtSJrnSZ4kYkBZh7rDd6XH9LARqnNEJnqYQ0abKblMxRm
         K3sfiC3eNttxfUbrRQC+YnrmVx7ohyvzwzVCkxsk4Xw+gRtXmT0/NjkmUDGuNL4QRk1E
         egpexhEBEFZ70nIlh8/iXRQhNoTrGRJwX6jONtOr9ZCd3rniFoJiiQA23h2UCqo6w+XN
         YiQQmW7Wj8P/FB+5MCwAh+SExt1EkTAsUrZRKtqIwi2D80kKk9QmwrXbvfCAVOVaUOxa
         XL0g==
X-Gm-Message-State: AOJu0YxdS8d2/hiXeUJ4fUrU/NVwaTe0DEaLHXxBtk4EgMGOltTm8ks6
        FmcetHzyMNmfya/Z+vqMrKc=
X-Google-Smtp-Source: AGHT+IEjoO8o6Ujp6u7Rku5wwKxupS9sA4x8/wplpXvxlJ/7kFVD2nsNBV21tG3XuLT18o/k1a2lYA==
X-Received: by 2002:a05:600c:b8d:b0:401:609f:7f9a with SMTP id fl13-20020a05600c0b8d00b00401609f7f9amr4275071wmb.8.1696408614641;
        Wed, 04 Oct 2023 01:36:54 -0700 (PDT)
Received: from PCBABN.skidata.net ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id l16-20020a7bc450000000b0040536dcec17sm918596wmi.27.2023.10.04.01.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 01:36:54 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
To:     aford173@gmail.com
Cc:     abelvesa@kernel.org, bbara93@gmail.com, benjamin.bara@skidata.com,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        festevam@gmail.com, frank@oltmanns.dev, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, mripard@kernel.org, mturquette@baylibre.com,
        peng.fan@nxp.com, robh+dt@kernel.org, s.hauer@pengutronix.de,
        sboyd@kernel.org, shawnguo@kernel.org
Subject: Re: [PATCH 02/13] arm64: dts: imx8mp: re-parent IMX8MP_CLK_MEDIA_MIPI_PHY1_REF
Date:   Wed,  4 Oct 2023 10:36:39 +0200
Message-Id: <20231004083639.2895890-1-bbara93@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHCN7x+TCxbaE7Y41Yn5SpG0G5V57hwXQ7HX_ExLF1EXKtZs4w@mail.gmail.com>
References: <CAHCN7x+TCxbaE7Y41Yn5SpG0G5V57hwXQ7HX_ExLF1EXKtZs4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

thanks for the feedback!

On Tue, 3 Oct 2023 at 15:02, Adam Ford <aford173@gmail.com> wrote:
> From what I can see, it looks like the IMX8MP_CLK_MEDIA_MIPI_PHY1_REF
> parent is being set to IMX8MP_CLK_24M.  Isn't that the default? I also
> don't think we need to set a 24MHz clock to 24MHz if that's the
> default.

I can retry (have the patch applied since then), but as far as I
remember, it was not. What was even funnier was that media_mipi_phy1_ref
hat a divider != 1 set (it is a composite), so it wasn't sufficient to
just re-parent it to OSC_24M - probably because set_rate() was called
before it was re-parented to OSC_24M. But thanks for the catch, I will
take a look again and adapt it if possible.

Regards
Benjamin

> If that is the case, I would suggest we try to remove the assignment
> altogether to make the device tree simpler and less to untangle if a
> board needs to manually manipulate the clocks for some specific
> reason.
>
> adam
>
> >
> > Cc: Adam Ford <aford173@gmail.com>
> > Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > index c946749a3d73..9539d747e28e 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > @@ -1640,11 +1640,6 @@ mipi_dsi: dsi@32e60000 {
> >                                 clocks = <&clk IMX8MP_CLK_MEDIA_APB_ROOT>,
> >                                          <&clk IMX8MP_CLK_MEDIA_MIPI_PHY1_REF>;
> >                                 clock-names = "bus_clk", "sclk_mipi";
> > -                               assigned-clocks = <&clk IMX8MP_CLK_MEDIA_APB>,
> > -                                                 <&clk IMX8MP_CLK_MEDIA_MIPI_PHY1_REF>;
> > -                               assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_800M>,
> > -                                                        <&clk IMX8MP_CLK_24M>;
> > -                               assigned-clock-rates = <200000000>, <24000000>;
> >                                 samsung,pll-clock-frequency = <24000000>;
> >                                 interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
> >                                 power-domains = <&media_blk_ctrl IMX8MP_MEDIABLK_PD_MIPI_DSI_1>;
> > @@ -1747,13 +1742,16 @@ media_blk_ctrl: blk-ctrl@32ec0000 {
> >                                                   <&clk IMX8MP_CLK_MEDIA_APB>,
> >                                                   <&clk IMX8MP_CLK_MEDIA_DISP1_PIX>,
> >                                                   <&clk IMX8MP_CLK_MEDIA_DISP2_PIX>,
> > -                                                 <&clk IMX8MP_VIDEO_PLL1>;
> > +                                                 <&clk IMX8MP_VIDEO_PLL1>,
> > +                                                 <&clk IMX8MP_CLK_MEDIA_MIPI_PHY1_REF>;
> >                                 assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_1000M>,
> >                                                          <&clk IMX8MP_SYS_PLL1_800M>,
> >                                                          <&clk IMX8MP_VIDEO_PLL1_OUT>,
> > -                                                        <&clk IMX8MP_VIDEO_PLL1_OUT>;
> > +                                                        <&clk IMX8MP_VIDEO_PLL1_OUT>,
> > +                                                        <&clk IMX8MP_CLK_24M>;
> >                                 assigned-clock-rates = <500000000>, <200000000>,
> > -                                                      <0>, <0>, <1039500000>;
> > +                                                      <0>, <0>, <1039500000>,
> > +                                                      <24000000>;
> >                                 #power-domain-cells = <1>;
> >
> >                                 lvds_bridge: bridge@5c {
> >
> > --
> > 2.34.1
> >
