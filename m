Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4EA811FB5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 21:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442343AbjLMUJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 15:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjLMUJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 15:09:30 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442F2D0;
        Wed, 13 Dec 2023 12:09:36 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c32df9174so65428445e9.3;
        Wed, 13 Dec 2023 12:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702498175; x=1703102975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1E00I7csYet+h6d3hCBs5SooYMP4Ja6qAuEnzWpbHw=;
        b=VYUv45Ldy9gfsQrnarg2tdD2zgLdFl/NH/GkrwAo8VsPOziIIrYMlPiIN5BqMKmyUR
         17PFPJId2W313bDp4ttHgymIhV9gyJ6lBY19XhqrF8J+cA6z4FzKSyYZk+TxrTb0gDO7
         JtpMLCjuId9D8EwVuL64VA7Aapk3AX0e7X2bx6UCiBWPG/7o85UNYTzvZGXAObzaxGff
         prmHNm/0GDaRGg39RQS0iixfWY3SgOTHSoGRydkyitUiGnZsKOtJ0b3V+RzzaOdTVBmm
         R215jnxcnmlsLWkcjarUYrYALc2OJPuvmG8Y8jGNsmeCmKv5EJNkClyzDKJp9KvvkehJ
         0qwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702498175; x=1703102975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1E00I7csYet+h6d3hCBs5SooYMP4Ja6qAuEnzWpbHw=;
        b=tYLoIr9DfmaYByYs8sXEEI45q/C2bACQwHzMqfRf0Wr3cT2WIRA5oX7UE4x3q3MrJa
         YcS9yj1ttr5IWVWKZ9a04orXkh9ta07N5aiCn+GlNYLSMWW4SFEIasLiRDw4tuqQp+RN
         JU+z/F1LZp8j1e+zg0XMQZDovvsbkQgxqF9ZpZSiVYz7Fkr5XR3bdkDKrRIuaKo18GkX
         xs8ndP0jPoq51aVuYZ//DYFKvP16cwSxP1LpGllEzYL+er34kl9o9/yUabE6etbW7iMM
         M8kaO7hWElp5WBKkFwEtWPUcaq4MVCxMzoog5STBWqGCdVHj5E/PMSaWXvK7cAgBXlko
         Bkxw==
X-Gm-Message-State: AOJu0Yw6xsIUg3w08Scuem+ZwXvvo1XWSm0cDfkqaZIAgFRDdQ2OlpUY
        /ZoGqZSUT4mX1iIK1iI9MGPAjtfyzuA=
X-Google-Smtp-Source: AGHT+IGgnj9gSAhJ/otmBIdrNYjW6wgF/y7XkF5VoE4tuaeCabEiVYTrQgIZsnFDgtnuMk+zMFilUw==
X-Received: by 2002:a7b:c419:0:b0:40b:2a3e:4c9b with SMTP id k25-20020a7bc419000000b0040b2a3e4c9bmr3183581wmi.29.1702498174346;
        Wed, 13 Dec 2023 12:09:34 -0800 (PST)
Received: from archlinux.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c468800b0040c488e4fb5sm11794611wmo.40.2023.12.13.12.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 12:09:34 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v7 4/7] ARM: dts: sun8i: v3s: Add support for the ISP
Date:   Wed, 13 Dec 2023 21:09:32 +0100
Message-ID: <3267480.aeNJFYEL58@archlinux>
In-Reply-To: <20231122141426.329694-5-paul.kocialkowski@bootlin.com>
References: <20231122141426.329694-1-paul.kocialkowski@bootlin.com>
 <20231122141426.329694-5-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, November 22, 2023 3:14:22 PM CET Paul Kocialkowski wrote:
> The V3s (and related platforms) come with an instance of the A31 ISP.
> Even though it is very close to the A31 ISP, it is not exactly
> register-compatible and a dedicated compatible only is used as a
> result.
> 
> Just like most other blocks of the camera pipeline, the ISP uses
> the common CSI bus, module and ram clock as well as reset.
> 
> A port connection to the ISP is added to CSI0 for convenience since
> CSI0 serves for MIPI CSI-2 interface support, which is likely to
> receive raw data that will need to be processed by the ISP to produce
> a final image.
> 
> The interconnects property is used to inherit the proper DMA offset.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  arch/arm/boot/dts/allwinner/sun8i-v3s.dtsi | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/allwinner/sun8i-v3s.dtsi b/arch/arm/boot/dts/allwinner/sun8i-v3s.dtsi
> index d57612023aa4..1a1dcd36cba4 100644
> --- a/arch/arm/boot/dts/allwinner/sun8i-v3s.dtsi
> +++ b/arch/arm/boot/dts/allwinner/sun8i-v3s.dtsi
> @@ -645,6 +645,14 @@ csi0_in_mipi_csi2: endpoint {
>  						remote-endpoint = <&mipi_csi2_out_csi0>;
>  					};
>  				};
> +
> +				port@2 {
> +					reg = <2>;
> +
> +					csi0_out_isp: endpoint {
> +						remote-endpoint = <&isp_in_csi0>;
> +					};
> +				};
>  			};
>  		};
>  
> @@ -703,5 +711,32 @@ csi1: camera@1cb4000 {
>  			resets = <&ccu RST_BUS_CSI>;
>  			status = "disabled";
>  		};
> +
> +		isp: isp@1cb8000 {
> +			compatible = "allwinner,sun8i-v3s-isp";
> +			reg = <0x01cb8000 0x1000>;
> +			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_CSI>,
> +				 <&ccu CLK_CSI1_SCLK>,
> +				 <&ccu CLK_DRAM_CSI>;
> +			clock-names = "bus", "mod", "ram";
> +			resets = <&ccu RST_BUS_CSI>;
> +			interconnects = <&mbus 5>;
> +			interconnect-names = "dma-mem";

Same as in previous patch, interconnects properties are not described in
bindings, please update.

Best regards,
Jernej

> +			status = "disabled";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					isp_in_csi0: endpoint {
> +						remote-endpoint = <&csi0_out_isp>;
> +					};
> +				};
> +			};
> +		};
>  	};
>  };
> 




