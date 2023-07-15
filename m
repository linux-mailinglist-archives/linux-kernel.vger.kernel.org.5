Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6156C754922
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 16:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjGOOGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 10:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjGOOGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 10:06:42 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F3C3586
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 07:06:40 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b933bbd3eeso5197961fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 07:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689429998; x=1692021998;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6/oofZQPgGTrFm/xFNaCXYysHJE6rz/K210kWzBmMEo=;
        b=kScAPAkOrbs0cNL+KxnjWOLdaO/mPqHzA+sHslTQlpCjMvTNqZORsHtDzp8WUPt3OH
         bRsA8n41U01Tb/WWT6ruNe+f8Sa/3Gxr2geM588t33JOLYji+xcMkTL3VPofC07zozZI
         YMbyqrDlJkbV28eCpWuy2w7tcUNChEkLPGVJ9EBy3mr7MRsL0BKJ2UctnWzUZwkeaTY1
         NZMONWOZBYDvNqke55iPzYRPJohp+fftnfYmtoS2nnNP9EXRrzmx7l/FVUyHJr46TFYl
         w4LVROATLDsbPKqfd2EokLOh95m9tde0vPAGpRp6iNzETaRiJi8BmRomYLjVM1XtHNEL
         ym5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689429998; x=1692021998;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/oofZQPgGTrFm/xFNaCXYysHJE6rz/K210kWzBmMEo=;
        b=fxn565PvLTYJSjqX2zmt0RK2AAk8AZc2LXm8rQLMN1wrVsyZFahE497Us7AUK3xo0Y
         CYHLlFuAllcf/a7fXpBvqYLksw0HW/rFGQiw8ZqrEJ6eMVLYMYm14TQJLM7TQMpA+mA9
         o+2RnpnWgBX6RXklhyMyCS8treDV1xgvmNZirUvwM28G9xsvupr1rIovSlkFfaWpy0Iv
         ZUmsze93fDGKZgdOiByuCvPzxfvs2JYRIXokn+xflRImu5OoGXNMsoqqQN8t8cr4rrBo
         LVCxn8NmHRChFuwprjqgbihIC2SAsUm9AsyTHjZsOZrZojFRPrHGvxZZvNguabMKe32l
         pY2w==
X-Gm-Message-State: ABy/qLbkQ/MAkJMaT3faIqMITZ05PYDQPjmrk18tTeM3n/rsJoHDggcO
        jAWvoG/ubb57tLuuNhQl4W14VA==
X-Google-Smtp-Source: APBJJlFqmQmo8w0oIye5X/kZkI28eHRZL+MvDkUJ95TPmKGlWFWNqmpVlWavj+lPBVz4kOs0C0Xteg==
X-Received: by 2002:a19:5016:0:b0:4f7:3ee8:eede with SMTP id e22-20020a195016000000b004f73ee8eedemr6416135lfb.61.1689429998294;
        Sat, 15 Jul 2023 07:06:38 -0700 (PDT)
Received: from [192.168.1.101] (abxi167.neoplus.adsl.tpnet.pl. [83.9.2.167])
        by smtp.gmail.com with ESMTPSA id a13-20020ac2520d000000b004fb78984592sm1904245lfl.172.2023.07.15.07.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jul 2023 07:06:37 -0700 (PDT)
Message-ID: <adc04328-d9c5-1c67-8396-08137334af1e@linaro.org>
Date:   Sat, 15 Jul 2023 16:06:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 5/5] thermal/drivers/tsens: Add IPQ5332 support
Content-Language: en-US
To:     Praveenkumar I <quic_ipkumar@quicinc.com>, amitk@kernel.org,
        thara.gopinath@gmail.com, agross@kernel.org, andersson@kernel.org,
        rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_varada@quicinc.com
References: <20230713052732.787853-1-quic_ipkumar@quicinc.com>
 <20230713052732.787853-6-quic_ipkumar@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230713052732.787853-6-quic_ipkumar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.07.2023 07:27, Praveenkumar I wrote:
> IPQ5332 uses tsens v2.3.3 IP and it is having combined interrupt.
> It does not have RPM and kernel needs to take care of sensor
> enablement, calibration. Hence introduced new feature_config,
> ops and data for IPQ5332.
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> ---
> [v3]:
> 	No changes.
> [v2]:
> 	Added tsens_features for ipq5332 with VER_2_X_NO_RPM. Used
> 	hw_ids to mention the available sensors. Dropped v2 in
> 	ops_ipq5332.
> 
>  drivers/thermal/qcom/tsens-v2.c | 25 +++++++++++++++++++++++++
>  drivers/thermal/qcom/tsens.c    |  3 +++
>  drivers/thermal/qcom/tsens.h    |  2 +-
>  3 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
> index 781595a9a622..e25d9d34e519 100644
> --- a/drivers/thermal/qcom/tsens-v2.c
> +++ b/drivers/thermal/qcom/tsens-v2.c
> @@ -62,6 +62,17 @@ static struct tsens_features ipq8074_feat = {
>  	.trip_max_temp	= 204000,
>  };
>  
> +static struct tsens_features ipq5332_feat = {
> +	.ver_major	= VER_2_X_NO_RPM,
> +	.crit_int	= 1,
> +	.combo_int	= 1,
> +	.adc		= 0,
> +	.srot_split	= 1,
> +	.max_sensors	= 16,
> +	.trip_min_temp	= 0,
> +	.trip_max_temp	= 204000,
204 degrees Celcius?

Konrad
> +};
> +
>  static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>  	/* ----- SROT ------ */
>  	/* VERSION */
> @@ -262,6 +273,20 @@ struct tsens_plat_data data_ipq8074 = {
>  	.fields	= tsens_v2_regfields,
>  };
>  
> +static const struct tsens_ops ops_ipq5332 = {
> +	.init		= init_tsens_v2_no_rpm,
> +	.get_temp	= get_temp_tsens_valid,
> +	.calibrate	= tsens_v2_calibration,
> +};
> +
> +struct tsens_plat_data data_ipq5332 = {
> +	.num_sensors	= 5,
> +	.ops		= &ops_ipq5332,
> +	.hw_ids		= (unsigned int []){11, 12, 13, 14, 15},
> +	.feat		= &ipq5332_feat,
> +	.fields		= tsens_v2_regfields,
> +};
> +
>  /* Kept around for backward compatibility with old msm8996.dtsi */
>  struct tsens_plat_data data_8996 = {
>  	.num_sensors	= 13,
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 9dc0c2150948..af58a94628a8 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -1106,6 +1106,9 @@ static const struct of_device_id tsens_table[] = {
>  	}, {
>  		.compatible = "qcom,ipq8074-tsens",
>  		.data = &data_ipq8074,
> +	}, {
> +		.compatible = "qcom,ipq5332-tsens",
> +		.data = &data_ipq5332,
>  	}, {
>  		.compatible = "qcom,mdm9607-tsens",
>  		.data = &data_9607,
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index b2e8f0f2b466..1dde363914cd 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -648,6 +648,6 @@ extern struct tsens_plat_data data_8226, data_8909, data_8916, data_8939, data_8
>  extern struct tsens_plat_data data_tsens_v1, data_8976, data_8956;
>  
>  /* TSENS v2 targets */
> -extern struct tsens_plat_data data_8996, data_ipq8074, data_tsens_v2;
> +extern struct tsens_plat_data data_8996, data_ipq8074, data_ipq5332, data_tsens_v2;
>  
>  #endif /* __QCOM_TSENS_H__ */
