Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5AD47EF45A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjKQOYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjKQOYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:24:08 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7C9D52
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 06:24:04 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40838915cecso16337045e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 06:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700231043; x=1700835843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CKxOTnv9JfSvH6BdnkUvc5Oor+bZOeZyCbGjkcr5HZ4=;
        b=xaeaZIYnVAGCE87yBecmhqhDtOxX79ERrX+VwNQVUizfiAaHy9WEFwNnlT8m3jsfzN
         JMUFFwX5GpGKQ+hqDQgzz+AU6H0b1015ZIgT7DZ+TFATCWxxD1Kw9yJdUA9LCHVsmsRY
         Ams9FLtDjIvFNK5yzXlu71HNNUWb4OlExN14ESrcqdzELMK0U9c+hW3OGU2/NBqzgBau
         PFqQUXub+kDHcrlj9zv5HNt7k5XiDIRtqJFwlRWFHpqLQ9UMkYhX6GC/XasW1uhbRzB2
         a5z/ucYZ3l7uruOZGOI6+jXJuREFBAvk0Nt173bqnyny10frnRXx1hyfVrn7wWoudPej
         JCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700231043; x=1700835843;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CKxOTnv9JfSvH6BdnkUvc5Oor+bZOeZyCbGjkcr5HZ4=;
        b=hY2pR8YEG8SmdEBeCT4GLdE050EM5eaCF9CvhA2kV6Uzqp5DaZwTnRYlNvPs45kPo3
         cMgZ5U4cfYgI8LJ3pyNAkHhxe1LTd0mrNSg0zhziv1fhYYj2/19nPgKhom4kjd2j2oqC
         SlhU9n4gG8d1cwqW7VALMgeCSUQ64IuuhqnXgJ1meiqnL7tAWmxJZ0ev8e038ME2z+E9
         GYvXaATcFko4jnEKoRnNcu99G8dQU3jYos6Jx4i7uR900c1hVhgg1ZYnvrba3WTAnKN2
         YtBw6NRMvGcEDDtB3XFtgVVJMrJsDER6UPr+Kqae5bSrRUSJRk8Ft80HwCSyJfUvu7Xb
         dVIw==
X-Gm-Message-State: AOJu0Yw+tw6fa1tptmnS4q0W6bfdBH2Te3274GxyvBwq0vYvbdud7xjq
        Ta0K9l5KWiahSXa+EqmXPzK7tg==
X-Google-Smtp-Source: AGHT+IFv9leUNZjNiQIqzlf8v4RMlj/DsgqhXWvcBbAW4P9cdbHdvPz7XGByDyW708WTbz3Wmi+1zA==
X-Received: by 2002:a05:600c:350f:b0:405:49aa:d578 with SMTP id h15-20020a05600c350f00b0040549aad578mr15287501wmq.37.1700231042824;
        Fri, 17 Nov 2023 06:24:02 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id y3-20020a05600c17c300b0040586360a36sm7047867wmo.17.2023.11.17.06.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 06:24:02 -0800 (PST)
Message-ID: <3d980823-29d5-44a7-9cf2-4246c8ae3c83@linaro.org>
Date:   Fri, 17 Nov 2023 14:24:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] clk: qcom: Add Global Clock controller (GCC) driver
 for SC8380XP
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
        konrad.dybcio@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     agross@kernel.org, conor+dt@kernel.org, quic_tdas@quicinc.com,
        quic_rjendra@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, neil.armstrong@linaro.org,
        abel.vesa@linaro.org, quic_tsoni@quicinc.com
References: <20231025133320.4720-1-quic_sibis@quicinc.com>
 <20231025133320.4720-3-quic_sibis@quicinc.com>
 <483c4de3-951c-4ba4-89fb-36fcd44fa99f@linaro.org>
 <e857c853-51ef-8314-2a21-fa6fd25162ca@quicinc.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <e857c853-51ef-8314-2a21-fa6fd25162ca@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 17/11/2023 03:56, Sibi Sankar wrote:
>>
>> This is another discontinuinty with sc8280xp.
>>
>> Could you have a look through the sc8280xp gcc and do an aduit for 
>> clk_rcg2_shared_ops as against sc8380xp ?
> 
> ack, will do a quick audit before the re-spin.

A best guess will do, we will "shake out the bugs" through 
suspend/resume real use cases anyway but, worth a quick pass since you 
are doing a v2 for the SoC name.

---
bod
