Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B008082E6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378203AbjLGIXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjLGIXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:23:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292F510EC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 00:23:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA88C433C7;
        Thu,  7 Dec 2023 08:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701937403;
        bh=yk6swEfuyRxghN0BW1FvsI13oCfcyxJGSxYDBp8aTtY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tyuz9FrzPf/fDcUa6SuBRAN8fJSbKpzRSIOJLn+4UP3+0E9bTArAZfATV8NbM+mxC
         dohXtJu2DvNbOrKmaOUUzPvAGk0GYdYvSOmTHH6n3dkgQ/lI+2OVhO9QIwTBp1vsUx
         zvKRhzKhUpBdieUNlU/jN+OGPfZC8pot9sXkJarO6S3SqX3Ey2uW9pVb9RBrsIn/Zs
         AUkBnDErFb7DIpvNRvMm94UI6rnPSz1Pnr8GbO9vdXPstayATdEciaMoy1bqIcVJ/M
         ZwwoD9WUvfLFfC48qxmkijrZXAqVui1BH5zRQVVPe80bPbYIYekocIIspBrXS/uHk7
         lZ62rlOPt6XMQ==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a1f0616a15bso21411966b.2;
        Thu, 07 Dec 2023 00:23:23 -0800 (PST)
X-Gm-Message-State: AOJu0Yye7lgrcquOUDCPV+X74ovk1qhv1qtY7s/Ge8yJsZ+snLou11Qm
        vkYYKM+LFbvv9FyczQsp5CLWVnHXlKwzWxQxQlI=
X-Google-Smtp-Source: AGHT+IFoCVyTLoIcwyDXDm0QqN3KpaIFbMYwNQTGB8nrfNWHSaJALJpdmDtfjqP8/m/GwnGLNHBEYi0kUL0Ufd0kiUM=
X-Received: by 2002:a17:906:1017:b0:a1e:42e1:293d with SMTP id
 23-20020a170906101700b00a1e42e1293dmr818321ejm.94.1701937402114; Thu, 07 Dec
 2023 00:23:22 -0800 (PST)
MIME-Version: 1.0
References: <20231206-th1520_mmc_dts-v8-0-69220e373e8f@baylibre.com> <20231206-th1520_mmc_dts-v8-2-69220e373e8f@baylibre.com>
In-Reply-To: <20231206-th1520_mmc_dts-v8-2-69220e373e8f@baylibre.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 7 Dec 2023 16:23:10 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTnhBZWZxad8=+9W38WL7sRFmugxAyDDzK=BUPK44q4qA@mail.gmail.com>
Message-ID: <CAJF2gTTnhBZWZxad8=+9W38WL7sRFmugxAyDDzK=BUPK44q4qA@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] riscv: dts: thead: Add TH1520 mmc controllers and
 sdhci clock
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>, Fu Wei <wefu@redhat.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 4:09=E2=80=AFPM Drew Fustini <dfustini@baylibre.com>=
 wrote:
>
> Add node for the fixed reference clock used for emmc and sdio nodes.
> Add emmc node for the 1st dwcmshc instance which is typically connected
> to an eMMC device. Add sdio0 node for the 2nd dwcmshc instance which is
> typically connected to microSD slot. Add sdio1 node for the 3rd dwcmshc
> instance which is typically connected to an SDIO WiFi module. The node
> names are based on Table 1-2 C910/C906 memory map in the TH1520 System
> User Manual.
>
> Link: https://git.beagleboard.org/beaglev-ahead/beaglev-ahead/-/tree/main=
/docs
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---
>  arch/riscv/boot/dts/thead/th1520.dtsi | 34 +++++++++++++++++++++++++++++=
+++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/=
thead/th1520.dtsi
> index ba4d2c673ac8..8b915e206f3a 100644
> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> @@ -146,6 +146,13 @@ uart_sclk: uart-sclk-clock {
>                 #clock-cells =3D <0>;
>         };
>
> +       sdhci_clk: sdhci-clock {
> +               compatible =3D "fixed-clock";
> +               clock-frequency =3D <198000000>;
> +               clock-output-names =3D "sdhci_clk";
> +               #clock-cells =3D <0>;
> +       };
> +
>         soc {
>                 compatible =3D "simple-bus";
>                 interrupt-parent =3D <&plic>;
> @@ -304,6 +311,33 @@ dmac0: dma-controller@ffefc00000 {
>                         status =3D "disabled";
>                 };
>
> +               emmc: mmc@ffe7080000 {
> +                       compatible =3D "thead,th1520-dwcmshc";
> +                       reg =3D <0xff 0xe7080000 0x0 0x10000>;
> +                       interrupts =3D <62 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks =3D <&sdhci_clk>;
> +                       clock-names =3D "core";
> +                       status =3D "disabled";
> +               };
> +
> +               sdio0: mmc@ffe7090000 {
> +                       compatible =3D "thead,th1520-dwcmshc";
> +                       reg =3D <0xff 0xe7090000 0x0 0x10000>;
> +                       interrupts =3D <64 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks =3D <&sdhci_clk>;
> +                       clock-names =3D "core";
> +                       status =3D "disabled";
> +               };
> +
> +               sdio1: mmc@ffe70a0000 {
> +                       compatible =3D "thead,th1520-dwcmshc";
> +                       reg =3D <0xff 0xe70a0000 0x0 0x10000>;
> +                       interrupts =3D <71 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks =3D <&sdhci_clk>;
> +                       clock-names =3D "core";
> +                       status =3D "disabled";
> +               };
> +
>                 timer0: timer@ffefc32000 {
>                         compatible =3D "snps,dw-apb-timer";
>                         reg =3D <0xff 0xefc32000 0x0 0x14>;
>
> --
> 2.34.1
>
Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren
