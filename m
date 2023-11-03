Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0E97E0A91
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 22:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjKCVHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 17:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKCVHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 17:07:24 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7E2D55;
        Fri,  3 Nov 2023 14:07:21 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2800db61af7so646464a91.0;
        Fri, 03 Nov 2023 14:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699045640; x=1699650440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXtRxsCTHEgd7N2VItusDHJ5nIX2rapcklDE17/uzJE=;
        b=fdl376WTYJaai+KI0tOw9U/nDYA24ZrUu/9JTocM9ViQbGyWawLA7SMAOADGg+dyDY
         v8bHJ0v3PKD82MxUZuzccRUq4uRFlnmZTiikPjFcRl41T0Cu0GGrQO1ceVnaPTCl8iYc
         zGPz1GbYfr4w38SJivwpvOL0J6q3/pw6eaPZ+MaR1pe245exg/cJGd8DBaaErvIbIs5j
         u6PfDicyuNDN6n6Lz4TieEFk7XL4VJw/3pxEdCsPt0Ayh3oUzYuLTziSwcqX4/y5y0YI
         +nlvJMlSTkKjBOOmxuFX7AzNjwHWMDiqCn/alQbJtafVSKYUZo3FEE+1x0EOm9VthovZ
         0n4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699045640; x=1699650440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXtRxsCTHEgd7N2VItusDHJ5nIX2rapcklDE17/uzJE=;
        b=QnhgO564LkGytsKlEypqi/Qr77tsUSH6L+aw15f0cwc3yJUjLDBcpv1uX+zHwWP0Gz
         FKqLhVNDSgq4/KzeJ5Ul4Y4pV4XDgN8AaYUlaJn8ihKQokdqFrL23rhAq7FJ03HzPwlA
         rKMfbL1klylRDGL/Pxn031WlLkkYLVx/EDOHiTOTWOXj4s0da8+rcQjpZYV9+HtQHpVq
         60KX59mYzBvN4s9uYgGiefP7rCNfKMyE3UCOgd1GNmcCoaKeWvXdwk/zF8vXG6cWlrEL
         ssS6PkMaV6ngm02wdH98VEz/BKQA9mI6uKVr810Wgf3J0wJNXRfTPmxq2ammIcpDvnJ0
         5P0g==
X-Gm-Message-State: AOJu0Yy2kTnTKj/dz4NaXrLQ7yaZ+uN5S7VGyjcyKsdDkPMRO0E4s3w9
        LMyo/y/26oJ1scQJqntPROMJrkFDuDl24mWR4Oc=
X-Google-Smtp-Source: AGHT+IGJnHDjaffBq5abN750AlLxA5NMdDZYql3wsA/ckA5GU/oohSUB17hUbs4+jxOS6LypGqox1qNojBol5JzVwUw=
X-Received: by 2002:a17:90b:310d:b0:27f:f8d6:9622 with SMTP id
 gc13-20020a17090b310d00b0027ff8d69622mr21995221pjb.0.1699045639878; Fri, 03
 Nov 2023 14:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231102231130.13ca0513@pcn112>
In-Reply-To: <20231102231130.13ca0513@pcn112>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 3 Nov 2023 18:07:08 -0300
Message-ID: <CAOMZO5C8wq=72HUqSb9bdQK2ji2zcEKByByovnKzUt6A5H3K8Q@mail.gmail.com>
Subject: Re: [PATCH v1] ARM: dts: imx: tqma7: add lm75a sensor (rev. 01xxx)
To:     =?UTF-8?Q?Jo=C3=A3o_Rodrigues?= <jrodrigues@ubimet.com>,
        Bruno Thomsen <bruno.thomsen@gmail.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Adding Bruno and Alexander]

On Thu, Nov 2, 2023 at 7:12=E2=80=AFPM Jo=C3=A3o Rodrigues <jrodrigues@ubim=
et.com> wrote:
>
> From: Jo=C3=A3o Rodrigues <jrodrigues@ubimet.com>
>
> TQMa7x (revision 01xxx) uses a LM75A temperature sensor.
> The two sensors use different I2C addresses, so we can set both sensors
> simultaneously.
>
> Signed-off-by: Jo=C3=A3o Rodrigues <jrodrigues@ubimet.com>
> ---
>  arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi b/arch/arm/boot/dt=
s/nxp/imx/imx7-tqma7.dtsi
> index fe42b0a4683..3fc3130f9de 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
> +++ b/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
> @@ -128,11 +128,16 @@ vgen6_reg: vldo4 {
>                 };
>         };
>
> -       /* NXP SE97BTP with temperature sensor + eeprom */
> +       /* LM75A temperature sensor, TQMa7x 01xx */
> +       lm75a: temperature-sensor@48 {
> +               compatible =3D "national,lm75a";
> +               reg =3D <0x48>;
> +       };
> +
> +       /* NXP SE97BTP with temperature sensor + eeprom, TQMa7x 02xx */
>         se97b: temperature-sensor-eeprom@1e {
>                 compatible =3D "nxp,se97b", "jedec,jc-42.4-temp";
>                 reg =3D <0x1e>;
> -               status =3D "okay";
>         };
>
>         /* ST M24C64 */
> --
> 2.25.1
>
