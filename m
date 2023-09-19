Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25937A6307
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjISMcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjISMcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:32:17 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429F5FB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:32:11 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c02e232c48so7218831fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695126729; x=1695731529; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XZCTRZKVBnR2YvNg1LyLeXAm38TzOjpP7llM/IPFqls=;
        b=jAWvBMcFfHTVGseK9wCfyvhcrut5Dsz4bwLAIw3VMcubDFh5uVxW/At16DMn0fSOc/
         8wi9zQNyV6pffsRR2tSFX2x0jgH8o8N34Ir2BYPrOTON9ZcfB4ZoOflRx7y1lPGZvXyq
         XhBp/9UYZQNSQ9jQo1wd1v1BcmEEdhu8ZGXlMSlD+3b3enGBse4bNHsGki2Zo3H32v6p
         4JvuFD5Q9uqZ3pX/M6heTeM9KAkFLUpkTMNGB5G62/qVtXcLrvIE8U9UDSeGk0cu80FH
         x8m9w8Rqw53Zc9wNwg7OtlJlMY+z1ZQ06IaF6BUtL2zAgStuONcV4LE0HUcBc1+mZg5d
         T8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695126729; x=1695731529;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZCTRZKVBnR2YvNg1LyLeXAm38TzOjpP7llM/IPFqls=;
        b=Ic6sbS6JhnLaHa5BXe5VqCWmx4GgXlTh8IvUpAhNNbz/yYLTv6YwmZame9MKm2ghF0
         9rn0G4Kd1hRt7BMHZWlt9vx3/e04pHXoWtRsnpjzuPoG5g5uuOowJRXhFAbXAs4pNgJT
         FvGbljFIHGsB5I4iQORi3q9MVqYjUcUMe0rS5NQi5AvCIsHvXFYSfPwoLQgNf7IEqHR+
         EbqHrTsuyUfLPDuWrTyjUf3R6tRkuZdrSDNhlZupJFu2CTvInZ2haF4tCIxyPj3EKR8Y
         OZ8cObkvDde4Ferkds+JtgpQsGmuPeSKXw9sxNo0Bewf0w/wL1/7MSjOSCPBSJvq6NBu
         bzMw==
X-Gm-Message-State: AOJu0YzwQ1RfB6YEw2lvZYCxWYS3GWwjjMivbr6oCQrVgc3njaHJ3GDX
        QGC7RgU9YbXcvZjLdVA2mxb5IQ==
X-Google-Smtp-Source: AGHT+IEMvNDUAog01rs4CwdBpxpoQSIRanKceTDHHAqosvyR1dwGOfCcPWL5cZ8GFNVP5mNVQ3B+kQ==
X-Received: by 2002:a05:6512:31d0:b0:503:102c:7a05 with SMTP id j16-20020a05651231d000b00503102c7a05mr6997285lfe.58.1695126729291;
        Tue, 19 Sep 2023 05:32:09 -0700 (PDT)
Received: from [172.20.24.238] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id cx15-20020a05640222af00b005313c60165asm1811488edb.77.2023.09.19.05.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 05:32:08 -0700 (PDT)
Message-ID: <ee19e076-8f9c-c5b2-3e25-2832dbdab25b@linaro.org>
Date:   Tue, 19 Sep 2023 14:32:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2 1/4] dt-bindings: thermal: qcom-tsens: Add ipq5018
 compatible
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dmitry.baryshkov@linaro.org
References: <20230915121504.806672-1-quic_srichara@quicinc.com>
 <20230915121504.806672-2-quic_srichara@quicinc.com>
 <03b0cafa-49c7-8838-b116-927c9649cbd3@linaro.org>
 <f5aee51d-0345-1294-a85b-ea96ed937685@linaro.org>
 <1f09339e-b3b5-874c-4874-199e8c7ae890@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1f09339e-b3b5-874c-4874-199e8c7ae890@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2023 09:22, Sricharan Ramabadhran wrote:
> 
> 
> On 9/15/2023 6:15 PM, Krzysztof Kozlowski wrote:
>> On 15/09/2023 14:43, Krzysztof Kozlowski wrote:
>>> On 15/09/2023 14:15, Sricharan Ramabadhran wrote:
>>>> IPQ5018 has tsens v1.0 block with 4 sensors and 1 interrupt.
>>>>
>>>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>>> ---
>>>>   [v2] Sorted the compatible and removed example
>>>>
>>>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> No, unreviewed. Your driver says it is not compatible with
>> qcom,tsens-v1. This does not look right :/
>>
> 
>   Yes it is V1 IP, but since there is no RPM, to enable the IP/SENSORS
>   have to do those steps after calling init_common. Similar reason
>   added a new feat as well in patch #2 as well. Hence for this,
>   new compatible was required.

I dud not write about new or old compatible ("compatible" as noun). I
wrote that it is not compatible ("compatible" as adjective) with v1.

Best regards,
Krzysztof

