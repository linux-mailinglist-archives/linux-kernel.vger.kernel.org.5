Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E12762DDE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjGZHg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjGZHfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:35:37 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5FB30EB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:34:19 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5222bc916acso4132098a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690356857; x=1690961657;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X+2Iliu7olik+NE8AfcvBGi3cE5KanWV2uC3MeiDPS0=;
        b=KlbDSOyYOBAThy3vB3vgl/3WnwAqdpLGHR77DAe4G0S14mkuzuFvWUPp9oZx7cx/OT
         P0lMKSm380e+eVPZjLbuFlR+a9eyRKKPUwtPMw9MsKE8ljq4ElNQhrSbLEGO0jTNxKrw
         ZnRGBCi6omqYmQyhFU0VuJ7VwgrlCaYvSWi9gKwAgVmKvFDNMtEtnGeVvN04827uwu4q
         Ho1fQQJv4ucUZoc6ZUXFLXHyBBGw5zIAj6PmafAN/HMBtTVrRysoS9JSYaYCU1vAmHNc
         x7bj43PSH4rTLxRfkyxaLSvxHVwthO6XswOuLLxw1eZTk3HhexY+Si+DRP7d4XZJnXOd
         lpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690356857; x=1690961657;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X+2Iliu7olik+NE8AfcvBGi3cE5KanWV2uC3MeiDPS0=;
        b=lmRVXB4YrnHy6MVSAZpIua0LqZcePiCMGWBzJOXuUJtOCojBxIXH+Rt1irhhhszMYh
         MfSu/7lFr1Jf6+Fbu1YHV4bXU1DyZrik1cRUGljUWZ8Li003DwvzAn6tOPNL73y2PB4+
         detfCdu5dJCYpXyeOAG21VSuDk0ffBsdoFqn4ilyxTq2bBFX5ENLX9PwEV1gBWsLyMfc
         FHFHi15PHvEeWe03GwrSn6lm/V+Z8l+bHtG0BjxdcSphwDu5dht+873qtOc+s9GuHQ4l
         Tr2Ve7MNMX4r1Iy/A3z91RWULKxU9Xuy3219vVJeRp9lN5+H2ExJd1yjJpQYEKTmf5jx
         HukA==
X-Gm-Message-State: ABy/qLYhjYdgYXzwxtjh3B270e/vlzdb6vkHy2Du4tzYzb+qceW5zAHA
        P9+CBnvGjmCGmW1eunVg38OMRA==
X-Google-Smtp-Source: APBJJlGR74zoKSYMwGskCgm5We2h4GhUdIEQdlH5TbM9FGnhgnA8mXhCNaiYrij4RkXzRuiIheq8iQ==
X-Received: by 2002:aa7:da0b:0:b0:522:2111:1063 with SMTP id r11-20020aa7da0b000000b0052221111063mr815433eds.18.1690356857657;
        Wed, 26 Jul 2023 00:34:17 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id d14-20020aa7d5ce000000b00521cb435d54sm8575934eds.37.2023.07.26.00.34.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 00:34:17 -0700 (PDT)
Message-ID: <d9cb0908-4074-2f01-efaf-cdd863a039f2@linaro.org>
Date:   Wed, 26 Jul 2023 09:34:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: Add BQ Aquaris M5
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        =?UTF-8?Q?Andr=c3=a9_Apitzsch?= <git@apitzsch.eu>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230724-bq_m5-v1-0-17a0870a73be@apitzsch.eu>
 <20230724-bq_m5-v1-1-17a0870a73be@apitzsch.eu>
 <877c6d2c-430f-b1fb-4267-18be5d7256dc@linaro.org>
 <d51dee67-02f4-1256-877f-61629c04b08f@linaro.org>
 <a90461fa-8319-5b87-397f-53ba169a3d31@linaro.org>
 <1717ccb1-46b3-8ac3-2c09-9558bd12cc40@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1717ccb1-46b3-8ac3-2c09-9558bd12cc40@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2023 12:03, Konrad Dybcio wrote:
> On 25.07.2023 11:43, Krzysztof Kozlowski wrote:
>> On 25/07/2023 10:13, Konrad Dybcio wrote:
>>> On 25.07.2023 07:46, Krzysztof Kozlowski wrote:
>>>> On 24/07/2023 22:52, André Apitzsch wrote:
>>>>> Add a compatible for BQ Aquaris M5 (Longcheer L9100).
>>>>>
>>>>> Signed-off-by: André Apitzsch <git@apitzsch.eu>
>>>>> ---
>>>>>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>
>>>>
>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>
>>>>
>>>> ---
>>>>
>>>> This is an automated instruction, just in case, because many review tags
>>>> are being ignored. If you do not know the process, here is a short
>>>> explanation:
>>>>
>>>> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
>>>> versions, under or above your Signed-off-by tag. Tag is "received", when
>>>> provided in a message replied to you on the mailing list. Tools like b4
>>>> can help here. However, there's no need to repost patches *only* to add
>>>> the tags. The upstream maintainer will do that for acks received on the
>>>> version they apply.
>>>>
>>>> https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540
>>> Krzysztof, update your bot to paste this link with s/v5.17/latest/g
>>
>> Is there any difference? :) I would need to update links in all my
>> templates and re-check the links...
> Don't know, but the keyword "latest" in the link always points to the..
> latest available release

And how do you update the line marker in "latest" version, so it points
to exact line I want? I could switch to latest kernel doc and point to
chapters, but then not to specific lines.

Best regards,
Krzysztof

