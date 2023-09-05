Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BDE792E68
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 21:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238638AbjIETKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 15:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbjIETKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 15:10:42 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FA0113
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 12:10:15 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-401ec23be82so30284035e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 12:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693940960; x=1694545760; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bjksFs9ME0ZMeGOd6P3pA7Ye4FZ8i8SMNjWPMfIw5lk=;
        b=HtKmzNM1O7x/oGmkulyzo08oLBcOSUelwcsKDOMChokZxl7GIkBOt9mHWfZ3iBKP3B
         waYeoQo4IfVQyhTDvZtaN1euNQPG8J39cZEuRb6p8d2utlx0dMau5r1+HMyGBswR4wbK
         emvkfwC1uc7PHHNUDfLaR7kYlyk4g3XAFzjAS7oVm6vGdjhwn5rcTrXPZ83M6aqTVwJb
         DVDC8BIuO6DJyS5lupR+kCMbOt+wUJqSpgNIDzzwVqxZKzpj/g/lBiaTbDcFlV1vsFwk
         s3W2rCv0V+jM+awIubEKxIv4AH4TJDzR5EMphJzvx6YpHB/f3mVrAD45AGKzC77dQRuQ
         gAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693940960; x=1694545760;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bjksFs9ME0ZMeGOd6P3pA7Ye4FZ8i8SMNjWPMfIw5lk=;
        b=F0WGoInzw3NuPafO63ZABjoUm72sYZvgVD3LvcUyMbtDwotlXP/3Zr1FHJexU4sqTq
         /7zROxnjo5ejza4NQtXa4pW76iM4zKbfAiCAPqRYHKOgyIKGUNsBaNhqcLCfAruoXkZ7
         wzj3HSaYVrlw7XJDr5ddDYELa6JuvYypezfxXDZVhp6YxG3AtOINI0ZAXkG9N54c+Kf/
         5x8JM8tZLObW+aCEeTyKmvD1GpE8/qu3B1R7M5pH5diKfWUPtLmVjqZqi0SK/awIgmLe
         fbFgR1k4j7GswRCuz7Zg7LAcL0mDPWUsiEBQB/CYzDK5G7grDsC5Yg4PjLY5+LoKDu1R
         xazw==
X-Gm-Message-State: AOJu0YzIKnnWcaIRtdmDF7b2uhZRATD2uAIzoHI1DxR8ypZdv9KhQDBV
        5eITd96cmjtrKRx/sb+iPmbpNlot4MKs1o7uU0s=
X-Google-Smtp-Source: AGHT+IGPdPwLCLtw5pl5htm08s4io9/1/fHruh8qkZPW18UOGYZ04JcE/v4EnVNpCFOI8nTRGZI5ow==
X-Received: by 2002:a17:906:3057:b0:9a1:6252:16a0 with SMTP id d23-20020a170906305700b009a1625216a0mr240900ejd.46.1693931837438;
        Tue, 05 Sep 2023 09:37:17 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id k23-20020a1709061c1700b00992b71d8f19sm7750341ejg.133.2023.09.05.09.37.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 09:37:16 -0700 (PDT)
Message-ID: <f5b05cfa-f12c-4f4d-a801-3aa76d843d6d@linaro.org>
Date:   Tue, 5 Sep 2023 18:37:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 0/3] Add qcom hvc/shmem transport
To:     Nikunj Kela <quic_nkela@quicinc.com>, sudeep.holla@arm.com
Cc:     cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230811175719.28378-1-quic_nkela@quicinc.com>
 <3342d8bf-5281-c082-cb9a-7a027b413237@quicinc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3342d8bf-5281-c082-cb9a-7a027b413237@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2023 18:06, Nikunj Kela wrote:
> 
> On 8/11/2023 10:57 AM, Nikunj Kela wrote:
>> This change introduce a new transport channel for Qualcomm virtual
>> platforms. The transport is mechanically similar to ARM_SCMI_TRANSPORT_SMC.
>> The difference between the two transports is that a parameter is passed in
>> the hypervisor call to identify which doorbell to assert. This parameter is
>> dynamically generated at runtime on the device and insuitable to pass via
>> the devicetree.
>>
>> The function ID and parameter are stored by firmware in the shmem region.
>>
>> This has been tested on ARM64 virtual Qualcomm platform.
>>
>> ---
>> v3 -> fix the compilation error reported by the test bot,
>>        add support for polling based instances
>>
>> v2 -> use allOf construct in dtb schema,
>>        remove wrappers from mutexes,
>>        use architecture independent channel layout
>>
>> v1 -> original patches
>>
>> Nikunj Kela (3):
>>    dt-bindings: arm: convert nested if-else construct to allOf
>>    dt-bindings: arm: Add qcom specific hvc transport for SCMI
>>    firmware: arm_scmi: Add qcom hvc/shmem transport
>>
>>   .../bindings/firmware/arm,scmi.yaml           |  67 ++---
>>   drivers/firmware/arm_scmi/Kconfig             |  13 +
>>   drivers/firmware/arm_scmi/Makefile            |   2 +
>>   drivers/firmware/arm_scmi/common.h            |   3 +
>>   drivers/firmware/arm_scmi/driver.c            |   4 +
>>   drivers/firmware/arm_scmi/qcom_hvc.c          | 232 ++++++++++++++++++
>>   6 files changed, 293 insertions(+), 28 deletions(-)
>>   create mode 100644 drivers/firmware/arm_scmi/qcom_hvc.c
> Gentle Ping!

It's third ping these two weeks from Qualcomm. Folks, it is merge
window. What do you think will happen with your ping during this time?

Best regards,
Krzysztof

