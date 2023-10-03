Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E457B69B4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjJCNCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjJCNCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:02:04 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E257BD;
        Tue,  3 Oct 2023 06:02:01 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-53fa455cd94so534854a12.2;
        Tue, 03 Oct 2023 06:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696338120; x=1696942920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOSJ1LD4bOqUpxIFjxXpNvYG4tETz6JJkPH8DncEASw=;
        b=Q0euPap9gQxXxqis9T5E/DCrDxaFW50eDkILnExesUzzQJhff7kt8VQCOcgE1eer43
         XqFWloh0RILmC/3bMSvmshyD3mAZF0hOjmWg+IlJ57U+vh79vDNCi69ROQEaKkH7ygUw
         7d6+pol0EQslwo11EyzEJcijlJ3lK5UaaRyeUqSKhJ5iLYhPHcVJ/HwWHIC1lJMHMdcA
         CSIIuji3l9Do4J1GkXU753Mj5k/UiDdbOgjzopdvvmI9UCq6u7jVXIh2sX7tUDg7Z9lK
         CJ5RrmqFHfeas91xA5eSdLXaEy0DruujuQrbVbTYQpR5QYX2WmPT0YB+2QL8cPZXtpSb
         og0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696338120; x=1696942920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOSJ1LD4bOqUpxIFjxXpNvYG4tETz6JJkPH8DncEASw=;
        b=UQq22MeQFjaDbNMSQLxby5D7gn8EprNLtEbVanE9SVSZMg7t9DXiqGQKGEAazimUKl
         C3RwBJfWuqOsFOa9onamijO5jGoLbKSao0iQS5YJTcaTMZEDu/E67vD37WVCB3qXfC6y
         dWda53mVkRFkQRSnXMOqKHj5ePHhywiwyP3RYHwSYxIGHERGMRwcBEChb3IIpZ3w9MkG
         RuY1xXbUtcNrttXQw1MoJS9ad1DFV1QO07z36N2URoiBkGd14h70QCSB62K89rxTkHxI
         mLcRPD+Jq1wyElNwtENxnobWBaM84tLqHY3qAeyJOwttDO98ASOTp5ysff251qFT6iMz
         r9OA==
X-Gm-Message-State: AOJu0YzOQIQADPs4gjXKOoe9Y18dFD/jobQr0AdcJU4Yzyldsgloimf/
        xiRIPM6IehVWeP1cctPzVx8//4BHGj58paQaaOs=
X-Google-Smtp-Source: AGHT+IEu16w6ytf2IPuNE3nxhAFN87R51szRBqXUKJrqIGlckFiZFrvkEdHL/wOHt+LUrSqZd4mUJhAX6D2olpMX8zo=
X-Received: by 2002:a17:90a:fe8d:b0:269:3cdb:4edf with SMTP id
 co13-20020a17090afe8d00b002693cdb4edfmr12043422pjb.16.1696338120302; Tue, 03
 Oct 2023 06:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230918-imx8mp-dtsi-v1-0-1d008b3237c0@skidata.com> <20230918-imx8mp-dtsi-v1-2-1d008b3237c0@skidata.com>
In-Reply-To: <20230918-imx8mp-dtsi-v1-2-1d008b3237c0@skidata.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 3 Oct 2023 08:01:49 -0500
Message-ID: <CAHCN7x+TCxbaE7Y41Yn5SpG0G5V57hwXQ7HX_ExLF1EXKtZs4w@mail.gmail.com>
Subject: Re: [PATCH 02/13] arm64: dts: imx8mp: re-parent IMX8MP_CLK_MEDIA_MIPI_PHY1_REF
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Frank Oltmanns <frank@oltmanns.dev>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
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

On Sun, Sep 17, 2023 at 5:40=E2=80=AFPM Benjamin Bara <bbara93@gmail.com> w=
rote:
>
> From: Benjamin Bara <benjamin.bara@skidata.com>
>
> Similar to commit 07bb2e368820 ("arm64: dts: imx8mp: Fix video clock
> parents") the parent of IMX8MP_CLK_MEDIA_MIPI_PHY1_REF should be set in
> the media_blk_ctrl. Currently, if mipi_dsi is not in use, its parent is
> set to IMX8MP_VIDEO_PLL1_OUT, and might therefore clash with the
> constraints coming from a panel.

From what I can see, it looks like the IMX8MP_CLK_MEDIA_MIPI_PHY1_REF
parent is being set to IMX8MP_CLK_24M.  Isn't that the default? I also
don't think we need to set a 24MHz clock to 24MHz if that's the
default.

If that is the case, I would suggest we try to remove the assignment
altogether to make the device tree simpler and less to untangle if a
board needs to manually manipulate the clocks for some specific
reason.

adam

>
> Cc: Adam Ford <aford173@gmail.com>
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/=
dts/freescale/imx8mp.dtsi
> index c946749a3d73..9539d747e28e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -1640,11 +1640,6 @@ mipi_dsi: dsi@32e60000 {
>                                 clocks =3D <&clk IMX8MP_CLK_MEDIA_APB_ROO=
T>,
>                                          <&clk IMX8MP_CLK_MEDIA_MIPI_PHY1=
_REF>;
>                                 clock-names =3D "bus_clk", "sclk_mipi";
> -                               assigned-clocks =3D <&clk IMX8MP_CLK_MEDI=
A_APB>,
> -                                                 <&clk IMX8MP_CLK_MEDIA_=
MIPI_PHY1_REF>;
> -                               assigned-clock-parents =3D <&clk IMX8MP_S=
YS_PLL1_800M>,
> -                                                        <&clk IMX8MP_CLK=
_24M>;
> -                               assigned-clock-rates =3D <200000000>, <24=
000000>;
>                                 samsung,pll-clock-frequency =3D <24000000=
>;
>                                 interrupts =3D <GIC_SPI 18 IRQ_TYPE_LEVEL=
_HIGH>;
>                                 power-domains =3D <&media_blk_ctrl IMX8MP=
_MEDIABLK_PD_MIPI_DSI_1>;
> @@ -1747,13 +1742,16 @@ media_blk_ctrl: blk-ctrl@32ec0000 {
>                                                   <&clk IMX8MP_CLK_MEDIA_=
APB>,
>                                                   <&clk IMX8MP_CLK_MEDIA_=
DISP1_PIX>,
>                                                   <&clk IMX8MP_CLK_MEDIA_=
DISP2_PIX>,
> -                                                 <&clk IMX8MP_VIDEO_PLL1=
>;
> +                                                 <&clk IMX8MP_VIDEO_PLL1=
>,
> +                                                 <&clk IMX8MP_CLK_MEDIA_=
MIPI_PHY1_REF>;
>                                 assigned-clock-parents =3D <&clk IMX8MP_S=
YS_PLL2_1000M>,
>                                                          <&clk IMX8MP_SYS=
_PLL1_800M>,
>                                                          <&clk IMX8MP_VID=
EO_PLL1_OUT>,
> -                                                        <&clk IMX8MP_VID=
EO_PLL1_OUT>;
> +                                                        <&clk IMX8MP_VID=
EO_PLL1_OUT>,
> +                                                        <&clk IMX8MP_CLK=
_24M>;
>                                 assigned-clock-rates =3D <500000000>, <20=
0000000>,
> -                                                      <0>, <0>, <1039500=
000>;
> +                                                      <0>, <0>, <1039500=
000>,
> +                                                      <24000000>;
>                                 #power-domain-cells =3D <1>;
>
>                                 lvds_bridge: bridge@5c {
>
> --
> 2.34.1
>
