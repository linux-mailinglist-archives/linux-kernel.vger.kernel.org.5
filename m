Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AD77E48BD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbjKGSvL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Nov 2023 13:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbjKGSvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:51:08 -0500
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC64299;
        Tue,  7 Nov 2023 10:51:06 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5a82f176860so72250917b3.1;
        Tue, 07 Nov 2023 10:51:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699383065; x=1699987865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zo2CIx1raepgvOnpR/3U87T9vjTq67Lepg+WhUeVktg=;
        b=c3jv4BMD3eFCmXRUCFuQR4wOfOGUhg2C0gNCMYWPIoWhqYi1N3IrAcOTSJmh4MOTEM
         aJvIpXMXfTI+7aN4oQsjDS1teevGTd1cL4Om4qyKIu90gaZn1RTlh1nsriYKZ0awTPr/
         CvSpTlYTpRm59knEX/m8p1A4hrpbvHb/DuDDPlMIVvHKxvW07lrlTyD/MAc3kB3ZCfwL
         ViQdDRX3LWMLItkOMlvwxSHD19bpNMb7ylqIPoX7H/JIVSbuuu5wuPZeOuOBwakia/c0
         /Y4r8574ff7yZXyRzp0TMMbkmP69VSqT6H3RoBBCfn+0c+7XlCRkXTUMjIAsTHuuri0U
         horw==
X-Gm-Message-State: AOJu0YySRk4OJ56OrUfOv9iW78aHri8fr1AqSR9PXf5hGWNSwgnnzQKc
        Co+FcH5Y0JO9bw09GKJaRyUjN7BQKjZiMw==
X-Google-Smtp-Source: AGHT+IEa3m70HLSR2443dJmQvoFAF6d3QbBgIpVtG1/pi5KU/4OOblVJ5w3bxxmVUjhnsb3n93cpkg==
X-Received: by 2002:a0d:ea43:0:b0:595:e1b:b978 with SMTP id t64-20020a0dea43000000b005950e1bb978mr14304338ywe.21.1699383065677;
        Tue, 07 Nov 2023 10:51:05 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id v202-20020a8148d3000000b005a7bbd713ddsm5860358ywa.108.2023.11.07.10.51.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 10:51:05 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5a81ab75f21so72211987b3.2;
        Tue, 07 Nov 2023 10:51:05 -0800 (PST)
X-Received: by 2002:a0d:ebc5:0:b0:5a7:aa54:42b1 with SMTP id
 u188-20020a0debc5000000b005a7aa5442b1mr14354385ywe.28.1699383064754; Tue, 07
 Nov 2023 10:51:04 -0800 (PST)
MIME-Version: 1.0
References: <20231107121837.3759358-1-sashal@kernel.org> <20231107121837.3759358-34-sashal@kernel.org>
In-Reply-To: <20231107121837.3759358-34-sashal@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Nov 2023 19:50:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXWBzM41KjWCVRTmncJa=e2degFqXpRG0M7jE+s-Rkysw@mail.gmail.com>
Message-ID: <CAMuHMdXWBzM41KjWCVRTmncJa=e2degFqXpRG0M7jE+s-Rkysw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.6 34/40] arm64: dts: renesas: r8a779f0: spider:
 Enable PCIe Host ch0
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        magnus.damm@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha,

On Tue, Nov 7, 2023 at 1:21 PM Sasha Levin <sashal@kernel.org> wrote:
> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>
> [ Upstream commit c588e1c9846b32182fd5a0ceb637b983810e7100 ]
>
> Enable PCIe Host controller channel 0 on R-Car S4-8 Spider board.
>
> Since this board has an Oculink connector, CLKREQ# pin of PFC for PCIe
> should not be used. So, using a GPIO is used to output the clock instead.
> Otherwise the controller cannot detect a PCIe device.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link: https://lore.kernel.org/r/20230905012404.2915246-3-yoshihiro.shimoda.uh@renesas.com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r8a779f0-spider-cpu.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a779f0-spider-cpu.dtsi

> @@ -145,6 +157,18 @@ &mmc0 {
>         status = "okay";
>  };
>
> +&pcie0_clkref {
> +       compatible = "gpio-gate-clock";
> +       clocks = <&rc21012_pci>;
> +       enable-gpios = <&gpio2 15 GPIO_ACTIVE_LOW>;
> +       /delete-property/ clock-frequency;
> +};
> +
> +&pciec0 {
> +       reset-gpio = <&gpio_exp_20 0 GPIO_ACTIVE_LOW>;
> +       status = "okay";
> +};
> +
>  &pfc {
>         pinctrl-0 = <&scif_clk_pins>;
>         pinctrl-names = "default";

These references have a hard dependency on commit 183a709d3719e5c9
("arm64: dts: renesas: r8a779f0: Add PCIe Host and Endpoint nodes")
in v6.6+ (i.e. v6.7-rc1 soon).

To actually work, this has a soft (runtime) dependency on commit
0d0c551011df4519 ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller
support for host mode") in v6.6+.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
