Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E18797B5B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237867AbjIGSNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343667AbjIGSNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:13:30 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98ED1FCC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:12:59 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so5073655a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 11:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694110378; x=1694715178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mDoUjvYQ5hLp90NpvOpciamYswy5+ILruLlYsWMAII8=;
        b=xymxHE+gEWJOo0yJ73by9cymivEJpwzrAfQxomSIX9mHeN4dv5/QurYVHTrbR4NfXL
         Idnku7xhJFjow43qwbQPoNV0WyZA5LPMIIBIGFToQIYYNF+REOWER5vuTnDX1bNDFlnV
         t1t8gyedCLwbAFHDQHO5Yt1bKOPtnaAGGAUeV8Z2wEqm1app/MLEP7/fKE9INoLpanxE
         VR//FTwzjnItsu10Dlu9btUPLWXJEjkWMHVVZzkknrMQDokIYkEYFwPw80HPqRYgV6SK
         yBTJvZWrYps0EuYmtRDbS0Y1U9EpfM5WiW2tM7qC1QltgRnj3l0rUYtXLcmBjKi0fjBU
         Q/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694110378; x=1694715178;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mDoUjvYQ5hLp90NpvOpciamYswy5+ILruLlYsWMAII8=;
        b=iqAnRTaaYqrrHC3DYsYBke4Uq6brpfJ/gxujjzN3pbKira+DxYK5qy7lwZwQqvjNtn
         hVQxbIU3kIQm0+1bpTqXD/mya3RsOhqKCcYLwIF2FBUJA5GhSUTEenZ61rBzASuY6lPp
         3GFpmysOG0zlGlzRSoNZxSUI1Xj0EnkyUlAYhkv0CCS//8OLIEJVH1dXQJGoEcjplQ4t
         fxfVguEO/KY4E+ZFtbzpEjhBRo5q0bCNESn6RitmNXRtCbunP6Woq33j9m9V4a9h8vbl
         z9BPqHA7pXhPyA8wFThsfIxNbkpqZaqM9SVQLY4ERlhkY7gJbfGA4FRpugMEhB2Zlsnq
         p3/w==
X-Gm-Message-State: AOJu0YwiYbFYEngQ2eesC6h44JHVmmmicI4dkCBdL6ONMJ0x/SeIj1Wp
        OKW/YH45JByOG5zsmwWCkkgSJBDU9I2Yr1REiIKgdQ==
X-Google-Smtp-Source: AGHT+IFvxabhPY7oNJR7yHmojbvgWgbazhQtpCoLLsasYPzm8UdBiLSJ/NE+FoR8Wyv0Yf2YrLLe5g==
X-Received: by 2002:a17:907:6e87:b0:9a1:c69c:9388 with SMTP id sh7-20020a1709076e8700b009a1c69c9388mr2016148ejc.37.1694075690953;
        Thu, 07 Sep 2023 01:34:50 -0700 (PDT)
Received: from [192.168.37.232] (178235177204.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.204])
        by smtp.gmail.com with ESMTPSA id f25-20020a170906495900b0099d9dee8108sm10215498ejt.149.2023.09.07.01.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 01:34:50 -0700 (PDT)
Message-ID: <f7c2f7dd-dcc7-4f3a-9c04-e370ba608de5@linaro.org>
Date:   Thu, 7 Sep 2023 10:34:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 06/10] cpufreq: qti: Enable cpufreq for ipq53xx
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>,
        ilia.lin@kernel.org, agross@kernel.org, andersson@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        quic_kathirav@quicinc.com, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <cover.1693996662.git.quic_varada@quicinc.com>
 <558c6b70090ea7220bfb0b6e7d81828025018376.1693996662.git.quic_varada@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <558c6b70090ea7220bfb0b6e7d81828025018376.1693996662.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7.09.2023 07:21, Varadarajan Narayanan wrote:
> IPQ53xx have different OPPs available for the CPU based on
> SoC variant. This can be determined through use of an eFuse
> register present in the silicon.
> 
> Added support for ipq53xx on nvmem driver which helps to
> determine OPPs at runtime based on the eFuse register which
> has the CPU frequency limits. opp-supported-hw dt binding
> can be used to indicate the available OPPs for each limit.
> 
> nvmem driver also creates the "cpufreq-dt" platform_device after
> passing the version matching data to the OPP framework so that the
> cpufreq-dt handles the actual cpufreq implementation.
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c |  1 +
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 15 +++++++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 02ec58a..f0c45d4 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
Viresh probably picks up patches for both files, so it should
be fine, but I'd say it's 'eeeh' to edit 2 separate drivers at
once.

> @@ -178,6 +178,7 @@ static const struct of_device_id blocklist[] __initconst = {
>  	{ .compatible = "ti,am625", },
>  	{ .compatible = "ti,am62a7", },
>  
> +	{ .compatible = "qcom,ipq5332", },
>  	{ .compatible = "qcom,ipq8064", },
>  	{ .compatible = "qcom,apq8064", },
>  	{ .compatible = "qcom,msm8974", },
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index 84d7033..49d21b0 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -146,6 +146,20 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
>  		return PTR_ERR(speedbin);
>  
>  	switch (msm_id) {
> +	case QCOM_ID_IPQ5332:
> +	case QCOM_ID_IPQ5322:
> +	case QCOM_ID_IPQ5312:
> +	case QCOM_ID_IPQ5302:
> +	case QCOM_ID_IPQ5300:
> +		/* Fuse Value    Freq    BIT to set
> +		 * ---------------------------------
> +		 *   2’b00     No Limit     BIT(0)
> +		 *   2’b01     1.5 GHz      BIT(1)
> +		 *   2’b10     1.2 Ghz      BIT(2)
> +		 *   2’b11     1.0 GHz      BIT(3)
I think the last column is a bit excessive, it says exactly
the same as the line below.

Actually, with this data being present in the devicetree, perhaps
this comment could be entirely skipped.

Konrad
> +		 */
> +		drv->versions = 1 << (unsigned int)(*speedbin);
> +		break;
>  	case QCOM_ID_MSM8996:
>  	case QCOM_ID_APQ8096:
>  		drv->versions = 1 << (unsigned int)(*speedbin);
> @@ -359,6 +373,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
>  	{ .compatible = "qcom,apq8096", .data = &match_data_kryo },
>  	{ .compatible = "qcom,msm8996", .data = &match_data_kryo },
>  	{ .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
> +	{ .compatible = "qcom,ipq5332", .data = &match_data_kryo },
>  	{ .compatible = "qcom,ipq8064", .data = &match_data_krait },
>  	{ .compatible = "qcom,apq8064", .data = &match_data_krait },
>  	{ .compatible = "qcom,msm8974", .data = &match_data_krait },
