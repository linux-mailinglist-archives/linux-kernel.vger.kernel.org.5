Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7995978AF56
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 13:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjH1Lz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 07:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjH1LzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 07:55:00 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC5811B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 04:54:57 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so654424266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 04:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693223696; x=1693828496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CghXjnmhGYaNTmxkJrC++UaP4UDjN3m0O5QjItGpeIc=;
        b=X7+ocAxKSgLrN8rjs8F69qlU282AImYlDHJY3dDPc5shGwSNNQ6t2X7iSXaOfTjSUY
         Kd5lJEcybxgPmbQImioJgjcm3RrgWVExjIBHWGcbiGb1kDy35QipmVm/Cbpx9lHQKt7B
         A0Cx2LGiHAbr4HuzizXIOafczH+7vCQy6NdZmEHuGcsCpLq0kKS/37sPO9xCwy5mMajZ
         XpgcWSc9IX+A3Wxo5CdZcDWM0DzHHWLZ57ceMsD3kK+iEsuOBO5w11jw7XIipUBCqNL1
         EvDHuH0caoHuEAX1g1fmyK/VY1bbv4gG1JZ7hQTQTZ6ltkDrLFh7yQ0A9yzEYRMYy8yE
         h6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693223696; x=1693828496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CghXjnmhGYaNTmxkJrC++UaP4UDjN3m0O5QjItGpeIc=;
        b=D2CtmRwomThXQjP2vpfQ5xJx9cbGPWp3tAdqQJ3i3IzeFPmriLGOnD9mVh1S1WasrB
         aHt+Q4it22u/zTTTFhWT7pHkxoXjjTAWprR2R5v4oxU+QEXlTHJb3zs8otHGfW4R9Ns7
         Emnd3mOGUFTau55k7hUow6Osb72mcT0A7XHdqh1hBeKovdpOxJj8NrV9HwRsenJfunRG
         QxcOIUrMsmsk7E9osBrJaDc8szyoAQYAJncUFuPZ4t3rmuxqZF4UGWFMnpWRDSOZyoL/
         5JaYGLFFzGxedtnmUquWlB93xLThsM1z3O2LldA44WoDXN9RyAQEte2U2v5+r8OHpsSX
         bPFQ==
X-Gm-Message-State: AOJu0YzaKO5Da64Jngzp6gVaNFImcEeR/JHch1neUvaX0LmMa8riw7GT
        OPXc5/DMgZYHcWfzxN2BYwgHPA==
X-Google-Smtp-Source: AGHT+IGSevbzv9y6W2qDDFwFBahmZ75ulPmjKvMSfcsIPU4w5/uFCsjEOezSMRpGXMsPleyd3tO+uQ==
X-Received: by 2002:a17:907:2c43:b0:9a5:ae8a:6e0b with SMTP id hf3-20020a1709072c4300b009a5ae8a6e0bmr3032324ejc.24.1693223695598;
        Mon, 28 Aug 2023 04:54:55 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id k6-20020a17090646c600b009a168ab6ee2sm4513777ejs.164.2023.08.28.04.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 04:54:55 -0700 (PDT)
Message-ID: <3a5e343c-a0cc-8d1b-eadc-82c3d038aaa1@linaro.org>
Date:   Mon, 28 Aug 2023 13:54:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [-next v1] riscv: dts: starfive: visionfive 2: Enable usb0 and
 fix tdm pins sort order
To:     Hal Feng <hal.feng@starfivetech.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230828115239.16012-1-hal.feng@starfivetech.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230828115239.16012-1-hal.feng@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2023 13:52, Hal Feng wrote:
> usb0 was disabled by mistake when merging, so enable it.
> tdm_pins node should be sorted alphabetically.
> 
> Fixes: e7c304c0346d ("riscv: dts: starfive: jh7110: add the node and pins configuration for tdm")
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../jh7110-starfive-visionfive-2.dtsi         | 49 ++++++++++---------
>  1 file changed, 25 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index d79f94432b27..382dfb5e64e4 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -440,30 +440,6 @@ GPOEN_ENABLE,
>  		};
>  	};
>  
> -	uart0_pins: uart0-0 {
> -		tx-pins {
> -			pinmux = <GPIOMUX(5, GPOUT_SYS_UART0_TX,
> -					     GPOEN_ENABLE,
> -					     GPI_NONE)>;
> -			bias-disable;
> -			drive-strength = <12>;
> -			input-disable;
> -			input-schmitt-disable;
> -			slew-rate = <0>;
> -		};
> -
> -		rx-pins {
> -			pinmux = <GPIOMUX(6, GPOUT_LOW,
> -					     GPOEN_DISABLE,
> -					     GPI_SYS_UART0_RX)>;
> -			bias-disable; /* external pull-up */
> -			drive-strength = <2>;
> -			input-enable;
> -			input-schmitt-enable;
> -			slew-rate = <0>;
> -		};
> -	};
> -
>  	tdm_pins: tdm-0 {
>  		tx-pins {
>  			pinmux = <GPIOMUX(44, GPOUT_SYS_TDM_TXD,
> @@ -497,6 +473,30 @@ GPOEN_DISABLE,
>  			input-enable;
>  		};
>  	};
> +
> +	uart0_pins: uart0-0 {
> +		tx-pins {
> +			pinmux = <GPIOMUX(5, GPOUT_SYS_UART0_TX,
> +					     GPOEN_ENABLE,
> +					     GPI_NONE)>;
> +			bias-disable;
> +			drive-strength = <12>;
> +			input-disable;
> +			input-schmitt-disable;
> +			slew-rate = <0>;
> +		};
> +
> +		rx-pins {
> +			pinmux = <GPIOMUX(6, GPOUT_LOW,
> +					     GPOEN_DISABLE,
> +					     GPI_SYS_UART0_RX)>;
> +			bias-disable; /* external pull-up */
> +			drive-strength = <2>;
> +			input-enable;
> +			input-schmitt-enable;
> +			slew-rate = <0>;
> +		};


What is fixed in this hunk? Order of nodes is just a style, not a bug
needing backports.

Best regards,
Krzysztof

