Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F35751052
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 20:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjGLSLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 14:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjGLSLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 14:11:05 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2439D11B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:11:04 -0700 (PDT)
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C25F73F171
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 18:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689185462;
        bh=jZV4lxXU1ZB6Js3u/270T4FZAtmvDEeFk82+tjv5Ytg=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=k+dhtSXXEJf3TwV8UMej0Qy7H1jmmXmM2SgJiEaEx2ygj/Zv16HoFWaMDpSaK9nyy
         /+u3uJ/y/yT63x+/16hxibe3kYD5hTcZL0+MrqmzZcc1+0xDrX6qeHuI4xQSmRt2bK
         3iXWre/neluC+inZuf8TVDBM2QoyHnD9MWt5nYEGPCh4CYxJUCRzD9n+IM13SznXp+
         EmG4njcrJgVKP9gMkLvIpBpLCMuvhSBgXym9CCDZ2Dv3cRKPpW2AAwveLdfTSriNOx
         5lBIlVUX8Q3RldOV3R8zBIvAigUHj35tnBj0ijl55iFkK0a3W3KLQlWUtFEm6Gtvga
         6MuVRBAmlKUSw==
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7623a4864c2so948641785a.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689185462; x=1691777462;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jZV4lxXU1ZB6Js3u/270T4FZAtmvDEeFk82+tjv5Ytg=;
        b=lhb6kdQyeXYPGnlHLuI0fK9/dRkM2P3b1PyuDf4fQq9yBxbPLW6V9aDE3CRnfaP3XY
         OvWlT/BwfAW3Mra7cJ2+nzO3VR4aGN4RS8+NgvsY/BZrrPNoYEKXHN6Z3urpueYM9WXR
         2VkpDnuQ7cQw65q2+WqlhpTL8AgvloKlt2a2BCO6GlsdwhkuyrTt23jIONqptNKyYrT/
         0Br1lcfXDHuF38UfOj9XotT8gjNZTk8poMfgYvCl5KnNrb19tzPhrIuHatGTGUvfmYWi
         GgIZ789R796U4+QjGBfWerpCXiP4tnZNcD4qswoSy/IahRNixqIXi3uHc9RkT5bs2SSN
         0xxg==
X-Gm-Message-State: ABy/qLYOUO9VahzgAogjArSAcUzlYtNowbwjOBLsFqwGFvpreW3AikUI
        4tTN7X2jQlImtINRCk4VLr4hKBcz6OvErVO4jqxqEh6wiB9Bq/mEgbfgwGxAzJr05CsO4sSIFnl
        k2+T/2MPVmHeGfBXLTMFylT4MmjMVnJC6bUDJYWXjA/VA5gdO+ZGMn1tq9g==
X-Received: by 2002:a05:622a:144d:b0:403:b395:b3c0 with SMTP id v13-20020a05622a144d00b00403b395b3c0mr9913188qtx.3.1689185461751;
        Wed, 12 Jul 2023 11:11:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHEi6ZnXrU4jchYntQmVhlI+BbvJ58VQ34IJb9Ptwwjd3rb28kvuNYpTLkLgpIcX7In9qBHKfW1YR3dXyt8LFc=
X-Received: by 2002:a05:622a:144d:b0:403:b395:b3c0 with SMTP id
 v13-20020a05622a144d00b00403b395b3c0mr9913166qtx.3.1689185461476; Wed, 12 Jul
 2023 11:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230712092007.31013-1-xingyu.wu@starfivetech.com> <20230712092007.31013-9-xingyu.wu@starfivetech.com>
In-Reply-To: <20230712092007.31013-9-xingyu.wu@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 12 Jul 2023 20:10:45 +0200
Message-ID: <CAJM55Z_DVgYuLBXMb=_V5nmYDCGnzty2TCJ5FLwNXHFRdaVi4Q@mail.gmail.com>
Subject: Re: [PATCH v7 8/9] riscv: dts: starfive: jh7110: Add DVP and HDMI TX
 pixel external clocks
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023 at 11:22, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
>
> Add DVP and HDMI TX pixel external fixed clocks and the rates are
> 74.25MHz and 297MHz.
>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
>  .../dts/starfive/jh7110-starfive-visionfive-2.dtsi   |  8 ++++++++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi             | 12 ++++++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index fa0061eb33a7..de0f40a8be93 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -38,6 +38,10 @@ gpio-restart {
>         };
>  };
>
> +&dvp_clk {
> +       clock-frequency = <74250000>;
> +};
> +
>  &gmac0_rgmii_rxin {
>         clock-frequency = <125000000>;
>  };
> @@ -54,6 +58,10 @@ &gmac1_rmii_refin {
>         clock-frequency = <50000000>;
>  };
>
> +&hdmitx0_pixelclk {
> +       clock-frequency = <297000000>;
> +};
> +
>  &i2srx_bclk_ext {
>         clock-frequency = <12288000>;
>  };
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index ec2e70011a73..e9c1e4ad71a2 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -197,6 +197,12 @@ opp-1500000000 {
>                         };
>         };
>
> +       dvp_clk: dvp-clock {
> +               compatible = "fixed-clock";
> +               clock-output-names = "dvp_clk";
> +               #clock-cells = <0>;
> +       };
> +
>         gmac0_rgmii_rxin: gmac0-rgmii-rxin-clock {
>                 compatible = "fixed-clock";
>                 clock-output-names = "gmac0_rgmii_rxin";
> @@ -221,6 +227,12 @@ gmac1_rmii_refin: gmac1-rmii-refin-clock {
>                 #clock-cells = <0>;
>         };
>
> +       hdmitx0_pixelclk: hdmitx0-pixel-clock {
> +               compatible = "fixed-clock";
> +               clock-output-names = "hdmitx0_pixelclk";
> +               #clock-cells = <0>;
> +       };
> +
>         i2srx_bclk_ext: i2srx-bclk-ext-clock {
>                 compatible = "fixed-clock";
>                 clock-output-names = "i2srx_bclk_ext";
> --
> 2.25.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
