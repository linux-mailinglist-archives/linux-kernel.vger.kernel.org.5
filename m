Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B2581350C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573868AbjLNPnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjLNPm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:42:58 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98A411A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:43:04 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6cebbf51742so616550b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702568584; x=1703173384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vrf71zeRoakCOirikHCZQN6uP6xeWPqt6djJMiGmq4s=;
        b=LElnosvI9dDxlQWUhLtNohHhPJzSIq9wY+2LBzHamZTeXWc/xwW43NFTUa4RKA6iUO
         n6G/6elc0MawwhAb8VWtFKjN8tHdCRtjB5Gs4g/HRM61Un7wRKXTdcS4SUyaWmI4668B
         MtvKtFlixzKWw90Yy7bye4FhuH22FX1s+ZxlvYiHYlDgGuNpa/6TAfcfek39pIDZ/e0J
         VL4qAkG8fTfz6mFbGHojsXkTazmTWJPFa50gOU7F/A/DAMjH7Sa+7KtgEqoppbTpD6Z9
         Lj7fZ5gNyc2N+++w031ripq92XoRtVHJgTkokvJDZqHnlPzvaLza7fjpCye7FmMCqW6X
         6ytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702568584; x=1703173384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vrf71zeRoakCOirikHCZQN6uP6xeWPqt6djJMiGmq4s=;
        b=kK8hKMiItRXkbxhw3qQkSJfaUswmgYyNzsImLSYQLJWyhV20sVJOLpZrE2y7JwXZHN
         GnuC3C5iDVZ4F2Nuh4dJtL679TmMdsCQIfG18RJLB1xNTu+1HXyuBQGnBXs2UoQArUTR
         JAPLjl2vzRABisGXUNE8htmUMWJmf/ybGVgeTSfpnvk/vldneRztI9hR8yXhrDEXkBP1
         5vKAgpLOv/z7BBsInlCVB1YYTVPjqqYpwzEKxcbm02QxUJjJW9Q7fvkF9SfOmjfBpEJ0
         8L+q87BqpURgFSqqBt7gcBGWQb4CW4UXezeDHllODjrSriS66YPHkdlMriLm+p8aGyC2
         Hinw==
X-Gm-Message-State: AOJu0Yy7RTnxfLqUul08exhYrwdUJFX/c91PVpfQO+xleKWxMfUtg8Zx
        8S1R+pe3DxK2VQUovR6AIMzPFhWC3C5lEBGsBH6N+A==
X-Google-Smtp-Source: AGHT+IE2jilk7oyFiidXwFcRC0piQwl6OP8nRC5rbBI5bUGmjT02Tn4mP2ogLRSB6Dh8EFxlAaTVDguaa4ZMpkPqCu8=
X-Received: by 2002:a05:6a00:bef:b0:6d0:96d2:f2f7 with SMTP id
 x47-20020a056a000bef00b006d096d2f2f7mr7169098pfu.3.1702568584185; Thu, 14 Dec
 2023 07:43:04 -0800 (PST)
MIME-Version: 1.0
References: <20231214105243.3707730-1-tudor.ambarus@linaro.org> <20231214105243.3707730-10-tudor.ambarus@linaro.org>
In-Reply-To: <20231214105243.3707730-10-tudor.ambarus@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 14 Dec 2023 09:42:53 -0600
Message-ID: <CAPLW+4kzdsuHiPqFuCbgD+595Kg3+mM8ziXr+D3K0LvEQXF_rQ@mail.gmail.com>
Subject: Re: [PATCH 09/13] arm64: dts: exynos: gs101: update USI UART to use
 peric0 clocks
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     peter.griffin@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org, andi.shyti@kernel.org,
        alim.akhtar@samsung.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        s.nawrocki@samsung.com, tomasz.figa@gmail.com,
        cw00.choi@samsung.com, arnd@arndb.de, andre.draszik@linaro.org,
        saravanak@google.com, willmcvicker@google.com,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 4:53=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
> Get rid of the dummy clock and start using the cmu_peric0 clocks
> for the usi_uart and serial_0 nodes.
>
> Tested the serial at 115200, 1000000 and 3000000 baudrates,
> everthing went fine.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  arch/arm64/boot/dts/exynos/google/gs101.dtsi | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/bo=
ot/dts/exynos/google/gs101.dtsi
> index d0b0ad70c6ba..ffb7b4d89a8c 100644
> --- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> +++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> @@ -180,14 +180,6 @@ HERA_CPU_SLEEP: cpu-hera-sleep {
>                 };
>         };
>
> -       /* TODO replace with CCF clock */
> -       dummy_clk: clock-3 {
> -               compatible =3D "fixed-clock";
> -               #clock-cells =3D <0>;
> -               clock-frequency =3D <12345>;
> -               clock-output-names =3D "pclk";
> -       };
> -
>         /* ect node is required to be present by bootloader */
>         ect {
>         };
> @@ -369,7 +361,8 @@ usi_uart: usi@10a000c0 {
>                         ranges;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
> -                       clocks =3D <&dummy_clk>, <&dummy_clk>;
> +                       clocks =3D <&cmu_peric0 CLK_GOUT_PERIC0_CLK_PERIC=
0_USI0_UART_CLK>,
> +                                <&cmu_peric0 CLK_DOUT_PERIC0_USI0_UART>;

Why using DIV clock here? Usually all leaf clocks are GATE clocks (at
least it's so in Exynos850).

>                         clock-names =3D "pclk", "ipclk";
>                         samsung,sysreg =3D <&sysreg_peric0 0x1020>;
>                         samsung,mode =3D <USI_V2_UART>;
> @@ -381,7 +374,8 @@ serial_0: serial@10a00000 {
>                                 reg-io-width =3D <4>;
>                                 interrupts =3D <GIC_SPI 634
>                                               IRQ_TYPE_LEVEL_HIGH 0>;
> -                               clocks =3D <&dummy_clk 0>, <&dummy_clk 0>=
;
> +                               clocks =3D <&cmu_peric0 CLK_GOUT_PERIC0_C=
LK_PERIC0_USI0_UART_CLK>,
> +                                        <&cmu_peric0 CLK_DOUT_PERIC0_USI=
0_UART>;

Ditto.

>                                 clock-names =3D "uart", "clk_uart_baud0";
>                                 samsung,uart-fifosize =3D <256>;
>                                 status =3D "disabled";
> --
> 2.43.0.472.g3155946c3a-goog
>
