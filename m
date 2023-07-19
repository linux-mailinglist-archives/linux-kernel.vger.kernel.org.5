Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EFC759E2F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjGSTF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGSTF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:05:27 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B701BF7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:05:25 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b703caf344so107452631fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689793523; x=1692385523;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uxzu4bTwNO5BdcIxJkw1/nWB+CP9FwcUhHLLgewCkgw=;
        b=bhII2Uj+TkgnIjMm9sToEM5IW39MSLgMv2SVJAXa7OF8jwzzINNd/XuigFxHQKUOGi
         PcMsH5te8ILc8UFlgsgn1LPxw76s/7v+Kwz6nRfJmqRLmByrpsBR4DXLXPfaQ9goWtGq
         8qATDajVQY90BOwRwW0UGOLFm8OwZ/2KVRBYZv2hDKojVbQtxFvKaidB9AOORwelCPJ1
         VkYNVU0PqX7lysKjjmRT71I/8Fux5AERdcvGlnVZKELBP89KbrGah/2JgTAZwrlmo6ed
         Cmmdrl7XM0KOvdPco4h+qiz0C8/Wj7WoKGEiuK0Zve4LUntVjUJGnZWwtlO2cQjqtxav
         nXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689793523; x=1692385523;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uxzu4bTwNO5BdcIxJkw1/nWB+CP9FwcUhHLLgewCkgw=;
        b=axwZxNa6ZqdLjVArshf91Zed+qi4bOB+cjJa1PjvFekhENbocSrIBVphW+7AwLQCtK
         Mvgbgxc1JnFOSJIC1ooF+Tq+PisgC84a9i4SlRc/FYibP0bx79r/Vj2d9TkHcrL4EYUf
         xmoDBp6EeSnG8xAArYg0cjcncsfjAvG+sho25dSWh9lSj0lWWtdof9x0i5fV22Pg23/u
         Fn0SJmRx0CGUW0r0hKVWovkgdVCCSifFJz3O8CwRdIQ0NqBb35eTexugLyFBbv6/LJsl
         oMSwX8OUDvzNCd2LBY8cVodFaOn+BOhs7NQ0IjhxP29+/hcRDyWxyO7cwgu20oR1XBJ8
         rYcw==
X-Gm-Message-State: ABy/qLbf8sql74TSd8y8EGxERzsef8YN6A2a4Xoh12KUUQUzI+onPn3r
        8BjR3UGGGBx4soTd+qZokkLSVw==
X-Google-Smtp-Source: APBJJlHfDiWa6z/RIaWmCgcjPLMVIlHwrtDTsbKJH/hNfg/cg6myuLG7psXda3yupTjsCaobBA3dfw==
X-Received: by 2002:a2e:99cd:0:b0:2b7:14d4:ce6d with SMTP id l13-20020a2e99cd000000b002b714d4ce6dmr613499ljj.48.1689793523679;
        Wed, 19 Jul 2023 12:05:23 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id gx3-20020a170906f1c300b00993cc1242d4sm2692809ejb.151.2023.07.19.12.05.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 12:05:23 -0700 (PDT)
Message-ID: <74f81a77-6cba-37eb-54ed-e7570db47632@linaro.org>
Date:   Wed, 19 Jul 2023 21:05:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/3] pinctrl: qcom: sm8350-lpass-lpi: add SM8350 LPASS
 TLMM
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230619092735.20323-1-krzysztof.kozlowski@linaro.org>
 <20230619092735.20323-2-krzysztof.kozlowski@linaro.org>
 <851790f2-f673-f754-08b8-d07cc2c809fb@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <851790f2-f673-f754-08b8-d07cc2c809fb@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/2023 14:12, Konrad Dybcio wrote:
> On 19.06.2023 11:27, Krzysztof Kozlowski wrote:
>> Add driver for pin controller in Low Power Audio SubSystem (LPASS).  The
>> driver is similar to SM8250 LPASS pin controller, with difference in one
>> new pin (gpio14).
>>



> <       LPI_MUX_swr_tx_data2,
> 54d52
> < static int gpio14_pins[] = { 14 };
> 71d68
> <       PINCTRL_PIN(14, "gpio14"),
> 75c72
> < static const char * const swr_tx_data_groups[] = { "gpio1", "gpio2", "gpio5", "gpio14" };
> ---
>> static const char * const swr_tx_data_groups[] = { "gpio1", "gpio2", "gpio5" };
> 111d107
> <       LPI_PINGROUP(14, 6, swr_rx_data, _, _, _),
> 
> 
> 
> I really think adding just these pin14 entries to the 8250 driver would
> be a good idea..
> 


I could extend arrays with gpio14 and pass array size -1 to sm8250
variant and full size to sm8350. However the difference will be in:

-static const char * const swr_tx_data_groups[] = { "gpio1", "gpio2", "gpio5" };
+static const char * const swr_tx_data_groups[] = { "gpio1", "gpio2", "gpio5", "gpio14" };

I cannot create here variant "swr_tx_data_groups_sm8350" because the
name is used in macros. Using bigger (with gpio14) group for sm8250
should work, because there is no gpio14, but produces difference in the
controller:

-/sys/kernel/debug/pinctrl/33c0000.pinctrl/pinmux-functions:function 18: swr_tx_data, groups = [ gpio1 gpio2 gpio5 ]
+/sys/kernel/debug/pinctrl/33c0000.pinctrl/pinmux-functions:function 18: swr_tx_data, groups = [ gpio1 gpio2 gpio5 gpio14 ]

Therefore I will go with separate drivers.

Best regards,
Krzysztof

