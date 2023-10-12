Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5913D7C7061
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 16:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343837AbjJLOgx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Oct 2023 10:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbjJLOgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 10:36:51 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403B3BE;
        Thu, 12 Oct 2023 07:36:50 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5a7e5dc8573so13030647b3.0;
        Thu, 12 Oct 2023 07:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697121409; x=1697726209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xNUkD+t8nN69dK1Tkr14yK7DyMQjN5EP3Sv+TV2NO4=;
        b=wJDe08GnxvgDzS0/s2bsFX8+DMGXCq2qkkqbEI7Rxcigyg6xrluojSguNRST8aG4+f
         JsTr86US/9w6fLBmPzb4WncSgjHRRt+Miw597MSRTF0by4TZ7XPh6pW5tNGgARqUIKnE
         +5rC4VUwBWBK8Z74xeTN53pLzeo+GcCkYcLsIAivCysQOtwN08XHF4eb1qekKP1XJIa5
         KwXr0Sxob1LGS4pxUxn9nVDaRFQKQOwVFOWwwJDZ19Zfr8aAtTlJJEZrSOrmsFybWrg5
         gK4vNRo//2ePZHeEWenRa5wSz9ubHxJcq1d1q1oT3n8QRL1tc8UjTwflf6RUy3bkfwCB
         CEnQ==
X-Gm-Message-State: AOJu0YyGWu+iAUdhgH6RlibZHnFRMIpo6OBqyTcdd7YZKhfaaUU5mZtQ
        ShQxQenY3qvOmnBq4dxlg+YqwN2L8IfpUA==
X-Google-Smtp-Source: AGHT+IEX9tcaEEox552ONpzn3vErKFV+9ykd5SIaVw8mYX9EXMJzd9IainrzGm1kGv+e+XSSnlCjCQ==
X-Received: by 2002:a81:4402:0:b0:5a7:b1d9:70cb with SMTP id r2-20020a814402000000b005a7b1d970cbmr10123357ywa.2.1697121409247;
        Thu, 12 Oct 2023 07:36:49 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id v83-20020a814856000000b005a7d50b7edfsm1503222ywa.142.2023.10.12.07.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 07:36:47 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-59f6441215dso12712287b3.2;
        Thu, 12 Oct 2023 07:36:47 -0700 (PDT)
X-Received: by 2002:a0d:ce02:0:b0:59b:ec11:7734 with SMTP id
 q2-20020a0dce02000000b0059bec117734mr25998262ywd.39.1697121407643; Thu, 12
 Oct 2023 07:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231010132701.1658737-1-claudiu.beznea.uj@bp.renesas.com> <20231010132701.1658737-5-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20231010132701.1658737-5-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 12 Oct 2023 16:36:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW-m+ikzOiCqGaiofd0QG5BVuoMK+z6G7u2JboGTw3xhQ@mail.gmail.com>
Message-ID: <CAMuHMdW-m+ikzOiCqGaiofd0QG5BVuoMK+z6G7u2JboGTw3xhQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] arm64: dts: renesas: rzg3s-smarc-som: Enable SDHI2
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     magnus.damm@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

Thanks for your patch!

On Tue, Oct 10, 2023 at 3:27 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add SDHI2 to RZ/G3S Smarc SoM. SDHI2 pins are multiplexed with SCIF1, SSI3,

SSI0

> IRQ0. The selection b/w SDHI2 and SCIF1, SSI3, IRQ0 is done with a switch

and IRQ1 (twice). Or just say "The selection is done ...".

> button. To be able to select b/w these a compilation flag has been added
> (SW_SD2_EN) at the moment being instantiated to select SDHI2.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> @@ -13,14 +13,21 @@
>   * @SW_SD0_DEV_SEL:
>   *     0 - SD0 is connected to eMMC
>   *     1 - SD0 is connected to uSD0 card
> + * @SW_SD2_EN:
> + *     0 - SCIF1, SSI3, IRQ0, IRQ1 connected to SoC

SSI0

> + *     1 - SD2 is connected to SoC
>   */
>  #define SW_SD0_DEV_SEL 1
> +#define SW_SD2_EN      1

> @@ -100,6 +125,19 @@ &sdhi0 {
>  };
>  #endif
>
> +#if SW_SD2_EN
> +&sdhi2 {
> +       pinctrl-0 = <&sdhi2_pins>;
> +       pinctrl-1 = <&sdhi2_pins>;
> +       pinctrl-names = "default", "state_uhs";

Do you need two states if there is only a single voltage?
AFAIK, UHS needs 1.8V.

> +       vmmc-supply = <&vcc_sdhi2>;
> +       vqmmc-supply = <&reg_3p3v>;
> +       bus-width = <4>;
> +       max-frequency = <50000000>;
> +       status = "okay";
> +};
> +#endif
> +
>  &pinctrl {
>         sdhi0_pins: sd0 {
>                 data {

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
