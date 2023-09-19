Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6387A632B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjISMiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjISMiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:38:05 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FECFB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:37:59 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9ada609bb62so721033266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695127078; x=1695731878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ElFl2P9I49dKgc5GPio4ojq866f2cNZ+vD/OQLMGKro=;
        b=QCUlzv6R3rLQKKKVaSdV5L7V0i20DHFDDz855oS0zFmKvifyo7+LGtVNjS8MHaoJLI
         hABKXjwTS94H44hjD20Iy8Htabheo2p4XSH0L4+4RXIvWPblkj1Qn4DHxBKHfm9T+A6f
         NZnKtPgi0Z77hpIpIOLXHgy1n8lqQxSiyEFW3Vx3YAZglTPF17S0Swoc42juYfuDsegI
         FS0BPjKftJi+3cfJn90PuA9RmVekZSo4gJMH8j3+7Bh0Yaoe9/q1N74FK/DwxR8DwFtW
         ID5Wx5iSBnYIRKVDx/dBVF/fHuueY9xTWAHI9rbqVX+WZgtc4Q6TvCl70rz0Y2w/4tii
         s4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695127078; x=1695731878;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ElFl2P9I49dKgc5GPio4ojq866f2cNZ+vD/OQLMGKro=;
        b=NKTqXZziT1p+iwLiAldIdZJb1zKmrw8r+ojduZcy6p3FvwrCdpKnJGbnXXmj69oNY4
         QTjCOsEb+Swseu77l2JmG1wj1ghaY+8gsqfroQJ0qydF9O1rJ5Qdv8uiV8oAASz3oOSx
         1Lgu4ZbSixy2oBG0nNG1TlKV/vI3JxbQli5SQmPar0I03qUijWGGPmBpsRQpGQSNcu38
         If5k7BCiMxwwpVYpw+qWcvejXY4uAJitEKQX/YOfUjPg3SZe/Vks+njANvSuLm7dhQPF
         CZndmTLY/LyYLn2n/7nz1ubMdSyrdP0ttfvUVcr8u/4XLenqWhFN9Vn/z/O3v0m5TU02
         6aiQ==
X-Gm-Message-State: AOJu0YyYH0oqpARnzYsICI0Ml1V7P4ULvjZSc2iHKLP5CI5dXGhPZ23m
        x1Xn1wB5n9KCk7GSVL/gMRP4cQ==
X-Google-Smtp-Source: AGHT+IHF+mK3Ru/oqZskjsjpAcam/b3opFYlTzcYXoOk56BMQtkD/TfxpO/C1DxDPxuKm7003vykSg==
X-Received: by 2002:a17:906:73c4:b0:9ad:bffb:2e2c with SMTP id n4-20020a17090673c400b009adbffb2e2cmr10789397ejl.39.1695127077803;
        Tue, 19 Sep 2023 05:37:57 -0700 (PDT)
Received: from [172.20.24.238] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id jx10-20020a170906ca4a00b009ae3e6c342asm106371ejb.111.2023.09.19.05.37.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 05:37:57 -0700 (PDT)
Message-ID: <463923fe-7938-ad1b-fd79-6491329289af@linaro.org>
Date:   Tue, 19 Sep 2023 14:37:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2 4/4] arm64: dts: qcom: ipq5018: Add tsens node
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dmitry.baryshkov@linaro.org
References: <20230915121504.806672-1-quic_srichara@quicinc.com>
 <20230915121504.806672-5-quic_srichara@quicinc.com>
 <b0fe17e4-e4d8-02af-4e09-06b3930b38fe@linaro.org>
 <b40c6439-ab73-d796-589e-ffee21cedfc9@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b40c6439-ab73-d796-589e-ffee21cedfc9@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2023 09:28, Sricharan Ramabadhran wrote:
> 
> 
> On 9/15/2023 6:16 PM, Krzysztof Kozlowski wrote:
>> On 15/09/2023 14:15, Sricharan Ramabadhran wrote:
>>> IPQ5018 has tsens V1.0 IP with 4 sensors.
>>> There is no RPM, so tsens has to be manually enabled. Adding the tsens
>>> and nvmem node and IPQ5018 has 4 thermal sensors (zones). With the
>>> critical temperature being 120'C and action is to reboot. Adding all
>>> the 4 zones here.
>>>
>>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>> ---
>>>   [v2] Fixed node names, order and added qfprom cells for points
>>>        seperately to use the calibrate_common and squashed thermal_zone
>>>        nodes here
>>>
>>>   arch/arm64/boot/dts/qcom/ipq5018.dtsi | 169 ++++++++++++++++++++++++++
>>>   1 file changed, 169 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>> index 9f13d2dcdfd5..d53aea5342e2 100644
>>> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>> @@ -93,6 +93,117 @@ soc: soc@0 {
>>>   		#size-cells = <1>;
>>>   		ranges = <0 0 0 0xffffffff>;
>>>   
>>> +		qfprom: qfprom@a0000 {
>>> +			#address-cells = <1>;
>>> +			#size-cells = <1>;
>>> +			compatible = "qcom,ipq5018-qfprom", "qcom,qfprom";
>>
>> This is a friendly reminder during the review process.
>>
>> It seems my previous comments were not fully addressed. Maybe my
>> feedback got lost between the quotes, maybe you just forgot to apply it.
>> Please go back to the previous discussion and either implement all
>> requested changes or keep discussing them.
>>
> 
>   oops, moved the compatible to first, but missed it on posting version.
>   Will fix it in V3.

What do you mean by "posting version"? If it is not the same as your Git
version, then your process is buggy. You must work on mainline tree and
send patches from that tree. Not edit patches and edit Git separately...

Best regards,
Krzysztof

