Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6A476371F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 15:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjGZNI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 09:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbjGZNIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:08:21 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F671BF2;
        Wed, 26 Jul 2023 06:08:19 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so639784a12.0;
        Wed, 26 Jul 2023 06:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690376899; x=1690981699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+jvLTMD6SRKXD1ssV+mqKXmm2sh5l8tuK18dvXLDZ0=;
        b=JantokC007z8nEFr53znXAczHo3EziakfiaRd8YueLDEqP+3OiVl5VVwNRNIW0vwyw
         5Z3F7dNCrhY5oZUQm6x8veUzAlko8u/+psC0QnnHBJGmhBhmqaOYrWubRfOdw5SsF2o3
         NXY2P95drR1x5vGghA2SHkcCrfgrO6gkoLnqnaFACoxM98ENHe60SLjJ4IB8CUFG4CDq
         R4RdDZwgAjuYPVoVj3Wk3Se8xij9X4H4OfSQeLI8M2d/VYRVBep9OjXX8Bx4NCPDlfoH
         hNcM8UEjshHOtgKXJWEby7fVXN51z4IgUknmWaIrRM8bfeONOZ9kBcer8dcpxxigEhx2
         gidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690376899; x=1690981699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+jvLTMD6SRKXD1ssV+mqKXmm2sh5l8tuK18dvXLDZ0=;
        b=SpuQqPpRxsSNZVNT/3zjkniCn3eZJKMd8Tq/lb2jAhpmCoCBPPFniSmTWQix4VWNB1
         zc6YK5ywnFe4g/5j6VcxxuGDC4i0CdlPityZ0U0tgvh61CdnqtE2cln3xOKL8fcYfgQO
         r4loIoDS5IbOi361u8f8DEO1LSNt4/2SxMjz7NKSP2WfumfpSBUlcjUY+AtBl1vhTyuf
         osL5XXnOenRG6xS/Ag4EgoZyKE0rvMp01UlCB5T6ezU4sQ+6/CefJRlnys5gfQ70sYQ7
         +hCYxo3Pi9821LiHGenTbr+ay+aBTNB+UdyDLc86T+lKAFeaNVyY3DkLoE7jjn6VQxbZ
         5gHA==
X-Gm-Message-State: ABy/qLaFFf3UNFT5t6uCWMo9E5bLqAJ0AZ1uU5FS5dbbUwvVP7nloruN
        3nxJAyna6DM6BnoTmIu3bHPlDTctfyYz1FPRqak=
X-Google-Smtp-Source: APBJJlFTiYK0k9/t8RBR1HkDbkL5w5yMREd7qN1MlfDydukq9zeFXNYodS+7QYkQTvzjgTFnirOm6uwpPySkbSYINTs=
X-Received: by 2002:a17:90a:1189:b0:263:f36e:d610 with SMTP id
 e9-20020a17090a118900b00263f36ed610mr1965297pja.0.1690376899208; Wed, 26 Jul
 2023 06:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230726070322.103871-1-krzysztof.kozlowski@linaro.org> <20230726070322.103871-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230726070322.103871-3-krzysztof.kozlowski@linaro.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 26 Jul 2023 10:08:07 -0300
Message-ID: <CAOMZO5C1JN7w+LhK-J0_ttKVopyeRq6VmCpAHujN_tGPMobotA@mail.gmail.com>
Subject: Re: [PATCH 3/8] AMR: dts: imx28-m28evk: populate fixed regulators
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patches 1, 2, 3, and 4 have a typo in the Subject: s/AMR/ARM.

On Wed, Jul 26, 2023 at 4:03=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Fixed regulators put under "regulators" node will not be populated,
> unless simple-bus or something similar is used.  Drop the "regulators"
> wrapper node to fix this.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/nxp/mxs/imx28-m28evk.dts | 45 ++++++++++------------
>  1 file changed, 20 insertions(+), 25 deletions(-)
>
> diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-m28evk.dts b/arch/arm/boot/d=
ts/nxp/mxs/imx28-m28evk.dts
> index e350d57a4cec..6bf26f386a5e 100644
> --- a/arch/arm/boot/dts/nxp/mxs/imx28-m28evk.dts
> +++ b/arch/arm/boot/dts/nxp/mxs/imx28-m28evk.dts
> @@ -18,33 +18,28 @@ backlight {
>                 default-brightness-level =3D <6>;
>         };
>
> -       regulators {
> -               reg_vddio_sd0: regulator@1 {
> -                       compatible =3D "regulator-fixed";
> -                       reg =3D <1>;
> -                       regulator-name =3D "vddio-sd0";
> -                       regulator-min-microvolt =3D <3300000>;
> -                       regulator-max-microvolt =3D <3300000>;
> -                       gpio =3D <&gpio3 28 0>;
> -               };
> +       reg_vddio_sd0: regulator-1 {

It should be better to write:

reg_vddio_sd0: regulator-vddio-sd0 {

regulator-1 is not very descriptive.
