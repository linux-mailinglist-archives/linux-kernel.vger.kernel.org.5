Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BDE7E4B2D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 22:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjKGVzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 16:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjKGVzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:55:08 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C9D10D1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:55:05 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50931355d48so8390807e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 13:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699394104; x=1699998904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=is3uec+Gjolh358pkRprV7sJtX7HVQmPCXm7wrHL1HE=;
        b=za9lE+XRX46dFeQ4xXMH9pW6OtXRF0XSAukO8UVHNzB5qPBMyr9LhTLoXAjtJV68Ie
         LXJuL6OS7mGl4jxCFxDn6lqQZgEVLowVw8kHqhkvTtlGn6KzjhLLAXBxMeWCOngVVXi3
         3qdQtwZurmVILgMZd6Ew14lMNQRhGdd29X/Wzguh2A3yK/wlraT+fjSo2xn036cYgpFV
         wy5hDb1tEjGCXSML1jHksgyh72SNmx1CT0G73YNSo/8Gkl1LHbvsk9Bvs78kPCJwaWcP
         q8ghOpLtcVewJUXHrO13WRA1+4kKtukpgvEEs7Mj0wf8ukSXJZZ7UUeT6fCXHdDeSmjy
         VzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699394104; x=1699998904;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=is3uec+Gjolh358pkRprV7sJtX7HVQmPCXm7wrHL1HE=;
        b=s89hr5tSY6uR20SiaAyvF/HqipMXeZWG4fuL/nWGbzHMinvfrpjmDBdP0b5kccuExX
         mgunARGJQxvLnsa8cHNa3DCdoC+/t2Mr9TixMx1Ql4LAAYSyubDDPo4nzM+sEiWdCcwx
         IWJungL6LUtVxtO4Ciq/OQ9Y5L57e0gldbI81NVonAeje4DefNTWVYxbFxLYdEas1tnL
         ZQqIs6bSum2dMuRKhvlcrBLyajOhCxp28CjZ9qQABaTi9VbBhcuioTssKAmKgroyYdoH
         PFmqN1MPjLSG/kqzv+ZfebIt7RpPRBEWrS/MLE+0JMnpYwum1hD7vww5jJ0ufAfGBQFT
         hiqg==
X-Gm-Message-State: AOJu0YzUq39MJDjl0LdsceNnP1SFDAh/ajDnrFxjUutayi8uw+eAjTgi
        LYXtybJiSA6jMYtR2qpyxKG1vA==
X-Google-Smtp-Source: AGHT+IEGa1Ik4BCcscA0WV4B7tpiUI0SnhrwmsDWsJnGx8HU27IkFvRL8BZQ8rU9z91pUDgpcDUeBQ==
X-Received: by 2002:a19:675b:0:b0:503:26bc:b08f with SMTP id e27-20020a19675b000000b0050326bcb08fmr24875055lfj.24.1699394103973;
        Tue, 07 Nov 2023 13:55:03 -0800 (PST)
Received: from [172.30.205.109] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id h24-20020a197018000000b00507c7ae32cesm462967lfc.192.2023.11.07.13.55.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 13:55:03 -0800 (PST)
Message-ID: <19f32f8e-dfe2-410b-9a4d-80e24a888d65@linaro.org>
Date:   Tue, 7 Nov 2023 22:54:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] arm64: dts: qcom: sa8775p: Add ep pcie1 controller
 node
Content-Language: en-US
To:     Andrew Halaney <ahalaney@redhat.com>,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mani@kernel.org, robh+dt@kernel.org, quic_shazhuss@quicinc.com,
        quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com,
        quic_nayiluri@quicinc.com, dmitry.baryshkov@linaro.org,
        robh@kernel.org, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com, quic_parass@quicinc.com,
        quic_schintav@quicinc.com, quic_shijjose@quicinc.com,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
References: <1699362294-15558-1-git-send-email-quic_msarkar@quicinc.com>
 <1699362294-15558-3-git-send-email-quic_msarkar@quicinc.com>
 <i3yum3wbko33jwn7tfbcflpcxe5k5j5ituhyxtucx6gk2bs3gz@7ncewfmepnai>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <i3yum3wbko33jwn7tfbcflpcxe5k5j5ituhyxtucx6gk2bs3gz@7ncewfmepnai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/23 19:37, Andrew Halaney wrote:
> On Tue, Nov 07, 2023 at 06:34:53PM +0530, Mrinmay Sarkar wrote:
>> Add ep pcie dtsi node for pcie1 controller found on sa8775p platform.
>> It supports gen4 and x4 link width. Limiting the speed to Gen3 due to
>> stability issues.
> 
> I wouldn't mind a bit more information on what "stability" issues
> entails! I'm a sucker for details in a commit message.
Yep, giving us a bit more than "doesnt work" may help us help you!


>> +
>> +		interrupts = <GIC_SPI 518 IRQ_TYPE_LEVEL_HIGH>,
>> +					 <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
>> +					 <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>;
Looks like the indentation is off?

>> +
>> +		interrupt-names = "global", "doorbell", "dma";
>> +
>> +		interconnects = <&pcie_anoc MASTER_PCIE_1 0 &mc_virt SLAVE_EBI1 0>,
>> +				<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_1 0>;
> 
> I keep seeing Konrad requesting that we use the #define instead of a raw
> number 0, i.e. something like QCOM_ICC_TAG_ALWAYS (although if I'm
> reading that correctly QCOM_ICC_TAG_ALWAYS doesn't evaluate to 0, so
> make sure you pick the appropriate one).
No it doesn't, but if you look at the code, tag being non-existent
assigns QCOM_ICC_TAG_ALWAYS which is a workaround for DTBs from back
when interconnect tags were not a thing

> 
>> +		interconnect-names = "pcie-mem", "cpu-pcie";
> 
> This is nitpicky, but unless someone told you to do the whitespace
> between some of these properties I'd get more consistent. i.e. reg and
> reg-names has no newline between them, but clocks and clock-names does,
> and then interconnects/interconnect-names does not.
:)

Konrad
