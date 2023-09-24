Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD5B7AC7CA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 13:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjIXLpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 07:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIXLpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 07:45:13 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73E5101
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 04:45:06 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31f7638be6eso4532826f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 04:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695555905; x=1696160705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bfo+tbTQVTfcB3muEtJ5dcAI76Wff7ckKMaMA7hGJTc=;
        b=mem4Gj/ALL5KmE+GqBobzCFoByRTLQrhDm+bsx2yj7BTmWi35kVTl+bSpbpEjhtKtb
         2HLj4REEhbEOFrDk0ZR8uAFwXQ5fgS0m+eEF7ft8DVbZJbo1hMsyaKLP+kJo5c1icU8N
         2B+mAcYGQLD5rid+ktVMS5B5fOdReUaiG+Hj0NJJgz70xMjY5YmKKlj2WrfOKSpANXC/
         HwDZdVccXtgHjuW8BHGewq4oImC4JhPKjpuDF8aZPTEdLRuB9Knfg5/ilmVmEw55RQbO
         Z47AwwybN7m86WHppRh26Fr2B8HIBsQU/7EYLCl9H1rkL1h02tk8d/DaU73nb6RKfABo
         XcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695555905; x=1696160705;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bfo+tbTQVTfcB3muEtJ5dcAI76Wff7ckKMaMA7hGJTc=;
        b=FfCq+3SAl9S6AXWCD5qWyvWqUFC5XG6smr51/shJMyulNcbGBLv9uXHLRyw2UPUS79
         TjNKBF5+tAAMkKm8pyIS8KfbH1+RMpL/Cfhdo3BJReW6Z18r4gjOKV1T9+PSHRz9ar0a
         +ZVq5/4LVgIQxCDSYu7NgzNOv+bUncGvWLPEoc3ehhrDyjcUXonub+rGlqnPiFXxQSlE
         CUw1OrF4svpjtRQ4VEV8XE+W0GQBAMtFp0vOLjlqF5Eiljngl3VJ+phQWP0qMM+0YjM+
         JLybzSAFjwAbqEvLqnnQc2o0nN8PTULULyZDB+VphornzvY0S9C6ovC0RHMoSWzqxRBw
         vLHQ==
X-Gm-Message-State: AOJu0YyTLmdDQmknceEbiF4fhAh1sA6sQApME+fc7WircirCauCxWjEh
        MecCtjzrKifmZcwizzEakfIUHA==
X-Google-Smtp-Source: AGHT+IEatxzY4iGxij3aKDiWG2DKIBpfinUH0KyqJo8wPunfVfcVbwDKYCOzxb44z/Samx/U6zZbBg==
X-Received: by 2002:adf:e791:0:b0:31f:fab1:c3c3 with SMTP id n17-20020adfe791000000b0031ffab1c3c3mr3898673wrm.35.1695555905240;
        Sun, 24 Sep 2023 04:45:05 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id m12-20020a056000008c00b0031f3b04e7cdsm9077174wrx.109.2023.09.24.04.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Sep 2023 04:45:04 -0700 (PDT)
Message-ID: <53e67234-1dc3-0f23-c4c4-6622828a24b9@linaro.org>
Date:   Sun, 24 Sep 2023 13:45:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/4] dt-bindings: clock: qcom,camcc.yaml: Convert
 qcom,camcc to a single yaml file
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jonathan@marek.ca, quic_tdas@quicinc.com,
        vladimir.zapolskiy@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230923150045.1068556-1-bryan.odonoghue@linaro.org>
 <20230923150045.1068556-2-bryan.odonoghue@linaro.org>
 <2565aa33-619c-6c90-de96-29dc5ac5d961@linaro.org>
 <fac95d85-0802-4819-9efe-a31e6df7a0e4@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <fac95d85-0802-4819-9efe-a31e6df7a0e4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2023 12:20, Bryan O'Donoghue wrote:
> On 23/09/2023 17:13, Krzysztof Kozlowski wrote:
>> On 23/09/2023 17:00, Bryan O'Donoghue wrote:
>>> Move the various camcc yaml files into one. The Camera Clock Controller
>>> is pretty similar from SoC to SoC.
>>>
>>> Mostly we have some SoCs which require fewer clocks than others. In some
>>> cases we have SoCs which have required-opps and required-power-domains.
>>>
>>> It is likely we could and should extend the thin CAMCC descriptions such
>>> as sdm845 an sm6350 to the more robust descriptions such as sm8250 and
>>> sm8450.
>>>
>>> As a result of listing sm8250 and sm8450 together required-opps and
>>> power-domains become required for sm8250, which is a NOP for the dtsi
>>> since both declarations already exist for sm8250.
>>>
>>> sm8250 is also chosen as the example for the new combined camcc.yaml.
>>>
>>> A minor tweak to fix Bjorn's email address in the Maintainer list is
>>> included.
>>>
>>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>
>> No, that's not the right approach. For GCC and CamCC and all other
>> Qualcomm clock controllers, we split into device schemas, not merge into
>> one. The one schema is just becoming unreviewable over time with
>> multiple if:then clauses.
>>
>> Please use approach like we have for GCC, RPMh interconnects or remote
>> proc loaders - common file. What's more, here you probably don't even
>> need common file because it is already there - qcom,gcc.yaml
>>
>> Best regards,
>> Krzysztof
>>
> 
> Ah OK, I see what you mean.
> 
> commit f8cc21d454c50157a528c900b60aa9588b4066b3
> Author: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Date:   Tue Dec 27 15:40:56 2022 +0100
> 
>      media: dt-bindings: qcom,venus: split common properties

Yes, except that in case of camcc it might be enough to use existing
gcc.yaml

Best regards,
Krzysztof

