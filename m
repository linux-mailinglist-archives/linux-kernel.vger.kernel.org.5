Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D1275DF39
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 01:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjGVXEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 19:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGVXES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 19:04:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6751A7;
        Sat, 22 Jul 2023 16:04:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FF6F60BD4;
        Sat, 22 Jul 2023 23:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85FBBC433CD;
        Sat, 22 Jul 2023 23:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690067054;
        bh=jHDurJCKvh+0DW2iz6/hNYVkG/b77t0wwifyBKWDoQ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MM/VZcc9SSBG8sY3FioZUC8DvEhQpaWmbfjX+U0MDN/20a0ucLWbu2BhVQGCEwiiA
         JDTVGSHOaULmhXZUQvN5C6TiiZ4LhyNlGwROSFaEG6nVfv3WYUjYM4at2hxF+mzr2V
         Gd2Vgrzl0ASWzX/d4PaPkzEuV5h4gmcphEiigE5EsHLFiHK68BMNUAM1HdSxARiRjf
         jGAA++1lFJXoTaf8PfWHsNWDj7dNRHKregqHxVYAQ+QuBCOnC4ExInEhI5IiddAg/Y
         MQlPREmH+Brr7r8j3e/m+bi/S2CprY/5g0CNTFIud1kKXaJkW6GcXtgPGmVbUNDd6q
         CPCTmRz4yzebg==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-98e39784a85so895333766b.1;
        Sat, 22 Jul 2023 16:04:14 -0700 (PDT)
X-Gm-Message-State: ABy/qLbOeihBBMPRv3qzfoGR3R69hZoIbNV0LO8d9PNhANfpcPxm1wsN
        +R6P56b6UmzQE1gw5lTc9DYkTEb4JNQZMuWf3WA=
X-Google-Smtp-Source: APBJJlHEIAEKlsJ3S8q5nOLrJPnA7QWosr2T4LRq/I7my9NOXv77NsFxailpjiAeFkQL3gGB0DohcUF9YxjSgXhYwFY=
X-Received: by 2002:a17:906:5a53:b0:994:5457:269e with SMTP id
 my19-20020a1709065a5300b009945457269emr6034479ejc.0.1690067052821; Sat, 22
 Jul 2023 16:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230722-upstream-beaglev-ahead-dts-v1-0-ccda511357f4@baylibre.com>
 <20230722-upstream-beaglev-ahead-dts-v1-1-ccda511357f4@baylibre.com>
In-Reply-To: <20230722-upstream-beaglev-ahead-dts-v1-1-ccda511357f4@baylibre.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 23 Jul 2023 07:04:01 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTTJM8o+rTciXE2W29OaCTi+CPrSWx0+4XFA8yQBEGm9w@mail.gmail.com>
Message-ID: <CAJF2gTTTJM8o+rTciXE2W29OaCTi+CPrSWx0+4XFA8yQBEGm9w@mail.gmail.com>
Subject: Re: [PATCH 1/3] riscv: dts: thead: add BeagleV Ahead board device tree
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>, Fu Wei <wefu@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Sun, Jul 23, 2023 at 5:56=E2=80=AFAM Drew Fustini <dfustini@baylibre.com=
> wrote:
>
> The BeagleV Ahead single board computer uses the T-Head TH1520 SoC.
> Add a minimal device tree to support basic uart/gpio/dmac drivers so
> that a user can boot to a basic shell.
>
> Link: https://beagleboard.org/beaglev-ahead
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---
>  arch/riscv/boot/dts/thead/Makefile                 |  2 +-
>  arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts | 61 ++++++++++++++++=
++++++
>  2 files changed, 62 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/boot/dts/thead/Makefile b/arch/riscv/boot/dts/the=
ad/Makefile
> index e311fc9a5939..b55a17127c2b 100644
> --- a/arch/riscv/boot/dts/thead/Makefile
> +++ b/arch/riscv/boot/dts/thead/Makefile
> @@ -1,2 +1,2 @@
>  # SPDX-License-Identifier: GPL-2.0
> -dtb-$(CONFIG_ARCH_THEAD) +=3D th1520-lichee-pi-4a.dtb
> +dtb-$(CONFIG_ARCH_THEAD) +=3D th1520-lichee-pi-4a.dtb th1520-beaglev-ahe=
ad.dtb
> diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/ri=
scv/boot/dts/thead/th1520-beaglev-ahead.dts
> new file mode 100644
> index 000000000000..c315e5bd3d2d
> --- /dev/null
> +++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> + * Copyright (C) 2023 Drew Fustini <dfustini@baylibre.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "th1520.dtsi"
> +
> +/ {
> +       model =3D "BeagleV Ahead";
> +       compatible =3D "beagle,beaglev-ahead", "thead,th1520";
> +
> +       aliases {
> +               gpio0 =3D &gpio0;
> +               gpio1 =3D &gpio1;
> +               gpio2 =3D &gpio2;
> +               gpio3 =3D &gpio3;
> +               serial0 =3D &uart0;
> +               serial1 =3D &uart1;
> +               serial2 =3D &uart2;
> +               serial3 =3D &uart3;
> +               serial4 =3D &uart4;
> +               serial5 =3D &uart5;
> +       };
> +
> +       chosen {
> +               stdout-path =3D "serial0:115200n8";
> +       };
> +
> +       memory@0 {
> +               device_type =3D "memory";
> +               reg =3D <0x0  0x00000000  0x1 0x00000000>;
> +
> +       };
> +};
> +
> +&osc {
> +       clock-frequency =3D <24000000>;
> +};
> +
> +&osc_32k {
> +       clock-frequency =3D <32768>;
> +};
> +
> +&apb_clk {
> +       clock-frequency =3D <62500000>;
> +};
> +
> +&uart_sclk {
> +       clock-frequency =3D <100000000>;
> +};
> +
> +&dmac0 {
> +       status =3D "okay";
> +};
> +
> +&uart0 {
> +       status =3D "okay";
> +};
>
> --
> 2.34.1
>


--=20
Best Regards
 Guo Ren
