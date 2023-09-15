Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665A07A1EBF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbjIOMbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjIOMbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:31:47 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84466DD
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:31:41 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-501bef6e0d3so3350847e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694781100; x=1695385900; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gMZ7XUyzdHt60v82Ptduk4zBdtsS1JXuRnupgoYfUWQ=;
        b=lhZOeovQFXZVBL3URJRGtu5KHJB+5MqtmY9C2EeHTEc/hfrxPFwpk403gATNVpn/yQ
         CuI2GzGrOBJGN+neVml0mymy+3VSBnzFs82+rlSyu8AQb9fGeUbl6pRbalrWaJihvE3x
         IpUv2tXY2k4m6i8UZ8/fy1BuILa+e7Tr8M+kB8SSjsxvjRoMpfkF7RusWgpDHXPcDyU6
         QqFyj15S5wjTeEdMoVybfrfK0m4i3lIXpD+yRYmAUkHKjzw2i2SiNOa83QUxCjjGUhuV
         /ggdHkI0P2TdruCQEjUD9lEpLPI9GBTrLy7CZ81P8mc23ThtgpWoXRAzxrlADpQ6E4bP
         Typg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694781100; x=1695385900;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gMZ7XUyzdHt60v82Ptduk4zBdtsS1JXuRnupgoYfUWQ=;
        b=IdJNYUZ+Qx9/bM0uAstD+TQFP8yhqQ+UdWn9mANu5nG3sqdldpsvnZLBiDwPWhwk3+
         MpqmrvNLcvADg+pzdBV/uvpgKdWmo15Ht6saftJFbpuVhhQeb4Id+FE3b+LogDpsEsnw
         piU9RNaLeo8YEezTDtt2YHQIuFYU+72S2/CbRyavQ51k5+3tt7qREdP4K8RSsSekv1DP
         Zih/E4BARqfOd3nMVYgpPIiTY6YGH/dtpXsmcAnCTdhwRZcRwEha0vsxJnnPCx4qmBgE
         6X8HfiL/M2opjFnrmjCjBROINp/3N2bqbU6DB/ALA5jhOpmjje6xp67gPjDS4JXIC9ZR
         vAbA==
X-Gm-Message-State: AOJu0YxmUmO0TvI4/a6x6LtuoGMbQNB4ue70E6goMLacZvvzHw2l72+a
        dN4+X3QBYTjFIFg3ZMZTFi9zOA==
X-Google-Smtp-Source: AGHT+IEUty0fFIjHdSAMWxYfy5TdEZT0g4uBgez+KWHoD6Z0vZwAT79FlizQj4+A0bnqz+vkYYn/QQ==
X-Received: by 2002:a05:6512:2390:b0:502:f740:220 with SMTP id c16-20020a056512239000b00502f7400220mr1279087lfv.58.1694781098880;
        Fri, 15 Sep 2023 05:31:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id u24-20020a056402065800b005231e3d89efsm2194149edx.31.2023.09.15.05.31.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 05:31:37 -0700 (PDT)
Message-ID: <d798e6b7-3a3d-cd80-6504-8ed78c46b740@linaro.org>
Date:   Fri, 15 Sep 2023 14:31:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 4/5] dt-bindings: firmware: qcom,scm: document IPQ5018
 compatible
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_gurus@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     computersforpeace@gmail.com
References: <20230815140030.1068590-1-robimarko@gmail.com>
 <20230815140030.1068590-4-robimarko@gmail.com>
 <0bb12177-e8f0-1873-4ffb-9a0df0a9f24d@linaro.org>
 <9a723cc7-bc85-7dac-8923-e4e1974ded85@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9a723cc7-bc85-7dac-8923-e4e1974ded85@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 14:23, Sricharan Ramabadhran wrote:
> 
> 
> On 8/16/2023 11:40 AM, Krzysztof Kozlowski wrote:
>> On 15/08/2023 15:59, Robert Marko wrote:
>>> It seems that IPQ5018 compatible was never documented in the bindings.
>>>
>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>>> ---
>>>   Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
> 
>   I earlier posted this here, [1]
> 
>   [1] https://www.spinics.net/lists/linux-mmc/msg77015.html

So it should be applied... although status said superseded. No clue,
please check with Bjorn.

https://patchwork.kernel.org/project/linux-arm-msm/list/?series=770464&state=*

Best regards,
Krzysztof

