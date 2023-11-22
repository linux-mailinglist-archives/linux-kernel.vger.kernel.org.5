Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1CB7F50F8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 20:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjKVT66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 14:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjKVT65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 14:58:57 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874E312A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 11:58:53 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507c5249d55so120370e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 11:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700683132; x=1701287932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=owGEeKQSkUhkxsVwujRwMFyJouN+ra21rm+Zo53wjqY=;
        b=tvaT9HmKRdWu84mo5ZPHWsY8T9pmn1kNg0kicHvaDcySX/AY4EBXLHFBAPShQ2dKnH
         aWjjKBBhnY2SabxcgPt19YuIAE3vlIdYpRQtY7G4byKJxj0e7qVC4YVGyjyOiSZ0/zWb
         04yTfH/DkJEbargl75isHL5TOP+AJsas9MLcpQTwndFTFhEZfuqs4AEpFdThrx5l37eb
         Z6t9CQAreVFxVWYF7rHtlMHnHw6HRAKsVRnlvlUOrCbywTrglqpXob1kl9kAl8XgUpdl
         7CUer/lEy2akSBEj3B00r5gShYAUbezhLQJ41cDT7QHFVyWuDJoz1ngD6k0npX7whSRp
         voeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700683132; x=1701287932;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=owGEeKQSkUhkxsVwujRwMFyJouN+ra21rm+Zo53wjqY=;
        b=vgd1wQ2OZJ3IjBa3aA9v9B9EW5Xdl3MjjT+CSsLXrALwfHy5HD7svzFjltak6hxFoB
         LNnsHETphMJF1exQUenbBluDN4Cvpy+lwWBo8YhdyDa3XRa3yTlW00gmq7pGjgeATjCd
         +Dfh8F1Whs+1UdS0zc9sLdYqZPWTvf182BhmSA8ecu1Uza2xrX/JLTdnUP/Yu/LvhEhw
         qf0ZxBCMgT9WPZQHAkdrZIby75vz370wxv4jkpKcaqdm7umONkbH6Iy7y2/qWqgubwDG
         Tz+cqw42jLszXb4uqqfTYILjcu4uoEObQpw31srvNAnolC9Ow6tABuOa6XkU/Ma6BNGS
         WL1g==
X-Gm-Message-State: AOJu0YxxjRESUlaAOGYDu9te88Cxzfhq15IasLh4/gOlFVZw1Uac1wgK
        FvUZBUUsmunCgeMoAm3/rUC14Q==
X-Google-Smtp-Source: AGHT+IGYqOWN7ZE1DBlANCP1hywbHhcJvA+AMBnV5R5G1Kpc69S8u66ZkA3X4OqbdUjjha8Wo36dKg==
X-Received: by 2002:a05:6512:b86:b0:509:8fbf:7af0 with SMTP id b6-20020a0565120b8600b005098fbf7af0mr1044667lfv.69.1700683131795;
        Wed, 22 Nov 2023 11:58:51 -0800 (PST)
Received: from [172.30.204.74] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id u19-20020a05651220d300b0050300e013f3sm1935876lfr.254.2023.11.22.11.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 11:58:51 -0800 (PST)
Message-ID: <b7b7db08-7294-4085-8249-e7b1741dd796@linaro.org>
Date:   Wed, 22 Nov 2023 20:58:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] soundwire: qcom: move sconfig in
 qcom_swrm_stream_alloc_ports() out of critical section
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
 <20231120190740.339350-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231120190740.339350-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/20/23 20:07, Krzysztof Kozlowski wrote:
> Setting members of local variable "sconfig" in
> qcom_swrm_stream_alloc_ports() does not depend on any earlier code in
> this function, so can be moved up before the critical section.  This
> makes the code a bit easier to follow because critical section is
> smaller.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
