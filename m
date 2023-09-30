Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6168E7B4488
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 01:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbjI3XBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 19:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjI3XBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 19:01:17 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDAADA
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 16:01:14 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3214cdb4b27so14280464f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 16:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696114873; x=1696719673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k7J57l7/zqdeGA0GlKWE9U/nzxhEBk4B9Yh6/PcmQ+Y=;
        b=nNd8YT1F25Wle1EvHD+YeW78L2qz3rNY/By+WVlVXeq/ioiQ9TvJtxH8b/fCPGD6lL
         C4JjBgi+4D4PDxtQ5ByKN8QNans61uANMfEU+bsqMblL6ORnN+DWBvSNkz6iuee1sE7D
         0Wi9qY8hRlKsPgVQVRZfb7tO4T77rrrpZwXbmOXM1MMd5FK3xR44Ex5NJDFn8E2RC3Zi
         eDrMncdAe5qQ2kFV436w3/Ccig8FsEVqjC6utzqKYB0cxXM5hWdNYzyUY71LjeGrQ98I
         re+QBzjm9MDz4jm26ghuXfKJP4OGZGfzYA5JwFE6M/7INCeoFe8d6zAVAVpAuPARaR0C
         fdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696114873; x=1696719673;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k7J57l7/zqdeGA0GlKWE9U/nzxhEBk4B9Yh6/PcmQ+Y=;
        b=STTqBMqLbeS62Frq5JIpy8fCIB+UYUTWH6rLec+I8oNO65YHbHyx75RxsbDIJxKdhP
         rcmtLMCO5HhAlh/azRkCKrSSKpCdL2ZnsnlCtXWh4JMaCdorrTkSeODqk0CTSuHxk+96
         XO4pWFtxA1O7mkPYrwGHJR2nmcWk3OWNZz/8azo2k6beWHVilEu6kjNKg6o7ht5Beax0
         Elv+FqzxPhYacZ4gZkP5lOblzDNgffoEE58Z4AOUKKRDCyMCVtKi9QGSHpqOMQhmHBSi
         fSa0FDmh9MYOoG397d6F4XHmIHu/n7z8tZOPvEZxeTUtgEG8KLL3eP8mtM0souDelaGw
         +EGg==
X-Gm-Message-State: AOJu0YxtX8Fm8lQFGu2SN6Rnf2d/66U1ZmOvVduipQiQqsMAcLwudCiP
        VBvav/Nfz/MkBKlyu+XLXlb9Yw==
X-Google-Smtp-Source: AGHT+IFi/TLo16IHjm3Kw76Bp+GiKKw2JyFRtplFnfLdEE4SikJbt1pucx26C+8iV0F8WoKT+wTXdw==
X-Received: by 2002:a5d:5902:0:b0:324:7a6b:d503 with SMTP id v2-20020a5d5902000000b003247a6bd503mr7083067wrd.11.1696114873130;
        Sat, 30 Sep 2023 16:01:13 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id w11-20020adff9cb000000b00326c952716esm2411004wrr.61.2023.09.30.16.01.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Sep 2023 16:01:12 -0700 (PDT)
Message-ID: <ec28c662-8065-4bfc-bd5e-af0b9f3e87ac@linaro.org>
Date:   Sun, 1 Oct 2023 00:01:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] arm64: boot: dts: qcom: sc8280xp: Add in CAMCC for
 sc8280xp
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        andersson@kernel.org, agross@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jonathan@marek.ca, quic_tdas@quicinc.com,
        vladimir.zapolskiy@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230930134114.1816590-1-bryan.odonoghue@linaro.org>
 <20230930134114.1816590-6-bryan.odonoghue@linaro.org>
 <449cd202-a7d8-4d20-3a41-17a3ba1355cb@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <449cd202-a7d8-4d20-3a41-17a3ba1355cb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2023 17:41, Konrad Dybcio wrote:
> 
> 
> On 9/30/23 15:41, Bryan O'Donoghue wrote:
>> Add in CAMCC for sc8280xp. The sc8280xp Camera Clock Controller looks
>> similar to most of the sdmX, smX and now scX controllers.
>>
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi 
>> b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> index cad59af7ccef..ca43d038578b 100644
>> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> @@ -8,6 +8,7 @@
>>   #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
>>   #include <dt-bindings/clock/qcom,gpucc-sc8280xp.h>
>>   #include <dt-bindings/clock/qcom,rpmh.h>
>> +#include <dt-bindings/clock/qcom,sc8280xp-camcc.h>
>>   #include <dt-bindings/clock/qcom,sc8280xp-lpasscc.h>
>>   #include <dt-bindings/interconnect/qcom,osm-l3.h>
>>   #include <dt-bindings/interconnect/qcom,sc8280xp.h>
>> @@ -3450,6 +3451,21 @@ usb_1_role_switch: endpoint {
>>               };
>>           };
>> +        camcc: clock-controller@ad00000 {
>> +            compatible = "qcom,sc8280xp-camcc";
>> +            reg = <0 0x0ad00000 0 0x20000>;
>> +            clocks = <&gcc GCC_CAMERA_AHB_CLK>,
>> +                 <&rpmhcc RPMH_CXO_CLK>,
>> +                 <&rpmhcc RPMH_CXO_CLK_A>,
>> +                 <&sleep_clk>;
>> +            clock-names = "iface", "bi_tcxo", "bi_tcxo_ao", "sleep_clk";
> clock-names is now redundant :)
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Konrad

BTW.

Looking at the block diagram for the Camera, I see why Cam_CC_AHB is 
included in this list. Its not called out as a dependency in the clock 
tree but when you look at the block diagram you can see it gates the AHB 
bus to the CAM_CC block.

anyway

---
bod
