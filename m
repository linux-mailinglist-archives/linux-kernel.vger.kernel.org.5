Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C80980F7BF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377317AbjLLUUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377263AbjLLUUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:20:15 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E304BD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:20:20 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a1ef2f5ed02so668706066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702412418; x=1703017218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ngERMlUllXQ8ZRUThwj6cID071LS3nU+eAyqRU27NM=;
        b=rbrKkcyiNZY0oCTOb22AXk3EcfAwFi7DgHVP5AIo63wKLsd8OFXDmjkLPwaa2yqcxk
         T8gXo/HJyva9UfGnld68ixH48lE2E5Z8d86kjBY75h/NFpb7zFHSGkiUM0fRNsWZzQwF
         QSxmTv/C55AiivCprYlqX6LNuZ0/UhXf2XvX6sLaPbPkLVqsvJCDCJb4W6xKvqUr4wuj
         oZln/ikURo1wlc++IghAkw6BlUWr8SDLHOGpK7uPizj6m5FBf5tmyv38bHNrqELWiGUA
         O6vMYrqZrXKSjJnq9Mxs5zew2EgtvsWtyAFn2YKWgmUqdd35PiPkXgs47e9qN2on3Pdg
         wKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702412418; x=1703017218;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ngERMlUllXQ8ZRUThwj6cID071LS3nU+eAyqRU27NM=;
        b=SifiiSWC01Fwq9C2/jbJ8GsWrKtcHPjjPuzCIhbVz6vD/saVeodig1t2N5/Ff5ZvK9
         gt5xbMTKrii4W8VwPvt4bdcBZOPWr65deJPSzSZr9o6MLHDtL7erggG/6CeTabTKhfom
         LDE2/Mia26ogVBwjrP630Nrde2qyEKqbi05SFAQ9tgegafaFmuqu64R7jZ9hpZdSeTgZ
         uuI0j5u4FjJxm9ROrock+HhrDKvyv3U7qBQi3TPKdntgjVG0JY23vob+1V1top+HV/lh
         RmLny9daY1gpVOOtB9y2+IaGqYX+dkSVzaOLAiPUt4ab/D7+sY3K2J06ivjfBWYESug7
         C+Ag==
X-Gm-Message-State: AOJu0YwjTUqbXs9CBF7s0zdafDs+WX5gID+oMyf9E6u5yZ3l2dVy5LtA
        kgh76X4rSzoCuKuFrrXXKkslJg==
X-Google-Smtp-Source: AGHT+IGDF5Cp6rn6wjaislsRhak5ERzaj+pUWahDpuaS1jBS07qWaO1DIvjztazkGvdBhnEFYnqBYA==
X-Received: by 2002:a17:907:3d91:b0:9fe:57b3:bc08 with SMTP id he17-20020a1709073d9100b009fe57b3bc08mr4434566ejc.41.1702412418574;
        Tue, 12 Dec 2023 12:20:18 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id li14-20020a170907198e00b00a1f738318a5sm6178368ejc.155.2023.12.12.12.20.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 12:20:18 -0800 (PST)
Message-ID: <81d90c0d-9d7e-43a9-ade8-16b85a242b48@linaro.org>
Date:   Tue, 12 Dec 2023 21:20:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/8] ARM: dts: aspeed: System1: IBM system1 BMC board
Content-Language: en-US
To:     Ninad Palsule <ninad@linux.ibm.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com,
        johannes.holland@infineon.com, linux@roeck-us.net,
        broonie@kernel.org
Cc:     Andrew Geissler <geissonator@yahoo.com>,
        patrick.rudolph@9elements.com, vincent@vtremblay.dev,
        peteryin.openbmc@gmail.com, lakshmiy@us.ibm.com,
        bhelgaas@google.com, naresh.solanki@9elements.com,
        alexander.stein@ew.tq-group.com, festevam@denx.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-4-ninad@linux.ibm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231212164004.1683589-4-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2023 17:39, Ninad Palsule wrote:
> From: Andrew Geissler <geissonator@yahoo.com>
> 
> Add a device tree for IBM system1 BMC board. It uses AST2600 SOC.
> 
> Tested:
>     This board is tested using the simics simulator.
> 
> Signed-off-by: Andrew Geissler <geissonator@yahoo.com>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  arch/arm/boot/dts/aspeed/Makefile             |   1 +
>  .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 188 ++++++++++++++++++
>  2 files changed, 189 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> 
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
> index 3e3e6b96cb79..6f7ed11978ff 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -35,6 +35,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-ibm-rainier.dtb \
>  	aspeed-bmc-ibm-rainier-1s4u.dtb \
>  	aspeed-bmc-ibm-rainier-4u.dtb \
> +	aspeed-bmc-ibm-system1.dtb \
>  	aspeed-bmc-intel-s2600wf.dtb \
>  	aspeed-bmc-inspur-fp5280g2.dtb \
>  	aspeed-bmc-inspur-nf5280m6.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> new file mode 100644
> index 000000000000..01291b407f59
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> @@ -0,0 +1,188 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright 2023 IBM Corp.
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/i2c/i2c.h>
> +#include <dt-bindings/leds/leds-pca955x.h>
> +
> +/ {
> +	model = "System1";
> +	compatible = "ibm,system1-bmc", "aspeed,ast2600";
> +
> +	chosen {
> +		stdout-path = &uart5;
> +		bootargs = "console=ttyS4,115200n8 earlycon";

Drop early con, debugging feature not release. Then use stdout path
alone, so drop console as well.


> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x40000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		event_log: tcg_event_log@b3d00000 {

No underscores in node names.


Best regards,
Krzysztof

