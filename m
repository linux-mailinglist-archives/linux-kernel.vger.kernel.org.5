Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FE4775232
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 07:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjHIF1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 01:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjHIF1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 01:27:49 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A871BF3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 22:27:48 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6873a30d02eso4385023b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 22:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691558868; x=1692163668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bhL+GxxZwosDcbr2JYGeROiUQ9hern+seiOFs9BotUA=;
        b=FpHstVBIBNa9DWGPBaFDWK4OED+TplT0ysD5F18BYQTdlL7RrHzYGP08KJNSYNkYko
         +xyVHq4Kzkc5uuXYetntwbaGLOH/kknYAyTSBnjnF/G5MoAWGAqku+CkJkBENO9XZ2HU
         6qQcLAMM5JxCHwrZt9vsMQJNIceqCXpwhEwST/6fq3dnp5g7DLCu3Q/3P9f7+XhZ1xb+
         cHQq0tbkuCkNBYXK/FV3Lb8DeQ3OzrzzfOcnlyQxs2bsjhdC5ONMRS0s7JTI0V5rKAZk
         /6FlJjH7DsIZDpt5dtjkMgXc7fmx5EJC6HnWSZCSxso05YqTjPcShmYrtpfhHbxbX6Ps
         asqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691558868; x=1692163668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhL+GxxZwosDcbr2JYGeROiUQ9hern+seiOFs9BotUA=;
        b=lidbou+3NH9kh3SZBS6VXR7bkoPvNTiF02vTbNfDGOyBnJzrsY5e5whOaBHYRfHAhA
         Z9UtRuqT/zwZy0io5Tn4RQA1iObKGf7urdj9hgDcUVRrQu+HEFj4n2j2BF8RrvOM3ZV5
         xUrdz1nDtTu11627miNtFgSWZ6dLWu/eEnlpUL5Cas/JB9tyjRuhRqJ92NeGWSmjy6MM
         011WQRCzLlGu1LDT6kM97OHDkWsO/FWARn5FXPfkjcJ3TbLo+Yms6EIK3fb7i997lc3u
         lBhJESCrewZ1bpoWFV4gBte+o2Q5seH87MSA/Daw1LjmCkEOPof8MR6tUSYtWUgV6dcO
         /w8w==
X-Gm-Message-State: AOJu0YwrKFw8m4YqJviWMa+IoEkL9WymvrKOA8SMEeM5BIagVsYUV1JF
        Q0vzz+fXNvHQfqG7p737unymLg==
X-Google-Smtp-Source: AGHT+IE0e9qLHd0eWNh5zZHugB+X99G5gvGqpAbe1AF4HkM2/Udm4HQCZgqNIzpuigcyCJyEnnRtUQ==
X-Received: by 2002:a05:6a20:1590:b0:13b:b4bb:8b18 with SMTP id h16-20020a056a20159000b0013bb4bb8b18mr1841936pzj.1.1691558867948;
        Tue, 08 Aug 2023 22:27:47 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id fk3-20020a056a003a8300b0062e0515f020sm9001226pfb.162.2023.08.08.22.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 22:27:47 -0700 (PDT)
Date:   Wed, 9 Aug 2023 10:57:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: blocklist more Qualcomm platforms in
 cpufreq-dt-platdev
Message-ID: <20230809052743.hp2vvq2rr25hqine@vireshk-i7>
References: <20230809-topic-cpufreq_qcom_block-v1-1-624acbcefa5c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809-topic-cpufreq_qcom_block-v1-1-624acbcefa5c@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-08-23, 02:07, Konrad Dybcio wrote:
> All Qualcomm platforms utilizing the qcom-cpufreq-hw driver have no
> business in using cpufreq-dt. Prevent that from happening.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index adb3579a1fee..fb2875ce1fdd 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -144,14 +144,18 @@ static const struct of_device_id blocklist[] __initconst = {
>  	{ .compatible = "qcom,apq8096", },
>  	{ .compatible = "qcom,msm8996", },
>  	{ .compatible = "qcom,msm8998", },
> +	{ .compatible = "qcom,qcm2290", },
>  	{ .compatible = "qcom,qcs404", },
> +	{ .compatible = "qcom,qdu1000", },
>  	{ .compatible = "qcom,sa8155p" },
>  	{ .compatible = "qcom,sa8540p" },
> +	{ .compatible = "qcom,sa8775p" },
>  	{ .compatible = "qcom,sc7180", },
>  	{ .compatible = "qcom,sc7280", },
>  	{ .compatible = "qcom,sc8180x", },
>  	{ .compatible = "qcom,sc8280xp", },
>  	{ .compatible = "qcom,sdm845", },
> +	{ .compatible = "qcom,sdx75", },
>  	{ .compatible = "qcom,sm6115", },
>  	{ .compatible = "qcom,sm6350", },
>  	{ .compatible = "qcom,sm6375", },
> @@ -159,6 +163,8 @@ static const struct of_device_id blocklist[] __initconst = {
>  	{ .compatible = "qcom,sm8150", },
>  	{ .compatible = "qcom,sm8250", },
>  	{ .compatible = "qcom,sm8350", },
> +	{ .compatible = "qcom,sm8450", },
> +	{ .compatible = "qcom,sm8550", },
>  
>  	{ .compatible = "st,stih407", },
>  	{ .compatible = "st,stih410", },

Applied. Thanks.

-- 
viresh
