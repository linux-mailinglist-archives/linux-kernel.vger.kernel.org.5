Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF047523A1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbjGMNYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235528AbjGMNXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:23:33 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0696A4236
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 06:22:36 -0700 (PDT)
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D5BB53F0C3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689254512;
        bh=enRX6hWC2iaemXY8CE1QlIdDJtfFUqCURuPciqCUAP8=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=qZY3YhuDCTtOSku0swNWMEKJuSxXPIh+eysklS9YSmT64SL++ITeP9rsw72MONVnO
         WHCZlCOKJCtNhw2htsQBsG/xVkjElQy+yVfuKeAuZpbt7OgY+Qx3Catc0KIDLarRBC
         jz/j5q36QlFPofB5IFwE5pusN3tu49lvBIBMQb0CUYzHWQKiEQWxJQthj9jUyMiqqx
         e1gbrNLiDaFybMeehxzww3B+1RMOFoIexFVgYc23FEYlpHm6Puk5GFIXiEdh+JyDN4
         NgzXOEj6BH2BwQSZctVtba7HZJjY67GFw2htQQFfSnq30u+QUT+6raQX7KXYHpUcmT
         ByLKYJcTFZs5A==
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-403b066c6e7so9512841cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 06:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689254512; x=1691846512;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=enRX6hWC2iaemXY8CE1QlIdDJtfFUqCURuPciqCUAP8=;
        b=aYnsKPcMnUG6JKFDAslDWH8NkekBft5CGazP01Ot+PHoXijs7674Fps07egfciDIqU
         I6sbBiCxNJI3kgBbykaP7BsGVnNEOLB6nEP6KqJInDos3cmI6FSt/rgE3mgxXxq0Puht
         z+m08junaYlVRKClqCeNb9oTxQje2QDtFS73WXi82NWkPqHhOVpoj0NoLaKODc2/+Wbj
         GRl1/xnwzNLvqKMST6nb2y4Ez9W3GyLtgxkDYpg7U1rn7gwQY9vxiVNCNaiXAnOJ0xio
         JSOR4d0GW7klwWUkgcCsM4+y6c7/K/mQ43s+qQrlr0cHyK6o3P/0SDA5Xaorb8fFaZms
         j4Yw==
X-Gm-Message-State: ABy/qLZh7HvUc1adui9eVMC6rBodhR21u58XynrUF2GgvhkQ7PYqCbfN
        zVS2YsvNPART1SmaVGW9csV52nD+msLLihH6I4HizjiNqcQHG1uuXAJpGKueT50xtTWMsRM0hfv
        DjPlhCqsRbPiPFA66w7b0fDnOxrbBuNVK1xHJ+wMs7IO0VJBEqna93H3l3w==
X-Received: by 2002:a05:622a:104a:b0:3ec:490b:ce6e with SMTP id f10-20020a05622a104a00b003ec490bce6emr2001180qte.48.1689254512001;
        Thu, 13 Jul 2023 06:21:52 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFJMIRJnzg3ozLNbx0GZublHY6dW4PSuFNYeS/2iDDTUQp4OX+srNMRFZPrJS2XCDeDowhX2Cfv7yQDvY2KNO0=
X-Received: by 2002:a05:622a:104a:b0:3ec:490b:ce6e with SMTP id
 f10-20020a05622a104a00b003ec490bce6emr2001156qte.48.1689254511797; Thu, 13
 Jul 2023 06:21:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230704064610.292603-1-xingyu.wu@starfivetech.com> <20230704064610.292603-7-xingyu.wu@starfivetech.com>
In-Reply-To: <20230704064610.292603-7-xingyu.wu@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Thu, 13 Jul 2023 15:21:35 +0200
Message-ID: <CAJM55Z8VequKy59P5zKrVOr7WPRbUqq4CUHrk8aDO+3qpkzm2Q@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 6/7] riscv: dts: starfive: jh7110: Add syscon nodes
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2023 at 08:49, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
>
> From: William Qiu <william.qiu@starfivetech.com>
>
> Add stg_syscon/sys_syscon/aon_syscon/PLL nodes for JH7110 SoC.
>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Co-developed-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index 4c5fdb905da8..11dd4c9d64b0 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -353,6 +353,11 @@ i2c2: i2c@10050000 {
>                         status = "disabled";
>                 };
>
> +               stg_syscon: syscon@10240000 {
> +                       compatible = "starfive,jh7110-stg-syscon", "syscon";
> +                       reg = <0x0 0x10240000 0x0 0x1000>;
> +               };
> +
>                 uart3: serial@12000000 {
>                         compatible = "snps,dw-apb-uart";
>                         reg = <0x0 0x12000000 0x0 0x10000>;
> @@ -457,6 +462,17 @@ syscrg: clock-controller@13020000 {
>                         #reset-cells = <1>;
>                 };
>
> +               sys_syscon: syscon@13030000 {
> +                       compatible = "starfive,jh7110-sys-syscon", "syscon", "simple-mfd";
> +                       reg = <0x0 0x13030000 0x0 0x1000>;
> +
> +                       pllclk: clock-controller {

Maybe call the handle "pll", so the references can be just <&pll 0>,
<&pll 1> and <&pll 2> if you choose to drop the JH7110_PLLCLK_PLL?_OUT
defines.

In any case:
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> +                               compatible = "starfive,jh7110-pll";
> +                               clocks = <&osc>;
> +                               #clock-cells = <1>;
> +                       };
> +               };
> +
>                 sysgpio: pinctrl@13040000 {
>                         compatible = "starfive,jh7110-sys-pinctrl";
>                         reg = <0x0 0x13040000 0x0 0x10000>;
> @@ -486,6 +502,12 @@ aoncrg: clock-controller@17000000 {
>                         #reset-cells = <1>;
>                 };
>
> +               aon_syscon: syscon@17010000 {
> +                       compatible = "starfive,jh7110-aon-syscon", "syscon";
> +                       reg = <0x0 0x17010000 0x0 0x1000>;
> +                       #power-domain-cells = <1>;
> +               };
> +
>                 aongpio: pinctrl@17020000 {
>                         compatible = "starfive,jh7110-aon-pinctrl";
>                         reg = <0x0 0x17020000 0x0 0x10000>;
> --
> 2.25.1
>
