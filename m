Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9277CD6DC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjJRIp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjJRIp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:45:57 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8849FD
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:45:52 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507c91582fdso424041e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697618751; x=1698223551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vuSYY3UGKypgoG2oO5ZQJosLBGlI5DqiAchgtxsdT+A=;
        b=uiW4x9X7+oXbI5SPD38k2qtsRFEyiYJTgU1qhvI0tdGAWFi/ttyVByam7Ugtzm6/+V
         7lgfI7267nazWExKIc9Ef0vV4K/IgmtraNyzUKdnq1trmUP5TOcHeadlSUjhvHZVkppC
         kPmkZPtFOTCmiNFfHf44cLBJtI7526AaIol/IKAhP6RKAPQbLMrcy9JJXpVAguIsZCvE
         uTFVs6OEaa2YRGX7ANbvT8AG7uFMhQow6MxFRAb5yFGlztSoM86p5qqBPVDQ/u9sDmZl
         1flyMSo1DMeF2umSPWEd6J/YjyFD974gr23Ktn77PxHpFFHTnFhXaBQzuxvTVoY+sl/R
         a9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697618751; x=1698223551;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vuSYY3UGKypgoG2oO5ZQJosLBGlI5DqiAchgtxsdT+A=;
        b=N8SjPdkHEXRSXZccw+SIpgxa48zl9ggZshWdk2TsxhxpuGUcZHP9w3+Tl3FzL9gQS1
         UHJ5rLQEa8a1KPIKIhkI53hwVV+w2XB/dvxVoT+giQAOHBaeTntG7UNbAcAiZ93ftQzd
         NI3BnfgPEsNlkkSQPF7JylpiDaxEbBy4CsSH9NsPEf8Pqwi1s2GTwF5LIbWg97fY+LAi
         v69CbuViZ4UlXiS0VXODBTdlqsEyO+BgTZh5blIzLGfdFiHXXZKph8ndfulkmW/UhI2s
         ZzdIWWjdp5ZomsYiaFJtBgrWM78PgUmeEl7pQ+btoMbMHoay+uAXFxAHUM+5ao5oHFSO
         /dVA==
X-Gm-Message-State: AOJu0YxvLqS2US6vNLWPK+71BQ6umA+YU2xukOSCLzZNkEklj3l3wDlX
        ymDJEs5A7GQ8swPI6IFrOxdcrg==
X-Google-Smtp-Source: AGHT+IFSrAtYIXnsRJz+6mqib8VMrG9JuyZoa2zobypzJyTfE5YOgWamYLpLwlmq6ZWXvifQ2+ZqTA==
X-Received: by 2002:a19:645b:0:b0:507:b935:9f5f with SMTP id b27-20020a19645b000000b00507b9359f5fmr3390635lfj.24.1697618750850;
        Wed, 18 Oct 2023 01:45:50 -0700 (PDT)
Received: from [172.30.204.55] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id l2-20020ac24a82000000b00502fd9110ffsm615707lfp.294.2023.10.18.01.45.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 01:45:50 -0700 (PDT)
Message-ID: <06f3e2b0-bfeb-40db-92e2-279abfbb98cd@linaro.org>
Date:   Wed, 18 Oct 2023 10:45:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] cpufreq: qcom-nvmem: Simplify driver data
 allocation
Content-Language: en-US
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
References: <20231018-msm8909-cpufreq-v2-0-0962df95f654@kernkonzept.com>
 <20231018-msm8909-cpufreq-v2-1-0962df95f654@kernkonzept.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231018-msm8909-cpufreq-v2-1-0962df95f654@kernkonzept.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/18/23 10:06, Stephan Gerhold wrote:
> Simplify the allocation and cleanup of driver data by using devm
> together with a flexible array. Prepare for adding additional per-CPU
> data by defining a struct qcom_cpufreq_drv_cpu instead of storing the
> opp_tokens directly.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
