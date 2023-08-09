Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C80776458
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjHIPsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbjHIPsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:48:01 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04917268D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 08:38:44 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9a2033978so106897061fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 08:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691595519; x=1692200319;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r707B4tVygZaMVBucHiTCFygPxl557dnSQW/UZnC7uU=;
        b=OfOOw7Ha21cX+SrmOxpMaIRauiUgty3GCDD5tHf3R//xmOQmpMk3DI7KnmCF/uATwX
         WPS6+SIz7fGfnN/kVipZDGgZTRwfJoaYOzYyzvGF7TIbYNRY1QJCL8gGL/cYIk+xVv/T
         dKFqxukjYgUZP//nnFvnK6HoSUL65xHxPiYhk8eVkk5zYYhLFYUb4hQ4eVGfMyfKC5z+
         Ciy1KJlQF9FyedEKpvxdiPIpIi0t2thhWdG6G/DhlAfwrxNufHrsz5kwZLeIttDMH6hw
         XbxqJYLA0Uu+q5PM5CXPiiuNE5B28LBrzQv3yzuZrLhVdF2Px9tCLglV81NNJZaAkPPY
         j8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691595519; x=1692200319;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r707B4tVygZaMVBucHiTCFygPxl557dnSQW/UZnC7uU=;
        b=dYbbCC8RW9LK51Hjs9IO/B7gtQ2GaGGZNtP40xpbLbDHkg1OtdN69a/l8FTMlkD0t3
         Sczz2kTMFiTHgq6TvTTq76G6Boj+QH7EBB1KsmDNVARzlY9/iCJ2b3DrXWgkMQU6vCds
         OvJtz6BY7AeUYxkhzLUdDkpAYYUP6eOBcv/y3GKBMQyDj7UvH1ZcxcQunPQ3ySckvhZL
         12mshzqHAHt7MihzIdsDGdDzPRYvDI9cqJ5uQQaYpLTwp5X6iNHKbl7NuWVUYlz/ck+e
         WwClAy5jJyaYPAuuGUVjyXKAPZRCj9iMSehvZeyfNJnwrjw4djDx9zU0rZLPlXV4DETL
         YG0A==
X-Gm-Message-State: AOJu0Yxi3KObSA5qnjQkHM4CP6CjC90lZcqjGX7v/h05midSr7uQoVAR
        vIew3XB0tdv0C78ntxSwN/+UiQ==
X-Google-Smtp-Source: AGHT+IEwCkohKzjzb9m/9Gqa3Pcdu5zzc0ctCyzc48SRmLCFKPtbVms2jwuQZiO6czAxnYqiUKT8jg==
X-Received: by 2002:a2e:6e18:0:b0:2b6:e2cd:20f5 with SMTP id j24-20020a2e6e18000000b002b6e2cd20f5mr2121599ljc.9.1691595519512;
        Wed, 09 Aug 2023 08:38:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id h11-20020a170906854b00b0099cb1a2cab0sm6773292ejy.28.2023.08.09.08.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 08:38:39 -0700 (PDT)
Message-ID: <18d2241a-98ab-6a57-1c4f-d961a4b37c6b@linaro.org>
Date:   Wed, 9 Aug 2023 17:38:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 3/4] clk: qcom: add clock controller driver for
 qca8386/qca8084
Content-Language: en-US
To:     Luo Jie <quic_luoj@quicinc.com>, andersson@kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com
References: <20230809080047.19877-1-quic_luoj@quicinc.com>
 <20230809080047.19877-4-quic_luoj@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230809080047.19877-4-quic_luoj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2023 10:00, Luo Jie wrote:
> Add clock & reset controller driver for qca8386/qca8084.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  drivers/clk/qcom/Kconfig       |    8 +
>  drivers/clk/qcom/Makefile      |    1 +
>  drivers/clk/qcom/nsscc-qca8k.c | 2195 ++++++++++++++++++++++++++++++++
>  3 files changed, 2204 insertions(+)
>  create mode 100644 drivers/clk/qcom/nsscc-qca8k.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 263e55d75e3f..d84705ff920d 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -195,6 +195,14 @@ config IPQ_GCC_9574
>  	  i2c, USB, SD/eMMC, etc. Select this for the root clock
>  	  of ipq9574.
>  
> +config IPQ_NSSCC_QCA8K
> +	tristate "QCA8K(QCA8386 or QCA8084) NSS Clock Controller"

Is it specific to some arch? We keep ARM or ARM64 for most of the entries.

> +	help
> +	  Support for NSS(Network SubSystem) clock controller on
> +	  qca8386/qca8084 chip.
> +	  Say Y if you want to use network features of switch or PHY
> +	  device. Select this for the root clock of qca8k.
> +
>  config MSM_GCC_8660
>  	tristate "MSM8660 Global Clock Controller"
>  	depends on ARM || COMPILE_TEST

...

> +static int nss_cc_qca8k_probe(struct mdio_device *mdiodev)
> +{
> +	struct device *dev = &mdiodev->dev;
> +	struct regmap *regmap;
> +	struct qcom_reset_controller *reset;
> +	struct qcom_cc_desc desc = nss_cc_qca8k_desc;
> +	size_t num_clks = desc.num_clks;
> +	struct clk_regmap **rclks = desc.clks;
> +	struct qcom_cc *cc;
> +	int ret, i;
> +
> +	cc = devm_kzalloc(dev, sizeof(*cc), GFP_KERNEL);
> +	if (!cc)
> +		return -ENOMEM;
> +
> +	cc->rclks = rclks;
> +	cc->num_rclks = num_clks;
> +	reset = &cc->reset;
> +
> +	regmap = devm_regmap_init(dev, NULL, mdiodev->bus, desc.config);
> +

Drop blank line.

> +	if (IS_ERR(regmap)) {
> +		dev_err(dev, "Failed to init MDIO regmap\n");

All of error returns could be converted return dev_err_probe(), just to
have smaller code. Not a requirement, though.

> +		return PTR_ERR(regmap);
> +	}
> +
> +	reset->rcdev.of_node = dev->of_node;
> +	reset->rcdev.dev = dev;
> +	reset->rcdev.ops = &qcom_reset_ops;
> +	reset->rcdev.owner = dev->driver->owner;
> +	reset->rcdev.nr_resets = desc.num_resets;
> +	reset->regmap = regmap;
> +	reset->reset_map = desc.resets;
> +
> +	ret = devm_reset_controller_register(dev, &reset->rcdev);
> +	if (ret) {
> +		dev_err(dev, "Failed to register QCA8K reset controller: %d\n", ret);
> +		return ret;
> +	}
> +
> +	for (i = 0; i < num_clks; i++) {
> +		if (!rclks[i])
> +			continue;
> +
> +		ret = devm_clk_register_regmap(dev, rclks[i]);
> +		if (ret) {
> +			dev_err(dev, "Failed to regmap register for QCA8K clock: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	ret = devm_of_clk_add_hw_provider(dev, qcom_qca8k_clk_hw_get, cc);
> +	if (ret) {
> +		dev_err(dev, "Failed to register provider for QCA8K clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	dev_info(dev, "Registered NSSCC QCA8K clocks\n");

Drop the simple info for probe status. Kernel has other ways to do this.

> +	return ret;
> +}
> +
> +static const struct of_device_id nss_cc_qca8k_match_table[] = {
> +	{ .compatible = "qcom,qca8085-nsscc" },
> +	{ .compatible = "qcom,qca8084-nsscc" },
> +	{ .compatible = "qcom,qca8082-nsscc" },
> +	{ .compatible = "qcom,qca8386-nsscc" },
> +	{ .compatible = "qcom,qca8385-nsscc" },
> +	{ .compatible = "qcom,qca8384-nsscc" },

You only need qca8084 here. Drop all other entries.

> +	{ }
> +};



Best regards,
Krzysztof

