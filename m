Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED9B75499E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 17:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjGOPJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 11:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjGOPJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 11:09:52 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA4130E2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 08:09:49 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fb761efa7aso4837479e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 08:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689433787; x=1692025787;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=amPlcbDpulTFOsow/YvicAIG+61RE4wSP76UghvZkDc=;
        b=LjFCnFxnREZGUDfhT4VW51KlYy0xfK1JrVIPprVF/fTyRuXnzlSJCcR3D2G2zyGHwz
         CFv+FkkBMwc3AHzSBmW3W07hZD00AZmFjGEX46gs2cp+Yrq6Q8phQCXeD4I+vqZNHVWk
         mnk+ep4pTkwvvpwBrpbOqJW5nBp4KtF+PG7bQNQD+nt3/TLzom7rnUDL/gnOy/9WxG6Y
         6vdlUseXij7Tpx8Xs3lZz/m/vibG+LJKGUD0ObReboZaZDNHA7LO/SQSjqWVOsFQvkXb
         aGku7+AYktrHEiLOUB+NswqcuFof9OunuEs4FNBuaryWPI8OKhNCjpQIHYhdPj9pCjIE
         zxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689433787; x=1692025787;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=amPlcbDpulTFOsow/YvicAIG+61RE4wSP76UghvZkDc=;
        b=K8USOxbe7C7UAPmncGz3I/4jmYt56dyEyn3RpmMgpFHgjXMoWZyHKnUGzmcZkBkIkl
         hFFXHH4UfDK3Hd5bTG3rhCL8hqSf1U+M6XVmI8D8DkVYoys8Ynmj8iNOtxyHQ+9DXVoI
         OvKznEGMvErsSRW5EriJiL4If/hJEUmTpfKeOFd7rHQMQWjFj7EyYFcIIrztnvCpqYOe
         YPnXqYuCq/UUBVJmmQei4nwCmyHyqXAhw5n2/e70xSpfDyANn8tyzxo6O4J85utrzv1k
         3EWF3i1kXYs3Trl5dmljRVYB+xWlU0LkX7Di0jQJFQmtPWo0UW1Jl5ZsGyE6Zo0Ierp/
         MBEA==
X-Gm-Message-State: ABy/qLah5NIG387dU00ntxVOIcT1V4+BlV62C8QPs9tqEaUen1WBFcE7
        KETsltui9wzZQ9DTlgknjbpJdA==
X-Google-Smtp-Source: APBJJlEEbjLVhNpZlgevCjtFWDFvRtWdujxLD4TiNGl4wp+NxSuW5PaSXwBmHfbr2c6ro1RfEOb37A==
X-Received: by 2002:a05:6512:3985:b0:4fd:b7fb:c9fa with SMTP id j5-20020a056512398500b004fdb7fbc9famr168026lfu.42.1689433787515;
        Sat, 15 Jul 2023 08:09:47 -0700 (PDT)
Received: from [192.168.1.101] (abxi167.neoplus.adsl.tpnet.pl. [83.9.2.167])
        by smtp.gmail.com with ESMTPSA id j13-20020ac2454d000000b004faa2de9877sm1932342lfm.286.2023.07.15.08.09.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jul 2023 08:09:47 -0700 (PDT)
Message-ID: <269bd956-6cf3-2215-a7ab-1b6b8b84b6d4@linaro.org>
Date:   Sat, 15 Jul 2023 17:09:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 01/53] dt-bindings: interconnect: qcom,icc: Introduce
 fixed BCM voter indices
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
 <20230708-topic-rpmh_icc_rsc-v1-1-b223bd2ac8dd@linaro.org>
 <3b733848-2745-e6ef-f517-039712bbe7af@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <3b733848-2745-e6ef-f517-039712bbe7af@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.07.2023 22:39, Krzysztof Kozlowski wrote:
> On 11/07/2023 14:18, Konrad Dybcio wrote:
>> It makes zero (or less) sense to consume BCM voters per interconnect
>> provider. They are shared throughout the entire system and it's enough
>> to keep a single reference to each of them.
>>
>> Storing them in a shared array at fixed indices will let us improve both
>> the representation of the RPMh architecture (every RSC can hold a resource
>> vote on any bus, they're not limited in that regard) and save as much as
>> kilobytes worth of RAM.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  include/dt-bindings/interconnect/qcom,icc.h | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/include/dt-bindings/interconnect/qcom,icc.h b/include/dt-bindings/interconnect/qcom,icc.h
>> index cd34f36daaaa..9c13ef8a044e 100644
>> --- a/include/dt-bindings/interconnect/qcom,icc.h
>> +++ b/include/dt-bindings/interconnect/qcom,icc.h
>> @@ -23,4 +23,12 @@
>>  #define QCOM_ICC_TAG_ALWAYS		(QCOM_ICC_TAG_AMC | QCOM_ICC_TAG_WAKE |\
>>  					 QCOM_ICC_TAG_SLEEP)
>>  
>> +#define ICC_BCM_VOTER_APPS		0
>> +#define ICC_BCM_VOTER_DISP		1
>> +#define ICC_BCM_VOTER_CAM0		2
>> +#define ICC_BCM_VOTER_CAM1		3
>> +#define ICC_BCM_VOTER_CAM2		4
>> +
>> +#define ICC_BCM_VOTER_MAX		64
> 
> I proposed to skip the max. If you actually use it, you won't be able to
> change it ever.
I guess I can just add the max in the driver.

Konrad

> 
> 
> Best regards,
> Krzysztof
> 
