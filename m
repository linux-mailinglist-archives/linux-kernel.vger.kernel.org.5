Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994D77EC524
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344068AbjKOO2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjKOO2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:28:06 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A8411C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 06:28:03 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id ffacd0b85a97d-32f7abbb8b4so4236617f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 06:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700058481; x=1700663281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Evtot4Yh11FEYzBefFRVE52J4bwfzJ6OpH6hCREKuc0=;
        b=vPgwcnj64Qwu6IN+RS8M1iGLH7VzIy6Yx/j8EBStTr0q7LcCp5b5+4jzyoiXPaTJOX
         X6fV7HEcipg5wJ9gsAWTy0WwiwD95R1lHnqmPl4X4YFOXf/Pv4IiLdcTMH3IdiXZLg8v
         VkhKztOpU1Yhwr2qAulsNancIbFjpejQ2yo0G0ieYnLX4Td7w8YAJQWs+yNRxrrwNZkd
         yvzY2/uUM/9Ku17bxwPZzFBDG+k1C4k1mbGRniNWoRHd9Fj52fGpdPzd78Vvb+npu9LF
         X0eP97C1G5dD8Y0LiwK4kmIN9OKlpHavDpLUFXZS0LVcrEmXWUtezc6ajTWPGUj2G+K1
         4iMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700058481; x=1700663281;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Evtot4Yh11FEYzBefFRVE52J4bwfzJ6OpH6hCREKuc0=;
        b=fmO57hdrTJytZ0GCYidGbN63t7oNFGr9MnEH+cs4fSJCtDsAGaq0BLaD9H1FCm/3F+
         xF2WC3I6/fgxtoqy1C9XNF6z02TXilcVM9kx7sQeztGcDEKxjDhOudFJ6qhWScqawOIg
         cTzgGqCaWbr4mbfu5JAW+K0YaIIIfq2W/OxPokSB/oAytgBd/HU64pCGF6llH9cmM14b
         Sqd/IjGKqR9lxCPggVixz8ngx5VxGxkGHnaDR9AldgwZ8VaxRdvFz7lRWT6ek2rPEX0d
         mOykolN6uRPir2VBYuVXkwNmqRFAoBX0jG5sXAEwCjOGmLvVaSNgBWJZGN6Il8mqwhJ3
         spsg==
X-Gm-Message-State: AOJu0YzXdjcpiCu/vF93g4nTKSER94l4LM5ntZiyHO51O32mROW9vp9P
        P0FvDu4wD1RAePbMWFJ4Zn9HZg==
X-Google-Smtp-Source: AGHT+IGy/J9LcmDCiDCJZj8G9WmVZlzWvn8wbfDi7y0jzmUhP2J26XTDrpjGpc0p/0knDyMccZdLFA==
X-Received: by 2002:adf:f0ce:0:b0:314:dc0:2fca with SMTP id x14-20020adff0ce000000b003140dc02fcamr8889899wro.29.1700058481635;
        Wed, 15 Nov 2023 06:28:01 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id p1-20020a5d48c1000000b0032fdcbfb093sm10695138wrs.81.2023.11.15.06.28.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 06:28:01 -0800 (PST)
Message-ID: <cf22c52e-cd4b-4560-b5db-c887c9f8a1b8@linaro.org>
Date:   Wed, 15 Nov 2023 14:28:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: ipq6018: add QUP5 I2C node
Content-Language: en-US
To:     Legale Legale <legale.legale@gmail.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CACDmYyf4hxbuw+cpKqEDnqmHpS9yPXuE5MPD5_XZ3hjmYuViUQ@mail.gmail.com>
 <a3e35d3b-906a-4540-924c-0103cf32efa4@linaro.org>
 <CACDmYydnLQd0n9ACnTQ6P4wYf38eMzokyHrF7r6LisG4oTFtyg@mail.gmail.com>
 <5cd19f5e-baa6-47da-8730-fe0ddedff364@linaro.org>
 <CACDmYyeBbGVPxLh+dmWus=BEiM6rp-1Qn17_RhSyDywrWf8uLw@mail.gmail.com>
 <CACDmYycHgu8JKjRM6xrMeNkruEHMba+afXtSqLq5TCw3y-b0Zw@mail.gmail.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <CACDmYycHgu8JKjRM6xrMeNkruEHMba+afXtSqLq5TCw3y-b0Zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 15/11/2023 14:20, Legale Legale wrote:
> Wrong file. sorry. This one is correct:

Top posting makes Alan Turning cry.

https://docs.kernel.org/process/submitting-patches.html#use-trimmed-interleaved-replies-in-email-discussions

> ---
>   arch/arm64/boot/dts/qcom/ipq6018.dtsi | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> index e59b9df96..00a61de9d 100644
> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> @@ -506,6 +506,21 @@ blsp1_i2c3: i2c@78b7000 {
>                          dma-names = "tx", "rx";
>                          status = "disabled";
>                  };
> +
> +               blsp1_i2c6: i2c@78ba000 {
> +                       compatible = "qcom,i2c-qup-v2.2.1";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0 0x078ba000 0x0 0x600>;
> +                       interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&gcc GCC_BLSP1_QUP6_I2C_APPS_CLK>,
> +                                <&gcc GCC_BLSP1_AHB_CLK>;
> +                       clock-names = "core", "iface";
> +                       clock-frequency = <400000>;
> +                       dmas = <&blsp_dma 22>, <&blsp_dma 23>;
> +                       dma-names = "tx", "rx";
> +                       status = "disabled";
> +               };
> 
>                  qpic_bam: dma-controller@7984000 {
>                          compatible = "qcom,bam-v1.7.0";
> --

So you need to make a V2 of this patch.

1. Suggested changing "Legale Leagle" to your signoff name
    Isaev Ruslan <legale.legale@gmail.com>

2. Please remember to run dtbs_check and dtbs_binding_check

The dtb checks should catch errors like the register size.

---
bod

