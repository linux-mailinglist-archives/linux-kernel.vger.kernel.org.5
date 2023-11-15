Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F22A7EC951
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbjKORFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbjKOREt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:04:49 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B82E1715
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:04:35 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c501bd6ff1so94752531fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700067873; x=1700672673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EZtoQ6TsypQDjyf9B3Yz1sAlQQ1e5vDW1aebdA/byQI=;
        b=UQw2aDV3PE2Gz+HpNbZF0CRbLfvz+CiVy1Nhg9BnZtV1bnWNLrheeZkrkDgN6hxNV/
         jU73kJPItjYkSDaw78r75YGGeaHHr1c9+prFT0s/gYj3VkQLai/Jam6/jFx/2LKUzuJ9
         SDzyRRwwY5wYzKOzotOqNsFVU6OHtSkCQPIs2H8k/g0SYRwuDxpXKAzTZGImkAWCQU96
         BvYdhWC6GMa4iJR4jTcIZeagLet76TFxwfQtYOlwIUtqubqd4P2bHfYRy8OwXkESolyD
         Aix9P9HllKKMvV6yeCUG9YHH2V7Gi8g6iGQEip7xwZAVnJsIwD2Y5vGBkxv1Pcur5G4P
         73Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700067873; x=1700672673;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EZtoQ6TsypQDjyf9B3Yz1sAlQQ1e5vDW1aebdA/byQI=;
        b=Lp4rNLDKxJn/+MaxUxpS9a3pGzLchaQIVgmECe41ZEjqt3xehLXdjDLxV8UYtG4rVS
         ie/pPfYAgx3A8pbJpDc5pGiY9Re6064kedsmzmNVD2Q61rfI8MFltlH+4yLMT/LmZKVd
         104SuPFDTK8HCRMcCART/4TWbOSBrYJm6VmphlDWdnFVZroZebfr6aTbDWXGJYgym3jN
         ncV2x9JmFv+m9X2QhAacwU00XHKFejbkp/srBnWWun9mwTCnNeRpj+Y8lvl1BTYYt/cd
         NpsyCL4ESsrrljF/5B4zuRWm/pTWnlZbOewpjgSHqDfwIwL25AgDlUDhbXArmi3XUFL8
         qttw==
X-Gm-Message-State: AOJu0Yxthb6fdmTxOOcgMvN+kKm2IGj23bx8YgIAiT1Zma/nwzprWBQI
        3cci0WGseLe5agM9vui3MYEeTA==
X-Google-Smtp-Source: AGHT+IE8avvVATeajyNQ9GHaEnf/2U2LC2iro5zXR+3HKqwOW58FE8XdyzjevmeJ/ayGaxeS3qGMUQ==
X-Received: by 2002:a05:651c:4c9:b0:2c5:19f2:4fde with SMTP id e9-20020a05651c04c900b002c519f24fdemr5596423lji.23.1700067873639;
        Wed, 15 Nov 2023 09:04:33 -0800 (PST)
Received: from [172.30.204.150] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id z4-20020a2eb524000000b002bff8ed8e2bsm1795340ljm.9.2023.11.15.09.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 09:04:33 -0800 (PST)
Message-ID: <1208232f-c618-4a95-bca5-e5ee4245a873@linaro.org>
Date:   Wed, 15 Nov 2023 18:04:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: ipq6018: add QUP5 I2C node
Content-Language: en-US
To:     Isaev Ruslan <legale.legale@gmail.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CACDmYyfOe-jcgj4BAD8=pr08sHpOF=+FRcwrouuLAVsa4+zwtw@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CACDmYyfOe-jcgj4BAD8=pr08sHpOF=+FRcwrouuLAVsa4+zwtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/23 16:38, Isaev Ruslan wrote:
> Add node to support this bus inside of IPQ6018.
> For example, this bus is used to work with the
> voltage regulator (mp5496) on the Yuncore AX840 wireless AP.
> 
> 
> Signed-off-by: Isaev Ruslan <legale.legale@gmail.com>
> ---
> v1 -> v2: fix clocks typo; fix reg size warning.
Hi, it's also good practice to share a link to the previous
revision for easier comparison. The b4 tool [1] takes care
of most of the comments you've got.

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
The irq number seems a bit sus.. they're usually more or less contiguous
and I2C3 uses SPI97.. Are you sure it's the correct one?

Konrad

[1] https://b4.docs.kernel.org/en/latest/
