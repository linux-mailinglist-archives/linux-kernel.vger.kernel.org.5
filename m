Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6795577D491
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239537AbjHOUrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238693AbjHOUqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:46:33 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719462706
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:46:08 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51e2a6a3768so7938088a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692132366; x=1692737166;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7/OQUgxZSXGdXEOLudPU0bFyRRP7WuyPv3FT7DpWnT8=;
        b=nHZMv6M54PIa6JJHJm9nodNH2x1cC9DNjcRqerawVL/Vj1AnI/PA5aPr4hs9Z3NXVn
         kXdbayxSToqo4dOGno043q9kyV9Mlt8NqNTXDDfycLi3Y2dUAZ8xGJO8e24PPdgvMcaH
         JAjkQcVyUkesN+MyRJlfaRoK+AZupZpi/vKjV/vWsxb6HkTEB5xdW25cjg1jf3rWUIiV
         gu5XXibUw0QI1gJ81H/4sMmjNqo8/anFedoub+m6HRrgcuo+PdZYQSqC1SHzYvGkoMU1
         TW2RU9W27cMoI/HxMsWBPt0B2VB31Sbs2yE2gmGp+4K6nZSrF81SWnEI3TvuWndVwiSC
         jQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692132366; x=1692737166;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/OQUgxZSXGdXEOLudPU0bFyRRP7WuyPv3FT7DpWnT8=;
        b=BVrEl2D94t/+um8qZwVgM8d0DmC9LgXBgOFnb+iN7TSAY8ux9vPxblK45VM0kZWb1v
         heYVzlKi7URldbOrK4Mh1N6YREJyCt7BPql4xJ1LvkCRKIdVgXh1dY7C5B9UnMa/4e4H
         J1j6sxV7ij6o59qIA91R5TyAvRBG4pVxDJ8Kfta/tjKi6lXB9dV9z7nVD7ZOvBQIU3Xd
         HwvconBpOoInOYeFC2Je1anNL6L/wz1ph8ge1i1Sibhk7ckhHVZSws5LhCwpIwEJYlwA
         d4+h/rhx+DIGbf9FQecfgDt1XEyy+vLK0etgOPnYjPi9bWQSZh6LOxowUIePwOPz17NC
         MoDw==
X-Gm-Message-State: AOJu0Yy78c3RL6Z3WoVSCKfvvs16BvrgiKdKK8mbGgKXdQOsKBrysZF6
        hVpPo9MX4gTiXk7GU7Ieu3v2Yg==
X-Google-Smtp-Source: AGHT+IGPiWnjNSugY+loxPrGX2qhA7sV6YAHpRpRKKXWp8S9BK8vl6Fy8EerZC/9V6h+MV0jyGT8pg==
X-Received: by 2002:a17:907:7608:b0:99c:180a:ea61 with SMTP id jx8-20020a170907760800b0099c180aea61mr9891970ejc.32.1692132365721;
        Tue, 15 Aug 2023 13:46:05 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id k18-20020a170906055200b0099bd453357esm7451666eja.41.2023.08.15.13.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 13:46:05 -0700 (PDT)
Message-ID: <55d4090f-d2f3-ffb2-cc6f-a13222f14e47@linaro.org>
Date:   Tue, 15 Aug 2023 22:46:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: qcom: add sc7180-lazor board
 bindings
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230804095836.39551-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20230804175734.v2.1.I7a950de49ec24b957e90d7fe7abd5f2f5f2e24c3@changeid>
 <3ed8a34b-5f7d-6547-7e34-35e4d0994bba@linaro.org>
 <CAD=FV=WqFo5PFB7+7ZOQtsTLYojjTn1VkaAQpMkqvWUFPOmBQg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=WqFo5PFB7+7ZOQtsTLYojjTn1VkaAQpMkqvWUFPOmBQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2023 22:41, Doug Anderson wrote:
> Hi,
> 
> On Sun, Aug 6, 2023 at 11:32 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 04/08/2023 11:58, Sheng-Liang Pan wrote:
>>> Introduce more sc7180-lazor sku and board version configuration,
>>> add no-eSIM SKU 10 for Lazor, no-eSIM SKU 15 and 18 for Limozeen,
>>> add new board version 10 for audio codec ALC5682i-VS.
>>>
>>> Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
>>> ---
>>>
>>> Changes in v2:
>>> - add new entry rev9 with Parade bridge chip
>>>
>>>  .../devicetree/bindings/arm/qcom.yaml         | 55 +++++++++++++++++++
>>>  1 file changed, 55 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>>> index 450f616774e0..dce7b771a280 100644
>>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>>> @@ -470,6 +470,11 @@ properties:
>>>            - const: google,lazor-rev8
>>>            - const: qcom,sc7180
>>>
>>> +      - description: Acer Chromebook Spin 513 Parade bridge chip (rev9)
>>> +        items:
>>> +          - const: google,lazor-rev9
>>> +          - const: qcom,sc7180
>>> +
>>>        - description: Acer Chromebook Spin 513 (newest rev)
>>>          items:
>>>            - const: google,lazor
>>> @@ -491,6 +496,11 @@ properties:
>>>            - const: google,lazor-rev8-sku2
>>>            - const: qcom,sc7180
>>>
>>> +      - description: Acer Chromebook Spin 513 Parade bridge chip with KB Backlight (rev9)
>>> +        items:
>>> +          - const: google,lazor-rev9-sku2
>>> +          - const: qcom,sc7180
>>> +
>>>        - description: Acer Chromebook Spin 513 with KB Backlight (newest rev)
>>>          items:
>>>            - const: google,lazor-sku2
>>> @@ -512,11 +522,26 @@ properties:
>>>            - const: google,lazor-rev8-sku0
>>>            - const: qcom,sc7180
>>>
>>> +      - description: Acer Chromebook Spin 513 Parade bridge chip with LTE (rev9)
>>> +        items:
>>> +          - const: google,lazor-rev9-sku0
>>> +          - const: qcom,sc7180
>>> +
>>>        - description: Acer Chromebook Spin 513 with LTE (newest rev)
>>>          items:
>>>            - const: google,lazor-sku0
>>>            - const: qcom,sc7180
>>>
>>> +      - description: Acer Chromebook Spin 513 Parade bridge chip with LTE no-esim (rev9)
>>> +        items:
>>> +          - const: google,lazor-rev9-sku10
>>> +          - const: qcom,sc7180
>>> +
>>> +      - description: Acer Chromebook Spin 513 with LTE no-esim (newest rev)
>>> +        items:
>>> +          - const: google,lazor-sku10
>>> +          - const: qcom,sc7180
>>> +
>>>        - description: Acer Chromebook 511 (rev4 - rev8)
>>>          items:
>>>            - const: google,lazor-rev4-sku4
>>> @@ -526,6 +551,11 @@ properties:
>>>            - const: google,lazor-rev8-sku4
>>>            - const: qcom,sc7180
>>>
>>> +      - description: Acer Chromebook 511 Parade bridge chip (rev9)
>>> +        items:
>>> +          - const: google,lazor-rev9-sku4
>>> +          - const: qcom,sc7180
>>> +
>>>        - description: Acer Chromebook 511 (newest rev)
>>>          items:
>>>            - const: google,lazor-sku4
>>> @@ -545,11 +575,36 @@ properties:
>>>            - const: google,lazor-rev8-sku6
>>>            - const: qcom,sc7180
>>>
>>> +      - description: Acer Chromebook 511 Parade bridge chip without Touchscreen (rev9)
>>> +        items:
>>> +          - const: google,lazor-rev9-sku6
>>> +          - const: qcom,sc7180
>>> +
>>>        - description: Acer Chromebook 511 without Touchscreen (newest rev)
>>>          items:
>>>            - const: google,lazor-sku6
>>>            - const: qcom,sc7180
>>>
>>> +      - description: Acer Chromebook 511 Parade bridge chip no-esim (rev9)
>>> +        items:
>>> +          - const: google,lazor-rev9-sku15
>>> +          - const: qcom,sc7180
>>> +
>>> +      - description: Acer Chromebook 511 no-esim (newest rev)
>>> +        items:
>>> +          - const: google,lazor-sku15
>>> +          - const: qcom,sc7180
>>> +
>>> +      - description: Acer Chromebook 511 Parade bridge chip without Touchscreen no-esim (rev9)
>>> +        items:
>>> +          - const: google,lazor-rev9-sku18
>>> +          - const: qcom,sc7180
>>> +
>>> +      - description: Acer Chromebook 511 without Touchscreen no-esim (newest rev)
>>> +        items:
>>> +          - const: google,lazor-sku18
>>
>> All of these entries (existing and new) should be just one entry with:
>>  - enum:
>>      - ....
>>      - ....
>>  - const: qcom,sc7180
> 
> I believe we've had this discussion before. At least twice. Here's a
> link to the last time you said "Ah, OK, I guess this is fine".
> 
> https://lore.kernel.org/r/d3d4d90b-85b5-5ad9-78e6-5a074c21af4f@linaro.org

Current solutions brings descriptions, so it has some benefits... I
guess this is fine for third time. Maybe this time I will remember...
Although I keep coming with several same questions to all SoC
DTS/bindings which do things differently than common case. I will be
coming because that's the price of doing things awkwardly or differently
than everyone else, e.g. overriding by full DT path like in Tegra.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

