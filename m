Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680997D6589
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbjJYIpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbjJYIpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:45:35 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C98129
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:45:29 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so80157241fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698223527; x=1698828327; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lz4GBEe2iYd2hPiUbHjNhJfJE8hAsaCc8WBmk1URiJY=;
        b=b7rhufxxmcb94qp3i2N35UWGm/z6Xl42Rl8pQWlvmy155jjhjEEfHwrPfFkOdOPOtA
         T+iOduuURmv4p3C7bmcz05q7D7AHR0pOi8PyPuv0U7CXTpX6Zr+sFHrzamyTQv1lY4jh
         FquSufL5cluBloDJI3LyJ2WYYIge1M+cvauTtfTs68U05MFWZ5H2Msy+I6NQz9W17B86
         8K1/Rh1BflYCUA7ATD3Knznog8BNGtaTOzVYEskfnV7+JxBObbx9l83c7ud57/N0YUwG
         54qTrCEYDlx5JrVTTiyOhDV1dgQ2hiGvP1UIuZtlehZ1P1wl0OS8tA7HhLtp9uSs3svJ
         gG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698223527; x=1698828327;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lz4GBEe2iYd2hPiUbHjNhJfJE8hAsaCc8WBmk1URiJY=;
        b=vyKl6O7GM/EYqsCKXZ0OByxGskzcxq/pZpPi2FGMX2fJ+PuqAsLT6cmwCAymTAikTv
         xpMVAi6U0s33l0PE30sWwlhrOlyGSYq6St8Pj5xSZGXdDSZ7BzmDdsV1ke2FKZD1ysGd
         4ONoXCkK9qvtDXocga/Lm9eTHxEgO6GzJGYoJ0huE5YBiAxwolTPgq6TdwpCAH1Mz/Ls
         pjtHfoCoBlSVb9V+hE3XhXBzE1IKpGW31PyfOn2wZfFvUAzPmFDx/muCkHi6XxWjGHgF
         +dvuG36x8JrFW8FKPaMMkpcWjP6HjcCYN4MpWb7sr0i2N9zF5ZtP1uJGgp+Yu8XQLaEU
         6jLQ==
X-Gm-Message-State: AOJu0YyXXEgV97dgt8liqnT1hlTKAW/XBMDA49PLwc0bW4A13Z4ccgsq
        RrH5nc+c4yGdPIDo15TVZ8nhbA==
X-Google-Smtp-Source: AGHT+IHRs8ioYUF0uiv43OgYZEf/cTRv3dTA9nQGwcK/q3lIqgD/wBvpiIIeY+3yK3L3jwhMQp7voQ==
X-Received: by 2002:a2e:2e06:0:b0:2c5:cac:e9a3 with SMTP id u6-20020a2e2e06000000b002c50cace9a3mr10482614lju.52.1698223527595;
        Wed, 25 Oct 2023 01:45:27 -0700 (PDT)
Received: from [172.30.204.57] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id p13-20020a2e9a8d000000b002c5122f13b8sm2320875lji.30.2023.10.25.01.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 01:45:26 -0700 (PDT)
Message-ID: <4d6b8e54-8ec2-4774-9a7e-881af58093e2@linaro.org>
Date:   Wed, 25 Oct 2023 10:45:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] clk: qcom: add the SM8650 Display Clock Controller
 driver
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231025-topic-sm8650-upstream-clocks-v1-0-c89b59594caf@linaro.org>
 <20231025-topic-sm8650-upstream-clocks-v1-8-c89b59594caf@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231025-topic-sm8650-upstream-clocks-v1-8-c89b59594caf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/23 09:32, Neil Armstrong wrote:
> Add Display Clock Controller (DISPCC) support for SM8650 platform.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
[...]

> +static int disp_cc_sm8650_probe(struct platform_device *pdev)
> +{
> +	struct regmap *regmap;
> +	int ret;
> +
> +	ret = devm_pm_runtime_enable(&pdev->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = pm_runtime_resume_and_get(&pdev->dev);
> +	if (ret)
> +		return ret;
> +
> +	regmap = qcom_cc_map(pdev, &disp_cc_sm8650_desc);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
need to clean up RPM

Konrad
