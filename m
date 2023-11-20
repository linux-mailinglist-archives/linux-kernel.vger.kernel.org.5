Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD797F0C9F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 08:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjKTHNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 02:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjKTHNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 02:13:08 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9801EC1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 23:13:02 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507bd64814fso5599332e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 23:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700464381; x=1701069181; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DGS3LqpOXvMHWFZfngDkw3XYyRRmTs0hdbzdAVl4HKQ=;
        b=bdaiXygOBgqqJ3t37wiVX1/eWgojwQ7eDs4EkkPOozzpsVXdbPTFMy+DeDZxQI+wTq
         pQKUnNYaBcZVAb1XqTV8HunffJ2KPrrcYjURia9JmQzqYa/U+ApurpeASAwR2xdt99Rl
         P4az+VBh/s3iqx/bqvIa82wXT7GWmarmEEcS+Up3ajhR721+rGwXtv2D55MQSDltS955
         BQJpIQVjPAAAiyCU6Hsa7+4JFhEUkjijYoNVbGqxURQVjq8K/tTXhGK+F9jWIaKTItG3
         XD85yGu+wScHhMhT6xxn/BdBoCOZ9PviH3+tMHU/tiPIqgGYKFX1mPZyI9zwdlZ29uM5
         cpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700464381; x=1701069181;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DGS3LqpOXvMHWFZfngDkw3XYyRRmTs0hdbzdAVl4HKQ=;
        b=w7dxZKEPzDEgxuToe6C+MlcA+G5IaGcjRcn2ACyaoigqfbZvTWrmlAxCzYqBpoHxA8
         ZgmEkwIFzFmqSCi3z5J68xV/4T7lVm1BVy290TuE6xbj8NBJ78J1/EvlQJXlNoXF8Xsa
         2dymNON4AA2itejB4G9QtbysIv/cAw9MYMpbuYBUw6YWuG3u5NVHnWQ1Vi09o3CuLA2O
         cppeH0qDIRezdmo0eUI7aRvg3Wd4FN+SCR/iZyEJUjuh+0j8Y11xoOgDOuE9jYc/MRJO
         7KTUdeNC2fMylpe5ovT+RBSo3IUzMlACU9B2ZJYbB6sNaZEQbcm/B5i8q046teXSOynU
         9LjA==
X-Gm-Message-State: AOJu0YzPx4HWlNtUMYnEe789Q+jm9c8UgN7o2Fuq0UQrzupQB0Xuoit7
        IEnL7hE5qXmEAr0clZK3MxYiSA==
X-Google-Smtp-Source: AGHT+IH8sGAfSfpsxitI4qviUODKu8mGIu277Y0nmf8tCnNCzyQivyiZEnHg3NpqlimZexz7mXJu3w==
X-Received: by 2002:ac2:457c:0:b0:500:daf6:3898 with SMTP id k28-20020ac2457c000000b00500daf63898mr5110630lfm.26.1700464380779;
        Sun, 19 Nov 2023 23:13:00 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.11])
        by smtp.gmail.com with ESMTPSA id p6-20020a5d48c6000000b0032db8cccd3asm10166457wrs.114.2023.11.19.23.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Nov 2023 23:13:00 -0800 (PST)
Message-ID: <b502d655-5b01-4e23-8100-237f3b38f94a@linaro.org>
Date:   Mon, 20 Nov 2023 08:12:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: dt-bindings: add DTS Coding Style document
Content-Language: en-US
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@amd.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nishanth Menon <nm@ti.com>, Olof Johansson <olof@lixom.net>
References: <20231116181218.18886-1-krzysztof.kozlowski@linaro.org>
 <3266223.44csPzL39Z@phil> <d8363bac-df41-416a-9043-f6212ad61e13@linaro.org>
 <7592981.EvYhyI6sBW@phil>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <7592981.EvYhyI6sBW@phil>
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

On 16/11/2023 21:33, Heiko Stuebner wrote:

>> 	regulator-state-mem {
>> 		regulator-off-in-suspend;
>> 	};
>>
>> What exactly would be here misordered?
> 
> going with the vcc5v0_host regulator of the rk3588-quartzpro64 and
> 
> +1. compatible
> +2. reg
> +3. ranges
> +4. All properties with values
> +5. Boolean properties
> +6. status (if applicable)
> +7. Child nodes
> 
> we'd end up with
> 
>         vcc5v0_host: vcc5v0-host-regulator {
> /* 1. */        compatible = "regulator-fixed";
> /* 4. */        gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&vcc5v0_host_en>;
>                 regulator-min-microvolt = <5000000>;
>                 regulator-max-microvolt = <5000000>;
>                 regulator-name = "vcc5v0_host";
>                 vin-supply = <&vcc5v0_usb>;
> /* 5. */        enable-active-high;
>                 regulator-always-on;
>                 regulator-boot-on;
>         };      
> 
> which I find somewhat counter-intuitive ;-) .

Yes, good point.

Best regards,
Krzysztof

