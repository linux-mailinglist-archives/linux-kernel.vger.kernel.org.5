Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1ED475FC9A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjGXQxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjGXQxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:53:34 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C7D83
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 09:53:33 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fba03becc6so7088776e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 09:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690217611; x=1690822411;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jWZptjp672pbp4wzzJy6KeaAirSS9I7O5nIJe9tdEzY=;
        b=NUFW5LacpSrWKBpUVwg9TdSXCA1VzXv7SpzwDP65J3DZoajaxT3XrOJlH4Q7ILxc4w
         Sb+tSidXIezqWOVV614Drj6mJ7plQVN6zMUtmxIN6EIb3nkkrKjOYgozTJ1jRTYvTgLv
         eSfoVSv+YVPd6bDYWeLdi4ue4zHPQ6t0kN6dGHPxKFxO8vkOvW5aAjvG6LZD47lRTqnf
         Xlbs8d2zczzn3/f+qZ+/G6WS8K/+PCdPvdjfpBqw21rq2QQQqUFENwvWHPPCuqQdkpq5
         S7UQKZnMnRLFz73LmPH767ygf+O+rDCklZELA01dLhkuhCN5uWKvm6WrABrjMjJgfGLo
         rgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690217611; x=1690822411;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jWZptjp672pbp4wzzJy6KeaAirSS9I7O5nIJe9tdEzY=;
        b=NYBK6EDmMRHV7q7+afYtpn2eKsaWj7Zy7PSC73KjC30oCjoJl0LGQAXuek+00kBSSb
         qLcizI7ihPYwyVNbQ+/2Zg5yU4ttnFzTYh3Ivd22Wpw8HnwO0t+QVxWr6M3aLn3jLIm+
         R6O35/Hq2XWlBlvimG6JKHDJcZEcRSZnK7Q0duvObyCce1Ep27ycQCdk+cHvuOLgdVAe
         h+FWw+zDSlfgnnLHWxKO4CDZ378BoOSBwGHJm2SmAiE+AFQY474CeShNwrgDiMEYUzqr
         F4eA1kDIe6dZNrHxSS4viS6u2yAFwcTkw6hmzDhRPtt89mD8tE7F1vW1FHyMuPRRALn4
         3K5A==
X-Gm-Message-State: ABy/qLaNHTZDWhxbphuN3uJkeyhuHsB0TfVNq5d8o6PcNGOUZ2yotzs1
        1npi6m0Tmh+8qDJS5ACRm12SnA==
X-Google-Smtp-Source: APBJJlGff6Eibus0NpUSXEkq9nY3qVv+uHU1rPkbA34ItoNmb4uZeRNJElQTtyuQzbtl13FP01Ubhg==
X-Received: by 2002:a05:6512:108f:b0:4ef:edb4:2c77 with SMTP id j15-20020a056512108f00b004efedb42c77mr5383749lfg.11.1690217611471;
        Mon, 24 Jul 2023 09:53:31 -0700 (PDT)
Received: from [192.168.1.101] (abxj221.neoplus.adsl.tpnet.pl. [83.9.3.221])
        by smtp.gmail.com with ESMTPSA id z18-20020ac24f92000000b004f640b0fb04sm2297878lfs.212.2023.07.24.09.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 09:53:31 -0700 (PDT)
Message-ID: <aa3c95f5-69a8-678a-307a-25bd0ae51a94@linaro.org>
Date:   Mon, 24 Jul 2023 18:53:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm8150: Fix the I2C7 interrupt
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        qaz6750 <qaz6750@outlook.com>, andersson@kernel.org,
        agross@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <SY7P282MB3787F073ED6E860E820C6CDDB202A@SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM>
 <898f8e84-de31-8147-ebb3-cef41f22868f@linaro.org>
 <58475de8-8636-d9e5-d91b-bb61f77d6cca@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <58475de8-8636-d9e5-d91b-bb61f77d6cca@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.07.2023 18:52, Krzysztof Kozlowski wrote:
> On 24/07/2023 18:29, Konrad Dybcio wrote:
>> On 24.07.2023 18:21, qaz6750 wrote:
>>> I2C6 and I2C7 use the same interrupts, which is incorrect.
>>> In the downstream kernel, I2C7 has interrupts of 608 instead of 607.
>>>
>>> Signed-off-by: qaz6750 <qaz6750@outlook.com>
>>> ---
>> Fixes: 81bee6953b58 ("arm64: dts: qcom: sm8150: add i2c nodes")
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> But we also need full name or known identity, not anonymous contribution.
Ack, I overlooked that.

Konrad
