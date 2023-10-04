Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D5D7B8C6B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244816AbjJDTJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245252AbjJDTJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:09:24 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA18D10C7;
        Wed,  4 Oct 2023 12:07:39 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53829312d12so2886594a12.0;
        Wed, 04 Oct 2023 12:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696446458; x=1697051258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LfKbENQF1OCDpyRozcLgcbIFYekG+q6fUxVUaA/+cFk=;
        b=b3VtB/EKY2wwAsSWeMt2BAqctndLxxPkiM9CLeN3v025aqwFW6KxJMueyd0P4B73pf
         p1VhqXJ3V07VCyPpsZ+QOQpRbWI36TCYZ2z25t28zmlpLX+IBmzdqNaWtkY4ju0TMW2T
         8m/yHoQmqN9ltqnKDCZn7/XFkuhstZdKyhJDSo7wJICr4TZY+9A4njqhPuN/xg9LxOD5
         h8Nyy8bsJJ8hoHaWqODP09BxclXHw+IAv5yE6nAsFiJxuOFACFaVI5DpFXQlNcr4Wqtx
         Y1zEujuKNPKpczSANlA0xrfBU+x+3w2PFen35B5AfjDNIoQfNOvJpmO5gLKABNFsDdC3
         DZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696446458; x=1697051258;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LfKbENQF1OCDpyRozcLgcbIFYekG+q6fUxVUaA/+cFk=;
        b=pxH3bE57OMhi50foVjhso/T/7R1SzRIYwKedd89ix5tsuKzH+SvkOyo48YJmlNN4Tu
         7VO+1SoHlcgJyd+lr8yRbc1q2flsxG6T32DOUdRd2NlqIJohl3eDm+pH+zgz/4mP3kNJ
         gMqBAqWiNlVE6myvYF+NZQDiazFPJDkFjjFLGSWDdXcOxqw6WsXpD0W4nG9Q+jZshR0a
         L5+RKdWesxdRutnpoV8SxXeHZx+5Ni0fDBNdtKP1VyaMfXTrFIrm9Flw8j79KA497dvk
         MZIS/oRqtJb225g+kWwu+wuUf6KHSFKZa0MUTPa0u3znY16OOSPZj68z8UjlonlLe2Ss
         U8oQ==
X-Gm-Message-State: AOJu0YxRS9AEKT+mgL5kqDiWLoPmN8PU9BnjackTwC8CCj3gY7ReuePv
        rY5bFJizr30bSjZlVjJC3m4+mVQtWbfnww==
X-Google-Smtp-Source: AGHT+IHqhJ4GZi6aYGamS04rmL30PBsqdW0lHsZ2cwUiZHgmls26+BclzmYEh0miTmW7ThqWmgJIAA==
X-Received: by 2002:a17:906:3109:b0:9b6:3be9:a8f with SMTP id 9-20020a170906310900b009b63be90a8fmr497677ejx.20.1696446457879;
        Wed, 04 Oct 2023 12:07:37 -0700 (PDT)
Received: from [192.168.3.32] (cpezg-94-253-131-161-cbl.xnet.hr. [94.253.131.161])
        by smtp.gmail.com with ESMTPSA id p24-20020a170906a01800b009b28ad521f4sm3261380ejy.4.2023.10.04.12.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 12:07:37 -0700 (PDT)
Message-ID: <cbe6eae5-3490-eb3e-7f28-87ec2c600875@gmail.com>
Date:   Wed, 4 Oct 2023 21:07:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V3 3/4] thermal/drivers/tsens: Add support for IPQ5018
 tsens
To:     Sricharan R <srichara@win-platform-upstream01.qualcomm.com>,
        krzysztof.kozlowski@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dmitry.baryshkov@linaro.org,
        quic_srichara@quicinc.com
References: <20230922115116.2748804-1-srichara@win-platform-upstream01.qualcomm.com>
 <20230922115116.2748804-4-srichara@win-platform-upstream01.qualcomm.com>
Content-Language: en-US
From:   Robert Marko <robimarko@gmail.com>
In-Reply-To: <20230922115116.2748804-4-srichara@win-platform-upstream01.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22. 09. 2023. 13:51, Sricharan R wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>
> IPQ5018 has tsens IP V1.0, 4 sensors and 1 interrupt.
> The soc does not have a RPM, hence tsens has to be reset and
> enabled in the driver init. Adding the driver support for same.
>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>   [v3] Fixed Dmitry's comments for error checks in init_ipq5018
>
>   drivers/thermal/qcom/tsens-v1.c | 60 +++++++++++++++++++++++++++++++++
>   drivers/thermal/qcom/tsens.c    |  3 ++
>   drivers/thermal/qcom/tsens.h    |  2 +-
>   3 files changed, 64 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
> index dc1c4ae2d8b0..acee2064f83e 100644
> --- a/drivers/thermal/qcom/tsens-v1.c
> +++ b/drivers/thermal/qcom/tsens-v1.c
> @@ -79,6 +79,18 @@ static struct tsens_features tsens_v1_feat = {
>   	.trip_max_temp	= 120000,
>   };
>   
> +static struct tsens_features tsens_v1_ipq5018_feat = {
> +	.ver_major	= VER_1_X,
> +	.crit_int	= 0,
> +	.combo_int	= 0,
> +	.adc		= 1,
> +	.srot_split	= 1,
> +	.max_sensors	= 11,
> +	.trip_min_temp	= -40000,
> +	.trip_max_temp	= 120000,
> +	.ignore_enable	= 1,
> +};
> +
>   static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
>   	/* ----- SROT ------ */
>   	/* VERSION */
> @@ -150,6 +162,41 @@ static int __init init_8956(struct tsens_priv *priv) {
>   	return init_common(priv);
>   }
>   
> +static int init_ipq5018(struct tsens_priv *priv)

__init is missing after int, otherwise I get modpost warning while building:
WARNING: modpost: vmlinux: section mismatch in reference: 
init_ipq5018+0x14 (section: .text) -> init_common (section: .init.text)

Regards,
Robert

> +{
> +	int ret;
> +	u32 mask;
> +
> +	ret = init_common(priv);
> +	if (ret < 0) {
> +		dev_err(priv->dev, "Init common failed %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regmap_field_write(priv->rf[TSENS_SW_RST], 1);
> +	if (ret) {
> +		dev_err(priv->dev, "Reset failed\n");
> +		return ret;
> +	}
> +
> +	mask = GENMASK(priv->num_sensors, 0);
> +	ret = regmap_field_update_bits(priv->rf[SENSOR_EN], mask, mask);
> +	if (ret) {
> +		dev_err(priv->dev, "Sensor Enable failed\n");
> +		return ret;
> +	}
> +
> +	ret = regmap_field_write(priv->rf[TSENS_EN], 1);
> +	if (ret) {
> +		dev_err(priv->dev, "Enable failed\n");
> +		return ret;
> +	}
> +
> +	ret = regmap_field_write(priv->rf[TSENS_SW_RST], 0);
> +
> +	return ret;
> +}
> +
>   static const struct tsens_ops ops_generic_v1 = {
>   	.init		= init_common,
>   	.calibrate	= calibrate_v1,
> @@ -187,3 +234,16 @@ struct tsens_plat_data data_8976 = {
>   	.feat		= &tsens_v1_feat,
>   	.fields		= tsens_v1_regfields,
>   };
> +
> +const struct tsens_ops ops_ipq5018 = {
> +	.init		= init_ipq5018,
> +	.calibrate	= tsens_calibrate_common,
> +	.get_temp	= get_temp_tsens_valid,
> +};
> +
> +struct tsens_plat_data data_ipq5018 = {
> +	.num_sensors	= 5,
> +	.ops		= &ops_ipq5018,
> +	.feat		= &tsens_v1_ipq5018_feat,
> +	.fields		= tsens_v1_regfields,
> +};
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 0a43ccf02ec4..c792b9dc6676 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -1101,6 +1101,9 @@ static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
>   
>   static const struct of_device_id tsens_table[] = {
>   	{
> +		.compatible = "qcom,ipq5018-tsens",
> +		.data = &data_ipq5018,
> +	}, {
>   		.compatible = "qcom,ipq8064-tsens",
>   		.data = &data_8960,
>   	}, {
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index e254cd2df904..b6594b546d11 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -645,7 +645,7 @@ extern struct tsens_plat_data data_8960;
>   extern struct tsens_plat_data data_8226, data_8909, data_8916, data_8939, data_8974, data_9607;
>   
>   /* TSENS v1 targets */
> -extern struct tsens_plat_data data_tsens_v1, data_8976, data_8956;
> +extern struct tsens_plat_data data_tsens_v1, data_8976, data_8956, data_ipq5018;
>   
>   /* TSENS v2 targets */
>   extern struct tsens_plat_data data_8996, data_ipq8074, data_tsens_v2;
