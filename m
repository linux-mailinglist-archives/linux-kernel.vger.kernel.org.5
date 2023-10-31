Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EBB7DCF62
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344494AbjJaOir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjJaOip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:38:45 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07ADE4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:38:42 -0700 (PDT)
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1F77E4081E
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 14:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698763114;
        bh=au17QPiJsjAocXmUfByZs1Bf5AaxfhY0/xgh3nLmqCY=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=pkcgatLGruVrFC1KZkHbr6lflUuZja1M2cmhmghsFWfFexjXw8OjGNaIL7OLp0I0L
         KgWIM0hyWO4buQ0XPAsN3WolZsFwAE3tsuBCSkE1oDmIgq8ic16lu1Qy6JuAcO2gqk
         TB9iRAWX6bbiqzNcELxBXwLxeK+2oknpCkQRMKB7+fLxluVwWuudyHlNEiJdtDMQLP
         D/0Q2qWGTnVwj54PWGUYbBba2gBqY0uRqiCoIBZo2ln1p2YynHjIzOPaCQVwwib1QB
         zMBFvMy8m0pGC5eTEE2lj8n7LY/x25nRP6Gu9a1ZN9UQJJVKFYuyQZazOyvtuvUGQ0
         X8S+OeWOsv4pA==
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-670b675b2c5so38738836d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698763109; x=1699367909;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=au17QPiJsjAocXmUfByZs1Bf5AaxfhY0/xgh3nLmqCY=;
        b=QpoIboJfJ/2/lcm0X/CVw4jZIWS4kKaM+9vepxcuDLGkFTsoEprVTa4ynXhhk1C8em
         nXcjEUpZxa3WF0mInOePamJWwSrGllhx2xpxI1YOgUEwb+Ygxrk7HsZRAcAsarbGANbP
         Z/u5PD6NFVKahQgWdCDp1xI2a6U7Kohcv/C3lARitXMrrk836b0BLAzzRCRtUwxt+NTo
         7wSBibEoBhu5tIVAdgQGWvTjigndWl76LdlqjjcFkpZpRH3hJ+t+O7lLRWESXfV7TK2v
         CGtFcZLhtL2WX1uYnmVaGXc2HSof1BIQGprUlJ7zNbsia6hB6BkOYtRbUCy6/jD6YdmD
         uuQg==
X-Gm-Message-State: AOJu0YwUACVValQbNguHui4F/UZw8zuqsc6GgS2rkqAi22pXb0n8xes8
        0JxMAPSLMtqya3ODYtoUqg1musVnrX8QHi9jKHCUdSfa3X8EZnQEXt1AbdSpQtdQjz6DX4/iwgh
        Lqn5rfDvNfP6tmTlVVgEfDq7oZ8LdK06Ee9mF+0fMUA4arnfM0vfVKVAqqw==
X-Received: by 2002:a05:622a:1009:b0:419:7623:ef6c with SMTP id d9-20020a05622a100900b004197623ef6cmr16897769qte.60.1698763109679;
        Tue, 31 Oct 2023 07:38:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEManiQqpXLt0b01D3i/c6XioIV3LcDFDS3I/YsKWQWlnlDlbI16LCgriOnJiUp81AuiFuChC8BPHTNIdY05AA=
X-Received: by 2002:a05:622a:1009:b0:419:7623:ef6c with SMTP id
 d9-20020a05622a100900b004197623ef6cmr16897742qte.60.1698763109425; Tue, 31
 Oct 2023 07:38:29 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 31 Oct 2023 07:38:29 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231029042712.520010-8-cristian.ciocaltea@collabora.com>
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com> <20231029042712.520010-8-cristian.ciocaltea@collabora.com>
Mime-Version: 1.0
Date:   Tue, 31 Oct 2023 07:38:29 -0700
Message-ID: <CAJM55Z8D12XoRG4WGaf=PG0_yp7d_xk9EhOk7bnCKQRMok9eBA@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] riscv: dts: starfive: jh7100: Add ccache DT node
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Samin Guo <samin.guo@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cristian Ciocaltea wrote:
> Provide a DT node for the SiFive Composable Cache controller found on
> the StarFive JH7100 SoC.
>
> Note this is also used to support non-coherent DMA, via the
> sifive,cache-ops cache flushing operations.

This property is no longer needed:
https://lore.kernel.org/linux-riscv/20231031141444.53426-1-emil.renner.berthing@canonical.com/

Also it would be nice to mention that these nodes are copied from my
visionfive patches ;)

>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  arch/riscv/boot/dts/starfive/jh7100.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi b/arch/riscv/boot/dts/starfive/jh7100.dtsi
> index 06bb157ce111..a8a5bb00b0d8 100644
> --- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
> @@ -32,6 +32,7 @@ U74_0: cpu@0 {
>  			i-tlb-sets = <1>;
>  			i-tlb-size = <32>;
>  			mmu-type = "riscv,sv39";
> +			next-level-cache = <&ccache>;
>  			riscv,isa = "rv64imafdc";
>  			riscv,isa-base = "rv64i";
>  			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zicntr", "zicsr",
> @@ -60,6 +61,7 @@ U74_1: cpu@1 {
>  			i-tlb-sets = <1>;
>  			i-tlb-size = <32>;
>  			mmu-type = "riscv,sv39";
> +			next-level-cache = <&ccache>;
>  			riscv,isa = "rv64imafdc";
>  			riscv,isa-base = "rv64i";
>  			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zicntr", "zicsr",
> @@ -147,6 +149,18 @@ soc {
>  		dma-noncoherent;
>  		ranges;
>
> +		ccache: cache-controller@2010000 {
> +			compatible = "starfive,jh7100-ccache", "sifive,ccache0", "cache";
> +			reg = <0x0 0x2010000 0x0 0x1000>;
> +			interrupts = <128>, <130>, <131>, <129>;
> +			cache-block-size = <64>;
> +			cache-level = <2>;
> +			cache-sets = <2048>;
> +			cache-size = <2097152>;
> +			cache-unified;
> +			sifive,cache-ops;
> +		};
> +
>  		clint: clint@2000000 {
>  			compatible = "starfive,jh7100-clint", "sifive,clint0";
>  			reg = <0x0 0x2000000 0x0 0x10000>;
> --
> 2.42.0
>
