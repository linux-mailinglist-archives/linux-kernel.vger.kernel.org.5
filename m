Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3364C79FDA6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbjINH6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjINH6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:58:40 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2755C1BFA
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 00:58:36 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bfb0a2682fso10021911fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 00:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694678314; x=1695283114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BbQLH7nE4IDFv4D1KGNNw5oakRW09gU02ZbpYUht0n4=;
        b=D9iRgGGkOtcLSUrFu+zIveEZFpbvq1yhlmM1GELd4ZRxeF2b47tD8XBDoOaJGCjO/V
         71c9EnkJC6jzHEvqpX05VeMqnT4tHT/GsXCnEvYKUbjsRoN8MX0RWzmDrcDt7NcEmgeA
         A+HvfTXYN8PfdjXUucgvbe6tWzd1PVlS1dUgGxTtzyiwD739h9YFZsbxVBuLxAL0HUMU
         0H51JF3Rcd8IRFkGotuIopFp52InAIQjS2rL4j3fh6w+EdXs6Q7nIo8vnBCADZcRocfQ
         je/E+QEQ95P7cTw/vIAExXT5/BCA+e2v4Gmw9vpm91rSJxK6PKyayrF4K7eYxizJ0tlu
         Kr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694678314; x=1695283114;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BbQLH7nE4IDFv4D1KGNNw5oakRW09gU02ZbpYUht0n4=;
        b=KThscc9LynA/ZXAiXYW+YXZvdqPluIiBx2ku6zBwiZyE5eVMnAwzCRoqbAVSF3hAJk
         A0UWuNo9NmIe+sBilfcw5Mn/jwToYDAauZDKlO3S3j6W6/rBYSUcfjscBzuYERmTI/N4
         gWTNHVHgQfJehO13krL++AwWpphNZprU0Yx7EPtPtJ33DBkehs1rgNxeF2stRE8vSxn9
         kj2nJH0prhZIMZUKSJq4udKzCTxzuX/2wkmVSNDYBzGoUd9SI6Iu979YM7xMLBE0Uo+V
         e4Q4nBB+JZ/x71/6lORiRcadYrQW31+oMPIv62PHDMg3t9mFq5qdGSM1NkIKbRaxNvLt
         vQTA==
X-Gm-Message-State: AOJu0YxIEzkWx/NZ1/3Tv+iSOIKYofrs06Fq25GPNz95dia5McrSj7iO
        chYk0o74otEqv+iLHuSucICnyg==
X-Google-Smtp-Source: AGHT+IGl9iUSiuwx+cME20CcLxNpbz+K+s5Tn4VVY7yBGAiQ6nWnIAJqUufkPxFR0gCnOzqcctoehw==
X-Received: by 2002:a2e:321a:0:b0:2b6:cff1:cd1c with SMTP id y26-20020a2e321a000000b002b6cff1cd1cmr4014654ljy.34.1694678314344;
        Thu, 14 Sep 2023 00:58:34 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id k8-20020a5d4288000000b00317a29af4b2sm1007983wrq.68.2023.09.14.00.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 00:58:33 -0700 (PDT)
Message-ID: <c7c28667-0266-5fc4-2dc3-132c51a93a92@linaro.org>
Date:   Thu, 14 Sep 2023 09:58:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v7 4/4] clk: qcom: add clock controller driver for
 qca8386/qca8084
Content-Language: en-US
To:     Jie Luo <quic_luoj@quicinc.com>, andersson@kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com
References: <20230914054639.13075-1-quic_luoj@quicinc.com>
 <20230914054639.13075-5-quic_luoj@quicinc.com>
 <357805c5-bedb-8972-bcf1-fabaaaf90ad9@linaro.org>
 <1a1922ec-a8ae-4a42-d8a9-921450592213@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1a1922ec-a8ae-4a42-d8a9-921450592213@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2023 09:52, Jie Luo wrote:
> 
> 
> On 9/14/2023 2:15 PM, Krzysztof Kozlowski wrote:
>> On 14/09/2023 07:46, Luo Jie wrote:
>>> The clock controller driver of qca8386/qca8084 is registered
>>> as the MDIO device, the hardware register is accessed by MDIO bus
>>> that is normally used to access general PHY device, which is
>>> different from the current existed qcom clock controller drivers
>>> using ioremap to access hardware clock registers.
>>>
>>> MDIO bus is common utilized by both qca8386/qca8084 and other
>>> PHY devices, so the mutex lock mdio_bus->mdio_lock should be
>>> used instead of using the mutex lock of remap.
>>>
>>> To access the hardware clock registers of qca8386/qca8084, there
>>> is special MDIO frame sequence(three MDIO read/write operations)
>>> need to be sent to device.
>>>
>>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>>> ---
>>>   drivers/clk/qcom/Kconfig       |    9 +
>>>   drivers/clk/qcom/Makefile      |    1 +
>>>   drivers/clk/qcom/nsscc-qca8k.c | 2178 ++++++++++++++++++++++++++++++++
>>>   3 files changed, 2188 insertions(+)
>>>   create mode 100644 drivers/clk/qcom/nsscc-qca8k.c
>>>
>>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>>> index 865db5202e4c..c95ada6a1385 100644
>>> --- a/drivers/clk/qcom/Kconfig
>>> +++ b/drivers/clk/qcom/Kconfig
>>> @@ -203,6 +203,15 @@ config IPQ_GCC_9574
>>>   	  i2c, USB, SD/eMMC, etc. Select this for the root clock
>>>   	  of ipq9574.
>>>   
>>> +config IPQ_NSSCC_QCA8K
>>> +	tristate "QCA8K(QCA8386 or QCA8084) NSS Clock Controller"
>>> +	depends on MDIO_BUS || COMPILE_TEST
>>
>> This is SoC is for both ARM and ARM64 worlds?
>>
> Thanks Krzysztof for the comments.
> This chip is independent of the ARCH, which just depends on the MDIO 
> bus, both mips and arm are supported.

There is no ARCH_QCOM on MIPS, so it's limited to ARM. Then add
restriction to ARM || COMPILE_TEST.

Best regards,
Krzysztof

