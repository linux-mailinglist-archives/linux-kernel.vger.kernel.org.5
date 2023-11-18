Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BE37EFF3F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 12:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjKRLaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 06:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKRLaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 06:30:06 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56007D75
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 03:30:02 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 5b1f17b1804b1-4083740f92dso2921285e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 03:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700307001; x=1700911801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I05hizi/ziQIYj44ryTJSTiDmdIMI2fLRCRgol7O9do=;
        b=bqbnVh2+2ZquxsoTXdQHewg/IsptQlBZSCXH6cI56CIq9Cwox+zR/hhOWU6VdmrThu
         EtKHvmTcjhL32xt67NGyY3fngjF0DUQHV8Z/tvAsWGx+7h++gE8vjbuHin23ySsH1HZr
         PDw9BPS6ZFf+L2imXaqRs54veJY5Fd0e5VRX2H2aE3/+CwJmNX65lOaGAXVocwglTBIk
         qq6PKTbv+g8D46pS+GfMPdoc5NsWBCfU+IAAFMf1L/Pm9zGfDHIebIcwwJf4j7WKMIXd
         Jjk0jFxyYum0nXFO0QYsmX8toW0eL+n6Y1KRhM/tKdvkqD9X1plsZzhI/pMQj3FnRpY6
         CBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700307001; x=1700911801;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I05hizi/ziQIYj44ryTJSTiDmdIMI2fLRCRgol7O9do=;
        b=Hlz0iGpE97h5I10l3+ZkFchJh20ghRGqSg10AsWUk/Y4zF9CF9QtEa/r6seX8VLR6u
         nv27v9XQjOk4cKHICmXrdvsWuuU7nlCwrE79fFy0e0g9WiugOnSewK+75MqtyzohtVJH
         aDPxfe/SEOKoEyIUaotdYWEUddHySuzgS1zMI90uep+jKGky5pbINRZh+OSMv0fPjyia
         O1LAY/QkpdOEYkRobe4u9kSHAQ2XAuCSl3yXVbChtVSIX0rLHL4ijjdKtS1HeKJeQyHN
         ly2UJQitgAJxwrzg7XNsQkf52Z+w/rlLHf8dFibA51W7fU5Bqb8Y/D4AeC2kAmnz88Py
         52tQ==
X-Gm-Message-State: AOJu0YyD7ld3AlmWpvHfdCGZulezYu83w1g6Lq2aZqYrQI5GlCiQrMN6
        K+2ReU9AMcSqtrLslO4Ou/h7Sg==
X-Google-Smtp-Source: AGHT+IHXRPdTBeCZwvX5z2lN8s7sgQIAOPmxapzZDUOSqb/DBt8xN/LwehbOdqPRjfGrH960hvtUQA==
X-Received: by 2002:a05:600c:3b27:b0:405:a30:151e with SMTP id m39-20020a05600c3b2700b004050a30151emr1563466wms.12.1700307000180;
        Sat, 18 Nov 2023 03:30:00 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id y4-20020a5d4ac4000000b003316c8ad545sm4008051wrs.76.2023.11.18.03.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Nov 2023 03:29:59 -0800 (PST)
Message-ID: <715fd71e-89c7-4332-9c45-361f6562b1b7@linaro.org>
Date:   Sat, 18 Nov 2023 11:29:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Add sc8280xp CCI and CAMSS core dtsi
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, andersson@kernel.org,
        agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        dmitry.baryshkov@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jonathan@marek.ca, quic_tdas@quicinc.com,
        vladimir.zapolskiy@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231012113100.3656480-1-bryan.odonoghue@linaro.org>
 <e59569d3-cb49-4e11-8bd8-f814f369aaa7@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <e59569d3-cb49-4e11-8bd8-f814f369aaa7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2023 00:51, Konrad Dybcio wrote:
> On 12.10.2023 13:30, Bryan O'Donoghue wrote:
>> V4:
>> - Adds RB - Krzysztof
>> - Drops indicated newline - Krzysztof
>> - Moves "This patch depends-on" below the "---" - Krsysztof
> Just a note for Bjorn, this series is likely on hold as we iron out the
> driver details.. e.g. _src clocks were dropped since this submission.
> 
> Konrad

Eh yes.

Let me take the opportunity to plug the series/patches I'm targeting 
that Bjorn can merge

The CAMCC controller
https://lore.kernel.org/lkml/20231026105345.3376-1-bryan.odonoghue@linaro.org/

The first patch here
https://lore.kernel.org/lkml/20231110-b4-camss-sc8280xp-v5-1-7f4947cc59c8@linaro.org/T/

---
bod
