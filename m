Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74797778EC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbjHJM7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbjHJM73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:59:29 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840A72691
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 05:59:28 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b962535808so13949171fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 05:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691672367; x=1692277167;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wk+zm0d06jLEAReFRShjOq87rLOotXXr0iiPkZag8v8=;
        b=B2ZGQfi0E7+mq4GCi8OBMFKMDMOjt4TrHm+hgbNq8F3Aqm3MAL3Jobc9Ha3MZWhOZy
         111TJ7gn1uN2vB+eBX9mEtn05EE2WByZLoAvvsJPMqpTEYHLcmBNiZbub125LZQNEDPB
         sSO97uANHNKYP2Mpxlsz6iZx/Q/X5hprkwqopbO+RJShvrATMHCY1C/GV56njdtl452a
         46bBueehDI1O8D6ITJ1JJJoyTp/PFCTeGx7MFvFyUh1dTYZR0ZIW41VOyIJHIu/JBlLf
         +2cfGm48gvtSDhQfggumQebIM6yzy9tVxKhw51JUz2pvCfE8/PLjkaVWYmuupsMi+6GM
         t4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691672367; x=1692277167;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wk+zm0d06jLEAReFRShjOq87rLOotXXr0iiPkZag8v8=;
        b=Fp+jha9hORwNFnkeKJTrDV6i3uz+6ym+6Aqleldkk5Q3mLfYA2Zxa/fAypv3BSoA/i
         +LJ2qAXptrzx9FGD3t35JlwBE6QHE9C2kxDm9TPqaEETUPxDuZiAQYV3W0PkEBPAM4IH
         3IMl8CXZqQW7P5xIM/pazDQqyeCRSZm9KwKqlt5GdYYdZwJhOs7AR4tFDooL6EJCU51S
         ZtlRAnlJEw5Lg2mNrd3eexb8ywhWcg30aj6dI5gXcOrAmX7TCqEe5KCAmPsaKpIxDyjO
         5Myv/wdQUTLkLK8H7Jfnmjv5myoy1ZOns1iyyP4YmYpAhCwpgUbD4sB4eXJch8QSDi/j
         VIfg==
X-Gm-Message-State: AOJu0Yynh+M8uY9ybTeYRxAAY9eQ+5IxmaLVxyQnoxduA3OXpuj2BA9d
        yHX6AzzvG5go7aCkKXX+ID7HRg==
X-Google-Smtp-Source: AGHT+IHTsZWeX9PLzv0ARPxF/b9bUQFJCXF2d4FgPRJaPHGroko/PDHFHw8TSdTAoBpe9wcNjgif0A==
X-Received: by 2002:a2e:8555:0:b0:2b6:ad79:a4fb with SMTP id u21-20020a2e8555000000b002b6ad79a4fbmr1937417ljj.1.1691672366726;
        Thu, 10 Aug 2023 05:59:26 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id n12-20020a2e720c000000b002b9fdfdab75sm354562ljc.12.2023.08.10.05.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 05:59:26 -0700 (PDT)
Message-ID: <9dec09fa-a5a3-416c-9b4d-4b4c4e10320b@linaro.org>
Date:   Thu, 10 Aug 2023 14:59:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] clk: qcom: add clock controller driver for
 qca8386/qca8084
Content-Language: en-US
To:     Luo Jie <quic_luoj@quicinc.com>, andersson@kernel.org,
        agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        p.zabel@pengutronix.de
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com
References: <20230810115419.25539-1-quic_luoj@quicinc.com>
 <20230810115419.25539-4-quic_luoj@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230810115419.25539-4-quic_luoj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
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

On 10.08.2023 13:54, Luo Jie wrote:
> Add clock & reset controller driver for qca8386/qca8084.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---

> +struct qcom_cc {
> +	struct qcom_reset_controller reset;
> +	struct clk_regmap **rclks;
> +	size_t num_rclks;
> +};
This all, including the probe func, is required because of the MDIO dance,
I assume?

Commonizing that would make more sense should more clocks like this appear
in the future.

[...]

> +static struct clk_branch nss_cc_switch_core_clk = {
> +	.halt_reg = 0x8,
> +	.clkr = {
> +		.enable_reg = 0x8,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "nss_cc_switch_core_clk",
> +			.parent_hws = (const struct clk_hw *[]) {
> +				&nss_cc_switch_core_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			/* Can be disabled in PHY mode for power saving */
Well it clearly cannot be disabled if it has the CLK_IS_CRITICAL flag :D

What's the "PHY mode" you're talking about?

> +			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
> +			.ops = &clk_branch2_mdio_ops,
> +		},
> +	},
> +};
I see a whole bunch of CRITICAL clocks.. please make sure these clocks
are actually necessary for Linux to know about (i.e. if we don't need
to call any operations on them, we might just skip registering them
with the driver).

Konrad

