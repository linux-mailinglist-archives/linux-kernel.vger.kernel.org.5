Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5867C7395
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347334AbjJLQ75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344025AbjJLQ7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:59:55 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3DBC0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:59:53 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5384975e34cso2291376a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697129992; x=1697734792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pJa6qviOc6NfzgcGhr4/+c108cgp9z9RgjqREJMTdj0=;
        b=IY2BCzNqXfCcIAGU9WRWO08GgaNnvaSyI5DSjLBfzxr0fcTQ2xLNxyhdgrRJuV44aN
         4UJ4fmukpO8gztRMcp3F5SMoNO9BgJlXqY3LRCfyCf/3IMP1UyYFcassG9uVkb2ifrNM
         pnGVzncsS2rK+ozKa67udn1ReVYj0L3rxAu3mXLmb6bf/2G0UUinHX/oBoFUdfRXZZG9
         h/1UfXxlTw6Je2F5vmGREQ6PRXrq4meqi7dZVQcXKvs1Lna3ICo2Qo4tk2lSNHANeGBa
         T3GpSe7MqrLMfGFheLEGb4n+FNSlLtjko0FkSgNXIspKfl+SQiXkXd6a4Wmx+AS6zFk4
         /oQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697129992; x=1697734792;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pJa6qviOc6NfzgcGhr4/+c108cgp9z9RgjqREJMTdj0=;
        b=oUbscpeUOKw+7M9Qer27vAbZwMSD+s8x1c1AuImwGsrb4swuNsNdy8J0D0dG3whYTf
         QPF0C8gJsAjVrSFUijn0siS3EYA0hZkQXX1EhLY98mRIC5Dqqi+RP57AB43/yc7nfZdg
         IvToqBuQkCMPnrtF1uH1np/V+nmQVd+NsGMsM/Tkf8l8zPbRDCVxfTrGMB/JQ0OslUwC
         VOblqzLcIddAL0gWo5GhWV5nx2ZFpiKwIoyyS+5mSuMsDjewKsWAt3cfrTCmao7UhqIr
         vxXo5hADjo5ya45ArMwiInUzVHrc7Jy0jofud+wUkJLpU1DP56EDFwSm9GQtxT+/doab
         gqIA==
X-Gm-Message-State: AOJu0YzL9xW/wTP94Xi/Vcj7GLsAloBxt0wm65u69UKZrTnIGKJVJwc/
        iRpwxD5ARVhdJYMy3B2HhBW2DOLVw7x5stzZbvk=
X-Google-Smtp-Source: AGHT+IEuPBo53ttTwjsowx5rW5/ddy4SAjK+lkxugYZUqKOgBzbExw2Vk+lqy5i94nS17dqL4kq5Nw==
X-Received: by 2002:a50:9f4b:0:b0:53d:a1c0:410e with SMTP id b69-20020a509f4b000000b0053da1c0410emr7604135edf.7.1697129992402;
        Thu, 12 Oct 2023 09:59:52 -0700 (PDT)
Received: from [172.30.204.175] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id bf14-20020a0564021a4e00b005362bcc089csm10152630edb.67.2023.10.12.09.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 09:59:52 -0700 (PDT)
Message-ID: <fe4da875-36d4-4eeb-ba83-8c24899c9097@linaro.org>
Date:   Thu, 12 Oct 2023 18:59:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] arm64: dts: qcom: Add interconnect nodes for SDX75
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        dmitry.baryshkov@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1696406908-9688-1-git-send-email-quic_rohiagar@quicinc.com>
 <1696406908-9688-2-git-send-email-quic_rohiagar@quicinc.com>
 <3a042a26-81b4-4ab3-ba03-a38ae876634b@linaro.org>
 <6da8dc86-0b9a-488f-9046-9d9d269beeaf@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <6da8dc86-0b9a-488f-9046-9d9d269beeaf@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/23 18:57, Rohit Agarwal wrote:
> 
> On 10/12/2023 10:18 PM, Konrad Dybcio wrote:
>>
>>
>> On 10/4/23 10:08, Rohit Agarwal wrote:
>>> Add interconnect nodes to support interconnects on SDX75.
>>> Also parallely add the interconnect property for UART required
>>> so that the bootup to shell does not break with interconnects
>>> in place.
>>>
>>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sdx75.dtsi | 52 
>>> +++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 52 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi 
>>> b/arch/arm64/boot/dts/qcom/sdx75.dtsi
>>> index e180aa4..b4723fa 100644
>>> --- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
>>> @@ -8,6 +8,8 @@
>>>     #include <dt-bindings/clock/qcom,rpmh.h>
>>>   #include <dt-bindings/clock/qcom,sdx75-gcc.h>
>>> +#include <dt-bindings/interconnect/qcom,icc.h>
>>> +#include <dt-bindings/interconnect/qcom,sdx75.h>
>>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>   #include <dt-bindings/power/qcom,rpmhpd.h>
>>>   #include <dt-bindings/power/qcom-rpmpd.h>
>>> @@ -203,6 +205,19 @@
>>>           };
>>>       };
>>>   +    clk_virt: interconnect-0 {
>>> +        compatible = "qcom,sdx75-clk-virt";
>>> +        #interconnect-cells = <2>;
>>> +        qcom,bcm-voters = <&apps_bcm_voter>;
>>> +        clocks = <&rpmhcc RPMH_QPIC_CLK>;
>>> +    };
>>> +
>>> +    mc_virt: interconnect-1 {
>>> +        compatible = "qcom,sdx75-mc-virt";
>>> +        #interconnect-cells = <2>;
>>> +        qcom,bcm-voters = <&apps_bcm_voter>;
>>> +    };
>>> +
>>>       memory@80000000 {
>>>           device_type = "memory";
>>>           reg = <0x0 0x80000000 0x0 0x0>;
>>> @@ -434,6 +449,9 @@
>>>               clock-names = "m-ahb",
>>>                         "s-ahb";
>>>               iommus = <&apps_smmu 0xe3 0x0>;
>>> +            interconnects = <&clk_virt MASTER_QUP_CORE_0 
>>> QCOM_ICC_TAG_ALWAYS
>>> +                     &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>;
>>> +            interconnect-names = "qup-core";
>> No qup-config?
>>
>> My brain compiler says this would cause a dt checker warning, at least 
>> on next-20231012.
> If I check the tip, then there is only one interconnect entry.
> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/soc/qcom/qcom%2Cgeni-se.yaml#L50
> For the debug uart, the qup-config is added.
> I did check the dtbs_check before sending these patches.
> Please let me know if I am missing anything.
Oh, my brain compiler was correct, but for the wrong input data :)

I thought you added this property to the UART itself, not to the QUP 
controller. Yes, you're right.

Konrad
