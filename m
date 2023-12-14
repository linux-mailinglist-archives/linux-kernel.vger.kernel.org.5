Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E5B8139CB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573014AbjLNSSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444209AbjLNSSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:18:18 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4218810F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:18:24 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50bf82f4409so930677e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702577902; x=1703182702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aUXxNIE0oyhaGNjYhqDm71JIvcw2/l7lxWAlHlBLujc=;
        b=kAgstMJo59Uulo15INN4HDJUpYM5JnIK6OhLAqGBKXFXoFlG5KzO0OKnGvj4x4U1Bt
         99U6Uvg4F/Zk1hRyp2EmW80qYBzV5GpZEbazT3cPB6GdhyfI2vcVP+4zQfavpPs0nE7M
         U8V/ngLyCpW8C5xBQEv5+IExNEGawEBMITF0FyCrq919AnehwLZsPVTQVUUdGk7IOuTK
         sAPpyuluR7T+QQxIqxbKHFT0N0boAPJXS83QT5uW5RDGvkZl2sRO3pNENlzq/BNMDq/Z
         eiweJL7VX7z7LWsbTokpTJTJuaLxe6UQYEDWr7d4GJKkbUuBsI1XmZmhuatJ0aPW+SKA
         mdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702577902; x=1703182702;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aUXxNIE0oyhaGNjYhqDm71JIvcw2/l7lxWAlHlBLujc=;
        b=W+6yukuuCJoIuvmiIhgkQqL7omnWvcsnNUjq8KcSu29WE7HyT+eD00hBVUEpxO+WRq
         P4Y87hYDuvWce2BPzp40Ssf1ltN5wUtlbyBSWLGrGGyWJIGANroM6wERPSMl7KciNDVR
         KCVUnlyCBd2zA3G0MpECL80pl7wa+traXenOEDFtxeLhY2YH+1lCKTQnrCOH7FvDFoXu
         i8sk0aVm9xXug3y/CrzMQWrgA0sqKKE1hyUhGcf1AUJ4AyTljoHGMWsSC1Y+MPMK6scn
         clkNvHPtAM0IG+onaOcr6VK1lISbTMEPqD7HjeJkwoascjVJQNSyyJu4SG9z9PHGkid3
         ZR+Q==
X-Gm-Message-State: AOJu0YzDcF8OtEfKp7EfKBU8ThzyjSwlaWtakSrUx28NeTY24KO7DuVH
        AOBxlScRJRXzGLraUNl934RBDA==
X-Google-Smtp-Source: AGHT+IHPvoFv9KvPlT+AD1GWaLtelWYGlfY72peH/oBCnqzIcbZPrWCVcWP96N2Eo12F9Pm8pvzRCA==
X-Received: by 2002:a05:6512:398f:b0:50e:15de:9931 with SMTP id j15-20020a056512398f00b0050e15de9931mr1257549lfu.24.1702577902567;
        Thu, 14 Dec 2023 10:18:22 -0800 (PST)
Received: from [172.30.205.72] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id c16-20020a056512105000b0050d1a0e7129sm1659686lfb.291.2023.12.14.10.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 10:18:22 -0800 (PST)
Message-ID: <92e9039b-a0e3-4f93-aaa8-226ef9e8b613@linaro.org>
Date:   Thu, 14 Dec 2023 19:18:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] arm64: dts: qcom: ipq5332: add support for the
 NSSCC
Content-Language: en-US
To:     Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20231211-ipq5332-nsscc-v3-0-ad13bef9b137@quicinc.com>
 <20231211-ipq5332-nsscc-v3-7-ad13bef9b137@quicinc.com>
 <c4034715-53a5-468e-914a-3f19d0618c42@linaro.org>
 <8cc2a8ec-632e-4e3b-b13b-d1523a61c136@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <8cc2a8ec-632e-4e3b-b13b-d1523a61c136@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/11/23 14:28, Kathiravan Thirumoorthy wrote:
> 
> 
> On 12/11/2023 4:02 PM, Konrad Dybcio wrote:
>> On 11.12.2023 04:37, Kathiravan Thirumoorthy wrote:
>>> Describe the NSS clock controller node and it's relevant external
>>> clocks.
>>>
>>> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/ipq5332.dtsi | 28 ++++++++++++++++++++++++++++
>>>   1 file changed, 28 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>>> index 42e2e48b2bc3..a1504f6c40c1 100644
>>> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>>> @@ -15,6 +15,18 @@ / {
>>>       #size-cells = <2>;
>>>       clocks {
>>> +        cmn_pll_nss_200m_clk: cmn-pll-nss-200m-clk {
>>> +            compatible = "fixed-clock";
>>> +            clock-frequency = <200000000>;
>>> +            #clock-cells = <0>;
>>> +        };
>>> +
>>> +        cmn_pll_nss_300m_clk: cmn-pll-nss-300m-clk {
>>> +            compatible = "fixed-clock";
>>> +            clock-frequency = <300000000>;
>>> +            #clock-cells = <0>;
>>> +        };
>>> +
>>>           sleep_clk: sleep-clk {
>>>               compatible = "fixed-clock";
>>>               #clock-cells = <0>;
>>> @@ -473,6 +485,22 @@ frame@b128000 {
>>>                   status = "disabled";
>>>               };
>>>           };
>>> +
>>> +        nsscc: clock-controller@39b00000{
>> Missing space between the opening curly brace
> 
> My bad :( will fix it in next spin.
> 
>>
>>> +            compatible = "qcom,ipq5332-nsscc";
>>> +            reg = <0x39b00000 0x80000>;
>> the regmap_config in the clk driver has .max_register = 0x800, is this
>> correct?
> 
> As per the memory map, 512KB is the size of this block. However the last register in that region is at the offset 0x800. Shall I update the max_register also to 512KB to keep it consistency?
No, it's fine, I just wanted to know if it's intentional :)

Thanks!

Konrad
