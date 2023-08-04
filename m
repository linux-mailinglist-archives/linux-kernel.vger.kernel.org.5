Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904F1770A67
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjHDVFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjHDVFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:05:38 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B74F526E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 14:05:12 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbea14706eso23627435e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 14:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691183111; x=1691787911;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3tY2x5jOA5MdZIZQOU+BSDgMhCiPCQJMMt53eXPrT6A=;
        b=ToYJOdJ5fj7DrMiQyzjHrRm8CPjZtUeDWLgCVQMEWcK2D7SHvzCTpvT+G3YXVFJzL0
         PQqRKhfW+CTxP2e9x7tnro/ca9kFlHutp3C0KJ81cvc9Io2DQva9Nmtv0bjQwPvVWUeG
         mRpa8udRCVui1Ng0juDV7Wp5ePMmaK5r0KYHEEteDixsLvf/IAclFd1C98D+SDgY+NtU
         +b1bW3iwo1osF8yTZrK8t0CkVyJj5QcMCT85lTGhoB0f6unJ0MeqzTH65Q1uh2RU2NWt
         4NIWyrx+cctBsmuiw2vutTcdq0faJu5MKLHYTHqgv6kIbjzUo9uLZDDvfPfUSipnJt2R
         3Sxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691183111; x=1691787911;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3tY2x5jOA5MdZIZQOU+BSDgMhCiPCQJMMt53eXPrT6A=;
        b=TiaNkXBCvjm+C9HSHws99+JyeSG/pQzQqgddOY6+o78xWFI/6yQs9KVs7qgKwThi9M
         hkfhg4eFu2LOtXh6op7kuyr3wo9Iz2sCEXdtZtV8EF31/C3sJCycMX69Af3Oz6Omy1Wn
         /5tYPCe8OwZCpeACng3g4gkjMUHelGiO83ceuviMikRT0bIrYdd07LPhZCCa5yOqZJA1
         3DWeAHVNkIRXSNvuMRBIvsdQD7PmU3x6Li/SdYYYzZ4dmTRB09k1AUEuC3ZC2Rqn9VxR
         4NOVqqpEVKonE9IEvstRtKBnUmItMoy1P7zi2AN9UT77uXf6mOZ/2Z8vj3SMxPgw/maO
         l4yg==
X-Gm-Message-State: AOJu0YwPUmvzXPnp92ybB5bshyHSJEys5Ef6GCoeYydwqefnW3s1FS+p
        FpKk/evmVLUrAqIkuv7sDf6gCg==
X-Google-Smtp-Source: AGHT+IGhQzTlOvnyUH7z13hhyfjdj82sVmoev7p0mQju8BbwDFXwFx+c7okVHM5ncHB2MgwoXMueow==
X-Received: by 2002:a5d:4e03:0:b0:314:3ad6:2327 with SMTP id p3-20020a5d4e03000000b003143ad62327mr2025995wrt.12.1691183110969;
        Fri, 04 Aug 2023 14:05:10 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id l12-20020adff48c000000b0030ada01ca78sm3372266wro.10.2023.08.04.14.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 14:05:10 -0700 (PDT)
Message-ID: <9dc7d386-2922-0fb5-171f-1dd19505c092@linaro.org>
Date:   Fri, 4 Aug 2023 22:05:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/6] media: venus: core: Remove trailing commas from of
 match entries
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230731-topic-8280_venus-v1-0-8c8bbe1983a5@linaro.org>
 <20230731-topic-8280_venus-v1-2-8c8bbe1983a5@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230731-topic-8280_venus-v1-2-8c8bbe1983a5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2023 21:09, Konrad Dybcio wrote:
> Even though it has zero effect on functionality, remove them for coherency
> with other drivers.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/media/platform/qcom/venus/core.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 3cc38881d4f6..0af45faec247 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -884,14 +884,14 @@ static const struct venus_resources sc7280_res = {
>   };
>   
>   static const struct of_device_id venus_dt_match[] = {
> -	{ .compatible = "qcom,msm8916-venus", .data = &msm8916_res, },
> -	{ .compatible = "qcom,msm8996-venus", .data = &msm8996_res, },
> -	{ .compatible = "qcom,sdm660-venus", .data = &sdm660_res, },
> -	{ .compatible = "qcom,sdm845-venus", .data = &sdm845_res, },
> -	{ .compatible = "qcom,sdm845-venus-v2", .data = &sdm845_res_v2, },
> -	{ .compatible = "qcom,sc7180-venus", .data = &sc7180_res, },
> -	{ .compatible = "qcom,sc7280-venus", .data = &sc7280_res, },
> -	{ .compatible = "qcom,sm8250-venus", .data = &sm8250_res, },
> +	{ .compatible = "qcom,msm8916-venus", .data = &msm8916_res },
> +	{ .compatible = "qcom,msm8996-venus", .data = &msm8996_res },
> +	{ .compatible = "qcom,sdm660-venus", .data = &sdm660_res },
> +	{ .compatible = "qcom,sdm845-venus", .data = &sdm845_res },
> +	{ .compatible = "qcom,sdm845-venus-v2", .data = &sdm845_res_v2 },
> +	{ .compatible = "qcom,sc7180-venus", .data = &sc7180_res },
> +	{ .compatible = "qcom,sc7280-venus", .data = &sc7280_res },
> +	{ .compatible = "qcom,sm8250-venus", .data = &sm8250_res },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, venus_dt_match);


Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
