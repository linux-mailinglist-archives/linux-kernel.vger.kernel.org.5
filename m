Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EF17E0F1B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 12:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjKDL3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 07:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbjKDL3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 07:29:43 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E3E1BF
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 04:29:41 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9d0b4dfd60dso438358766b.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 04:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699097379; x=1699702179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZJy2KKsB0PbRWKDGIHkbpjHuAvHX1QTO5G0UNsgJYlE=;
        b=kopawgnmyApzF0PvDeDoebgXv7h3knlw+hsq58KPya09RvlenbzpwlhXYxtvw4hAjM
         x8Rju7AynnSJOui5M79J5qX3uCwCKDLRJR1bthx65tLXeU1Oc/8F6uSbeNbKzSZkAmqR
         Hr6enkaH48SqYlzflsLCx6gbWw3h5soEQKQnj7+Sk/Vkt1Dg4IOc6Gs+Qoixy+a3J4h2
         qRkZoR9Ba4MXLFIg/yF2bnuaUvSZmYg9gj5ggjd47rI998BPDa0uKkz7eLYvtq4J3E5/
         AiJyP336rfvpfbwbAXzftte/OXYrfztGfGLdh5QEzo2927TX6yhCpPatGbZtJLtDO7Xy
         JJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699097379; x=1699702179;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJy2KKsB0PbRWKDGIHkbpjHuAvHX1QTO5G0UNsgJYlE=;
        b=bYU/lIsjFdvLWDulGDRh0VykwtfVag4hNg7TJl/que7GRgUrrRY8OilKSg66Gihpu1
         5ciMQaDJK9w7oWHgGATQ5A9gSa40Ba9N6rrG2rDLWT/Xw6T4igv5oxq97MA/9n5GxFko
         P/hRwKPZpIJ0B1Iu1lplMTRkgdgQy8ZARx3Hbk3ixw1mgxPv459xrC/GPx6C45ELv+3a
         ID7rRn6Gn7LBqHjCl66sdttGbyetHWlfW7ueHlAMCy72Fc5Lg1hAhejmFHljch0SjR+T
         VzbBvZvrsLwHk9pIEfXkXN+J455m7YOWeUwpUe6wRHNRjBfs1UYWPOqSKoNryfEmv0hE
         /FPQ==
X-Gm-Message-State: AOJu0YxsmWcTcXDuXJIClyC04vSsL0eQzTqnNm+C+q8Xz1RJeib0z50o
        BWbQ0+EXZn9T7206FrM+oRGoNg==
X-Google-Smtp-Source: AGHT+IEuzZ1y3DjdgqAfYz2QBkwZeMYD0RlEFfRha4mPCbrG7WKwE7gDC2yS115Aw3rKUa0Nzo8mzg==
X-Received: by 2002:a17:906:7955:b0:9dc:ee58:6604 with SMTP id l21-20020a170906795500b009dcee586604mr3980586ejo.21.1699097379512;
        Sat, 04 Nov 2023 04:29:39 -0700 (PDT)
Received: from [192.168.0.153] (178235177017.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.17])
        by smtp.gmail.com with ESMTPSA id s5-20020a170906454500b009c7608eb499sm1878707ejq.94.2023.11.04.04.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Nov 2023 04:29:39 -0700 (PDT)
Message-ID: <27b4a561-a2af-47a4-912e-6ee6961f0f6b@linaro.org>
Date:   Sat, 4 Nov 2023 12:29:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iommu/arm-smmu: add ACTLR data and support for SM8550
Content-Language: en-US
To:     Bibek Kumar Patro <quic_bibekkum@quicinc.com>, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, dmitry.baryshkov@linaro.org,
        a39.skl@gmail.com, quic_saipraka@quicinc.com,
        quic_pkondeti@quicinc.com, quic_molvera@quicinc.com
Cc:     linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, qipl.kernel.upstream@quicinc.com
References: <20231103215124.1095-1-quic_bibekkum@quicinc.com>
 <20231103215124.1095-3-quic_bibekkum@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231103215124.1095-3-quic_bibekkum@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/3/23 22:51, Bibek Kumar Patro wrote:
> Add ACTLR data table for SM8550 along with support for
> same including SM8550 specific implementation operations.
> 
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 85 +++++++++++++++++++++-
>   1 file changed, 81 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 68c1f4908473..590b7c285299 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -25,6 +25,64 @@ struct actlr_data {
>   	u32 actlr;
>   };
> 
> +static const struct actlr_data sm8550_apps_actlr_data[] = {
I assume this data will be different for each SoC.. perhaps
moving this to a separate file (not sure if dt makes sense if
it's hardcoded per platform) makes sense.

This will also assume that these can not differ between firmware
versions.

Konrad
