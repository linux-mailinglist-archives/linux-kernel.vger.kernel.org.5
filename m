Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA697E2F3E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbjKFVwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjKFVwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:52:30 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473F0D57
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 13:52:26 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-509109104e2so6542178e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 13:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699307544; x=1699912344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/qRrFx/wNeMYw9ETElF53MB35UWxI/2rKGXFKbSlTEw=;
        b=X54NDkNi7eB0X80HC5GMsu+fqiV8dWuUr+TMXvt8c7KhE8RXrnvFhHr1nloTfb3rED
         csSv17el10DU5U/iM/JBJjLkW0zcIAkUizo6z+yl7lVRIWkUxTP6N6oL3v5maxhiaTRQ
         LE3uS8m+Uds6howuq/7C6ePkWbQJ2fyUYgGHWiGEzrvywQeZ6gAt+zfaKcKj7g97ZS7W
         76HHS2f5JrcwiZW09VuDxzJjn6ILgZfR68qgHmlo6oGZiSBAj37DRKoOObB0uuXYIP4C
         Ow8st+UgikN5BpB/rs97Tmq9vfmyraf07q6WRSNGOFF9xntwuVM8jraJNB49dFFZPYty
         fiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699307544; x=1699912344;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/qRrFx/wNeMYw9ETElF53MB35UWxI/2rKGXFKbSlTEw=;
        b=bIS5ahfbNNhAO1quUo+wZ5tfPgo5hnFr0Zl6MmilJj9TiO4L0FcDUiYBFTOHU1z0Be
         u43zujG0o/+7EGWpIdRTJ+nvf+rQMJVDdx3UyPNZi/M/PQKMrvNUjoxlQ0tB9X5XPMvx
         iykbC7PO6W4TB+qs1leXv7pI/Js1/C4AM5VIEkh3rexZNsokVs0AEBTNXFU+SrSw5E+X
         /aWiEgR3BgA8kXnqI5SAVTm2UjBYGp4A/NB4cs2KGg42H4B0sleeiQhHJmdQRMj0fcz9
         RRGjExju9+QxN9bgUjTokqsCS4vBECNzEc3MrHp9MBVluVNgEb3ErmInpBIlEkIBAVMS
         S4yA==
X-Gm-Message-State: AOJu0YzEMtALYep4ya6bg/pHsERMcbhg5bfap2hEuEC1JqQuu2eJP1+t
        LTgItOAhffiMVzXdzM3riamJug==
X-Google-Smtp-Source: AGHT+IEfY5A/EtKdSou972t7ClGnYfgkScAaLuG2gYZRayKdE6odNjC1Th/Nlm7E4A7dlaZdyZq1mw==
X-Received: by 2002:ac2:5def:0:b0:500:daec:2817 with SMTP id z15-20020ac25def000000b00500daec2817mr22298941lfq.54.1699307544506;
        Mon, 06 Nov 2023 13:52:24 -0800 (PST)
Received: from [172.30.204.18] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id c3-20020a196543000000b00501c12fe522sm105077lfj.73.2023.11.06.13.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 13:52:24 -0800 (PST)
Message-ID: <a3f3c391-370a-4ed2-92ed-afcfbea829e8@linaro.org>
Date:   Mon, 6 Nov 2023 22:52:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280: Add capacity and DPC
 properties
To:     Doug Anderson <dianders@chromium.org>
Cc:     Ankit Sharma <quic_anshar@quicinc.com>,
        cros-qcom-dts-watchers@chromium.org, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_ashayj@quicinc.com,
        quic_atulpant@quicinc.com, quic_rgottimu@quicinc.com,
        quic_shashim@quicinc.com, quic_pkondeti@quicinc.com
References: <20231103105440.23904-1-quic_anshar@quicinc.com>
 <feca8e74-6653-4cec-943d-47302431e1fc@linaro.org>
 <CAD=FV=VTCXSQo3Bo3G7oJ48qA-fUet5rHAzT8WLM1Hx70KyYMA@mail.gmail.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAD=FV=VTCXSQo3Bo3G7oJ48qA-fUet5rHAzT8WLM1Hx70KyYMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 11/6/23 17:56, Doug Anderson wrote:
> Hi,
> 
> On Sat, Nov 4, 2023 at 4:52 AM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>
>>
>> On 11/3/23 11:54, Ankit Sharma wrote:
>>> The "capacity-dmips-mhz" and "dynamic-power-coefficient" are
>>> used to build Energy Model which in turn is used by EAS to take
>>> placement decisions. So add it to SC7280 soc.
>>>
>>> Signed-off-by: Ankit Sharma <quic_anshar@quicinc.com>
>>> ---Hi, thanks for this patch
>>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>
>> I performed a quick grep in arch/arm64/boot/dts/qcom and noticed
>> that at least one of these values is missing for:
>>
>> rg -l --files-without-match dynamic-power-coeff $(rg cpu@ -l) | sort
>> ipq5018.dtsi (homogeneous cluster)
>> ipq5332.dtsi (homogeneous cluster)
>> ipq6018.dtsi (homogeneous cluster)
>> ipq8074.dtsi (homogeneous cluster)
>> ipq9574.dtsi (homogeneous cluster)
>> msm8916.dtsi (homogeneous cluster)
>> msm8939.dtsi
>> msm8953.dtsi
>> msm8976.dtsi
>> msm8994.dtsi
>> msm8996.dtsi
>> msm8998.dtsi
>> qcs404.dtsi (homogeneous cluster)
>> qdu1000.dtsi (homogeneous cluster)
>> sa8775p.dtsi
>> sc7280.dtsi
>> sc8180x.dtsi
>> sc8280xp.dtsi
>> sdm630.dtsi
>> sm4450.dtsi
>> sm6125.dtsi
>> sm6375.dtsi
>> sm8350.dtsi
>> sm8450.dtsi
>>
>> rg -l --files-without-match capacity-dmips $(rg cpu@ -l) | sort
>> ipq5018.dtsi (homogeneous cluster)
>> ipq5332.dtsi (homogeneous cluster)
>> ipq6018.dtsi (homogeneous cluster)
>> ipq8074.dtsi (homogeneous cluster)
>> ipq9574.dtsi (homogeneous cluster)
>> msm8916.dtsi (homogeneous cluster)
>> msm8939.dtsi
>> msm8994.dtsi
>> qcs404.dtsi (homogeneous cluster)
>> qdu1000.dtsi (homogeneous cluster)
>> sa8775p.dtsi
>> sc7280.dtsi
>> sm4450.dtsi
>> sm6375.dtsi
>> sm8350.dtsi
>> sm8450.dtsi
>>
>> Where platforms with a single, homogeneous cluster likely don't
>> benefit from EAS..
>>
>> Is there any chance you could dig up the correct values, for at least
>> some of these platforms? Or would you know whom to ask?
>>
>> FWIW the one we're missing the most is sc8280xp..
> 
> FWIW, I wrote up a longwinded commit message when I added these values
> for sc7180. See commit 82ea7d411d43 ("arm64: dts: qcom: sc7180: Base
> dynamic CPU power coefficients in reality").
> 
> The short of it is that if you have hardware and a basic "smart
> battery" to measure power consumption it's pretty easy for anyone to
> add some reasonable numbers.
That's a big ask, especially with stupid laptop battmgr firmware that
only refreshes data every 5 to 25 seconds :)

Qcom probably has some reasonable numbers somewhere, given they are
likely to test their SoCs' characteristics before taping them out
en masse :P

Konrad
