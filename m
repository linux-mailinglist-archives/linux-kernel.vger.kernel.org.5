Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D191D7DF3DF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 14:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376555AbjKBNct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 09:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347444AbjKBNcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 09:32:48 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089B6134
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 06:32:40 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-540c54944c4so1896642a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 06:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698931958; x=1699536758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWqG2ztO/4Kq+r8e04N5c4GPpXVKxa7YE3LsI9aATO4=;
        b=B9VQzk4L4RKdJXGDEPgDhA7E6v9/G2StDHV4N1sYC9nil2RqE2pAS2wduP5+ILV7vf
         X/MrBazHwDJnZHKI5KMyuIpTQEH+mtWvc6mrYyN1rjM+UcINgdsGj+4l8HEG05uGawYr
         rptPitD0UHl/OIoTOUqGvk69MzZExkb/2bLx4XWpwUo53H+ZZ7xvrMtk4MVaXRKjdSJr
         QAwY3io1/POj/TXrUrMu2VNNLilU10wP3Sjdlc9Nwz5tkXL87op9wwmjImlTO2jEcHxR
         D6oLrKX77y+PRkb90rrsLl1LRJg5OPbMAezY+s99Y6+ZS3rXyjsM5AWyIhYyjSgM0NG5
         Sk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698931958; x=1699536758;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TWqG2ztO/4Kq+r8e04N5c4GPpXVKxa7YE3LsI9aATO4=;
        b=J5XXmBCg5MkBnBx+xs8ZCEEG2RCIAIdT3vaaq3khBEuF29x71LqRgyIddPDSTvh/ew
         BA/aOR5z8rvjlKJMg8/14AlOv8iSIKmK/TPCaMLmkM6xLiRjOmiWyJ9wcRNAXj/0zJpJ
         xe4Hlp3CG5csPo17KNDWH5UlxlRjdeIcDlZQ8bb5roaGqbNe4Ned7xK4tqskkRChx4LB
         3aUwkegJ3W0T+PeG0UhVpRJAcGEaRs44ADLb46PxmjJNQ0gtDfqmBU7N3zPtxtL/Cli6
         H+ukyXULgBaufmbRc5tAtuhbV0BgmtzaolWfXo6T36ZZ23DLi1V/uxPFoQ0+rVQyi2Wl
         tVgQ==
X-Gm-Message-State: AOJu0YxABSvfM4KOYTLON6tRQqi5fMQeKqbmlaQ0AZo+6evOa8ym+s9Z
        yib8WwaIwYqUM+Zuwnfyr1q4lw==
X-Google-Smtp-Source: AGHT+IEAKMfeVnCg00V7ZQjJLGjgu3S7wbNyIyAKdOYKhJZ3Aq9axcEXnT3psGJCj1/BIPzRB86pcQ==
X-Received: by 2002:a50:aa92:0:b0:543:57dd:503 with SMTP id q18-20020a50aa92000000b0054357dd0503mr7029602edc.3.1698931958088;
        Thu, 02 Nov 2023 06:32:38 -0700 (PDT)
Received: from [192.168.1.118] (abyj199.neoplus.adsl.tpnet.pl. [83.9.29.199])
        by smtp.gmail.com with ESMTPSA id j18-20020a508a92000000b0054351b5a768sm2378891edj.82.2023.11.02.06.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 06:32:37 -0700 (PDT)
Message-ID: <30b4c424-39ee-7ae6-faf2-c5ba32dda07f@linaro.org>
Date:   Thu, 2 Nov 2023 14:32:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH RFC 2/8] arm64: dts: qcom: add initial SM8650 dtsi
To:     neil.armstrong@linaro.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231025-topic-sm8650-upstream-dt-v1-0-a821712af62f@linaro.org>
 <20231025-topic-sm8650-upstream-dt-v1-2-a821712af62f@linaro.org>
 <691f1781-906c-411f-90f6-e1cc71062253@linaro.org>
 <e86fa7b4-635c-4fd5-9b3c-ade96ddf5c0f@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <e86fa7b4-635c-4fd5-9b3c-ade96ddf5c0f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/11/2023 11:54, Neil Armstrong wrote:
> On 25/10/2023 11:01, Konrad Dybcio wrote:
>>
>>
>> On 10/25/23 09:47, Neil Armstrong wrote:
>>> Add initial DTSI for the Qualcomm SM8650 platform,
>>> only contains nodes which doesn't depend on interconnect.
>>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---[...]
>>
>>> +            CLUSTER_SLEEP_1: cluster-sleep-1 {
>>> +                compatible = "domain-idle-state";
>>> +                arm,psci-suspend-param = <0x4100c344>;
>> I think this parameter signals the AOSS to attempt system
>> suspend and CLUSTER_SLEEP is a shallower, separate state.
> 
> OK, so downstream call this state "APSS_OFF" and the other state
> calling 0x41000044 "CLUSTER_PWR_DN"Well, the name APSS_OFF suggests that all clusters go offline so
that would be a bit more complex than a simple "cut power to this
cluster"


> On sm8[345]0 and qdu1000/sm4450 there's both states called 
> CLUSTER_SLEEP_0 and CLUSTER_SLEEP_1,
> and referenced into CLUSTER_PD cluster power domain.
> 
> I assume this is the same as SM8550, so what's the issue ?
It's just that we've been naming it in the most generic way possible
and that it could be more descriptive, especially given its
correlation with different things

Konrad
