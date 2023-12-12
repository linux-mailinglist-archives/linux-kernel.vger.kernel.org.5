Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F1580F7E1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbjLLU0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjLLU0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:26:31 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A74CE9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:26:37 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40c3f68b69aso33858045e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702412795; x=1703017595; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hgxv7EF4Irll71B8Hw+ZNuQf2aAKASeN0rbDIOWc5pE=;
        b=hERGBRR+lL8HmQwAP+AM2yKHA9/mmXGrOYbMQVcKKKIdVeZNFZQnM3E57lc00fdVi/
         71j5ef5s2b7Ddb4zWRcU5jboydH9Ud1kQP/tyjMcA093zV4hEwwlcGJkjcLHk+jk+TnX
         ZYVCV/k/HrElWQycPH12WRHXxWKUZGB5dEbAddIyaQnsnosflbpDo2NNomYvF1BIEi/J
         ga1gu4p1aDc/BiMsKtocj3eOGhnylyUF0D1JeSRvRlSI29U3S5qvXy8BdKz7HwkeHQha
         M4kHcW3bxsE7YE3fwYCn4zCGz3VP1GRFOWBBSsJCoXxNFhBzzlltAWuvPh1KQp0qwIWO
         e1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702412795; x=1703017595;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hgxv7EF4Irll71B8Hw+ZNuQf2aAKASeN0rbDIOWc5pE=;
        b=lI0KUTno+7NnfPB0YUmWikXRVlwsvqU6rAoTrr3BCgLn9z6LmmMF96mUGasO41z5UC
         FgT6qeHG33gbXoT6ZpUmeVF3oD7lTA9+/6kPkPSUf+MvtXLa+m8socvCtELoKt44UQB3
         cq2qPeNPMYsEcIhCcJe+UAZakk5FCT1YZpIs09c8KVn1FqEF81gQ0hTLUm4GsuT8KYfp
         b7GgkRj/m1+Rp20AU8WKVL6/KhHFeOWgrrHWROs+zyYI1/3snQLgemka4vRV9dsxZI4f
         7yNcVUfPIoIpQY7R0N5WuPnTjvv15D9fFgTfazoFCZZySSQfKYvV/NNTemkmHCmrydcV
         be6A==
X-Gm-Message-State: AOJu0YzhkUu5D6zNfdx9JKMxx6PdLlrQjb8+ThmT5lDm+YddmIUrYzkY
        u1ghWw9q3mH6BCbtNXMyNpnUXw==
X-Google-Smtp-Source: AGHT+IGWv/YdluhtwVphE7CoDTj82BpgPHXdubShtukPi5QX8GCQ6dewT+kR6iaFEQFQPaMMh7Vcgw==
X-Received: by 2002:a7b:c3d8:0:b0:40c:3820:eff0 with SMTP id t24-20020a7bc3d8000000b0040c3820eff0mr3489292wmj.105.1702412795584;
        Tue, 12 Dec 2023 12:26:35 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id w6-20020a5d6806000000b00336103442d2sm10177965wru.76.2023.12.12.12.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 12:26:35 -0800 (PST)
Message-ID: <5b98538a-8ffe-42ec-b020-514dcfcebba3@linaro.org>
Date:   Tue, 12 Dec 2023 21:26:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 8/8] ARM: dts: aspeed: System1: PS, sensor and more
Content-Language: en-US
To:     Ninad Palsule <ninad@linux.ibm.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com,
        johannes.holland@infineon.com, linux@roeck-us.net,
        broonie@kernel.org
Cc:     patrick.rudolph@9elements.com, vincent@vtremblay.dev,
        peteryin.openbmc@gmail.com, lakshmiy@us.ibm.com,
        bhelgaas@google.com, naresh.solanki@9elements.com,
        alexander.stein@ew.tq-group.com, festevam@denx.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org,
        geissonator@yahoo.com
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-9-ninad@linux.ibm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231212164004.1683589-9-ninad@linux.ibm.com>
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

On 12/12/2023 17:40, Ninad Palsule wrote:
> This drop adds following devices in the device tree.
> - EEPROM/VPD
> - Power supplies
> - Humidity, pressure and temperature sensors.
> - Trusted platform module(TPM) chip
> 
> Tested:
>     This board is tested using the simics simulator.
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---

Don't mix DTS with drivers. DTS and drivers go via different subsystems
and cannot have dependencies, so why DTS is patch #6, then driver #7 and
now again DTS #7?


>  .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> index 75562aa63701..d960b938fe8d 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> @@ -461,6 +461,11 @@ &kcs3 {
>  &i2c0 {
>  	status = "okay";
>  
> +	eeprom@50 {
> +		compatible = "atmel,24c64";
> +		reg = <0x50>;
> +	};
> +
>  	regulator@60 {
>  		compatible = "maxim,max8952";
>  		reg = <0x60>;
> @@ -655,6 +660,25 @@ pca0: pca9539@74 {
>  
>  &i2c2 {
>  	status = "okay";
> +
> +	power-supply@58 {
> +		compatible = "ibm,cffps";
> +		reg = <0x58>;
> +	};
> +
> +	power-supply@59 {
> +		compatible = "ibm,cffps";
> +		reg = <0x59>;
> +	};
> +
> +	power-supply@5a {
> +		compatible = "ibm,cffps";
> +		reg = <0x5a>;
> +	};

Missing blank line

> +	power-supply@5b {
> +		compatible = "ibm,cffps";
> +		reg = <0x5b>;
> +	};


Best regards,
Krzysztof

