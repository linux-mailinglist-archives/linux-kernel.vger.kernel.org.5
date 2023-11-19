Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7EB7F0837
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 18:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjKSR7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 12:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKSR7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 12:59:45 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038A3B5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 09:59:39 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-409299277bbso8858035e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 09:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700416778; x=1701021578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qf+R7atLBnXoeb69e/M4yOdfux/rV2voS2Y05sz1Lqk=;
        b=eLU3v7s1BLa6zpS7Qol3ays+kC5ZCNsVwg2qD2zBMpKquWv8grwabv3IUuoY84SRIg
         vrAHep4GafFDllQxRpzU392KuxYPHFmP4bAkhDZwVGconOow2HNBbW9Utw9KqG9n27gu
         T7Ueeeol74JYCp0GShqKSA/LTdiGh9mhG87fTysw7JhGAyAb7aS+eWDyXvJ82z4Ps7jB
         uQ34l2FmsHNee+J7uVTd878cR+7+eswSg4V078Tj0Rk6JOzQBYipxUBYdhfjAP9CzCeg
         jUPUz0ctp34KexXa8BTab4RcKdh2dGQqj7qHUA4vRAvegQRtgivfyfCaGRlx+WSp4x91
         ZrHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700416778; x=1701021578;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qf+R7atLBnXoeb69e/M4yOdfux/rV2voS2Y05sz1Lqk=;
        b=wawFfBAL1Uy310LdRL+Q7wj14Z5WnxLcd2CfnO2jakQZXTu6FeMayEwgzp2AKxu6rL
         uJsWu1D2C1PZD4Z1wG5aMnIfxS8NlHr6i/Xj3SO/m/l/LAfi81wESnF8GbGoWYJ6bbuF
         mx9hXZhgygfhT1DISUBk29N+znWMlZgfIeaKxsMHNAFVuSYgjMpkWBMK68jkUmB77Jum
         9xm97UxH7akyNwqS9FH3e0FYQNxRpwBnnphU9UPwmn0nyqS0R9xMxDW5/4GDv4XJ71N6
         QqAESCRXJsgZnnY5eqGG6dpyjFnrwqIy7/2pwIiEvooEkY6GtbxukM4R+uDuvO2fm/Vx
         SNWQ==
X-Gm-Message-State: AOJu0YxbF1hSj6813G+Zb3+KU5nXwQPPgwQ5NpQjjmCPqW2W8YhfWe/s
        bSFABqdoWPCzg5vKFV+qvmwNSA==
X-Google-Smtp-Source: AGHT+IE8LzkXqUtq9mx4ztIGMkvVwAd4EVx58EUo8VA+tzgS1Yg5dCSSDh417mKg1YyXkewSEJnOFQ==
X-Received: by 2002:a05:600c:5125:b0:40a:57b4:3d35 with SMTP id o37-20020a05600c512500b0040a57b43d35mr3800900wms.13.1700416778163;
        Sun, 19 Nov 2023 09:59:38 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:203f:8c0f:b03c:8d45? ([2a01:e0a:982:cbb0:203f:8c0f:b03c:8d45])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c4e8b00b0040535648639sm10774533wmq.36.2023.11.19.09.59.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Nov 2023 09:59:37 -0800 (PST)
Message-ID: <26df42ac-edb0-ac72-d5cb-4a4ae6819736@linaro.org>
Date:   Sun, 19 Nov 2023 18:59:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 07/16] arm64: dts: qcom: sm8550-aim300: add PCIe0
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Tengfei Fan <quic_tengfan@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tglx@linutronix.de
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, -cc=kernel@quicinc.com
References: <20231117101817.4401-1-quic_tengfan@quicinc.com>
 <20231117101817.4401-8-quic_tengfan@quicinc.com>
 <37a3a407-07e7-49d8-bbce-b1dac8cfcf5a@linaro.org>
 <247f4654-ec65-4857-8b35-1a79088e8b87@linaro.org>
 <1ae2da80-77e8-487a-a94d-b329e6f48360@linaro.org>
Content-Language: en-GB
From:   Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <1ae2da80-77e8-487a-a94d-b329e6f48360@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 18/11/2023 à 01:08, Konrad Dybcio a écrit :
> On 17.11.2023 11:41, neil.armstrong@linaro.org wrote:
>> On 17/11/2023 11:29, Dmitry Baryshkov wrote:
>>> On 17/11/2023 12:18, Tengfei Fan wrote:
>>>> Add PCIe0 nodes used with WCN7851 device.  The PCIe1 is not connected,
>>>> thus skip pcie_1_phy_aux_clk input clock to GCC.
>>>>
>>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/sm8550-aim300.dts | 32 ++++++++++++++++++++++
>>>>    1 file changed, 32 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8550-aim300.dts b/arch/arm64/boot/dts/qcom/sm8550-aim300.dts
>>>> index 202b979da8ca..3aca0a433a00 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sm8550-aim300.dts
>>>> +++ b/arch/arm64/boot/dts/qcom/sm8550-aim300.dts
>>>> @@ -393,6 +393,38 @@
>>>>        };
>>>>    };
>>>> +&gcc {
>>>> +    clocks = <&bi_tcxo_div2>, <&sleep_clk>,
>>>> +         <&pcie0_phy>,
>>>> +         <&pcie1_phy>,
>>>> +         <0>,
>>>> +         <&ufs_mem_phy 0>,
>>>> +         <&ufs_mem_phy 1>,
>>>> +         <&ufs_mem_phy 2>,
>>>> +         <&usb_dp_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
>>>> +};
>>>
>>> NAK, this should go to sm8550.dtsi unless there is a good reason.
>>
>> Actually this is how QRD8550 was designed, so it's fine to mimic.
> Does CCF not handle this gracefully?

CCF handles this very gracefully and it's a perfectly valid DT in regard
to the bindings...

neil

> 
> Konrad

