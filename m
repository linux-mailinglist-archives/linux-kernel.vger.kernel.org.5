Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B88D759E9D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjGSTch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGSTce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:32:34 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB2E199A;
        Wed, 19 Jul 2023 12:32:33 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-55b78bf0423so410514a12.0;
        Wed, 19 Jul 2023 12:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689795153; x=1692387153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgIpzoU0VyQgL0NkVcRHfS3NqAECcKE/nlvXM/xlG+M=;
        b=h/Rc6xYRpJRL80HYp/Qg/Vf5WIp3rIkulUvx5EI0vtSzDl5SuUL5lXqyJTmlvq/Drg
         nGmkeNdHbOnfPBs0pHIoGxMpMm++ePmxrF0txPoCrIvQoj8g+1ZkkT860MrA6Mex/a9z
         Rez08BJTdM0buF9FOhAdvyTkIb31qJ/x9R357vJz2yUkYRmksEuwrg64aOsHMhb+1S5F
         oOFU3NexOR4rdOCmxJ7yHjhCdLTaTmnkAGATqTd0C5v0C/ot3DXmMujQYq2n1DUyW/vZ
         LVlaC5GroqcdfmbIZotE9X6NqlunqYQ4wPeQkeydIJCPMNYAm49Z+ajt2vnGL34F8lWI
         Ejaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689795153; x=1692387153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JgIpzoU0VyQgL0NkVcRHfS3NqAECcKE/nlvXM/xlG+M=;
        b=R9wIQ/eixT3bQL3Cz1sf7uRWtRo1af1usFQsdbf16mx2RIoM5aC0RtNzgBmXJXiAbi
         q6XmnMt1MZVorburG69P7ZrMOkmxmPp2K7eR+xh68Kw2sorbt+wCjn7BLa8WP0S/GYOg
         LIGQI4+N+H7Zun72/sVJ+4vNR2d6jayYjmt/90o3CnfnqAqPYRAenrNvJ4RwpI1AUSt9
         aUeAzUsdJkBEaokBieGIdkCiTj06jGsFDZQZy+V+l1K49wK965O1E1KJIqcmNEX6GA8x
         tqrZVh2E3auiyYlZy415mWOU0cq4IKvxGvddtcHUmv6KrlYytDZFCNzAqPhzhS0Arisa
         1o3g==
X-Gm-Message-State: ABy/qLbzswQ5xBo7AVhgdZ0gpyEb8btmGjVmnsEKCcaAnLh1mu/yv9oo
        jc3aTKW1otJJBb+vuXv/oa7wth0i8ErX5kifyx4TnUoMuZxchA==
X-Google-Smtp-Source: APBJJlFQl3zbsRGAKqJGd4h0afkfwXib7FZqWkCfiL9xu+3C9/loC7Gq+fzEIDjgESruY8JcSm6o30/KrThsBUyIdYA=
X-Received: by 2002:a17:90a:3e05:b0:25b:88bc:bb6b with SMTP id
 j5-20020a17090a3e0500b0025b88bcbb6bmr193123pjc.2.1689795153073; Wed, 19 Jul
 2023 12:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230719160048.2737423-1-james.hilliard1@gmail.com> <20230719160048.2737423-2-james.hilliard1@gmail.com>
In-Reply-To: <20230719160048.2737423-2-james.hilliard1@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 19 Jul 2023 16:32:21 -0300
Message-ID: <CAOMZO5C_BFm+P=9uizL0buSJ9a33PM6hNgG5OcZ3B4YxD=h_6w@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx6q: Add Variscite MX6 Custom board support
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Wed, Jul 19, 2023 at 1:01=E2=80=AFPM James Hilliard
<james.hilliard1@gmail.com> wrote:
>
> This patch adds support for the Variscite MX6 SoM Carrier Board.
>
> This Carrier-Board has the following :
> - LVDS interface for the VLCD-CAP-GLD-LVDS 7" LCD 800 x 480 touch display
> - HDMI Connector
> - USB Host + USB OTG Connector
> - 10/100/1000 Mbps Ethernet
> - miniPCI-Express slot
> - SD Card connector
> - Audio Headphone/Line In jack connectors
> - S-ATA
> - On-board DMIC
> - RS485 Header
> - CAN bus header
> - SPI header
> - Camera Interfaces header
> - OnBoard RTC with Coin Backup battery socket
> - RS232 Debug Header (IDC10)
> - RS232 DTE

Good, but what exactly has been tested?

> Product Page : https://www.variscite.com/product/single-board-computers/v=
ar-mx6customboard
>
> The dts file based on the ones provided by Variscite on their own
> kernel, but adapted for mainline.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Is this patch from you or Gregory? If Gregory is the author, then his
name should appear in the From: line.

> +&iomuxc {
> +       imx6qdl-var-som-mx6 {

This ' imx6qdl-var-som-mx6' should be dropped.

> +
> +               pinctrl_ipu1: ipu1grp {
> +                       fsl,pins =3D <
> +                               MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CL=
K      0x10
> +                               MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15     =
       0x10
> +                               MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02      =
       0x10
> +                               MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03      =
       0x10
> +                               MX6QDL_PAD_DI0_PIN4__IPU1_DI0_PIN04      =
       0x80000000

No 0x80000000 please. Use the real pad ctl value instead.
This applies globally.

&mipi_csi {
> +       status =3D "okay";
> +       ipu_id =3D <0>;
> +       csi_id =3D <1>;
> +       v_channel =3D <0>;
> +       lanes =3D <2>;

These are all NXP vendor devicetree properties. They do not exist upstream.

> +       lvds-channel@0 {
> +               fsl,data-mapping =3D "spwg";
> +               fsl,data-width =3D <24>;
> +               status =3D "okay";
> +               primary;

This property does not exist upstream.

> +       lvds-channel@1 {
> +               fsl,data-mapping =3D "spwg";
> +               fsl,data-width =3D <24>;
> +               status =3D "okay";
> +               primary;

Ditto.

> +&usbphy1 {
> +       tx-d-cal =3D <0x5>;

In upstream it is called fsl,tx-d-cal.

> +};
> +
> +&usbphy2 {
> +       tx-d-cal =3D <0x5>;

Ditto.
