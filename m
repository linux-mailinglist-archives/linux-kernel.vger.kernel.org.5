Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6F17D660E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbjJYJBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbjJYJBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:01:20 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE07198
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 02:01:17 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507b9408c61so7400814e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 02:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698224476; x=1698829276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AvgTazU05wmbAVu8s1pewYEdDleLktThS4lYuVG5GWA=;
        b=OimNZ9aVm7DVVVDFF1tukWaSQxopYsClRM3K7b8f4qan4CyOH0cREhf2KVe4Un2ES5
         WcRw35fckOwoIiTqkjg5MjM+FaMpCF0+Y/+S/NutqQYLnwS8Rt6Kmh9M/Zk6DrCutn9Z
         ysqOdiMrKIMQNXSIy/U1VxTCb5uub82OyhOAJTd75VYP3pMDjCW4EUdn0++rFk5w9UFU
         xe1JODdIaIzKzLRtIfvgwbeiaw/jKpvgpdqrBPDoBuBTslvq7upC2ahNpvoETObWTUzj
         +gDl2MuV455IKhbCQUpcXIO6okKn7Z+jv296wY/939HO5A+8Xnyq8TNh1EzlDSQHFRaM
         zDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698224476; x=1698829276;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AvgTazU05wmbAVu8s1pewYEdDleLktThS4lYuVG5GWA=;
        b=q68uUYvbay6f3Y//l6opHxdJ4Pva3P7Sptm7IUbpGtDNXCgy2SufKADwzgLDK8zYkO
         QvTnR9/HiqFMTeQg0i2sYUPe4sU09L1nfwZrdj+gB0cRGE7KM1wVW97JxqlEEFJOzuFC
         YO2rqyiqmeMAlUOAQlHpI2OqOB+A9slYEkVjE8JGmPk61Y3Pw2DeaNoMCrOkhny+C+Hm
         5wZNHn1rUNzWUkdnxtAhHuOUH64g/mx+aGPWLeuylrZN8urLMFN3hshaesNkRo20CYWx
         JjAuZyR3EIJY/SIuQIfaNHYwxctpa9Z2stdnJuLJIjPsgB+INlTJB9hZPvfJkdstILmb
         l6OA==
X-Gm-Message-State: AOJu0YzCCFm3kAWqBVDlIIG1GCGTEQwgFt5IV4xV9kAImmBR+g+rNZat
        1eBusek2wYuFGbvlIHAP+QT+2Q==
X-Google-Smtp-Source: AGHT+IEcHR1W3xSeqiVG6hd48eONiv2HigJ9anogPs5wH/X2HmMIp0FVAqWjrSocCI2xbJRSQd2SBQ==
X-Received: by 2002:a19:9115:0:b0:503:1722:bf3a with SMTP id t21-20020a199115000000b005031722bf3amr10690089lfd.1.1698224475861;
        Wed, 25 Oct 2023 02:01:15 -0700 (PDT)
Received: from [172.30.204.57] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id k10-20020ac257ca000000b005079ab8ab19sm2458305lfo.150.2023.10.25.02.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 02:01:15 -0700 (PDT)
Message-ID: <691f1781-906c-411f-90f6-e1cc71062253@linaro.org>
Date:   Wed, 25 Oct 2023 11:01:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/8] arm64: dts: qcom: add initial SM8650 dtsi
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231025-topic-sm8650-upstream-dt-v1-0-a821712af62f@linaro.org>
 <20231025-topic-sm8650-upstream-dt-v1-2-a821712af62f@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231025-topic-sm8650-upstream-dt-v1-2-a821712af62f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/23 09:47, Neil Armstrong wrote:
> Add initial DTSI for the Qualcomm SM8650 platform,
> only contains nodes which doesn't depend on interconnect.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---[...]

> +			CLUSTER_SLEEP_1: cluster-sleep-1 {
> +				compatible = "domain-idle-state";
> +				arm,psci-suspend-param = <0x4100c344>;
I think this parameter signals the AOSS to attempt system
suspend and CLUSTER_SLEEP is a shallower, separate state.

[...]
> +			qcom,tcs-config = <ACTIVE_TCS    3>, <SLEEP_TCS     2>,
> +					  <WAKE_TCS      2>, <CONTROL_TCS   0>;
Is <CONTROL_TCS 0> the correct value?

I think it looks good otherwise

Konrad
