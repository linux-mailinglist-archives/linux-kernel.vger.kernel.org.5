Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1C67D5370
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbjJXN5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbjJXN45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:56:57 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F34C10DB
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:55:08 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40906fc54fdso13277695e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698155707; x=1698760507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WVvJSmKdB8QA7XXk5oVO214x0d/SCNFjFOhZkbU5BcQ=;
        b=SXwLnCrPcCsca80qHPN2Qzi+8XRPdQHsQBGSiTqFaPi0NDGeGUdJSrWXkXqBlUBSin
         S20+EdvS7GWrRXg7AwVcvcqy+7O1jDvZi8VceAjXM4K+7vENOvxXsI6ntWVZmzlHar8W
         pSES6UAY9oZJGFbPf1G6Wt4XnmydEXx7GMyGt0gQ3DnCVGQUYW+0mlqVwR9I9uV3ui3j
         7fPA6Xd85nXHEoxkRXa1+/s5zqP/9VHpns5DJ15hAeH0Y++4wmuYUmQxrywBubb5hG4Z
         dyhtGbCToUMFIp8d+ulfs4sfUIk6jx2UwiQ2SVMQ1+hD0vidJ3zmky6RukMIXNonkKs0
         VCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155707; x=1698760507;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WVvJSmKdB8QA7XXk5oVO214x0d/SCNFjFOhZkbU5BcQ=;
        b=epg8F13wy3KZJUuhR8Pzk6ISx4mQawkzw+LiLHyA8ZEPNvoQ6Pm4zjWF5Jbhgf5Ktt
         UKovO+wmrCcJmZSGGYFsmfjByuzSwN5ZQYTo5eUMym2DqizQUg3Pr3vQ86WlFnuz4RHE
         Or3ktT1AZpTQkJoCP1d/dCWiHC5JEwbrOCSKvMXQUOCfrH3TjjEJKBCcqLt+z0rm8lx8
         ZUUG8/QqsU563PLn2rSne1WE0Kxi21fQ7Niqe/QFLZPip06CwPQzY8X9Eoy63UmdYLam
         YOdoJkPvpgTlghpQeP/3U1aKZSAOtmXfvN1UX/ru01HEYDA1Y5egzvegFXO/+4TsrQls
         dFqg==
X-Gm-Message-State: AOJu0YyQPOLGussgOdGF7IkO4vxwtrLbHfl6cqpD1MR4cWUj1GDz/P2e
        OlslbpnDRrSTqs9O3NI2mZOezQ==
X-Google-Smtp-Source: AGHT+IGXC4b4EMmGnTiggsj6T5p3sDh8hvZ8EFQSQ6SPShTMk26zqe+tdz3pHiTyyTCkr3sPazCTJg==
X-Received: by 2002:adf:ed8e:0:b0:32d:9d99:d0a5 with SMTP id c14-20020adfed8e000000b0032d9d99d0a5mr9757772wro.5.1698155706981;
        Tue, 24 Oct 2023 06:55:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id e23-20020adf9bd7000000b0032d893d8dc8sm10075487wrc.2.2023.10.24.06.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 06:55:06 -0700 (PDT)
Message-ID: <424de835-0b9b-49d5-a0d8-dc74c58ff5a1@linaro.org>
Date:   Tue, 24 Oct 2023 15:55:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/5] dt-bindings: soc: qcom: Add memory_dump driver
 bindings
Content-Language: en-US
To:     Zhenhua Huang <quic_zhenhuah@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@quicinc.com,
        quic_tingweiz@quicinc.com
References: <1698052857-6918-1-git-send-email-quic_zhenhuah@quicinc.com>
 <1698052857-6918-2-git-send-email-quic_zhenhuah@quicinc.com>
 <27fcdcc1-b29b-43b2-8b1a-c648dd9e696c@linaro.org>
 <d3b62002-c29c-a45e-279f-7d07c697aa77@quicinc.com>
 <38aa02c4-5b8d-4978-96a2-241fe5f94b50@linaro.org>
 <7a703504-edf1-d85c-0949-9cfcf3251b0b@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <7a703504-edf1-d85c-0949-9cfcf3251b0b@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2023 12:57, Zhenhua Huang wrote:
> 
> 
> On 2023/10/23 20:52, Krzysztof Kozlowski wrote:
>> On 23/10/2023 13:54, Zhenhua Huang wrote:
>>>
>>>
>>> On 2023/10/23 17:27, Krzysztof Kozlowski wrote:
>>>> On 23/10/2023 11:20, Zhenhua Huang wrote:
>>>>> Add bindings for the QCOM Memory Dump driver providing debug
>>>>
>>>> Bindings are for hardware, not driver. This suggests it is not suitable
>>>> for bindings at all.
>>>>
>>>>> facilities. Firmware dumps system cache, internal memory,
>>>>> peripheral registers to reserved DDR as per the table which
>>>>> populated by the driver, after crash and warm reset.
>>>>
>>>> Again driver :/
>>>
>>> Thanks for pointing out. Qualcomm memory dump device is a reserved
>>> memory region which is used to communicate with firmware. I will update
>>> description in next version.
>>
>> I have still doubts that it is suitable for DT. I usually expect  such
>> firmware feature-drivers to be instantiated by existing firmware
>> drivers. You do not need DT for this.
> 
> Got it, as it interacts with firmware, you think it should be a firmware 
> driver? But it seems there should not be existing suitable place to put 
> it now(qcom_scm.c is for TZ). Shall we create one new file like 
> *qcom_sdi.c* in drivers/firmware and put it there? Because SDI(system 
> debug image, which is part of bootloader) is the firmware doing the things.

Dunno, didn't think about this. I comment here only about bindings. This
does not look suitable for bindings. That's it.

Best regards,
Krzysztof

