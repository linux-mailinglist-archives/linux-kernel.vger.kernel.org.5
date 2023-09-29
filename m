Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A7B7B2E0B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 10:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjI2Ilp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 04:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjI2Ill (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 04:41:41 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56D01AC
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 01:41:39 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40651a72807so16151175e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 01:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695976898; x=1696581698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M1qa9MPXO3QkuATigdmsJ+7YJ61rWQy2j+JwMEZKO3Y=;
        b=o6TPz/5CBu7SXr1j3rNH31VLcRQY8LPeiS8s2phtQWSG/TzyMAMNADW2e8yg7kyVTm
         DD0U8k7Ts6v0fMxpI3qsJCYQsc5VYCoLy6/bKRrnAVqr9Aq3or4u8d34PcyifAbq7Cbb
         R0hDRB0U8bdcmStxO7KmFSnZ76baZwaWHVeLwSav+6Vsk1Pi3xVUyCN1yo3Y/IQR+JBp
         6BFgbrmEvmJlRqSHVFNia3IzqPSM41vhFar1WlRh01ChiG/BecC4/Eh74ow9sG8ahKzq
         tGg6TV6TxBhTVnz5fdkKbxhI/ir7QUrlR9xPcHlD8f7i86f9VoJSL/QO1GRSmXF0qNTE
         RWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695976898; x=1696581698;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M1qa9MPXO3QkuATigdmsJ+7YJ61rWQy2j+JwMEZKO3Y=;
        b=S2iY4LbWZ+qbFfGyS13+AmNGXtPU5MlYoV32gHT1+GUR9rK0vXCydIbAkE6Uz+r2Yc
         AqfLYaNQF02xj10FKIHlz0fVTbpOkwADOn0M0Z7fcd7EMYmsLRh+tPR3/EF6tV8d3H4A
         8iZ/PlcKEEZG8zmhRUjXAghKMtHZEoku61HKFiMztiqmXq23ahfXzxSxw5yHjPdMVZhE
         DZ2uR6JTRioZulByFdO+33+LrrqTpNYvVTLs1C+YASB+9xTLU0+lU+/7USyxgFcWNxTn
         54c6R5i+AZibG7omcO2dbR08pvRlsraC5MhR+KlSPKhRoQ6cFPRSSOccWHHyMS+y9bn9
         2ZEQ==
X-Gm-Message-State: AOJu0YyBARel92e4zBYINPxyhR9tcCstf+U5fOPy06hULeZzKckazNw8
        82c/Q0pz8LbN1cVk/3U5weFv1g==
X-Google-Smtp-Source: AGHT+IGoAq5YuKVMoGvdyZ7QMvGcwB5OFGA+8f2cwGQcecWyWkmY78FgzMH9ry9w/k10s4mUQpQonw==
X-Received: by 2002:adf:ead1:0:b0:315:ad1a:5abc with SMTP id o17-20020adfead1000000b00315ad1a5abcmr3241388wrn.5.1695976898094;
        Fri, 29 Sep 2023 01:41:38 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id z17-20020adfd0d1000000b00317a04131c5sm21032893wrh.57.2023.09.29.01.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 01:41:37 -0700 (PDT)
Message-ID: <0523aa22-5a82-488a-b325-0cab6a4c95aa@linaro.org>
Date:   Fri, 29 Sep 2023 09:41:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] media: venus: core: Set up secure memory ranges for
 SC7280
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230929-sc7280-venus-pas-v1-0-9c6738cf157a@fairphone.com>
 <20230929-sc7280-venus-pas-v1-1-9c6738cf157a@fairphone.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230929-sc7280-venus-pas-v1-1-9c6738cf157a@fairphone.com>
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

On 29/09/2023 09:38, Luca Weiss wrote:
> Not all SC7280 devices ship with ChromeOS firmware. Other devices need
> PAS for image authentication. That requires the predefined virtual
> address ranges to be passed via scm calls. Define them to enable Venus
> on non-CrOS SC7280 devices.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>   drivers/media/platform/qcom/venus/core.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 054b8e74ba4f..5c6baa0f4d45 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -881,6 +881,10 @@ static const struct venus_resources sc7280_res = {
>   	.vmem_size = 0,
>   	.vmem_addr = 0,
>   	.dma_mask = 0xe0000000 - 1,
> +	.cp_start = 0,
> +	.cp_size = 0x25800000,
> +	.cp_nonpixel_start = 0x1000000,
> +	.cp_nonpixel_size = 0x24800000,
>   	.fwname = "qcom/vpu-2.0/venus.mbn",
>   };
>   
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
