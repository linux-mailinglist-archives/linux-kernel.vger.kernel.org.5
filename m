Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEA18053D5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442385AbjLEMJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442266AbjLEMJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:09:26 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F803FA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 04:09:33 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c9fe0b5b28so30449371fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 04:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701778171; x=1702382971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zq5iNAQ1y1/ofhK1voNUhMj7x5xpHF0VD5FVrbbBMQg=;
        b=RkRmGijuPyfpap7lqGq3WT6WHsOwI4kKV9VqxgWhnvB69t5pkM8Byjz7LTSVudVnR8
         q6e8Hm6vWZD0nMNgQcHkqBm7UHJjXXNyVDm3+1dOtAAUh0Gkk1/4PjMBu+5kBxfG/JAE
         1HoXPROpZLmN6BZfzEzeo/LSA5svqUDELh8qEr/WdbC0v22uWzxHav4jjp7sORxXvSWm
         JsItru0L+3io5/q6jx13yA074g50TCHCIjE2xM3RPUsRm0Wtp2sbFUm/Rnv0iTOqv+xJ
         f2LrS4O2K0fRWHbSejsB5qKhQMcQXzRO5uyYstFHHvqzhOh2zQMfF/UHf0wgtGRcY+eF
         U09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701778171; x=1702382971;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zq5iNAQ1y1/ofhK1voNUhMj7x5xpHF0VD5FVrbbBMQg=;
        b=YHp3RR3P963VkDdpWKVPL19BNd7crYLLNpPCGlh9MiUWi50REEQtWJU9+VVQk2io63
         B/jIq11YAMfiQnN5/9M7PgDc0PI2y4NaZ5QTC7nBrU1tYejDe9sQDBDjJx6HkmSttUVs
         LXGOR+o09E94hGrqK7TVyYAzf4734NCH0pWEfCL5oUnxuhbIX5Fa3LVRqbVNgMfHmv28
         23k54ukEKx5odtfXuQLS8NEBVtIA3mPjJxgoWE+F4s47A22AJErdQBCd9TUuWeOYXLdf
         ut4u5VzxKXGCtbmpDI7Qypn2oEGRLTlRFmJXsdEHXPCkRMmulL30blDIo76LsgFxg1Wa
         +SMQ==
X-Gm-Message-State: AOJu0YxTI4nJcIgmj06LHaVjVhkOZh5kXMHtslspZITfbrl3zaC1Tw7Y
        eX4DnZsrgkEzMsuQ7rqOKxYhPw==
X-Google-Smtp-Source: AGHT+IFWJu20XMJnMqJQmeSGCxwMvv+kJmTfyJ5kS9lWQoV8p4TzYw/OgMgUxGj7hR8M2NDEA6nJuA==
X-Received: by 2002:a05:651c:cc:b0:2c9:f0e8:bb5f with SMTP id 12-20020a05651c00cc00b002c9f0e8bb5fmr2801707ljr.40.1701778171157;
        Tue, 05 Dec 2023 04:09:31 -0800 (PST)
Received: from [172.30.204.197] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id s22-20020a2e2c16000000b002c9f7c2635fsm956195ljs.1.2023.12.05.04.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 04:09:30 -0800 (PST)
Message-ID: <6c29bddf-175d-4ff7-b560-3d4017707baa@linaro.org>
Date:   Tue, 5 Dec 2023 13:09:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] arm64: dts: qcom: msm8996: Fix 'in-ports' is a
 required property
Content-Language: en-US
To:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>
References: <20231205082922.32149-1-quic_jinlmao@quicinc.com>
 <20231205082922.32149-3-quic_jinlmao@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231205082922.32149-3-quic_jinlmao@quicinc.com>
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



On 12/5/23 09:29, Mao Jinlong wrote:
> Add the inport of funnel@3023000 to fix 'in-ports' is a required property
> warning.
> 
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/msm8996.dtsi | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 6ba9da9e6a8b..e7d93d0b4f3b 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -444,6 +444,20 @@ memory@80000000 {
>   		reg = <0x0 0x80000000 0x0 0x0>;
>   	};
>   
> +	modem-etm0 {
> +		compatible = "qcom,coresight-remote-etm";
> +
> +		qcom,inst-id = <2>;
> +		out-ports {
> +			port {
> +				modem_etm_out_funnel_in2: endpoint{
Nit: missing space between 'endpoint' and the opening brace

Konrad
