Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E153771240
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 23:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjHEVFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 17:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjHEVE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 17:04:58 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BA0F3
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 14:04:55 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fe2bc27029so31746015e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 14:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691269494; x=1691874294;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VXgvu4PdDcYeSWEAGjMAQ6aaokT2QYB0Ybt1pTFSg+A=;
        b=vgA2xqtfz8HfxCtetsIBocLLjd+CLI0pMJbGIsNa719wEia2zfDrrFeco3WOGOjdSY
         xknRMHN1PzoOC8IQ6NkL2zK9YbRpg0mTfhvmVBrr6qMg+SAMdEUgdRIrcfZOn/stw7Ad
         YU65yACHGJ5q9kgo1bJ5nPv/wBq99EBKt8PR0G8TfGNmQELNtbZ5YB6XFUemHO4cjgMm
         NKtu4fyKR71+0TxvQM9EThPmFS5y1eooJ7p1qQFuf8Ze3ORPqVZyz1T5MMe61zssWh1H
         3u9nlASTQlrBtIT/Hrq6biV8jwr7CwaklGNoxp85xPrW0NkfbWQ8qD9zUUQym5fsXmiI
         Ac3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691269494; x=1691874294;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VXgvu4PdDcYeSWEAGjMAQ6aaokT2QYB0Ybt1pTFSg+A=;
        b=cALeFv11w2Qr1OLtGkYk7V87OA4gXY2TY8197VerpSHpaqMfOqoJemjQVSQJrrU59x
         cGorB/J0xwtS9IsYEETVC090q4OXdMPU1ZGh29Tsdrc3YuSfQsWy6T7ONbrYCKmg7H77
         ZqeQsH1I9PZdwSf+p3LjCQQ1djM5PRKtaZ39wfVPs3KVbJqSqRkJ9Jca4GZk3APXWUOm
         EAbf6196swclGLYGSF4cU08quh1F3qnF8w7Y1Xaocvf0FHQY3dEfjeROX0TFDR0QNClZ
         4m9Je8w/byTrd4g4BxxvHXjGnTf2ypLy+LbU3x/DD+4zrNmwTv3mUd4Cfh0v6zhUO2oJ
         UJ1Q==
X-Gm-Message-State: AOJu0Yzdn2M+gCXAzHlclxLUJ9O6uUGxRtPeEXTCWKI0NFRB9QZfjK7B
        Vw48KT5jMkXS2s2yjO3tlQ8oNQ==
X-Google-Smtp-Source: AGHT+IELrrb3HMZVfrxFaUMcQP1kpcJAAxcbzg8Tw9gdaGgOuScyzdpPV8YzQuwVSlRpdWDtYUKKxQ==
X-Received: by 2002:a5d:6812:0:b0:314:3740:7f69 with SMTP id w18-20020a5d6812000000b0031437407f69mr3812846wru.37.1691269494423;
        Sat, 05 Aug 2023 14:04:54 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.245])
        by smtp.gmail.com with ESMTPSA id w14-20020adfec4e000000b003141e629cb6sm5892063wrn.101.2023.08.05.14.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Aug 2023 14:04:53 -0700 (PDT)
Message-ID: <8fc27960-fa82-c900-0414-75b10a118f15@linaro.org>
Date:   Sat, 5 Aug 2023 23:04:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 5/5] riscv: dts: starfive: Add the nodes and pins of
 I2Srx/I2Stx0/I2Stx1
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Jose Abreu <joabreu@synopsys.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-riscv@lists.infradead.org
References: <20230802084301.134122-1-xingyu.wu@starfivetech.com>
 <20230802084301.134122-6-xingyu.wu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230802084301.134122-6-xingyu.wu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2023 10:43, Xingyu Wu wrote:
> Add I2Srx/I2Stx0/I2Stx1 nodes and pins configuration for the
> StarFive JH7110 SoC.
> 
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---

...

> +
>  	spi0_pins: spi0-0 {
>  		mosi-pins {
>  			pinmux = <GPIOMUX(52, GPOUT_SYS_SPI0_TXD,
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index 05f843b8ca03..507312eb6053 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -512,6 +512,30 @@ tdm: tdm@10090000 {
>  			status = "disabled";
>  		};
>  
> +		i2srx: i2srx@100e0000 {

Node names should be generic, so:
i2s@

> +			compatible = "starfive,jh7110-i2srx";
> +			reg = <0x0 0x100e0000 0x0 0x1000>;
> +			clocks = <&syscrg JH7110_SYSCLK_I2SRX_BCLK_MST>,
> +				 <&syscrg JH7110_SYSCLK_I2SRX_APB>,
> +				 <&syscrg JH7110_SYSCLK_MCLK>,
> +				 <&syscrg JH7110_SYSCLK_MCLK_INNER>,
> +				 <&mclk_ext>,
> +				 <&syscrg JH7110_SYSCLK_I2SRX_BCLK>,
> +				 <&syscrg JH7110_SYSCLK_I2SRX_LRCK>,
> +				 <&i2srx_bclk_ext>,
> +				 <&i2srx_lrck_ext>;
> +			clock-names = "i2sclk", "apb", "mclk",
> +				      "mclk_inner", "mclk_ext", "bclk",
> +				      "lrck", "bclk_ext", "lrck_ext";
> +			resets = <&syscrg JH7110_SYSRST_I2SRX_APB>,
> +				 <&syscrg JH7110_SYSRST_I2SRX_BCLK>;
> +			dmas = <0>, <&dma 24>;
> +			dma-names = "tx", "rx";
> +			starfive,syscon = <&sys_syscon 0x18 0x2>;
> +			#sound-dai-cells = <0>;
> +			status = "disabled";
> +		};
> +
>  		usb0: usb@10100000 {
>  			compatible = "starfive,jh7110-usb";
>  			ranges = <0x0 0x0 0x10100000 0x100000>;
> @@ -736,6 +760,47 @@ spi6: spi@120a0000 {
>  			status = "disabled";
>  		};
>  
> +		i2stx0: i2stx0@120b0000 {

i2s@

> +			compatible = "starfive,jh7110-i2stx0";
> +			reg = <0x0 0x120b0000 0x0 0x1000>;
> +			clocks = <&syscrg JH7110_SYSCLK_I2STX0_BCLK_MST>,
> +				 <&syscrg JH7110_SYSCLK_I2STX0_APB>,
> +				 <&syscrg JH7110_SYSCLK_MCLK>,
> +				 <&syscrg JH7110_SYSCLK_MCLK_INNER>,
> +				 <&mclk_ext>;
> +			clock-names = "i2sclk", "apb", "mclk",
> +				      "mclk_inner","mclk_ext";
> +			resets = <&syscrg JH7110_SYSRST_I2STX0_APB>,
> +				 <&syscrg JH7110_SYSRST_I2STX0_BCLK>;
> +			dmas = <&dma 47>;
> +			dma-names = "tx";
> +			#sound-dai-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2stx1: i2stx1@120c0000 {

i2s@



Best regards,
Krzysztof

