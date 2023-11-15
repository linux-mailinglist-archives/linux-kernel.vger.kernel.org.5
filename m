Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AF67EC914
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjKOQtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjKOQtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:49:00 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501CAF9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:48:57 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c504a5e1deso94589991fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700066935; x=1700671735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1JFVW100N4q4TU3demIcnNlFQYmXCxWuiTOcydzmEwY=;
        b=AhM0lJtrT1HgzWsbK7Dg+nDqwOr72BNlirOuLbYXGOaKBO3QOAQjfZiKfczd2K8qld
         GrK/FbKGo1QQEjm8h2uBrM5eL3pW0bFmNNZhc3oXbMsGgzIlGcJ93pe+6I63YjtYkwg7
         SKFqMijsnbqTs+xG5pARwyNOOi7NQNDNpSydkctMw56kJSW5KKJmm6PjiCBN0brH3c0F
         cYXGV5ax1WvywdwtQLrXg7sqDBLDxEwe5Bip+ISuxcvHW59oQ+xzMEXwUWh14kvFDCF1
         aOV7X4ukAI2N34vvz9X3xY+zPOXiJnH3gapW0LX4WcQoS+DXMQVJOv6E+i3cvgVtL7hc
         OCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700066935; x=1700671735;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1JFVW100N4q4TU3demIcnNlFQYmXCxWuiTOcydzmEwY=;
        b=hce+atrdAguk8gpaJSrfm+jPUPSnXyDG9X66X165eyMzMqAjNcpbuiOtUn3V/t16aC
         nmnvwxLUkcrcP7RYHLMRTlUNSUxunrpmd/jswdsMAfqj986wE7ajgzlYLO4ZFzXuoA84
         2agxZ0tn/XL8j6hHRGwoyN7hiogSuXgbra7rDHGHmat9ZATKHXr8gWgf/DxKw2TvK9sR
         4tkJ+HpKF6m5iNzN8D8NMJgFkyzazGMS2DHaL+cP7g1HkneffxS1H4KwaddJK0jNOy/g
         fN0HdzSs6KmxOLkW5FU8dRAekbcLZXsaap+Ceyr4mCc45ownBnLlV7fcSTNM3gKfBjtn
         XpXQ==
X-Gm-Message-State: AOJu0YwtP4zkSPHho7WaCUTVYKz/BGaqi240Ha6TPA2TRF6t6yEbcQMV
        mGugwX+NR6zDRYKzisJwOBG3Qdw7mvgKv7V404ntug==
X-Google-Smtp-Source: AGHT+IF//qea0b+ScHEr5OSH8aWRS+7t3/vcP/3QNs+mv/50Xc927AFTs4UtGj0Lcu0WmYl0eoSMmg==
X-Received: by 2002:a2e:82cd:0:b0:2b9:3684:165 with SMTP id n13-20020a2e82cd000000b002b936840165mr4070474ljh.8.1700066935560;
        Wed, 15 Nov 2023 08:48:55 -0800 (PST)
Received: from [172.30.204.150] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id a13-20020a2ebe8d000000b002c12c2094e4sm1705775ljr.74.2023.11.15.08.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 08:48:55 -0800 (PST)
Message-ID: <2c5dae0f-5bd4-4fed-ba47-1175eba07207@linaro.org>
Date:   Wed, 15 Nov 2023 17:48:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] clk: qcom: videocc-sm8150: Update the videocc resets
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20231110065029.2117212-1-quic_skakitap@quicinc.com>
 <20231110065029.2117212-3-quic_skakitap@quicinc.com>
 <31dac823-cc46-401e-85f8-d04544bd38c3@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <31dac823-cc46-401e-85f8-d04544bd38c3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/23 12:49, Bryan O'Donoghue wrote:
> On 10/11/2023 06:50, Satya Priya Kakitapalli wrote:
>> Add all the available resets for the video clock controller
>> on sm8150.
>>
>> Fixes: 5658e8cf1a8a ("clk: qcom: add video clock controller driver for SM8150")
>> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
>> ---
>>   drivers/clk/qcom/videocc-sm8150.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/videocc-sm8150.c b/drivers/clk/qcom/videocc-sm8150.c
>> index 1afdbe4a249d..6a5f89f53da8 100644
>> --- a/drivers/clk/qcom/videocc-sm8150.c
>> +++ b/drivers/clk/qcom/videocc-sm8150.c
>> @@ -214,6 +214,10 @@ static const struct regmap_config video_cc_sm8150_regmap_config = {
>>   static const struct qcom_reset_map video_cc_sm8150_resets[] = {
>>       [VIDEO_CC_MVSC_CORE_CLK_BCR] = { 0x850, 2 },
>> +    [VIDEO_CC_INTERFACE_BCR] = { 0x8f0 },
>> +    [VIDEO_CC_MVS0_BCR] = { 0x870 },
>> +    [VIDEO_CC_MVS1_BCR] = { 0x8b0 },
>> +    [VIDEO_CC_MVSC_BCR] = { 0x810 },
> 
> Are you sure this shouldn't be
> 
> +    [VIDEO_CC_INTERFACE_BCR] = { 0x9ac },
> +    [VIDEO_CC_MVS0_BCR] = { 0x870 },
> +    [VIDEO_CC_MVS1_BCR] = { 0x8b0 },
> +    [VIDEO_CC_MVSC_BCR] = { 0x810 },
FWIW this seems to be a copypaste from

https://git.codelinaro.org/clo/la/kernel/msm-5.4/-/blame/92b31370d31d22e910120f6a875bf0919b3f1773/drivers/clk/qcom/videocc-sm8150.c

so if it's an issue, it should probably be fixed downstream too

Konrad
