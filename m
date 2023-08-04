Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08606770A5B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjHDVFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjHDVEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:04:53 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534A45255
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 14:04:21 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fe4b95c371so5206535e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 14:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691183057; x=1691787857;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qj00refZhLuErTSKNSGUW/qZ75TMCYbmVyutlgVJHgQ=;
        b=MO4H8yS+K+Xm2FffRCOiWPEJvYNH7Yf7+h3x+U9xYZzfFgMmpZUQjWTjHfVrozc7h/
         r1kIzVT+FkUPql+u9EMpPdrjjCTYY50SCKB075W4lYtmEMBBON6Mwe1fweQqDzZFhQKs
         TZLIqkK3tgJASIB/1nKvF4hVv68QZ2OHtPtMKeseCJa2IOV7/dsH0rXH/FGlxYGVpAwB
         B7TzAF8GYgSCieLZwqMmc5pGKF0wh96lIx4r/RpmDlZQgNaggzYGFNi/jB+ngNy2WXGp
         Zub3xDQbXD1LD2ZyCJ6NJ60UoLo8DKr/C7lBZLwJphAv6FfM3pm37PCChO9Fo+kRigSu
         wf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691183057; x=1691787857;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qj00refZhLuErTSKNSGUW/qZ75TMCYbmVyutlgVJHgQ=;
        b=TabgBKjR5wkoIX0mxNbVdY6/eJ28Nq2/Zv7wZ0xiAQ2EtoFaKd3ivrVqnxtOjs/XjU
         fhLsj9vRafOwLaJ701Lz33A9e9yTncsOzdy/G6vKoTma5X7SRf+gIhiqZXHgTqaQsTST
         JzCwj9AqrfCpf2lv1T1L3uQX96W3xnxztTeZ2rbA2TyQz2SI6NMvrDautCC49xXT8g1v
         gGKZOFm6CeTVUx3FyMPABjdPZy3oD+eQfrVAPbvut7cddvjztbdnpCwMSh80J2RZUWLm
         39f8ciChM0Hk/9p9du8flL8viyCa6gSyefQiIZW6WgPXEaWvDIkxOK4HTp0ERc0SK2tO
         5QEA==
X-Gm-Message-State: AOJu0YxPOiQzHVOV/Gqd+K6q1F02dVKd083R4t5DLVitf/tTWtIYKa5O
        2bQoUs9XT3gKg+G9U6uETRt8qA==
X-Google-Smtp-Source: AGHT+IGyA0Q3+2Nb2ODfW2rz93zZN2wGnB+YRvJRjvFlRWp31BI5vk2MXcuURK8UbD0Ovp4v/kCKnw==
X-Received: by 2002:a05:600c:2609:b0:3fb:416d:7324 with SMTP id h9-20020a05600c260900b003fb416d7324mr617463wma.6.1691183056759;
        Fri, 04 Aug 2023 14:04:16 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id l22-20020a7bc456000000b003fc06169ab3sm7556830wmi.20.2023.08.04.14.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 14:04:16 -0700 (PDT)
Message-ID: <78d2fd56-804d-827b-d074-b139cf62a498@linaro.org>
Date:   Fri, 4 Aug 2023 22:04:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 4/6] media: platform: venus: Add optional LLCC path
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
 <20230731-topic-8280_venus-v1-4-8c8bbe1983a5@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230731-topic-8280_venus-v1-4-8c8bbe1983a5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2023 21:09, Konrad Dybcio wrote:
> Some newer SoCs (such as SM8350) have a third interconnect path. Add
> it and make it optional.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/media/platform/qcom/venus/core.c       | 19 +++++++++++++++++++
>   drivers/media/platform/qcom/venus/core.h       |  3 +++
>   drivers/media/platform/qcom/venus/pm_helpers.c |  3 +++
>   3 files changed, 25 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 0af45faec247..db363061748f 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -302,6 +302,15 @@ static int venus_probe(struct platform_device *pdev)
>   	if (IS_ERR(core->cpucfg_path))
>   		return PTR_ERR(core->cpucfg_path);
>   
> +	core->llcc_path = devm_of_icc_get(dev, "video-llcc");
> +	if (IS_ERR(core->llcc_path)) {
> +		/* LLCC path is optional */
> +		if (PTR_ERR(core->llcc_path) == -ENODATA)
> +			core->llcc_path = NULL;
> +		else
> +			return PTR_ERR(core->llcc_path);
> +	}
> +
>   	core->irq = platform_get_irq(pdev, 0);
>   	if (core->irq < 0)
>   		return core->irq;
> @@ -479,12 +488,18 @@ static __maybe_unused int venus_runtime_suspend(struct device *dev)
>   	if (ret)
>   		goto err_cpucfg_path;
>   
> +	ret = icc_set_bw(core->llcc_path, 0, 0);
> +	if (ret)
> +		goto err_llcc_path;
> +
>   	ret = icc_set_bw(core->video_path, 0, 0);
>   	if (ret)
>   		goto err_video_path;
>   
>   	return ret;
>   
> +err_llcc_path:
> +	icc_set_bw(core->video_path, kbps_to_icc(20000), 0);
>   err_video_path:
>   	icc_set_bw(core->cpucfg_path, kbps_to_icc(1000), 0);
>   err_cpucfg_path:
> @@ -504,6 +519,10 @@ static __maybe_unused int venus_runtime_resume(struct device *dev)
>   	if (ret)
>   		return ret;
>   
> +	ret = icc_set_bw(core->llcc_path, kbps_to_icc(20000), 0);
> +	if (ret)
> +		return ret;
> +

I would scream if someone left me this comment but...

In probe we have

video_path =
cpu_cfgpath =

llc_path =

suspend

icc_set_bw(cpu_cfgpath,);
icc_set_bw(llc_path,);
icc_set_bw(video_path,);

resume
icc_set_bw(video_path,);
icc_set_bw(llc_path,);
icc_set_bw(cpu_cfgpath,);

it would be nice to have probe match the ordering ...

>   	ret = icc_set_bw(core->cpucfg_path, kbps_to_icc(1000), 0);
>   	if (ret)
>   		return ret;
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index 2999c24392f5..45ed1551c2db 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -65,6 +65,7 @@ struct venus_resources {
>   	unsigned int bw_tbl_enc_size;
>   	const struct bw_tbl *bw_tbl_dec;
>   	unsigned int bw_tbl_dec_size;
> +	bool has_llcc_path;

Why do you need this bool, you can get for llc_path == NULL

---
bod
