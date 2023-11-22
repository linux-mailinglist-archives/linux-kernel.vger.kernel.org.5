Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F067F50F5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 20:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjKVT5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 14:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjKVT5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 14:57:18 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5383E18E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 11:57:15 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50797cf5b69so110363e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 11:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700683033; x=1701287833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z3eKzYiaUPur0IhJyaSZpFt+RCAlVJJsNbMkeIZr53A=;
        b=oSYrgAoAD7E7HWiDD3/6emjf+SZ6wssePKx0/pvPXKq/HThtopipCHnnWQaiDCbDKb
         d+miICMqkxzC52iUdr9YrgjPGEkjlnJ2lFSU0YxiQXAfvxUnlDQ3MJl7dqIfoEi81NB1
         SKEkFFHX+DEcINvqozesRHYTE0AWjReXNZDeXklvskm679DsiDCHqh9KMKWhKgu8RSuG
         qahLfB6ASZD5XqoAQBRpUAO8O4dNhGQ1xfU53EcK3mDmkWND6i78a+ROqlFflWd4iDHY
         Ld0EZEWoSkDGVcE7cnLCpNA+Lw5r0ePnx6Wd4US3y15TZdbzOzm4PaP1Y6GQLsrrDXgq
         jOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700683033; x=1701287833;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z3eKzYiaUPur0IhJyaSZpFt+RCAlVJJsNbMkeIZr53A=;
        b=s/fLWd7YolIYs3Told1yjF+uDmaISP239SLnC8gChUpnABr32RH6XkKHP7lN2CEnwD
         MXFBDJ1PBXe31J80jB7VzzF1jG4DJbLKf85fO/GN97jOQ55PL6JzKId01KR5nI3zDRGa
         z33e+4Qvd2c0WPvPEBMu8FBAFcY36JqUlGEr1ZWSUN+8HuutbfSODVDWMlfnbmPAjoLc
         b+nMIz1SWn24uw08kr+qjudyju/hcIOwu1cqN6s/SdJoV+Nd0NfHIPMM9rrrrRUCDmwx
         NiGjjBcOfFJzDaiaaSeslj3+6GmCrpYfJYSxuvt7cI8r0PPAgL7oW4aD0C3H3mezVfJS
         jpkg==
X-Gm-Message-State: AOJu0Yy8I496q1ZTc6qn7qdTIC9ukxs57dVqdJPsUuZpHQVyqIOrbTde
        wd5nRqTYOBMOgt7TB1jgwXZgRQ==
X-Google-Smtp-Source: AGHT+IFXLsNjyGl1aWYWlgDu4MftGSAqzRIBwU82aj9LRkzZJs8EcwuYv+qq3oVWL6RWFELs3lHO0Q==
X-Received: by 2002:a05:6512:3254:b0:50a:a571:88 with SMTP id c20-20020a056512325400b0050aa5710088mr2424023lfr.61.1700683033496;
        Wed, 22 Nov 2023 11:57:13 -0800 (PST)
Received: from [172.30.204.74] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id u19-20020a05651220d300b0050300e013f3sm1935876lfr.254.2023.11.22.11.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 11:57:13 -0800 (PST)
Message-ID: <4fe84f86-b7e8-4f71-8a01-dabb835959c3@linaro.org>
Date:   Wed, 22 Nov 2023 20:57:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] soundwire: qcom: drop unneeded
 qcom_swrm_stream_alloc_ports() cleanup
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20231120190740.339350-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231120190740.339350-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/20/23 20:07, Krzysztof Kozlowski wrote:
> The cleanup in "err" goto label clears bits from pconfig array which is
> a local variable.  This does not have any effect outside of this
> function, so drop this useless code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
