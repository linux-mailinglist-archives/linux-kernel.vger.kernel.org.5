Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB977FE329
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjK2W3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjK2W3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:29:51 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDB7C1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:29:57 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a04196fc957so35542166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701296995; x=1701901795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jjJ8Mb+534HQepceR4AuOphlKM7gML1f+9PSTE2HCjU=;
        b=Twumr8gt3E9+63cRKBsbZdTs9o0k95AQa92DaWz8n+2cGT/Z57di/Agc7C02U4l8Lx
         u82iKtJKVtpwEqYLBQFMHxS5AGgZPh3OnTLVDwcIT2y82TO+KXjd62RQa6XXwS65c2P4
         IF7c0nWRaPd7Q8lNKiCJ+qq24NP1lyJrgjmbDZrgztZ+Y3BQ1Sbdwelz6CBUBFdmDwbM
         SuNfw0uGXwuYoDnZliuna08llr/kvBcFeGfFhzJoLygVccSBk06sl4fT8pemcNGqpeiF
         sn7DgVNCQ4jcwqkYXZ0M1LTy3dD4aq+2CuTXowPRpFtjbGNr3kldd2UjXFAYjznublIG
         9Z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701296995; x=1701901795;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jjJ8Mb+534HQepceR4AuOphlKM7gML1f+9PSTE2HCjU=;
        b=jb6+4LY1I2tSIijrIkkhovsPV+fTjLuWtDzf07Z/SiaHE8tZ3A68BbX6M//oNeotF6
         NjZUMzpfjbW70d3/qLIBSJ9fYFPoXJueO1+FtG4fv481u68W99j3AK9MlqIcTPCGr8vS
         ukKU2ULUV599ro9FM7ss4BooqtiVBoEO575VluJnSJkEFkfZP/BDRGDFWwewXwPiG2ON
         CIAyMRlHVleM4TwCLKw4lNuf0eEz9C0Csukpdc3VhLilOmsDN92DkhVXXs810WgZeoyY
         3DYGJ3rGIdahUVrF+2CGsSrmheBETv9gs1wK76KmYeXnJwQyAcQnc8Hh39dl6oFeVZFS
         dT7A==
X-Gm-Message-State: AOJu0YxnySfzuHJbyFkauRUnkPMrUCMckxpmYjpbSIqm+o37zmb4NcCP
        pcpRL8AkGOnQu7x9wn0amzF1Dg==
X-Google-Smtp-Source: AGHT+IFPWBWAiWFLmSm+a0zThkr+g5UOIuJnAP86zUgmmcw2sX3gcHSnHqviZtEbzdTrQ2XTT+zKLA==
X-Received: by 2002:a17:907:9728:b0:9be:7b67:1673 with SMTP id jg40-20020a170907972800b009be7b671673mr17684397ejc.1.1701296995481;
        Wed, 29 Nov 2023 14:29:55 -0800 (PST)
Received: from [192.168.209.83] (178235187166.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.166])
        by smtp.gmail.com with ESMTPSA id f4-20020a170906560400b009fcb5fcfbe6sm8316172ejq.220.2023.11.29.14.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 14:29:54 -0800 (PST)
Message-ID: <5ffa4cbf-c30f-4169-ad75-38cd3e8d11c2@linaro.org>
Date:   Wed, 29 Nov 2023 23:29:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/5] arm64: dts: qcom: Add base X1E80100 dtsi and the
 QCP dts
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        catalin.marinas@arm.com, ulf.hansson@linaro.org
Cc:     agross@kernel.org, conor+dt@kernel.org, ayan.kumar.halder@amd.com,
        j@jannau.net, dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        m.szyprowski@samsung.com, u-kumar1@ti.com, peng.fan@nxp.com,
        lpieralisi@kernel.org, quic_rjendra@quicinc.com,
        abel.vesa@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, quic_tsoni@quicinc.com,
        neil.armstrong@linaro.org
References: <20231117113931.26660-1-quic_sibis@quicinc.com>
 <20231117113931.26660-4-quic_sibis@quicinc.com>
 <918ff1f5-ce01-43ea-b034-e69fbb31f495@linaro.org>
 <3dd41426-c026-a832-0a6b-0aabfaec2a8c@quicinc.com>
 <c6e05a10-88cc-409c-afc0-37166b763eaa@linaro.org>
 <8021a6f5-6316-031d-8181-e0e2047e2fa8@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <8021a6f5-6316-031d-8181-e0e2047e2fa8@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.11.2023 16:46, Sibi Sankar wrote:
> 
> 
> On 11/29/23 18:24, Konrad Dybcio wrote:
>> On 29.11.2023 10:25, Sibi Sankar wrote:
>>>
>>>
>>> On 11/18/23 06:36, Konrad Dybcio wrote:
>>>> On 17.11.2023 12:39, Sibi Sankar wrote:
>>>>> From: Rajendra Nayak <quic_rjendra@quicinc.com>
>>>>>
>>>>> Add base dtsi and QCP board (Qualcomm Compute Platform) dts file for
>>>>> X1E80100 SoC, describing the CPUs, GCC and RPMHCC clock controllers,
>>>>> geni UART, interrupt controller, TLMM, reserved memory, interconnects,
>>>>> SMMU and LLCC nodes.
>>>>>
>>>>> Co-developed-by: Abel Vesa <abel.vesa@linaro.org>
>>>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>>>> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
>>>>> Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
>>>>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>>>>> ---
>> [...]
>>
>>
>>>>> +        idle-states {
>>>>> +            entry-method = "psci";
>>>>> +
>>>>> +            CLUSTER_C4: cpu-sleep-0 {
>>>>> +                compatible = "arm,idle-state";
>>>>> +                idle-state-name = "ret";
>>>>> +                arm,psci-suspend-param = <0x00000004>;
>>>> These suspend parameters look funky.. is this just a PSCI sleep
>>>> implementation that strays far away from Arm's suggested guidelines?
>>>
>>> not really! it's just that 30th bit is set according to spec i.e
>>> it's marked as a retention state.
>> So, is there no state where the cores actually power down? Or is it
>> not described yet?
>>
>> FWIW by "power down" I mean it in the sense that Arm DEN0022D does,
>> so "In this state the core is powered off. Software on the device
>> needs to save all core state, so that it can be preserved over
>> the powerdown."
> 
> I was told we mark it explicitly as retention because hw is expected
> to handle powerdown and we don't want sw to also do the same.
> 
>>
>>>
>>>>
>>>> [...]
>>>>
>>>>
>>>>> +        CPU_PD11: power-domain-cpu11 {
>>>>> +            #power-domain-cells = <0>;
>>>>> +            power-domains = <&CLUSTER_PD>;
>>>>> +        };
>>>>> +
>>>>> +        CLUSTER_PD: power-domain-cpu-cluster {
>>>>> +            #power-domain-cells = <0>;
>>>>> +            domain-idle-states = <&CLUSTER_CL4>, <&CLUSTER_CL5>;
>>>>> +        };
>>>> So, can the 3 clusters not shut down their L2 and PLLs (if separate?)
>>>> on their own?
>>>
>>> on CL5 the clusters are expected to shutdown their l2 and PLL on their
>>> own.
>> Then I think this won't happen with this description
>>
>> every cpu has a genpd tree like this:
>>
>> cpu_n
>>   |_CPU_PDn
>>      |_CLUSTER_PD
>>
>> and CLUSTER_PD has two idle states: CLUSTER_CL4 and CLUSTER_CL5
>>
>> which IIUC means that neither cluster idle state will be reached
>> unless all children of CLUSTER_PD (so, all CPUs) go down that low
>>
>> This is "fine" on e.g. sc8280 where both CPU clusters are part of
>> the same Arm DynamIQ cluster (which is considered one cluster as
>> far as MPIDR_EL1 goes) (though perhaps that's misleading and with
>> the qcom plumbing they perhaps could actually be collapsed separately)
> 
> We did verify that the sleep stats increase independently for each
> cluster, so it's behavior is unlike what you explained above. I'll
> re-spin this series again in the meantime and you can take another
> stab at it there.
So are you saying that you checked the RPMh sleep stats and each cluster
managed to sleep on its own, or did you do something different?

Were the sleep durations far apart? What's the order of magnitude of that
difference? Are the values reported in RPMh greater than those in
/sys/kernel/debug/pm_genpd/power-domain-cpu-cluster/total_idle_time?

Is there any other (i.e. non-Linux) source of "go to sleep" votes?

Konrad
