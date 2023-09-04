Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737BF791B23
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 18:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345103AbjIDQJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 12:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbjIDQJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 12:09:37 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C386CD7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 09:09:33 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bd6611873aso24283681fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 09:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693843771; x=1694448571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MS9NE2CNJ35SnPex0XMzCBjM3M/pOjkRvvlo6ye2ZQE=;
        b=RgPAArrErPvimG7axl/IhYGn6HbA6AxKemSAS5W4PD7OqgI7gL47DRq+vujSvTku6U
         p+Ja8kD83EzjwQdjfCj8Vzbil5+KPOJfhsyOmJ7a0VXEK+GWZ44ArOD8TZJnSayT5ejd
         41u+Ug09ZpPpYofiZQWZm0eNtGbgH8KfKtBAb6f1ZP028Hk3Tfq7ADCkLxdectmYzJN2
         FM7Vl+aapRX7xxrt2tnYUKgMlNRi2Zloym1whCwGNXv/RgqeGfEYloxuOxHBBAe5K0v9
         GLa/XYZrKF+lpQYQS2FQ+EsX1ERZsMTe8U99xYIg156knIawwsywkI2stz2joFCZJkpZ
         Y4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693843771; x=1694448571;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MS9NE2CNJ35SnPex0XMzCBjM3M/pOjkRvvlo6ye2ZQE=;
        b=k/IrjUA4Hzx04SBKMa6H7Nzqym6U/l10fWxD8yjSfXaIJEXpm1EKXrU+fqQcYAKzyO
         anf/qxMjAoC3SEE7BmbL2YeE58+F2gEpqv6RdTETCGVhNCbCB2OyUoBOGP6Yrsm7fa0L
         hC2uIuqGvyMWvlX5kUYMQZ8At1HMAqDpYRdb8yW0WyyjxMllp+qKp7iff7yO6msZQIrp
         8pGwJvhF+BfilJqMxwn2sgcgeCgTaEUWzmFlIZe09shncDll8hBVWIzc84PnVjQaFVSw
         bxhgqI6J2DTUUZcEGIp0mQ2rzL/jBnq7bEmrYATtB+Wis12JqjogfJvSrG1QD61ESUUp
         MYXg==
X-Gm-Message-State: AOJu0YwV8WkTZ28eyowAOvtUqS7LcZt2Xd6p9oviiwLqtkaDSEctHGlJ
        dO/nIYrrlUESjpeWXplgigWwmQ==
X-Google-Smtp-Source: AGHT+IF8gHeYqYu3zEoRQDtidaBPWhbjm2fTKB8jASr7Phrtjhk8pkWTjrblay+eDVhMQk2dtHo9DA==
X-Received: by 2002:a2e:98c9:0:b0:2bc:d33f:3e8f with SMTP id s9-20020a2e98c9000000b002bcd33f3e8fmr7292563ljj.53.1693843771469;
        Mon, 04 Sep 2023 09:09:31 -0700 (PDT)
Received: from [192.168.1.101] (abxj43.neoplus.adsl.tpnet.pl. [83.9.3.43])
        by smtp.gmail.com with ESMTPSA id v2-20020a2e9602000000b002b9fe77d00dsm2226210ljh.93.2023.09.04.09.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 09:09:31 -0700 (PDT)
Message-ID: <d84bbada-cff6-4752-90e9-cff39e32b92d@linaro.org>
Date:   Mon, 4 Sep 2023 18:09:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: msm8916-samsung-j5-common: Add
 accelerometer
Content-Language: en-US
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>
References: <20230904123123.2593-1-linmengbo0689@protonmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230904123123.2593-1-linmengbo0689@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4.09.2023 14:35, Lin, Meng-Bo wrote:
> From: Markuss Broks <markuss.broks@gmail.com>
> 
> J5 and J5X have ST LIS2HH12 accelerometer.
> Add support for it.
> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> Co-developed-by: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> Co-developed-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
> ---
Why is i2c-gpio used? Is it normally accessed through ADSP?

Konrad
