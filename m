Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEC77581FF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbjGRQXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjGRQXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:23:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504F7E47;
        Tue, 18 Jul 2023 09:23:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBE9961626;
        Tue, 18 Jul 2023 16:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE47C433C8;
        Tue, 18 Jul 2023 16:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689697385;
        bh=icbMFMtQ3lkA9tylPtFj8ej7HHiBHCQ5HZ8vA+FRV5Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aUBYuh/cAvGLezSlqeXudZfvhdJH2M7pHQPswcn+WmUa+NTZRbqPXtezLJt/RBxJh
         iFzWGE7ALjIcYCb48nJ1kehSCAmvzhpMKJed05Q/S+WDNPSkxAhRZgYsWf+YYt0fao
         HZITvtf2L5J+hryS4ZrU8cTUgv3fNhKvqah5+ms7FJ4xD2KPa6lv3EFMGWOlSlFGQL
         DheVjoSJtsz7zHVDqtmJ4xPn7ribMVS0Q/GyoWMRapFRykF2Xme8+iG9+3FET7XfnX
         CVwfE930P1AwjVzVEjXYpkAV789QWtyU+vnlK6r6eC7LPpRM5QXj1nAWIdV+SSwau5
         S0fy/kflmIWbw==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2b703d7ed3aso92636841fa.1;
        Tue, 18 Jul 2023 09:23:05 -0700 (PDT)
X-Gm-Message-State: ABy/qLZVpmMPQDsZFGxIJQfnGICnUifychFMdcAO8BY762yOmLi3PKdG
        pxOX0ZY0Op73lLBYJORirLsn68RINhMN7SWVsw==
X-Google-Smtp-Source: APBJJlGj+ZpofUIc6zHHujxiGcPXHnRgVhDNboz2CC9TUdOUC83BktrYxXR294WRF91vmibjYQyttpRf6KCypi+pu/Q=
X-Received: by 2002:a2e:9901:0:b0:2b8:6f78:ffa0 with SMTP id
 v1-20020a2e9901000000b002b86f78ffa0mr7351467lji.18.1689697383268; Tue, 18 Jul
 2023 09:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230626221019.3946448-1-robh@kernel.org>
In-Reply-To: <20230626221019.3946448-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 18 Jul 2023 10:22:50 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+x8qZuov0c7XFzvCxb6TqEudCrLDsOM-bkS9Gu7B4R4Q@mail.gmail.com>
Message-ID: <CAL_Jsq+x8qZuov0c7XFzvCxb6TqEudCrLDsOM-bkS9Gu7B4R4Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: hisilicon: Fix "status" values
To:     Wei Xu <xuwei5@hisilicon.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 4:10=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> The defined value for "status" is "disabled", not "disable".
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm/boot/dts/hisilicon/hi3519.dtsi | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Ping!

>
> diff --git a/arch/arm/boot/dts/hisilicon/hi3519.dtsi b/arch/arm/boot/dts/=
hisilicon/hi3519.dtsi
> index c524c854d319..a42b71cdc5d7 100644
> --- a/arch/arm/boot/dts/hisilicon/hi3519.dtsi
> +++ b/arch/arm/boot/dts/hisilicon/hi3519.dtsi
> @@ -54,7 +54,7 @@ uart0: serial@12100000 {
>                         interrupts =3D <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
>                         clocks =3D <&crg HI3519_UART0_CLK>, <&crg HI3519_=
UART0_CLK>;
>                         clock-names =3D "uartclk", "apb_pclk";
> -                       status =3D "disable";
> +                       status =3D "disabled";
>                 };
>
>                 uart1: serial@12101000 {
> @@ -63,7 +63,7 @@ uart1: serial@12101000 {
>                         interrupts =3D <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
>                         clocks =3D <&crg HI3519_UART1_CLK>, <&crg HI3519_=
UART1_CLK>;
>                         clock-names =3D "uartclk", "apb_pclk";
> -                       status =3D "disable";
> +                       status =3D "disabled";
>                 };
>
>                 uart2: serial@12102000 {
> @@ -72,7 +72,7 @@ uart2: serial@12102000 {
>                         interrupts =3D <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
>                         clocks =3D <&crg HI3519_UART2_CLK>, <&crg HI3519_=
UART2_CLK>;
>                         clock-names =3D "uartclk", "apb_pclk";
> -                       status =3D "disable";
> +                       status =3D "disabled";
>                 };
>
>                 uart3: serial@12103000 {
> @@ -81,7 +81,7 @@ uart3: serial@12103000 {
>                         interrupts =3D <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
>                         clocks =3D <&crg HI3519_UART3_CLK>, <&crg HI3519_=
UART3_CLK>;
>                         clock-names =3D "uartclk", "apb_pclk";
> -                       status =3D "disable";
> +                       status =3D "disabled";
>                 };
>
>                 uart4: serial@12104000 {
> @@ -90,7 +90,7 @@ uart4: serial@12104000 {
>                         interrupts =3D <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
>                         clocks =3D <&crg HI3519_UART4_CLK>, <&crg HI3519_=
UART4_CLK>;
>                         clock-names =3D "uartclk", "apb_pclk";
> -                       status =3D "disable";
> +                       status =3D "disabled";
>                 };
>
>                 dual_timer0: timer@12000000 {
> @@ -100,7 +100,7 @@ dual_timer0: timer@12000000 {
>                         reg =3D <0x12000000 0x1000>;
>                         clocks =3D <&clk_3m>;
>                         clock-names =3D "apb_pclk";
> -                       status =3D "disable";
> +                       status =3D "disabled";
>                 };
>
>                 dual_timer1: timer@12001000 {
> @@ -110,7 +110,7 @@ dual_timer1: timer@12001000 {
>                         reg =3D <0x12001000 0x1000>;
>                         clocks =3D <&clk_3m>;
>                         clock-names =3D "apb_pclk";
> -                       status =3D "disable";
> +                       status =3D "disabled";
>                 };
>
>                 dual_timer2: timer@12002000 {
> @@ -120,7 +120,7 @@ dual_timer2: timer@12002000 {
>                         reg =3D <0x12002000 0x1000>;
>                         clocks =3D <&clk_3m>;
>                         clock-names =3D "apb_pclk";
> -                       status =3D "disable";
> +                       status =3D "disabled";
>                 };
>
>                 spi_bus0: spi@12120000 {
> @@ -132,7 +132,7 @@ spi_bus0: spi@12120000 {
>                         num-cs =3D <1>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <0>;
> -                       status =3D "disable";
> +                       status =3D "disabled";
>                 };
>
>                 spi_bus1: spi@12121000 {
> @@ -144,7 +144,7 @@ spi_bus1: spi@12121000 {
>                         num-cs =3D <1>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <0>;
> -                       status =3D "disable";
> +                       status =3D "disabled";
>                 };
>
>                 spi_bus2: spi@12122000 {
> @@ -156,7 +156,7 @@ spi_bus2: spi@12122000 {
>                         num-cs =3D <1>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <0>;
> -                       status =3D "disable";
> +                       status =3D "disabled";
>                 };
>
>                 sysctrl: system-controller@12020000 {
> --
> 2.40.1
>
