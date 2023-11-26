Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265BF7F922B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 11:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjKZK1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 05:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZK1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 05:27:19 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9D1F0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 02:27:25 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54b07ba599fso2160591a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 02:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700994443; x=1701599243; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pVGCdugKR2zaTd8xqnCBNZ6lxlpm/j0K5fW0qicxgT4=;
        b=ipmwFh3Y6CzosQE/myPb4FxCTouhr8T8HGKRqjTLuCLUpNmrC+r38mnSw5IVjPbUiY
         ADP2xCmIhs9R4Sg3TqtcqFc0hmUHCWy39jYkVWwHQIvtFkeLNshAycewoPQNKl/kW5nl
         7vm0tgQ0oqmqJvDzsIYmo1ZxEmlmhf45NKYJVWtSEKMz2ERZJbyTBe2F7lPmfGcv1CB0
         raKiLWTMpeIYpO+5WNpZbzo0Z5GKc4+1UmJcdPgkiJCC37Tvtmnho6PU891rdQT/usGO
         vCfrWBTRYkdS18++uOpjnit6j2Es3B/+pSNEYSualnXstpLbQ08JkK4oykCw7pH2VHbf
         kMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700994443; x=1701599243;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVGCdugKR2zaTd8xqnCBNZ6lxlpm/j0K5fW0qicxgT4=;
        b=mNoHJpFZATe9B6akNfwZIXrktVi06RSOkHF2CqBa+POBYV0x8SUCCTFH7NbV9mFmQd
         KBGIT4nC1o83SVwasggM1tMR2Xxa6V7pssigPGkzPECuG+3vwq3pW5lq1qhBjbWOVwVJ
         TUfO9uDUW+HzW62pxvX9Lsx9DxAg6C8woZ6rgKW9y1HToTCoRMNFQ4khd7NfZJJaelrF
         oaBhqTXmb+wOL9qwUJWckIJvoaqTw8L/VkS40xxB0/rMLQMfXjjcci9o+XZo2vzdenjF
         BFnv/zuXmKnOk1OQATcJA9Sfy4r4Mo7keFWBRPsDKu25AvzZ8Ya3DnXZ/Tcz2ny4NPZa
         UwZg==
X-Gm-Message-State: AOJu0YyGhTs4oUIOWsNKfol/a9q5yanDWtcJ4LGtSOsZ+94u5C0Z/kPJ
        y8/me1O7tq5bBJWAuTHfoyo5Z+e8DHALadPxeQE=
X-Google-Smtp-Source: AGHT+IFlyfACKSOXgfPCa0POOqv0Lf0fSeJPvWIaX7QOWDlGpFb982/4lklA15JVP2cNkGVCOuiTlQ==
X-Received: by 2002:a17:906:290:b0:9e6:18fe:7447 with SMTP id 16-20020a170906029000b009e618fe7447mr5737574ejf.9.1700994443065;
        Sun, 26 Nov 2023 02:27:23 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id hz19-20020a1709072cf300b009a168ab6ee2sm4381068ejc.164.2023.11.26.02.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Nov 2023 02:27:22 -0800 (PST)
Message-ID: <ef4eda2a-4be5-4992-a315-d02e1a36b656@linaro.org>
Date:   Sun, 26 Nov 2023 11:27:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: dts: starfive: add Milkv Mars board device tree
To:     Jisheng Zhang <jszhang@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20231126100055.1595-1-jszhang@kernel.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231126100055.1595-1-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/2023 11:00, Jisheng Zhang wrote:
> The Milkv Mars is a development board based on the Starfive JH7110 SoC.
> The board features:
> 
> - JH7110 SoC
> - 1/2/4/8 GiB LPDDR4 DRAM
> - AXP15060 PMIC
> - 40 pin GPIO header
> - 3x USB 3.0 host port
> - 1x USB 2.0 host port
> - 1x M.2 E-Key
> - 1x eMMC slot
> - 1x MicroSD slot
> - 1x QSPI Flash
> - 1x 1Gbps Ethernet port
> - 1x HDMI port
> - 1x 2-lane DSI and 1x 4-lane DSI
> - 1x 2-lane CSI
> 
> Add the devicetree file describing the currently supported features,
> namely PMIC, UART, SD card, QSPI Flash, eMMC and Ethernet.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/boot/dts/starfive/Makefile         |   2 +
>  .../boot/dts/starfive/jh7110-milkv-mars.dts   | 634 ++++++++++++++++++
>  2 files changed, 636 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
> 
> diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
> index 0141504c0f5c..fe0a62cc4759 100644
> --- a/arch/riscv/boot/dts/starfive/Makefile
> +++ b/arch/riscv/boot/dts/starfive/Makefile
> @@ -10,3 +10,5 @@ dtb-$(CONFIG_ARCH_STARFIVE) += jh7100-starfive-visionfive-v1.dtb
>  
>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.2a.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.3b.dtb
> +
> +dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-mars.dtb
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
> new file mode 100644
> index 000000000000..41cc67f53bbe
> --- /dev/null
> +++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
> @@ -0,0 +1,634 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
> + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> + */
> +
> +/dts-v1/;
> +#include "jh7110.dtsi"
> +#include "jh7110-pinfunc.h"
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	aliases {
> +		ethernet0 = &gmac0;
> +		ethernet1 = &gmac1;
> +		i2c0 = &i2c0;
> +		i2c2 = &i2c2;
> +		i2c5 = &i2c5;
> +		i2c6 = &i2c6;
> +		mmc0 = &mmc0;
> +		mmc1 = &mmc1;
> +		serial0 = &uart0;
> +	};
> +

You miss board compatible and bindings.

> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	cpus {

Board should not bring new CPU nodes. Override by label instead.


> +		timebase-frequency = <4000000>;
> +	};
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x40000000 0x1 0x0>;
> +	};
> +
> +	gpio-restart {
> +		compatible = "gpio-restart";
> +		gpios = <&sysgpio 35 GPIO_ACTIVE_HIGH>;
> +		priority = <224>;
> +	};
> +
> +	pwmdac_codec: pwmdac-codec {

audio-codec

> +		compatible = "linux,spdif-dit";
> +		#sound-dai-cells = <0>;
> +	};
> +
> +	sound-pwmdac {

sound


Best regards,
Krzysztof

