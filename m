Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE3F7FEC94
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjK3KLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjK3KLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:11:17 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1313F10C9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:11:24 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54af4f2838dso693845a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701339082; x=1701943882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BQKXf1q2OEZnZ3kEZQU0tyP5ahd6SKR/Xu20SNGKyvI=;
        b=q0m9yJqtu2DQf/EE1EwzftGf3pDLx3OYr3s10XvOXPS10UzyY8L+o6cnbyHBy0PsNd
         pTbRkUPYlkzJ0uKboXQcbRYzQ+7NwHaJ9k+3UbXaEK5tl6e6/5kOyau5TIfa4TLOO/Te
         4CF4dXl14h/0TLvAhPgqtlJJXNA+rejXHhePeS5SxDvVjq9N3ZhqsqXEzxNh7e1tAD3R
         NIeG1as7ZFCN56gnlXZ0jG2GZ3EOUFS6+Gp8Jd5n9UiT+5dAq0gW1xY+0T/w21qxKfAL
         rPfqIRTqr6VC8aKhmXo7IHzfAlYtwTaaca0CXJ2gZWz9ZYxb5A7TfQ2E0AIrCBTd16dP
         zgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701339082; x=1701943882;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BQKXf1q2OEZnZ3kEZQU0tyP5ahd6SKR/Xu20SNGKyvI=;
        b=lGjoahD+a3qviM0AchV+EFJrd8AzeDTMYLBsa6PjwFW0Cu5RaGtYJX91WvMuXjq4Ap
         vVXf7EbfnsyNgFhjNH3n9WWZpjZxgH5/aTo+MOZlmMP511PsMEeS600bcwgFRsRAuUQX
         q9vER3t5Bz+8Iw3EzER6pzmpPIfdWnYnkVY9JxHVqBaKa7WDcNX+L38uZ13wkWMJtfOq
         1ll2u+59vOEn51J/Hwo2iwCOO6255N88g16oph0+Z3gy1wGBs+HB6rHYu/KCktvauf5+
         U6zjYWZ8RMq49fIAUjcxMEpW9pON//fz0rRPxY42z/8NylHSnfTYFuNHx+C+ne5F7UC5
         k/tg==
X-Gm-Message-State: AOJu0YxOAtmJ+wCScPjQwwxkNcn228d1KkAiBXqtA2C0mXaoY8Ov8CdA
        0WQ7Pd7ktPk3IkMm9w6LiQ2m5I/TfM0rlr8dWbg=
X-Google-Smtp-Source: AGHT+IG3ruccL35j76zEEvNRMlePh8SiM5AZ0WyM0wpJQBtIO9fxbhSqjZBvKqiH0QLtO6/n8eTOJw==
X-Received: by 2002:a17:906:2756:b0:9bd:9bfe:e40b with SMTP id a22-20020a170906275600b009bd9bfee40bmr13385846ejd.75.1701339082444;
        Thu, 30 Nov 2023 02:11:22 -0800 (PST)
Received: from [192.168.209.83] (178235187166.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.166])
        by smtp.gmail.com with ESMTPSA id r21-20020a170906281500b009fca9f39e98sm504965ejc.26.2023.11.30.02.11.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 02:11:22 -0800 (PST)
Message-ID: <1e014d8c-9a46-4a99-bca2-9f84598bd614@linaro.org>
Date:   Thu, 30 Nov 2023 11:11:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8550: correct TX Soundwire clock
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Neil Armstrong <neil.armstrong@linaro.org>
References: <20231129140537.161720-1-krzysztof.kozlowski@linaro.org>
 <20231129140537.161720-2-krzysztof.kozlowski@linaro.org>
 <3ec70fd9-11a3-4bd3-bd8c-a73c3d44dcde@linaro.org>
 <0be610ed-ac95-4de1-9639-d634cf979359@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <0be610ed-ac95-4de1-9639-d634cf979359@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.11.2023 09:06, Krzysztof Kozlowski wrote:
> On 29/11/2023 15:35, Konrad Dybcio wrote:
>> On 29.11.2023 15:05, Krzysztof Kozlowski wrote:
>>> The TX Soundwire controller should take clock from TX macro codec, not
>>> VA macro codec clock, otherwise the clock stays disabled.  This looks
>>> like a copy-paste issue, because the SC8280xp code uses here correctly
>>> clock from TX macro.  The VA macro clock is already consumed by TX macro
>>> codec, thus it won't be disabled by this change.
>>>
>>> Fixes: 61b006389bb7 ("arm64: dts: qcom: sm8550: add Soundwire controllers")
>>> Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>> Interestingly, downstream 8550 has
>>
>> qcom,use-clk-id = <VA_CORE_CLK>;
>>
>> which doesn't seem to be used in techpack
> 
> In which node? I see it in the va-macro node, not the tx-macro.
You're right, I misread this.

Konrad
