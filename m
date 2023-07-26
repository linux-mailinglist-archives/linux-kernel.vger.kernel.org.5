Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A15763ED1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjGZSrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjGZSrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:47:08 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7EC1FEC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:47:05 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fbaef9871cso211710e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690397223; x=1691002023;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DoNr41tGBWXp3avhlR4Ok0kkS9MDJL40PJEw7jr86GQ=;
        b=TMbSmNVHJfi25lv/O4PhUkZsuUECLgf9LzvjGlofvLtL+GUkiSSAP4/xiRlXQvskLO
         faddlbjaIpRQ9WQ6GCYK35xL81XQ1R9/5HgJNOc5N1sxVj9hwoU4uKGgNrp5UvosIfoA
         Ne16I960rWPcMwJghMjZMOiabFwDzdx8/9nuat3XHjz/tkFlR5/fhP3K5xT3yuDoO10h
         Mw74P58GDlNxNUUdWiR0J7o9BWZ1VmXSCDj08DqrKb+RVpzsgEk1KEHEa7pjOFsBL3j/
         vQFjgmH0and/UynAoDuch2scR8c6APkM9asNZadLR6nocSwA8/JULovMu4TJmCyyJAuM
         mhbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690397223; x=1691002023;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DoNr41tGBWXp3avhlR4Ok0kkS9MDJL40PJEw7jr86GQ=;
        b=Q2PqgURqg/mTVdHnP1mvRxdmktaUGtus8pNE/fC7i/rh5OEC5MIuRHAnz0MniQk4YJ
         HLYjTJV7/4je/bnWcSrEqEwo79sJgE+TYSkeVue6n8hJf9B0GsLICRSezHtrVXQP7Eu8
         O4KVpNUg4zhiqhcrrimFa/WY/An/pUm1TYzfYoopOHf9zQ2lvBrJfcSRFezE3s1v0BLe
         +9kPmmj9BN0aRONNuqpc77Ai71pIA25NuuYrEA6rciovGB0ChVrX1DLq7uNIhKM6cBcK
         usV2OudhNIkO+CayjJF3qWA5TZ7nCRvIJSwXdkwIPAWUZRZrKL6c+KOeae/m1oNPP/V3
         nK0w==
X-Gm-Message-State: ABy/qLZ9bceqpjQ/4mx6wdGfrqzs/wiMCJsXIyhTVszFtOACWNvAFkta
        4G/stnCE5hNDww/i+pba7fOGJQ==
X-Google-Smtp-Source: APBJJlEXJbOsjrE/15dB7NjD+ZINdAiDrOZ7mX0KhXkt36CxGyF07k3vSeHIlGjhqVKVSkGMVE7dJA==
X-Received: by 2002:a19:f00e:0:b0:4f9:5933:8eea with SMTP id p14-20020a19f00e000000b004f959338eeamr30981lfc.3.1690397223510;
        Wed, 26 Jul 2023 11:47:03 -0700 (PDT)
Received: from [192.168.1.101] (abxi164.neoplus.adsl.tpnet.pl. [83.9.2.164])
        by smtp.gmail.com with ESMTPSA id q8-20020ac25288000000b004fcdf8b8ab4sm3475652lfm.23.2023.07.26.11.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 11:47:03 -0700 (PDT)
Message-ID: <31324276-9222-aab3-533e-6aae5fec4751@linaro.org>
Date:   Wed, 26 Jul 2023 20:46:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] arm64: dts: qcom: sm8150: Fix the I2C7 interrupt
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        qaz6750 lzy <qaz6750@outlook.com>, andersson@kernel.org,
        agross@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <SY7P282MB378740C6070900BEBF5D0D7CB203A@SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM>
 <8bd8fa38-551b-35dc-cb6b-7c5fd79dc0a0@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <8bd8fa38-551b-35dc-cb6b-7c5fd79dc0a0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.07.2023 20:46, Krzysztof Kozlowski wrote:
> On 25/07/2023 10:42, qaz6750 lzy wrote:
>> I2C6 and I2C7 use the same interrupts, which is incorrect.
>> In the downstream kernel, I2C7 has interrupts of 608 instead of 607.
>>
>> Fixes: 81bee6953b58 ("arm64: dts: qcom: sm8150: add i2c nodes")
>> Signed-off-by: qaz6750 lzy <qaz6750@outlook.com>
>> ---
>>  [v2] Fixed issue of not using full name
> 
> You mentioned your full name as a bit different, so I am not sure what
> improved here.
To be clear: "real name" usually means "the name that is present on your
government-issued ID card.

Konrad
