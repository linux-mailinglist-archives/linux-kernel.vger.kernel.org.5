Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20407B4FA1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236278AbjJBJ4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236277AbjJBJ4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:56:12 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A00D9E
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 02:56:07 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50585357903so804307e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 02:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696240566; x=1696845366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VI6ALURCYFTZzB2n0KbkvH0CnC/yIlDD9PmeGJooHMM=;
        b=kMWAElZ1iknV5CgzRu9hpyJO+jTSMH8408YtG+t/fVy0KnKWByRIG4+FGr0D/tX3y/
         SrBBcw+9CDWoOdXLv0oNnwy66IrlnssODrwmw7THAEbNXzuij75V/YuKG2n4tJYmGofh
         QR3lbWWcIAmv9tPkPlDazuqRTyeLyIEy5XbNWxKTqfLb3hTv7rBpZq+OFuTeN+ofQgKf
         764B7Qx+N5XGFwLLGhz3w43c0GUVVeliiGdqoKbm5GI4byHCrtqA195up+IGWv1+/7kB
         +0+PwNpi/+OVfExZhmRnGZnFJjBxdvsLmiiHqrfqSeB/Cx6BJ4hLGoD20AYNY3mkNa68
         9yiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696240566; x=1696845366;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VI6ALURCYFTZzB2n0KbkvH0CnC/yIlDD9PmeGJooHMM=;
        b=BKdKvZILeB/dDfTWy/Su/MrQM/4HheKnuM1UcoaXHVL8UISWW+w5sorcDSt7QIQ3AV
         zp4/HJBzxbFOSqlv6A9/PwdKlf3jTVG4VzXZYsTbolYz4r56ZrEIEZ0pYfcBm3LHwvEI
         tPbqrhyaJ5AdLYnlJJjfX+yBJ74jAbLpqepI7n6KivlWDB/eCNkFQhAqyxOCfhWLJAN7
         VLoBVZ0/nusGUqCmyOgtOptGwaHj9wqpYraYKsc31aXwJ9Nq3UrBPxUrRntNmqXvOy1u
         x1LMleM/IoG2s8r7F0zdqVzGMk8tXH5bCKaz3ZuwpK9UWIxJRVsxc+yKgEMgBX6gcKa1
         xI1g==
X-Gm-Message-State: AOJu0YyVjqQeWtat0Dvdyf58/Ac1xH3IOz21zob8jLJaZjbIJlwLADbh
        Q72NSn6Rdxd2rWXomdT+0GUcqQ==
X-Google-Smtp-Source: AGHT+IEyPY2VWrXaKI4eQ9fWZwqFimDpZkQ+STvWpRTjmOVGlI4ZzlEncK2E1RdAljpCJEvp4OTGQw==
X-Received: by 2002:a05:6512:485b:b0:503:3707:66ed with SMTP id ep27-20020a056512485b00b00503370766edmr8580902lfb.34.1696240565714;
        Mon, 02 Oct 2023 02:56:05 -0700 (PDT)
Received: from [172.30.204.164] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id f8-20020ac25328000000b004fe37339f8esm4687715lfh.149.2023.10.02.02.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 02:56:05 -0700 (PDT)
Message-ID: <36e790a6-a9e8-bca9-226c-48339fefffb1@linaro.org>
Date:   Mon, 2 Oct 2023 11:56:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 5/5] arm64: boot: dts: qcom: sc8280xp: Add in CAMCC for
 sc8280xp
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
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
 <ec28c662-8065-4bfc-bd5e-af0b9f3e87ac@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ec28c662-8065-4bfc-bd5e-af0b9f3e87ac@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/1/23 01:01, Bryan O'Donoghue wrote:
> On 30/09/2023 17:41, Konrad Dybcio wrote:
>>
>>
>> On 9/30/23 15:41, Bryan O'Donoghue wrote:
>>> Add in CAMCC for sc8280xp. The sc8280xp Camera Clock Controller looks
>>> similar to most of the sdmX, smX and now scX controllers.
>>>
>>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 16 ++++++++++++++++
>>>   1 file changed, 16 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi 
>>> b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>>> index cad59af7ccef..ca43d038578b 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>>> @@ -8,6 +8,7 @@
>>>   #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
>>>   #include <dt-bindings/clock/qcom,gpucc-sc8280xp.h>
>>>   #include <dt-bindings/clock/qcom,rpmh.h>
>>> +#include <dt-bindings/clock/qcom,sc8280xp-camcc.h>
>>>   #include <dt-bindings/clock/qcom,sc8280xp-lpasscc.h>
>>>   #include <dt-bindings/interconnect/qcom,osm-l3.h>
>>>   #include <dt-bindings/interconnect/qcom,sc8280xp.h>
>>> @@ -3450,6 +3451,21 @@ usb_1_role_switch: endpoint {
>>>               };
>>>           };
>>> +        camcc: clock-controller@ad00000 {
>>> +            compatible = "qcom,sc8280xp-camcc";
>>> +            reg = <0 0x0ad00000 0 0x20000>;
>>> +            clocks = <&gcc GCC_CAMERA_AHB_CLK>,
>>> +                 <&rpmhcc RPMH_CXO_CLK>,
>>> +                 <&rpmhcc RPMH_CXO_CLK_A>,
>>> +                 <&sleep_clk>;
>>> +            clock-names = "iface", "bi_tcxo", "bi_tcxo_ao", 
>>> "sleep_clk";
>> clock-names is now redundant :)
>>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>
>> Konrad
> 
> BTW.
> 
> Looking at the block diagram for the Camera, I see why Cam_CC_AHB is 
> included in this list. Its not called out as a dependency in the clock 
> tree but when you look at the block diagram you can see it gates the AHB 
> bus to the CAM_CC block.
Yep, that's why using is as pm_clk for the clock controller makes sense

Konrad
