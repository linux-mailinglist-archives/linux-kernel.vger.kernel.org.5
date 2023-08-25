Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80723788DA0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 19:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240866AbjHYRJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 13:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344214AbjHYRJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 13:09:21 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4668D213D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 10:09:09 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-500913779f5so1767771e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 10:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692983347; x=1693588147;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RioHCPItio+9KsIGdFnJI9hZp/KECGYSVwaxV3OMlMI=;
        b=Wgc3o3PW1VT+LDEHC2XxNmrPjbIKUVeb7BA/b6tVVCNlxN5EstxGq8iagsDMcuVI++
         zbX/HAEAfdue5vpBISwCoJvgYndMijiQLAscsoliW0+Gnxryc8f/Bsor4QpPP/QuAFDh
         3EOOaUdQg2YfADfCIn2V84sDiodlnUkyaobv7rz9LIUkjIPaYR5Smo4dHTcgINj1sw2J
         LWLOMiMt/2cCuvA6MHBwkWXYkV2wjTT2+nRA77f3K/3xwELzpl1DTSwa+SOvrG6T39it
         8T6DQPnwG+nzozw6BVCsR8qCLRrrXcVbW41F3KbCheaQnMclGFT0f35eoNY9DOeJ8CWa
         YaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692983347; x=1693588147;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RioHCPItio+9KsIGdFnJI9hZp/KECGYSVwaxV3OMlMI=;
        b=QtZSdwlzsz4/SRWTZ3XtJPHzwU7pxFJYU8HaaPYm+ynXeDTHnccvuO0h//iBh9kYZI
         8Jvulpp7IzNAds1ZfOTSo9QC1kohpnf7mMEWWvYDv6JrfUblENUZQLEZxLjMQ92Bsu+j
         IUS0Pme8om2km2ytrZ4MDz/ob6qQVV2hqO2s9+9Yue0iiQ9rypd/QxMJyJSlLTJy+c7t
         8PuIjksvaeKM2Dw+vK4hK8lkMuV66AKjlv2Mx4jE1BmF5xhRNJ3vI7GtMAd57jIHdsAr
         IT8sSAGqEFey9If2um0xb2dy09pG9CHLeWfOEMOLiCUZcCQWa+4ojXQ1ghlc28gC7Wuw
         BKIA==
X-Gm-Message-State: AOJu0Yxit4GEVaqfXJesHkxYUHJ7f/F4ua4x+J0vrD3Gff0nDvUz3vpB
        oK36Q94harZYYLkJO0EObEbXIA==
X-Google-Smtp-Source: AGHT+IEkmZ4C2L+iH1VgJNj3kSwaZ/wclqc+t20H21tgJCD7Loa9MGkSC0xdOVn419jkCYQJ/Hn7Ng==
X-Received: by 2002:a05:6512:2512:b0:4fe:af1:c3ae with SMTP id be18-20020a056512251200b004fe0af1c3aemr14981156lfb.15.1692983347405;
        Fri, 25 Aug 2023 10:09:07 -0700 (PDT)
Received: from [192.168.1.101] (abxh59.neoplus.adsl.tpnet.pl. [83.9.1.59])
        by smtp.gmail.com with ESMTPSA id m2-20020a195202000000b004fdd6b72bfdsm351930lfb.117.2023.08.25.10.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 10:09:06 -0700 (PDT)
Message-ID: <379ac43f-2b21-420b-a487-bec37b8c94a7@linaro.org>
Date:   Fri, 25 Aug 2023 19:09:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC DNM] perf: Add support for Qualcomm Last-Level Cache
 Controller PMU
Content-Language: en-US
To:     Trilok Soni <quic_tsoni@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
References: <20230809-topic-llcc_pmu-v1-1-dd27bd1f44c9@linaro.org>
 <f71bc35a-c45c-0429-1164-d047d61ef061@quicinc.com>
 <b46d8e10-5f25-4350-b5b9-77bf5885780f@linaro.org>
 <362594bc-6315-0125-ff80-33894c8d9337@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <362594bc-6315-0125-ff80-33894c8d9337@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.08.2023 19:07, Trilok Soni wrote:
> On 8/25/2023 4:50 AM, Konrad Dybcio wrote:
>> On 24.08.2023 23:31, Trilok Soni wrote:
>>> On 8/9/2023 1:09 PM, Konrad Dybcio wrote:
>>>> Add support for the Qualcomm LLCC (Last-Level Cache Controller) PMU,
>>>> which provides a single event, expressing cache read misses.
>>>>
>>>> Based on the vendor driver found in the msm-5.10 downstream kernel.
>>>>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>> Hi, I've been trying to get this driver going upstream by cleaning it
>>>> up and adding the necessary perf boilerplate (the original Qualcomm one
>>>> only pokes at the PMU from within the kernel itself) to use the
>>>> userspace tool.
>>>>
>>>> I can not however get it to cooperate.. in this iteration I get a PMU
>>>> event registered (though with only a "raw" name - no "x OR y" like with
>>>> other PMUs on the system) as:
>>>>
>>>> llcc_pmu/read_miss/                                [Kernel PMU event]
>>>>
>>>> but the .read callback is never called when I run:
>>>>
>>>> sudo perf stat -C 0 -a -e llcc_pmu/read_miss/ stress-ng -C 8 -c 8 -m 10
>>>>
>>>> which always returns 0
>>>>
>>>> if I add --always-kernel I get:
>>>> <not supported>      llcc_pmu/read_miss/
>>>
>>> Which SOC you are trying this on?
>> 8250
> 
> Thanks. Let me see if my team can try this on latest SOCs and if it is the same behavior. Did you tried reading the counter by "printk" in the kernel and see the values are dumped from the register?
Thanks for looking into this.

I debugbombed all the interesting functions and somehow the ones
which interface with the hardware are not even called as part of
executing `perf [...]` :/

Konrad
