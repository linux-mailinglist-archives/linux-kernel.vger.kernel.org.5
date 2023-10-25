Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EE77D6D6E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 15:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbjJYNik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbjJYNii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:38:38 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CD6132
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 06:38:36 -0700 (PDT)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 93E82420B2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698241113;
        bh=4kZetE1rdZ7P5Qi3G+jzZsycI0EzhJ2peFQaOTjHG8s=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=iSQMAyYZnMyLp1VgKQKvTQoS/26q980nZkF+gJtE1voTEVXcFaTFaejRkex0nd4U2
         fZOVOzFpwb7wLO8smMVOIdNSlWq4QUu5TQ8vJLuPLNHKCqOikgGs+9Zh9ExJcWDPix
         B5EoXs2hfDu9c0P748KUcG6TQIOOESyen1trcaEx9Dn6luPrCnQJs36rqXwbvgcNOg
         pz+f06a4Rnt1SrA1z4FYbCm0OoKGfIRk4RMvyF98f1ShsP51XkxorVKje3lFRdKwA+
         mE3SRuCsauPX3zRmHLiOnlMhppFJj6DhLsh4TnbKe+gotbuUOtNjhhHtea4agKzWo1
         XFZhodSXgrwAw==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1c9c83b656fso48953905ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 06:38:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698241111; x=1698845911;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4kZetE1rdZ7P5Qi3G+jzZsycI0EzhJ2peFQaOTjHG8s=;
        b=Dq+ITjOrlaK+i2eE2OwxVFHCiFQ/U8993Jn3PDr9b6wrDwnsI/85QFpGiKpbFeoGKp
         Mh2qHSvkxV5rDyzuoOs/p5/5Xogwe5BoLpAiFbK8P144Wx8KSZHWliIjTaepAnGXKV3F
         SFpbhTXS45va+y1lpFMEA8AsGMYz4pF8sdw3KUhNKV8KLkVmmhUvAhzPEQpgXhgOV4Ko
         CJOd4wDe5R6WnUCBS7SpulYOgvxgV46YMKjQU/6qDek4J6RX2YA0sUjQ0w9NI/c5s69h
         zAuVxeFkRO7QRLAebB2lcnXAZmTafUwnA9c2PwOoUnZeyHvasCj++howU71vNdN2h8YX
         ipHA==
X-Gm-Message-State: AOJu0YxV6TcpxOXDe9rZKkjfMAVCz6yiQ3rRUa1K/bIQqNFiBRkWN+Xa
        MZ+qfwegRiU3xPQAAcsyibAvXzctVrjHds/UQ788I2x/RF1hNpZ+IOj87ohxVh6gBkXqtH5my0k
        AmWK04lne0G2wYzKenjPbiSsFSaIO+DxLVzNC6FtUPIq1m8dsLRCiO6Pf0Q==
X-Received: by 2002:a05:622a:1b9f:b0:417:bd2c:2683 with SMTP id bp31-20020a05622a1b9f00b00417bd2c2683mr16970910qtb.19.1698241090311;
        Wed, 25 Oct 2023 06:38:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9sqk9O9NSffONLMLkF62MheH44KULbbJziO/VE+15eqK7tXOWni0WrQFzdn8ozLKmF0Jvc5dWLHw93tWI6nk=
X-Received: by 2002:a05:622a:1b9f:b0:417:bd2c:2683 with SMTP id
 bp31-20020a05622a1b9f00b00417bd2c2683mr16970883qtb.19.1698241090030; Wed, 25
 Oct 2023 06:38:10 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Oct 2023 06:38:09 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231025103957.3776-3-keith.zhao@starfivetech.com>
References: <20231025103957.3776-1-keith.zhao@starfivetech.com> <20231025103957.3776-3-keith.zhao@starfivetech.com>
Mime-Version: 1.0
Date:   Wed, 25 Oct 2023 06:38:09 -0700
Message-ID: <CAJM55Z_Y_qp0J5FmWDPdziCRY7duNBhHnvM0Zza2pG-vK0etbw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] riscv: dts: starfive: jh7110: add dc controller
 and hdmi node
To:     Keith Zhao <keith.zhao@starfivetech.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        christian.koenig@amd.com, Bjorn Andersson <andersson@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>, Jagan Teki <jagan@edgeble.ai>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Shengyang Chen <shengyang.chen@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Zhao wrote:
> Add the dc controller and hdmi node for the Starfive JH7110 SoC.
>
> Signed-off-by: Keith Zhao <keith.zhao@starfivetech.com>
> ---
>  .../jh7110-starfive-visionfive-2.dtsi         | 91 +++++++++++++++++++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 41 +++++++++
>  2 files changed, 132 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index de0f40a8b..97909b6d2 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -31,6 +31,25 @@ memory@40000000 {
>  		reg = <0x0 0x40000000 0x1 0x0>;
>  	};
>
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		/* vout applies for space from this CMA
> +		 * Without this CMA reservation,
> +		 * vout may not work properly.
> +		 */
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			reusable;
> +			size = <0x0 0x20000000>;
> +			alignment = <0x0 0x1000>;
> +			alloc-ranges = <0x0 0x70000000 0x0 0x20000000>;
> +			linux,cma-default;
> +		};
> +	};
> +
>  	gpio-restart {
>  		compatible = "gpio-restart";
>  		gpios = <&sysgpio 35 GPIO_ACTIVE_HIGH>;
> @@ -231,6 +250,41 @@ GPOEN_DISABLE,
>  			slew-rate = <0>;
>  		};
>  	};
> +
> +	hdmi_pins: hdmi-0 {
> +		hdmi-scl-pins {
> +			pinmux = <GPIOMUX(0, GPOUT_SYS_HDMI_DDC_SCL,
> +					     GPOEN_SYS_HDMI_DDC_SCL,
> +					     GPI_SYS_HDMI_DDC_SCL)>;
> +			input-enable;
> +			bias-pull-up;
> +		};
> +
> +		hdmi-sda-pins {
> +			pinmux = <GPIOMUX(1, GPOUT_SYS_HDMI_DDC_SDA,
> +					     GPOEN_SYS_HDMI_DDC_SDA,
> +					     GPI_SYS_HDMI_DDC_SDA)>;
> +			input-enable;
> +			bias-pull-up;
> +		};
> +
> +		hdmi-cec-pins {
> +			pinmux = <GPIOMUX(14, GPOUT_SYS_HDMI_CEC_SDA,
> +					     GPOEN_SYS_HDMI_CEC_SDA,
> +					     GPI_SYS_HDMI_CEC_SDA)>;
> +			input-enable;
> +			bias-pull-up;
> +		};
> +
> +		hdmi-hpd-pins {
> +			pinmux = <GPIOMUX(15, GPOUT_HIGH,
> +					     GPOEN_ENABLE,
> +					     GPI_SYS_HDMI_HPD)>;
> +			input-enable;
> +			bias-disable; /* external pull-up */
> +		};
> +	};
> +

Please don't break the alphabetical ordering of these nodes.

>  };
>
>  &uart0 {
> @@ -254,3 +308,40 @@ &U74_3 {
>  &U74_4 {
>  	cpu-supply = <&vdd_cpu>;
>  };
> +
> +&voutcrg {
> +	status = "okay";
> +};
> +
> +&display {
> +	status = "okay";
> +};
> +
> +&hdmi {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&hdmi_pins>;
> +
> +	hdmi_in: port {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		hdmi_in_dc: endpoint@0 {
> +			reg = <0>;
> +			remote-endpoint = <&dc_out_hdmi>;
> +		};
> +	};
> +};
> +
> +&dc8200 {
> +	status = "okay";
> +
> +	dc_out: port {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		dc_out_hdmi: endpoint@0 {
> +			reg = <0>;
> +			remote-endpoint = <&hdmi_in_dc>;
> +		};
> +
> +	};
> +};

Some goes for these node references. The order is /-node, clocks, node refences
sorted alphabetically.


> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index 0005fa163..1670452fb 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -282,6 +282,11 @@ tdm_ext: tdm-ext-clock {
>  		#clock-cells = <0>;
>  	};
>
> +	display: display-subsystem {
> +		compatible = "starfive,display-subsystem";
> +		ports = <&dc_out>;
> +	};
> +
>  	soc {
>  		compatible = "simple-bus";
>  		interrupt-parent = <&plic>;
> @@ -613,5 +618,41 @@ voutcrg: clock-controller@295c0000 {
>  			#reset-cells = <1>;
>  			power-domains = <&pwrc JH7110_PD_VOUT>;
>  		};
> +
> +		dc8200: lcd-controller@29400000 {
> +			compatible = "starfive,jh7110-dc8200";
> +			reg = <0x0 0x29400000 0x0 0x100>,
> +			      <0x0 0x29400800 0x0 0x2000>;
> +			interrupts = <95>;
> +			clocks = <&syscrg JH7110_SYSCLK_NOC_BUS_DISP_AXI>,
> +				<&voutcrg JH7110_VOUTCLK_DC8200_PIX0>,
> +				<&voutcrg JH7110_VOUTCLK_DC8200_PIX1>,
> +				<&voutcrg JH7110_VOUTCLK_DC8200_CORE>,
> +				<&voutcrg JH7110_VOUTCLK_DC8200_AXI>,
> +				<&voutcrg JH7110_VOUTCLK_DC8200_AHB>,
> +				<&hdmitx0_pixelclk>,
> +				<&voutcrg JH7110_VOUTCLK_DC8200_PIX>;
> +			clock-names = "noc_bus", "channel0", "channel1",
> +				      "dc_core", "axi_core", "ahb",
> +				      "hdmi_tx", "dc_parent";
> +			resets = <&voutcrg JH7110_VOUTRST_DC8200_AXI>,
> +				 <&voutcrg JH7110_VOUTRST_DC8200_AHB>,
> +				 <&voutcrg JH7110_VOUTRST_DC8200_CORE>;
> +			reset-names = "axi","ahb", "core";
> +		};
> +
> +		hdmi: hdmi@29590000 {
> +			compatible = "starfive,jh7110-inno-hdmi";
> +			reg = <0x0 0x29590000 0x0 0x4000>;
> +			interrupts = <99>;
> +
> +			clocks = <&voutcrg JH7110_VOUTCLK_HDMI_TX_SYS>,
> +				 <&voutcrg JH7110_VOUTCLK_HDMI_TX_MCLK>,
> +				 <&voutcrg JH7110_VOUTCLK_HDMI_TX_BCLK>,
> +				 <&hdmitx0_pixelclk>;
> +			clock-names = "sysclk", "mclk", "bclk", "pclk";
> +			resets = <&voutcrg JH7110_VOUTRST_HDMI_TX_HDMI>;
> +			#sound-dai-cells = <0>;
> +		};

These nodes, however, are sorted by their address which you alse break in this
patch :(

>  	};
>  };
> --
> 2.34.1
>
