Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA93806F8E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378212AbjLFMT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377846AbjLFMT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:19:57 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9B812B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 04:20:01 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2ca0f21e48cso34105451fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 04:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701865200; x=1702470000; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+i4Ygk68LEIXvF8ovwCDnUeBvBPCrOF9ltM3kyzBELs=;
        b=PF1ziB2SIg4qc/OE5MV0auQAj/lWiY3/ZBafxRKxFSVH/WUD9JzLLdMy8jDb9/DnMB
         5MADX6vbvWyhfx1It6PvZJe+qhOp4apenPvNou5cm1WnhCHAgz8GptVOxlPD85FK1n+K
         ptDipsmIuNCrM8f1BH0wh7XiMM1VlkdkAsw5jVfcMmP0akwDye0CXlcfZdhbA1bkxHFK
         /bcRZuB+/9UtwphSDtzxTGd/mvkrgilmrBmwe76Rk7u0bKT7TP2Q8USQzz/eh1S6+m2L
         nYlsfnBnfTyBRQA3MWRH1i1pfXJNmILB3LZ3yxq21FZcQdMT6i8VAA/Oa4fdnh1/xa9M
         ezWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701865200; x=1702470000;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+i4Ygk68LEIXvF8ovwCDnUeBvBPCrOF9ltM3kyzBELs=;
        b=MnvRNCmbuiO4n23gJ1CnKEGWMEPQ95FFPNVgGPm21aXJljYDdKKpvDexB4AEio76/I
         dRtNUNG/VFShLaKM05yJ0KZozTcsUI3VitFb9VXFwFV1wZ6M5oR1VZdpVCAqP0L2f0PY
         RJeDWFtaPHqj+siSPsaCvN7fEvejEPFpjfwEa/Ij3We5Yx9+sk4e8XbXxjslUSbq7WTd
         S2AxMoyIAWgh2RoD1ZrK+R6//wg29ZO7IxDnTE5GTlmxgo+eTMknXUSpNUyMGgE617jA
         0U3ZQndYDJQJzeZ3ZNRNzBzQxk0WvjDN8WCQqLr/Bqe/u2L4zMwPuxWaRWiBhY6WSsPc
         hXTg==
X-Gm-Message-State: AOJu0YzefclcDjGqfhKck/ccdWgsRECh0sNhXKOM9YGi0FbNbbCN6QqZ
        Qhy7xm6WvVGnUEvk12sTyPKQ/A==
X-Google-Smtp-Source: AGHT+IGDUAakGvSrTeFgi2nx9gIOE1y209ymR5Qb+p1nSlHQs/zqcKybiK8Xz1Q0AbYMBjC+NnL+xQ==
X-Received: by 2002:a2e:3514:0:b0:2ca:18de:5c63 with SMTP id z20-20020a2e3514000000b002ca18de5c63mr553729ljz.72.1701865199839;
        Wed, 06 Dec 2023 04:19:59 -0800 (PST)
Received: from [172.30.205.186] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id z23-20020a05651c023700b002c9f8d8e5f4sm1209955ljn.41.2023.12.06.04.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 04:19:59 -0800 (PST)
Message-ID: <81b4f158-41e7-43b6-a762-1a05a0994d6e@linaro.org>
Date:   Wed, 6 Dec 2023 13:19:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT] interconnect: qcom: icc-rpm: Fix peak rate
 calculation
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20231205-qcom_icc_calc_rate-typo-v1-1-9d4378dcf53e@quicinc.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231205-qcom_icc_calc_rate-typo-v1-1-9d4378dcf53e@quicinc.com>
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



On 12/5/23 23:14, Bjorn Andersson wrote:
> Per the commit message of commit 'dd014803f260 ("interconnect: qcom:
> icc-rpm: Add AB/IB calculations coefficients")', the peak rate should be
> 100/ib_percent. But, in what looks like a typical typo, the numerator
> value is discarded in the calculation.
> 
> Update the implementation to match the described intention.
> 
> Fixes: dd014803f260 ("interconnect: qcom: icc-rpm: Add AB/IB calculations coefficients")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> Spotted while reading the code, patch is untested.
> ---
>   drivers/interconnect/qcom/icc-rpm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index fb54e78f8fd7..a8ed435f696c 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -307,7 +307,7 @@ static u64 qcom_icc_calc_rate(struct qcom_icc_provider *qp, struct qcom_icc_node
>   
>   	if (qn->ib_coeff) {
>   		agg_peak_rate = qn->max_peak[ctx] * 100;
> -		agg_peak_rate = div_u64(qn->max_peak[ctx], qn->ib_coeff);
> +		agg_peak_rate = div_u64(agg_peak_rate, qn->ib_coeff);
Oh fun.. I'dve assumed the compiler is smart enough to catch this

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
