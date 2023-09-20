Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D26B7A7A6C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 13:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbjITL2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 07:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjITL2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:28:13 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B08B0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 04:28:07 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9adca291f99so676884366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 04:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695209286; x=1695814086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GACDrnV+AI9jqnTx+ewaqjW9iyUrnWty7M6DlDib3xY=;
        b=Jew4i+KKCPTjDYUfasNhsDJvQr4GJMsiFnnv2QecUb3uC0Cp0zfQ/tvVHIDsdny0BK
         gy0ZEXKzpR1GvUPv4QERl6X2RooP/fRn5AWFNDIAPB+PE8R5AuqEk6+Q0YXyUnuDQ2Ph
         l6Wku95Y247xoJIRpNbWd60ce3VPgniUGRWsLDSOvP0SGiA4RBzIS7HeHCLhNVEX9ddP
         MLHckis0z51GOF5yuBrrroXqRQ6xrt9VIubqhQF9FhpStD9HAf34uQe+uGbZzycLkEuB
         Hx/UVR0GFi1w5it4RnXV6kExvEDduILP759XPiZyn84MzzzR+RCJrNjm7dQbyLqti97c
         dD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695209286; x=1695814086;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GACDrnV+AI9jqnTx+ewaqjW9iyUrnWty7M6DlDib3xY=;
        b=DfOcYHtPgcBtJNHp2KUygef9WkPI1Cr/XJZe0rujyvzaA4W8ndTodS5HZShdV4GgQ7
         r0CFXVMypB0zIEdjqqPPUx4rIBfOnMj2llrvyOKymt6D74o7Jo6A3pNwxWGevrQWLgVS
         +9IsKvcHSqvpzfedxp8JMrE+m8EdU0/MBn1n60AR8+lvSiFn+QbzEJxum1PMV+7umoQa
         paxiXbS+PkbuNQGMV+bIlhGcjhvFy0qgi1ZYB9VWzQ4YJFUrcNzkGqd9Da3JFNPaldXx
         twvgdJ1UlKRDQNKiqiCj3JQAr2LdWfSLBRl/jfhrZ2xhLj82PWeZKBuLVsp+yU6U1olj
         lx5A==
X-Gm-Message-State: AOJu0YwECTdrqym8+APKa81iorB1BPBauC0fav6A0cP84u9ccpVSV2wn
        d4w0IIYAIb1RNOhkozg5Y93jwg==
X-Google-Smtp-Source: AGHT+IGPfIQWQ+EueBRU+uoEQXPLQOfh1V2CdlSsyL7H9gVvMK0VwLBKxAMb/iW36KEiRSVWP/qlAA==
X-Received: by 2002:a17:906:311b:b0:9a2:143e:a062 with SMTP id 27-20020a170906311b00b009a2143ea062mr1843177ejx.49.1695209286403;
        Wed, 20 Sep 2023 04:28:06 -0700 (PDT)
Received: from [172.20.24.238] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id wy2-20020a170906fe0200b009adcb6c0f0esm7835502ejb.193.2023.09.20.04.28.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 04:28:05 -0700 (PDT)
Message-ID: <9d612171-8ae4-de65-31b0-fbb5f1f8331e@linaro.org>
Date:   Wed, 20 Sep 2023 13:28:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] ASoC: dt-bindings: tfa9879: Convert to dtschema
To:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230919090739.2448-1-bragathemanick0908@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230919090739.2448-1-bragathemanick0908@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2023 11:07, Bragatheswaran Manickavel wrote:
> Convert the tfa9879 audio CODEC bindings to DT schema
> 

> +required:
> +  - compatible
> +  - reg
> +  - '#sound-dai-cells'
> +
> +additionalProperties: false

Instead:
unevaluatedProperties: false

> +
> +examples:
> +  - |
> +    i2c1 {
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +       amp: amp@6c {

amplifier@6c

> +          compatible: "nxp,tfa9879";
> +          reg: <0x6c>;
> +          "#sound-dai-cells": <0>;
> +          pinctrl-names: "default";
> +          pinctrl-0: <&pinctrl_i2c1>;

That's not a DT syntax.

Best regards,
Krzysztof

