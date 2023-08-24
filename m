Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1889A786A9F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjHXIsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240555AbjHXIsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:48:03 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0FD1BC0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:47:37 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4ffa01fc987so761819e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692866842; x=1693471642;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Luu2mgu5dBhR6s0bCtSFfR5zNZajHF5BW8EWntyR8Zc=;
        b=QUg6K6RRwKwmJKro0tziz7F+gHcpcXqtWXrEdODclSfX6hERwyWAQ7gi38RTf+Si7y
         UqEtpQTRWG5L8nzjPmgnc2AsuiCsShq4ze/ZHNTCZ0e1z2p2U9CPTVIylMhvnaHoMLHP
         VfNXkbDvVcim1WDv8+rEEHZsYHdlJVTln1wcV8xHatpawV6EpozV7h97MdEGXmuLmEJq
         m2ms1I/TIlDIYqWe6951t9M4mBsCaO325sQMKgC4poip7vheGdnc3n8YqkNSwlbISnLf
         LqnsDMdzpZKUz2fk5ZErjYJ/xRhNFtSqy04fw4ykl/19rl9npekV3Ce5SF033yxwC9bp
         aKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692866842; x=1693471642;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Luu2mgu5dBhR6s0bCtSFfR5zNZajHF5BW8EWntyR8Zc=;
        b=AVQsntIVdG5bAhoNwOUJpTGydwT6EXtti3gAnP4Qggfg26kfxGy66AICp0fpL19FKR
         7r4/mda37Ct5APmSi37q+twiQ5yduA0u1ax7vag0NWMqUvOjFVVzA1NDf2P+WP3cre+e
         elK3wWnDiD4BncXjkCO6MHHdeO6P9XJIltT62HC4q8giZAcGAn2MGj5UclJ4ZONA2vHL
         d5y2VYx2u9Gh/4KDf0ohgH5OkeN8cRuzJYiehatjD5GjJSAYbviHsRuUE5Qk18XOiKSx
         NMlnCe2eyovypAiNTD+djHc7DgrNqe1NbNNqJCT551Lp4DDvIixYanM4GplxeGFVltMU
         zfGA==
X-Gm-Message-State: AOJu0YzvvxxE3HIRAJnjJmAXlb4zEAfwHHj0/u6otbwHaJb5+9LSByOj
        hJ3G7WANIfvBR3qOZx7ABwHfeQ==
X-Google-Smtp-Source: AGHT+IFxr2lky/zZxRDrtPoerryLLsp8lOpSvqyqiX9re9sZXlPeGUSvwTTorceGzllqJ3qri5xsvQ==
X-Received: by 2002:ac2:4f15:0:b0:4ff:8f76:678c with SMTP id k21-20020ac24f15000000b004ff8f76678cmr6695568lfr.1.1692866842361;
        Thu, 24 Aug 2023 01:47:22 -0700 (PDT)
Received: from ?IPV6:2a00:f41:4882:ba34:4490:938b:eab4:c5ef? ([2a00:f41:4882:ba34:4490:938b:eab4:c5ef])
        by smtp.gmail.com with ESMTPSA id w12-20020a05651203cc00b004ff8ee47f2fsm3063805lfp.1.2023.08.24.01.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 01:47:22 -0700 (PDT)
Message-ID: <868da572-cff1-42b6-9931-06b6a8c73809@linaro.org>
Date:   Thu, 24 Aug 2023 10:47:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] dt-bindings: clock: Add ipq9574 NSSCC clock and reset
 definitions
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>,
        Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        p.zabel@pengutronix.de, richardcochran@gmail.com, arnd@arndb.de,
        geert+renesas@glider.be, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Cc:     quic_saahtoma@quicinc.com
References: <20230711093529.18355-1-quic_devipriy@quicinc.com>
 <20230711093529.18355-4-quic_devipriy@quicinc.com>
 <ea229d40-0bce-87e8-edef-72a7f251c051@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ea229d40-0bce-87e8-edef-72a7f251c051@quicinc.com>
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

On 24.08.2023 07:18, Kathiravan T wrote:
> 
> On 7/11/2023 3:05 PM, Devi Priya wrote:
>> Add NSSCC clock and reset definitions for ipq9574.
>>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
>>   .../bindings/clock/qcom,ipq9574-nsscc.yaml    |  76 +++++++++
>>   .../dt-bindings/clock/qcom,ipq9574-nsscc.h    | 152 ++++++++++++++++++
>>   .../dt-bindings/reset/qcom,ipq9574-nsscc.h    | 134 +++++++++++++++
>>   3 files changed, 362 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
>>   create mode 100644 include/dt-bindings/clock/qcom,ipq9574-nsscc.h
>>   create mode 100644 include/dt-bindings/reset/qcom,ipq9574-nsscc.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
>> new file mode 100644
>> index 000000000000..1e8754760785
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
>> @@ -0,0 +1,76 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/qcom,ipq9574-nsscc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Networking Sub System Clock & Reset Controller on IPQ9574
>> +
>> +maintainers:
>> +  - Bjorn Andersson <andersson@kernel.org>
>> +  - Anusha Rao <quic_anusha@quicinc.com>
>> +
>> +description: |
>> +  Qualcomm networking sub system clock control module provides the clocks,
>> +  resets and power domains on IPQ9574
>> +
>> +  See also::
>> +    include/dt-bindings/clock/qcom,ipq9574-nsscc.h
>> +    include/dt-bindings/reset/qcom,ipq9574-nsscc.h
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,ipq9574-nsscc
>> +
>> +  clocks:
>> +    items:
>> +      - description: Bias PLL cc clock source
>> +      - description: Bias PLL nss noc clock source
>> +      - description: Bias PLL ubi nc clock source
>> +      - description: GCC GPLL0 out aux clock source
>> +      - description: Uniphy0 GCC Rx clock source
>> +      - description: Uniphy0 GCC Tx clock source
>> +      - description: Uniphy1 GCC Rx clock source
>> +      - description: Uniphy1 GCC Tx clock source
>> +      - description: Uniphy2 GCC Rx clock source
>> +      - description: Uniphy2 GCC Tx clock source
> 
> 
> These are UniphyX *NSS* TX/RX clock source?
Wouldn't that be "source from GCC"?

Konrad
