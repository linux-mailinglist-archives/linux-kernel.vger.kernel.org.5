Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4528480A311
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 13:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbjLHMU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 07:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjLHMU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 07:20:56 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4721987
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 04:21:02 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2cb21afa6c1so7609921fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 04:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702038060; x=1702642860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pl0clnwrD65PTyvZ51AXFWygx4cIxP6ccg197Ec+HPE=;
        b=IgFYXOiJRduaqhdL7d8MG02RwhYaXCTYi0psb3soRWlrsx1PYp+atZAH9syrXKY7Oa
         qhgzWxd7OT5Ydo047GMrx+3Kvo3Fw6UJgEi4iV7MARFokwE+QEAn4LgH5rF23xXBhGJ3
         L//TAlN1LDNEfs4AUA0UfHmneVx1kOD+/vvb/8z2yZ/eN68zKwoBiLJrTDGaGbgJM/l8
         dt8ps/27pQGVW99gGcp9zONVZt1xgS/equL5+Ru1GXiemMyXKhdavmTMQKG420ViXf/C
         ND0OifQ1U9LTe98jy7VdC4nJyd6dydv0pt1a6Z/Uz4tWd5ZugJzlSfuZ6OabDLGR+/B3
         QBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702038060; x=1702642860;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pl0clnwrD65PTyvZ51AXFWygx4cIxP6ccg197Ec+HPE=;
        b=aCNKJyKgAU06TU7imgQgpub89/1DDZF3074F7ul8wSPmkZoQyykIqeljJEhGu2tcKm
         jLiy/u9MItHvXoXBQoPoPQrcDfjbX4OnXg9YaW6FooC2Jrhnxg2V0N+cFkRyHJsCAsq7
         XyRm4GbGl/d+gla4jCprkupTiEtY3Yy6OKmMvnZnvG54aSNWOQ2K+gCrJ92CvBpe9gx2
         K3rhsdnqM8PTd5xRui6Nd9rII3iVjxg7f0zBKcxdmkuHTNFeuBjrLmrA669cAbdfI1u8
         C3pru1OBIuNDMja/JcGgFPMTxOlXotJjwhTMvF/k4NkJnJGinitIg4tVunIAWEzoJPnt
         oOUg==
X-Gm-Message-State: AOJu0YwCAsmDI/eZG9+wPHLZCw4x90JkyfFu1hx1wYrqpg1zDlA0PeZn
        KQ7RO+mvarEUpy2dDilsVaJPjA==
X-Google-Smtp-Source: AGHT+IER4YlgGGyKEHV9dQr5tdof58Pqyht6yuF2QXUJoFt24Q9DtS/qCkLD1Wd5t4lITLKwjr/tWA==
X-Received: by 2002:a2e:361a:0:b0:2ca:24c:e252 with SMTP id d26-20020a2e361a000000b002ca024ce252mr2846721lja.91.1702038060334;
        Fri, 08 Dec 2023 04:21:00 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id he43-20020a1709073dab00b00a1e21893a26sm936349ejc.222.2023.12.08.04.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 04:20:59 -0800 (PST)
Message-ID: <d885928d-035b-4abd-890b-c9626b925d76@linaro.org>
Date:   Fri, 8 Dec 2023 13:20:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] dt-bindings: phy: qcom-edp: Add X1E80100 PHY
 compatibles
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231122-phy-qualcomm-edp-x1e80100-v3-0-576fc4e9559d@linaro.org>
 <20231122-phy-qualcomm-edp-x1e80100-v3-2-576fc4e9559d@linaro.org>
 <b6d3928c-75ba-47a3-93fc-a60729be2e35@linaro.org>
 <545d3ace-66e5-4470-b3a4-cbdac5ae473d@linaro.org>
 <ab7223a2-9f3f-4c9c-ab97-31512e7a0123@linaro.org>
 <CAA8EJpoboN85bLiayXJgn5iwh+Gn0OtK0aZ26ZJu9H3xkTT2Tw@mail.gmail.com>
 <d9d27fa4-6ede-4958-b717-db425be61068@linaro.org>
 <CAA8EJpq7dB+45fiq2WmkMmSO7KszY0Et_t1gZ9ZvfsSxftpm8g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAA8EJpq7dB+45fiq2WmkMmSO7KszY0Et_t1gZ9ZvfsSxftpm8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2023 13:17, Dmitry Baryshkov wrote:
>>>>>> Anyway, I was thinking this should be rather argument to phy-cells.
>>>>> I'm not sure I'm for this, because the results would be:
>>>>>
>>>>> --- device.dts ---
>>>>> &dp_controller0 {
>>>>>      phys = <&dp_phy0 PHY_EDP>;
>>>>> };
>>>>>
>>>>> &dp_controller1 {
>>>>>      phys = <&dp_phy1 PHY_DP>;
>>>>> };
>>>>> ------------------
>>>>>
>>>>> as opposed to:
>>>>>
>>>>> --- device.dts ---
>>>>> &dp_phy0 {
>>>>>      phy-type <PHY_EDP>;
>>>>> };
>>>>>
>>>>> &dp_phy1 {
>>>>>      phy-type = <PHY_DP>;
>>>>> };
>>>>> ------------------
>>>>
>>>> Which is exactly what I proposed/wanted to see.
>>>>
>>>>>
>>>>> i.e., we would be saying "this board is connected to this phy
>>>>> instead" vs "this phy is of this type on this board".
>>>>>
>>>>> While none of them really fit the "same hw, different config"
>>>>> situation, I'd vote for the latter one being closer to the
>>>>> truth
>>>>
>>>> Then maybe I miss the bigger picture, but commit msg clearly says:
>>>> "multiple PHYs that can work in both eDP or DP mode"
>>>>
>>>> If this is not the case, describe the hardware correctly in the commit
>>>> msg, so people will not ask stupid questions...
>>>
>>> There are multiple PHYs (each of them at its own address space). Each
>>> of the PHYs in question can be used either for the DisplayPort output
>>> (directly or through the USB-C) or to drive the eDP panel.
>>>
>>> Same applies to the displayport-controller. It can either drive the DP
>>> or eDP output, hardware-wise it is the same.
>>
>> Therefore what I proposed was correct - the block which uses the phy
>> configures its mode. Because this part:
>>   "this phy is of this type on this board".
>> is not true. The phy is both types.
> 
> But hopefully you don't mean using #phy-cells here. There are no
> sub-PHYs or anything like that.

I am exactly talking about phy-cells. Look at first example from Abel's
code.

Best regards,
Krzysztof

