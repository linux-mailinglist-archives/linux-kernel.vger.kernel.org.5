Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E1675783E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjGRJkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjGRJkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:40:43 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D50DE56
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:40:40 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51d95aed33aso7409787a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689673239; x=1692265239;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M0N8btKrBEl8US0muPWkTHrV3A+jfker/XqFXbKhuNM=;
        b=LiktnGMdMBgcrwGwBd55VnfmVE4V3+RMVccoWw1Whzak1pjDcIQtAermeh3RUAk7ol
         Mu4FMjXKSp7ZY70SbVCPFwoKmFS51bLCwiZL1UqkrCaHMY2yunR5qSwKmcir9D0s5zCP
         /kpXFTlhK4chBS5+jG7gYGiY6LeRuTWFVzM1f5z2t62jRSkpif4FTaXl73IlhLkHa30C
         SdGowawyPq9EwUkJVdOXfNqk33FWSdBJK2vEL/gWDFm45BDv+kp9w8zTWqNLg3Ok6MwI
         C/Z9p05zUD7wl5fpCZa8ay0ZmDhkjI/wXQs0nH58pjvJ/lSznudtW6WVAHx+C6J8d1mW
         iw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689673239; x=1692265239;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M0N8btKrBEl8US0muPWkTHrV3A+jfker/XqFXbKhuNM=;
        b=Y8VvuUjeAiuB8A4gtiBcHYZJdcVa3+g3b44jPf+2xLe7Up9r12euSVQWsc1Rb0vfnz
         Qytmr4YuUQPN2593n6KhLoXZpFTS5mkAe4FAOFHKG3m4gguniW1reepQLTE6YOX6y3iC
         sQsXCvkXKe+V2rY3PpF01fgsFhzfGnHHLnj8fv8yYGH3GRzjprBo+NHw1gCwnYqn4xGS
         mFpCCb8XAU50MVtYGaOdrugHqPlOayAfr77lAJ1OxHrjZaVHcVGtvQ2vc+g9LavoXNhK
         demmqYqP9166BANd4HnGpbbCFfmLYtQ4LkLQyebMQD/5BMD+zwiVbST0g7jFk2IC/9wC
         T+dQ==
X-Gm-Message-State: ABy/qLaEqIr75i5O53sjicsJ0ot+eqe1PfE6mUiuqlzv4xXmIVa++lr4
        gSm7cpO9rl76uVRGwcHsKgc2Qw==
X-Google-Smtp-Source: APBJJlE29PdR8LOpeQCVpY3BGmHmGV2bndVirQX9jqE36YcbNr53bhsq+2ZlKH7NGxw1s1x3ODVrMg==
X-Received: by 2002:a17:906:739e:b0:993:e752:1a71 with SMTP id f30-20020a170906739e00b00993e7521a71mr14389092ejl.9.1689673238920;
        Tue, 18 Jul 2023 02:40:38 -0700 (PDT)
Received: from [192.168.1.194] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id l22-20020a170906231600b00992e4d8cc89sm800293eja.57.2023.07.18.02.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 02:40:38 -0700 (PDT)
Message-ID: <76c99543-4f77-38c2-5940-517f2715060d@linaro.org>
Date:   Tue, 18 Jul 2023 10:40:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] arm64: dts: qcom: sm8450-hdk: add other analogue
 microphones
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230717143824.203352-1-krzysztof.kozlowski@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230717143824.203352-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/07/2023 15:38, Krzysztof Kozlowski wrote:
> Add proper audio routes for onboard analogue microphones: AMIC[1345].
> Use also new DAPM input widget (TX SWR_INPUTn) for them, not the
> deprecated ADC one.  Change is not compatible with older kernels not
> having the new SWR_INPUTn input widget.
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Depends on ASoC driver changes:
> https://lore.kernel.org/alsa-devel/20230717140138.201745-1-krzysztof.kozlowski@linaro.org/T/#t
> This patch should wait till respective ASoC changes got merged.
> ---
>   arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 23 ++++++++++++++++-------
>   1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> index bd5e8181f2aa..9bd1ef401ca3 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> @@ -915,14 +915,23 @@ &sound {
>   			"SpkrRight IN", "WSA_SPK2 OUT",
>   			"IN1_HPHL", "HPHL_OUT",
>   			"IN2_HPHR", "HPHR_OUT",
> +			"AMIC1", "MIC BIAS1",
>   			"AMIC2", "MIC BIAS2",
> -			"VA DMIC0", "MIC BIAS1",
> -			"VA DMIC1", "MIC BIAS1",
> -			"VA DMIC2", "MIC BIAS3",
> -			"TX DMIC0", "MIC BIAS1",
> -			"TX DMIC1", "MIC BIAS2",
> -			"TX DMIC2", "MIC BIAS3",
> -			"TX SWR_ADC1", "ADC2_OUTPUT";
> +			"AMIC3", "MIC BIAS3",
> +			"AMIC4", "MIC BIAS3",
> +			"AMIC5", "MIC BIAS4",
These should reflect the board-level wiring of MIC BIAS, are you sure 
that this is how the hdk is wired up?

> +			"VA DMIC0", "MIC BIAS3",
> +			"VA DMIC1", "MIC BIAS3",
> +			"VA DMIC2", "MIC BIAS1",
> +			"VA DMIC3", "MIC BIAS1",
> +			"TX DMIC0", "MIC BIAS3",
> +			"TX DMIC1", "MIC BIAS3",
> +			"TX DMIC2", "MIC BIAS1",
> +			"TX DMIC3", "MIC BIAS1",
Same here.

--srini
> +			"TX SWR_INPUT0", "ADC1_OUTPUT",
> +			"TX SWR_INPUT1", "ADC2_OUTPUT",
> +			"TX SWR_INPUT2", "ADC3_OUTPUT",
> +			"TX SWR_INPUT3", "ADC4_OUTPUT";
>   
>   	wcd-playback-dai-link {
>   		link-name = "WCD Playback";
