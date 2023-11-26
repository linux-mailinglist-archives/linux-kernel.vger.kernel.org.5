Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E78D7F9573
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 22:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjKZVPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 16:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjKZVO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 16:14:59 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEC8102
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 13:15:05 -0800 (PST)
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id ABD1340C57
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701033304;
        bh=X6K8bPWubM7CP2uBLEzKZ5K58KMm2j9nc1xapYlq3qo=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Aub6WyT+CVJfY/3Sv4kYBukHCXcMrgFijXO6xugHkPg83xCnMczVi3lzkKu7xrFsX
         C6J3d/+8M6hntaqF9PnszipiFzrloIOYOuh2Yf+uqMYyk+3G/99xax+FAFidM0NGYE
         QlNIJ/EYsL8/Oicb8jKmo4F+bIZOtaVuZxdmFhEEcKRTJY8Q4klTxDDsHSqLwVdxsx
         Gg+a3b6f6Izdz32VUunLiqMMHjXUwD8qzEOdyFW0/ItOIDEJ9RLG6aa7uj3yxD2Dsm
         9yB5+XNMt1u/b9cH47tGNOEj5XVHPCpqL9fYaVD+tA8i+Vf65Ec2L4E+wWoF8CHbzb
         b82LKwYu86KcQ==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-41cca916954so48542711cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 13:15:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701033303; x=1701638103;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X6K8bPWubM7CP2uBLEzKZ5K58KMm2j9nc1xapYlq3qo=;
        b=aHFAC4xocll9Bo8KJD4UnO9sqjy04CsI7Bb/orbsX+zHFDoUgvAqAtjtlMRT/7CjiR
         NWz1vUyBbubInPnupLaht/4ltXHcWamzcLw+e60ZJ2IrOb+eAL8SOk8hLFjGjukqAtrm
         YkNHu6RPWON/VdSS6pB89zcQrFQcmdQbZmqFOWofFZQLLTEGZE+mEKwF6kkvhDJETIz+
         vo5/yq9CDqAurllkZc8bvi+E7xn8K6ZwKKpYlg6U5zYhDy+ZYMgmjsZkP4xaaaf5hTw1
         pYHBS2VeA9Bv7oZScXUGCl0AFJPUQCtd8xzsMkg8PoV8RAdsdrUDns9HuwHYgnbBjQUh
         fmZw==
X-Gm-Message-State: AOJu0YxNo1PEEQct35kIeBi7ohiQMnjtibiVLASHmfTDNjE0NGfQxv5q
        UnocNilcipBH32CO+2WPcwNjKLf28eZ4cp9pGld9mf2gbl25b0vkcM3IkKDmzAZ6IGZwZtUgdLN
        KmDYpWhYz32cQdPkDcJtSdHdrgu+6gVdvL2uvjLq7O1zX7fykU1hr6leojA==
X-Received: by 2002:a05:622a:4d1:b0:423:93ce:56a8 with SMTP id q17-20020a05622a04d100b0042393ce56a8mr9480175qtx.37.1701033303344;
        Sun, 26 Nov 2023 13:15:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvOe1/VcODkUu33j/9j5dbJoi16WUGuqQQy1j3aYZEMCOFUmi43jYGiMI7L4+bD3DEsgAlRyl8uU3g9zCAnrU=
X-Received: by 2002:a05:622a:4d1:b0:423:93ce:56a8 with SMTP id
 q17-20020a05622a04d100b0042393ce56a8mr9480140qtx.37.1701033303037; Sun, 26
 Nov 2023 13:15:03 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 26 Nov 2023 22:15:02 +0100
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231029042712.520010-10-cristian.ciocaltea@collabora.com>
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com> <20231029042712.520010-10-cristian.ciocaltea@collabora.com>
Mime-Version: 1.0
Date:   Sun, 26 Nov 2023 22:15:02 +0100
Message-ID: <CAJM55Z-1ibownJG-pEuUx5VvPfnuV0+kT-6Fo3VnVs2YycNEEg@mail.gmail.com>
Subject: Re: [PATCH v2 09/12] riscv: dts: starfive: jh7100: Add sysmain and
 gmac DT nodes
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cristian Ciocaltea wrote:
> Provide the sysmain and gmac DT nodes supporting the DWMAC found on the
> StarFive JH7100 SoC.
>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  arch/riscv/boot/dts/starfive/jh7100.dtsi | 36 ++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi b/arch/riscv/boot/dts/starfive/jh7100.dtsi
> index a8a5bb00b0d8..e8228e96d350 100644
> --- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
> @@ -179,6 +179,37 @@ plic: interrupt-controller@c000000 {
>  			riscv,ndev = <133>;
>  		};
>
> +		gmac: ethernet@10020000 {
> +			compatible = "starfive,jh7100-dwmac", "snps,dwmac";
> +			reg = <0x0 0x10020000 0x0 0x10000>;
> +			clocks = <&clkgen JH7100_CLK_GMAC_ROOT_DIV>,
> +				 <&clkgen JH7100_CLK_GMAC_AHB>,
> +				 <&clkgen JH7100_CLK_GMAC_PTP_REF>,
> +				 <&clkgen JH7100_CLK_GMAC_TX_INV>,
> +				 <&clkgen JH7100_CLK_GMAC_GTX>;
> +			clock-names = "stmmaceth", "pclk", "ptp_ref", "tx", "gtx";
> +			resets = <&rstgen JH7100_RSTN_GMAC_AHB>;
> +			reset-names = "ahb";
> +			interrupts = <6>, <7>;
> +			interrupt-names = "macirq", "eth_wake_irq";
> +			max-frame-size = <9000>;
> +			snps,multicast-filter-bins = <32>;
> +			snps,perfect-filter-entries = <128>;
> +			starfive,syscon = <&sysmain 0x70 0>;
> +			rx-fifo-depth = <32768>;
> +			tx-fifo-depth = <16384>;
> +			snps,axi-config = <&stmmac_axi_setup>;
> +			snps,fixed-burst;
> +			snps,force_thresh_dma_mode;
> +			status = "disabled";
> +
> +			stmmac_axi_setup: stmmac-axi-config {
> +				snps,wr_osr_lmt = <0xf>;
> +				snps,rd_osr_lmt = <0xf>;

As I also noted on the JH7110 patches these are not addresses or offsets but
limits eg. counting things, which makes a lot more sense in decimal for most
humans. But here you've changed them back to 0xf, why?

> +				snps,blen = <256 128 64 32 0 0 0>;
> +			};
> +		};
> +
>  		clkgen: clock-controller@11800000 {
>  			compatible = "starfive,jh7100-clkgen";
>  			reg = <0x0 0x11800000 0x0 0x10000>;
> @@ -193,6 +224,11 @@ rstgen: reset-controller@11840000 {
>  			#reset-cells = <1>;
>  		};
>
> +		sysmain: syscon@11850000 {
> +			compatible = "starfive,jh7100-sysmain", "syscon";
> +			reg = <0x0 0x11850000 0x0 0x10000>;
> +		};
> +
>  		i2c0: i2c@118b0000 {
>  			compatible = "snps,designware-i2c";
>  			reg = <0x0 0x118b0000 0x0 0x10000>;
> --
> 2.42.0
>
