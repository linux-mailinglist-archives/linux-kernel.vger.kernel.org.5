Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CD57F6E13
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344684AbjKXI1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 03:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKXI1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:27:41 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533CDD4E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 00:27:46 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a00b01955acso234702566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 00:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700814465; x=1701419265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f5z4R+/uebh0H8kwZbipC142tI6MNEmnzXMKVJSCviE=;
        b=T/yZ/9VM3gFy2iZelGPh79mqsR2bLTLRqGVZG4+LpBxFMEWcfk+jlmQApxTswMzJ9J
         lY/DGn7wqguMQ//K4ESlRAynuUckQBVDneXFVBF+luqGfa+FYDF41xuDXO/Pc8KT9hcp
         EDNvsKuOVfXQNSYGXqVaRJ+f7AQSHCp0HFj2QyFa13D9F4RSGLthlj3gcRi+nPmDK4u6
         9txa3QYykiRAq1VzOQ+lYnE3JSEHqieK1eRh5soQ8OET+zFuhzTjU8ZAPbMmToxY/wv1
         8D4LaV3Zazdks2SQlIrNi5KK0tasjl+b3gJpFNlfEcFRwpiNz4tVwj0olbCkqiswo+p/
         YUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700814465; x=1701419265;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f5z4R+/uebh0H8kwZbipC142tI6MNEmnzXMKVJSCviE=;
        b=szwQl1Afy8QfDmfqlCkmXJDFegTYeh8Y5xgNXDaxa84RX6POEJQyt6xjaXxG7z9K7E
         auzdSc9HEW8lqCBzWgUSlTXKX8EMUpud1rU4+XCKXQO1dsAqEzgQ35HOr3JegXP798MZ
         6MkVX8DMaTDulOlsaDBdIY1s9spllUhbzaUk4vTOqbt1BctA3ITBJuRc/Xymxahd1KSs
         BLBMlbBam+P2RBGCVPB9tmm1ixsii68dC+3gH3sRSffLYfNbwK5+h+JhyzHr92hEBejQ
         uoTK10fyuWZM0NMcqVohZPsT8PmxAfG64TnziORDhrx+4ZXxbEKn40Y0IjduiWPCheFo
         OO0w==
X-Gm-Message-State: AOJu0YwSd8LlrddoGJ/sCGmT53QZC2G2iJHv6zBNNG83waf6OO3vu9Zg
        QPJHwM0y9YaY3yc6wx9ll6P8cQ==
X-Google-Smtp-Source: AGHT+IG8Cald1MJmAYnUL5rrZ5j3GsAkBmSpYI9i8bSwtQpqyBsgVgkguxYQiCLF6hkeQEx8/5z4XQ==
X-Received: by 2002:a17:906:3418:b0:a03:a411:abcb with SMTP id c24-20020a170906341800b00a03a411abcbmr1343935ejb.39.1700814464781;
        Fri, 24 Nov 2023 00:27:44 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id ks20-20020a170906f85400b009db53aa4f7bsm1772489ejb.28.2023.11.24.00.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 00:27:44 -0800 (PST)
Message-ID: <46bba00c-00b7-46db-984c-4391f7fc11f6@linaro.org>
Date:   Fri, 24 Nov 2023 09:27:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/21] MIPS: mobileye: Add EyeQ5 dtsi
Content-Language: en-US
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20231123152639.561231-1-gregory.clement@bootlin.com>
 <20231123152639.561231-19-gregory.clement@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231123152639.561231-19-gregory.clement@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2023 16:26, Gregory CLEMENT wrote:
> Add a device tree include file for the Mobileye EyeQ5 SoC.
> 
> Based on the work of Slava Samsonov <stanislav.samsonov@intel.com>
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---


> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +	};
> +
> +	cpu_intc: interrupt-controller {
> +		compatible = "mti,cpu-interrupt-controller";
> +		interrupt-controller;
> +		#address-cells = <0>;
> +		#interrupt-cells = <1>;
> +	};
> +
> +	gic: interrupt-controller@140000 {

Why do you put MMIO nodes in top-level?

> +		compatible = "mti,gic";
> +		reg = <0x0 0x140000 0x0 0x20000>;
> +		interrupt-controller;
> +		#interrupt-cells = <3>;
> +
> +		/*
> +		* Declare the interrupt-parent even though the mti,gic
> +		* binding doesn't require it, such that the kernel can
> +		* figure out that cpu_intc is the root interrupt
> +		* controller & should be probed first.
> +		*/
> +		interrupt-parent = <&cpu_intc>;
> +
> +		timer {
> +			compatible = "mti,gic-timer";
> +			interrupts = <GIC_LOCAL 1 IRQ_TYPE_NONE>;
> +			clocks = <&core0_clk>;
> +		};
> +	};
> +
> +	soc: soc {

Are you sure dtbs_check W=1 does not complain? I think you miss here
address.

> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +		compatible = "simple-bus";
> +
> +		uart0: serial@800000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0 0x800000 0x0 0x1000>;
> +			reg-io-width = <4>;
> +			interrupt-parent = <&gic>;
> +			interrupts = <GIC_SHARED 6 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks  = <&uart_clk>, <&occ_periph>;
> +			clock-names = "uartclk", "apb_pclk";
> +		};
> +
> +		uart1: serial@900000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0 0x900000 0x0 0x1000>;
> +			reg-io-width = <4>;
> +			interrupt-parent = <&gic>;
> +			interrupts = <GIC_SHARED 6 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks  = <&uart_clk>, <&occ_periph>;
> +			clock-names = "uartclk", "apb_pclk";
> +		};
> +
> +		uart2: serial@a00000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0 0xa00000 0x0 0x1000>;
> +			reg-io-width = <4>;
> +			interrupt-parent = <&gic>;
> +			interrupts = <GIC_SHARED 6 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks  = <&uart_clk>, <&occ_periph>;
> +			clock-names = "uartclk", "apb_pclk";
> +		};
> +
> +		olb: olb@e00000 {
> +			compatible = "mobileye,eyeq5-olb", "syscon", "simple-mfd";
> +			reg = <0 0xe00000 0x0 0x400>;
> +			reg-io-width = <4>;
> +		};
> +

Stray blank line.

> +	};
> +};

Best regards,
Krzysztof

