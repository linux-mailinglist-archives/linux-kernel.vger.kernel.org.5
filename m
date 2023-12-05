Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AB080569C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345558AbjLEN4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345523AbjLEN4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:56:53 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E652512C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:56:57 -0800 (PST)
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 341D83F65A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 13:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701784616;
        bh=IiRXF4n/93v5Ug5hjoOSvZlervZ246QbgRyu0qVcQa4=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=a6lbRkIL85HyTMX4ah6v0+WPNEH3DSlKOsftq1C6xOd/L0WlHBqYFUODkzGXSwAwt
         YUO8Spt8L2B1mDPdB6I/Y+O37F4e77gZH1jJObr1n9gSOSCM5QaTjpFLpNtQG0jYiV
         rD7YbPbF9jFV8z7c9EArC03TIZa+fBK+hniQUq3hRkHGs4i8V6/u0SsJwlebOieIak
         yzLyz/7dhD+IvneyfrpgnqvvvKHW3u4ZwdL6sITFv0bmn8kq9lCnRcE+MuWv0zFHzn
         Y8p0whDNI+jWVKTwkllYiWbBWtbl4WUWX1DZ/X2SnkDQyL1E4dM/1z1zXhSZg93kps
         6EbaF7+803gpA==
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-67ab1ce51b7so44339506d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 05:56:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701784615; x=1702389415;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IiRXF4n/93v5Ug5hjoOSvZlervZ246QbgRyu0qVcQa4=;
        b=tCBgFTciu4s9q8jSzqZ6wSJrrOcllIa9e3Tc6KANF5Gq+UD4bnv7fSdevNmMyTxbvR
         sGoySaHFio2mRcqiAzg/GCWifWB17El5rCLZf/4mhEGFY2XQjLQSZPIou219QdRjS07C
         1N5UJytVe/TqM2aqHE+stH1LQZsCjG047KQxDPwMmbflYXd0MlsUOZkbu4GAUdCukr41
         DgH5rfl3vX0pbosuvSspYsKjd9SgMGv8055Lb/e0bfjY9hvNtaUchPz/cJstXGe92PzX
         RtcXYYmkFg7CUwdtR55A5N+g0zLoTkyBk7dpMMYXAePRRZn/GhvbNzrcMG8scVeLURYs
         INBg==
X-Gm-Message-State: AOJu0YxivyxxWDvdK2yf1FkN5DgZYXY1a8M/AUx3qMcOdX0J8572yDwC
        oA/RgEwthZvxddtZIw8UbaHKLwLB49xhNkbtHKI4yg5Lgr04udeF6JYdPPjQWB3ih8/5jc+HMN2
        T2BITlLbIub7LUkp4WKE9cD1mWv6ZNPIuiRV8A3ELwkUyXY/zgMf1gMoOPw==
X-Received: by 2002:ad4:4486:0:b0:67a:a721:f30f with SMTP id m6-20020ad44486000000b0067aa721f30fmr1465513qvt.79.1701784615274;
        Tue, 05 Dec 2023 05:56:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErR1wXH/GabDZKXesdKBFPnJz7SeypeN/oGzxkp5WIwT9bEBYm1KaRkIO2O9CcQbAKZYRddKnzH6OnMewqq8I=
X-Received: by 2002:ad4:4486:0:b0:67a:a721:f30f with SMTP id
 m6-20020ad44486000000b0067aa721f30fmr1465497qvt.79.1701784615073; Tue, 05 Dec
 2023 05:56:55 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 5 Dec 2023 05:56:54 -0800
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <IA1PR20MB4953EBF14C9CA436760B2A58BB85A@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49532E1A3D8BA71FDBB444BCBB85A@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953EBF14C9CA436760B2A58BB85A@IA1PR20MB4953.namprd20.prod.outlook.com>
Mime-Version: 1.0
Date:   Tue, 5 Dec 2023 05:56:54 -0800
Message-ID: <CAJM55Z8DU_OPJOYqT28wtH9EGFj=y9VVPcawOnYjY=U75pt2vg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] riscv: dts: sophgo: add uart clock for Sophgo
 CV1800 series SoC
To:     Inochi Amaoto <inochiama@outlook.com>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Jisheng Zhang <jszhang@kernel.org>, qiujingbao.dlmu@gmail.com,
        dlan@gentoo.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inochi Amaoto wrote:
> Add missing clocks of uart node for CV1800B and CV1812H.
>
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> ---
>  arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> index c5642dd7cbbd..3f290a515011 100644
> --- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> @@ -5,6 +5,7 @@
>   */
>
>  #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/clock/sophgo,cv1800.h>
>
>  / {
>  	#address-cells = <1>;
> @@ -136,7 +137,9 @@ uart0: serial@4140000 {
>  			compatible = "snps,dw-apb-uart";
>  			reg = <0x04140000 0x100>;
>  			interrupts = <44 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&osc>;
> +			clock-frequency = <25000000>;
> +			clocks = <&clk CLK_UART0>, <&clk CLK_APB_UART0>;
> +			clock-names = "baudclk", "apb_pclk";
>  			reg-shift = <2>;
>  			reg-io-width = <4>;
>  			status = "disabled";

Hi Inochi,

When there is a proper "baudclk" defined the driver should get the rate
(frequency) from that and the manually defined clock-frequency should not be
needed.

/Emil
